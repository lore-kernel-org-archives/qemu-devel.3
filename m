Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4406CC5AD4E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC81-00011c-LF; Sun, 09 Aug 2026 18:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7z-0000ye-Vn
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:24 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7x-0007Qu-Ai
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:23 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2d032846c95so15778195ad.1
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314980; x=1786919780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bz2XBxP2T92FAyWVzu9j3Rr6m9/D14l5y68QA5xH0+k=;
 b=SkFp27rCYWd33Bc3FYQd/dlUzQEU3I5N+v79eD+Lz0Is5eT7qnOF7hJBsmI2IykF5e
 ffzjOFFmwzkxZAnwoef3XMzy1zS+1y9rUQbIN3vQslXpwyFKnvwhGgjkajspRyqlBZvq
 zs2gfQJXtByRQ5nWGI+vTwRkNCNwaAn+ceppegjDmRPn/fSCce40/d0l1zM0mymBNbcr
 bhbyZXd6sg0C3qAyZNUH519pCTfmo7bqedh3OkgS8EzWgBOFMn0NZILbMlI0/V25JUxg
 aziMtoy8wJ7oDLruRfLe6SCuNy+v4o0FzeiErrX/p6QlTfSkDJ6ZcZ56LQbbfYMigumw
 rblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314980; x=1786919780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Bz2XBxP2T92FAyWVzu9j3Rr6m9/D14l5y68QA5xH0+k=;
 b=SD37gHhgpeKCL1tV4O+Sawn8rT+ve9yGsEQD24ELWKc6Y2xd3c7cFf4vD72udG9VE0
 kztPBycNfQW0bViTOnbcrWFelxgB8V4K4t26zDhHPUMHlL3e/99z64TLQyycu/Y3ibC5
 1fHAV+AZE7azVkSYsHaj791YvqjvO7/uWgTw/Ijmpnj0NRsyFCdfqzwqBJ4Ehx3ttBJ9
 dI8yfCSL+u7wke2I3nhFT+RB01waFn5GdKTSZiQz/TzS8NetNQf7mxSoQTVfjCff8Flo
 +Zp7sNRSlF8VYd2p6ZkBFIDjz9L0JgOUHFNEZm/Tb/NbKrg64KX4XVDYxSRhThfI+B24
 nYIw==
X-Gm-Message-State: AOJu0Yw8Er/ve6CUjfl9kcUk0HleJwVDSzBfJ/713YtHfiWdrCrYrbhk
 hBiWVeCl9aGiVx3+OOcQW7Nrvh4foDljyrmKHEMG0GdvCm7Az5XsjIdXF7Ii51N7718hX+cNYY2
 c0fJj
X-Gm-Gg: AR+sD13KYUud6XuBpQfwCfKfSEAVl1X4rGlDv4egtDNILXc4t8eUpFwk1ZDObd9gNYb
 J26dzBXec31cqi0hIYOwDgNNHQ+FhsnBqWSZgn8A6tpv3gFcjzQZ6CvsxYFFZILxw+Q50NMx2dh
 pEDgQ4hl05QVIz2z9/kGYIr3EkKE7iE0SACwdBebo+Cmamu+KDZGeiETFhtdRquCGNNh2eHR23b
 egXo2bphERoIt/9GMyHPw85qqews9Cc3gMHDmVOCIDZuwf9g6iODYvxcLokUElb+zJMa8+qPxnc
 JjuUE1r9Ixcx1g1d0HI4Abko60kaGOmiBHWjofdyX/ced5OHDu6o4JeMHyzIuY+W4T6jErf2vWg
 I9/M+gqkZHkY59dxWWv9LqCGyCdVd3ymXz5fC2mIUqLdqLTBiTbAwxcooJCWxMadM4lztMVA6/0
 cGYfOIszYXwg7PyB/K0GUnyKdoTluqrSad5wlsiZvSeY0ZZhKI2H/UOEMRZHxf2cVb0ws6JsSJB
 4FZ+GrIZ6y3pMeXY3T5yGL6UpVlLnw=
X-Received: by 2002:a05:6a21:3a82:b0:3c3:791e:5e18 with SMTP id
 adf61e73a8af0-3cb85df09cbmr45496252637.7.1786314979651; 
 Sun, 09 Aug 2026 15:36:19 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:36:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 25/56] disas/riscv: Unify decomp_rv{32,64,128}
Date: Sun,  9 Aug 2026 15:35:14 -0700
Message-ID: <20260809223545.730664-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

We now distinguish compressed opcodes by isa during decode.
Therefore we don't need 3 copies of decomp_*.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.h |   4 +-
 disas/riscv.c | 155 ++++++++++++++++----------------------------------
 2 files changed, 51 insertions(+), 108 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 3909d73dd0..900363c603 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -183,9 +183,7 @@ typedef struct {
     rv_codec codec;
     const char *format;
     const rv_comp_data *pseudo;
-    short decomp_rv32;
-    short decomp_rv64;
-    short decomp_rv128;
+    rv_opcode decomp;
 } rv_opcode_data;
 
 typedef struct {
diff --git a/disas/riscv.c b/disas/riscv.c
index 95957506bd..2e891f509e 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1883,91 +1883,52 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "fcvt.q.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
     { "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1 },
     { "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1 },
-    { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm, NULL, rv_op_addi,
-      rv_op_addi, rv_op_addi },
-    { "c.fld", rv_codec_cl_ld, rv_fmt_frd_offset_rs1, NULL, rv_op_fld,
-      rv_op_fld, 0 },
-    { "c.lw", rv_codec_cl_lw, rv_fmt_rd_offset_rs1, NULL, rv_op_lw, rv_op_lw,
-      rv_op_lw },
-    { "c.flw", rv_codec_cl_lw, rv_fmt_frd_offset_rs1, NULL, rv_op_flw, 0, 0 },
-    { "c.fsd", rv_codec_cs_sd, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsd,
-      rv_op_fsd, 0 },
-    { "c.sw", rv_codec_cs_sw, rv_fmt_rs2_offset_rs1, NULL, rv_op_sw, rv_op_sw,
-      rv_op_sw },
-    { "c.fsw", rv_codec_cs_sw, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsw, 0, 0 },
+    { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm, NULL, rv_op_addi },
+    { "c.fld", rv_codec_cl_ld, rv_fmt_frd_offset_rs1, NULL, rv_op_fld },
+    { "c.lw", rv_codec_cl_lw, rv_fmt_rd_offset_rs1, NULL, rv_op_lw },
+    { "c.flw", rv_codec_cl_lw, rv_fmt_frd_offset_rs1, NULL, rv_op_flw },
+    { "c.fsd", rv_codec_cs_sd, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsd },
+    { "c.sw", rv_codec_cs_sw, rv_fmt_rs2_offset_rs1, NULL, rv_op_sw },
+    { "c.fsw", rv_codec_cs_sw, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsw },
     { },
-    { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi,
-      rv_op_addi },
-    { "c.jal", rv_codec_cj_jal, rv_fmt_rd_offset, NULL, rv_op_jal, 0, 0 },
-    { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi,
-      rv_op_addi },
-    { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm, NULL, rv_op_addi,
-      rv_op_addi, rv_op_addi },
-    { "c.lui", rv_codec_ci_lui, rv_fmt_rd_uimm, NULL, rv_op_lui, rv_op_lui,
-      rv_op_lui },
-    { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srli,
-      rv_op_srli, rv_op_srli },
-    { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srai,
-      rv_op_srai, rv_op_srai },
-    { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, NULL, rv_op_andi,
-      rv_op_andi, rv_op_andi },
-    { "c.sub", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_sub, rv_op_sub,
-      rv_op_sub },
-    { "c.xor", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_xor, rv_op_xor,
-      rv_op_xor },
-    { "c.or", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_or, rv_op_or,
-      rv_op_or },
-    { "c.and", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_and, rv_op_and,
-      rv_op_and },
-    { "c.subw", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_subw, rv_op_subw,
-      rv_op_subw },
-    { "c.addw", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_addw, rv_op_addw,
-      rv_op_addw },
-    { "c.j", rv_codec_cj, rv_fmt_rd_offset, NULL, rv_op_jal, rv_op_jal,
-      rv_op_jal },
-    { "c.beqz", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL, rv_op_beq, rv_op_beq,
-      rv_op_beq },
-    { "c.bnez", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL, rv_op_bne, rv_op_bne,
-      rv_op_bne },
-    { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_slli,
-      rv_op_slli, rv_op_slli },
-    { "c.fldsp", rv_codec_ci_ldsp, rv_fmt_frd_offset_rs1, NULL, rv_op_fld,
-      rv_op_fld, rv_op_fld },
-    { "c.lwsp", rv_codec_ci_lwsp, rv_fmt_rd_offset_rs1, NULL, rv_op_lw,
-      rv_op_lw, rv_op_lw },
-    { "c.flwsp", rv_codec_ci_lwsp, rv_fmt_frd_offset_rs1, NULL, rv_op_flw, 0,
-      0 },
-    { "c.jr", rv_codec_cr_jr, rv_fmt_rd_rs1_offset, NULL, rv_op_jalr,
-      rv_op_jalr, rv_op_jalr },
-    { "c.mv", rv_codec_cr_mv, rv_fmt_rd_rs1_rs2, NULL, rv_op_addi, rv_op_addi,
-      rv_op_addi },
-    { "c.ebreak", rv_codec_ci_none, rv_fmt_none, NULL, rv_op_ebreak,
-      rv_op_ebreak, rv_op_ebreak },
-    { "c.jalr", rv_codec_cr_jalr, rv_fmt_rd_rs1_offset, NULL, rv_op_jalr,
-      rv_op_jalr, rv_op_jalr },
-    { "c.add", rv_codec_cr, rv_fmt_rd_rs1_rs2, NULL, rv_op_add, rv_op_add,
-      rv_op_add },
-    { "c.fsdsp", rv_codec_css_sdsp, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsd,
-      rv_op_fsd, rv_op_fsd },
-    { "c.swsp", rv_codec_css_swsp, rv_fmt_rs2_offset_rs1, NULL, rv_op_sw,
-      rv_op_sw, rv_op_sw },
-    { "c.fswsp", rv_codec_css_swsp, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsw, 0,
-      0 },
-    { "c.ld", rv_codec_cl_ld, rv_fmt_rd_offset_rs1, NULL, 0, rv_op_ld,
-      rv_op_ld },
-    { "c.sd", rv_codec_cs_sd, rv_fmt_rs2_offset_rs1, NULL, 0, rv_op_sd,
-      rv_op_sd },
-    { "c.addiw", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, 0, rv_op_addiw,
-      rv_op_addiw },
-    { "c.ldsp", rv_codec_ci_ldsp, rv_fmt_rd_offset_rs1, NULL, 0, rv_op_ld,
-      rv_op_ld },
-    { "c.sdsp", rv_codec_css_sdsp, rv_fmt_rs2_offset_rs1, NULL, 0, rv_op_sd,
-      rv_op_sd },
-    { "c.lq", rv_codec_cl_lq, rv_fmt_rd_offset_rs1, NULL, 0, 0, rv_op_lq },
-    { "c.sq", rv_codec_cs_sq, rv_fmt_rs2_offset_rs1, NULL, 0, 0, rv_op_sq },
-    { "c.lqsp", rv_codec_ci_lqsp, rv_fmt_rd_offset_rs1, NULL, 0, 0, rv_op_lq },
-    { "c.sqsp", rv_codec_css_sqsp, rv_fmt_rs2_offset_rs1, NULL, 0, 0,
-      rv_op_sq },
+    { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, rv_op_addi },
+    { "c.jal", rv_codec_cj_jal, rv_fmt_rd_offset, NULL, rv_op_jal },
+    { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, NULL, rv_op_addi },
+    { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm, NULL, rv_op_addi },
+    { "c.lui", rv_codec_ci_lui, rv_fmt_rd_uimm, NULL, rv_op_lui },
+    { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srli },
+    { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srai },
+    { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, NULL, rv_op_andi },
+    { "c.sub", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_sub },
+    { "c.xor", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_xor },
+    { "c.or", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_or },
+    { "c.and", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_and },
+    { "c.subw", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_subw },
+    { "c.addw", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_addw },
+    { "c.j", rv_codec_cj, rv_fmt_rd_offset, NULL, rv_op_jal },
+    { "c.beqz", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL, rv_op_beq },
+    { "c.bnez", rv_codec_cb, rv_fmt_rs1_rs2_offset, NULL, rv_op_bne },
+    { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_slli },
+    { "c.fldsp", rv_codec_ci_ldsp, rv_fmt_frd_offset_rs1, NULL, rv_op_fld },
+    { "c.lwsp", rv_codec_ci_lwsp, rv_fmt_rd_offset_rs1, NULL, rv_op_lw },
+    { "c.flwsp", rv_codec_ci_lwsp, rv_fmt_frd_offset_rs1, NULL, rv_op_flw },
+    { "c.jr", rv_codec_cr_jr, rv_fmt_rd_rs1_offset, NULL, rv_op_jalr },
+    { "c.mv", rv_codec_cr_mv, rv_fmt_rd_rs1_rs2, NULL, rv_op_addi },
+    { "c.ebreak", rv_codec_ci_none, rv_fmt_none, NULL, rv_op_ebreak },
+    { "c.jalr", rv_codec_cr_jalr, rv_fmt_rd_rs1_offset, NULL, rv_op_jalr },
+    { "c.add", rv_codec_cr, rv_fmt_rd_rs1_rs2, NULL, rv_op_add },
+    { "c.fsdsp", rv_codec_css_sdsp, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsd },
+    { "c.swsp", rv_codec_css_swsp, rv_fmt_rs2_offset_rs1, NULL, rv_op_sw },
+    { "c.fswsp", rv_codec_css_swsp, rv_fmt_frs2_offset_rs1, NULL, rv_op_fsw },
+    { "c.ld", rv_codec_cl_ld, rv_fmt_rd_offset_rs1, NULL, rv_op_ld },
+    { "c.sd", rv_codec_cs_sd, rv_fmt_rs2_offset_rs1, NULL,  rv_op_sd },
+    { "c.addiw", rv_codec_ci, rv_fmt_rd_rs1_imm, NULL, rv_op_addiw },
+    { "c.ldsp", rv_codec_ci_ldsp, rv_fmt_rd_offset_rs1, NULL, rv_op_ld },
+    { "c.sdsp", rv_codec_css_sdsp, rv_fmt_rs2_offset_rs1, NULL, rv_op_sd },
+    { "c.lq", rv_codec_cl_lq, rv_fmt_rd_offset_rs1, NULL, rv_op_lq },
+    { "c.sq", rv_codec_cs_sq, rv_fmt_rs2_offset_rs1, NULL, rv_op_sq },
+    { "c.lqsp", rv_codec_ci_lqsp, rv_fmt_rd_offset_rs1, NULL, rv_op_lq },
+    { "c.sqsp", rv_codec_css_sqsp, rv_fmt_rs2_offset_rs1, NULL, rv_op_sq },
     { "nop", rv_codec_i, rv_fmt_none },
     { "mv", rv_codec_i, rv_fmt_rd_rs1 },
     { "not", rv_codec_i, rv_fmt_rd_rs1 },
@@ -2649,10 +2610,8 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "ssrdp", rv_codec_r, rv_fmt_rd },
     { "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
     { "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "c.sspush", rv_codec_cmop_ss, rv_fmt_rs2, NULL, rv_op_sspush,
-      rv_op_sspush, 0 },
-    { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
-      rv_op_sspopchk, 0 },
+    { "c.sspush", rv_codec_cmop_ss, rv_fmt_rs2, NULL, rv_op_sspush },
+    { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk },
    { "cbo.inval", rv_codec_r, rv_fmt_rs1 },
    { "cbo.clean", rv_codec_r, rv_fmt_rs1 },
    { "cbo.flush", rv_codec_r, rv_fmt_rs1 },
@@ -5397,24 +5356,10 @@ static const rv_opcode_data *decode_inst_lift_pseudo(rv_decode *dec,
 
 /* decompress instruction */
 
-static const rv_opcode_data *decode_inst_decompress(rv_decode *dec, rv_isa isa,
+static const rv_opcode_data *decode_inst_decompress(rv_decode *dec,
                                                     const rv_opcode_data *op)
 {
-    int decomp_op;
-
-    switch (isa) {
-    case rv32:
-        decomp_op = op->decomp_rv32;
-        break;
-    case rv64:
-        decomp_op = op->decomp_rv64;
-        break;
-    case rv128:
-        decomp_op = op->decomp_rv128;
-        break;
-    default:
-        g_assert_not_reached();
-    }
+    int decomp_op = op->decomp;
 
     if (decomp_op != rv_op_illegal) {
         dec->op = decomp_op;
@@ -5473,7 +5418,7 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
 
     op = &dec.opcode_data[dec.op];
     decode_inst_operands(&dec, isa, op);
-    op = decode_inst_decompress(&dec, isa, op);
+    op = decode_inst_decompress(&dec, op);
     op = decode_inst_lift_pseudo(&dec, op);
     return format_inst(24, &dec, op);
 }
-- 
2.43.0


