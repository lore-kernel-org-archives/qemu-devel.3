Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98020C4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlD8z-0006zw-H5; Sat, 18 Jul 2026 18:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD8x-0006w0-0R; Sat, 18 Jul 2026 18:04:23 -0400
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.155.198.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD8u-0005T4-Ni; Sat, 18 Jul 2026 18:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412260; x=1815948260;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m9WF7sOcpITnllvXQcPF+NIn05qRED1gJpFK9HNjkQM=;
 b=Sj/LBLncjv1GcxO3c2amfe1v3mPEnHfI+T4kUp0+cYKiGHzKZNWpPLpn
 26TBaTucnO6/rAiiztOKR6DMqcOsqQ2ujODBqvOiI5dRsgpv/w93Xx1lH
 ZWZ69mt6vEpsR6BH0ZQGFnW37JmqdZS7OiX9jUu9KzmxyRDXF4pAwM+I+
 V3SLJlcmUX6k3uilefTuj9kvLoz3cPbCmPJ2BUXfRbplASsd9Xf4lk31i
 w7ylAHfKpwpWCzjgImU0ypsN+XSME+M8lhB8lyO2DjYm6jT3tCZTUQwx2
 w8STq3sDV/fJOIzY+bugv8nxQZFsFkQHc22aV2btmnbTpnDQfTLkG74VY A==;
X-CSE-ConnectionGUID: WNCxDmKMRBW6mNg9l5iGnA==
X-CSE-MsgGUID: g83soVdnQ9KDpnSjGzx5gQ==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23817117"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:04:17 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:29768]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.115:2525]
 with esmtp (Farcaster)
 id e167519a-a4c5-4640-b0f2-3c8fe08ccd23; Sat, 18 Jul 2026 22:04:16 +0000 (UTC)
X-Farcaster-Flow-ID: e167519a-a4c5-4640-b0f2-3c8fe08ccd23
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:04:16 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:04:07 +0000
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
Subject: [RFC PATCH v2 098/137] hw/m68k: Give memory regions an explicit owner
Date: Sat, 18 Jul 2026 21:36:13 +0000
Message-ID: <20260718213652.37673-99-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=35.155.198.111;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
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

Convert memory_region_init*() calls that pass NULL owner to pass
the enclosing machine or device instead.

Thread Object *owner through the static mcf5208_sys_init() helper. mcf5206_mbar_realize() already has DeviceState *dev in scope.

No functional change intended.

RAMBlock idstrs are unchanged: the owners added here are Machine
or SysBus devices, and memory_region_register_ram() maps both to
dev=NULL for qemu_ram_set_idstr().

Reviewed-by: Thomas Huth <th.huth+qemu@posteo.eu> # coldfire, next-cube only
AI-used-for: code (refactoring)
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


