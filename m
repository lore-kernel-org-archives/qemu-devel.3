Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA52CC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RAC-0001hI-0q; Fri, 25 Apr 2025 18:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7V-0004a5-P8
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:06 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7R-0001JQ-HJ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:05 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-301a4d5156aso3711266a91.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618519; x=1746223319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhoJxZH+JaGkGJba1u4R8N/P5alM/UcNkGcFuGwtyCE=;
 b=F+G1c/1gdx5l/FiSTnNVg5wCHynlCoHYXaQjoXNWwGPLcf3ZAYzi1WoWiOGyX1LnUA
 5c1BZhQljSkBKUnaig0NYl7Ma/5/Wdm4BE7LzOgji0qO1GJ+QLxcSUjOpU9ieSVfnMzr
 AR00QsA+JjdddcQsqWyBknWloSP25zP3e+opZle/jz4eMoHdRR9IWTrrCJC5ubFHCuUg
 tXIu0TLNFikQLfob2EAMTyx5D5g1xJwUqn1S+/xuiCH3PCrbEyCF1ndJ8YIdW4hP63pI
 +ArFqPvSscBfeVqGhsgW+EugKFLJ24bQO4SmqiP84Wi2n+g1JYO91MIDa8aN1xvO4Fi7
 moBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618519; x=1746223319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhoJxZH+JaGkGJba1u4R8N/P5alM/UcNkGcFuGwtyCE=;
 b=aOYafZr/7rGPKJxBmGRS7/Sjsl90TiJcAaIWpZ1Hc+H1gsWKwhGGUNVBbV8eMsiD79
 8SvPF9jguXpd2HpGNi9FYsen0EYjSzk4Tm78xhCq/O78UdY4ULT+mqRUQeETWbH71gxz
 IrFNVrJRfxPEnS6icUbC2iILPkCxpwutFFhddyUmDiBj6hSf4qszKOa/0pkvV/X8wzhF
 8x0HL00j9i90lr1Dnfdqa+L1dMMl08PiOIlvKbCLZB8+opuBIq25HF+JE38dECEfwlJr
 q1u5/KM1ce2QJSeH/4e0Q36VlgApFDz8A7lX55OG2QcWjtVVEDhaHaKpewGAi8g2UyoB
 snsA==
X-Gm-Message-State: AOJu0YzxkOGJ6tFG6+duKG6t0gfFb3sDn2WZUtxEPGEE2rt3JhTttQyF
 kOvov1eP3ExGH06s1c7ov+XriZ4pMQBJL3s4FRmF/1nbpgOv2quPUESwb/3i9owDtI6V97fQVn8
 R
X-Gm-Gg: ASbGncvGWODlVfY8fIT3EQPraVFSSJ4YaYIUxa1py6AhqP0vEiEEkJK133yb82LiNJF
 tgIdTmn8/rHRAaE96STdXvToIq4rTE59ZEi7+38j4xA7f4t7AVMg7e0S0F/3ZbtJ4HCo0msP4bf
 8Pfd07BTdYPgoEWTAlUt5mXYkmeBXuJGz8inY2i4X2LU+nuavMkWsp4SzV9Y7fFSjYGISjjL6VC
 k2aanOrxfDqQ7Er8vKgOUYG6sdnwsCXm4DmdPflS27rdYS7r/9q2Wyp8N5aOXtIu8QVTcAvlx+k
 TQ7tZuQm7AVrHjYnqDD+lTMGyjNs95zPtLojIL+61oMCCWH4JCTO8ifNu0yBa3wOTGyf4BeWtqs
 =
X-Google-Smtp-Source: AGHT+IGtzDZ0db+QbfRDkPokVEYj8LOA+hlLmkkFD7UR1Cqzyetp3PXCtSGaFJJbmUprFF2B2IaZFw==
X-Received: by 2002:a17:90b:4e90:b0:309:e351:2e3d with SMTP id
 98e67ed59e1d1-309f7ddfe75mr7473089a91.12.1745618519475; 
 Fri, 25 Apr 2025 15:01:59 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:01:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 083/159] tcg: Merge INDEX_op_brcond_{i32,i64}
Date: Fri, 25 Apr 2025 14:53:37 -0700
Message-ID: <20250425215454.886111-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  4 +---
 tcg/optimize.c           |  6 +++---
 tcg/tcg-op.c             |  4 ++--
 tcg/tcg.c                | 24 ++++++++----------------
 tcg/tci.c                |  6 ++----
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  4 ++--
 7 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index f40bb5796a..d40ca001c2 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -34,6 +34,7 @@ DEF(set_label, 0, 0, 1, TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 DEF(call, 0, 0, 3, TCG_OPF_CALL_CLOBBER | TCG_OPF_NOT_PRESENT)
 
 DEF(br, 0, 0, 1, TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
+DEF(brcond, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH | TCG_OPF_INT)
 
 DEF(mb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 
@@ -89,8 +90,6 @@ DEF(extract_i32, 1, 1, 2, 0)
 DEF(sextract_i32, 1, 1, 2, 0)
 DEF(extract2_i32, 1, 2, 1, 0)
 
-DEF(brcond_i32, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
-
 DEF(add2_i32, 2, 4, 0, 0)
 DEF(sub2_i32, 2, 4, 0, 0)
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
@@ -124,7 +123,6 @@ DEF(extu_i32_i64, 1, 1, 0, 0)
 DEF(extrl_i64_i32, 1, 1, 0, 0)
 DEF(extrh_i64_i32, 1, 1, 0, 0)
 
-DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(bswap16_i64, 1, 1, 1, 0)
 DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index e53dbd4290..d0cb4588ed 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1529,14 +1529,14 @@ static bool fold_brcond2(OptContext *ctx, TCGOp *op)
         break;
 
     do_brcond_low:
-        op->opc = INDEX_op_brcond_i32;
+        op->opc = INDEX_op_brcond;
         op->args[1] = op->args[2];
         op->args[2] = cond;
         op->args[3] = label;
         return fold_brcond(ctx, op);
 
     do_brcond_high:
-        op->opc = INDEX_op_brcond_i32;
+        op->opc = INDEX_op_brcond;
         op->args[0] = op->args[1];
         op->args[1] = op->args[3];
         op->args[2] = cond;
@@ -2864,7 +2864,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_andc_vec:
             done = fold_andc(&ctx, op);
             break;
-        CASE_OP_32_64(brcond):
+        case INDEX_op_brcond:
             done = fold_brcond(&ctx, op);
             break;
         case INDEX_op_brcond2_i32:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 477dfc25b7..041ca95f0d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -529,7 +529,7 @@ void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
     if (cond == TCG_COND_ALWAYS) {
         tcg_gen_br(l);
     } else if (cond != TCG_COND_NEVER) {
-        TCGOp *op = tcg_gen_op4ii_i32(INDEX_op_brcond_i32,
+        TCGOp *op = tcg_gen_op4ii_i32(INDEX_op_brcond,
                                       arg1, arg2, cond, label_arg(l));
         add_as_label_use(l, op);
     }
@@ -1874,7 +1874,7 @@ void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
                                    TCGV_HIGH(arg1), TCGV_LOW(arg2),
                                    TCGV_HIGH(arg2), cond, label_arg(l));
         } else {
-            op = tcg_gen_op4ii_i64(INDEX_op_brcond_i64, arg1, arg2, cond,
+            op = tcg_gen_op4ii_i64(INDEX_op_brcond, arg1, arg2, cond,
                                    label_arg(l));
         }
         add_as_label_use(l, op);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index dbaa574cb5..4dc6995d00 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1048,8 +1048,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
-    OUTOP(INDEX_op_brcond_i32, TCGOutOpBrcond, outop_brcond),
-    OUTOP(INDEX_op_brcond_i64, TCGOutOpBrcond, outop_brcond),
+    OUTOP(INDEX_op_brcond, TCGOutOpBrcond, outop_brcond),
     OUTOP(INDEX_op_clz, TCGOutOpBinary, outop_clz),
     OUTOP(INDEX_op_ctpop, TCGOutOpUnary, outop_ctpop),
     OUTOP(INDEX_op_ctz, TCGOutOpBinary, outop_ctz),
@@ -2282,6 +2281,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_add:
     case INDEX_op_and:
+    case INDEX_op_brcond:
     case INDEX_op_mov:
     case INDEX_op_negsetcond:
     case INDEX_op_or:
@@ -2289,7 +2289,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_xor:
         return has_type;
 
-    case INDEX_op_brcond_i32:
     case INDEX_op_movcond_i32:
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8s_i32:
@@ -2319,7 +2318,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond2_i32:
         return TCG_TARGET_REG_BITS == 32;
 
-    case INDEX_op_brcond_i64:
     case INDEX_op_movcond_i64:
     case INDEX_op_ld8u_i64:
     case INDEX_op_ld8s_i64:
@@ -2869,13 +2867,12 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
                                                   op->args[k++]));
             }
             switch (c) {
-            case INDEX_op_brcond_i32:
+            case INDEX_op_brcond:
             case INDEX_op_setcond:
             case INDEX_op_negsetcond:
             case INDEX_op_movcond_i32:
             case INDEX_op_brcond2_i32:
             case INDEX_op_setcond2_i32:
-            case INDEX_op_brcond_i64:
             case INDEX_op_movcond_i64:
             case INDEX_op_cmp_vec:
             case INDEX_op_cmpsel_vec:
@@ -2961,8 +2958,7 @@ void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
             switch (c) {
             case INDEX_op_set_label:
             case INDEX_op_br:
-            case INDEX_op_brcond_i32:
-            case INDEX_op_brcond_i64:
+            case INDEX_op_brcond:
             case INDEX_op_brcond2_i32:
                 col += ne_fprintf(f, "%s$L%d", k ? "," : "",
                                   arg_label(op->args[k])->id);
@@ -3417,8 +3413,7 @@ void tcg_op_remove(TCGContext *s, TCGOp *op)
     case INDEX_op_br:
         remove_label_use(op, 0);
         break;
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
+    case INDEX_op_brcond:
         remove_label_use(op, 3);
         break;
     case INDEX_op_brcond2_i32:
@@ -3519,8 +3514,7 @@ static void move_label_uses(TCGLabel *to, TCGLabel *from)
         case INDEX_op_br:
             op->args[0] = label_arg(to);
             break;
-        case INDEX_op_brcond_i32:
-        case INDEX_op_brcond_i64:
+        case INDEX_op_brcond:
             op->args[3] = label_arg(to);
             break;
         case INDEX_op_brcond2_i32:
@@ -5068,8 +5062,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     o_allocated_regs = s->reserved_regs;
 
     switch (op->opc) {
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
+    case INDEX_op_brcond:
         op_cond = op->args[2];
         break;
     case INDEX_op_setcond:
@@ -5496,8 +5489,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
+    case INDEX_op_brcond:
         {
             const TCGOutOpBrcond *out = &outop_brcond;
             TCGCond cond = new_args[2];
diff --git a/tcg/tci.c b/tcg/tci.c
index d431cad6fd..4c5dc16ecb 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -664,8 +664,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
             regs[r0] = sextract32(regs[r1], pos, len);
             break;
-        case INDEX_op_brcond_i32:
-        case INDEX_op_brcond_i64:
+        case INDEX_op_brcond:
             tci_args_rl(insn, tb_ptr, &r0, &ptr);
             if (regs[r0]) {
                 tb_ptr = ptr;
@@ -959,8 +958,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
         info->fprintf_func(info->stream, "%-12s  %d, %p", op_name, len, ptr);
         break;
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
+    case INDEX_op_brcond:
         tci_args_rl(insn, tb_ptr, &r0, &ptr);
         info->fprintf_func(info->stream, "%-12s  %s, 0, ne, %p",
                            op_name, str_r(r0), ptr);
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index d3283265cd..18f02c5122 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -239,7 +239,7 @@ Jumps/Labels
 
      - | Jump to label.
 
-   * - brcond_i32/i64 *t0*, *t1*, *cond*, *label*
+   * - brcond *t0*, *t1*, *cond*, *label*
 
      - | Conditional jump if *t0* *cond* *t1* is true. *cond* can be:
        |
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 2c7fb5d75f..18628b957a 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -964,7 +964,7 @@ static void tgen_brcond(TCGContext *s, TCGType type, TCGCond cond,
                         TCGReg arg0, TCGReg arg1, TCGLabel *l)
 {
     tgen_setcond(s, type, cond, TCG_REG_TMP, arg0, arg1);
-    tcg_out_op_rl(s, INDEX_op_brcond_i32, TCG_REG_TMP, l);
+    tcg_out_op_rl(s, INDEX_op_brcond, TCG_REG_TMP, l);
 }
 
 static const TCGOutOpBrcond outop_brcond = {
@@ -1047,7 +1047,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_brcond2_i32:
         tcg_out_op_rrrrrc(s, INDEX_op_setcond2_i32, TCG_REG_TMP,
                           args[0], args[1], args[2], args[3], args[4]);
-        tcg_out_op_rl(s, INDEX_op_brcond_i32, TCG_REG_TMP, arg_label(args[5]));
+        tcg_out_op_rl(s, INDEX_op_brcond, TCG_REG_TMP, arg_label(args[5]));
         break;
 #endif
 
-- 
2.43.0


