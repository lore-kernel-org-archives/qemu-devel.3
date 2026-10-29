Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C210F606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMW4V-0000RK-TZ; Thu, 29 Oct 2026 15:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rishab@rispop.dev>) id 1xMV1I-0008RC-TG
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:38:37 -0400
Received: from mail-07.mail-europe.com ([37.187.220.204])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rishab@rispop.dev>) id 1xMV1G-00014m-MA
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:38:36 -0400
X-Pm-Submission-Id: 4jFtK42DwZz1DFSl
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
Subject: [PATCH 2/2] target/riscv: Apply pointer masking to SSPUSH/SSPOPCHK
 addresses
Date: Thu, 29 Oct 2026 13:37:51 -0500
Message-ID: <20261029183751.11143-3-rishab@rispop.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029183751.11143-1-rishab@rispop.dev>
References: <20261029183751.11143-1-rishab@rispop.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.187.220.204; envelope-from=rishab@rispop.dev;
 helo=mail-07.mail-europe.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-22.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SSPUSH and SSPOPCHK form their effective address from ssp rather than
a GPR, so they bypass get_address() and the pointer-masking ignore
transformation is never applied. With pointer masking enabled, a
tagged ssp raises a store/AMO page fault, while SSAMOSWAP through the
same tagged pointer succeeds.

Apply gen_pm_adjust_addr() to the ssp-derived address. ssp itself is
still written back unmasked, and the SSPOPCHK comparison of the loaded
value against rs1 is unchanged.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4758
Co-developed-by: Tarun Patanjali <tarun.patanjali@utexas.edu>
Signed-off-by: Tarun Patanjali <tarun.patanjali@utexas.edu>
Co-developed-by: Chris Elwood <christopher.elwood2024@gmail.com>
Signed-off-by: Chris Elwood <christopher.elwood2024@gmail.com>
Signed-off-by: Rishab Pradeep <rishab@rispop.dev>
---
 target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
index d47a9f9c7d..c2dddcc8bb 100644
--- a/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvzicfiss.c.inc
@@ -29,6 +29,7 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
     }
 
     TCGv addr = tcg_temp_new();
+    TCGv maddr = tcg_temp_new();
     TCGLabel *skip = gen_new_label();
     uint32_t tmp = (get_xl(ctx) == MXL_RV64) ? 8 : 4;
     TCGv data = tcg_temp_new();
@@ -36,8 +37,9 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
     TCGv_i64 wide_addr = tcg_temp_new_i64();
     tcg_gen_ld_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
     tcg_gen_trunc_i64_tl(addr, wide_addr);
+    gen_pm_adjust_addr(ctx, maddr, addr);
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
-    tcg_gen_qemu_ld_tl(data, addr, SS_MMU_INDEX(ctx),
+    tcg_gen_qemu_ld_tl(data, maddr, SS_MMU_INDEX(ctx),
                        mxl_memop(ctx) | MO_ALIGN);
     TCGv rs1 = get_gpr(ctx, a->rs1, EXT_NONE);
     tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
@@ -60,6 +62,7 @@ static bool trans_sspush(DisasContext *ctx, arg_sspush *a)
     }
 
     TCGv addr = tcg_temp_new();
+    TCGv maddr = tcg_temp_new();
     int tmp = (get_xl(ctx) == MXL_RV64) ? -8 : -4;
     TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
     TCGv_i64 wide_addr = tcg_temp_new_i64();
@@ -67,7 +70,8 @@ static bool trans_sspush(DisasContext *ctx, arg_sspush *a)
     tcg_gen_ld_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
     tcg_gen_trunc_i64_tl(addr, wide_addr);
     tcg_gen_addi_tl(addr, addr, tmp);
-    tcg_gen_qemu_st_tl(data, addr, SS_MMU_INDEX(ctx),
+    gen_pm_adjust_addr(ctx, maddr, addr);
+    tcg_gen_qemu_st_tl(data, maddr, SS_MMU_INDEX(ctx),
                        mxl_memop(ctx) | MO_ALIGN);
     tcg_gen_ext_tl_i64(wide_addr, addr);
     tcg_gen_st_i64(wide_addr, tcg_env, offsetof(CPURISCVState, ssp));
-- 
2.54.0 (Apple Git-157)


