Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5403FCEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 14:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL0ZE-00029n-Py; Mon, 17 Nov 2025 09:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vL0Z8-00028O-VA
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 09:50:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vL0Z7-0003Eo-18
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 09:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763391047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9dBTX90l9ueJvnbn+jMaFRARUaVJ9s9Ws67F4xizjk4=;
 b=C1igZQ+2kYBYATlskPPd+tu2vdJR7PKMIpPVdZkptrHRlCJuzRfSyyuy7OQtbqsQfT4o9z
 aKL/VDMqetHPlKb+33TJRnALwD3RqvWEXX5xurrToZNoUN7+KApgzoBk/J/NeqTU7IxK7M
 H0/3FCJ+BZzP0jfPVXV0nrrZAOsSjWc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-sfdDatKZMri7-u-EAT3nnQ-1; Mon,
 17 Nov 2025 09:50:43 -0500
X-MC-Unique: sfdDatKZMri7-u-EAT3nnQ-1
X-Mimecast-MFC-AGG-ID: sfdDatKZMri7-u-EAT3nnQ_1763391041
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28125180122F; Mon, 17 Nov 2025 14:50:41 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.115])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48127180049F; Mon, 17 Nov 2025 14:50:36 +0000 (UTC)
Date: Mon, 17 Nov 2025 15:50:33 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: Re: [PATCH v2 12/19] qcow2: Fix cache_clean_timer
Message-ID: <aRs2OSuFy0HyW4EU@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
 <20251110154854.151484-13-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251110154854.151484-13-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Am 10.11.2025 um 16:48 hat Hanna Czenczek geschrieben:
> The cache-cleaner runs as a timer CB in the BDS AioContext.  With
> multiqueue, it can run concurrently to I/O requests, and because it does
> not take any lock, this can break concurrent cache accesses, corrupting
> the image.  While the chances of this happening are low, it can be
> reproduced e.g. by modifying the code to schedule the timer CB every
> 5 ms (instead of at most once per second) and modifying the last (inner)
> while loop of qcow2_cache_clean_unused() like so:
> 
>     while (i < c->size && can_clean_entry(c, i)) {
>         for (int j = 0; j < 1000 && can_clean_entry(c, i); j++) {
>             usleep(100);
>         }
>         c->entries[i].offset = 0;
>         c->entries[i].lru_counter = 0;
>         i++;
>         to_clean++;
>     }
> 
> i.e. making it wait on purpose for the point in time where the cache is
> in use by something else.
> 
> The solution chosen for this in this patch is not the best solution, I
> hope, but I admittedly can’t come up with anything strictly better.
> 
> We can protect from concurrent cache accesses either by taking the
> existing s->lock, or we introduce a new (non-coroutine) mutex
> specifically for cache accesses.  I would prefer to avoid the latter so
> as not to introduce additional (very slight) overhead.
> 
> Using s->lock, which is a coroutine mutex, however means that we need to
> take it in a coroutine, so the timer must run in a coroutine.  We can
> transform it from the current timer CB style into a coroutine that
> sleeps for the set interval.  As a result, however, we can no longer
> just deschedule the timer to instantly guarantee it won’t run anymore,
> but have to await the coroutine’s exit.
> 
> (Note even before this patch there were places that may not have been so
> guaranteed after all: Anything calling cache_clean_timer_del() from the
> QEMU main AioContext could have been running concurrently to an existing
> timer CB invocation.)
> 
> Polling to await the timer to actually settle seems very complicated for
> something that’s rather a minor problem, but I can’t come up with any
> better solution that doesn’t again just overlook potential problems.
> 
> (Not Cc-ing qemu-stable, as the issue is quite unlikely to be hit, and
> I’m not too fond of this solution.)
> 
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>

> -static void cache_clean_timer_cb(void *opaque)
> +static void coroutine_fn cache_clean_timer(void *opaque)
>  {
> -    BlockDriverState *bs = opaque;
> -    BDRVQcow2State *s = bs->opaque;
> -    qcow2_cache_clean_unused(s->l2_table_cache);
> -    qcow2_cache_clean_unused(s->refcount_block_cache);
> -    timer_mod(s->cache_clean_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
> -              (int64_t) s->cache_clean_interval * 1000);
> +    BDRVQcow2State *s = opaque;
> +    uint64_t wait_ns;
> +
> +    WITH_QEMU_LOCK_GUARD(&s->lock) {
> +        wait_ns = s->cache_clean_interval * NANOSECONDS_PER_SECOND;
> +    }
> +
> +    while (wait_ns > 0) {
> +        qemu_co_sleep_ns_wakeable(&s->cache_clean_timer_wake,
> +                                  QEMU_CLOCK_VIRTUAL, wait_ns);
> +
> +        WITH_QEMU_LOCK_GUARD(&s->lock) {
> +            if (s->cache_clean_interval > 0) {
> +                qcow2_cache_clean_unused(s->l2_table_cache);
> +                qcow2_cache_clean_unused(s->refcount_block_cache);
> +            }
> +
> +            wait_ns = s->cache_clean_interval * NANOSECONDS_PER_SECOND;
> +        }
> +    }
> +
> +    WITH_QEMU_LOCK_GUARD(&s->lock) {
> +        s->cache_clean_timer_co = NULL;
> +        qemu_co_queue_restart_all(&s->cache_clean_timer_exit);
> +    }
>  }

> +/**
> + * Delete the cache clean timer and await any yet running instance.
> + * Called holding s->lock.
> + */
> +static void coroutine_fn
> +cache_clean_timer_co_locked_del_and_wait(BlockDriverState *bs)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +
> +    if (s->cache_clean_timer_co) {
> +        s->cache_clean_interval = 0;
> +        qemu_co_sleep_wake(&s->cache_clean_timer_wake);
> +        qemu_co_queue_wait(&s->cache_clean_timer_exit, &s->lock);
>      }
>  }

I don't want to count the number of context switches this dance between
cache_clean_timer_co_locked_del_and_wait() and cache_clean_timer()
takes! Good that it's not a hot path. :-)

> +/* s_locked specifies whether s->lock is held or not */
>  static void qcow2_update_options_commit(BlockDriverState *bs,
> -                                        Qcow2ReopenState *r)
> +                                        Qcow2ReopenState *r,
> +                                        bool s_locked)
>  {
>      BDRVQcow2State *s = bs->opaque;
>      int i;
>  
> +    /*
> +     * We need to stop the cache-clean-timer before destroying the metadata
> +     * table caches
> +     */
> +    if (s_locked) {
> +        cache_clean_timer_co_locked_del_and_wait(bs);
> +    } else {
> +        cache_clean_timer_del_and_wait(bs);
> +    }
> +
>      if (s->l2_table_cache) {
>          qcow2_cache_destroy(s->l2_table_cache);
>      }
> @@ -1228,6 +1312,10 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
>      }
>      s->l2_table_cache = r->l2_table_cache;
>      s->refcount_block_cache = r->refcount_block_cache;
> +
> +    s->cache_clean_interval = r->cache_clean_interval;
> +    cache_clean_timer_init(bs, bdrv_get_aio_context(bs));
> +
>      s->l2_slice_size = r->l2_slice_size;
>  
>      s->overlap_check = r->overlap_check;
> @@ -1239,12 +1327,6 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
>  
>      s->discard_no_unref = r->discard_no_unref;
>  
> -    if (s->cache_clean_interval != r->cache_clean_interval) {
> -        cache_clean_timer_del(bs);
> -        s->cache_clean_interval = r->cache_clean_interval;
> -        cache_clean_timer_init(bs, bdrv_get_aio_context(bs));
> -    }
> -
>      qapi_free_QCryptoBlockOpenOptions(s->crypto_opts);
>      s->crypto_opts = r->crypto_opts;
>  }

Is there any specific reason why you move cache_clean_timer_init()
earlier? I don't see an actual problem with the code as it is after this
change, but s->l2_slice_size is related to the cache in a way, so it
would feel safer if the cache cleaner were only started once all the
settings are updated and not only those that it actually happens to
access at the moment.

Kevin


