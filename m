Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053BDD59D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFg3j-00058E-Rs; Mon, 25 Nov 2024 15:51:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tFg3h-00053c-4f
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 15:51:49 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tFg3f-0004rU-8l
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 15:51:48 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 42ECD21184;
 Mon, 25 Nov 2024 20:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732567905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hid5PQ2NamKSCghruMP/VYIZ3qSCKRZI6ucAcCB8cP0=;
 b=N2r8e1NZr0+W7nH9vQTpEVzM+jqxd2G59NNCzdHIJCCL97jJkEXCS20j+932vc4Irv1YPs
 kru5oFp+iYcAxxncKAmEu8RdVXxTn9ZTPFK0FFuJzOmxMKbGNkAi8QYAdzfBSmtjiSyuSb
 dRvyawl9XB5F9NB7ZTyc9S3uQ43xHOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732567905;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hid5PQ2NamKSCghruMP/VYIZ3qSCKRZI6ucAcCB8cP0=;
 b=kHltQUO9o5aQtkRzE+0Umwyr1amIgQAF9csIKJqZ0u+DzLEBvRlFRZTKY2E1i23wKqvc0w
 TNGV2hUDnjpWgjCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732567905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hid5PQ2NamKSCghruMP/VYIZ3qSCKRZI6ucAcCB8cP0=;
 b=N2r8e1NZr0+W7nH9vQTpEVzM+jqxd2G59NNCzdHIJCCL97jJkEXCS20j+932vc4Irv1YPs
 kru5oFp+iYcAxxncKAmEu8RdVXxTn9ZTPFK0FFuJzOmxMKbGNkAi8QYAdzfBSmtjiSyuSb
 dRvyawl9XB5F9NB7ZTyc9S3uQ43xHOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732567905;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hid5PQ2NamKSCghruMP/VYIZ3qSCKRZI6ucAcCB8cP0=;
 b=kHltQUO9o5aQtkRzE+0Umwyr1amIgQAF9csIKJqZ0u+DzLEBvRlFRZTKY2E1i23wKqvc0w
 TNGV2hUDnjpWgjCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B67CA137D4;
 Mon, 25 Nov 2024 20:51:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tss7HmDjRGeFPwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 25 Nov 2024 20:51:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3 04/24] thread-pool: Implement generic (non-AIO) pool
 support
In-Reply-To: <7efee58f-90be-44a5-92b0-7b792e1ab906@maciej.szmigiero.name>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <babda1bbe43024baaa4a9ac855f7930b6679f2b7.1731773021.git.maciej.szmigiero@oracle.com>
 <87ldx7nlsj.fsf@suse.de>
 <7efee58f-90be-44a5-92b0-7b792e1ab906@maciej.szmigiero.name>
Date: Mon, 25 Nov 2024 17:51:42 -0300
Message-ID: <87a5dnnijl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On 25.11.2024 20:41, Fabiano Rosas wrote:
>> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
>> 
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> Migration code wants to manage device data sending threads in one place.
>>>
>>> QEMU has an existing thread pool implementation, however it is limited
>>> to queuing AIO operations only and essentially has a 1:1 mapping between
>>> the current AioContext and the AIO ThreadPool in use.
>>>
>>> Implement generic (non-AIO) ThreadPool by essentially wrapping Glib's
>>> GThreadPool.
>>>
>>> This brings a few new operations on a pool:
>>> * thread_pool_wait() operation waits until all the submitted work requests
>>> have finished.
>>>
>>> * thread_pool_set_max_threads() explicitly sets the maximum thread count
>>> in the pool.
>>>
>>> * thread_pool_adjust_max_threads_to_work() adjusts the maximum thread count
>>> in the pool to equal the number of still waiting in queue or unfinished work.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   include/block/thread-pool.h |   9 +++
>>>   util/thread-pool.c          | 109 ++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 118 insertions(+)
>>>
>>> diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
>>> index 6f27eb085b45..3f9f66307b65 100644
>>> --- a/include/block/thread-pool.h
>>> +++ b/include/block/thread-pool.h
>>> @@ -38,5 +38,14 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
>>>   int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg);
>>>   void thread_pool_update_params(ThreadPoolAio *pool, struct AioContext *ctx);
>>>   
>>> +typedef struct ThreadPool ThreadPool;
>>> +
>>> +ThreadPool *thread_pool_new(void);
>>> +void thread_pool_free(ThreadPool *pool);
>>> +void thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
>>> +                        void *opaque, GDestroyNotify opaque_destroy);
>>> +void thread_pool_wait(ThreadPool *pool);
>>> +bool thread_pool_set_max_threads(ThreadPool *pool, int max_threads);
>>> +bool thread_pool_adjust_max_threads_to_work(ThreadPool *pool);
>>>   
>>>   #endif
>>> diff --git a/util/thread-pool.c b/util/thread-pool.c
>>> index 908194dc070f..d80c4181c897 100644
>>> --- a/util/thread-pool.c
>>> +++ b/util/thread-pool.c
>>> @@ -374,3 +374,112 @@ void thread_pool_free_aio(ThreadPoolAio *pool)
>>>       qemu_mutex_destroy(&pool->lock);
>>>       g_free(pool);
>>>   }
>>> +
>>> +struct ThreadPool { /* type safety */
>>> +    GThreadPool *t;
>>> +    size_t unfinished_el_ctr;
>>> +    QemuMutex unfinished_el_ctr_mutex;
>>> +    QemuCond unfinished_el_ctr_zero_cond;
>>> +};
>>> +
>>> +typedef struct {
>>> +    ThreadPoolFunc *func;
>>> +    void *opaque;
>>> +    GDestroyNotify opaque_destroy;
>>> +} ThreadPoolElement;
>>> +
>>> +static void thread_pool_func(gpointer data, gpointer user_data)
>>> +{
>>> +    ThreadPool *pool = user_data;
>>> +    g_autofree ThreadPoolElement *el = data;
>>> +
>>> +    el->func(el->opaque);
>>> +
>>> +    if (el->opaque_destroy) {
>>> +        el->opaque_destroy(el->opaque);
>>> +    }
>>> +
>>> +    QEMU_LOCK_GUARD(&pool->unfinished_el_ctr_mutex);
>>> +
>>> +    assert(pool->unfinished_el_ctr > 0);
>>> +    pool->unfinished_el_ctr--;
>>> +
>>> +    if (pool->unfinished_el_ctr == 0) {
>>> +        qemu_cond_signal(&pool->unfinished_el_ctr_zero_cond);
>>> +    }
>>> +}
>>> +
>>> +ThreadPool *thread_pool_new(void)
>>> +{
>>> +    ThreadPool *pool = g_new(ThreadPool, 1);
>>> +
>>> +    pool->unfinished_el_ctr = 0;
>>> +    qemu_mutex_init(&pool->unfinished_el_ctr_mutex);
>>> +    qemu_cond_init(&pool->unfinished_el_ctr_zero_cond);
>>> +
>>> +    pool->t = g_thread_pool_new(thread_pool_func, pool, 0, TRUE, NULL);
>>> +    /*
>>> +     * g_thread_pool_new() can only return errors if initial thread(s)
>>> +     * creation fails but we ask for 0 initial threads above.
>>> +     */
>>> +    assert(pool->t);
>>> +
>>> +    return pool;
>>> +}
>>> +
>>> +void thread_pool_free(ThreadPool *pool)
>>> +{
>>> +    g_thread_pool_free(pool->t, FALSE, TRUE);
>> 
>> Should we make it an error to call thread_poll_free without first
>> calling thread_poll_wait? I worry the current usage will lead to having
>> two different ways of waiting with one of them (this one) being quite
>> implicit.
>> 
>
> thread_pool_wait() can be used as a barrier between two sets of
> tasks executed on a thread pool without destroying it or in a performance
> sensitive path where we want to just wait for task completion while
> deferring the free operation for later, less sensitive time.
>
> I don't think requiring explicit thread_pool_wait() before
> thread_pool_free() actually gives any advantage, while at the same
> time it's making this API usage slightly more complex in cases
> where the consumer is fine with having combined wait+free semantics
> for thread_pool_free().

Fair enough,

Reviewed-by: Fabiano Rosas <farosas@suse.de>

