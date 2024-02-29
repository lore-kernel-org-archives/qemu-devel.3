Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED71CC54E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 14:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhOE-0005zz-9b; Thu, 29 Feb 2024 09:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfhO4-0005Vo-4Q
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:27:52 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfhO2-0005v4-0u
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:27:51 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AA46F225D3;
 Thu, 29 Feb 2024 14:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709216867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5IYpXJXZ6JkwiLUARsOdXPZwYwAWQvdJiqE7KW+sd/g=;
 b=ROWO6p4vxDJUQCNgVJJUFTmmvscrpeKzEHsqMFO+J9XK2N1GnAYGLg/uqVdTAFOKVVFGEe
 xqdFucASm8P7FmJbl7jNJ/ooFA4OKLJji054s6AkgvJj0eVWRJvR+EbzRlueHxMeTr1j+e
 oHcbCLyxnHg0agK/nV5NRCw0ptdhqDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709216867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5IYpXJXZ6JkwiLUARsOdXPZwYwAWQvdJiqE7KW+sd/g=;
 b=NnLZzkMzm84PpZm7+WOkOkzUcjifuS8eGl7iR6WHZXk0W87jMnaBbTUsYn7zm5IRi8yR/O
 huUsl7vG68vao1Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709216867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5IYpXJXZ6JkwiLUARsOdXPZwYwAWQvdJiqE7KW+sd/g=;
 b=ROWO6p4vxDJUQCNgVJJUFTmmvscrpeKzEHsqMFO+J9XK2N1GnAYGLg/uqVdTAFOKVVFGEe
 xqdFucASm8P7FmJbl7jNJ/ooFA4OKLJji054s6AkgvJj0eVWRJvR+EbzRlueHxMeTr1j+e
 oHcbCLyxnHg0agK/nV5NRCw0ptdhqDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709216867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5IYpXJXZ6JkwiLUARsOdXPZwYwAWQvdJiqE7KW+sd/g=;
 b=NnLZzkMzm84PpZm7+WOkOkzUcjifuS8eGl7iR6WHZXk0W87jMnaBbTUsYn7zm5IRi8yR/O
 huUsl7vG68vao1Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E0A913A4B;
 Thu, 29 Feb 2024 14:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Aqr2OGKU4GVkIAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 29 Feb 2024 14:27:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>
Subject: Re: [PATCH v5 17/23] migration/multifd: Add outgoing QIOChannelFile
 support
In-Reply-To: <Zd_67kAJ3OcDFNjC@x1n>
References: <20240228152127.18769-1-farosas@suse.de>
 <20240228152127.18769-18-farosas@suse.de> <Zd_vhfonAX5gIcJl@x1n>
 <Zd_67kAJ3OcDFNjC@x1n>
Date: Thu, 29 Feb 2024 11:27:44 -0300
Message-ID: <87msrjz6ov.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ROWO6p4v;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NnLZzkMz
X-Spamd-Result: default: False [-4.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 BAYES_HAM(-3.00)[100.00%]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[5];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: AA46F225D3
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Thu, Feb 29, 2024 at 10:44:21AM +0800, Peter Xu wrote:
>> On Wed, Feb 28, 2024 at 12:21:21PM -0300, Fabiano Rosas wrote:
>> > Allow multifd to open file-backed channels. This will be used when
>> > enabling the mapped-ram migration stream format which expects a
>> > seekable transport.
>> > 
>> > The QIOChannel read and write methods will use the preadv/pwritev
>> > versions which don't update the file offset at each call so we can
>> > reuse the fd without re-opening for every channel.
>> > 
>> > Contrary to the socket migration, the file migration doesn't need an
>> > asynchronous channel creation process, so expose
>> > multifd_channel_connect() and call it directly.
>> > 
>> > Note that this is just setup code and multifd cannot yet make use of
>> > the file channels.
>> > 
>> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> > ---
>> > - moved flags change to another patch
>> > - removed channels_created assert
>> > ---
>> >  migration/file.c    | 41 +++++++++++++++++++++++++++++++++++++++--
>> >  migration/file.h    |  4 ++++
>> >  migration/multifd.c | 18 +++++++++++++++---
>> >  migration/multifd.h |  1 +
>> >  4 files changed, 59 insertions(+), 5 deletions(-)
>> > 
>> > diff --git a/migration/file.c b/migration/file.c
>> > index 22d052a71f..83328a7a1b 100644
>> > --- a/migration/file.c
>> > +++ b/migration/file.c
>> > @@ -12,12 +12,17 @@
>> >  #include "channel.h"
>> >  #include "file.h"
>> >  #include "migration.h"
>> > +#include "multifd.h"
>> >  #include "io/channel-file.h"
>> >  #include "io/channel-util.h"
>> >  #include "trace.h"
>> >  
>> >  #define OFFSET_OPTION ",offset="
>> >  
>> > +static struct FileOutgoingArgs {
>> > +    char *fname;
>> > +} outgoing_args;
>> > +
>> >  /* Remove the offset option from @filespec and return it in @offsetp. */
>> >  
>> >  int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
>> > @@ -37,6 +42,36 @@ int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp)
>> >      return 0;
>> >  }
>> >  
>> > +void file_cleanup_outgoing_migration(void)
>> > +{
>> > +    g_free(outgoing_args.fname);
>> > +    outgoing_args.fname = NULL;
>> > +}
>> > +
>> > +bool file_send_channel_create(gpointer opaque, Error **errp)
>> > +{
>> > +    QIOChannelFile *ioc;
>> > +    int flags = O_WRONLY;
>> > +    bool ret = true;
>> > +
>> > +    ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
>> > +    if (!ioc) {
>> > +        ret = false;
>> > +        goto out;
>> > +    }
>> > +
>> > +    multifd_channel_connect(opaque, QIO_CHANNEL(ioc));
>> > +
>> > +out:
>> > +    /*
>> > +     * File channel creation is synchronous. However posting this
>> > +     * semaphore here is simpler than adding a special case.
>> > +     */
>> > +    multifd_send_channel_created();
>> > +
>> > +    return ret;
>> > +}
>> > +
>> >  void file_start_outgoing_migration(MigrationState *s,
>> >                                     FileMigrationArgs *file_args, Error **errp)
>> >  {
>> > @@ -47,12 +82,14 @@ void file_start_outgoing_migration(MigrationState *s,
>> >  
>> >      trace_migration_file_outgoing(filename);
>> >  
>> > -    fioc = qio_channel_file_new_path(filename, O_CREAT | O_WRONLY | O_TRUNC,
>> > -                                     0600, errp);
>> > +    fioc = qio_channel_file_new_path(filename, O_CREAT | O_TRUNC | O_WRONLY,
>> > +                                     0660, errp);
>> 
>> It seems this is still leftover?
>> 
>> >      if (!fioc) {
>> >          return;
>> >      }
>> >  
>> > +    outgoing_args.fname = g_strdup(filename);
>> > +
>> >      ioc = QIO_CHANNEL(fioc);
>> >      if (offset && qio_channel_io_seek(ioc, offset, SEEK_SET, errp) < 0) {
>> >          return;
>> > diff --git a/migration/file.h b/migration/file.h
>> > index 37d6a08bfc..4577f9efdd 100644
>> > --- a/migration/file.h
>> > +++ b/migration/file.h
>> > @@ -9,10 +9,14 @@
>> >  #define QEMU_MIGRATION_FILE_H
>> >  
>> >  #include "qapi/qapi-types-migration.h"
>> > +#include "io/task.h"
>> > +#include "channel.h"
>> >  
>> >  void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp);
>> >  
>> >  void file_start_outgoing_migration(MigrationState *s,
>> >                                     FileMigrationArgs *file_args, Error **errp);
>> >  int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
>> > +void file_cleanup_outgoing_migration(void);
>> > +bool file_send_channel_create(gpointer opaque, Error **errp);
>> >  #endif
>> > diff --git a/migration/multifd.c b/migration/multifd.c
>> > index 3574fd3953..f155223303 100644
>> > --- a/migration/multifd.c
>> > +++ b/migration/multifd.c
>> > @@ -17,6 +17,7 @@
>> >  #include "exec/ramblock.h"
>> >  #include "qemu/error-report.h"
>> >  #include "qapi/error.h"
>> > +#include "file.h"
>> >  #include "ram.h"
>> >  #include "migration.h"
>> >  #include "migration-stats.h"
>> > @@ -28,6 +29,7 @@
>> >  #include "threadinfo.h"
>> >  #include "options.h"
>> >  #include "qemu/yank.h"
>> > +#include "io/channel-file.h"
>> >  #include "io/channel-socket.h"
>> >  #include "yank_functions.h"
>> >  
>> > @@ -694,6 +696,7 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
>> >  {
>> >      if (p->c) {
>> >          migration_ioc_unregister_yank(p->c);
>> > +        qio_channel_close(p->c, NULL);
>> 
>> s/NULL/&error_abort/?
>
> Or we can drop this line?  IIUC iochannel finalize() will always close it,
> or it could be a separate bug.
>

We need it so the fsync happens. The finalize() will be a noop because
the qio_channel_file_close() will clear the fd. Not the cleanest, but it
works.

>> 
>> >          object_unref(OBJECT(p->c));
>> >          p->c = NULL;
>> >      }
>> > @@ -715,6 +718,7 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
>> >  
>> >  static void multifd_send_cleanup_state(void)
>> >  {
>> > +    file_cleanup_outgoing_migration();
>> >      socket_cleanup_outgoing_migration();
>> >      qemu_sem_destroy(&multifd_send_state->channels_created);
>> >      qemu_sem_destroy(&multifd_send_state->channels_ready);
>> > @@ -977,7 +981,7 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
>> >      return true;
>> >  }
>> >  
>> > -static void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc)
>> > +void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc)
>> >  {
>> >      qio_channel_set_delay(ioc, false);
>> >  
>> > @@ -1045,9 +1049,14 @@ out:
>> >      error_free(local_err);
>> >  }
>> >  
>> > -static void multifd_new_send_channel_create(gpointer opaque)
>> > +static bool multifd_new_send_channel_create(gpointer opaque, Error **errp)
>> >  {
>> > +    if (!multifd_use_packets()) {
>> > +        return file_send_channel_create(opaque, errp);
>> > +    }
>> > +
>> >      socket_send_channel_create(multifd_new_send_channel_async, opaque);
>> > +    return true;
>> >  }
>> >  
>> >  bool multifd_send_setup(void)
>> > @@ -1096,7 +1105,10 @@ bool multifd_send_setup(void)
>> >          p->page_size = qemu_target_page_size();
>> >          p->page_count = page_count;
>> >          p->write_flags = 0;
>> > -        multifd_new_send_channel_create(p);
>> > +
>> > +        if (!multifd_new_send_channel_create(p, &local_err)) {
>> > +            return -1;
>> 
>> "-1" is unfortunately a "true"!..
>> 
>> > +        }
>> >      }
>> >  
>> >      /*
>> > diff --git a/migration/multifd.h b/migration/multifd.h
>> > index 1d8bbaf96b..db8887f088 100644
>> > --- a/migration/multifd.h
>> > +++ b/migration/multifd.h
>> > @@ -227,5 +227,6 @@ static inline void multifd_send_prepare_header(MultiFDSendParams *p)
>> >      p->iovs_num++;
>> >  }
>> >  
>> > +void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc);
>> >  
>> >  #endif
>> > -- 
>> > 2.35.3
>> > 
>> 
>> -- 
>> Peter Xu

