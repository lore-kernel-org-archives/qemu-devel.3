Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D032EC44506
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigX8-0006Zn-3x; Sat, 11 Jul 2026 18:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigX6-0006Ue-0h; Sat, 11 Jul 2026 18:50:52 -0400
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([50.112.246.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigX2-0008Fg-84; Sat, 11 Jul 2026 18:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810248; x=1815346248;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=16t5vzSsRTsxyi4B7qNFBpvWZ/ig6NGpK1W/pWLHh9c=;
 b=bZOmLkaccvLIb5tn19VeEuLSCJcc1d+n1NWX9Lz0zOk5iCzlPrOh2fCG
 J6GRMrElr2rRNS5jRvXCQLi0SdynfeQe2WSWVB1U5piwb210rbe6q5mQB
 dbErYQn0QE+Wlnt25f91bHu8M/URnYppurragQ/5zHZNWrp1bd/6UV4+U
 CG+pmPt6XxWIyeJ9L6WAj8WrIfnIA1mFKihlaf48x6/79QgGd2aLaPVl/
 8F1WUpfl7NGFg2fBKjfk2f44WFWEispFNoUwCIw5zCNmijjxC2GvlF05y
 oWdzxL5xrByWfIA0bl0BSGyJmXYA17ny2sElol938OG1ciznK49Md+RpB A==;
X-CSE-ConnectionGUID: n1JZauyzSJWI5lbmuzk7gQ==
X-CSE-MsgGUID: YTvesjqgTc24QAMV3fzXRQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23300005"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:50:44 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:5101]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.54:2525]
 with esmtp (Farcaster)
 id 490d90da-6787-4554-87a6-3fa8040784a5; Sat, 11 Jul 2026 22:50:43 +0000 (UTC)
X-Farcaster-Flow-ID: 490d90da-6787-4554-87a6-3fa8040784a5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:50:43 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:50:34 +0000
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
Subject: [RFC PATCH 051/134] hw/riscv: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:44 +0000
Message-ID: <20260711223707.42139-52-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=50.112.246.219;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in hw/riscv to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/riscv/boston-aia.c:308 | qdev_new | OBJECT(machine) | "pcie" | static helper called from board init; thread Object *parent through
hw/riscv/boston-aia.c:355 | qdev_new | OBJECT(machine) | "boston" | board MachineClass.init()
hw/riscv/boston-aia.c:422 | pci_create_simple_multifunction | OBJECT(machine) | "ahci" | board MachineClass.init()
hw/riscv/microblaze-v-generic.c:82 | qdev_new | OBJECT(machine) | "intc" | board MachineClass.init()
hw/riscv/microblaze-v-generic.c:95 | qdev_new | OBJECT(machine) | "uartlite" | board MachineClass.init()
hw/riscv/microblaze-v-generic.c:108 | qdev_new | OBJECT(machine) | "timer[*]" | board MachineClass.init(); two timers
hw/riscv/microblaze-v-generic.c:117 | qdev_new | OBJECT(machine) | "timer[*]" | board MachineClass.init(); two timers
hw/riscv/microblaze-v-generic.c:126 | qdev_new | OBJECT(machine) | "ethlite" | board MachineClass.init()
hw/riscv/microblaze-v-generic.c:136 | qdev_new | OBJECT(machine) | "xilinx-eth" | board init; collapse existing object_property_add_child, keep name
hw/riscv/microblaze-v-generic.c:137 | qdev_new | OBJECT(machine) | "xilinx-dma" | board init; collapse existing object_property_add_child, keep name
hw/riscv/microchip_pfsoc.c:584 | qdev_new | OBJECT(machine) | "sd-card" | board MachineClass.init()
hw/riscv/sifive_u.c:596 | qdev_new | OBJECT(machine) | "flash" | board MachineClass.init()
hw/riscv/sifive_u.c:609 | ssi_create_peripheral | OBJECT(machine) | "ssi-sd" | board MachineClass.init()
hw/riscv/sifive_u.c:616 | qdev_new | OBJECT(machine) | "sd-card" | board MachineClass.init()
hw/riscv/tt_atlantis.c:580 | i2c_slave_create_simple | OBJECT(s) | "rtc" | board init; s is TTAtlantisState (machine)
hw/riscv/tt_atlantis.c:581 | i2c_slave_create_simple | OBJECT(s) | "tmp105" | board init; s is TTAtlantisState (machine)
hw/riscv/virt.c:129 | qdev_new | OBJECT(s) | name | helper receives RISCVVirtState *s; collapse existing object_property_add_child, keep name arg
hw/riscv/virt.c:1054 | qdev_new | OBJECT(s) | "pcie" | helper receives RISCVVirtState *s (machine)
hw/riscv/virt.c:1147 | qdev_new | OBJECT(s) | "platform-bus" | helper receives RISCVVirtState *s (machine)
hw/riscv/virt.c:1484 | sysbus_create_simple | OBJECT(machine) | "virtio-mmio[*]" | board MachineClass.init(); loop
hw/riscv/virt.c:1497 | sysbus_create_simple | OBJECT(machine) | "rtc" | board MachineClass.init()
hw/riscv/virt.c:1519 | qdev_new | OBJECT(machine) | "iommu" | board MachineClass.init()

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/riscv/boston-aia.c           | 17 +++++++++--------
 hw/riscv/microblaze-v-generic.c | 32 ++++++++++++++------------------
 hw/riscv/microchip_pfsoc.c      |  5 +++--
 hw/riscv/sifive_u.c             | 15 ++++++++-------
 hw/riscv/tt_atlantis.c          |  5 +++--
 hw/riscv/virt.c                 | 24 ++++++++++++------------
 6 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 26bacf0e59..3b0eba00a7 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -297,7 +297,7 @@ static void gen_firmware(uint32_t *p)
 }
 
 static inline XilinxPCIEHost *
-xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
+xilinx_pcie_init(Object *parent, MemoryRegion *sys_mem, uint32_t bus_nr,
                  hwaddr cfg_base, uint64_t cfg_size,
                  hwaddr mmio_base, uint64_t mmio_size,
                  qemu_irq irq)
@@ -305,7 +305,7 @@ xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
     DeviceState *dev;
     MemoryRegion *cfg, *mmio;
 
-    dev = qdev_new_orphan(TYPE_XILINX_PCIE_HOST);
+    dev = qdev_new(parent, "pcie", TYPE_XILINX_PCIE_HOST);
 
     qdev_prop_set_uint32(dev, "bus_nr", bus_nr);
     qdev_prop_set_uint64(dev, "cfg_base", cfg_base);
@@ -313,7 +313,7 @@ xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
     qdev_prop_set_uint64(dev, "mmio_base", mmio_base);
     qdev_prop_set_uint64(dev, "mmio_size", mmio_size);
 
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     cfg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
     memory_region_add_subregion_overlap(sys_mem, cfg_base, cfg, 0);
@@ -352,8 +352,8 @@ static void boston_mach_init(MachineState *machine)
         exit(1);
     }
 
-    dev = qdev_new_orphan(TYPE_MIPS_BOSTON_AIA);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    dev = qdev_new(OBJECT(machine), "boston", TYPE_MIPS_BOSTON_AIA);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     s = BOSTON(dev);
     s->mach = machine;
@@ -390,7 +390,7 @@ static void boston_mach_init(MachineState *machine)
                              MIN(machine->ram_size, (256 * MiB)));
     memory_region_add_subregion_overlap(sys_mem, 0, ddr_low_alias, 0);
 
-    pcie2 = xilinx_pcie_init(sys_mem, 2,
+    pcie2 = xilinx_pcie_init(OBJECT(machine), sys_mem, 2,
                              boston_memmap[BOSTON_PCIE2].base,
                              boston_memmap[BOSTON_PCIE2].size,
                              boston_memmap[BOSTON_PCIE2_MMIO].base,
@@ -419,8 +419,9 @@ static void boston_mach_init(MachineState *machine)
     qemu_chr_fe_set_handlers(&s->lcd_display, NULL, NULL,
                              boston_lcd_event, NULL, s, NULL, true);
 
-    pdev = pci_create_simple_multifunction_orphan(&PCI_BRIDGE(&pcie2->root)->sec_bus,
-                                           PCI_DEVFN(0, 0), TYPE_ICH9_AHCI);
+    pdev = pci_create_simple_multifunction(OBJECT(machine), "ahci",
+                                &PCI_BRIDGE(&pcie2->root)->sec_bus,
+                                PCI_DEVFN(0, 0), TYPE_ICH9_AHCI);
     ich9 = ICH9_AHCI(pdev);
     g_assert(ARRAY_SIZE(hd) == ich9->ahci.ports);
     ide_drive_get(hd, ich9->ahci.ports);
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index 063be14b19..fbfdec7ede 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -79,11 +79,11 @@ static void mb_v_generic_init(MachineState *machine)
                            ram_size, &error_fatal);
     memory_region_add_subregion(sysmem, ddr_base, phys_ram);
 
-    dev = qdev_new_orphan("xlnx.xps-intc");
+    dev = qdev_new(OBJECT(machine), "intc", "xlnx.xps-intc");
     qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qdev_prop_set_uint32(dev, "kind-of-intr",
                          1 << UARTLITE_IRQ);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, INTC_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(DEVICE(cpu), 11));
@@ -92,10 +92,10 @@ static void mb_v_generic_init(MachineState *machine)
     }
 
     /* Uartlite */
-    dev = qdev_new_orphan(TYPE_XILINX_UARTLITE);
+    dev = qdev_new(OBJECT(machine), "uartlite", TYPE_XILINX_UARTLITE);
     qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qdev_prop_set_chr(dev, "chardev", serial_hd(0));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, UARTLITE_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[UARTLITE_IRQ]);
 
@@ -105,40 +105,36 @@ static void mb_v_generic_init(MachineState *machine)
                    DEVICE_LITTLE_ENDIAN);
 
     /* 2 timers at irq 0 @ 100 Mhz.  */
-    dev = qdev_new_orphan("xlnx.xps-timer");
+    dev = qdev_new(OBJECT(machine), "timer[*]", "xlnx.xps-timer");
     qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 100000000);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
 
     /* 2 timers at irq 3 @ 100 Mhz.  */
-    dev = qdev_new_orphan("xlnx.xps-timer");
+    dev = qdev_new(OBJECT(machine), "timer[*]", "xlnx.xps-timer");
     qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qdev_prop_set_uint32(dev, "one-timer-only", 0);
     qdev_prop_set_uint32(dev, "clock-frequency", 100000000);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, TIMER_BASEADDR2);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ2]);
 
     /* Emaclite */
-    dev = qdev_new_orphan("xlnx.xps-ethernetlite");
+    dev = qdev_new(OBJECT(machine), "ethlite", "xlnx.xps-ethernetlite");
     qdev_prop_set_enum(dev, "endianness", ENDIAN_MODE_LITTLE);
     qemu_configure_nic_device(dev, true, NULL);
     qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
     qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ETHLITE_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
 
     /* axi ethernet and dma initialization. */
-    eth0 = qdev_new_orphan("xlnx.axi-ethernet");
-    dma = qdev_new_orphan("xlnx.axi-dma");
-
-    /* FIXME: attach to the sysbus instead */
-    object_property_add_child(qdev_get_machine(), "xilinx-eth", OBJECT(eth0));
-    object_property_add_child(qdev_get_machine(), "xilinx-dma", OBJECT(dma));
+    eth0 = qdev_new(OBJECT(machine), "xilinx-eth", "xlnx.axi-ethernet");
+    dma = qdev_new(OBJECT(machine), "xilinx-dma", "xlnx.axi-dma");
 
     ds = object_property_get_link(OBJECT(dma),
                                   "axistream-connected-target", NULL);
@@ -151,7 +147,7 @@ static void mb_v_generic_init(MachineState *machine)
                              &error_abort);
     object_property_set_link(OBJECT(eth0), "axistream-control-connected", cs,
                              &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(eth0), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(eth0), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(eth0), 0, AXIENET_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(eth0), 0, irq[AXIENET_IRQ]);
 
@@ -164,7 +160,7 @@ static void mb_v_generic_init(MachineState *machine)
                              &error_abort);
     object_property_set_link(OBJECT(dma), "axistream-control-connected", cs,
                              &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dma), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, AXIDMA_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dma), 0, irq[AXIDMA_IRQ0]);
     sysbus_connect_irq(SYS_BUS_DEVICE(dma), 1, irq[AXIDMA_IRQ1]);
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 52fb5d5970..0d298aa3fc 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -581,11 +581,12 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     /* Attach an SD card */
     if (dinfo) {
         CadenceSDHCIState *sdhci = &(s->soc.sdhci);
-        DeviceState *card = qdev_new_orphan(TYPE_SD_CARD);
+        DeviceState *card = qdev_new(OBJECT(machine), "sd-card",
+                                     TYPE_SD_CARD);
 
         qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
-        qdev_realize_and_unref(card, sdhci->bus, &error_fatal);
+        qdev_realize(card, sdhci->bus, &error_fatal);
     }
 
     /*
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 0ef0124140..3d60a501dd 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -593,31 +593,32 @@ static void sifive_u_machine_init(MachineState *machine)
                                  sizeof(reset_vec), kernel_entry);
 
     /* Connect an SPI flash to SPI0 */
-    flash_dev = qdev_new_orphan("is25wp256");
+    flash_dev = qdev_new(OBJECT(machine), "flash", "is25wp256");
     dinfo = drive_get(IF_MTD, 0, 0);
     if (dinfo) {
         qdev_prop_set_drive_err(flash_dev, "drive",
                                 blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
     }
-    qdev_realize_and_unref(flash_dev, BUS(s->soc.spi0.spi), &error_fatal);
+    qdev_realize(flash_dev, BUS(s->soc.spi0.spi), &error_fatal);
 
     flash_cs = qdev_get_gpio_in_named(flash_dev, SSI_GPIO_CS, 0);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->soc.spi0), 1, flash_cs);
 
     /* Connect an SD card to SPI2 */
-    sd_dev = ssi_create_peripheral_orphan(s->soc.spi2.spi, "ssi-sd");
+    sd_dev = ssi_create_peripheral(OBJECT(machine), "ssi-sd",
+                                   s->soc.spi2.spi, "ssi-sd");
 
     sd_cs = qdev_get_gpio_in_named(sd_dev, SSI_GPIO_CS, 0);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->soc.spi2), 1, sd_cs);
 
     dinfo = drive_get(IF_SD, 0, 0);
     blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
-    card_dev = qdev_new_orphan(TYPE_SD_CARD_SPI);
+    card_dev = qdev_new(OBJECT(machine), "sd-card", TYPE_SD_CARD_SPI);
     qdev_prop_set_drive_err(card_dev, "drive", blk, &error_fatal);
-    qdev_realize_and_unref(card_dev,
-                           qdev_get_child_bus(sd_dev, "sd-bus"),
-                           &error_fatal);
+    qdev_realize(card_dev,
+                 qdev_get_child_bus(sd_dev, "sd-bus"),
+                 &error_fatal);
 }
 
 static bool sifive_u_machine_get_start_in_flash(Object *obj, Error **errp)
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index ec6988fe62..57ced817e3 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -577,8 +577,9 @@ static void tt_atlantis_machine_init(MachineState *machine)
     }
 
     /* I2C peripherals: qemu specific */
-    i2c_slave_create_simple_orphan(i2c_get_bus(s, 0), "ds1338", 0x6f);
-    i2c_slave_create_simple_orphan(i2c_get_bus(s, 4), "tmp105", 0x48);
+    i2c_slave_create_simple(OBJECT(s), "rtc", i2c_get_bus(s, 0), "ds1338", 0x6f);
+    i2c_slave_create_simple(OBJECT(s), "tmp105", i2c_get_bus(s, 4),
+                            "tmp105", 0x48);
 
     /* Load or create device tree */
     if (machine->dtb) {
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e1f5f1c889..7e5bdaf210 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -126,7 +126,7 @@ static PFlashCFI01 *virt_flash_create1(RISCVVirtState *s,
      * Create a single flash device.  We use the same parameters as
      * the flash devices on the ARM virt board.
      */
-    DeviceState *dev = qdev_new_orphan(TYPE_PFLASH_CFI01);
+    DeviceState *dev = qdev_new(OBJECT(s), name, TYPE_PFLASH_CFI01);
 
     qdev_prop_set_uint64(dev, "sector-length", VIRT_FLASH_SECTOR_SIZE);
     qdev_prop_set_uint8(dev, "width", 4);
@@ -138,7 +138,6 @@ static PFlashCFI01 *virt_flash_create1(RISCVVirtState *s,
     qdev_prop_set_uint16(dev, "id3", 0x00);
     qdev_prop_set_string(dev, "name", name);
 
-    object_property_add_child(OBJECT(s), name, OBJECT(dev));
     object_property_add_alias(OBJECT(s), alias_prop_name,
                               OBJECT(dev), "drive");
 
@@ -160,7 +159,7 @@ static void virt_flash_map1(PFlashCFI01 *flash,
     assert(QEMU_IS_ALIGNED(size, VIRT_FLASH_SECTOR_SIZE));
     assert(size / VIRT_FLASH_SECTOR_SIZE <= UINT32_MAX);
     qdev_prop_set_uint32(dev, "num-blocks", size / VIRT_FLASH_SECTOR_SIZE);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     memory_region_add_subregion(sysmem, base,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
@@ -1051,7 +1050,7 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
     qemu_irq irq;
     int i;
 
-    dev = qdev_new_orphan(TYPE_GPEX_HOST);
+    dev = qdev_new(OBJECT(s), "pcie", TYPE_GPEX_HOST);
 
     /* Set GPEX object properties for the virt machine */
     object_property_set_uint(OBJECT(dev), PCI_HOST_ECAM_BASE,
@@ -1071,7 +1070,7 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
     object_property_set_int(OBJECT(dev), PCI_HOST_PIO_SIZE,
                             pio_size, NULL);
 
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     ecam_alias = g_new0(MemoryRegion, 1);
     ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
@@ -1144,11 +1143,11 @@ static void create_platform_bus(RISCVVirtState *s, DeviceState *irqchip)
     int i;
     MemoryRegion *sysmem = get_system_memory();
 
-    dev = qdev_new_orphan(TYPE_PLATFORM_BUS_DEVICE);
+    dev = qdev_new(OBJECT(s), "platform-bus", TYPE_PLATFORM_BUS_DEVICE);
     dev->id = g_strdup(TYPE_PLATFORM_BUS_DEVICE);
     qdev_prop_set_uint32(dev, "num_irqs", VIRT_PLATFORM_BUS_NUM_IRQS);
     qdev_prop_set_uint32(dev, "mmio_size", s->memmap[VIRT_PLATFORM_BUS].size);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     s->platform_bus_dev = dev;
 
     sysbus = SYS_BUS_DEVICE(dev);
@@ -1481,7 +1480,7 @@ static void virt_machine_init(MachineState *machine)
 
     /* VirtIO MMIO devices */
     for (i = 0; i < VIRTIO_COUNT; i++) {
-        sysbus_create_simple_orphan("virtio-mmio",
+        sysbus_create_simple(OBJECT(machine), "virtio-mmio[*]", "virtio-mmio",
             s->memmap[VIRT_VIRTIO].base + i * s->memmap[VIRT_VIRTIO].size,
             qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
     }
@@ -1494,8 +1493,8 @@ static void virt_machine_init(MachineState *machine)
         0, qdev_get_gpio_in(mmio_irqchip, UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
-    sysbus_create_simple_orphan("goldfish_rtc", s->memmap[VIRT_RTC].base,
-        qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
+    sysbus_create_simple(OBJECT(machine), "rtc", "goldfish_rtc",
+        s->memmap[VIRT_RTC].base, qdev_get_gpio_in(mmio_irqchip, RTC_IRQ));
 
     for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
         /* Map legacy -drive if=pflash to machine properties */
@@ -1516,7 +1515,8 @@ static void virt_machine_init(MachineState *machine)
     }
 
     if (virt_is_iommu_sys_enabled(s)) {
-        DeviceState *iommu_sys = qdev_new_orphan(TYPE_RISCV_IOMMU_SYS);
+        DeviceState *iommu_sys = qdev_new(OBJECT(machine), "iommu",
+                                          TYPE_RISCV_IOMMU_SYS);
 
         object_property_set_uint(OBJECT(iommu_sys), "addr",
                                  s->memmap[VIRT_IOMMU_SYS].base,
@@ -1535,7 +1535,7 @@ static void virt_machine_init(MachineState *machine)
                                  riscv_is_32bit(&s->soc[0]) ? 34 : 56,
                                  &error_fatal);
 
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
     }
 
     s->machine_done.notify = virt_machine_done;
-- 
2.47.1


