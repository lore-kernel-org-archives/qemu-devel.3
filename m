Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC79C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigO6-00060N-QR; Sat, 11 Jul 2026 18:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigO4-0005y9-RV; Sat, 11 Jul 2026 18:41:32 -0400
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.26.1.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigO0-0005vV-Oi; Sat, 11 Jul 2026 18:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783809688; x=1815345688;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RncaBp9AWxGSftZuWkeLsuFC+aVbpad6KBOmlHbCn0g=;
 b=PfTCjpIkkKisgkp7wgYa9Uqm5uT7wIT8JLBlEZsf0A9elnwE9LPRDyXG
 a/NnCpPD0PucoAQ0dpQ+ydeTDwzogJO/cqHjY4x0/O8IZybJXlmbtPPRK
 ZzA7nyIbeXdqTqrOm0xJv5+nfFD4MRzSC2XwQwB/0XudIbkUr5DHQgwUE
 61kX6YFRE5VFiwJH8jELxu8nGLHcVxxtPJAcASUGcI6zNKa4DZueoQM2u
 HAZVDSGa16H5c9OxfnSsuqFsKxeZoIf9G7ZrtKg1JBTkOPH22SO9YAHSj
 OQh/VeEaN3c2oHc4P4KMCItLcj0wgYaSWuvXI7cQPyiaVrVY2dact5QPm A==;
X-CSE-ConnectionGUID: lePvNfXFSIWjokDUljhAPQ==
X-CSE-MsgGUID: hLPlCHmoSZa8jfJ5+5+dFg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23522100"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:41:24 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:3368]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.175:2525]
 with esmtp (Farcaster)
 id b8ce2edb-8dd9-4367-a36d-b9ae8d54b95c; Sat, 11 Jul 2026 22:41:24 +0000 (UTC)
X-Farcaster-Flow-ID: b8ce2edb-8dd9-4367-a36d-b9ae8d54b95c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:41:24 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:41:15 +0000
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
Subject: [RFC PATCH 016/134] hw/hppa: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:09 +0000
Message-ID: <20260711223707.42139-17-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.26.1.71;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in hw/hppa to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

  hw/hppa/machine.c:268 | OBJECT(machine) | "lasi" | lasi_init() static helper called from board init; thread Object *parent from caller
  hw/hppa/machine.c:278 | OBJECT(machine) | "dino" | dino_init() static helper called from board init; thread Object *parent from caller
  hw/hppa/machine.c:301 | OBJECT(machine) | "cpu[*]" | board init CPU creation loop; auto-index child of machine
  hw/hppa/machine.c:414 | OBJECT(machine) | "artist" | board init tail; on-board Artist graphics owned by machine
  hw/hppa/machine.c:431 | OBJECT(machine) | "diva-gsp" | board init tail; on-board Diva GSP PCI card owned by machine
  hw/hppa/machine.c:446 | OBJECT(machine) | "ohci" | board init tail; on-board OHCI USB controller owned by machine
  hw/hppa/machine.c:449 | OBJECT(pci_dev) | "usb-kbd" | USB keyboard is child of the OHCI controller it plugs into
  hw/hppa/machine.c:450 | OBJECT(pci_dev) | "usb-mouse" | USB mouse is child of the OHCI controller it plugs into
  hw/hppa/machine.c:617 | OBJECT(machine) | "lasips2" | HP 715 board init; on-board Lasi PS/2 controller
  hw/hppa/machine.c:709 | OBJECT(machine) | "lasips2" | HP B160L board init; on-board Lasi PS/2 controller
  hw/hppa/machine.c:724 | OBJECT(machine) | "scsi" | HP B160L board init; on-board LSI SCSI HBA
  hw/hppa/machine.c:736 | OBJECT(machine) | "astro" | astro_init() static helper called from board init; thread Object *parent from caller
  hw/hppa/machine.c:776 | OBJECT(machine) | "scsi" | HP C3700 board init; on-board LSI SCSI HBA

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/hppa/machine.c | 60 ++++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index a4b8e9ee77..729524e065 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -261,24 +261,24 @@ static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus,
     return fw_cfg;
 }
 
-static LasiState *lasi_init(void)
+static LasiState *lasi_init(Object *parent)
 {
     DeviceState *dev;
 
-    dev = qdev_new_orphan(TYPE_LASI_CHIP);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    dev = qdev_new(parent, "lasi", TYPE_LASI_CHIP);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     return LASI_CHIP(dev);
 }
 
-static DinoState *dino_init(MemoryRegion *addr_space)
+static DinoState *dino_init(Object *parent, MemoryRegion *addr_space)
 {
     DeviceState *dev;
 
-    dev = qdev_new_orphan(TYPE_DINO_PCI_HOST_BRIDGE);
+    dev = qdev_new(parent, "dino", TYPE_DINO_PCI_HOST_BRIDGE);
     object_property_set_link(OBJECT(dev), "memory-as", OBJECT(addr_space),
                              &error_fatal);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     return DINO_PCI_HOST_BRIDGE(dev);
 }
@@ -298,7 +298,8 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
 
     /* Create CPUs.  */
     for (unsigned int i = 0; i < smp_cpus; i++) {
-        cpu[i] = HPPA_CPU(cpu_create_orphan(machine->cpu_type));
+        cpu[i] = HPPA_CPU(cpu_create(OBJECT(machine), "cpu[*]",
+                                     machine->cpu_type));
     }
 
     /* Initialize memory */
@@ -411,11 +412,11 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
     lasi_dev = hpm->lasi_dev;
     if (lasi_dev && machine->enable_graphics &&
         vga_interface_type != VGA_NONE) {
-        dev = qdev_new_orphan("artist");
+        dev = qdev_new(OBJECT(machine), "artist", "artist");
         s = SYS_BUS_DEVICE(dev);
         bool disabled = object_property_get_bool(OBJECT(dev), "disable", NULL);
         if (!disabled) {
-            sysbus_realize_and_unref(s, &error_fatal);
+            sysbus_realize(s, &error_fatal);
             vga_interface_created = true;
             sysbus_mmio_map(s, 0, translate(NULL, LASI_GFX_HPA));
             sysbus_mmio_map(s, 1, translate(NULL, ARTIST_FB_ADDR));
@@ -428,7 +429,8 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
 
     if (pci_bus && hppa_is_pa20(&cpu[0]->env)) {
         /* BMC board: HP Diva GSP PCI card */
-        pci_dev = pci_new_multifunction_orphan(PCI_DEVFN(2, 0), "diva-gsp");
+        pci_dev = pci_new_multifunction(OBJECT(machine), "diva-gsp",
+                                        PCI_DEVFN(2, 0), "diva-gsp");
         if (!lasi_dev) {
             /* bind default keyboard/serial to Diva card */
             qdev_prop_set_chr(DEVICE(pci_dev), "chardev1", serial_hd(0));
@@ -436,18 +438,19 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
             qdev_prop_set_chr(DEVICE(pci_dev), "chardev3", serial_hd(2));
             qdev_prop_set_chr(DEVICE(pci_dev), "chardev4", serial_hd(3));
         }
-        pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
+        qdev_realize(DEVICE(pci_dev), BUS(pci_bus), &error_fatal);
     }
 
     /* create USB OHCI controller for USB keyboard & mouse on Astro machines */
     if (!lasi_dev && machine->enable_graphics && defaults_enabled()) {
         USBBus *usb_bus;
 
-        pci_create_simple_orphan(pci_bus, -1, "pci-ohci");
+        pci_dev = pci_create_simple(OBJECT(machine), "ohci", pci_bus, -1,
+                                    "pci-ohci");
         usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
                                                           &error_abort));
-        usb_create_simple_orphan(usb_bus, "usb-kbd");
-        usb_create_simple_orphan(usb_bus, "usb-mouse");
+        usb_create_simple(OBJECT(pci_dev), "usb-kbd", usb_bus, "usb-kbd");
+        usb_create_simple(OBJECT(pci_dev), "usb-mouse", usb_bus, "usb-mouse");
     }
 
     /* register power switch emulation */
@@ -597,7 +600,7 @@ static void machine_HP_715_init(MachineState *machine)
     assert(isa_bus);
 
     /* Init Lasi chip */
-    lasi_dev = DEVICE(lasi_init());
+    lasi_dev = DEVICE(lasi_init(OBJECT(machine)));
     hpm->lasi_dev = lasi_dev;
     memory_region_add_subregion(addr_space, translate(NULL, LASI_HPA_715),
                                 sysbus_mmio_get_region(
@@ -614,8 +617,8 @@ static void machine_HP_715_init(MachineState *machine)
                      parallel_hds[0]);
 
     /* PS/2 Keyboard/Mouse */
-    dev = qdev_new_orphan(TYPE_LASIPS2);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    dev = qdev_new(OBJECT(machine), "lasips2", TYPE_LASIPS2);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(lasi_dev, LASI_IRQ_PS2KBD_HPA));
     memory_region_add_subregion(addr_space,
@@ -672,14 +675,14 @@ static void machine_HP_B160L_init(MachineState *machine)
     }
 
     /* Init Lasi chip */
-    lasi_dev = DEVICE(lasi_init());
+    lasi_dev = DEVICE(lasi_init(OBJECT(machine)));
     hpm->lasi_dev = lasi_dev;
     memory_region_add_subregion(addr_space, translate(NULL, LASI_HPA),
                                 sysbus_mmio_get_region(
                                     SYS_BUS_DEVICE(lasi_dev), 0));
 
     /* Init Dino (PCI host bus chip).  */
-    dino_dev = DEVICE(dino_init(addr_space));
+    dino_dev = DEVICE(dino_init(OBJECT(machine), addr_space));
     memory_region_add_subregion(addr_space, translate(NULL, DINO_HPA),
                                 sysbus_mmio_get_region(
                                     SYS_BUS_DEVICE(dino_dev), 0));
@@ -706,8 +709,8 @@ static void machine_HP_B160L_init(MachineState *machine)
                      parallel_hds[0]);
 
     /* PS/2 Keyboard/Mouse */
-    dev = qdev_new_orphan(TYPE_LASIPS2);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    dev = qdev_new(OBJECT(machine), "lasips2", TYPE_LASIPS2);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(lasi_dev, LASI_IRQ_PS2KBD_HPA));
     memory_region_add_subregion(addr_space,
@@ -721,7 +724,8 @@ static void machine_HP_B160L_init(MachineState *machine)
 
     /* SCSI disk setup. */
     if (drive_get_max_bus(IF_SCSI) >= 0) {
-        dev = DEVICE(pci_create_simple_orphan(pci_bus, -1, "lsi53c895a"));
+        dev = DEVICE(pci_create_simple(OBJECT(machine), "scsi", pci_bus, -1,
+                                       "lsi53c895a"));
         lsi53c8xx_handle_legacy_cmdline(dev);
     }
 
@@ -729,15 +733,15 @@ static void machine_HP_B160L_init(MachineState *machine)
     machine_HP_common_init_tail(machine, pci_bus, translate);
 }
 
-static AstroState *astro_init(void)
+static AstroState *astro_init(Object *parent)
 {
     DeviceState *dev;
 
-    dev = qdev_new_orphan(TYPE_ASTRO_CHIP);
+    dev = qdev_new(parent, "astro", TYPE_ASTRO_CHIP);
     object_property_set_int(OBJECT(dev), "phys-addr-bits",
                             hppa_phys_addr_bits(&cpu[0]->env),
                             &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     return ASTRO_CHIP(dev);
 }
@@ -763,7 +767,7 @@ static void machine_HP_C3700_init(MachineState *machine)
     }
 
     /* Init Astro and the Elroys (PCI host bus chips).  */
-    astro = astro_init();
+    astro = astro_init(OBJECT(machine));
     astro_dev = DEVICE(astro);
     memory_region_add_subregion(addr_space, translate(NULL, ASTRO_HPA),
                                 sysbus_mmio_get_region(
@@ -773,7 +777,9 @@ static void machine_HP_C3700_init(MachineState *machine)
 
     /* SCSI disk setup. */
     if (drive_get_max_bus(IF_SCSI) >= 0) {
-        DeviceState *dev = DEVICE(pci_create_simple_orphan(pci_bus, -1, "lsi53c895a"));
+        DeviceState *dev = DEVICE(pci_create_simple(OBJECT(machine), "scsi",
+                                                    pci_bus, -1,
+                                                    "lsi53c895a"));
         lsi53c8xx_handle_legacy_cmdline(dev);
     }
 
-- 
2.47.1


