Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19413CD6E6B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVPr1-0006Tx-Rj; Fri, 05 Jun 2026 04:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wVPqy-0006S4-6a
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:24:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wVPqu-0004hh-7A
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 04:24:31 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8Dx13i6hyJqteMQAA--.21560S3;
 Fri, 05 Jun 2026 16:24:26 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJCxvsKuhyJqnLucAA--.34744S9;
 Fri, 05 Jun 2026 16:24:24 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v3 07/14] target/loongarch: Use sys_state in tcg_cpu.c when
 accessing CSR registers
Date: Fri,  5 Jun 2026 16:25:45 +0800
Message-ID: <20260605082552.175336-8-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605082552.175336-1-maobibo@loongson.cn>
References: <20260605082552.175336-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxvsKuhyJqnLucAA--.34744S9
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3AFW5Gw4xAw15GFykCr18Xrc_yoWfKFWrp3
 W8KFW0yry5Grn3A343J39xAF1rZw1xAws2y343CF1YkFykWr1FqFWkXr1UKrsrArW5Z3y7
 ZFnrXrWagF17GFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWr
 XVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
 AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
 6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF
 0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
 xhVjvjDU0xZFpf9x07j6sjUUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

When accessing CSR registers in file tcg_cpu.c, use sys_state rather
than env. There is no function change.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
---
 target/loongarch/tcg/tcg_cpu.c | 107 +++++++++++++++++----------------
 1 file changed, 56 insertions(+), 51 deletions(-)

diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 31d3db6e8e..66b3f45807 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -77,34 +77,35 @@ void G_NORETURN do_raise_exception(CPULoongArchState *env,
 static void loongarch_cpu_do_interrupt(CPUState *cs)
 {
     CPULoongArchState *env = cpu_env(cs);
+    CPUSysState *sys = env_sys(env);
     bool update_badinstr = 1;
     int cause = -1;
-    bool tlbfill = FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR);
-    uint32_t vec_size = FIELD_EX64(env->CSR_ECFG, CSR_ECFG, VS);
+    bool tlbfill = FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR);
+    uint32_t vec_size = FIELD_EX64(sys->CSR_ECFG, CSR_ECFG, VS);
     uint64_t last_pc = env->pc;
 
     if (cs->exception_index != EXCCODE_INT) {
         qemu_log_mask(CPU_LOG_INT,
                      "%s enter: pc " TARGET_FMT_lx " ERA " TARGET_FMT_lx
                      " TLBRERA " TARGET_FMT_lx " exception: %d (%s)\n",
-                     __func__, env->pc, env->CSR_ERA, env->CSR_TLBRERA,
+                     __func__, env->pc, sys->CSR_ERA, sys->CSR_TLBRERA,
                      cs->exception_index,
                      loongarch_exception_name(cs->exception_index));
     }
 
     switch (cs->exception_index) {
     case EXCCODE_DBP:
-        env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DCL, 1);
-        env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, ECODE, 0xC);
+        sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DCL, 1);
+        sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, ECODE, 0xC);
         goto set_DERA;
     set_DERA:
-        env->CSR_DERA = env->pc;
-        env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DST, 1);
-        set_pc(env, env->CSR_EENTRY + 0x480);
+        sys->CSR_DERA = env->pc;
+        sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DST, 1);
+        set_pc(env, sys->CSR_EENTRY + 0x480);
         break;
     case EXCCODE_INT:
-        if (FIELD_EX64(env->CSR_DBG, CSR_DBG, DST)) {
-            env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DEI, 1);
+        if (FIELD_EX64(sys->CSR_DBG, CSR_DBG, DST)) {
+            sys->CSR_DBG = FIELD_DP64(sys->CSR_DBG, CSR_DBG, DEI, 1);
             goto set_DERA;
         }
         QEMU_FALLTHROUGH;
@@ -115,7 +116,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
         update_badinstr = 0;
         break;
     case EXCCODE_BCE:
-        env->CSR_BADV = env->pc;
+        sys->CSR_BADV = env->pc;
         QEMU_FALLTHROUGH;
     case EXCCODE_SYS:
     case EXCCODE_BRK:
@@ -142,35 +143,35 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     if (update_badinstr) {
         MemOpIdx oi = make_memop_idx(MO_LEUL, cpu_mmu_index(cs, true));
 
-        env->CSR_BADI = cpu_ldl_code_mmu(env, env->pc, oi, 0);
+        sys->CSR_BADI = cpu_ldl_code_mmu(env, env->pc, oi, 0);
     }
 
     /* Save PLV and IE */
     if (tlbfill) {
-        env->CSR_TLBRPRMD = FIELD_DP64(env->CSR_TLBRPRMD, CSR_TLBRPRMD, PPLV,
-                                       FIELD_EX64(env->CSR_CRMD,
+        sys->CSR_TLBRPRMD = FIELD_DP64(sys->CSR_TLBRPRMD, CSR_TLBRPRMD, PPLV,
+                                       FIELD_EX64(sys->CSR_CRMD,
                                        CSR_CRMD, PLV));
-        env->CSR_TLBRPRMD = FIELD_DP64(env->CSR_TLBRPRMD, CSR_TLBRPRMD, PIE,
-                                       FIELD_EX64(env->CSR_CRMD, CSR_CRMD, IE));
+        sys->CSR_TLBRPRMD = FIELD_DP64(sys->CSR_TLBRPRMD, CSR_TLBRPRMD, PIE,
+                                       FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, IE));
         /* set the DA mode */
-        env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DA, 1);
-        env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PG, 0);
-        env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA,
+        sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DA, 1);
+        sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PG, 0);
+        sys->CSR_TLBRERA = FIELD_DP64(sys->CSR_TLBRERA, CSR_TLBRERA,
                                       PC, (env->pc >> 2));
     } else {
-        env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, ECODE,
+        sys->CSR_ESTAT = FIELD_DP64(sys->CSR_ESTAT, CSR_ESTAT, ECODE,
                                     EXCODE_MCODE(cause));
-        env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, ESUBCODE,
+        sys->CSR_ESTAT = FIELD_DP64(sys->CSR_ESTAT, CSR_ESTAT, ESUBCODE,
                                     EXCODE_SUBCODE(cause));
-        env->CSR_PRMD = FIELD_DP64(env->CSR_PRMD, CSR_PRMD, PPLV,
-                                   FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV));
-        env->CSR_PRMD = FIELD_DP64(env->CSR_PRMD, CSR_PRMD, PIE,
-                                   FIELD_EX64(env->CSR_CRMD, CSR_CRMD, IE));
-        env->CSR_ERA = env->pc;
+        sys->CSR_PRMD = FIELD_DP64(sys->CSR_PRMD, CSR_PRMD, PPLV,
+                                   FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PLV));
+        sys->CSR_PRMD = FIELD_DP64(sys->CSR_PRMD, CSR_PRMD, PIE,
+                                   FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, IE));
+        sys->CSR_ERA = env->pc;
     }
 
-    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PLV, 0);
-    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, IE, 0);
+    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PLV, 0);
+    sys->CSR_CRMD = FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, IE, 0);
 
     if (vec_size) {
         vec_size = (1 << vec_size) * 4;
@@ -179,27 +180,27 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     if  (cs->exception_index == EXCCODE_INT) {
         /* Interrupt */
         uint32_t vector = 0;
-        uint32_t pending = FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS);
-        pending &= FIELD_EX64(env->CSR_ECFG, CSR_ECFG, LIE);
+        uint32_t pending = FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS);
+        pending &= FIELD_EX64(sys->CSR_ECFG, CSR_ECFG, LIE);
 
         /* Find the highest-priority interrupt. */
         vector = 31 - clz32(pending);
-        set_pc(env, env->CSR_EENTRY + \
+        set_pc(env, sys->CSR_EENTRY + \
                (EXCCODE_EXTERNAL_INT + vector) * vec_size);
         qemu_log_mask(CPU_LOG_INT,
                       "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx
                       " cause %d\n" "    A " TARGET_FMT_lx " D "
                       TARGET_FMT_lx " vector = %d ExC " TARGET_FMT_lx "ExS"
                       TARGET_FMT_lx "\n",
-                      __func__, env->pc, env->CSR_ERA,
-                      cause, env->CSR_BADV, env->CSR_DERA, vector,
-                      env->CSR_ECFG, env->CSR_ESTAT);
+                      __func__, env->pc, sys->CSR_ERA,
+                      cause, sys->CSR_BADV, sys->CSR_DERA, vector,
+                      sys->CSR_ECFG, sys->CSR_ESTAT);
         qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
     } else {
         if (tlbfill) {
-            set_pc(env, env->CSR_TLBRENTRY);
+            set_pc(env, sys->CSR_TLBRENTRY);
         } else {
-            set_pc(env, env->CSR_EENTRY + EXCODE_MCODE(cause) * vec_size);
+            set_pc(env, sys->CSR_EENTRY + EXCODE_MCODE(cause) * vec_size);
         }
         qemu_log_mask(CPU_LOG_INT,
                       "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx
@@ -207,12 +208,12 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
                       " EXCFG " TARGET_FMT_lx " BADVA " TARGET_FMT_lx
                       "BADI " TARGET_FMT_lx " SYS_NUM " TARGET_FMT_lu
                       " cpu %d asid " TARGET_FMT_lx "\n", __func__, env->pc,
-                      tlbfill ? env->CSR_TLBRERA : env->CSR_ERA,
-                      cause, tlbfill ? "(refill)" : "", env->CSR_ESTAT,
-                      env->CSR_ECFG,
-                      tlbfill ? env->CSR_TLBRBADV : env->CSR_BADV,
-                      env->CSR_BADI, env->gpr[11], cs->cpu_index,
-                      env->CSR_ASID);
+                      tlbfill ? sys->CSR_TLBRERA : sys->CSR_ERA,
+                      cause, tlbfill ? "(refill)" : "", sys->CSR_ESTAT,
+                      sys->CSR_ECFG,
+                      tlbfill ? sys->CSR_TLBRBADV : sys->CSR_BADV,
+                      sys->CSR_BADI, env->gpr[11], cs->cpu_index,
+                      sys->CSR_ASID);
         qemu_plugin_vcpu_exception_cb(cs, last_pc);
     }
     cs->exception_index = -1;
@@ -226,8 +227,9 @@ static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                                 uintptr_t retaddr)
 {
     CPULoongArchState *env = cpu_env(cs);
+    CPUSysState *sys = env_sys(env);
 
-    env->CSR_BADV = addr;
+    sys->CSR_BADV = addr;
     if (access_type == MMU_INST_FETCH) {
         do_raise_exception(env, EXCCODE_ADEF, retaddr);
     } else {
@@ -238,9 +240,10 @@ static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
 static inline bool cpu_loongarch_hw_interrupts_enabled(CPULoongArchState *env)
 {
     bool ret = 0;
+    CPUSysState *sys = env_sys(env);
 
-    ret = (FIELD_EX64(env->CSR_CRMD, CSR_CRMD, IE) &&
-          !(FIELD_EX64(env->CSR_DBG, CSR_DBG, DST)));
+    ret = (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, IE) &&
+          !(FIELD_EX64(sys->CSR_DBG, CSR_DBG, DST)));
 
     return ret;
 }
@@ -271,12 +274,13 @@ static vaddr loongarch_pointer_wrap(CPUState *cs, int mmu_idx,
 static TCGTBCPUState loongarch_get_tb_cpu_state(CPUState *cs)
 {
     CPULoongArchState *env = cpu_env(cs);
+    CPUSysState *sys = env_sys(env);
     uint32_t flags;
 
-    flags = env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
-    flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
-    flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
-    flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
+    flags = sys->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
+    flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
+    flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
+    flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
     flags |= is_va32(env) * HW_FLAGS_VA32;
 
     return (TCGTBCPUState){ .pc = env->pc, .flags = flags };
@@ -299,9 +303,10 @@ static void loongarch_restore_state_to_opc(CPUState *cs,
 static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
     CPULoongArchState *env = cpu_env(cs);
+    CPUSysState *sys = env_sys(env);
 
-    if (FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG)) {
-        return FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
+    if (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PG)) {
+        return FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PLV);
     }
     return MMU_DA_IDX;
 }
-- 
2.54.0


