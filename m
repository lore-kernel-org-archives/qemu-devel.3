Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851A7CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 05:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBoDx-0001T5-Tf; Thu, 23 Oct 2025 01:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vBoDv-0001Rg-4L
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 01:50:55 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vBoDq-0003xd-RZ
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 01:50:54 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59N5oZRZ041582
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 23 Oct 2025 14:50:36 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=mu6oAkI/wOwtXbxu1UIlsg3aWAsleMxiM2JdFVj7NDM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1761198636; v=1;
 b=TbpKQ0/w6PRd+20Xge9AG5C7lEOnIQ49tWzTMkBYOn0pe6AzLBGFoVby2TByaC0S
 JnSAJBSfvLH2tjv2C03MnEg++CEz8xdhr+qTJOXYkPJpz/4PziT0alLv5dscCLkb
 pIwoxdGyhnx5GVyKPxGIlqbT+ydhYV9g4oAXG1zXhHTgqcJoFq0Af1X8RR6/qjei
 nUpkYp7rwuwHqIOz5eqi138QBOIu441CErkTXu66KiU/To6NFD5JKtZ+OnLsf9Rj
 I3dsylOx3D4k0nbchJSsKklKdvqUFFpEeOipITJfJGQNRUAOtf+KZokZIlTKcBSW
 5S6UUNYaJtBMFGr2XL94lQ==
Message-ID: <ef54339e-c78c-43a0-94af-9908478095d6@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 23 Oct 2025 14:50:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Unify force quiescent state
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20251016-force-v1-1-919a82112498@rsg.ci.i.u-tokyo.ac.jp>
 <cc38a1ac-6f05-4c27-90a5-6ed71d9b566c@collabora.com>
 <626016e1-c7d8-4377-bf9f-ab0f0eef1457@rsg.ci.i.u-tokyo.ac.jp>
 <f89d4a21-635a-4779-95c1-7db0abe66863@rsg.ci.i.u-tokyo.ac.jp>
 <38973a24-787a-4ec0-866b-7f4a7a7824d1@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <38973a24-787a-4ec0-866b-7f4a7a7824d1@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/10/22 12:30, Dmitry Osipenko wrote:
> On 10/17/25 03:40, Akihiko Odaki wrote:
>> On 2025/10/17 8:43, Akihiko Odaki wrote:
>>> On 2025/10/17 4:33, Dmitry Osipenko wrote:
>>>> On 10/16/25 09:34, Akihiko Odaki wrote:
>>>>> -        /* Wait for one thread to report a quiescent state and try
>>>>> again.
>>>>> +        /*
>>>>> +         * Sleep for a while and try again.
>>>>>             * Release rcu_registry_lock, so rcu_(un)register_thread()
>>>>> doesn't
>>>>>             * wait too much time.
>>>>>             *
>>>>> @@ -133,7 +150,20 @@ static void wait_for_readers(void)
>>>>>             * rcu_registry_lock is released.
>>>>>             */
>>>>>            qemu_mutex_unlock(&rcu_registry_lock);
>>>>> -        qemu_event_wait(&rcu_gp_event);
>>>>> +
>>>>> +        if (forced) {
>>>>> +            qemu_event_wait(&rcu_gp_event);
>>>>> +
>>>>> +            /*
>>>>> +             * We want to be notified of changes made to
>>>>> rcu_gp_ongoing
>>>>> +             * while we walk the list.
>>>>> +             */
>>>>> +            qemu_event_reset(&rcu_gp_event);
>>>>> +        } else {
>>>>> +            g_usleep(10000);
>>>>> +            sleeps++;
>>>>
>>>> Thanks a lot for this RCU improvement. It indeed removes the hard stalls
>>>> with unmapping of virtio-gpu blobs.
>>>>
>>>> Am I understanding correctly that potentially we will be hitting this
>>>> g_usleep(10000) and stall virtio-gpu for the first ~10ms? I.e. the
>>>> MemoryRegion patches from Alex [1] are still needed to avoid stalls
>>>> entirely.
>>>>
>>>> [1]
>>>> https://lore.kernel.org/qemu-devel/20251014111234.3190346-6-
>>>> alex.bennee@linaro.org/
>>>
>>> That is right, but "avoiding stalls entirely" also causes use-after-free.
>>>
>>> The problem with virtio-gpu on TCG is that TCG keeps using the old
>>> memory map until force_rcu is triggered. So, without force_rcu, the
>>> following pseudo-code on a guest will result in use-after-free:
>>>
>>> address = blob_map(resource_id);
>>> blob_unmap(resource_id);
>>>
>>> for (i = 0; i < some_big_number; i++)
>>>     *(uint8_t *)address = 0;
>>>
>>> *(uint8_t *)address will dereference the blob until force_rcu is
>>> triggered, so finalizing MemoryRegion before force_rcu results in use-
>>> after-free.
>>>
>>> The best option to eliminate the delay entirely I have in mind is to
>>> call drain_call_rcu(), but I'm not for such a change (for now).
>>> drain_call_rcu() eliminates the delay if the FlatView protected by RCU
>>> is the only referrer of the MemoryRegion, but that is not guaranteed.
>>>
>>> Performance should not be a concern anyway in this situation. The
>>> guest should not waste CPU time by polling in the first place if you
>>> really care performance; since it's a para-virtualized device and not
>>> a real hardware, CPU time may be shared between the guest and the
>>> device, and thus polling on the guest has an inherent risk of slowing
>>> down the device. For performance-sensitive workloads, the guest should:
>>>
>>> - avoid polling and
>>> - accumulate commands instead of waiting for each
>>>
>>> The delay will be less problematic if the guest does so, and I think
>>> at least Linux does avoid polling.
>>>
>>> That said, stalling the guest forever in this situation is "wrong" (!=
>>> "bad performance"). I wrote this patch to guarantee forward progress,
>>> which is mandatory for semantic correctness.
>>>
>>> Perhaps drain_call_rcu() may make sense also in other, performance-
>>> sensitive scenarios, but it should be added after benchmark or we will
>>> have a immature optimization.
>>
>> I first thought just adding drain_call_rcu() would work but apparently
>> it is not that simple. Adding drain_call_rcu() has a few problems:
>>
>> - It drops the BQL, which should be avoided. Problems caused by
>> run_on_cpu(), which drops the BQL, was discussed on the list for a few
>> times and drain_call_rcu() may also suffer from them.
>>
>> - It is less effective if the RCU thread enters g_usleep() before
>> drain_call_rcu() is called.
>>
>> - It slows down readers due to the nature of drain_call_rcu().
>>
>> So, if you know some workload that may suffer from the delay, it may be
>> a good idea to try them with the patches from Alex first, and then think
>> of a clean solution if it improves performance.
> 
> What's not clear to me is whether this use-after-free problem affects
> only TCG or KVM too.
> 
> Can we unmap blob immediately using Alex' method when using KVM? Would
> be great if we could optimize unmapping for KVM. TCG performance is a
> much lesser concern.

Unfortunately no, the use-after-free can occur whatever acceleration is 
used. It was discussed thoroughly in the past. In short, the patch 
breaks reference counting (which also breaks RCU as it is indirectly 
tracked with reference counting) so use-after-free can be triggered with 
a DMA operation.

The best summary I can find is the following:
https://lore.kernel.org/qemu-devel/6c4b9d6a-d86e-44cf-be48-f919b81eac15@rsg.ci.i.u-tokyo.ac.jp/

The breakage of reference counting can be checked with the code in the 
following email:
https://lore.kernel.org/qemu-devel/e9285843-0487-4754-a348-34f1a852b24c@daynix.com/

I suggested adding an RCU API to request the force quiescent
state for virtio-gpu as a solution that works both on TCG and KVM in 
another thread, but I think it is also the easiest solution for KVM that 
avoids a regression. The thread can be found at:
https://lore.kernel.org/qemu-devel/f5d55625-10e0-496f-9b3e-2010fe0c741f@rsg.ci.i.u-tokyo.ac.jp/

I think it is straightforward enough, but I'm worried that it may not be 
implemented before the feature freeze. I am now just a hobbyist that has 
little time to spend for QEMU, and RCU and the memory region management 
are too important to make a change in haste.

Regards,
Akihiko Odaki

