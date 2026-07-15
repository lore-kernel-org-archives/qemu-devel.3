Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C35C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 22:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk8Mo-0001SD-It; Wed, 15 Jul 2026 18:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wk8Mm-0001Ri-VI
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 18:46:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wk8Mk-0004BY-MT
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 18:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784155566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z6g4897i3DZ3SUUwDsLrjurEgc9DjGy1G2XAg6tAjnU=;
 b=UP983zNqv5iqV2CvIav27IWAbNLb5gNfSRTd5VnBwxYsROon+FOqWuqv2HTCkyZN0zi40g
 1qeNmd6oCCPRhVbah1EPpoRFnSkCxFHCbvN0is/HgwHX793gvixIftyJfdls2cfUKgJfRu
 5MCFvUjT/8YE294uX/DwkLKv8L5SuuU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-VWWgnH0uPoisUZ5LAQe0EQ-1; Wed, 15 Jul 2026 18:46:04 -0400
X-MC-Unique: VWWgnH0uPoisUZ5LAQe0EQ-1
X-Mimecast-MFC-AGG-ID: VWWgnH0uPoisUZ5LAQe0EQ_1784155563
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4731a357b0aso2535688f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 15:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784155563; x=1784760363; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z6g4897i3DZ3SUUwDsLrjurEgc9DjGy1G2XAg6tAjnU=;
 b=I2JlzozSc5Q5Uks//9j6rmf3mTSmuxFlEkVG4QHFmyihkxwV8+MoqyQXtkVQSyeDwp
 b5xoJK4/AO96ue11k7cYHrL3tsC533bSxzVTxHpkhHBk1epNFH6U0iacIrUfHZBXxA7I
 7SuUdGcZ6C6oFrBcHDLEknzf4HNxyR6OXcTk746Z3a11RR77+2rxFgXwQj84fvUJoAR6
 BylSEGL+nsqXjbdXACguJlWox7APh1+xOrA7lnbyZ0bJvmMbEBLqBOIX4+i8rxB4mETn
 CDmE+8xodgloHSrYGgLg92EttWwMqt7gq7xhaVBKDsK6hJ1ogN3bnBR/8KXVERWxa3UO
 82Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784155563; x=1784760363;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z6g4897i3DZ3SUUwDsLrjurEgc9DjGy1G2XAg6tAjnU=;
 b=c5QtErmyvj9p9MOS9AusaHHk135UtehDZa4LgiPaZSZ3dhME+CuvMZGVVVXG1XUskK
 oqO1PQeFPvIUj02oULa+VNr5UOBaO1mo1TcZRzOOK+EbK7CyRdB6SHdUO0kfeMPrqoo1
 I8YDe9clQSAavApfGhlRLAWjs2+tOWoLaNKHB46TqQju3gnOgQkp2MKpUb5VYUH0BAYY
 9HJcDXRjM65/FGmOf/rughKPw4VG9B9pGt0WZTqKX+DIBlsNi574H9nk2BBc95TrGLcr
 KcslAwcMuwDEKzXmgXNKuzfWqi/TTJwSW8vZIRxJe863YoTIMx9Ab7A+q2JYgipJ8eDH
 AXBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZ4ry6kaw2Sv7T9xvNsmNdOvrqaVMzUWvEcItNh92igBWquzpGPO4Dowq2JA9fe7443us4OfVEboQ/@nongnu.org
X-Gm-Message-State: AOJu0YwukgdJJsf9CwTYGwkSXH1FY34Zn9lk4exkqw0EAMIvbtotAR2n
 EXg4EnDFAmjCNb+TXfN626LEdodoAaSFkvI9P4uEbvee5uaK65iam3wyoILRlBpDYdWAIGeZngC
 7ZJ2eod42N03feDAzKZCGgaOC2osEL4e05ohH2pVNYr+Pd0AQClXyUDA8
X-Gm-Gg: AfdE7cnp3MF7J++i/jJPhpBCeEaO/eYgTABDKwjqBmsrA0F4f3VxJ87IGd/eM04gR0q
 7eTj4erWVqP9vAX6fqWNLyGgQMsIqVxjvZhcYV+ZV6fLUm1Bqt5T2v6i/Vg9rJ+SiY8jR4BCFrA
 lp1SmuYaAhiMBOePSgAFVAdqfxr6Zz6Zyv4kZ3HzMOKJapd8zGIUQaXKu96Xsci7dswU8fOVW5t
 qimp3D8btGy97hHfRgbeHv6MZ43NS5dhe++PiP2LOdtS4MbsPz4CRDZ/crW1X8IShqSSLcZoHD9
 Ffbbcl+RqaiIX1S+GXTVZPcJgru+S85I8PmLd3DbP8DleW62zS7esCco/3rgWjRUl5f1/XKSzmS
 Dt+XJRZVBKycqPPY/6RPou5Zr
X-Received: by 2002:a05:6000:2997:20b0:47f:538d:87b5 with SMTP id
 ffacd0b85a97d-47f538d87e0mr2538193f8f.34.1784155562920; 
 Wed, 15 Jul 2026 15:46:02 -0700 (PDT)
X-Received: by 2002:a05:6000:2997:20b0:47f:538d:87b5 with SMTP id
 ffacd0b85a97d-47f538d87e0mr2538178f8f.34.1784155562399; 
 Wed, 15 Jul 2026 15:46:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a973fsm20807169f8f.17.2026.07.15.15.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 15:46:01 -0700 (PDT)
Date: Wed, 15 Jul 2026 18:45:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Peter Xu <peterx@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, jasowang@redhat.com,
 armbru@redhat.com, farosas@suse.de, raphael.s.norwitz@gmail.com,
 bchaney@akamai.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com
Subject: Re: [PATCH v19 00/15] virtio-net: live-TAP local migration
Message-ID: <20260715181555-mutt-send-email-mst@kernel.org>
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <fa53bef0-4fbd-445a-9395-379bbfcb3773@tls.msk.ru>
 <20260715114802-mutt-send-email-mst@kernel.org>
 <ales0BaHaS0ZgA2d@redhat.com> <aleut_YyeS_YeYus@x1.local>
 <142f9286-bbc7-4aed-8822-5d560a09daf9@yandex-team.ru>
 <20260715163116-mutt-send-email-mst@kernel.org>
 <d62fa0f5-4339-49e1-aeef-85196561a94e@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d62fa0f5-4339-49e1-aeef-85196561a94e@yandex-team.ru>
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

On Thu, Jul 16, 2026 at 01:11:05AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 15.07.26 23:32, Michael S. Tsirkin wrote:
> > On Wed, Jul 15, 2026 at 11:21:23PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > On 15.07.26 19:00, Peter Xu wrote:
> > > > On Wed, Jul 15, 2026 at 04:52:48PM +0100, Daniel P. Berrangé wrote:
> > > > > On Wed, Jul 15, 2026 at 11:48:40AM -0400, Michael S. Tsirkin wrote:
> > > > > > On Wed, Jul 15, 2026 at 06:01:39PM +0300, Michael Tokarev wrote:
> > > > > > > On 14.07.2026 18:42, Vladimir Sementsov-Ogievskiy wrote:
> > > > > > > > Hi all!
> > > > > > > > 
> > > > > > > > Here is a migration for TAP net backend, including its properties and
> > > > > > > > open fds.
> > > > > > > > 
> > > > > > > > With this new feature, management software doesn't need to initialize
> > > > > > > > new TAP and do a switch to it. Nothing should be done around
> > > > > > > > virtio-net in local migration: it just migrates and continues to use
> > > > > > > > same TAP device. So we avoid extra logic in management software, extra
> > > > > > > > allocations in kernel (for new TAP), and corresponding extra delay in
> > > > > > > > migration downtime.
> > > > > > > 
> > > > > > > This is quite a big patch set, - is this really worth the effort to do
> > > > > > > all this just for *local* migration?  What's the possible use case for
> > > > > > > this in real, - am I right this is just about upgrading the host qemu?
> > > > > > > And with that in mind, isn't it sufficient to use what we already have
> > > > > > > (namely, create new tap, start new qemu instance, and migrate the usual
> > > > > > > way), and tolerate some very minor downtime while the networking code
> > > > > > > learns the new network topology (isn't it happening almost instantly
> > > > > > > anyway, and if not, the management can help by sending gratitious ARP)?
> > > > > > > 
> > > > > > > I wonder what's the use for this at yandex?
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > 
> > > > > > > /mjt
> > > > > > 
> > > > > > Well just theoretically, imagine a big VM, reserving twice the amount
> > > > > > of memory just to migrate is not nice at all.
> > > > > 
> > > > > Don't we already have the ability to skip memory transfer by setting
> > > > > the "x-ignore-shared" capability, assuming the VM RAM has a shared
> > > > > memory backing.
> > > > 
> > > > Right, IIUC all similar single-host migrations like this series or CPR (or
> > > > anything else...) should always need to enable x-ignore-shared in the first
> > > > place.  That's almost always the starting point of optimizing local
> > > > migrations.. no matter how the memory will be shared (by the same pool of
> > > > page cache, or persisted over kexec, etc.).
> > > > 
> > > 
> > > Yes, sharing RAM between source and target + enabling x-ignore-shared is a first thing to do.
> > > 
> > > This series optimizes TAP recreating. Not only skip recreating but also allow to
> > > exclude cloud-networking component form live-update entirely, making the process
> > > simpler (less components involved), and as I already said, reducing corresponding
> > > downtime.
> > > 
> > > -- 
> > > Best regards,
> > > Vladimir
> > 
> > So can you explain, how is this better than
> > 1. a persistent tap
> 
> You mean open same tap device both on source and target?
> 
> This will require some additional steps anyway, to avoid packet loss,
> like keeping queues disabled on target until post_load.
> 
> Another thing is MAX_TAP_QUEUES=256 in kernel: this is a problem, if you have more
> than 128 queues already opened on source. Seems cleaner just pass already opened
> queues to the target.
> 
> And finally, on hosts with many CPUs, TAP queue allocate noticeable amount
> of RAM, so having x2 queues during migration would be an overhead.

ah I forgot. yes queues do get 

> > 2. a non persistent tap that some server gets a hold of
> 
> You mean, just pass FDs externally, instead of using QEMUs migration stream?
> That's possible. But requires mgmt tool to store (or get from source) and pass
> these FDs. Requires mgmt to even know about these FDs.

e.g. libvirt already does, right? it creates them?

> But why? QEMU already
> can pass FDs through migration for vfio devices (CPR), why is TAP worse?

it's not that it's worse. it's that we are growing bespoke mechanisms so far.
so if qemu gets tap fd on command line then what? how does that
interact?

> Like with persistent tap, it will require some changes in Qemu anyway, to avoid packet loss
> (like patch 12/15 here).

that one is more like a bugfix.

> > 
> > IOW why does qemu need to bother.
> 
> QEMU owns the TAP fd and has full knowledge of its state. Pushing this responsibility
> to an external tool means the tool needs to understand QEMU internals just to pass
> an fd that QEMU already has. I think, that's a worse separation of concerns.
> 
> Of course, there are other ways to do TAP local migration. But looking at wider
> picture, where we want to migrate not only TAP, but also vfio devices (already
> implemented as CPR migration, but may be updated to use similar approach as in
> this series, to use one migration channel), vhost-user-blk (my another series
> in flight) and vhost-user-fs (not yet published), vhost-vsock migration
> ("[PATCH v3 0/7] migration/cpr: support vhost-vsock devices" in flight series),
> it seems a good generic approach: simply pass backends (including open FDs) to
> the target, not involving mgmt. Qemu has full knowledge about these FDs and
> owns the whole state. Migrating them in QEMU looks correct for me.

if you find a way to generalize things and reuse them for your
purposes without intrusive changes all over qemu, fine.

But this one is poking as far as frontend code even.


> -- 
> Best regards,
> Vladimir


