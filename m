Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D453BD2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 11:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi9dk-0007On-L0; Tue, 20 Jan 2026 06:11:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vi9dj-0007Ml-1E
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:11:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vi9dg-0004Uh-Az
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768907471;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=juyI3LIKDIo2fO7uBqkGMrdaefzP2diUN4X6R8y/USU=;
 b=eXVHXJPfZrpuIaWPdwil811zwbZ+pfHRr2vmOX2ZgqQZkNCKRnRRjFEs4qTLYVYi55ho44
 doNXqrofeazNM7gcwGv7Wv58qCaMrYAjrzAKfx+CRFLq3HskqDUu8ja654HDv665G1CkNJ
 ClmC7+r1FlB0NPprO5ph19eZxO+K9sI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-yMADpmaAMryaCdGxiNDhTA-1; Tue,
 20 Jan 2026 06:11:09 -0500
X-MC-Unique: yMADpmaAMryaCdGxiNDhTA-1
X-Mimecast-MFC-AGG-ID: yMADpmaAMryaCdGxiNDhTA_1768907468
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 909E01956048; Tue, 20 Jan 2026 11:11:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.89])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 691F31800240; Tue, 20 Jan 2026 11:11:06 +0000 (UTC)
Date: Tue, 20 Jan 2026 11:11:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, peterx@redhat.com
Subject: Re: [PATCH v3 04/25] migration: Cleanup TLS handshake hostname passing
Message-ID: <aW9ixg59R8a90FIs@redhat.com>
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-5-farosas@suse.de>
 <CAE8KmOw66B0Za=KA=TyxyWMPYSjFK=GBq7XhREevkCO4Vs+HYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOw66B0Za=KA=TyxyWMPYSjFK=GBq7XhREevkCO4Vs+HYQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jan 20, 2026 at 04:32:55PM +0530, Prasad Pandit wrote:
> On Fri, 9 Jan 2026 at 18:18, Fabiano Rosas <farosas@suse.de> wrote:
> > The TLS hostname is doing a tour around the world just to be cached
> > into s->hostname. We're already abusing MigrationState by doing that,
> > so incorporate the s->hostname into migration_tls_hostname() and stop
> > passing the string around.
> 
> * I get the idea of not passing 's->hostname' around as a parameter,  but:
>    - migrate_tls_hostname() already returns  '->tls_hostname->u.s',
> why are we making it return 's->hostname' too?
>    - How are 'tls_hostname->u.s' and 's->hostname' different?
>    + virsh(1) migrate has:
>        --tls-destination <string>  override the destination host name
> used for TLS verification
> 
> * IIUC, when --tls-destination is supplied, s->hostname and
> tls_hostname are different, otherwise they are the same? If that is
> the case,  could we set tls_hostname = s->hostname when
> params->tls_hostname is not defined below?

Normal default behaviour is that the hostname in the TLS certificate
MUST be validated against the hostname that is specified by the user
(or mgmt app) in the migration URI.

The 'tls-hostname' migration parameter is an optional override that
replaces the hostname from the migration URI, to be used in scenarios
such as:

 * The URI is a UNIX socket. eg the UNIX socket points to a proxy
   that is transporting data to the dest in some manner.  There is
   no way to know the hostname from the URI, so 'tls-hostname' must
   be provided
   
 * The URI is pointing to a proxy that forwards to the real host.
   eg perhaps you setup an SSH tunnel from localhost, to the real
   target. QEMU must NOT validate the remote TLS cert against
   'localhost', so 'tls-hostname' must be provided by the user

Whatever is usd to validate the TLS hostname, must be data that is
provided by the user in some manner.

TL:DR: always use 'tls-hostname' if it is provided by the user,
otherwise always use the hostname from the migration URI,
otherwise do not provide a hostname.

> ===
> static void migrate_params_test_apply(MigrationParameters *params,
>                                       MigrationParameters *dest)
>          {
>     if (params->tls_hostname) {
>         dest->tls_hostname = QAPI_CLONE(StrOrNull, params->tls_hostname);
>     } else {
>         /* clear the reference, it's owned by s->parameters */
>         dest->tls_hostname = NULL;
>     }
> ...
> static void migrate_params_apply(MigrationParameters *params)
> {
>     ...
>     if (params->tls_hostname) {
>         qapi_free_StrOrNull(s->parameters.tls_hostname);
>         s->parameters.tls_hostname = QAPI_CLONE(StrOrNull,
>                                                 params->tls_hostname);
>     }
>     ...
> }
> ===
> 
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >  migration/channel.c      |  6 ++----
> >  migration/channel.h      |  1 -
> >  migration/exec.c         |  2 +-
> >  migration/fd.c           |  2 +-
> >  migration/file.c         |  2 +-
> >  migration/multifd.c      |  9 +++------
> >  migration/options.c      |  5 +++++
> >  migration/postcopy-ram.c |  2 +-
> >  migration/socket.c       |  9 +++------
> >  migration/tls.c          | 17 ++++-------------
> >  migration/tls.h          |  2 --
> >  migration/trace-events   | 10 +++++-----
> >  12 files changed, 26 insertions(+), 41 deletions(-)
> >
> > diff --git a/migration/channel.c b/migration/channel.c
> > index b4ab676048..ba14f66d85 100644
> > --- a/migration/channel.c
> > +++ b/migration/channel.c
> > @@ -60,20 +60,18 @@ void migration_channel_process_incoming(QIOChannel *ioc)
> >   *
> >   * @s: Current migration state
> >   * @ioc: Channel to which we are connecting
> > - * @hostname: Where we want to connect
> >   * @error: Error indicating failure to connect, free'd here
> >   */
> >  void migration_channel_connect(MigrationState *s,
> >                                 QIOChannel *ioc,
> > -                               const char *hostname,
> >                                 Error *error)
> >  {
> >      trace_migration_set_outgoing_channel(
> > -        ioc, object_get_typename(OBJECT(ioc)), hostname, error);
> > +        ioc, object_get_typename(OBJECT(ioc)), error);
> >
> >      if (!error) {
> >          if (migrate_channel_requires_tls_upgrade(ioc)) {
> > -            migration_tls_channel_connect(s, ioc, hostname, &error);
> > +            migration_tls_channel_connect(s, ioc, &error);
> >
> >              if (!error) {
> >                  /* tls_channel_connect will call back to this
> > diff --git a/migration/channel.h b/migration/channel.h
> > index 5bdb8208a7..2215091323 100644
> > --- a/migration/channel.h
> > +++ b/migration/channel.h
> > @@ -22,7 +22,6 @@ void migration_channel_process_incoming(QIOChannel *ioc);
> >
> >  void migration_channel_connect(MigrationState *s,
> >                                 QIOChannel *ioc,
> > -                               const char *hostname,
> >                                 Error *error_in);
> >
> >  int migration_channel_read_peek(QIOChannel *ioc,
> > diff --git a/migration/exec.c b/migration/exec.c
> > index 20e6cccf8c..78fe0fff13 100644
> > --- a/migration/exec.c
> > +++ b/migration/exec.c
> > @@ -55,7 +55,7 @@ void exec_start_outgoing_migration(MigrationState *s, strList *command,
> >      }
> >
> >      qio_channel_set_name(ioc, "migration-exec-outgoing");
> > -    migration_channel_connect(s, ioc, NULL, NULL);
> > +    migration_channel_connect(s, ioc, NULL);
> >      object_unref(OBJECT(ioc));
> >  }
> >
> > diff --git a/migration/fd.c b/migration/fd.c
> > index 9bf9be6acb..c956b260a4 100644
> > --- a/migration/fd.c
> > +++ b/migration/fd.c
> > @@ -70,7 +70,7 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
> >      }
> >
> >      qio_channel_set_name(ioc, "migration-fd-outgoing");
> > -    migration_channel_connect(s, ioc, NULL, NULL);
> > +    migration_channel_connect(s, ioc, NULL);
> >      object_unref(OBJECT(ioc));
> >  }
> >
> > diff --git a/migration/file.c b/migration/file.c
> > index bb8031e3c7..c490f2b219 100644
> > --- a/migration/file.c
> > +++ b/migration/file.c
> > @@ -122,7 +122,7 @@ void file_start_outgoing_migration(MigrationState *s,
> >          return;
> >      }
> >      qio_channel_set_name(ioc, "migration-file-outgoing");
> > -    migration_channel_connect(s, ioc, NULL, NULL);
> > +    migration_channel_connect(s, ioc, NULL);
> >  }
> >
> >  static gboolean file_accept_incoming_migration(QIOChannel *ioc,
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index bf6da85af8..3fb1a07ba9 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -814,12 +814,10 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
> >                                          QIOChannel *ioc,
> >                                          Error **errp)
> >  {
> > -    MigrationState *s = migrate_get_current();
> > -    const char *hostname = s->hostname;
> >      MultiFDTLSThreadArgs *args;
> >      QIOChannelTLS *tioc;
> >
> > -    tioc = migration_tls_client_create(ioc, hostname, errp);
> > +    tioc = migration_tls_client_create(ioc, errp);
> >      if (!tioc) {
> >          return false;
> >      }
> > @@ -829,7 +827,7 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
> >       * created TLS channel, which has already taken a reference.
> >       */
> >      object_unref(OBJECT(ioc));
> > -    trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
> > +    trace_multifd_tls_outgoing_handshake_start(ioc, tioc);
> >      qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
> >
> >      args = g_new0(MultiFDTLSThreadArgs, 1);
> > @@ -876,8 +874,7 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
> >          goto out;
> >      }
> >
> > -    trace_multifd_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)),
> > -                                       migrate_get_current()->hostname);
> > +    trace_multifd_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)));
> >
> >      if (migrate_channel_requires_tls_upgrade(ioc)) {
> >          ret = multifd_tls_channel_connect(p, ioc, &local_err);
> > diff --git a/migration/options.c b/migration/options.c
> > index 9a5a39c886..881034c289 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -956,6 +956,11 @@ const char *migrate_tls_hostname(void)
> >          return s->parameters.tls_hostname->u.s;
> >      }
> >
> > +    /* hostname saved from a previously connected channel */
> > +    if (s->hostname) {
> > +        return s->hostname;
> > +    }
> > +
> 
> * Maybe this return 's->hostname' can be avoided by setting
> tls_hostname = s->hostname at the initialisation stage. If
> 'tls_hostname' and 's->hostname' are different, will the
> migrate_tls_hostname() callers work correctly with s->hostname?
> 
> >      return NULL;
> >  }
> >
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 98a98138be..7afb42bd27 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -1966,7 +1966,7 @@ postcopy_preempt_send_channel_new(QIOTask *task, gpointer opaque)
> >      }
> >
> >      if (migrate_channel_requires_tls_upgrade(ioc)) {
> > -        tioc = migration_tls_client_create(ioc, s->hostname, &local_err);
> > +        tioc = migration_tls_client_create(ioc, &local_err);
> >          if (!tioc) {
> >              goto out;
> >          }
> > diff --git a/migration/socket.c b/migration/socket.c
> > index 9e379bf56f..426f363b99 100644
> > --- a/migration/socket.c
> > +++ b/migration/socket.c
> > @@ -44,7 +44,6 @@ void socket_send_channel_create(QIOTaskFunc f, void *data)
> >
> >  struct SocketConnectData {
> >      MigrationState *s;
> > -    char *hostname;
> >  };
> >
> >  static void socket_connect_data_free(void *opaque)
> > @@ -53,7 +52,6 @@ static void socket_connect_data_free(void *opaque)
> >      if (!data) {
> >          return;
> >      }
> > -    g_free(data->hostname);
> >      g_free(data);
> >  }
> >
> > @@ -69,7 +67,7 @@ static void socket_outgoing_migration(QIOTask *task,
> >             goto out;
> >      }
> >
> > -    trace_migration_socket_outgoing_connected(data->hostname);
> > +    trace_migration_socket_outgoing_connected();
> >
> >      if (migrate_zero_copy_send() &&
> >          !qio_channel_has_feature(sioc, QIO_CHANNEL_FEATURE_WRITE_ZERO_COPY)) {
> > @@ -77,7 +75,7 @@ static void socket_outgoing_migration(QIOTask *task,
> >      }
> >
> >  out:
> > -    migration_channel_connect(data->s, sioc, data->hostname, err);
> > +    migration_channel_connect(data->s, sioc, err);
> >      object_unref(OBJECT(sioc));
> >  }
> >
> > @@ -96,7 +94,7 @@ void socket_start_outgoing_migration(MigrationState *s,
> >      outgoing_args.saddr = addr;
> >
> >      if (saddr->type == SOCKET_ADDRESS_TYPE_INET) {
> > -        data->hostname = g_strdup(saddr->u.inet.host);
> > +        s->hostname = g_strdup(saddr->u.inet.host);
> >      }
> >
> >      qio_channel_set_name(QIO_CHANNEL(sioc), "migration-socket-outgoing");
> > @@ -180,4 +178,3 @@ void socket_start_incoming_migration(SocketAddress *saddr,
> >          qapi_free_SocketAddress(address);
> >      }
> >  }
> > -
> > diff --git a/migration/tls.c b/migration/tls.c
> > index 1df31bdcbb..82f58cbc78 100644
> > --- a/migration/tls.c
> > +++ b/migration/tls.c
> > @@ -112,12 +112,11 @@ static void migration_tls_outgoing_handshake(QIOTask *task,
> >      } else {
> >          trace_migration_tls_outgoing_handshake_complete();
> >      }
> > -    migration_channel_connect(s, ioc, NULL, err);
> > +    migration_channel_connect(s, ioc, err);
> >      object_unref(OBJECT(ioc));
> >  }
> >
> >  QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
> > -                                           const char *hostname,
> >                                             Error **errp)
> >  {
> >      QCryptoTLSCreds *creds;
> > @@ -127,29 +126,21 @@ QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
> >          return NULL;
> >      }
> >
> > -    const char *tls_hostname = migrate_tls_hostname();
> > -    if (tls_hostname) {
> > -        hostname = tls_hostname;
> > -    }
> > -
> > -    return qio_channel_tls_new_client(ioc, creds, hostname, errp);
> > +    return qio_channel_tls_new_client(ioc, creds, migrate_tls_hostname(), errp);
> >  }
> >
> >  void migration_tls_channel_connect(MigrationState *s,
> >                                     QIOChannel *ioc,
> > -                                   const char *hostname,
> >                                     Error **errp)
> >  {
> >      QIOChannelTLS *tioc;
> >
> > -    tioc = migration_tls_client_create(ioc, hostname, errp);
> > +    tioc = migration_tls_client_create(ioc, errp);
> >      if (!tioc) {
> >          return;
> >      }
> >
> > -    /* Save hostname into MigrationState for handshake */
> > -    s->hostname = g_strdup(hostname);
> > -    trace_migration_tls_outgoing_handshake_start(hostname);
> > +    trace_migration_tls_outgoing_handshake_start();
> >      qio_channel_set_name(QIO_CHANNEL(tioc), "migration-tls-outgoing");
> >
> >      if (migrate_postcopy_ram() || migrate_return_path()) {
> > diff --git a/migration/tls.h b/migration/tls.h
> > index 7607cfe803..7cd9c76013 100644
> > --- a/migration/tls.h
> > +++ b/migration/tls.h
> > @@ -27,12 +27,10 @@
> >  void migration_tls_channel_process_incoming(QIOChannel *ioc, Error **errp);
> >
> >  QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
> > -                                           const char *hostname,
> >                                             Error **errp);
> >
> >  void migration_tls_channel_connect(MigrationState *s,
> >                                     QIOChannel *ioc,
> > -                                   const char *hostname,
> >                                     Error **errp);
> >  void migration_tls_channel_end(QIOChannel *ioc, Error **errp);
> >  /* Whether the QIO channel requires further TLS handshake? */
> > diff --git a/migration/trace-events b/migration/trace-events
> > index bf11b62b17..da8f909cac 100644
> > --- a/migration/trace-events
> > +++ b/migration/trace-events
> > @@ -149,10 +149,10 @@ multifd_send_sync_main_wait(uint8_t id) "channel %u"
> >  multifd_send_terminate_threads(void) ""
> >  multifd_send_thread_end(uint8_t id, uint64_t packets) "channel %u packets %" PRIu64
> >  multifd_send_thread_start(uint8_t id) "%u"
> > -multifd_tls_outgoing_handshake_start(void *ioc, void *tioc, const char *hostname) "ioc=%p tioc=%p hostname=%s"
> > +multifd_tls_outgoing_handshake_start(void *ioc, void *tioc) "ioc=%p tioc=%p"
> >  multifd_tls_outgoing_handshake_error(void *ioc, const char *err) "ioc=%p err=%s"
> >  multifd_tls_outgoing_handshake_complete(void *ioc) "ioc=%p"
> > -multifd_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname)  "ioc=%p ioctype=%s hostname=%s"
> > +multifd_set_outgoing_channel(void *ioc, const char *ioctype)  "ioc=%p ioctype=%s"
> >
> >  # migration.c
> >  migrate_set_state(const char *new_state) "new state %s"
> > @@ -204,7 +204,7 @@ migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma)
> >
> >  # channel.c
> >  migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
> > -migration_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname, void *err)  "ioc=%p ioctype=%s hostname=%s err=%p"
> > +migration_set_outgoing_channel(void *ioc, const char *ioctype, void *err)  "ioc=%p ioctype=%s err=%p"
> >
> >  # global_state.c
> >  migrate_state_too_big(void) ""
> > @@ -328,11 +328,11 @@ migration_file_incoming(const char *filename) "filename=%s"
> >
> >  # socket.c
> >  migration_socket_incoming_accepted(void) ""
> > -migration_socket_outgoing_connected(const char *hostname) "hostname=%s"
> > +migration_socket_outgoing_connected(void) ""
> >  migration_socket_outgoing_error(const char *err) "error=%s"
> >
> >  # tls.c
> > -migration_tls_outgoing_handshake_start(const char *hostname) "hostname=%s"
> > +migration_tls_outgoing_handshake_start(void) ""
> >  migration_tls_outgoing_handshake_error(const char *err) "err=%s"
> >  migration_tls_outgoing_handshake_complete(void) ""
> >  migration_tls_incoming_handshake_start(void) ""
> > --
> 
> * Otherwise change looks okay.
> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
> 
> Thank you.
> ---
>   - Prasad
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


