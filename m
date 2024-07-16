Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AE1C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 12:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTgyc-00067C-Ky; Tue, 16 Jul 2024 08:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sTgya-0005yB-8t; Tue, 16 Jul 2024 08:08:12 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sTgyT-0003kj-LZ; Tue, 16 Jul 2024 08:08:12 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9400B4E601D;
 Tue, 16 Jul 2024 14:08:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 19mYf-UXpyYo; Tue, 16 Jul 2024 14:07:58 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9917D4E6013; Tue, 16 Jul 2024 14:07:58 +0200 (CEST)
Message-Id: <ec23cd8584882f1ef70bb5bd2e376d0b5a9dfdbb.1721131193.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1721131193.git.balaton@eik.bme.hu>
References: <cover.1721131193.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 2/2] hw/ppc: Consolidate ppc440 initial mapping creation
 functions
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Edgar E. Iglesias <edgar.iglesias@gmail.com>
Date: Tue, 16 Jul 2024 14:07:58 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a utility function and use it to replace very similar
create_initial_mapping functions in 440 based machines.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc440_bamboo.c | 28 +++-----------------------
 hw/ppc/ppc_booke.c     | 10 ++++++++++
 hw/ppc/sam460ex.c      | 45 ++++++++++--------------------------------
 hw/ppc/virtex_ml507.c  | 28 +++-----------------------
 include/hw/ppc/ppc.h   |  2 ++
 5 files changed, 28 insertions(+), 85 deletions(-)

diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 73f80cf706..ae4d6cd96b 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -110,29 +110,6 @@ static int bamboo_load_device_tree(MachineState *machine,
     return 0;
 }
 
-/* Create reset TLB entries for BookE, spanning the 32bit addr space.  */
-static void mmubooke_create_initial_mapping(CPUPPCState *env,
-                                     target_ulong va,
-                                     hwaddr pa)
-{
-    ppcemb_tlb_t *tlb = &env->tlb.tlbe[0];
-
-    tlb->attr = 0;
-    tlb->prot = PAGE_VALID | ((PAGE_READ | PAGE_WRITE | PAGE_EXEC) << 4);
-    tlb->size = 1U << 31; /* up to 0x80000000  */
-    tlb->EPN = va & TARGET_PAGE_MASK;
-    tlb->RPN = pa & TARGET_PAGE_MASK;
-    tlb->PID = 0;
-
-    tlb = &env->tlb.tlbe[1];
-    tlb->attr = 0;
-    tlb->prot = PAGE_VALID | ((PAGE_READ | PAGE_WRITE | PAGE_EXEC) << 4);
-    tlb->size = 1U << 31; /* up to 0xffffffff  */
-    tlb->EPN = 0x80000000 & TARGET_PAGE_MASK;
-    tlb->RPN = 0x80000000 & TARGET_PAGE_MASK;
-    tlb->PID = 0;
-}
-
 static void main_cpu_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
@@ -143,8 +120,9 @@ static void main_cpu_reset(void *opaque)
     env->gpr[3] = FDT_ADDR;
     env->nip = entry;
 
-    /* Create a mapping for the kernel.  */
-    mmubooke_create_initial_mapping(env, 0, 0);
+    /* Create a mapping spanning the 32bit addr space. */
+    booke_set_tlb(&env->tlb.tlbe[0], 0, 0, 1U << 31);
+    booke_set_tlb(&env->tlb.tlbe[1], 0x80000000, 0x80000000, 1U << 31);
 }
 
 static void bamboo_init(MachineState *machine)
diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index ca22da196a..c8849e66ff 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -31,6 +31,16 @@
 #include "hw/loader.h"
 #include "kvm_ppc.h"
 
+void booke_set_tlb(ppcemb_tlb_t *tlb, target_ulong va, hwaddr pa,
+                   target_ulong size)
+{
+    tlb->attr = 0;
+    tlb->prot = PAGE_RWX << 4 | PAGE_VALID;
+    tlb->size = size;
+    tlb->EPN = va & TARGET_PAGE_MASK;
+    tlb->RPN = pa & TARGET_PAGE_MASK;
+    tlb->PID = 0;
+}
 
 /* Timer Control Register */
 
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 8dc75fb9f0..ea99a4c624 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -213,38 +213,6 @@ static int sam460ex_load_device_tree(MachineState *machine,
     return fdt_size;
 }
 
-/* Create reset TLB entries for BookE, mapping only the flash memory.  */
-static void mmubooke_create_initial_mapping_uboot(CPUPPCState *env)
-{
-    ppcemb_tlb_t *tlb = &env->tlb.tlbe[0];
-
-    /* on reset the flash is mapped by a shadow TLB,
-     * but since we don't implement them we need to use
-     * the same values U-Boot will use to avoid a fault.
-     */
-    tlb->attr = 0;
-    tlb->prot = PAGE_VALID | ((PAGE_READ | PAGE_WRITE | PAGE_EXEC) << 4);
-    tlb->size = 0x10000000; /* up to 0xffffffff  */
-    tlb->EPN = 0xf0000000 & TARGET_PAGE_MASK;
-    tlb->RPN = (0xf0000000 & TARGET_PAGE_MASK) | 0x4;
-    tlb->PID = 0;
-}
-
-/* Create reset TLB entries for BookE, spanning the 32bit addr space.  */
-static void mmubooke_create_initial_mapping(CPUPPCState *env,
-                                     target_ulong va,
-                                     hwaddr pa)
-{
-    ppcemb_tlb_t *tlb = &env->tlb.tlbe[0];
-
-    tlb->attr = 0;
-    tlb->prot = PAGE_VALID | ((PAGE_READ | PAGE_WRITE | PAGE_EXEC) << 4);
-    tlb->size = 1 << 31; /* up to 0x80000000  */
-    tlb->EPN = va & TARGET_PAGE_MASK;
-    tlb->RPN = pa & TARGET_PAGE_MASK;
-    tlb->PID = 0;
-}
-
 static void main_cpu_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
@@ -253,20 +221,27 @@ static void main_cpu_reset(void *opaque)
 
     cpu_reset(CPU(cpu));
 
-    /* either we have a kernel to boot or we jump to U-Boot */
+    /*
+     * On reset the flash is mapped by a shadow TLB, but since we
+     * don't implement them we need to use the same values U-Boot
+     * will use to avoid a fault.
+     * either we have a kernel to boot or we jump to U-Boot
+     */
     if (bi->entry != UBOOT_ENTRY) {
         env->gpr[1] = (16 * MiB) - 8;
         env->gpr[3] = FDT_ADDR;
         env->nip = bi->entry;
 
         /* Create a mapping for the kernel.  */
-        mmubooke_create_initial_mapping(env, 0, 0);
+        booke_set_tlb(&env->tlb.tlbe[0], 0, 0, 1 << 31);
         env->gpr[6] = tswap32(EPAPR_MAGIC);
         env->gpr[7] = (16 * MiB) - 8; /* bi->ima_size; */
 
     } else {
         env->nip = UBOOT_ENTRY;
-        mmubooke_create_initial_mapping_uboot(env);
+        /* Create a mapping for U-Boot. */
+        booke_set_tlb(&env->tlb.tlbe[0], 0xf0000000, 0xf0000000, 0x10000000);
+        env->tlb.tlbe[0].RPN |= 4;
     }
 }
 
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index c49da1f46f..16ddb528fe 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -67,29 +67,6 @@ static struct boot_info
     void *vfdt;
 } boot_info;
 
-/* Create reset TLB entries for BookE, spanning the 32bit addr space.  */
-static void mmubooke_create_initial_mapping(CPUPPCState *env,
-                                     target_ulong va,
-                                     hwaddr pa)
-{
-    ppcemb_tlb_t *tlb = &env->tlb.tlbe[0];
-
-    tlb->attr = 0;
-    tlb->prot = PAGE_VALID | ((PAGE_READ | PAGE_WRITE | PAGE_EXEC) << 4);
-    tlb->size = 1U << 31; /* up to 0x80000000  */
-    tlb->EPN = va & TARGET_PAGE_MASK;
-    tlb->RPN = pa & TARGET_PAGE_MASK;
-    tlb->PID = 0;
-
-    tlb = &env->tlb.tlbe[1];
-    tlb->attr = 0;
-    tlb->prot = PAGE_VALID | ((PAGE_READ | PAGE_WRITE | PAGE_EXEC) << 4);
-    tlb->size = 1U << 31; /* up to 0xffffffff  */
-    tlb->EPN = 0x80000000 & TARGET_PAGE_MASK;
-    tlb->RPN = 0x80000000 & TARGET_PAGE_MASK;
-    tlb->PID = 0;
-}
-
 static PowerPCCPU *ppc440_init_xilinx(const char *cpu_type, uint32_t sysclk)
 {
     PowerPCCPU *cpu;
@@ -139,8 +116,9 @@ static void main_cpu_reset(void *opaque)
     env->gpr[3] = bi->fdt;
     env->nip = bi->bootstrap_pc;
 
-    /* Create a mapping for the kernel.  */
-    mmubooke_create_initial_mapping(env, 0, 0);
+    /* Create a mapping spanning the 32bit addr space. */
+    booke_set_tlb(&env->tlb.tlbe[0], 0, 0, 1U << 31);
+    booke_set_tlb(&env->tlb.tlbe[1], 0x80000000, 0x80000000, 1U << 31);
     env->gpr[6] = tswap32(EPAPR_MAGIC);
     env->gpr[7] = bi->ima_size;
 }
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 070524b02e..8a14d623f8 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -119,6 +119,8 @@ enum {
 #ifndef CONFIG_USER_ONLY
 void booke206_set_tlb(ppcmas_tlb_t *tlb, target_ulong va, hwaddr pa,
                       hwaddr len);
+void booke_set_tlb(ppcemb_tlb_t *tlb, target_ulong va, hwaddr pa,
+                   target_ulong size);
 #endif
 
 /* ppc_booke.c */
-- 
2.30.9


