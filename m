Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA14CD8CA7
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWtAw-0006nk-AB; Tue, 09 Jun 2026 05:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wWtAm-0006lP-CI
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:55:05 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wWtAg-0004sz-Pn
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:55:02 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxVXjq4idqdjUSAA--.23783S3;
 Tue, 09 Jun 2026 17:54:50 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxSMHg4idqJrGgAA--.28412S4;
 Tue, 09 Jun 2026 17:54:49 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PULL 02/14] target/loongarch: Use sys_state in cpu.c when accessing
 CSR registers
Date: Tue,  9 Jun 2026 17:28:12 +0800
Message-Id: <20260609092824.227250-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260609092824.227250-1-gaosong@loongson.cn>
References: <20260609092824.227250-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxSMHg4idqJrGgAA--.28412S4
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

From: Bibo Mao <maobibo@loongson.cn>

When accessing CSR register in file cpu.c, use sys_state rather than
env.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Tested-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20260605082552.175336-3-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c | 114 ++++++++++++++++++++++-------------------
 target/loongarch/cpu.h |   5 +-
 2 files changed, 63 insertions(+), 56 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 13de1722de..8424f185f2 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -62,6 +62,7 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
     LoongArchCPU *cpu = opaque;
     CPULoongArchState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
+    CPUSysState *sys = env_sys(env);
 
     if (irq < 0 || irq >= N_IRQS) {
         return;
@@ -70,8 +71,8 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
     if (kvm_enabled()) {
         kvm_loongarch_set_interrupt(cpu, irq, level);
     } else if (tcg_enabled()) {
-        env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);
-        if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
+        sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, irq, 1, level != 0);
+        if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
             cpu_interrupt(cs, CPU_INTERRUPT_HARD);
         } else {
             cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
@@ -84,9 +85,10 @@ bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
 {
     uint32_t pending;
     uint32_t status;
+    CPUSysState *sys = env_sys(env);
 
-    pending = FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS);
-    status  = FIELD_EX64(env->CSR_ECFG, CSR_ECFG, LIE);
+    pending = FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS);
+    status  = FIELD_EX64(sys->CSR_ECFG, CSR_ECFG, LIE);
 
     return (pending & status) != 0;
 }
@@ -112,11 +114,12 @@ static void loongarch_la464_init_csr(DeviceState *dev)
     static bool initialized;
     LoongArchCPU *cpu = LOONGARCH_CPU(dev);
     CPULoongArchState *env = &cpu->env;
+    CPUSysState *sys = env_sys(env);
     int i, num;
 
     if (!initialized) {
         initialized = true;
-        num = FIELD_EX64(env->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM);
+        num = FIELD_EX64(sys->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM);
         for (i = num; i < 16; i++) {
             set_csr_flag(LOONGARCH_CSR_SAVE(i), CSRFL_UNUSED);
         }
@@ -275,6 +278,7 @@ static void loongarch_la464_initfn(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
     CPULoongArchState *env = &cpu->env;
+    CPUSysState *sys;
     uint32_t data = 0, field;
     int i;
 
@@ -382,18 +386,19 @@ static void loongarch_la464_initfn(Object *obj)
     data = FIELD_DP32(data, CPUCFG20, L3IU_SIZE, 6);
     env->cpucfg[20] = data;
 
-    env->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
+    sys = env_sys(env);
+    sys->CSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
 
-    env->CSR_PRCFG1 = FIELD_DP64(env->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM, 8);
-    env->CSR_PRCFG1 = FIELD_DP64(env->CSR_PRCFG1, CSR_PRCFG1, TIMER_BITS, 0x2f);
-    env->CSR_PRCFG1 = FIELD_DP64(env->CSR_PRCFG1, CSR_PRCFG1, VSMAX, 7);
+    sys->CSR_PRCFG1 = FIELD_DP64(sys->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM, 8);
+    sys->CSR_PRCFG1 = FIELD_DP64(sys->CSR_PRCFG1, CSR_PRCFG1, TIMER_BITS, 0x2f);
+    sys->CSR_PRCFG1 = FIELD_DP64(sys->CSR_PRCFG1, CSR_PRCFG1, VSMAX, 7);
 
-    env->CSR_PRCFG2 = 0x3ffff000;
+    sys->CSR_PRCFG2 = 0x3ffff000;
 
-    env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, TLB_TYPE, 2);
-    env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, MTLB_ENTRY, 63);
-    env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, STLB_WAYS, 7);
-    env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS, 8);
+    sys->CSR_PRCFG3 = FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, TLB_TYPE, 2);
+    sys->CSR_PRCFG3 = FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, MTLB_ENTRY, 63);
+    sys->CSR_PRCFG3 = FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, STLB_WAYS, 7);
+    sys->CSR_PRCFG3 = FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS, 8);
 
     cpu->msgint = ON_OFF_AUTO_OFF;
     cpu->ptw = ON_OFF_AUTO_OFF;
@@ -595,6 +600,7 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
     CPUState *cs = CPU(obj);
     LoongArchCPUClass *lacc = LOONGARCH_CPU_GET_CLASS(obj);
     CPULoongArchState *env = cpu_env(cs);
+    CPUSysState *sys = env_sys(env);
 
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
+    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PLV, 0);
+    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, IE, 0);
+    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DA, 1);
+    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PG, 0);
+    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DATF, 0);
+    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DATM, 0);
+
+    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, FPE, 0);
+    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, SXE, 0);
+    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, ASXE, 0);
+    sys->CSR_EUEN = FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, BTE, 0);
+
+    sys->CSR_MISC = 0;
+
+    sys->CSR_ECFG = FIELD_DP64(sys->CSR_ECFG, CSR_ECFG, VS, 0);
+    sys->CSR_ECFG = FIELD_DP64(sys->CSR_ECFG, CSR_ECFG, LIE, 0);
+
+    sys->CSR_ESTAT = sys->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
+    sys->CSR_RVACFG = FIELD_DP64(sys->CSR_RVACFG, CSR_RVACFG, RBITS, 0);
+    sys->CSR_CPUID = cs->cpu_index;
+    sys->CSR_TCFG = FIELD_DP64(sys->CSR_TCFG, CSR_TCFG, EN, 0);
+    sys->CSR_LLBCTL = FIELD_DP64(sys->CSR_LLBCTL, CSR_LLBCTL, KLO, 0);
+    sys->CSR_TLBRERA = FIELD_DP64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
+    sys->CSR_MERRCTL = FIELD_DP64(sys->CSR_MERRCTL, CSR_MERRCTL, ISMERR, 0);
+    sys->CSR_TID = cs->cpu_index;
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
+    sys->CSR_PGDH = 0;
+    sys->CSR_PGDL = 0;
+    sys->CSR_PWCH = 0;
+    sys->CSR_EENTRY = 0;
+    sys->CSR_TLBRENTRY = 0;
+    sys->CSR_MERRENTRY = 0;
     /* set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits from CSR_PRCFG2 */
-    if (env->CSR_PRCFG2 == 0) {
-        env->CSR_PRCFG2 = 0x3fffff000;
+    if (sys->CSR_PRCFG2 == 0) {
+        sys->CSR_PRCFG2 = 0x3fffff000;
     }
-    tlb_ps = ctz32(env->CSR_PRCFG2);
-    env->CSR_STLBPS = FIELD_DP64(env->CSR_STLBPS, CSR_STLBPS, PS, tlb_ps);
-    env->CSR_PWCL = FIELD_DP64(env->CSR_PWCL, CSR_PWCL, PTBASE, tlb_ps);
+    tlb_ps = ctz32(sys->CSR_PRCFG2);
+    sys->CSR_STLBPS = FIELD_DP64(sys->CSR_STLBPS, CSR_STLBPS, PS, tlb_ps);
+    sys->CSR_PWCL = FIELD_DP64(sys->CSR_PWCL, CSR_PWCL, PTBASE, tlb_ps);
     for (n = 0; n < 4; n++) {
-        env->CSR_DMW[n] = FIELD_DP64(env->CSR_DMW[n], CSR_DMW, PLV0, 0);
-        env->CSR_DMW[n] = FIELD_DP64(env->CSR_DMW[n], CSR_DMW, PLV1, 0);
-        env->CSR_DMW[n] = FIELD_DP64(env->CSR_DMW[n], CSR_DMW, PLV2, 0);
-        env->CSR_DMW[n] = FIELD_DP64(env->CSR_DMW[n], CSR_DMW, PLV3, 0);
+        sys->CSR_DMW[n] = FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV0, 0);
+        sys->CSR_DMW[n] = FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV1, 0);
+        sys->CSR_DMW[n] = FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV2, 0);
+        sys->CSR_DMW[n] = FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV3, 0);
     }
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index b087548295..906470f59b 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -503,8 +503,9 @@ static inline bool is_va32(CPULoongArchState *env)
 {
     /* VA32 if !LA64 or VA32L[1-3] */
     bool va32 = !is_la64(env);
-    uint64_t plv = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
-    if (plv >= 1 && (FIELD_EX64(env->CSR_MISC, CSR_MISC, VA32) & (1 << plv))) {
+    CPUSysState *sys = env_sys(env);
+    uint64_t plv = FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PLV);
+    if (plv >= 1 && (FIELD_EX64(sys->CSR_MISC, CSR_MISC, VA32) & (1 << plv))) {
         va32 = true;
     }
     return va32;
-- 
2.54.0


