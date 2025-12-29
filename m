Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C619E92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJ1h-00011e-L2; Mon, 29 Dec 2025 14:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vaJ1c-0000xw-G9
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:35:29 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vaJ1a-0008D1-3Y
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:35:28 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B6161336BA;
 Mon, 29 Dec 2025 19:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767036922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EZDrq1EN9UYHWklRiflBzSW/afKV6QONVnfiH/tw0LU=;
 b=NNYGtVouIJVH4/8Hi9Y200X0cMOqifZYsHGDQ4j0JVn1LndQeqvpuN5GyI0ANDLWoVYXyn
 epL7liA7UxlVoZZ9X/ikVWP9S2K8AEHyxe4Yi1H+R6ppfNBPkp27IYlBsAGz5r2eRMpEly
 KQSWzENW5D96/2eBGPtKOHQIcooBhGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767036922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EZDrq1EN9UYHWklRiflBzSW/afKV6QONVnfiH/tw0LU=;
 b=647B6icBK4mhHerZgnq1sEhOxxhFA5hoxYNa4g2qFiGCmK3fibReVRXbtN6FlLFXi4ZSnq
 ZL7kvuRoBMxyRbDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767036921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EZDrq1EN9UYHWklRiflBzSW/afKV6QONVnfiH/tw0LU=;
 b=FMyqsswe4DDTvvUKsTKrFSSg2CblbieiNlPS1tNfuQnn5AlOnRkXZ0AOip0QkRhfw9TEDL
 /LJ3AjsOQP/aRgegTrZW6gCdv0QRW7YIJwDDkqUbu56U7Do6CR17jD4SIauLELkdbxL5bz
 NKeJ4HZkmcNaivFXxcjRxkyooENMJ6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767036921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EZDrq1EN9UYHWklRiflBzSW/afKV6QONVnfiH/tw0LU=;
 b=DsZriVsO9c/Mwp0GQNYZ2v0WI2nn5y7B9HqluMQ+wGQYxz/sMt99ry74aQrXgIKFf0KObf
 NJIbq3dInQST6gAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31FB8137C3;
 Mon, 29 Dec 2025 19:35:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9poiOfjXUmlIVgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Dec 2025 19:35:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [RFC PATCH 13/25] migration: Handle error in the early async paths
In-Reply-To: <aVLRsm5dukbnVZtb@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-14-farosas@suse.de> <aVLRsm5dukbnVZtb@x1.local>
Date: Mon, 29 Dec 2025 16:35:18 -0300
Message-ID: <87fr8t84jt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.992]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Dec 26, 2025 at 06:19:15PM -0300, Fabiano Rosas wrote:
>> Simplify migration_channel_connect() and migration_connect() to not
>> take an error as input. Move the error handling into the paths that
>> generate the error.
>> 
>> To achive this, call migration_connect_error_propagate() from socket.c
>> and tls.c, which are the async paths.
>> 
>> For the sync paths, the handling is done as normal by returning all
>> the way to qmp_migrate_finish(), except that now the sync paths don't
>> pass the error forward into migration_connect() anymore.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Yeah this looks better in general, feel free to take:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> One thing to mention:
>
> Strictly speaking, migration_tls_channel_connect() doesn't fall into the
> "async op" category - it was invoked from migration core, so logically it
> can still keep its errp, then the migration core should also be able to
> process the error in migration_channel_connect().  It's not like the other
> two "async ops" where migration context was lost.
>

I actually had it return the error in a previous version. Let me check
if it still makes sense to do that.

> IOW, I can kind of see why we used to pass an Error into the current
> migration_channel_connect(), and it still makes some sense.

Yes, it was definitely not incorrect. I just think it's become a
surprising thing to do given how the code has evolved.

> OTOH, it doesn't really make sense to me to keep passing it to
> migration_connect()..
>
> But since that's the only user of migration_tls_channel_connect(), I assume
> it's not a huge deal, anyway.
>
>> ---
>>  migration/channel.c    | 46 +++++++++++++++++-------------------------
>>  migration/channel.h    |  4 +---
>>  migration/exec.c       |  2 +-
>>  migration/fd.c         |  2 +-
>>  migration/file.c       |  2 +-
>>  migration/migration.c  | 11 ++--------
>>  migration/migration.h  |  3 ++-
>>  migration/rdma.c       |  2 +-
>>  migration/socket.c     | 17 ++++++++--------
>>  migration/tls.c        | 19 ++++++++---------
>>  migration/tls.h        |  4 +---
>>  migration/trace-events |  2 +-
>>  12 files changed, 49 insertions(+), 65 deletions(-)
>> 
>> diff --git a/migration/channel.c b/migration/channel.c
>> index ba14f66d85..7243b99108 100644
>> --- a/migration/channel.c
>> +++ b/migration/channel.c
>> @@ -60,38 +60,30 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>>   *
>>   * @s: Current migration state
>>   * @ioc: Channel to which we are connecting
>> - * @error: Error indicating failure to connect, free'd here
>>   */
>> -void migration_channel_connect(MigrationState *s,
>> -                               QIOChannel *ioc,
>> -                               Error *error)
>> +void migration_channel_connect(MigrationState *s, QIOChannel *ioc)
>>  {
>> -    trace_migration_set_outgoing_channel(
>> -        ioc, object_get_typename(OBJECT(ioc)), error);
>> +    trace_migration_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)));
>>  
>> -    if (!error) {
>> -        if (migrate_channel_requires_tls_upgrade(ioc)) {
>> -            migration_tls_channel_connect(s, ioc, &error);
>> +    if (migrate_channel_requires_tls_upgrade(ioc)) {
>> +        migration_tls_channel_connect(s, ioc);
>>  
>> -            if (!error) {
>> -                /* tls_channel_connect will call back to this
>> -                 * function after the TLS handshake,
>> -                 * so we mustn't call migration_connect until then
>> -                 */
>> -
>> -                return;
>> -            }
>> -        } else {
>> -            QEMUFile *f = qemu_file_new_output(ioc);
>> -
>> -            migration_ioc_register_yank(ioc);
>> -
>> -            qemu_mutex_lock(&s->qemu_file_lock);
>> -            s->to_dst_file = f;
>> -            qemu_mutex_unlock(&s->qemu_file_lock);
>> -        }
>> +        /*
>> +         * async: the above will call back to this function after
>> +         * the TLS handshake is successfully completed.
>> +         */
>> +        return;
>>      }
>> -    migration_connect(s, error);
>> +
>> +    QEMUFile *f = qemu_file_new_output(ioc);
>> +
>> +    migration_ioc_register_yank(ioc);
>> +
>> +    qemu_mutex_lock(&s->qemu_file_lock);
>> +    s->to_dst_file = f;
>> +    qemu_mutex_unlock(&s->qemu_file_lock);
>> +
>> +    migration_connect(s);
>>  }
>>  
>>  
>> diff --git a/migration/channel.h b/migration/channel.h
>> index 2215091323..ccfeaaef18 100644
>> --- a/migration/channel.h
>> +++ b/migration/channel.h
>> @@ -20,9 +20,7 @@
>>  
>>  void migration_channel_process_incoming(QIOChannel *ioc);
>>  
>> -void migration_channel_connect(MigrationState *s,
>> -                               QIOChannel *ioc,
>> -                               Error *error_in);
>> +void migration_channel_connect(MigrationState *s, QIOChannel *ioc);
>>  
>>  int migration_channel_read_peek(QIOChannel *ioc,
>>                                  const char *buf,
>> diff --git a/migration/exec.c b/migration/exec.c
>> index 78fe0fff13..d83a07435a 100644
>> --- a/migration/exec.c
>> +++ b/migration/exec.c
>> @@ -55,7 +55,7 @@ void exec_start_outgoing_migration(MigrationState *s, strList *command,
>>      }
>>  
>>      qio_channel_set_name(ioc, "migration-exec-outgoing");
>> -    migration_channel_connect(s, ioc, NULL);
>> +    migration_channel_connect(s, ioc);
>>      object_unref(OBJECT(ioc));
>>  }
>>  
>> diff --git a/migration/fd.c b/migration/fd.c
>> index c956b260a4..0144a70742 100644
>> --- a/migration/fd.c
>> +++ b/migration/fd.c
>> @@ -70,7 +70,7 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
>>      }
>>  
>>      qio_channel_set_name(ioc, "migration-fd-outgoing");
>> -    migration_channel_connect(s, ioc, NULL);
>> +    migration_channel_connect(s, ioc);
>>      object_unref(OBJECT(ioc));
>>  }
>>  
>> diff --git a/migration/file.c b/migration/file.c
>> index c490f2b219..7bb9c1c79f 100644
>> --- a/migration/file.c
>> +++ b/migration/file.c
>> @@ -122,7 +122,7 @@ void file_start_outgoing_migration(MigrationState *s,
>>          return;
>>      }
>>      qio_channel_set_name(ioc, "migration-file-outgoing");
>> -    migration_channel_connect(s, ioc, NULL);
>> +    migration_channel_connect(s, ioc);
>>  }
>>  
>>  static gboolean file_accept_incoming_migration(QIOChannel *ioc,
>> diff --git a/migration/migration.c b/migration/migration.c
>> index a66b2d7aaf..5c6c76f110 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1572,7 +1572,7 @@ static void migrate_error_free(MigrationState *s)
>>      }
>>  }
>>  
>> -static void migration_connect_error_propagate(MigrationState *s, Error *error)
>> +void migration_connect_error_propagate(MigrationState *s, Error *error)
>>  {
>>      MigrationStatus current = s->state;
>>      MigrationStatus next = MIGRATION_STATUS_NONE;
>> @@ -4033,7 +4033,7 @@ fail_setup:
>>      return NULL;
>>  }
>>  
>> -void migration_connect(MigrationState *s, Error *error_in)
>> +void migration_connect(MigrationState *s)
>>  {
>>      Error *local_err = NULL;
>>      uint64_t rate_limit;
>> @@ -4041,13 +4041,6 @@ void migration_connect(MigrationState *s, Error *error_in)
>>      int ret;
>>  
>>      s->expected_downtime = migrate_downtime_limit();
>> -    if (error_in) {
>> -        migration_connect_error_propagate(s, error_in);
>> -        if (s->error) {
>> -            error_report_err(error_copy(s->error));
>> -        }
>> -        return;
>> -    }
>>  
>>      if (resume) {
>>          /* This is a resumed migration */
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 4d42e8f9a7..f340cd518d 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -532,10 +532,11 @@ void migration_incoming_process(void);
>>  
>>  bool  migration_has_all_channels(void);
>>  
>> +void migration_connect_error_propagate(MigrationState *s, Error *error);
>>  void migrate_error_propagate(MigrationState *s, Error *error);
>>  bool migrate_has_error(MigrationState *s);
>>  
>> -void migration_connect(MigrationState *s, Error *error_in);
>> +void migration_connect(MigrationState *s);
>>  
>>  int migration_call_notifiers(MigrationState *s, MigrationEventType type,
>>                               Error **errp);
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index 337b415889..596a1aba0b 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -3997,7 +3997,7 @@ void rdma_start_outgoing_migration(void *opaque,
>>  
>>      s->to_dst_file = rdma_new_output(rdma);
>>      s->rdma_migration = true;
>> -    migration_connect(s, NULL);
>> +    migration_connect(s);
>>      return;
>>  return_path_err:
>>      qemu_rdma_cleanup(rdma);
>> diff --git a/migration/socket.c b/migration/socket.c
>> index 426f363b99..298bac30cc 100644
>> --- a/migration/socket.c
>> +++ b/migration/socket.c
>> @@ -59,24 +59,25 @@ static void socket_outgoing_migration(QIOTask *task,
>>                                        gpointer opaque)
>>  {
>>      struct SocketConnectData *data = opaque;
>> -    QIOChannel *sioc = QIO_CHANNEL(qio_task_get_source(task));
>> +    g_autoptr(QIOChannel) sioc = QIO_CHANNEL(qio_task_get_source(task));
>>      Error *err = NULL;
>>  
>>      if (qio_task_propagate_error(task, &err)) {
>> -        trace_migration_socket_outgoing_error(error_get_pretty(err));
>> -           goto out;
>> +        goto err;
>>      }
>>  
>> -    trace_migration_socket_outgoing_connected();
>> -
>>      if (migrate_zero_copy_send() &&
>>          !qio_channel_has_feature(sioc, QIO_CHANNEL_FEATURE_WRITE_ZERO_COPY)) {
>>          error_setg(&err, "Zero copy send feature not detected in host kernel");
>> +        goto err;
>>      }
>>  
>> -out:
>> -    migration_channel_connect(data->s, sioc, err);
>> -    object_unref(OBJECT(sioc));
>> +    trace_migration_socket_outgoing_connected();
>> +    migration_channel_connect(data->s, sioc);
>> +    return;
>> +err:
>> +    trace_migration_socket_outgoing_error(error_get_pretty(err));
>> +    migration_connect_error_propagate(data->s, err);
>>  }
>>  
>>  void socket_start_outgoing_migration(MigrationState *s,
>> diff --git a/migration/tls.c b/migration/tls.c
>> index 82f58cbc78..a54e8e6e14 100644
>> --- a/migration/tls.c
>> +++ b/migration/tls.c
>> @@ -104,16 +104,17 @@ static void migration_tls_outgoing_handshake(QIOTask *task,
>>                                               gpointer opaque)
>>  {
>>      MigrationState *s = opaque;
>> -    QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
>> +    g_autoptr(QIOChannel) ioc = QIO_CHANNEL(qio_task_get_source(task));
>>      Error *err = NULL;
>>  
>>      if (qio_task_propagate_error(task, &err)) {
>>          trace_migration_tls_outgoing_handshake_error(error_get_pretty(err));
>> -    } else {
>> -        trace_migration_tls_outgoing_handshake_complete();
>> +        migration_connect_error_propagate(s, err);
>> +        return;
>>      }
>> -    migration_channel_connect(s, ioc, err);
>> -    object_unref(OBJECT(ioc));
>> +
>> +    trace_migration_tls_outgoing_handshake_complete();
>> +    migration_channel_connect(s, ioc);
>>  }
>>  
>>  QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
>> @@ -129,14 +130,14 @@ QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
>>      return qio_channel_tls_new_client(ioc, creds, migrate_tls_hostname(), errp);
>>  }
>>  
>> -void migration_tls_channel_connect(MigrationState *s,
>> -                                   QIOChannel *ioc,
>> -                                   Error **errp)
>> +void migration_tls_channel_connect(MigrationState *s, QIOChannel *ioc)
>>  {
>>      QIOChannelTLS *tioc;
>> +    Error *local_err = NULL;
>>  
>> -    tioc = migration_tls_client_create(ioc, errp);
>> +    tioc = migration_tls_client_create(ioc, &local_err);
>>      if (!tioc) {
>> +        migration_connect_error_propagate(s, local_err);
>>          return;
>>      }
>>  
>> diff --git a/migration/tls.h b/migration/tls.h
>> index 7cd9c76013..7399c42edf 100644
>> --- a/migration/tls.h
>> +++ b/migration/tls.h
>> @@ -29,9 +29,7 @@ void migration_tls_channel_process_incoming(QIOChannel *ioc, Error **errp);
>>  QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
>>                                             Error **errp);
>>  
>> -void migration_tls_channel_connect(MigrationState *s,
>> -                                   QIOChannel *ioc,
>> -                                   Error **errp);
>> +void migration_tls_channel_connect(MigrationState *s, QIOChannel *ioc);
>>  void migration_tls_channel_end(QIOChannel *ioc, Error **errp);
>>  /* Whether the QIO channel requires further TLS handshake? */
>>  bool migrate_channel_requires_tls_upgrade(QIOChannel *ioc);
>> diff --git a/migration/trace-events b/migration/trace-events
>> index da8f909cac..cbf10d0b63 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -204,7 +204,7 @@ migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma)
>>  
>>  # channel.c
>>  migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
>> -migration_set_outgoing_channel(void *ioc, const char *ioctype, void *err)  "ioc=%p ioctype=%s err=%p"
>> +migration_set_outgoing_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
>>  
>>  # global_state.c
>>  migrate_state_too_big(void) ""
>> -- 
>> 2.51.0
>> 

