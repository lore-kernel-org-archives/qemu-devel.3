Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B82C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wighy-0004HI-Ra; Sat, 11 Jul 2026 19:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wighw-0004Ew-TP; Sat, 11 Jul 2026 19:02:04 -0400
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([44.246.77.92])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wighs-0002V9-Hh; Sat, 11 Jul 2026 19:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810920; x=1815346920;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NZAkmR9DgASiSiF7oiWZArJziZLnM9FMZOPtI4sVT+Y=;
 b=b1lMTitP5khYuHfe3KmPOgWMK52qlY3f1rJYDv0ICRcBeNyA2FN3TqO/
 oRQG9dHTjWlmwdFESpngE8XyjxqaPPTiV0+EA/vgdi11xzix7VaqvD03e
 VZl0hVtOaYmXlq2dXdf33cg4d0zsEXSLvdUXGkbNq7JzDARyPBEZBrgQ9
 YYxOKwFauwiKIA6feSF9ssCZlLmMLRksu1auwzKjTWhc4sqrn715Lz4+G
 5BpfpxAyowT0qO5LfhZMPgrQU+1cuWqTU71pFm5mc36+4S8CG76vSaR5I
 0wUfUzzlM1YP0YKVJGdAc9TUyPXmgf7zQf9vrnXWnCz0YWO3pV18LT5e6 g==;
X-CSE-ConnectionGUID: prJRftq2QLC4/KPbXqCdzg==
X-CSE-MsgGUID: CO5UNAu3TtK6lIPxombkJA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23493313"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:01:56 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:31437]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.68:2525]
 with esmtp (Farcaster)
 id 96603ab5-59f3-4931-8bb8-5c40a0523f7c; Sat, 11 Jul 2026 23:01:56 +0000 (UTC)
X-Farcaster-Flow-ID: 96603ab5-59f3-4931-8bb8-5c40a0523f7c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:01:56 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:01:47 +0000
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
Subject: [RFC PATCH 094/134] hw/arm: Give memory regions an explicit owner
Date: Sat, 11 Jul 2026 22:36:27 +0000
Message-ID: <20260711223707.42139-95-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
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

Convert memory_region_init*() calls that pass NULL owner to pass
the enclosing SoC device or machine instead.

Static helpers make_ram()/make_ram_alias() in mps2.c and mps2-tz.c,
create_tag_ram() in virt.c, and exynos4_boards_init_ram() gain an
Object *owner first argument. armsse.c:make_alias() and
aspeed_install_boot_rom() already carry a QOM-derived first
argument; use it.

hw/arm/omap1.c is handled in a separate commit as its 20+ non-QOM
sub-init helpers all need owner threading.

No functional change intended.

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/arm/armsse.c            |  8 ++++----
 hw/arm/aspeed.c            |  2 +-
 hw/arm/aspeed_soc_common.c |  2 +-
 hw/arm/exynos4210.c        |  2 +-
 hw/arm/exynos4_boards.c    |  8 ++++----
 hw/arm/fsl-imx25.c         |  2 +-
 hw/arm/fsl-imx31.c         |  2 +-
 hw/arm/fsl-imx6.c          |  2 +-
 hw/arm/fsl-imx6ul.c        |  2 +-
 hw/arm/fsl-imx7.c          |  8 ++++----
 hw/arm/imx25_pdk.c         |  2 +-
 hw/arm/integratorcp.c      |  2 +-
 hw/arm/kzm.c               |  2 +-
 hw/arm/max78000_soc.c      |  2 +-
 hw/arm/mps2-tz.c           |  9 +++++----
 hw/arm/mps2.c              | 33 +++++++++++++++++----------------
 hw/arm/mps3r.c             |  4 ++--
 hw/arm/msf2-soc.c          |  2 +-
 hw/arm/msf2-som.c          |  2 +-
 hw/arm/musca.c             |  4 ++--
 hw/arm/musicpal.c          |  2 +-
 hw/arm/omap_sx1.c          | 14 +++++++-------
 hw/arm/realview.c          |  8 ++++----
 hw/arm/sbsa-ref.c          |  2 +-
 hw/arm/stellaris.c         |  4 ++--
 hw/arm/stm32f100_soc.c     |  2 +-
 hw/arm/stm32f205_soc.c     |  2 +-
 hw/arm/stm32f405_soc.c     |  4 ++--
 hw/arm/vexpress.c          |  8 ++++----
 hw/arm/virt.c              | 13 +++++++------
 hw/arm/xilinx_zynq.c       |  2 +-
 hw/arm/xlnx-zynqmp.c       |  2 +-
 32 files changed, 83 insertions(+), 80 deletions(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index ddb210c895..81895ad370 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -620,7 +620,7 @@ static uint32_t armsse_sys_config_value(ARMSSE *s, const ARMSSEInfo *info)
 static void make_alias(ARMSSE *s, MemoryRegion *mr, MemoryRegion *container,
                        const char *name, hwaddr base, hwaddr size, hwaddr orig)
 {
-    memory_region_init_alias(mr, NULL, name, container, orig, size);
+    memory_region_init_alias(mr, OBJECT(s), name, container, orig, size);
     /* The alias is even lower priority than unimplemented_device regions */
     memory_region_add_subregion_overlap(container, base, mr, -1500);
 }
@@ -1161,7 +1161,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         SysBusDevice *sbd_mpc;
         uint32_t sram_bank_size = 1 << s->sram_addr_width;
 
-        memory_region_init_ram(&s->sram[i], NULL, ramname,
+        memory_region_init_ram(&s->sram[i], OBJECT(dev), ramname,
                                sram_bank_size, errp);
         g_free(ramname);
         if (*errp) {
@@ -1226,11 +1226,11 @@ static void armsse_realize(DeviceState *dev, Error **errp)
 
     if (info->has_tcms) {
         /* The SSE-300 has an ITCM at 0x0000_0000 and a DTCM at 0x2000_0000 */
-        memory_region_init_ram(&s->itcm, NULL, "sse300-itcm", 512 * KiB, errp);
+        memory_region_init_ram(&s->itcm, OBJECT(dev), "sse300-itcm", 512 * KiB, errp);
         if (*errp) {
             return;
         }
-        memory_region_init_ram(&s->dtcm, NULL, "sse300-dtcm", 512 * KiB, errp);
+        memory_region_init_ram(&s->dtcm, OBJECT(dev), "sse300-dtcm", 512 * KiB, errp);
         if (*errp) {
             return;
         }
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 2e76e09f8f..f9249a9851 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -201,7 +201,7 @@ static void aspeed_machine_init(MachineState *machine)
     if (machine->kernel_filename && sc->num_cpus > 1) {
         /* With no u-boot we must set up a boot stub for the secondary CPU */
         MemoryRegion *smpboot = g_new(MemoryRegion, 1);
-        memory_region_init_ram(smpboot, NULL, "aspeed.smpboot",
+        memory_region_init_ram(smpboot, OBJECT(bmc), "aspeed.smpboot",
                                0x80, &error_abort);
         memory_region_add_subregion(get_system_memory(),
                                     AST_SMP_MAILBOX_BASE, smpboot);
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index 780a9659cc..c79b27c561 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -177,7 +177,7 @@ void aspeed_install_boot_rom(AspeedSoCState *soc, BlockBackend *blk,
 {
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(soc);
 
-    memory_region_init_rom(boot_rom, NULL, "aspeed.boot_rom", rom_size,
+    memory_region_init_rom(boot_rom, OBJECT(soc), "aspeed.boot_rom", rom_size,
                            &error_abort);
     memory_region_add_subregion_overlap(&soc->spi_boot_container, 0,
                                         boot_rom, 1);
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 74ce36c1e6..676915e814 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -660,7 +660,7 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
                                 &s->irom_alias_mem);
 
     /* Internal RAM */
-    memory_region_init_ram(&s->iram_mem, NULL, "exynos4210.iram",
+    memory_region_init_ram(&s->iram_mem, OBJECT(socdev), "exynos4210.iram",
                            EXYNOS4210_IRAM_SIZE, &error_fatal);
     memory_region_add_subregion(system_mem, EXYNOS4210_IRAM_BASE_ADDR,
                                 &s->iram_mem);
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index dce2c24860..8430317815 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -88,14 +88,14 @@ static void lan9215_init(uint32_t base, qemu_irq irq)
     }
 }
 
-static void exynos4_boards_init_ram(Exynos4BoardState *s,
+static void exynos4_boards_init_ram(Object *owner, Exynos4BoardState *s,
                                     MemoryRegion *system_mem,
                                     unsigned long ram_size)
 {
     unsigned long mem_size = ram_size;
 
     if (mem_size > EXYNOS4210_DRAM_MAX_SIZE) {
-        memory_region_init_ram(&s->dram1_mem, NULL, "exynos4210.dram1",
+        memory_region_init_ram(&s->dram1_mem, owner, "exynos4210.dram1",
                                mem_size - EXYNOS4210_DRAM_MAX_SIZE,
                                &error_fatal);
         memory_region_add_subregion(system_mem, EXYNOS4210_DRAM1_BASE_ADDR,
@@ -103,7 +103,7 @@ static void exynos4_boards_init_ram(Exynos4BoardState *s,
         mem_size = EXYNOS4210_DRAM_MAX_SIZE;
     }
 
-    memory_region_init_ram(&s->dram0_mem, NULL, "exynos4210.dram0", mem_size,
+    memory_region_init_ram(&s->dram0_mem, owner, "exynos4210.dram0", mem_size,
                            &error_fatal);
     memory_region_add_subregion(system_mem, EXYNOS4210_DRAM0_BASE_ADDR,
                                 &s->dram0_mem);
@@ -122,7 +122,7 @@ exynos4_boards_init_common(MachineState *machine,
     exynos4_board_binfo.gic_cpu_if_addr =
             EXYNOS4210_SMP_PRIVATE_BASE_ADDR + 0x100;
 
-    exynos4_boards_init_ram(s, get_system_memory(),
+    exynos4_boards_init_ram(OBJECT(machine), s, get_system_memory(),
                             exynos4_board_ram_size[board_type]);
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc,
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 7f65f4ca4b..f589c83567 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -292,7 +292,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                 &s->rom[1]);
 
     /* initialize internal RAM (128 KB) */
-    if (!memory_region_init_ram(&s->iram, NULL, "imx25.iram",
+    if (!memory_region_init_ram(&s->iram, OBJECT(dev), "imx25.iram",
                                 FSL_IMX25_IRAM_SIZE, errp)) {
         return;
     }
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 190f863355..fc387bbbc3 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -204,7 +204,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
                                 &s->rom);
 
     /* initialize internal RAM (16 KB) */
-    if (!memory_region_init_ram(&s->iram, NULL, "imx31.iram",
+    if (!memory_region_init_ram(&s->iram, OBJECT(dev), "imx31.iram",
                                 FSL_IMX31_IRAM_SIZE, errp)) {
         return;
     }
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index f0fbdc1a68..99250910cb 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -491,7 +491,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                 &s->caam);
 
     /* OCRAM memory */
-    if (!memory_region_init_ram(&s->ocram, NULL, "imx6.ocram",
+    if (!memory_region_init_ram(&s->ocram, OBJECT(dev), "imx6.ocram",
                                 FSL_IMX6_OCRAM_SIZE, errp)) {
         return;
     }
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index adbb896fd1..f830dce9df 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -699,7 +699,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * OCRAM memory
      */
-    memory_region_init_ram(&s->ocram, NULL, "imx6ul.ocram",
+    memory_region_init_ram(&s->ocram, OBJECT(dev), "imx6ul.ocram",
                            FSL_IMX6UL_OCRAM_MEM_SIZE,
                            &error_abort);
     memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_OCRAM_MEM_ADDR,
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 07a5ae8cd0..ceb26b4efd 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -689,7 +689,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     /*
      * OCRAM memory
      */
-    memory_region_init_ram(&s->ocram, NULL, "imx7.ocram",
+    memory_region_init_ram(&s->ocram, OBJECT(dev), "imx7.ocram",
                            FSL_IMX7_OCRAM_MEM_SIZE,
                            &error_abort);
     memory_region_add_subregion(get_system_memory(), FSL_IMX7_OCRAM_MEM_ADDR,
@@ -698,7 +698,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     /*
      * OCRAM EPDC memory
      */
-    memory_region_init_ram(&s->ocram_epdc, NULL, "imx7.ocram_epdc",
+    memory_region_init_ram(&s->ocram_epdc, OBJECT(dev), "imx7.ocram_epdc",
                            FSL_IMX7_OCRAM_EPDC_SIZE,
                            &error_abort);
     memory_region_add_subregion(get_system_memory(), FSL_IMX7_OCRAM_EPDC_ADDR,
@@ -707,7 +707,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     /*
      * OCRAM PXP memory
      */
-    memory_region_init_ram(&s->ocram_pxp, NULL, "imx7.ocram_pxp",
+    memory_region_init_ram(&s->ocram_pxp, OBJECT(dev), "imx7.ocram_pxp",
                            FSL_IMX7_OCRAM_PXP_SIZE,
                            &error_abort);
     memory_region_add_subregion(get_system_memory(), FSL_IMX7_OCRAM_PXP_ADDR,
@@ -716,7 +716,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     /*
      * OCRAM_S memory
      */
-    memory_region_init_ram(&s->ocram_s, NULL, "imx7.ocram_s",
+    memory_region_init_ram(&s->ocram_s, OBJECT(dev), "imx7.ocram_s",
                            FSL_IMX7_OCRAM_S_SIZE,
                            &error_abort);
     memory_region_add_subregion(get_system_memory(), FSL_IMX7_OCRAM_S_ADDR,
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 9351d53850..cecfc25e9a 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -104,7 +104,7 @@ static void imx25_pdk_init(MachineState *machine)
         ram_size -= size;
 
         if (size < ram[i].size) {
-            memory_region_init_alias(&s->ram_alias, NULL, "ram.alias",
+            memory_region_init_alias(&s->ram_alias, OBJECT(machine), "ram.alias",
                                      machine->ram,
                                      alias_offset, ram[i].size - size);
             memory_region_add_subregion(get_system_memory(),
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index ed715a3eb8..81c0bce8f9 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -617,7 +617,7 @@ static void integratorcp_init(MachineState *machine)
     /* SDRAM at address zero*/
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
     /* And again at address 0x80000000 */
-    memory_region_init_alias(ram_alias, NULL, "ram.alias", machine->ram,
+    memory_region_init_alias(ram_alias, OBJECT(machine), "ram.alias", machine->ram,
                              0, ram_size);
     memory_region_add_subregion(address_space_mem, 0x80000000, ram_alias);
 
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 36e12bb362..3e879c492d 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -104,7 +104,7 @@ static void kzm_init(MachineState *machine)
         ram_size -= size;
 
         if (size < ram[i].size) {
-            memory_region_init_alias(&s->ram_alias, NULL, "ram.alias",
+            memory_region_init_alias(&s->ram_alias, OBJECT(machine), "ram.alias",
                                      machine->ram,
                                      alias_offset, ram[i].size - size);
             memory_region_add_subregion(get_system_memory(),
diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index b8e0265de2..41cfaee925 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -74,7 +74,7 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
 
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
 
-    memory_region_init_ram(&s->sram, NULL, "MAX78000.sram", SRAM_SIZE,
+    memory_region_init_ram(&s->sram, obj, "MAX78000.sram", SRAM_SIZE,
                            &err);
 
     gcrdev = DEVICE(&s->gcr);
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 32e3db1134..a57915e208 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -338,7 +338,7 @@ static MemoryRegion *mr_for_raminfo(MPS2TZMachineState *mms,
     assert(raminfo->mrindex < MPS2TZ_RAM_MAX);
     ram = &mms->ram[raminfo->mrindex];
 
-    memory_region_init_ram(ram, NULL, raminfo->name,
+    memory_region_init_ram(ram, OBJECT(mms), raminfo->name,
                            raminfo->size, &error_fatal);
     if (raminfo->flags & IS_ROM) {
         memory_region_set_readonly(ram, true);
@@ -349,10 +349,10 @@ static MemoryRegion *mr_for_raminfo(MPS2TZMachineState *mms,
 /* Create an alias of an entire original MemoryRegion @orig
  * located at @base in the memory map.
  */
-static void make_ram_alias(MemoryRegion *mr, const char *name,
+static void make_ram_alias(Object *owner, MemoryRegion *mr, const char *name,
                            MemoryRegion *orig, hwaddr base)
 {
-    memory_region_init_alias(mr, NULL, name, orig, 0,
+    memory_region_init_alias(mr, owner, name, orig, 0,
                              memory_region_size(orig));
     memory_region_add_subregion(get_system_memory(), base, mr);
 }
@@ -767,7 +767,8 @@ static void create_non_mpc_ram(MPS2TZMachineState *mms)
         if (p->flags & IS_ALIAS) {
             SysBusDevice *mpc_sbd = SYS_BUS_DEVICE(&mms->mpc[p->mpc]);
             MemoryRegion *upstream = sysbus_mmio_get_region(mpc_sbd, 1);
-            make_ram_alias(&mms->ram[p->mrindex], p->name, upstream, p->base);
+            make_ram_alias(OBJECT(mms), &mms->ram[p->mrindex], p->name,
+                           upstream, p->base);
         } else if (p->mpc == -1) {
             /* RAM not behind an MPC */
             MemoryRegion *mr = mr_for_raminfo(mms, p);
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 23a814e4e4..1dec4a5d4d 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -115,20 +115,20 @@ OBJECT_DECLARE_TYPE(MPS2MachineState, MPS2MachineClass, MPS2_MACHINE)
 /* Initialize the auxiliary RAM region @mr and map it into
  * the memory map at @base.
  */
-static void make_ram(MemoryRegion *mr, const char *name,
+static void make_ram(Object *owner, MemoryRegion *mr, const char *name,
                      hwaddr base, hwaddr size)
 {
-    memory_region_init_ram(mr, NULL, name, size, &error_fatal);
+    memory_region_init_ram(mr, owner, name, size, &error_fatal);
     memory_region_add_subregion(get_system_memory(), base, mr);
 }
 
 /* Create an alias of an entire original MemoryRegion @orig
  * located at @base in the memory map.
  */
-static void make_ram_alias(MemoryRegion *mr, const char *name,
+static void make_ram_alias(Object *owner, MemoryRegion *mr, const char *name,
                            MemoryRegion *orig, hwaddr base)
 {
-    memory_region_init_alias(mr, NULL, name, orig, 0,
+    memory_region_init_alias(mr, owner, name, orig, 0,
                              memory_region_size(orig));
     memory_region_add_subregion(get_system_memory(), base, mr);
 }
@@ -192,12 +192,12 @@ static void mps2_common_init(MachineState *machine)
     memory_region_add_subregion(system_memory, mmc->psram_base, machine->ram);
 
     if (mmc->has_block_ram) {
-        make_ram(&mms->blockram, "mps.blockram", 0x01000000, 0x4000);
-        make_ram_alias(&mms->blockram_m1, "mps.blockram_m1",
+        make_ram(obj, &mms->blockram, "mps.blockram", 0x01000000, 0x4000);
+        make_ram_alias(obj, &mms->blockram_m1, "mps.blockram_m1",
                        &mms->blockram, 0x01004000);
-        make_ram_alias(&mms->blockram_m2, "mps.blockram_m2",
+        make_ram_alias(obj, &mms->blockram_m2, "mps.blockram_m2",
                        &mms->blockram, 0x01008000);
-        make_ram_alias(&mms->blockram_m3, "mps.blockram_m3",
+        make_ram_alias(obj, &mms->blockram_m3, "mps.blockram_m3",
                        &mms->blockram, 0x0100c000);
     }
 
@@ -205,17 +205,18 @@ static void mps2_common_init(MachineState *machine)
     case FPGA_AN385:
     case FPGA_AN386:
     case FPGA_AN500:
-        make_ram(&mms->ssram1, "mps.ssram1", 0x0, 0x400000);
-        make_ram_alias(&mms->ssram1_m, "mps.ssram1_m", &mms->ssram1, 0x400000);
-        make_ram(&mms->ssram23, "mps.ssram23", 0x20000000, 0x400000);
-        make_ram_alias(&mms->ssram23_m, "mps.ssram23_m",
+        make_ram(obj, &mms->ssram1, "mps.ssram1", 0x0, 0x400000);
+        make_ram_alias(obj, &mms->ssram1_m, "mps.ssram1_m",
+                       &mms->ssram1, 0x400000);
+        make_ram(obj, &mms->ssram23, "mps.ssram23", 0x20000000, 0x400000);
+        make_ram_alias(obj, &mms->ssram23_m, "mps.ssram23_m",
                        &mms->ssram23, 0x20400000);
         break;
     case FPGA_AN511:
-        make_ram(&mms->blockram, "mps.blockram", 0x0, 0x40000);
-        make_ram(&mms->ssram1, "mps.ssram1", 0x00400000, 0x00800000);
-        make_ram(&mms->sram, "mps.sram", 0x20000000, 0x20000);
-        make_ram(&mms->ssram23, "mps.ssram23", 0x20400000, 0x400000);
+        make_ram(obj, &mms->blockram, "mps.blockram", 0x0, 0x40000);
+        make_ram(obj, &mms->ssram1, "mps.ssram1", 0x00400000, 0x00800000);
+        make_ram(obj, &mms->sram, "mps.sram", 0x20000000, 0x20000);
+        make_ram(obj, &mms->ssram23, "mps.ssram23", 0x20400000, 0x400000);
         break;
     default:
         g_assert_not_reached();
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 4d432de6ba..d6c29c1172 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -215,7 +215,7 @@ static MemoryRegion *mr_for_raminfo(MPS3RMachineState *mms,
     assert(raminfo->mrindex < MPS3R_RAM_MAX);
     ram = &mms->ram[raminfo->mrindex];
 
-    memory_region_init_ram(ram, NULL, raminfo->name,
+    memory_region_init_ram(ram, OBJECT(mms), raminfo->name,
                            raminfo->size, &error_fatal);
     if (raminfo->flags & IS_ROM) {
         memory_region_set_readonly(ram, true);
@@ -397,7 +397,7 @@ static void mps3r_common_init(MachineState *machine)
         object_unref(mms->cpu[i]);
 
         /* Per-CPU RAM */
-        memory_region_init_ram(&mms->cpu_ram[i], NULL, ramname,
+        memory_region_init_ram(&mms->cpu_ram[i], OBJECT(mms), ramname,
                                0x1000, &error_fatal);
         memory_region_add_subregion(&mms->cpu_sysmem[i], 0xe7c01000,
                                     &mms->cpu_ram[i]);
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index c03778c439..ce320a5a38 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -128,7 +128,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(system_memory, ENVM_BASE_ADDRESS, &s->nvm);
     memory_region_add_subregion(system_memory, 0, &s->nvm_alias);
 
-    memory_region_init_ram(&s->sram, NULL, "MSF2.eSRAM", s->esram_size,
+    memory_region_init_ram(&s->sram, OBJECT(dev_soc), "MSF2.eSRAM", s->esram_size,
                            &error_fatal);
     memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sram);
 
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 0d0e2514dd..5493f1cf70 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -55,7 +55,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
     MemoryRegion *ddr = g_new(MemoryRegion, 1);
     Clock *m3clk;
 
-    memory_region_init_ram(ddr, NULL, "ddr-ram", DDR_SIZE,
+    memory_region_init_ram(ddr, OBJECT(machine), "ddr-ram", DDR_SIZE,
                            &error_fatal);
     memory_region_add_subregion(sysmem, DDR_BASE_ADDRESS, ddr);
 
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 75d82eebca..38eac4af76 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -235,12 +235,12 @@ static MemoryRegion *make_mpc(MuscaMachineState *mms, void *opaque,
     switch (mpcinfo[i].type) {
     case MPC_ROM:
         downstream = &mms->ram[i];
-        memory_region_init_rom(downstream, NULL, mpcinfo[i].name,
+        memory_region_init_rom(downstream, OBJECT(mms), mpcinfo[i].name,
                                mpcinfo[i].size, &error_fatal);
         break;
     case MPC_RAM:
         downstream = &mms->ram[i];
-        memory_region_init_ram(downstream, NULL, mpcinfo[i].name,
+        memory_region_init_ram(downstream, OBJECT(mms), mpcinfo[i].name,
                                mpcinfo[i].size, &error_fatal);
         break;
     case MPC_CRYPTOISLAND:
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 86ea348d3d..fda42f71d5 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1236,7 +1236,7 @@ static void musicpal_init(MachineState *machine)
 
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
-    memory_region_init_ram(sram, NULL, "musicpal.sram", MP_SRAM_SIZE,
+    memory_region_init_ram(sram, OBJECT(machine), "musicpal.sram", MP_SRAM_SIZE,
                            &error_fatal);
     memory_region_add_subregion(address_space_mem, MP_SRAM_BASE, sram);
 
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 1bd6c6d4bc..f8d54c2716 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -128,22 +128,22 @@ static void sx1_init(MachineState *machine, const int version)
     mpu = omap310_mpu_init(OBJECT(machine), machine->ram, machine->cpu_type);
 
     /* External Flash (EMIFS) */
-    memory_region_init_rom(flash, NULL, "omap_sx1.flash0-0", flash_size,
+    memory_region_init_rom(flash, OBJECT(machine), "omap_sx1.flash0-0", flash_size,
                            &error_fatal);
     memory_region_add_subregion(address_space, OMAP_CS0_BASE, flash);
 
-    memory_region_init_io(&cs[0], NULL, &static_ops, &cs0val,
+    memory_region_init_io(&cs[0], OBJECT(machine), &static_ops, &cs0val,
                           "sx1.cs0", OMAP_CS0_SIZE - flash_size);
     memory_region_add_subregion(address_space,
                                 OMAP_CS0_BASE + flash_size, &cs[0]);
 
 
-    memory_region_init_io(&cs[2], NULL, &static_ops, &cs2val,
+    memory_region_init_io(&cs[2], OBJECT(machine), &static_ops, &cs2val,
                           "sx1.cs2", OMAP_CS2_SIZE);
     memory_region_add_subregion(address_space,
                                 OMAP_CS2_BASE, &cs[2]);
 
-    memory_region_init_io(&cs[3], NULL, &static_ops, &cs3val,
+    memory_region_init_io(&cs[3], OBJECT(machine), &static_ops, &cs3val,
                           "sx1.cs3", OMAP_CS3_SIZE);
     memory_region_add_subregion(address_space,
                                 OMAP_CS3_BASE, &cs[3]);
@@ -160,11 +160,11 @@ static void sx1_init(MachineState *machine, const int version)
     if ((version == 1) &&
             (dinfo = drive_get(IF_PFLASH, 0, fl_idx)) != NULL) {
         MemoryRegion *flash_1 = g_new(MemoryRegion, 1);
-        memory_region_init_rom(flash_1, NULL, "omap_sx1.flash1-0",
+        memory_region_init_rom(flash_1, OBJECT(machine), "omap_sx1.flash1-0",
                                FLASH1_SIZE, &error_fatal);
         memory_region_add_subregion(address_space, OMAP_CS1_BASE, flash_1);
 
-        memory_region_init_io(&cs[1], NULL, &static_ops, &cs1val,
+        memory_region_init_io(&cs[1], OBJECT(machine), &static_ops, &cs1val,
                               "sx1.cs1", OMAP_CS1_SIZE - FLASH1_SIZE);
         memory_region_add_subregion(address_space,
                                 OMAP_CS1_BASE + FLASH1_SIZE, &cs[1]);
@@ -175,7 +175,7 @@ static void sx1_init(MachineState *machine, const int version)
                               SECTOR_SIZE, 4, 0, 0, 0, 0, 0);
         fl_idx++;
     } else {
-        memory_region_init_io(&cs[1], NULL, &static_ops, &cs1val,
+        memory_region_init_io(&cs[1], OBJECT(machine), &static_ops, &cs1val,
                               "sx1.cs1", OMAP_CS1_SIZE);
         memory_region_add_subregion(address_space,
                                 OMAP_CS1_BASE, &cs[1]);
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 2441137222..73bfffa6e6 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -159,18 +159,18 @@ static void realview_init(MachineState *machine,
         ram_lo = g_new(MemoryRegion, 1);
         low_ram_size = ram_size - 0x20000000;
         ram_size = 0x20000000;
-        memory_region_init_ram(ram_lo, NULL, "realview.lowmem", low_ram_size,
+        memory_region_init_ram(ram_lo, OBJECT(machine), "realview.lowmem", low_ram_size,
                                &error_fatal);
         memory_region_add_subregion(sysmem, 0x20000000, ram_lo);
     }
 
-    memory_region_init_ram(ram_hi, NULL, "realview.highmem", ram_size,
+    memory_region_init_ram(ram_hi, OBJECT(machine), "realview.highmem", ram_size,
                            &error_fatal);
     low_ram_size = ram_size;
     if (low_ram_size > 0x10000000)
       low_ram_size = 0x10000000;
     /* SDRAM at address zero.  */
-    memory_region_init_alias(ram_alias, NULL, "realview.alias",
+    memory_region_init_alias(ram_alias, OBJECT(machine), "realview.alias",
                              ram_hi, 0, low_ram_size);
     memory_region_add_subregion(sysmem, 0, ram_alias);
     if (is_pb) {
@@ -396,7 +396,7 @@ static void realview_init(MachineState *machine,
        startup code.  I guess this works on real hardware because the
        BootROM happens to be in ROM/flash or in memory that isn't clobbered
        until after Linux boots the secondary CPUs.  */
-    memory_region_init_ram(ram_hack, NULL, "realview.hack", 0x1000,
+    memory_region_init_ram(ram_hack, OBJECT(machine), "realview.hack", 0x1000,
                            &error_fatal);
     memory_region_add_subregion(sysmem, SMP_BOOT_ADDR, ram_hack);
 
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index f632df742b..c9adc972c1 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -410,7 +410,7 @@ static void create_secure_ram(SBSAMachineState *sms,
     hwaddr base = sbsa_ref_memmap[SBSA_SECURE_MEM].base;
     hwaddr size = sbsa_ref_memmap[SBSA_SECURE_MEM].size;
 
-    memory_region_init_ram(secram, NULL, "sbsa-ref.secure-ram", size,
+    memory_region_init_ram(secram, OBJECT(sms), "sbsa-ref.secure-ram", size,
                            &error_fatal);
     memory_region_add_subregion(secure_sysmem, base, secram);
 }
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 6a732a3c11..1bc428e063 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1084,11 +1084,11 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     object_property_add_child(OBJECT(ms), "soc", soc_container);
 
     /* Flash programming is done via the SCU, so pretend it is ROM.  */
-    memory_region_init_rom(flash, NULL, "stellaris.flash", flash_size,
+    memory_region_init_rom(flash, OBJECT(ms), "stellaris.flash", flash_size,
                            &error_fatal);
     memory_region_add_subregion(system_memory, 0, flash);
 
-    memory_region_init_ram(sram, NULL, "stellaris.sram", sram_size,
+    memory_region_init_ram(sram, OBJECT(ms), "stellaris.sram", sram_size,
                            &error_fatal);
     memory_region_add_subregion(system_memory, 0x20000000, sram);
 
diff --git a/hw/arm/stm32f100_soc.c b/hw/arm/stm32f100_soc.c
index e9e722f359..d6d81c1338 100644
--- a/hw/arm/stm32f100_soc.c
+++ b/hw/arm/stm32f100_soc.c
@@ -108,7 +108,7 @@ static void stm32f100_soc_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(system_memory, 0, &s->flash_alias);
 
     /* Init SRAM region */
-    memory_region_init_ram(&s->sram, NULL, "STM32F100.sram", SRAM_SIZE,
+    memory_region_init_ram(&s->sram, OBJECT(dev_soc), "STM32F100.sram", SRAM_SIZE,
                            &error_fatal);
     memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sram);
 
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index a03c6b4002..2997e7d777 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -121,7 +121,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
     memory_region_add_subregion(system_memory, 0, &s->flash_alias);
 
-    memory_region_init_ram(&s->sram, NULL, "STM32F205.sram", SRAM_SIZE,
+    memory_region_init_ram(&s->sram, OBJECT(dev_soc), "STM32F205.sram", SRAM_SIZE,
                            &error_fatal);
     memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sram);
 
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index dc9b3053a5..4783f3f64a 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -134,7 +134,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
     memory_region_add_subregion(system_memory, 0, &s->flash_alias);
 
-    memory_region_init_ram(&s->sram, NULL, "STM32F405.sram", SRAM_SIZE,
+    memory_region_init_ram(&s->sram, OBJECT(dev_soc), "STM32F405.sram", SRAM_SIZE,
                            &err);
     if (err != NULL) {
         error_propagate(errp, err);
@@ -142,7 +142,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     }
     memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sram);
 
-    memory_region_init_ram(&s->ccm, NULL, "STM32F405.ccm", CCM_SIZE,
+    memory_region_init_ram(&s->ccm, OBJECT(dev_soc), "STM32F405.ccm", CCM_SIZE,
                            &err);
     if (err != NULL) {
         error_propagate(errp, err);
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index a643c6b079..f877ccf330 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -392,7 +392,7 @@ static void a15_daughterboard_init(VexpressMachineState *vms,
     /* 0x2b060000: SP805 watchdog: not modelled */
     /* 0x2b0a0000: PL341 dynamic memory controller: not modelled */
     /* 0x2e000000: system SRAM */
-    memory_region_init_ram(&vms->a15sram, NULL, "vexpress.a15sram", 0x10000,
+    memory_region_init_ram(&vms->a15sram, OBJECT(vms), "vexpress.a15sram", 0x10000,
                            &error_fatal);
     memory_region_add_subregion(sysmem, 0x2e000000, &vms->a15sram);
 
@@ -677,7 +677,7 @@ static void vexpress_common_init(MachineState *machine)
         /* Map flash 0 as an alias into low memory */
         MemoryRegion *flash0mem;
         flash0mem = sysbus_mmio_get_region(SYS_BUS_DEVICE(pflash0), 0);
-        memory_region_init_alias(&vms->flashalias, NULL, "vexpress.flashalias",
+        memory_region_init_alias(&vms->flashalias, OBJECT(vms), "vexpress.flashalias",
                                  flash0mem, 0, VEXPRESS_FLASH_SIZE);
         memory_region_add_subregion(sysmem, map[VE_NORFLASHALIAS], &vms->flashalias);
     }
@@ -687,12 +687,12 @@ static void vexpress_common_init(MachineState *machine)
                              "vexpress.flash1", dinfo);
 
     sram_size = 0x2000000;
-    memory_region_init_ram(&vms->sram, NULL, "vexpress.sram", sram_size,
+    memory_region_init_ram(&vms->sram, OBJECT(vms), "vexpress.sram", sram_size,
                            &error_fatal);
     memory_region_add_subregion(sysmem, map[VE_SRAM], &vms->sram);
 
     vram_size = 0x800000;
-    memory_region_init_ram(&vms->vram, NULL, "vexpress.vram", vram_size,
+    memory_region_init_ram(&vms->vram, OBJECT(vms), "vexpress.vram", vram_size,
                            &error_fatal);
     memory_region_add_subregion(sysmem, map[VE_VIDEORAM], &vms->vram);
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ea51a5f3bd..f2249a0b72 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2308,13 +2308,13 @@ static void create_platform_bus(VirtMachineState *vms)
                                 sysbus_mmio_get_region(s, 0));
 }
 
-static void create_tag_ram(MemoryRegion *tag_sysmem,
+static void create_tag_ram(Object *owner, MemoryRegion *tag_sysmem,
                            hwaddr base, hwaddr size,
                            const char *name)
 {
     MemoryRegion *tagram = g_new(MemoryRegion, 1);
 
-    memory_region_init_ram(tagram, NULL, name, size / 32, &error_fatal);
+    memory_region_init_ram(tagram, owner, name, size / 32, &error_fatal);
     memory_region_add_subregion(tag_sysmem, base / 32, tagram);
 }
 
@@ -2328,7 +2328,7 @@ static void create_secure_ram(VirtMachineState *vms,
     hwaddr size = vms->memmap[VIRT_SECURE_MEM].size;
     MachineState *ms = MACHINE(vms);
 
-    memory_region_init_ram(secram, NULL, "virt.secure-ram", size,
+    memory_region_init_ram(secram, OBJECT(vms), "virt.secure-ram", size,
                            &error_fatal);
     memory_region_add_subregion(secure_sysmem, base, secram);
 
@@ -2340,7 +2340,8 @@ static void create_secure_ram(VirtMachineState *vms,
     qemu_fdt_setprop_string(ms->fdt, nodename, "secure-status", "okay");
 
     if (secure_tag_sysmem) {
-        create_tag_ram(secure_tag_sysmem, base, size, "mach-virt.secure-tag");
+        create_tag_ram(OBJECT(vms), secure_tag_sysmem, base, size,
+                       "mach-virt.secure-tag");
     }
 
     g_free(nodename);
@@ -2840,7 +2841,7 @@ static void virt_post_cpus_gic_realized(VirtMachineState *vms,
                 exit(1);
             }
 
-            memory_region_init_ram(pvtime, NULL, "pvtime", pvtime_size, NULL);
+            memory_region_init_ram(pvtime, OBJECT(vms), "pvtime", pvtime_size, NULL);
             memory_region_add_subregion(sysmem, pvtime_reg_base, pvtime);
         }
         if (!aarch64 && vms->virt) {
@@ -3200,7 +3201,7 @@ static void machvirt_init(MachineState *machine)
     }
 
     if (tag_sysmem) {
-        create_tag_ram(tag_sysmem, vms->memmap[VIRT_MEM].base,
+        create_tag_ram(OBJECT(vms), tag_sysmem, vms->memmap[VIRT_MEM].base,
                        machine->ram_size, "mach-virt.tag");
     }
 
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 30f0ce5b5f..441289e63f 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -238,7 +238,7 @@ static void zynq_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
     /* 256K of on-chip memory */
-    memory_region_init_ram(ocm_ram, NULL, "zynq.ocm_ram", 256 * KiB,
+    memory_region_init_ram(ocm_ram, OBJECT(machine), "zynq.ocm_ram", 256 * KiB,
                            &error_fatal);
     memory_region_add_subregion(address_space_mem, 0xFFFC0000, ocm_ram);
 
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index e4a10861a8..a25d5d3158 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -510,7 +510,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < XLNX_ZYNQMP_NUM_OCM_BANKS; i++) {
         char *ocm_name = g_strdup_printf("zynqmp.ocm_ram_bank_%d", i);
 
-        memory_region_init_ram(&s->ocm_ram[i], NULL, ocm_name,
+        memory_region_init_ram(&s->ocm_ram[i], OBJECT(dev), ocm_name,
                                XLNX_ZYNQMP_OCM_RAM_SIZE, &error_fatal);
         memory_region_add_subregion(get_system_memory(),
                                     XLNX_ZYNQMP_OCM_RAM_0_ADDRESS +
-- 
2.47.1


