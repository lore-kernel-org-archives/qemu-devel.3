Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D38C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnmX-0005ZY-Ha; Sun, 16 Feb 2025 18:10:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmN-0005Vt-L1
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:28 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmL-0005De-9X
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:26 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220c92c857aso58778805ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747424; x=1740352224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+j2BOFAT6JxfMOdy5UOOdQseV+XeqxwfwDPQn9Ww+A=;
 b=z2YLGRYQ8g2/YpiiFswxLXaSGIyOAUEOmjddoboKYNH04c4VxGXRRmHG9QU8FPr6D9
 jVby0ebe7FsNAo++jvUzB2OtDXjNczcNxOGA/QD6xvvxcvDzmsABXf1XRvsgWBqXHzJZ
 jhaiurtDw9XQ+Z89ZPnuWgiFIR/ZQHFgtKDXy6C9wOQuZQaLPlE6yyFoVl/cufOVn1My
 nR36JpK8447Fbnd4UDNiYTtJ4AN0grwoM8ss4cTQhJ2I1QqyKkJppW+wNaLO3B633/fO
 RrMxngFnPl90U/IXzlFppLN6hRR2o5UYcT+/g6SPLjiOcU9d+w8kCGjYL19USYpqxuRG
 9lWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747424; x=1740352224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+j2BOFAT6JxfMOdy5UOOdQseV+XeqxwfwDPQn9Ww+A=;
 b=nJSvUbBf0hwDfLDI2iJbR/MzhZqRdxbbesdfzI0gmH736dVnH9fZz2ybuA8qn7yRIr
 LP6qSl7Z77ZEpmXoEe/o8lA5lLKdT61PXn9L9guruCLDnRpERBbEXmFDw6prxT2q2zMG
 YRaYNZ+SgI7uBOsPA5ucsPKAYqoA+rfYsSExxk0hZot3qmpMKjU+Kt7Z+tvISjYWzeKz
 UIQR5Fbc44AcHVUHxeiWSLGGh2GPR4hfCsnIihO0xYmPwwpiT1mEfcC90m+O7DjVub7W
 ZVOp4Y24aDHll5EzWLWBZSaeYhleQNaLMfGZQBzuwkZTn0mozNTQIwKTyHN6AUc4+srK
 FGYQ==
X-Gm-Message-State: AOJu0YzvboJqwFhUBxUG+ie7GIGKVdo3aE4ujljae94GJFhFcVFKVaGv
 3/jylaQgqYV+hzwyzWLxBMN1HcNG2S/y2oBPEK0WhF2B2ftza4bZZAHGj5RJWtj24IY6EvzWDiD
 H
X-Gm-Gg: ASbGncsvhVVte4HJzcHZVxPq1ak15dw8dV8f01Dbj1gopQAPHvXHZ3LmL/QdmyxAred
 d7wjiilnCRIFkA10C/7xBPuNbLPslJZhSEpKmFHxvGioSHErpb7r54qFISP4w/4cnXVXm+Ec69D
 g6pKULK76AvZUA/TKkxiR+PsBQY6XT4F7qaQz5CizFpIYDkUc/u1Bt2lGQeNIxtrNrp/dR56gTn
 1+dbKaSNfzU+sHe/dDxpOV4qBujra/f09fKV1XyeQ3JZBf3XV5t8QL9X7/rqVIxo0jlA0R3Dhyj
 7mWjvOylkt1Tof9+4/TPBuT3oy9eQym6fuIWfYN9DMEjjj4=
X-Google-Smtp-Source: AGHT+IHWY6Qtts9bMMx13obJ0UUqLYmr0qGrvlvOwmrY3121P7+UxESkSfGv1AO82+vvomUViKgjyQ==
X-Received: by 2002:a17:902:ccd1:b0:21f:97c3:f885 with SMTP id
 d9443c01a7336-220d357a8d2mr265750425ad.18.1739747423757; 
 Sun, 16 Feb 2025 15:10:23 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 013/162] tcg: Merge INDEX_op_or_{i32,i64}
Date: Sun, 16 Feb 2025 15:07:42 -0800
Message-ID: <20250216231012.2808572-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
index acc6b92f18..17e09f3d2a 100644
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
index 6dfc1da1b6..d388c2b9ae 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -425,7 +425,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_and_vec:
         return x & y;
 
-    CASE_OP_32_64_VEC(or):
+    case INDEX_op_or:
+    case INDEX_op_or_vec:
         return x | y;
 
     CASE_OP_32_64_VEC(xor):
@@ -2949,7 +2950,8 @@ void tcg_optimize(TCGContext *s)
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
index 8edbb98596..88ab792814 100644
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
@@ -5437,8 +5435,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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


