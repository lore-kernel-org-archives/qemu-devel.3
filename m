Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14805C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigVZ-0002p8-SW; Sat, 11 Jul 2026 18:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigUz-0002TX-P3; Sat, 11 Jul 2026 18:48:48 -0400
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.245.243.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigUs-0007hI-ND; Sat, 11 Jul 2026 18:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810114; x=1815346114;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8KkhcGyYmg0+jThLKAxCQ7nWBS2kSIXd0k39qM9FEew=;
 b=sC33+53RdIOE5FfYAvgAz9rvOe96qTsTfAIjYsWfVyZfN/gcL/HVZCAH
 oJybLiP4WhS2vgyLXDToXq8+qRpnjzzsZ5kFAUmOARW6W6b6l38927v5b
 yAYY2daahL6YCVeO+qfZb5xyFT8Dz5AS2HjwJiMdepMF8MZkUh5dUaQa0
 HVzev3d7pNveiUWo9G5P87ELAVqJNc/xZEnDN2CbpilwUMVXs4a5ZnSo0
 O1V8dSfwB41KXPn17JW/vPCwLG+8375Zh2vcFSm5zxUyEvwmMjhctkQDb
 XkZe+PaomGo3rFNEahSpOu7kGYyDk/yUyzYchSRhQTzr961+PecoAT/n2 Q==;
X-CSE-ConnectionGUID: H7N00OZKQcOM+AmKb7jJeQ==
X-CSE-MsgGUID: tpFFSFlLRQepVsdEn5Ff8A==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="22997528"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:48:29 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:17675]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.214:2525]
 with esmtp (Farcaster)
 id 994473be-6809-44dd-ad88-b5ecf0ca075d; Sat, 11 Jul 2026 22:48:29 +0000 (UTC)
X-Farcaster-Flow-ID: 994473be-6809-44dd-ad88-b5ecf0ca075d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:48:29 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:48:20 +0000
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
Subject: [RFC PATCH 043/134] hw/sparc: Give onboard devices a QOM parent
Date: Sat, 11 Jul 2026 22:35:36 +0000
Message-ID: <20260711223707.42139-44-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
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

Convert the *_orphan() device-creation calls in hw/sparc to the new
parented API introduced earlier in this series, so every onboard
device gets a stable path in the composition tree instead of landing
in /machine/unattached with an unstable device[N] name.

The parent for each device is the object that owns its lifetime: the
machine for board-created devices, the containing device for
composite children.  Names follow existing QOM conventions.

Per-site rationale (reviewers: dispute the modeling here):

hw/sparc/leon3.c:295 | qdev_new | OBJECT(machine) | "ahb-pnp" | leon3_generic_hw_init() board init
hw/sparc/leon3.c:302 | qdev_new | OBJECT(machine) | "apb-pnp" | leon3_generic_hw_init() board init
hw/sparc/leon3.c:310 | qdev_new | OBJECT(machine) | "irqmp" | leon3_generic_hw_init() board init
hw/sparc/leon3.c:409 | qdev_new | OBJECT(machine) | "gptimer" | leon3_generic_hw_init() board init
hw/sparc/leon3.c:426 | qdev_new | OBJECT(machine) | "uart" | leon3_generic_hw_init() board init
hw/sparc/sun4m.c:283 | qdev_new | parent | "iommu" | iommu_init() helper: thread Object *parent from board init
hw/sparc/sun4m.c:305 | qdev_new | parent | "dma" | sparc32_dma_init() helper: thread Object *parent from board init
hw/sparc/sun4m.c:350 | qdev_new | parent | "intctl" | slavio_intctl_init() helper: thread Object *parent from board init
hw/sparc/sun4m.c:379 | qdev_new | parent | "timer" | slavio_timer_init_all() helper: thread Object *parent from board init
hw/sparc/sun4m.c:417 | qdev_new | parent | "misc" | slavio_misc_init() helper: thread Object *parent from board init
hw/sparc/sun4m.c:454 | qdev_new | parent | "ecc" | ecc_init() helper: thread Object *parent from board init
hw/sparc/sun4m.c:470 | qdev_new | parent | "apc" | apc_init() helper: thread Object *parent from board init
hw/sparc/sun4m.c:484 | qdev_new | parent | "tcx" | tcx_init() helper: thread Object *parent from board init
hw/sparc/sun4m.c:536 | qdev_new | parent | "cgthree" | cg3_init() helper: thread Object *parent from board init
hw/sparc/sun4m.c:565 | qdev_new | parent | "idreg" | idreg_init() helper: thread Object *parent from board init
hw/sparc/sun4m.c:624 | qdev_new | parent | "afx" | afx_init() helper: thread Object *parent from board init
hw/sparc/sun4m.c:681 | qdev_new | parent | "prom" | prom_init() helper: thread Object *parent from board init
hw/sparc/sun4m.c:838 | qdev_new | OBJECT(machine) | "ram" | sun4m_hw_init() board init
hw/sparc/sun4m.c:950 | qdev_new | OBJECT(machine) | "nvram" | sun4m_hw_init() board init
hw/sparc/sun4m.c:962 | qdev_new | OBJECT(machine) | "escc-kbd" | sun4m_hw_init() board init; keyboard/mouse ESCC
hw/sparc/sun4m.c:975 | qdev_new | OBJECT(machine) | "ms-kb-orgate" | sun4m_hw_init() board init; drop _and_unref
hw/sparc/sun4m.c:982 | qdev_new | OBJECT(machine) | "escc-serial" | sun4m_hw_init() board init; serial ESCC
hw/sparc/sun4m.c:996 | qdev_new | OBJECT(machine) | "serial-orgate" | sun4m_hw_init() board init; drop _and_unref
hw/sparc/sun4m.c:1022 | sysbus_create_simple | OBJECT(machine) | "cs4231" | sun4m_hw_init() board init
hw/sparc/sun4m.c:1055 | qdev_new | OBJECT(machine) | TYPE_FW_CFG | collapse existing object_property_add_child(); keep name; drop _and_unref

Link: https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/
Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/sparc/leon3.c |  22 ++++----
 hw/sparc/sun4m.c | 142 ++++++++++++++++++++++++-----------------------
 2 files changed, 85 insertions(+), 79 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index d921cd8dc6..a96ccca8e3 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -292,25 +292,27 @@ static void leon3_generic_hw_init(MachineState *machine)
         qemu_register_reset(leon3_cpu_reset, &reset_info->info[i]);
     }
 
-    ahb_pnp = GRLIB_AHB_PNP(qdev_new_orphan(TYPE_GRLIB_AHB_PNP));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(ahb_pnp), &error_fatal);
+    ahb_pnp = GRLIB_AHB_PNP(qdev_new(OBJECT(machine), "ahb-pnp",
+                                     TYPE_GRLIB_AHB_PNP));
+    sysbus_realize(SYS_BUS_DEVICE(ahb_pnp), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(ahb_pnp), 0, LEON3_AHB_PNP_OFFSET);
     grlib_ahb_pnp_add_entry(ahb_pnp, 0, 0, GRLIB_VENDOR_GAISLER,
                             GRLIB_LEON3_DEV, GRLIB_AHB_MASTER,
                             GRLIB_CPU_AREA);
 
-    apb_pnp = GRLIB_APB_PNP(qdev_new_orphan(TYPE_GRLIB_APB_PNP));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(apb_pnp), &error_fatal);
+    apb_pnp = GRLIB_APB_PNP(qdev_new(OBJECT(machine), "apb-pnp",
+                                     TYPE_GRLIB_APB_PNP));
+    sysbus_realize(SYS_BUS_DEVICE(apb_pnp), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(apb_pnp), 0, LEON3_APB_PNP_OFFSET);
     grlib_ahb_pnp_add_entry(ahb_pnp, LEON3_APB_PNP_OFFSET, 0xFFF,
                             GRLIB_VENDOR_GAISLER, GRLIB_APBMST_DEV,
                             GRLIB_AHB_SLAVE, GRLIB_AHBMEM_AREA);
 
     /* Allocate IRQ manager */
-    irqmpdev = qdev_new_orphan(TYPE_GRLIB_IRQMP);
+    irqmpdev = qdev_new(OBJECT(machine), "irqmp", TYPE_GRLIB_IRQMP);
     object_property_set_int(OBJECT(irqmpdev), "ncpus", machine->smp.cpus,
                             &error_fatal);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
 
     for (i = 0; i < machine->smp.cpus; i++) {
         cpu = reset_info->info[i].cpu;
@@ -406,11 +408,11 @@ static void leon3_generic_hw_init(MachineState *machine)
     }
 
     /* Allocate timers */
-    dev = qdev_new_orphan(TYPE_GRLIB_GPTIMER);
+    dev = qdev_new(OBJECT(machine), "gptimer", TYPE_GRLIB_GPTIMER);
     qdev_prop_set_uint32(dev, "nr-timers", LEON3_TIMER_COUNT);
     qdev_prop_set_uint32(dev, "frequency", CPU_CLK);
     qdev_prop_set_uint32(dev, "irq-line", LEON3_TIMER_IRQ);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_TIMER_OFFSET);
     for (i = 0; i < LEON3_TIMER_COUNT; i++) {
@@ -423,9 +425,9 @@ static void leon3_generic_hw_init(MachineState *machine)
                             0, LEON3_TIMER_IRQ, GRLIB_APBIO_AREA);
 
     /* Allocate uart */
-    dev = qdev_new_orphan(TYPE_GRLIB_APB_UART);
+    dev = qdev_new(OBJECT(machine), "uart", TYPE_GRLIB_APB_UART);
     qdev_prop_set_chr(dev, "chrdev", serial_hd(0));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_UART_OFFSET);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(irqmpdev, LEON3_UART_IRQ));
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 52627dbdec..b0f018a3c5 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -275,22 +275,23 @@ static unsigned long sun4m_load_kernel(const char *kernel_filename,
     return kernel_size;
 }
 
-static void *iommu_init(hwaddr addr, uint32_t version, qemu_irq irq)
+static void *iommu_init(Object *parent, hwaddr addr, uint32_t version,
+                        qemu_irq irq)
 {
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new_orphan(TYPE_SUN4M_IOMMU);
+    dev = qdev_new(parent, "iommu", TYPE_SUN4M_IOMMU);
     qdev_prop_set_uint32(dev, "version", version);
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     sysbus_connect_irq(s, 0, irq);
     sysbus_mmio_map(s, 0, addr);
 
     return s;
 }
 
-static void *sparc32_dma_init(hwaddr dma_base,
+static void *sparc32_dma_init(Object *parent, hwaddr dma_base,
                               hwaddr esp_base, qemu_irq espdma_irq,
                               hwaddr le_base, qemu_irq ledma_irq,
                               MACAddr *mac)
@@ -302,7 +303,7 @@ static void *sparc32_dma_init(hwaddr dma_base,
     SysBusPCNetState *lance;
     NICInfo *nd = qemu_find_nic_info("lance", true, NULL);
 
-    dma = qdev_new_orphan(TYPE_SPARC32_DMA);
+    dma = qdev_new(parent, "dma", TYPE_SPARC32_DMA);
     espdma = SPARC32_ESPDMA_DEVICE(object_resolve_path_component(
                                    OBJECT(dma), "espdma"));
 
@@ -322,7 +323,7 @@ static void *sparc32_dma_init(hwaddr dma_base,
         qdev_prop_set_macaddr(DEVICE(lance), "mac", mac->a);
     }
 
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dma), &error_fatal);
 
     sysbus_connect_irq(SYS_BUS_DEVICE(espdma), 0, espdma_irq);
 
@@ -338,7 +339,7 @@ static void *sparc32_dma_init(hwaddr dma_base,
     return dma;
 }
 
-static DeviceState *slavio_intctl_init(hwaddr addr,
+static DeviceState *slavio_intctl_init(Object *parent, hwaddr addr,
                                        hwaddr addrg,
                                        unsigned int smp_cpus,
                                        DeviceState **cpus)
@@ -347,10 +348,10 @@ static DeviceState *slavio_intctl_init(hwaddr addr,
     SysBusDevice *s;
     unsigned int i, j;
 
-    dev = qdev_new_orphan("slavio_intctl");
+    dev = qdev_new(parent, "intctl", "slavio_intctl");
 
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
 
     for (i = 0; i < smp_cpus; i++) {
         for (j = 0; j < MAX_PILS; j++) {
@@ -369,17 +370,18 @@ static DeviceState *slavio_intctl_init(hwaddr addr,
 #define SYS_TIMER_OFFSET      0x10000ULL
 #define CPU_TIMER_OFFSET(cpu) (0x1000ULL * cpu)
 
-static void slavio_timer_init_all(hwaddr addr, qemu_irq master_irq,
+static void slavio_timer_init_all(Object *parent, hwaddr addr,
+                                  qemu_irq master_irq,
                                   qemu_irq *cpu_irqs, unsigned int num_cpus)
 {
     DeviceState *dev;
     SysBusDevice *s;
     unsigned int i;
 
-    dev = qdev_new_orphan("slavio_timer");
+    dev = qdev_new(parent, "timer", "slavio_timer");
     qdev_prop_set_uint32(dev, "num_cpus", num_cpus);
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     sysbus_connect_irq(s, 0, master_irq);
     sysbus_mmio_map(s, 0, addr + SYS_TIMER_OFFSET);
 
@@ -406,7 +408,7 @@ static Notifier slavio_system_powerdown_notifier = {
 #define MISC_MDM  0x01b00000
 #define MISC_SYS  0x01f00000
 
-static void slavio_misc_init(hwaddr base,
+static void slavio_misc_init(Object *parent, hwaddr base,
                              hwaddr aux1_base,
                              hwaddr aux2_base, qemu_irq irq,
                              qemu_irq fdc_tc)
@@ -414,9 +416,9 @@ static void slavio_misc_init(hwaddr base,
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new_orphan("slavio_misc");
+    dev = qdev_new(parent, "misc", "slavio_misc");
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     if (base) {
         /* 8 bit registers */
         /* Slavio control */
@@ -446,15 +448,16 @@ static void slavio_misc_init(hwaddr base,
     qemu_register_powerdown_notifier(&slavio_system_powerdown_notifier);
 }
 
-static void ecc_init(hwaddr base, qemu_irq irq, uint32_t version)
+static void ecc_init(Object *parent, hwaddr base, qemu_irq irq,
+                     uint32_t version)
 {
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new_orphan("eccmemctl");
+    dev = qdev_new(parent, "ecc", "eccmemctl");
     qdev_prop_set_uint32(dev, "version", version);
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     sysbus_connect_irq(s, 0, irq);
     sysbus_mmio_map(s, 0, base);
     if (version == 0) { // SS-600MP only
@@ -462,32 +465,32 @@ static void ecc_init(hwaddr base, qemu_irq irq, uint32_t version)
     }
 }
 
-static void apc_init(hwaddr power_base, qemu_irq cpu_halt)
+static void apc_init(Object *parent, hwaddr power_base, qemu_irq cpu_halt)
 {
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new_orphan("apc");
+    dev = qdev_new(parent, "apc", "apc");
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     /* Power management (APC) XXX: not a Slavio device */
     sysbus_mmio_map(s, 0, power_base);
     sysbus_connect_irq(s, 0, cpu_halt);
 }
 
-static void tcx_init(hwaddr addr, qemu_irq irq, int vram_size, int width,
-                     int height, int depth)
+static void tcx_init(Object *parent, hwaddr addr, qemu_irq irq, int vram_size,
+                     int width, int height, int depth)
 {
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new_orphan("sun-tcx");
+    dev = qdev_new(parent, "tcx", "sun-tcx");
     qdev_prop_set_uint32(dev, "vram_size", vram_size);
     qdev_prop_set_uint16(dev, "width", width);
     qdev_prop_set_uint16(dev, "height", height);
     qdev_prop_set_uint16(dev, "depth", depth);
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
 
     /* 10/ROM : FCode ROM */
     sysbus_mmio_map(s, 0, addr);
@@ -527,19 +530,19 @@ static void tcx_init(hwaddr addr, qemu_irq irq, int vram_size, int width,
     sysbus_connect_irq(s, 0, irq);
 }
 
-static void cg3_init(hwaddr addr, qemu_irq irq, int vram_size, int width,
-                     int height, int depth)
+static void cg3_init(Object *parent, hwaddr addr, qemu_irq irq, int vram_size,
+                     int width, int height, int depth)
 {
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new_orphan("cgthree");
+    dev = qdev_new(parent, "cgthree", "cgthree");
     qdev_prop_set_uint32(dev, "vram-size", vram_size);
     qdev_prop_set_uint16(dev, "width", width);
     qdev_prop_set_uint16(dev, "height", height);
     qdev_prop_set_uint16(dev, "depth", depth);
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
 
     /* FCode ROM */
     sysbus_mmio_map(s, 0, addr);
@@ -557,14 +560,14 @@ static void cg3_init(hwaddr addr, qemu_irq irq, int vram_size, int width,
 
 static const uint8_t idreg_data[] = { 0xfe, 0x81, 0x01, 0x03 };
 
-static void idreg_init(hwaddr addr)
+static void idreg_init(Object *parent, hwaddr addr)
 {
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new_orphan(TYPE_MACIO_ID_REGISTER);
+    dev = qdev_new(parent, "idreg", TYPE_MACIO_ID_REGISTER);
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
 
     sysbus_mmio_map(s, 0, addr);
     address_space_write_rom(&address_space_memory, addr,
@@ -616,14 +619,14 @@ struct AFXState {
 };
 
 /* SS-5 TCX AFX register */
-static void afx_init(hwaddr addr)
+static void afx_init(Object *parent, hwaddr addr)
 {
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_new_orphan(TYPE_TCX_AFX);
+    dev = qdev_new(parent, "afx", TYPE_TCX_AFX);
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
 
     sysbus_mmio_map(s, 0, addr);
 }
@@ -671,16 +674,16 @@ static uint64_t translate_prom_address(void *opaque, uint64_t addr)
     return addr + *base_addr - PROM_VADDR;
 }
 
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
 
@@ -835,9 +838,9 @@ static void sun4m_hw_init(MachineState *machine)
     }
 
     /* Create and map RAM frontend */
-    dev = qdev_new_orphan("memory");
+    dev = qdev_new(OBJECT(machine), "ram", "memory");
     object_property_set_link(OBJECT(dev), "memdev", OBJECT(ram_memdev), &error_fatal);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0);
 
     /* models without ECC don't trap when missing ram is accessed */
@@ -846,9 +849,9 @@ static void sun4m_hw_init(MachineState *machine)
                         hwdef->max_mem - machine->ram_size);
     }
 
-    prom_init(hwdef->slavio_base, machine->firmware);
+    prom_init(OBJECT(machine), hwdef->slavio_base, machine->firmware);
 
-    slavio_intctl = slavio_intctl_init(hwdef->intctl_base,
+    slavio_intctl = slavio_intctl_init(OBJECT(machine), hwdef->intctl_base,
                                        hwdef->intctl_base + 0x10000ULL,
                                        smp_cpus,
                                        cpus);
@@ -861,14 +864,15 @@ static void sun4m_hw_init(MachineState *machine)
     }
 
     if (hwdef->idreg_base) {
-        idreg_init(hwdef->idreg_base);
+        idreg_init(OBJECT(machine), hwdef->idreg_base);
     }
 
     if (hwdef->afx_base) {
-        afx_init(hwdef->afx_base);
+        afx_init(OBJECT(machine), hwdef->afx_base);
     }
 
-    iommu_init(hwdef->iommu_base, hwdef->iommu_version, slavio_irq[30]);
+    iommu_init(OBJECT(machine), hwdef->iommu_base, hwdef->iommu_version,
+               slavio_irq[30]);
 
     if (hwdef->iommu_pad_base) {
         /* On the real hardware (SS-5, LX) the MMU is not padded, but aliased.
@@ -879,7 +883,7 @@ static void sun4m_hw_init(MachineState *machine)
                         hwdef->iommu_pad_base, hwdef->iommu_pad_len);
     }
 
-    sparc32_dma_init(hwdef->dma_base,
+    sparc32_dma_init(OBJECT(machine), hwdef->dma_base,
                      hwdef->esp_base, slavio_irq[18],
                      hwdef->le_base, slavio_irq[16], &hostid);
 
@@ -911,7 +915,7 @@ static void sun4m_hw_init(MachineState *machine)
             }
 
             /* sbus irq 5 */
-            cg3_init(hwdef->tcx_base, slavio_irq[11], 0x00100000,
+            cg3_init(OBJECT(machine), hwdef->tcx_base, slavio_irq[11], 0x00100000,
                      graphic_width, graphic_height, graphic_depth);
             vga_interface_created = true;
         } else {
@@ -927,7 +931,7 @@ static void sun4m_hw_init(MachineState *machine)
                 exit(1);
             }
 
-            tcx_init(hwdef->tcx_base, slavio_irq[11], 0x00100000,
+            tcx_init(OBJECT(machine), hwdef->tcx_base, slavio_irq[11], 0x00100000,
                      graphic_width, graphic_height, graphic_depth);
             vga_interface_created = true;
         }
@@ -947,19 +951,20 @@ static void sun4m_hw_init(MachineState *machine)
         create_unimplemented_device("sun-sx", hwdef->sx_base, 0x2000);
     }
 
-    dev = qdev_new_orphan("sysbus-m48t08");
+    dev = qdev_new(OBJECT(machine), "nvram", "sysbus-m48t08");
     qdev_prop_set_int32(dev, "base-year", 1968);
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     sysbus_connect_irq(s, 0, slavio_irq[0]);
     sysbus_mmio_map(s, 0, hwdef->nvram_base);
     nvram = NVRAM(dev);
 
-    slavio_timer_init_all(hwdef->counter_base, slavio_irq[19], slavio_cpu_irq, smp_cpus);
+    slavio_timer_init_all(OBJECT(machine), hwdef->counter_base, slavio_irq[19],
+                          slavio_cpu_irq, smp_cpus);
 
     /* Slavio TTYA (base+4, Linux ttyS0) is the first QEMU serial device
        Slavio TTYB (base+0, Linux ttyS1) is the second QEMU serial device */
-    dev = qdev_new_orphan(TYPE_ESCC);
+    dev = qdev_new(OBJECT(machine), "escc-kbd", TYPE_ESCC);
     qdev_prop_set_uint32(dev, "disabled", !machine->enable_graphics);
     qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK);
     qdev_prop_set_uint32(dev, "it_shift", 1);
@@ -968,18 +973,18 @@ static void sun4m_hw_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "chnBtype", escc_mouse);
     qdev_prop_set_uint32(dev, "chnAtype", escc_kbd);
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     sysbus_mmio_map(s, 0, hwdef->ms_kb_base);
 
     /* Logically OR both its IRQs together */
-    ms_kb_orgate = qdev_new_orphan(TYPE_OR_IRQ);
+    ms_kb_orgate = qdev_new(OBJECT(machine), "ms-kb-orgate", TYPE_OR_IRQ);
     object_property_set_int(OBJECT(ms_kb_orgate), "num-lines", 2, &error_fatal);
-    qdev_realize_and_unref(ms_kb_orgate, NULL, &error_fatal);
+    qdev_realize(ms_kb_orgate, NULL, &error_fatal);
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(ms_kb_orgate, 0));
     sysbus_connect_irq(s, 1, qdev_get_gpio_in(ms_kb_orgate, 1));
     qdev_connect_gpio_out(ms_kb_orgate, 0, slavio_irq[14]);
 
-    dev = qdev_new_orphan(TYPE_ESCC);
+    dev = qdev_new(OBJECT(machine), "escc-serial", TYPE_ESCC);
     qdev_prop_set_uint32(dev, "disabled", 0);
     qdev_prop_set_uint32(dev, "frequency", ESCC_CLOCK);
     qdev_prop_set_uint32(dev, "it_shift", 1);
@@ -989,20 +994,21 @@ static void sun4m_hw_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
 
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     sysbus_mmio_map(s, 0, hwdef->serial_base);
 
     /* Logically OR both its IRQs together */
-    serial_orgate = qdev_new_orphan(TYPE_OR_IRQ);
+    serial_orgate = qdev_new(OBJECT(machine), "serial-orgate", TYPE_OR_IRQ);
     object_property_set_int(OBJECT(serial_orgate), "num-lines", 2,
                             &error_fatal);
-    qdev_realize_and_unref(serial_orgate, NULL, &error_fatal);
+    qdev_realize(serial_orgate, NULL, &error_fatal);
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(serial_orgate, 0));
     sysbus_connect_irq(s, 1, qdev_get_gpio_in(serial_orgate, 1));
     qdev_connect_gpio_out(serial_orgate, 0, slavio_irq[15]);
 
     if (hwdef->apc_base) {
-        apc_init(hwdef->apc_base, qemu_allocate_irq(cpu_halt_signal, NULL, 0));
+        apc_init(OBJECT(machine), hwdef->apc_base,
+                 qemu_allocate_irq(cpu_halt_signal, NULL, 0));
     }
 
     if (hwdef->fd_base) {
@@ -1015,12 +1021,12 @@ static void sun4m_hw_init(MachineState *machine)
         fdc_tc = qemu_allocate_irq(dummy_fdc_tc, NULL, 0);
     }
 
-    slavio_misc_init(hwdef->slavio_base, hwdef->aux1_base, hwdef->aux2_base,
-                     slavio_irq[30], fdc_tc);
+    slavio_misc_init(OBJECT(machine), hwdef->slavio_base, hwdef->aux1_base,
+                     hwdef->aux2_base, slavio_irq[30], fdc_tc);
 
     if (hwdef->cs_base) {
-        sysbus_create_simple_orphan("sun-CS4231", hwdef->cs_base,
-                             slavio_irq[5]);
+        sysbus_create_simple(OBJECT(machine), "cs4231", "sun-CS4231",
+                             hwdef->cs_base, slavio_irq[5]);
     }
 
     if (hwdef->dbri_base) {
@@ -1049,17 +1055,15 @@ static void sun4m_hw_init(MachineState *machine)
                hwdef->nvram_machine_id, "Sun4m");
 
     if (hwdef->ecc_base)
-        ecc_init(hwdef->ecc_base, slavio_irq[28],
+        ecc_init(OBJECT(machine), hwdef->ecc_base, slavio_irq[28],
                  hwdef->ecc_version);
 
-    dev = qdev_new_orphan(TYPE_FW_CFG_MEM);
+    dev = qdev_new(OBJECT(machine), TYPE_FW_CFG, TYPE_FW_CFG_MEM);
     fw_cfg = FW_CFG(dev);
     qdev_prop_set_uint32(dev, "data_width", 1);
     qdev_prop_set_bit(dev, "dma_enabled", false);
-    object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
-                              OBJECT(fw_cfg));
     s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
+    sysbus_realize(s, &error_fatal);
     sysbus_mmio_map(s, 0, CFG_ADDR);
     sysbus_mmio_map(s, 1, CFG_ADDR + 2);
 
-- 
2.47.1


