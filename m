Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF401CD6E50
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSyOM-0000Fk-3A; Fri, 29 May 2026 10:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wSyOK-0000FS-Hl
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:40:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wSyOI-00006u-EW
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780065649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lY058sC7lm+jnFbbC2nwMrFqP94fCRXBJVJRIvxrIYU=;
 b=iwxGSlrg4QrBzwXNkpJEWikLm0CQ9pLRA3l7kkvnJdeRpw5c8QuayCVC/PgkUClNxMyISk
 Rpihm5WVTX/Xqc5CGbVlxwwafiQ0/ry4+EKUyZ52mNUhyP/y/tMxUN4uuPJVDeOM/G+Hi9
 VcOOKD5HDRD2yeaPaauIU1m76ZwvoD8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-mcTWRz2dOma7nTZ8kTeKxw-1; Fri,
 29 May 2026 10:40:47 -0400
X-MC-Unique: mcTWRz2dOma7nTZ8kTeKxw-1
X-Mimecast-MFC-AGG-ID: mcTWRz2dOma7nTZ8kTeKxw_1780065646
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4086319560A6; Fri, 29 May 2026 14:40:46 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.95])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1261919560B4; Fri, 29 May 2026 14:40:43 +0000 (UTC)
Date: Fri, 29 May 2026 16:40:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 hreitz@redhat.com, stefanha@redhat.com
Subject: Re: [PATCH v2 1/1] coroutine: fix lost wakeup in qemu_co_sleep_wake()
Message-ID: <ahmlab5emsQcYcr9@redhat.com>
References: <20260520193849.467936-1-den@openvz.org>
 <20260520193849.467936-2-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520193849.467936-2-den@openvz.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 20.05.2026 um 21:38 hat Denis V. Lunev geschrieben:
> cache_clean_timer_del_and_wait() cancels the cache-cleaner coroutine
> by setting s->cache_clean_interval = 0 and calling qemu_co_sleep_wake()
> to cut short its qemu_co_sleep_ns_wakeable(). qemu_co_sleep_wake() is
> fire-and-forget: it reads w->to_wake and silently returns when it is
> NULL. A sleeper that is between two iterations -- has just released
> s->lock but has not yet set w->to_wake inside qemu_co_sleep() -- loses
> the wake:
> 
>   iothread0 timer coroutine           main thread (qcow2 close)
>   -------------------------           -------------------------
>   while-body (holding s->lock):
>     read interval = 600
>     wait_ns = 600 * NS
>     release s->lock
>                                       take s->lock
>                                       interval = 0
>                                       qemu_co_sleep_wake(w):
>                                         w->to_wake == NULL -> skip
>                                         return
>                                       qemu_co_queue_wait(exit, s->lock):
>                                         release s->lock
>                                         yield
>   qemu_co_sleep_ns_wakeable:
>     aio_timer_init(+600 s)
>     qemu_co_sleep:
>       cas scheduled NULL -> "qsns"
>       w->to_wake = co
>       yield  [sleeps 600 s]
> 
> cache_clean_timer_del_and_wait() then blocks on cache_clean_timer_exit
> until the original 600 s expiry fires, and qcow2_close() holds BQL the
> whole time so the VM stalls behind it.
> 
> block_copy_kick() has the same shape. Fix the primitive once instead
> of working around it in each caller.
> 
> Use a tri-state for QemuCoSleep::to_wake:
> 
>   NULL     - idle
>   co       - sleeper parked
>   PENDING  - wake delivered, no sleeper yet (sticky)
> 
> qemu_co_sleep_wake() xchgs PENDING into to_wake: a real sleeper is
> woken, NULL/PENDING is left untouched so the wake stays sticky.
> qemu_co_sleep() consumes a sticky PENDING on entry; otherwise it
> cmpxchg-publishes itself, and a wake racing in between is caught
> because the cmpxchg observes PENDING and returns without yielding.
> On normal resume qemu_co_sleep() clears the PENDING the waker left
> behind so the next sleep starts clean.
> 
> A double-fire (real wake plus timer callback) is harmless: the first
> xchg returns the coroutine and wakes it; the second returns PENDING
> and is a no-op. Cancellation latency through qemu_co_sleep_wake() is
> now bounded by aio_co_wake() rather than by the sleep duration.
> 
> Fixes: f86dde9a15 ("qcow2: Fix cache_clean_timer")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Hanna Czenczek <hreitz@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qemu/coroutine.h    | 17 ++++++++---
>  util/qemu-coroutine-sleep.c | 60 +++++++++++++++++++++++++++----------
>  2 files changed, 58 insertions(+), 19 deletions(-)
> 
> diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
> index e545bbf620..1c31de60f9 100644
> --- a/include/qemu/coroutine.h
> +++ b/include/qemu/coroutine.h
> @@ -260,10 +260,19 @@ int coroutine_fn qemu_co_timeout(CoroutineEntry *entry, void *opaque,
>                                   uint64_t timeout_ns, CleanupFunc clean);
>  
>  /**
> - * Wake a coroutine if it is sleeping in qemu_co_sleep_ns. The timer will be
> - * deleted. @sleep_state must be the variable whose address was given to
> - * qemu_co_sleep_ns() and should be checked to be non-NULL before calling
> - * qemu_co_sleep_wake().
> + * Wake a coroutine sleeping in qemu_co_sleep() or qemu_co_sleep_ns_wakeable().
> + * The timer set up by the latter is deleted on wakeup.
> + *
> + * The wake is sticky: if no sleeper is parked on @w at the time of the call,
> + * the wake is recorded on @w and consumed by the next qemu_co_sleep() on the
> + * same @w, which then returns without yielding. This closes the lost-wakeup
> + * window between two sleeps and is the documented behavior callers should
> + * rely on -- e.g. a cancellation signal raised between iterations of a
> + * sleep/work loop will shorten the next sleep instead of being dropped.
> + *
> + * The state persists until consumed: if no further qemu_co_sleep() is ever
> + * called on @w, the pending wake is harmlessly discarded when @w goes away.
> + * Multiple wakes coalesce -- the next sleep consumes at most one.
>   */
>  void qemu_co_sleep_wake(QemuCoSleep *w);
>  
> diff --git a/util/qemu-coroutine-sleep.c b/util/qemu-coroutine-sleep.c
> index edef117284..a5734a8eb7 100644
> --- a/util/qemu-coroutine-sleep.c
> +++ b/util/qemu-coroutine-sleep.c
> @@ -18,20 +18,29 @@
>  
>  static const char *qemu_co_sleep_ns__scheduled = "qemu_co_sleep_ns";
>  
> +/*
> + * Sentinel stored in QemuCoSleep::to_wake by qemu_co_sleep_wake() when no
> + * sleeper has parked yet. The next qemu_co_sleep() consumes it and returns
> + * without yielding, so a wake that races the arming of a sleep is never
> + * lost.
> + */
> +#define QEMU_CO_SLEEP_PENDING ((Coroutine *)(uintptr_t)1)
> +
>  void qemu_co_sleep_wake(QemuCoSleep *w)
>  {
>      Coroutine *co;
>  
> -    co = w->to_wake;
> -    w->to_wake = NULL;
> -    if (co) {
> -        /* Write of schedule protected by barrier write in aio_co_schedule */
> -        const char *scheduled = qatomic_cmpxchg(&co->scheduled,
> -                                                qemu_co_sleep_ns__scheduled, NULL);
> -
> -        assert(scheduled == qemu_co_sleep_ns__scheduled);
> -        aio_co_wake(co);
> +    co = qatomic_xchg(&w->to_wake, QEMU_CO_SLEEP_PENDING);
> +    if (co == NULL || co == QEMU_CO_SLEEP_PENDING) {
> +        /* No sleeper, or a wake is already pending. */
> +        return;
>      }
> +
> +    /* Write of scheduled protected by barrier write in aio_co_schedule */
> +    const char *scheduled = qatomic_cmpxchg(&co->scheduled,
> +                                            qemu_co_sleep_ns__scheduled, NULL);
> +    assert(scheduled == qemu_co_sleep_ns__scheduled);
> +    aio_co_wake(co);
>  }
>  
>  static void co_sleep_cb(void *opaque)
> @@ -43,6 +52,14 @@ static void co_sleep_cb(void *opaque)
>  void coroutine_fn qemu_co_sleep(QemuCoSleep *w)
>  {
>      Coroutine *co = qemu_coroutine_self();
> +    Coroutine *prev;
> +
> +    /* Consume an already-delivered wake without yielding. */
> +    prev = qatomic_cmpxchg(&w->to_wake, QEMU_CO_SLEEP_PENDING, NULL);
> +    if (prev == QEMU_CO_SLEEP_PENDING) {
> +        return;
> +    }
> +    assert(prev == NULL);

I'm wondering if this check serves a purpose when...

>      const char *scheduled = qatomic_cmpxchg(&co->scheduled, NULL,
>                                              qemu_co_sleep_ns__scheduled);
> @@ -53,11 +70,23 @@ void coroutine_fn qemu_co_sleep(QemuCoSleep *w)
>          abort();
>      }
>  
> -    w->to_wake = co;
> +    /*
> +     * Publish ourselves as the sleeper. If a wake raced in between the
> +     * fast path above and now, the cmpxchg observes QEMU_CO_SLEEP_PENDING
> +     * and we consume it without yielding.
> +     */
> +    prev = qatomic_cmpxchg(&w->to_wake, NULL, co);
> +    if (prev == QEMU_CO_SLEEP_PENDING) {

...we essentially have to repeat it here anyway. Couldn't we always just
use this second check?

> +        qatomic_set(&w->to_wake, NULL);
> +        qatomic_set(&co->scheduled, NULL);
> +        return;
> +    }
> +    assert(prev == NULL);
> +
>      qemu_coroutine_yield();
>  
> -    /* w->to_wake is cleared before resuming this coroutine.  */
> -    assert(w->to_wake == NULL);
> +    /* The waker left QEMU_CO_SLEEP_PENDING; clear it for the next sleep. */
> +    qatomic_set(&w->to_wake, NULL);
>  }
>  
>  void coroutine_fn qemu_co_sleep_ns_wakeable(QemuCoSleep *w,
> @@ -70,9 +99,10 @@ void coroutine_fn qemu_co_sleep_ns_wakeable(QemuCoSleep *w,
>      timer_mod(&ts, qemu_clock_get_ns(type) + ns);
>  
>      /*
> -     * The timer will fire in the current AiOContext, so the callback
> -     * must happen after qemu_co_sleep yields and there is no race
> -     * between timer_mod and qemu_co_sleep.
> +     * A wake racing with the arming of the sleep -- including the timer
> +     * we just armed firing in another AioContext before qemu_co_sleep()
> +     * publishes itself -- is captured by the sticky PENDING state in
> +     * qemu_co_sleep_wake() and consumed here without yielding.
>       */
>      qemu_co_sleep(w);
>      timer_del(&ts);

Overall this looks good to me. Some unit tests would be nice, though.

Kevin


