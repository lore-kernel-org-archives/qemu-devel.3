Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6253EE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPfL-0002lF-EV; Thu, 02 Jan 2025 13:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPek-0007Wh-0j
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:53 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPef-0006GK-Di
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:49 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2163b0c09afso155793925ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841444; x=1736446244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7jnO1A6SAIAAfT6wu6HCOlbt3kGlic4gLAkcw7PSCCA=;
 b=p2JxiQGpUkDNXLSeZ1NvTIYikOhpQItSbW7x+fM3s0t7ZUvAsmi1D1KbSt0OSh9wlO
 ArHD71fphUgzAQaOI67s86v3OqRfsFwNbhsbauGaxUrbab8j7irNHoj8VT8ADiJhzTvj
 jChra1T9DOe/Db/GEPwvz1OR7BNg277jYrI64Lq/perJmseFZL5+F6Obvzhi/xoFLdIe
 V6tYuF00lCHN6Yc81Es8bzzHCHMnfUc/TKGAdWGDyjgAZdKs8iKEq9XsKNDMRHnxlgTh
 YumwktvJgeq1Nvg7euslP8bqRN7EaeBumVBMR0AblUVetj70cdDrLn7efSR+SB2R79Vg
 zu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841444; x=1736446244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7jnO1A6SAIAAfT6wu6HCOlbt3kGlic4gLAkcw7PSCCA=;
 b=rOSIuRnnqzxXKdmEqy08pay99CkewBCYo4dLAT0WW+ecz/RAQPGayng16kdv//83lG
 TyM/KoIcs1Ii1rGYf+U96+JWTq4Cay4QqXD10wl4LOglaqRxyXteRD9VNSsCfbiXPuR1
 zFz4YlZFX6r6Ym04nNBG2QfUfMm8+DvDGaw0mIUBrY0PI3qOuBhfzW8Lu74MTCpPPwNH
 kOR+i5qmTnRBOeo7rDfBista7kQv3/kifHTd9DPpa1oL3srgAo42wrAd4jBkZgEeqGjb
 Puhg3MzSa8MLBgIbwyG5KbMsk7lVQ4NaaZlZpVO/HQO6PCU/btrgb+1ufuqpry01suEk
 xWMA==
X-Gm-Message-State: AOJu0Yzu4a+n2eO46D6WQUf5nNqG0VdOd8BX/I4k52OgHEyIS9Tw4AVr
 8k6hVfj2soDSJL6sFDLKNh3TrVgXxA+v8W4cLDdgvC4/fxGIVt0bHfRWleHv7S6w5Vy6zlPz3jE
 p
X-Gm-Gg: ASbGncvIypjyz6F1GURc13LzRqOHEMCDxhyFqNm8kxizs3JWFfAZHpuyvNc1DV4iHDh
 v7zIwg4vQTzFrXGq4g67Q0Nz6AxCH49QlIh8empy6WbBRUPZ+XRYb+VyfCfr3TUnw2zPL7DeZgP
 rsyb5EWfmjtxvk38Ra7jrSGkSBFFtaknIOnCUu0ArV+pM6Q8DTbcNOfIB+00o3Zm0uABtqPNpsP
 tv4H8n++qvQJm+iV6J41ikrQyqAMPH9tizQoMBIEBD11Di/hGLBzhKnbkMXFA==
X-Google-Smtp-Source: AGHT+IEyU983Og3nHlNzIVYKFiziVi50M1O8xGsVFzaQWUd6Zd0g9r0mcb0bkUM9od5eTwZPmBxGDA==
X-Received: by 2002:a05:6a20:d487:b0:1e1:ab51:f53e with SMTP id
 adf61e73a8af0-1e5e045869emr68365963637.5.1735841443489; 
 Thu, 02 Jan 2025 10:10:43 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 62/73] tcg: Merge integer logical operations
Date: Thu,  2 Jan 2025 10:06:42 -0800
Message-ID: <20250102180654.1420056-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

This is and, or, xor, andc, orc, eqv, nand, nor, not.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  27 ++--
 target/arm/tcg/translate-a64.c   |   2 +-
 target/arm/tcg/translate-sve.c   |   2 +-
 target/sh4/translate.c           |  14 +-
 target/tricore/translate.c       |   4 +-
 tcg/optimize.c                   |  90 +++++++------
 tcg/tcg-op.c                     |  40 +++---
 tcg/tcg.c                        |  46 +++----
 tcg/tci.c                        |  45 +++----
 tcg/aarch64/tcg-target.c.inc     |  54 ++------
 tcg/arm/tcg-target.c.inc         |  20 +--
 tcg/i386/tcg-target.c.inc        |  25 ++--
 tcg/loongarch64/tcg-target.c.inc |  42 ++----
 tcg/mips/tcg-target.c.inc        |  47 +++----
 tcg/ppc/tcg-target.c.inc         |  88 +++++--------
 tcg/riscv/tcg-target.c.inc       |  42 ++----
 tcg/s390x/tcg-target.c.inc       | 213 +++++++++++++------------------
 tcg/sparc64/tcg-target.c.inc     |  30 ++---
 tcg/tci/tcg-target.c.inc         |  45 +++----
 19 files changed, 352 insertions(+), 524 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 26b1144e4e..09eb7c3caf 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -38,6 +38,15 @@ DEF(br, 0, 0, 1, TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 DEF(mb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 
 DEF(mov, 1, 1, 0, TCG_OPF_INT | TCG_OPF_NOT_PRESENT)
+DEF(and, 1, 2, 0, TCG_OPF_INT)
+DEF(or, 1, 2, 0, TCG_OPF_INT)
+DEF(xor, 1, 2, 0, TCG_OPF_INT)
+DEF(andc, 1, 2, 0, TCG_OPF_INT)
+DEF(orc, 1, 2, 0, TCG_OPF_INT)
+DEF(eqv, 1, 2, 0, TCG_OPF_INT)
+DEF(nand, 1, 2, 0, TCG_OPF_INT)
+DEF(nor, 1, 2, 0, TCG_OPF_INT)
+DEF(not, 1, 1, 0, TCG_OPF_INT)
 
 DEF(setcond_i32, 1, 2, 1, 0)
 DEF(negsetcond_i32, 1, 2, 1, 0)
@@ -55,9 +64,6 @@ DEF(rem_i32, 1, 2, 0, 0)
 DEF(remu_i32, 1, 2, 0, 0)
 DEF(div2_i32, 2, 3, 0, 0)
 DEF(divu2_i32, 2, 3, 0, 0)
-DEF(and_i32, 1, 2, 0, 0)
-DEF(or_i32, 1, 2, 0, 0)
-DEF(xor_i32, 1, 2, 0, 0)
 /* shifts/rotates */
 DEF(shl_i32, 1, 2, 0, 0)
 DEF(shr_i32, 1, 2, 0, 0)
@@ -82,13 +88,7 @@ DEF(setcond2_i32, 1, 4, 1, 0)
 
 DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
-DEF(not_i32, 1, 1, 0, 0)
 DEF(neg_i32, 1, 1, 0, 0)
-DEF(andc_i32, 1, 2, 0, 0)
-DEF(orc_i32, 1, 2, 0, 0)
-DEF(eqv_i32, 1, 2, 0, 0)
-DEF(nand_i32, 1, 2, 0, 0)
-DEF(nor_i32, 1, 2, 0, 0)
 DEF(clz_i32, 1, 2, 0, 0)
 DEF(ctz_i32, 1, 2, 0, 0)
 DEF(ctpop_i32, 1, 1, 0, 0)
@@ -109,9 +109,6 @@ DEF(rem_i64, 1, 2, 0, 0)
 DEF(remu_i64, 1, 2, 0, 0)
 DEF(div2_i64, 2, 3, 0, 0)
 DEF(divu2_i64, 2, 3, 0, 0)
-DEF(and_i64, 1, 2, 0, 0)
-DEF(or_i64, 1, 2, 0, 0)
-DEF(xor_i64, 1, 2, 0, 0)
 /* shifts/rotates */
 DEF(shl_i64, 1, 2, 0, 0)
 DEF(shr_i64, 1, 2, 0, 0)
@@ -133,13 +130,7 @@ DEF(brcond_i64, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(bswap16_i64, 1, 1, 1, 0)
 DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
-DEF(not_i64, 1, 1, 0, 0)
 DEF(neg_i64, 1, 1, 0, 0)
-DEF(andc_i64, 1, 2, 0, 0)
-DEF(orc_i64, 1, 2, 0, 0)
-DEF(eqv_i64, 1, 2, 0, 0)
-DEF(nand_i64, 1, 2, 0, 0)
-DEF(nor_i64, 1, 2, 0, 0)
 DEF(clz_i64, 1, 2, 0, 0)
 DEF(ctz_i64, 1, 2, 0, 0)
 DEF(ctpop_i64, 1, 1, 0, 0)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 86da0c702f..755e2851b5 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8250,7 +8250,7 @@ static bool trans_CCMP(DisasContext *s, arg_CCMP *a)
     tcg_gen_subi_i32(tcg_t2, tcg_t0, 1);
 
     nzcv = a->nzcv;
-    has_andc = tcg_op_supported(INDEX_op_andc_i32, TCG_TYPE_I32);
+    has_andc = tcg_op_supported(INDEX_op_andc, TCG_TYPE_I32);
     if (nzcv & 8) { /* N */
         tcg_gen_or_i32(cpu_NF, cpu_NF, tcg_t1);
     } else {
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 1a28d04f17..7199fd61c9 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -622,7 +622,7 @@ static void gen_bsl2n_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
      *       =         | ~(m | k)
      */
     tcg_gen_and_i64(n, n, k);
-    if (tcg_op_supported(INDEX_op_orc_i64, TCG_TYPE_I64)) {
+    if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I64)) {
         tcg_gen_or_i64(m, m, k);
         tcg_gen_orc_i64(d, n, m);
     } else {
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index bcdd558818..bfb8d4919a 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1943,13 +1943,13 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         op_opc = INDEX_op_add_i32;
         goto do_reg_op;
     case 0x2009: /* and Rm,Rn */
-        op_opc = INDEX_op_and_i32;
+        op_opc = INDEX_op_and;
         goto do_reg_op;
     case 0x200a: /* xor Rm,Rn */
-        op_opc = INDEX_op_xor_i32;
+        op_opc = INDEX_op_xor;
         goto do_reg_op;
     case 0x200b: /* or Rm,Rn */
-        op_opc = INDEX_op_or_i32;
+        op_opc = INDEX_op_or;
     do_reg_op:
         /* The operation register should be as expected, and the
            other input cannot depend on the load.  */
@@ -1976,7 +1976,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
             goto fail;
         }
         op_dst = B11_8;
-        op_opc = INDEX_op_xor_i32;
+        op_opc = INDEX_op_xor;
         op_arg = tcg_constant_i32(-1);
         break;
 
@@ -2105,7 +2105,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         }
         break;
 
-    case INDEX_op_and_i32:
+    case INDEX_op_and:
         if (op_dst != st_src) {
             goto fail;
         }
@@ -2119,7 +2119,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         }
         break;
 
-    case INDEX_op_or_i32:
+    case INDEX_op_or:
         if (op_dst != st_src) {
             goto fail;
         }
@@ -2133,7 +2133,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         }
         break;
 
-    case INDEX_op_xor_i32:
+    case INDEX_op_xor:
         if (op_dst != st_src) {
             goto fail;
         }
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 6e6edeadfa..646110970f 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -3980,7 +3980,7 @@ static void decode_bit_andacc(DisasContext *ctx)
                     pos1, pos2, &tcg_gen_andc_tl, &tcg_gen_and_tl);
         break;
     case OPC2_32_BIT_AND_NOR_T:
-        if (tcg_op_supported(INDEX_op_andc_i32, TCG_TYPE_I32)) {
+        if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I32)) {
             gen_bit_2op(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2],
                         pos1, pos2, &tcg_gen_or_tl, &tcg_gen_andc_tl);
         } else {
@@ -4113,7 +4113,7 @@ static void decode_bit_orand(DisasContext *ctx)
                     pos1, pos2, &tcg_gen_andc_tl, &tcg_gen_or_tl);
         break;
     case OPC2_32_BIT_OR_NOR_T:
-        if (tcg_op_supported(INDEX_op_orc_i32, TCG_TYPE_I32)) {
+        if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I32)) {
             gen_bit_2op(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2],
                         pos1, pos2, &tcg_gen_or_tl, &tcg_gen_orc_tl);
         } else {
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 3264cab75b..d01cd22bf9 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -417,13 +417,16 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     CASE_OP_32_64(mul):
         return x * y;
 
-    CASE_OP_32_64_VEC(and):
+    case INDEX_op_and:
+    case INDEX_op_and_vec:
         return x & y;
 
-    CASE_OP_32_64_VEC(or):
+    case INDEX_op_or:
+    case INDEX_op_or_vec:
         return x | y;
 
-    CASE_OP_32_64_VEC(xor):
+    case INDEX_op_xor:
+    case INDEX_op_xor_vec:
         return x ^ y;
 
     case INDEX_op_shl_i32:
@@ -456,25 +459,31 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_rotl_i64:
         return rol64(x, y & 63);
 
-    CASE_OP_32_64_VEC(not):
+    case INDEX_op_not:
+    case INDEX_op_not_vec:
         return ~x;
 
     CASE_OP_32_64(neg):
         return -x;
 
-    CASE_OP_32_64_VEC(andc):
+    case INDEX_op_andc:
+    case INDEX_op_andc_vec:
         return x & ~y;
 
-    CASE_OP_32_64_VEC(orc):
+    case INDEX_op_orc:
+    case INDEX_op_orc_vec:
         return x | ~y;
 
-    CASE_OP_32_64_VEC(eqv):
+    case INDEX_op_eqv:
+    case INDEX_op_eqv_vec:
         return ~(x ^ y);
 
-    CASE_OP_32_64_VEC(nand):
+    case INDEX_op_nand:
+    case INDEX_op_nand_vec:
         return ~(x & y);
 
-    CASE_OP_32_64_VEC(nor):
+    case INDEX_op_nor:
+    case INDEX_op_nor_vec:
         return ~(x | y);
 
     case INDEX_op_clz_i32:
@@ -783,9 +792,8 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
 
     /* Expand to AND with a temporary if no backend support. */
     if (!TCG_TARGET_HAS_tst) {
-        TCGOpcode and_opc = (op->type == TCG_TYPE_I32
-                             ? INDEX_op_and_i32 : INDEX_op_and_i64);
-        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, and_opc, op->type, 3);
+        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_and,
+                                          op->type, 3);
         TCGArg tmp = arg_new_temp(ctx, op->type);
 
         op2->args[0] = tmp;
@@ -879,9 +887,9 @@ static int do_constant_folding_cond2(OptContext *ctx, TCGOp *op, TCGArg *args)
     /* Expand to AND with a temporary if no backend support. */
     if (!TCG_TARGET_HAS_tst && is_tst_cond(c)) {
         TCGOp *op1 = tcg_op_insert_before(ctx->tcg, op,
-                                          INDEX_op_and_i32, TCG_TYPE_I32, 3);
+                                          INDEX_op_and, TCG_TYPE_I32, 3);
         TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op,
-                                          INDEX_op_and_i32, TCG_TYPE_I32, 3);
+                                          INDEX_op_and, TCG_TYPE_I32, 3);
         TCGArg t1 = arg_new_temp(ctx, op->type);
         TCGArg t2 = arg_new_temp(ctx, op->type);
 
@@ -1080,11 +1088,11 @@ static bool fold_to_not(OptContext *ctx, TCGOp *op, int idx)
 
     switch (op->type) {
     case TCG_TYPE_I32:
-        not_op = INDEX_op_not_i32;
+        not_op = INDEX_op_not;
         have_not = TCG_TARGET_HAS_not(TCG_TYPE_I32);
         break;
     case TCG_TYPE_I64:
-        not_op = INDEX_op_not_i64;
+        not_op = INDEX_op_not;
         have_not = TCG_TARGET_HAS_not(TCG_TYPE_I64);
         break;
     case TCG_TYPE_V64:
@@ -1693,7 +1701,6 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     int ofs = op->args[3];
     int len = op->args[4];
     int width;
-    TCGOpcode and_opc;
     uint64_t z_mask, s_mask;
 
     if (ti_is_const(t1) && ti_is_const(t2)) {
@@ -1704,11 +1711,9 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
 
     switch (op->type) {
     case TCG_TYPE_I32:
-        and_opc = INDEX_op_and_i32;
         width = 32;
         break;
     case TCG_TYPE_I64:
-        and_opc = INDEX_op_and_i64;
         width = 64;
         break;
     default:
@@ -1719,7 +1724,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     if (ti_is_const_val(t1, 0) && ofs == 0) {
         uint64_t mask = MAKE_64BIT_MASK(0, len);
 
-        op->opc = and_opc;
+        op->opc = INDEX_op_and;
         op->args[1] = op->args[2];
         op->args[2] = arg_new_constant(ctx, op->type, mask);
         return fold_and(ctx, op);
@@ -1729,7 +1734,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     if (ti_is_const_val(t2, 0)) {
         uint64_t mask = deposit64(-1, ofs, len, 0);
 
-        op->opc = and_opc;
+        op->opc = INDEX_op_and;
         op->args[2] = arg_new_constant(ctx, op->type, mask);
         return fold_and(ctx, op);
     }
@@ -2244,7 +2249,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
             break;
         }
         if (convert) {
-            TCGOpcode add_opc, xor_opc, neg_opc;
+            TCGOpcode add_opc, neg_opc;
 
             if (!inv && !neg) {
                 return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
@@ -2254,12 +2259,10 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
             case TCG_TYPE_I32:
                 add_opc = INDEX_op_add_i32;
                 neg_opc = INDEX_op_neg_i32;
-                xor_opc = INDEX_op_xor_i32;
                 break;
             case TCG_TYPE_I64:
                 add_opc = INDEX_op_add_i64;
                 neg_opc = INDEX_op_neg_i64;
-                xor_opc = INDEX_op_xor_i64;
                 break;
             default:
                 g_assert_not_reached();
@@ -2271,7 +2274,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
                 op->opc = add_opc;
                 op->args[2] = arg_new_constant(ctx, op->type, -1);
             } else {
-                op->opc = xor_opc;
+                op->opc = INDEX_op_xor;
                 op->args[2] = arg_new_constant(ctx, op->type, 1);
             }
             return -1;
@@ -2282,7 +2285,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
-    TCGOpcode and_opc, sub_opc, xor_opc, neg_opc, shr_opc;
+    TCGOpcode sub_opc, neg_opc, shr_opc;
     TCGOpcode uext_opc = 0, sext_opc = 0;
     TCGCond cond = op->args[3];
     TCGArg ret, src1, src2;
@@ -2304,9 +2307,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 
     switch (op->type) {
     case TCG_TYPE_I32:
-        and_opc = INDEX_op_and_i32;
         sub_opc = INDEX_op_sub_i32;
-        xor_opc = INDEX_op_xor_i32;
         shr_opc = INDEX_op_shr_i32;
         neg_opc = INDEX_op_neg_i32;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I32, sh, 1)) {
@@ -2317,9 +2318,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         }
         break;
     case TCG_TYPE_I64:
-        and_opc = INDEX_op_and_i64;
         sub_opc = INDEX_op_sub_i64;
-        xor_opc = INDEX_op_xor_i64;
         shr_opc = INDEX_op_shr_i64;
         neg_opc = INDEX_op_neg_i64;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I64, sh, 1)) {
@@ -2356,7 +2355,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
             op2->args[2] = arg_new_constant(ctx, op->type, sh);
             src1 = ret;
         }
-        op->opc = and_opc;
+        op->opc = INDEX_op_and;
         op->args[1] = src1;
         op->args[2] = arg_new_constant(ctx, op->type, 1);
     }
@@ -2367,7 +2366,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         op2->args[1] = ret;
         op2->args[2] = arg_new_constant(ctx, op->type, 1);
     } else if (inv) {
-        op2 = tcg_op_insert_after(ctx->tcg, op, xor_opc, op->type, 3);
+        op2 = tcg_op_insert_after(ctx->tcg, op, INDEX_op_xor, op->type, 3);
         op2->args[0] = ret;
         op2->args[1] = ret;
         op2->args[2] = arg_new_constant(ctx, op->type, 1);
@@ -2782,10 +2781,12 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(add2):
             done = fold_add2(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(and):
+        case INDEX_op_and:
+        case INDEX_op_and_vec:
             done = fold_and(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(andc):
+        case INDEX_op_andc:
+        case INDEX_op_andc_vec:
             done = fold_andc(&ctx, op);
             break;
         CASE_OP_32_64(brcond):
@@ -2819,7 +2820,8 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_dup2_vec:
             done = fold_dup2(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(eqv):
+        case INDEX_op_eqv:
+        case INDEX_op_eqv_vec:
             done = fold_eqv(&ctx, op);
             break;
         CASE_OP_32_64(extract):
@@ -2867,22 +2869,27 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(mulu2):
             done = fold_multiply2(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(nand):
+        case INDEX_op_nand:
+        case INDEX_op_nand_vec:
             done = fold_nand(&ctx, op);
             break;
         CASE_OP_32_64(neg):
             done = fold_neg(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(nor):
+        case INDEX_op_nor:
+        case INDEX_op_nor_vec:
             done = fold_nor(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(not):
+        case INDEX_op_not:
+        case INDEX_op_not_vec:
             done = fold_not(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(or):
+        case INDEX_op_or:
+        case INDEX_op_or_vec:
             done = fold_or(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(orc):
+        case INDEX_op_orc:
+        case INDEX_op_orc_vec:
             done = fold_orc(&ctx, op);
             break;
         case INDEX_op_qemu_ld_a32_i32:
@@ -2949,7 +2956,8 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(sub2):
             done = fold_sub2(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(xor):
+        case INDEX_op_xor:
+        case INDEX_op_xor_vec:
             done = fold_xor(&ctx, op);
             break;
         case INDEX_op_set_label:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 113a7633db..aec952667a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -395,7 +395,7 @@ void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
 
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_and_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_and, ret, arg1, arg2);
 }
 
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -430,7 +430,7 @@ void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_or_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_or, ret, arg1, arg2);
 }
 
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -447,7 +447,7 @@ void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_xor_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_xor, ret, arg1, arg2);
 }
 
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -457,7 +457,7 @@ void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
         tcg_gen_mov_i32(ret, arg1);
     } else if (arg2 == -1 && TCG_TARGET_HAS_not(TCG_TYPE_I32)) {
         /* Don't recurse with tcg_gen_not_i32.  */
-        tcg_gen_op2_i32(INDEX_op_not_i32, ret, arg1);
+        tcg_gen_op2_i32(INDEX_op_not, ret, arg1);
     } else {
         tcg_gen_xor_i32(ret, arg1, tcg_constant_i32(arg2));
     }
@@ -466,7 +466,7 @@ void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (TCG_TARGET_HAS_not(TCG_TYPE_I32)) {
-        tcg_gen_op2_i32(INDEX_op_not_i32, ret, arg);
+        tcg_gen_op2_i32(INDEX_op_not, ret, arg);
     } else {
         tcg_gen_xori_i32(ret, arg, -1);
     }
@@ -663,7 +663,7 @@ void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_andc(TCG_TYPE_I32)) {
-        tcg_gen_op3_i32(INDEX_op_andc_i32, ret, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_andc, ret, arg1, arg2);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_not_i32(t0, arg2);
@@ -675,7 +675,7 @@ void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_eqv(TCG_TYPE_I32)) {
-        tcg_gen_op3_i32(INDEX_op_eqv_i32, ret, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_eqv, ret, arg1, arg2);
     } else {
         tcg_gen_xor_i32(ret, arg1, arg2);
         tcg_gen_not_i32(ret, ret);
@@ -685,7 +685,7 @@ void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_nand(TCG_TYPE_I32)) {
-        tcg_gen_op3_i32(INDEX_op_nand_i32, ret, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_nand, ret, arg1, arg2);
     } else {
         tcg_gen_and_i32(ret, arg1, arg2);
         tcg_gen_not_i32(ret, ret);
@@ -695,7 +695,7 @@ void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_nor(TCG_TYPE_I32)) {
-        tcg_gen_op3_i32(INDEX_op_nor_i32, ret, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_nor, ret, arg1, arg2);
     } else {
         tcg_gen_or_i32(ret, arg1, arg2);
         tcg_gen_not_i32(ret, ret);
@@ -705,7 +705,7 @@ void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_orc(TCG_TYPE_I32)) {
-        tcg_gen_op3_i32(INDEX_op_orc_i32, ret, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_orc, ret, arg1, arg2);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_not_i32(t0, arg2);
@@ -1573,7 +1573,7 @@ void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_and_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_and, ret, arg1, arg2);
     } else {
         tcg_gen_and_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_and_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
@@ -1583,7 +1583,7 @@ void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_or_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_or, ret, arg1, arg2);
     } else {
         tcg_gen_or_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_or_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
@@ -1593,7 +1593,7 @@ void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_xor_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_xor, ret, arg1, arg2);
     } else {
         tcg_gen_xor_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_xor_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
@@ -1762,7 +1762,7 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
         tcg_gen_mov_i64(ret, arg1);
     } else if (arg2 == -1 && TCG_TARGET_HAS_not(TCG_TYPE_I64)) {
         /* Don't recurse with tcg_gen_not_i64.  */
-        tcg_gen_op2_i64(INDEX_op_not_i64, ret, arg1);
+        tcg_gen_op2_i64(INDEX_op_not, ret, arg1);
     } else {
         tcg_gen_xor_i64(ret, arg1, tcg_constant_i64(arg2));
     }
@@ -2271,7 +2271,7 @@ void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg)
         tcg_gen_not_i32(TCGV_LOW(ret), TCGV_LOW(arg));
         tcg_gen_not_i32(TCGV_HIGH(ret), TCGV_HIGH(arg));
     } else if (TCG_TARGET_HAS_not(TCG_TYPE_I64)) {
-        tcg_gen_op2_i64(INDEX_op_not_i64, ret, arg);
+        tcg_gen_op2_i64(INDEX_op_not, ret, arg);
     } else {
         tcg_gen_xori_i64(ret, arg, -1);
     }
@@ -2283,7 +2283,7 @@ void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_andc_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_andc_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
     } else if (TCG_TARGET_HAS_andc(TCG_TYPE_I64)) {
-        tcg_gen_op3_i64(INDEX_op_andc_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_andc, ret, arg1, arg2);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_not_i64(t0, arg2);
@@ -2298,7 +2298,7 @@ void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_eqv_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_eqv_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
     } else if (TCG_TARGET_HAS_eqv(TCG_TYPE_I64)) {
-        tcg_gen_op3_i64(INDEX_op_eqv_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_eqv, ret, arg1, arg2);
     } else {
         tcg_gen_xor_i64(ret, arg1, arg2);
         tcg_gen_not_i64(ret, ret);
@@ -2311,7 +2311,7 @@ void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_nand_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_nand_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
     } else if (TCG_TARGET_HAS_nand(TCG_TYPE_I64)) {
-        tcg_gen_op3_i64(INDEX_op_nand_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_nand, ret, arg1, arg2);
     } else {
         tcg_gen_and_i64(ret, arg1, arg2);
         tcg_gen_not_i64(ret, ret);
@@ -2324,7 +2324,7 @@ void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_nor_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_nor_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
     } else if (TCG_TARGET_HAS_nor(TCG_TYPE_I64)) {
-        tcg_gen_op3_i64(INDEX_op_nor_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_nor, ret, arg1, arg2);
     } else {
         tcg_gen_or_i64(ret, arg1, arg2);
         tcg_gen_not_i64(ret, ret);
@@ -2337,7 +2337,7 @@ void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_orc_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_orc_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
     } else if (TCG_TARGET_HAS_orc(TCG_TYPE_I64)) {
-        tcg_gen_op3_i64(INDEX_op_orc_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_orc, ret, arg1, arg2);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_not_i64(t0, arg2);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 14e1045bef..9292e0bdd1 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2185,7 +2185,10 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_qemu_st_a64_i128:
         return TCG_TARGET_HAS_qemu_ldst_i128;
 
+    case INDEX_op_and:
     case INDEX_op_mov:
+    case INDEX_op_or:
+    case INDEX_op_xor:
         return has_type;
 
     case INDEX_op_setcond_i32:
@@ -2197,9 +2200,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_sub_i32:
     case INDEX_op_neg_i32:
     case INDEX_op_mul_i32:
-    case INDEX_op_and_i32:
-    case INDEX_op_or_i32:
-    case INDEX_op_xor_i32:
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
@@ -2208,6 +2208,19 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_deposit_i32:
         return true;
 
+    case INDEX_op_andc:
+        return has_type && TCG_TARGET_HAS_andc(type);
+    case INDEX_op_eqv:
+        return has_type && TCG_TARGET_HAS_eqv(type);
+    case INDEX_op_nand:
+        return has_type && TCG_TARGET_HAS_nand(type);
+    case INDEX_op_nor:
+        return has_type && TCG_TARGET_HAS_nor(type);
+    case INDEX_op_not:
+        return has_type && TCG_TARGET_HAS_not(type);
+    case INDEX_op_orc:
+        return has_type && TCG_TARGET_HAS_orc(type);
+
     case INDEX_op_negsetcond_i32:
         return TCG_TARGET_HAS_negsetcond(TCG_TYPE_I32);
     case INDEX_op_div_i32:
@@ -2239,18 +2252,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
         return TCG_TARGET_HAS_bswap(TCG_TYPE_I32);
-    case INDEX_op_not_i32:
-        return TCG_TARGET_HAS_not(TCG_TYPE_I32);
-    case INDEX_op_andc_i32:
-        return TCG_TARGET_HAS_andc(TCG_TYPE_I32);
-    case INDEX_op_orc_i32:
-        return TCG_TARGET_HAS_orc(TCG_TYPE_I32);
-    case INDEX_op_eqv_i32:
-        return TCG_TARGET_HAS_eqv(TCG_TYPE_I32);
-    case INDEX_op_nand_i32:
-        return TCG_TARGET_HAS_nand(TCG_TYPE_I32);
-    case INDEX_op_nor_i32:
-        return TCG_TARGET_HAS_nor(TCG_TYPE_I32);
     case INDEX_op_clz_i32:
         return TCG_TARGET_HAS_clz(TCG_TYPE_I32);
     case INDEX_op_ctz_i32:
@@ -2271,9 +2272,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_sub_i64:
     case INDEX_op_neg_i64:
     case INDEX_op_mul_i64:
-    case INDEX_op_and_i64:
-    case INDEX_op_or_i64:
-    case INDEX_op_xor_i64:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
@@ -2306,18 +2304,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_bswap(TCG_TYPE_I64);
-    case INDEX_op_not_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_not(TCG_TYPE_I64);
-    case INDEX_op_andc_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_andc(TCG_TYPE_I64);
-    case INDEX_op_orc_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_orc(TCG_TYPE_I64);
-    case INDEX_op_eqv_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_eqv(TCG_TYPE_I64);
-    case INDEX_op_nand_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_nand(TCG_TYPE_I64);
-    case INDEX_op_nor_i64:
-        return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_nor(TCG_TYPE_I64);
     case INDEX_op_clz_i64:
         return TCG_TARGET_REG_BITS == 64 && TCG_TARGET_HAS_clz(TCG_TYPE_I64);
     case INDEX_op_ctz_i64:
diff --git a/tcg/tci.c b/tcg/tci.c
index 23011a9dd5..af94428975 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -543,35 +543,35 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] * regs[r2];
             break;
-        CASE_32_64(and)
+        case INDEX_op_and:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] & regs[r2];
             break;
-        CASE_32_64(or)
+        case INDEX_op_or:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] | regs[r2];
             break;
-        CASE_32_64(xor)
+        case INDEX_op_xor:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ^ regs[r2];
             break;
-        CASE_32_64(andc)
+        case INDEX_op_andc:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] & ~regs[r2];
             break;
-        CASE_32_64(orc)
+        case INDEX_op_orc:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] | ~regs[r2];
             break;
-        CASE_32_64(eqv)
+        case INDEX_op_eqv:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] ^ regs[r2]);
             break;
-        CASE_32_64(nand)
+        case INDEX_op_nand:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] & regs[r2]);
             break;
-        CASE_32_64(nor)
+        case INDEX_op_nor:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ~(regs[r1] | regs[r2]);
             break;
@@ -679,7 +679,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = bswap32(regs[r1]);
             break;
-        CASE_32_64(not)
+        case INDEX_op_not:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = ~regs[r1];
             break;
@@ -1060,6 +1060,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
         break;
 
     case INDEX_op_mov:
+    case INDEX_op_not:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_bswap16_i32:
@@ -1067,8 +1068,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
     case INDEX_op_neg_i32:
     case INDEX_op_neg_i64:
     case INDEX_op_ctpop_i32:
@@ -1084,22 +1083,14 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
-    case INDEX_op_eqv_i32:
-    case INDEX_op_eqv_i64:
-    case INDEX_op_nand_i32:
-    case INDEX_op_nand_i64:
-    case INDEX_op_nor_i32:
-    case INDEX_op_nor_i64:
+    case INDEX_op_and:
+    case INDEX_op_or:
+    case INDEX_op_xor:
+    case INDEX_op_andc:
+    case INDEX_op_orc:
+    case INDEX_op_eqv:
+    case INDEX_op_nand:
+    case INDEX_op_nor:
     case INDEX_op_div_i32:
     case INDEX_op_div_i64:
     case INDEX_op_rem_i32:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 79265d1c1c..4168350845 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2222,10 +2222,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_insn(s, 3502, SUB, ext, a0, TCG_REG_XZR, a1);
         break;
 
-    case INDEX_op_and_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_and_i64:
+    case INDEX_op_and:
         if (c2) {
             tcg_out_logicali(s, I3404_ANDI, ext, a0, a1, a2);
         } else {
@@ -2233,10 +2230,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         }
         break;
 
-    case INDEX_op_andc_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_andc_i64:
+    case INDEX_op_andc:
         if (c2) {
             tcg_out_logicali(s, I3404_ANDI, ext, a0, a1, ~a2);
         } else {
@@ -2244,10 +2238,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         }
         break;
 
-    case INDEX_op_or_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_or_i64:
+    case INDEX_op_or:
         if (c2) {
             tcg_out_logicali(s, I3404_ORRI, ext, a0, a1, a2);
         } else {
@@ -2255,10 +2246,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         }
         break;
 
-    case INDEX_op_orc_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_orc_i64:
+    case INDEX_op_orc:
         if (c2) {
             tcg_out_logicali(s, I3404_ORRI, ext, a0, a1, ~a2);
         } else {
@@ -2266,10 +2254,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         }
         break;
 
-    case INDEX_op_xor_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_xor_i64:
+    case INDEX_op_xor:
         if (c2) {
             tcg_out_logicali(s, I3404_EORI, ext, a0, a1, a2);
         } else {
@@ -2277,10 +2262,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         }
         break;
 
-    case INDEX_op_eqv_i32:
-        a2 = (int32_t)a2;
-        /* FALLTHRU */
-    case INDEX_op_eqv_i64:
+    case INDEX_op_eqv:
         if (c2) {
             tcg_out_logicali(s, I3404_EORI, ext, a0, a1, ~a2);
         } else {
@@ -2288,8 +2270,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         }
         break;
 
-    case INDEX_op_not_i64:
-    case INDEX_op_not_i32:
+    case INDEX_op_not:
         tcg_out_insn(s, 3510, ORN, ext, a0, TCG_REG_XZR, a1);
         break;
 
@@ -2976,8 +2957,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ld_i64:
     case INDEX_op_neg_i32:
     case INDEX_op_neg_i64:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
+    case INDEX_op_not:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_bswap16_i64:
@@ -3023,18 +3003,12 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_mulsh_i64:
         return C_O1_I2(r, r, r);
 
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
-    case INDEX_op_eqv_i32:
-    case INDEX_op_eqv_i64:
+    case INDEX_op_and:
+    case INDEX_op_or:
+    case INDEX_op_xor:
+    case INDEX_op_andc:
+    case INDEX_op_orc:
+    case INDEX_op_eqv:
         return C_O1_I2(r, r, rL);
 
     case INDEX_op_shl_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 7d8d75465c..2422dd1d1b 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1925,18 +1925,18 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                             args[0], args[1], args[2], const_args[2]);
         }
         break;
-    case INDEX_op_and_i32:
+    case INDEX_op_and:
         tcg_out_dat_rIK(s, COND_AL, ARITH_AND, ARITH_BIC,
                         args[0], args[1], args[2], const_args[2]);
         break;
-    case INDEX_op_andc_i32:
+    case INDEX_op_andc:
         tcg_out_dat_rIK(s, COND_AL, ARITH_BIC, ARITH_AND,
                         args[0], args[1], args[2], const_args[2]);
         break;
-    case INDEX_op_or_i32:
+    case INDEX_op_or:
         c = ARITH_ORR;
         goto gen_arith;
-    case INDEX_op_xor_i32:
+    case INDEX_op_xor:
         c = ARITH_EOR;
         /* Fall through.  */
     gen_arith:
@@ -1985,7 +1985,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_neg_i32:
         tcg_out_dat_imm(s, COND_AL, ARITH_RSB, args[0], args[1], 0);
         break;
-    case INDEX_op_not_i32:
+    case INDEX_op_not:
         tcg_out_dat_reg(s, COND_AL,
                         ARITH_MVN, args[0], 0, args[1], SHIFT_IMM_LSL(0));
         break;
@@ -2183,7 +2183,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 
     case INDEX_op_ld_i32:
     case INDEX_op_neg_i32:
-    case INDEX_op_not_i32:
+    case INDEX_op_not:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
@@ -2199,8 +2199,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_negsetcond_i32:
         return C_O1_I2(r, r, rIN);
 
-    case INDEX_op_and_i32:
-    case INDEX_op_andc_i32:
+    case INDEX_op_and:
+    case INDEX_op_andc:
     case INDEX_op_clz_i32:
     case INDEX_op_ctz_i32:
         return C_O1_I2(r, r, rIK);
@@ -2214,8 +2214,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_muls2_i32:
         return C_O2_I2(r, r, r, r);
 
-    case INDEX_op_or_i32:
-    case INDEX_op_xor_i32:
+    case INDEX_op_or:
+    case INDEX_op_xor:
         return C_O1_I2(r, r, rI);
 
     case INDEX_op_shl_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 4a9ca6aafd..8064bee3a1 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2754,13 +2754,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(sub):
         c = ARITH_SUB;
         goto gen_arith;
-    OP_32_64(and):
+    case INDEX_op_and:
         c = ARITH_AND;
         goto gen_arith;
-    OP_32_64(or):
+    case INDEX_op_or:
         c = ARITH_OR;
         goto gen_arith;
-    OP_32_64(xor):
+    case INDEX_op_xor:
         c = ARITH_XOR;
         goto gen_arith;
     gen_arith:
@@ -2771,7 +2771,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(andc):
+    case INDEX_op_andc:
         if (const_a2) {
             tcg_out_mov(s, rexw ? TCG_TYPE_I64 : TCG_TYPE_I32, a0, a1);
             tgen_arithi(s, ARITH_AND + rexw, a0, ~a2, 0);
@@ -2901,7 +2901,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(neg):
         tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NEG, a0);
         break;
-    OP_32_64(not):
+    case INDEX_op_not:
         tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_NOT, a0);
         break;
 
@@ -3700,18 +3700,14 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
+    case INDEX_op_or:
+    case INDEX_op_xor:
         return C_O1_I2(r, 0, re);
 
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
+    case INDEX_op_and:
         return C_O1_I2(r, 0, reZ);
 
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
+    case INDEX_op_andc:
         return C_O1_I2(r, r, rI);
 
     case INDEX_op_shl_i32:
@@ -3739,8 +3735,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_bswap64_i64:
     case INDEX_op_neg_i32:
     case INDEX_op_neg_i64:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
+    case INDEX_op_not:
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, 0);
 
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 9d8bfdd8a1..a665f71e4a 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1312,13 +1312,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_srai_d(s, a0, a1, 32);
         break;
 
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
+    case INDEX_op_not:
         tcg_out_opc_nor(s, a0, a1, TCG_REG_ZERO);
         break;
 
-    case INDEX_op_nor_i32:
-    case INDEX_op_nor_i64:
+    case INDEX_op_nor:
         if (c2) {
             tcg_out_opc_ori(s, a0, a1, a2);
             tcg_out_opc_nor(s, a0, a0, TCG_REG_ZERO);
@@ -1327,8 +1325,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
+    case INDEX_op_andc:
         if (c2) {
             /* guaranteed to fit due to constraint */
             tcg_out_opc_andi(s, a0, a1, ~a2);
@@ -1337,8 +1334,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
+    case INDEX_op_orc:
         if (c2) {
             /* guaranteed to fit due to constraint */
             tcg_out_opc_ori(s, a0, a1, ~a2);
@@ -1347,8 +1343,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
+    case INDEX_op_and:
         if (c2) {
             tcg_out_opc_andi(s, a0, a1, a2);
         } else {
@@ -1356,8 +1351,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
+    case INDEX_op_or:
         if (c2) {
             tcg_out_opc_ori(s, a0, a1, a2);
         } else {
@@ -1365,8 +1359,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
+    case INDEX_op_xor:
         if (c2) {
             tcg_out_opc_xori(s, a0, a1, a2);
         } else {
@@ -2249,8 +2242,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ext_i32_i64:
     case INDEX_op_neg_i32:
     case INDEX_op_neg_i64:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
+    case INDEX_op_not:
     case INDEX_op_extract_i32:
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
@@ -2268,10 +2260,8 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_qemu_ld_a64_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
+    case INDEX_op_andc:
+    case INDEX_op_orc:
         /*
          * LoongArch insns for these ops don't have reg-imm forms, but we
          * can express using andi/ori if ~constant satisfies
@@ -2296,14 +2286,10 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_add_i64:
         return C_O1_I2(r, r, rJ);
 
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
-    case INDEX_op_nor_i32:
-    case INDEX_op_nor_i64:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
+    case INDEX_op_and:
+    case INDEX_op_nor:
+    case INDEX_op_or:
+    case INDEX_op_xor:
         /* LoongArch reg-imm bitops have their imms ZERO-extended */
         return C_O1_I2(r, r, rU);
 
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index af8e485a73..c2233a6931 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1769,12 +1769,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_add_i64:
         i1 = OPC_DADDU, i2 = OPC_DADDIU;
         goto do_binary;
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
+    case INDEX_op_or:
         i1 = OPC_OR, i2 = OPC_ORI;
         goto do_binary;
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
+    case INDEX_op_xor:
         i1 = OPC_XOR, i2 = OPC_XORI;
     do_binary:
         if (c2) {
@@ -1796,28 +1794,23 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             break;
         }
         goto do_binaryv;
-    case INDEX_op_and_i32:
-        if (c2 && a2 != (uint16_t)a2) {
-            int msb = ctz32(~a2) - 1;
-            tcg_debug_assert(use_mips32r2_instructions);
-            tcg_debug_assert(is_p2m1(a2));
-            tcg_out_opc_bf(s, OPC_EXT, a0, a1, msb, 0);
-            break;
-        }
-        i1 = OPC_AND, i2 = OPC_ANDI;
-        goto do_binary;
-    case INDEX_op_and_i64:
+
+    case INDEX_op_and:
         if (c2 && a2 != (uint16_t)a2) {
             int msb = ctz64(~a2) - 1;
             tcg_debug_assert(use_mips32r2_instructions);
             tcg_debug_assert(is_p2m1(a2));
-            tcg_out_opc_bf64(s, OPC_DEXT, OPC_DEXTM, OPC_DEXTU, a0, a1, msb, 0);
+            if (type == TCG_TYPE_I32) {
+                tcg_out_opc_bf(s, OPC_EXT, a0, a1, msb, 0);
+            } else {
+                tcg_out_opc_bf64(s, OPC_DEXT, OPC_DEXTM, OPC_DEXTU, a0, a1, msb, 0);
+            }
             break;
         }
         i1 = OPC_AND, i2 = OPC_ANDI;
         goto do_binary;
-    case INDEX_op_nor_i32:
-    case INDEX_op_nor_i64:
+
+    case INDEX_op_nor:
         i1 = OPC_NOR;
         goto do_binaryv;
 
@@ -1946,8 +1939,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_neg_i64:
         i1 = OPC_DSUBU;
         goto do_unary;
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
+    case INDEX_op_not:
         i1 = OPC_NOR;
         goto do_unary;
     do_unary:
@@ -2183,14 +2175,13 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 
     case INDEX_op_ld_i32:
     case INDEX_op_neg_i32:
-    case INDEX_op_not_i32:
+    case INDEX_op_not:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
     case INDEX_op_ld_i64:
     case INDEX_op_neg_i64:
-    case INDEX_op_not_i64:
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
@@ -2219,7 +2210,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_divu_i32:
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
-    case INDEX_op_nor_i32:
+    case INDEX_op_nor:
     case INDEX_op_setcond_i32:
     case INDEX_op_mul_i64:
     case INDEX_op_mulsh_i64:
@@ -2228,7 +2219,6 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_divu_i64:
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i64:
-    case INDEX_op_nor_i64:
     case INDEX_op_setcond_i64:
         return C_O1_I2(r, rZ, rZ);
     case INDEX_op_muls2_i32:
@@ -2236,13 +2226,10 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_muls2_i64:
     case INDEX_op_mulu2_i64:
         return C_O2_I2(r, r, r, r);
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
+    case INDEX_op_and:
         return C_O1_I2(r, r, rIK);
-    case INDEX_op_or_i32:
-    case INDEX_op_xor_i32:
-    case INDEX_op_or_i64:
-    case INDEX_op_xor_i64:
+    case INDEX_op_or:
+    case INDEX_op_xor:
         return C_O1_I2(r, r, rI);
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 538ffe9763..9a499f6861 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3042,24 +3042,17 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_and_i32:
+    case INDEX_op_and:
         a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
+        if (!const_args[2]) {
+            tcg_out32(s, AND | SAB(a1, a0, a2));
+        } else if (type == TCG_TYPE_I32) {
             tcg_out_andi32(s, a0, a1, a2);
         } else {
-            tcg_out32(s, AND | SAB(a1, a0, a2));
-        }
-        break;
-    case INDEX_op_and_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
             tcg_out_andi64(s, a0, a1, a2);
-        } else {
-            tcg_out32(s, AND | SAB(a1, a0, a2));
         }
         break;
-    case INDEX_op_or_i64:
-    case INDEX_op_or_i32:
+    case INDEX_op_or:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
             tcg_out_ori32(s, a0, a1, a2);
@@ -3067,8 +3060,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             tcg_out32(s, OR | SAB(a1, a0, a2));
         }
         break;
-    case INDEX_op_xor_i64:
-    case INDEX_op_xor_i32:
+    case INDEX_op_xor:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
             tcg_out_xori32(s, a0, a1, a2);
@@ -3076,46 +3068,36 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             tcg_out32(s, XOR | SAB(a1, a0, a2));
         }
         break;
-    case INDEX_op_andc_i32:
+    case INDEX_op_andc:
         a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
+        if (!const_args[2]) {
+            tcg_out32(s, ANDC | SAB(a1, a0, a2));
+        } else if (type == TCG_TYPE_I32) {
             tcg_out_andi32(s, a0, a1, ~a2);
         } else {
-            tcg_out32(s, ANDC | SAB(a1, a0, a2));
-        }
-        break;
-    case INDEX_op_andc_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
             tcg_out_andi64(s, a0, a1, ~a2);
-        } else {
-            tcg_out32(s, ANDC | SAB(a1, a0, a2));
         }
         break;
-    case INDEX_op_orc_i32:
+    case INDEX_op_orc:
         if (const_args[2]) {
+            tcg_debug_assert(type == TCG_TYPE_I32);
             tcg_out_ori32(s, args[0], args[1], ~args[2]);
             break;
         }
-        /* FALLTHRU */
-    case INDEX_op_orc_i64:
         tcg_out32(s, ORC | SAB(args[1], args[0], args[2]));
         break;
-    case INDEX_op_eqv_i32:
+    case INDEX_op_eqv:
         if (const_args[2]) {
+            tcg_debug_assert(type == TCG_TYPE_I32);
             tcg_out_xori32(s, args[0], args[1], ~args[2]);
             break;
         }
-        /* FALLTHRU */
-    case INDEX_op_eqv_i64:
         tcg_out32(s, EQV | SAB(args[1], args[0], args[2]));
         break;
-    case INDEX_op_nand_i32:
-    case INDEX_op_nand_i64:
+    case INDEX_op_nand:
         tcg_out32(s, NAND | SAB(args[1], args[0], args[2]));
         break;
-    case INDEX_op_nor_i32:
-    case INDEX_op_nor_i64:
+    case INDEX_op_nor:
         tcg_out32(s, NOR | SAB(args[1], args[0], args[2]));
         break;
 
@@ -3226,8 +3208,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out32(s, NEG | RT(args[0]) | RA(args[1]));
         break;
 
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
+    case INDEX_op_not:
         tcg_out32(s, NOR | SAB(args[1], args[0], args[1]));
         break;
 
@@ -4177,7 +4158,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ld_i32:
     case INDEX_op_ctpop_i32:
     case INDEX_op_neg_i32:
-    case INDEX_op_not_i32:
+    case INDEX_op_not:
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap32_i32:
     case INDEX_op_extract_i32:
@@ -4185,7 +4166,6 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ld_i64:
     case INDEX_op_ctpop_i64:
     case INDEX_op_neg_i64:
-    case INDEX_op_not_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
@@ -4201,20 +4181,25 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
+    case INDEX_op_or:
+    case INDEX_op_xor:
+        return (op->type == TCG_TYPE_I32
+                ? C_O1_I2(r, r, ri)
+                : C_O1_I2(r, r, rU));
+    case INDEX_op_orc:
+    case INDEX_op_eqv:
+        return (op->type == TCG_TYPE_I32
+                ? C_O1_I2(r, r, ri)
+                : C_O1_I2(r, r, r));
+
+    case INDEX_op_and:
+    case INDEX_op_andc:
     case INDEX_op_add_i32:
-    case INDEX_op_and_i32:
-    case INDEX_op_or_i32:
-    case INDEX_op_xor_i32:
-    case INDEX_op_andc_i32:
-    case INDEX_op_orc_i32:
-    case INDEX_op_eqv_i32:
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
-    case INDEX_op_and_i64:
-    case INDEX_op_andc_i64:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
@@ -4230,14 +4215,10 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_divu_i32:
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
-    case INDEX_op_nand_i32:
-    case INDEX_op_nor_i32:
+    case INDEX_op_nand:
+    case INDEX_op_nor:
     case INDEX_op_muluh_i32:
     case INDEX_op_mulsh_i32:
-    case INDEX_op_orc_i64:
-    case INDEX_op_eqv_i64:
-    case INDEX_op_nand_i64:
-    case INDEX_op_nor_i64:
     case INDEX_op_div_i64:
     case INDEX_op_divu_i64:
     case INDEX_op_rem_i64:
@@ -4250,9 +4231,6 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
         return C_O1_I2(r, rI, ri);
     case INDEX_op_add_i64:
         return C_O1_I2(r, r, rT);
-    case INDEX_op_or_i64:
-    case INDEX_op_xor_i64:
-        return C_O1_I2(r, r, rU);
     case INDEX_op_sub_i64:
         return C_O1_I2(r, rI, rT);
     case INDEX_op_clz_i32:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 72b06866c6..5650ab8115 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2061,8 +2061,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
+    case INDEX_op_and:
         if (c2) {
             tcg_out_opc_imm(s, OPC_ANDI, a0, a1, a2);
         } else {
@@ -2070,8 +2069,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
+    case INDEX_op_or:
         if (c2) {
             tcg_out_opc_imm(s, OPC_ORI, a0, a1, a2);
         } else {
@@ -2079,8 +2077,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
+    case INDEX_op_xor:
         if (c2) {
             tcg_out_opc_imm(s, OPC_XORI, a0, a1, a2);
         } else {
@@ -2088,24 +2085,21 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
+    case INDEX_op_andc:
         if (c2) {
             tcg_out_opc_imm(s, OPC_ANDI, a0, a1, ~a2);
         } else {
             tcg_out_opc_reg(s, OPC_ANDN, a0, a1, a2);
         }
         break;
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
+    case INDEX_op_orc:
         if (c2) {
             tcg_out_opc_imm(s, OPC_ORI, a0, a1, ~a2);
         } else {
             tcg_out_opc_reg(s, OPC_ORN, a0, a1, a2);
         }
         break;
-    case INDEX_op_eqv_i32:
-    case INDEX_op_eqv_i64:
+    case INDEX_op_eqv:
         if (c2) {
             tcg_out_opc_imm(s, OPC_XORI, a0, a1, ~a2);
         } else {
@@ -2113,8 +2107,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
+    case INDEX_op_not:
         tcg_out_opc_imm(s, OPC_XORI, a0, a1, -1);
         break;
 
@@ -2626,10 +2619,9 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
         return C_O0_I1(r);
 
     case INDEX_op_ld_i32:
-    case INDEX_op_not_i32:
+    case INDEX_op_not:
     case INDEX_op_neg_i32:
     case INDEX_op_ld_i64:
-    case INDEX_op_not_i64:
     case INDEX_op_neg_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
@@ -2653,25 +2645,19 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
         return C_O0_I2(rZ, r);
 
     case INDEX_op_add_i32:
-    case INDEX_op_and_i32:
-    case INDEX_op_or_i32:
-    case INDEX_op_xor_i32:
+    case INDEX_op_and:
+    case INDEX_op_or:
+    case INDEX_op_xor:
     case INDEX_op_add_i64:
-    case INDEX_op_and_i64:
-    case INDEX_op_or_i64:
-    case INDEX_op_xor_i64:
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i32:
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
-    case INDEX_op_eqv_i32:
-    case INDEX_op_eqv_i64:
+    case INDEX_op_andc:
+    case INDEX_op_orc:
+    case INDEX_op_eqv:
         return C_O1_I2(r, r, rJ);
 
     case INDEX_op_sub_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index f4a95b0c4f..8d738b41bb 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2248,33 +2248,41 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_and_i32:
-        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
+    case INDEX_op_and:
+        a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tgen_andi(s, TCG_TYPE_I32, a0, a2);
+            tcg_out_mov(s, type, a0, a1);
+            tgen_andi(s, type, a0, a2);
+        } else if (type != TCG_TYPE_I32) {
+            tcg_out_insn(s, RRFa, NGRK, a0, a1, a2);
         } else if (a0 == a1) {
             tcg_out_insn(s, RR, NR, a0, a2);
         } else {
             tcg_out_insn(s, RRFa, NRK, a0, a1, a2);
         }
         break;
-    case INDEX_op_or_i32:
-        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
+
+    case INDEX_op_or:
+        a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tgen_ori(s, a0, a2);
+            tcg_out_mov(s, type, a0, a1);
+            tgen_ori(s, a0, type == TCG_TYPE_I32 ? (uint32_t)a2 : a2);
+        } else if (type != TCG_TYPE_I32) {
+            tcg_out_insn(s, RRFa, OGRK, a0, a1, a2);
         } else if (a0 == a1) {
             tcg_out_insn(s, RR, OR, a0, a2);
         } else {
             tcg_out_insn(s, RRFa, ORK, a0, a1, a2);
         }
         break;
-    case INDEX_op_xor_i32:
-        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
+
+    case INDEX_op_xor:
+        a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tcg_out_insn(s, RIL, XILF, a0, a2);
+            tcg_out_mov(s, type, a0, a1);
+            tgen_xori(s, a0, type == TCG_TYPE_I32 ? (uint32_t)a2 : a2);
+        } else if (type != TCG_TYPE_I32) {
+            tcg_out_insn(s, RRFa, XGRK, a0, a1, a2);
         } else if (a0 == a1) {
             tcg_out_insn(s, RR, XR, args[0], args[2]);
         } else {
@@ -2282,45 +2290,67 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_andc_i32:
-        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
+    case INDEX_op_andc:
+        a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tgen_andi(s, TCG_TYPE_I32, a0, (uint32_t)~a2);
-	} else {
+            tcg_out_mov(s, type, a0, a1);
+            tgen_andi(s, type, a0, ~a2);
+        } else if (type == TCG_TYPE_I32) {
             tcg_out_insn(s, RRFa, NCRK, a0, a1, a2);
+	} else {
+            tcg_out_insn(s, RRFa, NCGRK, a0, a1, a2);
 	}
         break;
-    case INDEX_op_orc_i32:
-        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
+
+    case INDEX_op_orc:
+        a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tgen_ori(s, a0, (uint32_t)~a2);
-        } else {
+            tcg_out_mov(s, type, a0, a1);
+            tgen_ori(s, a0, type == TCG_TYPE_I32 ? ~(uint32_t)a2 : ~a2);
+        } else if (type == TCG_TYPE_I32) {
             tcg_out_insn(s, RRFa, OCRK, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_eqv_i32:
-        a0 = args[0], a1 = args[1], a2 = (uint32_t)args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I32, a0, a1);
-            tcg_out_insn(s, RIL, XILF, a0, ~a2);
         } else {
-            tcg_out_insn(s, RRFa, NXRK, a0, a1, a2);
+            tcg_out_insn(s, RRFa, OCGRK, a0, a1, a2);
         }
         break;
-    case INDEX_op_nand_i32:
-        tcg_out_insn(s, RRFa, NNRK, args[0], args[1], args[2]);
+
+    case INDEX_op_eqv:
+        a0 = args[0], a1 = args[1], a2 = args[2];
+        if (const_args[2]) {
+            tcg_out_mov(s, type, a0, a1);
+            tgen_xori(s, a0, type == TCG_TYPE_I32 ? ~(uint32_t)a2 : ~a2);
+        } else if (type == TCG_TYPE_I32) {
+            tcg_out_insn(s, RRFa, NXRK, a0, a1, a2);
+        } else {
+            tcg_out_insn(s, RRFa, NXGRK, a0, a1, a2);
+        }
         break;
-    case INDEX_op_nor_i32:
-        tcg_out_insn(s, RRFa, NORK, args[0], args[1], args[2]);
+
+    case INDEX_op_nand:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_insn(s, RRFa, NNRK, args[0], args[1], args[2]);
+        } else {
+            tcg_out_insn(s, RRFa, NNGRK, args[0], args[1], args[2]);
+        }
+        break;
+
+    case INDEX_op_nor:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_insn(s, RRFa, NORK, args[0], args[1], args[2]);
+        } else {
+            tcg_out_insn(s, RRFa, NOGRK, args[0], args[1], args[2]);
+        }
         break;
 
     case INDEX_op_neg_i32:
         tcg_out_insn(s, RR, LCR, args[0], args[1]);
         break;
-    case INDEX_op_not_i32:
-        tcg_out_insn(s, RRFa, NORK, args[0], args[1], args[1]);
+    case INDEX_op_not:
+        if (type == TCG_TYPE_I32) {
+            tcg_out_insn(s, RRFa, NORK, args[0], args[1], args[1]);
+        } else {
+            tcg_out_insn(s, RRFa, NOGRK, args[0], args[1], args[1]);
+        }
         break;
 
     case INDEX_op_mul_i32:
@@ -2496,7 +2526,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
 
-
     case INDEX_op_add_i64:
         a0 = args[0], a1 = args[1], a2 = args[2];
         if (const_args[2]) {
@@ -2536,74 +2565,9 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_and_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            tgen_andi(s, TCG_TYPE_I64, args[0], args[2]);
-        } else {
-            tcg_out_insn(s, RRFa, NGRK, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_or_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            tgen_ori(s, a0, a2);
-        } else {
-            tcg_out_insn(s, RRFa, OGRK, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_xor_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            tgen_xori(s, a0, a2);
-        } else {
-            tcg_out_insn(s, RRFa, XGRK, a0, a1, a2);
-        }
-        break;
-
-    case INDEX_op_andc_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            tgen_andi(s, TCG_TYPE_I64, a0, ~a2);
-        } else {
-            tcg_out_insn(s, RRFa, NCGRK, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_orc_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            tgen_ori(s, a0, ~a2);
-        } else {
-            tcg_out_insn(s, RRFa, OCGRK, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_eqv_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tcg_out_mov(s, TCG_TYPE_I64, a0, a1);
-            tgen_xori(s, a0, ~a2);
-        } else {
-            tcg_out_insn(s, RRFa, NXGRK, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_nand_i64:
-        tcg_out_insn(s, RRFa, NNGRK, args[0], args[1], args[2]);
-        break;
-    case INDEX_op_nor_i64:
-        tcg_out_insn(s, RRFa, NOGRK, args[0], args[1], args[2]);
-        break;
-
     case INDEX_op_neg_i64:
         tcg_out_insn(s, RRE, LCGR, args[0], args[1]);
         break;
-    case INDEX_op_not_i64:
-        tcg_out_insn(s, RRFa, NOGRK, args[0], args[1], args[1]);
-        break;
     case INDEX_op_bswap64_i64:
         tcg_out_insn(s, RRE, LRVGR, args[0], args[1]);
         break;
@@ -3265,30 +3229,28 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-    case INDEX_op_and_i32:
-    case INDEX_op_or_i32:
-    case INDEX_op_xor_i32:
         return C_O1_I2(r, r, ri);
-    case INDEX_op_and_i64:
-        return C_O1_I2(r, r, rNKR);
-    case INDEX_op_or_i64:
-    case INDEX_op_xor_i64:
-        return C_O1_I2(r, r, rK);
 
-    case INDEX_op_andc_i32:
-    case INDEX_op_orc_i32:
-    case INDEX_op_eqv_i32:
-        return C_O1_I2(r, r, ri);
-    case INDEX_op_andc_i64:
-        return C_O1_I2(r, r, rKR);
-    case INDEX_op_orc_i64:
-    case INDEX_op_eqv_i64:
-        return C_O1_I2(r, r, rNK);
-
-    case INDEX_op_nand_i32:
-    case INDEX_op_nand_i64:
-    case INDEX_op_nor_i32:
-    case INDEX_op_nor_i64:
+    case INDEX_op_and:
+        return (op->type == TCG_TYPE_I32
+                ? C_O1_I2(r, r, ri)
+                : C_O1_I2(r, r, rNKR));
+    case INDEX_op_or:
+    case INDEX_op_xor:
+        return (op->type == TCG_TYPE_I32
+                ? C_O1_I2(r, r, ri)
+                : C_O1_I2(r, r, rK));
+    case INDEX_op_andc:
+        return (op->type == TCG_TYPE_I32
+                ? C_O1_I2(r, r, ri)
+                : C_O1_I2(r, r, rKR));
+    case INDEX_op_orc:
+    case INDEX_op_eqv:
+        return (op->type == TCG_TYPE_I32
+                ? C_O1_I2(r, r, ri)
+                : C_O1_I2(r, r, rNK));
+    case INDEX_op_nand:
+    case INDEX_op_nor:
         return C_O1_I2(r, r, r);
 
     case INDEX_op_mul_i32:
@@ -3317,8 +3279,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_bswap64_i64:
     case INDEX_op_neg_i32:
     case INDEX_op_neg_i64:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
+    case INDEX_op_not:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 51def25f43..cec6a3df43 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1368,19 +1368,19 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(sub):
         c = ARITH_SUB;
         goto gen_arith;
-    OP_32_64(and):
+    case INDEX_op_and:
         c = ARITH_AND;
         goto gen_arith;
-    OP_32_64(andc):
+    case INDEX_op_andc:
         c = ARITH_ANDN;
         goto gen_arith;
-    OP_32_64(or):
+    case INDEX_op_or:
         c = ARITH_OR;
         goto gen_arith;
-    OP_32_64(orc):
+    case INDEX_op_orc:
         c = ARITH_ORN;
         goto gen_arith;
-    OP_32_64(xor):
+    case INDEX_op_xor:
         c = ARITH_XOR;
         goto gen_arith;
     case INDEX_op_shl_i32:
@@ -1402,7 +1402,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     OP_32_64(neg):
 	c = ARITH_SUB;
 	goto gen_arith1;
-    OP_32_64(not):
+    case INDEX_op_not:
 	c = ARITH_ORN;
 	goto gen_arith1;
 
@@ -1556,8 +1556,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_ld_i64:
     case INDEX_op_neg_i32:
     case INDEX_op_neg_i64:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
+    case INDEX_op_not:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
@@ -1588,16 +1587,11 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_divu_i64:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
+    case INDEX_op_and:
+    case INDEX_op_andc:
+    case INDEX_op_or:
+    case INDEX_op_orc:
+    case INDEX_op_xor:
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 793b00cf8f..8a6e8a9185 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -44,8 +44,7 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
 
     case INDEX_op_ld_i32:
     case INDEX_op_ld_i64:
-    case INDEX_op_not_i32:
-    case INDEX_op_not_i64:
+    case INDEX_op_not:
     case INDEX_op_neg_i32:
     case INDEX_op_neg_i64:
     case INDEX_op_ext_i32_i64:
@@ -83,22 +82,14 @@ static TCGConstraintSetIndex tcg_target_op_def(const TCGOp *op)
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_and_i32:
-    case INDEX_op_and_i64:
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
-    case INDEX_op_eqv_i32:
-    case INDEX_op_eqv_i64:
-    case INDEX_op_nand_i32:
-    case INDEX_op_nand_i64:
-    case INDEX_op_nor_i32:
-    case INDEX_op_nor_i64:
-    case INDEX_op_or_i32:
-    case INDEX_op_or_i64:
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
+    case INDEX_op_and:
+    case INDEX_op_andc:
+    case INDEX_op_eqv:
+    case INDEX_op_nand:
+    case INDEX_op_nor:
+    case INDEX_op_or:
+    case INDEX_op_orc:
+    case INDEX_op_xor:
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
@@ -728,14 +719,14 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     CASE_32_64(add)
     CASE_32_64(sub)
     CASE_32_64(mul)
-    CASE_32_64(and)
-    CASE_32_64(or)
-    CASE_32_64(xor)
-    CASE_32_64(andc)     /* Optional (TCG_TARGET_HAS_andc_*). */
-    CASE_32_64(orc)      /* Optional (TCG_TARGET_HAS_orc_*). */
-    CASE_32_64(eqv)      /* Optional (TCG_TARGET_HAS_eqv_*). */
-    CASE_32_64(nand)     /* Optional (TCG_TARGET_HAS_nand_*). */
-    CASE_32_64(nor)      /* Optional (TCG_TARGET_HAS_nor_*). */
+    case INDEX_op_and:
+    case INDEX_op_or:
+    case INDEX_op_xor:
+    case INDEX_op_andc:
+    case INDEX_op_orc:
+    case INDEX_op_eqv:
+    case INDEX_op_nand:
+    case INDEX_op_nor:
     CASE_32_64(shl)
     CASE_32_64(shr)
     CASE_32_64(sar)
@@ -770,7 +761,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
     CASE_32_64(neg)      /* Optional (TCG_TARGET_HAS_neg_*). */
-    CASE_32_64(not)      /* Optional (TCG_TARGET_HAS_not_*). */
+    case INDEX_op_not:
     CASE_32_64(ctpop)    /* Optional (TCG_TARGET_HAS_ctpop_*). */
     case INDEX_op_bswap32_i32: /* Optional (TCG_TARGET_HAS_bswap). */
     case INDEX_op_bswap64_i64: /* Optional (TCG_TARGET_HAS_bswap). */
-- 
2.43.0


