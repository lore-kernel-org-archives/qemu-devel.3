Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5881061B22
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 21:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7K11-0000q9-4s; Mon, 30 Mar 2026 17:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7K0z-0000q0-Pl
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:19:17 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7K0y-0003m1-57
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:19:17 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 149AA43974;
 Mon, 30 Mar 2026 21:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17928C4CEF7;
 Mon, 30 Mar 2026 21:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774905554;
 bh=8emu/u6YmaOVzGpK7CGOuoWPdfvgVUfc6OOJwBpWcog=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ebgf31kc7xlo5c5vOUOMy668MJ1vKNNVoaUY0u1H3DBRy+wJudCB6mNrsjTjmOas5
 MGzPflJvWKJHYdPqpQdZIU/7naZF0UL45a965W5pVSrH0Xt1gRfDT1FNV1K+bD/PpE
 o9rX6x+SKfybqMIceeCg5o6pCUvWSeRIYpuFUMxViTvzaaySYgAEktgxHWRsEKXPZ9
 saU+FhOVIVqEaCa6vfAuw6sN0lnjjHvHW6ZjCznoKRNOawjKQRLPNh2v9e1IuqyhFr
 oQGUhqcs79aYMQ2N408J8VgnFj5wWXC+AXtOtKe80PVm4EDLHmCUVrUZM2vnlz+7re
 r+OAVGp85G1ZA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 10/11] hw/hppa: Implement memory ranges
Date: Mon, 30 Mar 2026 23:18:57 +0200
Message-ID: <20260330211859.19317-11-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330211859.19317-1-deller@kernel.org>
References: <20260330211859.19317-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

All 64-bit PA-RISC machines split the memory into (up to 3) different
memory ranges, which are mapped at specific addresses.  This patch
mimics the mapping as it's done on physical machines, which includes the
3.75 GB split for C3700, and 1 GB split for newer 64-bit PAT machines
like the A400.

SeaBIOS-hppa needs to know how the memory split is done, so add a new
memsplit_addr variable which stores the specific split address and hand
this over to SeaBIOS-hppa via fwcfg.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/hppa_hardware.h |  3 ++-
 hw/hppa/machine.c       | 58 ++++++++++++++++++++++++++++++-----------
 2 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index 006aae63b9..e2b2faa4a3 100644
--- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -8,7 +8,8 @@
 #define FIRMWARE_END    0xf0100000
 #define FIRMWARE_HIGH   0xfffffff0  /* upper 32-bits of 64-bit firmware address */
 
-#define RAM_MAP_HIGH  0x0100000000  /* memory above 3.75 GB is mapped here */
+#define RAM_MAP_HIGH1 0x0100000000  /* memory above 4 GB */
+#define RAM_MAP_HIGH2 0x4040000000  /* memory between 1 G and 3.75 GB */
 
 #define MEM_PDC_ENTRY       0x4800  /* PDC entry address */
 
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 58e76bee2e..eece05ab65 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -43,6 +43,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(HppaMachineState, HPPA_COMMON_MACHINE)
 
 struct HppaMachineState {
     MachineState parent_obj;
+
+    uint64_t memsplit_addr;
 };
 
 #define MIN_SEABIOS_HPPA_VERSION 22 /* require at least this fw version */
@@ -208,6 +210,7 @@ static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus,
     const char qemu_version[] = QEMU_VERSION;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     int btlb_entries = HPPA_BTLB_ENTRIES(&cpu[0]->env);
+    struct HppaMachineState *hpm = HPPA_COMMON_MACHINE(ms);
     int len;
 
     fw_cfg = fw_cfg_init_mem_nodma(addr, addr + 4, 1);
@@ -231,6 +234,10 @@ static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus,
     fw_cfg_add_file(fw_cfg, "/etc/hppa/machine",
                     g_memdup2(mc->name, len), len);
 
+    val = cpu_to_le64(hpm->memsplit_addr);
+    fw_cfg_add_file(fw_cfg, "/etc/hppa/memsplit-addr",
+                    g_memdup2(&val, sizeof(val)), sizeof(val));
+
     val = cpu_to_le64(soft_power_reg);
     fw_cfg_add_file(fw_cfg, "/etc/hppa/power-button-addr",
                     g_memdup2(&val, sizeof(val)), sizeof(val));
@@ -287,6 +294,8 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
     TranslateFn *translate;
     MemoryRegion *cpu_region;
     uint64_t ram_max;
+    struct HppaMachineState *hpm;
+    hwaddr splitaddr;
 
     /* Create CPUs.  */
     for (unsigned int i = 0; i < smp_cpus; i++) {
@@ -347,21 +356,36 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
         info_report("Max RAM size limited to %" PRIu64 " MB", ram_max / MiB);
         machine->ram_size = ram_max;
     }
-    if (machine->ram_size <= FIRMWARE_START) {
-        /* contiguous memory up to 3.75 GB RAM */
-        memory_region_add_subregion_overlap(addr_space, 0, machine->ram, -1);
-    } else {
+
+    hpm = HPPA_COMMON_MACHINE(machine);
+    if (!hpm->memsplit_addr) {
         /* non-contiguous: Memory above 3.75 GB is mapped at RAM_MAP_HIGH */
-        MemoryRegion *mem_region;
-        mem_region = g_new(MemoryRegion, 2);
-        memory_region_init_alias(&mem_region[0], &addr_space->parent_obj,
-                              "LowMem", machine->ram, 0, FIRMWARE_START);
-        memory_region_init_alias(&mem_region[1], &addr_space->parent_obj,
-                              "HighMem", machine->ram, FIRMWARE_START,
-                              machine->ram_size - FIRMWARE_START);
-        memory_region_add_subregion_overlap(addr_space, 0, &mem_region[0], -1);
-        memory_region_add_subregion_overlap(addr_space, RAM_MAP_HIGH,
-                                            &mem_region[1], -1);
+        hpm->memsplit_addr = FIRMWARE_START;
+    }
+    splitaddr = hpm->memsplit_addr;
+
+    MemoryRegion *mem_region;
+    mem_region = g_new(MemoryRegion, 1);
+    memory_region_init_alias(&mem_region[0], &addr_space->parent_obj,
+                          "Range0_Mem", machine->ram, 0, splitaddr);
+    memory_region_add_subregion_overlap(addr_space, 0, &mem_region[0], -1);
+    if (hppa_is_pa20(&cpu[0]->env)) {
+        if (machine->ram_size > 4 * GiB) {
+            mem_region = g_new(MemoryRegion, 1);
+            memory_region_init_alias(&mem_region[0], &addr_space->parent_obj,
+                          "Range1_Mem", machine->ram, 4 * GiB,
+                          machine->ram_size - 4 * GiB);
+            memory_region_add_subregion_overlap(addr_space, RAM_MAP_HIGH1,
+                                        &mem_region[0], -1);
+        }
+        if (machine->ram_size > splitaddr) {
+            mem_region = g_new(MemoryRegion, 1);
+            memory_region_init_alias(&mem_region[0], &addr_space->parent_obj,
+                          "Range2_Mem", machine->ram, splitaddr,
+                          4 * GiB - splitaddr);
+            memory_region_add_subregion_overlap(addr_space, RAM_MAP_HIGH2,
+                                        &mem_region[0], -1);
+        }
     }
 
     return translate;
@@ -757,6 +781,10 @@ static void machine_HP_C3700_init(MachineState *machine)
  */
 static void machine_HP_A400_init(MachineState *machine)
 {
+    struct HppaMachineState *hpm;
+
+    hpm = HPPA_COMMON_MACHINE(machine);
+    hpm->memsplit_addr = 1 * GiB;
     machine_HP_C3700_init(machine);
 }
 
@@ -815,7 +843,7 @@ static void hppa_machine_common_class_init(ObjectClass *oc, const void *data)
     mc->default_cpus = 1;
     mc->max_cpus = HPPA_MAX_CPUS;
     mc->default_boot_order = "cd";
-    mc->default_ram_id = "ram";
+    mc->default_ram_id = "hppa.ram";
     mc->default_nic = "tulip";
 
     nc->nmi_monitor_handler = hppa_nmi;
-- 
2.53.0


