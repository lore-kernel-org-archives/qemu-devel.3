Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698B1C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 08:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4ynv-0003q3-IO; Thu, 09 May 2024 04:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s4ynq-0003pC-OE
 for qemu-devel@nongnu.org; Thu, 09 May 2024 04:06:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s4ynn-0006CS-Hr
 for qemu-devel@nongnu.org; Thu, 09 May 2024 04:06:58 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dx_+sYhDxmuuQJAA--.26376S3;
 Thu, 09 May 2024 16:06:48 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxhFYVhDxmfOYWAA--.27243S4; 
 Thu, 09 May 2024 16:06:48 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 2/3] target/loongarch: Add TCG macro in structure CPUArchState
Date: Thu,  9 May 2024 16:06:44 +0800
Message-Id: <20240509080645.457303-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240509080645.457303-1-gaosong@loongson.cn>
References: <20240509080645.457303-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxhFYVhDxmfOYWAA--.27243S4
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bibo Mao <maobibo@loongson.cn>

In structure CPUArchState some struct elements are only used in TCG
mode, and it is not used in KVM mode. Macro CONFIG_TCG is added to
make it simpiler in KVM mode, also there is the same modification
in c code when these structure elements are used.

When VM runs in KVM mode, TLB entries are not used and do not need
migrate. It is only useful when it runs in TCG mode.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240506011912.2108842-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c        |  7 +++++--
 target/loongarch/cpu.h        | 16 ++++++++++------
 target/loongarch/cpu_helper.c |  9 +++++++++
 target/loongarch/machine.c    | 30 +++++++++++++++++++++++++-----
 4 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 96da1a685e..a0cad53676 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -505,7 +505,9 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
         lacc->parent_phases.hold(obj, type);
     }
 
+#ifdef CONFIG_TCG
     env->fcsr0_mask = FCSR0_M1 | FCSR0_M2 | FCSR0_M3;
+#endif
     env->fcsr0 = 0x0;
 
     int n;
@@ -550,7 +552,9 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
 
 #ifndef CONFIG_USER_ONLY
     env->pc = 0x1c000000;
+#ifdef CONFIG_TCG
     memset(env->tlb, 0, sizeof(env->tlb));
+#endif
     if (kvm_enabled()) {
         kvm_arch_reset_vcpu(env);
     }
@@ -686,8 +690,7 @@ void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     int i;
 
     qemu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
-    qemu_fprintf(f, " FCSR0 0x%08x  fp_status 0x%02x\n", env->fcsr0,
-                 get_float_exception_flags(&env->fp_status));
+    qemu_fprintf(f, " FCSR0 0x%08x\n", env->fcsr0);
 
     /* gpr */
     for (i = 0; i < 32; i++) {
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index c5722670f5..41b8e6d96d 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -270,6 +270,7 @@ union fpr_t {
     VReg  vreg;
 };
 
+#ifdef CONFIG_TCG
 struct LoongArchTLB {
     uint64_t tlb_misc;
     /* Fields corresponding to CSR_TLBELO0/1 */
@@ -277,23 +278,18 @@ struct LoongArchTLB {
     uint64_t tlb_entry1;
 };
 typedef struct LoongArchTLB LoongArchTLB;
+#endif
 
 typedef struct CPUArchState {
     uint64_t gpr[32];
     uint64_t pc;
 
     fpr_t fpr[32];
-    float_status fp_status;
     bool cf[8];
-
     uint32_t fcsr0;
-    uint32_t fcsr0_mask;
 
     uint32_t cpucfg[21];
 
-    uint64_t lladdr; /* LL virtual address compared against SC */
-    uint64_t llval;
-
     /* LoongArch CSRs */
     uint64_t CSR_CRMD;
     uint64_t CSR_PRMD;
@@ -350,8 +346,16 @@ typedef struct CPUArchState {
     uint64_t CSR_DERA;
     uint64_t CSR_DSAVE;
 
+#ifdef CONFIG_TCG
+    float_status fp_status;
+    uint32_t fcsr0_mask;
+    uint64_t lladdr; /* LL virtual address compared against SC */
+    uint64_t llval;
+#endif
 #ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_TCG
     LoongArchTLB  tlb[LOONGARCH_TLB_MAX];
+#endif
 
     AddressSpace *address_space_iocsr;
     bool load_elf;
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index 960eec9567..580362ac3e 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -11,6 +11,7 @@
 #include "internals.h"
 #include "cpu-csr.h"
 
+#ifdef CONFIG_TCG
 static int loongarch_map_tlb_entry(CPULoongArchState *env, hwaddr *physical,
                                    int *prot, target_ulong address,
                                    int access_type, int index, int mmu_idx)
@@ -154,6 +155,14 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
 
     return TLBRET_NOMATCH;
 }
+#else
+static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
+                                 int *prot, target_ulong address,
+                                 MMUAccessType access_type, int mmu_idx)
+{
+    return TLBRET_NOMATCH;
+}
+#endif
 
 static hwaddr dmw_va2pa(CPULoongArchState *env, target_ulong va,
                         target_ulong dmw)
diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index c7029fb9b4..9cd9e848d6 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -8,6 +8,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "migration/cpu.h"
+#include "sysemu/tcg.h"
 #include "vec.h"
 
 static const VMStateDescription vmstate_fpu_reg = {
@@ -109,9 +110,15 @@ static const VMStateDescription vmstate_lasx = {
     },
 };
 
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+static bool tlb_needed(void *opaque)
+{
+    return tcg_enabled();
+}
+
 /* TLB state */
-const VMStateDescription vmstate_tlb = {
-    .name = "cpu/tlb",
+static const VMStateDescription vmstate_tlb_entry = {
+    .name = "cpu/tlb_entry",
     .version_id = 0,
     .minimum_version_id = 0,
     .fields = (const VMStateField[]) {
@@ -122,6 +129,19 @@ const VMStateDescription vmstate_tlb = {
     }
 };
 
+static const VMStateDescription vmstate_tlb = {
+    .name = "cpu/tlb",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .needed = tlb_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,
+                             0, vmstate_tlb_entry, LoongArchTLB),
+        VMSTATE_END_OF_LIST()
+    }
+};
+#endif
+
 /* LoongArch CPU state */
 const VMStateDescription vmstate_loongarch_cpu = {
     .name = "cpu",
@@ -187,9 +207,6 @@ const VMStateDescription vmstate_loongarch_cpu = {
         VMSTATE_UINT64(env.CSR_DBG, LoongArchCPU),
         VMSTATE_UINT64(env.CSR_DERA, LoongArchCPU),
         VMSTATE_UINT64(env.CSR_DSAVE, LoongArchCPU),
-        /* TLB */
-        VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,
-                             0, vmstate_tlb, LoongArchTLB),
 
         VMSTATE_END_OF_LIST()
     },
@@ -197,6 +214,9 @@ const VMStateDescription vmstate_loongarch_cpu = {
         &vmstate_fpu,
         &vmstate_lsx,
         &vmstate_lasx,
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+        &vmstate_tlb,
+#endif
         NULL
     }
 };
-- 
2.25.1


