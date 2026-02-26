Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E239FCE075
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 12:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvavM-0002qv-Pw; Thu, 26 Feb 2026 07:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vvavK-0002qg-LU
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 07:56:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vvavI-0001s9-1G
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 07:56:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772110614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vGPjbv3Ux2gI6gdBnHtmsiwJw8BnQyYk2fkN3x938J8=;
 b=GrWiw/TXQpaTYL4x0VwMVzBIUGEAFpklGcV9KNMAzZssue5PcqXU+bLo/NbTHrYpfvv/AF
 OcWrXs3fCcjQN9vPzx7Ti/sr9uDL3QC+I2bllmyp4rlcf83VYsSsWA0RnblCbxOVxrvhlD
 vCyNRt+GalONoyAPmz2fZQIVrsGLyrg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-4dKjqByYOG6_T8wZH2IFcg-1; Thu, 26 Feb 2026 07:56:53 -0500
X-MC-Unique: 4dKjqByYOG6_T8wZH2IFcg-1
X-Mimecast-MFC-AGG-ID: 4dKjqByYOG6_T8wZH2IFcg_1772110612
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43990373d35so648212f8f.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 04:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772110612; x=1772715412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vGPjbv3Ux2gI6gdBnHtmsiwJw8BnQyYk2fkN3x938J8=;
 b=qR6wyg0znVfWNyYXZzI96668r49DomcQPHZfRNXzX41Eikwx5E0JUHb+o0BD7dT6se
 eqvdppJy83nkFTUIZiFCiT8SJNzMWenTQ4z3G26IkHF6o6IYB3sISV/4RHOWQXIgcea4
 1ZRjw4j4Zd6+cw5K+seLLwm5nycO59xvdH02cTR3wN/XXA6QyDYR69nM4V2ak/OOUGNq
 DB5x/KTETG3NPRkLPij7V3l01tt2+7CJ1OOMkVDoCWO6ixO4MyzSxxbSRQLE+/ITycGy
 nQvsPecYpyMU11qx4jedw8HlFJQrw15p0XySxmWdwJlcJB5H8PNCVe2q6Va6t4ZmGDAl
 AmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772110612; x=1772715412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vGPjbv3Ux2gI6gdBnHtmsiwJw8BnQyYk2fkN3x938J8=;
 b=OBMZT+Rw1Z8d0MghN/hwqezfQthm0B1+YuTdmfsreuZ8LrCLzxfh1xtnA5nBkzeY/r
 WTp+vrNbhQXvfS9ZqmHFsTMJ4BKTi+UdCRBQ101dMI/FozLkIckaPjZ+EQPp1vVj7G5R
 IzTmitAo3DCbz5M8bWHXY7sfeoGhcNDwKUJuP5AdTs/BZUld3W760bOM2f/cLm27q8mo
 2bpDi2SvofchJYCZsH/Gu93sslx7jalKH/rs0C3TotevmylfXTcOIegKIiIVn0DAoeIe
 +GjzSpmTFgSxhz2L4pEK80UcLznWglkqvzUca3rQ/PXtDRH2vcgiKKifHHoBoQ9ntmxc
 Y/8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXISo3cyks5mVc7Pfu+FRxmLteKbd5EV8ygTqa4i/MYkzmxrvTb31cpAnOpBQ0LM5wzc+G3IJTKT8tB@nongnu.org
X-Gm-Message-State: AOJu0YxXSOC0r4CtMyCvl0ewVvwaz/IYikyaH0Uj2MwodzeZ+Nt8NcCn
 2GtsIYccRXW/749iXtz/Ar8You5W4Cjy17SkQPZqNdSLixljI8hH7xmKfUP4832D9Rts/OBz3xJ
 MxQfO+ERA6Q4Zwk0GRqlxG8mAJPn6BUPR4X6f2BtYKJ2LeJsIfa8QEHA2
X-Gm-Gg: ATEYQzwi9Xj85HjyahbzHXEYZQxANAHzo2pbYkBGwlNHrN4w5ZCUdGDNTZfeWEbJZNw
 1zpF8D3iZRit5BZA2yybDE12I5wFZPf7BI0pdzuMYgzcpmtukA/C3AAcX8bu9IiEQccyqqBHAmV
 3Ah1z1Iz51BBYjscgdX4GgOMHIDdOIrfopMM+lrT+zi8F7DTPOKEK7LvQ44a6hqMbU2R5RKjV8s
 u4cXEBJcGeI5nyqabfVRva5PpaKnLCgQailoz2aecKcqsMAcxUfyM0oDdNw6YQeklXJ2WmRfUGq
 o/uEu7ODtY+UnytTaPmkft43wh3orlNMjkp6xNJvve84pOMwi/HGi/LhwRERnfIO7vsTDU1Y4aL
 2AXwgdg==
X-Received: by 2002:a05:6000:290b:b0:439:8d77:4dad with SMTP id
 ffacd0b85a97d-43994305b07mr7721636f8f.55.1772110611534; 
 Thu, 26 Feb 2026 04:56:51 -0800 (PST)
X-Received: by 2002:a05:6000:290b:b0:439:8d77:4dad with SMTP id
 ffacd0b85a97d-43994305b07mr7721587f8f.55.1772110610997; 
 Thu, 26 Feb 2026 04:56:50 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970c09897sm42337544f8f.17.2026.02.26.04.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 04:56:50 -0800 (PST)
Date: Thu, 26 Feb 2026 13:56:48 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 shannon.zhaosl@gmail.com, philmd@linaro.org, zhao1.liu@intel.com,
 rad@semihalf.com, leif.lindholm@oss.qualcomm.com, Markus Armbruster
 <armbru@redhat.com>
Subject: Re: [PATCH 08/11] arm: virt: create GWDT watchdog paired with WDAT
 ACPI table
Message-ID: <20260226135648.4c1a4009@imammedo>
In-Reply-To: <aZ8THMubft44Q3E-@redhat.com>
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-9-imammedo@redhat.com>
 <CAFEAcA_QO_Pm5qKy2xOer+VmyMZ6KZ1KdUpf_ETV9fQu4YmaHg@mail.gmail.com>
 <20260219131751.4e4e4e0e@imammedo> <aZ8THMubft44Q3E-@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 25 Feb 2026 15:19:56 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Thu, Feb 19, 2026 at 01:17:51PM +0100, Igor Mammedov wrote:
> > On Wed, 18 Feb 2026 19:08:36 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >  =20
> > > On Fri, 6 Feb 2026 at 13:15, Igor Mammedov <imammedo@redhat.com> wrot=
e: =20
> > > >
> > > > Add SBSA generic watchdog to virt machine type with
> > > > all necessary wiring for ACPI watchdog. Which includes
> > > > setting its frequency to 1KHz (max that WDAT is able to handle).
> > > >
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > ---   =20
> > >  =20
> > > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > > index 390845c503..caf5700ed2 100644
> > > > --- a/hw/arm/virt.c
> > > > +++ b/hw/arm/virt.c
> > > > @@ -93,6 +93,7 @@
> > > >  #include "hw/cxl/cxl.h"
> > > >  #include "hw/cxl/cxl_host.h"
> > > >  #include "qemu/guest-random.h"
> > > > +#include "hw/watchdog/sbsa_gwdt.h"
> > > >
> > > >  static GlobalProperty arm_virt_compat[] =3D {
> > > >      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
> > > > @@ -194,6 +195,8 @@ static const MemMapEntry base_memmap[] =3D {
> > > >      [VIRT_PVTIME] =3D             { 0x090a0000, 0x00010000 },
> > > >      [VIRT_SECURE_GPIO] =3D        { 0x090b0000, 0x00001000 },
> > > >      [VIRT_ACPI_PCIHP] =3D         { 0x090c0000, ACPI_PCIHP_SIZE },
> > > > +    [VIRT_GWDT_REFRESH] =3D       { 0x090d0000, 0x00001000 },
> > > > +    [VIRT_GWDT_CONTROL] =3D       { 0x090d1000, 0x00001000 },
> > > >      [VIRT_MMIO] =3D               { 0x0a000000, 0x00000200 },
> > > >      /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of =
that size */
> > > >      [VIRT_PLATFORM_BUS] =3D       { 0x0c000000, 0x02000000 },
> > > > @@ -245,12 +248,32 @@ static const int a15irqmap[] =3D {
> > > >      [VIRT_GPIO] =3D 7,
> > > >      [VIRT_UART1] =3D 8,
> > > >      [VIRT_ACPI_GED] =3D 9,
> > > > +    [VIRT_GWDT_WS0] =3D 10,
> > > >      [VIRT_MMIO] =3D 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
> > > >      [VIRT_GIC_V2M] =3D 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
> > > >      [VIRT_SMMU] =3D 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
> > > >      [VIRT_PLATFORM_BUS] =3D 112, /* ...to 112 + PLATFORM_BUS_NUM_I=
RQS -1 */
> > > >  };
> > > >
> > > > +static void create_wdt(const VirtMachineState *vms)
> > > > +{
> > > > +    hwaddr rbase =3D vms->memmap[VIRT_GWDT_REFRESH].base;
> > > > +    hwaddr cbase =3D vms->memmap[VIRT_GWDT_CONTROL].base;
> > > > +    int irq =3D vms->irqmap[VIRT_GWDT_WS0];
> > > > +    DeviceState *dev =3D qdev_new(TYPE_WDT_SBSA);
> > > > +    SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
> > > > +
> > > > +    /*
> > > > +     * Set watchdog tick freq to 1Kz as it's the max WDAT driver
> > > > +     * is able to handle.
> > > > +     */
> > > > +    qdev_prop_set_uint64(dev, "clock-frequency", 1000 /* 1KHz */);
> > > > +    sysbus_realize_and_unref(s, &error_fatal);
> > > > +    sysbus_mmio_map(s, 0, rbase);
> > > > +    sysbus_mmio_map(s, 1, cbase);
> > > > +    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
> > > > +}   =20
> > >=20
> > > Please can you also add support for exposing this device
> > > in the device tree ? =20
> >=20
> > It's possible,
> > but we probably should not enable it if acpi variant was requested,
> > to avoid confusion on guest side.
> >=20
> > For Windows it doesn't really mater, for linux it does.
> > on x86 linux guest uses a quirk to disable native iTCO watchdog
> > in favor of WDAT one if later is present.
> > I assume quirk is not desirable so we should expose only a preferred
> > variant.
> >  =20
> > >  =20
> > > > +
> > > >  static void create_randomness(MachineState *ms, const char *node)
> > > >  {
> > > >      struct {
> > > > @@ -2515,6 +2538,9 @@ static void machvirt_init(MachineState *machi=
ne)
> > > >      vms->highmem_ecam &=3D (!firmware_loaded || aarch64);
> > > >
> > > >      create_rtc(vms);
> > > > +    if (machine->acpi_watchdog) {
> > > > +        create_wdt(vms);
> > > > +    }   =20
> > >=20
> > > Can we have a command line option name that isn't ACPI
> > > specific, please? There's nothing inherent to ACPI about
> > > "I would like a watchdog device". =20
> >=20
> > that is specifically asking for ACPI flavor being used/configured.
> > acpi specific option conflates 2 things:
> >    1. watchdog device creation (of the board choice) with properties tu=
ned for WDAT usage
> >    2. how to expose it on firmware level (in this case ACPI WDAT table)
> >=20
> > other option, I've considered was
> >  -device some_wd[,fw=3Ddt|acpi|none]
> > but then 'fw' is not exactly device property but rather a machine one
> > (we can 'abuse' it/use as a proxy of cause).
> > However it doesn't work for boards that have builtin watchdog. =20
>=20
> Right, if there was a case where we were already using -device to
> create the watchdog, then I would suggest having a simple
> 'wadt=3Don|off' property as standard for any watchdog wanting that
> ACPI abstraction wrapper.
>=20
> That could (hypothetically) be the case if we had chosen to add
> WADT suport backed by i6300esb, eg -device i6300esb,wadt=3Don|off
>=20
> For cases built-in to the machine type, I'd suggest <type>-wadt=3Don|off
>=20
> eg for Q35,  "-machine q35,itco-wadt=3Don|off"
>=20
> for virt, '-machine virt,gwdt-wadt=3Don|off'

CCin Markus since it touches QAPI stuff.

For respin, I've went ahead with a bit more generic approach
(as a user, I wouldn't really care what kind of built-in watchdog board shi=
ps,
and having 1 property instead total instead of machine specific ones makes =
it
easier for mgmt layer to deal with).

here is current idea:

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6411e68856..a0c6719b58 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1257,6 +1271,14 @@ static void machine_class_init(ObjectClass *oc, cons=
t void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "memory",
         "Memory size configuration");
+
+    object_class_property_add_enum(oc, "watchdog", "WatchdogType",
+        &WatchdogType_lookup,
+        machine_get_watchdog, machine_set_watchdog);
+     object_class_property_set_description(oc, "watchdog",
+        "Use: auto (watchdog is configured according board defaults),"
+        " off (disabled), native (built-in watchdog), wdat (ACPI based wat=
chdog)]. "
+        " Default: auto");
 }

diff --git a/qapi/machine-common.json b/qapi/machine-common.json
index 92e84dfb14..7f5e10340f 100644
--- a/qapi/machine-common.json
+++ b/qapi/machine-common.json
@@ -9,6 +9,23 @@
 # Common machine types
 # ********************
 ##
+##
+# @WatchdogType:
+#
+# On board watchdog configuration.
+#
+# @auto: Watchdog is configured according to board defaults.
+#
+# @off: Watchdog disabled (ARM).
+#
+# @native: Native watchdog (arm/virt: sbsa-gwdt, x86/q53: TCO)
+#
+# @wdat: ACPI WDAT watchdog.
+#
+# Since: 10.2
+##
+{ 'enum': 'WatchdogType',
+  'data': [ 'auto', 'off', 'native', 'wdat' ] }



> Q35 is easier as we rely on the guest quirks to disable direct
> access via both paths.
>=20
> With GWDT we need to decide if gwdt-wadt=3Don should imply DTB
> disabled, or if we just expose both & rely on a guest quirk
> or worst case, need a separate property to toggle DTB too.
>=20
> > I've used device property for x86 Q35 TCO watchdog and
> > then using -global to enable it as workaround in previous version.
> > Ugly but doable workaround. It puts a burden on users to learn how
> > to configure it for each support watchdog/board combo.
> > It's nightmare to discover/maintain though.
> >=20
> > Hence in this version, I've used a generic machine property approach
> > that exposes feature in uniform way across boards.
> >=20
> > enum might work, but ...
> >   machine.watchdog =3D [acpi | what else could we put here???]
> >=20
> > I'm not married to a way how we expose/configure it and will rewrite
> > it to something that works for majority.
> >  =20
> > > thanks
> > > -- PMM
> > >  =20
> >  =20
>=20
> With regards,
> Daniel


