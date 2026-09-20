Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49191C982DF
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 02:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x87WO-0006t4-34; Sat, 19 Sep 2026 22:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1x87WL-0006sT-5v
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 22:43:13 -0400
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1x87WI-0005P7-PE
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 22:43:12 -0400
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id E3364DFC8;
 Sun, 20 Sep 2026 08:13:08 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
	SignKirigami <prcups@krgm.moe>
Subject: [PATCH RESEND] target/loongarch: add get_sys() helper
Date: Sun, 20 Sep 2026 10:43:04 +0800
Message-ID: <20260920024305.18296-1-prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.47.186.116; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add get_sys() to retrieve a CPUSysState by VM level. Use it to access
the host state in CPU initialization and reset paths, and name the
local pointer host to distinguish it from the currently selected state
returned by env_sys() or guest. There is no function change in this
patch.

Signed-off-by: SignKirigami <prcups@krgm.moe>
---
This patch is a resend of [1], Sorry for wrongly handling Signed-off-by.
 
[1]: https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg05969.html

 target/loongarch/cpu.c | 45 +++++++++++++++++++++---------------------
 target/loongarch/cpu.h |  5 +++++
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index f22f64efb8..c71531c1cf 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -142,12 +142,12 @@ static void loongarch_la464_init_csr(DeviceState *dev)
     static bool initialized;
     LoongArchCPU *cpu = LOONGARCH_CPU(dev);
     CPULoongArchState *env = &cpu->env;
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *host = get_sys(env, VM_LEVEL0);
     int i, num;
 
     if (!initialized) {
         initialized = true;
-        num = FIELD_EX64(sys->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM);
+        num = FIELD_EX64(host->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM);
         for (i = num; i < 16; i++) {
             set_csr_flag(LOONGARCH_CSR_SAVE(i), CSRFL_UNUSED);
         }
@@ -300,7 +300,7 @@ static void loongarch_la464_initfn(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
     CPULoongArchState *env = &cpu->env;
-    CPUSysState *sys;
+    CPUSysState *host = get_sys(env, VM_LEVEL0);
     uint32_t data = 0, field;
     int i;
 
@@ -408,19 +408,18 @@ static void loongarch_la464_initfn(Object *obj)
     data = FIELD_DP32(data, CPUCFG20, L3IU_SIZE, 6);
     env->cpucfg[20] = data;
 
-    sys = env_sys(env);
-    sys->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
+    host->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
 
-    sys->CSR_PRCFG1 = FIELD_DP64(sys->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM, 8);
-    sys->CSR_PRCFG1 = FIELD_DP64(sys->CSR_PRCFG1, CSR_PRCFG1, TIMER_BITS, 0x2f);
-    sys->CSR_PRCFG1 = FIELD_DP64(sys->CSR_PRCFG1, CSR_PRCFG1, VSMAX, 7);
+    host->CSR_PRCFG1 = FIELD_DP64(host->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM, 8);
+    host->CSR_PRCFG1 = FIELD_DP64(host->CSR_PRCFG1, CSR_PRCFG1, TIMER_BITS, 0x2f);
+    host->CSR_PRCFG1 = FIELD_DP64(host->CSR_PRCFG1, CSR_PRCFG1, VSMAX, 7);
 
-    sys->CSR_PRCFG2 = 0x3ffff000;
+    host->CSR_PRCFG2 = 0x3ffff000;
 
-    sys->CSR_PRCFG3 = FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, TLB_TYPE, 2);
-    sys->CSR_PRCFG3 = FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, MTLB_ENTRY, 63);
-    sys->CSR_PRCFG3 = FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, STLB_WAYS, 7);
-    sys->CSR_PRCFG3 = FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS, 8);
+    host->CSR_PRCFG3 = FIELD_DP64(host->CSR_PRCFG3, CSR_PRCFG3, TLB_TYPE, 2);
+    host->CSR_PRCFG3 = FIELD_DP64(host->CSR_PRCFG3, CSR_PRCFG3, MTLB_ENTRY, 63);
+    host->CSR_PRCFG3 = FIELD_DP64(host->CSR_PRCFG3, CSR_PRCFG3, STLB_WAYS, 7);
+    host->CSR_PRCFG3 = FIELD_DP64(host->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS, 8);
 
     cpu->msgint = ON_OFF_AUTO_OFF;
     cpu->ptw = ON_OFF_AUTO_OFF;
@@ -627,7 +626,7 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
     CPUState *cs = CPU(obj);
     LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(obj);
     CPULoongArchState *env = cpu_env(cs);
-    CPUSysState *sys = env_sys(env);
+    CPUSysState *host = get_sys(env, VM_LEVEL0);
 
     if (lacc->parent_phases.hold) {
         lacc->parent_phases.hold(obj, type);
@@ -638,7 +637,7 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
      * its value is equal to zero for boot cpu, it causes reboot issue.
      */
     memset(env, 0, offsetof(CPULoongArchState, end_reset_fields));
-    memset(sys, 0, offsetof(CPUSysState, end_reset_fields));
+    memset(host, 0, offsetof(CPUSysState, end_reset_fields));
 
 #ifdef CONFIG_TCG
     env->fcsr0_mask = FCSR0_M1 | FCSR0_M2 | FCSR0_M3;
@@ -655,17 +654,17 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
     }
 #endif
 
-    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DA, 1);
-    sys->CSR_CPUID = cs->cpu_index;
-    sys->CSR_TID = cs->cpu_index;
+    host->CSR_CRMD = FIELD_DP64(host->CSR_CRMD, CSR_CRMD, DA, 1);
+    host->CSR_CPUID = cs->cpu_index;
+    host->CSR_TID = cs->cpu_index;
 
     /* set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits from CSR_PRCFG2 */
-    if (sys->CSR_PRCFG2 == 0) {
-        sys->CSR_PRCFG2 = 0x3fffff000;
+    if (host->CSR_PRCFG2 == 0) {
+        host->CSR_PRCFG2 = 0x3fffff000;
     }
-    tlb_ps = ctz32(sys->CSR_PRCFG2);
-    sys->CSR_STLBPS = FIELD_DP64(sys->CSR_STLBPS, CSR_STLBPS, PS, tlb_ps);
-    sys->CSR_PWCL = FIELD_DP64(sys->CSR_PWCL, CSR_PWCL, PTBASE, tlb_ps);
+    tlb_ps = ctz32(host->CSR_PRCFG2);
+    host->CSR_STLBPS = FIELD_DP64(host->CSR_STLBPS, CSR_STLBPS, PS, tlb_ps);
+    host->CSR_PWCL = FIELD_DP64(host->CSR_PWCL, CSR_PWCL, PTBASE, tlb_ps);
 
 #ifndef CONFIG_USER_ONLY
     env->pc = 0x1c000000;
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index c592f69885..477a5dee7d 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -512,6 +512,11 @@ static inline void set_sys_state(CPULoongArchState *env, CPUSysState *sys)
     env->sys_state = sys;
 }
 
+static inline CPUSysState *get_sys(CPULoongArchState *env, int vm_level)
+{
+    return &env->sys_states[vm_level];
+}
+
 static inline CPUTimerState *env_timer(CPULoongArchState *env)
 {
     return &env->sys_states[0].timer_state;
-- 
2.55.0


