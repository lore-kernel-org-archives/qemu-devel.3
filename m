Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8430FCD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 21:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUtFC-0004Kj-Si; Wed, 03 Jun 2026 17:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wUtF4-0004J4-KY
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 17:35:16 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wUtF2-0007cI-8h
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 17:35:14 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wUtEm-00000003FzW-3biz; Wed, 03 Jun 2026 23:34:56 +0200
Message-ID: <c739f4fe-1f43-45c4-b98f-109366526405@maciej.szmigiero.name>
Date: Wed, 3 Jun 2026 23:34:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vfio/migration: Parallelize device state transitions
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 qemu-devel@nongnu.org
References: <cover.1779217494.git.maciej.szmigiero@oracle.com>
 <743f03758d2a30df4093db140ccdd0f91f69bd7e.1779217494.git.maciej.szmigiero@oracle.com>
 <871peqtm5t.fsf@suse.de> <ah3eheRXN1QJAGj_@x1.local>
 <ac677bf9-1372-4905-a0b8-874a74be07be@maciej.szmigiero.name>
 <ah86Z0r5sMnxwgo-@x1.local>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Content-Language: en-US, pl-PL
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <ah86Z0r5sMnxwgo-@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2.06.2026 22:17, Peter Xu wrote:
> On Tue, Jun 02, 2026 at 12:01:32PM +0200, Maciej S. Szmigiero wrote:
>> On 1.06.2026 21:33, Peter Xu wrote:
>>> On Mon, Jun 01, 2026 at 10:39:26AM -0300, Fabiano Rosas wrote:
>>>> A bit idiosyncratic, but I don't have any better suggestions.
>>>
>>> One thing I don't think proper with the current approach: if it's a real
>>> "priority" it should be invoked always with high->low order, no matter if
>>> running=true or not..  but that's not what will happen if we encode it with
>>> the "depth" field.
>>>
>>> That is an implication that we have two demands, and they aren't the same,
>>> but this solution wrongly packed them together.
>>>
>>> In 2023, VFIO already introduced VMChangeStateEntry.prepare_cb().  That is
>>> a real impl of prority queues with only two: prepare_cb() always has higher
>>> priority than the cb() itself.
>>>
>>> Can VFIO simply leverage this existing interface, instead of hijacking
>>> "depth" in an unwanted way?
>>>
>>> I believe the _P2P states still need to happen first for all vfio devices,
>>> then it can do the next step. Logically I think it can also be done
>>> internally within VFIO by proper impl of these two callbacks, to achieve
>>> both:
>>>
>>> - Proper transition to P2P states first for all devices, meanwhile,
>>> - Proper concurrency of all VFIO devices on device state transitions
>>>
>>> Would that work in a cleaner way?
>>
>> In the VFIO migration save/source code we have two transitions:
>> PRE_COPY -> PRE_COPY_P2P done via prepare_cb() and
>> PRE_COPY_P2P -> STOP_COPY done via cb().
>> On the load/target side the situation is similar, only states are
>> different.
>>
>> For each of these transitions we need two callbacks: one has to launch
>> per-VFIO device state change thread and the other one has to "collect"
>> (or join) these threads.
>>
>> All handlers of the first callback have to be complete before calling
>> any handler of the second callback since otherwise there would be
>> VFIO device vs VFIO device serialization.
>>
>> Moreover, all the prepare_cb()-related transitions have to be done
>> before any of the cb()-related is started.
>>
>>
>> I presume what you suggest above is to launch per-VFIO device state
>> transition thread in prepare_cb() which would then be responsible for
>> doing *both* state transitions for this VFIO device.
>> And then collect this thread in cb().
> 
> Yes.
> 
>>
>> However, this would need some extra interlocking:
>> - A lock inside VFIO code shared by all VFIO devices making sure
>> no VFIO device starts the second transition (the cb() one) before
>> all VFIO devices finish the first transition (the prepare_cb() one).
> 
> Yes, more below.
> 
>>
>> - Looking at the current QEMU code, there are some non-VFIO cb()
>> handlers registered via qdev_add_vm_change_state_handler() and
>> quite a few handlers registered via qemu_add_vm_change_state_handler().
>>
>> I presume these VFIO prepare_cb()-related transitions need to finish
>> before calling any of these handlers to maintain the current ordering
> 
> IIUC, we don't necessarily need to keep this ordering; or do you see any
> real demand of that?
> 
> What I see is that the order is only introduced due to P2P state of VFIO,
> it seems very specific to me.

While I don't have a specific example why relaxing this ordering is unsafe
I am not certain that it is safe either - we can end up introducing subtle
race condition and possible guest memory corruption.

Maybe Alex and Cédric can provide some additional input here.

If nobody can authoritatively say that calling non-VFIO cb()
VM state change handlers before being certain that all VFIO devices
reached PRE_COPY_P2P / RUNNING_P2P state is indeed safe thing to do
I think we'll have to play safe here.

> 
>> so some kind of interlocking in vm_state_notify() between calling
>> prepare_cb() and cb() may be necessary since any "prio" based
>> ordering will have the same problem of reverse calling order on VM
>> start vs stop.
>>
>>
>> To be clear, I'm not insisting on the implementation from this patch -
>> any alternative one that preserves the aforementioned ordering rules
>> and has similar downtime performance is probably okay too.
> 
> The problem is, IIUC patch 1 needs better justification on its own, and I
> feel like it's not doing the right thing, as discussed previously. So even
> if we want to introduce a new priority-based approach, we may want to
> rethink patch 1.
> 
> IMHO it'll be perfect if we can simply reuse prepare_cb().  It seems
> working.
> 
> Due to this demand, I got to learn we have pthread_barrier_init(), but..
> personally I like a simple atomic+event approach:
> 
> vfio thread:
> 
>    # Do step 1, ->P2P
>    if (qatomic_fetch_inc(&vfio_p2p_done) + 1 == vfio_total_devices) {
>        qemu_event_set(&vfio_p2p_done_event);
>    }
>    qemu_event_wait(&vfio_p2p_done_event);
>    # Do step 2, ->STOPCOPY
> 
> cb() only join()s.
> 
> Would this work?

At the first glance it should work - of course, we'd need to introduce
the vfio_total_devices counter too.

However the issue about synchronization with other (non-VFIO) cb()
handlers described above still (possibly) remains.

> Thanks,
> 

Thanks,
Maciej


