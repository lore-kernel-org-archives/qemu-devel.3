Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D0CC4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmF66-0008A0-US; Tue, 21 Jul 2026 14:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wmF5y-00084s-4x
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wmF5w-00036q-3d
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784658090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QxIhtn2ah48as7ELaF8JV+UJyVYET0nxgTQit53oPI8=;
 b=DmNlkJinCwvJrLY08lyclgkCH34Wb8Jppjv9XkXvSt8ZEpzVgtZw4BQeBIpmgivdIrl4pg
 MgF1B8jUo85AqHXkuue8iwldbBL98YamZBaEldott+DDxFcQpYxFFBqvHASqBTm9ok5HVu
 CS7w+SuadIkL4y/XgOv/Hm9eDs+MOjw=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-EHW8TxJ8OwiOc30RnhWN4A-1; Tue, 21 Jul 2026 14:21:29 -0400
X-MC-Unique: EHW8TxJ8OwiOc30RnhWN4A-1
X-Mimecast-MFC-AGG-ID: EHW8TxJ8OwiOc30RnhWN4A_1784658089
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5ab036818efso3406589e0c.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784658089; x=1785262889; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QxIhtn2ah48as7ELaF8JV+UJyVYET0nxgTQit53oPI8=;
 b=FPqr/ARCLN8+Q5ydh3z8DM9o3FGC9naNz24B3ogRwQc7aJezKJQdJrb8FYI4MlFHhy
 /MJGyOxZYTPboKpnKlt+D/X5ou2UX9l4ydg1yIztwm/lpFzJLYs38z4BML3i68A/EG+g
 0coBqaJoqis1tQSFjIFcINQ7O1zmpXTzp3ydiI8dodW3oqqYaWCBGqiAFC9kFiIIWTvn
 1PJZG/0GVzeaB67j6H4L+wBnKb4TqRwx2u8vm6AhMVe20KnZbGjQGZLN60HecUXUU6An
 TXGoqxqg8r+eSb84IxPZGGoLpRS5fcwrKGh1JeVk8qPww6gnVy0tO3ZVEDG7n1pK9eXw
 Sgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784658089; x=1785262889;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QxIhtn2ah48as7ELaF8JV+UJyVYET0nxgTQit53oPI8=;
 b=Pd+vqBGEvUxbymUlUBl9B1MKWX3Yk2EbI/ceFHnqy9vyUmVm7dUU6DdI/N3zwNAy60
 BtJS6YFgvS8D0FZRRWYK3OWTv/s0m6v9DvNxaHCCmiYUbZyfMpXi2siotVdYsoH1Oj85
 8Mj8riibiLYMhbm6XwcmUGDGWl5x30WL/YwFQfT1667pWhgDgbeLbcdgwio+vAd7XWHy
 d7NhZGRmgOgtANbUjKI8Q/+/PFgpeO1WMEtOawhYT3L1lXlJzvxdULAEMkkEc8o91Ch3
 kxlOO1ymmnjxgfqDW3K3CK6poWucuOyZ70yHatq5KOIqPIN6z8fVOqfLqNp1mgkmNGTC
 84EQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3UxSOSUzzdg94L0LauVlCTGrfCY9yPWWHU+x+/rmWcevrMhfKDqKpgh96iMWlukKCOcsBm9AXAu5H@nongnu.org
X-Gm-Message-State: AOJu0YzjpcI5tCwcA/jp/HBPiwuy8YUfjtYM4/qFCLhpLJQGGtXwJfoz
 VQvBg4dgik7bFyApMmhLGHOFEEtvvl/UALyolTuBsV5K1Y92ETwthgLWMZ0AuIZPn30OMKUsy6X
 sEfRmcdmN2uvZ8JoPT8WpAVhnrWQ55Flpn3pZVVb+JsEFatFvt4PpKMgi
X-Gm-Gg: AR+sD12v79FQPOnY01nyOWpEQxdUP+6umcU379Tctuv+OeGxfiyWfG+zkTIckR0UTnI
 u5l1K8gnFCbgKEsb1+6gQWLJpxORwM0a70pegCB8rn9y+V0dYv8dgoJ4AvNd/ZXFOQbig7sKjQd
 +gsInBwhM3KcRvHf68MmY02qczqhMhTolslkwbiCXhy7TYfNiYjDGTR5uyjrpCz5qBYVwnD5tPS
 bBbR0W1IPM8BQ+uoQYejKABEGfjka71LIwVqImeWOlQOntmVWNG8VH5G56mnT0GjI/RItv2QKOL
 9Ac2etLkCLRoFQ1deHrO7psv8Bu8OmCC1eLljgCLtV65GNXl+NAF5Q9QF+dMgYY1BfP/
X-Received: by 2002:a05:6122:4d05:b0:5c1:3ed2:fd48 with SMTP id
 71dfb90a1353d-5c1bf939a74mr5029475e0c.14.1784658088396; 
 Tue, 21 Jul 2026 11:21:28 -0700 (PDT)
X-Received: by 2002:a05:6122:4d05:b0:5c1:3ed2:fd48 with SMTP id
 71dfb90a1353d-5c1bf939a74mr5029465e0c.14.1784658087732; 
 Tue, 21 Jul 2026 11:21:27 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c2c6486f59sm46315e0c.11.2026.07.21.11.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:21:27 -0700 (PDT)
Date: Tue, 21 Jul 2026 14:21:14 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] vfio/migration: Parallelize device state transitions
Message-ID: <al-4mtSxvaaY5PDH@x1.local>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b83e940e-554f-491e-a6ce-db990c4166bc@maciej.szmigiero.name>
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

On Tue, Jul 21, 2026 at 05:07:53PM +0200, Maciej S. Szmigiero wrote:
> On 20.07.2026 16:55, Peter Xu wrote:
> > On Fri, Jul 17, 2026 at 04:31:32PM +0200, Maciej S. Szmigiero wrote:
> > > Inside the VFIO code such sync point for VFIO devices could/should indeed
> > > be created, but then it's not available for these other (non-VFIO) devices
> > > for the purpose of avoiding the regression from the previous paragraph.
> > > 
> > > However, replacing the order priority/adjustment mechanism from patch 1
> > > with the "pre" and "post" handlers I described above would avoid having
> > > that regression (and help fix the vhost-net case too).
> > 
> > I'm not sure I fully get the pre/post handlers idea, I think it sounds
> > working, but in all cases I want to decouple it with patch 1: I don't think
> > it requires patch 1, am I right?
> 
> It wouldn't require the *current* patch 1 but it would need to be implemented
> in some preparatory patch so it would effectively be a new patch 1 (or a set
> of patches replacing patch 1).
> 
> Assuming that we would go this route instead of the one you described below.
> 
> > Now if we want to avoid this "theoretical regression" and solve both things
> > together.. I think we may need to refactor the notifiers mechanism.
> > 
> > Firstly, I hope we're on the same page that essentially prepare_cb() is the
> > priority mechanism here, we only have HIGH and NORMAL priority, where cb()
> > is the NORMAL priority.
> 
> Yeah, I think the current situation could be described this way.
> 
> > We also need to persist depth concept per-notifier, I think we should start
> > by renaming VMChangeStateEntry.priority to depth, add a comment explaining
> > it (on different order of invokations on VM start/shutdown).
> > 
> > But then, I don't think we need anything as complex as pre/post hooks with
> > hashes.  I think you're right then we need SYNC point which can be
> > essentially a priority notifier that is in the middle of HIGH and NORMAL.
> > 
> > Hence, I want to see if below should be the easiest:
> > 
> >    - Rename VMChangeStateEntry.priority to depth
> > 
> >    - Normalize prepare_cb() into VM_CHANGE_NOTIFY_PRI_HIGH, making cb() to
> >      be NORMAL, OTOH.  With this, prepare_cb() needs to be registered
> >      separately with qemu_add_vm_change_state_handler_prio_full().  The
> >      function now should drop prepare_cb() but instead take a real
> >      "priority" value of VM_CHANGE_NOTIFY_PRI_*.
> 
> And where the qdev tree depth will go in a call to
> qemu_add_vm_change_state_handler_prio_full() - as an additional "depth"
> parameter?

Yes.  The rename change I mentioned above should have done so.

> 
> > 
> >    - Introduce VM_CHANGE_NOTIFY_PRI_SYNC, in the middle of PREPARE / NORMAL.
> > 
> >    - VFIO can now register its 3rd notifier against SYNC.
> > 
> > All rest devices will need to shift part of its logic into PRI_HIGH to
> > either quiesce DMA or enable the backend to accept DMA (when on dest QEMU).
> > None of them will need SYNC only if they'll also switch to an async thread
> > model.
> 
> In principle, this *should* work but with some caveats:
> * vhost-net would need the DMA-stopping part of its cb() handler separated
> and moved into prepare_cb(),

I thought this is required with whatever priority impl we will have, even
if I don't think we need to fix it right now unless you wanted to..

> 
> * There's some restore code in "PowerPC sPAPR XIVE interrupt controller"
> running from cb() at prio 0, so originally always completing before VFIO device
> was switched into RUNNING state.
> I'm not 100% sure if it's okay to make VFIO device reach this state before
> that interrupt controller restore code finishes,

Is anyone using VFIO migration on PPC that you're aware of?  If not, maybe
we don't need to worry too much for now.  Meanwhile, this looks like an
existing issue as well.

For the fix whenever wanted, IIUC the intr controller should register both
HIGH and NORMAL priority notifiers, then when VM stop, disable the
controller only in NORMAL notifier, and when VM starts, enable the
controller only in HIGH notifier (we could think about better names for the
three steps, maybe it shouldn't be called as "priority" as well even if the
executions will be strictly ordered).

> 
> * The postponed dirty memory logging stop handler also runs from cb() at
> prio 0, so currently always finishes before VFIO device was switched into
> RUNNING state.
> This handler also stops DMA logging for VFIO device or its container,
> but here I presume it should be safe to do so while the VFIO device has already
> started dirtying memory even though this couldn't happen in the existing code?

It's only stopping the tracking, results of the tracking shouldn't matter
anymore on whether some DMA was trapped.  It looks safe no matter where we
put it.

> 
> * There's some sync/setup of x86 vAPIC state (for 32-bit guests?) also running
> from cb() at prio 0.
> Not sure if this needs to finish before VFIO device gets switched into
> RUNNING state.

Doesn't look relevant.  IIUC, only anything that is DMA capable can be
relevant.

> 
> These 3 possible issues above (besides vhost-net move/refactor) could be
> theoretically worked around by moving these callbacks from cb() to a new
> priority *before* VM_CHANGE_NOTIFY_PRI_SYNC (maybe called
> VM_CHANGE_NOTIFY_PRI_SYNC_BEFORE or similar) as I presume they won't need the
> VFIO device to reach DMA-accepting state but at the same time they shouldn't
> delay the launch of VFIO device state changing threads from VM_CHANGE_NOTIFY_PRI_HIGH.

IIUC we don't need a 4th step here, correct me otherwise, while the 3rd
SYNC was only needed for VFIO's threaded approach.

> 
> Also, the final VFIO thread joining/collection does *not* need to be ordered
> with exiting cb() handlers, so it should really run at VM_CHANGE_NOTIFY_PRI_LOW
> (below PRI_NORMAL) for best parallelism.

Yes. VFIO device only need its SYNC / MEDIUM priority notifier be ordered
with NORMAL notifiers, to make sure all VFIO devices switched to P2P state
before the NORMAL notifiers.

> 
> The disadvantages of this overall design are that it would need coordination
> between different sub-maintainers, increase the "blast radius" of the patch
> set to different parts of QEMU code, and so obviously would be more
> regression-risky than the aforementioned "pre" and "post" handlers design.
> 
> Especially that probably few people would be able to test, for example,
> the PPC XIVE case with VFIO.

We shouldn't justify a solution by "how many subsystems it touches".

I was suggesting to solve one problem at a time, but then prepare_cb()
already does it.  You pointed out there might be real regression on VM
start path, I agreed.

I thought you wanted to fix all things, which I'm ok with and agree it is
better, then it's unavoidable to touch all modules.  But yes, we need to
reproduce the problems and verify the fix.

The middle ground is we define the notifiers to suite for the solution we
think will fix everything, but you only need to fix VFIO and leave the rest
for later. We can discuss the problems in the cover letter or commit logs
for future works on top.  After all, in this case of VFIO to do the right
things it does need three steps / notifiers.

Thanks,

-- 
Peter Xu


