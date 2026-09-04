Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465F5C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2RlQ-0004KK-CL; Fri, 04 Sep 2026 07:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x2RlO-0004Jn-NX
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x2RlM-0000ZI-5H
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788520035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rma0vtMwq9+HEP9ZApTJBKj1zxbRdaELT3NPMRD9Df8=;
 b=bOWf8TciG/1oq8fQlxxt7rdBHtpvYp9DJ6FuAoAhuVklavjVOiaygdz6/xU/4QJgHWKHdC
 P7xE/BohkjWa6IrO+j51pelM28G9rXtt6xH17e8Mb1W3HOLhF1eVIjtJcIGDbQU1A8ySPV
 Bzw3hfl2No3uZTd5F4swe2RA+tBOR7E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-7madvALANmOsp0CY4ONinA-1; Fri, 04 Sep 2026 07:07:14 -0400
X-MC-Unique: 7madvALANmOsp0CY4ONinA-1
X-Mimecast-MFC-AGG-ID: 7madvALANmOsp0CY4ONinA_1788520033
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-496bbcf7d1eso8020305e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788520033; x=1789124833; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Rma0vtMwq9+HEP9ZApTJBKj1zxbRdaELT3NPMRD9Df8=;
 b=MWFHyjsaoBOP01TmhKcDUTx+7V3Eou6k5MeZk32qEVBS61HcMDuvulyMfKurbN3MKv
 l9DXXKEjkJq61FuWOv0ue4lpyVKAkYrRoT3OfFaSwEq3Bfhu+3osFUIZHkMlLogtHTjR
 Xrox64arvvTdy5VmFVX7EJ/lxOpcGTHLGC/ynhHBEE8H9IZ7QX/AJ9yuFetgDa7IpMzz
 VSB1BqaDNNZRISPk+mFWKrWO+i/Cdvd8gwrn0IMWsWSHBfijOn7epOCZzShAf6+yMuAB
 wbTO+VNF8i7PMfq2vWJet9ZYZpJni/LSnt8YM5sJK1NirztQlVbMgVkU9AJI2TW+N6iq
 A0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788520033; x=1789124833;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Rma0vtMwq9+HEP9ZApTJBKj1zxbRdaELT3NPMRD9Df8=;
 b=Dmk0wQqYt1jmRtMVsMpmowl8HrMHyEeGMxCnexmUbldGwidhIiMSLh0bB/09J8DG0w
 uG73cxdHCvDBhmToXSkKg76stxrj1b0VvsutOZfaoNX/Wki66iRLPHnY2WFQWYL65nJI
 dthUegBHvDJ3HCMcV/fRZmjfFZmvDp+sIgDVmUwP+qcEfeqcu3acbH/ecYC9AhvH9OwS
 +KSsM559wz7Rv25oC0qXPfwH89NPrFVRb+rhX+etJjE/OpXFYbK6yUfn5jQFUYBPOaoa
 XmsUAHiOyfuGeW+gsfvmP9uwKJJ/MatFXy+ZiMIOd7xaH9/AuTjhP3nyolA4Lyctogc+
 1WAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzOXrfcjN6Ch43xUv9e6BFK3PtOf8sBBSsf30gWXENNtDKtxTxC4tbpekFXCP5fjZ0TL7bPUgZFmt08@nongnu.org
X-Gm-Message-State: AFuF++lc+fio1AmpMJOxlSO+H33i+DuQ0rChViWICzhEQ6bPYmYpU7rr
 iSmGcVg9rx1HDlYhOaJVDtKaQ8q5EYCHkQCpa47V/i6gz93G6YndObXN3oKVFKzk8Enpfz9ThJ+
 CQX/51FcglMKeDAXdS9qjKV80CnGdAwy5j8uQi/9WR/tcRkdl3eTvENoZ
X-Gm-Gg: AYBFou3qTCXWTTt8Y8nfXEKaqqZyRKjDh3PPMnECQdCVJ3fLtXVQUME285lBfeqSTs4
 fbnZVyLqCzHe7B33kKAygkPJb96dfmZ+FsLeYmJjrlv3vEsBhac6GPvHx3zcAPZzSQLTqMwlGwZ
 IkHoPX+Jaqe7jnueqAilow7minh2ThgZeOBvfnC9IU951yNbnKaeuMmFq+n6Qcg/IQ0QLbPj7VK
 f5vz6/cUcfjwhNZd/g+dPu5JwQw1ORuDIPzCMOWnxlUz7P8YRDpvOOYDl7WJnRWccS4AHKPGlys
 TARUIzyYDb3BZ+HlGR8iRM89VN14m1gFNUKOjVc4K0GL
X-Received: by 2002:a05:600c:8b05:b0:499:be2d:c290 with SMTP id
 5b1f17b1804b1-49cf824e751mr61822885e9.9.1788520032819; 
 Fri, 04 Sep 2026 04:07:12 -0700 (PDT)
X-Received: by 2002:a05:600c:8b05:b0:499:be2d:c290 with SMTP id
 5b1f17b1804b1-49cf824e751mr61822205e9.9.1788520032319; 
 Fri, 04 Sep 2026 04:07:12 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf755c22esm62275895e9.0.2026.09.04.04.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 04:07:11 -0700 (PDT)
Date: Fri, 4 Sep 2026 13:07:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>, "Daniel P. =?UTF-8?B?QmVycmFu?=
 =?UTF-8?B?Z8Op?=" <berrange@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, xen-devel@lists.xenproject.org, dave@treblig.org,
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
Message-ID: <20260904130709.6769caee@imammedo>
In-Reply-To: <20260903160401-mutt-send-email-mst@kernel.org>
References: <20260824011420.752806-1-dongli.zhang@oracle.com>
 <aoxY4Rxst2qAyn5z@redhat.com>
 <01ee4841-76d8-4749-a80e-eb945ab8799a@oracle.com>
 <20260903172835.0e253a25@imammedo>
 <20260903160401-mutt-send-email-mst@kernel.org>
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

On Thu, 3 Sep 2026 16:17:20 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Sep 03, 2026 at 05:28:35PM +0200, Igor Mammedov wrote:
> > On Wed, 26 Aug 2026 09:15:47 -0700
> > Dongli Zhang <dongli.zhang@oracle.com> wrote:
> >  =20
> > > On Mon, Aug 24, 2026 7:44:49AM -0700, Daniel P. Berrang=C3=A9 wrote: =
=20
> > > > On Sun, Aug 23, 2026 at 06:13:30PM -0700, Dongli Zhang wrote:   =20
> > > >> Hot-unplugging a PCI device can require cooperation from the guest=
. For
> > > >> ACPI PCI hotplug, QEMU notifies the guest through ACPI and the gue=
st
> > > >> eventually writes the ACPI PCI eject register. For PCIe native hot=
plug,
> > > >> QEMU notifies the guest through the PCIe hotplug mechanism and wai=
ts for
> > > >> the slot unplug flow to complete. Only after that completion does =
QEMU
> > > >> unrealize the device and emit DEVICE_DELETED.
> > > >>=20
> > > >> This can leave a device stuck in the unplug pending state when the=
 guest
> > > >> does not cooperate. Examples include:
> > > >>=20
> > > >> 1. The guest has panicked, or the relevant ACPI/PCI hotplug driver=
 is
> > > >> unavailable.
> > > >>=20
> > > >> 2. The guest is stalled and cannot handle the hot-unplug event. For
> > > >> example, stalling the Linux [irq/9-acpi] kernel thread can reprodu=
ce this
> > > >> for ACPI-based hot-unplug.
> > > >>=20
> > > >> 3. The device was attached to a slot that the guest cannot use. For
> > > >> example, a pcie-root-port only supports slot 0. If a device is add=
ed to a
> > > >> non-zero slot below a pcie-root-port, the guest may never discover=
 the
> > > >> device and therefore may never complete the unplug request. =20
> >=20
> > all of above is actually expected, no (functioning) driver =3D> no hotp=
lug/unplug.
> > it's the guest problem. Once device it exposed to guest its life-cycle
> > not longer owned by QEMU.
> >=20
> > That's what one would see in real hw as well, you press eject button
> > but it will not do anything if OS doesn't process it.
> > also see comment at the end.
> >  =20
> > > >>=20
> > > >> The non-zero slot case has also been discussed in:
> > > >>=20
> > > >> hw/pci: warn when PCIe device is plugged into non-zero slot of dow=
nstream port
> > > >> https://gitlab.com/qemu-project/qemu/-/commit/   =20
> > > > ca92eb5defcf9d1c2106341744a73a03cf26e824   =20
> > > >>=20
> > > >> hw/pci: add comment to explain checking for available function 0 i=
n pci hotplug
> > > >> https://gitlab.com/qemu-project/qemu/-/   =20
> > > > commit/67d045a0ef5b9c5f871c3a1d87325a8a42d2b9d5   =20
> > > >>=20
> > > >> pci: don't skip function 0 occupancy verification for devfn auto a=
ssign
> > > >> https://gitlab.com/qemu-project/qemu/-/commit/   =20
> > > > e228d62b4af29bca698ec57efdceb46f392f5444   =20
> > > >>=20
> > > >> For example, if root-port.1 is a pcie-root-port, the following com=
mand adds
> > > >> a vhost-scsi-pci device to an invalid slot:
> > > >>=20
> > > >> (qemu) device_add vhost-scsi-pci,id=3Dscsi01,wwpn=3Dnaa.5001405324=
af0985,bus=3Droot-port.1,addr=3D01.0
> > > >> warning: PCI: slot 1 is not valid for vhost-scsi-pci, parent devic=
e only allows plugging into slot 0.   =20
> > > >=20
> > > > This rather looks like it should be a fatal error, not a mere warni=
ng.
> > > >=20
> > > > If I follow the commit ca92eb5def it links to https://bugzilla.redh=
at.com/show_bug.cgi?id=3D2128929
> > > > which states that this configuration is going to lead to a crash in
> > > > QEMU on guest OS shutdown. IMHO that crash is sufficient to justify
> > > > making this a fatal error.
> > > >=20
> > > > If we actually wanted this to remain a warning, then that shutdown
> > > > crash would need to be fixed.
> > > >    =20
> > >=20
> > > Thank you very much!
> > >=20
> > > I see that the issue has been fixed. The ticket mentions the followin=
g.
> > >=20
> > > "What I am observing is that it seems when the slot ID !=3D 0, the gu=
est OS seems
> > > to ignore this and we never seem to hit ich9_pm_device_unplug_cb()."
> > >=20
> > > Based on my experience and evaluation, ACPI-based hotplug is more lik=
ely to
> > > encounter an issue where the guest VM does not respond to an unplug o=
peration. =20
> >=20
> > I'm not sure it's a good idea to delete device when guest still thinks =
it's there
> > (you can make guesses on QEMU side if it's in use, how useful those are=
 is questionable).
> >=20
> > as far as I know, ACPI hotplug has no notion of surprise removal (pls e=
ducate me if it's not the case), =20
>=20
> why would it not?
>=20
> how do you think you can pull a laptop out of a dock?
> I expect bus check + _STA and config space saying it is gone
> will do exactly that.
>=20
>=20
> Here's linux code:
> static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
> {      =20
>         struct acpiphp_slot *slot;
>=20
>         /* Bail out if the bridge is going away. */
>         if (bridge->is_going_away)
>                 return;
>=20
>         if (bridge->pci_dev)
>                 pm_runtime_get_sync(&bridge->pci_dev->dev);
>        =20
>         list_for_each_entry(slot, &bridge->slots, node) {
>                 struct pci_bus *bus =3D slot->bus;
>                 struct pci_dev *dev, *tmp;
>=20
>                 if (slot_no_hotplug(slot)) {
>                         ; /* do nothing */
>                 } else if (device_status_valid(get_slot_status(slot))) {
>                         /* remove stale devices if any */
>                         list_for_each_entry_safe_reverse(dev, tmp,
>                                                          &bus->devices, b=
us_list)
>                                 if (PCI_SLOT(dev->devfn) =3D=3D slot->dev=
ice)
>                                         trim_stale_devices(dev);
>=20
>                         /* configure all functions */
>                         enable_slot(slot, true);
>                 } else {
>                         disable_slot(slot);
>                 }
>         }
>=20
>         if (bridge->pci_dev)
>                 pm_runtime_put(&bridge->pci_dev->dev);
> }
>=20
>=20
> so weirdly it wants bus check on a parent bus, otherwise it will
> not trim devices?  probably a bug, but easy to work around.

Modern docks would use native pcie surprise removal path.

As for ACPI, my old laptop, had an unlock button =3D> _LCK
and that relied on OS processing ACPI events, not so surprise.

There might have been ACPI/hybrid docks that did surprise removal,
but then one need to find one and model after that instead of=20
just blanket force removal. (likely out come would a doc device
support only, not an arbitrary device removal)

(not the case described in this series, though. hence my request to clarify=
 usecase)

from what I see in spec there is _RMV method that says that device
supports surprise removal that can be used for devices that support it.
However I would hesitate very much to blank apply it to every PCI device.
(it's not even realistic to ask for proving safe tear down across various
drivers and OSes/versions)

Rather than a knee jerk treatment of misconfig consequences,
I'd rather see patches to prevent misconfig in the 1st place
(subj to deprecation but doable).

As for the cases where OS mis-behaves (apcihp thread starvation,...),
fixing guest to follow hotplug contract is a proper place to do it.

On QEMU side we have it covered as well. If unplug was not processed,
mgmt is free to repeat action.

=20
> > so I wouldn't do what you are proposing here at all, it's basically ask=
ing for disaster to happen.
> > And all this is basically for dealing with abused qemu flexibility.
> >=20
> > Please (re)formulate usecase and make it more clear as what is eludes me
> > no matter how many times i've read this cover letter.
> >=20
> > On positive note:
> >=20
> > What you can try to implement is native PCI-E support for surprise remo=
val.
> > How hard that would be I don't know. And I would well expect if one dev=
iates from
> > real hw expectations/configs (such as not 0 slot/partial func removal),
> > one would quickly stumble upon issues as  that's not what what vendors =
write/test
> > drivers for.
> >=20
> > Even if it's not likely to be used in practice (guest still might not s=
upport it),
> > it may serve as test-bed for guest drivers.
> >  =20
> > > Thank you very much!
> > >=20
> > > Dongli Zhang
> > >  =20
>=20


