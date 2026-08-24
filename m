Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8652FC5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 06:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbU-0005Om-3w; Mon, 24 Aug 2026 01:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNav-0004hh-SN
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:42 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNaq-0002o4-Hu
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:41 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso3590006a91.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550695; x=1788155495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jbYaKFBvGXXY2CnicUYZq7lQqnHJQFU/m+HVMKAtotE=;
 b=lYCiS3E6HE8L2tjjF8vpFtuDq6qgDmWbpUfym552t4vak4GsOIRFK8l6fLNGaJPHdr
 4RQCr7xe7mnepG9g01Kzgu4L2cf4vPmOla74ZxgrDhvgB3oI5t8DXY37Cn3rw9tpUatt
 +a0nBZtt9r0YNCBoZ08s1IO4J/oLU5IUB0MGeT2hNZC8EyiKBEAIbUPlQraXA/CW6IPy
 H9ycBDaIxfFGu3ts2FGhB2quu3TLlyyTdWM/2aQ6UHgoZ6yR+vl5zK9lQubFLZUt2N58
 d1Isb7kjmNKeiHFCN0jKt6pgY7wISn0afJ621KggAazDnqB26iPYgc4SbNSJI5IJqBPs
 XaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550695; x=1788155495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jbYaKFBvGXXY2CnicUYZq7lQqnHJQFU/m+HVMKAtotE=;
 b=rXL7bcH/U5y2qzoGkTDAymdOPpo2uHEkrULOQ7JQsKk7Yex2sKTc1hO7aG5ayN7Osd
 lXT0bfCLyyBj+yR7lGapT3rHqKp3OGXhlgMJ1pMnsvBvyhrC8gPRMO1IbB2pSAO9Rfjp
 YI448pLqmo/zupg2u7+JuqDZ/5bNLQCVyo/xc1QSyCkefwpB0rtxJcZwW5xOFINxpDqc
 scB6o8ef6GmfJLlBzLqGBWnVnhrXubTe5xVag94wyTluRG2bmXWJWM/JbUAV55D+B6wX
 Pes/vZk1DDWfJNRryWxhnRepfs7TNpudrkvE+nSkUR5fXImuxdqtg/KW3SNFHUxnOdxh
 YdPg==
X-Gm-Message-State: AFuF++mq7pIundFMJnG+Xvh8gJSH8+2BR/Ps7TXi/JCwEgCWBcSeijoi
 Y/xQznic6Ubt6+AslokHFA26a2gZIX04Bouz3NvtN0EKGYygaR/KBiqjDW2TcA==
X-Gm-Gg: AR+sD12WR2giwHK3iHFm0k1Au7n3W1yt/2VRXGp4euzRgUBcEoBMFy4CHIVhWGn/4U0
 eisbvcPMJqcxvLJTQ/VNp5TABRME1qSx+LJLV84+G8LJ1aM47DhSa7roye5RzgfrI6tU9XtzDxx
 3N+cD4ZgAe241yZNYdnzSOdNK83xNSuwXIlsasWLAwQlxzBzXZkpCzdGh+WKR5Ul94ucRf9LUFL
 2wbk5F8DC87QS+J/GQZRDlGapa4OUC8rDYkO2nWyEay6VuBRo095p4Nq4rGzGm9/O8J6msGnJtQ
 sKYJJTOHCnDlCDZ6xZhBzCLnd9SWMrvchExiCFtZ74TcxN4kus20FTC4Vc0aa2Jr8EYyb+63DaT
 gza60yMcVPglbqsstKUMmGcgbmJ1e77z+9GyjU3CIYELBnFsROdlg1HJIZU/unpyu0KCBIRt3N2
 Z5KM6JlJE8QHVOtiP2NDRDLTDJhSRU7HphMhaofPDXLe04XaG+wtBe4RKnr/wRR01QV93XaAMs+
 Akiew==
X-Received: by 2002:a17:90b:560d:b0:38e:9045:bac0 with SMTP id
 98e67ed59e1d1-395deea6acbmr31183483a91.5.1787550695108; 
 Sun, 23 Aug 2026 22:51:35 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:51:34 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 65/96] disas/riscv: Use rv_codec_illegal for pseudos
Date: Mon, 24 Aug 2026 15:47:35 +1000
Message-ID: <20260824054806.2790041-66-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
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

The codec is never used, since we arrive into pseudos
from a decoding of another opcode.
Assert that rv_codec_illegal is never decoded.
Use rv_codec_none for rv_op_illegal.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-33-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 68 +++++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 7fa76b2d15..dedd925077 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1599,7 +1599,7 @@ static uint32_t operand_lpl(rv_inst inst)
 /* instruction metadata */
 
 static const rv_opcode_data rvi_opcode_data[] = {
-    { "illegal", rv_codec_illegal, rv_fmt_none },
+    { "illegal", rv_codec_none, rv_fmt_none },
     { "lui", rv_codec_u, rv_fmt_rd_uimm },
     { "auipc", rv_codec_u, rv_fmt_rd_uoffset },
     { "jal", rv_codec_uj, rv_fmt_rd_offset, rvcp_jal },
@@ -1872,38 +1872,38 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "c.sq", rv_codec_cs_sq, NULL, DECOMP(rv_op_sq) },
     { "c.lqsp", rv_codec_ci_lqsp, NULL, DECOMP(rv_op_lq) },
     { "c.sqsp", rv_codec_css_sqsp, NULL, DECOMP(rv_op_sq) },
-    { "nop", rv_codec_i, rv_fmt_none },
-    { "mv", rv_codec_i, rv_fmt_rd_rs1, rvcp_mv },
-    { "not", rv_codec_i, rv_fmt_rd_rs1 },
-    { "neg", rv_codec_r, rv_fmt_rd_rs2 },
-    { "negw", rv_codec_r, rv_fmt_rd_rs2 },
-    { "sext.w", rv_codec_i, rv_fmt_rd_rs1 },
-    { "seqz", rv_codec_i, rv_fmt_rd_rs1 },
-    { "snez", rv_codec_r, rv_fmt_rd_rs2 },
-    { "sltz", rv_codec_r, rv_fmt_rd_rs1 },
-    { "sgtz", rv_codec_r, rv_fmt_rd_rs2 },
-    { "fmv.s", rv_codec_r, rv_fmt_frd_frs1 },
-    { "fabs.s", rv_codec_r, rv_fmt_frd_frs1 },
-    { "fneg.s", rv_codec_r, rv_fmt_frd_frs1 },
-    { "fmv.d", rv_codec_r, rv_fmt_frd_frs1 },
-    { "fabs.d", rv_codec_r, rv_fmt_frd_frs1 },
-    { "fneg.d", rv_codec_r, rv_fmt_frd_frs1 },
-    { "fmv.q", rv_codec_r, rv_fmt_frd_frs1 },
-    { "fabs.q", rv_codec_r, rv_fmt_frd_frs1 },
-    { "fneg.q", rv_codec_r, rv_fmt_frd_frs1 },
-    { "beqz", rv_codec_sb, rv_fmt_rs1_offset },
-    { "bnez", rv_codec_sb, rv_fmt_rs1_offset },
-    { "blez", rv_codec_sb, rv_fmt_rs2_offset },
-    { "bgez", rv_codec_sb, rv_fmt_rs1_offset },
-    { "bltz", rv_codec_sb, rv_fmt_rs1_offset },
-    { "bgtz", rv_codec_sb, rv_fmt_rs2_offset },
-    { "jal", rv_codec_none, rv_fmt_offset }, /* rv_op_jal_ra */
-    { "jalr", rv_codec_none, rv_fmt_rs1 }, /* rv_op_jalr_ra */
+    { "nop", rv_codec_illegal, rv_fmt_none },
+    { "mv", rv_codec_illegal, rv_fmt_rd_rs1, rvcp_mv },
+    { "not", rv_codec_illegal, rv_fmt_rd_rs1 },
+    { "neg", rv_codec_illegal, rv_fmt_rd_rs2 },
+    { "negw", rv_codec_illegal, rv_fmt_rd_rs2 },
+    { "sext.w", rv_codec_illegal, rv_fmt_rd_rs1 },
+    { "seqz", rv_codec_illegal, rv_fmt_rd_rs1 },
+    { "snez", rv_codec_illegal, rv_fmt_rd_rs2 },
+    { "sltz", rv_codec_illegal, rv_fmt_rd_rs1 },
+    { "sgtz", rv_codec_illegal, rv_fmt_rd_rs2 },
+    { "fmv.s", rv_codec_illegal, rv_fmt_frd_frs1 },
+    { "fabs.s", rv_codec_illegal, rv_fmt_frd_frs1 },
+    { "fneg.s", rv_codec_illegal, rv_fmt_frd_frs1 },
+    { "fmv.d", rv_codec_illegal, rv_fmt_frd_frs1 },
+    { "fabs.d", rv_codec_illegal, rv_fmt_frd_frs1 },
+    { "fneg.d", rv_codec_illegal, rv_fmt_frd_frs1 },
+    { "fmv.q", rv_codec_illegal, rv_fmt_frd_frs1 },
+    { "fabs.q", rv_codec_illegal, rv_fmt_frd_frs1 },
+    { "fneg.q", rv_codec_illegal, rv_fmt_frd_frs1 },
+    { "beqz", rv_codec_illegal, rv_fmt_rs1_offset },
+    { "bnez", rv_codec_illegal, rv_fmt_rs1_offset },
+    { "blez", rv_codec_illegal, rv_fmt_rs2_offset },
+    { "bgez", rv_codec_illegal, rv_fmt_rs1_offset },
+    { "bltz", rv_codec_illegal, rv_fmt_rs1_offset },
+    { "bgtz", rv_codec_illegal, rv_fmt_rs2_offset },
+    { "jal", rv_codec_illegal, rv_fmt_offset }, /* rv_op_jal_ra */
+    { "jalr", rv_codec_illegal, rv_fmt_rs1 }, /* rv_op_jalr_ra */
     { },
     { },
-    { "j", rv_codec_uj, rv_fmt_offset },
-    { "ret", rv_codec_i, rv_fmt_none },
-    { "jr", rv_codec_i, rv_fmt_rs1, rvcp_jr },
+    { "j", rv_codec_illegal, rv_fmt_offset },
+    { "ret", rv_codec_illegal, rv_fmt_none },
+    { "jr", rv_codec_illegal, rv_fmt_rs1, rvcp_jr },
     { "rdcycle", rv_codec_i_csr, rv_fmt_rd },
     { "rdtime", rv_codec_i_csr, rv_fmt_rd },
     { "rdinstret", rv_codec_i_csr, rv_fmt_rd },
@@ -4551,8 +4551,6 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa,
     rv_inst inst = dec->inst;
 
     switch (op->codec) {
-    case rv_codec_illegal:
-        break;
     case rv_codec_none:
         dec->rd = dec->rs1 = dec->rs2 = rv_ireg_zero;
         dec->imm = 0;
@@ -4946,7 +4944,9 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa,
         dec->rs1 = dec->rs2 = operand_crs1(inst);
         dec->imm = 0;
         break;
-    };
+    default:
+        g_assert_not_reached();
+    }
 }
 
 /* check constraint */
-- 
2.54.0


