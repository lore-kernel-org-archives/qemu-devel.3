Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C705DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjBQH-0001OL-Gv; Mon, 13 Jul 2026 03:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wjBQ6-0001N7-UO
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:49:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wjBQ5-0003x3-37
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783928979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=famqP7taRR5ZjapK8qDSDnVO++BEsHGt74HS8yNgY/0=;
 b=E5TUprGw1wl1ZPvUv7I6zt432LES7XiYzSM1qQfAWOUX+M+phD5WqPU5RA4Km+FTriUQCR
 nGVe9RfPY7n7rHfOLOCBich71KZSyqjifY8HO7cyBslqIa72IvF+pqA1xdNCAFCFROCyjE
 IoUOLKIXAnBVM0JBxStewFONWa6m2RM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-4ydOLPaPOoGr8xeRlb94Pg-1; Mon, 13 Jul 2026 03:49:38 -0400
X-MC-Unique: 4ydOLPaPOoGr8xeRlb94Pg-1
X-Mimecast-MFC-AGG-ID: 4ydOLPaPOoGr8xeRlb94Pg_1783928977
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493bf840a69so20458065e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 00:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783928977; x=1784533777; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=famqP7taRR5ZjapK8qDSDnVO++BEsHGt74HS8yNgY/0=;
 b=VpHF3gVKPT6h0wAOMPRNgdoE4bsP08NN2GicZLM1/u8kzSZiDJsaOHbuuDhCbmrBGi
 R/fA0wSkTMPX8eg0taH3TvjGU+mNkTUT9xg9wK2TBaf1aewpY4SLdXcdyEp2xwykS27R
 fzowaxTESqN/3Q3cc6vuOTh67SeG3IysMZW4xdqkvrcp2JfiXZx3Cj3ZRVRcoQQGYymO
 opPfF+UXtUzam/gO86JsbtnFXup/DolX+Omsb+JBb+wE9GLPBBHqy6M2FXOaA1n/snwm
 m5l4sVDJ2HDhew+HHLsMv0S20qUkmuuXFpNcKgrKghvVMLJ0X/Re/Ouy7sdlPbIhvBvw
 nIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783928977; x=1784533777;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=famqP7taRR5ZjapK8qDSDnVO++BEsHGt74HS8yNgY/0=;
 b=hhtgocM+kat0MgjiRE3HUq/kFlNFA7bsXVtZLImGCIT2G1Sa0dXcRiB6HFDaWFx/9R
 4+c9cSRNMe25IFUzCsxuC7r/ZdP8/3LT+s4gw1BixWb1No93MAx0CCycw693eaorGHby
 dFohVhEjbU2KsmTXr4j+jH9wJj1YsC2glAyYHeSQTVmi5rpkazrttzM43qRBzIfo1qZO
 8E7jZyOszCEUNQZely1oxgV9sEeYPoDRFc1QdqT2wYInewXAbzMq4SsE/5D2yKFdo2P2
 CKf3f1r+GBsh7saPlzpMpkRcdpS2CRCjmgutF7NPe9y0D4devwRe12Kwfs3agMxNbpea
 qLLw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrjQ+jRKAOAcfl/1TjDQw11CUFnM7NemI//dgmw+dcp/tuiOkP5tN0n1MA7Edaelm40Jcbe6kqdIrwD@nongnu.org
X-Gm-Message-State: AOJu0YwhEmXyCdUw8/tOzLzeAG0x0+C2FlI0YVpiahDzRM3nOuqzchDy
 cXmSBKktPZbdZyoEe0soNm677L4a7o1ccUoda6RmIQaUGefw9orpPpR8GXD0Bewb9uJ43nazqym
 jPEDKOXTIc4xfx2Qmxa8bmGp9ZJ4qthzSVvD3OXdXSw0clE4PuFrrc2+I
X-Gm-Gg: AfdE7cno2z/xmKb1RrInuEZupnrLhJPKQZtxa/RYF6mwQI8Vn85526X9prVh6O/53iJ
 pRfGSfllsd9BPgj/qGpPFrWgGYmcs15J/djJESgrAIJdlioCamqJCvaFdTttJYFh109KzCtIpI6
 WlVqDqyp9t0Jh5dp0inmOPk0oO4BADD2BvE0aCKQTSKKeWP+x8Xn0rNM82bHMZeWe4IeX+5vrHS
 NGIKSGrf4rDb3f8RgazKDsyZA41+LjaR/U2WkdsLPmS2rQCG013vRfU8AAn/Y9s+BofDFa1mS5I
 2mFpChamOCnCoKZCXElJf7IvSCifrwRniVqzOcl4dl5HZ+pKTg8BOyqprRgH4/RpLd8tNAg=
X-Received: by 2002:a05:600c:6994:b0:493:c478:8744 with SMTP id
 5b1f17b1804b1-493f8819181mr78358715e9.18.1783928976874; 
 Mon, 13 Jul 2026 00:49:36 -0700 (PDT)
X-Received: by 2002:a05:600c:6994:b0:493:c478:8744 with SMTP id
 5b1f17b1804b1-493f8819181mr78358545e9.18.1783928976452; 
 Mon, 13 Jul 2026 00:49:36 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6ea082sm371595375e9.11.2026.07.13.00.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 00:49:35 -0700 (PDT)
Date: Mon, 13 Jul 2026 09:49:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Jia Jia <physicalmtea@gmail.com>
Subject: Re: [PATCH 2/3] hw/9pfs/virtio: disable hotpluggable property of
 virtio-9p device
Message-ID: <20260713094935.5eda77f9@imammedo>
In-Reply-To: <alEEROvr0gbuWCB2@redhat.com>
References: <cover.1783604079.git.qemu_oss@crudebyte.com>
 <2355649.iZASKD2KPV@weasel> <20260710145149.6e077fdd@imammedo>
 <2055091.yKVeVyVuyW@weasel> <alEEROvr0gbuWCB2@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=imammedo@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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

On Fri, 10 Jul 2026 15:40:04 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, Jul 10, 2026 at 04:31:51PM +0200, Christian Schoenebeck wrote:
> > On Friday, 10 July 2026 14:51:49 CEST Igor Mammedov wrote: =20
> > > On Fri, 10 Jul 2026 12:49:06 +0200
> > >=20
> > > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote: =20
> > > > On Friday, 10 July 2026 12:23:45 CEST Igor Mammedov wrote: =20
> > [...] =20
> > > note: I'm looking from pov of hotpluggable PCI device and generic hot=
plug
> > > infra, only. =20
> >=20
> > That's okay, but so far I don't see the relevance for this particular 9=
p=20
> > device.
> >   =20
> > > it's not guest users directly, it's how hotplug flow works for variou=
s guest
> > > OSes:
> > >=20
> > > 1. host plugs device in (-device or device_add)
> > > 2. guest OS get's notified one way or another and does what ever gues=
t side
> > >    init needed (incl. mounting share in 9pfs case) =20
> >=20
> > That's not affected by this patch, right?
> >  =20
> > > opposite flow:
> > > 1. host does device_del (basically notify guest to remove device)
> > > 2. guest OS frees resources and tells qemu to delete device
> > > 3. qemu process remove event (which incl. unrealize as part of destro=
ying
> > > device) =20
> >=20
> > And that's not affected by this patch either, right?

the patch would break unplug flow by effectively removing 'eject' knob=20
from guest side, which is part of unplug flow.

> >  =20
> > > Of cause guest if free to eject device without signal from host, =20
> >=20
> > OK, here is the point where we deviate: you are apparently seeing this =
from a=20
> > purely theoretical PoV.
> >=20
> > I am facing reality: for several years I'm the only person taking care =
about=20
> > this piece of code at all (on a side channel, for free, next to my actu=
al=20
> > work). And for several months I get AI generated security reports throw=
n at=20
> > me, where I have to a) filter legit ones, and b) fix those legit securi=
ty=20
> > issues.
> >=20
> > For that reason, I am tightening security wherever I can, to prevent fu=
rther=20
> > flood.
> >=20
> > So the question here is: are you concerned about a real-life issue bein=
g=20
> > introduced by disabling hotplugging for 9pfs specifically?

my concern is that there might be users that use unplug despite present bug=
(s),
and the patch would regress their usecase.

If unplug 'works', then we shouldn't disable it.
If it's never worked to begin with, it should be safe to disable it.

> > > (I could imagine: get some file from share once and then guest releas=
es
> > > no longer need resource). =20
> >=20
> > It's a pass-through file system. Ejecting the device does not really fr=
ee a=20
> > noteworthy amount of resources.
> >
> > > > Looking at the fixed issue (patch 1), my impression was that origin=
al 9p
> > > > server developers were unaware that guest can actually trigger a de=
vice
> > > > unrealize via ACPI eject. =20
> > >=20
> > > I'd say it's a bug, and you are trying to fix it in patch #1
> > >  =20
> > > > Most probably because hotplugging is enabled by
> > > > default for all devices in QEMU =20
> > >=20
> > > it is on by default for PCI devices but also heavily depends on used
> > > configuration (where/what is plugged). =20
> >=20
> > Exactly! And I was trying to explain, that for this particular use case=
=20
> > (9pfs), I don't see any real-live use-case for allowing a guest to ejec=
t the=20
> > 9p device at runtime.
> >=20
> > So why allowing it? Just for fun? =20
>=20
> I don't think it would be usual for a guest to unilaterally "eject"
> a 9p device. A host initiated PCI hot-unplug request from QEMU
> would ultimately trigger the guest eject code path though. IMHO
> host initiated hotplug+unplug is a valid use for any device. For
> 9p the use is to provide a time limited data share to some workload
> in the guest. There are many other ways that can be done too,
> USB MTP, or virtiofs, or in guest with SFTP or WebDAV, etc.=20
>=20
>=20
> With regards,
> Daniel


