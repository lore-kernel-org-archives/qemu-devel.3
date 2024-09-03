Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DC1CD343A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slUU9-0000Ea-WD; Tue, 03 Sep 2024 10:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slUU8-00007j-IO
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:26:20 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slUU6-0002YO-3T
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:26:20 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D33981F391;
 Tue,  3 Sep 2024 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725373575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T8UNFj+CwAa4sAFRTPiA5kW+jmTK8dKiEO5tev1aMjc=;
 b=UfkQqNche51f2aqP4xX3jqstUKXyCKu1aoOfQtjc8t2SdH05Lkhvt+Tt56rdmXntluUQGm
 wabEEqyGUxyf0z+/7Ge774P0Y6+uqYVWFpC8PCE6ZMQyiYp2NysJmp12724jDpFR+DAHSS
 MYzxMBb8KifmJ7CS8+bWxUG6e5/sm8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725373575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T8UNFj+CwAa4sAFRTPiA5kW+jmTK8dKiEO5tev1aMjc=;
 b=j6wuTZUuveMK+8fxp6GFzuHbMmT0rWFIHNYpPbsB9RGfajItcyOFTrZ50rfd3b9lplZ+o9
 RUZTArA/qLVsjiAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iVBWU4B+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qkGS26ft
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725373574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T8UNFj+CwAa4sAFRTPiA5kW+jmTK8dKiEO5tev1aMjc=;
 b=iVBWU4B+Nc0NR49COhKYpi1rlwLbOYROf3kOUdP6+pmAdtlXOzsSq9y61gJx7YIYwGfbdS
 1y757IkwNNe3gXoptPNitkrJ54kTPMU6l5rZTYhiC/C0lhyqOzw5XGKcIXtsuvSbOMBOu5
 zlhhOGLvNjHxwf6+Vqh9qYXAhVi3HUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725373574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T8UNFj+CwAa4sAFRTPiA5kW+jmTK8dKiEO5tev1aMjc=;
 b=qkGS26ft+aBRodCKp+lxR40azL2illR9SlpmPkebOhQL95c19SatFNhKUr3j3Thlw5t3US
 GynFPLszIaKVtFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 532BD13A80;
 Tue,  3 Sep 2024 14:26:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YMPQBoYc12Y+WgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Sep 2024 14:26:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Dan?=
 =?utf-8?Q?iel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>, Joao
 Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org, Stefan
 Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 05/17] thread-pool: Implement non-AIO (generic) pool
 support
In-Reply-To: <c30e02cf-34df-4d60-b940-5f55316c0a6d@maciej.szmigiero.name>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <54947c3a1df713f5b69d8296938f3da41116ffe0.1724701542.git.maciej.szmigiero@oracle.com>
 <87o755n20j.fsf@suse.de>
 <c30e02cf-34df-4d60-b940-5f55316c0a6d@maciej.szmigiero.name>
Date: Tue, 03 Sep 2024 11:26:11 -0300
Message-ID: <87ikvcn798.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: D33981F391
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> On 3.09.2024 00:07, Fabiano Rosas wrote:
>> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
>> 
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> Migration code wants to manage device data sending threads in one place.
>>>
>>> QEMU has an existing thread pool implementation, however it was limited
>>> to queuing AIO operations only and essentially had a 1:1 mapping between
>>> the current AioContext and the ThreadPool in use.
>>>
>>> Implement what is necessary to queue generic (non-AIO) work on a ThreadPool
>>> too.
>>>
>>> This brings a few new operations on a pool:
>>> * thread_pool_set_minmax_threads() explicitly sets the minimum and maximum
>>> thread count in the pool.
>>>
>>> * thread_pool_join() operation waits until all the submitted work requests
>>> have finished.
>>>
>>> * thread_pool_poll() lets the new thread and / or thread completion bottom
>>> halves run (if they are indeed scheduled to be run).
>>> It is useful for thread pool users that need to launch or terminate new
>>> threads without returning to the QEMU main loop.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   include/block/thread-pool.h   | 10 ++++-
>>>   tests/unit/test-thread-pool.c |  2 +-
>>>   util/thread-pool.c            | 77 ++++++++++++++++++++++++++++++-----
>>>   3 files changed, 76 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
>>> index b484c4780ea6..1769496056cd 100644
>>> --- a/include/block/thread-pool.h
>>> +++ b/include/block/thread-pool.h
>>> @@ -37,9 +37,15 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
>>>                                      void *arg, GDestroyNotify arg_destroy,
>>>                                      BlockCompletionFunc *cb, void *opaque);
>>>   int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg);
>>> -void thread_pool_submit(ThreadPoolFunc *func,
>>> -                        void *arg, GDestroyNotify arg_destroy);
>>> +BlockAIOCB *thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
>>> +                               void *arg, GDestroyNotify arg_destroy,
>>> +                               BlockCompletionFunc *cb, void *opaque);
>> 
>> These kinds of changes (create wrappers, change signatures, etc), could
>> be in their own patch as it's just code motion that should not have
>> functional impact. The "no_requests" stuff would be better discussed in
>> a separate patch.
>
> These changes *all* should have no functional impact on existing callers.
>
> But I get your overall point, will try to separate these really trivial
> parts.

Yeah, I guess I meant that one set of changes has a larger potential for
introducing a bug while the other is clearly harmless.

>
>>>   
>>> +void thread_pool_join(ThreadPool *pool);
>>> +void thread_pool_poll(ThreadPool *pool);
>>> +
>>> +void thread_pool_set_minmax_threads(ThreadPool *pool,
>>> +                                    int min_threads, int max_threads);
>>>   void thread_pool_update_params(ThreadPool *pool, struct AioContext *ctx);
>>>   
>>>   #endif
>>> diff --git a/tests/unit/test-thread-pool.c b/tests/unit/test-thread-pool.c
>>> index e4afb9e36292..469c0f7057b6 100644
>>> --- a/tests/unit/test-thread-pool.c
>>> +++ b/tests/unit/test-thread-pool.c
>>> @@ -46,7 +46,7 @@ static void done_cb(void *opaque, int ret)
>>>   static void test_submit(void)
>>>   {
>>>       WorkerTestData data = { .n = 0 };
>>> -    thread_pool_submit(worker_cb, &data, NULL);
>>> +    thread_pool_submit(NULL, worker_cb, &data, NULL, NULL, NULL);
>>>       while (data.n == 0) {
>>>           aio_poll(ctx, true);
>>>       }
>>> diff --git a/util/thread-pool.c b/util/thread-pool.c
>>> index 69a87ee79252..2bf3be875a51 100644
>>> --- a/util/thread-pool.c
>>> +++ b/util/thread-pool.c
>>> @@ -60,6 +60,7 @@ struct ThreadPool {
>>>       QemuMutex lock;
>>>       QemuCond worker_stopped;
>>>       QemuCond request_cond;
>>> +    QemuCond no_requests_cond;
>>>       QEMUBH *new_thread_bh;
>>>   
>>>       /* The following variables are only accessed from one AioContext. */
>>> @@ -73,6 +74,7 @@ struct ThreadPool {
>>>       int pending_threads; /* threads created but not running yet */
>>>       int min_threads;
>>>       int max_threads;
>>> +    size_t requests_executing;
>> 
>> What's with size_t? Should this be a uint32_t instead?
>
> Sizes of objects are normally size_t, since otherwise bad
> things happen if objects are bigger than 4 GiB.

Ok, but requests_executing is not the size of an object. It's the number
of objects in a linked list that satisfy a certain predicate. There are
no address space size considerations here.

>
> Considering that the minimum object size is 1 byte the
> max count of distinct objects also needs a size_t to not
> risk an overflow.

I'm not sure I get you, there's no overflow since you're bounds checking
with the assert. Or is this a more abstract line of thought about how
many ThreadPoolElements can be present in memory at a time and you'd
like a type that's certain to fit the theoretical amount of objects?

>
> I think that while 2^32 requests executing seems unlikely
> saving 4 bytes seems not worth worrying that someone will
> find a vulnerability triggered by overflowing a 32-bit
> variable (not necessary in the migration code but in some
> other thread pool user).
>
>>>   };
>>>   
>>>   static void *worker_thread(void *opaque)
>>> @@ -107,6 +109,10 @@ static void *worker_thread(void *opaque)
>>>           req = QTAILQ_FIRST(&pool->request_list);
>>>           QTAILQ_REMOVE(&pool->request_list, req, reqs);
>>>           req->state = THREAD_ACTIVE;
>>> +
>>> +        assert(pool->requests_executing < SIZE_MAX);
>>> +        pool->requests_executing++;
>>> +
>>>           qemu_mutex_unlock(&pool->lock);
>>>   
>>>           ret = req->func(req->arg);
>>> @@ -118,6 +124,14 @@ static void *worker_thread(void *opaque)
>>>   
>>>           qemu_bh_schedule(pool->completion_bh);
>>>           qemu_mutex_lock(&pool->lock);
>>> +
>>> +        assert(pool->requests_executing > 0);
>>> +        pool->requests_executing--;
>>> +
>>> +        if (pool->requests_executing == 0 &&
>>> +            QTAILQ_EMPTY(&pool->request_list)) {
>>> +            qemu_cond_signal(&pool->no_requests_cond);
>>> +        }
>> 
>> An empty requests list and no request in flight means the worker will
>> now exit after the timeout, no? Can you just kick the worker out of the
>> wait and use pool->worker_stopped instead of the new condition variable?
>
> First, all threads won't terminate if either min_threads or max_threads
> isn't 0.

Ah I overlooked the break condition, nevermind.

> It might be in the migration thread pool case but we are adding a
> generic thread pool so it should be as universal as possible.
> thread_pool_free() can get away with overwriting these values since
> it is destroying the pool anyway.
>
> Also, the *_join() (or whatever its final name will be) operation is
> about waiting for all requests / work items to finish, not about waiting
> for threads to terminate.

Right, but the idea was to piggyback on the thread termination to infer
(the obvious) requests service termination. We cannot do that, as you've
explained, fine.

> It's essentially a synchronization point for a thread pool, not a cleanup.
>
>>>       }
>>>   
>>>       pool->cur_threads--;
>>> @@ -243,13 +257,16 @@ static const AIOCBInfo thread_pool_aiocb_info = {
>>>       .cancel_async       = thread_pool_cancel,
>>>   };
>>>   
>>> -BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
>>> -                                   void *arg, GDestroyNotify arg_destroy,
>>> -                                   BlockCompletionFunc *cb, void *opaque)
>>> +BlockAIOCB *thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
>>> +                               void *arg, GDestroyNotify arg_destroy,
>>> +                               BlockCompletionFunc *cb, void *opaque)
>>>   {
>>>       ThreadPoolElement *req;
>>>       AioContext *ctx = qemu_get_current_aio_context();
>>> -    ThreadPool *pool = aio_get_thread_pool(ctx);
>>> +
>>> +    if (!pool) {
>>> +        pool = aio_get_thread_pool(ctx);
>>> +    }
>> 
>> I'd go for a separate implementation to really drive the point that this
>> new usage is different. See the code snippet below.
>
> I see your point there - will split these implementations.
>
>> It seems we're a short step away to being able to use this
>> implementation in a general way. Is there something that can be done
>> with the 'common' field in the ThreadPoolElement?
>
> The non-AIO request flow still need the completion callback from BlockAIOCB
> (and its argument pointer) so removing the "common" field from these requests
> would need introducing two "flavors" of ThreadPoolElement.
>
> Not sure memory saving here are worth the increase in code complexity.

I'm not asking that of you, but I think it should be done
eventually. The QEMU block layer is very particular and I wouldn't want
the use-cases for the thread-pool to get confused. But I can't see a way
out right now, so let's postpone this, see if anyone else has comments.

>
>> ========
>> static void thread_pool_submit_request(ThreadPool *pool, ThreadPoolElement *req)
>> {
>>      req->state = THREAD_QUEUED;
>>      req->pool = pool;
>> 
>>      QLIST_INSERT_HEAD(&pool->head, req, all);
>> 
>>      trace_thread_pool_submit(pool, req, req->arg);
>> 
>>      qemu_mutex_lock(&pool->lock);
>>      if (pool->idle_threads == 0 && pool->cur_threads < pool->max_threads) {
>>          spawn_thread(pool);
>>      }
>>      QTAILQ_INSERT_TAIL(&pool->request_list, req, reqs);
>>      qemu_mutex_unlock(&pool->lock);
>>      qemu_cond_signal(&pool->request_cond);
>> }
>> 
>> BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
>>                                     BlockCompletionFunc *cb, void *opaque)
>> {
>>      ThreadPoolElement *req;
>>      AioContext *ctx = qemu_get_current_aio_context();
>>      ThreadPool *pool = aio_get_thread_pool(ctx);
>> 
>>      /* Assert that the thread submitting work is the same running the pool */
>>      assert(pool->ctx == qemu_get_current_aio_context());
>> 
>>      req = qemu_aio_get(&thread_pool_aiocb_info, NULL, cb, opaque);
>>      req->func = func;
>>      req->arg = arg;
>> 
>>      thread_pool_submit_request(pool, req);
>>      return &req->common;
>> }
>> 
>> void thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func, void *arg)
>> {
>>      ThreadPoolElement *req;
>> 
>>      req = g_malloc(sizeof(ThreadPoolElement));
>>      req->func = func;
>>      req->arg = arg;
>> 
>>      thread_pool_submit_request(pool, req);
>> }
>> =================
>> 
>>>   
>>>       /* Assert that the thread submitting work is the same running the pool */
>>>       assert(pool->ctx == qemu_get_current_aio_context());
>>> @@ -275,6 +292,18 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
>>>       return &req->common;
>>>   }
>>>   
>>> +BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func,
>>> +                                   void *arg, GDestroyNotify arg_destroy,
>>> +                                   BlockCompletionFunc *cb, void *opaque)
>>> +{
>>> +    return thread_pool_submit(NULL, func, arg, arg_destroy, cb, opaque);
>>> +}
>>> +
>>> +void thread_pool_poll(ThreadPool *pool)
>>> +{
>>> +    aio_bh_poll(pool->ctx);
>>> +}
>>> +
>>>   typedef struct ThreadPoolCo {
>>>       Coroutine *co;
>>>       int ret;
>>> @@ -297,18 +326,38 @@ int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg)
>>>       return tpc.ret;
>>>   }
>>>   
>>> -void thread_pool_submit(ThreadPoolFunc *func,
>>> -                        void *arg, GDestroyNotify arg_destroy)
>>> +void thread_pool_join(ThreadPool *pool)
>> 
>> This is misleading because it's about the requests, not the threads in
>> the pool. Compare with what thread_pool_free does:
>> 
>>      /* Wait for worker threads to terminate */
>>      pool->max_threads = 0;
>>      qemu_cond_broadcast(&pool->request_cond);
>>      while (pool->cur_threads > 0) {
>>          qemu_cond_wait(&pool->worker_stopped, &pool->lock);
>>      }
>> 
>
> I'm open to thread_pool_join() better naming proposals.

thread_pool_wait() might be better.

>
> Thanks,
> Maciej

