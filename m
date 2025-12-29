Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30560E92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIbx-000136-Ah; Mon, 29 Dec 2025 14:08:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaIbo-00011W-Kf
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:08:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaIbk-00025Z-Pu
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767035323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lMsvNNKL2RM2lr4MWFkdcQUtSeuFt6thqaMnG/RbcPI=;
 b=Lf3qN8DerGx2bMO8TLMSwT9YJPLpaUeboivEQc/eepjZkAGfYh0YZqif/8T7Fz4SRDeUQC
 fwYblijzgo7vDXAdtoXSwNqvAtB50+E2xT0pMapMnw4kgo7DHpBB25rIUhN1Qto9tw6lc7
 jHZl069aeo/VjrqzLx8NCjuPUDaofVk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-pchcfwr3PlSdy8eboJQs1A-1; Mon, 29 Dec 2025 14:08:38 -0500
X-MC-Unique: pchcfwr3PlSdy8eboJQs1A-1
X-Mimecast-MFC-AGG-ID: pchcfwr3PlSdy8eboJQs1A_1767035317
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-88888397482so286868306d6.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 11:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767035317; x=1767640117; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lMsvNNKL2RM2lr4MWFkdcQUtSeuFt6thqaMnG/RbcPI=;
 b=M5aKZh8B/WmF3cK2ulHxDLv1NMU+ACK09rNN/4d2CvpZRKSSWnVYq6a8ZfIFPHkQ2e
 SeQdZk8yoMebmopBPLQhEUSNggTk+0eBkltnk4DukXKf7EBikWWVwdCY0GVmUXgS5zjc
 XdpdWsWUlxt0iNoWAeuegMzh6+E1XJTIWWAfd1qP+zihaUBTUYJc8pZJ9OFZ90bkeDX+
 384pjPjyuxolgihOG6g9OAePLNVICjo3UjcHEgrt/3tgNIf4T1u2UGpPovEE6bbhJKEe
 UNXTnbay0FjA3XmXqVz2iebBb1HG8vPxux0+9wMV/zwLL3J8pS3j6hngemi3P+4hygrC
 o4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767035317; x=1767640117;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lMsvNNKL2RM2lr4MWFkdcQUtSeuFt6thqaMnG/RbcPI=;
 b=dBQiXffaZFX/YItYrt0jhSlnGKCU7PY5AN5qyQaPukMzOFcbyu48nueU8jZKe0+Wc1
 AVZlI2hsi4OPXM8SQ5N8y9+wHO8REZAplBJkkvlPCJhgj8X4nUh1QdDLHhFz8FKJKK4n
 TI3LMIq9qI1rmmqR4ZIdAGi2pwDWO725oYTiG7G5dKBWfbRYopRxJzKiYJWZ3cGEq3tb
 aAw0muKozt6fClKPF9eklz39uZ4ke+rgDsrTXVhjJMBc1oO+oQPoO6HrLCpdcJ6lMmN/
 1+jUfxJpNwqCFPWlcMsb6aKk6dXt4vR1gRb3ILClIi8jZYUbiwWeuu69WpXIHEM5i0a/
 3qlw==
X-Gm-Message-State: AOJu0YwHT9SCm7SXr1FHp3mn41/Ne8cHjXev2ToQ+nefmOfO/up8GddD
 VccUBUVSvmqyzL2gQbBpyOOPxh5StQwZT5ezSxcVnGEP8mLQ5KTj9ChKokSsvyZRef5yiFl/Vs0
 HTFUZ/qnZho2f1GTHiarW2i6w8xxVNBnDqeQBfQdKcpXfp1hpwNtYLw54
X-Gm-Gg: AY/fxX653AKntBgeBcMJ6weEsnq4UwQRGZzQxrmTXxM5SLEkOAvvgw0kLXUSzYe4B2V
 o+hkc1Dz8pe671IXde5EeOxQZDmVAWJWQGS2IF4Tpe/+icuqH9RQ2+1q0iYcsRVT+bxjj54+g39
 tQCcy0ijjorC4y3imV0dAcXrsaR8bwUDZekMYBfOGGzWoEiQnPqCf5B+lZRaeNwr11oGlH6dtWG
 neyHY5AVowoF+w+0ND263M3qFK51DXUBvow6GCt/Kvjb253Q5HM5V5gqwgfx5wEbRXnSvn3ozqU
 V6RNGn8hGPxaohI38mmifN7dBT4SZkaLEkWdfQfyySkzEQrxuWmdw6fBCefUHamXOfaLYwJAacf
 sCrs=
X-Received: by 2002:a05:6214:5711:b0:88a:57db:8e12 with SMTP id
 6a1803df08f44-88d83792ef9mr471502456d6.32.1767035316803; 
 Mon, 29 Dec 2025 11:08:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnTDyv4+uBifOq89eayC/HGsrkydkOHLiGOy3QIjw5k6hAWwKBwJvEj5yqjfBsYbRS9CPtkw==
X-Received: by 2002:a05:6214:5711:b0:88a:57db:8e12 with SMTP id
 6a1803df08f44-88d83792ef9mr471501886d6.32.1767035316182; 
 Mon, 29 Dec 2025 11:08:36 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88d925f935asm234042246d6.0.2025.12.29.11.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 11:08:35 -0800 (PST)
Date: Mon, 29 Dec 2025 14:08:34 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [RFC PATCH 13/25] migration: Handle error in the early async paths
Message-ID: <aVLRsm5dukbnVZtb@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-14-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251226211930.27565-14-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Dec 26, 2025 at 06:19:15PM -0300, Fabiano Rosas wrote:
> Simplify migration_channel_connect() and migration_connect() to not
> take an error as input. Move the error handling into the paths that
> generate the error.
> 
> To achive this, call migration_connect_error_propagate() from socket.c
> and tls.c, which are the async paths.
> 
> For the sync paths, the handling is done as normal by returning all
> the way to qmp_migrate_finish(), except that now the sync paths don't
> pass the error forward into migration_connect() anymore.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Yeah this looks better in general, feel free to take:

Reviewed-by: Peter Xu <peterx@redhat.com>

One thing to mention:

Strictly speaking, migration_tls_channel_connect() doesn't fall into the
"async op" category - it was invoked from migration core, so logically it
can still keep its errp, then the migration core should also be able to
process the error in migration_channel_connect().  It's not like the other
two "async ops" where migration context was lost.

IOW, I can kind of see why we used to pass an Error into the current
migration_channel_connect(), and it still makes some sense.  OTOH, it
doesn't really make sense to me to keep passing it to migration_connect()..

But since that's the only user of migration_tls_channel_connect(), I assume
it's not a huge deal, anyway.

> ---
>  migration/channel.c    | 46 +++++++++++++++++-------------------------
>  migration/channel.h    |  4 +---
>  migration/exec.c       |  2 +-
>  migration/fd.c         |  2 +-
>  migration/file.c       |  2 +-
>  migration/migration.c  | 11 ++--------
>  migration/migration.h  |  3 ++-
>  migration/rdma.c       |  2 +-
>  migration/socket.c     | 17 ++++++++--------
>  migration/tls.c        | 19 ++++++++---------
>  migration/tls.h        |  4 +---
>  migration/trace-events |  2 +-
>  12 files changed, 49 insertions(+), 65 deletions(-)
> 
> diff --git a/migration/channel.c b/migration/channel.c
> index ba14f66d85..7243b99108 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -60,38 +60,30 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>   *
>   * @s: Current migration state
>   * @ioc: Channel to which we are connecting
> - * @error: Error indicating failure to connect, free'd here
>   */
> -void migration_channel_connect(MigrationState *s,
> -                               QIOChannel *ioc,
> -                               Error *error)
> +void migration_channel_connect(MigrationState *s, QIOChannel *ioc)
>  {
> -    trace_migration_set_outgoing_channel(
> -        ioc, object_get_typename(OBJECT(ioc)), error);
> +    trace_migration_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)));
>  
> -    if (!error) {
> -        if (migrate_channel_requires_tls_upgrade(ioc)) {
> -            migration_tls_channel_connect(s, ioc, &error);
> +    if (migrate_channel_requires_tls_upgrade(ioc)) {
> +        migration_tls_channel_connect(s, ioc);
>  
> -            if (!error) {
> -                /* tls_channel_connect will call back to this
> -                 * function after the TLS handshake,
> -                 * so we mustn't call migration_connect until then
> -                 */
> -
> -                return;
> -            }
> -        } else {
> -            QEMUFile *f = qemu_file_new_output(ioc);
> -
> -            migration_ioc_register_yank(ioc);
> -
> -            qemu_mutex_lock(&s->qemu_file_lock);
> -            s->to_dst_file = f;
> -            qemu_mutex_unlock(&s->qemu_file_lock);
> -        }
> +        /*
> +         * async: the above will call back to this function after
> +         * the TLS handshake is successfully completed.
> +         */
> +        return;
>      }
> -    migration_connect(s, error);
> +
> +    QEMUFile *f = qemu_file_new_output(ioc);
> +
> +    migration_ioc_register_yank(ioc);
> +
> +    qemu_mutex_lock(&s->qemu_file_lock);
> +    s->to_dst_file = f;
> +    qemu_mutex_unlock(&s->qemu_file_lock);
> +
> +    migration_connect(s);
>  }
>  
>  
> diff --git a/migration/channel.h b/migration/channel.h
> index 2215091323..ccfeaaef18 100644
> --- a/migration/channel.h
> +++ b/migration/channel.h
> @@ -20,9 +20,7 @@
>  
>  void migration_channel_process_incoming(QIOChannel *ioc);
>  
> -void migration_channel_connect(MigrationState *s,
> -                               QIOChannel *ioc,
> -                               Error *error_in);
> +void migration_channel_connect(MigrationState *s, QIOChannel *ioc);
>  
>  int migration_channel_read_peek(QIOChannel *ioc,
>                                  const char *buf,
> diff --git a/migration/exec.c b/migration/exec.c
> index 78fe0fff13..d83a07435a 100644
> --- a/migration/exec.c
> +++ b/migration/exec.c
> @@ -55,7 +55,7 @@ void exec_start_outgoing_migration(MigrationState *s, strList *command,
>      }
>  
>      qio_channel_set_name(ioc, "migration-exec-outgoing");
> -    migration_channel_connect(s, ioc, NULL);
> +    migration_channel_connect(s, ioc);
>      object_unref(OBJECT(ioc));
>  }
>  
> diff --git a/migration/fd.c b/migration/fd.c
> index c956b260a4..0144a70742 100644
> --- a/migration/fd.c
> +++ b/migration/fd.c
> @@ -70,7 +70,7 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
>      }
>  
>      qio_channel_set_name(ioc, "migration-fd-outgoing");
> -    migration_channel_connect(s, ioc, NULL);
> +    migration_channel_connect(s, ioc);
>      object_unref(OBJECT(ioc));
>  }
>  
> diff --git a/migration/file.c b/migration/file.c
> index c490f2b219..7bb9c1c79f 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -122,7 +122,7 @@ void file_start_outgoing_migration(MigrationState *s,
>          return;
>      }
>      qio_channel_set_name(ioc, "migration-file-outgoing");
> -    migration_channel_connect(s, ioc, NULL);
> +    migration_channel_connect(s, ioc);
>  }
>  
>  static gboolean file_accept_incoming_migration(QIOChannel *ioc,
> diff --git a/migration/migration.c b/migration/migration.c
> index a66b2d7aaf..5c6c76f110 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1572,7 +1572,7 @@ static void migrate_error_free(MigrationState *s)
>      }
>  }
>  
> -static void migration_connect_error_propagate(MigrationState *s, Error *error)
> +void migration_connect_error_propagate(MigrationState *s, Error *error)
>  {
>      MigrationStatus current = s->state;
>      MigrationStatus next = MIGRATION_STATUS_NONE;
> @@ -4033,7 +4033,7 @@ fail_setup:
>      return NULL;
>  }
>  
> -void migration_connect(MigrationState *s, Error *error_in)
> +void migration_connect(MigrationState *s)
>  {
>      Error *local_err = NULL;
>      uint64_t rate_limit;
> @@ -4041,13 +4041,6 @@ void migration_connect(MigrationState *s, Error *error_in)
>      int ret;
>  
>      s->expected_downtime = migrate_downtime_limit();
> -    if (error_in) {
> -        migration_connect_error_propagate(s, error_in);
> -        if (s->error) {
> -            error_report_err(error_copy(s->error));
> -        }
> -        return;
> -    }
>  
>      if (resume) {
>          /* This is a resumed migration */
> diff --git a/migration/migration.h b/migration/migration.h
> index 4d42e8f9a7..f340cd518d 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -532,10 +532,11 @@ void migration_incoming_process(void);
>  
>  bool  migration_has_all_channels(void);
>  
> +void migration_connect_error_propagate(MigrationState *s, Error *error);
>  void migrate_error_propagate(MigrationState *s, Error *error);
>  bool migrate_has_error(MigrationState *s);
>  
> -void migration_connect(MigrationState *s, Error *error_in);
> +void migration_connect(MigrationState *s);
>  
>  int migration_call_notifiers(MigrationState *s, MigrationEventType type,
>                               Error **errp);
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 337b415889..596a1aba0b 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3997,7 +3997,7 @@ void rdma_start_outgoing_migration(void *opaque,
>  
>      s->to_dst_file = rdma_new_output(rdma);
>      s->rdma_migration = true;
> -    migration_connect(s, NULL);
> +    migration_connect(s);
>      return;
>  return_path_err:
>      qemu_rdma_cleanup(rdma);
> diff --git a/migration/socket.c b/migration/socket.c
> index 426f363b99..298bac30cc 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -59,24 +59,25 @@ static void socket_outgoing_migration(QIOTask *task,
>                                        gpointer opaque)
>  {
>      struct SocketConnectData *data = opaque;
> -    QIOChannel *sioc = QIO_CHANNEL(qio_task_get_source(task));
> +    g_autoptr(QIOChannel) sioc = QIO_CHANNEL(qio_task_get_source(task));
>      Error *err = NULL;
>  
>      if (qio_task_propagate_error(task, &err)) {
> -        trace_migration_socket_outgoing_error(error_get_pretty(err));
> -           goto out;
> +        goto err;
>      }
>  
> -    trace_migration_socket_outgoing_connected();
> -
>      if (migrate_zero_copy_send() &&
>          !qio_channel_has_feature(sioc, QIO_CHANNEL_FEATURE_WRITE_ZERO_COPY)) {
>          error_setg(&err, "Zero copy send feature not detected in host kernel");
> +        goto err;
>      }
>  
> -out:
> -    migration_channel_connect(data->s, sioc, err);
> -    object_unref(OBJECT(sioc));
> +    trace_migration_socket_outgoing_connected();
> +    migration_channel_connect(data->s, sioc);
> +    return;
> +err:
> +    trace_migration_socket_outgoing_error(error_get_pretty(err));
> +    migration_connect_error_propagate(data->s, err);
>  }
>  
>  void socket_start_outgoing_migration(MigrationState *s,
> diff --git a/migration/tls.c b/migration/tls.c
> index 82f58cbc78..a54e8e6e14 100644
> --- a/migration/tls.c
> +++ b/migration/tls.c
> @@ -104,16 +104,17 @@ static void migration_tls_outgoing_handshake(QIOTask *task,
>                                               gpointer opaque)
>  {
>      MigrationState *s = opaque;
> -    QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
> +    g_autoptr(QIOChannel) ioc = QIO_CHANNEL(qio_task_get_source(task));
>      Error *err = NULL;
>  
>      if (qio_task_propagate_error(task, &err)) {
>          trace_migration_tls_outgoing_handshake_error(error_get_pretty(err));
> -    } else {
> -        trace_migration_tls_outgoing_handshake_complete();
> +        migration_connect_error_propagate(s, err);
> +        return;
>      }
> -    migration_channel_connect(s, ioc, err);
> -    object_unref(OBJECT(ioc));
> +
> +    trace_migration_tls_outgoing_handshake_complete();
> +    migration_channel_connect(s, ioc);
>  }
>  
>  QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
> @@ -129,14 +130,14 @@ QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
>      return qio_channel_tls_new_client(ioc, creds, migrate_tls_hostname(), errp);
>  }
>  
> -void migration_tls_channel_connect(MigrationState *s,
> -                                   QIOChannel *ioc,
> -                                   Error **errp)
> +void migration_tls_channel_connect(MigrationState *s, QIOChannel *ioc)
>  {
>      QIOChannelTLS *tioc;
> +    Error *local_err = NULL;
>  
> -    tioc = migration_tls_client_create(ioc, errp);
> +    tioc = migration_tls_client_create(ioc, &local_err);
>      if (!tioc) {
> +        migration_connect_error_propagate(s, local_err);
>          return;
>      }
>  
> diff --git a/migration/tls.h b/migration/tls.h
> index 7cd9c76013..7399c42edf 100644
> --- a/migration/tls.h
> +++ b/migration/tls.h
> @@ -29,9 +29,7 @@ void migration_tls_channel_process_incoming(QIOChannel *ioc, Error **errp);
>  QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
>                                             Error **errp);
>  
> -void migration_tls_channel_connect(MigrationState *s,
> -                                   QIOChannel *ioc,
> -                                   Error **errp);
> +void migration_tls_channel_connect(MigrationState *s, QIOChannel *ioc);
>  void migration_tls_channel_end(QIOChannel *ioc, Error **errp);
>  /* Whether the QIO channel requires further TLS handshake? */
>  bool migrate_channel_requires_tls_upgrade(QIOChannel *ioc);
> diff --git a/migration/trace-events b/migration/trace-events
> index da8f909cac..cbf10d0b63 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -204,7 +204,7 @@ migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma)
>  
>  # channel.c
>  migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
> -migration_set_outgoing_channel(void *ioc, const char *ioctype, void *err)  "ioc=%p ioctype=%s err=%p"
> +migration_set_outgoing_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
>  
>  # global_state.c
>  migrate_state_too_big(void) ""
> -- 
> 2.51.0
> 

-- 
Peter Xu


