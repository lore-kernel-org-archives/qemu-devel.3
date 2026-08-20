Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6411DC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtkv-0005OO-Iu; Wed, 19 Aug 2026 23:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtku-0005Nu-2Y
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:52 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtks-0004Fv-1d
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:51 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so1819487a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197668; x=1787802468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NfDNN58R8WheefjeRqGFB5HT4nt99gbZjt03X7sKOYA=;
 b=c4Mdwm+xRYBmB486xBsv6j4I98vAf7pfGAZsoLfpGY2nlcXJ+QGcTQNUsJXl3fp4aa
 JVAWjCCOeKqvWWhWBSVnXot2Aw1Iee+ykqrNnhFTi+hi1Kpfu2E/MsFH2DTE9HtYYmXQ
 DBvxtRLD44Jd/ItO+YIWH8GunxQ+XKY3s9gz4rErjoGcdz4wKP2ie5zW7Gaq6kX7tfIu
 /HCDubPEpenPfsTwibhx0Btu2zTAU6TyH0U3s8oBPY3JydT+KzixNHsijdnjLzGCySXc
 GABUL5JqaIdLQgFAq1xYVxVu//gHvonPvNN899Yq0+Uk8YIQGBASmrFO1vC3gpSnJSW8
 Vg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197668; x=1787802468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NfDNN58R8WheefjeRqGFB5HT4nt99gbZjt03X7sKOYA=;
 b=biQa7dfv8zoGA2zhK/0qYqz9vaE6SFIKjhRes0dFlZMlEkOQKX2qh24sHzaGTKH0lq
 KFfDyItMnJ4JHp/cvhCbThBkVfUoAEkm+X/vYg8TfQ0M3BbKC2hHXaPwhixT0XMuU2Hg
 Et49Zl8iPdmxwZ9UBnaSPvGlYpXWnSTipbxn7RzgVWW9QBdYh1LUc0Oe/CJba+IuJHns
 V3Gi/NDqP9OAqFn3gkZOI6611KDdBO6wqGGQDx3oAF492cCdUqPBf0Up3PG472Jfdc6m
 19icSZuGGwZrDXPKhoUR47wOtFF4OFOy2gw9+1GAzuRaow8+4+4Fo/GDJjOv1BHIP4rR
 2rJw==
X-Gm-Message-State: AFuF++k+mnvPmzYFEUO1C4tj3VjaxM3v3t6T41y1LxZ99npDOAkEKfGo
 fuYePnUqmFHq/xLcbIMWjS0VIdx+CwfPjPb+vT5f8rAoz0b3t7qjT6cjD8n3mg==
X-Gm-Gg: AR+sD133+TUUPzH5crjuZN9J/shGPJI801p5PvmQtboS7WEypPxf8bQ+vAIRGy8unT8
 lY85RPgDEghcmHIF03kIXYMtO3+B03fG47oATWw1uVQqS/ff9kPCN99yF57o4nGmKGYPJJSoqxb
 nkDsj40PuaMqQMgl8qBBqT9PSpBL2Z6UnDZQEdUXT/nGdJEywoXPTESY0ZLVE2Fbo7nDr2+o5tf
 snCd9Q3W6r2ccevk31UUMGdQm4NNa64kciQ2LVfknrPF3HOm4SstQF2A1kgP6+xCzb8uaMr4I8q
 PsoiFso9FuXOVe3vCv5mbld2MyqeI1E2t+7culNHs514N1Pun/SVIZlm7swaxZOjXDdKbssa40r
 qFxCyeyLu0wE4ndy1Z4njlbBho9vL5vRFBFAJD2V+9i/bErYhZUPwjfcrU/MHHpCnEm4dZs56sN
 3HP1BwPUV7SEezfO/ycdAKcVuG6s5TKryjVxuvIhKYC7X+X50AGCQLHDSPb8DijLJKadVtAI6JH
 f4GVQ==
X-Received: by 2002:a17:90a:da90:b0:37c:6910:5758 with SMTP id
 98e67ed59e1d1-39580a91ae0mr18944621a91.1.1787197668484; 
 Wed, 19 Aug 2026 20:47:48 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:47:47 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 64/93] disas/riscv: Drop format from DECOMP insns
Date: Thu, 20 Aug 2026 13:44:01 +1000
Message-ID: <20260820034430.1186695-65-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1030.google.com
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

The format for these will never be used -- we will use
the format from the decompressed insn.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-29-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.54.0


