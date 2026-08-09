Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF65C5AD4E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC8C-0001Jv-VM; Sun, 09 Aug 2026 18:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC8B-0001IX-Fz
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:35 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC89-0007WE-OK
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:35 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cf27856f9cso14728295ad.2
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314992; x=1786919792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QDdGXOAjRCRTBpAOJM0ehmKygQxg7qLy2hsExy2wv8c=;
 b=N9eeUU0Y44OOgZHAhmnff0qzPFauKrVHJJfw5X1bMy31fXseJaAh33QppIIT9Xc/E1
 zyIyi6FyxClf1LFITx4vrF0ziOKnB6yMBbbUUSMVXqr94cjQukw8ClIsrYWPOTKXtdvO
 ZB3Tp1bxh9udzQpYsO1xh8e9hjlDTYeI+oKY6ilyHCS0Eljly6G/h/baX7C3mXtceV+j
 ghVLXbXH8cTtEUGSA6R0BuU9pWLcbrZwPP1GWqtU4TZfyNoiRq9tTf9Ze7P0yV5FJYl8
 xKq+PmHx8IlGT/8xD9+xQMXXv76JR/swMXDhnVAKThhj9MpaeqgZgWVJbsf7RP+bOWAI
 /l8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314992; x=1786919792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QDdGXOAjRCRTBpAOJM0ehmKygQxg7qLy2hsExy2wv8c=;
 b=R3Q5AIBbMryuZuTL3/7RQwqDf50u/HoqTSHJzaCSrnUuYJuIV3lGc8TuOdXQlvE3MD
 0Bs2YDKNE4BGh/8xGPHX1QkkQgWIIAt6n7PeX7algsTH9tOIndzKovWW6jko99yxMRax
 4YY8BbvN0lj++OmnxeKK5hnhEPzcjQKINeh0DFdrGs/ZKol1TRbj7Wcl8DDboJ+81Hmt
 MDcoi7xDCkgbtkPQcQ68zFrhbvnwT+/pBCqn+4UMs7u09tUZLdBpsiRty+xJo5qf3o4c
 kBwdZz7Pof0lyhwamshFQib21wssILgf/JuE+KqKXrGNkHCi42W6ahU68hgMgsiK0Gvt
 g3NA==
X-Gm-Message-State: AOJu0YzOXtlecyQkw8IT0FK+x2rHtd8dS6m2BgqUf/Xd1AR0J5eeDriJ
 4+axbJCBIdRnR06BCZL0RACV2iH7DctwtDNyHjqPFrM1hPSkeohd3dczo9lTy+GbE6QdPRiOWFl
 yb+RH
X-Gm-Gg: AR+sD11VzJIZvsWe/Cy3Sh4LFWAEBuIG0UNot90WtMO5JUIGXXhI/0wRFnArJKaEBAs
 bMQySPP2zh7fuvjsYXCyP5ySW5h6LZIAPvHyxIF522Ozpd6KtFaA+VAkXkLBc/wbgZ+xx+Go4z8
 ADBI4wVDCs+PCYjPAom7rbxlrN2+Fwi7fRPZ+/24ej0EFBsxHI3EDiBbmk4tWwJW+PiEdUyO+Gt
 j8xJ4yAQ1jb+N/kHEHk7bL7JDOt4WbiOU3otX1UwXVBCvntmVXpD7vblxgg6MbWCql6TEVMCxMv
 gzOv9YFbDneJ3QPOFgp8QRPXY3uG9t+3s+9z/yVJ828uRdoE1aVe8A4FT1So+yBNJZhf+xe/4lE
 7WwlYP5Zec3EdwTwwsBd7SxGsY7jxHj3TmcbqzCwQWSoRERb7YF5rwVDsPCLSVrBjZAKJ7YJuP1
 5MxGG9xS2YmnWTWmeigaeaWgNwDXuwYUq9Qxugafx9A807OS+eako2otcMAhZ8mUzNtstAKMWcd
 TZWm1wbEMLsv3n/8aTj
X-Received: by 2002:a05:6300:4049:b0:3bf:a638:4376 with SMTP id
 adf61e73a8af0-3cb85ea369dmr44314498637.21.1786314992183; 
 Sun, 09 Aug 2026 15:36:32 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:36:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 37/56] disas/riscv: Use rv_codec_illegal for pseudos
Date: Sun,  9 Aug 2026 15:35:26 -0700
Message-ID: <20260809223545.730664-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

The codec is never used, since we arrive into pseudos
from a decoding of another opcode.
Assert that rv_codec_illegal is never decoded.
Use rv_codec_none for rv_op_illegal.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 68 +++++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 37f6440831..fc821355fe 100644
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
2.43.0


