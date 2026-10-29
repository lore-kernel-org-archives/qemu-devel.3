Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF59B606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMW4V-0000Qt-6Y; Thu, 29 Oct 2026 15:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rishab@rispop.dev>)
 id 1xMV1G-0008Jc-UW; Thu, 29 Oct 2026 14:38:34 -0400
Received: from mail-08.mail-europe.com ([57.129.93.249])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rishab@rispop.dev>)
 id 1xMV1D-00014S-5R; Thu, 29 Oct 2026 14:38:33 -0400
X-Pm-Submission-Id: 4jFtK050Rtz1DFSk
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Tarun Patanjali <tarun.patanjali@utexas.edu>,
 Chris Elwood <christopher.elwood2024@gmail.com>,
 Rishab Pradeep <rishab@rispop.dev>
Subject: [PATCH 1/2] target/riscv: Factor out pointer-masking address
 adjustment
Date: Thu, 29 Oct 2026 13:37:50 -0500
Message-ID: <20261029183751.11143-2-rishab@rispop.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029183751.11143-1-rishab@rispop.dev>
References: <20261029183751.11143-1-rishab@rispop.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=57.129.93.249; envelope-from=rishab@rispop.dev;
 helo=mail-08.mail-europe.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 29 Oct 2026 15:45:56 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Rishab Pradeep <rishab@rispop.dev>
From:  Rishab Pradeep via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the addr_xl/addr_signed extract, which applies address-width
truncation and the pointer-masking ignore transformation, out of
get_address() and get_address_indexed() into a new helper,
gen_pm_adjust_addr(), so it can be applied to addresses that are not
formed from a GPR. No functional change.

Co-developed-by: Tarun Patanjali <tarun.patanjali@utexas.edu>
Signed-off-by: Tarun Patanjali <tarun.patanjali@utexas.edu>
Co-developed-by: Chris Elwood <christopher.elwood2024@gmail.com>
Signed-off-by: Chris Elwood <christopher.elwood2024@gmail.com>
Signed-off-by: Rishab Pradeep <rishab@rispop.dev>
---
 target/riscv/tcg/translate.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index 79b0f444ef..72d36764d8 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -654,6 +654,15 @@ static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
+static void gen_pm_adjust_addr(DisasContext *ctx, TCGv dest, TCGv src)
+{
+    if (ctx->addr_signed) {
+        tcg_gen_sextract_tl(dest, src, 0, ctx->addr_xl);
+    } else {
+        tcg_gen_extract_tl(dest, src, 0, ctx->addr_xl);
+    }
+}
+
 /* Compute a canonical address from a register plus offset. */
 static TCGv get_address(DisasContext *ctx, int rs1, int imm)
 {
@@ -661,11 +670,7 @@ static TCGv get_address(DisasContext *ctx, int rs1, int imm)
     TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
 
     tcg_gen_addi_tl(addr, src1, imm);
-    if (ctx->addr_signed) {
-        tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_xl);
-    } else {
-        tcg_gen_extract_tl(addr, addr, 0, ctx->addr_xl);
-    }
+    gen_pm_adjust_addr(ctx, addr, addr);
 
     return addr;
 }
@@ -677,11 +682,7 @@ static TCGv get_address_indexed(DisasContext *ctx, int rs1, TCGv offs)
     TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
 
     tcg_gen_add_tl(addr, src1, offs);
-    if (ctx->addr_signed) {
-        tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_xl);
-    } else {
-        tcg_gen_extract_tl(addr, addr, 0, ctx->addr_xl);
-    }
+    gen_pm_adjust_addr(ctx, addr, addr);
 
     return addr;
 }
-- 
2.54.0 (Apple Git-157)


