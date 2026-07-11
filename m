Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6B8C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigNv-0005px-5e; Sat, 11 Jul 2026 18:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigNu-0005p9-7w; Sat, 11 Jul 2026 18:41:22 -0400
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([34.218.115.239])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigNr-0005sj-Nr; Sat, 11 Jul 2026 18:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783809679; x=1815345679;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WM1j05fIaWFt3IO+Q9HTPM9A3OHYUoVX37R/2BMVYho=;
 b=bZlkBGMhu1uGzAY6ir7Nqc2AToHFpWS5JtUNqZq9Ug+E/Hidqjq9fwRY
 RE4J0vHG2EqnBGcKnfzEvBf/LdO7JAWkawRmzuGYwYBVFae5t7fwiG2Vj
 QqIB59cFJGA3+OxXDYdN6BsoiFBJUXUNF7ftV0gs5we5+fjCC1m8+PTdm
 jMF9AHScElDI2YWt520HXvYjjj68nRSWZc7lmB3N5VKK1CeagJUPcKoVW
 X9PvooSHVXK/7SmfhNshyu4dhblofVbRY+0fAc0ULB3PmN92lNMRqFDL1
 XG5E11ZDK8tEAh0VPQ83uqfsHLWSNYxcJy3pb/nr3lD3D6HhNInK8IVHG w==;
X-CSE-ConnectionGUID: jsT+DxrsTgC9vbugxkXjzA==
X-CSE-MsgGUID: fWKLAXSBRq6JoNaosp0bsw==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23296577"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:41:16 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:25429]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.214:2525]
 with esmtp (Farcaster)
 id 962a8927-0119-4610-9b8c-881f727643a5; Sat, 11 Jul 2026 22:41:15 +0000 (UTC)
X-Farcaster-Flow-ID: 962a8927-0119-4610-9b8c-881f727643a5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:41:15 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:41:06 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>,
 <qemu-s390x@nongnu.org>, Song Gao <17746591750@163.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Farhan Ali
 <alifm@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>, "Alistair
 Francis" <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi
 <balbi@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, "Brian
 Cain" <brian.cain@oss.qualcomm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Chigot?=
 <chigot@adacore.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>, Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "Gautam Gala" <ggala@linux.ibm.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?=
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, "Laurent Vivier" <laurent@vivier.eu>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael Rolnik" <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 "Niek Linnenbank" <nieklinnenbank@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic
 <pasic@linux.ibm.com>, "Paolo Bonzini" <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>, Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow
 <shentey@gmail.com>, Stafford Horne <shorne@gmail.com>, Sergio Lopez
 <slp@redhat.com>, "Subbaraya Sundeep" <sundeep.lkml@gmail.com>, Thomas Huth
 <th.huth+qemu@posteo.eu>, "Ran Wang" <wangran@bosc.ac.cn>, Hao Wu
 <wuhaotsh@google.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: [RFC PATCH 015/134] hw/vmapple: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:08 +0000
Message-ID: <20260711223707.42139-16-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=34.218.115.239;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
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

Convert the *_orphan() device-creation calls in hw/vmapple to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

  hw/vmapple/vmapple.c:158 | OBJECT(vms) | "bdif" | board-init helper receives VMAppleMachineState *vms; single instance
  hw/vmapple/vmapple.c:172 | OBJECT(vms) | "pvpanic" | board-init helper receives vms; single instance
  hw/vmapple/vmapple.c:187 | OBJECT(vms) | "cfg" | board-init helper receives vms; single instance
  hw/vmapple/vmapple.c:212 | OBJECT(vms) | "gfx" | board-init helper receives vms; single instance
  hw/vmapple/vmapple.c:225 | OBJECT(vms) | "aes" | board-init helper receives vms; single instance
  hw/vmapple/vmapple.c:246 | OBJECT(vms) | "gic" | board-init helper receives vms; single instance
  hw/vmapple/vmapple.c:293 | OBJECT(vms) | "uart" | board-init helper receives vms (const dropped); single instance
  hw/vmapple/vmapple.c:308 | OBJECT(vms) | "rtc" | board-init helper receives vms (const dropped); single instance
  hw/vmapple/vmapple.c:326 | OBJECT(vms) | "gpio" | board-init helper receives vms (const dropped); single instance
  hw/vmapple/vmapple.c:334 | OBJECT(vms) | "gpio-key" | board-init helper receives vms; single instance
  hw/vmapple/vmapple.c:387 | OBJECT(vms) | "pcie" | board-init helper receives vms; single GPEX host
  hw/vmapple/vmapple.c:423 | OBJECT(vms) | "xhci" | board-init helper receives vms; single XHCI controller
  hw/vmapple/vmapple.c:428 | OBJECT(usb_controller) | "usb-kbd" | lifetime owned by the XHCI controller it plugs into
  hw/vmapple/vmapple.c:429 | OBJECT(usb_controller) | "usb-tablet" | lifetime owned by the XHCI controller it plugs into

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/vmapple/vmapple.c | 59 +++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index 4d218748c2..60c7dab89b 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -155,25 +155,25 @@ static void create_bdif(VMAppleMachineState *vms, MemoryRegion *mem)
     }
 
     /* PV backdoor device */
-    bdif = qdev_new_orphan(TYPE_VMAPPLE_BDIF);
+    bdif = qdev_new(OBJECT(vms), "bdif", TYPE_VMAPPLE_BDIF);
     bdif_sb = SYS_BUS_DEVICE(bdif);
     sysbus_mmio_map(bdif_sb, 0, vms->memmap[VMAPPLE_BDOOR].base);
 
     qdev_prop_set_drive(DEVICE(bdif), "aux", blk_by_legacy_dinfo(di_aux));
     qdev_prop_set_drive(DEVICE(bdif), "root", blk_by_legacy_dinfo(di_root));
 
-    sysbus_realize_and_unref(bdif_sb, &error_fatal);
+    sysbus_realize(bdif_sb, &error_fatal);
 }
 
 static void create_pvpanic(VMAppleMachineState *vms, MemoryRegion *mem)
 {
     SysBusDevice *pvpanic;
 
-    vms->pvpanic = qdev_new_orphan(TYPE_PVPANIC_MMIO_DEVICE);
+    vms->pvpanic = qdev_new(OBJECT(vms), "pvpanic", TYPE_PVPANIC_MMIO_DEVICE);
     pvpanic = SYS_BUS_DEVICE(vms->pvpanic);
     sysbus_mmio_map(pvpanic, 0, vms->memmap[VMAPPLE_PVPANIC].base);
 
-    sysbus_realize_and_unref(pvpanic, &error_fatal);
+    sysbus_realize(pvpanic, &error_fatal);
 }
 
 static bool create_cfg(VMAppleMachineState *vms, MemoryRegion *mem,
@@ -184,7 +184,7 @@ static bool create_cfg(VMAppleMachineState *vms, MemoryRegion *mem,
     MachineState *machine = MACHINE(vms);
     uint32_t rnd = 1;
 
-    vms->cfg = qdev_new_orphan(TYPE_VMAPPLE_CFG);
+    vms->cfg = qdev_new(OBJECT(vms), "cfg", TYPE_VMAPPLE_CFG);
     cfg = SYS_BUS_DEVICE(vms->cfg);
     sysbus_mmio_map(cfg, 0, vms->memmap[VMAPPLE_CONFIG].base);
 
@@ -195,7 +195,7 @@ static bool create_cfg(VMAppleMachineState *vms, MemoryRegion *mem,
     qdev_prop_set_uint64(vms->cfg, "ram-size", machine->ram_size);
     qdev_prop_set_uint32(vms->cfg, "rnd", rnd);
 
-    if (!sysbus_realize_and_unref(cfg, errp)) {
+    if (!sysbus_realize(cfg, errp)) {
         error_prepend(errp, "Error creating vmapple cfg device: ");
         return false;
     }
@@ -209,12 +209,12 @@ static void create_gfx(VMAppleMachineState *vms, MemoryRegion *mem)
     int irq_iosfc = vms->irqmap[VMAPPLE_APV_IOSFC];
     SysBusDevice *gfx;
 
-    gfx = SYS_BUS_DEVICE(qdev_new_orphan("apple-gfx-mmio"));
+    gfx = SYS_BUS_DEVICE(qdev_new(OBJECT(vms), "gfx", "apple-gfx-mmio"));
     sysbus_mmio_map(gfx, 0, vms->memmap[VMAPPLE_APV_GFX].base);
     sysbus_mmio_map(gfx, 1, vms->memmap[VMAPPLE_APV_IOSFC].base);
     sysbus_connect_irq(gfx, 0, qdev_get_gpio_in(vms->gic, irq_gfx));
     sysbus_connect_irq(gfx, 1, qdev_get_gpio_in(vms->gic, irq_iosfc));
-    sysbus_realize_and_unref(gfx, &error_fatal);
+    sysbus_realize(gfx, &error_fatal);
 }
 
 static void create_aes(VMAppleMachineState *vms, MemoryRegion *mem)
@@ -222,11 +222,11 @@ static void create_aes(VMAppleMachineState *vms, MemoryRegion *mem)
     int irq = vms->irqmap[VMAPPLE_AES_1];
     SysBusDevice *aes;
 
-    aes = SYS_BUS_DEVICE(qdev_new_orphan(TYPE_APPLE_AES));
+    aes = SYS_BUS_DEVICE(qdev_new(OBJECT(vms), "aes", TYPE_APPLE_AES));
     sysbus_mmio_map(aes, 0, vms->memmap[VMAPPLE_AES_1].base);
     sysbus_mmio_map(aes, 1, vms->memmap[VMAPPLE_AES_2].base);
     sysbus_connect_irq(aes, 0, qdev_get_gpio_in(vms->gic, irq));
-    sysbus_realize_and_unref(aes, &error_fatal);
+    sysbus_realize(aes, &error_fatal);
 }
 
 static int arm_gic_ppi_index(int cpu_nr, int ppi_index)
@@ -243,7 +243,7 @@ static void create_gic(VMAppleMachineState *vms, MemoryRegion *mem)
     int i;
     unsigned int smp_cpus = ms->smp.cpus;
 
-    vms->gic = qdev_new_orphan(gicv3_class_name());
+    vms->gic = qdev_new(OBJECT(vms), "gic", gicv3_class_name());
     qdev_prop_set_uint32(vms->gic, "revision", 3);
     qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
     /*
@@ -261,7 +261,7 @@ static void create_gic(VMAppleMachineState *vms, MemoryRegion *mem)
     qdev_prop_set_array(vms->gic, "redist-region-count", redist_region_count);
 
     gicbusdev = SYS_BUS_DEVICE(vms->gic);
-    sysbus_realize_and_unref(gicbusdev, &error_fatal);
+    sysbus_realize(gicbusdev, &error_fatal);
     sysbus_mmio_map(gicbusdev, 0, vms->memmap[VMAPPLE_GIC_DIST].base);
     sysbus_mmio_map(gicbusdev, 1, vms->memmap[VMAPPLE_GIC_REDIST].base);
 
@@ -285,27 +285,28 @@ static void create_gic(VMAppleMachineState *vms, MemoryRegion *mem)
     }
 }
 
-static void create_uart(const VMAppleMachineState *vms, int uart,
+static void create_uart(VMAppleMachineState *vms, int uart,
                         MemoryRegion *mem, Chardev *chr)
 {
     hwaddr base = vms->memmap[uart].base;
     int irq = vms->irqmap[uart];
-    DeviceState *dev = qdev_new_orphan(TYPE_PL011);
+    DeviceState *dev = qdev_new(OBJECT(vms), "uart", TYPE_PL011);
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
 
     qdev_prop_set_chr(dev, "chardev", chr);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     memory_region_add_subregion(mem, base,
                                 sysbus_mmio_get_region(s, 0));
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
 }
 
-static void create_rtc(const VMAppleMachineState *vms)
+static void create_rtc(VMAppleMachineState *vms)
 {
     hwaddr base = vms->memmap[VMAPPLE_RTC].base;
     int irq = vms->irqmap[VMAPPLE_RTC];
 
-    sysbus_create_simple_orphan("pl031", base, qdev_get_gpio_in(vms->gic, irq));
+    sysbus_create_simple(OBJECT(vms), "rtc", "pl031", base,
+                         qdev_get_gpio_in(vms->gic, irq));
 }
 
 static DeviceState *gpio_key_dev;
@@ -315,7 +316,7 @@ static void vmapple_powerdown_req(Notifier *n, void *opaque)
     qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
 }
 
-static void create_gpio_devices(const VMAppleMachineState *vms, int gpio,
+static void create_gpio_devices(VMAppleMachineState *vms, int gpio,
                                 MemoryRegion *mem)
 {
     DeviceState *pl061_dev;
@@ -323,16 +324,16 @@ static void create_gpio_devices(const VMAppleMachineState *vms, int gpio,
     int irq = vms->irqmap[gpio];
     SysBusDevice *s;
 
-    pl061_dev = qdev_new_orphan("pl061");
+    pl061_dev = qdev_new(OBJECT(vms), "gpio", "pl061");
     /* Pull lines down to 0 if not driven by the PL061 */
     qdev_prop_set_uint8(pl061_dev, "pullups", 0);
     qdev_prop_set_uint8(pl061_dev, "pulldowns", 0xff);
     s = SYS_BUS_DEVICE(pl061_dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     memory_region_add_subregion(mem, base, sysbus_mmio_get_region(s, 0));
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
-    gpio_key_dev = sysbus_create_simple_orphan("gpio-key", -1,
-                                        qdev_get_gpio_in(pl061_dev, 3));
+    gpio_key_dev = sysbus_create_simple(OBJECT(vms), "gpio-key", "gpio-key",
+                                        -1, qdev_get_gpio_in(pl061_dev, 3));
 }
 
 static void vmapple_firmware_init(VMAppleMachineState *vms,
@@ -384,9 +385,9 @@ static void create_pcie(VMAppleMachineState *vms)
     DeviceState *usb_controller;
     USBBus *usb_bus;
 
-    dev = qdev_new_orphan(TYPE_GPEX_HOST);
+    dev = qdev_new(OBJECT(vms), "pcie", TYPE_GPEX_HOST);
     qdev_prop_set_uint32(dev, "num-irqs", GPEX_NUM_IRQS);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Map only the first size_ecam bytes of ECAM space */
     ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
@@ -420,13 +421,15 @@ static void create_pcie(VMAppleMachineState *vms)
     }
 
     if (defaults_enabled()) {
-        usb_controller = qdev_new_orphan(TYPE_QEMU_XHCI);
-        qdev_realize_and_unref(usb_controller, BUS(pci->bus), &error_fatal);
+        usb_controller = qdev_new(OBJECT(vms), "xhci", TYPE_QEMU_XHCI);
+        qdev_realize(usb_controller, BUS(pci->bus), &error_fatal);
 
         usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
                                                           &error_fatal));
-        usb_create_simple_orphan(usb_bus, "usb-kbd");
-        usb_create_simple_orphan(usb_bus, "usb-tablet");
+        usb_create_simple(OBJECT(usb_controller), "usb-kbd", usb_bus,
+                          "usb-kbd");
+        usb_create_simple(OBJECT(usb_controller), "usb-tablet", usb_bus,
+                          "usb-tablet");
     }
 }
 
-- 
2.47.1


