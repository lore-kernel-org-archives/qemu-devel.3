Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608FBC531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 19:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmzP9-0001fV-Uv; Thu, 23 Jul 2026 15:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wmzP7-0001er-SY
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 15:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wmzP4-0002tI-JF
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 15:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784836100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PllLOMTlSc6dp6XMQRGW8XI/f2Le/G9tl4LbZWuzuok=;
 b=IEcjSoK3wBxNyaVmjLs3lXfPfGUWZf8de0rkGPJNl84WPt55nqAh5GrKqlh9tDFO2Qe9xR
 IUUXF7c/KF9Ft1zDP5diN9uOHLYSTJlZ7YhTKv4LtW/yNtXXgjVUkgHDjgXjuLhB2TqnfR
 x7dMQ4T7NyQJ1V7EbfuxTjIjeq7Rp/k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-LGb9QU2TOiuZCeTeblkyFg-1; Thu, 23 Jul 2026 15:48:17 -0400
X-MC-Unique: LGb9QU2TOiuZCeTeblkyFg-1
X-Mimecast-MFC-AGG-ID: LGb9QU2TOiuZCeTeblkyFg_1784836096
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-930b571432fso129224285a.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 12:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784836096; x=1785440896; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PllLOMTlSc6dp6XMQRGW8XI/f2Le/G9tl4LbZWuzuok=;
 b=VRW0qQ7cvzsjvBqP7lSVZGth2wAcRAGFlRA7tmYyie/GfvoAjXTNwtFNCdQ5i3O9gM
 uclYL/oYEOobwqLSAqNGjxeTXoLuStkpVCYr5lPgpCBHzXSDJyBI+eO0OOjvAZt0QVVe
 18EHu2MDufFQQcvAXn703/0cbdmLRCp6hm5Vyh7dKqFlKzKNaMmN/yHW23aQWRieIaZp
 DgRnYg3elN1UaZCOppu7qWqZBqj6qG3Fp+MDLnSeJX4BL/O0Qx7vyvohbhLkomq4OUQf
 E5kdwa4KDH13xNhFO2RrmSt3q4+HZnZBxyAzlTGp3walFQYkFN+PcfsE9u4POiy+5xFp
 1vgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784836096; x=1785440896;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PllLOMTlSc6dp6XMQRGW8XI/f2Le/G9tl4LbZWuzuok=;
 b=D5xXCt+IG/efxTFPzUJgw7GgH7eLRnynmWBspyyw/v4T2xuyUm3afV20aSTq8cZriC
 /AKcVj+TIIxVkRIpwTbHEUJ+VsH34wbejcRF63hN+mVX/OdB/0RWjlw1T6qeWhQRNowL
 OYJHjWL/1yqpSYA4CIj5PDP8nQrY+K/Y46zY6/K+IV59GiSj8HUa84TLEyADmehlFydz
 2b75P2vff0fGwSEY/nl4cZXHd8PAIo4QNCAcJ/TKR2T9j7yUOZ5cGdpEYYOV7EK0YCfJ
 i6vSlo2TRp+hH1xioM6F9qqGvj10sc+LdA4g2VytPWOkj1zPMvZhtgOujRqnSGERVR3b
 RZNA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqD9xgVT7mPk5TFfzEqvEOrMGm/Qz5/Lurogb/yLWI0O+j/de8cmrJIMnZ7X6MQX2KmyFTYVNdmhGkx@nongnu.org
X-Gm-Message-State: AOJu0YxsjeNNXOjE038+lZMbXIo37D9tClsn9U5xfSTQScwlT/GZ3xCr
 efTPvZF3KJ2P/nf7Yffw+lUi7/o1vlS+p33C9MlOs27+SDPryhSTxhwvij2PAyp0knEP61kF6Ur
 NZ/1Ypb4WTS02j96oK0pPzyo/jOJBKLuBzTAYlsaDaadTCX7PL4c1T7fl
X-Gm-Gg: AR+sD10qJ1fgXJmv9njxUjaStu8zqEKbV7yQo5p9YSs1K49614IG9yUKEuwhpOxbD3v
 Eg6xfTRCn4C3nZFVm+un+SfzNbfbQn2NjgR2W1kdeO4em5kLlNQm0GIQ+OTjOLZqeMD9UOtc8NH
 Nba/PMoe1CnzXWyUZb68PN5dGqsddUmg4uqfnpfvyDb0KO3K6ICAWrwz3QSewGPXNe+JPE/Z+QM
 +LZKBEwFWmusGYUqnCqm2UxlHJiWLpkMM655hh46vl3B3LLGlouUGF3kRml/3L39MgDvFjsyQsB
 kYzx/BFbs+5KbxnZxwJRn70E6fI8TJB2ZeB+XBcAjFZWKqWWXHuVAimRyygW1uDySucP
X-Received: by 2002:a05:620a:414e:b0:92e:7167:3f2c with SMTP id
 af79cd13be357-931048a2f28mr398554485a.32.1784836096153; 
 Thu, 23 Jul 2026 12:48:16 -0700 (PDT)
X-Received: by 2002:a05:620a:414e:b0:92e:7167:3f2c with SMTP id
 af79cd13be357-931048a2f28mr398551385a.32.1784836095451; 
 Thu, 23 Jul 2026 12:48:15 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930f68c67d6sm487451785a.17.2026.07.23.12.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 12:48:14 -0700 (PDT)
Date: Thu, 23 Jul 2026 15:48:03 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] vfio/migration: Parallelize device state transitions
Message-ID: <amJv85p7LKmBMyK9@x1.local>
References: <alZssI9OmGJyD-rc@x1.local>
 <19b76c19-4c7b-4a48-8c77-7db8746ff570@maciej.szmigiero.name>
 <alenmdWqD-x3bYll@x1.local>
 <5513c20b-0f5c-4bf2-93fc-d1619e3319c1@maciej.szmigiero.name>
 <aljc2-4XfpSkX_ay@x1.local>
 <cb1bdf37-58e8-4498-bc56-d65c4fcc3fa0@maciej.szmigiero.name>
 <al42_qzCLAjE-Mch@x1.local>
 <b83e940e-554f-491e-a6ce-db990c4166bc@maciej.szmigiero.name>
 <al-4mtSxvaaY5PDH@x1.local>
 <5d745423-c4a1-4d99-a10c-18c5a0cdac43@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d745423-c4a1-4d99-a10c-18c5a0cdac43@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 23, 2026 at 12:11:30PM +0200, Maciej S. Szmigiero wrote:
> On 21.07.2026 20:21, Peter Xu wrote:
> > On Tue, Jul 21, 2026 at 05:07:53PM +0200, Maciej S. Szmigiero wrote:
> > > On 20.07.2026 16:55, Peter Xu wrote:
> > > > On Fri, Jul 17, 2026 at 04:31:32PM +0200, Maciej S. Szmigiero wrote:
> > > > > Inside the VFIO code such sync point for VFIO devices could/should indeed
> > > > > be created, but then it's not available for these other (non-VFIO) devices
> > > > > for the purpose of avoiding the regression from the previous paragraph.
> > > > > 
> > > > > However, replacing the order priority/adjustment mechanism from patch 1
> > > > > with the "pre" and "post" handlers I described above would avoid having
> > > > > that regression (and help fix the vhost-net case too).
> > > > 
> > > > I'm not sure I fully get the pre/post handlers idea, I think it sounds
> > > > working, but in all cases I want to decouple it with patch 1: I don't think
> > > > it requires patch 1, am I right?
> > > 
> > > It wouldn't require the *current* patch 1 but it would need to be implemented
> > > in some preparatory patch so it would effectively be a new patch 1 (or a set
> > > of patches replacing patch 1).
> > > 
> > > Assuming that we would go this route instead of the one you described below.
> > > 
> > > > Now if we want to avoid this "theoretical regression" and solve both things
> > > > together.. I think we may need to refactor the notifiers mechanism.
> > > > 
> > > > Firstly, I hope we're on the same page that essentially prepare_cb() is the
> > > > priority mechanism here, we only have HIGH and NORMAL priority, where cb()
> > > > is the NORMAL priority.
> > > 
> > > Yeah, I think the current situation could be described this way.
> > > 
> > > > We also need to persist depth concept per-notifier, I think we should start
> > > > by renaming VMChangeStateEntry.priority to depth, add a comment explaining
> > > > it (on different order of invokations on VM start/shutdown).
> > > > 
> > > > But then, I don't think we need anything as complex as pre/post hooks with
> > > > hashes.  I think you're right then we need SYNC point which can be
> > > > essentially a priority notifier that is in the middle of HIGH and NORMAL.
> > > > 
> > > > Hence, I want to see if below should be the easiest:
> > > > 
> > > >     - Rename VMChangeStateEntry.priority to depth
> > > > 
> > > >     - Normalize prepare_cb() into VM_CHANGE_NOTIFY_PRI_HIGH, making cb() to
> > > >       be NORMAL, OTOH.  With this, prepare_cb() needs to be registered
> > > >       separately with qemu_add_vm_change_state_handler_prio_full().  The
> > > >       function now should drop prepare_cb() but instead take a real
> > > >       "priority" value of VM_CHANGE_NOTIFY_PRI_*.
> > > 
> > > And where the qdev tree depth will go in a call to
> > > qemu_add_vm_change_state_handler_prio_full() - as an additional "depth"
> > > parameter?
> > 
> > Yes.  The rename change I mentioned above should have done so.
> > 
> > > 
> > > > 
> > > >     - Introduce VM_CHANGE_NOTIFY_PRI_SYNC, in the middle of PREPARE / NORMAL.
> > > > 
> > > >     - VFIO can now register its 3rd notifier against SYNC.
> > > > 
> > > > All rest devices will need to shift part of its logic into PRI_HIGH to
> > > > either quiesce DMA or enable the backend to accept DMA (when on dest QEMU).
> > > > None of them will need SYNC only if they'll also switch to an async thread
> > > > model.
> > > 
> > > In principle, this *should* work but with some caveats:
> > > * vhost-net would need the DMA-stopping part of its cb() handler separated
> > > and moved into prepare_cb(),
> > 
> > I thought this is required with whatever priority impl we will have, even
> > if I don't think we need to fix it right now unless you wanted to..
> 
> Theoretically this depends on VM's PCI topology but indeed one can argue
> it's a "pre-existing condition".
> 
> > > 
> > > * There's some restore code in "PowerPC sPAPR XIVE interrupt controller"
> > > running from cb() at prio 0, so originally always completing before VFIO device
> > > was switched into RUNNING state.
> > > I'm not 100% sure if it's okay to make VFIO device reach this state before
> > > that interrupt controller restore code finishes,
> > 
> > Is anyone using VFIO migration on PPC that you're aware of?
> 
> No, but at the other hand it's hard to be sure of that.
> 
> Also, see the next paragraphs about one or two additional possibly
> affected interrupt controllers.
> 
> > If not, maybe
> > we don't need to worry too much for now.  Meanwhile, this looks like an
> > existing issue as well.
> 
> It's an existing issue *on the target* but for a slightly different reason:
> reading VFIO uAPI it seems that a device is allowed to generate interrupts
> already in RUNNING_P2P state.
> And this state is/was reached already after prepare_cb() handlers, so before
> that PPC interrupt controller handler running from cb() had chance to restore
> it.
> 
> However, it does not seem to be an existing issue *on the source* since
> there INTC cb() callback are currently always guaranteed to run after the
> VFIO device has already reached STOP_COPY and so was prevented from
> generating  further interrupts.

If we rely on intc have very small (or, 0 by default) depth, then yes.

> 
> Here, it would be a (at least theoretical) regression.

I don't yet get what is referred as "regression" here.  If what you said is
correct (which it seems true, that IRQ can be generated during PRECOPY_P2P
and RUNNING_P2P), then dest QEMU should be broken already with VFIO being
able to prepare_cb() converting devices to RUNNING_P2P.

That's not a regression by either your current patch or what I proposed
previously. This is then a bug existed since prepare_cb().  Meanwhile, it
was also an accident if it wasn't a bug even before it, after all intr
chips are still using qemu_* helpers to register, where depth isn't
accounted.

In reality maybe we should have done that; in case of an irq controller we
should make sure the depth should be very small, at least smaller than the
rest / normal devices to make sure its order of operation, otherwise even
emulated devices seem to be prone to irq lost during vm start/stop or
migration.

> 
> What's more, there seem to be one more interrupt controller in two
> variants/implementations that also do similar things on the source from their
> cb() handlers: ARM GICv3 basic flavor and ITS flavor.
> 
> > For the fix whenever wanted, IIUC the intr controller should register both
> > HIGH and NORMAL priority notifiers, then when VM stop, disable the
> > controller only in NORMAL notifier, and when VM starts, enable the
> > controller only in HIGH notifier (we could think about better names for the
> > three steps, maybe it shouldn't be called as "priority" as well even if the
> > executions will be strictly ordered).
> 
> As I wrote above, it looks like a device is already allowed to generate
> interrupts once it reaches RUNNING_P2P state.
> Correspondingly, PRE_COPY_P2P only quiesces *peer-to-peer* DMA, there's no
> mention in the specs that it prevents MSI DMA traffic, let alone INTx
> interrupt generation.
> 
> In other words, to implement this properly an interrupt controller would need
> to have its start/restore handler called at some VERY_HIGH priority (called before

IIUC, my solution proposed should be fine as long as the INTR chip will
split its vm state handler into two, "running" handler inserted into HIGH
prority, but "!running" handler inserted into NORMAL priority, as I
discussed above.  This also depends on that we will notify each queue (one
for each priority) with the depth in mind, so we will make sure to disable
/ quiesce the irq chip last (NORMAL, depth=0) when stop, and enable it
first (HIGH, depth=0) when start.

NOTE: we have HIGH/SYNC/NORMAL, so NORMAL is the lowest priority, if we
call it like that.  We can rename them..

> VFIO device state change threads are launched) and have its stop/suspend handler
> called at a VERY_LOW priority (called after VFIO threads are collected) -
> this would be the equivalent of running these INTC cb() at prio 0 during VM stop now.
> 
> Assuming, of course that the interrupt controller actually needs to do some work
> on VM start to be able to accept interrupts and that it needs to do some
> saving work on VM stop which can't be done until no new interrupts could came.

Yes, I also didn't read into all irq chip code yet.

> 
> > 
> > > 
> > > * The postponed dirty memory logging stop handler also runs from cb() at
> > > prio 0, so currently always finishes before VFIO device was switched into
> > > RUNNING state.
> > > This handler also stops DMA logging for VFIO device or its container,
> > > but here I presume it should be safe to do so while the VFIO device has already
> > > started dirtying memory even though this couldn't happen in the existing code?
> > 
> > It's only stopping the tracking, results of the tracking shouldn't matter
> > anymore on whether some DMA was trapped.  It looks safe no matter where we
> > put it.
> > 
> > > 
> > > * There's some sync/setup of x86 vAPIC state (for 32-bit guests?) also running
> > > from cb() at prio 0.
> > > Not sure if this needs to finish before VFIO device gets switched into
> > > RUNNING state.
> > 
> > Doesn't look relevant.  IIUC, only anything that is DMA capable can be
> > relevant.
> 
> It's relevant since a VFIO device could generate interrupts as soon as it
> is in RUNNING_P2P state.
> 
> However, this one here is start-side so it would be an existing issue rather
> than a regression.
> 
> > > 
> > > These 3 possible issues above (besides vhost-net move/refactor) could be
> > > theoretically worked around by moving these callbacks from cb() to a new
> > > priority *before* VM_CHANGE_NOTIFY_PRI_SYNC (maybe called
> > > VM_CHANGE_NOTIFY_PRI_SYNC_BEFORE or similar) as I presume they won't need the
> > > VFIO device to reach DMA-accepting state but at the same time they shouldn't
> > > delay the launch of VFIO device state changing threads from VM_CHANGE_NOTIFY_PRI_HIGH.
> > 
> > IIUC we don't need a 4th step here, correct me otherwise,
> 
> Depends whether we want to fix the existing issues or not.
> If not, then we don't need the extra priority level on the target.
> 
> However, I think we still need a possible extra level (VERY_LOW or similar) on
> the source to prevent possible regression with respect to the current code.

I'll re-comment after you read above.  In short, we have 3 priorities
(HIGH/SYNC/NORMAL, but again, prone to be renamed) but that's not the only
way we order things: for each priority we will still notify with "depth"
order, it's just that we will revert the depth order depending on running
or not.  irq chip issue is better solved with "depth" setting right all
over the places, because it has a semantic of "depth" not real "priority"
(e.g. turns off last, turns on first).

> 
> But that's a minor detail as I presume adding additional level would be essentially
> only a small data addition in some array and/or enum.
> 
> > while the 3rd
> > SYNC was only needed for VFIO's threaded approach.
> 
> I assume that we're designing the "plumbing" that allows doing async/threaded
> VFIO state change safely here.
> 
> > > 
> > > Also, the final VFIO thread joining/collection does *not* need to be ordered
> > > with exiting cb() handlers, so it should really run at VM_CHANGE_NOTIFY_PRI_LOW
> > > (below PRI_NORMAL) for best parallelism.
> > 
> > Yes. VFIO device only need its SYNC / MEDIUM priority notifier be ordered
> > with NORMAL notifiers, to make sure all VFIO devices switched to P2P state
> > before the NORMAL notifiers.
> > 
> > > 
> > > The disadvantages of this overall design are that it would need coordination
> > > between different sub-maintainers, increase the "blast radius" of the patch
> > > set to different parts of QEMU code, and so obviously would be more
> > > regression-risky than the aforementioned "pre" and "post" handlers design.
> > > 
> > > Especially that probably few people would be able to test, for example,
> > > the PPC XIVE case with VFIO.
> > 
> > We shouldn't justify a solution by "how many subsystems it touches".
> > 
> > I was suggesting to solve one problem at a time, but then prepare_cb()
> > already does it.  You pointed out there might be real regression on VM
> > start path, I agreed.
> > 
> > I thought you wanted to fix all things, which I'm ok with and agree it is
> > better, then it's unavoidable to touch all modules.  But yes, we need to
> > reproduce the problems and verify the fix.
> > 
> > The middle ground is we define the notifiers to suite for the solution we
> > think will fix everything, but you only need to fix VFIO and leave the rest
> > for later. We can discuss the problems in the cover letter or commit logs
> > for future works on top.  After all, in this case of VFIO to do the right
> > things it does need three steps / notifiers.
> 
> I think if there are existing issues then it's probably okay just to document
> these for future reference.
> 
> However, I would be vary of creating any clear regression, especially on
> a hardware that I can't test.

Understood, I have no good idea on testing.  IIUC what needs to be tested
for irq chips do not need VFIO involvement, maybe some regression test
should be enough on either migration or even stop/cont.  May need some help
from arch developers indeed if we want some better coverage.

If you can think of anything that doesn't need to mess up the depth as
patch 1 does (so if you want to reuse depth, make it a real "depth" would
be fine, not a mixture of depth+prio), then maybe we can check that. I just
can't think of anything else yet.

Thanks,

> 
> > Thanks,
> > 
> 
> Thanks,
> Maciej
> 

-- 
Peter Xu


