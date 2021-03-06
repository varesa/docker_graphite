FROM registry.esav.fi:5000/python2

MAINTAINER Esa Varemo <esa@kuivanto.fi>

RUN yum install -y bitmap-* cairo

RUN \
	pip install https://github.com/graphite-project/ceres/tarball/master &&\
	pip install whisper  carbon  graphite-web &&\
	pip install cairocffi django==1.8.8  django-tagging &&\
	pip install supervisor

ADD supervisord.conf /etc/supervisord.conf

RUN cp /opt/graphite/webapp/graphite/local_settings.py.example /opt/graphite/conf/local_settings.py
RUN ln -s /opt/graphite/conf/local_settings.py /opt/graphite/webapp/graphite/local_settings.py

VOLUME /opt/graphite/conf
VOLUME /opt/graphite/storage

ADD start.sh /start.sh
CMD ["/start.sh"]
