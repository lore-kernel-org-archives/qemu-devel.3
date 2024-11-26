Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D185D65559
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 21:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG30g-0005It-Nc; Tue, 26 Nov 2024 16:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tG30f-0005Ik-Kg
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:22:13 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tG30d-0002s3-SP
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 16:22:13 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tG30a-00000002pmg-000J; Tue, 26 Nov 2024 22:22:08 +0100
Message-ID: <d20ed0f2-2ea6-4737-b203-dee696e3c8d6@maciej.szmigiero.name>
Date: Tue, 26 Nov 2024 22:22:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/24] thread-pool: Implement generic (non-AIO) pool
 support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <babda1bbe43024baaa4a9ac855f7930b6679f2b7.1731773021.git.maciej.szmigiero@oracle.com>
 <455d1074-28b7-4b0b-9c67-6f6425cbf384@redhat.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <455d1074-28b7-4b0b-9c67-6f6425cbf384@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 26.11.2024 20:29, Cédric Le Goater wrote:
> On 11/17/24 20:19, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Migration code wants to manage device data sending threads in one place.
>>
>> QEMU has an existing thread pool implementation, however it is limited
>> to queuing AIO operations only and essentially has a 1:1 mapping between
>> the current AioContext and the AIO ThreadPool in use.
>>
>> Implement generic (non-AIO) ThreadPool by essentially wrapping Glib's
>> GThreadPool.
>>
>> This brings a few new operations on a pool:
>> * thread_pool_wait() operation waits until all the submitted work requests
>> have finished.
>>
>> * thread_pool_set_max_threads() explicitly sets the maximum thread count
>> in the pool.
>>
>> * thread_pool_adjust_max_threads_to_work() adjusts the maximum thread count
>> in the pool to equal the number of still waiting in queue or unfinished work.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   include/block/thread-pool.h |   9 +++
>>   util/thread-pool.c          | 109 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 118 insertions(+)
>>
>> diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
>> index 6f27eb085b45..3f9f66307b65 100644
>> --- a/include/block/thread-pool.h
>> +++ b/include/block/thread-pool.h
>> @@ -38,5 +38,14 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
>>   int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg);
>>   void thread_pool_update_params(ThreadPoolAio *pool, struct AioContext *ctx);
>> +typedef struct ThreadPool ThreadPool;
>> +
>> +ThreadPool *thread_pool_new(void);
>> +void thread_pool_free(ThreadPool *pool);
>> +void thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
>> +                        void *opaque, GDestroyNotify opaque_destroy);
>> +void thread_pool_wait(ThreadPool *pool);
>> +bool thread_pool_set_max_threads(ThreadPool *pool, int max_threads);
>> +bool thread_pool_adjust_max_threads_to_work(ThreadPool *pool);
> 
> We should add documentation for these routines.

Ack.

>>   #endif
>> diff --git a/util/thread-pool.c b/util/thread-pool.c
>> index 908194dc070f..d80c4181c897 100644
>> --- a/util/thread-pool.c
>> +++ b/util/thread-pool.c
>> @@ -374,3 +374,112 @@ void thread_pool_free_aio(ThreadPoolAio *pool)
>>       qemu_mutex_destroy(&pool->lock);
>>       g_free(pool);
>>   }
>> +
>> +struct ThreadPool { /* type safety */
>> +    GThreadPool *t;
>> +    size_t unfinished_el_ctr;
>> +    QemuMutex unfinished_el_ctr_mutex;
>> +    QemuCond unfinished_el_ctr_zero_cond;
>> +};
> 
> 
> I find the naming of the attributes a little confusing. Could we
> use names similar to ThreadPoolAio. Something like :
> 
> struct ThreadPool { /* type safety */
>      GThreadPool *t;
>      int cur_threads;

"cur_work" would probably be more accurate since the code that
decrements this counter is still running inside a worker thread
so by the time this reaches zero technically there are still
threads running.

>      QemuMutex lock;

This lock only protects the counter above, not the rest of the
structure so I guess "cur_work_lock" would be more accurate.

>      QemuCond finished_cond;

I would go for "all_finished_cond", since it's only signaled once
all of the work is finished (the counter above reaches zero).

> };
> 
> 
> 
>> +
>> +typedef struct {
>> +    ThreadPoolFunc *func;
>> +    void *opaque;
>> +    GDestroyNotify opaque_destroy;
>> +} ThreadPoolElement;
>> +
>> +static void thread_pool_func(gpointer data, gpointer user_data)
>> +{
>> +    ThreadPool *pool = user_data;
>> +    g_autofree ThreadPoolElement *el = data;
>> +
>> +    el->func(el->opaque);
>> +
>> +    if (el->opaque_destroy) {
>> +        el->opaque_destroy(el->opaque);
>> +    }
>> +
>> +    QEMU_LOCK_GUARD(&pool->unfinished_el_ctr_mutex);
>> +
>> +    assert(pool->unfinished_el_ctr > 0);
>> +    pool->unfinished_el_ctr--;
>> +
>> +    if (pool->unfinished_el_ctr == 0) {
>> +        qemu_cond_signal(&pool->unfinished_el_ctr_zero_cond);
>> +    }
>> +}
>> +
>> +ThreadPool *thread_pool_new(void)
>> +{
>> +    ThreadPool *pool = g_new(ThreadPool, 1);
>> +
>> +    pool->unfinished_el_ctr = 0;
>> +    qemu_mutex_init(&pool->unfinished_el_ctr_mutex);
>> +    qemu_cond_init(&pool->unfinished_el_ctr_zero_cond);
>> +
>> +    pool->t = g_thread_pool_new(thread_pool_func, pool, 0, TRUE, NULL);
>> +    /*
>> +     * g_thread_pool_new() can only return errors if initial thread(s)
>> +     * creation fails but we ask for 0 initial threads above.
>> +     */
>> +    assert(pool->t);
>> +
>> +    return pool;
>> +}
>> +
>> +void thread_pool_free(ThreadPool *pool)
>> +{
>> +    g_thread_pool_free(pool->t, FALSE, TRUE);
>> +
>> +    qemu_cond_destroy(&pool->unfinished_el_ctr_zero_cond);
>> +    qemu_mutex_destroy(&pool->unfinished_el_ctr_mutex);
>> +
>> +    g_free(pool);
>> +}
>> +
>> +void thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
>> +                        void *opaque, GDestroyNotify opaque_destroy)
>> +{
>> +    ThreadPoolElement *el = g_new(ThreadPoolElement, 1);
> 
> Where are the ThreadPool elements freed ? I am missing something
> may be.

At the entry to thread_pool_func(), the initialization of
automatic storage duration variable "ThreadPoolElement *el" takes
ownership of this object (RAII) and frees it when this variable
goes out of scope (that is, when this function exits) since it is
marked as a g_autofree.

> Thanks,
> 
> C.

Thanks,
Maciej


