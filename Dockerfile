FROM ruby:2.6-alpine3.8
RUN apk update && apk upgrade && apk add --update --no-cache build-base nodejs imagemagick postgresql-dev tzdata
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
ENV RAILS_ENV production
RUN bundle install
COPY . /app
CMD rake db:migrate assets:precompile && puma -C config/puma.rb