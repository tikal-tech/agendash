FROM node:14-alpine

# Dependencies
# RUN apk update && apk upgrade && \
#    apk add --no-cache bash gawk sed grep bc coreutils git openssh

ENV NODE_ENV=production \
  MONGODB_URI=mongodb://mongodb \
  COLLECTION=agendaJobs \
  BASE_PATH=/

ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.8.0/wait /wait
RUN chmod +x /wait

RUN mkdir -p /agendash
WORKDIR /agendash

COPY package.json /agendash/
RUN npm install && npm cache clean --force

COPY . /agendash
RUN chmod +x /agendash/entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["/agendash/entrypoint.sh"]
