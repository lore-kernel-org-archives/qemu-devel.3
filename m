Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B225CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 20:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vECiQ-0008Pk-Uj; Wed, 29 Oct 2025 16:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vECiO-0008P9-Cg
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 16:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vECiH-0003uM-De
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 16:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761769441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CurZeIG0kJD341p+XImiAFeeFuyeBzMxVCLuaDXl8q8=;
 b=N9UEADxhU3imKfMWc1bPi0/9JQQ2sxA7jcGn6Gfq8SR1g6sibagqV6w/FUquTJp1nGclmY
 LVconLFFauEKxxSygs41FPj5pfv8ZM3J0n+MSA5kwziHbUubZdt/NoaafgQvYyt899Xp78
 JGm/rbJfRQchi/3O5Eccfe4RH/GLJs0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-3GK2TcvlOBmB0dTYB2qgng-1; Wed,
 29 Oct 2025 16:23:56 -0400
X-MC-Unique: 3GK2TcvlOBmB0dTYB2qgng-1
X-Mimecast-MFC-AGG-ID: 3GK2TcvlOBmB0dTYB2qgng_1761769435
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1229F180136E; Wed, 29 Oct 2025 20:23:55 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.204])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54B9C1800579; Wed, 29 Oct 2025 20:23:49 +0000 (UTC)
Date: Wed, 29 Oct 2025 21:23:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: Re: [PATCH 10/16] qcow2: Fix cache_clean_timer
Message-ID: <aQJ30-Ifcji8lrme@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
 <20251028163343.116249-11-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028163343.116249-11-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Am 28.10.2025 um 17:33 hat Hanna Czenczek geschrieben:
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

In theory, the old plan was that eventually qcow2 would use fine grained
locks instead of the single s->lock, and having a separate cache lock
would be a step towards it. But if we never actually make use of it to
hold s->lock for a shorter time, that's not really a good argument. I'm
not sure if that's ever going to happen unless for a rewrite in Rust or
something.

I never tried to measure specifically if lock contention is a problem
with high queue depth and random I/O on a huge disk. Intuitively,
holding s->lock while doing I/O for loading entries into the cache can't
be really good.

Anyway, I went a bit on a tangent there...

> Using s->lock, which is a coroutine mutex, however means that we need to
> take it in a coroutine, so the timer CB must enter such a coroutine.  As
> a result, descheduling the timer is no longer a guarantee that the
> cache-cleaner will not run, because it may now be yielding in
> qemu_co_mutex_lock().

I think creating a coroutine in cache_clean_timer_cb() is the wrong
approach. Instead, cache_clean_timer_init() could create a coroutine
and its implementation could be something like this:

    while (!s->cache_clean_timer_stopping) {
        qemu_co_sleep_ns_wakeable(&s->cache_clean_timer_wake,
                                  QEMU_CLOCK_VIRTUAL,
                                  s->cache_clean_interval * NANOSECONDS_PER_SECOND);

        qemu_co_mutex_lock(&s->lock);
        qcow2_cache_clean_unused(s->l2_table_cache);
        qcow2_cache_clean_unused(s->refcount_block_cache);
        qemu_co_mutex_unlock(&s->lock);
    }
    s->cache_clean_timer_stopping = false;

> (Note even now this was only guaranteed for cache_clean_timer_del()
> callers that run in the BDS (the timer’s) AioContext.  For callers
> running in the main context, the problem may have already existed,
> though maybe the BQL prevents timers from running in other contexts, I’m
> not sure.)
> 
> Polling to await the timer to actually settle seems very complicated for
> something that’s rather a minor problem, but I can’t come up with any
> better solution that doesn’t again just overlook potential problems.
> 
> (One cleaner idea may be to have a generic way to have timers run
> coroutines, and to await those when descheduling the timer.  But while
> cleaner, it would also be more complicated, and I don’t think worth it
> at this point.)
> 
> (Not Cc-ing qemu-stable, as the issue is quite unlikely to be hit, and
> I’m not too fond of this solution.)
> 
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/qcow2.h |  1 +
>  block/qcow2.c | 90 ++++++++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 79 insertions(+), 12 deletions(-)

> @@ -867,6 +893,39 @@ static void cache_clean_timer_del(BlockDriverState *bs)
>      }
>  }
>  
> +/*
> + * Delete the cache clean timer and await any yet running instance.
> + * Must be called from the main or BDS AioContext, holding s->lock.
> + */
> +static void coroutine_fn
> +cache_clean_timer_locked_co_del_and_wait(BlockDriverState *bs)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    IO_OR_GS_CODE();
> +    cache_clean_timer_del(bs);
> +    if (qatomic_read(&s->cache_clean_running)) {
> +        qemu_co_mutex_unlock(&s->lock);
> +        qatomic_set(&s->cache_clean_polling, true);
> +        BDRV_POLL_WHILE(bs, qatomic_read(&s->cache_clean_running));

Polling in a coroutine_fn is verboten.

If we do need this function, I think it would be a yield here and a wake
on the other side. I think we might be able to get around it if we move
the call from qcow2_do_open() into qcow2_open() (i.e. outside the
coroutine). A bit ugly, so your choice.

> +        qemu_co_mutex_lock(&s->lock);
> +    }
> +}
> +
> +/*
> + * Delete the cache clean timer and await any yet running instance.
> + * Must be called from the main or BDS AioContext without s->lock held.
> + */
> +static void cache_clean_timer_del_and_wait(BlockDriverState *bs)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    IO_OR_GS_CODE();
> +    cache_clean_timer_del(bs);
> +    if (qatomic_read(&s->cache_clean_running)) {
> +        qatomic_set(&s->cache_clean_polling, true);
> +        BDRV_POLL_WHILE(bs, qatomic_read(&s->cache_clean_running));
> +    }
> +}
> +
>  static void qcow2_detach_aio_context(BlockDriverState *bs)
>  {
>      cache_clean_timer_del(bs);
> @@ -1214,12 +1273,20 @@ fail:
>      return ret;
>  }
>  
> +/* s_locked specifies whether s->lock is held or not */
>  static void qcow2_update_options_commit(BlockDriverState *bs,
> -                                        Qcow2ReopenState *r)
> +                                        Qcow2ReopenState *r,
> +                                        bool s_locked)
>  {
>      BDRVQcow2State *s = bs->opaque;
>      int i;
>  
> +    if (s_locked) {
> +        cache_clean_timer_locked_co_del_and_wait(bs);
> +    } else {
> +        cache_clean_timer_del_and_wait(bs);
> +    }
> +
>      if (s->l2_table_cache) {
>          qcow2_cache_destroy(s->l2_table_cache);
>      }
> @@ -1228,6 +1295,10 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
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
> @@ -1239,12 +1310,6 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
>  
>      s->discard_no_unref = r->discard_no_unref;
>  
> -    if (s->cache_clean_interval != r->cache_clean_interval) {
> -        cache_clean_timer_del(bs);
> -        s->cache_clean_interval = r->cache_clean_interval;
> -        cache_clean_timer_init(bs, bdrv_get_aio_context(bs));
> -    }
> -

I think the del/init pair here won't be necessary any more after
switching to the background coroutine. It will just start using the new
value of s->cache_clean_interval the next time it sleeps.

Kevin


