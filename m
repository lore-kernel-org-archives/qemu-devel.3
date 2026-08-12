Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9DEC5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHV4-0008IB-Kr; Wed, 12 Aug 2026 18:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUf-0007Rp-5s
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:17 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUb-00014k-Bp
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:16 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c966b9ee9cbso118935a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573932; x=1787178732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3LzPIAXqnqvmKLbzt6FI49HnMlBBf2OCfbEGzJd18O0=;
 b=q8fsbhLxdTqTRGEMs3NIXUJf20oaXGlUHXyOhEC8yVBM92H8Bu5/O/tmbTNOQLEPJv
 R7XkJuHNm1L+QIMRbMqQODSd2x0/K1y3nSKDOtn75mzGDOYJ0pL2HkCcAX9BMntSZ8Uo
 cvXp1r/9nivuWlvItlveM1rEM/2ppGiFGc6QU6S2/UnyQwa4nAPq5yYRMVY14PU3DDxG
 Pp2nP/6TWeRpnWbDtXHavQ2z+4T29oqbbP4/b4nYXe3gm/tNBOWFN5+b0HWXstQdbi7O
 P7mTiR8M050aSK32jg2LrDxVUC8r8+MPIaZ66fhny47/I5FtS2S7cvYOhs7ho1xDnQi7
 Eecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573932; x=1787178732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3LzPIAXqnqvmKLbzt6FI49HnMlBBf2OCfbEGzJd18O0=;
 b=X9EJM2WG2YUdAsDJgKAmPMhDfCDBYY8iDWHo9DIPfMQC9NEmkyz6hvefhg9DNXBnbt
 zbFGFdCtziBUSrjmJqxStteiZkvfhWICtQ6OqWzsRh7pJnk95gnhsEqSUmUT3i6RbK0H
 ZMtZf8d7OfAKfKc2oKqpJvMdlMjUpzljG2FIjbzNkNrGepo/4x4QlFuXOLnRp4gMVrJ0
 uQVgzwDzNq42yuOh4ztadXMKY/a04C20z8mwAN6MXOxD6FFG7r/4gMvy4t0uMzy5R04Y
 RAkHnNlO/FfCIJrg+uLOZAvRu6GB88zr4rVUUcyb0myKrvbFV5pHJHyZDPlWMq/dRtlB
 hIuQ==
X-Gm-Message-State: AOJu0YzgnwLd7LGjmRvjvL4MLGrF2rjS564NLGIzspcCVtRN0napYuYS
 VawUcq5KnaK5X7sJH1ShHFbG3U4z+C1Kcbj0PXHAYGnjIHNrluVLcoHIWSetMR2FELmHNtSxQ5d
 5R9k5
X-Gm-Gg: AR+sD13CRgJ85DJwW6bWS5zdOWq9XVNsRM8ASduEnpFeFfhtqrVY4GOMaomkzz5ikAR
 CDYIvKeAdr2kpQESWeYKwwlbJthRl/Ru54CtMGl7hQNLCTcM1v4nc90u1GkWu3s+JZpSbRY6Kzf
 6sIurVx2mppdpLsyAAAFZVOmtYitEdpR/fymLwZE0wYjHRetTZhxLXM8+Besvjks8Yytdw4zD9f
 CBQzcTD1BiTl8ECH4w6/PSt/BLBbFl5FyZjTX59B4lmiM6H3FfMG66JfrugX8ImI8Jromd1q0Ht
 QTEsbUAHFut9rzJxr6H3rfLvcZWBOStpssh2JxWipaoDbfUzmcjXCm9NhjaiN5miSR6tXQCg9mt
 NgqamF5Iifw1vwGGHazF+9S/ipLZxOf0nZb4XwK4kqMmAdQfST6WmOQp4+heaRXvNx3UUAU2H3H
 7CJdoo1FWQXC0a+kpf9++JDmtCS8Iys6ePmsvQIQG4ARTbkis7j/TjivS3Eks+OuOObjsG5PWry
 8pmxwg9MkL9gVxyxJ/J
X-Received: by 2002:a05:6a00:4303:b0:842:6a3b:60d8 with SMTP id
 d2e1a72fcca58-84fc744b1bamr1349515b3a.30.1786573931792; 
 Wed, 12 Aug 2026 15:32:11 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:32:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 28/52] disas/riscv: Drop format from DECOMP insns
Date: Wed, 12 Aug 2026 15:31:18 -0700
Message-ID: <20260812223142.349142-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The format for these will never be used -- we will use
the format from the decompressed insn.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 94 +++++++++++++++++++++++++--------------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index a359badab5..e0b3d22031 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1819,52 +1819,52 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "fcvt.q.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
     { "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1 },
     { "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1 },
-    { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm, DECOMP(rv_op_addi) },
-    { "c.fld", rv_codec_cl_ld, rv_fmt_frd_offset_rs1, DECOMP(rv_op_fld) },
-    { "c.lw", rv_codec_cl_lw, rv_fmt_rd_offset_rs1, DECOMP(rv_op_lw) },
-    { "c.flw", rv_codec_cl_lw, rv_fmt_frd_offset_rs1, DECOMP(rv_op_flw) },
-    { "c.fsd", rv_codec_cs_sd, rv_fmt_frs2_offset_rs1, DECOMP(rv_op_fsd) },
-    { "c.sw", rv_codec_cs_sw, rv_fmt_rs2_offset_rs1, DECOMP(rv_op_sw) },
-    { "c.fsw", rv_codec_cs_sw, rv_fmt_frs2_offset_rs1, DECOMP(rv_op_fsw) },
+    { "c.addi4spn", rv_codec_ciw_4spn, NULL, DECOMP(rv_op_addi) },
+    { "c.fld", rv_codec_cl_ld, NULL, DECOMP(rv_op_fld) },
+    { "c.lw", rv_codec_cl_lw, NULL, DECOMP(rv_op_lw) },
+    { "c.flw", rv_codec_cl_lw, NULL, DECOMP(rv_op_flw) },
+    { "c.fsd", rv_codec_cs_sd, NULL, DECOMP(rv_op_fsd) },
+    { "c.sw", rv_codec_cs_sw, NULL, DECOMP(rv_op_sw) },
+    { "c.fsw", rv_codec_cs_sw, NULL, DECOMP(rv_op_fsw) },
     { },
-    { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, DECOMP(rv_op_addi) },
-    { "c.jal", rv_codec_cj_jal, rv_fmt_rd_offset, DECOMP(rv_op_jal) },
-    { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, DECOMP(rv_op_addi) },
-    { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm, DECOMP(rv_op_addi) },
-    { "c.lui", rv_codec_ci_lui, rv_fmt_rd_uimm, DECOMP(rv_op_lui) },
-    { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, DECOMP(rv_op_srli) },
-    { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, DECOMP(rv_op_srai) },
-    { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, DECOMP(rv_op_andi) },
-    { "c.sub", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_sub) },
-    { "c.xor", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_xor) },
-    { "c.or", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_or) },
-    { "c.and", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_and) },
-    { "c.subw", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_subw) },
-    { "c.addw", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_addw) },
-    { "c.j", rv_codec_cj, rv_fmt_rd_offset, DECOMP(rv_op_jal) },
-    { "c.beqz", rv_codec_cb, rv_fmt_rs1_rs2_offset, DECOMP(rv_op_beq) },
-    { "c.bnez", rv_codec_cb, rv_fmt_rs1_rs2_offset, DECOMP(rv_op_bne) },
-    { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm, DECOMP(rv_op_slli) },
-    { "c.fldsp", rv_codec_ci_ldsp, rv_fmt_frd_offset_rs1, DECOMP(rv_op_fld) },
-    { "c.lwsp", rv_codec_ci_lwsp, rv_fmt_rd_offset_rs1, DECOMP(rv_op_lw) },
-    { "c.flwsp", rv_codec_ci_lwsp, rv_fmt_frd_offset_rs1, DECOMP(rv_op_flw) },
-    { "c.jr", rv_codec_cr_jr, rv_fmt_rd_rs1_offset, DECOMP(rv_op_jalr) },
-    { "c.mv", rv_codec_cr_mv, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_addi) },
-    { "c.ebreak", rv_codec_ci_none, rv_fmt_none, DECOMP(rv_op_ebreak) },
-    { "c.jalr", rv_codec_cr_jalr, rv_fmt_rd_rs1_offset, DECOMP(rv_op_jalr) },
-    { "c.add", rv_codec_cr, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_add) },
-    { "c.fsdsp", rv_codec_css_sdsp, rv_fmt_frs2_offset_rs1, DECOMP(rv_op_fsd) },
-    { "c.swsp", rv_codec_css_swsp, rv_fmt_rs2_offset_rs1, DECOMP(rv_op_sw) },
-    { "c.fswsp", rv_codec_css_swsp, rv_fmt_frs2_offset_rs1, DECOMP(rv_op_fsw) },
-    { "c.ld", rv_codec_cl_ld, rv_fmt_rd_offset_rs1, DECOMP(rv_op_ld) },
-    { "c.sd", rv_codec_cs_sd, rv_fmt_rs2_offset_rs1, DECOMP(rv_op_sd) },
-    { "c.addiw", rv_codec_ci, rv_fmt_rd_rs1_imm, DECOMP(rv_op_addiw) },
-    { "c.ldsp", rv_codec_ci_ldsp, rv_fmt_rd_offset_rs1, DECOMP(rv_op_ld) },
-    { "c.sdsp", rv_codec_css_sdsp, rv_fmt_rs2_offset_rs1, DECOMP(rv_op_sd) },
-    { "c.lq", rv_codec_cl_lq, rv_fmt_rd_offset_rs1, DECOMP(rv_op_lq) },
-    { "c.sq", rv_codec_cs_sq, rv_fmt_rs2_offset_rs1, DECOMP(rv_op_sq) },
-    { "c.lqsp", rv_codec_ci_lqsp, rv_fmt_rd_offset_rs1, DECOMP(rv_op_lq) },
-    { "c.sqsp", rv_codec_css_sqsp, rv_fmt_rs2_offset_rs1, DECOMP(rv_op_sq) },
+    { "c.addi", rv_codec_ci, NULL, DECOMP(rv_op_addi) },
+    { "c.jal", rv_codec_cj_jal, NULL, DECOMP(rv_op_jal) },
+    { "c.li", rv_codec_ci_li, NULL, DECOMP(rv_op_addi) },
+    { "c.addi16sp", rv_codec_ci_16sp, NULL, DECOMP(rv_op_addi) },
+    { "c.lui", rv_codec_ci_lui, NULL, DECOMP(rv_op_lui) },
+    { "c.srli", rv_codec_cb_sh6, NULL, DECOMP(rv_op_srli) },
+    { "c.srai", rv_codec_cb_sh6, NULL, DECOMP(rv_op_srai) },
+    { "c.andi", rv_codec_cb_imm, NULL, DECOMP(rv_op_andi) },
+    { "c.sub", rv_codec_cs, NULL, DECOMP(rv_op_sub) },
+    { "c.xor", rv_codec_cs, NULL, DECOMP(rv_op_xor) },
+    { "c.or", rv_codec_cs, NULL, DECOMP(rv_op_or) },
+    { "c.and", rv_codec_cs, NULL, DECOMP(rv_op_and) },
+    { "c.subw", rv_codec_cs, NULL, DECOMP(rv_op_subw) },
+    { "c.addw", rv_codec_cs, NULL, DECOMP(rv_op_addw) },
+    { "c.j", rv_codec_cj, NULL, DECOMP(rv_op_jal) },
+    { "c.beqz", rv_codec_cb, NULL, DECOMP(rv_op_beq) },
+    { "c.bnez", rv_codec_cb, NULL, DECOMP(rv_op_bne) },
+    { "c.slli", rv_codec_ci_sh6, NULL, DECOMP(rv_op_slli) },
+    { "c.fldsp", rv_codec_ci_ldsp, NULL, DECOMP(rv_op_fld) },
+    { "c.lwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_lw) },
+    { "c.flwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_flw) },
+    { "c.jr", rv_codec_cr_jr, NULL, DECOMP(rv_op_jalr) },
+    { "c.mv", rv_codec_cr_mv, NULL, DECOMP(rv_op_addi) },
+    { "c.ebreak", rv_codec_ci_none, NULL, DECOMP(rv_op_ebreak) },
+    { "c.jalr", rv_codec_cr_jalr, NULL, DECOMP(rv_op_jalr) },
+    { "c.add", rv_codec_cr, NULL, DECOMP(rv_op_add) },
+    { "c.fsdsp", rv_codec_css_sdsp, NULL, DECOMP(rv_op_fsd) },
+    { "c.swsp", rv_codec_css_swsp, NULL, DECOMP(rv_op_sw) },
+    { "c.fswsp", rv_codec_css_swsp, NULL, DECOMP(rv_op_fsw) },
+    { "c.ld", rv_codec_cl_ld, NULL, DECOMP(rv_op_ld) },
+    { "c.sd", rv_codec_cs_sd, NULL, DECOMP(rv_op_sd) },
+    { "c.addiw", rv_codec_ci, NULL, DECOMP(rv_op_addiw) },
+    { "c.ldsp", rv_codec_ci_ldsp, NULL, DECOMP(rv_op_ld) },
+    { "c.sdsp", rv_codec_css_sdsp, NULL, DECOMP(rv_op_sd) },
+    { "c.lq", rv_codec_cl_lq, NULL, DECOMP(rv_op_lq) },
+    { "c.sq", rv_codec_cs_sq, NULL, DECOMP(rv_op_sq) },
+    { "c.lqsp", rv_codec_ci_lqsp, NULL, DECOMP(rv_op_lq) },
+    { "c.sqsp", rv_codec_css_sqsp, NULL, DECOMP(rv_op_sq) },
     { "nop", rv_codec_i, rv_fmt_none },
     { "mv", rv_codec_i, rv_fmt_rd_rs1 },
     { "not", rv_codec_i, rv_fmt_rd_rs1 },
@@ -2546,8 +2546,8 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "ssrdp", rv_codec_r, rv_fmt_rd },
     { "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
     { "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "c.sspush", rv_codec_cmop_ss, rv_fmt_rs2, DECOMP(rv_op_sspush) },
-    { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, DECOMP(rv_op_sspopchk) },
+    { "c.sspush", rv_codec_cmop_ss, NULL, DECOMP(rv_op_sspush) },
+    { "c.sspopchk", rv_codec_cmop_ss, NULL, DECOMP(rv_op_sspopchk) },
    { "cbo.inval", rv_codec_r, rv_fmt_rs1 },
    { "cbo.clean", rv_codec_r, rv_fmt_rs1 },
    { "cbo.flush", rv_codec_r, rv_fmt_rs1 },
-- 
2.43.0


