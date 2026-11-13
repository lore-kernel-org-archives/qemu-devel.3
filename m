Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2343606A33A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmvR-0002qf-8w; Fri, 13 Nov 2026 03:46:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvO-0002mP-Pp
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:22 -0500
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmvM-0007QN-UP
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:22 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id D63E4780E;
 Fri, 13 Nov 2026 14:16:17 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v6 05/26] target/loongarch: add definition about guest mmu_idx
Date: Fri, 13 Nov 2026 16:45:20 +0800
Message-ID: <455f9e7061ffb73d3bb9ef9b43bc1029e9ac145b.1794558695.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794558695.git.prcups@krgm.moe>
References: <cover.1794558695.git.prcups@krgm.moe>
X-Archived-By: <archiver.kernel.org>
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

Add MMU_GUEST_IDX and MMU_GUEST_DA_IDX. Provide is_guest_mmu idx() and
mmu_idx_to_plv to calculate plv with new mmu_idx.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/cpu.h                         | 18 ++++++++++++++++++
 .../tcg/insn_trans/trans_privileged.c.inc      |  2 +-
 target/loongarch/tcg/tcg_cpu.c                 |  7 +++++++
 target/loongarch/tcg/translate.c               |  3 +++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ff22cde702..14316fc9c5 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -516,6 +516,24 @@ struct LoongArchCPUClass {
 #define MMU_KERNEL_IDX   MMU_PLV_KERNEL
 #define MMU_USER_IDX     MMU_PLV_USER
 #define MMU_DA_IDX       4
+#define MMU_GUEST_IDX    5
+#define MMU_GUEST_DA_IDX (MMU_GUEST_IDX + MMU_DA_IDX)
+
+static inline int mmu_idx_vm_level(int mmu_idx)
+{
+    return mmu_idx >= MMU_GUEST_IDX;
+}
+
+static inline int mmu_idx_to_plv(int mmu_idx)
+{
+    if (mmu_idx == MMU_DA_IDX || mmu_idx == MMU_GUEST_DA_IDX) {
+        return 0;
+    }
+    if (mmu_idx_vm_level(mmu_idx)) {
+        return mmu_idx - MMU_GUEST_IDX;
+    }
+    return mmu_idx;
+}
 
 static inline CPUSysState *env_sys(CPULoongArchState *env)
 {
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 6728ce5ec9..7ee3bb8e27 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -249,7 +249,7 @@ TRANS64(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_d)
 
 static void check_mmu_idx(DisasContext *ctx)
 {
-    if (ctx->mem_idx != MMU_DA_IDX) {
+    if (ctx->mem_idx != MMU_DA_IDX && ctx->mem_idx != MMU_GUEST_DA_IDX) {
         tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next + 4);
         ctx->base.is_jmp = DISAS_EXIT;
     }
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index c2792c8db1..7babc1a1f9 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -269,6 +269,13 @@ static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
     CPULoongArchState *env = cpu_env(cs);
     CPUSysState *sys = env_sys(env);
 
+    if (env_vm_level(env) == VM_LEVEL1) {
+        if (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PG)) {
+            return MMU_GUEST_IDX + FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PLV);
+        }
+        return MMU_GUEST_DA_IDX;
+    }
+
     if (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PG)) {
         return FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PLV);
     }
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 124dce6269..4ab06b48da 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -129,6 +129,9 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
     } else {
         ctx->mem_idx = MMU_DA_IDX;
     }
+    if (ctx->base.tb->flags & HW_FLAGS_GUEST_MODE) {
+        ctx->mem_idx += MMU_GUEST_IDX;
+    }
 
     /* Bound the number of insns to execute to those left on the page.  */
     bound = -(ctx->base.pc_first | TARGET_PAGE_MASK) / 4;
-- 
2.56.0


