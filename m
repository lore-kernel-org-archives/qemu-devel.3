Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A743C4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 21:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlCuA-0007KY-AI; Sat, 18 Jul 2026 17:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCu8-0007JU-7D; Sat, 18 Jul 2026 17:49:04 -0400
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.68.102])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlCu5-0003Tp-UB; Sat, 18 Jul 2026 17:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784411341; x=1815947341;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WtI6/LryjcJF/GDGDGWQHJKuVvIXg4pSK5f4cg+pxXM=;
 b=CbMjintThCz/2yl8ONLzdAhrXs0G5XE2Lj/4GTaUKVbNbdfjdr6lCwY3
 idNn57KSEbp3KEcBfvWDrXwULYOj2GIEM6FJaAj9V8FRzCPmRzYBfKKRQ
 hQ7VOU5KmyZca3ZFpUDwByVk4o4L4OI/7ewy5vSxX6ySJPU1US9xyFQan
 KyD6wBwP8/LXEclIhhG8uExuPqHBKEBbq/hZcrYvVtWlKmjiznckDS3tH
 0D4to9nfvgeEIK986TYJmS4pXVgs/7WRg2gxBjssiElDG4LwmyY6PGN+F
 X17GnfdhBOXv2iFUF8/q7MTB0R8XymAzVDNqtPj6FYPSA6Up1C2IgZXFp g==;
X-CSE-ConnectionGUID: pjHFv9qJTsy5lswvz1uCvQ==
X-CSE-MsgGUID: x7kehdEmR46JDyNqTVtgcg==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23941823"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 21:48:58 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:6818]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.147:2525]
 with esmtp (Farcaster)
 id 79940bbb-02ae-448f-ad99-b901619f5799; Sat, 18 Jul 2026 21:48:57 +0000 (UTC)
X-Farcaster-Flow-ID: 79940bbb-02ae-448f-ad99-b901619f5799
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:48:57 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 21:48:47 +0000
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
Subject: [RFC PATCH v2 043/137] hw/sparc64: Give onboard devices a QOM parent
Date: Sat, 18 Jul 2026 21:35:18 +0000
Message-ID: <20260718213652.37673-44-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=44.246.68.102;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_LOW=-0.7,
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

Convert the *_orphan() device-creation calls in hw/sparc64 to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/sparc64/sun4u.c:332 | isa_create_simple | OBJECT(s) | "i8042" | ebus_realize(): child of EBus device
hw/sparc64/sun4u.c:338 | isa_new | OBJECT(s) | "fdc" | ebus_realize(): child of EBus device; drop _and_unref
hw/sparc64/sun4u.c:345 | qdev_new | OBJECT(s) | "power" | ebus_realize(): child of EBus device; drop _and_unref
hw/sparc64/sun4u.c:426 | qdev_new | parent | "prom" | prom_init() helper: thread Object *parent from board init
hw/sparc64/sun4u.c:510 | qdev_new | parent | "ram" | ram_init() helper: thread Object *parent from board init
hw/sparc64/sun4u.c:562 | qdev_new | OBJECT(machine) | "iommu" | sun4uv_init() board init
hw/sparc64/sun4u.c:571 | qdev_new | OBJECT(machine) | "sabre" | sun4uv_init() board init; PCI host bridge
hw/sparc64/sun4u.c:602 | pci_new_multifunction | OBJECT(machine) | "ebus" | sun4uv_init() board init; drop _and_unref
hw/sparc64/sun4u.c:621 | pci_create_simple | OBJECT(machine) | "vga" | sun4uv_init() board init
hw/sparc64/sun4u.c:635 | pci_new_multifunction | OBJECT(machine) | "nic" | sun4uv_init() board init; onboard NIC; drop _and_unref
hw/sparc64/sun4u.c:651 | pci_new | OBJECT(machine) | "ide" | sun4uv_init() board init; drop _and_unref
hw/sparc64/sun4u.c:657 | qdev_new | OBJECT(machine) | "nvram" | sun4uv_init() board init; drop _and_unref
hw/sparc64/sun4u.c:692 | qdev_new | OBJECT(ebus) | TYPE_FW_CFG | collapse existing object_property_add_child(); keep name; drop _and_unref

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/sparc64/sun4u.c | 60 ++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index b60588cf7d..19a54b1f8a 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -329,22 +329,22 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
     parallel_hds_isa_init(s->isa_bus, MAX_PARALLEL_PORTS);
 
     /* Keyboard */
-    isa_create_simple_orphan(s->isa_bus, TYPE_I8042);
+    isa_create_simple(OBJECT(s), "i8042", s->isa_bus, TYPE_I8042);
 
     /* Floppy */
     for (i = 0; i < MAX_FD; i++) {
         fd[i] = drive_get(IF_FLOPPY, 0, i);
     }
-    isa_dev = isa_new_orphan(TYPE_ISA_FDC);
+    isa_dev = isa_new(OBJECT(s), "fdc", TYPE_ISA_FDC);
     dev = DEVICE(isa_dev);
     qdev_prop_set_uint32(dev, "dma", -1);
-    isa_realize_and_unref(isa_dev, s->isa_bus, &error_fatal);
+    qdev_realize(dev, BUS(s->isa_bus), &error_fatal);
     isa_fdc_init_drives(isa_dev, fd);
 
     /* Power */
-    dev = qdev_new_orphan(TYPE_SUN4U_POWER);
+    dev = qdev_new(OBJECT(s), "power", TYPE_SUN4U_POWER);
     sbd = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sbd, &error_fatal);
+    sysbus_realize(sbd, &error_fatal);
     memory_region_add_subregion(pci_address_space_io(pci_dev), 0x7240,
                                 sysbus_mmio_get_region(sbd, 0));
 
@@ -416,16 +416,16 @@ static uint64_t translate_prom_address(void *opaque, uint64_t addr)
 }
 
 /* Boot PROM (OpenBIOS) */
-static void prom_init(hwaddr addr, const char *bios_name)
+static void prom_init(Object *parent, hwaddr addr, const char *bios_name)
 {
     DeviceState *dev;
     SysBusDevice *s;
     char *filename;
     int ret;
 
-    dev = qdev_new_orphan(TYPE_OPENPROM);
+    dev = qdev_new(parent, "prom", TYPE_OPENPROM);
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
 
     sysbus_mmio_map(s, 0, addr);
 
@@ -500,19 +500,19 @@ static void ram_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &d->ram);
 }
 
-static void ram_init(hwaddr addr, ram_addr_t RAM_size)
+static void ram_init(Object *parent, hwaddr addr, ram_addr_t RAM_size)
 {
     DeviceState *dev;
     SysBusDevice *s;
     RamDevice *d;
 
     /* allocate RAM */
-    dev = qdev_new_orphan(TYPE_SUN4U_MEMORY);
+    dev = qdev_new(parent, "ram", TYPE_SUN4U_MEMORY);
     s = SYS_BUS_DEVICE(dev);
 
     d = SUN4U_RAM(dev);
     d->size = RAM_size;
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
 
     sysbus_mmio_map(s, 0, addr);
 }
@@ -559,21 +559,21 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     cpu = sparc64_cpu_devinit(machine->cpu_type, hwdef->prom_addr);
 
     /* IOMMU */
-    iommu = qdev_new_orphan(TYPE_SUN4U_IOMMU);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu), &error_fatal);
+    iommu = qdev_new(OBJECT(machine), "iommu", TYPE_SUN4U_IOMMU);
+    sysbus_realize(SYS_BUS_DEVICE(iommu), &error_fatal);
 
     /* set up devices */
-    ram_init(0, machine->ram_size);
+    ram_init(OBJECT(machine), 0, machine->ram_size);
 
-    prom_init(hwdef->prom_addr, machine->firmware);
+    prom_init(OBJECT(machine), hwdef->prom_addr, machine->firmware);
 
     /* Init sabre (PCI host bridge) */
-    sabre = SABRE(qdev_new_orphan(TYPE_SABRE));
+    sabre = SABRE(qdev_new(OBJECT(machine), "sabre", TYPE_SABRE));
     qdev_prop_set_uint64(DEVICE(sabre), "special-base", PBM_SPECIAL_BASE);
     qdev_prop_set_uint64(DEVICE(sabre), "mem-base", PBM_MEM_BASE);
     object_property_set_link(OBJECT(sabre), "iommu", OBJECT(iommu),
                              &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(sabre), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(sabre), &error_fatal);
 
     /* sabre_config */
     sysbus_mmio_map(SYS_BUS_DEVICE(sabre), 0, PBM_SPECIAL_BASE);
@@ -599,10 +599,11 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     pci_bus_set_slot_reserved_mask(pci_busA, 0xfffffff1);
     pci_bus_set_slot_reserved_mask(pci_busB, 0xfffffff0);
 
-    ebus = pci_new_multifunction_orphan(PCI_DEVFN(1, 0), TYPE_EBUS);
+    ebus = pci_new_multifunction(OBJECT(machine), "ebus", PCI_DEVFN(1, 0),
+                                 TYPE_EBUS);
     qdev_prop_set_uint64(DEVICE(ebus), "console-serial-base",
                          hwdef->console_serial_base);
-    pci_realize_and_unref(ebus, pci_busA, &error_fatal);
+    qdev_realize(DEVICE(ebus), BUS(pci_busA), &error_fatal);
 
     /* Wire up "well-known" ISA IRQs to PBM legacy obio IRQs */
     qdev_connect_gpio_out_named(DEVICE(ebus), "isa-irq", 7,
@@ -618,7 +619,8 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
 
     switch (vga_interface_type) {
     case VGA_STD:
-        pci_create_simple_orphan(pci_busA, PCI_DEVFN(2, 0), "VGA");
+        pci_create_simple(OBJECT(machine), "vga", pci_busA, PCI_DEVFN(2, 0),
+                          "VGA");
         vga_interface_created = true;
         break;
     case VGA_NONE:
@@ -632,10 +634,11 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
 
     nd = qemu_find_nic_info(mc->default_nic, true, NULL);
     if (nd) {
-        pci_dev = pci_new_multifunction_orphan(PCI_DEVFN(1, 1), mc->default_nic);
+        pci_dev = pci_new_multifunction(OBJECT(machine), "nic",
+                                        PCI_DEVFN(1, 1), mc->default_nic);
         dev = &pci_dev->qdev;
         qdev_set_nic_properties(dev, nd);
-        pci_realize_and_unref(pci_dev, pci_busA, &error_fatal);
+        qdev_realize(dev, BUS(pci_busA), &error_fatal);
 
         memcpy(&macaddr, &nd->macaddr.a, sizeof(MACAddr));
         onboard_nic = true;
@@ -648,16 +651,16 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
         qemu_macaddr_default_if_unset(&macaddr);
     }
 
-    pci_dev = pci_new_orphan(PCI_DEVFN(3, 0), "cmd646-ide");
+    pci_dev = pci_new(OBJECT(machine), "ide", PCI_DEVFN(3, 0), "cmd646-ide");
     qdev_prop_set_uint32(&pci_dev->qdev, "secondary", 1);
-    pci_realize_and_unref(pci_dev, pci_busA, &error_fatal);
+    qdev_realize(DEVICE(pci_dev), BUS(pci_busA), &error_fatal);
     pci_ide_create_devs(pci_dev);
 
     /* Map NVRAM into I/O (ebus) space */
-    dev = qdev_new_orphan("sysbus-m48t59");
+    dev = qdev_new(OBJECT(machine), "nvram", "sysbus-m48t59");
     qdev_prop_set_int32(dev, "base-year", 1968);
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     memory_region_add_subregion(pci_address_space_io(ebus), 0x2000,
                                 sysbus_mmio_get_region(s, 0));
     nvram = NVRAM(dev);
@@ -689,10 +692,9 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
                            graphic_width, graphic_height, graphic_depth,
                            (uint8_t *)&macaddr);
 
-    dev = qdev_new_orphan(TYPE_FW_CFG_IO);
+    dev = qdev_new(OBJECT(ebus), TYPE_FW_CFG, TYPE_FW_CFG_IO);
     qdev_prop_set_bit(dev, "dma_enabled", false);
-    object_property_add_child(OBJECT(ebus), TYPE_FW_CFG, OBJECT(dev));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     memory_region_add_subregion(pci_address_space_io(ebus), BIOS_CFG_IOPORT,
                                 &FW_CFG_IO(dev)->comb_iomem);
 
-- 
2.47.1


