Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6243606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RN4QVUr8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM8Mv-0005cR-Rw; Wed, 28 Oct 2026 14:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xM8Mn-0005am-5u
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:27:18 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xM8Mh-0003KH-3F
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:27:15 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A9B9B600DA;
 Wed, 28 Oct 2026 18:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3AA1F01825;
 Wed, 28 Oct 2026 18:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793212027;
 bh=dTZCJTYWVWJqF6kvOj5k8Dq8jE2tqLp4YrotU+lPUFg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RN4QVUr81z42td0XgIpYh6RKcOwYgFGXRp/lW7r+ikyqvlIKkhb9ADT6fnbIZTGqr
 rnI2CEb8wGme0uIT2Ljvu4Y/y8yz5q1t0Z/ssjK/NYBaafbgd3ItFNXtpMfSmOHse6
 3OqSXsxoW5zBLBuwuqeX9zh2OcKklmfS/Y+sagkErisM1o02kBLmlRX6pxcq0SRG9a
 8xdKn0VDILpnQTenRgrzeTFYXDLpDY+kwIcQFYK1paXoZXzy2vlWSJnrFDvtN5JyUD
 bqQItrxbYknq4NgZs9OIrnV6vzvlOX2zp+cnlNMR+7KI5+hnvQeKAVeYhnFehHzFup
 W8L59bHdvHyUA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 8/9] target/hppa: Map CPUs at same addresses as on physical
 machines
Date: Wed, 28 Oct 2026 19:26:50 +0100
Message-ID: <20261028182651.5950-9-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028182651.5950-1-deller@kernel.org>
References: <20261028182651.5950-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

SeaBIOS version 26 allows to use random addresses for CPU_HPA, so drop
the hardcoded CPU_HPA which was used until now for all machines, and use
individual addresses which correspond to the CPU HPA on the physical
machines.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 23 +++++++++++++----------
 target/hppa/cpu.h |  1 +
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index e403ae5fc9..f23936fc5b 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -241,11 +241,11 @@ static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus,
     fw_cfg_add_file(fw_cfg, "/etc/hppa/power-button-addr",
                     g_memdup2(&val, sizeof(val)), sizeof(val));
 
-    val = cpu_to_le64(CPU_HPA + 16);
+    val = cpu_to_le64(cpu[0]->env.cpu_hpa + 16);
     fw_cfg_add_file(fw_cfg, "/etc/hppa/rtc-addr",
                     g_memdup2(&val, sizeof(val)), sizeof(val));
 
-    val = cpu_to_le64(CPU_HPA + 24);
+    val = cpu_to_le64(cpu[0]->env.cpu_hpa + 24);
     fw_cfg_add_file(fw_cfg, "/etc/hppa/DebugOutputPort",
                     g_memdup2(&val, sizeof(val)), sizeof(val));
 
@@ -286,7 +286,8 @@ static DinoState *dino_init(MemoryRegion *addr_space)
 /*
  * Step 1: Create CPUs and Memory
  */
-static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
+static TranslateFn *machine_HP_common_init_cpus(MachineState *machine,
+                        target_ulong initial_cpu_hpa)
 {
     MemoryRegion *addr_space = get_system_memory();
     unsigned int smp_cpus = machine->smp.cpus;
@@ -299,6 +300,7 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
     /* Create CPUs.  */
     for (unsigned int i = 0; i < smp_cpus; i++) {
         cpu[i] = HPPA_CPU(cpu_create(machine->cpu_type));
+        cpu[i]->env.cpu_hpa = initial_cpu_hpa + i * 0x1000;
     }
 
     /* Initialize memory */
@@ -321,7 +323,7 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
         memory_region_init_io(cpu_region, OBJECT(cpu[i]), &hppa_io_eir_ops,
                               cpu[i], name, 4);
         memory_region_add_subregion(addr_space,
-                                    translate(NULL, CPU_HPA + i * 0x1000),
+                                    translate(NULL, cpu[i]->env.cpu_hpa),
                                     cpu_region);
 
         if (!hppa_is_pa20(&cpu[0]->env)) {
@@ -339,7 +341,7 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
         memory_region_init_io(cflush, NULL, &hppa_pci_ignore_ops,
                               NULL, cflush_name, 4);
         memory_region_add_subregion(addr_space,
-                              translate(NULL, CPU_HPA + i * 0x1000 + 0x500),
+                              translate(NULL, cpu[i]->env.cpu_hpa + 0x500),
                               cflush);
     }
 
@@ -347,7 +349,8 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
     cpu_region = g_new(MemoryRegion, 1);
     memory_region_init_io(cpu_region, OBJECT(cpu[0]), &hppa_io_helper_ops,
                           cpu[0], "cpu0-io-rtc", 2 * sizeof(uint64_t));
-    memory_region_add_subregion(addr_space, translate(NULL, CPU_HPA + 16),
+    memory_region_add_subregion(addr_space,
+                                translate(NULL, cpu[0]->env.cpu_hpa + 16),
                                 cpu_region);
 
     /* Main memory region. */
@@ -626,7 +629,7 @@ static void machine_HP_715_init(MachineState *machine)
     ISABus *isa_bus;
 
     /* Create CPUs and RAM.  */
-    translate = machine_HP_common_init_cpus(machine);
+    translate = machine_HP_common_init_cpus(machine, 0xfffbe000);
 
     if (hppa_is_pa20(&cpu[0]->env)) {
         error_report("The HP 715/64 workstation requires a 32-bit "
@@ -713,7 +716,7 @@ static void machine_HP_B160L_init(MachineState *machine)
     PCIBus *pci_bus;
 
     /* Create CPUs and RAM.  */
-    translate = machine_HP_common_init_cpus(machine);
+    translate = machine_HP_common_init_cpus(machine, 0xfff10000);
 
     if (hppa_is_pa20(&cpu[0]->env)) {
         error_report("The HP B160L workstation requires a 32-bit "
@@ -810,7 +813,7 @@ static void machine_HP_C3700_init(MachineState *machine)
     bool is_C3700 = strcmp(mc->name, "C3700") == 0;
 
     /* Create CPUs and RAM.  */
-    translate = machine_HP_common_init_cpus(machine);
+    translate = machine_HP_common_init_cpus(machine, 0xfffa0000);
 
     if (!hppa_is_pa20(&cpu[0]->env)) {
         error_report("The HP C3000 workstation requires a 64-bit CPU. "
@@ -893,7 +896,7 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
         cpu[i]->env.psw = PSW_Q;
         /* Firmware uses FP registers before configuring CCR. */
         cpu[i]->env.cr[CR_SCRCCR] = 0xc0;
-        cpu[i]->env.gr[5] = CPU_HPA + i * 0x1000;
+        cpu[i]->env.gr[5] = cpu[i]->env.cpu_hpa;
     }
 
     /*
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index da48a78569..7b708a564b 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -272,6 +272,7 @@ typedef struct CPUArchState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
+    target_ulong cpu_hpa;      /* HPA of this CPU */
     target_ulong kernel_entry; /* Linux kernel was loaded here */
     target_ulong cmdline_or_bootorder;
     target_ulong initrd_base, initrd_end;
-- 
2.54.0


