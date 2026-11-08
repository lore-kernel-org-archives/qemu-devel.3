Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB37606A31A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rispop.dev header.i=@rispop.dev header.a=rsa-sha256 header.s=protonmail header.b=UnGUsx5M
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPwgi-00028n-6p; Sun, 08 Nov 2026 01:47:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rishab@rispop.dev>)
 id 1xPwgh-00028H-Dg; Sun, 08 Nov 2026 01:47:35 -0500
Received: from mail-07.mail-europe.com ([37.187.220.204])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rishab@rispop.dev>)
 id 1xPwge-0006Wh-NA; Sun, 08 Nov 2026 01:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rispop.dev;
 s=protonmail; t=1794120447; x=1794379647;
 bh=s4Whv6OBVdByInpwS2rnh4nov+SzTKjG1/EW2bOsno0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=UnGUsx5M/RvnVWjEu27WQOdy4Z+OcR+Z4fWSFLQe7Zg7dtMW+y5VAG+s1f0V6SezD
 PZSifPwj+Qagnj4Arlxb05D5OpdDLAAME3r/XZdb76u8Qs8tJxHfX88QuVuA7fmZmu
 qo2XezBrqURH8HkFynPeGe+x3ZZto+U2GIQ2UIBPcn0HwwQg035aDvJgZmrf6h2Hwu
 JwZZibiDYJ03lGp3ry2ShwT0AfL1LbvQheGLvfq2SmFbA/zGmZaFs+ejGNJUa3BNzu
 CJR/Gcabh9m5Dhzjiyu3mXA1sEit1k6VYrdz6k639g7LBD83WPE8Ufi4bXQOJad4l3
 0OVxxr+QAYExw==
X-Pm-Submission-Id: 4jMk4C2p1Vz2ScX9
From: Rishab Pradeep <rishab@rispop.dev>
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
Subject: [PATCH v2 1/2] target/riscv: Factor out pointer-masking address
 adjustment
Date: Sun,  8 Nov 2026 00:46:40 -0600
Message-ID: <20261108064641.179764-2-rishab@rispop.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261108064641.179764-1-rishab@rispop.dev>
References: <20261108064641.179764-1-rishab@rispop.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.187.220.204; envelope-from=rishab@rispop.dev;
 helo=mail-07.mail-europe.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Rishab Pradeep <rishab@rispop.dev>

Move the addr_xl/addr_signed extract, which applies address-width
truncation and the pointer-masking ignore transformation, out of
get_address() and get_address_indexed() into a new helper,
gen_pm_adjust_addr(), so it can be applied to addresses that are not
formed from a GPR. No functional change.

Co-developed-by: Tarun Patanjali <tarun.patanjali@utexas.edu>
Signed-off-by: Tarun Patanjali <tarun.patanjali@utexas.edu>
Co-developed-by: Chris Elwood <christopher.elwood2024@gmail.com>
Signed-off-by: Chris Elwood <christopher.elwood2024@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
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
2.56.0


