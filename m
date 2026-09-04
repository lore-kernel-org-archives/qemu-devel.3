Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C95C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Sil-0004vz-A4; Fri, 04 Sep 2026 08:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x2Sih-0004vi-UU
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1x2Sie-0005ds-UV
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788523711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Exst7EJqJQoSBYryil+QQ12+6GqWDbDrhmxI8WakeCY=;
 b=YMEylQ4uz2MoHiTPokKL8MpyYVplgNDZHNwN6Ja2shqv0VYVgtp7zCd1nyUWKTDVwy+Mws
 9NXjHxam/PX4wL5nOunvDUFjfL5i1l3TMYulJIyv3a4j/ukQ7X/BfRBZUbwzpnmDVEyWDv
 hDOQCbplGcMAJyBnyeXV2E43AixsHBQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-Zzk5d9GQOPyltKXO3--Ddw-1; Fri, 04 Sep 2026 08:08:30 -0400
X-MC-Unique: Zzk5d9GQOPyltKXO3--Ddw-1
X-Mimecast-MFC-AGG-ID: Zzk5d9GQOPyltKXO3--Ddw_1788523709
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-472c330e555so483927f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788523709; x=1789128509; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Exst7EJqJQoSBYryil+QQ12+6GqWDbDrhmxI8WakeCY=;
 b=fAjSHebI7IwT6fyNAknl3AJ2xWVQcHCyEG4Piu3lasgI0cBGHjYqNtIdxmwmT41ZXR
 AbshZxRBVce8qdl5GVqWfYhuvjVtp7hRVObMNseyGf5wqqzWRrc0TgI65h6dA3BOK3Wd
 +HGnKP21C8zqCpX3c6u0Bg4YSLdbmZu95eibCE2vsQIOdm31EW2vqTxtZBCY+W5Ho7/i
 gyCW0WF4TEF4JSJ644cN/t63rmamyuxEaMsHZfnDhJBLwttDqD41TrkwwpqHDH6+C1cx
 Zmp3OTkfccwDMAhX/PW0jOl23u6hoUDQ1iSq8b7EmvWGbJPTNxAlO6tvAcL8HXY9qWPv
 MUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788523709; x=1789128509;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Exst7EJqJQoSBYryil+QQ12+6GqWDbDrhmxI8WakeCY=;
 b=H3JvQc1nNMFrl2yhzbONwNOdejUir0sPA8kv2Nd3VQj+oTCCPbqeabTtdc+JMDL2Wu
 Vb+yM8YOyynC8SiqTKfm5W99ibZhxKZ4zeUU3fTC6to5SmTAige2fwDIx7jJg2K5Zsai
 uHIoMxAxo3qiyXK6pEsmiHapKK7eZaYhoCgnr6ODhb2xFoD1RSCJNjx4DbKogb4LdGVM
 k83RFbV0ENpwHGMa1VMdBlfAtnKCGBNBmZb5S0jfuTjuaaXhFcESEZRs/IieDdev766l
 ZO9G6X1fYgQAXNBLgmZIN/osDoG7NffQHJoFj9aAmLW3tU2JbWuqGXU/eEpCVVRYvwAo
 ioYw==
X-Forwarded-Encrypted: i=1;
 AKwUvByyrhvhoHykUjeu2HJhLm3YOXz0YfxA3GF/R3E1FJDUC4k5zO0qrmdKU+Dz+mSArewfyJ2tbxEXGM5J@nongnu.org
X-Gm-Message-State: AFuF++l58dgA+qzvvSjkskjNm1Nj44MqS7aHFJvvjeKkL6gaGuCKTPiW
 2Uo9Lbw3Y10kuloh6SCU32V0GG8BdkwWWP2qjDqj7ja8RpS5y6O6SdAIP0R0JwPZQw/ogX6uVXh
 jxSISkS0FQftMaaUENReAjmXIPr27rOU9IxfVMJSuZ2AxR8S2NDQuDZq6
X-Gm-Gg: AYBFou1ob6K4SyjhAf7HpVrk+ExrlVg8bfqUYUbOY9sdLMnijpnPwEFoWCfPT0djpJY
 BIZiiXC4ofQUgRz0+ObFa87ycNpLaD0h9J4JUsrDPRLjEDbwQoAWFbxYvY0S0WG5Z18BDbQ5krt
 4ku2mc3nKzrHgx0CofWgPO0dxI0XeMd/+uyxcU52DATm9yDM/wDOs1syp56tQnV31OiwgfO5wZL
 NsR2rEDBLCVCKrl5u1yRfVtoABOtpLqrJsCRDOiExjYO061tv92Yh4+JFK2B3uVo9abydaGU+xH
 whDXtejPSnkrI1qcicK/aQ2EmOZMKU1I9hqOboPaFL172Yzh8kcVmlSq0Es=
X-Received: by 2002:a05:600d:864b:20b0:49c:fea3:8633 with SMTP id
 5b1f17b1804b1-49cfea38642mr11745625e9.24.1788523709298; 
 Fri, 04 Sep 2026 05:08:29 -0700 (PDT)
X-Received: by 2002:a05:600d:864b:20b0:49c:fea3:8633 with SMTP id
 5b1f17b1804b1-49cfea38642mr11745025e9.24.1788523708810; 
 Fri, 04 Sep 2026 05:08:28 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce831af89sm120170135e9.1.2026.09.04.05.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:08:27 -0700 (PDT)
Date: Fri, 4 Sep 2026 14:08:24 +0200
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
Message-ID: <20260904140824.177711f8@imammedo>
In-Reply-To: <20260904072052-mutt-send-email-mst@kernel.org>
References: <20260824011420.752806-1-dongli.zhang@oracle.com>
 <aoxY4Rxst2qAyn5z@redhat.com>
 <01ee4841-76d8-4749-a80e-eb945ab8799a@oracle.com>
 <20260903172835.0e253a25@imammedo>
 <20260903160401-mutt-send-email-mst@kernel.org>
 <20260904130709.6769caee@imammedo>
 <20260904072052-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, 4 Sep 2026 07:22:10 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Sep 04, 2026 at 01:07:09PM +0200, Igor Mammedov wrote:
> > On Thu, 3 Sep 2026 16:17:20 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >  =20
> > > On Thu, Sep 03, 2026 at 05:28:35PM +0200, Igor Mammedov wrote: =20
> > > > On Wed, 26 Aug 2026 09:15:47 -0700
> > > > Dongli Zhang <dongli.zhang@oracle.com> wrote:
> > > >    =20
> > > > > On Mon, Aug 24, 2026 7:44:49AM -0700, Daniel P. Berrang=C3=A9 wro=
te:   =20
> > > > > > On Sun, Aug 23, 2026 at 06:13:30PM -0700, Dongli Zhang wrote:  =
   =20
> > > > > >> Hot-unplugging a PCI device can require cooperation from the g=
uest. For
> > > > > >> ACPI PCI hotplug, QEMU notifies the guest through ACPI and the=
 guest
> > > > > >> eventually writes the ACPI PCI eject register. For PCIe native=
 hotplug,
> > > > > >> QEMU notifies the guest through the PCIe hotplug mechanism and=
 waits for
> > > > > >> the slot unplug flow to complete. Only after that completion d=
oes QEMU
> > > > > >> unrealize the device and emit DEVICE_DELETED.
> > > > > >>=20
> > > > > >> This can leave a device stuck in the unplug pending state when=
 the guest
> > > > > >> does not cooperate. Examples include:
> > > > > >>=20
> > > > > >> 1. The guest has panicked, or the relevant ACPI/PCI hotplug dr=
iver is
> > > > > >> unavailable.
> > > > > >>=20
> > > > > >> 2. The guest is stalled and cannot handle the hot-unplug event=
. For
> > > > > >> example, stalling the Linux [irq/9-acpi] kernel thread can rep=
roduce this
> > > > > >> for ACPI-based hot-unplug.
> > > > > >>=20
> > > > > >> 3. The device was attached to a slot that the guest cannot use=
. For
> > > > > >> example, a pcie-root-port only supports slot 0. If a device is=
 added to a
> > > > > >> non-zero slot below a pcie-root-port, the guest may never disc=
over the
> > > > > >> device and therefore may never complete the unplug request.   =
=20
> > > >=20
> > > > all of above is actually expected, no (functioning) driver =3D> no =
hotplug/unplug.
> > > > it's the guest problem. Once device it exposed to guest its life-cy=
cle
> > > > not longer owned by QEMU.
> > > >=20
> > > > That's what one would see in real hw as well, you press eject button
> > > > but it will not do anything if OS doesn't process it.
> > > > also see comment at the end.
> > > >    =20
> > > > > >>=20
> > > > > >> The non-zero slot case has also been discussed in:
> > > > > >>=20
> > > > > >> hw/pci: warn when PCIe device is plugged into non-zero slot of=
 downstream port
> > > > > >> https://gitlab.com/qemu-project/qemu/-/commit/     =20
> > > > > > ca92eb5defcf9d1c2106341744a73a03cf26e824     =20
> > > > > >>=20
> > > > > >> hw/pci: add comment to explain checking for available function=
 0 in pci hotplug
> > > > > >> https://gitlab.com/qemu-project/qemu/-/     =20
> > > > > > commit/67d045a0ef5b9c5f871c3a1d87325a8a42d2b9d5     =20
> > > > > >>=20
> > > > > >> pci: don't skip function 0 occupancy verification for devfn au=
to assign
> > > > > >> https://gitlab.com/qemu-project/qemu/-/commit/     =20
> > > > > > e228d62b4af29bca698ec57efdceb46f392f5444     =20
> > > > > >>=20
> > > > > >> For example, if root-port.1 is a pcie-root-port, the following=
 command adds
> > > > > >> a vhost-scsi-pci device to an invalid slot:
> > > > > >>=20
> > > > > >> (qemu) device_add vhost-scsi-pci,id=3Dscsi01,wwpn=3Dnaa.500140=
5324af0985,bus=3Droot-port.1,addr=3D01.0
> > > > > >> warning: PCI: slot 1 is not valid for vhost-scsi-pci, parent d=
evice only allows plugging into slot 0.     =20
> > > > > >=20
> > > > > > This rather looks like it should be a fatal error, not a mere w=
arning.
> > > > > >=20
> > > > > > If I follow the commit ca92eb5def it links to https://bugzilla.=
redhat.com/show_bug.cgi?id=3D2128929
> > > > > > which states that this configuration is going to lead to a cras=
h in
> > > > > > QEMU on guest OS shutdown. IMHO that crash is sufficient to jus=
tify
> > > > > > making this a fatal error.
> > > > > >=20
> > > > > > If we actually wanted this to remain a warning, then that shutd=
own
> > > > > > crash would need to be fixed.
> > > > > >      =20
> > > > >=20
> > > > > Thank you very much!
> > > > >=20
> > > > > I see that the issue has been fixed. The ticket mentions the foll=
owing.
> > > > >=20
> > > > > "What I am observing is that it seems when the slot ID !=3D 0, th=
e guest OS seems
> > > > > to ignore this and we never seem to hit ich9_pm_device_unplug_cb(=
)."
> > > > >=20
> > > > > Based on my experience and evaluation, ACPI-based hotplug is more=
 likely to
> > > > > encounter an issue where the guest VM does not respond to an unpl=
ug operation.   =20
> > > >=20
> > > > I'm not sure it's a good idea to delete device when guest still thi=
nks it's there
> > > > (you can make guesses on QEMU side if it's in use, how useful those=
 are is questionable).
> > > >=20
> > > > as far as I know, ACPI hotplug has no notion of surprise removal (p=
ls educate me if it's not the case),   =20
> > >=20
> > > why would it not?
> > >=20
> > > how do you think you can pull a laptop out of a dock?
> > > I expect bus check + _STA and config space saying it is gone
> > > will do exactly that.
> > >=20
> > >=20
> > > Here's linux code:
> > > static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
> > > {      =20
> > >         struct acpiphp_slot *slot;
> > >=20
> > >         /* Bail out if the bridge is going away. */
> > >         if (bridge->is_going_away)
> > >                 return;
> > >=20
> > >         if (bridge->pci_dev)
> > >                 pm_runtime_get_sync(&bridge->pci_dev->dev);
> > >        =20
> > >         list_for_each_entry(slot, &bridge->slots, node) {
> > >                 struct pci_bus *bus =3D slot->bus;
> > >                 struct pci_dev *dev, *tmp;
> > >=20
> > >                 if (slot_no_hotplug(slot)) {
> > >                         ; /* do nothing */
> > >                 } else if (device_status_valid(get_slot_status(slot))=
) {
> > >                         /* remove stale devices if any */
> > >                         list_for_each_entry_safe_reverse(dev, tmp,
> > >                                                          &bus->device=
s, bus_list)
> > >                                 if (PCI_SLOT(dev->devfn) =3D=3D slot-=
>device)
> > >                                         trim_stale_devices(dev);
> > >=20
> > >                         /* configure all functions */
> > >                         enable_slot(slot, true);
> > >                 } else {
> > >                         disable_slot(slot);
> > >                 }
> > >         }
> > >=20
> > >         if (bridge->pci_dev)
> > >                 pm_runtime_put(&bridge->pci_dev->dev);
> > > }
> > >=20
> > >=20
> > > so weirdly it wants bus check on a parent bus, otherwise it will
> > > not trim devices?  probably a bug, but easy to work around. =20
> >=20
> > Modern docks would use native pcie surprise removal path.
> >=20
> > As for ACPI, my old laptop, had an unlock button =3D> _LCK
> > and that relied on OS processing ACPI events, not so surprise.
> >=20
> > There might have been ACPI/hybrid docks that did surprise removal,
> > but then one need to find one and model after that instead of=20
> > just blanket force removal. (likely out come would a doc device
> > support only, not an arbitrary device removal)
> >=20
> > (not the case described in this series, though. hence my request to cla=
rify usecase)
> >=20
> > from what I see in spec there is _RMV method that says that device
> > supports surprise removal that can be used for devices that support it.
> > However I would hesitate very much to blank apply it to every PCI devic=
e.
> > (it's not even realistic to ask for proving safe tear down across vario=
us
> > drivers and OSes/versions)
> >=20
> > Rather than a knee jerk treatment of misconfig consequences,
> > I'd rather see patches to prevent misconfig in the 1st place
> > (subj to deprecation but doable).
> >=20
> > As for the cases where OS mis-behaves (apcihp thread starvation,...),
> > fixing guest to follow hotplug contract is a proper place to do it.
> >=20
> > On QEMU side we have it covered as well. If unplug was not processed,
> > mgmt is free to repeat action. =20
>=20
>=20
> Sorry if I am unclear. I just meant that it looks like we
> can support surprise removal with ACPI just by reporting
> bus check events on the parent.

maybe, but that ain't SPECed and might be OS specific.

The way I've read the cover letter, that won't work for mentioned mis-confi=
g cases.
Also what would happen on bus-check 'cleanup' would be a lottery.
hence I'm for being safe here.

It's better to implement native PCIE surprise removal if that's really need=
ed.

> > > > so I wouldn't do what you are proposing here at all, it's basically=
 asking for disaster to happen.
> > > > And all this is basically for dealing with abused qemu flexibility.
> > > >=20
> > > > Please (re)formulate usecase and make it more clear as what is elud=
es me
> > > > no matter how many times i've read this cover letter.
> > > >=20
> > > > On positive note:
> > > >=20
> > > > What you can try to implement is native PCI-E support for surprise =
removal.
> > > > How hard that would be I don't know. And I would well expect if one=
 deviates from
> > > > real hw expectations/configs (such as not 0 slot/partial func remov=
al),
> > > > one would quickly stumble upon issues as  that's not what what vend=
ors write/test
> > > > drivers for.
> > > >=20
> > > > Even if it's not likely to be used in practice (guest still might n=
ot support it),
> > > > it may serve as test-bed for guest drivers.
> > > >    =20
> > > > > Thank you very much!
> > > > >=20
> > > > > Dongli Zhang
> > > > >    =20
> > >  =20
>=20


