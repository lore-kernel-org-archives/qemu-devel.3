Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23605E92734
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 16:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaFrb-0008W9-Tt; Mon, 29 Dec 2025 11:12:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaFrZ-0008Vx-QY
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 11:12:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaFrW-0004Xa-50
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 11:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767024766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SI1SJpIFZfl6uZw/Sc/YRu7epnkXtTOdqbsj7dYNCDs=;
 b=itj9sJLJXlDD8D05N9VF2j332TTij3NEkvpDXjdLZycMCK2uYFg8RVMSEsuHEYulm1RaZW
 t500I3l/olt2lio/sKEP0+4b3pWm69in2FsgLAVitsXQ/2fwGABkVnXmpRpo1MjOFlONZq
 T9d+tQCzsoQpOkVYGvS1eqpbB5QGYHU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-tH58QTg7NvSjFxAXYHHdwQ-1; Mon, 29 Dec 2025 11:12:41 -0500
X-MC-Unique: tH58QTg7NvSjFxAXYHHdwQ-1
X-Mimecast-MFC-AGG-ID: tH58QTg7NvSjFxAXYHHdwQ_1767024760
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88a344b86f7so335133316d6.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 08:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767024760; x=1767629560; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SI1SJpIFZfl6uZw/Sc/YRu7epnkXtTOdqbsj7dYNCDs=;
 b=tjh1goRKPnS+QtruY9tJNquVbereFcjPlWn1iqO3ZcI9v+vvDwb/qvF57mOpIvrBgW
 ehR4F7UhBIHUiGQeGfgiBvyQQjR2uXEBlZpLFQu5tlDhb4gypO7leHKAMeOkc6w1SPU6
 kS7c2g6/H47ykXOyaVq7hLa9aFwTB/3MNdBhD/yUHHwYDsmxEIoPAFnyU0QOj6uD6N44
 LH/Pqag7nfYUGnD1Vzzr0PCTRn5b9L+0gu71oFS3ke6WmewpsN9ifw/kINlmRu7tNdRM
 ZqJkUutWxpw5zraloYEdqAEKfi1PEpHdI4kQeZdQsggqrdlklg4nfzimixIILFxXUx27
 NWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767024760; x=1767629560;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SI1SJpIFZfl6uZw/Sc/YRu7epnkXtTOdqbsj7dYNCDs=;
 b=CWDuiZcW1i1MBbr1nw2MvgH12EbEKBniLurGEOzOaUUVymQuHLmWUXn1/vz/jAX91u
 KEw0Rvcx3efP17bmU2I6qJtlRedwSAuaK6KygaISEdvH0bTVGcQOFHB/4aY0HrXncf+r
 1k80ZIPR42/nVqT8ulFJ4kGV+ivdHOjsWjXBjluvz/Np1qq/jyeSxqxZ6IrkdA9plnYY
 o0tNr09sOKGUwK5eTc9jFZ8DOgNJbldGp7HAA/QGTBLr5FUy2wupPtaYQx/qUM5MGK3n
 t7J++erK/LFsyRo8gKAgT8DVWDiUzWyEwE8z+KZjh0Zrjw/W7gXQckq6z8mdAcZpd4LG
 5DJQ==
X-Gm-Message-State: AOJu0YwDLB2avT5n9bnc5Jd29/2OY7bUSdDOerLv6U/JIhkRQyIZRNQE
 WOhkkMXoIXGllmny8287SHZDP7W3ajywE/eBYnff5kcW2EkAHSj0WZpwptx4nKOxz9Mjxw2iWvM
 wVevc1D59pt8qDQ6jzcgZBtGsbhuTZCNrC34mnbgkTSrBav892uxkA5f1
X-Gm-Gg: AY/fxX4kMJvxzdem2K5oEbCX7GrRUikdJkGUbrtsZQXBXipKYV2gA7h+QxIs9e5Cbt4
 66wchQZEb6m6WpBqwQDO9i4efYsPS7BkmOJpwHp+PJiYCiLXNonWuvGSUOtz3kmOG5cm0WMdfE6
 pLFog5MpfB/tmoNmGgy0MUU7gm7Zt2Q+yNqUpWZJ3eQ6vi/5rB9qMUX5CbxZDc31IX1Wv0LCwlY
 C5ojhqvxAYqFjguqZyVgZHSUJUro11MDqrhPJBZ2nB2kmLH2MVpxxRoii4c6uxLw+1ziKD0yH3Q
 xRR5hybIQMYM72dgOJsIN3bGHpflc5ZdFZWaKTs5MMmkstqSopMAdMsiyWgxIqZgltdklwPL1OG
 gS8Q=
X-Received: by 2002:ad4:4bc2:0:b0:882:4901:e960 with SMTP id
 6a1803df08f44-88d84fff90fmr375052246d6.29.1767024760455; 
 Mon, 29 Dec 2025 08:12:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpu8zrrLwyfwKaENImrTkZKqguKbDa3YdSqu4y754myYb2Pypjk3pbCnAQgYftsqH3Wfct0Q==
X-Received: by 2002:ad4:4bc2:0:b0:882:4901:e960 with SMTP id
 6a1803df08f44-88d84fff90fmr375051746d6.29.1767024759813; 
 Mon, 29 Dec 2025 08:12:39 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm2417461585a.4.2025.12.29.08.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 08:12:39 -0800 (PST)
Date: Mon, 29 Dec 2025 11:12:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 05/25] migration: Cleanup TLS handshake hostname
 passing
Message-ID: <aVKodt3HLXTKslnk@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251226211930.27565-6-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Dec 26, 2025 at 06:19:07PM -0300, Fabiano Rosas wrote:
> The TLS hostname is doing a tour around the world just to be cached
> into s->hostname. We're already abusing MigrationState by doing that,
> so incorporate the s->hostname into migration_tls_hostname() and stop
> passing the string around.
> 
> The old route was roughly:
> 
>  -transport code (socket.c, fd.c, etc):
>     if (SOCKET_ADDRESS_TYPE_INET)
>         hostname = saddr->u.inet.host
>     else
>         hostname = NULL
>     migration_channel_connect(..., hostname)
>       s->hostname = hostname;
>       migration_tls_client_create(..., hostname)
>         if (migrate_tls_hostname())
>             qio_channel_tls_new_client(migrate_tls_hostname())
>         else
>             qio_channel_tls_new_client(hostname)
> 
>  -postcopy_preempt_setup:
>     postcopy_preempt_send_channel_new
>       migration_tls_client_create(..., s->hostname)
> 
> New route is:
> 
>  -socket.c only:
>    if SOCKET_ADDRESS_TYPE_INET
>        s->hostname = saddr->u.inet.host
>    migration_channel_connect()
>      migration_tls_client_create()
>        qio_channel_tls_new_client(migrate_tls_hostname())
> 
>  -postcopy_preempt_setup:
>     postcopy_preempt_send_channel_new
>       migration_tls_client_create()
>         qio_channel_tls_new_client(migrate_tls_hostname())
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

I suggest let's still copy Dan on all tls changes, though. I've done it
here.

Looks alright to me:

Reviewed-by: Peter Xu <peterx@redhat.com>

Two trivial comments on top..

- Maybe, we can get rid of SocketConnectData altogether now

- Maybe, we want to keep at least one tracepoint that would dump the
  hostname used

> ---
>  migration/channel.c      |  6 ++----
>  migration/channel.h      |  1 -
>  migration/exec.c         |  2 +-
>  migration/fd.c           |  2 +-
>  migration/file.c         |  2 +-
>  migration/multifd.c      |  9 +++------
>  migration/options.c      |  5 +++++
>  migration/postcopy-ram.c |  2 +-
>  migration/socket.c       |  9 +++------
>  migration/tls.c          | 17 ++++-------------
>  migration/tls.h          |  2 --
>  migration/trace-events   | 10 +++++-----
>  12 files changed, 26 insertions(+), 41 deletions(-)
> 
> diff --git a/migration/channel.c b/migration/channel.c
> index b4ab676048..ba14f66d85 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -60,20 +60,18 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>   *
>   * @s: Current migration state
>   * @ioc: Channel to which we are connecting
> - * @hostname: Where we want to connect
>   * @error: Error indicating failure to connect, free'd here
>   */
>  void migration_channel_connect(MigrationState *s,
>                                 QIOChannel *ioc,
> -                               const char *hostname,
>                                 Error *error)
>  {
>      trace_migration_set_outgoing_channel(
> -        ioc, object_get_typename(OBJECT(ioc)), hostname, error);
> +        ioc, object_get_typename(OBJECT(ioc)), error);
>  
>      if (!error) {
>          if (migrate_channel_requires_tls_upgrade(ioc)) {
> -            migration_tls_channel_connect(s, ioc, hostname, &error);
> +            migration_tls_channel_connect(s, ioc, &error);
>  
>              if (!error) {
>                  /* tls_channel_connect will call back to this
> diff --git a/migration/channel.h b/migration/channel.h
> index 5bdb8208a7..2215091323 100644
> --- a/migration/channel.h
> +++ b/migration/channel.h
> @@ -22,7 +22,6 @@ void migration_channel_process_incoming(QIOChannel *ioc);
>  
>  void migration_channel_connect(MigrationState *s,
>                                 QIOChannel *ioc,
> -                               const char *hostname,
>                                 Error *error_in);
>  
>  int migration_channel_read_peek(QIOChannel *ioc,
> diff --git a/migration/exec.c b/migration/exec.c
> index 20e6cccf8c..78fe0fff13 100644
> --- a/migration/exec.c
> +++ b/migration/exec.c
> @@ -55,7 +55,7 @@ void exec_start_outgoing_migration(MigrationState *s, strList *command,
>      }
>  
>      qio_channel_set_name(ioc, "migration-exec-outgoing");
> -    migration_channel_connect(s, ioc, NULL, NULL);
> +    migration_channel_connect(s, ioc, NULL);
>      object_unref(OBJECT(ioc));
>  }
>  
> diff --git a/migration/fd.c b/migration/fd.c
> index 9bf9be6acb..c956b260a4 100644
> --- a/migration/fd.c
> +++ b/migration/fd.c
> @@ -70,7 +70,7 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
>      }
>  
>      qio_channel_set_name(ioc, "migration-fd-outgoing");
> -    migration_channel_connect(s, ioc, NULL, NULL);
> +    migration_channel_connect(s, ioc, NULL);
>      object_unref(OBJECT(ioc));
>  }
>  
> diff --git a/migration/file.c b/migration/file.c
> index bb8031e3c7..c490f2b219 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -122,7 +122,7 @@ void file_start_outgoing_migration(MigrationState *s,
>          return;
>      }
>      qio_channel_set_name(ioc, "migration-file-outgoing");
> -    migration_channel_connect(s, ioc, NULL, NULL);
> +    migration_channel_connect(s, ioc, NULL);
>  }
>  
>  static gboolean file_accept_incoming_migration(QIOChannel *ioc,
> diff --git a/migration/multifd.c b/migration/multifd.c
> index bf6da85af8..3fb1a07ba9 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -814,12 +814,10 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
>                                          QIOChannel *ioc,
>                                          Error **errp)
>  {
> -    MigrationState *s = migrate_get_current();
> -    const char *hostname = s->hostname;
>      MultiFDTLSThreadArgs *args;
>      QIOChannelTLS *tioc;
>  
> -    tioc = migration_tls_client_create(ioc, hostname, errp);
> +    tioc = migration_tls_client_create(ioc, errp);
>      if (!tioc) {
>          return false;
>      }
> @@ -829,7 +827,7 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
>       * created TLS channel, which has already taken a reference.
>       */
>      object_unref(OBJECT(ioc));
> -    trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
> +    trace_multifd_tls_outgoing_handshake_start(ioc, tioc);
>      qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
>  
>      args = g_new0(MultiFDTLSThreadArgs, 1);
> @@ -876,8 +874,7 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>          goto out;
>      }
>  
> -    trace_multifd_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)),
> -                                       migrate_get_current()->hostname);
> +    trace_multifd_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)));
>  
>      if (migrate_channel_requires_tls_upgrade(ioc)) {
>          ret = multifd_tls_channel_connect(p, ioc, &local_err);
> diff --git a/migration/options.c b/migration/options.c
> index 9a5a39c886..881034c289 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -956,6 +956,11 @@ const char *migrate_tls_hostname(void)
>          return s->parameters.tls_hostname->u.s;
>      }
>  
> +    /* hostname saved from a previously connected channel */
> +    if (s->hostname) {
> +        return s->hostname;
> +    }
> +
>      return NULL;
>  }
>  
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 3623ab9dab..03cb0d8d65 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1966,7 +1966,7 @@ postcopy_preempt_send_channel_new(QIOTask *task, gpointer opaque)
>      }
>  
>      if (migrate_channel_requires_tls_upgrade(ioc)) {
> -        tioc = migration_tls_client_create(ioc, s->hostname, &local_err);
> +        tioc = migration_tls_client_create(ioc, &local_err);
>          if (!tioc) {
>              goto out;
>          }
> diff --git a/migration/socket.c b/migration/socket.c
> index 9e379bf56f..426f363b99 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -44,7 +44,6 @@ void socket_send_channel_create(QIOTaskFunc f, void *data)
>  
>  struct SocketConnectData {
>      MigrationState *s;
> -    char *hostname;
>  };
>  
>  static void socket_connect_data_free(void *opaque)
> @@ -53,7 +52,6 @@ static void socket_connect_data_free(void *opaque)
>      if (!data) {
>          return;
>      }
> -    g_free(data->hostname);
>      g_free(data);
>  }
>  
> @@ -69,7 +67,7 @@ static void socket_outgoing_migration(QIOTask *task,
>             goto out;
>      }
>  
> -    trace_migration_socket_outgoing_connected(data->hostname);
> +    trace_migration_socket_outgoing_connected();
>  
>      if (migrate_zero_copy_send() &&
>          !qio_channel_has_feature(sioc, QIO_CHANNEL_FEATURE_WRITE_ZERO_COPY)) {
> @@ -77,7 +75,7 @@ static void socket_outgoing_migration(QIOTask *task,
>      }
>  
>  out:
> -    migration_channel_connect(data->s, sioc, data->hostname, err);
> +    migration_channel_connect(data->s, sioc, err);
>      object_unref(OBJECT(sioc));
>  }
>  
> @@ -96,7 +94,7 @@ void socket_start_outgoing_migration(MigrationState *s,
>      outgoing_args.saddr = addr;
>  
>      if (saddr->type == SOCKET_ADDRESS_TYPE_INET) {
> -        data->hostname = g_strdup(saddr->u.inet.host);
> +        s->hostname = g_strdup(saddr->u.inet.host);
>      }
>  
>      qio_channel_set_name(QIO_CHANNEL(sioc), "migration-socket-outgoing");
> @@ -180,4 +178,3 @@ void socket_start_incoming_migration(SocketAddress *saddr,
>          qapi_free_SocketAddress(address);
>      }
>  }
> -
> diff --git a/migration/tls.c b/migration/tls.c
> index 1df31bdcbb..82f58cbc78 100644
> --- a/migration/tls.c
> +++ b/migration/tls.c
> @@ -112,12 +112,11 @@ static void migration_tls_outgoing_handshake(QIOTask *task,
>      } else {
>          trace_migration_tls_outgoing_handshake_complete();
>      }
> -    migration_channel_connect(s, ioc, NULL, err);
> +    migration_channel_connect(s, ioc, err);
>      object_unref(OBJECT(ioc));
>  }
>  
>  QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
> -                                           const char *hostname,
>                                             Error **errp)
>  {
>      QCryptoTLSCreds *creds;
> @@ -127,29 +126,21 @@ QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
>          return NULL;
>      }
>  
> -    const char *tls_hostname = migrate_tls_hostname();
> -    if (tls_hostname) {
> -        hostname = tls_hostname;
> -    }
> -
> -    return qio_channel_tls_new_client(ioc, creds, hostname, errp);
> +    return qio_channel_tls_new_client(ioc, creds, migrate_tls_hostname(), errp);
>  }
>  
>  void migration_tls_channel_connect(MigrationState *s,
>                                     QIOChannel *ioc,
> -                                   const char *hostname,
>                                     Error **errp)
>  {
>      QIOChannelTLS *tioc;
>  
> -    tioc = migration_tls_client_create(ioc, hostname, errp);
> +    tioc = migration_tls_client_create(ioc, errp);
>      if (!tioc) {
>          return;
>      }
>  
> -    /* Save hostname into MigrationState for handshake */
> -    s->hostname = g_strdup(hostname);
> -    trace_migration_tls_outgoing_handshake_start(hostname);
> +    trace_migration_tls_outgoing_handshake_start();
>      qio_channel_set_name(QIO_CHANNEL(tioc), "migration-tls-outgoing");
>  
>      if (migrate_postcopy_ram() || migrate_return_path()) {
> diff --git a/migration/tls.h b/migration/tls.h
> index 7607cfe803..7cd9c76013 100644
> --- a/migration/tls.h
> +++ b/migration/tls.h
> @@ -27,12 +27,10 @@
>  void migration_tls_channel_process_incoming(QIOChannel *ioc, Error **errp);
>  
>  QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
> -                                           const char *hostname,
>                                             Error **errp);
>  
>  void migration_tls_channel_connect(MigrationState *s,
>                                     QIOChannel *ioc,
> -                                   const char *hostname,
>                                     Error **errp);
>  void migration_tls_channel_end(QIOChannel *ioc, Error **errp);
>  /* Whether the QIO channel requires further TLS handshake? */
> diff --git a/migration/trace-events b/migration/trace-events
> index bf11b62b17..da8f909cac 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -149,10 +149,10 @@ multifd_send_sync_main_wait(uint8_t id) "channel %u"
>  multifd_send_terminate_threads(void) ""
>  multifd_send_thread_end(uint8_t id, uint64_t packets) "channel %u packets %" PRIu64
>  multifd_send_thread_start(uint8_t id) "%u"
> -multifd_tls_outgoing_handshake_start(void *ioc, void *tioc, const char *hostname) "ioc=%p tioc=%p hostname=%s"
> +multifd_tls_outgoing_handshake_start(void *ioc, void *tioc) "ioc=%p tioc=%p"
>  multifd_tls_outgoing_handshake_error(void *ioc, const char *err) "ioc=%p err=%s"
>  multifd_tls_outgoing_handshake_complete(void *ioc) "ioc=%p"
> -multifd_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname)  "ioc=%p ioctype=%s hostname=%s"
> +multifd_set_outgoing_channel(void *ioc, const char *ioctype)  "ioc=%p ioctype=%s"
>  
>  # migration.c
>  migrate_set_state(const char *new_state) "new state %s"
> @@ -204,7 +204,7 @@ migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma)
>  
>  # channel.c
>  migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
> -migration_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname, void *err)  "ioc=%p ioctype=%s hostname=%s err=%p"
> +migration_set_outgoing_channel(void *ioc, const char *ioctype, void *err)  "ioc=%p ioctype=%s err=%p"
>  
>  # global_state.c
>  migrate_state_too_big(void) ""
> @@ -328,11 +328,11 @@ migration_file_incoming(const char *filename) "filename=%s"
>  
>  # socket.c
>  migration_socket_incoming_accepted(void) ""
> -migration_socket_outgoing_connected(const char *hostname) "hostname=%s"
> +migration_socket_outgoing_connected(void) ""
>  migration_socket_outgoing_error(const char *err) "error=%s"
>  
>  # tls.c
> -migration_tls_outgoing_handshake_start(const char *hostname) "hostname=%s"
> +migration_tls_outgoing_handshake_start(void) ""
>  migration_tls_outgoing_handshake_error(const char *err) "err=%s"
>  migration_tls_outgoing_handshake_complete(void) ""
>  migration_tls_incoming_handshake_start(void) ""
> -- 
> 2.51.0
> 

-- 
Peter Xu


