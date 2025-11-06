Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED76ACCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 01:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGp00-0002YU-R0; Wed, 05 Nov 2025 20:41:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vGozx-0002Xu-Ca
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 20:41:13 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vGozr-0003uC-P8
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 20:41:13 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5A61er9K091623
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 6 Nov 2025 10:40:53 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=tLEMRfHmaIFRi+wwHZWk5NukHRRtFwFkRDnt3Dl/w9M=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762393253; v=1;
 b=uXYeJKG09thGM/pIi/bUJLHEnkUGbeDhr4q/gPdqXsG5l6VhxD60yGnnYeNse4RG
 6YF+A3kwq8lY1LEBFYiwXOxm944aPH1PviDPnmmmN/+WpSjIx4eAWP56BNKe2DKS
 1gc9PAYPPNb2pM1LSGEwfmwNI8atqEj1NNhS2Tz1IpTqLKppwspm0VihKKucoGS5
 XR8vjx3MnWRSMX8SAkuKU50TU8b0ay1xxIqclQk/zfdMjBJXFIdpsEgdhBBSMh6O
 acTFo/vpAR7M9PUo2/Jms4MiF/AF5ISTy6ynD7d5veg5i1w+bS+lJPfun5Xuom/D
 jeg4tEc40f1qbYKGG1MxCQ==
Message-ID: <b419584d-f1af-4c05-81a6-35f533e8ff37@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 6 Nov 2025 10:40:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] rcu: Wake the RCU thread when draining
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
 <20251029-force_rcu-v1-4-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
 <aQJbd5qYR10qcbr7@x1.local>
 <38c07d37-1b4d-42d2-ab41-fbe1c860dd3b@rsg.ci.i.u-tokyo.ac.jp>
 <aQu2_izqViAbJ3A9@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aQu2_izqViAbJ3A9@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/11/06 5:43, Peter Xu wrote:
> On Mon, Nov 03, 2025 at 06:45:30PM +0900, Akihiko Odaki wrote:
>> On 2025/10/30 3:22, Peter Xu wrote:
>>> On Wed, Oct 29, 2025 at 03:12:48PM +0900, Akihiko Odaki wrote:
>>>> drain_call_rcu() triggers the force quiescent state, but it can be
>>>> delayed if the RCU thread is sleeping. Ensure the force quiescent state
>>>> is immediately triggered by waking the RCU thread up.
>>>>
>>>> The logic to trigger the force quiescent state is decoupled as
>>>> force_rcu() so that it can be used independently.
>>>>
>>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>> ---
>>>>    include/qemu/rcu.h |   1 +
>>>>    util/rcu.c         | 106 ++++++++++++++++++++++++++++++++---------------------
>>>>    2 files changed, 65 insertions(+), 42 deletions(-)
>>>>
>>>> diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
>>>> index 020dbe4d8b77..d6aa4e5854d3 100644
>>>> --- a/include/qemu/rcu.h
>>>> +++ b/include/qemu/rcu.h
>>>> @@ -118,6 +118,7 @@ static inline void rcu_read_unlock(void)
>>>>        }
>>>>    }
>>>> +void force_rcu(void);
>>>>    void synchronize_rcu(void);
>>>>    /*
>>>> diff --git a/util/rcu.c b/util/rcu.c
>>>> index 3c4af9d213c8..85f9333f5dff 100644
>>>> --- a/util/rcu.c
>>>> +++ b/util/rcu.c
>>>> @@ -49,10 +49,13 @@
>>>>    unsigned long rcu_gp_ctr = RCU_GP_LOCKED;
>>>>    QemuEvent rcu_gp_event;
>>>> -static int in_drain_call_rcu;
>>>> +static bool forced;
>>>>    static int rcu_call_count;
>>>>    static QemuMutex rcu_registry_lock;
>>>> +/* Set when the forced variable is set or rcu_call_count becomes non-zero. */
>>>> +static QemuEvent sync_event;
>>>> +
>>>>    /*
>>>>     * Check whether a quiescent state was crossed between the beginning of
>>>>     * update_counter_and_wait and now.
>>>> @@ -74,36 +77,21 @@ QEMU_DEFINE_CO_TLS(struct rcu_reader_data, rcu_reader)
>>>>    typedef QLIST_HEAD(, rcu_reader_data) ThreadList;
>>>>    static ThreadList registry = QLIST_HEAD_INITIALIZER(registry);
>>>> +void force_rcu(void)
>>>> +{
>>>> +    qatomic_set(&forced, true);
>>>> +    qemu_event_set(&sync_event);
>>>> +}
>>>> +
>>>>    /* Wait for previous parity/grace period to be empty of readers.  */
>>>> -static void wait_for_readers(void)
>>>> +static void wait_for_readers(bool sleep)
>>>>    {
>>>>        ThreadList qsreaders = QLIST_HEAD_INITIALIZER(qsreaders);
>>>>        struct rcu_reader_data *index, *tmp;
>>>> -    int sleeps = 0;
>>>> -    bool forced = false;
>>>> +    int sleeps = sleep ? 5 : 0;
>>>> +    bool waiting = false;
>>>>        for (;;) {
>>>> -        /*
>>>> -         * Force the grace period to end and wait for it if any of the
>>>> -         * following heuristical conditions are satisfied:
>>>> -         * - A decent number of callbacks piled up.
>>>> -         * - It timed out.
>>>> -         * - It is in a drain_call_rcu() call.
>>>> -         *
>>>> -         * Otherwise, periodically poll the grace period, hoping it ends
>>>> -         * promptly.
>>>> -         */
>>>> -        if (!forced &&
>>>> -            (qatomic_read(&rcu_call_count) >= RCU_CALL_MIN_SIZE ||
>>>> -             sleeps >= 5 || qatomic_read(&in_drain_call_rcu))) {
>>>> -            forced = true;
>>>> -
>>>> -            QLIST_FOREACH(index, &registry, node) {
>>>> -                notifier_list_notify(&index->force_rcu, NULL);
>>>> -                qatomic_set(&index->waiting, true);
>>>> -            }
>>>> -        }
>>>
>>> IIUC this is the part to set index->waiting first whenever necessary, then
>>> that'll guarantee the wait(rcu_gp_event) will be notified in rcu unlock.
>>>
>>> Now we removed this chunk, then could it happen if waiting=true and the
>>> wait(rcu_gp_event) may wait for more than it should (as nobody will wake it
>>> up if all threads have waiting=false)?
>>
>> It is not removed, but it is moved along with the assignment of the waiting
>> variable. So index->waiting is still set whenever the waiting variable is
>> set and no hang up will happen.
> 
> Ah, I noticed the "waiting" is actually the global variable and I think
> when I read it last time I somehow misread it with "sleep" (which was
> passed down from the caller).

waiting is local. There are several variables and some are global and 
the others are local so please be careful.

> 
>          if (waiting) {  <--------------------
>              qemu_event_wait(&rcu_gp_event);
>              qemu_event_reset(&rcu_gp_event);
>          } else if (qatomic_read(&rcu_call_count) >= RCU_CALL_MIN_SIZE ||
> 
> Yeah, I think it's non-issue.  Please ignore my question.
> 
>>
>>>
>>> The other thing is, right below here there's the code and comment:
>>>
>>>           /* Here, order the stores to index->waiting before the loads of
>>>            * index->ctr.  Pairs with smp_mb_placeholder() in rcu_read_unlock(),
>>>            * ensuring that the loads of index->ctr are sequentially consistent.
>>>            *
>>>            * If this is the last iteration, this barrier also prevents
>>>            * frees from seeping upwards, and orders the two wait phases
>>>            * on architectures with 32-bit longs; see enter_qs().
>>>            */
>>>           smp_mb_global();
>>>
>>> IIUC it explains the mb_global() to order the updates of waiting and the
>>> reads of index->ctr.  It doesn't look like applicable anymore.  Said that,
>>> I think we should indeed still need some barrier to make sure we read
>>> index->ctr at least to be after we update global gp_ctr (done before
>>> calling wait_for_readers()).  I'm not sure if it means the mb is needed,
>>> however maybe at least the comment is outdated if so.
>>
>> It is still applicable. The stores to index->waiting is still present and
>> needs to be ordered before the loads of index->ctr.
>>
>>>
>>>> -
>>>>            /* Here, order the stores to index->waiting before the loads of
>>>>             * index->ctr.  Pairs with smp_mb_placeholder() in rcu_read_unlock(),
>>>>             * ensuring that the loads of index->ctr are sequentially consistent.
>>>> @@ -150,7 +138,8 @@ static void wait_for_readers(void)
>>>>             */
>>>>            qemu_mutex_unlock(&rcu_registry_lock);
>>>> -        if (forced) {
>>>> +        if (waiting) {
>>>> +            /* Wait for the forced quiescent state. */
>>>>                qemu_event_wait(&rcu_gp_event);
>>>>                /*
>>>> @@ -158,9 +147,25 @@ static void wait_for_readers(void)
>>>>                 * while we walk the list.
>>>>                 */
>>>>                qemu_event_reset(&rcu_gp_event);
>>>> +        } else if (qatomic_read(&rcu_call_count) >= RCU_CALL_MIN_SIZE ||
>>>> +                   !sleeps || qemu_event_timedwait(&sync_event, 10)) {
>>>> +            /*
>>>> +             * Now one of the following heuristical conditions is satisfied:
>>>> +             * - A decent number of callbacks piled up.
>>>> +             * - It timed out.
>>>> +             * - force_rcu() was called.
>>>> +             *
>>>> +             * Force a quiescent state.
>>>> +             */
>>>> +            waiting = true;
>>>> +
>>>> +            QLIST_FOREACH(index, &registry, node) {
>>>> +                notifier_list_notify(&index->force_rcu, NULL);
>>>> +                qatomic_set(&index->waiting, true);
>>>> +            }
>>>>            } else {
>>>> -            g_usleep(10000);
>>>> -            sleeps++;
>>>> +            /* Try again. */
>>>> +            sleeps--;
>>>>            }
>>>>            qemu_mutex_lock(&rcu_registry_lock);
>>>> @@ -170,7 +175,7 @@ static void wait_for_readers(void)
>>>>        QLIST_SWAP(&registry, &qsreaders, node);
>>>>    }
>>>> -static void enter_qs(void)
>>>> +static void enter_qs(bool sleep)
>>>>    {
>>>>        /* Write RCU-protected pointers before reading p_rcu_reader->ctr.
>>>>         * Pairs with smp_mb_placeholder() in rcu_read_lock().
>>>> @@ -189,14 +194,14 @@ static void enter_qs(void)
>>>>                 * Switch parity: 0 -> 1, 1 -> 0.
>>>>                 */
>>>>                qatomic_set(&rcu_gp_ctr, rcu_gp_ctr ^ RCU_GP_CTR);
>>>> -            wait_for_readers();
>>>> +            wait_for_readers(sleep);
>>>>                qatomic_set(&rcu_gp_ctr, rcu_gp_ctr ^ RCU_GP_CTR);
>>>>            } else {
>>>>                /* Increment current grace period.  */
>>>>                qatomic_set(&rcu_gp_ctr, rcu_gp_ctr + RCU_GP_CTR);
>>>>            }
>>>> -        wait_for_readers();
>>>> +        wait_for_readers(sleep);
>>>>        }
>>>>    }
>>>> @@ -205,7 +210,6 @@ static void enter_qs(void)
>>>>     */
>>>>    static struct rcu_head dummy;
>>>>    static struct rcu_head *head = &dummy, **tail = &dummy.next;
>>>> -static QemuEvent rcu_call_ready_event;
>>>>    static void enqueue(struct rcu_head *node)
>>>>    {
>>>> @@ -282,6 +286,7 @@ static void *call_rcu_thread(void *opaque)
>>>>        rcu_register_thread();
>>>>        for (;;) {
>>>> +        bool sleep = true;
>>>>            int n;
>>>>            /*
>>>> @@ -289,7 +294,7 @@ static void *call_rcu_thread(void *opaque)
>>>>             * added before enter_qs() starts.
>>>>             */
>>>>            for (;;) {
>>>> -            qemu_event_reset(&rcu_call_ready_event);
>>>> +            qemu_event_reset(&sync_event);
>>>>                n = qatomic_read(&rcu_call_count);
>>>>                if (n) {
>>>>                    break;
>>>> @@ -298,20 +303,36 @@ static void *call_rcu_thread(void *opaque)
>>>>    #if defined(CONFIG_MALLOC_TRIM)
>>>>                malloc_trim(4 * 1024 * 1024);
>>>>    #endif
>>>> -            qemu_event_wait(&rcu_call_ready_event);
>>>> +            qemu_event_wait(&sync_event);
>>>> +        }
>>>> +
>>>> +        /*
>>>> +         * Ensure that an event for a rcu_call_count change will not interrupt
>>>> +         * wait_for_readers().
>>>> +         */
>>>> +        qemu_event_reset(&sync_event);
>>>> +
>>>> +        /*
>>>> +         * Ensure that the forced variable has not been set after fetching
>>>> +         * rcu_call_count; otherwise we may get confused by a force quiescent
>>>> +         * state request for an element later than n.
>>>> +         */
>>>> +        while (qatomic_xchg(&forced, false)) {
>>>> +            sleep = false;
>>>> +            n = qatomic_read(&rcu_call_count);
>>>>            }
>>>
>>> This is pretty tricky, and I wonder if it will make the code easier to read
>>> if we convert the sync_event to be a semaphore instead.  When as a sem, it
>>> will take account of whatever kick to it, either a call_rcu1() or an
>>> enforced rcu flush, so that we don't need to reset it.  Meanwhile, we don't
>>> worry on an slightly outdated "n" read because the 2nd round of sem_wait()
>>> will catch that new "n".
>>>
>>> Instead, worst case is rcu thread runs one more round without seeing
>>> callbacks on the queue.
>>>
>>> I'm not sure if that could help simplying code, maybe also make it less
>>> error-prone.
>>
>> Semaphore is not applicable here because it will not de-duplicate concurrent
>> kicks of RCU threads.
> 
> Why concurrent kicks of rcu threads is a problem?  QemuSemaphore is
> thread-safe itself, meanwhile IIUC it only still causes call_rcu_thread()
> loops some more rounds reading "n", which looks all safe. No?

It is safe but incurs overheads and confusing. QemuEvent represents the 
boolean semantics better.

I also have difficulty to understand how converting sync_event to a 
semaphore simplifies the code. Perhaps some (pseudo)code to show how the 
code will look like may be useful.

> 
>>
>>>
>>>> -        enter_qs();
>>>> +        enter_qs(sleep);
>>>>            qatomic_sub(&rcu_call_count, n);
>>>>            bql_lock();
>>>>            while (n > 0) {
>>>>                node = try_dequeue();
>>>>                while (!node) {
>>>
>>> I have a pure question here not relevant to your changes.. do you know when
>>> this "if" will trigger?  It seems to me the enqueue() should always happen
>>> before the increment of rcu_call_count:
>>>
>>> void call_rcu1(struct rcu_head *node, void (*func)(struct rcu_head *node))
>>> {
>>>       node->func = func;
>>>       enqueue(node);
>>>
>>>       if (!qatomic_fetch_inc(&rcu_call_count)) {
>>>           qemu_event_set(&sync_event);
>>>       }
>>> }>
>>> I believe qatomic_fetch_inc() is RMW so it's strong mb and order
>>> guaranteed.  Then here why the node can be null even if we're sure >=n have
>>> been enqueued?
>>
>> Indeed, enqueue() always happens before the increment of rcu_call_count
>> performed by the same thread.
>>
>> The node can still be NULL when there are two concurrent call_rcu1()
>> executions. In the following example, rcu_call_count will be greater than
>> the number of visible nodes after (A) and before (B):
>>
>> Thread T                 Thread U
>> call_rcu1(O)
>>   enqueue(O)
>>    Load N from tail
>>    tail = O->next
>>                           call_rcu1(P)
>>                            enqueue(P)
>>                             Load O->next from tail
>>                             tail = P
>>                             O->next = P
>>                            rcu_call_count++ (A)
>>    N->next = O (B)
>>    rcu_call_count++
> 
> Thanks, yeah it makes sense.  If you think worthwhile, maybe we could add a
> comment after the first try_dequeue().
> 

try_dequeue() and enqueue() do have comments that say that enqueue() is 
asynchronous and explain why, but perhaps they can be expanded by adding 
the example I showed.

Besides enqueue() may be renamed like enqueue_async() so that it will be 
clear that enqueuing does not happen immediately when you look at 
call_rcu1(). If you wonder enqueue_async() is asynchronous, you will 
look into enqueue_async() and find the explanatory comments.

Regards,
Akihiko Odaki

