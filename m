Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E02FC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigjB-0005WA-Sv; Sat, 11 Jul 2026 19:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigik-0005PS-GD; Sat, 11 Jul 2026 19:02:56 -0400
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.34.181.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigie-0002ae-8I; Sat, 11 Jul 2026 19:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810968; x=1815346968;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kIRDMMYQoAbVbR+Yb/nq/CG8IV16g3zCWr2Me2GLW6M=;
 b=sUfzUOvrQkXfianEQf6XpKIjfw6GTnGndKfxbQuP6PAG9P8W7x3ao94L
 a+ut8WNGBUf7Jczye+n/vGYRFnd7TWecy0XZr9aB0/gx2iDK7UYFuT3F6
 7o6zysR+mmUYqDKgvxwXiOs41NS8+wBypuVomJ+oam3Ws6AsndFzfgHXt
 MsJrXIm+NygTZxrfX1y8LOPbLidZFtlP8rVKPclFVDIkMSepmHHrTLs1b
 09L7EeEER0EvOztkwOOmI5UDwHTWiuAWzIU726QhdD/H/d3eTyESzX0du
 o22ZFYDN1HJcCRad7iKlLyfW1xH0ReufgQiS6mzEuInq0wFEB6JfF3q60 g==;
X-CSE-ConnectionGUID: UnS3OulPSI22PLwrbrOoMw==
X-CSE-MsgGUID: rqh8YVmBRDC1yM2K3LZ0kg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23483611"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:02:44 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:23292]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.135:2525]
 with esmtp (Farcaster)
 id c3cb8fca-4aa2-4924-8f15-6db4f3d24a39; Sat, 11 Jul 2026 23:02:44 +0000 (UTC)
X-Farcaster-Flow-ID: c3cb8fca-4aa2-4924-8f15-6db4f3d24a39
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:02:43 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:02:35 +0000
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
Subject: [RFC PATCH 097/134] hw/m68k: Give memory regions an explicit owner
Date: Sat, 11 Jul 2026 22:36:30 +0000
Message-ID: <20260711223707.42139-98-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.34.181.151;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert memory_region_init*() calls that pass NULL owner to pass
the enclosing machine or device instead.

Thread Object *owner through the static mcf5208_sys_init() helper. mcf5206_mbar_realize() already has DeviceState *dev in scope.

No functional change intended.

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/m68k/an5206.c    |  2 +-
 hw/m68k/mcf5206.c   |  2 +-
 hw/m68k/mcf5208.c   | 15 ++++++++-------
 hw/m68k/next-cube.c | 10 +++++-----
 hw/m68k/q800.c      | 10 +++++-----
 5 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 5027311cad..6c6c7d7248 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -60,7 +60,7 @@ static void an5206_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
     /* Internal SRAM.  */
-    memory_region_init_ram(sram, NULL, "an5206.sram", 512, &error_fatal);
+    memory_region_init_ram(sram, OBJECT(machine), "an5206.sram", 512, &error_fatal);
     memory_region_add_subregion(address_space_mem, AN5206_RAMBAR_ADDR, sram);
 
     mcf5206_init(OBJECT(machine), cpu, address_space_mem, AN5206_MBAR_ADDR);
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index b3c745d3f9..ee39a6ac30 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -589,7 +589,7 @@ static void mcf5206_mbar_realize(DeviceState *dev, Error **errp)
 {
     m5206_mbar_state *s = MCF5206_MBAR(dev);
 
-    memory_region_init_io(&s->iomem, NULL, &m5206_mbar_ops, s,
+    memory_region_init_io(&s->iomem, OBJECT(dev), &m5206_mbar_ops, s,
                           "mbar", 0x00001000);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index a955efebeb..93aee5ebd5 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -227,7 +227,8 @@ static const MemoryRegionOps m5208_rcm_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void mcf5208_sys_init(MemoryRegion *address_space, DeviceState *intc,
+static void mcf5208_sys_init(Object *owner, MemoryRegion *address_space,
+                             DeviceState *intc,
                              M68kCPU *cpu)
 {
     MemoryRegion *iomem = g_new(MemoryRegion, 1);
@@ -236,17 +237,17 @@ static void mcf5208_sys_init(MemoryRegion *address_space, DeviceState *intc,
     int i;
 
     /* RCM */
-    memory_region_init_io(iomem_rcm, NULL, &m5208_rcm_ops, cpu,
+    memory_region_init_io(iomem_rcm, owner, &m5208_rcm_ops, cpu,
                           "m5208-rcm", 0x00000080);
     memory_region_add_subregion(address_space, 0xfc0a0000, iomem_rcm);
     /* SDRAMC.  */
-    memory_region_init_io(iomem, NULL, &m5208_sys_ops, NULL, "m5208-sys", 0x00004000);
+    memory_region_init_io(iomem, owner, &m5208_sys_ops, NULL, "m5208-sys", 0x00004000);
     memory_region_add_subregion(address_space, 0xfc0a8000, iomem);
     /* Timers.  */
     for (i = 0; i < 2; i++) {
         s = g_new0(m5208_timer_state, 1);
         s->timer = ptimer_init(m5208_timer_trigger, s, PTIMER_POLICY_LEGACY);
-        memory_region_init_io(&s->iomem, NULL, &m5208_timer_ops, s,
+        memory_region_init_io(&s->iomem, owner, &m5208_timer_ops, s,
                               "m5208-timer", 0x00004000);
         memory_region_add_subregion(address_space, 0xfc080000 + 0x4000 * i,
                                     &s->iomem);
@@ -296,14 +297,14 @@ static void mcf5208evb_init(MachineState *machine)
     /* TODO: Configure BARs.  */
 
     /* ROM at 0x00000000 */
-    memory_region_init_rom(rom, NULL, "mcf5208.rom", ROM_SIZE, &error_fatal);
+    memory_region_init_rom(rom, OBJECT(machine), "mcf5208.rom", ROM_SIZE, &error_fatal);
     memory_region_add_subregion(address_space_mem, 0x00000000, rom);
 
     /* DRAM at 0x40000000 */
     memory_region_add_subregion(address_space_mem, 0x40000000, machine->ram);
 
     /* Internal SRAM.  */
-    memory_region_init_ram(sram, NULL, "mcf5208.sram", 16 * KiB, &error_fatal);
+    memory_region_init_ram(sram, OBJECT(machine), "mcf5208.sram", 16 * KiB, &error_fatal);
     memory_region_add_subregion(address_space_mem, 0x80000000, sram);
 
     /* Internal peripherals.  */
@@ -316,7 +317,7 @@ static void mcf5208evb_init(MachineState *machine)
     mcf_uart_create_mmap(OBJECT(machine), 0xfc068000,
                          qdev_get_gpio_in(intc, 28), serial_hd(2));
 
-    mcf5208_sys_init(address_space_mem, intc, cpu);
+    mcf5208_sys_init(OBJECT(machine), address_space_mem, intc, cpu);
 
     mcf_fec_init(address_space_mem, 0xfc030000, intc);
 
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index c80d32ef29..564a10a69e 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1310,11 +1310,11 @@ static void next_cube_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 5, 0x0211a000);
 
     /* BMAP memory */
-    memory_region_init_ram_flags_nomigrate(&m->bmapm1, NULL, "next.bmapmem",
+    memory_region_init_ram_flags_nomigrate(&m->bmapm1, OBJECT(machine), "next.bmapmem",
                                            64, RAM_SHARED, &error_fatal);
     memory_region_add_subregion(sysmem, 0x020c0000, &m->bmapm1);
     /* The Rev_2.5_v66.bin firmware accesses it at 0x820c0020, too */
-    memory_region_init_alias(&m->bmapm2, NULL, "next.bmapmem2", &m->bmapm1,
+    memory_region_init_alias(&m->bmapm2, OBJECT(machine), "next.bmapmem2", &m->bmapm1,
                              0x0, 64);
     memory_region_add_subregion(sysmem, 0x820c0000, &m->bmapm2);
 
@@ -1322,9 +1322,9 @@ static void next_cube_init(MachineState *machine)
     sysbus_create_simple(OBJECT(machine), "kbd", TYPE_NEXTKBD, 0x0200e000, NULL);
 
     /* Load ROM here */
-    memory_region_init_rom(&m->rom, NULL, "next.rom", 0x20000, &error_fatal);
+    memory_region_init_rom(&m->rom, OBJECT(machine), "next.rom", 0x20000, &error_fatal);
     memory_region_add_subregion(sysmem, 0x01000000, &m->rom);
-    memory_region_init_alias(&m->rom2, NULL, "next.rom2", &m->rom, 0x0,
+    memory_region_init_alias(&m->rom2, OBJECT(machine), "next.rom2", &m->rom, 0x0,
                              0x20000);
     memory_region_add_subregion(sysmem, 0x0, &m->rom2);
     Error *local_err = NULL;
@@ -1352,7 +1352,7 @@ static void next_cube_init(MachineState *machine)
     }
 
     /* DMA */
-    memory_region_init_io(&m->dmamem, NULL, &next_dma_ops, machine,
+    memory_region_init_io(&m->dmamem, OBJECT(machine), &next_dma_ops, machine,
                           "next.dma", 0x5000);
     memory_region_add_subregion(sysmem, 0x02000000, &m->dmamem);
 }
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 15b3bcab5f..954cdf8489 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -309,7 +309,7 @@ static void q800_machine_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), IO_BASE + IO_SLICE,
                                 &m->macio_alias);
 
-    memory_region_init_io(&m->machine_id, NULL, &machine_id_ops, NULL,
+    memory_region_init_io(&m->machine_id, OBJECT(machine), &machine_id_ops, NULL,
                           "Machine ID", 4);
     memory_region_add_subregion(get_system_memory(), 0x5ffffffc,
                                 &m->machine_id);
@@ -407,7 +407,7 @@ static void q800_machine_init(MachineState *machine)
     sysbus_connect_irq(sysbus, 0,
                        qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_SONIC));
 
-    memory_region_init_rom(&m->dp8393x_prom, NULL, "dp8393x-q800.prom",
+    memory_region_init_rom(&m->dp8393x_prom, OBJECT(machine), "dp8393x-q800.prom",
                            SONIC_PROM_SIZE, &error_fatal);
     memory_region_add_subregion(get_system_memory(), SONIC_PROM_BASE,
                                 &m->dp8393x_prom);
@@ -606,7 +606,7 @@ static void q800_machine_init(MachineState *machine)
         BOOTINFO1(param_ptr, BI_MAC_VROW, macfb_mode->stride);
         BOOTINFO1(param_ptr, BI_MAC_SCCBASE, SCC_BASE);
 
-        memory_region_init_ram_ptr(&m->rom, NULL, "m68k_fake_mac.rom",
+        memory_region_init_ram_ptr(&m->rom, OBJECT(machine), "m68k_fake_mac.rom",
                                    sizeof(fake_mac_rom), fake_mac_rom);
         memory_region_set_readonly(&m->rom, true);
         memory_region_add_subregion(get_system_memory(), MACROM_ADDR, &m->rom);
@@ -651,12 +651,12 @@ static void q800_machine_init(MachineState *machine)
     } else {
         uint8_t *ptr;
         /* allocate and load BIOS */
-        memory_region_init_rom(&m->rom, NULL, "m68k_mac.rom", MACROM_SIZE,
+        memory_region_init_rom(&m->rom, OBJECT(machine), "m68k_mac.rom", MACROM_SIZE,
                                &error_abort);
         filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
         memory_region_add_subregion(get_system_memory(), MACROM_ADDR, &m->rom);
 
-        memory_region_init_alias(&m->rom_alias, NULL, "m68k_mac.rom-alias",
+        memory_region_init_alias(&m->rom_alias, OBJECT(machine), "m68k_mac.rom-alias",
                                  &m->rom, 0, MACROM_SIZE);
         memory_region_add_subregion(get_system_memory(), 0x40000000,
                                     &m->rom_alias);
-- 
2.47.1


