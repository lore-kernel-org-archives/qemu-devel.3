Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BBFC531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmqPC-00022z-VO; Thu, 23 Jul 2026 06:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wmqPB-00020F-8d
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 06:11:53 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wmqP8-0003gM-Ke
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 06:11:53 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wmqOu-000000016l6-0fgT; Thu, 23 Jul 2026 12:11:36 +0200
Message-ID: <5d745423-c4a1-4d99-a10c-18c5a0cdac43@maciej.szmigiero.name>
Date: Thu, 23 Jul 2026 12:11:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 2/2] vfio/migration: Parallelize device state transitions
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 qemu-devel@nongnu.org
References: <akvWlciUvxjDbBBZ@x1.local>
 <e602d0cd-dfc2-441d-a017-067e55418dad@maciej.szmigiero.name>
 <alZssI9OmGJyD-rc@x1.local>
 <19b76c19-4c7b-4a48-8c77-7db8746ff570@maciej.szmigiero.name>
 <alenmdWqD-x3bYll@x1.local>
 <5513c20b-0f5c-4bf2-93fc-d1619e3319c1@maciej.szmigiero.name>
 <aljc2-4XfpSkX_ay@x1.local>
 <cb1bdf37-58e8-4498-bc56-d65c4fcc3fa0@maciej.szmigiero.name>
 <al42_qzCLAjE-Mch@x1.local>
 <b83e940e-554f-491e-a6ce-db990c4166bc@maciej.szmigiero.name>
 <al-4mtSxvaaY5PDH@x1.local>
Content-Language: en-US, pl-PL
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <al-4mtSxvaaY5PDH@x1.local>
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

On 21.07.2026 20:21, Peter Xu wrote:
> On Tue, Jul 21, 2026 at 05:07:53PM +0200, Maciej S. Szmigiero wrote:
>> On 20.07.2026 16:55, Peter Xu wrote:
>>> On Fri, Jul 17, 2026 at 04:31:32PM +0200, Maciej S. Szmigiero wrote:
>>>> Inside the VFIO code such sync point for VFIO devices could/should indeed
>>>> be created, but then it's not available for these other (non-VFIO) devices
>>>> for the purpose of avoiding the regression from the previous paragraph.
>>>>
>>>> However, replacing the order priority/adjustment mechanism from patch 1
>>>> with the "pre" and "post" handlers I described above would avoid having
>>>> that regression (and help fix the vhost-net case too).
>>>
>>> I'm not sure I fully get the pre/post handlers idea, I think it sounds
>>> working, but in all cases I want to decouple it with patch 1: I don't think
>>> it requires patch 1, am I right?
>>
>> It wouldn't require the *current* patch 1 but it would need to be implemented
>> in some preparatory patch so it would effectively be a new patch 1 (or a set
>> of patches replacing patch 1).
>>
>> Assuming that we would go this route instead of the one you described below.
>>
>>> Now if we want to avoid this "theoretical regression" and solve both things
>>> together.. I think we may need to refactor the notifiers mechanism.
>>>
>>> Firstly, I hope we're on the same page that essentially prepare_cb() is the
>>> priority mechanism here, we only have HIGH and NORMAL priority, where cb()
>>> is the NORMAL priority.
>>
>> Yeah, I think the current situation could be described this way.
>>
>>> We also need to persist depth concept per-notifier, I think we should start
>>> by renaming VMChangeStateEntry.priority to depth, add a comment explaining
>>> it (on different order of invokations on VM start/shutdown).
>>>
>>> But then, I don't think we need anything as complex as pre/post hooks with
>>> hashes.  I think you're right then we need SYNC point which can be
>>> essentially a priority notifier that is in the middle of HIGH and NORMAL.
>>>
>>> Hence, I want to see if below should be the easiest:
>>>
>>>     - Rename VMChangeStateEntry.priority to depth
>>>
>>>     - Normalize prepare_cb() into VM_CHANGE_NOTIFY_PRI_HIGH, making cb() to
>>>       be NORMAL, OTOH.  With this, prepare_cb() needs to be registered
>>>       separately with qemu_add_vm_change_state_handler_prio_full().  The
>>>       function now should drop prepare_cb() but instead take a real
>>>       "priority" value of VM_CHANGE_NOTIFY_PRI_*.
>>
>> And where the qdev tree depth will go in a call to
>> qemu_add_vm_change_state_handler_prio_full() - as an additional "depth"
>> parameter?
> 
> Yes.  The rename change I mentioned above should have done so.
> 
>>
>>>
>>>     - Introduce VM_CHANGE_NOTIFY_PRI_SYNC, in the middle of PREPARE / NORMAL.
>>>
>>>     - VFIO can now register its 3rd notifier against SYNC.
>>>
>>> All rest devices will need to shift part of its logic into PRI_HIGH to
>>> either quiesce DMA or enable the backend to accept DMA (when on dest QEMU).
>>> None of them will need SYNC only if they'll also switch to an async thread
>>> model.
>>
>> In principle, this *should* work but with some caveats:
>> * vhost-net would need the DMA-stopping part of its cb() handler separated
>> and moved into prepare_cb(),
> 
> I thought this is required with whatever priority impl we will have, even
> if I don't think we need to fix it right now unless you wanted to..

Theoretically this depends on VM's PCI topology but indeed one can argue
it's a "pre-existing condition".

>>
>> * There's some restore code in "PowerPC sPAPR XIVE interrupt controller"
>> running from cb() at prio 0, so originally always completing before VFIO device
>> was switched into RUNNING state.
>> I'm not 100% sure if it's okay to make VFIO device reach this state before
>> that interrupt controller restore code finishes,
> 
> Is anyone using VFIO migration on PPC that you're aware of? 

No, but at the other hand it's hard to be sure of that.

Also, see the next paragraphs about one or two additional possibly
affected interrupt controllers.

> If not, maybe
> we don't need to worry too much for now.  Meanwhile, this looks like an
> existing issue as well.

It's an existing issue *on the target* but for a slightly different reason:
reading VFIO uAPI it seems that a device is allowed to generate interrupts
already in RUNNING_P2P state.
And this state is/was reached already after prepare_cb() handlers, so before
that PPC interrupt controller handler running from cb() had chance to restore
it.

However, it does not seem to be an existing issue *on the source* since
there INTC cb() callback are currently always guaranteed to run after the
VFIO device has already reached STOP_COPY and so was prevented from
generating  further interrupts.

Here, it would be a (at least theoretical) regression.

What's more, there seem to be one more interrupt controller in two
variants/implementations that also do similar things on the source from their
cb() handlers: ARM GICv3 basic flavor and ITS flavor.

> For the fix whenever wanted, IIUC the intr controller should register both
> HIGH and NORMAL priority notifiers, then when VM stop, disable the
> controller only in NORMAL notifier, and when VM starts, enable the
> controller only in HIGH notifier (we could think about better names for the
> three steps, maybe it shouldn't be called as "priority" as well even if the
> executions will be strictly ordered).

As I wrote above, it looks like a device is already allowed to generate
interrupts once it reaches RUNNING_P2P state.
Correspondingly, PRE_COPY_P2P only quiesces *peer-to-peer* DMA, there's no
mention in the specs that it prevents MSI DMA traffic, let alone INTx
interrupt generation.

In other words, to implement this properly an interrupt controller would need
to have its start/restore handler called at some VERY_HIGH priority (called before
VFIO device state change threads are launched) and have its stop/suspend handler
called at a VERY_LOW priority (called after VFIO threads are collected) -
this would be the equivalent of running these INTC cb() at prio 0 during VM stop now.

Assuming, of course that the interrupt controller actually needs to do some work
on VM start to be able to accept interrupts and that it needs to do some
saving work on VM stop which can't be done until no new interrupts could came.

> 
>>
>> * The postponed dirty memory logging stop handler also runs from cb() at
>> prio 0, so currently always finishes before VFIO device was switched into
>> RUNNING state.
>> This handler also stops DMA logging for VFIO device or its container,
>> but here I presume it should be safe to do so while the VFIO device has already
>> started dirtying memory even though this couldn't happen in the existing code?
> 
> It's only stopping the tracking, results of the tracking shouldn't matter
> anymore on whether some DMA was trapped.  It looks safe no matter where we
> put it.
> 
>>
>> * There's some sync/setup of x86 vAPIC state (for 32-bit guests?) also running
>> from cb() at prio 0.
>> Not sure if this needs to finish before VFIO device gets switched into
>> RUNNING state.
> 
> Doesn't look relevant.  IIUC, only anything that is DMA capable can be
> relevant.

It's relevant since a VFIO device could generate interrupts as soon as it
is in RUNNING_P2P state.

However, this one here is start-side so it would be an existing issue rather
than a regression.

>>
>> These 3 possible issues above (besides vhost-net move/refactor) could be
>> theoretically worked around by moving these callbacks from cb() to a new
>> priority *before* VM_CHANGE_NOTIFY_PRI_SYNC (maybe called
>> VM_CHANGE_NOTIFY_PRI_SYNC_BEFORE or similar) as I presume they won't need the
>> VFIO device to reach DMA-accepting state but at the same time they shouldn't
>> delay the launch of VFIO device state changing threads from VM_CHANGE_NOTIFY_PRI_HIGH.
> 
> IIUC we don't need a 4th step here, correct me otherwise, 

Depends whether we want to fix the existing issues or not.
If not, then we don't need the extra priority level on the target.

However, I think we still need a possible extra level (VERY_LOW or similar) on
the source to prevent possible regression with respect to the current code.

But that's a minor detail as I presume adding additional level would be essentially
only a small data addition in some array and/or enum.

> while the 3rd
> SYNC was only needed for VFIO's threaded approach.

I assume that we're designing the "plumbing" that allows doing async/threaded
VFIO state change safely here.

>>
>> Also, the final VFIO thread joining/collection does *not* need to be ordered
>> with exiting cb() handlers, so it should really run at VM_CHANGE_NOTIFY_PRI_LOW
>> (below PRI_NORMAL) for best parallelism.
> 
> Yes. VFIO device only need its SYNC / MEDIUM priority notifier be ordered
> with NORMAL notifiers, to make sure all VFIO devices switched to P2P state
> before the NORMAL notifiers.
> 
>>
>> The disadvantages of this overall design are that it would need coordination
>> between different sub-maintainers, increase the "blast radius" of the patch
>> set to different parts of QEMU code, and so obviously would be more
>> regression-risky than the aforementioned "pre" and "post" handlers design.
>>
>> Especially that probably few people would be able to test, for example,
>> the PPC XIVE case with VFIO.
> 
> We shouldn't justify a solution by "how many subsystems it touches".
> 
> I was suggesting to solve one problem at a time, but then prepare_cb()
> already does it.  You pointed out there might be real regression on VM
> start path, I agreed.
> 
> I thought you wanted to fix all things, which I'm ok with and agree it is
> better, then it's unavoidable to touch all modules.  But yes, we need to
> reproduce the problems and verify the fix.
> 
> The middle ground is we define the notifiers to suite for the solution we
> think will fix everything, but you only need to fix VFIO and leave the rest
> for later. We can discuss the problems in the cover letter or commit logs
> for future works on top.  After all, in this case of VFIO to do the right
> things it does need three steps / notifiers.

I think if there are existing issues then it's probably okay just to document
these for future reference.

However, I would be vary of creating any clear regression, especially on
a hardware that I can't test.

> Thanks,
> 

Thanks,
Maciej

