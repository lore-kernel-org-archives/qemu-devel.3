Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014BAC4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkjbY-0003OQ-NW; Fri, 17 Jul 2026 10:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wkjbW-0003O8-Kb
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:31:54 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wkjbU-00007Z-0l
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:31:54 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wkjbF-00000000flO-3hl9; Fri, 17 Jul 2026 16:31:37 +0200
Message-ID: <cb1bdf37-58e8-4498-bc56-d65c4fcc3fa0@maciej.szmigiero.name>
Date: Fri, 17 Jul 2026 16:31:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 2/2] vfio/migration: Parallelize device state transitions
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 qemu-devel@nongnu.org
References: <ac677bf9-1372-4905-a0b8-874a74be07be@maciej.szmigiero.name>
 <ah86Z0r5sMnxwgo-@x1.local>
 <c739f4fe-1f43-45c4-b98f-109366526405@maciej.szmigiero.name>
 <e79a3746-9c7e-46a5-ad81-537b9d3affdb@maciej.szmigiero.name>
 <akvWlciUvxjDbBBZ@x1.local>
 <e602d0cd-dfc2-441d-a017-067e55418dad@maciej.szmigiero.name>
 <alZssI9OmGJyD-rc@x1.local>
 <19b76c19-4c7b-4a48-8c77-7db8746ff570@maciej.szmigiero.name>
 <alenmdWqD-x3bYll@x1.local>
 <5513c20b-0f5c-4bf2-93fc-d1619e3319c1@maciej.szmigiero.name>
 <aljc2-4XfpSkX_ay@x1.local>
Content-Language: en-US, pl-PL
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <aljc2-4XfpSkX_ay@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
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

On 16.07.2026 15:30, Peter Xu wrote:
> On Thu, Jul 16, 2026 at 02:18:34PM +0200, Maciej S. Szmigiero wrote:
>> On 15.07.2026 17:30, Peter Xu wrote:
>>> On Tue, Jul 14, 2026 at 10:23:05PM +0200, Maciej S. Szmigiero wrote:
>>>> The VFIO devices in {PRE_COPY,RUNNING}_P2P states can {still,already} accept
>>>> DMA so in the master branch by the time prepare_cb() handlers exit and
>>>> cb() ones start running the VFIO devices are {still,already} capable of
>>>> accepting incoming DMA.
>>>>
>>>> On the other hand, if you meant the state transition into STOP_COPY on the
>>>> migration source currently initiated from cb() handler then there can be an
>>>> ordering issue in principle.
>>>>
>>>> It looks like the current master branch mostly avoids this by registering
>>>> vhost-net vm_state_change handler from VirtIODevice and not from its parent
>>>> PCI device, so with the usual PCI topology vhost-net cb() handler will run
>>>> before the VFIO PCI device one (and so still hit DMA-capable VFIO device)
>>>> due to the vhost-net VirtIODevice being one level deeper in the qdev tree.
>>>> It could theoretically be problem with more complex PCI topology though.
>>>
>>> That's an interesting observation, but neither do I think it's intentional,
>>> nor do I think it guarantees the depth ordering. Consider when a VFIO
>>> device is put under a few layers of PCIe switches, or PCI bridges.  In that
>>> case the VFIO device notifier can have larger depth value v.s. the virtio
>>> device when the virtio device is attached to the root complex.
>>
>> Yeah, that's why I wrote that it could be a problem with "more complex PCI topology".
> 
> Ah yes.
> 
>>
>> Nevertheless, that's probably uncommon enough setup to not generate visible
>> complaints about things being broken.
>>
>>>
>>>>
>>>>> It is also an issue then even before P2P_DMA state introduced, because
>>>>> before that all cb()s can be run at random orders.
>>>>
>>>> Technically, the order is based on the device qdev tree depth and within
>>>> the same qdev tree depth level it looks like the handler calling order will
>>>> be dependent on the order the registering devices were instantiated.
>>>>
>>>> This means that even before these P2P states were introduced
>>>> VM configurations that instantiated VFIO/virtio devices in the certain
>>>> "right" order or topology weren't affected.
>>>>
>>>> So maybe adding these P2P states mostly fixed this issue too?
>>>
>>> I still think they're two different issues, and I still think with/without
>>> P2P the issue is the same, now I tend to agree this issue exists,
>>> especially if virtio-blk have similar behavior like virtio-net.
>>>
>>> For one example of virtio-blk DMA to VFIO MMIO regions:
>>>
>>> https://lore.kernel.org/r/20260616052552.389021-1-gshan@redhat.com
>>>
>>> Said that, I don't know it's 100% triggerable in this case with notifiers,
>>> but sounds relevant.
>>
>> It does look like it could trigger this issue indeed since it's DMA done
>> to VFIO device MMIO BAR.
>> However, how easy would be to reproduce this is another question.
>>
>>> For virtio-net and others, I have less idea.
>>>
>>> In all cases, I still think there are two issues to fix, and I think we
>>> don't need to fix this problem in one shot. I still don't think they're
>>> directly relevant, at least on the goals.
>>
>> Sure, let's just not make the possible race situation worse.
>>
>>> So with what I suggested previously relying on prepare_cb() I believe we
>>> can still do the concurrency issue you're looking for, making sure when
>>> reaching VFIO's cb() it's still at least accepting DMAs (P2P is fine).
>>
>> But that's more or less the design of this (original) patch set -
>> make the state change to RUNNING_P2P on the target finish already in the
>> prepare_cb() time, make the state change to STOP_COPY on the source begin
>> only in the cb() time?
> 
> I am not against the idea in general. I'm against patch 1 where it hijacks
> "depth" into something even more complicated.
> 
> The "depth" itself makes sense to be recorded as a value, but I think it's
> already a bit confusing to call it "priority" in VMChangeStateEntry,
> because it isn't: when something has higher "priority", it should always be
> executed before lower priority items.  Here, the current code invert the
> order for !RUN case, so it's in reality "depth", not "priority".
> 
> Now patch 1 added yet another extra "adj" concept on top of qdev hierachy's
> "depth", which in fact the caller needs "priority" and callers need to
> explicitly handle that by checking RUNNING and invert things.
> 
> That's the part I'm definitely against.  Such code is IMHO not maintainable.
> 
> So my point is if we can implement your idea with existing prepare_cb() we
> should just use it.  Even if we want to enhance the priority support for
> cb()s, we shouldn't use patch 1.  I never thought further on that because I
> still assumed relying on prepare_cb() works.

If term "priority" is misleading due to reverse order of calling these handlers
on start vs stop we can change this term to "order".

Then the new adjustment becomes "order adjustment".

On the other hand, if the need for "additional indirection" inside VFIO code
to make the start vs stop handler ordering constant and the priority/order
adjustment mechanism from patch 1 are the most controversial parts of this
approach then there's another way to have prepare_cb()/cb() called at the
beginning and end of vm_change_state priority level:
Simply add another data structure besides vm_change_state_head with these
"pre" and "post" handlers (probably a hash table) and then call these
handlers before and after entering each priority value inside the existing
QTAILQ_FOREACH_SAFE() and QTAILQ_FOREACH_REVERSE_SAFE() in vm_state_notify().

This way the VFIO code could register these "pre" and "post" handlers
directly for its prepare_cb() and cb() state transitions.

>>
>>> For the other issue you reported, even if existed, I am not yet sure VFIO
>>> is the only special case that got affected.  I think it's possible some
>>> other emulated devices suffer the same even if it has no direct hardware
>>> attached.  Say, there can be device backends got stopped in cb() when VM
>>> stopped, further DMA to it may cause assertions, then it's the same issue
>>> that needs solving, where essentially we may require all such devices to
>>> provide similar P2P states like VFIO to make sure they initiate DMAs and
>>> flush them in a prepare_cb(), then if all devices' prepare_cb() will make
>>> sure no DMA to be initiated anymore, cb()s will have no ordering constraint
>>> on DMAs.
>>
>> Although the description above is about the migration source the situation
>> on the migration target is essentially a mirror image of it so I will refer
>> to both cases below.
>>
>> Specifically:
>> * on the source no device should reach non DMA accepting state (like STOP_COPY
>> for VFIO) before all devices reach non DMA generating state (PRE_COPY_P2P-equivalent).
>>
>> * on the target no device should reach DMA generating state (RUNNING-equivalent)
>> before all devices reach DMA accepting state (RUNNING_P2P-like).
>>
>> That's why even in the case where non-VFIO devices introduce the equivalent of
>> VFIO P2P states and implement a prepare_cb() callback we still need a (VM-wide)
>> sync point between these callbacks for the benefit of async state changes/threads
>> since no cb()-like async state change should start until all prepare_cb()-like
>> changes finish (including these for other devices).
> 
> IIUC, prepare_cb() + cb() is already that "sync point".  After all
> prepare_cb() done, the VM should achieve "DMA quiesced" across the system?
>
> What's missing is we should move all problematic device cb()s "let's flush
> pending DMAs" logic into a prepare_cb(), leaving the real stop logic in
> cb()s.  That's the 2nd problem which I think we can skip until a reproducer
> pops up at least.

Judging by the fact that you mention "flushing the pending DMA" I think you
refer to situation on the source.
On the source there's the vhost-net issue, which one can indeed be broken
even in the current git master by atypical PCI topology.

But there's similar but mirror problem on the target (described in my second
bullet point in the quote above) - the one with virtio-blk and scsi-bus.
Even today, this issue should not depend on VM PCI topology.

In the target case the "sync point" is about all devices being "DMA ready"
(but not yet launching DMA - I wouldn't call it "DMA quiescent" since
there's nothing to quiesce yet at this point).

So this would be a true regression with VFIO parallel state change threads.

> VFIO is only special here when it wants to concurrent process of state
> changes.  If you create threads in prepare_cb(), then in cb() you have
> chance to synchronize everything correctly satisfying the "sync point".
> That's not a requirement for most of the rest devices.

Inside the VFIO code such sync point for VFIO devices could/should indeed
be created, but then it's not available for these other (non-VFIO) devices
for the purpose of avoiding the regression from the previous paragraph.

However, replacing the order priority/adjustment mechanism from patch 1
with the "pre" and "post" handlers I described above would avoid having
that regression (and help fix the vhost-net case too).

> Thanks,
> 

Thanks,
Maciej


