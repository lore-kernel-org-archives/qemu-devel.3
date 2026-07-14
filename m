Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3493C4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 17:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjgbD-0000Fr-Rh; Tue, 14 Jul 2026 13:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wjgb7-0000E5-4Z
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 13:07:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wjgb4-0003wn-32
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 13:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784048822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QwGWl11gAh3+SndohW7H1aRAx+s3e94g9KFM1eF5I3o=;
 b=eNhccyyy4b3Td+vrEteAcLlKy6cxaLr8Xi7rzXkJCl4LVN76SXjFL42GM8B9CSCwswpCRx
 BhAUzjETLX39yrjuqHH3eDMEjWytOt0TMatUo42mt9w+eiw19B3T8Db2b5iBMKb4wXT5ih
 +4aVazkfGxJlWI56qi5htGN6GomEEGo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-kAkEvkClPs6GqbjCfCa0sw-1; Tue, 14 Jul 2026 13:07:00 -0400
X-MC-Unique: kAkEvkClPs6GqbjCfCa0sw-1
X-Mimecast-MFC-AGG-ID: kAkEvkClPs6GqbjCfCa0sw_1784048820
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e66f9e2baso180413085a.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 10:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784048820; x=1784653620; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QwGWl11gAh3+SndohW7H1aRAx+s3e94g9KFM1eF5I3o=;
 b=kZgRo49NsJv9IN0fJGXhOj5SkoVHBoowS0seeIRkN5o1VjHf2zF+G6hR8BYsOiKEhn
 nRRhrKXv6IGRLxoaD1pWaGjxYEABfaM4rER/4BW7k+t8yb98IPvfN9e2sAMvaYpE3oM7
 IX6UnaN9NBlPAQ8gdVfQyA9CYCCunGS95ioZ8RdP5mO+Pc1UtvB9tIdRSM87EaUNa/7J
 XMIpqbb7qwe0lijhDaESk5YZ5+RBKlh2DAOgXupyrEYt84KSVcRufnlaON+FMTUasXgn
 E1Xt4eB0x0v1e6snP0k7tbrpGpw9FELAEy3vKEYn1P3hhttgE+ozrECiSTvSGprG1ooR
 pfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784048820; x=1784653620;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QwGWl11gAh3+SndohW7H1aRAx+s3e94g9KFM1eF5I3o=;
 b=I3RDJO9UTFHihm/PqXqYPX3nx6Px+GHo/l7C2CCK6tKqh/btxY+NLHY1CR7rekqqLn
 YmXfLBtxZ+LT1RyDg0j/pOZ+oZtp9wwQKUWXGnnLZNjvc36WQmHeLyFdAotMtKFKCyfh
 SBsUuNKdLYYj9wGOr3AN/UOf0Sk0tljiV3hEl9hV+ulsTz+8rfFNalVAMd7krCBHtTUw
 77/gCEd2LPwrGPyRnCxi/mJl72z/M2sVc4Va82WqaJEnOdK7j9MlP4KUJoYhKjZFYYn3
 aMKqugTEFFcj5LscifacxYJQfyyuPPMbNl89wymaFcWg/5RQjDh9ujAXVKE+MLzFKYb8
 dnjQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrt1nKxbIZArEGVvoaiYkQgx7NYQT4TWf6jcCMh+ilIYANF7671gsq9iqDS6dUyuJW2QHnbWHJMXWnc@nongnu.org
X-Gm-Message-State: AOJu0YxWMIX9tSCjcgix167EZQrxVLnY9fOcrlmTJWIUBF4Fgi0KU5Rm
 gQaQRQMJVfUQfjNfba4m+AMjJojMEP3PCJYzgAZ8gUpKbhGolzE4rlOlkDNVHGMTaUVS+bGLoMi
 ooUAgBhH1LEsi6o5HM85YTnEXzdWY+4dwZH9F3RoA6/qQZ9tU2JIxTnTX
X-Gm-Gg: AfdE7ckL1e9mghM5CzlyrWCNbIOReLHUpj1kJCNSg1pC2zovaLfrcEizaiRjUU/6v1z
 V2Uj41vI/6ik8VT67og8rmANmI18AW8ift8I163tT5Sbj8asb7teSlvIhFP0i2S7ZppeTe4ADu5
 /f2zRVIFG3tCIUz/0EkzFNFSCs+QRheJxDQnXMgTu5Xrt++ufY73wtNAlBUPKXP1E8Qo7cPm6Dl
 +R8Xnh+XEAhwNhj4mgzbW37cdo6UUUlySO6AwqIwtsQZQnie8VIBRCyx2hgFR7prJ3UN9TPaM8u
 Z4NZmAs+kXzzyrPPloeYFdG9OG2MGbDs1q0lamvxFrjQDM9WNmckLdfAXSQTzvs8Ra/XPhhZy+1
 4OhykqYHiZH8yR63zsvfxFrJqQsnzEOWT0fd2fzcTnVVsv6F2PERwnXCEUTgmpDIuY/eDUw==
X-Received: by 2002:a05:620a:2601:b0:92e:e314:c9ca with SMTP id
 af79cd13be357-92ef2c1fa96mr1434128085a.52.1784048819752; 
 Tue, 14 Jul 2026 10:06:59 -0700 (PDT)
X-Received: by 2002:a05:620a:2601:b0:92e:e314:c9ca with SMTP id
 af79cd13be357-92ef2c1fa96mr1434120885a.52.1784048819013; 
 Tue, 14 Jul 2026 10:06:59 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5b4920asm1453042985a.4.2026.07.14.10.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 10:06:58 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:06:56 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] vfio/migration: Parallelize device state transitions
Message-ID: <alZssI9OmGJyD-rc@x1.local>
References: <cover.1779217494.git.maciej.szmigiero@oracle.com>
 <743f03758d2a30df4093db140ccdd0f91f69bd7e.1779217494.git.maciej.szmigiero@oracle.com>
 <871peqtm5t.fsf@suse.de> <ah3eheRXN1QJAGj_@x1.local>
 <ac677bf9-1372-4905-a0b8-874a74be07be@maciej.szmigiero.name>
 <ah86Z0r5sMnxwgo-@x1.local>
 <c739f4fe-1f43-45c4-b98f-109366526405@maciej.szmigiero.name>
 <e79a3746-9c7e-46a5-ad81-537b9d3affdb@maciej.szmigiero.name>
 <akvWlciUvxjDbBBZ@x1.local>
 <e602d0cd-dfc2-441d-a017-067e55418dad@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e602d0cd-dfc2-441d-a017-067e55418dad@maciej.szmigiero.name>
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Jul 13, 2026 at 10:23:07PM +0200, Maciej S. Szmigiero wrote:
> On 6.07.2026 18:23, Peter Xu wrote:
> > On Thu, Jul 02, 2026 at 08:36:32PM +0200, Maciej S. Szmigiero wrote:
> > > I looked more deeply into this and even prototyped a similar new design.
> > 
> > Sorry for a late response; off work most of last week.
> 
> Also sorry for my late response - was extremely busy the entire previous week.
> 
> > > 
> > > However, in the end I think that running VFIO state transitions in
> > > parallel with other non-VFIO cb() handlers just isn't safe.
> > > 
> > > For example, on the migration source, the second transition is
> > > PRE_COPY_P2P -> STOP_COPY.
> > > PRE_COPY_P2P is the last state during migration that still allows the
> > > device to accept DMA and similar interactions, while STOP_COPY is
> > > already the "quiescent" state.
> > > 
> > > So if a VFIO has already reached STOP_COPY but a non-VFIO device
> > > callback still hasn't finished, then any DMA/MMIO/P2P transaction from
> > > that "unfinished" device to the VFIO device would now hit a VFIO device
> > > that no longer can accept such transactions.
> > > This may result in hard-to-debug memory corruption during live migration.
> > 
> > Do you have any solid example of this problem?
> > 
> > AFAIU, P2P in VFIO state's term only means P2P DMAs _between_ host VFIO
> > devices, nothing to do with emulated.
> 
> I presume that quiescent VFIO devices can't accept *any* DMA, the spec (vfio.h)
> even says that:
> > The user should take steps to restrict access to vfio device regions while
> > the device is in STOP_COPY or risk corruption of the device migration data
> > stream.
> 
> Correspondingly, I think the same goes for RESUMING state on the migration
> target since it is described there as:
> > The device is *stopped* and is loading a new internal state
> 
> While you are right that the spec only talks about P2P DMA I don't see how
> host-initiated DMA would be different here - after all, it's about changing
> internal device state in a state where the device can't accept that anymore/yet.
> 
> > I am not aware of any P2P that can be initiated from emulated devices, even
> > if it exists, it is only P2P from guest perspective not host: it will
> > become host operations finally from processor side.  I really don't think
> > it's a concern.
> 
> Yeah, it's normal DMA from the VFIO device perspective.
>  > My limited understanding of VFIO's P2P state is: when switching to P2P
> > state, the VFIO device can still accept P2P DMA from other devices, but
> > never initiating P2P DMAs, and the latter sentence is critical, it means
> > the real quiecent state of the whole system happens after the last VFIO
> > device switching to P2P state: then it means none of the VFIO devices can
> > initiate P2P DMA anymore, whole system is quiesced.
> 
> Just having the VFIO devices in the system prevented from being able to
> initiate DMA is not enough for them to reach "quiecent" or fully stable
> state as long as there are other possible sources of DMA transactions
> targeting them in the system.
> 
> Glancing at the existing vm_state_change handlers there are some
> concerning ones there:
> * vhost-net (called via virtio_vmstate_change() in base virtio-net),
> 
> In the vhost-net case the vm_state_change handler for this device
> ultimately reaches vhost_net_stop() and do_vhost_dev_stop() and these
> seem to stop this network device rings at this point.
> 
> Now, having vhost-net packet buffers in a VFIO device MMIO BAR would
> be rather atypical configuration, but nevertheless letting VFIO
> device possibly reach "quiecent" state before this handler finishes
> would theoretically be a regression.

If this is an issue, it was an issue for master branch too, right?  Because
the master branch (with prepare_cb()s) already switch to P2P_DMA state for
all VFIO devices before invoking any cb().

It is also an issue then even before P2P_DMA state introduced, because
before that all cb()s can be run at random orders.

What you said might be an issue indeed in that extremely corner case, but I
think it still needs some justification, and it's IMHO orthogonal to what
we're talking about.  If it's an issue, maybe we want to fix it first
before attempting to move further to any concurrent approaches, but is it
really an issue is to be better justified.

Applies to all below.

> 
> * virtio-blk virtio_blk_dma_restart_cb() vm_state_change handler
> submits some block requests to its (possibly dedicated) IOThread.
> 
> Again, having block device request buffers in a VFIO device MMIO BAR
> would not be a typical configuration, however letting this handler
> run before making sure that VFIO devices can accept DMA would
> theoretically make a regression too.
> 
> * same for scsi-bus scsi_dma_restart_cb() that does
> scsi_dma_restart_req() for each pending request.
> 
> 
> The above is not an exhaustive list, these are only the cases
> I was able to identify relatively easily by going through the
> code.
> And I think that with possible memory corruption issues its better
> to be safe than sorry, as they are pain to debug.
> 
> The only real non-VFIO cost of being safe about all of this is
> ~15 code lines addition to vm-change-state-handler.c, all the
> remaining complexity is already on the VFIO side of things.
> > That happens earlier
> > than reaching any of the cb()s here, because VFIO's prepare_cb() does that
> > P2P state switch.
> 
> I thought your proposed design was to launch (per-VFIO device)
> device state changing thread in prepare_cb(), make it do *both*
> VFIO device state transitions and collect it in cb()?

The idea was only about trying to leverage prepare_cb() to achieve real
"prioritized callbacks" for a device, based on patch 1 being problematic.

What prepare_cb() does can be anything.  Certainly, we can make it only do
step 1 then in cb() kick all threads to move on to step 2, and sync again.

> 
> In this case the transitions are *NOT* ordered with respect to
> other cb() handlers (besides them being finished by the time
> the VFIO device qdev tree depth cb() handlers are reached by
> virtue of the threads being collected at this point - this is
> actually necessary in order to preserve proper ordering with
> respect to some types of interrupt controllers on the source).
> 
> So on the migration source the thread could already put device
> into "quiecent" state by the time other cb() handlers could run
> and on the migration target the device could still be
> in an "unprepared" state by the time other cb() handlers are called.

Thanks,

-- 
Peter Xu


