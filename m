Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99E5C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 21:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rW1Av-0004eR-9h; Fri, 02 Feb 2024 16:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rW1Au-0004eH-M2
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:34:16 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rW1Ar-0007BS-Ux
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:34:16 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AA64121F54;
 Fri,  2 Feb 2024 21:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706909651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Vn7kgceAgIGEKcD5eaZg6Q6DDhMeRfItKUIcrpRQwk=;
 b=2Z63G2TUILkxkMn4FUAiwgBarCmlWw1rlX4of+z+fmt1Y2u+smLekSvhUkMTVvr5JGriHf
 S0j48wSsijeq2+yaEOhv0ZLEySnVVLx5p5sz1sHYaE0KsTRWTzFGF3pyrRKJonDE+24WzX
 iQgqBnIAAyYr+6twfOSmGMU7i0V3pe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706909651;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Vn7kgceAgIGEKcD5eaZg6Q6DDhMeRfItKUIcrpRQwk=;
 b=71+Kjb3OFLAka8Xbl3o84j0AJRZff4ymy5mkP+KH5LZdZXuC4wRSyewrozGCLUh98YUdAH
 n6TyxcMD35gvQuBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706909651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Vn7kgceAgIGEKcD5eaZg6Q6DDhMeRfItKUIcrpRQwk=;
 b=2Z63G2TUILkxkMn4FUAiwgBarCmlWw1rlX4of+z+fmt1Y2u+smLekSvhUkMTVvr5JGriHf
 S0j48wSsijeq2+yaEOhv0ZLEySnVVLx5p5sz1sHYaE0KsTRWTzFGF3pyrRKJonDE+24WzX
 iQgqBnIAAyYr+6twfOSmGMU7i0V3pe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706909651;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Vn7kgceAgIGEKcD5eaZg6Q6DDhMeRfItKUIcrpRQwk=;
 b=71+Kjb3OFLAka8Xbl3o84j0AJRZff4ymy5mkP+KH5LZdZXuC4wRSyewrozGCLUh98YUdAH
 n6TyxcMD35gvQuBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3449E139AB;
 Fri,  2 Feb 2024 21:34:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hXG1OtJfvWVZAgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Feb 2024 21:34:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>, Bryan Zhang
 <bryan.zhang@bytedance.com>, peterx@redhat.com, Avihai Horon
 <avihaih@nvidia.com>, Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit
 <ppandit@redhat.com>
Subject: Re: [PATCH v2 23/23] migration/multifd: Optimize sender side to be
 lockless
In-Reply-To: <20240202102857.110210-24-peterx@redhat.com>
References: <20240202102857.110210-1-peterx@redhat.com>
 <20240202102857.110210-24-peterx@redhat.com>
Date: Fri, 02 Feb 2024 18:34:08 -0300
Message-ID: <87wmrmft4f.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
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

peterx@redhat.com writes:

> From: Peter Xu <peterx@redhat.com>
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
> of comlicated data sharing, and the jobs can logically be submitted lockless.

complicated

>
> Arm the code with atomic weapons.  Two things worth mentioning:
>
>   - For multifd_send_pages(): we can use qatomic_load_acquire() when trying
>   to find a free channel, but that's expensive if we attach one ACQUIRE per
>   channel.  Instead, make it atomic_read() on the pending_job flag, but

s/make it/keep it/

The diff doesn't show the atomic_read already there so it's confusing.

>   merge the ACQUIRE into one single smp_mb_acquire() later.
>
>   - For pending_sync: it doesn't have any extra data required since now
>   p->flags are never touched, it should be safe to not use memory barrier.
>   That's different from pending_sync.

pending_job?

>
> Provide rich comments for all the lockless operations to state how they are
> paired.  With that, we can remove the mutex.
>
> [1] https://lore.kernel.org/r/87o7d1jlu5.fsf@suse.de
>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
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
> index b317d57d61..ef13e2e781 100644
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
> +             * free".  Pairs with the qatomic_load_acquire() in

smp_mb_acquire()

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

