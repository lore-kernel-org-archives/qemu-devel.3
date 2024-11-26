Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43004D3B9BB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 16:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyOx-0006F8-8K; Tue, 26 Nov 2024 11:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tFyOv-0006Eb-O7
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:26:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tFyOt-0003Xz-FT
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732638414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3TnGbU0GiAp9BuoMialb0tJUr7Ko2c6jEs+ndRF4rzg=;
 b=AkHklQGZWf1KuNA1enbp4yjFipcgQIqYX8hN+G1PSzkzZqjKaF/IsE4D6ptPtH1l3cwJA5
 bSacKViwlLp7yiCUh6W4g9D8XeyWyYFwMsH0nmQA98hMKXjWv2FnMVKD3PqAL2T5xn6lix
 c9dPjNJq4Qv3t2+Mtce7cbaIMWPkOW4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-x5gls2o6Nb6JO5HlSmx0TQ-1; Tue, 26 Nov 2024 11:26:52 -0500
X-MC-Unique: x5gls2o6Nb6JO5HlSmx0TQ-1
X-Mimecast-MFC-AGG-ID: x5gls2o6Nb6JO5HlSmx0TQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4349e97bfc4so24913825e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 08:26:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732638411; x=1733243211;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3TnGbU0GiAp9BuoMialb0tJUr7Ko2c6jEs+ndRF4rzg=;
 b=hW12MHOa2WePmfzAaJPc4UosUL39DrbP6i424zigZA8Q9X2rKYuq/JVCWtDM1FDeZ0
 vJ1ZFI0vUrkn62SWoeBbqrc2LaL3kueQ8a0wLCaUr4td6ljo1pBaEkHbm2lUZeJ4XTew
 P/rhu++l1Jf2SAevCD2WBFYluQcLCzCTlOyWk5uE0YlVbwtCWD1En9Pvjh1Xwb8j8ldz
 K2bO5eupjLXbCBTzvWH4hrtPXj3nxWzim60vav9+cZwC2Sk4B+8VmlHPeAuCRwk8Oqwz
 BU6vD5dpmXSPp0E3U9hN1ii+HvzeOkKzL2RFKLu0mWObYrcIZCHFFjLTfTIAsV8CXYBR
 kNTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULMzD3OHo1rGYljpWsi0M0LxmqcFFDqsuzerL+PG1ndwwfRo+vkw1f3F7odjjx7TrUwU7CwKXrsmbQ@nongnu.org
X-Gm-Message-State: AOJu0Yyz/7eeFJE8Cau7Awow7OqIbAuMU6eX3Hy9aNqsRa5BRZ09Sar9
 r73m+t22Uu+I917epIO+kWyjrW+U+5LRRyya67C6PO7YvanMTchPE78ZmdAKSO4KRyOgfY32aZE
 n71UKMKOfJ2z9mRK9fwPkltBjTGy7lfzgEWwXc5yiLxOhHrgWAucN
X-Gm-Gg: ASbGnctUz2cvkcZBpfhz5tY5HIhWH9m1UEHzfLucJ4S1tBURFp3W88QvMHYA1GeBewk
 jIse2yyLEEPYSVH/fDtIldyJVq9ApjfplECizqQD3z+YS7Jav4h1OqnF8HsPE0Vge7nbQS0K3j+
 opc92jx2+MuGZGIgKKpE/qruoH3Wf21XxH+5S1FqVjKn0nnmRnYiuukVmIfbpqGFGmISTi48fEb
 Jodu9JKLMaFJ/2niEpnsAbTpoPw8d7gBeeM4T9D4Xzp0qRUEuSpvB9d+FvvF2FgkfDO5h9PUpGU
 3zLMBqgFNScB
X-Received: by 2002:a05:6000:1faa:b0:382:511a:8f0c with SMTP id
 ffacd0b85a97d-38260bea7ddmr18998265f8f.56.1732638411250; 
 Tue, 26 Nov 2024 08:26:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZjL/x8yl8FEalZKNxRjmRgXm5hR0CrP9VSXzwQe/TkLb9KbGYA3L7F3rFLH0clNkaR9G+Kg==
X-Received: by 2002:a05:6000:1faa:b0:382:511a:8f0c with SMTP id
 ffacd0b85a97d-38260bea7ddmr18998228f8f.56.1732638410784; 
 Tue, 26 Nov 2024 08:26:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a28f3af4sm48951935e9.16.2024.11.26.08.26.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 08:26:50 -0800 (PST)
Message-ID: <185e1baa-9ed6-45b1-9e20-34082b57257d@redhat.com>
Date: Tue, 26 Nov 2024 17:26:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/24] thread-pool: Rename AIO pool functions to
 *_aio() and data types to *Aio
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <ea3e65080c00cebdc95dad8b68070709c3607e79.1731773021.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <ea3e65080c00cebdc95dad8b68070709c3607e79.1731773021.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/17/24 20:19, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> These names conflict with ones used by future generic thread pool
> equivalents.
> Generic names should belong to the generic pool type, not specific (AIO)
> type.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/block/aio.h         |  8 ++---
>   include/block/thread-pool.h |  8 ++---
>   util/async.c                |  6 ++--
>   util/thread-pool.c          | 58 ++++++++++++++++++-------------------
>   util/trace-events           |  4 +--
>   5 files changed, 42 insertions(+), 42 deletions(-)
> 
> diff --git a/include/block/aio.h b/include/block/aio.h
> index 43883a8a33a8..b2ab3514de23 100644
> --- a/include/block/aio.h
> +++ b/include/block/aio.h
> @@ -54,7 +54,7 @@ typedef void QEMUBHFunc(void *opaque);
>   typedef bool AioPollFn(void *opaque);
>   typedef void IOHandler(void *opaque);
>   
> -struct ThreadPool;
> +struct ThreadPoolAio;
>   struct LinuxAioState;
>   typedef struct LuringState LuringState;
>   
> @@ -207,7 +207,7 @@ struct AioContext {
>       /* Thread pool for performing work and receiving completion callbacks.
>        * Has its own locking.
>        */
> -    struct ThreadPool *thread_pool;
> +    struct ThreadPoolAio *thread_pool;
>   
>   #ifdef CONFIG_LINUX_AIO
>       struct LinuxAioState *linux_aio;
> @@ -500,8 +500,8 @@ void aio_set_event_notifier_poll(AioContext *ctx,
>    */
>   GSource *aio_get_g_source(AioContext *ctx);
>   
> -/* Return the ThreadPool bound to this AioContext */
> -struct ThreadPool *aio_get_thread_pool(AioContext *ctx);
> +/* Return the ThreadPoolAio bound to this AioContext */
> +struct ThreadPoolAio *aio_get_thread_pool(AioContext *ctx);
>   
>   /* Setup the LinuxAioState bound to this AioContext */
>   struct LinuxAioState *aio_setup_linux_aio(AioContext *ctx, Error **errp);
> diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
> index 4f6694026123..6f27eb085b45 100644
> --- a/include/block/thread-pool.h
> +++ b/include/block/thread-pool.h
> @@ -24,10 +24,10 @@
>   
>   typedef int ThreadPoolFunc(void *opaque);
>   
> -typedef struct ThreadPool ThreadPool;
> +typedef struct ThreadPoolAio ThreadPoolAio;
>   
> -ThreadPool *thread_pool_new(struct AioContext *ctx);
> -void thread_pool_free(ThreadPool *pool);
> +ThreadPoolAio *thread_pool_new_aio(struct AioContext *ctx);
> +void thread_pool_free_aio(ThreadPoolAio *pool);
>   
>   /*
>    * thread_pool_submit_{aio,co} API: submit I/O requests in the thread's
> @@ -36,7 +36,7 @@ void thread_pool_free(ThreadPool *pool);
>   BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
>                                      BlockCompletionFunc *cb, void *opaque);
>   int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg);
> +void thread_pool_update_params(ThreadPoolAio *pool, struct AioContext *ctx);
>   
> -void thread_pool_update_params(ThreadPool *pool, struct AioContext *ctx);
>   
>   #endif
> diff --git a/util/async.c b/util/async.c
> index 99db28389f66..f8b7678aefc8 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -369,7 +369,7 @@ aio_ctx_finalize(GSource     *source)
>       QEMUBH *bh;
>       unsigned flags;
>   
> -    thread_pool_free(ctx->thread_pool);
> +    thread_pool_free_aio(ctx->thread_pool);
>   
>   #ifdef CONFIG_LINUX_AIO
>       if (ctx->linux_aio) {
> @@ -435,10 +435,10 @@ GSource *aio_get_g_source(AioContext *ctx)
>       return &ctx->source;
>   }
>   
> -ThreadPool *aio_get_thread_pool(AioContext *ctx)
> +ThreadPoolAio *aio_get_thread_pool(AioContext *ctx)
>   {
>       if (!ctx->thread_pool) {
> -        ctx->thread_pool = thread_pool_new(ctx);
> +        ctx->thread_pool = thread_pool_new_aio(ctx);
>       }
>       return ctx->thread_pool;
>   }
> diff --git a/util/thread-pool.c b/util/thread-pool.c
> index 2f751d55b33f..908194dc070f 100644
> --- a/util/thread-pool.c
> +++ b/util/thread-pool.c
> @@ -23,9 +23,9 @@
>   #include "block/thread-pool.h"
>   #include "qemu/main-loop.h"
>   
> -static void do_spawn_thread(ThreadPool *pool);
> +static void do_spawn_thread(ThreadPoolAio *pool);
>   
> -typedef struct ThreadPoolElement ThreadPoolElement;
> +typedef struct ThreadPoolElementAio ThreadPoolElementAio;
>   
>   enum ThreadState {
>       THREAD_QUEUED,
> @@ -33,9 +33,9 @@ enum ThreadState {
>       THREAD_DONE,
>   };
>   
> -struct ThreadPoolElement {
> +struct ThreadPoolElementAio {
>       BlockAIOCB common;
> -    ThreadPool *pool;
> +    ThreadPoolAio *pool;
>       ThreadPoolFunc *func;
>       void *arg;
>   
> @@ -47,13 +47,13 @@ struct ThreadPoolElement {
>       int ret;
>   
>       /* Access to this list is protected by lock.  */
> -    QTAILQ_ENTRY(ThreadPoolElement) reqs;
> +    QTAILQ_ENTRY(ThreadPoolElementAio) reqs;
>   
>       /* This list is only written by the thread pool's mother thread.  */
> -    QLIST_ENTRY(ThreadPoolElement) all;
> +    QLIST_ENTRY(ThreadPoolElementAio) all;
>   };
>   
> -struct ThreadPool {
> +struct ThreadPoolAio {
>       AioContext *ctx;
>       QEMUBH *completion_bh;
>       QemuMutex lock;
> @@ -62,10 +62,10 @@ struct ThreadPool {
>       QEMUBH *new_thread_bh;
>   
>       /* The following variables are only accessed from one AioContext. */
> -    QLIST_HEAD(, ThreadPoolElement) head;
> +    QLIST_HEAD(, ThreadPoolElementAio) head;
>   
>       /* The following variables are protected by lock.  */
> -    QTAILQ_HEAD(, ThreadPoolElement) request_list;
> +    QTAILQ_HEAD(, ThreadPoolElementAio) request_list;
>       int cur_threads;
>       int idle_threads;
>       int new_threads;     /* backlog of threads we need to create */
> @@ -76,14 +76,14 @@ struct ThreadPool {
>   
>   static void *worker_thread(void *opaque)
>   {
> -    ThreadPool *pool = opaque;
> +    ThreadPoolAio *pool = opaque;
>   
>       qemu_mutex_lock(&pool->lock);
>       pool->pending_threads--;
>       do_spawn_thread(pool);
>   
>       while (pool->cur_threads <= pool->max_threads) {
> -        ThreadPoolElement *req;
> +        ThreadPoolElementAio *req;
>           int ret;
>   
>           if (QTAILQ_EMPTY(&pool->request_list)) {
> @@ -131,7 +131,7 @@ static void *worker_thread(void *opaque)
>       return NULL;
>   }
>   
> -static void do_spawn_thread(ThreadPool *pool)
> +static void do_spawn_thread(ThreadPoolAio *pool)
>   {
>       QemuThread t;
>   
> @@ -148,14 +148,14 @@ static void do_spawn_thread(ThreadPool *pool)
>   
>   static void spawn_thread_bh_fn(void *opaque)
>   {
> -    ThreadPool *pool = opaque;
> +    ThreadPoolAio *pool = opaque;
>   
>       qemu_mutex_lock(&pool->lock);
>       do_spawn_thread(pool);
>       qemu_mutex_unlock(&pool->lock);
>   }
>   
> -static void spawn_thread(ThreadPool *pool)
> +static void spawn_thread(ThreadPoolAio *pool)
>   {
>       pool->cur_threads++;
>       pool->new_threads++;
> @@ -173,8 +173,8 @@ static void spawn_thread(ThreadPool *pool)
>   
>   static void thread_pool_completion_bh(void *opaque)
>   {
> -    ThreadPool *pool = opaque;
> -    ThreadPoolElement *elem, *next;
> +    ThreadPoolAio *pool = opaque;
> +    ThreadPoolElementAio *elem, *next;
>   
>       defer_call_begin(); /* cb() may use defer_call() to coalesce work */
>   
> @@ -184,8 +184,8 @@ restart:
>               continue;
>           }
>   
> -        trace_thread_pool_complete(pool, elem, elem->common.opaque,
> -                                   elem->ret);
> +        trace_thread_pool_complete_aio(pool, elem, elem->common.opaque,
> +                                       elem->ret);
>           QLIST_REMOVE(elem, all);
>   
>           if (elem->common.cb) {
> @@ -217,10 +217,10 @@ restart:
>   
>   static void thread_pool_cancel(BlockAIOCB *acb)
>   {
> -    ThreadPoolElement *elem = (ThreadPoolElement *)acb;
> -    ThreadPool *pool = elem->pool;
> +    ThreadPoolElementAio *elem = (ThreadPoolElementAio *)acb;
> +    ThreadPoolAio *pool = elem->pool;
>   
> -    trace_thread_pool_cancel(elem, elem->common.opaque);
> +    trace_thread_pool_cancel_aio(elem, elem->common.opaque);
>   
>       QEMU_LOCK_GUARD(&pool->lock);
>       if (elem->state == THREAD_QUEUED) {
> @@ -234,16 +234,16 @@ static void thread_pool_cancel(BlockAIOCB *acb)
>   }
>   
>   static const AIOCBInfo thread_pool_aiocb_info = {
> -    .aiocb_size         = sizeof(ThreadPoolElement),
> +    .aiocb_size         = sizeof(ThreadPoolElementAio),
>       .cancel_async       = thread_pool_cancel,
>   };
>   
>   BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
>                                      BlockCompletionFunc *cb, void *opaque)
>   {
> -    ThreadPoolElement *req;
> +    ThreadPoolElementAio *req;
>       AioContext *ctx = qemu_get_current_aio_context();
> -    ThreadPool *pool = aio_get_thread_pool(ctx);
> +    ThreadPoolAio *pool = aio_get_thread_pool(ctx);
>   
>       /* Assert that the thread submitting work is the same running the pool */
>       assert(pool->ctx == qemu_get_current_aio_context());
> @@ -290,7 +290,7 @@ int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg)
>       return tpc.ret;
>   }
>   
> -void thread_pool_update_params(ThreadPool *pool, AioContext *ctx)
> +void thread_pool_update_params(ThreadPoolAio *pool, AioContext *ctx)
>   {
>       qemu_mutex_lock(&pool->lock);
>   
> @@ -317,7 +317,7 @@ void thread_pool_update_params(ThreadPool *pool, AioContext *ctx)
>       qemu_mutex_unlock(&pool->lock);
>   }
>   
> -static void thread_pool_init_one(ThreadPool *pool, AioContext *ctx)
> +static void thread_pool_init_one(ThreadPoolAio *pool, AioContext *ctx)
>   {
>       if (!ctx) {
>           ctx = qemu_get_aio_context();
> @@ -337,14 +337,14 @@ static void thread_pool_init_one(ThreadPool *pool, AioContext *ctx)
>       thread_pool_update_params(pool, ctx);
>   }
>   
> -ThreadPool *thread_pool_new(AioContext *ctx)
> +ThreadPoolAio *thread_pool_new_aio(AioContext *ctx)
>   {
> -    ThreadPool *pool = g_new(ThreadPool, 1);
> +    ThreadPoolAio *pool = g_new(ThreadPoolAio, 1);
>       thread_pool_init_one(pool, ctx);
>       return pool;
>   }
>   
> -void thread_pool_free(ThreadPool *pool)
> +void thread_pool_free_aio(ThreadPoolAio *pool)
>   {
>       if (!pool) {
>           return;
> diff --git a/util/trace-events b/util/trace-events
> index 5be12d7fab89..bd8f25fb5920 100644
> --- a/util/trace-events
> +++ b/util/trace-events
> @@ -15,8 +15,8 @@ reentrant_aio(void *ctx, const char *name) "ctx %p name %s"
>   
>   # thread-pool.c
>   thread_pool_submit_aio(void *pool, void *req, void *opaque) "pool %p req %p opaque %p"
> -thread_pool_complete(void *pool, void *req, void *opaque, int ret) "pool %p req %p opaque %p ret %d"
> -thread_pool_cancel(void *req, void *opaque) "req %p opaque %p"
> +thread_pool_complete_aio(void *pool, void *req, void *opaque, int ret) "pool %p req %p opaque %p ret %d"
> +thread_pool_cancel_aio(void *req, void *opaque) "req %p opaque %p"
>   
>   # buffer.c
>   buffer_resize(const char *buf, size_t olen, size_t len) "%s: old %zd, new %zd"
> 


