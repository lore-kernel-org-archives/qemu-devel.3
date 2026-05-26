Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC9BCD5BB4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 06:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRlcg-0002Gf-B3; Tue, 26 May 2026 02:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wRlcb-0002Fv-TC
 for qemu-devel@nongnu.org; Tue, 26 May 2026 02:50:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wRlcV-0000Z5-I8
 for qemu-devel@nongnu.org; Tue, 26 May 2026 02:50:37 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxReiyQhVqU0wNAA--.31941S3;
 Tue, 26 May 2026 14:50:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJBx68GwQhVqMF6RAA--.10913S4;
 Tue, 26 May 2026 14:50:25 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH 02/12] target/loongarch: Use curState in cpu.c when accessing
 CSR registers
Date: Tue, 26 May 2026 14:50:13 +0800
Message-Id: <20260526065023.1639371-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260526065023.1639371-1-maobibo@loongson.cn>
References: <20260526065023.1639371-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBx68GwQhVqMF6RAA--.10913S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

When accessing CSR register in file cpu.c, use curState rather than
env.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 114 ++++++++++++++++++++++-------------------
 target/loongarch/cpu.h |   5 +-
 2 files changed, 63 insertions(+), 56 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 693ce30b60..49bc896d7c 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -62,6 +62,7 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
     LoongArchCPU *cpu = opaque;
     CPULoongArchState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
+    CPUSysState *cur = get_current_state(env);
 
     if (irq < 0 || irq >= N_IRQS) {
         return;
@@ -70,8 +71,8 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
     if (kvm_enabled()) {
         kvm_loongarch_set_interrupt(cpu, irq, level);
     } else if (tcg_enabled()) {
-        env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);
-        if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
+        cur->CSR_ESTAT = deposit64(cur->CSR_ESTAT, irq, 1, level != 0);
+        if (FIELD_EX64(cur->CSR_ESTAT, CSR_ESTAT, IS)) {
             cpu_interrupt(cs, CPU_INTERRUPT_HARD);
         } else {
             cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
@@ -84,9 +85,10 @@ bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
 {
     uint32_t pending;
     uint32_t status;
+    CPUSysState *cur = get_current_state(env);
 
-    pending = FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS);
-    status  = FIELD_EX64(env->CSR_ECFG, CSR_ECFG, LIE);
+    pending = FIELD_EX64(cur->CSR_ESTAT, CSR_ESTAT, IS);
+    status  = FIELD_EX64(cur->CSR_ECFG, CSR_ECFG, LIE);
 
     return (pending & status) != 0;
 }
@@ -112,11 +114,12 @@ static void loongarch_la464_init_csr(DeviceState *dev)
     static bool initialized;
     LoongArchCPU *cpu = LOONGARCH_CPU(dev);
     CPULoongArchState *env = &cpu->env;
+    CPUSysState *cur = get_current_state(env);
     int i, num;
 
     if (!initialized) {
         initialized = true;
-        num = FIELD_EX64(env->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM);
+        num = FIELD_EX64(cur->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM);
         for (i = num; i < 16; i++) {
             set_csr_flag(LOONGARCH_CSR_SAVE(i), CSRFL_UNUSED);
         }
@@ -275,6 +278,7 @@ static void loongarch_la464_initfn(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
     CPULoongArchState *env = &cpu->env;
+    CPUSysState *cur;
     uint32_t data = 0, field;
     int i;
 
@@ -382,18 +386,19 @@ static void loongarch_la464_initfn(Object *obj)
     data = FIELD_DP32(data, CPUCFG20, L3IU_SIZE, 6);
     env->cpucfg[20] = data;
 
-    env->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
+    cur = get_current_state(env);
+    cur->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
 
-    env->CSR_PRCFG1 = FIELD_DP64(env->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM, 8);
-    env->CSR_PRCFG1 = FIELD_DP64(env->CSR_PRCFG1, CSR_PRCFG1, TIMER_BITS, 0x2f);
-    env->CSR_PRCFG1 = FIELD_DP64(env->CSR_PRCFG1, CSR_PRCFG1, VSMAX, 7);
+    cur->CSR_PRCFG1 = FIELD_DP64(cur->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM, 8);
+    cur->CSR_PRCFG1 = FIELD_DP64(cur->CSR_PRCFG1, CSR_PRCFG1, TIMER_BITS, 0x2f);
+    cur->CSR_PRCFG1 = FIELD_DP64(cur->CSR_PRCFG1, CSR_PRCFG1, VSMAX, 7);
 
-    env->CSR_PRCFG2 = 0x3ffff000;
+    cur->CSR_PRCFG2 = 0x3ffff000;
 
-    env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, TLB_TYPE, 2);
-    env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, MTLB_ENTRY, 63);
-    env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, STLB_WAYS, 7);
-    env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS, 8);
+    cur->CSR_PRCFG3 = FIELD_DP64(cur->CSR_PRCFG3, CSR_PRCFG3, TLB_TYPE, 2);
+    cur->CSR_PRCFG3 = FIELD_DP64(cur->CSR_PRCFG3, CSR_PRCFG3, MTLB_ENTRY, 63);
+    cur->CSR_PRCFG3 = FIELD_DP64(cur->CSR_PRCFG3, CSR_PRCFG3, STLB_WAYS, 7);
+    cur->CSR_PRCFG3 = FIELD_DP64(cur->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS, 8);
 
     cpu->msgint = ON_OFF_AUTO_OFF;
     cpu->ptw = ON_OFF_AUTO_OFF;
@@ -595,6 +600,7 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
     CPUState *cs = CPU(obj);
     LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(obj);
     CPULoongArchState *env = cpu_env(cs);
+    CPUSysState *cur = get_current_state(env);
 
     if (lacc->parent_phases.hold) {
         lacc->parent_phases.hold(obj, type);
@@ -618,55 +624,55 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
 
     int n;
     /* Set csr registers value after reset, see the manual 6.4. */
-    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PLV, 0);
-    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, IE, 0);
-    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DA, 1);
-    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PG, 0);
-    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DATF, 0);
-    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DATM, 0);
-
-    env->CSR_EUEN = FIELD_DP64(env->CSR_EUEN, CSR_EUEN, FPE, 0);
-    env->CSR_EUEN = FIELD_DP64(env->CSR_EUEN, CSR_EUEN, SXE, 0);
-    env->CSR_EUEN = FIELD_DP64(env->CSR_EUEN, CSR_EUEN, ASXE, 0);
-    env->CSR_EUEN = FIELD_DP64(env->CSR_EUEN, CSR_EUEN, BTE, 0);
-
-    env->CSR_MISC = 0;
-
-    env->CSR_ECFG = FIELD_DP64(env->CSR_ECFG, CSR_ECFG, VS, 0);
-    env->CSR_ECFG = FIELD_DP64(env->CSR_ECFG, CSR_ECFG, LIE, 0);
-
-    env->CSR_ESTAT = env->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
-    env->CSR_RVACFG = FIELD_DP64(env->CSR_RVACFG, CSR_RVACFG, RBITS, 0);
-    env->CSR_CPUID = cs->cpu_index;
-    env->CSR_TCFG = FIELD_DP64(env->CSR_TCFG, CSR_TCFG, EN, 0);
-    env->CSR_LLBCTL = FIELD_DP64(env->CSR_LLBCTL, CSR_LLBCTL, KLO, 0);
-    env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
-    env->CSR_MERRCTL = FIELD_DP64(env->CSR_MERRCTL, CSR_MERRCTL, ISMERR, 0);
-    env->CSR_TID = cs->cpu_index;
+    cur->CSR_CRMD = FIELD_DP64(cur->CSR_CRMD, CSR_CRMD, PLV, 0);
+    cur->CSR_CRMD = FIELD_DP64(cur->CSR_CRMD, CSR_CRMD, IE, 0);
+    cur->CSR_CRMD = FIELD_DP64(cur->CSR_CRMD, CSR_CRMD, DA, 1);
+    cur->CSR_CRMD = FIELD_DP64(cur->CSR_CRMD, CSR_CRMD, PG, 0);
+    cur->CSR_CRMD = FIELD_DP64(cur->CSR_CRMD, CSR_CRMD, DATF, 0);
+    cur->CSR_CRMD = FIELD_DP64(cur->CSR_CRMD, CSR_CRMD, DATM, 0);
+
+    cur->CSR_EUEN = FIELD_DP64(cur->CSR_EUEN, CSR_EUEN, FPE, 0);
+    cur->CSR_EUEN = FIELD_DP64(cur->CSR_EUEN, CSR_EUEN, SXE, 0);
+    cur->CSR_EUEN = FIELD_DP64(cur->CSR_EUEN, CSR_EUEN, ASXE, 0);
+    cur->CSR_EUEN = FIELD_DP64(cur->CSR_EUEN, CSR_EUEN, BTE, 0);
+
+    cur->CSR_MISC = 0;
+
+    cur->CSR_ECFG = FIELD_DP64(cur->CSR_ECFG, CSR_ECFG, VS, 0);
+    cur->CSR_ECFG = FIELD_DP64(cur->CSR_ECFG, CSR_ECFG, LIE, 0);
+
+    cur->CSR_ESTAT = cur->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
+    cur->CSR_RVACFG = FIELD_DP64(cur->CSR_RVACFG, CSR_RVACFG, RBITS, 0);
+    cur->CSR_CPUID = cs->cpu_index;
+    cur->CSR_TCFG = FIELD_DP64(cur->CSR_TCFG, CSR_TCFG, EN, 0);
+    cur->CSR_LLBCTL = FIELD_DP64(cur->CSR_LLBCTL, CSR_LLBCTL, KLO, 0);
+    cur->CSR_TLBRERA = FIELD_DP64(cur->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
+    cur->CSR_MERRCTL = FIELD_DP64(cur->CSR_MERRCTL, CSR_MERRCTL, ISMERR, 0);
+    cur->CSR_TID = cs->cpu_index;
     /*
      * Workaround for edk2-stable202408, CSR PGD register is set only if
      * its value is equal to zero for boot cpu, it causes reboot issue.
      *
      * Here clear CSR registers relative with TLB.
      */
-    env->CSR_PGDH = 0;
-    env->CSR_PGDL = 0;
-    env->CSR_PWCH = 0;
-    env->CSR_EENTRY = 0;
-    env->CSR_TLBRENTRY = 0;
-    env->CSR_MERRENTRY = 0;
+    cur->CSR_PGDH = 0;
+    cur->CSR_PGDL = 0;
+    cur->CSR_PWCH = 0;
+    cur->CSR_EENTRY = 0;
+    cur->CSR_TLBRENTRY = 0;
+    cur->CSR_MERRENTRY = 0;
     /* set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits from CSR_PRCFG2 */
-    if (env->CSR_PRCFG2 == 0) {
-        env->CSR_PRCFG2 = 0x3fffff000;
+    if (cur->CSR_PRCFG2 == 0) {
+        cur->CSR_PRCFG2 = 0x3fffff000;
     }
-    tlb_ps = ctz32(env->CSR_PRCFG2);
-    env->CSR_STLBPS = FIELD_DP64(env->CSR_STLBPS, CSR_STLBPS, PS, tlb_ps);
-    env->CSR_PWCL = FIELD_DP64(env->CSR_PWCL, CSR_PWCL, PTBASE, tlb_ps);
+    tlb_ps = ctz32(cur->CSR_PRCFG2);
+    cur->CSR_STLBPS = FIELD_DP64(cur->CSR_STLBPS, CSR_STLBPS, PS, tlb_ps);
+    cur->CSR_PWCL = FIELD_DP64(cur->CSR_PWCL, CSR_PWCL, PTBASE, tlb_ps);
     for (n = 0; n < 4; n++) {
-        env->CSR_DMW[n] = FIELD_DP64(env->CSR_DMW[n], CSR_DMW, PLV0, 0);
-        env->CSR_DMW[n] = FIELD_DP64(env->CSR_DMW[n], CSR_DMW, PLV1, 0);
-        env->CSR_DMW[n] = FIELD_DP64(env->CSR_DMW[n], CSR_DMW, PLV2, 0);
-        env->CSR_DMW[n] = FIELD_DP64(env->CSR_DMW[n], CSR_DMW, PLV3, 0);
+        cur->CSR_DMW[n] = FIELD_DP64(cur->CSR_DMW[n], CSR_DMW, PLV0, 0);
+        cur->CSR_DMW[n] = FIELD_DP64(cur->CSR_DMW[n], CSR_DMW, PLV1, 0);
+        cur->CSR_DMW[n] = FIELD_DP64(cur->CSR_DMW[n], CSR_DMW, PLV2, 0);
+        cur->CSR_DMW[n] = FIELD_DP64(cur->CSR_DMW[n], CSR_DMW, PLV3, 0);
     }
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index e738923049..dedb3971e5 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -503,8 +503,9 @@ static inline bool is_va32(CPULoongArchState *env)
 {
     /* VA32 if !LA64 or VA32L[1-3] */
     bool va32 = !is_la64(env);
-    uint64_t plv = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
-    if (plv >= 1 && (FIELD_EX64(env->CSR_MISC, CSR_MISC, VA32) & (1 << plv))) {
+    CPUSysState *cur = get_current_state(env);
+    uint64_t plv = FIELD_EX64(cur->CSR_CRMD, CSR_CRMD, PLV);
+    if (plv >= 1 && (FIELD_EX64(cur->CSR_MISC, CSR_MISC, VA32) & (1 << plv))) {
         va32 = true;
     }
     return va32;
-- 
2.39.3


