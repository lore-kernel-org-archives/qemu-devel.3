Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5E4CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 01:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHY3B-0006hc-VK; Fri, 07 Nov 2025 20:47:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vHY39-0006h7-SQ
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 20:47:31 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vHY36-00037s-3Q
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 20:47:31 -0500
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5A81lGKO048456
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 8 Nov 2025 10:47:16 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=WrfuSnAtzLINx19NOjcE7a6JPV4ekkDUQxKcgIx647g=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762566436; v=1;
 b=Gl7ViWe+/VukLklz5l9cEuamqbse3UPlQXUhRZzM+/vkAHPvnpGf3RKyKJUTJwJb
 Qmpxa1X3eVZy77YPP9AjvzJKuzM0KsB5g3ijtWDrGgDBLQg4BU+ouCpxvoqsaL1p
 n6lxFB5xHzKvNPYiWX+srqTQW2YZCpdBLWQNFHMR7UNJRv6lM3oSxvyxFcXxjybg
 48hx42K3HueYJdUZNrlWc2vn+x4P4yqTR51auG3IfkwgOQWskJ1c6y7iedKnkvd7
 uJQX98K/kzH2xekSgnAKdlvBnVFigs//NtQYNJJHTr7xEgRrXJCQK5/ivhTFnUmZ
 WKKhML4p3IERgMURGi34bA==
Message-ID: <5002e5b4-0493-4dff-af11-402cebecbcc2@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 8 Nov 2025 10:47:16 +0900
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
 <b419584d-f1af-4c05-81a6-35f533e8ff37@rsg.ci.i.u-tokyo.ac.jp>
 <aQ0Ys09WtlSPoapm@x1.local>
 <5279f15f-bf46-438e-9c1f-0873b08b59e7@rsg.ci.i.u-tokyo.ac.jp>
 <aQ37hd0fVJltYtt-@x1.local>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aQ37hd0fVJltYtt-@x1.local>
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

On 2025/11/07 23:00, Peter Xu wrote:
> On Fri, Nov 07, 2025 at 10:47:35AM +0900, Akihiko Odaki wrote:
>> On 2025/11/07 6:52, Peter Xu wrote:
>>> On Thu, Nov 06, 2025 at 10:40:52AM +0900, Akihiko Odaki wrote:
>>>>>>>> +        /*
>>>>>>>> +         * Ensure that the forced variable has not been set after fetching
>>>>>>>> +         * rcu_call_count; otherwise we may get confused by a force quiescent
>>>>>>>> +         * state request for an element later than n.
>>>>>>>> +         */
>>>>>>>> +        while (qatomic_xchg(&forced, false)) {
>>>>>>>> +            sleep = false;
>>>>>>>> +            n = qatomic_read(&rcu_call_count);
>>>>>>>>              }
>>>>>>>
>>>>>>> This is pretty tricky, and I wonder if it will make the code easier to read
>>>>>>> if we convert the sync_event to be a semaphore instead.  When as a sem, it
>>>>>>> will take account of whatever kick to it, either a call_rcu1() or an
>>>>>>> enforced rcu flush, so that we don't need to reset it.  Meanwhile, we don't
>>>>>>> worry on an slightly outdated "n" read because the 2nd round of sem_wait()
>>>>>>> will catch that new "n".
>>>>>>>
>>>>>>> Instead, worst case is rcu thread runs one more round without seeing
>>>>>>> callbacks on the queue.
>>>>>>>
>>>>>>> I'm not sure if that could help simplying code, maybe also make it less
>>>>>>> error-prone.
>>>>>>
>>>>>> Semaphore is not applicable here because it will not de-duplicate concurrent
>>>>>> kicks of RCU threads.
>>>>>
>>>>> Why concurrent kicks of rcu threads is a problem?  QemuSemaphore is
>>>>> thread-safe itself, meanwhile IIUC it only still causes call_rcu_thread()
>>>>> loops some more rounds reading "n", which looks all safe. No?
>>>>
>>>> It is safe but incurs overheads and confusing. QemuEvent represents the
>>>> boolean semantics better.
>>>>
>>>> I also have difficulty to understand how converting sync_event to a
>>>> semaphore simplifies the code. Perhaps some (pseudo)code to show how the
>>>> code will look like may be useful.
>>>
>>> I prepared a patch on top of your current patchset to show what I meant.  I
>>> also added comments and some test results showing why I think it might be
>>> fine that the sem overhead should be small.
>>>
>>> In short, I tested a VM with 8 vCPUs and 4G mem, booting Linux and properly
>>> poweroff, I only saw <1000 rcu_call1 users in total.  That should be the
>>> max-bound of sem overhead on looping in rcu thread.
>>>
>>> It's in patch format but still treat it as a comment instead to discuss
>>> with you.  Attaching it is just easier for me.
>>>
>>> ===8<===
>>>   From 71f15ed19050a973088352a8d71b6cc6b7b5f7cf Mon Sep 17 00:00:00 2001
>>> From: Peter Xu <peterx@redhat.com>
>>> Date: Thu, 6 Nov 2025 16:03:00 -0500
>>> Subject: [PATCH] rcu: Make sync_event a semaphore
>>>
>>> It could simply all reset logic, especially after enforced rcu is
>>> introduced we'll also need a tweak to re-read "n", which can be avoided too
>>> when with a sem.
>>>
>>> However, the sem can introduce an overhead in high frequecy rcu frees.
>>> This patch is drafted with the assumption that rcu free is at least very
>>> rare in QEMU, hence it's not a problem.
>>>
>>> When I tested with this command:
>>>
>>> qemu-system-x86_64 -M q35,kernel-irqchip=split,suppress-vmdesc=on -smp 8 \
>>>     -m 4G -msg timestamp=on -name peter-vm,debug-threads=on -cpu Nehalem \
>>>     -accel kvm -qmp unix:/tmp/peter.sock,server,nowait -nographic \
>>>     -monitor telnet::6666,server,nowait -netdev user,id=net0,hostfwd=tcp::5555-:22
>>>     -device e1000,netdev=net0 -device virtio-balloon $DISK
>>>
>>> I booted a pre-installed Linux, login and poweroff, wait until VM
>>> completely shutdowns.  I captured less than 1000 rcu_free1() calls in
>>> summary.  It means for the whole lifetime of such VM the max overhead of
>>> the call_rcu_thread() loop reading rcu_call_count will be 1000 loops.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    util/rcu.c | 36 ++++++++----------------------------
>>>    1 file changed, 8 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/util/rcu.c b/util/rcu.c
>>> index 85f9333f5d..dfe031a5c9 100644
>>> --- a/util/rcu.c
>>> +++ b/util/rcu.c
>>> @@ -54,7 +54,7 @@ static int rcu_call_count;
>>>    static QemuMutex rcu_registry_lock;
>>>    /* Set when the forced variable is set or rcu_call_count becomes non-zero. */
>>> -static QemuEvent sync_event;
>>> +static QemuSemaphore sync_event;
>>>    /*
>>>     * Check whether a quiescent state was crossed between the beginning of
>>> @@ -80,7 +80,7 @@ static ThreadList registry = QLIST_HEAD_INITIALIZER(registry);
>>>    void force_rcu(void)
>>>    {
>>>        qatomic_set(&forced, true);
>>> -    qemu_event_set(&sync_event);
>>> +    qemu_sem_post(&sync_event);
>>>    }
>>>    /* Wait for previous parity/grace period to be empty of readers.  */
>>> @@ -148,7 +148,7 @@ static void wait_for_readers(bool sleep)
>>>                 */
>>>                qemu_event_reset(&rcu_gp_event);
>>>            } else if (qatomic_read(&rcu_call_count) >= RCU_CALL_MIN_SIZE ||
>>> -                   !sleeps || qemu_event_timedwait(&sync_event, 10)) {
>>> +                   !sleeps || qemu_sem_timedwait(&sync_event, 10)) {
>>>                /*
>>>                 * Now one of the following heuristical conditions is satisfied:
>>>                 * - A decent number of callbacks piled up.
>>> @@ -286,7 +286,6 @@ static void *call_rcu_thread(void *opaque)
>>>        rcu_register_thread();
>>>        for (;;) {
>>> -        bool sleep = true;
>>>            int n;
>>>            /*
>>> @@ -294,7 +293,6 @@ static void *call_rcu_thread(void *opaque)
>>>             * added before enter_qs() starts.
>>>             */
>>>            for (;;) {
>>> -            qemu_event_reset(&sync_event);
>>>                n = qatomic_read(&rcu_call_count);
>>>                if (n) {
>>>                    break;
>>> @@ -303,36 +301,19 @@ static void *call_rcu_thread(void *opaque)
>>>    #if defined(CONFIG_MALLOC_TRIM)
>>>                malloc_trim(4 * 1024 * 1024);
>>>    #endif
>>> -            qemu_event_wait(&sync_event);
>>> +            qemu_sem_wait(&sync_event);
>>>            }
>>> -        /*
>>> -         * Ensure that an event for a rcu_call_count change will not interrupt
>>> -         * wait_for_readers().
>>> -         */
>>> -        qemu_event_reset(&sync_event);
>>> -
>>> -        /*
>>> -         * Ensure that the forced variable has not been set after fetching
>>> -         * rcu_call_count; otherwise we may get confused by a force quiescent
>>> -         * state request for an element later than n.
>>> -         */
>>> -        while (qatomic_xchg(&forced, false)) {
>>> -            sleep = false;
>>> -            n = qatomic_read(&rcu_call_count);
>>> -        }
>>> -
>>> -        enter_qs(sleep);
>>> +        enter_qs(!qatomic_xchg(&forced, false));
>>
>> This is not OK; the forced variable may be set after rcu_call_count is
>> fetched. In that case, we should avoid unsetting the force quiescent state
>> request for the elements later than "n" or refetch "n".
> 
> Indeed I missed that part, but it should be trivial to fix, on top of my
> previous patch:
> 
> ===8<===
> diff --git a/util/rcu.c b/util/rcu.c
> index dfe031a5c9..aff98d9ee2 100644
> --- a/util/rcu.c
> +++ b/util/rcu.c
> @@ -286,6 +286,7 @@ static void *call_rcu_thread(void *opaque)
>       rcu_register_thread();
>   
>       for (;;) {
> +        bool sleep;
>           int n;
>   
>           /*
> @@ -293,6 +294,7 @@ static void *call_rcu_thread(void *opaque)
>            * added before enter_qs() starts.
>            */
>           for (;;) {
> +            sleep = !qatomic_xchg(&forced, false);

This doesn't work either; the following sequence may happen (assume 
forced is false at beginning):

qatomic_xchg(&forced, false)  |
                               | call_rcu1()
                               |     qatomic_fetch_inc(&rcu_call_count)
                               | force_rcu()
                               |     qatomic_set(&forced, true)
qatomic_read(&rcu_call_count)

We need to enter the force quiescent state for the node added with the 
call_rcu1() call in this sequence, but this code doesn't.

>               n = qatomic_read(&rcu_call_count);
>               if (n) {
>                   break;
> @@ -304,7 +306,7 @@ static void *call_rcu_thread(void *opaque)
>               qemu_sem_wait(&sync_event);
>           }
>   
> -        enter_qs(!qatomic_xchg(&forced, false));
> +        enter_qs(sleep);
>           qatomic_sub(&rcu_call_count, n);
>           bql_lock();
>           while (n > 0) {
> ===8<===
> 
> The idea is still the same, using semaphore can avoid explicit resets and a
> lot of other ordering constraints like reading call_count, etc.
> 
> E.g. even before this series, we still need to properly reset at explicit
> time to make sure we can capture a set() correct.  When with sem, all these
> issues are gone simply because we won't miss post() when it's a counter not
> boolean.
> 
> Also, would you please also have a look at other comments I left in the
> same email (after the patch I attached)?
> 
> https://lore.kernel.org/qemu-devel/aQ0Ys09WtlSPoapm@x1.local/
> 
> Can search "When I was having a closer look, I found some other issues".

I have just replied to the email. My mailer ignored the part after "--".

Regards,
Akihiko Odaki

