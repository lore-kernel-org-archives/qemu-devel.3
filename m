Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBF0606B369
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRmwD-0003BF-SM; Fri, 13 Nov 2026 03:47:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xRmvl-00030Q-Ad
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:47 -0500
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xRmvj-0007W4-ET
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 03:46:44 -0500
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 3437D82B;
 Fri, 13 Nov 2026 14:16:41 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v6 22/26] target/loongarch: add guest CSR operations
Date: Fri, 13 Nov 2026 16:45:37 +0800
Message-ID: <c2019d74a2bb168a670ed27ec4332ab5971f1593.1794558695.git.prcups@krgm.moe>
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

Add gcsrrd, gcsrwr and gcsrxchg for guest CSR management.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/disas.c                      |  3 +++
 target/loongarch/insns.decode                 |  6 +++++
 .../tcg/insn_trans/trans_privileged.c.inc     | 27 +++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 03d1e560dd..3010e16608 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -682,6 +682,9 @@ INSN(bgeu,         rr_offs)
 INSN(csrrd,        r_csr)
 INSN(csrwr,        r_csr)
 INSN(csrxchg,      rr_csr)
+INSN(gcsrrd,       r_csr)
+INSN(gcsrwr,       r_csr)
+INSN(gcsrxchg,     rr_csr)
 INSN(iocsrrd_b,    rr)
 INSN(iocsrrd_h,    rr)
 INSN(iocsrrd_w,    rr)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 3089d42044..4612af9433 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -493,6 +493,12 @@ bgeu            0110 11 ................ ..... .....     @rr_offs16
   csrxchg           0000 0100 .............. ..... .....     @rr_csr
 }
 
+{
+  gcsrrd            0000 0101 .............. 00000 .....     @r_csr
+  gcsrwr            0000 0101 .............. 00001 .....     @r_csr
+  gcsrxchg          0000 0101 .............. ..... .....     @rr_csr
+}
+
 iocsrrd_b        0000 01100100 10000 00000 ..... .....    @rr
 iocsrrd_h        0000 01100100 10000 00001 ..... .....    @rr
 iocsrrd_w        0000 01100100 10000 00010 ..... .....    @rr
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 39d217877d..cfcd234340 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -39,6 +39,9 @@ GEN_FALSE_TRANS(lddir)
 GEN_FALSE_TRANS(ertn)
 GEN_FALSE_TRANS(dbcl)
 GEN_FALSE_TRANS(idle)
+GEN_FALSE_TRANS(gcsrrd)
+GEN_FALSE_TRANS(gcsrwr)
+GEN_FALSE_TRANS(gcsrxchg)
 
 #else
 
@@ -256,6 +259,30 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
     return trans_csrxchg_impl(ctx, a, mmu_idx_vm_level(ctx->mem_idx));
 }
 
+static bool trans_gcsrrd(DisasContext *ctx, arg_gcsrrd *a)
+{
+    if (!avail_LVZ(ctx) || mmu_idx_vm_level(ctx->mem_idx)) {
+        return false;
+    }
+    return trans_csrrd_impl(ctx, a, VM_LEVEL1);
+}
+
+static bool trans_gcsrwr(DisasContext *ctx, arg_gcsrwr *a)
+{
+    if (!avail_LVZ(ctx) || mmu_idx_vm_level(ctx->mem_idx)) {
+        return false;
+    }
+    return trans_csrwr_impl(ctx, a, VM_LEVEL1);
+}
+
+static bool trans_gcsrxchg(DisasContext *ctx, arg_gcsrxchg *a)
+{
+    if (!avail_LVZ(ctx) || mmu_idx_vm_level(ctx->mem_idx)) {
+        return false;
+    }
+    return trans_csrxchg_impl(ctx, a, VM_LEVEL1);
+}
+
 static bool gen_iocsrrd(DisasContext *ctx, arg_rr *a,
                         void (*func)(TCGv, TCGv_ptr, TCGv))
 {
-- 
2.56.0


