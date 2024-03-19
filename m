Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0929CD11C2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbAj-0001nZ-EP; Tue, 19 Mar 2024 11:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmbAa-0001n2-2V
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmbAX-0007xl-3F
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710861264;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=d2uN4Kin2h+VgmQ97CmOEjADNpdI9jJEqb0ZxpYEjn8=;
 b=HDqLIGlVaOeceThpdlwg47tcIrPR4l7iARME8B17aPs6vcveZFpWoJC2bz38c9QWOHt8+i
 WOPu8FWax9boeOcXCtZyJMv2z8tYCC0daEY73SAkAyY8Gl0GIQ/9fJVD/ozzNEwJwdE9sz
 zX6B9iyWDr6DfKUXX+LfvcGXZVclQ2E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-p4aiX2sMNre8ZSX4z2EN5w-1; Tue, 19 Mar 2024 11:14:20 -0400
X-MC-Unique: p4aiX2sMNre8ZSX4z2EN5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8357B8007A1;
 Tue, 19 Mar 2024 15:14:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FBDF1C060A4;
 Tue, 19 Mar 2024 15:14:13 +0000 (UTC)
Date: Tue, 19 Mar 2024 15:14:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Sanjay Rao <srao@redhat.com>,
 Boaz Ben Shabat <bbenshab@redhat.com>, Joe Mario <jmario@redhat.com>
Subject: Re: [PULL 1/1] coroutine: cap per-thread local pool size
Message-ID: <Zfmrv8Ph6GHSvuLJ@redhat.com>
References: <20240319150938.1108941-1-stefanha@redhat.com>
 <20240319150938.1108941-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240319150938.1108941-2-stefanha@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Sending this PULL feels little rushed, as I still have
un-answered questions on the inital patch posting just
a few hours ago....

On Tue, Mar 19, 2024 at 11:09:38AM -0400, Stefan Hajnoczi wrote:
> The coroutine pool implementation can hit the Linux vm.max_map_count
> limit, causing QEMU to abort with "failed to allocate memory for stack"
> or "failed to set up stack guard page" during coroutine creation.
> 
> This happens because per-thread pools can grow to tens of thousands of
> coroutines. Each coroutine causes 2 virtual memory areas to be created.
> Eventually vm.max_map_count is reached and memory-related syscalls fail.
> The per-thread pool sizes are non-uniform and depend on past coroutine
> usage in each thread, so it's possible for one thread to have a large
> pool while another thread's pool is empty.
> 
> Switch to a new coroutine pool implementation with a global pool that
> grows to a maximum number of coroutines and per-thread local pools that
> are capped at hardcoded small number of coroutines.
> 
> This approach does not leave large numbers of coroutines pooled in a
> thread that may not use them again. In order to perform well it
> amortizes the cost of global pool accesses by working in batches of
> coroutines instead of individual coroutines.
> 
> The global pool is a list. Threads donate batches of coroutines to when
> they have too many and take batches from when they have too few:
> 
> .-----------------------------------.
> | Batch 1 | Batch 2 | Batch 3 | ... | global_pool
> `-----------------------------------'
> 
> Each thread has up to 2 batches of coroutines:
> 
> .-------------------.
> | Batch 1 | Batch 2 | per-thread local_pool (maximum 2 batches)
> `-------------------'
> 
> The goal of this change is to reduce the excessive number of pooled
> coroutines that cause QEMU to abort when vm.max_map_count is reached
> without losing the performance of an adequately sized coroutine pool.
> 
> Here are virtio-blk disk I/O benchmark results:
> 
>       RW BLKSIZE IODEPTH    OLD    NEW CHANGE
> randread      4k       1 113725 117451 +3.3%
> randread      4k       8 192968 198510 +2.9%
> randread      4k      16 207138 209429 +1.1%
> randread      4k      32 212399 215145 +1.3%
> randread      4k      64 218319 221277 +1.4%
> randread    128k       1  17587  17535 -0.3%
> randread    128k       8  17614  17616 +0.0%
> randread    128k      16  17608  17609 +0.0%
> randread    128k      32  17552  17553 +0.0%
> randread    128k      64  17484  17484 +0.0%
> 
> See files/{fio.sh,test.xml.j2} for the benchmark configuration:
> https://gitlab.com/stefanha/virt-playbooks/-/tree/coroutine-pool-fix-sizing
> 
> Buglink: https://issues.redhat.com/browse/RHEL-28947
> Reported-by: Sanjay Rao <srao@redhat.com>
> Reported-by: Boaz Ben Shabat <bbenshab@redhat.com>
> Reported-by: Joe Mario <jmario@redhat.com>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-ID: <20240318183429.1039340-1-stefanha@redhat.com>
> ---
>  util/qemu-coroutine.c | 282 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 223 insertions(+), 59 deletions(-)
> 
> diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> index 5fd2dbaf8b..2790959eaf 100644
> --- a/util/qemu-coroutine.c
> +++ b/util/qemu-coroutine.c
> @@ -18,39 +18,200 @@
>  #include "qemu/atomic.h"
>  #include "qemu/coroutine_int.h"
>  #include "qemu/coroutine-tls.h"
> +#include "qemu/cutils.h"
>  #include "block/aio.h"
>  
> -/**
> - * The minimal batch size is always 64, coroutines from the release_pool are
> - * reused as soon as there are 64 coroutines in it. The maximum pool size starts
> - * with 64 and is increased on demand so that coroutines are not deleted even if
> - * they are not immediately reused.
> - */
>  enum {
> -    POOL_MIN_BATCH_SIZE = 64,
> -    POOL_INITIAL_MAX_SIZE = 64,
> +    COROUTINE_POOL_BATCH_MAX_SIZE = 128,
>  };
>  
> -/** Free list to speed up creation */
> -static QSLIST_HEAD(, Coroutine) release_pool = QSLIST_HEAD_INITIALIZER(pool);
> -static unsigned int pool_max_size = POOL_INITIAL_MAX_SIZE;
> -static unsigned int release_pool_size;
> +/*
> + * Coroutine creation and deletion is expensive so a pool of unused coroutines
> + * is kept as a cache. When the pool has coroutines available, they are
> + * recycled instead of creating new ones from scratch. Coroutines are added to
> + * the pool upon termination.
> + *
> + * The pool is global but each thread maintains a small local pool to avoid
> + * global pool contention. Threads fetch and return batches of coroutines from
> + * the global pool to maintain their local pool. The local pool holds up to two
> + * batches whereas the maximum size of the global pool is controlled by the
> + * qemu_coroutine_inc_pool_size() API.
> + *
> + * .-----------------------------------.
> + * | Batch 1 | Batch 2 | Batch 3 | ... | global_pool
> + * `-----------------------------------'
> + *
> + * .-------------------.
> + * | Batch 1 | Batch 2 | per-thread local_pool (maximum 2 batches)
> + * `-------------------'
> + */
> +typedef struct CoroutinePoolBatch {
> +    /* Batches are kept in a list */
> +    QSLIST_ENTRY(CoroutinePoolBatch) next;
>  
> -typedef QSLIST_HEAD(, Coroutine) CoroutineQSList;
> -QEMU_DEFINE_STATIC_CO_TLS(CoroutineQSList, alloc_pool);
> -QEMU_DEFINE_STATIC_CO_TLS(unsigned int, alloc_pool_size);
> -QEMU_DEFINE_STATIC_CO_TLS(Notifier, coroutine_pool_cleanup_notifier);
> +    /* This batch holds up to @COROUTINE_POOL_BATCH_MAX_SIZE coroutines */
> +    QSLIST_HEAD(, Coroutine) list;
> +    unsigned int size;
> +} CoroutinePoolBatch;
>  
> -static void coroutine_pool_cleanup(Notifier *n, void *value)
> +typedef QSLIST_HEAD(, CoroutinePoolBatch) CoroutinePool;
> +
> +/* Host operating system limit on number of pooled coroutines */
> +static unsigned int global_pool_hard_max_size;
> +
> +static QemuMutex global_pool_lock; /* protects the following variables */
> +static CoroutinePool global_pool = QSLIST_HEAD_INITIALIZER(global_pool);
> +static unsigned int global_pool_size;
> +static unsigned int global_pool_max_size = COROUTINE_POOL_BATCH_MAX_SIZE;
> +
> +QEMU_DEFINE_STATIC_CO_TLS(CoroutinePool, local_pool);
> +QEMU_DEFINE_STATIC_CO_TLS(Notifier, local_pool_cleanup_notifier);
> +
> +static CoroutinePoolBatch *coroutine_pool_batch_new(void)
> +{
> +    CoroutinePoolBatch *batch = g_new(CoroutinePoolBatch, 1);
> +
> +    QSLIST_INIT(&batch->list);
> +    batch->size = 0;
> +    return batch;
> +}
> +
> +static void coroutine_pool_batch_delete(CoroutinePoolBatch *batch)
>  {
>      Coroutine *co;
>      Coroutine *tmp;
> -    CoroutineQSList *alloc_pool = get_ptr_alloc_pool();
>  
> -    QSLIST_FOREACH_SAFE(co, alloc_pool, pool_next, tmp) {
> -        QSLIST_REMOVE_HEAD(alloc_pool, pool_next);
> +    QSLIST_FOREACH_SAFE(co, &batch->list, pool_next, tmp) {
> +        QSLIST_REMOVE_HEAD(&batch->list, pool_next);
>          qemu_coroutine_delete(co);
>      }
> +    g_free(batch);
> +}
> +
> +static void local_pool_cleanup(Notifier *n, void *value)
> +{
> +    CoroutinePool *local_pool = get_ptr_local_pool();
> +    CoroutinePoolBatch *batch;
> +    CoroutinePoolBatch *tmp;
> +
> +    QSLIST_FOREACH_SAFE(batch, local_pool, next, tmp) {
> +        QSLIST_REMOVE_HEAD(local_pool, next);
> +        coroutine_pool_batch_delete(batch);
> +    }
> +}
> +
> +/* Ensure the atexit notifier is registered */
> +static void local_pool_cleanup_init_once(void)
> +{
> +    Notifier *notifier = get_ptr_local_pool_cleanup_notifier();
> +    if (!notifier->notify) {
> +        notifier->notify = local_pool_cleanup;
> +        qemu_thread_atexit_add(notifier);
> +    }
> +}
> +
> +/* Helper to get the next unused coroutine from the local pool */
> +static Coroutine *coroutine_pool_get_local(void)
> +{
> +    CoroutinePool *local_pool = get_ptr_local_pool();
> +    CoroutinePoolBatch *batch = QSLIST_FIRST(local_pool);
> +    Coroutine *co;
> +
> +    if (unlikely(!batch)) {
> +        return NULL;
> +    }
> +
> +    co = QSLIST_FIRST(&batch->list);
> +    QSLIST_REMOVE_HEAD(&batch->list, pool_next);
> +    batch->size--;
> +
> +    if (batch->size == 0) {
> +        QSLIST_REMOVE_HEAD(local_pool, next);
> +        coroutine_pool_batch_delete(batch);
> +    }
> +    return co;
> +}
> +
> +/* Get the next batch from the global pool */
> +static void coroutine_pool_refill_local(void)
> +{
> +    CoroutinePool *local_pool = get_ptr_local_pool();
> +    CoroutinePoolBatch *batch;
> +
> +    WITH_QEMU_LOCK_GUARD(&global_pool_lock) {
> +        batch = QSLIST_FIRST(&global_pool);
> +
> +        if (batch) {
> +            QSLIST_REMOVE_HEAD(&global_pool, next);
> +            global_pool_size -= batch->size;
> +        }
> +    }
> +
> +    if (batch) {
> +        QSLIST_INSERT_HEAD(local_pool, batch, next);
> +        local_pool_cleanup_init_once();
> +    }
> +}
> +
> +/* Add a batch of coroutines to the global pool */
> +static void coroutine_pool_put_global(CoroutinePoolBatch *batch)
> +{
> +    WITH_QEMU_LOCK_GUARD(&global_pool_lock) {
> +        unsigned int max = MIN(global_pool_max_size,
> +                               global_pool_hard_max_size);
> +
> +        if (global_pool_size < max) {
> +            QSLIST_INSERT_HEAD(&global_pool, batch, next);
> +
> +            /* Overshooting the max pool size is allowed */
> +            global_pool_size += batch->size;
> +            return;
> +        }
> +    }
> +
> +    /* The global pool was full, so throw away this batch */
> +    coroutine_pool_batch_delete(batch);
> +}
> +
> +/* Get the next unused coroutine from the pool or return NULL */
> +static Coroutine *coroutine_pool_get(void)
> +{
> +    Coroutine *co;
> +
> +    co = coroutine_pool_get_local();
> +    if (!co) {
> +        coroutine_pool_refill_local();
> +        co = coroutine_pool_get_local();
> +    }
> +    return co;
> +}
> +
> +static void coroutine_pool_put(Coroutine *co)
> +{
> +    CoroutinePool *local_pool = get_ptr_local_pool();
> +    CoroutinePoolBatch *batch = QSLIST_FIRST(local_pool);
> +
> +    if (unlikely(!batch)) {
> +        batch = coroutine_pool_batch_new();
> +        QSLIST_INSERT_HEAD(local_pool, batch, next);
> +        local_pool_cleanup_init_once();
> +    }
> +
> +    if (unlikely(batch->size >= COROUTINE_POOL_BATCH_MAX_SIZE)) {
> +        CoroutinePoolBatch *next = QSLIST_NEXT(batch, next);
> +
> +        /* Is the local pool full? */
> +        if (next) {
> +            QSLIST_REMOVE_HEAD(local_pool, next);
> +            coroutine_pool_put_global(batch);
> +        }
> +
> +        batch = coroutine_pool_batch_new();
> +        QSLIST_INSERT_HEAD(local_pool, batch, next);
> +    }
> +
> +    QSLIST_INSERT_HEAD(&batch->list, co, pool_next);
> +    batch->size++;
>  }
>  
>  Coroutine *qemu_coroutine_create(CoroutineEntry *entry, void *opaque)
> @@ -58,31 +219,7 @@ Coroutine *qemu_coroutine_create(CoroutineEntry *entry, void *opaque)
>      Coroutine *co = NULL;
>  
>      if (IS_ENABLED(CONFIG_COROUTINE_POOL)) {
> -        CoroutineQSList *alloc_pool = get_ptr_alloc_pool();
> -
> -        co = QSLIST_FIRST(alloc_pool);
> -        if (!co) {
> -            if (release_pool_size > POOL_MIN_BATCH_SIZE) {
> -                /* Slow path; a good place to register the destructor, too.  */
> -                Notifier *notifier = get_ptr_coroutine_pool_cleanup_notifier();
> -                if (!notifier->notify) {
> -                    notifier->notify = coroutine_pool_cleanup;
> -                    qemu_thread_atexit_add(notifier);
> -                }
> -
> -                /* This is not exact; there could be a little skew between
> -                 * release_pool_size and the actual size of release_pool.  But
> -                 * it is just a heuristic, it does not need to be perfect.
> -                 */
> -                set_alloc_pool_size(qatomic_xchg(&release_pool_size, 0));
> -                QSLIST_MOVE_ATOMIC(alloc_pool, &release_pool);
> -                co = QSLIST_FIRST(alloc_pool);
> -            }
> -        }
> -        if (co) {
> -            QSLIST_REMOVE_HEAD(alloc_pool, pool_next);
> -            set_alloc_pool_size(get_alloc_pool_size() - 1);
> -        }
> +        co = coroutine_pool_get();
>      }
>  
>      if (!co) {
> @@ -100,19 +237,10 @@ static void coroutine_delete(Coroutine *co)
>      co->caller = NULL;
>  
>      if (IS_ENABLED(CONFIG_COROUTINE_POOL)) {
> -        if (release_pool_size < qatomic_read(&pool_max_size) * 2) {
> -            QSLIST_INSERT_HEAD_ATOMIC(&release_pool, co, pool_next);
> -            qatomic_inc(&release_pool_size);
> -            return;
> -        }
> -        if (get_alloc_pool_size() < qatomic_read(&pool_max_size)) {
> -            QSLIST_INSERT_HEAD(get_ptr_alloc_pool(), co, pool_next);
> -            set_alloc_pool_size(get_alloc_pool_size() + 1);
> -            return;
> -        }
> +        coroutine_pool_put(co);
> +    } else {
> +        qemu_coroutine_delete(co);
>      }
> -
> -    qemu_coroutine_delete(co);
>  }
>  
>  void qemu_aio_coroutine_enter(AioContext *ctx, Coroutine *co)
> @@ -223,10 +351,46 @@ AioContext *qemu_coroutine_get_aio_context(Coroutine *co)
>  
>  void qemu_coroutine_inc_pool_size(unsigned int additional_pool_size)
>  {
> -    qatomic_add(&pool_max_size, additional_pool_size);
> +    QEMU_LOCK_GUARD(&global_pool_lock);
> +    global_pool_max_size += additional_pool_size;
>  }
>  
>  void qemu_coroutine_dec_pool_size(unsigned int removing_pool_size)
>  {
> -    qatomic_sub(&pool_max_size, removing_pool_size);
> +    QEMU_LOCK_GUARD(&global_pool_lock);
> +    global_pool_max_size -= removing_pool_size;
> +}
> +
> +static unsigned int get_global_pool_hard_max_size(void)
> +{
> +#ifdef __linux__
> +    g_autofree char *contents = NULL;
> +    int max_map_count;
> +
> +    /*
> +     * Linux processes can have up to max_map_count virtual memory areas
> +     * (VMAs). mmap(2), mprotect(2), etc fail with ENOMEM beyond this limit. We
> +     * must limit the coroutine pool to a safe size to avoid running out of
> +     * VMAs.
> +     */
> +    if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents, NULL,
> +                            NULL) &&
> +        qemu_strtoi(contents, NULL, 10, &max_map_count) == 0) {
> +        /*
> +         * This is a conservative upper bound that avoids exceeding
> +         * max_map_count. Leave half for non-coroutine users like library
> +         * dependencies, vhost-user, etc. Each coroutine takes up 2 VMAs so
> +         * halve the amount again.
> +         */
> +        return max_map_count / 4;
> +    }
> +#endif
> +
> +    return UINT_MAX;
> +}
> +
> +static void __attribute__((constructor)) qemu_coroutine_init(void)
> +{
> +    qemu_mutex_init(&global_pool_lock);
> +    global_pool_hard_max_size = get_global_pool_hard_max_size();
>  }
> -- 
> 2.44.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


