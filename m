Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9468BE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJIGj-0001a1-LT; Thu, 05 Dec 2024 15:16:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJIGi-0001Zs-Jn
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:16:12 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJIGg-0007Yg-52
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:16:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1DEAB1F393;
 Thu,  5 Dec 2024 20:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733429768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mhgeAtsmZCbFjnZRWjg7eknpnn1UFezqu/W829VL4aw=;
 b=sXF9NS9truLjYBmC1L7pKNDbSELvGRRoR/NM2ZdFhasru2hmBZuGr9BFNuZy5c2TB3b5jS
 LIiwBlBJDQiXLy4JRAedSfPigm/a/iD9Mxrrq/gn4si5dFOF7TMLkkFV0d7fAXZO4iMgGj
 D9JPUwwO357XLDiC5Lr5RzWn/xHwG1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733429768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mhgeAtsmZCbFjnZRWjg7eknpnn1UFezqu/W829VL4aw=;
 b=oWtALxQ4Kuh7e9nZTXx6nbFtICZMajnekIhedT5iu4vINyo1pzekZ+zO+wR8ccCXEL/0KK
 drdKygfNew7PPuBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sXF9NS9t;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oWtALxQ4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733429768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mhgeAtsmZCbFjnZRWjg7eknpnn1UFezqu/W829VL4aw=;
 b=sXF9NS9truLjYBmC1L7pKNDbSELvGRRoR/NM2ZdFhasru2hmBZuGr9BFNuZy5c2TB3b5jS
 LIiwBlBJDQiXLy4JRAedSfPigm/a/iD9Mxrrq/gn4si5dFOF7TMLkkFV0d7fAXZO4iMgGj
 D9JPUwwO357XLDiC5Lr5RzWn/xHwG1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733429768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mhgeAtsmZCbFjnZRWjg7eknpnn1UFezqu/W829VL4aw=;
 b=oWtALxQ4Kuh7e9nZTXx6nbFtICZMajnekIhedT5iu4vINyo1pzekZ+zO+wR8ccCXEL/0KK
 drdKygfNew7PPuBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98FF0138A5;
 Thu,  5 Dec 2024 20:16:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eJy7FwcKUmc7SwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 05 Dec 2024 20:16:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 2/2] migration/multifd: Allow to sync with sender
 threads only
In-Reply-To: <20241205185303.897010-3-peterx@redhat.com>
References: <20241205185303.897010-1-peterx@redhat.com>
 <20241205185303.897010-3-peterx@redhat.com>
Date: Thu, 05 Dec 2024 17:16:05 -0300
Message-ID: <875xnxj37e.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 1DEAB1F393
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> Teach multifd_send_sync_main() to sync with threads only.
>
> We already have such requests, which is when mapped-ram is enabled with
> multifd.  In that case, no SYNC messages will be pushed to the stream when
> multifd syncs the sender threads because there's no destination threads
> waiting for that.  The whole point of the sync is to make sure all threads
> flushed their jobs.
>
> So fundamentally we have a request to do the sync in different ways:
>
>   - Either to sync the threads only,
>   - Or to sync the threads but also with the destination side
>
> Mapped-ram did it already because of the use_packet check in the sync
> handler of the sender thread.  It works.
>
> However it may stop working when e.g. VFIO may start to reuse multifd
> channels to push device states.  In that case VFIO has similar request on
> "thread-only sync" however we can't check a flag because such sync request
> can still come from RAM which needs the on-wire notifications.
>
> Paving way for that by allowing the multifd_send_sync_main() to specify
> what kind of sync the caller needs.  We can use it for mapped-ram already.
>
> No functional change intended.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/multifd.h        | 16 +++++++++++++---
>  migration/multifd-nocomp.c |  8 +++++++-
>  migration/multifd.c        | 14 ++++++++------
>  3 files changed, 28 insertions(+), 10 deletions(-)
>
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 50d58c0c9c..6b2f60a917 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -19,6 +19,15 @@
>  typedef struct MultiFDRecvData MultiFDRecvData;
>  typedef struct MultiFDSendData MultiFDSendData;
>  
> +typedef enum {
> +    /* No sync request */
> +    MULTIFD_SYNC_NONE = 0,
> +    /* Sync on the sender threads without pushing messages */
> +    MULTIFD_SYNC_THREADS,
> +    /* Sync on the sender threads, meanwhile push "SYNC" message to the wire */

s/meanwhile//

> +    MULTIFD_SYNC_THREADS_AND_NOTIFY,
> +} MultiFDSyncReq;

I think I'd prefer the local vs. remote terminology I introduced in my
proposal [1] for cleaning up the multifd_flush_after_each_section() code:

LOCAL - sync the local threads between themselves
REMOTE - put a message on the stream for the remote end to perform a
         sync on their threads.

Down below you're passing the
MULTIFD_SYNC_THREADS_AND_NOTIFY into the send thread, but the "sync
threads" part of this is really done outside the thread, so that part
doesn't have a meaning inside the thread.

1- https://lore.kernel.org/r/875xo8n4ue.fsf@suse.de

Also, please provide your input there^, it would be nice to unify the
terminology and reasoning about both changes.

> +
>  bool multifd_send_setup(void);
>  void multifd_send_shutdown(void);
>  void multifd_send_channel_created(void);
> @@ -28,7 +37,7 @@ void multifd_recv_shutdown(void);
>  bool multifd_recv_all_channels_created(void);
>  void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
>  void multifd_recv_sync_main(void);
> -int multifd_send_sync_main(void);
> +int multifd_send_sync_main(MultiFDSyncReq req);
>  bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
>  bool multifd_recv(void);
>  MultiFDRecvData *multifd_get_recv_data(void);
> @@ -143,7 +152,7 @@ typedef struct {
>      /* multifd flags for each packet */
>      uint32_t flags;
>      /*
> -     * The sender thread has work to do if either of below boolean is set.
> +     * The sender thread has work to do if either of below field is set.
>       *
>       * @pending_job:  a job is pending
>       * @pending_sync: a sync request is pending
> @@ -152,7 +161,8 @@ typedef struct {
>       * cleared by the multifd sender threads.
>       */
>      bool pending_job;
> -    bool pending_sync;
> +    MultiFDSyncReq pending_sync;
> +
>      MultiFDSendData *data;
>  
>      /* thread local variables. No locking required */
> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> index 55191152f9..f64c4c9abd 100644
> --- a/migration/multifd-nocomp.c
> +++ b/migration/multifd-nocomp.c
> @@ -345,6 +345,8 @@ retry:
>  
>  int multifd_ram_flush_and_sync(void)
>  {
> +    MultiFDSyncReq req;
> +
>      if (!migrate_multifd()) {
>          return 0;
>      }
> @@ -356,7 +358,11 @@ int multifd_ram_flush_and_sync(void)
>          }
>      }
>  
> -    return multifd_send_sync_main();
> +    /* File migrations only need to sync with threads */
> +    req = migrate_mapped_ram() ?
> +        MULTIFD_SYNC_THREADS : MULTIFD_SYNC_THREADS_AND_NOTIFY;
> +
> +    return multifd_send_sync_main(req);
>  }
>  
>  bool multifd_send_prepare_common(MultiFDSendParams *p)
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 498e71fd10..77645e87a0 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -523,7 +523,7 @@ static int multifd_zero_copy_flush(QIOChannel *c)
>      return ret;
>  }
>  
> -int multifd_send_sync_main(void)
> +int multifd_send_sync_main(MultiFDSyncReq req)
>  {
>      int i;
>      bool flush_zero_copy;
> @@ -543,8 +543,8 @@ int multifd_send_sync_main(void)
>           * We should be the only user so far, so not possible to be set by
>           * others concurrently.
>           */
> -        assert(qatomic_read(&p->pending_sync) == false);
> -        qatomic_set(&p->pending_sync, true);
> +        assert(qatomic_read(&p->pending_sync) == MULTIFD_SYNC_NONE);
> +        qatomic_set(&p->pending_sync, req);

Hmm, isn't it easier to skip the whole loop if req ==
MULTIFD_SYNC_THREADS? I don't remember why we kept this loop here for
mapped-ram.

>          qemu_sem_post(&p->sem);
>      }
>      for (i = 0; i < migrate_multifd_channels(); i++) {
> @@ -635,14 +635,16 @@ static void *multifd_send_thread(void *opaque)
>               */
>              qatomic_store_release(&p->pending_job, false);
>          } else {
> +            MultiFDSyncReq req = qatomic_read(&p->pending_sync);
> +
>              /*
>               * If not a normal job, must be a sync request.  Note that
>               * pending_sync is a standalone flag (unlike pending_job), so
>               * it doesn't require explicit memory barriers.
>               */
> -            assert(qatomic_read(&p->pending_sync));
> +            assert(req != MULTIFD_SYNC_NONE);
>  
> -            if (use_packets) {
> +            if (req == MULTIFD_SYNC_THREADS_AND_NOTIFY) {

Good, more explicit.

>                  p->flags = MULTIFD_FLAG_SYNC;
>                  multifd_send_fill_packet(p);
>                  ret = qio_channel_write_all(p->c, (void *)p->packet,
> @@ -654,7 +656,7 @@ static void *multifd_send_thread(void *opaque)
>                  stat64_add(&mig_stats.multifd_bytes, p->packet_len);
>              }
>  
> -            qatomic_set(&p->pending_sync, false);
> +            qatomic_set(&p->pending_sync, MULTIFD_SYNC_NONE);

It's a bit weird that MULTIFD_SYNC_THREADS will never have an use inside
the thread. Makes me think it should never exist in the first place. But
then we're back into pending_sync + use_packets... looks like it would
be less convoluted to skip the loop up there and assert(!use_packets) in
here.

Unless I'm missing something...

>              qemu_sem_post(&p->sem_sync);
>          }
>      }

