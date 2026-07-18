Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22E3C4450A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlD7s-0003uh-Mp; Sat, 18 Jul 2026 18:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD7q-0003lZ-4d; Sat, 18 Jul 2026 18:03:14 -0400
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.13.214.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlD7n-0005NZ-Mm; Sat, 18 Jul 2026 18:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412191; x=1815948191;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YEMoqFRORhQJVsFGzoPtlNX9TwARBH3qOZoBH0ZerFk=;
 b=PdZBhg3QXa3RWoAjIy9kBY2PC53ontvWs1jQAPaLN9/K6UeBxdbsVsTf
 B2CaFE4BVq8YquDGiV0U7vzDokeJ/qmoj3ab1nwJEDcLWhBWqRbxcv8Q0
 lSe6Y/3g8dCMMr7EKTZWhDecVvG17aehNFV6sBrxNqGzk8Rih13mMpnFf
 VPkOGBkvi6uwsz8xtkzn2XaczMjsA3xXb+iwLRuRF0TAizaljuMD3kWFO
 GRasEfyNk9PAf8K8NLNeQD8dnf5OxrKm+73WdtkffCHmTp7cbwLXa/nIJ
 Y1Sz6JBy7WENm5cYOCOL2oyLdwbZNf5JhFf3AUkegvvmB/ehHbjLV0k7c Q==;
X-CSE-ConnectionGUID: NPtcU6GyTduAuMBjwlDCTw==
X-CSE-MsgGUID: erLxfkTUSd2uJ5sov2GTzA==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23904316"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:03:07 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:7195]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.115:2525]
 with esmtp (Farcaster)
 id da63f774-6385-4c10-bf00-7406293c02a8; Sat, 18 Jul 2026 22:03:07 +0000 (UTC)
X-Farcaster-Flow-ID: da63f774-6385-4c10-bf00-7406293c02a8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:03:07 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:02:57 +0000
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
Subject: [RFC PATCH v2 093/137] hw/riscv: Give memory regions an explicit owner
Date: Sat, 18 Jul 2026 21:36:08 +0000
Message-ID: <20260718213652.37673-94-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.13.214.179;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
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
the enclosing machine or SoC device instead. All sites are inside
board init (MachineState *machine) or SoC realize (DeviceState *dev)
functions.

No functional change intended.

RAMBlock idstrs are unchanged: the owners added here are Machine
or SysBus devices, and memory_region_register_ram() maps both to
dev=NULL for qemu_ram_set_idstr().

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/riscv/boston-aia.c           |  8 ++++----
 hw/riscv/microblaze-v-generic.c |  4 ++--
 hw/riscv/microchip_pfsoc.c      | 14 +++++++-------
 hw/riscv/sifive_u.c             |  4 ++--
 hw/riscv/spike.c                |  2 +-
 hw/riscv/tt_atlantis.c          |  2 +-
 hw/riscv/virt.c                 |  2 +-
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index 5a9ec28068..ef41f53aac 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -374,7 +374,7 @@ static void boston_mach_init(MachineState *machine)
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
 
     flash =  g_new(MemoryRegion, 1);
-    memory_region_init_rom(flash, NULL, "boston.flash",
+    memory_region_init_rom(flash, OBJECT(machine), "boston.flash",
                            boston_memmap[BOSTON_FLASH].size, &error_fatal);
     memory_region_add_subregion_overlap(sys_mem,
                                         boston_memmap[BOSTON_FLASH].base,
@@ -385,7 +385,7 @@ static void boston_mach_init(MachineState *machine)
                                         machine->ram, 0);
 
     ddr_low_alias = g_new(MemoryRegion, 1);
-    memory_region_init_alias(ddr_low_alias, NULL, "boston_low.ddr",
+    memory_region_init_alias(ddr_low_alias, OBJECT(machine), "boston_low.ddr",
                              machine->ram, 0,
                              MIN(machine->ram_size, (256 * MiB)));
     memory_region_add_subregion_overlap(sys_mem, 0, ddr_low_alias, 0);
@@ -398,7 +398,7 @@ static void boston_mach_init(MachineState *machine)
                              qdev_get_gpio_in(s->cps.aplic, PCIE2_INT));
 
     platreg = g_new(MemoryRegion, 1);
-    memory_region_init_io(platreg, NULL, &boston_platreg_ops, s,
+    memory_region_init_io(platreg, OBJECT(machine), &boston_platreg_ops, s,
                           "boston-platregs",
                           boston_memmap[BOSTON_PLATREG].size);
     memory_region_add_subregion_overlap(sys_mem,
@@ -410,7 +410,7 @@ static void boston_mach_init(MachineState *machine)
                              serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
     lcd = g_new(MemoryRegion, 1);
-    memory_region_init_io(lcd, NULL, &boston_lcd_ops, s, "boston-lcd", 0x8);
+    memory_region_init_io(lcd, OBJECT(machine), &boston_lcd_ops, s, "boston-lcd", 0x8);
     memory_region_add_subregion_overlap(sys_mem,
                                         boston_memmap[BOSTON_LCD].base, lcd, 0);
 
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index 7253ae7822..0a83932405 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -70,12 +70,12 @@ static void mb_v_generic_init(MachineState *machine)
     object_property_set_bool(OBJECT(cpu), "d", false, NULL);
     qdev_realize(DEVICE(cpu), NULL, &error_abort);
     /* Attach emulated BRAM through the LMB.  */
-    memory_region_init_ram(phys_lmb_bram, NULL,
+    memory_region_init_ram(phys_lmb_bram, OBJECT(machine),
                            "mb_v.lmb_bram", LMB_BRAM_SIZE,
                            &error_fatal);
     memory_region_add_subregion(sysmem, 0x00000000, phys_lmb_bram);
 
-    memory_region_init_ram(phys_ram, NULL, "mb_v.ram",
+    memory_region_init_ram(phys_ram, OBJECT(machine), "mb_v.ram",
                            ram_size, &error_fatal);
     memory_region_add_subregion(sysmem, ddr_base, phys_ram);
 
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 0a98ac1c5e..f1ee64ef86 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -219,14 +219,14 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     qdev_realize(DEVICE(&s->u_cluster), NULL, &error_abort);
 
     /* Reserved Memory at address 0 */
-    memory_region_init_ram(rsvd0_mem, NULL, "microchip.pfsoc.rsvd0_mem",
+    memory_region_init_ram(rsvd0_mem, OBJECT(dev), "microchip.pfsoc.rsvd0_mem",
                            memmap[MICROCHIP_PFSOC_RSVD0].size, &error_fatal);
     memory_region_add_subregion(system_memory,
                                 memmap[MICROCHIP_PFSOC_RSVD0].base,
                                 rsvd0_mem);
 
     /* E51 DTIM */
-    memory_region_init_ram(e51_dtim_mem, NULL, "microchip.pfsoc.e51_dtim_mem",
+    memory_region_init_ram(e51_dtim_mem, OBJECT(dev), "microchip.pfsoc.e51_dtim_mem",
                            memmap[MICROCHIP_PFSOC_E51_DTIM].size, &error_fatal);
     memory_region_add_subregion(system_memory,
                                 memmap[MICROCHIP_PFSOC_E51_DTIM].base,
@@ -271,7 +271,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
      * leave it enabled all the time. This won't break anything, but will be
      * too generous to misbehaving guests.
      */
-    memory_region_init_ram(l2lim_mem, NULL, "microchip.pfsoc.l2lim",
+    memory_region_init_ram(l2lim_mem, OBJECT(dev), "microchip.pfsoc.l2lim",
                            memmap[MICROCHIP_PFSOC_L2LIM].size, &error_fatal);
     memory_region_add_subregion(system_memory,
                                 memmap[MICROCHIP_PFSOC_L2LIM].base,
@@ -549,10 +549,10 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
     /* Split RAM into low and high regions using aliases to machine->ram */
     mem_low_size = memmap[MICROCHIP_PFSOC_DRAM_LO].size;
     mem_high_size = machine->ram_size - mem_low_size;
-    memory_region_init_alias(mem_low, NULL,
+    memory_region_init_alias(mem_low, OBJECT(machine),
                              "microchip.icicle.kit.ram_low", machine->ram,
                              0, mem_low_size);
-    memory_region_init_alias(mem_high, NULL,
+    memory_region_init_alias(mem_high, OBJECT(machine),
                              "microchip.icicle.kit.ram_high", machine->ram,
                              mem_low_size, mem_high_size);
 
@@ -565,13 +565,13 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
                                 mem_high);
 
     /* Create aliases for the low and high RAM regions */
-    memory_region_init_alias(mem_low_alias, NULL,
+    memory_region_init_alias(mem_low_alias, OBJECT(machine),
                              "microchip.icicle.kit.ram_low.alias",
                              mem_low, 0, mem_low_size);
     memory_region_add_subregion(system_memory,
                                 memmap[MICROCHIP_PFSOC_DRAM_LO_ALIAS].base,
                                 mem_low_alias);
-    memory_region_init_alias(mem_high_alias, NULL,
+    memory_region_init_alias(mem_high_alias, OBJECT(machine),
                              "microchip.icicle.kit.ram_high.alias",
                              mem_high, 0, mem_high_size);
     memory_region_add_subregion(system_memory,
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index aba6716b73..9d3f5c8f59 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -477,7 +477,7 @@ static void sifive_u_machine_init(MachineState *machine)
                                 machine->ram);
 
     /* register QSPI0 Flash */
-    memory_region_init_ram(flash0, NULL, "riscv.sifive.u.flash0",
+    memory_region_init_ram(flash0, OBJECT(machine), "riscv.sifive.u.flash0",
                            memmap[SIFIVE_U_DEV_FLASH0].size, &error_fatal);
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_DEV_FLASH0].base,
                                 flash0);
@@ -763,7 +763,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
      * leave it enabled all the time. This won't break anything, but will be
      * too generous to misbehaving guests.
      */
-    memory_region_init_ram(l2lim_mem, NULL, "riscv.sifive.u.l2lim",
+    memory_region_init_ram(l2lim_mem, OBJECT(dev), "riscv.sifive.u.l2lim",
                            memmap[SIFIVE_U_DEV_L2LIM].size, &error_fatal);
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_DEV_L2LIM].base,
                                 l2lim_mem);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index c53409e4f1..9f1a1b5898 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -179,7 +179,7 @@ static void spike_board_init(MachineState *machine)
         machine->ram);
 
     /* boot rom */
-    memory_region_init_rom(mask_rom, NULL, "riscv.spike.mrom",
+    memory_region_init_rom(mask_rom, OBJECT(machine), "riscv.spike.mrom",
                            memmap[SPIKE_MROM].size, &error_fatal);
     memory_region_add_subregion(system_memory, memmap[SPIKE_MROM].base,
                                 mask_rom);
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 068a0bc542..e378f6e856 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -538,7 +538,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
                                 s->memmap[TT_ATL_DDR_LO].base, ram_lo);
 
     /* Boot ROM */
-    memory_region_init_rom(bootrom, NULL, "tt-atlantis.bootrom",
+    memory_region_init_rom(bootrom, OBJECT(machine), "tt-atlantis.bootrom",
                            s->memmap[TT_ATL_BOOTROM].size, &error_fatal);
     memory_region_add_subregion(system_memory, s->memmap[TT_ATL_BOOTROM].base,
                                 bootrom);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 718b730a4d..3442edb87a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1462,7 +1462,7 @@ static void virt_machine_init(MachineState *machine)
                                 machine->ram);
 
     /* boot rom */
-    memory_region_init_rom(mask_rom, NULL, "riscv_virt_board.mrom",
+    memory_region_init_rom(mask_rom, OBJECT(machine), "riscv_virt_board.mrom",
                            s->memmap[VIRT_MROM].size, &error_fatal);
     memory_region_add_subregion(system_memory, s->memmap[VIRT_MROM].base,
                                 mask_rom);
-- 
2.47.1


