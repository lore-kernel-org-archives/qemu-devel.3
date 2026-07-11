Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B16BC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigYg-0001FB-1Z; Sat, 11 Jul 2026 18:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigYc-00017D-Gl; Sat, 11 Jul 2026 18:52:27 -0400
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.77.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigYY-0008Tx-V9; Sat, 11 Jul 2026 18:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810343; x=1815346343;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qJ9SPZd6KqKT0DByIkveEz5n2P2u8Ab+W4C2Tdl7jYU=;
 b=RaQia3awJ9VURokJD/SJpdT5RmyuQIi9OzMik2N9DQGN/CRREhUdD/vC
 yK7Ahl/4PcylV0VfAljIfFQ+WPbgFrruvhevlbspTkEqPNYMxwoNPo5xw
 eobvM/v7GllIn4tLurNatE+cmZkVZU4EqQqlfaTQvqLpZKlMa6+VN77xs
 VtQEIMulGneHMqtFJSJGCVC/6ly8XqTynghEOi4ezRiJDF1ikwX1sMvNq
 xFN2SKArBFl2SqJN4eeFFh85/2CB3EhvSH3y1DTg/lm+ZD0Ypkp9w9CXE
 RflYbU7HSGAbfG5xBcBA5u4eDo8/HbMawfAcGfY/gikuA3t3i1WwRqs+6 w==;
X-CSE-ConnectionGUID: jjHQ2GzHTxyUeU25lbK3Pg==
X-CSE-MsgGUID: 290MNva6RYilvvSdP7ceRA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23493166"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:52:18 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:25417]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.54:2525]
 with esmtp (Farcaster)
 id 1520f47c-e749-4a59-a4bb-753b46ca57be; Sat, 11 Jul 2026 22:52:18 +0000 (UTC)
X-Farcaster-Flow-ID: 1520f47c-e749-4a59-a4bb-753b46ca57be
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:52:18 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:52:09 +0000
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
Subject: [RFC PATCH 057/134] hw/arm/sbsa-ref: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:50 +0000
Message-ID: <20260711223707.42139-58-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.246.77.92;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
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

Convert the *_orphan() device-creation calls in the hw/arm sbsa-ref
board files to the new parented API introduced earlier in this
series, so every onboard device gets a stable path in the
composition tree instead of landing in /machine/unattached with an
unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing SoC device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/arm/sbsa-ref.c:299 | qdev_new | OBJECT(sms) | name | collapse existing object_property_add_child(OBJECT(sms), name, ...); keep existing name; sbsa_flash_map1 realize -> sysbus_realize
hw/arm/sbsa-ref.c:424 | qdev_new | OBJECT(sms) | "its" | helper receives SBSAMachineState* board pointer
hw/arm/sbsa-ref.c:443 | qdev_new | OBJECT(sms) | "gic" | helper receives SBSAMachineState* board pointer
hw/arm/sbsa-ref.c:525 | qdev_new | OBJECT(sms) | "uart[*]" | helper called 3x from board init -> auto-index; drop const
hw/arm/sbsa-ref.c:540 | sysbus_create_simple | OBJECT(sms) | "rtc" | helper receives SBSAMachineState*; drop const
hw/arm/sbsa-ref.c:547 | qdev_new | OBJECT(sms) | "wdt" | helper receives SBSAMachineState*; drop const
hw/arm/sbsa-ref.c:575 | sysbus_create_simple | OBJECT(sms) | "gpio" | helper receives SBSAMachineState*; drop const
hw/arm/sbsa-ref.c:578 | sysbus_create_simple | OBJECT(sms) | "gpio-key" | helper receives SBSAMachineState*
hw/arm/sbsa-ref.c:593 | qdev_new | OBJECT(sms) | "ahci" | helper receives SBSAMachineState*; drop const
hw/arm/sbsa-ref.c:608 | qdev_new | OBJECT(sms) | "xhci" | helper receives SBSAMachineState*; drop const
hw/arm/sbsa-ref.c:625 | qdev_new | OBJECT(sms) | "smmuv3" | helper receives SBSAMachineState*; drop const
hw/arm/sbsa-ref.c:661 | qdev_new | OBJECT(sms) | "pcie" | helper receives SBSAMachineState*
hw/arm/sbsa-ref.c:698 | pci_create_simple | OBJECT(sms) | "bochs-display" | board owns lifetime; bus is plug location not parent
hw/arm/sbsa-ref.c:715 | qdev_new | parent | "sbsa-ec" | helper lacks parent-capable pointer -> thread Object *parent from sbsa_ref_init

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/sbsa-ref.c | 70 ++++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index f9fb681d31..f632df742b 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -296,7 +296,7 @@ static PFlashCFI01 *sbsa_flash_create1(SBSAMachineState *sms,
      * Create a single flash device.  We use the same parameters as
      * the flash devices on the Versatile Express board.
      */
-    DeviceState *dev = qdev_new_orphan(TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new(OBJECT(sms), name, TYPE_PFLASH_CFI01);
 
     qdev_prop_set_uint64(dev, "sector-length", SBSA_FLASH_SECTOR_SIZE);
     qdev_prop_set_uint8(dev, "width", 4);
@@ -307,7 +307,6 @@ static PFlashCFI01 *sbsa_flash_create1(SBSAMachineState *sms,
     qdev_prop_set_uint16(dev, "id2", 0x00);
     qdev_prop_set_uint16(dev, "id3", 0x00);
     qdev_prop_set_string(dev, "name", name);
-    object_property_add_child(OBJECT(sms), name, OBJECT(dev));
     object_property_add_alias(OBJECT(sms), alias_prop_name,
                               OBJECT(dev), "drive");
     return PFLASH_CFI01(dev);
@@ -328,7 +327,7 @@ static void sbsa_flash_map1(PFlashCFI01 *flash,
     assert(QEMU_IS_ALIGNED(size, SBSA_FLASH_SECTOR_SIZE));
     assert(size / SBSA_FLASH_SECTOR_SIZE <= UINT32_MAX);
     qdev_prop_set_uint32(dev, "num-blocks", size / SBSA_FLASH_SECTOR_SIZE);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     memory_region_add_subregion(sysmem, base,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
@@ -421,11 +420,11 @@ static void create_its(SBSAMachineState *sms)
     const char *itsclass = its_class_name();
     DeviceState *dev;
 
-    dev = qdev_new_orphan(itsclass);
+    dev = qdev_new(OBJECT(sms), "its", itsclass);
 
     object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(sms->gic),
                              &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, sbsa_ref_memmap[SBSA_GIC_ITS].base);
 }
 
@@ -440,7 +439,7 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
 
     gictype = gicv3_class_name();
 
-    sms->gic = qdev_new_orphan(gictype);
+    sms->gic = qdev_new(OBJECT(sms), "gic", gictype);
     qdev_prop_set_uint32(sms->gic, "revision", 3);
     qdev_prop_set_uint32(sms->gic, "num-cpu", smp_cpus);
     /*
@@ -463,7 +462,7 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
     qdev_prop_set_bit(sms->gic, "has-lpi", true);
 
     gicbusdev = SYS_BUS_DEVICE(sms->gic);
-    sysbus_realize_and_unref(gicbusdev, &error_fatal);
+    sysbus_realize(gicbusdev, &error_fatal);
     sysbus_mmio_map(gicbusdev, 0, sbsa_ref_memmap[SBSA_GIC_DIST].base);
     sysbus_mmio_map(gicbusdev, 1, sbsa_ref_memmap[SBSA_GIC_REDIST].base);
 
@@ -517,39 +516,40 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
     create_its(sms);
 }
 
-static void create_uart(const SBSAMachineState *sms, int uart,
+static void create_uart(SBSAMachineState *sms, int uart,
                         MemoryRegion *mem, Chardev *chr)
 {
     hwaddr base = sbsa_ref_memmap[uart].base;
     int irq = sbsa_ref_irqmap[uart];
-    DeviceState *dev = qdev_new_orphan(TYPE_PL011);
+    DeviceState *dev = qdev_new(OBJECT(sms), "uart[*]", TYPE_PL011);
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
 
     qdev_prop_set_chr(dev, "chardev", chr);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     memory_region_add_subregion(mem, base,
                                 sysbus_mmio_get_region(s, 0));
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(sms->gic, irq));
 }
 
-static void create_rtc(const SBSAMachineState *sms)
+static void create_rtc(SBSAMachineState *sms)
 {
     hwaddr base = sbsa_ref_memmap[SBSA_RTC].base;
     int irq = sbsa_ref_irqmap[SBSA_RTC];
 
-    sysbus_create_simple_orphan("pl031", base, qdev_get_gpio_in(sms->gic, irq));
+    sysbus_create_simple(OBJECT(sms), "rtc", "pl031", base,
+                         qdev_get_gpio_in(sms->gic, irq));
 }
 
-static void create_wdt(const SBSAMachineState *sms)
+static void create_wdt(SBSAMachineState *sms)
 {
     hwaddr rbase = sbsa_ref_memmap[SBSA_GWDT_REFRESH].base;
     hwaddr cbase = sbsa_ref_memmap[SBSA_GWDT_CONTROL].base;
-    DeviceState *dev = qdev_new_orphan(TYPE_WDT_SBSA);
+    DeviceState *dev = qdev_new(OBJECT(sms), "wdt", TYPE_WDT_SBSA);
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
     int irq = sbsa_ref_irqmap[SBSA_GWDT_WS0];
 
     qdev_prop_set_uint64(dev, "clock-frequency", SBSA_GTIMER_HZ);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     sysbus_mmio_map(s, 0, rbase);
     sysbus_mmio_map(s, 1, cbase);
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(sms->gic, irq));
@@ -566,23 +566,23 @@ static Notifier sbsa_ref_powerdown_notifier = {
     .notify = sbsa_ref_powerdown_req
 };
 
-static void create_gpio(const SBSAMachineState *sms)
+static void create_gpio(SBSAMachineState *sms)
 {
     DeviceState *pl061_dev;
     hwaddr base = sbsa_ref_memmap[SBSA_GPIO].base;
     int irq = sbsa_ref_irqmap[SBSA_GPIO];
 
-    pl061_dev = sysbus_create_simple_orphan("pl061", base,
+    pl061_dev = sysbus_create_simple(OBJECT(sms), "gpio", "pl061", base,
                                      qdev_get_gpio_in(sms->gic, irq));
 
-    gpio_key_dev = sysbus_create_simple_orphan("gpio-key", -1,
-                                        qdev_get_gpio_in(pl061_dev, 3));
+    gpio_key_dev = sysbus_create_simple(OBJECT(sms), "gpio-key", "gpio-key",
+                                        -1, qdev_get_gpio_in(pl061_dev, 3));
 
     /* connect powerdown request */
     qemu_register_powerdown_notifier(&sbsa_ref_powerdown_notifier);
 }
 
-static void create_ahci(const SBSAMachineState *sms)
+static void create_ahci(SBSAMachineState *sms)
 {
     hwaddr base = sbsa_ref_memmap[SBSA_AHCI].base;
     int irq = sbsa_ref_irqmap[SBSA_AHCI];
@@ -590,9 +590,9 @@ static void create_ahci(const SBSAMachineState *sms)
     DriveInfo *hd[NUM_SATA_PORTS];
     SysbusAHCIState *sysahci;
 
-    dev = qdev_new_orphan("sysbus-ahci");
+    dev = qdev_new(OBJECT(sms), "ahci", "sysbus-ahci");
     qdev_prop_set_uint32(dev, "num-ports", NUM_SATA_PORTS);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(sms->gic, irq));
 
@@ -601,19 +601,19 @@ static void create_ahci(const SBSAMachineState *sms)
     ahci_ide_create_devs(&sysahci->ahci, hd);
 }
 
-static void create_xhci(const SBSAMachineState *sms)
+static void create_xhci(SBSAMachineState *sms)
 {
     hwaddr base = sbsa_ref_memmap[SBSA_XHCI].base;
     int irq = sbsa_ref_irqmap[SBSA_XHCI];
-    DeviceState *dev = qdev_new_orphan(TYPE_XHCI_SYSBUS);
+    DeviceState *dev = qdev_new(OBJECT(sms), "xhci", TYPE_XHCI_SYSBUS);
     qdev_prop_set_uint32(dev, "slots", XHCI_MAXSLOTS);
 
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(sms->gic, irq));
 }
 
-static void create_smmu(const SBSAMachineState *sms, PCIBus *bus,
+static void create_smmu(SBSAMachineState *sms, PCIBus *bus,
                         MemoryRegion *sysmem,
                         MemoryRegion *secure_sysmem)
 {
@@ -622,7 +622,7 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus,
     DeviceState *dev;
     int i;
 
-    dev = qdev_new_orphan(TYPE_ARM_SMMUV3);
+    dev = qdev_new(OBJECT(sms), "smmuv3", TYPE_ARM_SMMUV3);
 
     object_property_set_str(OBJECT(dev), "stage", "nested", &error_abort);
     object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
@@ -631,7 +631,7 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus,
                              &error_abort);
     object_property_set_link(OBJECT(dev), "secure-memory", OBJECT(secure_sysmem),
                              &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
@@ -658,8 +658,8 @@ static void create_pcie(SBSAMachineState *sms,
     PCIHostState *pci;
     int i;
 
-    dev = qdev_new_orphan(TYPE_GPEX_HOST);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    dev = qdev_new(OBJECT(sms), "pcie", TYPE_GPEX_HOST);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Map ECAM space */
     ecam_alias = g_new0(MemoryRegion, 1);
@@ -695,7 +695,7 @@ static void create_pcie(SBSAMachineState *sms,
 
     pci_init_nic_devices(pci->bus, mc->default_nic);
 
-    pci_create_simple_orphan(pci->bus, -1, "bochs-display");
+    pci_create_simple(OBJECT(sms), "bochs-display", pci->bus, -1, "bochs-display");
 
     create_smmu(sms, pci->bus, sysmem, secure_sysmem);
 }
@@ -709,12 +709,14 @@ static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
     return board->fdt;
 }
 
-static void create_secure_ec(MemoryRegion *mem)
+static void create_secure_ec(Object *parent, MemoryRegion *mem)
 {
     hwaddr base = sbsa_ref_memmap[SBSA_SECURE_EC].base;
-    DeviceState *dev = qdev_new_orphan("sbsa-ec");
+    DeviceState *dev = qdev_new(parent, "sbsa-ec", "sbsa-ec");
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
 
+    sysbus_realize(s, &error_fatal);
+
     memory_region_add_subregion(mem, base,
                                 sysbus_mmio_get_region(s, 0));
 }
@@ -835,7 +837,7 @@ static void sbsa_ref_init(MachineState *machine)
 
     create_pcie(sms, sysmem, secure_sysmem);
 
-    create_secure_ec(secure_sysmem);
+    create_secure_ec(OBJECT(sms), secure_sysmem);
 
     sms->bootinfo.ram_size = machine->ram_size;
     sms->bootinfo.board_id = -1;
-- 
2.47.1


