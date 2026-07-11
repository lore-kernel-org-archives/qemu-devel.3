Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87833C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigXF-0007B9-Lu; Sat, 11 Jul 2026 18:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigXD-00072F-8a; Sat, 11 Jul 2026 18:50:59 -0400
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.245.243.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigXA-0008Gy-0R; Sat, 11 Jul 2026 18:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810256; x=1815346256;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8OZTUahB02z7edF10eT/FQZqejuEkL/BRaGyOrT0/14=;
 b=dwjbagYfr5LxNRZT94Vio2fshMIF60LHvI2Qyf2m87GOi9WntXsK3AvV
 FSrYA+H4z8kCt4YT4OXd0g8sPWVteR4HYuLIzFWM9KIPaIc63KRP8RvQy
 Ti1N/m5xxFVE1J32BXHSa2a81sICQcUHCisQXi0RsDLeJrsIVQj9H2RE3
 j0zY8XAM8N4LbFYTjPzP1j40w8dr0f0SthbZYJs4R5V/SdJXrWUrFLLTe
 pVCsp1VvdwglEU1RDFiNZ5yTqBW+PK1loH8S3GYBCiJY+OIMZOBrdlp1/
 XIv4pddBWkRGhktxv8RMDTv2VCB4SRyKKMS0Brv1O5h0sHYNrhvPgU1s+ w==;
X-CSE-ConnectionGUID: aiiU3/3cThGZ75MVdKZx5g==
X-CSE-MsgGUID: F1xxRmI0QHu5YVTSxf/Rsw==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="22997544"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:50:52 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:11735]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.115:2525]
 with esmtp (Farcaster)
 id 523c9be8-6015-4852-81e5-214f04879d82; Sat, 11 Jul 2026 22:50:52 +0000 (UTC)
X-Farcaster-Flow-ID: 523c9be8-6015-4852-81e5-214f04879d82
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:50:51 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:50:42 +0000
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
Subject: [RFC PATCH 052/134] hw/mips: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:45 +0000
Message-ID: <20260711223707.42139-53-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.245.243.92;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in hw/mips to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/mips/boston.c:435 | qdev_new | parent | "pcie[*]" | static helper called 3x from board init; thread Object *parent as first arg
hw/mips/boston.c:691 | qdev_new | OBJECT(machine) | "boston" | board MachineClass.init()
hw/mips/boston.c:773 | pci_create_simple_multifunction | OBJECT(machine) | "ahci" | board MachineClass.init()
hw/mips/fuloong2e.c:289 | pci_new_multifunction | OBJECT(machine) | "via" | board MachineClass.init()
hw/mips/fuloong2e.c:315 | pci_new | OBJECT(machine) | "vga" | board MachineClass.init()
hw/mips/jazz.c:130 | qdev_new | parent | "dp8393x" | static helper called from board init; thread Object *parent as first arg
hw/mips/jazz.c:292 | isa_new | OBJECT(machine) | "pcspk" | board MachineClass.init() helper receiving MachineState*
hw/mips/jazz.c:299 | qdev_new | OBJECT(machine) | "g364" | board MachineClass.init() helper receiving MachineState*
hw/mips/jazz.c:316 | qdev_new | OBJECT(machine) | "vga" | board MachineClass.init() helper receiving MachineState*
hw/mips/jazz.c:332 | qdev_new | OBJECT(machine) | "esp" | board MachineClass.init() helper receiving MachineState*
hw/mips/jazz.c:363 | qdev_new | OBJECT(machine) | "i8042" | board MachineClass.init() helper receiving MachineState*
hw/mips/jazz.c:393 | qdev_new | OBJECT(machine) | "nvram" | board MachineClass.init() helper receiving MachineState*
hw/mips/jazz.c:399 | sysbus_create_simple | OBJECT(machine) | "led" | board MachineClass.init() helper receiving MachineState*
hw/mips/loongson3_virt.c:427 | qdev_new | OBJECT(machine) | "pcie" | inline helper receiving MachineState* from board init
hw/mips/loongson3_virt.c:468 | pci_create_simple | OBJECT(machine) | "ohci" | inline helper receiving MachineState* from board init
hw/mips/loongson3_virt.c:471 | usb_create_simple | OBJECT(machine) | "usb-kbd" | inline helper receiving MachineState* from board init
hw/mips/loongson3_virt.c:472 | usb_create_simple | OBJECT(machine) | "usb-tablet" | inline helper receiving MachineState* from board init
hw/mips/loongson3_virt.c:522 | qdev_new | OBJECT(machine) | "ipi" | board MachineClass.init()
hw/mips/loongson3_virt.c:530 | qdev_new | OBJECT(machine) | "liointc" | board MachineClass.init()
hw/mips/loongson3_virt.c:539 | sysbus_create_simple | OBJECT(machine) | "rtc" | board MachineClass.init()
hw/mips/malta.c:1101 | qdev_new | OBJECT(machine) | "malta" | board MachineClass.init()
hw/mips/malta.c:1230 | qdev_new | OBJECT(machine) | "gt64120" | board MachineClass.init()
hw/mips/malta.c:1237 | pci_new_multifunction | OBJECT(machine) | "piix4" | board MachineClass.init()
hw/mips/malta.c:1257 | isa_create_simple | OBJECT(machine) | "superio" | board MachineClass.init()

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/mips/boston.c         | 21 +++++++++++----------
 hw/mips/fuloong2e.c      |  9 +++++----
 hw/mips/jazz.c           | 36 +++++++++++++++++++-----------------
 hw/mips/loongson3_virt.c | 22 ++++++++++++----------
 hw/mips/malta.c          | 16 +++++++++-------
 5 files changed, 56 insertions(+), 48 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 770160c4e5..a156b218fb 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -424,7 +424,7 @@ static const struct fit_loader boston_fit_loader = {
 };
 
 static inline XilinxPCIEHost *
-xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
+xilinx_pcie_init(Object *parent, MemoryRegion *sys_mem, uint32_t bus_nr,
                  hwaddr cfg_base, uint64_t cfg_size,
                  hwaddr mmio_base, uint64_t mmio_size,
                  qemu_irq irq)
@@ -432,7 +432,7 @@ xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
     DeviceState *dev;
     MemoryRegion *cfg, *mmio;
 
-    dev = qdev_new_orphan(TYPE_XILINX_PCIE_HOST);
+    dev = qdev_new(parent, "pcie[*]", TYPE_XILINX_PCIE_HOST);
 
     qdev_prop_set_uint32(dev, "bus_nr", bus_nr);
     qdev_prop_set_uint64(dev, "cfg_base", cfg_base);
@@ -440,7 +440,7 @@ xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
     qdev_prop_set_uint64(dev, "mmio_base", mmio_base);
     qdev_prop_set_uint64(dev, "mmio_size", mmio_size);
 
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     cfg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
     memory_region_add_subregion_overlap(sys_mem, cfg_base, cfg, 0);
@@ -688,8 +688,8 @@ static void boston_mach_init(MachineState *machine)
         exit(1);
     }
 
-    dev = qdev_new_orphan(TYPE_BOSTON);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    dev = qdev_new(OBJECT(machine), "boston", TYPE_BOSTON);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     s = BOSTON(dev);
     s->mach = machine;
@@ -727,21 +727,21 @@ static void boston_mach_init(MachineState *machine)
                              MIN(machine->ram_size, (256 * MiB)));
     memory_region_add_subregion_overlap(sys_mem, 0, ddr_low_alias, 0);
 
-    xilinx_pcie_init(sys_mem, 0,
+    xilinx_pcie_init(OBJECT(machine), sys_mem, 0,
                      boston_memmap[BOSTON_PCIE0].base,
                      boston_memmap[BOSTON_PCIE0].size,
                      boston_memmap[BOSTON_PCIE0_MMIO].base,
                      boston_memmap[BOSTON_PCIE0_MMIO].size,
                      get_cps_irq(&s->cps, 2));
 
-    xilinx_pcie_init(sys_mem, 1,
+    xilinx_pcie_init(OBJECT(machine), sys_mem, 1,
                      boston_memmap[BOSTON_PCIE1].base,
                      boston_memmap[BOSTON_PCIE1].size,
                      boston_memmap[BOSTON_PCIE1_MMIO].base,
                      boston_memmap[BOSTON_PCIE1_MMIO].size,
                      get_cps_irq(&s->cps, 1));
 
-    pcie2 = xilinx_pcie_init(sys_mem, 2,
+    pcie2 = xilinx_pcie_init(OBJECT(machine), sys_mem, 2,
                              boston_memmap[BOSTON_PCIE2].base,
                              boston_memmap[BOSTON_PCIE2].size,
                              boston_memmap[BOSTON_PCIE2_MMIO].base,
@@ -770,8 +770,9 @@ static void boston_mach_init(MachineState *machine)
     qemu_chr_fe_set_handlers(&s->lcd_display, NULL, NULL,
                              boston_lcd_event, NULL, s, NULL, true);
 
-    pdev = pci_create_simple_multifunction_orphan(&PCI_BRIDGE(&pcie2->root)->sec_bus,
-                                           PCI_DEVFN(0, 0), TYPE_ICH9_AHCI);
+    pdev = pci_create_simple_multifunction(OBJECT(machine), "ahci",
+                                    &PCI_BRIDGE(&pcie2->root)->sec_bus,
+                                    PCI_DEVFN(0, 0), TYPE_ICH9_AHCI);
     ich9 = ICH9_AHCI(pdev);
     g_assert(ARRAY_SIZE(hd) == ich9->ahci.ports);
     ide_drive_get(hd, ich9->ahci.ports);
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 0046423d40..88d2901829 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -286,7 +286,8 @@ static void mips_fuloong2e_init(MachineState *machine)
     pci_bus = bonito_init(OBJECT(machine), (qemu_irq *)&(env->irq[2]));
 
     /* South bridge -> IP5 */
-    pci_dev = pci_new_multifunction_orphan(PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
+    pci_dev = pci_new_multifunction(OBJECT(machine), "via",
+                                    PCI_DEVFN(FULOONG2E_VIA_SLOT, 0),
                                     TYPE_VT82C686B_ISA);
 
     /* Set properties on individual devices before realizing the south bridge */
@@ -295,7 +296,7 @@ static void mips_fuloong2e_init(MachineState *machine)
         qdev_prop_set_string(dev, "audiodev", machine->audiodev);
     }
 
-    pci_realize_and_unref(pci_dev, pci_bus, &error_abort);
+    qdev_realize(DEVICE(pci_dev), BUS(pci_bus), &error_abort);
 
     object_property_add_alias(OBJECT(machine), "rtc-time",
                               object_resolve_path_component(OBJECT(pci_dev),
@@ -312,12 +313,12 @@ static void mips_fuloong2e_init(MachineState *machine)
     /* GPU */
     if (vga_interface_type != VGA_NONE) {
         vga_interface_created = true;
-        pci_dev = pci_new_orphan(-1, "ati-vga");
+        pci_dev = pci_new(OBJECT(machine), "vga", -1, "ati-vga");
         dev = DEVICE(pci_dev);
         qdev_prop_set_uint32(dev, "vgamem_mb", 16);
         qdev_prop_set_uint16(dev, "x-device-id", 0x5159);
         qdev_prop_set_uint64(dev, "x-linear-aper-size", 16 * MiB);
-        pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
+        qdev_realize(DEVICE(pci_dev), BUS(pci_bus), &error_fatal);
     }
 
     /* Populate SPD eeprom data */
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 31ef357554..208e59fbeb 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -113,7 +113,8 @@ static const MemoryRegionOps dma_dummy_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static void mips_jazz_init_net(IOMMUMemoryRegion *rc4030_dma_mr,
+static void mips_jazz_init_net(Object *parent,
+                               IOMMUMemoryRegion *rc4030_dma_mr,
                                DeviceState *rc4030, MemoryRegion *dp8393x_prom)
 {
     DeviceState *dev;
@@ -127,14 +128,14 @@ static void mips_jazz_init_net(IOMMUMemoryRegion *rc4030_dma_mr,
         return;
     }
 
-    dev = qdev_new_orphan("dp8393x");
+    dev = qdev_new(parent, "dp8393x", "dp8393x");
     qdev_set_nic_properties(dev, nd);
     qdev_prop_set_uint8(dev, "it_shift", 2);
     qdev_prop_set_bit(dev, "big_endian", TARGET_BIG_ENDIAN);
     object_property_set_link(OBJECT(dev), "dma_mr",
                              OBJECT(rc4030_dma_mr), &error_abort);
     sysbus = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sysbus, &error_fatal);
+    sysbus_realize(sysbus, &error_fatal);
     sysbus_mmio_map(sysbus, 0, 0x80001000);
     sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(rc4030, 4));
 
@@ -289,16 +290,16 @@ static void mips_jazz_init(MachineState *machine,
     isa_bus_register_input_irqs(isa_bus, i8259);
     i8257_dma_init(OBJECT(rc4030), isa_bus, 0);
     pit = i8254_pit_init(isa_bus, 0x40, 0, NULL);
-    pcspk = isa_new_orphan(TYPE_PC_SPEAKER);
+    pcspk = isa_new(OBJECT(machine), "pcspk", TYPE_PC_SPEAKER);
     object_property_set_link(OBJECT(pcspk), "pit", OBJECT(pit), &error_fatal);
-    isa_realize_and_unref(pcspk, isa_bus, &error_fatal);
+    qdev_realize(DEVICE(pcspk), BUS(isa_bus), &error_fatal);
 
     /* Video card */
     switch (jazz_model) {
     case JAZZ_MAGNUM:
-        dev = qdev_new_orphan("sysbus-g364");
+        dev = qdev_new(OBJECT(machine), "g364", "sysbus-g364");
         sysbus = SYS_BUS_DEVICE(dev);
-        sysbus_realize_and_unref(sysbus, &error_fatal);
+        sysbus_realize(sysbus, &error_fatal);
         sysbus_mmio_map(sysbus, 0, 0x60080000);
         sysbus_mmio_map(sysbus, 1, 0x40000000);
         sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(rc4030, 3));
@@ -313,10 +314,10 @@ static void mips_jazz_init(MachineState *machine,
         }
         break;
     case JAZZ_PICA61:
-        dev = qdev_new_orphan(TYPE_VGA_MMIO);
+        dev = qdev_new(OBJECT(machine), "vga", TYPE_VGA_MMIO);
         qdev_prop_set_uint8(dev, "it_shift", 0);
         sysbus = SYS_BUS_DEVICE(dev);
-        sysbus_realize_and_unref(sysbus, &error_fatal);
+        sysbus_realize(sysbus, &error_fatal);
         sysbus_mmio_map(sysbus, 0, 0x60000000);
         sysbus_mmio_map(sysbus, 1, 0x400a0000);
         sysbus_mmio_map(sysbus, 2, VBE_DISPI_LFB_PHYSICAL_ADDRESS);
@@ -326,10 +327,10 @@ static void mips_jazz_init(MachineState *machine,
     }
 
     /* Network controller */
-    mips_jazz_init_net(rc4030_dma_mr, rc4030, dp8393x_prom);
+    mips_jazz_init_net(OBJECT(machine), rc4030_dma_mr, rc4030, dp8393x_prom);
 
     /* SCSI adapter */
-    dev = qdev_new_orphan(TYPE_SYSBUS_ESP);
+    dev = qdev_new(OBJECT(machine), "esp", TYPE_SYSBUS_ESP);
     sysbus_esp = SYSBUS_ESP(dev);
     esp = &sysbus_esp->esp;
     esp->dma_memory_read = rc4030_dma_read;
@@ -340,7 +341,7 @@ static void mips_jazz_init(MachineState *machine,
     esp->dma_enabled = 1;
 
     sysbus = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sysbus, &error_fatal);
+    sysbus_realize(sysbus, &error_fatal);
     sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(rc4030, 5));
     sysbus_mmio_map(sysbus, 0, 0x80002000);
 
@@ -360,10 +361,10 @@ static void mips_jazz_init(MachineState *machine,
     memory_region_add_subregion(address_space, 0x80004000, rtc);
 
     /* Keyboard (i8042) */
-    i8042 = I8042_MMIO(qdev_new_orphan(TYPE_I8042_MMIO));
+    i8042 = I8042_MMIO(qdev_new(OBJECT(machine), "i8042", TYPE_I8042_MMIO));
     qdev_prop_set_uint64(DEVICE(i8042), "mask", 1);
     qdev_prop_set_uint32(DEVICE(i8042), "size", 0x1000);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(i8042), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(i8042), &error_fatal);
 
     qdev_connect_gpio_out(DEVICE(i8042), I8042_KBD_IRQ,
                           qdev_get_gpio_in(rc4030, 6));
@@ -390,13 +391,14 @@ static void mips_jazz_init(MachineState *machine,
     /* FIXME: missing Jazz sound at 0x8000c000, rc4030[2] */
 
     /* NVRAM */
-    dev = qdev_new_orphan("ds1225y");
+    dev = qdev_new(OBJECT(machine), "nvram", "ds1225y");
     sysbus = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sysbus, &error_fatal);
+    sysbus_realize(sysbus, &error_fatal);
     sysbus_mmio_map(sysbus, 0, 0x80009000);
 
     /* LED indicator */
-    sysbus_create_simple_orphan("jazz-led", 0x8000f000, NULL);
+    sysbus_create_simple(OBJECT(machine), "led", "jazz-led",
+                         0x8000f000, NULL);
 
     g_free(dmas);
 }
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 6f2ac8ba90..9ab1edceb2 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -424,8 +424,8 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     LoongsonMachineState *s = LOONGSON_MACHINE(machine);
 
-    dev = qdev_new_orphan(TYPE_GPEX_HOST);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    dev = qdev_new(OBJECT(machine), "pcie", TYPE_GPEX_HOST);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     pci_bus = PCI_HOST_BRIDGE(dev)->bus;
 
     s->ecam_alias = g_new0(MemoryRegion, 1);
@@ -465,11 +465,12 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
     if (defaults_enabled() && object_class_by_name("pci-ohci")) {
         USBBus *usb_bus;
 
-        pci_create_simple_orphan(pci_bus, -1, "pci-ohci");
+        pci_create_simple(OBJECT(machine), "ohci", pci_bus, -1, "pci-ohci");
         usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
                                                           &error_abort));
-        usb_create_simple_orphan(usb_bus, "usb-kbd");
-        usb_create_simple_orphan(usb_bus, "usb-tablet");
+        usb_create_simple(OBJECT(machine), "usb-kbd", usb_bus, "usb-kbd");
+        usb_create_simple(OBJECT(machine), "usb-tablet", usb_bus,
+                          "usb-tablet");
     }
 
     pci_init_nic_devices(pci_bus, mc->default_nic);
@@ -519,16 +520,16 @@ static void mips_loongson3_virt_init(MachineState *machine)
 
     memory_region_init(iocsr, OBJECT(machine), "loongson3.iocsr", UINT32_MAX);
 
-    ipi = qdev_new_orphan(TYPE_LOONGSON_IPI);
+    ipi = qdev_new(OBJECT(machine), "ipi", TYPE_LOONGSON_IPI);
     qdev_prop_set_uint32(ipi, "num-cpu", machine->smp.cpus);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(ipi), &error_fatal);
     memory_region_add_subregion(iocsr, SMP_IPI_MAILBOX,
                             sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 0));
     memory_region_add_subregion(iocsr, MAIL_SEND_ADDR,
                             sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 1));
 
-    liointc = qdev_new_orphan("loongson.liointc");
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(liointc), &error_fatal);
+    liointc = qdev_new(OBJECT(machine), "liointc", "loongson.liointc");
+    sysbus_realize(SYS_BUS_DEVICE(liointc), &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(liointc), 0, virt_memmap[VIRT_LIOINTC].base);
 
@@ -536,7 +537,8 @@ static void mips_loongson3_virt_init(MachineState *machine)
                    qdev_get_gpio_in(liointc, UART_IRQ), 115200, serial_hd(0),
                    DEVICE_LITTLE_ENDIAN);
 
-    sysbus_create_simple_orphan("goldfish_rtc", virt_memmap[VIRT_RTC].base,
+    sysbus_create_simple(OBJECT(machine), "rtc", "goldfish_rtc",
+                         virt_memmap[VIRT_RTC].base,
                          qdev_get_gpio_in(liointc, RTC_IRQ));
 
     cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index ea11299af8..ebd1456657 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1098,8 +1098,8 @@ void mips_malta_init(MachineState *machine)
     PCIDevice *piix4;
     DeviceState *dev;
 
-    s = MIPS_MALTA(qdev_new_orphan(TYPE_MIPS_MALTA));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
+    s = MIPS_MALTA(qdev_new(OBJECT(machine), "malta", TYPE_MIPS_MALTA));
+    sysbus_realize(SYS_BUS_DEVICE(s), &error_fatal);
 
     /* create CPU */
     mips_create_cpu(machine, s, &cbus_irq, &i8259_irq);
@@ -1227,16 +1227,17 @@ void mips_malta_init(MachineState *machine)
     stl_p(memory_region_get_ram_ptr(bios_copy) + 0x10, 0x00000420);
 
     /* Northbridge */
-    dev = qdev_new_orphan("gt64120");
+    dev = qdev_new(OBJECT(machine), "gt64120", "gt64120");
     qdev_prop_set_bit(dev, "cpu-little-endian", !TARGET_BIG_ENDIAN);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci"));
     pci_bus_map_irqs(pci_bus, malta_pci_slot_get_pirq);
 
     /* Southbridge */
-    piix4 = pci_new_multifunction_orphan(PIIX4_PCI_DEVFN, TYPE_PIIX4_PCI_DEVICE);
+    piix4 = pci_new_multifunction(OBJECT(machine), "piix4",
+                                  PIIX4_PCI_DEVFN, TYPE_PIIX4_PCI_DEVICE);
     qdev_prop_set_uint32(DEVICE(piix4), "smb_io_base", 0x1100);
-    pci_realize_and_unref(piix4, pci_bus, &error_fatal);
+    qdev_realize(DEVICE(piix4), BUS(pci_bus), &error_fatal);
     isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(piix4), "isa.0"));
 
     dev = DEVICE(object_resolve_path_component(OBJECT(piix4), "ide"));
@@ -1254,7 +1255,8 @@ void mips_malta_init(MachineState *machine)
     g_free(smbus_eeprom_buf);
 
     /* Super I/O: SMS FDC37M817 */
-    isa_create_simple_orphan(isa_bus, TYPE_FDC37M81X_SUPERIO);
+    isa_create_simple(OBJECT(machine), "superio", isa_bus,
+                      TYPE_FDC37M81X_SUPERIO);
 
     /* Network card */
     network_init(pci_bus);
-- 
2.47.1


