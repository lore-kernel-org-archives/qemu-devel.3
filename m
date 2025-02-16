Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78371C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnsA-0008EA-BR; Sun, 16 Feb 2025 18:16:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnqU-0001TG-G3
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:42 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnqC-0005Tx-ML
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:30 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-219f8263ae0so65603365ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747651; x=1740352451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zjr47jjo6eyQHE8MMlRZoOKTBqPiSi2lpcgcXHvWhhQ=;
 b=mck4jTQdMkNEoWrpM7ppBlcbpRDT9v3T5kz2P74W6JYq+1wZmju75Tp/R9xV5ytOmS
 KZIwP+m53D94CAzSd3DUWsmr6roTXfrO7GjF4HMT3Q3eq/C6+cteKePs6vqztjWxjYRX
 myTD4fcDWbzQwHL4Juqoq5ns2o+t+8G9irdMngVDIWQVy40FmFBxiPEEgH6xDVDVijTR
 Zcmj5XQrOlE5UCNN0jNHdwYLp3WvP/p2ed04VSuOwSPWRgFkH9AAnDAleyiYAgR9AG9r
 Ljkd8iDfP5kDDNzLFZlpbxneTCfhbcRW85UhX9Zd1132p56x51ZR1D2Dpf2vs90mfiUF
 Nu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747651; x=1740352451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zjr47jjo6eyQHE8MMlRZoOKTBqPiSi2lpcgcXHvWhhQ=;
 b=iJfXpRzoT/QaJM45lLQW1y1tBg0JQZQxgfJQVhy2iv7azLsjd6yGJohgBQS4xuxoPP
 Oc7saOKRlYXVk9Kk6zYXuRBI8PMUa8+1N6so3OPiDfNORrX66nOXdepBe8Lc+0QCSaOQ
 pXMi0FDJvzgOTOm6bilVQDQ06j1oUGNqPoyWQkqCbhnhqNi8Z5whcgeBj7L1yk/4fELx
 b/HRmYeC+iHimlbPSVGbi8+rECHQgYSYsUULqVv5XglDRhN2ayywsXCiSG2Ih4yc+5Wt
 PfwGgBoqureI9XOGnfG2IKYXzllI3PIgP5JirVJ00WLw84UqwT0KtwkSateaTYFY2k1O
 y1KQ==
X-Gm-Message-State: AOJu0YwAQUgFAXnMMYzKDzts/nvsUs9flwoCe6JpOJSVEUiWpjGSzSBN
 fn1o+qWbkLJTU71I42mUe0Z+PqYfbizjbgTztPvODqk15KPRIRSFvait45PxIfjiOaU0WnwqWhm
 B
X-Gm-Gg: ASbGncuv7Ao72JRUNUJKexrHZ8/idKL/TU7iYErDWTZ1kkVaEx7XTbjznSsgQHbnXCo
 3P0OO7Gb/Ptezr5YULtsfuADJKivw/xaMG4WOy1pR2a6YDHEZMcT6RgyxqFlMi4lDHVME96RAp0
 Ldjg0MaDhkV+l9ic0kyKDpM6XomlELAuDetJ3EU8bZdSZObltPPmloNfnd19eUCZnRXAzXBtI0z
 OK9+Mwa6/P/UI1xw+aS9wSMTwcOLbvXKR39LkfBBhmMRLYFOcIQfGpiBOoWqZT/9IL5rOrUDBKX
 008S/DhaLpKv1L3oYTrz1SWx2CEpYzZp5clvrHzZwQ8IKFQ=
X-Google-Smtp-Source: AGHT+IH/jh8p81pKz7sJNcPP3di6pO9t8/flI+0ac/7gHEemVCy9fpEV2SvAskJBDXDZciHLyvfsmQ==
X-Received: by 2002:a17:902:e74a:b0:220:cd9f:a180 with SMTP id
 d9443c01a7336-221040eb9fdmr112206765ad.53.1739747651612; 
 Sun, 16 Feb 2025 15:14:11 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.14.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:14:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 078/162] tcg: Merge INDEX_op_brcond_{i32,i64}
Date: Sun, 16 Feb 2025 15:08:47 -0800
Message-ID: <20250216231012.2808572-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
index 4b78b0ba82..9e6a2e3ec1 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1517,14 +1517,14 @@ static bool fold_brcond2(OptContext *ctx, TCGOp *op)
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
@@ -2852,7 +2852,7 @@ void tcg_optimize(TCGContext *s)
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
index d7016d393f..1c6490891f 100644
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
@@ -5062,8 +5056,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     o_allocated_regs = s->reserved_regs;
 
     switch (op->opc) {
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
+    case INDEX_op_brcond:
         op_cond = op->args[2];
         break;
     case INDEX_op_setcond:
@@ -5484,8 +5477,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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


