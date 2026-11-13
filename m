Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B399606C188
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmx8-0004ru-8v; Fri, 13 Nov 2026 03:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvq-000327-6P
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:52 -0500
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmvo-0007W4-BY
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:49 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 0F58F780E;
 Fri, 13 Nov 2026 14:16:46 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
	SignKirigami <prcups@krgm.moe>
Subject: [PATCH v6 26/26] target/loongarch: exit to vm level 0 for fpd,
 sxd and asxd of vm level 0
Date: Fri, 13 Nov 2026 16:45:41 +0800
Message-ID: <a94445d9ea2bf32832a62b62a446d90ecda03985.1794558695.git.prcups@krgm.moe>
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

When vm level 0 fpe, sxe and asxe is set to 0, although on vm level 1 these
are enabled, in TCGTBCPUState flags corresponding bit should not be set, and
when handling exceptions, executing trigger_vm_exit() in this situation.

Signed-off-by: SignKirigami <prcups@krgm.moe>
---
 target/loongarch/tcg/op_helper.c | 20 ++++++++++++++++++++
 target/loongarch/tcg/tcg_cpu.c   | 17 ++++++++++++-----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index 3b32e04268..3eaf2cfd69 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -20,9 +20,29 @@
 /* Exceptions helpers */
 void HELPER(raise_exception)(CPULoongArchState *env, uint32_t exception)
 {
+    CPUSysState *host;
+    int vm_exit = 0;
+
     if (exception == EXCCODE_GSPR || exception == EXCCODE_HVC) {
+        vm_exit = 1;
+    } else if (env_vm_level(env)) {
+        host = get_sys(env, VM_LEVEL0);
+        if (exception == EXCCODE_FPD &&
+            FIELD_EX64(host->CSR_EUEN, CSR_EUEN, FPE) == 0) {
+            vm_exit = 1;
+        } else if (exception == EXCCODE_SXD &&
+            FIELD_EX64(host->CSR_EUEN, CSR_EUEN, SXE) == 0) {
+            vm_exit = 1;
+        }
+        if (exception == EXCCODE_ASXD &&
+            FIELD_EX64(host->CSR_EUEN, CSR_EUEN, ASXE) == 0) {
+            vm_exit = 1;
+        }
+    }
+    if (vm_exit) {
         trigger_vm_exit(env);
     }
+
     do_raise_exception(env, exception, GETPC());
 }
 
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 1301a9c6ad..523e0e02a1 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -261,16 +261,23 @@ static vaddr loongarch_pointer_wrap(CPUState *cs, int mmu_idx,
 static TCGTBCPUState loongarch_get_tb_cpu_state(CPUState *cs)
 {
     CPULoongArchState *env = cpu_env(cs);
-    CPUSysState *sys = env_sys(env);
-    uint32_t flags;
+    CPUSysState *sys = env_sys(env), *host;
+    uint32_t flags, fpe, sxe, asxe;
 
     flags = sys->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
+    fpe = FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, FPE);
+    sxe = FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, SXE);
+    asxe = FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, ASXE);
     if (env_vm_level(env) == VM_LEVEL1) {
         flags |= HW_FLAGS_GUEST_MODE;
+        host = get_sys(env, VM_LEVEL0);
+        fpe &= FIELD_EX64(host->CSR_EUEN, CSR_EUEN, FPE);
+        sxe &= FIELD_EX64(host->CSR_EUEN, CSR_EUEN, SXE);
+        asxe &= FIELD_EX64(host->CSR_EUEN, CSR_EUEN, ASXE);
     }
-    flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
-    flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
-    flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
+    flags |= fpe * HW_FLAGS_EUEN_FPE;
+    flags |= sxe * HW_FLAGS_EUEN_SXE;
+    flags |= asxe * HW_FLAGS_EUEN_ASXE;
     flags |= is_va32(env) * HW_FLAGS_VA32;
 
     return (TCGTBCPUState){ .pc = env->pc, .flags = flags };
-- 
2.56.0


