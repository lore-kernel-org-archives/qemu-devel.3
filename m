Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F0AC369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lvt-0001B6-FW; Tue, 15 Apr 2025 15:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lv1-0000Bh-Ls
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:26:09 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lun-00084D-Il
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:53 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so1135127b3a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745145; x=1745349945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ezklAt8CsY+CSud3ZgZCwa5zFOeTFoTjcD7qbGhmWBA=;
 b=gh2JBcWZ7tkDcZuhrO5Kz3M279jh0u1VMMNGD2XBMDbhqntruUHsxTACol7a8aZ+rA
 L7VKbzej22GcGRtU7lc+risCUnQZWG6LV6A8GEZ5lNOneVwiXXaowxPn1WuoDcJIwZs9
 4yxwodGOKVRNQkhaTXY+JI2gMsuN8pNMHLGIp/eVU5dYZkuLTsNHVUSNOr7sN/idqrZd
 1IZfwwkgOIAKRMz5bYHwsbXv1iOkrw1i06JWpo7StXF/jvEkQmMpcV4M3VbTAJnweupn
 rHH1lxaeUKAOD2Qf+AtTjBIs1Tmy0iyroSGWq7PYl+wXDp8ZyNfveLBtI7EZGPJdP+5l
 ngcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745145; x=1745349945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ezklAt8CsY+CSud3ZgZCwa5zFOeTFoTjcD7qbGhmWBA=;
 b=krdmX3p/6HBITSN/l4AmjT2eGAcYB/LEdBdM3e6W64vp44XSScns0Z7PVkNxi7KaJz
 qBHxjMax3rcwNns1Fs3QA5DSv7hzXZNOJCgHBGgua/5ym5CLeeLQScWA/vFBlw9Cy1xX
 7nJjfj2JJ81lXxILH9jRCdT2EWsPNwX6F1/ZBicVTiqPVjXSDifUMH5WYi3WZ9sLpfgL
 21UFqXe5B6jEKkQT3+NvlWeIixVYqoavJti9W0xTD5TXpB2yMjNsBRCQzN8UYU0rSPiN
 1ePGMWmNK6r0/fA5zRO9ilTKg9fB/RoV4jun0/mLzZXuXthY2UiDlEnSd6D2tTECgg4U
 twUg==
X-Gm-Message-State: AOJu0YwjW29g6CJGrO488iXUmtlAy/2fvbG4mSjJbV1Zum0M9pRnzeKH
 Sx8JjC9t2T5xnYTYGrHgkTmgFarf3BJmvJp9ynpmYWYRZciuXsAE0Vh9jJJqiYojT8fAmgZ9PJT
 V
X-Gm-Gg: ASbGncvPc1d+cWaLxofepKfA9t0bHCy7dM6BXiPJrDDNNaLOHjKkLnGR0i9wil5571K
 5eAGpVbzDnIoeSUZPzurf9RZ5nL8paG7TL7Bv5Tw99w8/T976y4Zow2qesP3+CuJLbltPEadLrS
 F+mDqKjaivLLxvVbbpZdjvYJrraEmu3dbgtxkI3gt/W7Pkh9586qUl2s3EsgGrhcwtvNfaOmt/b
 vBW7JRqwoC1rwnTOGrFT9zN9DG47CANPonWupDmtWGY0jC+JeHb85N9gjpnWDjr21iNv5CUjktj
 3vF+uoEcGDmBbcWlJ+n5TDbR+a1sedHrdZHiT6A5MmiV7+qAMTZPFoAu0LuKVEtRiF2neYYS7Z8
 =
X-Google-Smtp-Source: AGHT+IGeknvy2isf3N+kyS4gIXPechX5wqnBkxD4hMwQAd0MlgcspU9ME9P/8MBTQYyFDlHrXpIedw==
X-Received: by 2002:a05:6a00:181c:b0:736:ab49:a6e4 with SMTP id
 d2e1a72fcca58-73c1f8c6c74mr799109b3a.1.1744745144916; 
 Tue, 15 Apr 2025 12:25:44 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 032/163] tcg: Merge INDEX_op_neg_{i32,i64}
Date: Tue, 15 Apr 2025 12:23:03 -0700
Message-ID: <20250415192515.232910-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  3 +--
 tcg/optimize.c           | 30 ++++++------------------------
 tcg/tcg-op.c             |  4 ++--
 tcg/tcg.c                |  6 ++----
 tcg/tci.c                | 11 +++++------
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 18 insertions(+), 40 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 1be9b01caf..13b7650cec 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -44,6 +44,7 @@ DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(nand, 1, 2, 0, TCG_OPF_INT)
+DEF(neg, 1, 1, 0, TCG_OPF_INT)
 DEF(nor, 1, 2, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
@@ -95,7 +96,6 @@ DEF(setcond2_i32, 1, 4, 1, 0)
 DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
 DEF(not_i32, 1, 1, 0, 0)
-DEF(neg_i32, 1, 1, 0, 0)
 DEF(clz_i32, 1, 2, 0, 0)
 DEF(ctz_i32, 1, 2, 0, 0)
 DEF(ctpop_i32, 1, 1, 0, 0)
@@ -145,7 +145,6 @@ DEF(bswap16_i64, 1, 1, 1, 0)
 DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
 DEF(not_i64, 1, 1, 0, 0)
-DEF(neg_i64, 1, 1, 0, 0)
 DEF(clz_i64, 1, 2, 0, 0)
 DEF(ctz_i64, 1, 2, 0, 0)
 DEF(ctpop_i64, 1, 1, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 8927b1256c..d3fa21eead 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -466,7 +466,7 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     CASE_OP_32_64_VEC(not):
         return ~x;
 
-    CASE_OP_32_64(neg):
+    case INDEX_op_neg:
         return -x;
 
     case INDEX_op_andc:
@@ -2302,25 +2302,12 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
             break;
         }
         if (convert) {
-            TCGOpcode neg_opc;
-
             if (!inv && !neg) {
                 return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
             }
 
-            switch (ctx->type) {
-            case TCG_TYPE_I32:
-                neg_opc = INDEX_op_neg_i32;
-                break;
-            case TCG_TYPE_I64:
-                neg_opc = INDEX_op_neg_i64;
-                break;
-            default:
-                g_assert_not_reached();
-            }
-
             if (!inv) {
-                op->opc = neg_opc;
+                op->opc = INDEX_op_neg;
             } else if (neg) {
                 op->opc = INDEX_op_add;
                 op->args[2] = arg_new_constant(ctx, -1);
@@ -2336,7 +2323,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
-    TCGOpcode neg_opc, shr_opc;
+    TCGOpcode shr_opc;
     TCGOpcode uext_opc = 0, sext_opc = 0;
     TCGCond cond = op->args[3];
     TCGArg ret, src1, src2;
@@ -2359,7 +2346,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
     switch (ctx->type) {
     case TCG_TYPE_I32:
         shr_opc = INDEX_op_shr_i32;
-        neg_opc = INDEX_op_neg_i32;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I32, sh, 1)) {
             uext_opc = INDEX_op_extract_i32;
         }
@@ -2369,7 +2355,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         break;
     case TCG_TYPE_I64:
         shr_opc = INDEX_op_shr_i64;
-        neg_opc = INDEX_op_neg_i64;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I64, sh, 1)) {
             uext_opc = INDEX_op_extract_i64;
         }
@@ -2420,7 +2405,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         op2->args[1] = ret;
         op2->args[2] = arg_new_constant(ctx, 1);
     } else if (neg) {
-        op2 = tcg_op_insert_after(ctx->tcg, op, neg_opc, 2);
+        op2 = tcg_op_insert_after(ctx->tcg, op, INDEX_op_neg, 2);
         op2->args[0] = ret;
         op2->args[1] = ret;
     }
@@ -2632,11 +2617,8 @@ static bool fold_sub_to_neg(OptContext *ctx, TCGOp *op)
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
-        neg_op = INDEX_op_neg_i32;
-        have_neg = true;
-        break;
     case TCG_TYPE_I64:
-        neg_op = INDEX_op_neg_i64;
+        neg_op = INDEX_op_neg;
         have_neg = true;
         break;
     case TCG_TYPE_V64:
@@ -2986,7 +2968,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_nand_vec:
             done = fold_nand(&ctx, op);
             break;
-        CASE_OP_32_64(neg):
+        case INDEX_op_neg:
             done = fold_neg(&ctx, op);
             break;
         case INDEX_op_nor:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 15faf4dc57..cb2eb9ae52 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -396,7 +396,7 @@ void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    tcg_gen_op2_i32(INDEX_op_neg_i32, ret, arg);
+    tcg_gen_op2_i32(INDEX_op_neg, ret, arg);
 }
 
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
@@ -1691,7 +1691,7 @@ void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op2_i64(INDEX_op_neg_i64, ret, arg);
+        tcg_gen_op2_i64(INDEX_op_neg, ret, arg);
     } else {
         TCGv_i32 zero = tcg_constant_i32(0);
         tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret),
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 8e1bc82758..6af8c61418 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1022,8 +1022,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
-    OUTOP(INDEX_op_neg_i32, TCGOutOpUnary, outop_neg),
-    OUTOP(INDEX_op_neg_i64, TCGOutOpUnary, outop_neg),
+    OUTOP(INDEX_op_neg, TCGOutOpUnary, outop_neg),
     OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
@@ -5473,8 +5472,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
+    case INDEX_op_neg:
         {
             const TCGOutOpUnary *out =
                 container_of(all_outop[op->opc], TCGOutOpUnary, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 508d1405cd..c736691e9f 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -567,6 +567,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] | regs[r2]);
             break;
+        case INDEX_op_neg:
+            tci_args_rr(insn, &r0, &r1);
+            regs[r0] = -regs[r1];
+            break;
 
             /* Arithmetic operations (32 bit). */
 
@@ -697,10 +701,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = ~regs[r1];
             break;
 #endif
-        CASE_32_64(neg)
-            tci_args_rr(insn, &r0, &r1);
-            regs[r0] = -regs[r1];
-            break;
 #if TCG_TARGET_REG_BITS == 64
             /* Load/store operations (64 bit). */
 
@@ -1054,6 +1054,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
         break;
 
     case INDEX_op_mov:
+    case INDEX_op_neg:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_bswap16_i32:
@@ -1063,8 +1064,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_bswap64_i64:
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
-    case INDEX_op_neg_i32:
-    case INDEX_op_neg_i64:
     case INDEX_op_ctpop_i32:
     case INDEX_op_ctpop_i64:
         tci_args_rr(insn, &r0, &r1);
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 96b7f05919..fb51691538 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -269,7 +269,7 @@ Arithmetic
 
      - | *t0* = *t1* - *t2*
 
-   * - neg_i32/i64 *t0*, *t1*
+   * - neg *t0*, *t1*
 
      - | *t0* = -*t1* (two's complement)
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 200b256e73..c42f9dff11 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -731,7 +731,7 @@ static const TCGOutOpBinary outop_xor = {
 
 static void tgen_neg(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
 {
-    tcg_out_op_rr(s, glue(INDEX_op_neg_i,TCG_TARGET_REG_BITS), a0, a1);
+    tcg_out_op_rr(s, INDEX_op_neg, a0, a1);
 }
 
 static const TCGOutOpUnary outop_neg = {
-- 
2.43.0


