Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E94C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R11-0007XU-GW; Fri, 25 Apr 2025 17:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0r-0007Mj-Ix
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:13 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0o-0000Wi-Hn
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:13 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso2849264b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618109; x=1746222909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prr4U/W4oLjzWazFRvQUaMzq44/5WGFUy6o4CLEaoxo=;
 b=xJD/PdiWar5J68vq0rDQdCtE/RyiatfsDTV61CV+OsKhUcB8CfPfPIjSg6W1aKw9ZY
 IZfB6A7uZpRQX5UcuQ0DPdqrYqH/aZQ7+fqhTKWOintVc1mARNHmklD0R6O3b59bBp3a
 c8/1ceXMqhWqcYQPWr/xKng5tv50rDPZk53jFgoGr/afgC8pAcbHcxJ7aORzCSWAQf4p
 FE+P26chpQtYL/DnHVUHi9BraUbV29ieUuJLypVbOWzKPU0eygKaim5USdPNJ15iBH0R
 eioF+mubqriQnBoauBLYu0TfuOr4G8M87uO7AEy6rcVkAlp3Vmrj20OqjlTUQPoMfVOv
 OlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618109; x=1746222909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=prr4U/W4oLjzWazFRvQUaMzq44/5WGFUy6o4CLEaoxo=;
 b=doXOibjmS2tOHnfvLnp7ILp7NhC5+fLEMoskK8vdgG8krEVOGK9t9WHZ3aS2WQsz5+
 pAZJpa5PYdw4QLXwdIbpJObUwYN0Y68svX2k7JknjW78W/MpHFeVSL+G/OaPIm/5vWW7
 40rdo66jmeI/Xd5xJWAJwF+beBRCsjaJWV6xbYDyfDRiAmUivy/ZmW/Mal74x/UnF/h4
 5DpILwyv0hxJbEkdDglt7LjisJicRge3h3arTdYY6cemxdI/pQ0QFlxcAOk2STIuuVbC
 mfPJM9EpOSuNJQEfp2V03a0t3iLTCFo2TP26U9DSBouyh793KATwTGdA1kjyUe1/2VLK
 Xayg==
X-Gm-Message-State: AOJu0Yyg/nNf6n9zHxwbx0nCmIPgkobp1ZJztokUMOVB6Z2yue4KtjJD
 Ur3ruCkgzuZTO8DE0Jp48a8hUa6qDgynYdkoaQwOid6nc71RusfOjg6O8CY7gROHp6WperbwolD
 X
X-Gm-Gg: ASbGncs+v5x3YD3ta+EapiRvkfsbicIKJLh11VRFEBD5FeWgrZ+xB4fGXGIsoNUZORk
 nauZVMvem50vPsvlAvBJDSI6UNpjLfrxuPA6hpVamg5LTo3sdv9u/zYK2q6Il18R7pZFU02de57
 2nckybIBub6SXcLbClk4q5A+w9fQX63ewGsjaMKaUuQL2Gh6V6OA25DplzPLbRj/o9OEwYCNqvx
 rMCFHEGlkeGsUbyimnIKHc9sG/DY0i3yVjoTAdnQyyLUfSWeFkZbIDwOA95QgIIGicVl11KGBL9
 SArfMBa7QefR61xvE3+aJzy9v+OT4UzXx0w98NYDlnBj+bTakOISugz+8GFJYh/hw8re9wAHwSg
 =
X-Google-Smtp-Source: AGHT+IFw8CnnLkDupBcHdDuCS8R87uesK4Xr4bfSyh/txXE1EOUH8JzrcOakJzSbNrendrA8qgOcaA==
X-Received: by 2002:a05:6a00:3984:b0:736:ab1d:83c4 with SMTP id
 d2e1a72fcca58-73fc7c4b0d9mr5377713b3a.0.1745618108729; 
 Fri, 25 Apr 2025 14:55:08 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:55:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 018/159] tcg: Merge INDEX_op_or_{i32,i64}
Date: Fri, 25 Apr 2025 14:52:32 -0700
Message-ID: <20250425215454.886111-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 include/tcg/tcg-opc.h    | 3 +--
 target/sh4/translate.c   | 4 ++--
 tcg/optimize.c           | 6 ++++--
 tcg/tcg-op.c             | 4 ++--
 tcg/tcg.c                | 9 +++------
 tcg/tci.c                | 5 ++---
 docs/devel/tcg-ops.rst   | 2 +-
 tcg/tci/tcg-target.c.inc | 2 +-
 8 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 9bc511992d..95608d6d31 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -42,6 +42,7 @@ DEF(mov, 1, 1, 0, TCG_OPF_INT | TCG_OPF_NOT_PRESENT)
 DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
+DEF(or, 1, 2, 0, TCG_OPF_INT)
 
 DEF(setcond_i32, 1, 2, 1, 0)
 DEF(negsetcond_i32, 1, 2, 1, 0)
@@ -64,7 +65,6 @@ DEF(rem_i32, 1, 2, 0, 0)
 DEF(remu_i32, 1, 2, 0, 0)
 DEF(div2_i32, 2, 3, 0, 0)
 DEF(divu2_i32, 2, 3, 0, 0)
-DEF(or_i32, 1, 2, 0, 0)
 DEF(xor_i32, 1, 2, 0, 0)
 /* shifts/rotates */
 DEF(shl_i32, 1, 2, 0, 0)
@@ -124,7 +124,6 @@ DEF(rem_i64, 1, 2, 0, 0)
 DEF(remu_i64, 1, 2, 0, 0)
 DEF(div2_i64, 2, 3, 0, 0)
 DEF(divu2_i64, 2, 3, 0, 0)
-DEF(or_i64, 1, 2, 0, 0)
 DEF(xor_i64, 1, 2, 0, 0)
 /* shifts/rotates */
 DEF(shl_i64, 1, 2, 0, 0)
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 3d0eda2128..094613d312 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1949,7 +1949,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         op_opc = INDEX_op_xor_i32;
         goto do_reg_op;
     case 0x200b: /* or Rm,Rn */
-        op_opc = INDEX_op_or_i32;
+        op_opc = INDEX_op_or;
     do_reg_op:
         /* The operation register should be as expected, and the
            other input cannot depend on the load.  */
@@ -2119,7 +2119,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         }
         break;
 
-    case INDEX_op_or_i32:
+    case INDEX_op_or:
         if (op_dst != st_src) {
             goto fail;
         }
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 875d80c254..7d5f7af223 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -437,7 +437,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_and_vec:
         return x & y;
 
-    CASE_OP_32_64_VEC(or):
+    case INDEX_op_or:
+    case INDEX_op_or_vec:
         return x | y;
 
     CASE_OP_32_64_VEC(xor):
@@ -2961,7 +2962,8 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64_VEC(not):
             done = fold_not(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(or):
+        case INDEX_op_or:
+        case INDEX_op_or_vec:
             done = fold_or(&ctx, op);
             break;
         CASE_OP_32_64_VEC(orc):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index d87bd13375..6807f4eebd 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -436,7 +436,7 @@ void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_or_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_or, ret, arg1, arg2);
 }
 
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -1585,7 +1585,7 @@ void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_or_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_or, ret, arg1, arg2);
     } else {
         tcg_gen_or_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_or_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 7357b5c127..f31ae4e56b 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1007,8 +1007,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
-    OUTOP(INDEX_op_or_i32, TCGOutOpBinary, outop_or),
-    OUTOP(INDEX_op_or_i64, TCGOutOpBinary, outop_or),
+    OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
 };
 
 #undef OUTOP
@@ -2212,6 +2211,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_mov:
+    case INDEX_op_or:
         return has_type;
 
     case INDEX_op_setcond_i32:
@@ -2228,7 +2228,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i32:
     case INDEX_op_neg_i32:
     case INDEX_op_mul_i32:
-    case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
@@ -2308,7 +2307,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i64:
     case INDEX_op_neg_i64:
     case INDEX_op_mul_i64:
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
@@ -5443,8 +5441,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
+    case INDEX_op_or:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index e4a0408fec..3e361be6bd 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -539,7 +539,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] & regs[r2];
             break;
-        CASE_32_64(or)
+        case INDEX_op_or:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] | regs[r2];
             break;
@@ -1083,12 +1083,11 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
+    case INDEX_op_or:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
     case INDEX_op_orc_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 116a0438b1..8d67b0cdeb 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -307,7 +307,7 @@ Logical
 
      - | *t0* = *t1* & *t2*
 
-   * - or_i32/i64 *t0*, *t1*, *t2*
+   * - or *t0*, *t1*, *t2*
 
      - | *t0* = *t1* | *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 6fdfcab061..4214b76b34 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -669,7 +669,7 @@ static const TCGOutOpBinary outop_andc = {
 static void tgen_or(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_or_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_or, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_or = {
-- 
2.43.0


