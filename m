Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2676C4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCy6-0007YD-Cz; Sat, 18 Jul 2026 17:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCy4-0007R1-K8; Sat, 18 Jul 2026 17:53:08 -0400
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([34.218.115.239])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCy1-00043a-Jn; Sat, 18 Jul 2026 17:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411585; x=1815947585;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=plv0gjrdMYCF1rCRY9EhOrLWp8nX2WczRtjb97EGJPA=;
 b=MUIVl1k5qb24DPgEMKmQ3FuT52yt7MHyvH0OhN4NlN2SNxZoWH0kVzdI
 GCl/OsAhoyN/gkIUvxzuRHPlQAZ+g7x8DsWcLn60D2Ah0KJyIBQnjrMYH
 8TGTpfXje4jMPIRStbbJ6Xe99l+GR/war1M6+5+aWQMiOvEgW6FkemERz
 E+q/1YwFwsaU/giW4QYsXHQ2auWJHrCVKmKN6kbZ25FH2Gb5lguGkCh06
 r+TBE5sURSzDjcYcJda3elMqJJkysn/m+uK/U7q9werV072jFwfFl53BB
 hxb+PuWFCT3eh5bzDFLPto7cc2+evDwPQHLd9/LPj+wCF0EjYmCS6wgKB g==;
X-CSE-ConnectionGUID: qTY5uyreRv6Q5udifIyUtw==
X-CSE-MsgGUID: tLC9YaEjRiuD86r8Mwbn8w==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23719160"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:53:02 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:23388]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.246:2525]
 with esmtp (Farcaster)
 id 995a4f38-e857-48ac-8f41-cdad6060104e; Sat, 18 Jul 2026 21:53:01 +0000 (UTC)
X-Farcaster-Flow-ID: 995a4f38-e857-48ac-8f41-cdad6060104e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:53:01 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:52:51 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>,
 <qemu-s390x@nongnu.org>, Song Gao <17746591750@163.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Farhan Ali
 <alifm@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>, "Alistair
 Francis" <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi
 <balbi@kernel.org>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Chigot?=
 <chigot@adacore.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Fabiano Rosas
 <farosas@suse.de>, Francisco Iglesias <francisco.iglesias@amd.com>, "Gaurav
 Sharma" <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?=
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, Laurent Vivier <laurent@vivier.eu>, "Manos
 Pitsidianakis" <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic
 <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow <shentey@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Sergio Lopez <slp@redhat.com>, "Subbaraya
 Sundeep" <sundeep.lkml@gmail.com>, Thomas Huth <th.huth+qemu@posteo.eu>, "Ran
 Wang" <wangran@bosc.ac.cn>, Hao Wu <wuhaotsh@google.com>
Subject: [RFC PATCH v2 057/137] hw/arm/virt: Give onboard devices a QOM parent
Date: Sat, 18 Jul 2026 21:35:32 +0000
Message-ID: <20260718213652.37673-58-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=34.218.115.239;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Convert the *_orphan() device-creation calls in hw/arm/virt.c to the
new parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing SoC device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/arm/virt.c:1085 | qdev_new | OBJECT(vms) | "acpi-ged" | helper receives VirtMachineState* board pointer
hw/arm/virt.c:1123 | qdev_new | OBJECT(vms) | "its" | helper receives VirtMachineState* board pointer
hw/arm/virt.c:1140 | qdev_new | OBJECT(vms) | "gicv2m" | helper receives VirtMachineState* board pointer
hw/arm/virt.c:1228 | qdev_new | OBJECT(vms) | "gic" | helper receives VirtMachineState* board pointer
hw/arm/virt.c:1359 | qdev_new | OBJECT(vms) | "gic" | helper receives VirtMachineState* board pointer; only one of gicv2/gicv3/gicv5 created
hw/arm/virt.c:1415 | qdev_new | OBJECT(vms) | "gic" | helper receives VirtMachineState* board pointer; only one of gicv2/gicv3/gicv5 created
hw/arm/virt.c:1512 | qdev_new | OBJECT(vms) | "uart[*]" | helper receives VirtMachineState*; called up to 2x -> auto-index; drop const
hw/arm/virt.c:1564 | sysbus_create_simple | OBJECT(vms) | "rtc" | helper receives VirtMachineState* board pointer; drop const
hw/arm/virt.c:1609 | sysbus_create_simple | parent | "gpio-key" | helper lacks parent pointer -> thread Object *parent from create_gpio_devices
hw/arm/virt.c:1634 | sysbus_create_simple | parent | "gpio-pwr" | helper lacks parent pointer -> thread Object *parent from create_gpio_devices
hw/arm/virt.c:1673 | qdev_new | OBJECT(vms) | "gpio[*]" | helper receives VirtMachineState*; called for VIRT_GPIO and VIRT_SECURE_GPIO -> auto-index; drop const
hw/arm/virt.c:1749 | sysbus_create_simple | OBJECT(vms) | "virtio-mmio[*]" | loop over transports; drop const
hw/arm/virt.c:1789 | qdev_new | OBJECT(vms) | name | collapse existing object_property_add_child(OBJECT(vms), name, ...) into qdev_new; keep existing name; virt_flash_map1 realize -> sysbus_realize
hw/arm/virt.c:2072 | qdev_new | OBJECT(vms) | "smmuv3" | helper receives VirtMachineState* board pointer; drop const
hw/arm/virt.c:2165 | qdev_new | OBJECT(vms) | "pcie" | helper receives VirtMachineState* board pointer
hw/arm/virt.c:2293 | qdev_new | OBJECT(vms) | "platform-bus" | helper receives VirtMachineState* board pointer

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/virt.c | 85 ++++++++++++++++++++++++---------------------------
 1 file changed, 40 insertions(+), 45 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1845124dc0..8bb20e692e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1082,11 +1082,11 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
         event |= ACPI_GED_NVDIMM_HOTPLUG_EVT;
     }
 
-    dev = qdev_new_orphan(TYPE_ACPI_GED);
+    dev = qdev_new(OBJECT(vms), "acpi-ged", TYPE_ACPI_GED);
     qdev_prop_set_uint32(dev, "ged-event", event);
     object_property_set_link(OBJECT(dev), "bus", OBJECT(vms->bus), &error_abort);
     sbdev = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sbdev, &error_fatal);
+    sysbus_realize(sbdev, &error_fatal);
 
     sysbus_mmio_map_name(sbdev, TYPE_ACPI_GED, vms->memmap[VIRT_ACPI_GED].base);
     sysbus_mmio_map_name(sbdev, ACPI_MEMHP_REGION_NAME,
@@ -1120,11 +1120,11 @@ static void create_its(VirtMachineState *vms)
         return;
     }
 
-    dev = qdev_new_orphan(its_class_name());
+    dev = qdev_new(OBJECT(vms), "gic-its", its_class_name());
 
     object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(vms->gic),
                              &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_ITS].base);
 
     fdt_add_its_gic_node(vms);
@@ -1137,10 +1137,10 @@ static void create_v2m(VirtMachineState *vms)
     int irq = vms->irqmap[VIRT_GIC_V2M];
     DeviceState *dev;
 
-    dev = qdev_new_orphan("arm-gicv2m");
+    dev = qdev_new(OBJECT(vms), "gicv2m", "arm-gicv2m");
     qdev_prop_set_uint32(dev, "base-spi", irq);
     qdev_prop_set_uint32(dev, "num-spi", NUM_GICV2M_SPIS);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_V2M].base);
 
     for (i = 0; i < NUM_GICV2M_SPIS; i++) {
@@ -1225,7 +1225,7 @@ static void create_gicv5(VirtMachineState *vms, MemoryRegion *mem)
     const char *gictype = gicv5_class_name();
     QList *cpulist = qlist_new(), *iaffidlist = qlist_new();
 
-    vms->gic = qdev_new_orphan(gictype);
+    vms->gic = qdev_new(OBJECT(vms), "gic", gictype);
     qdev_prop_set_uint32(vms->gic, "spi-range", NUM_IRQS);
 
     object_property_set_link(OBJECT(vms->gic), "sysmem", OBJECT(mem),
@@ -1243,7 +1243,7 @@ static void create_gicv5(VirtMachineState *vms, MemoryRegion *mem)
     qdev_prop_set_array(vms->gic, "cpu-iaffids", iaffidlist);
 
     gicbusdev = SYS_BUS_DEVICE(vms->gic);
-    sysbus_realize_and_unref(gicbusdev, &error_fatal);
+    sysbus_realize(gicbusdev, &error_fatal);
 
     /*
      * Map the IRS config frames for the interrupt domains.
@@ -1356,7 +1356,7 @@ static void create_gicv2(VirtMachineState *vms, MemoryRegion *mem)
         exit(1);
     }
 
-    vms->gic = qdev_new_orphan(gic_class_name());
+    vms->gic = qdev_new(OBJECT(vms), "gic", gic_class_name());
     qdev_prop_set_uint32(vms->gic, "revision", 2);
     qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
     /*
@@ -1370,7 +1370,7 @@ static void create_gicv2(VirtMachineState *vms, MemoryRegion *mem)
     }
 
     gicbusdev = SYS_BUS_DEVICE(vms->gic);
-    sysbus_realize_and_unref(gicbusdev, &error_fatal);
+    sysbus_realize(gicbusdev, &error_fatal);
     sysbus_mmio_map(gicbusdev, 0, vms->memmap[VIRT_GIC_DIST].base);
     sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_CPU].base);
     if (vms->virt) {
@@ -1412,7 +1412,7 @@ static void create_gicv3(VirtMachineState *vms, MemoryRegion *mem)
         exit(1);
     }
 
-    vms->gic = qdev_new_orphan(gicv3_class_name());
+    vms->gic = qdev_new(OBJECT(vms), "gic", gicv3_class_name());
     qdev_prop_set_uint32(vms->gic, "revision", revision);
     qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
     /*
@@ -1454,7 +1454,7 @@ static void create_gicv3(VirtMachineState *vms, MemoryRegion *mem)
     }
 
     gicbusdev = SYS_BUS_DEVICE(vms->gic);
-    sysbus_realize_and_unref(gicbusdev, &error_fatal);
+    sysbus_realize(gicbusdev, &error_fatal);
     sysbus_mmio_map(gicbusdev, 0, vms->memmap[VIRT_GIC_DIST].base);
     sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_REDIST].base);
     if (nb_redist_regions == 2) {
@@ -1500,7 +1500,7 @@ static void create_msi_controller(VirtMachineState *vms)
     }
 }
 
-static void create_uart(const VirtMachineState *vms, int uart,
+static void create_uart(VirtMachineState *vms, int uart,
                         MemoryRegion *mem, Chardev *chr, bool secure)
 {
     char *nodename;
@@ -1509,12 +1509,12 @@ static void create_uart(const VirtMachineState *vms, int uart,
     int irq = vms->irqmap[uart];
     const char compat[] = "arm,pl011\0arm,primecell";
     const char clocknames[] = "uartclk\0apb_pclk";
-    DeviceState *dev = qdev_new_orphan(TYPE_PL011);
+    DeviceState *dev = qdev_new(OBJECT(vms), "uart[*]", TYPE_PL011);
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
     MachineState *ms = MACHINE(vms);
 
     qdev_prop_set_chr(dev, "chardev", chr);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     memory_region_add_subregion(mem, base,
                                 sysbus_mmio_get_region(s, 0));
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
@@ -1552,7 +1552,7 @@ static void create_uart(const VirtMachineState *vms, int uart,
     g_free(nodename);
 }
 
-static void create_rtc(const VirtMachineState *vms)
+static void create_rtc(VirtMachineState *vms)
 {
     char *nodename;
     hwaddr base = vms->memmap[VIRT_RTC].base;
@@ -1561,7 +1561,8 @@ static void create_rtc(const VirtMachineState *vms)
     const char compat[] = "arm,pl031\0arm,primecell";
     MachineState *ms = MACHINE(vms);
 
-    sysbus_create_simple_orphan("pl031", base, qdev_get_gpio_in(vms->gic, irq));
+    sysbus_create_simple(OBJECT(vms), "rtc", "pl031", base,
+                         qdev_get_gpio_in(vms->gic, irq));
 
     nodename = g_strdup_printf("/pl031@%" PRIx64, base);
     qemu_fdt_add_subnode(ms->fdt, nodename);
@@ -1603,10 +1604,10 @@ static void virt_generic_error_req(Notifier *n, void *opaque)
     acpi_send_event(s->acpi_dev, ACPI_GENERIC_ERROR);
 }
 
-static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
+static void create_gpio_keys(Object *parent, char *fdt, DeviceState *pl061_dev,
                              uint32_t phandle)
 {
-    gpio_key_dev = sysbus_create_simple_orphan("gpio-key", -1,
+    gpio_key_dev = sysbus_create_simple(parent, "gpio-key", "gpio-key", -1,
                                         qdev_get_gpio_in(pl061_dev,
                                                          GPIO_PIN_POWER_BUTTON));
 
@@ -1625,13 +1626,13 @@ static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
 #define SECURE_GPIO_POWEROFF 0
 #define SECURE_GPIO_RESET    1
 
-static void create_secure_gpio_pwr(char *fdt, DeviceState *pl061_dev,
-                                   uint32_t phandle)
+static void create_secure_gpio_pwr(Object *parent, char *fdt,
+                                   DeviceState *pl061_dev, uint32_t phandle)
 {
     DeviceState *gpio_pwr_dev;
 
     /* gpio-pwr */
-    gpio_pwr_dev = sysbus_create_simple_orphan("gpio-pwr", -1, NULL);
+    gpio_pwr_dev = sysbus_create_simple(parent, "gpio-pwr", "gpio-pwr", -1, NULL);
 
     /* connect secure pl061 to gpio-pwr */
     qdev_connect_gpio_out(pl061_dev, SECURE_GPIO_RESET,
@@ -1658,7 +1659,7 @@ static void create_secure_gpio_pwr(char *fdt, DeviceState *pl061_dev,
                             "okay");
 }
 
-static void create_gpio_devices(const VirtMachineState *vms, int gpio,
+static void create_gpio_devices(VirtMachineState *vms, int gpio,
                                 MemoryRegion *mem)
 {
     char *nodename;
@@ -1670,12 +1671,12 @@ static void create_gpio_devices(const VirtMachineState *vms, int gpio,
     SysBusDevice *s;
     MachineState *ms = MACHINE(vms);
 
-    pl061_dev = qdev_new_orphan("pl061");
+    pl061_dev = qdev_new(OBJECT(vms), "gpio[*]", "pl061");
     /* Pull lines down to 0 if not driven by the PL061 */
     qdev_prop_set_uint8(pl061_dev, "pullups", 0);
     qdev_prop_set_uint8(pl061_dev, "pulldowns", 0xff);
     s = SYS_BUS_DEVICE(pl061_dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     memory_region_add_subregion(mem, base, sysbus_mmio_get_region(s, 0));
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
 
@@ -1703,13 +1704,13 @@ static void create_gpio_devices(const VirtMachineState *vms, int gpio,
 
     /* Child gpio devices */
     if (gpio == VIRT_GPIO) {
-        create_gpio_keys(ms->fdt, pl061_dev, phandle);
+        create_gpio_keys(OBJECT(vms), ms->fdt, pl061_dev, phandle);
     } else {
-        create_secure_gpio_pwr(ms->fdt, pl061_dev, phandle);
+        create_secure_gpio_pwr(OBJECT(vms), ms->fdt, pl061_dev, phandle);
     }
 }
 
-static void create_virtio_devices(const VirtMachineState *vms)
+static void create_virtio_devices(VirtMachineState *vms)
 {
     int i;
     hwaddr size = vms->memmap[VIRT_MMIO].size;
@@ -1746,8 +1747,8 @@ static void create_virtio_devices(const VirtMachineState *vms)
         int irq = vms->irqmap[VIRT_MMIO] + i;
         hwaddr base = vms->memmap[VIRT_MMIO].base + i * size;
 
-        sysbus_create_simple_orphan("virtio-mmio", base,
-                             qdev_get_gpio_in(vms->gic, irq));
+        sysbus_create_simple(OBJECT(vms), "virtio-mmio[*]", "virtio-mmio",
+                             base, qdev_get_gpio_in(vms->gic, irq));
     }
 
     /* We add dtb nodes in reverse order so that they appear in the finished
@@ -1786,7 +1787,7 @@ static PFlashCFI01 *virt_flash_create1(VirtMachineState *vms,
      * Create a single flash device.  We use the same parameters as
      * the flash devices on the Versatile Express board.
      */
-    DeviceState *dev = qdev_new_orphan(TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new(OBJECT(vms), name, TYPE_PFLASH_CFI01);
 
     qdev_prop_set_uint64(dev, "sector-length", VIRT_FLASH_SECTOR_SIZE);
     qdev_prop_set_uint8(dev, "width", 4);
@@ -1797,7 +1798,6 @@ static PFlashCFI01 *virt_flash_create1(VirtMachineState *vms,
     qdev_prop_set_uint16(dev, "id2", 0x00);
     qdev_prop_set_uint16(dev, "id3", 0x00);
     qdev_prop_set_string(dev, "name", name);
-    object_property_add_child(OBJECT(vms), name, OBJECT(dev));
     object_property_add_alias(OBJECT(vms), alias_prop_name,
                               OBJECT(dev), "drive");
     return PFLASH_CFI01(dev);
@@ -1818,7 +1818,7 @@ static void virt_flash_map1(PFlashCFI01 *flash,
     assert(QEMU_IS_ALIGNED(size, VIRT_FLASH_SECTOR_SIZE));
     assert(size / VIRT_FLASH_SECTOR_SIZE <= UINT32_MAX);
     qdev_prop_set_uint32(dev, "num-blocks", size / VIRT_FLASH_SECTOR_SIZE);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     memory_region_add_subregion(sysmem, base,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
@@ -2056,7 +2056,7 @@ static void create_smmuv3_dev_dtb(VirtMachineState *vms, DeviceState *dev,
                            0x0, vms->iommu_phandle, 0x0, 0x10000);
 }
 
-static void create_smmu(const VirtMachineState *vms, PCIBus *bus)
+static void create_smmu(VirtMachineState *vms, PCIBus *bus)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     int irq =  vms->irqmap[VIRT_SMMU];
@@ -2069,7 +2069,7 @@ static void create_smmu(const VirtMachineState *vms, PCIBus *bus)
         return;
     }
 
-    dev = qdev_new_orphan(TYPE_ARM_SMMUV3);
+    dev = qdev_new(OBJECT(vms), "smmuv3", TYPE_ARM_SMMUV3);
 
     if (!vmc->no_nested_smmu) {
         object_property_set_str(OBJECT(dev), "stage", "nested", &error_fatal);
@@ -2080,7 +2080,7 @@ static void create_smmu(const VirtMachineState *vms, PCIBus *bus)
                              &error_abort);
     object_property_set_link(OBJECT(dev), "secure-memory", OBJECT(vms->secure_sysmem),
                              &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
@@ -2162,8 +2162,8 @@ static void create_pcie(VirtMachineState *vms)
     MachineState *ms = MACHINE(vms);
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
-    dev = qdev_new_orphan(TYPE_GPEX_HOST);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    dev = qdev_new(OBJECT(vms), "pcie", TYPE_GPEX_HOST);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
     base_ecam = vms->memmap[ecam_id].base;
@@ -2290,11 +2290,11 @@ static void create_platform_bus(VirtMachineState *vms)
     int i;
     MemoryRegion *sysmem = get_system_memory();
 
-    dev = qdev_new_orphan(TYPE_PLATFORM_BUS_DEVICE);
+    dev = qdev_new(OBJECT(vms), "platform-bus", TYPE_PLATFORM_BUS_DEVICE);
     dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
     qdev_prop_set_uint32(dev, "num_irqs", PLATFORM_BUS_NUM_IRQS);
     qdev_prop_set_uint32(dev, "mmio_size", vms->memmap[VIRT_PLATFORM_BUS].size);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     vms->platform_bus_dev = dev;
 
     s = SYS_BUS_DEVICE(dev);
@@ -4410,11 +4410,6 @@ static void virt_instance_finalize(Object *obj)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
-    for (int i = 0; i < ARRAY_SIZE(vms->flash); i++) {
-        if (vms->flash[i] && !qdev_is_realized(DEVICE(vms->flash[i]))) {
-            object_unref(OBJECT(vms->flash[i]));
-        }
-    }
     g_free(vms->oem_id);
     g_free(vms->oem_table_id);
     g_ptr_array_free(vms->smmuv3_devices, TRUE);
-- 
2.47.1


