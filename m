Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA90C48292
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 18:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX3GA-0002N9-2x; Mon, 05 Feb 2024 12:59:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rX3G4-0002Mp-JT
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 12:59:52 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rX3G2-0003bE-97
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 12:59:52 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B80E622167;
 Mon,  5 Feb 2024 17:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707155986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=87sbH+Xv9P2ednSXHSKURl+x+DPivMR0sbjcaxBWdv8=;
 b=Q61PZZSlqLFAcM+2wwNZKZJ0OiwJz4hobvubQJxGgavED4XxhlE8VKwPyQnhZF/dYMXq5c
 bLNrLubQU21GWa8QsnDKaI92Xuk3izB+UX5rFsLFHe7JOAoZpbQ1DM7cdiKrC17ih+T0bE
 Mi54J5F9SqSPh0C76odgg+PUlRi1WF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707155986;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=87sbH+Xv9P2ednSXHSKURl+x+DPivMR0sbjcaxBWdv8=;
 b=7tUSyCvWwpHsqoZCji79j2JWdlmd1nmH2S5iKRDgHW5AslCv7ILLK6oVEuwzy3G3Xj4R5J
 uED+/2cU5oqmd/Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707155986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=87sbH+Xv9P2ednSXHSKURl+x+DPivMR0sbjcaxBWdv8=;
 b=Q61PZZSlqLFAcM+2wwNZKZJ0OiwJz4hobvubQJxGgavED4XxhlE8VKwPyQnhZF/dYMXq5c
 bLNrLubQU21GWa8QsnDKaI92Xuk3izB+UX5rFsLFHe7JOAoZpbQ1DM7cdiKrC17ih+T0bE
 Mi54J5F9SqSPh0C76odgg+PUlRi1WF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707155986;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=87sbH+Xv9P2ednSXHSKURl+x+DPivMR0sbjcaxBWdv8=;
 b=7tUSyCvWwpHsqoZCji79j2JWdlmd1nmH2S5iKRDgHW5AslCv7ILLK6oVEuwzy3G3Xj4R5J
 uED+/2cU5oqmd/Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 367F2136F5;
 Mon,  5 Feb 2024 17:59:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ws0DABIiwWULKAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 Feb 2024 17:59:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Hao Xiang <hao.xiang@bytedance.com>, Bryan Zhang
 <bryan.zhang@bytedance.com>, Avihai Horon <avihaih@nvidia.com>, Yuan Liu
 <yuan1.liu@intel.com>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 23/23] migration/multifd: Optimize sender side to be
 lockless
In-Reply-To: <ZcDvt7ASULc-Xb_A@x1n>
References: <20240202102857.110210-1-peterx@redhat.com>
 <20240202102857.110210-24-peterx@redhat.com> <87wmrmft4f.fsf@suse.de>
 <ZcBloXUWBORVraiu@x1n> <87cytb57dx.fsf@suse.de> <ZcDvt7ASULc-Xb_A@x1n>
Date: Mon, 05 Feb 2024 14:59:43 -0300
Message-ID: <87y1byhjw0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Q61PZZSl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7tUSyCvW
X-Spamd-Result: default: False [-4.81 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B80E622167
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Mon, Feb 05, 2024 at 11:10:34AM -0300, Fabiano Rosas wrote:
>> > (maybe I can repost this single patch in-place to avoid another round of
>> >  mail bombs..)
>> 
>> Sure.
>
> I've got the final version attached here.  Feel free to have a look, thanks.
>
> ====
> From 6ba337320430feae4ce9d3d906ea19f68430642d Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Fri, 2 Feb 2024 18:28:57 +0800
> Subject: [PATCH] migration/multifd: Optimize sender side to be lockless
>
> When reviewing my attempt to refactor send_prepare(), Fabiano suggested we
> try out with dropping the mutex in multifd code [1].
>
> I thought about that before but I never tried to change the code.  Now
> maybe it's time to give it a stab.  This only optimizes the sender side.
>
> The trick here is multifd has a clear provider/consumer model, that the
> migration main thread publishes requests (either pending_job/pending_sync),
> while the multifd sender threads are consumers.  Here we don't have a lot
> of complicated data sharing, and the jobs can logically be submitted
> lockless.
>
> Arm the code with atomic weapons.  Two things worth mentioning:
>
>   - For multifd_send_pages(): we can use qatomic_load_acquire() when trying
>   to find a free channel, but that's expensive if we attach one ACQUIRE per
>   channel.  Instead, keep the qatomic_read() on reading the pending_job
>   flag as we do already, meanwhile use one smp_mb_acquire() after the loop
>   to guarantee the memory ordering.
>
>   - For pending_sync: it doesn't have any extra data required since now
>   p->flags are never touched, it should be safe to not use memory barrier.
>   That's different from pending_job.
>
> Provide rich comments for all the lockless operations to state how they are
> paired.  With that, we can remove the mutex.
>
> [1] https://lore.kernel.org/r/87o7d1jlu5.fsf@suse.de
>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Link: https://lore.kernel.org/r/20240202102857.110210-24-peterx@redhat.com
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/multifd.h |  2 --
>  migration/multifd.c | 51 +++++++++++++++++++++++----------------------
>  2 files changed, 26 insertions(+), 27 deletions(-)
>
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 98876ff94a..78a2317263 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -91,8 +91,6 @@ typedef struct {
>      /* syncs main thread and channels */
>      QemuSemaphore sem_sync;
>  
> -    /* this mutex protects the following parameters */
> -    QemuMutex mutex;
>      /* is this channel thread running */
>      bool running;
>      /* multifd flags for each packet */
> diff --git a/migration/multifd.c b/migration/multifd.c
> index b317d57d61..fbdb129088 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -501,19 +501,19 @@ static bool multifd_send_pages(void)
>          }
>      }
>  
> -    qemu_mutex_lock(&p->mutex);
> -    assert(!p->pages->num);
> -    assert(!p->pages->block);
>      /*
> -     * Double check on pending_job==false with the lock.  In the future if
> -     * we can have >1 requester thread, we can replace this with a "goto
> -     * retry", but that is for later.
> +     * Make sure we read p->pending_job before all the rest.  Pairs with
> +     * qatomic_store_release() in multifd_send_thread().
>       */
> -    assert(qatomic_read(&p->pending_job) == false);
> -    qatomic_set(&p->pending_job, true);
> +    smp_mb_acquire();
> +    assert(!p->pages->num);
>      multifd_send_state->pages = p->pages;
>      p->pages = pages;
> -    qemu_mutex_unlock(&p->mutex);
> +    /*
> +     * Making sure p->pages is setup before marking pending_job=true. Pairs
> +     * with the qatomic_load_acquire() in multifd_send_thread().
> +     */
> +    qatomic_store_release(&p->pending_job, true);
>      qemu_sem_post(&p->sem);
>  
>      return true;
> @@ -648,7 +648,6 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
>      }
>      multifd_send_channel_destroy(p->c);
>      p->c = NULL;
> -    qemu_mutex_destroy(&p->mutex);
>      qemu_sem_destroy(&p->sem);
>      qemu_sem_destroy(&p->sem_sync);
>      g_free(p->name);
> @@ -742,14 +741,12 @@ int multifd_send_sync_main(void)
>  
>          trace_multifd_send_sync_main_signal(p->id);
>  
> -        qemu_mutex_lock(&p->mutex);
>          /*
>           * We should be the only user so far, so not possible to be set by
>           * others concurrently.
>           */
>          assert(qatomic_read(&p->pending_sync) == false);
>          qatomic_set(&p->pending_sync, true);
> -        qemu_mutex_unlock(&p->mutex);
>          qemu_sem_post(&p->sem);
>      }
>      for (i = 0; i < migrate_multifd_channels(); i++) {
> @@ -796,9 +793,12 @@ static void *multifd_send_thread(void *opaque)
>          if (multifd_send_should_exit()) {
>              break;
>          }
> -        qemu_mutex_lock(&p->mutex);
>  
> -        if (qatomic_read(&p->pending_job)) {
> +        /*
> +         * Read pending_job flag before p->pages.  Pairs with the
> +         * qatomic_store_release() in multifd_send_pages().
> +         */
> +        if (qatomic_load_acquire(&p->pending_job)) {
>              MultiFDPages_t *pages = p->pages;
>  
>              p->iovs_num = 0;
> @@ -806,14 +806,12 @@ static void *multifd_send_thread(void *opaque)
>  
>              ret = multifd_send_state->ops->send_prepare(p, &local_err);
>              if (ret != 0) {
> -                qemu_mutex_unlock(&p->mutex);
>                  break;
>              }
>  
>              ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
>                                                0, p->write_flags, &local_err);
>              if (ret != 0) {
> -                qemu_mutex_unlock(&p->mutex);
>                  break;
>              }
>  
> @@ -822,24 +820,31 @@ static void *multifd_send_thread(void *opaque)
>  
>              multifd_pages_reset(p->pages);
>              p->next_packet_size = 0;
> -            qatomic_set(&p->pending_job, false);
> -            qemu_mutex_unlock(&p->mutex);
> +
> +            /*
> +             * Making sure p->pages is published before saying "we're
> +             * free".  Pairs with the smp_mb_acquire() in
> +             * multifd_send_pages().
> +             */
> +            qatomic_store_release(&p->pending_job, false);
>          } else {
> -            /* If not a normal job, must be a sync request */
> +            /*
> +             * If not a normal job, must be a sync request.  Note that
> +             * pending_sync is a standalone flag (unlike pending_job), so
> +             * it doesn't require explicit memory barriers.
> +             */
>              assert(qatomic_read(&p->pending_sync));
>              p->flags = MULTIFD_FLAG_SYNC;
>              multifd_send_fill_packet(p);
>              ret = qio_channel_write_all(p->c, (void *)p->packet,
>                                          p->packet_len, &local_err);
>              if (ret != 0) {
> -                qemu_mutex_unlock(&p->mutex);
>                  break;
>              }
>              /* p->next_packet_size will always be zero for a SYNC packet */
>              stat64_add(&mig_stats.multifd_bytes, p->packet_len);
>              p->flags = 0;
>              qatomic_set(&p->pending_sync, false);
> -            qemu_mutex_unlock(&p->mutex);
>              qemu_sem_post(&p->sem_sync);
>          }
>      }
> @@ -853,10 +858,7 @@ out:
>          error_free(local_err);
>      }
>  
> -    qemu_mutex_lock(&p->mutex);
>      p->running = false;
> -    qemu_mutex_unlock(&p->mutex);
> -
>      rcu_unregister_thread();
>      migration_threads_remove(thread);
>      trace_multifd_send_thread_end(p->id, p->packets_sent, p->total_normal_pages);
> @@ -998,7 +1000,6 @@ int multifd_send_setup(Error **errp)
>      for (i = 0; i < thread_count; i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
> -        qemu_mutex_init(&p->mutex);
>          qemu_sem_init(&p->sem, 0);
>          qemu_sem_init(&p->sem_sync, 0);
>          p->id = i;
> -- 
> 2.43.0

Reviewed-by: Fabiano Rosas <farosas@suse.de>

