Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84592C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDpH-00048H-RU; Wed, 28 May 2025 06:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uKDp2-000472-2D
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:15:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uKDod-0000pE-CD
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748427316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D5/EqYuJ+LBdMAwVzlVRlyL1+xbWXiH+2gUZZ1TPZI4=;
 b=Pqb8WVtBgFwydiiAmzUtyExN3dccz6MIf0QwEXzXNk7yGLEzFdiW8yq/qvG2RoSg4ki40+
 9A1qP1Rcydf0yG3B2vTBC8CI51rpG4A2uDFX65/443F9Xol32zY5GARG7Lrrs3n0J+4gOh
 TEUtTIuLyJ4WN/4W5SU9TLCMagbH+dg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-36j5cdblO7insL58LjJiVA-1; Wed, 28 May 2025 06:15:15 -0400
X-MC-Unique: 36j5cdblO7insL58LjJiVA-1
X-Mimecast-MFC-AGG-ID: 36j5cdblO7insL58LjJiVA_1748427314
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43f251dc364so24956695e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 03:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748427314; x=1749032114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D5/EqYuJ+LBdMAwVzlVRlyL1+xbWXiH+2gUZZ1TPZI4=;
 b=gqSGyoldxhOkcFXci2hEPrivKmlXYSYMRB8K2TjltBkJMVPtGRm8iqzkqMx/ADrN1J
 OLDKK2RD2MZQ1ISFznOK9U5r9micipQCGjMTjwUF1/sbJ6E8LVWPMeeslXqs4rZjxq3Q
 5nKQdUNmlVvTUuhxU9cmx+lWrLkRR48Ekq9eyDjyC70AtO7EBEI79QnUWxtSo+3TCzEJ
 j7mIWCyH/44XElbwSPYHR2Bpe1iPeQoVztXB6vhOILCd9nkNx3ckIPWiaeH0JHaHBbaL
 TMyi4BhSjaEJVtgbI/N+0n7jtCBEkzi2LNFtwLLrtkdnsU5HIa6hRRXeBk2FkapesJYR
 ZDuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4vorkV+g8RHDuQt27KSN4rQPW9qQnpyRkPVDFQY141uq4C9aM71LUZKsCnz2V06e/5n7O59/D0e1q@nongnu.org
X-Gm-Message-State: AOJu0Yz40eMAKSHuwbCPqz2LWx4A3K9sGecAsPnPW0j4jkaQYrVQvhli
 Uz2bd7TAOZTaEC4zsKUZ1P7Xp5Zk55a68nAi2GFF3dch473mqu6U5PGGMYQzt3Fj/N72LK/pl7a
 g/pcJ1fCbZiFJHNPwi++PK29RLyYCDhNkFc/DNY3defpJBppG4r9rh61e
X-Gm-Gg: ASbGncuHj/ZZajutIjAeB5Si4QUhm/VB87kmaHF41KpamXo6/1hUR7PH8a+8CVmzjW1
 xnvLQ7XISL7UI61wocy1FHKc9E8AMAMZSeD6ZRTqL/w25x/22ql2XH8tLbCswtZXX2nITSARIAZ
 jPIzxxENlcrNwDTOa3G2e2o8gsHFtch0X/wXrlGi7uqiVjYnI8ivFsZVyXytxVP0hD4GJRww53j
 dn9RRlUTt34TdiJB8PAjP+e0KlEICZJ8Jgsq1xZj6khq+F4ZzacD2pDv1ddo0DdIwt8v/o2xLQ/
 TciKeiA64hnUwEi0SMbOiJV4grfrKC+N
X-Received: by 2002:a05:600c:154f:b0:441:d438:505c with SMTP id
 5b1f17b1804b1-44c935dd818mr114901905e9.32.1748427314006; 
 Wed, 28 May 2025 03:15:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXd5dMM9UbL8XsH8JhJmC9ueZi3CH9Ckof92FHuS3JSLIzJPx8ESwXJ8p3wC8sjJ/H9pr76A==
X-Received: by 2002:a05:600c:154f:b0:441:d438:505c with SMTP id
 5b1f17b1804b1-44c935dd818mr114901585e9.32.1748427313436; 
 Wed, 28 May 2025 03:15:13 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4eac7e0c8sm1069652f8f.30.2025.05.28.03.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 03:15:13 -0700 (PDT)
Date: Wed, 28 May 2025 12:15:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: Re: [PATCH v2 22/25] hw/arm/virt: Let virt support pci
 hotplug/unplug GED event
Message-ID: <20250528121511.510bbba2@imammedo.users.ipa.redhat.com>
In-Reply-To: <363b7862-84b3-4bd1-85d6-781eb9ecf161@linaro.org>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-23-eric.auger@redhat.com>
 <20250527175649.5d276bc8@imammedo.users.ipa.redhat.com>
 <363b7862-84b3-4bd1-85d6-781eb9ecf161@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 27 May 2025 13:44:35 -0300
Gustavo Romero <gustavo.romero@linaro.org> wrote:

> Hi folks,
>=20
> On 5/27/25 12:56, Igor Mammedov wrote:
> > On Tue, 27 May 2025 09:40:24 +0200
> > Eric Auger <eric.auger@redhat.com> wrote:
> >  =20
> >> Set up the IO registers used to communicate between QEMU
> >> and ACPI. =20
> >=20
> >=20
> >  =20
> >> Move the create_pcie() call after the creation of the acpi
> >> ged device since hotplug callbacks will soon be called on gpex
> >> realize and will require the acpi pcihp state to be initialized.
> >>
> >> The hacky thing is the root bus has not yet been created on
> >> acpi_pcihp_init() call so it is set later after the gpex realize. =20
> >=20
> > can you elaborate on this, preferably with call expected call flows? =20
>=20
> The way I'm understanding it is: because the GED and GPEX are created
> in virt.c, so at the machine "level" (and so a machine hotplug handler is
> used instead of a device hotplug handler, like it's done in PIIX4 and ICH9
> controller in the x86 machines), and they need to be created in that
> order because of dependecy of GPEX of GED, the flow is:
>=20
> 1) create_acpi_ged() -> calls acpi_pcihp_init(), which by its turn will i=
nspect the root bus to generate the ACPI code
> 2) create_pcie() -> just in realize the root bus will be created
>=20
> and the sequence has to be 1 -> 2, because GED will be used in the GPEX c=
allbacks on hotplug.
>=20
> So here we're following a different design from the current one in x86,
> which handles the hotplug at the PCI controller "level".

It should be fine to keep x86 design instead of making up a new one
(unless we have to).

The difference between x86 and ARM is that acpi device happens to part of
host bridge or its children. While in ARM virt, its separate devices
(GPEX & GED).

=46rom quick glance at the code, It should be fine to keep pcihp hw as part
of GED. All it needs from host-bridge is root bus, the rest is paravirt
ACPI magic wand.

Also we typically handle hotplug for devices that have parent bus
we are using bus hotplug handler.
Only bus-less or complicated cases are orchestrated by machine.
That's what is not this series, it probably has been overlooked
since it's not in pcihp.c, so kinda not obvious.

for example see:
   ich9_pm_init()
     qbus_set_hotplug_handler()
where default native hotplug handler is overridden with ACPI one,
and then later on, all coldplug bridges are picked up by
acpi_pcihp_device_plug_cb() and got the same treatment.

So I'd suggest to try keeping current order with few changes
  create pci
  create ged (bus)
      acpidev =3D object_new(GED)
      object_property_set_link(acpidev, 'pci_root_bus', bus)
      realize(acpidev)

and then in
     ged_realize(dev)
        acpi_pcihp_init()
        qbus_set_hotplug_handler(root_bus, dev)

that's likely would do the job.

>=20
> Cheers,
> Gustavo
>=20
> >> How to fix this chicken & egg issue?
> >>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >>
> >> ---
> >>
> >> v1 -> v2:
> >> - use ACPI_PCIHP_REGION_NAME
> >> ---
> >>   include/hw/arm/virt.h    |  1 +
> >>   hw/arm/virt-acpi-build.c |  1 +
> >>   hw/arm/virt.c            | 42 +++++++++++++++++++++++++++++++++++---=
--
> >>   3 files changed, 39 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> >> index 1b2e2e1284..a4c4e3a67a 100644
> >> --- a/include/hw/arm/virt.h
> >> +++ b/include/hw/arm/virt.h
> >> @@ -35,6 +35,7 @@
> >>   #include "hw/boards.h"
> >>   #include "hw/arm/boot.h"
> >>   #include "hw/arm/bsa.h"
> >> +#include "hw/acpi/pcihp.h"
> >>   #include "hw/block/flash.h"
> >>   #include "system/kvm.h"
> >>   #include "hw/intc/arm_gicv3_common.h"
> >> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> >> index 9d88ffc318..cd49f67d60 100644
> >> --- a/hw/arm/virt-acpi-build.c
> >> +++ b/hw/arm/virt-acpi-build.c
> >> @@ -44,6 +44,7 @@
> >>   #include "hw/acpi/generic_event_device.h"
> >>   #include "hw/acpi/tpm.h"
> >>   #include "hw/acpi/hmat.h"
> >> +#include "hw/acpi/pcihp.h"
> >>   #include "hw/pci/pcie_host.h"
> >>   #include "hw/pci/pci.h"
> >>   #include "hw/pci/pci_bus.h"
> >> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> >> index 4aa40c8e8b..cdcff0a984 100644
> >> --- a/hw/arm/virt.c
> >> +++ b/hw/arm/virt.c
> >> @@ -682,6 +682,8 @@ static inline DeviceState *create_acpi_ged(VirtMac=
hineState *vms)
> >>   {
> >>       DeviceState *dev;
> >>       MachineState *ms =3D MACHINE(vms);
> >> +    SysBusDevice *sbdev;
> >> +
> >>       int irq =3D vms->irqmap[VIRT_ACPI_GED];
> >>       uint32_t event =3D ACPI_GED_PWR_DOWN_EVT;
> >>  =20
> >> @@ -693,12 +695,28 @@ static inline DeviceState *create_acpi_ged(VirtM=
achineState *vms)
> >>           event |=3D ACPI_GED_NVDIMM_HOTPLUG_EVT;
> >>       }
> >>  =20
> >> +    if (vms->acpi_pcihp) {
> >> +        event |=3D ACPI_GED_PCI_HOTPLUG_EVT;
> >> +    }
> >> +
> >>       dev =3D qdev_new(TYPE_ACPI_GED);
> >>       qdev_prop_set_uint32(dev, "ged-event", event);
> >> -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> >> +    sbdev =3D SYS_BUS_DEVICE(dev);
> >> +    sysbus_realize_and_unref(sbdev, &error_fatal);
> >>  =20
> >> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_ACPI_GED=
].base);
> >> -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, vms->memmap[VIRT_PCDIMM_A=
CPI].base);
> >> +    sysbus_mmio_map(sbdev, 0, vms->memmap[VIRT_ACPI_GED].base);
> >> +    sysbus_mmio_map(sbdev, 1, vms->memmap[VIRT_PCDIMM_ACPI].base); =20
> >=20
> >=20
> > Perhaps move out sbdev renaming into a separate patch, as it's not real=
ly related.
> >  =20
> >> +    if (vms->acpi_pcihp) {
> >> +        AcpiGedState *acpi_ged_state =3D ACPI_GED(dev);
> >> +        int i;
> >> +
> >> +        i =3D sysbus_mmio_map_name(sbdev, ACPI_PCIHP_REGION_NAME,
> >> +                                 vms->memmap[VIRT_ACPI_PCIHP].base); =
=20
> >=20
> > I don't like mix of old way (index based) above and new name based mapp=
ing,
> > can we use the same, please?
> >  =20
> >> +        assert(i >=3D 0); =20
> > g_assert(sysbus_mmio_map_name...) to get more meaning-full crash
> > that is not compiled out.
> >  =20
> >> +        acpi_pcihp_init(OBJECT(dev), &acpi_ged_state->pcihp_state,
> >> +                        vms->bus, sysbus_mmio_get_region(sbdev, i), 0=
); =20
> >=20
> > hmm, looks broken..
> >   region mapping must happen after acpi_pcihp_init().
> >=20
> > if we after making sysbus_mmio_map() sane and easier to use
> > (which is a bit on tangent to this series).
> > We could feed sysbus owner device a memory map (ex: name based),
> > and then use [pre_]plug handlers on sysbus to map children
> > automatically.
> > That will alleviate need to do all mapping manually in every board.
> > (frankly speaking it deserves its own series, with tree wide cleanup).
> >=20
> > As it is I'd use old index based approach like the rest.
> > (unless you feel adventurous about sysbus refactoring)
> >=20
> >  =20
> >> +        acpi_ged_state->pcihp_state.use_acpi_hotplug_bridge =3D true;
> >> +    }
> >>       sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(vms-=
>gic, irq));
> >>  =20
> >>       return dev;
> >> @@ -1758,6 +1776,13 @@ void virt_machine_done(Notifier *notifier, void=
 *data)
> >>       pci_bus_add_fw_cfg_extra_pci_roots(vms->fw_cfg, vms->bus,
> >>                                          &error_abort); =20
> >=20
> >  =20
> >> +
> >> +    if (vms->acpi_pcihp) {
> >> +        AcpiGedState *acpi_ged_state =3D ACPI_GED(vms->acpi_dev);
> >> +
> >> +        acpi_pcihp_reset(&acpi_ged_state->pcihp_state);
> >> +    }
> >> +
> >>       virt_acpi_setup(vms);
> >>       virt_build_smbios(vms);
> >>   }
> >> @@ -2395,8 +2420,6 @@ static void machvirt_init(MachineState *machine)
> >>  =20
> >>       create_rtc(vms);
> >>  =20
> >> -    create_pcie(vms);
> >> -
> >>       if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enable=
d(vms)) {
> >>           vms->acpi_pcihp &=3D !vmc->no_acpi_pcihp;
> >>           vms->acpi_dev =3D create_acpi_ged(vms);
> >> @@ -2405,6 +2428,15 @@ static void machvirt_init(MachineState *machine)
> >>           create_gpio_devices(vms, VIRT_GPIO, sysmem);
> >>       }
> >>  =20
> >> +    create_pcie(vms);
> >> +
> >> +    if (vms->acpi_dev) {
> >> +        AcpiGedState *acpi_ged_state =3D ACPI_GED(vms->acpi_dev);
> >> +
> >> +        acpi_ged_state =3D ACPI_GED(vms->acpi_dev);
> >> +        acpi_ged_state->pcihp_state.root =3D vms->bus;
> >> +    }
> >> +
> >>       if (vms->secure && !vmc->no_secure_gpio) {
> >>           create_gpio_devices(vms, VIRT_SECURE_GPIO, secure_sysmem);
> >>       } =20
> >=20
> > I don't like pulling acpi_pcihp_init()/reset (and issues it causes) int=
o board code,
> > on x86 it's a part of host bridge device model.
> > The same should apply to GED device.
> >=20
> > The only thing board has to do is map regions into IO space like we do
> > everywhere else.
> >=20
> > with current code, may be add link<pci_bus> property to GED,
> > and set it before GED realize in create_acpi_ged(),
> > then just follow existing sysbus_mmio_map() pattern.
> >  =20
>=20


