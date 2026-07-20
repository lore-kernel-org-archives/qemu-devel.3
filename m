Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BCFC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlm68-00064H-9Q; Mon, 20 Jul 2026 07:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wlm67-000645-1l
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wlm65-0006kU-4y
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 07:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784546623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CaYT/hlQebVBBjWxo6yEYllRtoTGR+8HUzobQBXo5no=;
 b=KMOIgeK559N09Nm2uGjqwWCvoHrNp9JLi3wmSbBjs92IQ5cVTHmAWWXQg3uQQ/yqO7Dc1r
 6N4hIbH5jLZGiFSQ9S6ZAFPFOBLfHHjWxsTAyvjCLRKfwTmeblD/osNvv8kVkPfl+CjE5e
 /nYQroub7irBL8x4rMpnD+YC87tyIQw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-mdQDlRxHO06JHGaAgR1--A-1; Mon, 20 Jul 2026 07:23:42 -0400
X-MC-Unique: mdQDlRxHO06JHGaAgR1--A-1
X-Mimecast-MFC-AGG-ID: mdQDlRxHO06JHGaAgR1--A_1784546621
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4955ecd8a10so5154205e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 04:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784546621; x=1785151421; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CaYT/hlQebVBBjWxo6yEYllRtoTGR+8HUzobQBXo5no=;
 b=tlxmlrK7nWKQxA75rnj4/5fDJLCPdyF9GVjIwGcnSTOUX1+RhYKiPveYQZwZ0GebB3
 7MLSEpguK1rlS2EornPozsEZTE2sGSpmAcSDkP6nYnYYQQL0BsTTyFx4EHLNVg/RVF0C
 86F54MRa+HeL2FdedW8FDkXw9plahDf/7maRhWOV8+21g1CSVJvjypYS4a7QdXWRutRj
 Cbkq1a4RrP+dqnMf8CxOC04zZx2DfNEPlvvbcG/EbUl9F7ddtH2J/BlBD+CB1GkS07h0
 hIp6IltBhWhOsuuXbo5XrasccN/VomW4gF7az1xsKxVmHr25REoG023dGapSQazgBRUU
 rD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784546621; x=1785151421;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CaYT/hlQebVBBjWxo6yEYllRtoTGR+8HUzobQBXo5no=;
 b=M/un9r9dK07PeCFJSCHakuMv+Mczhfbx0ju3AQPWKsHw8faeRqxZGVGnc0ifOpktDS
 SE7ns77IKxKV1obDEUYdjZ4QSl/Y1lgTtyquXoAiFO5rnufMBUOvtInNvN0xz7AiVPYE
 o/oyeByFJx93NIUMgZhnen5U1X4H8dOX8Bgqh3wqB5WWMI32o4k3bqzzWzRmO4D1b0ND
 KMbS6QOeeJTg2LJuCXCtSbWV7fTkWuqRKnVYPXPtHJoYgjM6Bwoothe6uLIGWRW32cqM
 4vkzrOyfUzQzDXImf30/mXasfCbft037AIPqLWUHojq3PLQcg/CqjELNx05CWito8+qU
 FPFg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrsNpKW3PwiLwie67LJAUZSlIl6q7hV6PitbsBo/ExOaym6UMQsQmsFjvtmbjwslmHAdu1kQYkfB2xK@nongnu.org
X-Gm-Message-State: AOJu0YwkD6/X/M2dfAIrBcHoeVyuNw5ZMvt7yNhBxuDbXABvSs/9Ajfi
 psUb8oV7X49I9LCip3EZJSRgk24DLefD3Irh9nsWVroUkNG22txm6F3/mDPjcg0h/cy4kwre9cP
 5Ec7B4SUy8IVtCdNf0ZYC/cpgHGHg2lgKA016gmWHC3oTn+g/0UdTvdUN
X-Gm-Gg: AfdE7cnO4fWVVzUmlPo3qX02/uMPBzw16eKb0EFGPNU2hAXbCkLjgMqjqKE+P9AFFED
 C/LdHxc9fLmDJJAXraT8aNWpwaTnO1Lon7WXz2m3WbP3UZdR0k6cHq9kfc3r2Ujq0+rYcYRLEHP
 VlDDN71opbg5UdY8SnBmGYhKePW/OtTbUP/OYIPcvO2zAFGamenHX4tgkb+ynFG7hnZYSWuXUCN
 ZNNKTxqRnaT3p7UHJbjwGOLof3eOYpWD45tZEOrOdA/EIm411pl5H2RU41ZUXJPloL0NSOhEzJp
 duXahCXC9ShuFbd/nkxX0M7uSytBamefsSq7oMAiI4ZuUbts0qQm42tSxQiT
X-Received: by 2002:a05:600c:1d15:b0:494:ca0e:880a with SMTP id
 5b1f17b1804b1-4954a3e4855mr156077295e9.12.1784546620825; 
 Mon, 20 Jul 2026 04:23:40 -0700 (PDT)
X-Received: by 2002:a05:600c:1d15:b0:494:ca0e:880a with SMTP id
 5b1f17b1804b1-4954a3e4855mr156076905e9.12.1784546620420; 
 Mon, 20 Jul 2026 04:23:40 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4955dfa4a97sm101926315e9.4.2026.07.20.04.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 04:23:40 -0700 (PDT)
Date: Mon, 20 Jul 2026 13:23:37 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Jia Jia <physicalmtea@gmail.com>
Subject: Re: [PATCH 2/3] hw/9pfs/virtio: disable hotpluggable property of
 virtio-9p device
Message-ID: <20260720132337.0110bd9e@imammedo>
In-Reply-To: <alo5LiqOfOVx0Yxu@redhat.com>
References: <cover.1783604079.git.qemu_oss@crudebyte.com>
 <alEEROvr0gbuWCB2@redhat.com> <20260713094935.5eda77f9@imammedo>
 <3767624.R56niFO833@weasel> <alo5LiqOfOVx0Yxu@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=170.10.133.124;
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

On Fri, 17 Jul 2026 15:16:14 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, Jul 17, 2026 at 04:05:42PM +0200, Christian Schoenebeck wrote:
> > On Monday, 13 July 2026 09:49:35 CEST Igor Mammedov wrote: =20
> > > On Fri, 10 Jul 2026 15:40:04 +0100
> > >=20
> > > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote: =20
> > > > On Fri, Jul 10, 2026 at 04:31:51PM +0200, Christian Schoenebeck wro=
te: =20
> > > > > On Friday, 10 July 2026 14:51:49 CEST Igor Mammedov wrote: =20
> > > > > > On Fri, 10 Jul 2026 12:49:06 +0200
> > > > > >=20
> > > > > > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote: =20
> > > > > > > On Friday, 10 July 2026 12:23:45 CEST Igor Mammedov wrote: =20
> > > > > [...]
> > > > >  =20
> > > > > > note: I'm looking from pov of hotpluggable PCI device and gener=
ic
> > > > > > hotplug
> > > > > > infra, only. =20
> > > > >=20
> > > > > That's okay, but so far I don't see the relevance for this partic=
ular 9p
> > > > > device.
> > > > >  =20
> > > > > > it's not guest users directly, it's how hotplug flow works for =
various
> > > > > > guest OSes:
> > > > > >=20
> > > > > > 1. host plugs device in (-device or device_add)
> > > > > > 2. guest OS get's notified one way or another and does what eve=
r guest
> > > > > > side
> > > > > >=20
> > > > > >    init needed (incl. mounting share in 9pfs case) =20
> > > > >=20
> > > > > That's not affected by this patch, right?
> > > > >  =20
> > > > > > opposite flow:
> > > > > > 1. host does device_del (basically notify guest to remove devic=
e)
> > > > > > 2. guest OS frees resources and tells qemu to delete device
> > > > > > 3. qemu process remove event (which incl. unrealize as part of
> > > > > > destroying
> > > > > > device) =20
> > > > >=20
> > > > > And that's not affected by this patch either, right? =20
> > >=20
> > > the patch would break unplug flow by effectively removing 'eject' knob
> > > from guest side, which is part of unplug flow. =20
> >=20
> > These are two different things: device_del would not be affected by thi=
s.=20
> >=20
> > 1. Ejecting the device from host side e.g. via QMP would still work.
> >=20
> > vs.
> >=20
> > 2. Ejecting from guest side OTOH would be disabled.
> >=20
> > It is also different from regular block devices where you have convenie=
nt ways
> > to eject a block device on guest OSes. For a virtio-9p device it is not=
 that
> > easy. =20
>=20
> Igor can correct me if I'm wrong, but IIUC there's no distinction
> to those 2 scenarios from the guest POV.
>=20
> A "device_del" in QMP does not actually delete a device from the
> QEMU POV.  Rather it triggers an ACPI notification to the geust
> OS, that the operator wants to unplug the device.  The guest OS
> then honours (or not) that by initiating a guest side "eject".
> IOW disabling guest initiated eject would break device_del too
> AFAIK.

That's how it works.
Sorry if I wasn't able to convey the message in my previous replies.

>=20
> With regards,
> Daniel


