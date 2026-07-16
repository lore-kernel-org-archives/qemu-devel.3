Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19083C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkMAM-0007lM-O5; Thu, 16 Jul 2026 09:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wkMAL-0007jz-GI
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:30:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wkMAJ-0005Ye-1e
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784208613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mx+c5m/N8NFdRTUudQi0Kcf3Bv0CqHFJMH5XXZ7eH+E=;
 b=DvBJkr1dmbz5bqYIupQ3n75Z1c4AtWhZGyugFWsFQkueqm4feoB9JRLAe24b+lQbibbzbl
 OIsDTdhJ+/ir4+3OqsOEbqMScl3iLC3w9ZPT6IrVYqc6ydxdyAlaZw9xgISDrowzgUqe6n
 VPXxIENxzCbP2YI8pUwJ3RFLEb855So=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-s9jj3jQFOhWMmcq0CGOiJg-1; Thu, 16 Jul 2026 09:30:11 -0400
X-MC-Unique: s9jj3jQFOhWMmcq0CGOiJg-1
X-Mimecast-MFC-AGG-ID: s9jj3jQFOhWMmcq0CGOiJg_1784208611
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso136321441cf.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 06:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784208611; x=1784813411; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mx+c5m/N8NFdRTUudQi0Kcf3Bv0CqHFJMH5XXZ7eH+E=;
 b=r6zVQgCbmsl0fmg5xX35+xZ2NZbe334+JNfjC2a4Z2sM1RwLjkbcr4yGu6+TtwMUMS
 v7cVwZ3zuTtjQN0qxbml23hjJjGnULjV1ZPIQH3oXgf+7SYdVKJHstS3onavPKLyXBtc
 YUKabENuUbW9lBvfR3qo17BUWal6HeKI2q0Lcv/1/yHwhvrKWWd+tmziIrFsfDKWTjF7
 vUTe6xZ+O2TYdidoFBdceshQTyP9DeAhHcMfr9hiHv1FVLB6/qA0VJecuIp37zcftGzi
 v428omIpydk4n/rqQzRfM2cUQ6id74p5cVAIonVm2dWG8y/J9ZgjLZdJEuy5c9eEIen6
 ulsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784208611; x=1784813411;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mx+c5m/N8NFdRTUudQi0Kcf3Bv0CqHFJMH5XXZ7eH+E=;
 b=pKRabxuUP/yfLxr0Dt19srwWV8PKfc16RbSn2Ve/pQG/zsLYwjJ5h8RRV9vrLPxtSw
 GXv6RaHZbLXhMPoXC1lnduVfsAZecgyDxxG0VrJPI82qD72FV1ZHr/tqrtwQWoKaXYft
 8DNgu5NBvYs+MgB8tUDZKPl1xmHRF2pFQxxag2LMbxeVgzTOADd3gtg7pS67ZxOyj4LO
 fCQBI1uCY/s9MRVp50XTKucWqOmRGqqEhs72cXdC5u8t5iOTmC9ofD66vVHCzegEGlcB
 q9gxvN2Hu/NsvRytZPSXL6Hm44j6L78ZwpPoW10xo0OR7AWfiJlbCxmRTe3WnBB+5zwE
 q6MQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqH8EKMGWUK4q99zJku/CF7VCECTCP+JcL1bORKCzyDDw1k6D5U+bW/llU6GadCnL/PeUmm3lH6zNNV@nongnu.org
X-Gm-Message-State: AOJu0Yy/gO0i594pGqCRyxuFth74Y/lftMKGaCflG6yL2F4W1fjAI4Df
 uN388oCIaf0KNX8NOeaKQI/Vr+kq2de8Dy1IODBKH+0Mt0b2RmCcYm0fgtSSegTwjWGo0MsD1Ck
 iYMhIeEnjk0Zgh3onVr/PIj5N0Arbl4IHoeV3YUt7je3IEDtRU+YIxXSW
X-Gm-Gg: AfdE7ckG6+cbQG8wxLcgt4m+Vp4byPZEjmf59R1iYwylKwCa+yET1lSbSdJivjrns/T
 Wt9Cx2rU4Xaaxb6uZFpisRHKk8wHhefDAfgxMxnb5iZiO3U9UQqcvBR5XG4GNZKyhfjIfi/Ot3O
 wk8Q06bA2fvXfyN+jIcYJTGfJ+4N1wqpBT60ZImDc8mUVoj+gn1Jjnd5Jauau1P2MkQIDiOmEHF
 dUxmkCglQhS+UiSnxEduDHdLaXMNpTMCul5pLl1B4glSjJDmPT/p5UJ8pqzDx4VhSwFOU49Cxb8
 vI9l2qlMBBi0Qq0RltS11VlhJQX1xknCAhbzK3g9VVZKx2qHcXpw0NomyQjAZvd9HhgX
X-Received: by 2002:ac8:5a8f:0:b0:51c:7b12:5fda with SMTP id
 d75a77b69052e-51e4f12cda6mr75238621cf.86.1784208609906; 
 Thu, 16 Jul 2026 06:30:09 -0700 (PDT)
X-Received: by 2002:ac8:5a8f:0:b0:51c:7b12:5fda with SMTP id
 d75a77b69052e-51e4f12cda6mr75236451cf.86.1784208608076; 
 Thu, 16 Jul 2026 06:30:08 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51caacdacf7sm160021361cf.11.2026.07.16.06.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:30:07 -0700 (PDT)
Date: Thu, 16 Jul 2026 09:30:03 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] vfio/migration: Parallelize device state transitions
Message-ID: <aljc2-4XfpSkX_ay@x1.local>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5513c20b-0f5c-4bf2-93fc-d1619e3319c1@maciej.szmigiero.name>
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Jul 16, 2026 at 02:18:34PM +0200, Maciej S. Szmigiero wrote:
> On 15.07.2026 17:30, Peter Xu wrote:
> > On Tue, Jul 14, 2026 at 10:23:05PM +0200, Maciej S. Szmigiero wrote:
> > > The VFIO devices in {PRE_COPY,RUNNING}_P2P states can {still,already} accept
> > > DMA so in the master branch by the time prepare_cb() handlers exit and
> > > cb() ones start running the VFIO devices are {still,already} capable of
> > > accepting incoming DMA.
> > > 
> > > On the other hand, if you meant the state transition into STOP_COPY on the
> > > migration source currently initiated from cb() handler then there can be an
> > > ordering issue in principle.
> > > 
> > > It looks like the current master branch mostly avoids this by registering
> > > vhost-net vm_state_change handler from VirtIODevice and not from its parent
> > > PCI device, so with the usual PCI topology vhost-net cb() handler will run
> > > before the VFIO PCI device one (and so still hit DMA-capable VFIO device)
> > > due to the vhost-net VirtIODevice being one level deeper in the qdev tree.
> > > It could theoretically be problem with more complex PCI topology though.
> > 
> > That's an interesting observation, but neither do I think it's intentional,
> > nor do I think it guarantees the depth ordering. Consider when a VFIO
> > device is put under a few layers of PCIe switches, or PCI bridges.  In that
> > case the VFIO device notifier can have larger depth value v.s. the virtio
> > device when the virtio device is attached to the root complex.
> 
> Yeah, that's why I wrote that it could be a problem with "more complex PCI topology".

Ah yes.

> 
> Nevertheless, that's probably uncommon enough setup to not generate visible
> complaints about things being broken.
> 
> > 
> > > 
> > > > It is also an issue then even before P2P_DMA state introduced, because
> > > > before that all cb()s can be run at random orders.
> > > 
> > > Technically, the order is based on the device qdev tree depth and within
> > > the same qdev tree depth level it looks like the handler calling order will
> > > be dependent on the order the registering devices were instantiated.
> > > 
> > > This means that even before these P2P states were introduced
> > > VM configurations that instantiated VFIO/virtio devices in the certain
> > > "right" order or topology weren't affected.
> > > 
> > > So maybe adding these P2P states mostly fixed this issue too?
> > 
> > I still think they're two different issues, and I still think with/without
> > P2P the issue is the same, now I tend to agree this issue exists,
> > especially if virtio-blk have similar behavior like virtio-net.
> > 
> > For one example of virtio-blk DMA to VFIO MMIO regions:
> > 
> > https://lore.kernel.org/r/20260616052552.389021-1-gshan@redhat.com
> > 
> > Said that, I don't know it's 100% triggerable in this case with notifiers,
> > but sounds relevant.
> 
> It does look like it could trigger this issue indeed since it's DMA done
> to VFIO device MMIO BAR.
> However, how easy would be to reproduce this is another question.
> 
> > For virtio-net and others, I have less idea.
> > 
> > In all cases, I still think there are two issues to fix, and I think we
> > don't need to fix this problem in one shot. I still don't think they're
> > directly relevant, at least on the goals.
> 
> Sure, let's just not make the possible race situation worse.
> 
> > So with what I suggested previously relying on prepare_cb() I believe we
> > can still do the concurrency issue you're looking for, making sure when
> > reaching VFIO's cb() it's still at least accepting DMAs (P2P is fine).
> 
> But that's more or less the design of this (original) patch set -
> make the state change to RUNNING_P2P on the target finish already in the
> prepare_cb() time, make the state change to STOP_COPY on the source begin
> only in the cb() time?

I am not against the idea in general. I'm against patch 1 where it hijacks
"depth" into something even more complicated.

The "depth" itself makes sense to be recorded as a value, but I think it's
already a bit confusing to call it "priority" in VMChangeStateEntry,
because it isn't: when something has higher "priority", it should always be
executed before lower priority items.  Here, the current code invert the
order for !RUN case, so it's in reality "depth", not "priority".

Now patch 1 added yet another extra "adj" concept on top of qdev hierachy's
"depth", which in fact the caller needs "priority" and callers need to
explicitly handle that by checking RUNNING and invert things.

That's the part I'm definitely against.  Such code is IMHO not maintainable.

So my point is if we can implement your idea with existing prepare_cb() we
should just use it.  Even if we want to enhance the priority support for
cb()s, we shouldn't use patch 1.  I never thought further on that because I
still assumed relying on prepare_cb() works.

> 
> > For the other issue you reported, even if existed, I am not yet sure VFIO
> > is the only special case that got affected.  I think it's possible some
> > other emulated devices suffer the same even if it has no direct hardware
> > attached.  Say, there can be device backends got stopped in cb() when VM
> > stopped, further DMA to it may cause assertions, then it's the same issue
> > that needs solving, where essentially we may require all such devices to
> > provide similar P2P states like VFIO to make sure they initiate DMAs and
> > flush them in a prepare_cb(), then if all devices' prepare_cb() will make
> > sure no DMA to be initiated anymore, cb()s will have no ordering constraint
> > on DMAs.
> 
> Although the description above is about the migration source the situation
> on the migration target is essentially a mirror image of it so I will refer
> to both cases below.
> 
> Specifically:
> * on the source no device should reach non DMA accepting state (like STOP_COPY
> for VFIO) before all devices reach non DMA generating state (PRE_COPY_P2P-equivalent).
> 
> * on the target no device should reach DMA generating state (RUNNING-equivalent)
> before all devices reach DMA accepting state (RUNNING_P2P-like).
> 
> That's why even in the case where non-VFIO devices introduce the equivalent of
> VFIO P2P states and implement a prepare_cb() callback we still need a (VM-wide)
> sync point between these callbacks for the benefit of async state changes/threads
> since no cb()-like async state change should start until all prepare_cb()-like
> changes finish (including these for other devices).

IIUC, prepare_cb() + cb() is already that "sync point".  After all
prepare_cb() done, the VM should achieve "DMA quiesced" across the system?

What's missing is we should move all problematic device cb()s "let's flush
pending DMAs" logic into a prepare_cb(), leaving the real stop logic in
cb()s.  That's the 2nd problem which I think we can skip until a reproducer
pops up at least.

VFIO is only special here when it wants to concurrent process of state
changes.  If you create threads in prepare_cb(), then in cb() you have
chance to synchronize everything correctly satisfying the "sync point".
That's not a requirement for most of the rest devices.

Thanks,

-- 
Peter Xu


