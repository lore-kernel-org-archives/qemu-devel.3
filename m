Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C28CE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 13:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJYLi-0007i8-TO; Fri, 06 Dec 2024 08:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJYLY-0007eH-KR
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:26:18 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJYLU-0002FU-A6
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:26:13 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 007701F394;
 Fri,  6 Dec 2024 13:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733491570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6jYdPke2HWurNFqMsT55dw2zX5Pl8WQp+od2q+pJOr8=;
 b=T6bkUHvbUkp4/wiHKkzVEfaGUiAUMwUDR9kCEJBT2bdoDGNYX4KrXz7ySSZZOWrB7O+dwl
 3r7L8sJYjNva6Jf9W5zAs5BOq9+VMOjT7FYbEiWpxgbDsCeJjIK5hrPgNGapny16eWFCAT
 WdHYq8PDyHDykBFL4TnqKG4GDJC2LRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733491570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6jYdPke2HWurNFqMsT55dw2zX5Pl8WQp+od2q+pJOr8=;
 b=CnKKYYHRBec95UvPDLt27qQpgFh8zrOeob6mfgeLoh5oZFwppCNYHIaI2UDjqdsAdZpGxH
 EjxMy1lXPjWgmyDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733491570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6jYdPke2HWurNFqMsT55dw2zX5Pl8WQp+od2q+pJOr8=;
 b=T6bkUHvbUkp4/wiHKkzVEfaGUiAUMwUDR9kCEJBT2bdoDGNYX4KrXz7ySSZZOWrB7O+dwl
 3r7L8sJYjNva6Jf9W5zAs5BOq9+VMOjT7FYbEiWpxgbDsCeJjIK5hrPgNGapny16eWFCAT
 WdHYq8PDyHDykBFL4TnqKG4GDJC2LRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733491570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6jYdPke2HWurNFqMsT55dw2zX5Pl8WQp+od2q+pJOr8=;
 b=CnKKYYHRBec95UvPDLt27qQpgFh8zrOeob6mfgeLoh5oZFwppCNYHIaI2UDjqdsAdZpGxH
 EjxMy1lXPjWgmyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D98D13647;
 Fri,  6 Dec 2024 13:26:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nlVkEXH7Umd7VgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Dec 2024 13:26:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, peterx@redhat.com,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>, Alex
 Williamson <alex.williamson@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 2/7] migration/multifd: Allow to sync with sender
 threads only
In-Reply-To: <20241206005834.1050905-3-peterx@redhat.com>
References: <20241206005834.1050905-1-peterx@redhat.com>
 <20241206005834.1050905-3-peterx@redhat.com>
Date: Fri, 06 Dec 2024 10:26:06 -0300
Message-ID: <877c8dc58x.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

s/flushed/finished/ otherwise we risk confusing people.

>
> So fundamentally we have a request to do the sync in different ways:
>
>   - Either to sync the threads only,
>   - Or to sync the threads but also with the destination side.
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
>  migration/multifd.h        | 19 ++++++++++++++++---
>  migration/multifd-nocomp.c |  7 ++++++-
>  migration/multifd.c        | 15 +++++++++------
>  3 files changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 50d58c0c9c..bd337631ec 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -19,6 +19,18 @@
>  typedef struct MultiFDRecvData MultiFDRecvData;
>  typedef struct MultiFDSendData MultiFDSendData;
>  
> +typedef enum {
> +    /* No sync request */
> +    MULTIFD_SYNC_NONE = 0,
> +    /* Sync locally on the sender threads without pushing messages */
> +    MULTIFD_SYNC_LOCAL,
> +    /*
> +     * Sync not only on the sender threads, but also push "SYNC" message to
> +     * the wire (which is for a remote sync).

s/SYNC/MULTIFD_FLAG_SYNC/

Do we need to also mention that this needs to be paired with a
multifd_recv_sync_main() via the emission of the
RAM_SAVE_FLAG_MULTIFD_FLUSH flag on the stream?

> +     */
> +    MULTIFD_SYNC_ALL,
> +} MultiFDSyncReq;
> +
>  bool multifd_send_setup(void);
>  void multifd_send_shutdown(void);
>  void multifd_send_channel_created(void);
> @@ -28,7 +40,7 @@ void multifd_recv_shutdown(void);
>  bool multifd_recv_all_channels_created(void);
>  void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
>  void multifd_recv_sync_main(void);
> -int multifd_send_sync_main(void);
> +int multifd_send_sync_main(MultiFDSyncReq req);
>  bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
>  bool multifd_recv(void);
>  MultiFDRecvData *multifd_get_recv_data(void);
> @@ -143,7 +155,7 @@ typedef struct {
>      /* multifd flags for each packet */
>      uint32_t flags;
>      /*
> -     * The sender thread has work to do if either of below boolean is set.
> +     * The sender thread has work to do if either of below field is set.
>       *
>       * @pending_job:  a job is pending
>       * @pending_sync: a sync request is pending
> @@ -152,7 +164,8 @@ typedef struct {
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
> index 55191152f9..219f9e58ef 100644
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
> @@ -356,7 +358,10 @@ int multifd_ram_flush_and_sync(void)
>          }
>      }
>  
> -    return multifd_send_sync_main();
> +    /* File migrations only need to sync with threads */
> +    req = migrate_mapped_ram() ? MULTIFD_SYNC_LOCAL : MULTIFD_SYNC_ALL;
> +
> +    return multifd_send_sync_main(req);
>  }
>  
>  bool multifd_send_prepare_common(MultiFDSendParams *p)
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 498e71fd10..2248bd2d46 100644
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

assert(req != MULTIFD_SYNC_NONE) ?

> @@ -543,8 +543,8 @@ int multifd_send_sync_main(void)
>           * We should be the only user so far, so not possible to be set by
>           * others concurrently.
>           */
> -        assert(qatomic_read(&p->pending_sync) == false);
> -        qatomic_set(&p->pending_sync, true);
> +        assert(qatomic_read(&p->pending_sync) == MULTIFD_SYNC_NONE);
> +        qatomic_set(&p->pending_sync, req);
>          qemu_sem_post(&p->sem);
>      }
>      for (i = 0; i < migrate_multifd_channels(); i++) {
> @@ -635,14 +635,17 @@ static void *multifd_send_thread(void *opaque)
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
> +            /* Only push the SYNC message if it involves a remote sync */
> +            if (req == MULTIFD_SYNC_ALL) {
>                  p->flags = MULTIFD_FLAG_SYNC;
>                  multifd_send_fill_packet(p);
>                  ret = qio_channel_write_all(p->c, (void *)p->packet,
> @@ -654,7 +657,7 @@ static void *multifd_send_thread(void *opaque)
>                  stat64_add(&mig_stats.multifd_bytes, p->packet_len);
>              }
>  
> -            qatomic_set(&p->pending_sync, false);
> +            qatomic_set(&p->pending_sync, MULTIFD_SYNC_NONE);
>              qemu_sem_post(&p->sem_sync);
>          }
>      }

