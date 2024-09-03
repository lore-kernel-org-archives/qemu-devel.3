Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A17CD13CF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 12:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slSFQ-0006UT-W8; Tue, 03 Sep 2024 08:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1slSFJ-0006Mz-54
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 08:02:53 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1slSFG-0001mL-C5
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 08:02:52 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1slSF1-0006u1-1X; Tue, 03 Sep 2024 14:02:35 +0200
Message-ID: <c30e02cf-34df-4d60-b940-5f55316c0a6d@maciej.szmigiero.name>
Date: Tue, 3 Sep 2024 14:02:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/17] thread-pool: Implement non-AIO (generic) pool
 support
To: Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <54947c3a1df713f5b69d8296938f3da41116ffe0.1724701542.git.maciej.szmigiero@oracle.com>
 <87o755n20j.fsf@suse.de>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <87o755n20j.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3.09.2024 00:07, Fabiano Rosas wrote:
> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
> 
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Migration code wants to manage device data sending threads in one place.
>>
>> QEMU has an existing thread pool implementation, however it was limited
>> to queuing AIO operations only and essentially had a 1:1 mapping between
>> the current AioContext and the ThreadPool in use.
>>
>> Implement what is necessary to queue generic (non-AIO) work on a ThreadPool
>> too.
>>
>> This brings a few new operations on a pool:
>> * thread_pool_set_minmax_threads() explicitly sets the minimum and maximum
>> thread count in the pool.
>>
>> * thread_pool_join() operation waits until all the submitted work requests
>> have finished.
>>
>> * thread_pool_poll() lets the new thread and / or thread completion bottom
>> halves run (if they are indeed scheduled to be run).
>> It is useful for thread pool users that need to launch or terminate new
>> threads without returning to the QEMU main loop.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   include/block/thread-pool.h   | 10 ++++-
>>   tests/unit/test-thread-pool.c |  2 +-
>>   util/thread-pool.c            | 77 ++++++++++++++++++++++++++++++-----
>>   3 files changed, 76 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
>> index b484c4780ea6..1769496056cd 100644
>> --- a/include/block/thread-pool.h
>> +++ b/include/block/thread-pool.h
>> @@ -37,9 +37,15 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
>>                                      void *arg, GDestroyNotify arg_destroy,
>>                                      BlockCompletionFunc *cb, void *opaque);
>>   int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg);
>> -void thread_pool_submit(ThreadPoolFunc *func,
>> -                        void *arg, GDestroyNotify arg_destroy);
>> +BlockAIOCB *thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
>> +                               void *arg, GDestroyNotify arg_destroy,
>> +                               BlockCompletionFunc *cb, void *opaque);
> 
> These kinds of changes (create wrappers, change signatures, etc), could
> be in their own patch as it's just code motion that should not have
> functional impact. The "no_requests" stuff would be better discussed in
> a separate patch.

These changes *all* should have no functional impact on existing callers.

But I get your overall point, will try to separate these really trivial
parts.

>>   
>> +void thread_pool_join(ThreadPool *pool);
>> +void thread_pool_poll(ThreadPool *pool);
>> +
>> +void thread_pool_set_minmax_threads(ThreadPool *pool,
>> +                                    int min_threads, int max_threads);
>>   void thread_pool_update_params(ThreadPool *pool, struct AioContext *ctx);
>>   
>>   #endif
>> diff --git a/tests/unit/test-thread-pool.c b/tests/unit/test-thread-pool.c
>> index e4afb9e36292..469c0f7057b6 100644
>> --- a/tests/unit/test-thread-pool.c
>> +++ b/tests/unit/test-thread-pool.c
>> @@ -46,7 +46,7 @@ static void done_cb(void *opaque, int ret)
>>   static void test_submit(void)
>>   {
>>       WorkerTestData data = { .n = 0 };
>> -    thread_pool_submit(worker_cb, &data, NULL);
>> +    thread_pool_submit(NULL, worker_cb, &data, NULL, NULL, NULL);
>>       while (data.n == 0) {
>>           aio_poll(ctx, true);
>>       }
>> diff --git a/util/thread-pool.c b/util/thread-pool.c
>> index 69a87ee79252..2bf3be875a51 100644
>> --- a/util/thread-pool.c
>> +++ b/util/thread-pool.c
>> @@ -60,6 +60,7 @@ struct ThreadPool {
>>       QemuMutex lock;
>>       QemuCond worker_stopped;
>>       QemuCond request_cond;
>> +    QemuCond no_requests_cond;
>>       QEMUBH *new_thread_bh;
>>   
>>       /* The following variables are only accessed from one AioContext. */
>> @@ -73,6 +74,7 @@ struct ThreadPool {
>>       int pending_threads; /* threads created but not running yet */
>>       int min_threads;
>>       int max_threads;
>> +    size_t requests_executing;
> 
> What's with size_t? Should this be a uint32_t instead?

Sizes of objects are normally size_t, since otherwise bad
things happen if objects are bigger than 4 GiB.

Considering that the minimum object size is 1 byte the
max count of distinct objects also needs a size_t to not
risk an overflow.

I think that while 2^32 requests executing seems unlikely
saving 4 bytes seems not worth worrying that someone will
find a vulnerability triggered by overflowing a 32-bit
variable (not necessary in the migration code but in some
other thread pool user).

>>   };
>>   
>>   static void *worker_thread(void *opaque)
>> @@ -107,6 +109,10 @@ static void *worker_thread(void *opaque)
>>           req = QTAILQ_FIRST(&pool->request_list);
>>           QTAILQ_REMOVE(&pool->request_list, req, reqs);
>>           req->state = THREAD_ACTIVE;
>> +
>> +        assert(pool->requests_executing < SIZE_MAX);
>> +        pool->requests_executing++;
>> +
>>           qemu_mutex_unlock(&pool->lock);
>>   
>>           ret = req->func(req->arg);
>> @@ -118,6 +124,14 @@ static void *worker_thread(void *opaque)
>>   
>>           qemu_bh_schedule(pool->completion_bh);
>>           qemu_mutex_lock(&pool->lock);
>> +
>> +        assert(pool->requests_executing > 0);
>> +        pool->requests_executing--;
>> +
>> +        if (pool->requests_executing == 0 &&
>> +            QTAILQ_EMPTY(&pool->request_list)) {
>> +            qemu_cond_signal(&pool->no_requests_cond);
>> +        }
> 
> An empty requests list and no request in flight means the worker will
> now exit after the timeout, no? Can you just kick the worker out of the
> wait and use pool->worker_stopped instead of the new condition variable?

First, all threads won't terminate if either min_threads or max_threads
isn't 0.
It might be in the migration thread pool case but we are adding a
generic thread pool so it should be as universal as possible.
thread_pool_free() can get away with overwriting these values since
it is destroying the pool anyway.

Also, the *_join() (or whatever its final name will be) operation is
about waiting for all requests / work items to finish, not about waiting
for threads to terminate.
It's essentially a synchronization point for a thread pool, not a cleanup.

>>       }
>>   
>>       pool->cur_threads--;
>> @@ -243,13 +257,16 @@ static const AIOCBInfo thread_pool_aiocb_info = {
>>       .cancel_async       = thread_pool_cancel,
>>   };
>>   
>> -BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
>> -                                   void *arg, GDestroyNotify arg_destroy,
>> -                                   BlockCompletionFunc *cb, void *opaque)
>> +BlockAIOCB *thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
>> +                               void *arg, GDestroyNotify arg_destroy,
>> +                               BlockCompletionFunc *cb, void *opaque)
>>   {
>>       ThreadPoolElement *req;
>>       AioContext *ctx = qemu_get_current_aio_context();
>> -    ThreadPool *pool = aio_get_thread_pool(ctx);
>> +
>> +    if (!pool) {
>> +        pool = aio_get_thread_pool(ctx);
>> +    }
> 
> I'd go for a separate implementation to really drive the point that this
> new usage is different. See the code snippet below.

I see your point there - will split these implementations.

> It seems we're a short step away to being able to use this
> implementation in a general way. Is there something that can be done
> with the 'common' field in the ThreadPoolElement?

The non-AIO request flow still need the completion callback from BlockAIOCB
(and its argument pointer) so removing the "common" field from these requests
would need introducing two "flavors" of ThreadPoolElement.

Not sure memory saving here are worth the increase in code complexity.

> ========
> static void thread_pool_submit_request(ThreadPool *pool, ThreadPoolElement *req)
> {
>      req->state = THREAD_QUEUED;
>      req->pool = pool;
> 
>      QLIST_INSERT_HEAD(&pool->head, req, all);
> 
>      trace_thread_pool_submit(pool, req, req->arg);
> 
>      qemu_mutex_lock(&pool->lock);
>      if (pool->idle_threads == 0 && pool->cur_threads < pool->max_threads) {
>          spawn_thread(pool);
>      }
>      QTAILQ_INSERT_TAIL(&pool->request_list, req, reqs);
>      qemu_mutex_unlock(&pool->lock);
>      qemu_cond_signal(&pool->request_cond);
> }
> 
> BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
>                                     BlockCompletionFunc *cb, void *opaque)
> {
>      ThreadPoolElement *req;
>      AioContext *ctx = qemu_get_current_aio_context();
>      ThreadPool *pool = aio_get_thread_pool(ctx);
> 
>      /* Assert that the thread submitting work is the same running the pool */
>      assert(pool->ctx == qemu_get_current_aio_context());
> 
>      req = qemu_aio_get(&thread_pool_aiocb_info, NULL, cb, opaque);
>      req->func = func;
>      req->arg = arg;
> 
>      thread_pool_submit_request(pool, req);
>      return &req->common;
> }
> 
> void thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func, void *arg)
> {
>      ThreadPoolElement *req;
> 
>      req = g_malloc(sizeof(ThreadPoolElement));
>      req->func = func;
>      req->arg = arg;
> 
>      thread_pool_submit_request(pool, req);
> }
> =================
> 
>>   
>>       /* Assert that the thread submitting work is the same running the pool */
>>       assert(pool->ctx == qemu_get_current_aio_context());
>> @@ -275,6 +292,18 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
>>       return &req->common;
>>   }
>>   
>> +BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
>> +                                   void *arg, GDestroyNotify arg_destroy,
>> +                                   BlockCompletionFunc *cb, void *opaque)
>> +{
>> +    return thread_pool_submit(NULL, func, arg, arg_destroy, cb, opaque);
>> +}
>> +
>> +void thread_pool_poll(ThreadPool *pool)
>> +{
>> +    aio_bh_poll(pool->ctx);
>> +}
>> +
>>   typedef struct ThreadPoolCo {
>>       Coroutine *co;
>>       int ret;
>> @@ -297,18 +326,38 @@ int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg)
>>       return tpc.ret;
>>   }
>>   
>> -void thread_pool_submit(ThreadPoolFunc *func,
>> -                        void *arg, GDestroyNotify arg_destroy)
>> +void thread_pool_join(ThreadPool *pool)
> 
> This is misleading because it's about the requests, not the threads in
> the pool. Compare with what thread_pool_free does:
> 
>      /* Wait for worker threads to terminate */
>      pool->max_threads = 0;
>      qemu_cond_broadcast(&pool->request_cond);
>      while (pool->cur_threads > 0) {
>          qemu_cond_wait(&pool->worker_stopped, &pool->lock);
>      }
> 

I'm open to thread_pool_join() better naming proposals.

Thanks,
Maciej



