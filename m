Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98144C44506
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wighC-0002YX-Dk; Sat, 11 Jul 2026 19:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigh9-0002Un-5m; Sat, 11 Jul 2026 19:01:15 -0400
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.155.198.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigh6-0002I0-RF; Sat, 11 Jul 2026 19:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810872; x=1815346872;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1CchIhLIesii1Pr3uVPdGr5jWwBPnZsbtALftaLa2u4=;
 b=R3yOTXTqhMwBMtjPz/SKIp6055HYXVeYFrhW59AXRASwmXIeB7de3/Iv
 hBn+BSWPNYKYNgIUpsTTE69kDf4j3j9iA2IICPY/w/sXHJA0ou6IABa2S
 u34gujOE/TAj5l6V0Q9PiTGqFuDRnkwuZ0ty8v7jH5m87xh68mbFRaggM
 YpX+3FnOjZeTTeZqNivu8YBUcCPtULD15FacE6fQ24r8AlLF3e/xZOhi0
 OYjqfPCubeqoahH8UH4l7JflefdiIgApn7KeWxWkAH5hfFZ/u4GJox/kM
 p66prRb+qVoK2RI4nvvmtKp9fmkGRxWYpbZprzq1ZxDg9ziKjRtl55/yU w==;
X-CSE-ConnectionGUID: /+1HF/7/QZG4kbb3Gms2Ig==
X-CSE-MsgGUID: /85l6TTTR3SKlzhqFS0K6A==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23390659"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:01:09 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:3274]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.115:2525]
 with esmtp (Farcaster)
 id 27e625e1-174b-4ac7-b0a0-3b2e928974bf; Sat, 11 Jul 2026 23:01:08 +0000 (UTC)
X-Farcaster-Flow-ID: 27e625e1-174b-4ac7-b0a0-3b2e928974bf
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:01:08 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:01:00 +0000
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
Subject: [RFC PATCH 091/134] hw/mips: Give memory regions an explicit owner
Date: Sat, 11 Jul 2026 22:36:24 +0000
Message-ID: <20260711223707.42139-92-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=35.155.198.111;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
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
the enclosing machine instead. All sites are inside board init
functions (MachineState *machine) or a helper that already carries
an Object *parent from the earlier hw/mips device-parenting patch (malta_fpga_init).

No functional change intended.

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/mips/boston.c         |  8 ++++----
 hw/mips/fuloong2e.c      |  2 +-
 hw/mips/jazz.c           | 16 ++++++++--------
 hw/mips/loongson3_virt.c |  6 +++---
 hw/mips/malta.c          | 12 ++++++------
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index a156b218fb..f012f22307 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -711,7 +711,7 @@ static void boston_mach_init(MachineState *machine)
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
 
     flash =  g_new(MemoryRegion, 1);
-    memory_region_init_rom(flash, NULL, "boston.flash",
+    memory_region_init_rom(flash, OBJECT(machine), "boston.flash",
                            boston_memmap[BOSTON_FLASH].size, &error_fatal);
     memory_region_add_subregion_overlap(sys_mem,
                                         boston_memmap[BOSTON_FLASH].base,
@@ -722,7 +722,7 @@ static void boston_mach_init(MachineState *machine)
                                         machine->ram, 0);
 
     ddr_low_alias = g_new(MemoryRegion, 1);
-    memory_region_init_alias(ddr_low_alias, NULL, "boston_low.ddr",
+    memory_region_init_alias(ddr_low_alias, OBJECT(machine), "boston_low.ddr",
                              machine->ram, 0,
                              MIN(machine->ram_size, (256 * MiB)));
     memory_region_add_subregion_overlap(sys_mem, 0, ddr_low_alias, 0);
@@ -749,7 +749,7 @@ static void boston_mach_init(MachineState *machine)
                              get_cps_irq(&s->cps, 0));
 
     platreg = g_new(MemoryRegion, 1);
-    memory_region_init_io(platreg, NULL, &boston_platreg_ops, s,
+    memory_region_init_io(platreg, OBJECT(machine), &boston_platreg_ops, s,
                           "boston-platregs",
                           boston_memmap[BOSTON_PLATREG].size);
     memory_region_add_subregion_overlap(sys_mem,
@@ -761,7 +761,7 @@ static void boston_mach_init(MachineState *machine)
                              serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
     lcd = g_new(MemoryRegion, 1);
-    memory_region_init_io(lcd, NULL, &boston_lcd_ops, s, "boston-lcd", 0x8);
+    memory_region_init_io(lcd, OBJECT(machine), &boston_lcd_ops, s, "boston-lcd", 0x8);
     memory_region_add_subregion_overlap(sys_mem,
                                         boston_memmap[BOSTON_LCD].base, lcd, 0);
 
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 1b105ca37c..29e6561f2a 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -245,7 +245,7 @@ static void mips_fuloong2e_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0, machine->ram);
 
     /* Boot ROM */
-    memory_region_init_rom(bios, NULL, "fuloong2e.bios", BIOS_SIZE,
+    memory_region_init_rom(bios, OBJECT(machine), "fuloong2e.bios", BIOS_SIZE,
                            &error_fatal);
     memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
 
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index cb24d8c00d..8999efb352 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -234,9 +234,9 @@ static void mips_jazz_init(MachineState *machine,
     /* allocate RAM */
     memory_region_add_subregion(address_space, 0, machine->ram);
 
-    memory_region_init_rom(bios, NULL, "mips_jazz.bios", MAGNUM_BIOS_SIZE,
+    memory_region_init_rom(bios, OBJECT(machine), "mips_jazz.bios", MAGNUM_BIOS_SIZE,
                            &error_fatal);
-    memory_region_init_alias(bios2, NULL, "mips_jazz.bios", bios,
+    memory_region_init_alias(bios2, OBJECT(machine), "mips_jazz.bios", bios,
                              0, MAGNUM_BIOS_SIZE);
     memory_region_add_subregion(address_space, 0x1fc00000LL, bios);
     memory_region_add_subregion(address_space, 0xfff00000LL, bios2);
@@ -270,17 +270,17 @@ static void mips_jazz_init(MachineState *machine,
                                 sysbus_mmio_get_region(sysbus, 0));
     memory_region_add_subregion(address_space, 0xf0000000,
                                 sysbus_mmio_get_region(sysbus, 1));
-    memory_region_init_io(dma_dummy, NULL, &dma_dummy_ops,
+    memory_region_init_io(dma_dummy, OBJECT(machine), &dma_dummy_ops,
                           NULL, "dummy_dma", 0x1000);
     memory_region_add_subregion(address_space, 0x8000d000, dma_dummy);
 
-    memory_region_init_rom(dp8393x_prom, NULL, "dp8393x-jazz.prom",
+    memory_region_init_rom(dp8393x_prom, OBJECT(machine), "dp8393x-jazz.prom",
                            SONIC_PROM_SIZE, &error_fatal);
     memory_region_add_subregion(address_space, 0x8000b000, dp8393x_prom);
 
     /* ISA bus: IO space at 0x90000000, mem space at 0x91000000 */
-    memory_region_init(isa_io, NULL, "isa-io", 0x00010000);
-    memory_region_init(isa_mem, NULL, "isa-mem", 0x01000000);
+    memory_region_init(isa_io, OBJECT(machine), "isa-io", 0x00010000);
+    memory_region_init(isa_mem, OBJECT(machine), "isa-mem", 0x01000000);
     memory_region_add_subregion(address_space, 0x90000000, isa_io);
     memory_region_add_subregion(address_space, 0x91000000, isa_mem);
     isa_bus = isa_bus_new_bridge(OBJECT(machine), isa_mem, isa_io, &error_abort);
@@ -306,7 +306,7 @@ static void mips_jazz_init(MachineState *machine,
         {
             /* Simple ROM, so user doesn't have to provide one */
             MemoryRegion *rom_mr = g_new(MemoryRegion, 1);
-            memory_region_init_rom(rom_mr, NULL, "g364fb.rom", 0x80000,
+            memory_region_init_rom(rom_mr, OBJECT(machine), "g364fb.rom", 0x80000,
                                    &error_fatal);
             uint8_t *rom = memory_region_get_ram_ptr(rom_mr);
             memory_region_add_subregion(address_space, 0x60000000, rom_mr);
@@ -357,7 +357,7 @@ static void mips_jazz_init(MachineState *machine,
 
     /* Real time clock */
     mc146818_rtc_init(OBJECT(machine), isa_bus, 1980, NULL);
-    memory_region_init_io(rtc, NULL, &rtc_ops, NULL, "rtc", 0x1000);
+    memory_region_init_io(rtc, OBJECT(machine), &rtc_ops, NULL, "rtc", 0x1000);
     memory_region_add_subregion(address_space, 0x80004000, rtc);
 
     /* Keyboard (i8042) */
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 93c14026ab..97d097373d 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -586,11 +586,11 @@ static void mips_loongson3_virt_init(MachineState *machine)
     assert(cpu); /* This variable points to the first created cpu. */
 
     /* Allocate RAM/BIOS, 0x00000000~0x10000000 is alias of 0x80000000~0x90000000 */
-    memory_region_init_rom(bios, NULL, "loongson3.bios",
+    memory_region_init_rom(bios, OBJECT(machine), "loongson3.bios",
                            virt_memmap[VIRT_BIOS_ROM].size, &error_fatal);
-    memory_region_init_alias(ram, NULL, "loongson3.lowmem",
+    memory_region_init_alias(ram, OBJECT(machine), "loongson3.lowmem",
                            machine->ram, 0, virt_memmap[VIRT_LOWMEM].size);
-    memory_region_init_io(iomem, NULL, &loongson3_pm_ops,
+    memory_region_init_io(iomem, OBJECT(machine), &loongson3_pm_ops,
                            NULL, "loongson3_pm", virt_memmap[VIRT_PM].size);
     qemu_register_wakeup_support();
 
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 72bc97625f..e1d8c3b4dd 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -577,11 +577,11 @@ static MaltaFPGAState *malta_fpga_init(Object *parent, MemoryRegion *address_spa
 
     s = g_new0(MaltaFPGAState, 1);
 
-    memory_region_init_io(&s->iomem, NULL, &malta_fpga_ops, s,
+    memory_region_init_io(&s->iomem, parent, &malta_fpga_ops, s,
                           "malta-fpga", 0x100000);
-    memory_region_init_alias(&s->iomem_lo, NULL, "malta-fpga",
+    memory_region_init_alias(&s->iomem_lo, parent, "malta-fpga",
                              &s->iomem, 0, 0x900);
-    memory_region_init_alias(&s->iomem_hi, NULL, "malta-fpga",
+    memory_region_init_alias(&s->iomem_hi, parent, "malta-fpga",
                              &s->iomem, 0xa00, 0x100000 - 0xa00);
 
     memory_region_add_subregion(address_space, base, &s->iomem_lo);
@@ -1115,14 +1115,14 @@ void mips_malta_init(MachineState *machine)
     memory_region_add_subregion(system_memory, 0x80000000, machine->ram);
 
     /* alias for pre IO hole access */
-    memory_region_init_alias(ram_low_preio, NULL, "mips_malta_low_preio.ram",
+    memory_region_init_alias(ram_low_preio, OBJECT(machine), "mips_malta_low_preio.ram",
                              machine->ram, 0, MIN(ram_size, 256 * MiB));
     memory_region_add_subregion(system_memory, 0, ram_low_preio);
 
     /* alias for post IO hole access, if there is enough RAM */
     if (ram_size > 512 * MiB) {
         ram_low_postio = g_new(MemoryRegion, 1);
-        memory_region_init_alias(ram_low_postio, NULL,
+        memory_region_init_alias(ram_low_postio, OBJECT(machine),
                                  "mips_malta_low_postio.ram",
                                  machine->ram, 512 * MiB,
                                  ram_size - 512 * MiB);
@@ -1213,7 +1213,7 @@ void mips_malta_init(MachineState *machine)
      * handled by an overlapping region as the resulting ROM code subpage
      * regions are not executable.
      */
-    memory_region_init_ram(bios_copy, NULL, "bios.1fc", BIOS_SIZE,
+    memory_region_init_ram(bios_copy, OBJECT(machine), "bios.1fc", BIOS_SIZE,
                            &error_fatal);
     if (!rom_copy(memory_region_get_ram_ptr(bios_copy),
                   FLASH_ADDRESS, BIOS_SIZE)) {
-- 
2.47.1


