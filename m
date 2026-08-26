Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51ED2C61DC4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLrV-0001uG-N3; Wed, 26 Aug 2026 18:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLrT-0001tY-2V
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:12:47 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLrN-0006cd-9r
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:12:43 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso1907657a91.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 15:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787782360; x=1788387160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cYrYRFsDEYadIwXO/tqyMC/amdwUYkmKIWK3I1LucWI=;
 b=aYszlS35V2jgtkrQtCIVmOW5kgctrWRcYDGIYYR4BnDhZbJvV6I4HjQGYlEPiS/tkK
 /hB4lsiZzMBbM2VmlQhbOxa0W3l7bBPTopomVdAcNTfft4XuHlyawkOvL7IaPXiMmJ/A
 cgcXJLLWKfa6H9aRBj1VFJzlH3sW9gd3Me7lv4WFyrmnQGikHHDB3lo59WC8XUx3AiRF
 aV/Svui0aEgxkNaOTi96/BI2D4PvmtJ0GG+Bo7Bmuyex0/SoBumiba452niFQ7O0XmtR
 I1OHyPTFD8VEZABdJencTTnUI3FzLeeozhXIKHEA9zHIVot+NRNp44WxUiLXdaUztEAI
 UNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787782360; x=1788387160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cYrYRFsDEYadIwXO/tqyMC/amdwUYkmKIWK3I1LucWI=;
 b=JaNlOylepev/rhBhiEiKDoFGJaN8HqgcTZ5tF2/tOnarBTGRI2NW7uQxv+hXr+Xycr
 GT7N2u5VhKt9ZbD1IRHrlH+SvyyXdnOditO3PlN1hDect/LF8ZxZcdJeL1HITxTHRNaD
 yTO9oQVp5k//E9/r6XNNNhaT8hJOr4ifCQwcT0M2nK04fWKQnl++nP7U1J0FT+abH8KJ
 Apuo55Z+Psw/WxaX3AxdaQNsTBYX2y/sCQ2nHnv/OK4NEqGpgPTPPXtC3FIRnt7FMqKH
 PSfjnKlq7OPvlYBy4WccCp2jhWuiwHS2t36sIn7RvjkYzQPUXHp3hhPMWeuClLeii+bx
 SVtA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpq/+3WnotYCuJsP8ovdRjEhSgrrEbzGGHyKJY6gEje9xI/NioivtLdMIj1qMLfSSspZnnquwLKGCVb@nongnu.org
X-Gm-Message-State: AFuF++miqhvyQ6IiXxFf1RxyVE290PkaJZYLsE6AhOUwyvM1QbucKLYe
 zQmY6bQk2dcsJpkCMXhC94CR2cdZ0hRawJVfXbvtBZY3/7R1etxw8PEp
X-Gm-Gg: AR+sD10jXG1u0jikncL2sxHYD8TOXymJP4AyLCklD2+Wj/ee3xXEhZdWJFDZeN4xHxX
 JTeXYlD1z7cNVBF8pWc7MqZ9hlykn0Ij0p7J7QYKcWQ69wkJ37Xw09I3BatF2CJuO/6klh/1Rog
 nSRYiXamDmTXRkrvu36fHr1RREDzfkLf8gd0HBOX3FDzfsMDxjHwTnQ4yHMkOrNViOHffeR7MYO
 vKX47BBkeLgN15P35kcnVWPriStt5bAt2Mh8zYEmVBzv6NRcFW7fdDiCqUh6V25D1NoSOE+OSpg
 A4YNcLT70UABPgY2Z6WEp338s6b8KjbkWC8hrxj5tCSnrjpnZme7Oa6kgx4dAkYUd6sLXed6Ogn
 HnBz5bkR1FKDrgG7L91KU9/sy5tLfy8Tbfo9M0iShX4ISGogDz+MziMbGMR19MtdRuRCWoSnLJD
 NBj9ltMAQGo7nAnKeZRRzmx41U0fABqRPAkg722WzEbKxIM48cjG27noLcIMgQK6Yp1m7UWQH95
 sFDwBlrhXcDQD7u5idQaLapa9O81cqKsXNu8TQSYHYkmvRGQKX2u3q/JphZXZ7DNWACJr3Swh6W
 jZXVF2D0scOaNGPhhPgu
X-Received: by 2002:a17:90b:4a50:b0:396:61f1:da5c with SMTP id
 98e67ed59e1d1-3966d3aabe3mr19314007a91.4.1787782359865; 
 Wed, 26 Aug 2026 15:12:39 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0d3d7fbsm17459a91.3.2026.08.26.15.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 15:12:39 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 15/16] hw/riscv/atlantis: Extract an Atlantis SoC device
Date: Thu, 27 Aug 2026 07:41:51 +0930
Message-ID: <20260826221154.54577-7-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260826221154.54577-1-joel@jms.id.au>
References: <20260826220528.54516-1-joel@jms.id.au>
 <20260826221154.54577-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Introduce TYPE_TT_ATLANTIS_SOC and move the hart array, AIA, ACLINT,
boot ROM, UART and I2C controllers into the new TTAtlantisSoCState. The
machine keeps ownership of RAM, device tree generation, firmware
loading, and the board-level I2C slaves.

This makes it easier to compose the SoC into a more complex machine in
the future.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/tt_atlantis.h |  21 ++++-
 hw/riscv/tt_atlantis.c         | 144 +++++++++++++++++++++++----------
 2 files changed, 119 insertions(+), 46 deletions(-)

diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
index 9ca98bfb8478..5d4e4d133bd9 100644
--- a/include/hw/riscv/tt_atlantis.h
+++ b/include/hw/riscv/tt_atlantis.h
@@ -19,14 +19,16 @@
 #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
 OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
 
+#define TYPE_TT_ATLANTIS_SOC "tt-atlantis-soc"
+OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisSoCState, TT_ATLANTIS_SOC)
+
 #define TT_ATL_NUM_I2C 5
 
-struct TTAtlantisState {
+struct TTAtlantisSoCState {
     /*< private >*/
-    MachineState parent;
+    DeviceState parent;
 
     /*< public >*/
-    Notifier machine_done;
     const MemMapEntry *memmap;
 
     MemoryRegion *memory;
@@ -39,6 +41,19 @@ struct TTAtlantisState {
     DesignWareI2CState i2c[TT_ATL_NUM_I2C];
     UnimplementedDeviceState uart1;
     MemoryRegion bootrom;
+
+    uint32_t num_harts;
+    char *cpu_type;
+};
+
+struct TTAtlantisState {
+    /*< private >*/
+    MachineState parent;
+
+    /*< public >*/
+    Notifier machine_done;
+
+    TTAtlantisSoCState soc;
 };
 
 enum {
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index b80bdf54c40b..d2b29ff1a477 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
@@ -14,6 +15,7 @@
 
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/core/sysbus.h"
 
 #include "target/riscv/cpu.h"
@@ -67,7 +69,7 @@ static const MemMapEntry tt_atlantis_memmap[] = {
     [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
 };
 
-static I2CBus *i2c_get_bus(TTAtlantisState *s, unsigned busnr)
+static I2CBus *i2c_get_bus(TTAtlantisSoCState *s, unsigned busnr)
 {
     assert(busnr < TT_ATL_NUM_I2C);
 
@@ -80,7 +82,7 @@ static uint32_t next_phandle(void)
     return fdt_phandle++;
 }
 
-static void create_fdt_memory(void *fdt, TTAtlantisState *s)
+static void create_fdt_memory(void *fdt, TTAtlantisSoCState *s)
 {
     hwaddr ram_size = memory_region_size(s->dram);
     hwaddr size_lo = ram_size;
@@ -104,7 +106,7 @@ static void create_fdt_memory(void *fdt, TTAtlantisState *s)
     }
 }
 
-static void create_fdt_aclint(void *fdt, TTAtlantisState *s,
+static void create_fdt_aclint(void *fdt, TTAtlantisSoCState *s,
                               uint32_t *intc_phandles)
 {
     g_autofree char *name = NULL;
@@ -206,7 +208,7 @@ static void create_fdt_one_aplic(void *fdt,
     qemu_fdt_setprop_cell(fdt, name, "phandle", aplic_phandle);
 }
 
-static void create_fdt_pmu(void *fdt, TTAtlantisState *s)
+static void create_fdt_pmu(void *fdt, TTAtlantisSoCState *s)
 {
     char pmu_name[] = "/pmu";
     RISCVCPU *hart = &s->cpus.harts[0];
@@ -216,7 +218,7 @@ static void create_fdt_pmu(void *fdt, TTAtlantisState *s)
     riscv_pmu_generate_fdt_node(fdt, hart->pmu_avail_ctrs, pmu_name);
 }
 
-static void create_fdt_cpu(void *fdt, TTAtlantisState *s,
+static void create_fdt_cpu(void *fdt, TTAtlantisSoCState *s,
                            uint32_t aplic_s_phandle,
                            uint32_t imsic_s_phandle)
 {
@@ -313,7 +315,7 @@ static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
     qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
 }
 
-static void create_fdt_i2c_device(void *fdt, TTAtlantisState *s, int bus,
+static void create_fdt_i2c_device(void *fdt, TTAtlantisSoCState *s, int bus,
                                   const char *compat, int addr)
 {
     hwaddr base = s->memmap[TT_ATL_I2C0 + bus].base;
@@ -325,7 +327,7 @@ static void create_fdt_i2c_device(void *fdt, TTAtlantisState *s, int bus,
     qemu_fdt_setprop_cell(fdt, name, "reg", addr);
 }
 
-static void finalize_fdt(void *fdt, TTAtlantisState *s)
+static void finalize_fdt(void *fdt, TTAtlantisSoCState *s)
 {
     uint32_t aplic_s_phandle = next_phandle();
     uint32_t imsic_s_phandle = next_phandle();
@@ -359,9 +361,9 @@ static void finalize_fdt(void *fdt, TTAtlantisState *s)
     create_fdt_i2c_device(fdt, s, 4, "ti,tmp105", 0x48);
 }
 
-static void create_fdt(TTAtlantisState *s)
+static void create_fdt(TTAtlantisState *ams)
 {
-    MachineState *ms = MACHINE(s);
+    MachineState *ms = MACHINE(ams);
     int fdt_size = 0;
 
     ms->fdt = create_board_device_tree("Tenstorrent Atlantis RISC-V Machine",
@@ -373,12 +375,12 @@ static void create_fdt(TTAtlantisState *s)
 
     qemu_fdt_add_subnode(ms->fdt, "/aliases");
 
-    create_fdt_pmu(ms->fdt, s);
+    create_fdt_pmu(ms->fdt, &ams->soc);
 }
 
-static void load_fdt(TTAtlantisState *s)
+static void load_fdt(TTAtlantisState *ams)
 {
-    MachineState *ms = MACHINE(s);
+    MachineState *ms = MACHINE(ams);
     char **node_path;
     Error *err = NULL;
     int fdt_size = 0;
@@ -404,7 +406,7 @@ static void load_fdt(TTAtlantisState *s)
         g_strfreev(node_path);
     }
 
-    create_fdt_memory(ms->fdt, s);
+    create_fdt_memory(ms->fdt, &ams->soc);
 }
 
 static void mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
@@ -418,10 +420,11 @@ static void mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
                                         sysbus_mmio_get_region(dev, 0), -1000);
 }
 
-static void tt_atlantis_machine_done(Notifier *notifier, void *data)
+static void tt_atlantis_machine_done(Notifier *n, void *data)
 {
-    TTAtlantisState *s = container_of(notifier, TTAtlantisState, machine_done);
-    MachineState *machine = MACHINE(s);
+    TTAtlantisState *ams = container_of(n, TTAtlantisState, machine_done);
+    TTAtlantisSoCState *s = &ams->soc;
+    MachineState *machine = MACHINE(ams);
     hwaddr start_addr = s->memmap[TT_ATL_DDR_LO].base;
     hwaddr mem_size;
     target_ulong firmware_end_addr, kernel_start_addr;
@@ -479,23 +482,39 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
                               fdt_load_addr);
 }
 
-static void tt_atlantis_machine_init(MachineState *machine)
+static void tt_atlantis_soc_init(Object *obj)
 {
-    TTAtlantisState *s = TT_ATLANTIS_MACHINE(machine);
+    TTAtlantisSoCState *s = TT_ATLANTIS_SOC(obj);
+
+    object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
+
+    object_initialize_child(obj, "uart1", &s->uart1,
+                            TYPE_UNIMPLEMENTED_DEVICE);
 
+    for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
+        object_initialize_child(obj, "i2c[*]", &s->i2c[i],
+                                TYPE_DESIGNWARE_I2C);
+    }
+}
+
+static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
+{
+    TTAtlantisSoCState *s = TT_ATLANTIS_SOC(dev);
     ram_addr_t lo_ram_size, ram_size;
-    int hart_count = machine->smp.cpus;
+    int hart_count = s->num_harts;
 
     s->memory = get_system_memory();
 
-    s->dram = machine->ram;
+    if (!s->dram) {
+        error_setg(errp, "'dram' link is not set");
+        return;
+    }
     ram_size = memory_region_size(s->dram);
 
     s->memmap = tt_atlantis_memmap;
 
-    object_initialize_child(OBJECT(machine), "soc", &s->cpus,
-                            TYPE_RISCV_HART_ARRAY);
-    object_property_set_str(OBJECT(&s->cpus), "cpu-type", machine->cpu_type,
+    /* CPUs */
+    object_property_set_str(OBJECT(&s->cpus), "cpu-type", s->cpu_type,
                             &error_abort);
     object_property_set_int(OBJECT(&s->cpus), "hartid-base", 0,
                             &error_abort);
@@ -504,7 +523,9 @@ static void tt_atlantis_machine_init(MachineState *machine)
     object_property_set_int(OBJECT(&s->cpus), "resetvec",
                             s->memmap[TT_ATL_BOOTROM].base,
                             &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpus), errp)) {
+        return;
+    }
 
     s->irqchip = riscv_create_aia(s->memory,
                                   true, TT_IMSIC_GUESTS,
@@ -534,26 +555,27 @@ static void tt_atlantis_machine_init(MachineState *machine)
      * up to 64GB. The low address is an alias of the first 2GB of that RAM.
      */
     if (ram_size > s->memmap[TT_ATL_DDR_HI].size) {
-        char *sz = size_to_str(s->memmap[TT_ATL_DDR_HI].size);
-        error_report("RAM size is too large, maximum is %s", sz);
-        g_free(sz);
-        exit(EXIT_FAILURE);
+        g_autofree char *sz = size_to_str(s->memmap[TT_ATL_DDR_HI].size);
+        error_setg(errp, "RAM size is too large, maximum is %s", sz);
+        return;
     }
 
-    memory_region_init_alias(&s->ram_hi, OBJECT(machine), "ram.high", s->dram,
+    memory_region_init_alias(&s->ram_hi, OBJECT(s), "ram.high", s->dram,
                              0, ram_size);
     memory_region_add_subregion(s->memory,
                                 s->memmap[TT_ATL_DDR_HI].base, &s->ram_hi);
 
     lo_ram_size = MIN(ram_size, s->memmap[TT_ATL_DDR_LO].size);
-    memory_region_init_alias(&s->ram_lo, OBJECT(machine), "ram.low", s->dram,
+    memory_region_init_alias(&s->ram_lo, OBJECT(s), "ram.low", s->dram,
                              0, lo_ram_size);
     memory_region_add_subregion(s->memory,
                                 s->memmap[TT_ATL_DDR_LO].base, &s->ram_lo);
 
     /* Boot ROM */
-    memory_region_init_rom(&s->bootrom, NULL, "tt-atlantis.bootrom",
-                           s->memmap[TT_ATL_BOOTROM].size, &error_fatal);
+    if (!memory_region_init_rom(&s->bootrom, OBJECT(s), "tt-atlantis.bootrom",
+                                s->memmap[TT_ATL_BOOTROM].size, errp)) {
+        return;
+    }
     memory_region_add_subregion(s->memory, s->memmap[TT_ATL_BOOTROM].base,
                                 &s->bootrom);
 
@@ -570,26 +592,56 @@ static void tt_atlantis_machine_init(MachineState *machine)
      * Create an unimplemented device region so writes don't fault
      * and reads return zero, which keeps Linux happy.
      */
-    object_initialize_child(OBJECT(s), "uart1", &s->uart1,
-                            TYPE_UNIMPLEMENTED_DEVICE);
     mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->uart1),
                            "tt-atlantis.uart1", s->memmap[TT_ATL_UART1].base,
                            s->memmap[TT_ATL_UART1].size);
 
     /* I2C */
     for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
-        SysBusDevice *sbd;
+        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->i2c[i]);
 
-        object_initialize_child(OBJECT(s), "i2c[*]", &s->i2c[i],
-                                TYPE_DESIGNWARE_I2C);
-        sbd = SYS_BUS_DEVICE(&s->i2c[i]);
-        sysbus_realize(sbd, &error_fatal);
+        if (!sysbus_realize(sbd, errp)) {
+            return;
+        }
         memory_region_add_subregion(s->memory,
                                     s->memmap[TT_ATL_I2C0 + i].base,
                                     sysbus_mmio_get_region(sbd, 0));
         sysbus_connect_irq(sbd, 0,
                            qdev_get_gpio_in(s->irqchip, TT_ATL_I2C0_IRQ + i));
     }
+}
+
+static const Property tt_atlantis_soc_props[] = {
+    DEFINE_PROP_STRING("cpu-type", TTAtlantisSoCState, cpu_type),
+    DEFINE_PROP_UINT32("num-harts", TTAtlantisSoCState, num_harts, 8),
+    DEFINE_PROP_LINK("dram", TTAtlantisSoCState, dram,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
+};
+
+static void tt_atlantis_soc_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = tt_atlantis_soc_realize;
+    device_class_set_props(dc, tt_atlantis_soc_props);
+    /* The SoC can only be instantiated from the machine */
+    dc->user_creatable = false;
+}
+
+static void tt_atlantis_machine_init(MachineState *machine)
+{
+    TTAtlantisState *ams = TT_ATLANTIS_MACHINE(machine);
+    TTAtlantisSoCState *s = &ams->soc;
+
+    object_initialize_child(OBJECT(machine), "soc", &ams->soc,
+                            TYPE_TT_ATLANTIS_SOC);
+    object_property_set_str(OBJECT(&ams->soc), "cpu-type", machine->cpu_type,
+                            &error_abort);
+    object_property_set_int(OBJECT(&ams->soc), "num-harts", machine->smp.cpus,
+                            &error_abort);
+    object_property_set_link(OBJECT(&ams->soc), "dram", OBJECT(machine->ram),
+                             &error_abort);
+    qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
 
     /* I2C peripherals: qemu specific */
     i2c_slave_create_simple(i2c_get_bus(s, 0), "ds1338", 0x6f);
@@ -597,13 +649,13 @@ static void tt_atlantis_machine_init(MachineState *machine)
 
     /* Load or create device tree */
     if (machine->dtb) {
-        load_fdt(s);
+        load_fdt(ams);
     } else {
-        create_fdt(s);
+        create_fdt(ams);
     }
 
-    s->machine_done.notify = tt_atlantis_machine_done;
-    qemu_add_machine_init_done_notifier(&s->machine_done);
+    ams->machine_done.notify = tt_atlantis_machine_done;
+    qemu_add_machine_init_done_notifier(&ams->machine_done);
 }
 
 static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
@@ -623,6 +675,12 @@ static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
 
 static const TypeInfo tt_atlantis_types[] = {
     {
+        .name       = TYPE_TT_ATLANTIS_SOC,
+        .parent     = TYPE_DEVICE,
+        .instance_size = sizeof(TTAtlantisSoCState),
+        .instance_init = tt_atlantis_soc_init,
+        .class_init = tt_atlantis_soc_class_init,
+    }, {
         .name       = MACHINE_TYPE_NAME("tt-atlantis"),
         .parent     = TYPE_MACHINE,
         .class_init = tt_atlantis_machine_class_init,
-- 
2.47.3


