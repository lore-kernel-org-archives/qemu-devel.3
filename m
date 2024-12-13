Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72836E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Xc-0007R7-FC; Fri, 13 Dec 2024 12:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9X5-0006za-Sn
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:57 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9X3-0001Vo-MB
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:55 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so1509819f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111172; x=1734715972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UvCNc+SNol+mmfXe4nD22J5FvUFCfyVXPg9YYzFJKJI=;
 b=Fx6nmKDcTH5EW0MWRZYkzPfLbg6l7KewOy8D/R/ozTP7V0Cw4ZzYLIqfpujeXLQU/E
 GQCsmVzvd3A2/A5JQOO0QllRI+KdIXz6NQfw5seWeuA7SE4+2jTNjuYHrIdsHK5vUUt8
 4F0t5tM4rx9r4i07OPTutz8YKxoedPYhF/fu9Wh1JUXIj8Tuz1X+pi8cG6/FFzf6sexb
 ZtbCp23i2XzJaAnQvJ9zv882ciZx7RiQbr2YbpP0JbnTBjYjSCWaDxADljM5NBdF5S9r
 3WdLAuVyX2KNekbxrTV7GILjV7tO7XsR5r07BWVijK5GmU8owNuQMEzqgN+E0r4ZsWMv
 kmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111172; x=1734715972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UvCNc+SNol+mmfXe4nD22J5FvUFCfyVXPg9YYzFJKJI=;
 b=FBCbJY7UHjV3zOWJjrRhXwpB58XNxqlLct2+bc5Ve6bbttdzkirJdW0GIwIEyjS9Lz
 VwR6enJWzq2D+vTsf4HTrr2hArQyPtHAb6DWgNNSEgIiIDn+46eD3Zcfwa+tWiOTC3Hj
 HsbNC1gx0bCEoABKKLuqt+BtCN4/JYmjHz0oW1syrMwTSb8FZONDuLFllxoWKtwvN/99
 uqopF2XEOhRUt2tgjgw2qyrCfI6kqWnBo9DzRFM38z/uLjCpfd3+i5uiyDffdukdVhjV
 TaX5ik6J/MhPhkBKRuPoGAPEQ/NPbiWa4wQ2q3a5KunNujaBcPl8BLcG0Nj1hfT1TUL7
 4FJw==
X-Gm-Message-State: AOJu0Yy8dZ7PQulTpC92gSqY5bIaZ++m9cHiSJyrOq/cFp9BKfLy/PtG
 RAct8F0bHAfjfsfBmmMSh3B15FUYwX/7+xR4HS5LLtMC0CsTUeTiIjCvY+x9T1/qcoQLRr2r870
 e
X-Gm-Gg: ASbGncuMrRhZWHMJmvm9OzESOIreJ2Vhym2KgZxfLauxGS42tS4ozrMoIMOFALr6yeE
 +czxlj+rtHsGhXTl5a2/HPgumHm60s6+rXqAaM0e/s3HgfzKFTmLaK5tUvKMnG6sJdAhLmoaGpp
 NqlZ3E5f8H8IPY3V6hq5/UHzJrPHVpnqBKTUhHAEjnUDcOUBbcry4FrabES24flIrTIM1q07fxP
 /yygg/71gUKbtAqhMEf9BsAoYTvHKPfsF9/lt0AuObYjI6igpPfGMpAFO8lSg==
X-Google-Smtp-Source: AGHT+IExkCDfeRyhrrBpubSmJWC0KgSDVl0ZO+nyI7fiMrYl+jHBmSO9etp4qQKcm7nY56G/GUzEGQ==
X-Received: by 2002:a05:6000:18ad:b0:386:3e65:5a58 with SMTP id
 ffacd0b85a97d-38880acd57bmr2855789f8f.20.1734111171995; 
 Fri, 13 Dec 2024 09:32:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/85] target/arm: Convert disas_cond_select to decodetree
Date: Fri, 13 Dec 2024 17:31:23 +0000
Message-Id: <20241213173229.3308926-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Id: <qemu-devel.nongnu.org>
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

This includes CSEL, CSINC, CSINV, CSNEG.  Remove disas_data_proc_reg,
as these were the last insns decoded by that function.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-20-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  3 ++
 target/arm/tcg/translate-a64.c | 84 ++++++----------------------------
 2 files changed, 17 insertions(+), 70 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index a9d7d571995..56708467681 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -766,6 +766,9 @@ SETF16          0 01 11010000 00000 010010 rn:5 01101
 CCMP            sf:1 op:1 1 11010010 y:5 cond:4 imm:1 0 rn:5 0 nzcv:4
 
 # Conditional select
+
+CSEL            sf:1 else_inv:1 011010100 rm:5 cond:4 0 else_inc:1 rn:5 rd:5
+
 # Data Processing (3-source)
 
 &rrrr           rd rn rm ra
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 56a445a3c28..9c6365f5efc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8171,39 +8171,17 @@ static bool trans_CCMP(DisasContext *s, arg_CCMP *a)
     return true;
 }
 
-/* Conditional select
- *   31   30  29  28             21 20  16 15  12 11 10 9    5 4    0
- * +----+----+---+-----------------+------+------+-----+------+------+
- * | sf | op | S | 1 1 0 1 0 1 0 0 |  Rm  | cond | op2 |  Rn  |  Rd  |
- * +----+----+---+-----------------+------+------+-----+------+------+
- */
-static void disas_cond_select(DisasContext *s, uint32_t insn)
+static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
 {
-    unsigned int sf, else_inv, rm, cond, else_inc, rn, rd;
-    TCGv_i64 tcg_rd, zero;
+    TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+    TCGv_i64 zero = tcg_constant_i64(0);
     DisasCompare64 c;
 
-    if (extract32(insn, 29, 1) || extract32(insn, 11, 1)) {
-        /* S == 1 or op2<1> == 1 */
-        unallocated_encoding(s);
-        return;
-    }
-    sf = extract32(insn, 31, 1);
-    else_inv = extract32(insn, 30, 1);
-    rm = extract32(insn, 16, 5);
-    cond = extract32(insn, 12, 4);
-    else_inc = extract32(insn, 10, 1);
-    rn = extract32(insn, 5, 5);
-    rd = extract32(insn, 0, 5);
+    a64_test_cc(&c, a->cond);
 
-    tcg_rd = cpu_reg(s, rd);
-
-    a64_test_cc(&c, cond);
-    zero = tcg_constant_i64(0);
-
-    if (rn == 31 && rm == 31 && (else_inc ^ else_inv)) {
+    if (a->rn == 31 && a->rm == 31 && (a->else_inc ^ a->else_inv)) {
         /* CSET & CSETM.  */
-        if (else_inv) {
+        if (a->else_inv) {
             tcg_gen_negsetcond_i64(tcg_invert_cond(c.cond),
                                    tcg_rd, c.value, zero);
         } else {
@@ -8211,53 +8189,23 @@ static void disas_cond_select(DisasContext *s, uint32_t insn)
                                 tcg_rd, c.value, zero);
         }
     } else {
-        TCGv_i64 t_true = cpu_reg(s, rn);
-        TCGv_i64 t_false = read_cpu_reg(s, rm, 1);
-        if (else_inv && else_inc) {
+        TCGv_i64 t_true = cpu_reg(s, a->rn);
+        TCGv_i64 t_false = read_cpu_reg(s, a->rm, 1);
+
+        if (a->else_inv && a->else_inc) {
             tcg_gen_neg_i64(t_false, t_false);
-        } else if (else_inv) {
+        } else if (a->else_inv) {
             tcg_gen_not_i64(t_false, t_false);
-        } else if (else_inc) {
+        } else if (a->else_inc) {
             tcg_gen_addi_i64(t_false, t_false, 1);
         }
         tcg_gen_movcond_i64(c.cond, tcg_rd, c.value, zero, t_true, t_false);
     }
 
-    if (!sf) {
+    if (!a->sf) {
         tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
     }
-}
-
-/*
- * Data processing - register
- *  31  30 29  28      25    21  20  16      10         0
- * +--+---+--+---+-------+-----+-------+-------+---------+
- * |  |op0|  |op1| 1 0 1 | op2 |       |  op3  |         |
- * +--+---+--+---+-------+-----+-------+-------+---------+
- */
-static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
-{
-    int op1 = extract32(insn, 28, 1);
-    int op2 = extract32(insn, 21, 4);
-
-    if (!op1) {
-        goto do_unallocated;
-    }
-
-    switch (op2) {
-    case 0x4: /* Conditional select */
-        disas_cond_select(s, insn);
-        break;
-
-    default:
-    do_unallocated:
-    case 0x0:
-    case 0x2: /* Conditional compare */
-    case 0x6: /* Data-processing */
-    case 0x8 ... 0xf: /* (3 source) */
-        unallocated_encoding(s);
-        break;
-    }
+    return true;
 }
 
 static void handle_fp_compare(DisasContext *s, int size,
@@ -11212,10 +11160,6 @@ static bool btype_destination_ok(uint32_t insn, bool bt, int btype)
 static void disas_a64_legacy(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 25, 4)) {
-    case 0x5:
-    case 0xd:      /* Data processing - register */
-        disas_data_proc_reg(s, insn);
-        break;
     case 0x7:
     case 0xf:      /* Data processing - SIMD and floating point */
         disas_data_proc_simd_fp(s, insn);
-- 
2.34.1


