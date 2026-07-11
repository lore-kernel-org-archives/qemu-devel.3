Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353A7C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigOg-00075x-5e; Sat, 11 Jul 2026 18:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigOf-00074A-1J; Sat, 11 Jul 2026 18:42:09 -0400
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.26.1.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigOc-0006Cw-SU; Sat, 11 Jul 2026 18:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783809726; x=1815345726;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qMPbGFqCKxPQM6ElTAz9beLpsHNRC+O2pYsyGiJtOHI=;
 b=jVT7szav1pBjT9+u1xll1+2AoFL9+N9Ih5SNLC10DUvnhFBdPxgm/Aup
 UjUma9144a7wFVLxTPeBKsljQwS3b2jnjT6ydb7U5LbnL0uWpionYAXJt
 3KeVJfj0FvSr5KuGBI7bt8SAVbSINwOo1D4dKikgHSIGj2RJtjwVQJXc0
 nYLipYoo0KdCI/TNqaZSimwldmnZFeB7w3tyf9T5M8DdIR6k8J4cU6NaL
 +Ql87hQpgnR16H1iuPaXm4lyYAOO0/TPz3rZxMLmfRvkr96IzFlWCTUc9
 gGvO4SnIcScnGxU2xogEnadwbDPuMyYINmqUUHtj2n9fX/jNdNQgjHt5L w==;
X-CSE-ConnectionGUID: iDaGxdddRseyg5kwJExRAw==
X-CSE-MsgGUID: XB4nlmNtTa2yGCl+3ocxRQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23522119"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:42:03 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:23420]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.68:2525]
 with esmtp (Farcaster)
 id 4974013e-61a9-479e-b25a-f2e429ecef96; Sat, 11 Jul 2026 22:42:03 +0000 (UTC)
X-Farcaster-Flow-ID: 4974013e-61a9-479e-b25a-f2e429ecef96
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:42:02 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:41:53 +0000
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
Subject: [RFC PATCH 018/134] hw/sh4: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:11 +0000
Message-ID: <20260711223707.42139-19-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
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

Convert the *_orphan() device-creation calls in hw/sh4 to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/sh4/r2d.c:254 | cpu_create | OBJECT(machine) | "cpu" | board init: single CPU owned by machine
hw/sh4/r2d.c:269 | qdev_new | OBJECT(machine) | "pci-host" | board init: SH PCI host bridge owned by machine
hw/sh4/r2d.c:280 | qdev_new | OBJECT(machine) | "sm501" | board init: on-board SM501 companion chip owned by machine
hw/sh4/r2d.c:292 | qdev_new | OBJECT(machine) | "ide" | board init: on-board CF/IDE controller owned by machine
hw/sh4/r2d.c:323 | usb_create_simple | OBJECT(BUS(usb_bus)->parent) | "usb-kbd" | keyboard hangs off the SM501 OHCI controller that owns the USB bus
hw/sh4/sh7750.c:765 | qdev_new | parent | "sci" | SoC helper: threaded Object *parent from board; on-chip SCI UART
hw/sh4/sh7750.c:782 | qdev_new | parent | "scif" | SoC helper: threaded Object *parent from board; on-chip SCIF UART

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/sh4/r2d.c        | 20 +++++++++++---------
 hw/sh4/sh7750.c     | 11 ++++++-----
 include/hw/sh4/sh.h |  3 ++-
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 9f313a77cb..c0f8cad335 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -251,7 +251,8 @@ static void r2d_init(MachineState *machine)
     USBBus *usb_bus;
     r2d_fpga_t *fpga;
 
-    cpu = SUPERH_CPU(cpu_create_orphan(machine->cpu_type));
+    cpu = SUPERH_CPU(cpu_create(OBJECT(machine), "cpu",
+                                machine->cpu_type));
     env = &cpu->env;
 
     reset_info = g_new0(ResetData, 1);
@@ -263,12 +264,12 @@ static void r2d_init(MachineState *machine)
     memory_region_init_ram(sdram, NULL, "r2d.sdram", SDRAM_SIZE, &error_fatal);
     memory_region_add_subregion(address_space_mem, SDRAM_BASE, sdram);
     /* Register peripherals */
-    s = sh7750_init(cpu, address_space_mem);
+    s = sh7750_init(OBJECT(machine), cpu, address_space_mem);
     fpga = r2d_fpga_init(address_space_mem, 0x04000000, sh7750_irl(s));
 
-    dev = qdev_new_orphan("sh_pci");
+    dev = qdev_new(OBJECT(machine), "pci-host", "sh_pci");
     busdev = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_realize(busdev, &error_fatal);
     pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci"));
     sysbus_mmio_map(busdev, 0, P4ADDR(0x1e200000));
     sysbus_mmio_map(busdev, 1, A7ADDR(0x1e200000));
@@ -277,23 +278,23 @@ static void r2d_init(MachineState *machine)
     sysbus_connect_irq(busdev, 2, &fpga->irq[PCI_INTC]);
     sysbus_connect_irq(busdev, 3, &fpga->irq[PCI_INTD]);
 
-    dev = qdev_new_orphan("sysbus-sm501");
+    dev = qdev_new(OBJECT(machine), "sm501", "sysbus-sm501");
     busdev = SYS_BUS_DEVICE(dev);
     qdev_prop_set_uint32(dev, "vram-size", SM501_VRAM_SIZE);
     qdev_prop_set_uint64(dev, "dma-offset", 0x10000000);
     qdev_prop_set_chr(dev, "chardev", serial_hd(2));
-    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_realize(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0x10000000);
     sysbus_mmio_map(busdev, 1, 0x13e00000);
     sysbus_connect_irq(busdev, 0, &fpga->irq[SM501]);
 
     /* onboard CF (True IDE mode, Master only). */
     dinfo = drive_get(IF_IDE, 0, 0);
-    dev = qdev_new_orphan("mmio-ide");
+    dev = qdev_new(OBJECT(machine), "ide", "mmio-ide");
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_connect_irq(busdev, 0, &fpga->irq[CF_IDE]);
     qdev_prop_set_uint32(dev, "shift", 1);
-    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_realize(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0x14001000);
     sysbus_mmio_map(busdev, 1, 0x1400080c);
     mmio_ide_init_drives(dev, dinfo, NULL);
@@ -320,7 +321,8 @@ static void r2d_init(MachineState *machine)
     /* USB keyboard */
     usb_bus = USB_BUS(object_resolve_type_unambiguous(TYPE_USB_BUS,
                                                       &error_abort));
-    usb_create_simple_orphan(usb_bus, "usb-kbd");
+    usb_create_simple(OBJECT(BUS(usb_bus)->parent), "usb-kbd",
+                      usb_bus, "usb-kbd");
 
     /* Todo: register on board registers */
     memset(&boot_params, 0, sizeof(boot_params));
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 3eb47bc660..ff9724fadf 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -710,7 +710,8 @@ static const MemoryRegionOps sh7750_mmct_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-SH7750State *sh7750_init(SuperHCPU *cpu, MemoryRegion *sysmem)
+SH7750State *sh7750_init(Object *parent, SuperHCPU *cpu,
+                         MemoryRegion *sysmem)
 {
     SH7750State *s;
     DeviceState *dev;
@@ -762,11 +763,11 @@ SH7750State *sh7750_init(SuperHCPU *cpu, MemoryRegion *sysmem)
     cpu->env.intc_handle = &s->intc;
 
     /* SCI */
-    dev = qdev_new_orphan(TYPE_SH_SERIAL);
+    dev = qdev_new(parent, "sci", TYPE_SH_SERIAL);
     dev->id = g_strdup("sci");
     qdev_prop_set_chr(dev, "chardev", serial_hd(0));
     sb = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sb, &error_fatal);
+    sysbus_realize(sb, &error_fatal);
     sysbus_mmio_map(sb, 0, 0xffe00000);
     alias = g_malloc(sizeof(*alias));
     mr = sysbus_mmio_get_region(sb, 0);
@@ -779,12 +780,12 @@ SH7750State *sh7750_init(SuperHCPU *cpu, MemoryRegion *sysmem)
     qdev_connect_gpio_out_named(dev, "tei", 0, s->intc.irqs[SCI1_TEI]);
 
     /* SCIF */
-    dev = qdev_new_orphan(TYPE_SH_SERIAL);
+    dev = qdev_new(parent, "scif", TYPE_SH_SERIAL);
     dev->id = g_strdup("scif");
     qdev_prop_set_chr(dev, "chardev", serial_hd(1));
     qdev_prop_set_uint8(dev, "features", SH_SERIAL_FEAT_SCIF);
     sb = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(sb, &error_fatal);
+    sysbus_realize(sb, &error_fatal);
     sysbus_mmio_map(sb, 0, 0xffe80000);
     alias = g_malloc(sizeof(*alias));
     mr = sysbus_mmio_get_region(sb, 0);
diff --git a/include/hw/sh4/sh.h b/include/hw/sh4/sh.h
index c82feef8d0..b7ec234212 100644
--- a/include/hw/sh4/sh.h
+++ b/include/hw/sh4/sh.h
@@ -36,7 +36,8 @@
 /* sh7750.c */
 struct SH7750State;
 
-struct SH7750State *sh7750_init(SuperHCPU *cpu, MemoryRegion *sysmem);
+struct SH7750State *sh7750_init(Object *parent, SuperHCPU *cpu,
+                                MemoryRegion *sysmem);
 
 #define TYPE_SH_SERIAL "sh-serial"
 #define SH_SERIAL_FEAT_SCIF (1 << 0)
-- 
2.47.1


