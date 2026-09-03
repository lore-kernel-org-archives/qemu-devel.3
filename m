Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBCDC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x29Mz-0002FA-40; Thu, 03 Sep 2026 11:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x29Mt-0002EQ-1T
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:28:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x29Mq-0000wL-EL
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 11:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788449322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZlgcpyErJlCEJFwxXWLl2G2MJ6RenYBs5jbw6Dpw5Q=;
 b=J4pXppy0naKn1dkwuqlIj/0B+3s1I+Pw1UypGQQQeXYLL9nLjNcKwD9Ij3bS/ArxDSRdwb
 c7+nyICpQoOzdHFwNfg8Kne2Ir3hzLXGmSpxQ7sp8d9ZYhD0AD9e+I+hdZUmY95WhAhYyw
 JGdcy5/cNGtFlwLZ5/uWVH98fekX4/w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-dYNcHDelMrKPxKGsHayRWA-1; Thu, 03 Sep 2026 11:28:41 -0400
X-MC-Unique: dYNcHDelMrKPxKGsHayRWA-1
X-Mimecast-MFC-AGG-ID: dYNcHDelMrKPxKGsHayRWA_1788449320
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49b8c651ac0so29951355e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 08:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788449320; x=1789054120; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zZlgcpyErJlCEJFwxXWLl2G2MJ6RenYBs5jbw6Dpw5Q=;
 b=OxEs9d80mtAdkC1lcb2JK4Nh81fnofnQ7GUxDXMY+JpTakc7BLuE+fjN6tI0qydLbi
 2d2kZSVhiOVrkeXCRxnBdHQ340rnHghJoJg+8A57wL65DvNkGjhG/GZY2hoK8BhEvUS1
 nURSRDqWtf6DA8B2uz7qoaP7W5rbIoMUL6gYfYAacJMnc29G6vBxtErRd6+aPIsqpVKa
 ZOgNFRdB2D/roJ7bKx+OHgXzn+3jUVXujdhoulsj/JSLXkJUAV4teXYKfTQymxbt31Df
 4QWR63po9eQPmWdoXTQ3nvpKfqtTrk3oaZg9KsIvm3aVAd80RvjWVepdBX5g8J2BbZGs
 Y9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788449320; x=1789054120;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zZlgcpyErJlCEJFwxXWLl2G2MJ6RenYBs5jbw6Dpw5Q=;
 b=DMxDdrXD/8kqYJNCumHqF3yCJiiubQAHWy74t37xEBH6zn+/dHaJD+BGknS3t435ML
 UBO49eTL8BcH9Edg1c+3TOKWi8lkw0bMzc76lAFumBa1Lt7IydFdNxMNwzzTcagyVgkI
 UDm+HuTnbLuKAJXrQb3fVLK2+jd0of+NR4Q13wPt0sKOviuL4rudLrbT+uqrNhKdePBg
 9KLJuZq+J7QCrF5JJBY1+l4unNrQxoWsYCeVzLuwYm8uo+re30Lkjyhk7F7qmJb2rkXF
 gS52/3IdtKZ0LEvPEYQRCYgitMuJk11gQC7wVzuOo/0gv1H61YmNZlSeS/2rY+RaoAfb
 5gaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByzvDz2CH6yl3RMPO9tjGCS5vkqkDz9UBWtSnc/HZwzVnTFsNPzkISG6Y6mDY5A75SBjyGuWdo5E9h4@nongnu.org
X-Gm-Message-State: AFuF++lJgd8KTzVEAbavM0N7gMHb//g6CqG5U+/UcsGibVmepmD01AmR
 Ta+ZVxJVo3YASsD2rYJWX9FTDhLuJy75ntXtX6AXzvPkkL9Fgmw5qr4+bGr7xywPTUWgU88pEzY
 Lp+7uf89JfM1FNOhnRzEWF2j7Jer+RWQ/fCYI8JmYhujdq+t2yVfWwY2S
X-Gm-Gg: AYBFou2hcRvjQVVzOOTRa77Y3DFOOFE8qzofK5hdMm6GGq6k8a/juWb1C3VLVMHL9Il
 FmB94lY80ECzff9PtvFWcnYiwIxM7GTZTmneesKpvE2x7hy7kO7xR8bJ0UzKaDsQThV5gajsBdz
 bHftaVyAIsIXQAJBpNWvqoJyJdWrZRx9wYjjZjXiNnt9uCU41bZ7YuF5MGGus1UvaS2had7tVF2
 hfS87Rhk1ydKDUenVWRtEOhr7ZnrfKHsajFvKgDMdvj5oJKrYUAZr68U/8ByMNmB8yvxOczi6j4
 8DruBgL1X76heNHp6sEKWGyU9+V4GQHjiQT/c7nu4L4/sCTw5T3oUUd0g8M=
X-Received: by 2002:a05:600c:81c9:b0:49c:df2b:15fc with SMTP id
 5b1f17b1804b1-49cf5b79c84mr17210115e9.8.1788449319974; 
 Thu, 03 Sep 2026 08:28:39 -0700 (PDT)
X-Received: by 2002:a05:600c:81c9:b0:49c:df2b:15fc with SMTP id
 5b1f17b1804b1-49cf5b79c84mr17209195e9.8.1788449319587; 
 Thu, 03 Sep 2026 08:28:39 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5f9114sm76185195e9.5.2026.09.03.08.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 08:28:38 -0700 (PDT)
Date: Thu, 3 Sep 2026 17:28:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org, dave@treblig.org, mst@redhat.com,
 anisinha@redhat.com, philmd@mailo.com, aurelien@aurel32.net,
 mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, clg@redhat.com, akrowiak@linux.ibm.com,
 jjherne@linux.ibm.com, sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, joe.jin@oracle.com
Subject: Re: [PATCH 0/8] Force detach PCI devices for ACPI-based and PCIe
 native hot-unplug
Message-ID: <20260903172835.0e253a25@imammedo>
In-Reply-To: <01ee4841-76d8-4749-a80e-eb945ab8799a@oracle.com>
References: <20260824011420.752806-1-dongli.zhang@oracle.com>
 <aoxY4Rxst2qAyn5z@redhat.com>
 <01ee4841-76d8-4749-a80e-eb945ab8799a@oracle.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 26 Aug 2026 09:15:47 -0700
Dongli Zhang <dongli.zhang@oracle.com> wrote:

> On Mon, Aug 24, 2026 7:44:49AM -0700, Daniel P. Berrang=C3=A9 wrote:
> > On Sun, Aug 23, 2026 at 06:13:30PM -0700, Dongli Zhang wrote: =20
> >> Hot-unplugging a PCI device can require cooperation from the guest. For
> >> ACPI PCI hotplug, QEMU notifies the guest through ACPI and the guest
> >> eventually writes the ACPI PCI eject register. For PCIe native hotplug,
> >> QEMU notifies the guest through the PCIe hotplug mechanism and waits f=
or
> >> the slot unplug flow to complete. Only after that completion does QEMU
> >> unrealize the device and emit DEVICE_DELETED.
> >>=20
> >> This can leave a device stuck in the unplug pending state when the gue=
st
> >> does not cooperate. Examples include:
> >>=20
> >> 1. The guest has panicked, or the relevant ACPI/PCI hotplug driver is
> >> unavailable.
> >>=20
> >> 2. The guest is stalled and cannot handle the hot-unplug event. For
> >> example, stalling the Linux [irq/9-acpi] kernel thread can reproduce t=
his
> >> for ACPI-based hot-unplug.
> >>=20
> >> 3. The device was attached to a slot that the guest cannot use. For
> >> example, a pcie-root-port only supports slot 0. If a device is added t=
o a
> >> non-zero slot below a pcie-root-port, the guest may never discover the
> >> device and therefore may never complete the unplug request.

all of above is actually expected, no (functioning) driver =3D> no hotplug/=
unplug.
it's the guest problem. Once device it exposed to guest its life-cycle
not longer owned by QEMU.

That's what one would see in real hw as well, you press eject button
but it will not do anything if OS doesn't process it.
also see comment at the end.

> >>=20
> >> The non-zero slot case has also been discussed in:
> >>=20
> >> hw/pci: warn when PCIe device is plugged into non-zero slot of downstr=
eam port
> >> https://gitlab.com/qemu-project/qemu/-/commit/ =20
> > ca92eb5defcf9d1c2106341744a73a03cf26e824 =20
> >>=20
> >> hw/pci: add comment to explain checking for available function 0 in pc=
i hotplug
> >> https://gitlab.com/qemu-project/qemu/-/ =20
> > commit/67d045a0ef5b9c5f871c3a1d87325a8a42d2b9d5 =20
> >>=20
> >> pci: don't skip function 0 occupancy verification for devfn auto assign
> >> https://gitlab.com/qemu-project/qemu/-/commit/ =20
> > e228d62b4af29bca698ec57efdceb46f392f5444 =20
> >>=20
> >> For example, if root-port.1 is a pcie-root-port, the following command=
 adds
> >> a vhost-scsi-pci device to an invalid slot:
> >>=20
> >> (qemu) device_add vhost-scsi-pci,id=3Dscsi01,wwpn=3Dnaa.5001405324af09=
85,bus=3Droot-port.1,addr=3D01.0
> >> warning: PCI: slot 1 is not valid for vhost-scsi-pci, parent device on=
ly allows plugging into slot 0. =20
> >=20
> > This rather looks like it should be a fatal error, not a mere warning.
> >=20
> > If I follow the commit ca92eb5def it links to https://bugzilla.redhat.c=
om/show_bug.cgi?id=3D2128929
> > which states that this configuration is going to lead to a crash in
> > QEMU on guest OS shutdown. IMHO that crash is sufficient to justify
> > making this a fatal error.
> >=20
> > If we actually wanted this to remain a warning, then that shutdown
> > crash would need to be fixed.
> >  =20
>=20
> Thank you very much!
>=20
> I see that the issue has been fixed. The ticket mentions the following.
>=20
> "What I am observing is that it seems when the slot ID !=3D 0, the guest =
OS seems
> to ignore this and we never seem to hit ich9_pm_device_unplug_cb()."
>=20
> Based on my experience and evaluation, ACPI-based hotplug is more likely =
to
> encounter an issue where the guest VM does not respond to an unplug opera=
tion.

I'm not sure it's a good idea to delete device when guest still thinks it's=
 there
(you can make guesses on QEMU side if it's in use, how useful those are is =
questionable).

as far as I know, ACPI hotplug has no notion of surprise removal (pls educa=
te me if it's not the case),
so I wouldn't do what you are proposing here at all, it's basically asking =
for disaster to happen.
And all this is basically for dealing with abused qemu flexibility.

Please (re)formulate usecase and make it more clear as what is eludes me
no matter how many times i've read this cover letter.

On positive note:

What you can try to implement is native PCI-E support for surprise removal.
How hard that would be I don't know. And I would well expect if one deviate=
s from
real hw expectations/configs (such as not 0 slot/partial func removal),
one would quickly stumble upon issues as  that's not what what vendors writ=
e/test
drivers for.

Even if it's not likely to be used in practice (guest still might not suppo=
rt it),
it may serve as test-bed for guest drivers.

> Thank you very much!
>=20
> Dongli Zhang
>=20


