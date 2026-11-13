Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D3A606C1AA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmvQ-0002pw-Eq; Fri, 13 Nov 2026 03:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvN-0002ll-DX
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:21 -0500
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmvK-0007Pz-RX
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:21 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 30D22780D;
 Fri, 13 Nov 2026 14:16:16 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v6 04/26] target/loongarch: add vm level 1 definition
Date: Fri, 13 Nov 2026 16:45:19 +0800
Message-ID: <4d1d8f40f581a9a0a5986480eceadc4c62e576c8.1794558695.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794558695.git.prcups@krgm.moe>
References: <cover.1794558695.git.prcups@krgm.moe>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add VM_LEVEL1 macro, env_vm_level() and trigger_vm_exit() functions, preparing
for later interrupt virtualization.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu.h         | 22 +++++++++++++++++++++-
 target/loongarch/tcg/tcg_cpu.c |  3 +++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 05309336d2..ff22cde702 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -324,7 +324,8 @@ typedef struct CPUTimerState {
 } CPUTimerState;
 
 #define VM_LEVEL0   0
-#define VM_LEVELS   1
+#define VM_LEVEL1   1
+#define VM_LEVELS   2
 
 #define CPU_VENDOR_LOONGSON   "Loongson"
 #define CPU_MODEL_3A5000      "3A5000"
@@ -448,6 +449,7 @@ typedef struct CPUArchState {
 #endif
     int vm_level;
     unsigned int irq_nr;
+    bool vm_exit;
 } CPULoongArchState;
 
 typedef struct LoongArchCPUTopo {
@@ -520,6 +522,11 @@ static inline CPUSysState *env_sys(CPULoongArchState *env)
     return &env->sys_states[env->vm_level];
 }
 
+static inline int env_vm_level(CPULoongArchState *env)
+{
+    return env_sys(env) - env->sys_states;
+}
+
 static inline void set_sys(CPULoongArchState *env, int vm_level)
 {
     if (vm_level >= 0 && vm_level <  VM_LEVELS) {
@@ -537,6 +544,18 @@ static inline bool cpu_has_lvz(CPULoongArchState *env)
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
@@ -583,6 +602,7 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
 #define HW_FLAGS_CRMD_PG    R_CSR_CRMD_PG_MASK   /* 0x10 */
 #define HW_FLAGS_VA32       0x20
 #define HW_FLAGS_EUEN_ASXE  0x40
+#define HW_FLAGS_GUEST_MODE 0x80
 
 #define CPU_RESOLVING_TYPE TYPE_LOONGARCH_CPU
 
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 0549506035..c2792c8db1 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -239,6 +239,9 @@ static TCGTBCPUState loongarch_get_tb_cpu_state(CPUState *cs)
     uint32_t flags;
 
     flags = sys->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
+    if (env_vm_level(env) == VM_LEVEL1) {
+        flags |= HW_FLAGS_GUEST_MODE;
+    }
     flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
     flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
     flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
-- 
2.56.0


