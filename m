Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7327C44506
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigYs-0001PW-DK; Sat, 11 Jul 2026 18:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigYk-0001Gp-Hz; Sat, 11 Jul 2026 18:52:36 -0400
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.12.53.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigYh-0008Vj-Tn; Sat, 11 Jul 2026 18:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810351; x=1815346351;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=B23PwcG3rOHYutLOLYO8XYvVh6nIkH9whKtaeOA8vO8=;
 b=m7sg6si1aXEvalbByZ2Cbstq/TC/SmUA/EiFxHzMi/YSdaYSW2/H/+hD
 ZxV+lKFH9oglG4d8JxEcz3KoqPWUL7YKMhZZK2cAFXH5EaNFexAg9s8sx
 l125UGm+nTD42N4CY4PR92tFGXBXTiinxg+YUafPH3bOYmm9oazbAdPI0
 dqK3IrQh8SuGbDFlXFcgwMoy49arLFAUD2uEsM9MGpuN7ceYGS8Y7FwO+
 zVIS1dc/NspM2UAmGzua55QY05ipzHr5SGSC/MutHIJ+22tyr6tP1MtHq
 M0Ti622wL+b5p4kAL4HeDpma3YaK+s9ME5mTnJ36GN/HG4qWOI7bEI5Nf A==;
X-CSE-ConnectionGUID: E+W5oHfdSPCmt5fk3vE+tg==
X-CSE-MsgGUID: Dq0B/d0ASlCDh9uVDp1mfQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23369891"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:52:27 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:13433]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.54:2525]
 with esmtp (Farcaster)
 id a7ebf90f-50bb-48a2-9b9a-b8c2db68b363; Sat, 11 Jul 2026 22:52:27 +0000 (UTC)
X-Farcaster-Flow-ID: a7ebf90f-50bb-48a2-9b9a-b8c2db68b363
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:52:26 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:52:18 +0000
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
Subject: [RFC PATCH 058/134] hw/arm/xilinx-zynq: Give onboard devices a QOM
 parent
Date: Sat, 11 Jul 2026 22:35:51 +0000
Message-ID: <20260711223707.42139-59-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.12.53.23;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert the *_orphan() device-creation calls in the hw/arm xilinx-zynq
board files to the new parented API introduced earlier in this
series, so every onboard device gets a stable path in the
composition tree instead of landing in /machine/unattached with an
unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing SoC device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/arm/xilinx_zynq.c:113 | qdev_new | parent | "gem[*]" | thread Object *parent into gem_init(); board init callers pass OBJECT(machine); sysbus_realize
hw/arm/xilinx_zynq.c:134 | qdev_new | parent | is_qspi?"qspi":"spi[*]" | thread Object *parent into zynq_init_spi_flashes(); sysbus_realize
hw/arm/xilinx_zynq.c:155 | qdev_new | OBJECT(dev) | "flash[*]" | flash owned by SPI controller; qdev_realize
hw/arm/xilinx_zynq.c:198 | qdev_new | parent | "ddr-ctrl" | thread Object *parent into ddr_ctrl_init(); sysbus_realize
hw/arm/xilinx_zynq.c:259 | qdev_new | OBJECT(machine) | "slcr" | board init; sysbus_realize
hw/arm/xilinx_zynq.c:265 | qdev_new | OBJECT(machine) | "a9mpcore" | board init; sysbus_realize
hw/arm/xilinx_zynq.c:272 | sysbus_create_varargs | OBJECT(machine) | "l2x0" | board init; create_simple realizes internally
hw/arm/xilinx_zynq.c:290 | sysbus_create_simple | OBJECT(machine) | "usb[*]" | board init; two ChipIdea USB controllers
hw/arm/xilinx_zynq.c:291 | sysbus_create_simple | OBJECT(machine) | "usb[*]" | board init
hw/arm/xilinx_zynq.c:293 | qdev_new | OBJECT(machine) | "uart[*]" | board init; sysbus_realize
hw/arm/xilinx_zynq.c:301 | qdev_new | OBJECT(machine) | "uart[*]" | board init; sysbus_realize
hw/arm/xilinx_zynq.c:310 | sysbus_create_varargs | OBJECT(machine) | "ttc[*]" | board init; two Cadence TTCs
hw/arm/xilinx_zynq.c:312 | sysbus_create_varargs | OBJECT(machine) | "ttc[*]" | board init
hw/arm/xilinx_zynq.c:332 | qdev_new | OBJECT(machine) | "sdhci[*]" | board init loop; sysbus_realize
hw/arm/xilinx_zynq.c:341 | qdev_new | OBJECT(dev) | "sd-card" | card owned by its SDHCI controller; qdev_realize
hw/arm/xilinx_zynq.c:347 | qdev_new | OBJECT(machine) | "xadc" | board init; sysbus_realize
hw/arm/xilinx_zynq.c:352 | qdev_new | OBJECT(machine) | "dma" | board init pl330 DMA; sysbus_realize
hw/arm/xilinx_zynq.c:375 | qdev_new | OBJECT(machine) | "devcfg" | board init; sysbus_realize

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/xilinx_zynq.c | 92 ++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 42 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index ba00c5a3aa..378ab532a3 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -105,22 +105,23 @@ static void zynq_write_board_setup(ARMCPU *cpu,
 
 static struct arm_boot_info zynq_binfo = {};
 
-static void gem_init(uint32_t base, qemu_irq irq)
+static void gem_init(Object *parent, uint32_t base, qemu_irq irq)
 {
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new_orphan(TYPE_CADENCE_GEM);
+    dev = qdev_new(parent, "gem[*]", TYPE_CADENCE_GEM);
     qemu_configure_nic_device(dev, true, NULL);
     object_property_set_int(OBJECT(dev), "phy-addr", 7, &error_abort);
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     sysbus_mmio_map(s, 0, base);
     sysbus_connect_irq(s, 0, irq);
 }
 
-static inline int zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
-                                        bool is_qspi, int unit0)
+static inline int zynq_init_spi_flashes(Object *parent, uint32_t base_addr,
+                                        qemu_irq irq, bool is_qspi,
+                                        int unit0)
 {
     int unit = unit0;
     DeviceState *dev;
@@ -131,12 +132,13 @@ static inline int zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
     int num_busses =  is_qspi ? NUM_QSPI_BUSSES : 1;
     int num_ss = is_qspi ? NUM_QSPI_FLASHES : NUM_SPI_FLASHES;
 
-    dev = qdev_new_orphan(is_qspi ? "xlnx.ps7-qspi" : "xlnx.ps7-spi");
+    dev = qdev_new(parent, is_qspi ? "qspi" : "spi[*]",
+                   is_qspi ? "xlnx.ps7-qspi" : "xlnx.ps7-spi");
     qdev_prop_set_uint8(dev, "num-txrx-bytes", is_qspi ? 4 : 1);
     qdev_prop_set_uint8(dev, "num-ss-bits", num_ss);
     qdev_prop_set_uint8(dev, "num-busses", num_busses);
     busdev = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_realize(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, base_addr);
     if (is_qspi) {
         sysbus_mmio_map(busdev, 1, 0xFC000000);
@@ -152,14 +154,14 @@ static inline int zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
 
         for (j = 0; j < num_ss; ++j) {
             DriveInfo *dinfo = drive_get(IF_MTD, 0, unit++);
-            flash_dev = qdev_new_orphan("n25q128");
+            flash_dev = qdev_new(OBJECT(dev), "flash[*]", "n25q128");
             if (dinfo) {
                 qdev_prop_set_drive_err(flash_dev, "drive",
                                         blk_by_legacy_dinfo(dinfo),
                                         &error_fatal);
             }
             qdev_prop_set_uint8(flash_dev, "cs", j);
-            qdev_realize_and_unref(flash_dev, BUS(spi), &error_fatal);
+            qdev_realize(flash_dev, BUS(spi), &error_fatal);
 
             cs_line = qdev_get_gpio_in_named(flash_dev, SSI_GPIO_CS, 0);
             sysbus_connect_irq(busdev, i * num_ss + j + 1, cs_line);
@@ -190,14 +192,14 @@ static void zynq_set_boot_mode(Object *obj, const char *str,
     m->boot_mode = mode;
 }
 
-static void ddr_ctrl_init(uint32_t base)
+static void ddr_ctrl_init(Object *parent, uint32_t base)
 {
     DeviceState *dev;
     SysBusDevice *busdev;
 
-    dev = qdev_new_orphan("zynq.ddr-ctlr");
+    dev = qdev_new(parent, "ddr-ctrl", "zynq.ddr-ctlr");
     busdev = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_realize(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, base);
 }
 
@@ -256,20 +258,21 @@ static void zynq_init(MachineState *machine)
     clock_set_hz(zynq_machine->ps_clk, PS_CLK_FREQUENCY);
 
     /* Create slcr, keep a pointer to connect clocks */
-    slcr = qdev_new_orphan("xilinx-zynq_slcr");
+    slcr = qdev_new(OBJECT(machine), "slcr", "xilinx-zynq_slcr");
     qdev_connect_clock_in(slcr, "ps_clk", zynq_machine->ps_clk);
     qdev_prop_set_uint8(slcr, "boot-mode", zynq_machine->boot_mode);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(slcr), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(slcr), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
 
-    dev = qdev_new_orphan(TYPE_A9MPCORE_PRIV);
+    dev = qdev_new(OBJECT(machine), "a9mpcore", TYPE_A9MPCORE_PRIV);
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
     qdev_prop_set_uint32(dev, "num-irq", GIC_EXT_IRQS + GIC_INTERNAL);
     busdev = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_realize(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
     zynq_binfo.gic_cpu_if_addr = MPCORE_PERIPHBASE + 0x100;
-    sysbus_create_varargs_orphan("l2x0", MPCORE_PERIPHBASE + 0x2000, NULL);
+    sysbus_create_varargs(OBJECT(machine), "l2x0", "l2x0",
+                          MPCORE_PERIPHBASE + 0x2000, NULL);
     for (n = 0; n < smp_cpus; n++) {
         /* See "hw/intc/arm_gic.h" for the IRQ line association */
         DeviceState *cpudev = DEVICE(zynq_machine->cpu[n]);
@@ -283,39 +286,44 @@ static void zynq_init(MachineState *machine)
         pic[n] = qdev_get_gpio_in(dev, n);
     }
 
-    n = zynq_init_spi_flashes(0xE0006000, pic[58 - GIC_INTERNAL], false, 0);
-    n = zynq_init_spi_flashes(0xE0007000, pic[81 - GIC_INTERNAL], false, n);
-    n = zynq_init_spi_flashes(0xE000D000, pic[51 - GIC_INTERNAL], true, n);
+    n = zynq_init_spi_flashes(OBJECT(machine), 0xE0006000,
+                              pic[58 - GIC_INTERNAL], false, 0);
+    n = zynq_init_spi_flashes(OBJECT(machine), 0xE0007000,
+                              pic[81 - GIC_INTERNAL], false, n);
+    n = zynq_init_spi_flashes(OBJECT(machine), 0xE000D000,
+                              pic[51 - GIC_INTERNAL], true, n);
 
-    sysbus_create_simple_orphan(TYPE_CHIPIDEA, 0xE0002000, pic[53 - GIC_INTERNAL]);
-    sysbus_create_simple_orphan(TYPE_CHIPIDEA, 0xE0003000, pic[76 - GIC_INTERNAL]);
+    sysbus_create_simple(OBJECT(machine), "usb[*]", TYPE_CHIPIDEA,
+                         0xE0002000, pic[53 - GIC_INTERNAL]);
+    sysbus_create_simple(OBJECT(machine), "usb[*]", TYPE_CHIPIDEA,
+                         0xE0003000, pic[76 - GIC_INTERNAL]);
 
-    dev = qdev_new_orphan(TYPE_CADENCE_UART);
+    dev = qdev_new(OBJECT(machine), "uart[*]", TYPE_CADENCE_UART);
     busdev = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", serial_hd(0));
     qdev_connect_clock_in(dev, "refclk",
                           qdev_get_clock_out(slcr, "uart0_ref_clk"));
-    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_realize(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0xE0000000);
     sysbus_connect_irq(busdev, 0, pic[59 - GIC_INTERNAL]);
-    dev = qdev_new_orphan(TYPE_CADENCE_UART);
+    dev = qdev_new(OBJECT(machine), "uart[*]", TYPE_CADENCE_UART);
     busdev = SYS_BUS_DEVICE(dev);
     qdev_prop_set_chr(dev, "chardev", serial_hd(1));
     qdev_connect_clock_in(dev, "refclk",
                           qdev_get_clock_out(slcr, "uart1_ref_clk"));
-    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_realize(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0xE0001000);
     sysbus_connect_irq(busdev, 0, pic[82 - GIC_INTERNAL]);
 
-    sysbus_create_varargs_orphan("cadence_ttc", 0xF8001000,
+    sysbus_create_varargs(OBJECT(machine), "ttc[*]", "cadence_ttc", 0xF8001000,
             pic[42-GIC_INTERNAL], pic[43-GIC_INTERNAL], pic[44-GIC_INTERNAL], NULL);
-    sysbus_create_varargs_orphan("cadence_ttc", 0xF8002000,
+    sysbus_create_varargs(OBJECT(machine), "ttc[*]", "cadence_ttc", 0xF8002000,
             pic[69-GIC_INTERNAL], pic[70-GIC_INTERNAL], pic[71-GIC_INTERNAL], NULL);
 
-    ddr_ctrl_init(0xF8006000);
+    ddr_ctrl_init(OBJECT(machine), 0xF8006000);
 
-    gem_init(0xE000B000, pic[54 - GIC_INTERNAL]);
-    gem_init(0xE000C000, pic[77 - GIC_INTERNAL]);
+    gem_init(OBJECT(machine), 0xE000B000, pic[54 - GIC_INTERNAL]);
+    gem_init(OBJECT(machine), 0xE000C000, pic[77 - GIC_INTERNAL]);
 
     for (n = 0; n < 2; n++) {
         int hci_irq = n ? 79 : 56;
@@ -329,27 +337,27 @@ static void zynq_init(MachineState *machine)
          * - SDIO Specification Version 2.0
          * - MMC Specification Version 3.31
          */
-        dev = qdev_new_orphan(TYPE_SYSBUS_SDHCI);
+        dev = qdev_new(OBJECT(machine), "sdhci[*]", TYPE_SYSBUS_SDHCI);
         qdev_prop_set_uint8(dev, "sd-spec-version", 2);
         qdev_prop_set_uint64(dev, "capareg", ZYNQ_SDHCI_CAPABILITIES);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, hci_addr);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[hci_irq - GIC_INTERNAL]);
 
         di = drive_get(IF_SD, 0, n);
         blk = di ? blk_by_legacy_dinfo(di) : NULL;
-        carddev = qdev_new_orphan(TYPE_SD_CARD);
+        carddev = qdev_new(OBJECT(dev), "sd-card", TYPE_SD_CARD);
         qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
-        qdev_realize_and_unref(carddev, qdev_get_child_bus(dev, "sd-bus"),
-                               &error_fatal);
+        qdev_realize(carddev, qdev_get_child_bus(dev, "sd-bus"),
+                     &error_fatal);
     }
 
-    dev = qdev_new_orphan(TYPE_ZYNQ_XADC);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    dev = qdev_new(OBJECT(machine), "xadc", TYPE_ZYNQ_XADC);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xF8007100);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[39-GIC_INTERNAL]);
 
-    dev = qdev_new_orphan("pl330");
+    dev = qdev_new(OBJECT(machine), "dma", "pl330");
     object_property_set_link(OBJECT(dev), "memory",
                              OBJECT(address_space_mem),
                              &error_fatal);
@@ -365,16 +373,16 @@ static void zynq_init(MachineState *machine)
     qdev_prop_set_uint16(dev, "data_buffer_dep",  256);
 
     busdev = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_realize(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, 0xF8003000);
     sysbus_connect_irq(busdev, 0, pic[45-GIC_INTERNAL]); /* abort irq line */
     for (n = 0; n < ARRAY_SIZE(dma_irqs); ++n) { /* event irqs */
         sysbus_connect_irq(busdev, n + 1, pic[dma_irqs[n] - GIC_INTERNAL]);
     }
 
-    dev = qdev_new_orphan("xlnx.ps7-dev-cfg");
+    dev = qdev_new(OBJECT(machine), "devcfg", "xlnx.ps7-dev-cfg");
     busdev = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_realize(busdev, &error_fatal);
     sysbus_connect_irq(busdev, 0, pic[40 - GIC_INTERNAL]);
     sysbus_mmio_map(busdev, 0, 0xF8007000);
 
-- 
2.47.1


