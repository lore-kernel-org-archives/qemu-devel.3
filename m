Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E770ECA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF0xM-0006kD-89; Thu, 08 Oct 2026 23:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xF0vu-0004h7-EJ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:06:09 -0400
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xF0vq-0005ot-Vi
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:06:04 -0400
Received: from yuno-loong (unknown
 [IPv6:2409:8900:2684:b82:443b:7baf:6228:2a79])
 by krgm.moe (Postfix) with ESMTPSA id 14F08E006;
 Fri, 09 Oct 2026 08:36:00 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
	SignKirigami <prcups@krgm.moe>
Subject: [PATCH v5 23/23] target/loongarch: exit to vm level 0 for fpd,
 sxd and asxd of vm level 0
Date: Fri,  9 Oct 2026 11:05:19 +0800
Message-ID: <7948d6f966049e9e67af89243930b9c282acc918.1791514848.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791514848.git.prcups@krgm.moe>
References: <cover.1791514848.git.prcups@krgm.moe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a14:640:1:12b5::1 (failed)
Received-SPF: pass client-ip=2a14:640:1:12b5::1; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When vm level 0 fpe, sxe and asxe is set to 0, although on vm level 1 these
are enabled, in TCGTBCPUState flags corresponding bit should not be set, and
when handling exceptions, executing trigger_vm_exit() in this situation.

Signed-off-by: SignKirigami <prcups@krgm.moe>
---
 target/loongarch/tcg/op_helper.c | 20 ++++++++++++++++++++
 target/loongarch/tcg/tcg_cpu.c   | 17 ++++++++++++-----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index e2fe4b212f..a24a9b8b6a 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -20,9 +20,29 @@
 /* Exceptions helpers */
 void helper_raise_exception(CPULoongArchState *env, uint32_t exception)
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
index 6f1ba12edb..f70efaad78 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -304,16 +304,23 @@ static vaddr loongarch_pointer_wrap(CPUState *cs, int mmu_idx,
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
2.55.0


