Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281AEC54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQGi-0007D4-PU; Wed, 13 Mar 2024 11:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rkQGV-0005n9-1q
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 11:11:39 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rkQGI-0006kI-Rh
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 11:11:34 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 849C221C75;
 Wed, 13 Mar 2024 15:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710342680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wqc+S3KogG0hVeINQwvTFYdsTBB7WNFbJUVwPtjtmRM=;
 b=IA+qsDwkpUhhjCkhGbJdS+VAEGKjJq24IJMnrK7lhVvnrViTArNHenaanBCZBb5xPhdBJs
 sGEZy7J1LkieRpYGx+gFV4GAzZ3KZQ4gAAUR2hsaKvr4KgDb7GNwDi4/svgcWJFtYEonEV
 6hNtmV60d+AqiGV9gtxF+NKRy4mLhTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710342680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wqc+S3KogG0hVeINQwvTFYdsTBB7WNFbJUVwPtjtmRM=;
 b=JbZapmJwlm7E2e6EjNMXUcetiaoMG2nZhyZFyUKOzGmw4asEIdirxASwXKnWnWvCllMiay
 6IlAhg2s/0R8rYCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710342680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wqc+S3KogG0hVeINQwvTFYdsTBB7WNFbJUVwPtjtmRM=;
 b=IA+qsDwkpUhhjCkhGbJdS+VAEGKjJq24IJMnrK7lhVvnrViTArNHenaanBCZBb5xPhdBJs
 sGEZy7J1LkieRpYGx+gFV4GAzZ3KZQ4gAAUR2hsaKvr4KgDb7GNwDi4/svgcWJFtYEonEV
 6hNtmV60d+AqiGV9gtxF+NKRy4mLhTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710342680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wqc+S3KogG0hVeINQwvTFYdsTBB7WNFbJUVwPtjtmRM=;
 b=JbZapmJwlm7E2e6EjNMXUcetiaoMG2nZhyZFyUKOzGmw4asEIdirxASwXKnWnWvCllMiay
 6IlAhg2s/0R8rYCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EF3313977;
 Wed, 13 Mar 2024 15:11:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vpWuMRfC8WUpcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Mar 2024 15:11:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH] migration: Fix iocs leaks during file and fd migration
In-Reply-To: <ZfG-apnNAky0e5yw@x1n>
References: <20240313135018.28079-1-farosas@suse.de> <ZfG-apnNAky0e5yw@x1n>
Date: Wed, 13 Mar 2024 12:11:17 -0300
Message-ID: <874jdacgkq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IA+qsDwk;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JbZapmJw
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 BAYES_HAM(-3.00)[100.00%]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 849C221C75
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Wed, Mar 13, 2024 at 10:50:18AM -0300, Fabiano Rosas wrote:
>> The memory for the io channels is being leaked in three different ways
>> during file migration:
>> 
>> 1) if the offset check fails we never drop the ioc reference;
>> 
>> 2) if multifd is not enabled, we allocate an extra channel for no
>>    reason;
>
> This leak should also happen even if multifd enabled; it just always leak
> one unconditionally..
>
>> 
>> 3) if multifd is enabled but channel creation fails when calling
>>    dup(), we leave the previous channels around along with the glib
>>    polling;
>> 
>> Fix all issues by restructuring the code to first allocate the
>> channels and only register the watches when all channels have been
>> created.
>> 
>> The file and fd migrations can share this code because both are backed
>> by the file migration infrastructure.
>> 
>> Fixes: 2dd7ee7a51 ("migration/multifd: Add incoming QIOChannelFile support")
>> Fixes: decdc76772 ("migration/multifd: Add mapped-ram support to fd: URI")
>> Reported-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>> based-on: https://gitlab.com/peterx/migration-stable
>
> Invalid link. :)

lol, all kinds of wrong.

The correct one would be:

https://gitlab.com/peterx/qemu/-/commits/migration-stable

>
> I am not sure whether patchew will understand this even if the link is
> correct, but I hope!

I was thinking more of helping reviewers than patchew actually.

>
>> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1211909831
>> ---
>>  migration/fd.c   | 28 +++-------------------
>>  migration/file.c | 62 +++++++++++++++++++++++++++++++-----------------
>>  migration/file.h |  3 +++
>>  3 files changed, 46 insertions(+), 47 deletions(-)
>> 
>> diff --git a/migration/fd.c b/migration/fd.c
>> index 4e2a63a73d..b74a3eb8c8 100644
>> --- a/migration/fd.c
>> +++ b/migration/fd.c
>> @@ -18,6 +18,7 @@
>>  #include "qapi/error.h"
>>  #include "channel.h"
>>  #include "fd.h"
>> +#include "file.h"
>>  #include "migration.h"
>>  #include "monitor/monitor.h"
>>  #include "io/channel-file.h"
>> @@ -68,19 +69,9 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
>>      object_unref(OBJECT(ioc));
>>  }
>>  
>> -static gboolean fd_accept_incoming_migration(QIOChannel *ioc,
>> -                                             GIOCondition condition,
>> -                                             gpointer opaque)
>> -{
>> -    migration_channel_process_incoming(ioc);
>> -    object_unref(OBJECT(ioc));
>> -    return G_SOURCE_REMOVE;
>> -}
>> -
>>  void fd_start_incoming_migration(const char *fdname, Error **errp)
>>  {
>>      QIOChannel *ioc;
>> -    QIOChannelFile *fioc;
>>      int fd = monitor_fd_param(monitor_cur(), fdname, errp);
>>      if (fd == -1) {
>>          return;
>> @@ -96,24 +87,11 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
>>  
>>      qio_channel_set_name(ioc, "migration-fd-incoming");
>>      qio_channel_add_watch_full(ioc, G_IO_IN,
>> -                               fd_accept_incoming_migration,
>> +                               file_accept_incoming_migration,
>>                                 NULL, NULL,
>>                                 g_main_context_get_thread_default());
>
> Mostly correct, but IIUC we'll still leak this main io watch if below
> failed, similar issue for file path below.  We may need to manage all IOCs
> including the main one.
>

Yes, good point. Sigh... I'll get it right eventually.

>>  
>>      if (migrate_multifd()) {
>> -        int channels = migrate_multifd_channels();
>> -
>> -        while (channels--) {
>> -            fioc = qio_channel_file_new_dupfd(fd, errp);
>> -            if (!fioc) {
>> -                return;
>> -            }
>> -
>> -            qio_channel_set_name(ioc, "migration-fd-incoming");
>> -            qio_channel_add_watch_full(QIO_CHANNEL(fioc), G_IO_IN,
>> -                                       fd_accept_incoming_migration,
>> -                                       NULL, NULL,
>> -                                       g_main_context_get_thread_default());
>> -        }
>> +        file_recv_channels_create(fd, errp);
>>      }
>>  }
>> diff --git a/migration/file.c b/migration/file.c
>> index e56c5eb0a5..bb264115eb 100644
>> --- a/migration/file.c
>> +++ b/migration/file.c
>> @@ -106,22 +106,48 @@ void file_start_outgoing_migration(MigrationState *s,
>>      migration_channel_connect(s, ioc, NULL, NULL);
>>  }
>>  
>> -static gboolean file_accept_incoming_migration(QIOChannel *ioc,
>> -                                               GIOCondition condition,
>> -                                               gpointer opaque)
>> +gboolean file_accept_incoming_migration(QIOChannel *ioc, GIOCondition condition,
>> +                                        gpointer opaque)
>>  {
>>      migration_channel_process_incoming(ioc);
>>      object_unref(OBJECT(ioc));
>>      return G_SOURCE_REMOVE;
>>  }
>>  
>> +void file_recv_channels_create(int fd, Error **errp)
>> +{
>> +    int i, channels = migrate_multifd_channels();
>> +    g_autofree QIOChannelFile **fiocs = g_new0(QIOChannelFile *, channels);
>> +
>> +    for (i = 0; i < channels; i++) {
>> +        QIOChannelFile *fioc = qio_channel_file_new_dupfd(fd, errp);
>> +
>> +        if (!fioc) {
>> +            while (i) {
>> +                object_unref(fiocs[--i]);
>> +            }
>> +            return;
>> +        }
>> +
>> +        fiocs[i] = fioc;
>> +    }
>> +
>> +    for (i = 0; i < channels; i++) {
>> +        QIOChannelFile *fioc = fiocs[i];
>> +
>> +        qio_channel_set_name(QIO_CHANNEL(fioc), "migration-file-incoming");
>> +        qio_channel_add_watch_full(QIO_CHANNEL(fioc), G_IO_IN,
>> +                                   file_accept_incoming_migration,
>> +                                   NULL, NULL,
>> +                                   g_main_context_get_thread_default());
>> +    }
>> +}
>> +
>>  void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
>>  {
>>      g_autofree char *filename = g_strdup(file_args->filename);
>>      QIOChannelFile *fioc = NULL;
>>      uint64_t offset = file_args->offset;
>> -    int channels = 1;
>> -    int i = 0;
>>  
>>      trace_migration_file_incoming(filename);
>>  
>> @@ -132,28 +158,20 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
>>  
>>      if (offset &&
>>          qio_channel_io_seek(QIO_CHANNEL(fioc), offset, SEEK_SET, errp) < 0) {
>> +        object_unref(OBJECT(fioc));
>>          return;
>>      }
>>  
>> +    qio_channel_set_name(QIO_CHANNEL(fioc), "migration-file-incoming");
>> +    qio_channel_add_watch_full(QIO_CHANNEL(fioc), G_IO_IN,
>> +                               file_accept_incoming_migration,
>> +                               NULL, NULL,
>> +                               g_main_context_get_thread_default());
>> +
>> +
>>      if (migrate_multifd()) {
>> -        channels += migrate_multifd_channels();
>> +        file_recv_channels_create(fioc->fd, errp);
>>      }
>> -
>> -    do {
>> -        QIOChannel *ioc = QIO_CHANNEL(fioc);
>> -
>> -        qio_channel_set_name(ioc, "migration-file-incoming");
>> -        qio_channel_add_watch_full(ioc, G_IO_IN,
>> -                                   file_accept_incoming_migration,
>> -                                   NULL, NULL,
>> -                                   g_main_context_get_thread_default());
>> -
>> -        fioc = qio_channel_file_new_dupfd(fioc->fd, errp);
>> -
>> -        if (!fioc) {
>> -            break;
>> -        }
>> -    } while (++i < channels);
>>  }
>>  
>>  int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
>> diff --git a/migration/file.h b/migration/file.h
>> index 9f71e87f74..940122db0f 100644
>> --- a/migration/file.h
>> +++ b/migration/file.h
>> @@ -20,6 +20,9 @@ void file_start_outgoing_migration(MigrationState *s,
>>  int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
>>  void file_cleanup_outgoing_migration(void);
>>  bool file_send_channel_create(gpointer opaque, Error **errp);
>> +void file_recv_channels_create(int fd, Error **errp);
>> +gboolean file_accept_incoming_migration(QIOChannel *ioc, GIOCondition condition,
>> +                                        gpointer opaque);
>>  int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
>>                              int niov, RAMBlock *block, Error **errp);
>>  int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp);
>> -- 
>> 2.35.3
>> 

