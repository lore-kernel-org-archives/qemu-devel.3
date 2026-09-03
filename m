Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886CAC624D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 05:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x20OW-0008J1-5O; Thu, 03 Sep 2026 01:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20OU-0008G5-H9
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:53:50 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20OS-0006Wn-1R
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:53:50 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-8485b358552so1774108b3a.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 22:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788414826; x=1789019626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BlSJVfV2+w/82vd+SBa033cLZPwJ67X/v46HQIf9Oa4=;
 b=Fdnq3EF96JW6A6IqH8y1c9NLtphE0jVsDGviWZdK0j1BJf4VwG/aQMGvdgmI5pxnqY
 giMrWJzKqYtCPAW8W18VlJEMrrZkElMmuMZvmnssCs1vLJOX5ZtolPGsWpnzqSuaz8XC
 zJQ2tU5ybKyxVV6xXUp/Lp9OKFVQWpDBFNsb8h3FojFurQ6l2RFZZu+FJKW3oNWUFJZ5
 9e8oS0qIHajXG5Ka4N36ho4uk6zT52JCflVjiE8ZlX79gMM2hLKUH+MaO9AfsBkqcurb
 wihqG0dQdlcKLpkQseVt3I3asoSdFa105wDNyDWBz6nM7SmyJz4tmZS5iUlLizsDve5d
 ojTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788414826; x=1789019626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BlSJVfV2+w/82vd+SBa033cLZPwJ67X/v46HQIf9Oa4=;
 b=Zt6uSViOItuLF/RtMMSUIbWQmSCnZJtzw/OKuXwernsfAFRMyzXB4Ef1EHbk0ycFW2
 MddRqjXWm37iyn4YMIRgJX3aCCMTVJzxY8hvZe8fI5n3+C9ROCxid18tJb094h+TSQXk
 i3bN+cimnJHRhKeWo6WWx5HdSonx6V8Cfz3Sevpcd5zK7/lvBUumzUyljMP8To7rloro
 i40kxKt+TnpS8Ue7GV3QZwMaJawGFUThYgBQeQafXGlS68IAq+4tbfqjKOMLWRSldk34
 GsxD4JzcWRJ64CQM1nFPR1XBKYo77F06L6i4rbpJnHWgw7C3HB4Ss6jRugpnYs34YU+r
 QweQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvxIq56lcK71sG9ANVDphq/zC+WAaryl2ejgngljJ1hgu5qVL71F0gvBOLHY0Ax5JD1d/JSQhtA5Df@nongnu.org
X-Gm-Message-State: AFuF++kSo6FMgjIufQz5k4GrUF/WhpXXU+UJauXfp1xyoK5jel6ntloZ
 MZ1z21Ciohrp8sVgnWT3+XXYYl7UkemyhTu1131261MhE31W+OQEJbnx
X-Gm-Gg: AYBFou37fGvkSNuMiVjm4t8Qr87WudEak2U9GuByhJPupi9aFKKkU+i53Pz6YIGzMsu
 qryDHb7a8FtuIZNwbInR3z12yX1mlKrhVLJgZN8J4l0ojoYNNZCwtWLy+PrAdXAc9XdoXOiV081
 icunVKkJ81aZasBRb1Q5G6Mf6r5hwSVCwer5NjJ1PiALq/Xmb7CUOVSG13KBQIg8Y3M6XaDw4P1
 9tURakpOemkdOJhBao2C0NPauazKGabIZUFmxHPMEVRLoczSex+FkLGo+FKPLOMw88cNj2LAnJw
 5APoTD9MHGeiX5DIf/Ahvaq8vcVgQ5sRt++IHVfD0OjYUxxzK6w2XZzrA/g+cCG2fbqEv/yjdDl
 m/G9HFKruMfvWRmTbXAgcAK4BH7Ig1AGWcSq0fLdHVqHXRHUS5A7SFkEWYlZkh9lsxXkyQPdOzq
 nnWq0OPU1zKMIaYKCnnK5wquZssnX1orKSDhX45cg9AnyNsVPolL3npItInoHpO8d89w26Fi4zP
 KkNGD5ZPwpaEC1YHJb/VZbhCD0+exHJteDpBF2qzSr1dWi6/JXiBhkdrB4A3z8zMiBCmlbcxD+x
 MH9ope10YeGyKyUIJaSi
X-Received: by 2002:a05:6a20:430c:b0:3d3:aec2:4dce with SMTP id
 adf61e73a8af0-3d9b0a3d145mr14061566637.26.1788414826453; 
 Wed, 02 Sep 2026 22:53:46 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431990a39bsm2770619c88.3.2026.09.02.22.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 22:53:45 -0700 (PDT)
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
Subject: [PATCH v3 15/16] hw/riscv/atlantis: Extract an Atlantis SoC device
Date: Thu,  3 Sep 2026 15:21:29 +0930
Message-ID: <20260903055131.257903-16-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903055131.257903-1-joel@jms.id.au>
References: <20260903055131.257903-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x431.google.com
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

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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
index d4fe505fe033..6c46121287c7 100644
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
@@ -105,7 +107,7 @@ static void create_fdt_memory(void *fdt, TTAtlantisState *s)
     }
 }
 
-static void create_fdt_aclint(void *fdt, TTAtlantisState *s,
+static void create_fdt_aclint(void *fdt, TTAtlantisSoCState *s,
                               uint32_t *intc_phandles)
 {
     g_autofree char *name = NULL;
@@ -207,7 +209,7 @@ static void create_fdt_one_aplic(void *fdt,
     qemu_fdt_setprop_cell(fdt, name, "phandle", aplic_phandle);
 }
 
-static void create_fdt_pmu(void *fdt, TTAtlantisState *s)
+static void create_fdt_pmu(void *fdt, TTAtlantisSoCState *s)
 {
     char pmu_name[] = "/pmu";
     RISCVCPU *hart = &s->cpus.harts[0];
@@ -217,7 +219,7 @@ static void create_fdt_pmu(void *fdt, TTAtlantisState *s)
     riscv_pmu_generate_fdt_node(fdt, hart->pmu_avail_ctrs, pmu_name);
 }
 
-static void create_fdt_cpu(void *fdt, TTAtlantisState *s,
+static void create_fdt_cpu(void *fdt, TTAtlantisSoCState *s,
                            uint32_t aplic_s_phandle,
                            uint32_t imsic_s_phandle)
 {
@@ -314,7 +316,7 @@ static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
     qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
 }
 
-static void create_fdt_i2c_device(void *fdt, TTAtlantisState *s, int bus,
+static void create_fdt_i2c_device(void *fdt, TTAtlantisSoCState *s, int bus,
                                   const char *compat, int addr)
 {
     hwaddr base = s->memmap[TT_ATL_I2C0 + bus].base;
@@ -326,7 +328,7 @@ static void create_fdt_i2c_device(void *fdt, TTAtlantisState *s, int bus,
     qemu_fdt_setprop_cell(fdt, name, "reg", addr);
 }
 
-static void finalize_fdt(void *fdt, TTAtlantisState *s)
+static void finalize_fdt(void *fdt, TTAtlantisSoCState *s)
 {
     uint32_t aplic_s_phandle = next_phandle();
     uint32_t imsic_s_phandle = next_phandle();
@@ -360,9 +362,9 @@ static void finalize_fdt(void *fdt, TTAtlantisState *s)
     create_fdt_i2c_device(fdt, s, 4, "ti,tmp105", 0x48);
 }
 
-static void create_fdt(TTAtlantisState *s)
+static void create_fdt(TTAtlantisState *ams)
 {
-    MachineState *ms = MACHINE(s);
+    MachineState *ms = MACHINE(ams);
     int fdt_size = 0;
 
     ms->fdt = riscv_create_board_device_tree("Tenstorrent Atlantis RISC-V Machine",
@@ -374,12 +376,12 @@ static void create_fdt(TTAtlantisState *s)
 
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
@@ -405,7 +407,7 @@ static void load_fdt(TTAtlantisState *s)
         g_strfreev(node_path);
     }
 
-    create_fdt_memory(ms->fdt, s);
+    create_fdt_memory(ms->fdt, &ams->soc);
 }
 
 static void mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
@@ -419,10 +421,11 @@ static void mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
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
@@ -480,23 +483,39 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
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
@@ -505,7 +524,9 @@ static void tt_atlantis_machine_init(MachineState *machine)
     object_property_set_int(OBJECT(&s->cpus), "resetvec",
                             s->memmap[TT_ATL_BOOTROM].base,
                             &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpus), errp)) {
+        return;
+    }
 
     s->irqchip = riscv_create_aia(s->memory,
                                   true, TT_IMSIC_GUESTS,
@@ -535,26 +556,27 @@ static void tt_atlantis_machine_init(MachineState *machine)
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
 
@@ -571,26 +593,56 @@ static void tt_atlantis_machine_init(MachineState *machine)
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
@@ -598,13 +650,13 @@ static void tt_atlantis_machine_init(MachineState *machine)
 
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
@@ -624,6 +676,12 @@ static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
 
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


