Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB53C54FC6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 22:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slFCj-00042C-5U; Mon, 02 Sep 2024 18:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slFCh-000414-G3
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 18:07:19 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slFCe-0002Ye-VI
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 18:07:19 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 11E7621B4C;
 Mon,  2 Sep 2024 22:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725314832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r+ZawTVwLexRiFN4HOeJfhEpXhWHjJe5vKQ3SwZEMiE=;
 b=p9aK/sBFQ41ZXThSdDgEvI7h//kx9nwL3/Q0JFzNfG6ZBCJOvuxggTgPE6/+opmHgv9GyQ
 agYG7Th0bmT08ovC4C3ik/KEgL+TayyV+qHG9WC9FCJ3UHRLwwbI8m9t85DpskfpOD+9Ws
 QO1zr421hm2Tvj/V2k9VHYPGZbtuoyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725314832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r+ZawTVwLexRiFN4HOeJfhEpXhWHjJe5vKQ3SwZEMiE=;
 b=YS0zgQMK2eKmRn/Vv8rIWROfz/nChz2MAIyMWXc/enEUSRNyWHDtW1Q+IrRIPtGewzd6BD
 VO0E/IZsHCvybzDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="p9aK/sBF";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YS0zgQMK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725314832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r+ZawTVwLexRiFN4HOeJfhEpXhWHjJe5vKQ3SwZEMiE=;
 b=p9aK/sBFQ41ZXThSdDgEvI7h//kx9nwL3/Q0JFzNfG6ZBCJOvuxggTgPE6/+opmHgv9GyQ
 agYG7Th0bmT08ovC4C3ik/KEgL+TayyV+qHG9WC9FCJ3UHRLwwbI8m9t85DpskfpOD+9Ws
 QO1zr421hm2Tvj/V2k9VHYPGZbtuoyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725314832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r+ZawTVwLexRiFN4HOeJfhEpXhWHjJe5vKQ3SwZEMiE=;
 b=YS0zgQMK2eKmRn/Vv8rIWROfz/nChz2MAIyMWXc/enEUSRNyWHDtW1Q+IrRIPtGewzd6BD
 VO0E/IZsHCvybzDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85A4A13A21;
 Mon,  2 Sep 2024 22:07:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lPYBEw831mYZMwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Sep 2024 22:07:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Peter Xu
 <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 05/17] thread-pool: Implement non-AIO (generic) pool
 support
In-Reply-To: <54947c3a1df713f5b69d8296938f3da41116ffe0.1724701542.git.maciej.szmigiero@oracle.com>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <54947c3a1df713f5b69d8296938f3da41116ffe0.1724701542.git.maciej.szmigiero@oracle.com>
Date: Mon, 02 Sep 2024 19:07:08 -0300
Message-ID: <87o755n20j.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 11E7621B4C
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Migration code wants to manage device data sending threads in one place.
>
> QEMU has an existing thread pool implementation, however it was limited
> to queuing AIO operations only and essentially had a 1:1 mapping between
> the current AioContext and the ThreadPool in use.
>
> Implement what is necessary to queue generic (non-AIO) work on a ThreadPool
> too.
>
> This brings a few new operations on a pool:
> * thread_pool_set_minmax_threads() explicitly sets the minimum and maximum
> thread count in the pool.
>
> * thread_pool_join() operation waits until all the submitted work requests
> have finished.
>
> * thread_pool_poll() lets the new thread and / or thread completion bottom
> halves run (if they are indeed scheduled to be run).
> It is useful for thread pool users that need to launch or terminate new
> threads without returning to the QEMU main loop.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  include/block/thread-pool.h   | 10 ++++-
>  tests/unit/test-thread-pool.c |  2 +-
>  util/thread-pool.c            | 77 ++++++++++++++++++++++++++++++-----
>  3 files changed, 76 insertions(+), 13 deletions(-)
>
> diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
> index b484c4780ea6..1769496056cd 100644
> --- a/include/block/thread-pool.h
> +++ b/include/block/thread-pool.h
> @@ -37,9 +37,15 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
>                                     void *arg, GDestroyNotify arg_destroy,
>                                     BlockCompletionFunc *cb, void *opaque);
>  int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg);
> -void thread_pool_submit(ThreadPoolFunc *func,
> -                        void *arg, GDestroyNotify arg_destroy);
> +BlockAIOCB *thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
> +                               void *arg, GDestroyNotify arg_destroy,
> +                               BlockCompletionFunc *cb, void *opaque);

These kinds of changes (create wrappers, change signatures, etc), could
be in their own patch as it's just code motion that should not have
functional impact. The "no_requests" stuff would be better discussed in
a separate patch.

>  
> +void thread_pool_join(ThreadPool *pool);
> +void thread_pool_poll(ThreadPool *pool);
> +
> +void thread_pool_set_minmax_threads(ThreadPool *pool,
> +                                    int min_threads, int max_threads);
>  void thread_pool_update_params(ThreadPool *pool, struct AioContext *ctx);
>  
>  #endif
> diff --git a/tests/unit/test-thread-pool.c b/tests/unit/test-thread-pool.c
> index e4afb9e36292..469c0f7057b6 100644
> --- a/tests/unit/test-thread-pool.c
> +++ b/tests/unit/test-thread-pool.c
> @@ -46,7 +46,7 @@ static void done_cb(void *opaque, int ret)
>  static void test_submit(void)
>  {
>      WorkerTestData data = { .n = 0 };
> -    thread_pool_submit(worker_cb, &data, NULL);
> +    thread_pool_submit(NULL, worker_cb, &data, NULL, NULL, NULL);
>      while (data.n == 0) {
>          aio_poll(ctx, true);
>      }
> diff --git a/util/thread-pool.c b/util/thread-pool.c
> index 69a87ee79252..2bf3be875a51 100644
> --- a/util/thread-pool.c
> +++ b/util/thread-pool.c
> @@ -60,6 +60,7 @@ struct ThreadPool {
>      QemuMutex lock;
>      QemuCond worker_stopped;
>      QemuCond request_cond;
> +    QemuCond no_requests_cond;
>      QEMUBH *new_thread_bh;
>  
>      /* The following variables are only accessed from one AioContext. */
> @@ -73,6 +74,7 @@ struct ThreadPool {
>      int pending_threads; /* threads created but not running yet */
>      int min_threads;
>      int max_threads;
> +    size_t requests_executing;

What's with size_t? Should this be a uint32_t instead?

>  };
>  
>  static void *worker_thread(void *opaque)
> @@ -107,6 +109,10 @@ static void *worker_thread(void *opaque)
>          req = QTAILQ_FIRST(&pool->request_list);
>          QTAILQ_REMOVE(&pool->request_list, req, reqs);
>          req->state = THREAD_ACTIVE;
> +
> +        assert(pool->requests_executing < SIZE_MAX);
> +        pool->requests_executing++;
> +
>          qemu_mutex_unlock(&pool->lock);
>  
>          ret = req->func(req->arg);
> @@ -118,6 +124,14 @@ static void *worker_thread(void *opaque)
>  
>          qemu_bh_schedule(pool->completion_bh);
>          qemu_mutex_lock(&pool->lock);
> +
> +        assert(pool->requests_executing > 0);
> +        pool->requests_executing--;
> +
> +        if (pool->requests_executing == 0 &&
> +            QTAILQ_EMPTY(&pool->request_list)) {
> +            qemu_cond_signal(&pool->no_requests_cond);
> +        }

An empty requests list and no request in flight means the worker will
now exit after the timeout, no? Can you just kick the worker out of the
wait and use pool->worker_stopped instead of the new condition variable?

>      }
>  
>      pool->cur_threads--;
> @@ -243,13 +257,16 @@ static const AIOCBInfo thread_pool_aiocb_info = {
>      .cancel_async       = thread_pool_cancel,
>  };
>  
> -BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
> -                                   void *arg, GDestroyNotify arg_destroy,
> -                                   BlockCompletionFunc *cb, void *opaque)
> +BlockAIOCB *thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
> +                               void *arg, GDestroyNotify arg_destroy,
> +                               BlockCompletionFunc *cb, void *opaque)
>  {
>      ThreadPoolElement *req;
>      AioContext *ctx = qemu_get_current_aio_context();
> -    ThreadPool *pool = aio_get_thread_pool(ctx);
> +
> +    if (!pool) {
> +        pool = aio_get_thread_pool(ctx);
> +    }

I'd go for a separate implementation to really drive the point that this
new usage is different. See the code snippet below.

It seems we're a short step away to being able to use this
implementation in a general way. Is there something that can be done
with the 'common' field in the ThreadPoolElement?

========
static void thread_pool_submit_request(ThreadPool *pool, ThreadPoolElement *req)
{
    req->state = THREAD_QUEUED;
    req->pool = pool;

    QLIST_INSERT_HEAD(&pool->head, req, all);

    trace_thread_pool_submit(pool, req, req->arg);

    qemu_mutex_lock(&pool->lock);
    if (pool->idle_threads == 0 && pool->cur_threads < pool->max_threads) {
        spawn_thread(pool);
    }
    QTAILQ_INSERT_TAIL(&pool->request_list, req, reqs);
    qemu_mutex_unlock(&pool->lock);
    qemu_cond_signal(&pool->request_cond);
}

BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
                                   BlockCompletionFunc *cb, void *opaque)
{
    ThreadPoolElement *req;
    AioContext *ctx = qemu_get_current_aio_context();
    ThreadPool *pool = aio_get_thread_pool(ctx);

    /* Assert that the thread submitting work is the same running the pool */
    assert(pool->ctx == qemu_get_current_aio_context());

    req = qemu_aio_get(&thread_pool_aiocb_info, NULL, cb, opaque);
    req->func = func;
    req->arg = arg;

    thread_pool_submit_request(pool, req);
    return &req->common;
}

void thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func, void *arg)
{
    ThreadPoolElement *req;

    req = g_malloc(sizeof(ThreadPoolElement));
    req->func = func;
    req->arg = arg;

    thread_pool_submit_request(pool, req);
}
=================

>  
>      /* Assert that the thread submitting work is the same running the pool */
>      assert(pool->ctx == qemu_get_current_aio_context());
> @@ -275,6 +292,18 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
>      return &req->common;
>  }
>  
> +BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
> +                                   void *arg, GDestroyNotify arg_destroy,
> +                                   BlockCompletionFunc *cb, void *opaque)
> +{
> +    return thread_pool_submit(NULL, func, arg, arg_destroy, cb, opaque);
> +}
> +
> +void thread_pool_poll(ThreadPool *pool)
> +{
> +    aio_bh_poll(pool->ctx);
> +}
> +
>  typedef struct ThreadPoolCo {
>      Coroutine *co;
>      int ret;
> @@ -297,18 +326,38 @@ int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg)
>      return tpc.ret;
>  }
>  
> -void thread_pool_submit(ThreadPoolFunc *func,
> -                        void *arg, GDestroyNotify arg_destroy)
> +void thread_pool_join(ThreadPool *pool)

This is misleading because it's about the requests, not the threads in
the pool. Compare with what thread_pool_free does:

    /* Wait for worker threads to terminate */
    pool->max_threads = 0;
    qemu_cond_broadcast(&pool->request_cond);
    while (pool->cur_threads > 0) {
        qemu_cond_wait(&pool->worker_stopped, &pool->lock);
    }

>  {
> -    thread_pool_submit_aio(func, arg, arg_destroy, NULL, NULL);
> +    /* Assert that the thread waiting is the same running the pool */
> +    assert(pool->ctx == qemu_get_current_aio_context());
> +
> +    qemu_mutex_lock(&pool->lock);
> +
> +    if (pool->requests_executing > 0 ||
> +        !QTAILQ_EMPTY(&pool->request_list)) {
> +        qemu_cond_wait(&pool->no_requests_cond, &pool->lock);
> +    }
> +    assert(pool->requests_executing == 0 &&
> +           QTAILQ_EMPTY(&pool->request_list));
> +
> +    qemu_mutex_unlock(&pool->lock);
> +
> +    aio_bh_poll(pool->ctx);
> +
> +    assert(QLIST_EMPTY(&pool->head));
>  }
>  
> -void thread_pool_update_params(ThreadPool *pool, AioContext *ctx)
> +void thread_pool_set_minmax_threads(ThreadPool *pool,
> +                                    int min_threads, int max_threads)
>  {
> +    assert(min_threads >= 0);
> +    assert(max_threads > 0);
> +    assert(max_threads >= min_threads);
> +
>      qemu_mutex_lock(&pool->lock);
>  
> -    pool->min_threads = ctx->thread_pool_min;
> -    pool->max_threads = ctx->thread_pool_max;
> +    pool->min_threads = min_threads;
> +    pool->max_threads = max_threads;
>  
>      /*
>       * We either have to:
> @@ -330,6 +379,12 @@ void thread_pool_update_params(ThreadPool *pool, AioContext *ctx)
>      qemu_mutex_unlock(&pool->lock);
>  }
>  
> +void thread_pool_update_params(ThreadPool *pool, AioContext *ctx)
> +{
> +    thread_pool_set_minmax_threads(pool,
> +                                   ctx->thread_pool_min, ctx->thread_pool_max);
> +}
> +
>  static void thread_pool_init_one(ThreadPool *pool, AioContext *ctx)
>  {
>      if (!ctx) {
> @@ -342,6 +397,7 @@ static void thread_pool_init_one(ThreadPool *pool, AioContext *ctx)
>      qemu_mutex_init(&pool->lock);
>      qemu_cond_init(&pool->worker_stopped);
>      qemu_cond_init(&pool->request_cond);
> +    qemu_cond_init(&pool->no_requests_cond);
>      pool->new_thread_bh = aio_bh_new(ctx, spawn_thread_bh_fn, pool);
>  
>      QLIST_INIT(&pool->head);
> @@ -382,6 +438,7 @@ void thread_pool_free(ThreadPool *pool)
>      qemu_mutex_unlock(&pool->lock);
>  
>      qemu_bh_delete(pool->completion_bh);
> +    qemu_cond_destroy(&pool->no_requests_cond);
>      qemu_cond_destroy(&pool->request_cond);
>      qemu_cond_destroy(&pool->worker_stopped);
>      qemu_mutex_destroy(&pool->lock);

