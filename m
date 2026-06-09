Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D70BCD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWtB4-0006xh-Ny; Tue, 09 Jun 2026 05:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wWtAk-0006lN-Vs
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:55:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wWtAg-0004u4-Rx
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:55:02 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx3sDs4idqgjUSAA--.24750S3;
 Tue, 09 Jun 2026 17:54:52 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJDxSMHg4idqJrGgAA--.28412S9;
 Tue, 09 Jun 2026 17:54:52 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PULL 07/14] target/loongarch: Use sys_state in tcg_cpu.c when
 accessing CSR registers
Date: Tue,  9 Jun 2026 17:28:17 +0800
Message-Id: <20260609092824.227250-8-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260609092824.227250-1-gaosong@loongson.cn>
References: <20260609092824.227250-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxSMHg4idqJrGgAA--.28412S9
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

When accessing CSR registers in file tcg_cpu.c, use sys_state rather
than env. There is no function change.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Tested-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20260605082552.175336-8-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
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


