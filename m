Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62659CA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF0w5-0004jO-AV; Thu, 08 Oct 2026 23:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xF0vU-0004cv-J4
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:05:42 -0400
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xF0vS-0005m1-O0
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:05:40 -0400
Received: from yuno-loong (unknown
 [IPv6:2409:8900:2684:b82:443b:7baf:6228:2a79])
 by krgm.moe (Postfix) with ESMTPSA id B0613E004;
 Fri, 09 Oct 2026 08:35:35 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v5 05/23] target/loongarch: add vm level 1 definition
Date: Fri,  9 Oct 2026 11:05:01 +0800
Message-ID: <d4fc3a5248011a32eaaa4ae4398fd8e7ad599fdb.1791514848.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791514848.git.prcups@krgm.moe>
References: <cover.1791514848.git.prcups@krgm.moe>
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

Add VM_LEVEL1 macro, env_vm_level() and trigger_vm_exit() functions, preparing
for later interrupt virtualization.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu.h         | 24 ++++++++++++++++++++++--
 target/loongarch/tcg/tcg_cpu.c |  3 +++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 0b7d63d8f3..183210efd8 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -323,7 +323,8 @@ typedef struct CPUTimerState {
 } CPUTimerState;
 
 #define VM_LEVEL0   0
-#define VM_LEVELS   1
+#define VM_LEVEL1   1
+#define VM_LEVELS   2
 
 #define CPU_VENDOR_LOONGSON   "Loongson"
 #define CPU_MODEL_3A5000      "3A5000"
@@ -434,7 +435,7 @@ typedef struct CPUArchState {
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-    CPUSysState sys_states[1];
+    CPUSysState sys_states[VM_LEVELS];
     uint32_t cpucfg[21];
     uint32_t pv_features;
     uint64_t vendor_id;
@@ -446,6 +447,7 @@ typedef struct CPUArchState {
     uint32_t mp_state;
 #endif
     CPUSysState *sys_state;
+    bool vm_exit;
 } CPULoongArchState;
 
 typedef struct LoongArchCPUTopo {
@@ -517,6 +519,11 @@ static inline CPUSysState *env_sys(CPULoongArchState *env)
     return env->sys_state;
 }
 
+static inline int env_vm_level(CPULoongArchState *env)
+{
+    return env_sys(env) - env->sys_states;
+}
+
 static inline void set_sys(CPULoongArchState *env, int vm_level)
 {
     env->sys_state = &env->sys_states[vm_level];
@@ -532,6 +539,18 @@ static inline bool cpu_has_lvz(CPULoongArchState *env)
     return FIELD_EX32(env->cpucfg[2], CPUCFG2, LVZ);
 }
 
+static inline void trigger_vm_exit(CPULoongArchState *env)
+{
+    CPUSysState *host = get_sys(env, VM_LEVEL0);
+
+    if (env_vm_level(env) != VM_LEVEL1) {
+        return;
+    }
+
+    host->CSR_GSTAT = FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, PVM, 1);
+    env->vm_exit = true;
+}
+
 static inline CPUTimerState *env_timer(CPULoongArchState *env)
 {
     return &env->sys_states[0].timer_state;
@@ -572,6 +591,7 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
 #define HW_FLAGS_CRMD_PG    R_CSR_CRMD_PG_MASK   /* 0x10 */
 #define HW_FLAGS_VA32       0x20
 #define HW_FLAGS_EUEN_ASXE  0x40
+#define HW_FLAGS_GUEST_MODE 0x80
 
 #define CPU_RESOLVING_TYPE TYPE_LOONGARCH_CPU
 
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 4b1d44a164..14fa5f5809 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -279,6 +279,9 @@ static TCGTBCPUState loongarch_get_tb_cpu_state(CPUState *cs)
     uint32_t flags;
 
     flags = sys->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
+    if (env_vm_level(env) == VM_LEVEL1) {
+        flags |= HW_FLAGS_GUEST_MODE;
+    }
     flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
     flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
     flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
-- 
2.55.0


