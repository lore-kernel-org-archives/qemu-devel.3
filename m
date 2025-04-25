Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4100C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R5i-0006Ia-1J; Fri, 25 Apr 2025 18:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4T-0002Fi-F8
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:57 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4Q-0000tB-Tn
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:57 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so43063605ad.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618333; x=1746223133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JWutsX7iLV8juzFBHNtvOxslwzMj0X1yk7UswwWhxQc=;
 b=hZv254WLh7G4nQEOrUriAZqZ6mUyLDaSBz/gx35L8cpv40XaMg1SKdV7JWKKTIHTv3
 p7B3/wYSRgN2TjyeI6dxKFa1xVjwjntJ2WtUwZcjPfcsDzfoaqTGV6N/bov00DdQ2wvW
 J+sJf9DbAP1fhKGk03mgxVQZirxIk8xiAE5K+mkfuNExVqJiq8dDfkoptRegamMMY4nQ
 J0lBFKhddvrCBI59Lfg8BO1cgqYoVP0c/kzmHolQcg5gI/ILjb6bv7mGsEzmKEvRqZLM
 XmSm5DVOntmbw1vPtGEx9Wv+m7ggui9UEip/h5rkg3PPBunP4IrO24cdHnru4aCDhfza
 D0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618333; x=1746223133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JWutsX7iLV8juzFBHNtvOxslwzMj0X1yk7UswwWhxQc=;
 b=K2A8EepoFnXM8vYs3WlRv4pTQ+IDu7522Dn3P5eYH4inLyr0hjsT0x7OJOf8Q7PdYp
 el7xuuBwKEZAwtlus95TuR5E5yTuPQQqzx6uW3bT3/csE4m9yMkNgxv0ZlggtS8Et/ij
 3K+LSJh1FYENxEezjHzVe6uuaVNdljooHSUZ8Bb4FTFIrpSSEVwzplo3BDhR3hB5XqLd
 RXDFn1ncEL0JxUPezeNVd6wzz6oj/7KUYHMxEUDZBe7WuKWKNBF5UQdkoGo3B2vX+1YC
 B7TnaP+T80eVAgQTuwc8S2cwRMafzfXJjiyfaJD5J89Iv+/3vxI99UbkKth7TFQ1IakB
 u9bA==
X-Gm-Message-State: AOJu0YwChvRoI93cTaeUoUlYlSC4k5RImuvkgkefu39FiTfKJa8jPRD8
 YuUMqGkOg+l0XFLPpDnErITe6CkccMV9Zq24Xzzz8Cs2gG7ulFEJ1uD0NUsf0x4PzRj64Fv8/kb
 v
X-Gm-Gg: ASbGnctexlzEMV039xmAYH+nYgrJd36g+he9z7w5tFrJHNJ6xX6rFU4/AB5zjCRwb1J
 aHymX9FPYil3hZevFTzyzF2Uc8dOKW3lLs6iGcezEsRrj8nWmaJ+w6COXhOhm5HTJtbsp3vdphv
 pqC1lxmlZ5D1+aOmOGSHbYyNG6Z8g02oDHgn9ID1pFeWSldwBW2M9DbzCFVV1tdtNTCfh/Uvh2L
 SDrqUefEMUBU/pqaZbFOs/ETKnoCnzpHHr43XTpcu9iTKFKw+TUGLfRfwTDyLjaojROu8aC43tz
 l6FjAB7n0Q+6HfAg0RDqfrolVFyGMPowd2VYXIDmLV+w7fC1Ep1+OtxafxX57l+WaoaVZy2Hi2I
 =
X-Google-Smtp-Source: AGHT+IEH+lMN6Bf0NaTRaD83sYoF+PeMwlcuUGm4ayWz4FH6wAdLjHzd0mfbPcA8Et2dgbtRYh0M0Q==
X-Received: by 2002:a17:902:ecc2:b0:220:e9ef:ec98 with SMTP id
 d9443c01a7336-22dbf5ef3dbmr58858475ad.19.1745618333227; 
 Fri, 25 Apr 2025 14:58:53 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm37749595ad.17.2025.04.25.14.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:58:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 075/159] tcg: Merge INDEX_op_mulu2_{i32,i64}
Date: Fri, 25 Apr 2025 14:53:29 -0700
Message-ID: <20250425215454.886111-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 tcg/optimize.c           | 17 +++++++++--------
 tcg/tcg-op.c             | 10 +++++-----
 tcg/tcg.c                |  9 +++------
 tcg/tci.c                |  6 ++----
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  3 +--
 7 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index a45b22ca1a..287bdf3473 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -53,6 +53,7 @@ DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
 DEF(muls2, 2, 2, 0, TCG_OPF_INT)
 DEF(mulsh, 1, 2, 0, TCG_OPF_INT)
+DEF(mulu2, 2, 2, 0, TCG_OPF_INT)
 DEF(muluh, 1, 2, 0, TCG_OPF_INT)
 DEF(nand, 1, 2, 0, TCG_OPF_INT)
 DEF(neg, 1, 1, 0, TCG_OPF_INT)
@@ -92,7 +93,6 @@ DEF(brcond_i32, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 
 DEF(add2_i32, 2, 4, 0, 0)
 DEF(sub2_i32, 2, 4, 0, 0)
-DEF(mulu2_i32, 2, 2, 0, 0)
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
 
@@ -133,7 +133,6 @@ DEF(bswap64_i64, 1, 1, 1, 0)
 
 DEF(add2_i64, 2, 4, 0, 0)
 DEF(sub2_i64, 2, 4, 0, 0)
-DEF(mulu2_i64, 2, 2, 0, 0)
 
 #define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
 
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 756f681e88..14d943cf97 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2069,13 +2069,14 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
         TCGOp *op2;
 
         switch (op->opc) {
-        case INDEX_op_mulu2_i32:
-            l = (uint64_t)(uint32_t)a * (uint32_t)b;
-            h = (int32_t)(l >> 32);
-            l = (int32_t)l;
-            break;
-        case INDEX_op_mulu2_i64:
-            mulu64(&l, &h, a, b);
+        case INDEX_op_mulu2:
+            if (ctx->type == TCG_TYPE_I32) {
+                l = (uint64_t)(uint32_t)a * (uint32_t)b;
+                h = (int32_t)(l >> 32);
+                l = (int32_t)l;
+            } else {
+                mulu64(&l, &h, a, b);
+            }
             break;
         case INDEX_op_muls2:
             if (ctx->type == TCG_TYPE_I32) {
@@ -2975,7 +2976,7 @@ void tcg_optimize(TCGContext *s)
             done = fold_mul_highpart(&ctx, op);
             break;
         case INDEX_op_muls2:
-        CASE_OP_32_64(mulu2):
+        case INDEX_op_mulu2:
             done = fold_multiply2(&ctx, op);
             break;
         case INDEX_op_nand:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a4d976242a..22af3b12bc 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1138,8 +1138,8 @@ void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
 
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_mulu2_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op4_i32(INDEX_op_mulu2_i32, rl, rh, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I32, 0)) {
+        tcg_gen_op4_i32(INDEX_op_mulu2, rl, rh, arg1, arg2);
     } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I32, 0)) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
@@ -2861,8 +2861,8 @@ void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
 
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (tcg_op_supported(INDEX_op_mulu2_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op4_i64(INDEX_op_mulu2_i64, rl, rh, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0)) {
+        tcg_gen_op4_i64(INDEX_op_mulu2, rl, rh, arg1, arg2);
     } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
         tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
@@ -2888,7 +2888,7 @@ void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op3_i64(INDEX_op_mulsh, rh, arg1, arg2);
         tcg_gen_mov_i64(rl, t);
         tcg_temp_free_i64(t);
-    } else if (tcg_op_supported(INDEX_op_mulu2_i64, TCG_TYPE_I64, 0) ||
+    } else if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0) ||
                tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d38b55d04f..685408f0f9 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1043,8 +1043,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_muls2, TCGOutOpMul2, outop_muls2),
     OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
-    OUTOP(INDEX_op_mulu2_i32, TCGOutOpMul2, outop_mulu2),
-    OUTOP(INDEX_op_mulu2_i64, TCGOutOpMul2, outop_mulu2),
+    OUTOP(INDEX_op_mulu2, TCGOutOpMul2, outop_mulu2),
     OUTOP(INDEX_op_muluh, TCGOutOpBinary, outop_muluh),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
     OUTOP(INDEX_op_neg, TCGOutOpUnary, outop_neg),
@@ -4009,8 +4008,7 @@ liveness_pass_1(TCGContext *s)
             opc_new = INDEX_op_mul;
             opc_new2 = INDEX_op_mulsh;
             goto do_mul2;
-        case INDEX_op_mulu2_i32:
-        case INDEX_op_mulu2_i64:
+        case INDEX_op_mulu2:
             opc_new = INDEX_op_mul;
             opc_new2 = INDEX_op_muluh;
         do_mul2:
@@ -5474,8 +5472,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     case INDEX_op_muls2:
-    case INDEX_op_mulu2_i32:
-    case INDEX_op_mulu2_i64:
+    case INDEX_op_mulu2:
         {
             const TCGOutOpMul2 *out =
                 container_of(all_outop[op->opc], TCGOutOpMul2, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 5c8c62c0ef..569b5c7ed0 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -590,8 +590,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             muls64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
 #endif
             break;
-        case INDEX_op_mulu2_i32:
-        case INDEX_op_mulu2_i64:
+        case INDEX_op_mulu2:
             tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
 #if TCG_TARGET_REG_BITS == 32
             tmp64 = (uint64_t)(uint32_t)regs[r2] * (uint32_t)regs[r3];
@@ -1092,8 +1091,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
         break;
 
     case INDEX_op_muls2:
-    case INDEX_op_mulu2_i32:
-    case INDEX_op_mulu2_i64:
+    case INDEX_op_mulu2:
         tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s",
                            op_name, str_r(r0), str_r(r1),
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 0394767291..592e002971 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -599,7 +599,7 @@ Multiword arithmetic support
          formed from two single-word arguments, and the double-word output *t0*
          is returned in two single-word outputs.
 
-   * - mulu2_i32/i64 *t0_low*, *t0_high*, *t1*, *t2*
+   * - mulu2 *t0_low*, *t0_high*, *t1*, *t2*
 
      - | Similar to mul, except two unsigned inputs *t1* and *t2* yielding the full
          double-word product *t0*. The latter is returned in two single-word outputs.
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 4bce206f80..563529e055 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -728,8 +728,7 @@ static const TCGOutOpBinary outop_mulsh = {
 static void tgen_mulu2(TCGContext *s, TCGType type,
                        TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3)
 {
-    tcg_out_op_rrrr(s, glue(INDEX_op_mulu2_i,TCG_TARGET_REG_BITS),
-                    a0, a1, a2, a3);
+    tcg_out_op_rrrr(s, INDEX_op_mulu2, a0, a1, a2, a3);
 }
 
 static const TCGOutOpMul2 outop_mulu2 = {
-- 
2.43.0


