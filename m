Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E76DD48984
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 11:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghqe-0007HM-Pp; Fri, 16 Jan 2026 06:18:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vghqI-00076F-1g
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:18:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vghqD-0005e3-6a
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 06:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768562287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X/iqnQ6oZ0Df8qCEnUOvkUBcT9EP61Sb7o6WLz8fojA=;
 b=cVRUfPMHOu5SFEnw+quLkGk8ci3yWny6kvrcJpy6ZQcDu5AxPT/SUch7ymXU4SNV0ZOv8u
 tkAOV7fVCB3UKEDMRfY3Nv1eUOzoXOLxc+o5U3/tFLmHKnv3aknwdnHzO5iiT+M+ee7fMU
 BI+m3V68vW1xCzqX0v/YWLC3gG+GWHM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-7YO6_9tSNza6CK9oKIiw2g-1; Fri, 16 Jan 2026 06:18:05 -0500
X-MC-Unique: 7YO6_9tSNza6CK9oKIiw2g-1
X-Mimecast-MFC-AGG-ID: 7YO6_9tSNza6CK9oKIiw2g_1768562285
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47edf8ba319so15127835e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 03:18:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768562285; cv=none;
 d=google.com; s=arc-20240605;
 b=hoAHzNJhMcAsJ2e6CFyAguw8q6LggMVLtkYwoNUJW5tH4TGf+6or7yX+x/BfIlJFm5
 saPhEbGXJmUWLlH8kz8b6TbWlfAttXvXoPAnn9wBA65cLgfpBLQRusr2whvQru4/ipPs
 eF95QQnJEDlYT8Y2pg5nBOXDctvOEtrxrj/liwmuzcrSdU1zwsm9CkyzY/SFpHkH/zAs
 LCTxmblbLMlgWejmtROwsFTOrRKzbk8Oj3tlZ9GbHig//u0InUGVzQKl1PeRf5i4i1g1
 fYqIABohsSqxU9lAt+1F/75hXvM2lF1FuZZX6kHP5bpYJU4MIN9IuBZmivETPt7vdWGK
 pGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=X/iqnQ6oZ0Df8qCEnUOvkUBcT9EP61Sb7o6WLz8fojA=;
 fh=0wQhbH5PyiW8mCGsVuFpUsFCyW2Tj+HDIxFJ/KoT2Iw=;
 b=fq3wpiAiIt5J0SbqYCulf12bbceT5VEtOo0K5AuvceXnH7AH6gc/FR/O1OaynmQtTY
 OsmLmuU7vXRuX0YnyQpe5d5JVtrgLcajJN63XxixVl27NFh/muqVoW6Nwd7bn8w8yA56
 TsBZqeuHy5OpmdzSubrdoSP9IdSWg65O8XXpPAbUUwETPmExdtdHNSERKxz8we4zLEhZ
 jo4hh9nrhX8GS2Dn+fv/EV9MFPKccTm92nQRxm85yZS6zurMGaiCeLyXaD0CFEFMG3ve
 I24UUgpGTzAuAwJ61i9TIeZw9xKRyTkLa5BZd4ITe7MFiYfDZfimtqPLD+8Gc9MJ7uWv
 UwOA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768562285; x=1769167085; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X/iqnQ6oZ0Df8qCEnUOvkUBcT9EP61Sb7o6WLz8fojA=;
 b=HBHoNrN4GpDvZiHbxPm5/BAwL6uDRwRfPVJOLCR6lOO0ea88kKT702Wcd8XCUBNi2j
 8c5I5lmG00RenCLEfPOPvKCFiziddjZNsINdXNQ5wDnbI7/6FeM1lHVvZRPSXOh95uR6
 tgSL8EgffJFiqy/YfMpJiAPddtcDh5seiBf1m2hwXvjHy99GIkfH60wVOi9fwMuY0tQJ
 RXz0epnN3W1AjDoAyCef+mI+0LmMgujZ8tzzJ99NuVK5k9hytJslR78E1MldoqbnB9Rl
 2CLz3yVHjSZHChlnwiY1w5Dph9A2PbIeWRK2b3li466LYGzrrP+9DMJdQnmv/V8O/wUb
 PiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768562285; x=1769167085;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X/iqnQ6oZ0Df8qCEnUOvkUBcT9EP61Sb7o6WLz8fojA=;
 b=Flhz0LgaaVWnhtRA4Tt0ABTdZQGdJiH9GfaFjncNWSHvP6xC3OvUhkIPTaI5E6m5Eg
 t4s80vm2+lTNcg2zaab2nOUIH6+V7rUmr0EMOWDmbKhLzLMpmT+VseIySN/EWd6KClc6
 nHFDG0K4BNheUapFJyXkQzSdS56y6AG/aAc09MhIqt19+037w8c4cUYw0m5yvuEZum63
 d7zA2MYxvy6Ngw5Sj0paoBGRkebcYPUafIgLjnPdxnfN/+k49wAKLZp+H3dICsDtCk/Y
 x0OP0GYL868yVEIEgZKxU1+FLLx5nwaevdbcDc9rOLkndXp/0pg45kcx505TxtQ75tBT
 Ra+w==
X-Gm-Message-State: AOJu0YyZUCzyHVJTUsu+ZKB72mxIbep4oQQNcLXqcapOoxh4DZ659PeR
 Jtatgea6UiijJrwml2sKFLzW12Zb9fea/xD4xbOQq9qWd+wNGCAIEQXnTZ1+2w4Zo1Ah1ISJkV6
 Dl+KXdGd+DOkvX1vVVCmo1Q4eP6DJ/i9FqMVy3kmML0aw0mLD2wNqpR45XLLTqHXClTcUa0yvkz
 aGj1tlI/9nVxc/J7bXsfswQ1jSz9a6f1Y=
X-Gm-Gg: AY/fxX6/HLkna/oDSrDA84ImHTo1wbf6pHV57+YwvQGIJOMUzz12A3FkHRnIB0hXmyk
 KLDojpFmYca7ivOmLIn9g2bx8SBD/4Pf8EO70pGsNkWEOho0Oi1VGr9yQQ+LAIXqxmK5gqvWdVc
 8lZng3ex4j/MbzvNmzJhZC2aA/9R7OEcwGav4YyLmSlfN8DYcJIiKqXi6hgTweRyBZFTwSNAN3+
 wmDQq0ZLlp9SuG0xJLozUcOTECkP8N721+v6PQKEcnqsPD0/+qIvbZT
X-Received: by 2002:a05:600c:8b21:b0:477:54cd:200e with SMTP id
 5b1f17b1804b1-4801e2f8e0fmr33528685e9.1.1768562284448; 
 Fri, 16 Jan 2026 03:18:04 -0800 (PST)
X-Received: by 2002:a05:600c:8b21:b0:477:54cd:200e with SMTP id
 5b1f17b1804b1-4801e2f8e0fmr33528315e9.1.1768562283923; Fri, 16 Jan 2026
 03:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-13-farosas@suse.de>
In-Reply-To: <20260109124043.25019-13-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 16 Jan 2026 16:47:47 +0530
X-Gm-Features: AZwV_QgttmRgHIMtOtF1_9YzXV6zzAJ6cN5-2MT1n2hsXQNKHoVDlIE_lnznKzc
Message-ID: <CAE8KmOyi7_H71v2xEpGrYD_60D0z3_aQaAMer-QO=BOkpqnc7Q@mail.gmail.com>
Subject: Re: [PATCH v3 12/25] migration: Handle error in the early async paths
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Li Zhijian <lizhijian@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 9 Jan 2026 at 18:11, Fabiano Rosas <farosas@suse.de> wrote:
> Simplify migration_channel_connect() and migration_connect() to not
> take an error as input. Move the error handling into the paths that
> generate the error.
>
> To achieve this, call migration_connect_error_propagate() from
> socket.c and tls.c, which are the async paths.
>
> For the sync paths, the handling is done as normal by returning all
> the way to qmp_migrate_finish(), except that now the sync paths don't
> pass the error forward into migration_connect() anymore.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/channel.c    | 49 ++++++++++++++++++++----------------------
>  migration/channel.h    |  4 +---
>  migration/exec.c       |  2 +-
>  migration/fd.c         |  2 +-
>  migration/file.c       |  2 +-
>  migration/migration.c  | 11 ++--------
>  migration/migration.h  |  3 ++-
>  migration/rdma.c       |  2 +-
>  migration/socket.c     | 17 ++++++++-------
>  migration/tls.c        | 14 ++++++------
>  migration/tls.h        |  3 +--
>  migration/trace-events |  2 +-
>  12 files changed, 50 insertions(+), 61 deletions(-)
>
> diff --git a/migration/channel.c b/migration/channel.c
> index ba14f66d85..26cb7bf059 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -60,38 +60,35 @@ void migration_channel_process_incoming(QIOChannel *ioc)
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
> +        Error *local_err = NULL;
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
> +        migration_tls_channel_connect(s, ioc, &local_err);
> +        if (local_err) {
> +            migration_connect_error_propagate(s, local_err);
>          }
> +
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
> index d57cc2dc3b..1ea6125454 100644
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
> @@ -4028,7 +4028,7 @@ fail_setup:
>      return NULL;
>  }
>
> -void migration_connect(MigrationState *s, Error *error_in)
> +void migration_connect(MigrationState *s)
>  {
>      Error *local_err = NULL;
>      uint64_t rate_limit;
> @@ -4036,13 +4036,6 @@ void migration_connect(MigrationState *s, Error *error_in)
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
> index 8b55d4741a..d134881eaf 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -533,10 +533,11 @@ void migration_incoming_process(void);
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
>  int migration_call_notifiers(MigrationEventType type, Error **errp);
>
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

* Goto label and variable both are named the same: 'err'.

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
> index 82f58cbc78..837b08294f 100644
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
> @@ -129,8 +130,7 @@ QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
>      return qio_channel_tls_new_client(ioc, creds, migrate_tls_hostname(), errp);
>  }
>
> -void migration_tls_channel_connect(MigrationState *s,
> -                                   QIOChannel *ioc,
> +void migration_tls_channel_connect(MigrationState *s, QIOChannel *ioc,
>                                     Error **errp)
>  {
>      QIOChannelTLS *tioc;
> diff --git a/migration/tls.h b/migration/tls.h
> index 7cd9c76013..0e86d38862 100644
> --- a/migration/tls.h
> +++ b/migration/tls.h
> @@ -29,8 +29,7 @@ void migration_tls_channel_process_incoming(QIOChannel *ioc, Error **errp);
>  QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
>                                             Error **errp);
>
> -void migration_tls_channel_connect(MigrationState *s,
> -                                   QIOChannel *ioc,
> +void migration_tls_channel_connect(MigrationState *s, QIOChannel *ioc,
>                                     Error **errp);
>  void migration_tls_channel_end(QIOChannel *ioc, Error **errp);
>  /* Whether the QIO channel requires further TLS handshake? */
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

/* /me makes a note to check about this syntax, strings after function
signature. */

>  # global_state.c
>  migrate_state_too_big(void) ""
> --
> 2.51.0

* Change looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


