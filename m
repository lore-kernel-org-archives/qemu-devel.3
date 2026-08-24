Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB3FC5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbR-0005JZ-9z; Mon, 24 Aug 2026 01:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNap-0004Uz-IM
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:35 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNad-0002fb-Vi
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:29 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c9eefcf9175so3167532a12.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550681; x=1788155481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GPJ/EM8CC6R9rZqKxgsloXc62/KmmIxRWgCKFfWrSo8=;
 b=IJa5jxYDuabNuozeQ88hb2+ROQ85O/aYWmTdhZu8RRsOnIqoGm0kQ8zUqw1Jd9cSKC
 irnPzuRRr4SzxZy2dxfLvWhb+xJyz5O2ubE5l7mr6b6DmOcqQWyM640lV0uYA8mLMiCm
 seabXmHI9B0t3SgutMeAetcZoTXW+8J8qyaVJMObdNWY4QRNHArG18WYuHGslKqO6W84
 hCMGByywbX/XIkeUiY8cjGGeuEOUEbXcITsZQZZDnl0hB8fRZK7gXnPFWrzMTOYiYtJ3
 jhpSJEfiuQ/HPFM6q6AoMQKacWhbJQyoYqgRgzt27Z9C/MPNIVAAS6uuIs+6xwVaW0mH
 FklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550681; x=1788155481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GPJ/EM8CC6R9rZqKxgsloXc62/KmmIxRWgCKFfWrSo8=;
 b=CjpgUcjyqsOGLGddzNjAbPCLW11YuL8dHExDZiy9Yihd9ukYe1TdqsS3jg9OwNRmmR
 sWU2r9uQR1FmdmNb6bZCEYjYpznIO/66ufpQ4SWpytLSsCZFwQWi8Wn5VIgimdvK/osT
 tv85W/Rd9/j7AVxE0vKGnEBCQDY3bPYuZ6kO93SiSmjh3nuhFsUx2cArHLUJQvKBnNDr
 hle5U3sZo6/uVnC7BFopV0XrPbBWJERYco3rCAgg6/GPhCgH2AFCqURB++1HM/W6qVFj
 lPvJ8BrA2kb7/lPMfoy4uikq6l98zJKGjhMmGIS/q1YGOmz4V+W8Bn/VzHB0DiaVrc/5
 y2EQ==
X-Gm-Message-State: AFuF++lFcheVvFdusRnxTlqSeNTJi0I51DBNsL2fpnhrP5WlDBl6NwsV
 CTcjWJTIYK/zHGK5dT97NAp8D5P8m62xmrvOjLUtESaSfQJPWquqmkoPSN4k5A==
X-Gm-Gg: AR+sD11gg8asSOOMJytg+QoySMPInhZKXVo8zFB///9EFeeFttFz22wkEy6VP4dSgrV
 /Pk9HiH+SGnDsPDUYnSCmsfQdTcaVAhaza4lAFlSqN3tO0/4LawqksUoq3YIxm/YRaOi0iTYwQU
 2ZRcLFiS4QnVtDVA2wpawMbVfut0iNWNESbD0lWi1SN2e40MiSAJTy+QO2XiRLjcSatVpKgUhrk
 783pm6asxjIqimQV9FwUu+O31xSlLm4xdiiwuQ9D9r5dldBU2b2GebgXV62J7uckVGf5LuBkezN
 DyGoHpTGrdkvsVnjd16RbaEEp2MuwkkSola6823F4oC23VDdSt4yMuyW8UZhmO4GiUwQaY5rHcr
 e6Ieo9eGI2Ptkw/I9+ipYVofmg5OI4DOIdPnPkfOfMGlntvbEPLkTEFcQT57japUeVd/DYvKshV
 QVXQoTZY2TmqlPpxwFxSopyl4NoOFvfoBJo+IHYBvW1UB0hjEhy5fqgHNJlKM6SuHmpKavpLzlQ
 z8mg3DOUoqKmnsB
X-Received: by 2002:a17:90b:4a81:b0:38e:6f90:eabd with SMTP id
 98e67ed59e1d1-395c355c570mr41056478a91.5.1787550681012; 
 Sun, 23 Aug 2026 22:51:21 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:51:20 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 60/96] disas/riscv: Handle decompression via
 decode_inst_lift_pseudo
Date: Mon, 24 Aug 2026 15:47:30 +1000
Message-ID: <20260824054806.2790041-61-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Introduce a DECOMP macro that expands an rv_comp_data
that always succeeds.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-28-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h |   1 -
 disas/riscv.c | 113 +++++++++++++++++++++++---------------------------
 2 files changed, 51 insertions(+), 63 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 3bbcbf10fb..ea7141d3b5 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -174,7 +174,6 @@ typedef struct {
     rv_codec codec;
     const char *format;
     const rv_comp_data *pseudo;
-    rv_opcode decomp;
 } rv_opcode_data;
 
 typedef struct {
diff --git a/disas/riscv.c b/disas/riscv.c
index b8e5b124a5..a359badab5 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1065,6 +1065,7 @@ static const rvc_constraint rvcc_ret[] = { rvc_rd_eq_x0, rvc_rs1_eq_ra,
                                            rvc_end };
 static const rvc_constraint rvcc_jr[] = { rvc_rd_eq_x0, rvc_imm_eq_zero,
                                           rvc_end };
+static const rvc_constraint rvcc_true[] = { rvc_end };
 
 /* pseudo-instruction metadata */
 
@@ -1190,6 +1191,9 @@ static const rv_comp_data rvcp_fsgnjx_q[] = {
     { rv_op_illegal, NULL }
 };
 
+/* Convert compressed insns into normal insns via pseudo expansion. */
+#define DECOMP(X)  &(const rv_comp_data){ X, rvcc_true }
+
 /* operand extractors */
 
 static uint32_t operand_rd(rv_inst inst)
@@ -1815,52 +1819,52 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "fcvt.q.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
     { "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1 },
     { "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1 },
-    { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm, NULL, rv_op_addi },
-    { "c.fld", rv_codec_cl_ld, rv_fmt_frd_offset_rs1, NULL, rv_op_fld },
-    { "c.lw", rv_codec_cl_lw, rv_fmt_rd_offset_rs1, NULL, rv_op_lw },
-    { "c.flw", rv_codec_cl_lw, rv_fmt_frd_offset_rs1, NULL, rv_op_flw },
-    { "c.fsd", rv_codec_cs_sd, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsd },
-    { "c.sw", rv_codec_cs_sw, rv_fmt_rs2_offset_rs1, NULL, rv_op_sw },
-    { "c.fsw", rv_codec_cs_sw, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsw },
+    { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm, DECOMP(rv_op_addi) },
+    { "c.fld", rv_codec_cl_ld, rv_fmt_frd_offset_rs1, DECOMP(rv_op_fld) },
+    { "c.lw", rv_codec_cl_lw, rv_fmt_rd_offset_rs1, DECOMP(rv_op_lw) },
+    { "c.flw", rv_codec_cl_lw, rv_fmt_frd_offset_rs1, DECOMP(rv_op_flw) },
+    { "c.fsd", rv_codec_cs_sd, rv_fmt_frs2_offset_rs1, DECOMP(rv_op_fsd) },
+    { "c.sw", rv_codec_cs_sw, rv_fmt_rs2_offset_rs1, DECOMP(rv_op_sw) },
+    { "c.fsw", rv_codec_cs_sw, rv_fmt_frs2_offset_rs1, DECOMP(rv_op_fsw) },
     { },
-    { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, rv_op_addi },
-    { "c.jal", rv_codec_cj_jal, rv_fmt_rd_offset, NULL, rv_op_jal },
-    { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, NULL, rv_op_addi },
-    { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm, NULL, rv_op_addi },
-    { "c.lui", rv_codec_ci_lui, rv_fmt_rd_uimm, NULL, rv_op_lui },
-    { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srli },
-    { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srai },
-    { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, NULL, rv_op_andi },
-    { "c.sub", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_sub },
-    { "c.xor", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_xor },
-    { "c.or", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_or },
-    { "c.and", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_and },
-    { "c.subw", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_subw },
-    { "c.addw", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_addw },
-    { "c.j", rv_codec_cj, rv_fmt_rd_offset, NULL, rv_op_jal },
-    { "c.beqz", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL, rv_op_beq },
-    { "c.bnez", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL, rv_op_bne },
-    { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_slli },
-    { "c.fldsp", rv_codec_ci_ldsp, rv_fmt_frd_offset_rs1, NULL, rv_op_fld },
-    { "c.lwsp", rv_codec_ci_lwsp, rv_fmt_rd_offset_rs1, NULL, rv_op_lw },
-    { "c.flwsp", rv_codec_ci_lwsp, rv_fmt_frd_offset_rs1, NULL, rv_op_flw },
-    { "c.jr", rv_codec_cr_jr, rv_fmt_rd_rs1_offset, NULL, rv_op_jalr },
-    { "c.mv", rv_codec_cr_mv, rv_fmt_rd_rs1_rs2, NULL, rv_op_addi },
-    { "c.ebreak", rv_codec_ci_none, rv_fmt_none, NULL, rv_op_ebreak },
-    { "c.jalr", rv_codec_cr_jalr, rv_fmt_rd_rs1_offset, NULL, rv_op_jalr },
-    { "c.add", rv_codec_cr, rv_fmt_rd_rs1_rs2, NULL, rv_op_add },
-    { "c.fsdsp", rv_codec_css_sdsp, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsd },
-    { "c.swsp", rv_codec_css_swsp, rv_fmt_rs2_offset_rs1, NULL, rv_op_sw },
-    { "c.fswsp", rv_codec_css_swsp, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsw },
-    { "c.ld", rv_codec_cl_ld, rv_fmt_rd_offset_rs1, NULL, rv_op_ld },
-    { "c.sd", rv_codec_cs_sd, rv_fmt_rs2_offset_rs1, NULL,  rv_op_sd },
-    { "c.addiw", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, rv_op_addiw },
-    { "c.ldsp", rv_codec_ci_ldsp, rv_fmt_rd_offset_rs1, NULL, rv_op_ld },
-    { "c.sdsp", rv_codec_css_sdsp, rv_fmt_rs2_offset_rs1, NULL, rv_op_sd },
-    { "c.lq", rv_codec_cl_lq, rv_fmt_rd_offset_rs1, NULL, rv_op_lq },
-    { "c.sq", rv_codec_cs_sq, rv_fmt_rs2_offset_rs1, NULL, rv_op_sq },
-    { "c.lqsp", rv_codec_ci_lqsp, rv_fmt_rd_offset_rs1, NULL, rv_op_lq },
-    { "c.sqsp", rv_codec_css_sqsp, rv_fmt_rs2_offset_rs1, NULL, rv_op_sq },
+    { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, DECOMP(rv_op_addi) },
+    { "c.jal", rv_codec_cj_jal, rv_fmt_rd_offset, DECOMP(rv_op_jal) },
+    { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, DECOMP(rv_op_addi) },
+    { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm, DECOMP(rv_op_addi) },
+    { "c.lui", rv_codec_ci_lui, rv_fmt_rd_uimm, DECOMP(rv_op_lui) },
+    { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, DECOMP(rv_op_srli) },
+    { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, DECOMP(rv_op_srai) },
+    { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, DECOMP(rv_op_andi) },
+    { "c.sub", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_sub) },
+    { "c.xor", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_xor) },
+    { "c.or", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_or) },
+    { "c.and", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_and) },
+    { "c.subw", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_subw) },
+    { "c.addw", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_addw) },
+    { "c.j", rv_codec_cj, rv_fmt_rd_offset, DECOMP(rv_op_jal) },
+    { "c.beqz", rv_codec_cb, rv_fmt_rs1_rs2_offset, DECOMP(rv_op_beq) },
+    { "c.bnez", rv_codec_cb, rv_fmt_rs1_rs2_offset, DECOMP(rv_op_bne) },
+    { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm, DECOMP(rv_op_slli) },
+    { "c.fldsp", rv_codec_ci_ldsp, rv_fmt_frd_offset_rs1, DECOMP(rv_op_fld) },
+    { "c.lwsp", rv_codec_ci_lwsp, rv_fmt_rd_offset_rs1, DECOMP(rv_op_lw) },
+    { "c.flwsp", rv_codec_ci_lwsp, rv_fmt_frd_offset_rs1, DECOMP(rv_op_flw) },
+    { "c.jr", rv_codec_cr_jr, rv_fmt_rd_rs1_offset, DECOMP(rv_op_jalr) },
+    { "c.mv", rv_codec_cr_mv, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_addi) },
+    { "c.ebreak", rv_codec_ci_none, rv_fmt_none, DECOMP(rv_op_ebreak) },
+    { "c.jalr", rv_codec_cr_jalr, rv_fmt_rd_rs1_offset, DECOMP(rv_op_jalr) },
+    { "c.add", rv_codec_cr, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_add) },
+    { "c.fsdsp", rv_codec_css_sdsp, rv_fmt_frs2_offset_rs1, DECOMP(rv_op_fsd) },
+    { "c.swsp", rv_codec_css_swsp, rv_fmt_rs2_offset_rs1, DECOMP(rv_op_sw) },
+    { "c.fswsp", rv_codec_css_swsp, rv_fmt_frs2_offset_rs1, DECOMP(rv_op_fsw) },
+    { "c.ld", rv_codec_cl_ld, rv_fmt_rd_offset_rs1, DECOMP(rv_op_ld) },
+    { "c.sd", rv_codec_cs_sd, rv_fmt_rs2_offset_rs1, DECOMP(rv_op_sd) },
+    { "c.addiw", rv_codec_ci, rv_fmt_rd_rs1_imm, DECOMP(rv_op_addiw) },
+    { "c.ldsp", rv_codec_ci_ldsp, rv_fmt_rd_offset_rs1, DECOMP(rv_op_ld) },
+    { "c.sdsp", rv_codec_css_sdsp, rv_fmt_rs2_offset_rs1, DECOMP(rv_op_sd) },
+    { "c.lq", rv_codec_cl_lq, rv_fmt_rd_offset_rs1, DECOMP(rv_op_lq) },
+    { "c.sq", rv_codec_cs_sq, rv_fmt_rs2_offset_rs1, DECOMP(rv_op_sq) },
+    { "c.lqsp", rv_codec_ci_lqsp, rv_fmt_rd_offset_rs1, DECOMP(rv_op_lq) },
+    { "c.sqsp", rv_codec_css_sqsp, rv_fmt_rs2_offset_rs1, DECOMP(rv_op_sq) },
     { "nop", rv_codec_i, rv_fmt_none },
     { "mv", rv_codec_i, rv_fmt_rd_rs1 },
     { "not", rv_codec_i, rv_fmt_rd_rs1 },
@@ -2542,8 +2546,8 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "ssrdp", rv_codec_r, rv_fmt_rd },
     { "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
     { "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "c.sspush", rv_codec_cmop_ss, rv_fmt_rs2, NULL, rv_op_sspush },
-    { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk },
+    { "c.sspush", rv_codec_cmop_ss, rv_fmt_rs2, DECOMP(rv_op_sspush) },
+    { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, DECOMP(rv_op_sspopchk) },
    { "cbo.inval", rv_codec_r, rv_fmt_rs1 },
    { "cbo.clean", rv_codec_r, rv_fmt_rs1 },
    { "cbo.flush", rv_codec_r, rv_fmt_rs1 },
@@ -5269,20 +5273,6 @@ static const rv_opcode_data *decode_inst_lift_pseudo(rv_decode *dec,
     return op;
 }
 
-/* decompress instruction */
-
-static const rv_opcode_data *decode_inst_decompress(rv_decode *dec,
-                                                    const rv_opcode_data *op)
-{
-    int decomp_op = op->decomp;
-
-    if (decomp_op != rv_op_illegal) {
-        dec->op = decomp_op;
-        op = &dec->opcode_data[decomp_op];
-    }
-    return op;
-}
-
 /* disassemble instruction */
 
 static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
@@ -5333,7 +5323,6 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
 
     op = &dec.opcode_data[dec.op];
     decode_inst_operands(&dec, isa, op);
-    op = decode_inst_decompress(&dec, op);
     op = decode_inst_lift_pseudo(&dec, op);
     return format_inst(24, &dec, op);
 }
-- 
2.54.0


