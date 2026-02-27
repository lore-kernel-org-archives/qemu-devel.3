Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE6EFD5323
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 09:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvuMx-0003eo-Ig; Fri, 27 Feb 2026 04:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vvuMu-0003eT-7k
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 04:42:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vvuMp-0005oU-HM
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 04:42:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772185357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dZA1WBA4FETQ9pY8HOR9yTT3oIH0yOYOVCXzxT1O6l0=;
 b=cJPmf040tTzr9/QfM3naW7j3pXKZmGbZKWtF2jhVDzJJNCIh//vAYtQLdf+59buk2SwnLG
 Hv/R02OOPcXrZGR9YOU6nJOGc6c6kk1YNy/9uW7HwgqJxWxrt3UqCNh6f9ZPiKzETJFG/N
 7TumuTeLJ78ToP4xy6nBGVK9dDLGdQM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-RaqdPOz_MUy1k1GXLbN2Rg-1; Fri, 27 Feb 2026 04:42:35 -0500
X-MC-Unique: RaqdPOz_MUy1k1GXLbN2Rg-1
X-Mimecast-MFC-AGG-ID: RaqdPOz_MUy1k1GXLbN2Rg_1772185354
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4398fed3552so1629880f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 01:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772185354; x=1772790154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dZA1WBA4FETQ9pY8HOR9yTT3oIH0yOYOVCXzxT1O6l0=;
 b=kgUVyabSxblUG61ub6aPK04Xkcy/mQqUdLJKvYhjlGY91ZVBREfZFhY7Fi0QYnPzUM
 UK2WGLMM40XLVCjdZ9i6hW7y9NXTTIttutAmJ/BKHs8JHtD+nZtTagol7dSOL9VEgbBX
 SQyckcCKhb7aFDZR9hyXd1Szy8UJaiBfCzYo8HA1pkxyTHbf638UEFhUip5pn8jaAKf/
 l8nfk/oAfWfMep/e49pzve/XtMQ2MhTpc9WQnDOvTYGCdwz+28Cwvq6i9pbQrMgmMeN+
 3w994+/83QtfmOQFyQvDRl2OlFq5mr5mBMeN7J6UiFl7rav/GadG+Ts1FN+8M5UlIpxu
 Af1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772185354; x=1772790154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dZA1WBA4FETQ9pY8HOR9yTT3oIH0yOYOVCXzxT1O6l0=;
 b=EmrQQC4Pyz+YVj3hIXouF3HcZ19qDpCGSRnt5L1wAQE6u7z7+UWk4x/kU8Ck6ITV9K
 RJvd/sYu3F8dMpBhUwOCUP3KwGo0MrPYqBaekPWR+sJGp4ZFO+LDo2j9tb1CtINXNI78
 bVOQtaLmK+MWlSUwKeLpL5MXWbWR9tnkCQlePl9ZEUECVImO7rPK9Gs7NLlLbaxTZjB7
 tbYYWgWpkIE+bgA9TBBOqGbx/WkZB3Yg8SOjHs2WSrYCLuMoK4P/9bzyQcur5gvwSJVj
 t1ICo72CeCUhXlf9rY8PRf2kS0UWjd+Lpxz9vLQBU5OYj1RRqVcwWHmzQUkpLi8YDFg1
 caVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1g4M2G9KGrcWCsE+IF6iLVeHrYPog+A9GzjAaeFU4QSQYq6qQiagJjQeI4hOJU6weQGeVqsTFEqKg@nongnu.org
X-Gm-Message-State: AOJu0Yyy4gdcUXKBuuyIium0nussQ0sudkZ+UuNUbC3AJTkou3+rRUk1
 kWs/22M+OPHaQmPhsZykqxeKVnn+x3i9Mfr5L0OqKFL95/EzsF1AuoP7E2UyazFApiA/V5faKH2
 fyvqscEUYYfXOUZEJe+2YFig4YnEOE9w2np1tlwps13u9GVh6EL7D/0p3
X-Gm-Gg: ATEYQzzRpMyFP5nGeBlVPXa9n8sjkHubUPyDJqOCgofdEMmRuPJklyliQDFP16VGHsI
 SaNkSkE3ndvp1C6rSNiiyjRHhNlc3Wkgbt3wpphEyu5wGcmC/ls0pb45+xS7kLjG85USU9loM3U
 YuTb2GCPYzBYnyh3NheigXC0IFhIMWoK8N7dvqRAKuDWz8ZZev9+fXDBS1lt1QF8WtF6jMM+DhF
 fljBrNrzEzeO3I1uPGNuevErFTtKDb01Mdr0Bna8iqhv7WijYpijgulPBqiJEdbdqORDuBkIbjq
 RyQTFO/EhhqXs0+lxwwjDRDKSo/ZP9idoO0edJ5E6/ZaLQwHyuqUw7NL3SfhFS1qNDnWeYL6LG6
 spS53ig==
X-Received: by 2002:a05:6000:25c3:b0:437:8f37:887 with SMTP id
 ffacd0b85a97d-4399de3e4f6mr3728816f8f.36.1772185353648; 
 Fri, 27 Feb 2026 01:42:33 -0800 (PST)
X-Received: by 2002:a05:6000:25c3:b0:437:8f37:887 with SMTP id
 ffacd0b85a97d-4399de3e4f6mr3728753f8f.36.1772185352977; 
 Fri, 27 Feb 2026 01:42:32 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b19esm6305321f8f.25.2026.02.27.01.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 01:42:32 -0800 (PST)
Date: Fri, 27 Feb 2026 10:42:27 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, mst@redhat.com,
 anisinha@redhat.com, pbonzini@redhat.com, shannon.zhaosl@gmail.com,
 philmd@linaro.org, zhao1.liu@intel.com, rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com
Subject: Re: [PATCH 08/11] arm: virt: create GWDT watchdog paired with WDAT
 ACPI table
Message-ID: <20260227104227.3d84f0d7@imammedo>
In-Reply-To: <878qced4xx.fsf@pond.sub.org>
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-9-imammedo@redhat.com>
 <CAFEAcA_QO_Pm5qKy2xOer+VmyMZ6KZ1KdUpf_ETV9fQu4YmaHg@mail.gmail.com>
 <20260219131751.4e4e4e0e@imammedo> <aZ8THMubft44Q3E-@redhat.com>
 <20260226135648.4c1a4009@imammedo> <878qced4xx.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 27 Feb 2026 08:24:42 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Igor Mammedov <imammedo@redhat.com> writes:
>=20
> > On Wed, 25 Feb 2026 15:19:56 +0000
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > =20
> >> On Thu, Feb 19, 2026 at 01:17:51PM +0100, Igor Mammedov wrote: =20
> >> > On Wed, 18 Feb 2026 19:08:36 +0000
> >> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >> >    =20
> >> > > On Fri, 6 Feb 2026 at 13:15, Igor Mammedov <imammedo@redhat.com> w=
rote:   =20
> >> > > >
> >> > > > Add SBSA generic watchdog to virt machine type with
> >> > > > all necessary wiring for ACPI watchdog. Which includes
> >> > > > setting its frequency to 1KHz (max that WDAT is able to handle).
> >> > > >
> >> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >> > > > ---     =20
> >> > >    =20
> >> > > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> >> > > > index 390845c503..caf5700ed2 100644
> >> > > > --- a/hw/arm/virt.c
> >> > > > +++ b/hw/arm/virt.c
> >> > > > @@ -93,6 +93,7 @@
> >> > > >  #include "hw/cxl/cxl.h"
> >> > > >  #include "hw/cxl/cxl_host.h"
> >> > > >  #include "qemu/guest-random.h"
> >> > > > +#include "hw/watchdog/sbsa_gwdt.h"
> >> > > >
> >> > > >  static GlobalProperty arm_virt_compat[] =3D {
> >> > > >      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
> >> > > > @@ -194,6 +195,8 @@ static const MemMapEntry base_memmap[] =3D {
> >> > > >      [VIRT_PVTIME] =3D             { 0x090a0000, 0x00010000 },
> >> > > >      [VIRT_SECURE_GPIO] =3D        { 0x090b0000, 0x00001000 },
> >> > > >      [VIRT_ACPI_PCIHP] =3D         { 0x090c0000, ACPI_PCIHP_SIZE=
 },
> >> > > > +    [VIRT_GWDT_REFRESH] =3D       { 0x090d0000, 0x00001000 },
> >> > > > +    [VIRT_GWDT_CONTROL] =3D       { 0x090d1000, 0x00001000 },
> >> > > >      [VIRT_MMIO] =3D               { 0x0a000000, 0x00000200 },
> >> > > >      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each =
of that size */
> >> > > >      [VIRT_PLATFORM_BUS] =3D       { 0x0c000000, 0x02000000 },
> >> > > > @@ -245,12 +248,32 @@ static const int a15irqmap[] =3D {
> >> > > >      [VIRT_GPIO] =3D 7,
> >> > > >      [VIRT_UART1] =3D 8,
> >> > > >      [VIRT_ACPI_GED] =3D 9,
> >> > > > +    [VIRT_GWDT_WS0] =3D 10,
> >> > > >      [VIRT_MMIO] =3D 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1=
 */
> >> > > >      [VIRT_GIC_V2M] =3D 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
> >> > > >      [VIRT_SMMU] =3D 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
> >> > > >      [VIRT_PLATFORM_BUS] =3D 112, /* ...to 112 + PLATFORM_BUS_NU=
M_IRQS -1 */
> >> > > >  };
> >> > > >
> >> > > > +static void create_wdt(const VirtMachineState *vms)
> >> > > > +{
> >> > > > +    hwaddr rbase =3D vms->memmap[VIRT_GWDT_REFRESH].base;
> >> > > > +    hwaddr cbase =3D vms->memmap[VIRT_GWDT_CONTROL].base;
> >> > > > +    int irq =3D vms->irqmap[VIRT_GWDT_WS0];
> >> > > > +    DeviceState *dev =3D qdev_new(TYPE_WDT_SBSA);
> >> > > > +    SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
> >> > > > +
> >> > > > +    /*
> >> > > > +     * Set watchdog tick freq to 1Kz as it's the max WDAT driver
> >> > > > +     * is able to handle.
> >> > > > +     */
> >> > > > +    qdev_prop_set_uint64(dev, "clock-frequency", 1000 /* 1KHz *=
/);
> >> > > > +    sysbus_realize_and_unref(s, &error_fatal);
> >> > > > +    sysbus_mmio_map(s, 0, rbase);
> >> > > > +    sysbus_mmio_map(s, 1, cbase);
> >> > > > +    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
> >> > > > +}     =20
> >> > >=20
> >> > > Please can you also add support for exposing this device
> >> > > in the device tree ?   =20
> >> >=20
> >> > It's possible,
> >> > but we probably should not enable it if acpi variant was requested,
> >> > to avoid confusion on guest side.
> >> >=20
> >> > For Windows it doesn't really mater, for linux it does.
> >> > on x86 linux guest uses a quirk to disable native iTCO watchdog
> >> > in favor of WDAT one if later is present.
> >> > I assume quirk is not desirable so we should expose only a preferred
> >> > variant.
> >> >    =20
> >> > >    =20
> >> > > > +
> >> > > >  static void create_randomness(MachineState *ms, const char *nod=
e)
> >> > > >  {
> >> > > >      struct {
> >> > > > @@ -2515,6 +2538,9 @@ static void machvirt_init(MachineState *ma=
chine)
> >> > > >      vms->highmem_ecam &=3D (!firmware_loaded || aarch64);
> >> > > >
> >> > > >      create_rtc(vms);
> >> > > > +    if (machine->acpi_watchdog) {
> >> > > > +        create_wdt(vms);
> >> > > > +    }     =20
> >> > >=20
> >> > > Can we have a command line option name that isn't ACPI
> >> > > specific, please? There's nothing inherent to ACPI about
> >> > > "I would like a watchdog device".   =20
> >> >=20
> >> > that is specifically asking for ACPI flavor being used/configured.
> >> > acpi specific option conflates 2 things:
> >> >    1. watchdog device creation (of the board choice) with properties=
 tuned for WDAT usage
> >> >    2. how to expose it on firmware level (in this case ACPI WDAT tab=
le)
> >> >=20
> >> > other option, I've considered was
> >> >  -device some_wd[,fw=3Ddt|acpi|none]
> >> > but then 'fw' is not exactly device property but rather a machine one
> >> > (we can 'abuse' it/use as a proxy of cause).
> >> > However it doesn't work for boards that have builtin watchdog.   =20
> >>=20
> >> Right, if there was a case where we were already using -device to
> >> create the watchdog, then I would suggest having a simple
> >> 'wadt=3Don|off' property as standard for any watchdog wanting that
> >> ACPI abstraction wrapper.
> >>=20
> >> That could (hypothetically) be the case if we had chosen to add
> >> WADT suport backed by i6300esb, eg -device i6300esb,wadt=3Don|off
> >>=20
> >> For cases built-in to the machine type, I'd suggest <type>-wadt=3Don|o=
ff
> >>=20
> >> eg for Q35,  "-machine q35,itco-wadt=3Don|off"
> >>=20
> >> for virt, '-machine virt,gwdt-wadt=3Don|off' =20
> >
> > CCin Markus since it touches QAPI stuff.
> >
> > For respin, I've went ahead with a bit more generic approach
> > (as a user, I wouldn't really care what kind of built-in watchdog board=
 ships,
> > and having 1 property instead total instead of machine specific ones ma=
kes it
> > easier for mgmt layer to deal with).
> >
> > here is current idea:
> >
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 6411e68856..a0c6719b58 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -1257,6 +1271,14 @@ static void machine_class_init(ObjectClass *oc, =
const void *data)
> >          NULL, NULL);
> >      object_class_property_set_description(oc, "memory",
> >          "Memory size configuration");
> > +
> > +    object_class_property_add_enum(oc, "watchdog", "WatchdogType",
> > +        &WatchdogType_lookup,
> > +        machine_get_watchdog, machine_set_watchdog);
> > +     object_class_property_set_description(oc, "watchdog",
> > +        "Use: auto (watchdog is configured according board defaults),"
> > +        " off (disabled), native (built-in watchdog), wdat (ACPI based=
 watchdog)]. "
> > +        " Default: auto");
> >  } =20
>=20
> Adds the property to abstract base type "machine", i.e. every machine
> has it.

in past (which might be different from now 'policies'), we used to add
a property to abstract machine when there is more than 1 board/target
that consumes it. This follows that trend.
If that is not desirable now, I can move it specific boards at the cost
of some boiler-plate code duplication.

Boards of interest in this series are arm/virt and q35

> Fundamentally assumes there is at most one onboard watchdog of interest.

there might be, hence default 'auto' to describe various boards default/
implicit watchdog selection.
User might set it but is doesn't make much sense to configure already
default state.

> I'm lacking context, please bear with me: who or what is going to set
> this property, and for what purpose?

it's for users/mgmt apps that wish to explicitly optin to use watchdog.
majority users don't need it (and can leave it at default 'auto' or 'off' s=
tate)
but depending on usecase, watchdog presence can be a mandatory requirement.=
=20

and here comes a choice for a layer that knows what guest OS supports
to pick a suitable watchdog.

 - native: requires from user upfront knowledge what built-in watchdog is
           and if it's supported by guest
 - wdat: abstracts user from need to know what built-in watchdog is
         as still requires user to know is guest supports it

As of today guest drivers support is in following state:
  TCO watchdog on Q35 (linux: supported, Windows: not supported)
  sbsa-gwdt watchdog in arm world - (linux: supported, Windows: broken)
  wdat abstract watchdog (Q35 and arm) - (linux: supported, Windows: suppor=
ted)

peddling points in favor of wdat (MS and my to some extent)
=46rom above selection, wdat is widely supported already for 10 years,
and while it's not ideal/limited than purpose built drivers
and relies on less that ideal MS spec.
It lets use out of box drivers (both Linux and Windows) without need
to install ones on guest side.

=46rom QEMU maintenance pov, wdat abstraction uses under the hood
native watchdog, but guest OS doesn't care as all it does in wdat driver
is executing a series of mmio instructions as specified in WDAT ACPI table.
And QEMU can transparently change hidden native watchdog to
another one without need to reconfigure guest OS.
With deprecation and old machine types being removed we can gradually
phase out undesirable watchdog impl and replace it with what
we would fancy in that moment.

> > diff --git a/qapi/machine-common.json b/qapi/machine-common.json
> > index 92e84dfb14..7f5e10340f 100644
> > --- a/qapi/machine-common.json
> > +++ b/qapi/machine-common.json
> > @@ -9,6 +9,23 @@
> >  # Common machine types
> >  # ********************
> >  ##
> > +##
> > +# @WatchdogType:
> > +#
> > +# On board watchdog configuration.
> > +#
> > +# @auto: Watchdog is configured according to board defaults. =20
>=20
> As far as I can tell, we don't document "boards" (machine types)
> anywhere, let alone "board defaults".  Not this patch's fault, of
> course.  The meaning of @auto remains unclear.

would mentioning q35 and arm/virt here be of any help?
Suggestions how to deal with it?

>=20
> > +#
> > +# @off: Watchdog disabled (ARM).
> > +#
> > +# @native: Native watchdog (arm/virt: sbsa-gwdt, x86/q53: TCO)
> > +#
> > +# @wdat: ACPI WDAT watchdog.
> > +#
> > +# Since: 10.2 =20
>=20
> 11.0
>=20
> > +##
> > +{ 'enum': 'WatchdogType',
> > +  'data': [ 'auto', 'off', 'native', 'wdat' ] } =20
>=20
> What do managament applications need to know about onboard watchdog
> configuration?

given it emulates firmware knob (with qemu acting as fw),
if watchdog is needed, mgmt would need to pick either native
or wdat one based on what works for guest OS.=20

> Do they need to know what @auto means for the machine type at hand?

I don't think they would need to know what 'auto' means.

> Do they ever need to pick a value?  Do they need to know which values
> work with the machine type then?

tentatively answer to both questions is yes. not impl. yet though)
valid states per board would be:
  q35 { auto -> native, wdat, off - not supported }
  arm/virt {auto -> off, native, wdat, off }

other boards might have different mapping.

Easiest way to check for this is duplicated per board 'watchdog' property
with per board setter that verifies setting.
Or in case a of genric machine property, a callback to let boards
add their own logic in generic property setter.
=20
> >> Q35 is easier as we rely on the guest quirks to disable direct
> >> access via both paths.
> >>=20
> >> With GWDT we need to decide if gwdt-wadt=3Don should imply DTB
> >> disabled, or if we just expose both & rely on a guest quirk
> >> or worst case, need a separate property to toggle DTB too.
> >>  =20
> >> > I've used device property for x86 Q35 TCO watchdog and
> >> > then using -global to enable it as workaround in previous version.
> >> > Ugly but doable workaround. It puts a burden on users to learn how
> >> > to configure it for each support watchdog/board combo.
> >> > It's nightmare to discover/maintain though. =20
>=20
> Our unsolved "how to configure onboard devices" problem bites again.
>=20
> -global can be pressed into service when there's just once instance of
> the device type.  The drawbacks you describe are real.  I want to see
> less of it, not more.
>=20
> >> > Hence in this version, I've used a generic machine property approach
> >> > that exposes feature in uniform way across boards. =20
>=20
> We've done that before.  It works, but I don't think it scale up to a
> complete solution (I understand you are not after a complete solution
> here, and that's okay).
>=20
> For instance, machine pc-q35-FOO has two onboard cfi.pflash01 devices.
> To enable configuration of their block backends, we alias their "drive"
> properties as machine properties "pflash0" and "pflash1".  Their other
> properties remain inaccessible.
>=20
> Adding a few alias properties to the machine type is workable.  A bit ad
> hoc, perhaps.  Bothersome to document, so we largely don't.
>=20
> Adding alias properties for everything anyone could possibly want to
> configure feels unworkable.
>=20
> This is *not* an objection to solving the problem at hand with a machine
> property.

using aliases might work for q35 since it doesn't have 'off' option,
i.e. we can add 'wdat' property to TCO watchdog and then let alias it
to q35 as watchdog property:
     { native -> tco.wdat =3D off,
       wdat -> tco.wdat =3D on }

for arm/virt it would look like, adding wdat property to sbsa-gwdt watchdog
and then aliasing it machine's 'watchdog' property with following
mapping
     { off - don't create watchdog at all,
       native -> sbsa-gwdt.wdat=3Doff,
       wdat ->  sbsa-gwdt.wdat=3Don }

it doesn't seem like a workable approach

> >> > enum might work, but ...
> >> >   machine.watchdog =3D [acpi | what else could we put here???]
> >> >=20
> >> > I'm not married to a way how we expose/configure it and will rewrite
> >> > it to something that works for majority.
> >> >    =20
> >> > > thanks
> >> > > -- PMM
> >> > >    =20
> >> >    =20
> >>=20
> >> With regards,
> >> Daniel =20
>=20


