Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A847C44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 23:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigjC-0005Xi-Hr; Sat, 11 Jul 2026 19:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigip-0005Q0-Ea; Sat, 11 Jul 2026 19:03:11 -0400
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([50.112.246.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigim-0002e4-Mx; Sat, 11 Jul 2026 19:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783810976; x=1815346976;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mupvrQmP/1C1UdxWHHAvm3q1pIt62nT2Ls7KUj9l5W0=;
 b=EyaAULhx6OsniDGQG3xwcorlwaQa0ypo/QXhBAjji6JPDcS4zLPPSRfI
 gnQXh88hgasNkcs32WM1AOYh5gLWUuBZ0SR5eL57TPDTsDMocC9j44aXs
 1sOtEShPxcSo8n3rRSrS/ZK4fbEsGt3M6cIz53TTsaF9E7TMQ0XIy1k1z
 UVssiBod98bPo6YzlH4LnnqT0oPK6tz+mo7MV9WpSHPL7XM5bfJw5q2C9
 WB0x9zYUm0caR9MNBDyurKn1awQuFZAJwJmvQXf8JDXtlI+kztCl9bwLE
 s4B9+mgoOrxfx/gql7bu92naRPS1DwrMWtIup8mKj6TxPKqLxQs1xYZV4 w==;
X-CSE-ConnectionGUID: UDC2m+UhTiKl4q5hXhYg2A==
X-CSE-MsgGUID: mvHw0ARjRPWJ3xmb/Qexzg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23300211"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 23:02:52 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:19391]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.68:2525]
 with esmtp (Farcaster)
 id 6d9a9e20-2426-4635-8be1-dc4a457f5021; Sat, 11 Jul 2026 23:02:52 +0000 (UTC)
X-Farcaster-Flow-ID: 6d9a9e20-2426-4635-8be1-dc4a457f5021
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:02:52 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 23:02:43 +0000
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
Subject: [RFC PATCH 098/134] hw/ppc: Give memory regions an explicit owner
Date: Sat, 11 Jul 2026 22:36:31 +0000
Message-ID: <20260711223707.42139-99-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260711223707.42139-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
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

Convert memory_region_init*() calls that pass NULL owner to pass
the enclosing machine or device instead.

Thread Object *owner through ppc4xx_l2sram_init() (called from sam460ex board init) and the static ppc4xx_sdram_banks() / sdram_bank_map() / sdram_bank_set_bcr() helpers (called from ppc4xx-sdram-ddr[2] realize and DCR write callbacks that already carry the device state).

No functional change intended.

Assisted-by: Kiro
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/ppc/amigaone.c      |  6 +++---
 hw/ppc/mac_newworld.c  |  2 +-
 hw/ppc/mac_oldworld.c  |  2 +-
 hw/ppc/pegasos.c       |  2 +-
 hw/ppc/ppc440.h        |  2 +-
 hw/ppc/ppc440_bamboo.c |  2 +-
 hw/ppc/ppc440_uc.c     | 10 +++++-----
 hw/ppc/ppc4xx_sdram.c  | 34 +++++++++++++++++-----------------
 hw/ppc/prep.c          |  2 +-
 hw/ppc/sam460ex.c      |  4 ++--
 10 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 60aed15a6e..4a4e52c1fe 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -130,7 +130,7 @@ static void nvram_realize(DeviceState *dev, Error **errp)
     void *p;
     uint32_t crc, *c;
 
-    memory_region_init_rom_device(&s->mr, NULL, &nvram_ops, s, "nvram",
+    memory_region_init_rom_device(&s->mr, OBJECT(dev), &nvram_ops, s, "nvram",
                                   NVRAM_SIZE, &error_fatal);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
     c = p = memory_region_get_ram_ptr(&s->mr);
@@ -297,7 +297,7 @@ static void amigaone_init(MachineState *machine)
     if (machine->ram_size < 1 * GiB + 32 * KiB) {
         /* Firmware uses this area for startup */
         mr = g_new(MemoryRegion, 1);
-        memory_region_init_ram(mr, NULL, "init-cache", 32 * KiB, &error_fatal);
+        memory_region_init_ram(mr, OBJECT(machine), "init-cache", 32 * KiB, &error_fatal);
         memory_region_add_subregion(get_system_memory(), INIT_RAM_ADDR, mr);
     }
 
@@ -313,7 +313,7 @@ static void amigaone_init(MachineState *machine)
 
     /* allocate and load firmware */
     rom = g_new(MemoryRegion, 1);
-    memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal);
+    memory_region_init_rom(rom, OBJECT(machine), "rom", PROM_SIZE, &error_fatal);
     memory_region_add_subregion(get_system_memory(), PROM_ADDR, rom);
     if (!machine->firmware) {
         rom_add_blob_fixed("dummy-fw", dummy_fw, sizeof(dummy_fw),
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index a6af53e21a..392a1fb87d 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -176,7 +176,7 @@ static void ppc_core99_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), 0, machine->ram);
 
     /* allocate and load firmware ROM */
-    memory_region_init_rom(bios, NULL, "ppc_core99.bios", PROM_SIZE,
+    memory_region_init_rom(bios, OBJECT(machine), "ppc_core99.bios", PROM_SIZE,
                            &error_fatal);
     memory_region_add_subregion(get_system_memory(), PROM_BASE, bios);
 
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index f9b62a518a..0fe8dfaf8c 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -130,7 +130,7 @@ static void ppc_heathrow_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), 0, machine->ram);
 
     /* allocate and load firmware ROM */
-    memory_region_init_rom(bios, NULL, "ppc_heathrow.bios", PROM_SIZE,
+    memory_region_init_rom(bios, OBJECT(machine), "ppc_heathrow.bios", PROM_SIZE,
                            &error_fatal);
     memory_region_add_subregion(get_system_memory(), PROM_BASE, bios);
 
diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index 4917d8137a..426a54d8ee 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -194,7 +194,7 @@ static void pegasos_init(MachineState *machine)
     if (pm->type == PEGASOS1) {
         prom_addr += PROM_SIZE;
     }
-    memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal);
+    memory_region_init_rom(rom, OBJECT(machine), "rom", PROM_SIZE, &error_fatal);
     memory_region_add_subregion(get_system_memory(), prom_addr, rom);
     sz = load_elf(filename, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
                   ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
diff --git a/hw/ppc/ppc440.h b/hw/ppc/ppc440.h
index 909373fb38..192b76adc4 100644
--- a/hw/ppc/ppc440.h
+++ b/hw/ppc/ppc440.h
@@ -13,7 +13,7 @@
 
 #include "hw/ppc/ppc.h"
 
-void ppc4xx_l2sram_init(CPUPPCState *env);
+void ppc4xx_l2sram_init(Object *owner, CPUPPCState *env);
 void ppc4xx_cpr_init(CPUPPCState *env);
 void ppc4xx_sdr_init(CPUPPCState *env);
 void ppc4xx_ahb_init(CPUPPCState *env);
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 2d9efeba77..5aad2a504b 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -194,7 +194,7 @@ static void bamboo_init(MachineState *machine)
         exit(1);
     }
 
-    memory_region_init_alias(isa, NULL, "isa_mmio",
+    memory_region_init_alias(isa, OBJECT(machine), "isa_mmio",
                              get_system_io(), 0, PPC440EP_PCI_IOLEN);
     memory_region_add_subregion(get_system_memory(), PPC440EP_PCI_IO, isa);
 
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 016c756c19..e86519326e 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -167,19 +167,19 @@ static void l2sram_reset(void *opaque)
     memset(l2sram->isram0, 0, sizeof(l2sram->isram0));
 }
 
-void ppc4xx_l2sram_init(CPUPPCState *env)
+void ppc4xx_l2sram_init(Object *owner, CPUPPCState *env)
 {
     ppc4xx_l2sram_t *l2sram;
 
     l2sram = g_malloc0(sizeof(*l2sram));
     /* XXX: Size is 4*64kB for 460ex, cf. U-Boot, ppc4xx-isram.h */
-    memory_region_init_ram(&l2sram->bank[0], NULL, "ppc4xx.l2sram_bank0",
+    memory_region_init_ram(&l2sram->bank[0], owner, "ppc4xx.l2sram_bank0",
                            64 * KiB, &error_abort);
-    memory_region_init_ram(&l2sram->bank[1], NULL, "ppc4xx.l2sram_bank1",
+    memory_region_init_ram(&l2sram->bank[1], owner, "ppc4xx.l2sram_bank1",
                            64 * KiB, &error_abort);
-    memory_region_init_ram(&l2sram->bank[2], NULL, "ppc4xx.l2sram_bank2",
+    memory_region_init_ram(&l2sram->bank[2], owner, "ppc4xx.l2sram_bank2",
                            64 * KiB, &error_abort);
-    memory_region_init_ram(&l2sram->bank[3], NULL, "ppc4xx.l2sram_bank3",
+    memory_region_init_ram(&l2sram->bank[3], owner, "ppc4xx.l2sram_bank3",
                            64 * KiB, &error_abort);
     qemu_register_reset(&l2sram_reset, l2sram);
     ppc_dcr_register(env, DCR_L2CACHE_CFG,
diff --git a/hw/ppc/ppc4xx_sdram.c b/hw/ppc/ppc4xx_sdram.c
index b2c8f96d5f..8be3bb3160 100644
--- a/hw/ppc/ppc4xx_sdram.c
+++ b/hw/ppc/ppc4xx_sdram.c
@@ -53,7 +53,7 @@
  * must be one of a small set of sizes. The number of banks and the supported
  * sizes varies by SoC.
  */
-static bool ppc4xx_sdram_banks(MemoryRegion *ram, int nr_banks,
+static bool ppc4xx_sdram_banks(Object *owner, MemoryRegion *ram, int nr_banks,
                                Ppc4xxSdramBank ram_banks[],
                                const ram_addr_t sdram_bank_sizes[],
                                Error **errp)
@@ -76,7 +76,7 @@ static bool ppc4xx_sdram_banks(MemoryRegion *ram, int nr_banks,
                 base += bank_size;
                 size_left -= bank_size;
                 snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
-                memory_region_init_alias(&ram_banks[i].ram, NULL, name, ram,
+                memory_region_init_alias(&ram_banks[i].ram, owner, name, ram,
                                          ram_banks[i].base, ram_banks[i].size);
                 break;
             }
@@ -108,10 +108,10 @@ static bool ppc4xx_sdram_banks(MemoryRegion *ram, int nr_banks,
     return true;
 }
 
-static void sdram_bank_map(Ppc4xxSdramBank *bank)
+static void sdram_bank_map(Object *owner, Ppc4xxSdramBank *bank)
 {
     trace_ppc4xx_sdram_map(bank->base, bank->size);
-    memory_region_init(&bank->container, NULL, "sdram-container", bank->size);
+    memory_region_init(&bank->container, owner, "sdram-container", bank->size);
     memory_region_add_subregion(&bank->container, 0, &bank->ram);
     memory_region_add_subregion(get_system_memory(), bank->base,
                                 &bank->container);
@@ -125,7 +125,7 @@ static void sdram_bank_unmap(Ppc4xxSdramBank *bank)
     object_unparent(OBJECT(&bank->container));
 }
 
-static void sdram_bank_set_bcr(Ppc4xxSdramBank *bank, uint32_t bcr,
+static void sdram_bank_set_bcr(Object *owner, Ppc4xxSdramBank *bank, uint32_t bcr,
                                hwaddr base, hwaddr size, int enabled)
 {
     if (memory_region_is_mapped(&bank->container)) {
@@ -135,7 +135,7 @@ static void sdram_bank_set_bcr(Ppc4xxSdramBank *bank, uint32_t bcr,
     bank->base = base;
     bank->size = size;
     if (enabled && (bcr & 1)) {
-        sdram_bank_map(bank);
+        sdram_bank_map(owner, bank);
     }
 }
 
@@ -296,7 +296,7 @@ static void sdram_ddr_dcr_write(void *opaque, int dcrn, uint32_t val)
                 /* validate all RAM mappings */
                 for (i = 0; i < s->nbanks; i++) {
                     if (s->bank[i].size) {
-                        sdram_bank_set_bcr(&s->bank[i], s->bank[i].bcr,
+                        sdram_bank_set_bcr(OBJECT(s), &s->bank[i], s->bank[i].bcr,
                                            s->bank[i].base, s->bank[i].size,
                                            1);
                     }
@@ -307,7 +307,7 @@ static void sdram_ddr_dcr_write(void *opaque, int dcrn, uint32_t val)
                 /* invalidate all RAM mappings */
                 for (i = 0; i < s->nbanks; i++) {
                     if (s->bank[i].size) {
-                        sdram_bank_set_bcr(&s->bank[i], s->bank[i].bcr,
+                        sdram_bank_set_bcr(OBJECT(s), &s->bank[i], s->bank[i].bcr,
                                            s->bank[i].base, s->bank[i].size,
                                            0);
                     }
@@ -337,7 +337,7 @@ static void sdram_ddr_dcr_write(void *opaque, int dcrn, uint32_t val)
             i = (s->addr - 0x40) / 4;
             val &= SDRAM_DDR_BCR_MASK;
             if (s->bank[i].size) {
-                sdram_bank_set_bcr(&s->bank[i], val,
+                sdram_bank_set_bcr(OBJECT(s), &s->bank[i], val,
                                    sdram_ddr_base(val), sdram_ddr_size(val),
                                    s->cfg & 0x80000000);
             }
@@ -400,17 +400,17 @@ static void ppc4xx_sdram_ddr_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "Missing dram memory region");
         return;
     }
-    if (!ppc4xx_sdram_banks(s->dram_mr, s->nbanks, s->bank,
+    if (!ppc4xx_sdram_banks(OBJECT(s), s->dram_mr, s->nbanks, s->bank,
                             valid_bank_sizes, errp)) {
         return;
     }
     for (i = 0; i < s->nbanks; i++) {
         if (s->bank[i].size) {
             s->bank[i].bcr = sdram_ddr_bcr(s->bank[i].base, s->bank[i].size);
-            sdram_bank_set_bcr(&s->bank[i], s->bank[i].bcr,
+            sdram_bank_set_bcr(OBJECT(s), &s->bank[i], s->bank[i].bcr,
                                s->bank[i].base, s->bank[i].size, 0);
         } else {
-            sdram_bank_set_bcr(&s->bank[i], 0, 0, 0, 0);
+            sdram_bank_set_bcr(OBJECT(s), &s->bank[i], 0, 0, 0, 0);
         }
         trace_ppc4xx_sdram_init(sdram_ddr_base(s->bank[i].bcr),
                                 sdram_ddr_size(s->bank[i].bcr),
@@ -607,7 +607,7 @@ static void sdram_ddr2_dcr_write(void *opaque, int dcrn, uint32_t val)
                 /* validate all RAM mappings */
                 for (i = 0; i < s->nbanks; i++) {
                     if (s->bank[i].size) {
-                        sdram_bank_set_bcr(&s->bank[i], s->bank[i].bcr,
+                        sdram_bank_set_bcr(OBJECT(s), &s->bank[i], s->bank[i].bcr,
                                            s->bank[i].base, s->bank[i].size,
                                            1);
                     }
@@ -619,7 +619,7 @@ static void sdram_ddr2_dcr_write(void *opaque, int dcrn, uint32_t val)
                 /* invalidate all RAM mappings */
                 for (i = 0; i < s->nbanks; i++) {
                     if (s->bank[i].size) {
-                        sdram_bank_set_bcr(&s->bank[i], s->bank[i].bcr,
+                        sdram_bank_set_bcr(OBJECT(s), &s->bank[i], s->bank[i].bcr,
                                            s->bank[i].base, s->bank[i].size,
                                            0);
                     }
@@ -666,7 +666,7 @@ static void ppc4xx_sdram_ddr2_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "Missing dram memory region");
         return;
     }
-    if (!ppc4xx_sdram_banks(s->dram_mr, s->nbanks, s->bank,
+    if (!ppc4xx_sdram_banks(OBJECT(s), s->dram_mr, s->nbanks, s->bank,
                             valid_bank_sizes, errp)) {
         return;
     }
@@ -674,10 +674,10 @@ static void ppc4xx_sdram_ddr2_realize(DeviceState *dev, Error **errp)
         if (s->bank[i].size) {
             s->bank[i].bcr = sdram_ddr2_bcr(s->bank[i].base, s->bank[i].size);
             s->bank[i].bcr &= SDRAM_DDR2_BCR_MASK;
-            sdram_bank_set_bcr(&s->bank[i], s->bank[i].bcr,
+            sdram_bank_set_bcr(OBJECT(s), &s->bank[i], s->bank[i].bcr,
                                s->bank[i].base, s->bank[i].size, 0);
         } else {
-            sdram_bank_set_bcr(&s->bank[i], 0, 0, 0, 0);
+            sdram_bank_set_bcr(OBJECT(s), &s->bank[i], 0, 0, 0, 0);
         }
         trace_ppc4xx_sdram_init(sdram_ddr2_base(s->bank[i].bcr),
                                 sdram_ddr2_size(s->bank[i].bcr),
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 52f94b206a..c79736a1f3 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -274,7 +274,7 @@ static void ibm_40p_init(MachineState *machine)
         error_report("Could not find bios image '%s'", bios_name);
         exit(1);
     }
-    memory_region_init_rom(bios, NULL, "bios", BIOS_SIZE, &error_fatal);
+    memory_region_init_rom(bios, OBJECT(machine), "bios", BIOS_SIZE, &error_fatal);
     memory_region_add_subregion(get_system_memory(), BIOS_ADDR, bios);
     bios_size = load_elf(filename, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
                          ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 59c217e2b2..20b2acb40b 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -375,9 +375,9 @@ static void sam460ex_init(MachineState *machine)
     ppc4xx_dma_init(env, 0x200);
 
     /* 256K of L2 cache as memory */
-    ppc4xx_l2sram_init(env);
+    ppc4xx_l2sram_init(OBJECT(machine), env);
     /* FIXME: remove this after fixing l2sram mapping in ppc440_uc.c? */
-    memory_region_init_ram(l2cache_ram, NULL, "ppc440.l2cache_ram", 256 * KiB,
+    memory_region_init_ram(l2cache_ram, OBJECT(machine), "ppc440.l2cache_ram", 256 * KiB,
                            &error_abort);
     memory_region_add_subregion(get_system_memory(), 0x400000000LL,
                                 l2cache_ram);
-- 
2.47.1


