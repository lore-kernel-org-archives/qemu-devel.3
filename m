Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F14AC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnt9-00021u-Al; Sun, 16 Feb 2025 18:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnt0-0001Xe-Ay
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:18 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnsx-0005zd-0B
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:17 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-220c92c857aso58818255ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747833; x=1740352633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FRBq/xYD3/JfYNF5jZaTjVpPZayAJnbvKXgiL0UvszA=;
 b=T1jf4iSVr+zPlsHgQpfRvgeIkr2BrCEfilbAV/8KZnyVcIJqDfRSFG6GM+/8mTBU5L
 0WziOfR9Ii55A97qpc9jvGK9W8TabXKUKeYfzoYGjFTUFdhiZSZsOTZAFQONDYd65qDI
 Z/dzbcBuMOI/YI4rfjsksUkGewSUBFlVP3/orQ24aOWCWMS5qDmj31EsIqTJ5je4CGJ0
 NYblJJx0lS7p4ZZ556ZBcscfd5J5Fd1nhWCgP6g/YYB1qOYwAsxvfj8Pk9G/va7h4XdB
 yzDJnUmneECkLNeYLWt0AYlLQGypWe4+qIXC8ljVO8+RXvfevMlPPFrAHYtuCexi3nJq
 B9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747833; x=1740352633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FRBq/xYD3/JfYNF5jZaTjVpPZayAJnbvKXgiL0UvszA=;
 b=nM9DQHB3VtZf+l1C1bRBIsNk6IkpfG2EshcL9xiA1WvVJqB7CIEFnv0F9tVnwcs95f
 Z9bRNwPPt0TRcoNzLX6xgDqjjEviGAkXpzQmFCatehvklSRuC/MuxfU8j6CnowLMuQ+T
 scmoCjJe3/oDM2HcUXfVCFsj0SAKugJxD85N9FitFt3Eq4SloEktqlOFE48jZjhzBUJc
 cqIoyvAyL5YfEOMx9RjF6XheLSOjuYJOAlJTeXVjXvzqdA+PBpdtsZKw/1YszKSvE79/
 Qw76cXusBkpc9W8DUN6AFq4hyzxR5PpA6mAxXDgspqKh14L3yXg2xP12EvyDSDDBMfdh
 K8hw==
X-Gm-Message-State: AOJu0YwRqkeCOv/65KT2efuBX1VnAU/GIH3fh/cAIBIM0Bg4+C2laFUH
 jNHY88TVaeLmDehoPxdjvBbbDIDsWlukKV09cjcM/zNMPh6Ahrr8N2JIwkRlR6QgqwdpYU6xXEh
 O
X-Gm-Gg: ASbGncsbvgJmpd9vBXdvw5aFFOTWJYHkdRnBG3+HX0iezwIARvohzR1FqwjTI2pjT/n
 DtlrZwPJAvyMnsqwldtUqcEpgocrTVFx5vhYBKlJUZCc8NAXKEZxNYASB9sObvLjzoApO3Pl/bQ
 /ipvhJY24DSXAX8euMQII+gkKzVvCrDOuIDSibUAWlfPK+PODqQ/1yDZZ7F/2wBVDf2tlL3XjCh
 1cEgqFH+bVhfcbATaAhVtDiQLixFJPJepP94NC4Jg+1mHfQ2FRnuCTPcRcaBO+gxXMoo6BgrFyq
 BDrZJPgw1a0VOe+7AGyXcBbXbTrszWd9jWcfy0IPUyyugOg=
X-Google-Smtp-Source: AGHT+IH5wLyz1e6O/Z1rAhUKnX5MajOtGuDRxjJ2hM+g8tlieYz6ZsgaqJq4+GTgsnnBbaio3ofJfQ==
X-Received: by 2002:a17:903:2cb:b0:220:e98e:4f1b with SMTP id
 d9443c01a7336-22104118a7emr137956065ad.0.1739747833318; 
 Sun, 16 Feb 2025 15:17:13 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 080/162] tcg: Merge INDEX_op_movcond_{i32,i64}
Date: Sun, 16 Feb 2025 15:08:49 -0800
Message-ID: <20250216231012.2808572-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  3 +--
 tcg/optimize.c           |  2 +-
 tcg/tcg-op.c             |  4 ++--
 tcg/tcg.c                | 15 +++++----------
 tcg/tci.c                |  4 ++--
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index d40ca001c2..5e085607d5 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -51,6 +51,7 @@ DEF(divs2, 2, 3, 0, TCG_OPF_INT)
 DEF(divu, 1, 2, 0, TCG_OPF_INT)
 DEF(divu2, 2, 3, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
+DEF(movcond, 1, 4, 1, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
 DEF(muls2, 2, 2, 0, TCG_OPF_INT)
 DEF(mulsh, 1, 2, 0, TCG_OPF_INT)
@@ -74,7 +75,6 @@ DEF(shr, 1, 2, 0, TCG_OPF_INT)
 DEF(sub, 1, 2, 0, TCG_OPF_INT)
 DEF(xor, 1, 2, 0, TCG_OPF_INT)
 
-DEF(movcond_i32, 1, 4, 1, 0)
 /* load/store */
 DEF(ld8u_i32, 1, 1, 1, 0)
 DEF(ld8s_i32, 1, 1, 1, 0)
@@ -98,7 +98,6 @@ DEF(setcond2_i32, 1, 4, 1, 0)
 DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
 
-DEF(movcond_i64, 1, 4, 1, 0)
 /* load/store */
 DEF(ld8u_i64, 1, 1, 1, 0)
 DEF(ld8s_i64, 1, 1, 1, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 9e6a2e3ec1..8783447e29 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2931,7 +2931,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_mov_vec:
             done = fold_mov(&ctx, op);
             break;
-        CASE_OP_32_64(movcond):
+        case INDEX_op_movcond:
             done = fold_movcond(&ctx, op);
             break;
         case INDEX_op_mul:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 041ca95f0d..3527952c66 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1095,7 +1095,7 @@ void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_mov_i32(ret, v2);
     } else {
-        tcg_gen_op6i_i32(INDEX_op_movcond_i32, ret, c1, c2, v1, v2, cond);
+        tcg_gen_op6i_i32(INDEX_op_movcond, ret, c1, c2, v1, v2, cond);
     }
 }
 
@@ -2799,7 +2799,7 @@ void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_mov_i64(ret, v2);
     } else if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op6i_i64(INDEX_op_movcond_i64, ret, c1, c2, v1, v2, cond);
+        tcg_gen_op6i_i64(INDEX_op_movcond, ret, c1, c2, v1, v2, cond);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 zero = tcg_constant_i32(0);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 9a7c73fba2..4d8803e1c2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1064,8 +1064,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
     OUTOP(INDEX_op_divu2, TCGOutOpDivRem, outop_divu2),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
-    OUTOP(INDEX_op_movcond_i32, TCGOutOpMovcond, outop_movcond),
-    OUTOP(INDEX_op_movcond_i64, TCGOutOpMovcond, outop_movcond),
+    OUTOP(INDEX_op_movcond, TCGOutOpMovcond, outop_movcond),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_muls2, TCGOutOpMul2, outop_muls2),
     OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
@@ -2292,13 +2291,13 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_and:
     case INDEX_op_brcond:
     case INDEX_op_mov:
+    case INDEX_op_movcond:
     case INDEX_op_negsetcond:
     case INDEX_op_or:
     case INDEX_op_setcond:
     case INDEX_op_xor:
         return has_type;
 
-    case INDEX_op_movcond_i32:
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld16u_i32:
@@ -2327,7 +2326,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond2_i32:
         return TCG_TARGET_REG_BITS == 32;
 
-    case INDEX_op_movcond_i64:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i64:
     case INDEX_op_ld16u_i64:
@@ -2879,10 +2877,9 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
             case INDEX_op_brcond:
             case INDEX_op_setcond:
             case INDEX_op_negsetcond:
-            case INDEX_op_movcond_i32:
+            case INDEX_op_movcond:
             case INDEX_op_brcond2_i32:
             case INDEX_op_setcond2_i32:
-            case INDEX_op_movcond_i64:
             case INDEX_op_cmp_vec:
             case INDEX_op_cmpsel_vec:
                 if (op->args[k] < ARRAY_SIZE(cond_name)
@@ -5076,8 +5073,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_brcond2_i32:
         op_cond = op->args[4];
         break;
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
+    case INDEX_op_movcond:
     case INDEX_op_setcond2_i32:
     case INDEX_op_cmpsel_vec:
         op_cond = op->args[5];
@@ -5501,8 +5497,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_movcond_i32:
-    case INDEX_op_movcond_i64:
+    case INDEX_op_movcond:
         {
             const TCGOutOpMovcond *out = &outop_movcond;
             TCGCond cond = new_args[5];
diff --git a/tcg/tci.c b/tcg/tci.c
index aef0023dc6..9c3f58242e 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -450,7 +450,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrrc(insn, &r0, &r1, &r2, &condition);
             regs[r0] = tci_compare64(regs[r1], regs[r2], condition);
             break;
-        case INDEX_op_movcond_i64:
+        case INDEX_op_movcond:
             tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &condition);
             tmp32 = tci_compare64(regs[r1], regs[r2], condition);
             regs[r0] = regs[tmp32 ? r3 : r4];
@@ -1075,7 +1075,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
         break;
 
     case INDEX_op_tci_movcond32:
-    case INDEX_op_movcond_i64:
+    case INDEX_op_movcond:
     case INDEX_op_setcond2_i32:
         tci_args_rrrrrc(insn, &r0, &r1, &r2, &r3, &r4, &c);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s, %s, %s",
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 18f02c5122..26dc3bad49 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -511,7 +511,7 @@ Conditional moves
        |
        | Set *dest* to -1 if (*t1* *cond* *t2*) is true, otherwise set to 0.
 
-   * - movcond_i32/i64 *dest*, *c1*, *c2*, *v1*, *v2*, *cond*
+   * - movcond *dest*, *c1*, *c2*, *v1*, *v2*, *cond*
 
      - | *dest* = (*c1* *cond* *c2* ? *v1* : *v2*)
        |
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 79f9219187..99a5744ab4 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -976,7 +976,7 @@ static void tgen_movcond(TCGContext *s, TCGType type, TCGCond cond,
 {
     TCGOpcode opc = (type == TCG_TYPE_I32
                      ? INDEX_op_tci_movcond32
-                     : INDEX_op_movcond_i64);
+                     : INDEX_op_movcond);
     tcg_out_op_rrrrrc(s, opc, ret, c1, c2, vt, vf, cond);
 }
 
-- 
2.43.0


