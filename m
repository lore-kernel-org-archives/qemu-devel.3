Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4B0C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnml-0005gC-S9; Sun, 16 Feb 2025 18:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmf-0005dU-BA
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:45 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmd-0005IO-AO
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:45 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2212a930001so11543665ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747442; x=1740352242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4H0qiGXb4+8rwfLKMCyH88KUnh4RaOazeaaZ8WaVObc=;
 b=TpPqqoEkXOC/BfJjTlcEDpIG8N1hkw2lpkCQcQ2Az9WPnnUGESnfQtzTkSHSos1qdj
 9i/UGhR3LeGgovUgqlCOwD/MDxdyzfp6esBN18nBVQnrrJGVm1fTz2p6QQm9bQwIak/3
 FlXPbutFmVbsADbqeS85/y5nVqMmbs4gGaK2/npJW1lFXk1o8vAAxZ1apsEGZeR0CZYH
 5kwHTBFDvWXWgSCmEGpI6lt7TsplJHQq2A/ipxLtlbWsB0+oaH8bktp9AuWaPu2o1Jbt
 AaUyyb+xwRLZgJVf7T6z0pjoumWnJlEALeANNceJchGRaFCvkxkOMs0Q4hYGesB1YgFi
 U3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747442; x=1740352242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4H0qiGXb4+8rwfLKMCyH88KUnh4RaOazeaaZ8WaVObc=;
 b=oeGB4GCVHrAx6LlMIJWN0RZGPRm3Je0jMrsbkh5GGUTsljAHFIColfPhKmnnEpzZPr
 9eMlv3VBW4bXCBqD8zHFnUKTB2aTX+J4U9fOcBhd5l2z0VfOnxsPkvQI77Zj1dmAHd/+
 mg4oBcXiphsrjZSVjZWaahlJq+GvTbqhdVasQa1V/6a3WPylBEgc6DOk1gxYlt3F+P54
 Nb6gXXYqGVpEuw5yvZIJ1cinZ/2S9RwB0nNB2OHTda3hBLKwY9O3sqoGzKjUK+7SqEqc
 Y/6bVo74tUjBt841aa8F1OTlFqWIi2pceqH55jp99jRhm59d6SbglBosrJeh38aIvao+
 YDbw==
X-Gm-Message-State: AOJu0YxLiJA1ABghsUQrheMKkHvOL9WD8pDaezZwBDzlXhurDABspp0E
 xZ8juPatvI92vHoyKkYbZ9jDqBKBOUqMQPqLRSng94rsUAAMFxmJ9TqqN4J++MnjbwN/7osKC7a
 L
X-Gm-Gg: ASbGncuC8hTPBMPK+Zq55waeRtaAWHl5yUUbhqv7SaGq7eu1MfweauxVHwHFeP0Cb2A
 XucNZ4mk28izt3neEEolVNfYsNCSgOgsshqyfnxFkDPoukvqrUoow20Voq4HrQu0KE9PI+aF+eW
 YwqNVOulqyaXf8H6op0q/HQ1Us2zpsu8FAdqrCEu8GhIsDYQ/x5KH+cw44uAOv/jOryohjb7j8L
 ogKqI1qTxIX9oRGUjZJNp0AzJwenjcW0v3ohU4PU1XQvpVyVGfnNmFdiBNqQihpNzOacPOLR1Eb
 lU78NndN77uqUxqtexMgOcT8dNIklCe/L1C4IsS+qIvSniA=
X-Google-Smtp-Source: AGHT+IGfbh3J2dh4UGMk7WvubHz4Sk0LqrtKCW5iteaWD2+K/NkLIHmihO1R9KNmU3+DfzkfV97i2Q==
X-Received: by 2002:a17:903:2351:b0:215:a964:e680 with SMTP id
 d9443c01a7336-2210404fc53mr111945145ad.25.1739747441923; 
 Sun, 16 Feb 2025 15:10:41 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 037/162] tcg: Merge INDEX_op_muluh_{i32,i64}
Date: Sun, 16 Feb 2025 15:08:06 -0800
Message-ID: <20250216231012.2808572-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
 include/tcg/tcg-opc.h  |  3 +--
 tcg/optimize.c         | 19 +++++++++++--------
 tcg/tcg-op.c           | 10 +++++-----
 tcg/tcg.c              | 13 ++++---------
 docs/devel/tcg-ops.rst |  2 +-
 5 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 4ecba62fda..28a5128537 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -44,6 +44,7 @@ DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
+DEF(muluh, 1, 2, 0, TCG_OPF_INT)
 DEF(nand, 1, 2, 0, TCG_OPF_INT)
 DEF(neg, 1, 1, 0, TCG_OPF_INT)
 DEF(nor, 1, 2, 0, TCG_OPF_INT)
@@ -89,7 +90,6 @@ DEF(add2_i32, 2, 4, 0, 0)
 DEF(sub2_i32, 2, 4, 0, 0)
 DEF(mulu2_i32, 2, 2, 0, 0)
 DEF(muls2_i32, 2, 2, 0, 0)
-DEF(muluh_i32, 1, 2, 0, 0)
 DEF(mulsh_i32, 1, 2, 0, 0)
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
@@ -151,7 +151,6 @@ DEF(add2_i64, 2, 4, 0, 0)
 DEF(sub2_i64, 2, 4, 0, 0)
 DEF(mulu2_i64, 2, 2, 0, 0)
 DEF(muls2_i64, 2, 2, 0, 0)
-DEF(muluh_i64, 1, 2, 0, 0)
 DEF(mulsh_i64, 1, 2, 0, 0)
 
 #define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 547a338486..cd37a540ca 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -407,7 +407,8 @@ static bool tcg_opt_gen_movi(OptContext *ctx, TCGOp *op,
     return tcg_opt_gen_mov(ctx, op, dst, arg_new_constant(ctx, val));
 }
 
-static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
+static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
+                                      uint64_t x, uint64_t y)
 {
     uint64_t l64, h64;
 
@@ -529,14 +530,16 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_extrh_i64_i32:
         return (uint64_t)x >> 32;
 
-    case INDEX_op_muluh_i32:
-        return ((uint64_t)(uint32_t)x * (uint32_t)y) >> 32;
+    case INDEX_op_muluh:
+        if (type == TCG_TYPE_I32) {
+            return ((uint64_t)(uint32_t)x * (uint32_t)y) >> 32;
+        }
+        mulu64(&l64, &h64, x, y);
+        return h64;
+
     case INDEX_op_mulsh_i32:
         return ((int64_t)(int32_t)x * (int32_t)y) >> 32;
 
-    case INDEX_op_muluh_i64:
-        mulu64(&l64, &h64, x, y);
-        return h64;
     case INDEX_op_mulsh_i64:
         muls64(&l64, &h64, x, y);
         return h64;
@@ -568,7 +571,7 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
 static uint64_t do_constant_folding(TCGOpcode op, TCGType type,
                                     uint64_t x, uint64_t y)
 {
-    uint64_t res = do_constant_folding_2(op, x, y);
+    uint64_t res = do_constant_folding_2(op, type, x, y);
     if (type == TCG_TYPE_I32) {
         res = (int32_t)res;
     }
@@ -2955,7 +2958,7 @@ void tcg_optimize(TCGContext *s)
             done = fold_mul(&ctx, op);
             break;
         CASE_OP_32_64(mulsh):
-        CASE_OP_32_64(muluh):
+        case INDEX_op_muluh:
             done = fold_mul_highpart(&ctx, op);
             break;
         CASE_OP_32_64(muls2):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 39581465f2..7a37b21c56 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1132,10 +1132,10 @@ void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_mulu2_i32) {
         tcg_gen_op4_i32(INDEX_op_mulu2_i32, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_muluh_i32, TCG_TYPE_I32, 0)) {
+    } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I32, 0)) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i32(INDEX_op_muluh_i32, rh, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_muluh, rh, arg1, arg2);
         tcg_gen_mov_i32(rl, t);
         tcg_temp_free_i32(t);
     } else if (TCG_TARGET_REG_BITS == 64) {
@@ -2842,10 +2842,10 @@ void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_HAS_mulu2_i64) {
         tcg_gen_op4_i64(INDEX_op_mulu2_i64, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_muluh_i64, TCG_TYPE_I64, 0)) {
+    } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
         tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i64(INDEX_op_muluh_i64, rh, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_muluh, rh, arg1, arg2);
         tcg_gen_mov_i64(rl, t);
         tcg_temp_free_i64(t);
     } else {
@@ -2868,7 +2868,7 @@ void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_mov_i64(rl, t);
         tcg_temp_free_i64(t);
     } else if (TCG_TARGET_HAS_mulu2_i64 ||
-               tcg_op_supported(INDEX_op_muluh_i64, TCG_TYPE_I64, 0)) {
+               tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         TCGv_i64 t2 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 2741048353..dc7a15ccd5 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1022,8 +1022,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
-    OUTOP(INDEX_op_muluh_i32, TCGOutOpBinary, outop_muluh),
-    OUTOP(INDEX_op_muluh_i64, TCGOutOpBinary, outop_muluh),
+    OUTOP(INDEX_op_muluh, TCGOutOpBinary, outop_muluh),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
     OUTOP(INDEX_op_neg, TCGOutOpUnary, outop_neg),
     OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
@@ -4030,17 +4029,14 @@ liveness_pass_1(TCGContext *s)
             }
             goto do_not_remove;
 
-        case INDEX_op_mulu2_i32:
-            opc_new = INDEX_op_mul;
-            opc_new2 = INDEX_op_muluh_i32;
-            goto do_mul2;
         case INDEX_op_muls2_i32:
             opc_new = INDEX_op_mul;
             opc_new2 = INDEX_op_mulsh_i32;
             goto do_mul2;
+        case INDEX_op_mulu2_i32:
         case INDEX_op_mulu2_i64:
             opc_new = INDEX_op_mul;
-            opc_new2 = INDEX_op_muluh_i64;
+            opc_new2 = INDEX_op_muluh;
             goto do_mul2;
         case INDEX_op_muls2_i64:
             opc_new = INDEX_op_mul;
@@ -5424,8 +5420,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_andc:
     case INDEX_op_eqv:
     case INDEX_op_mul:
-    case INDEX_op_muluh_i32:
-    case INDEX_op_muluh_i64:
+    case INDEX_op_muluh:
     case INDEX_op_nand:
     case INDEX_op_nor:
     case INDEX_op_or:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 6c36e72242..4fed5a77c6 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -591,7 +591,7 @@ Multiword arithmetic support
 
    * - mulsh_i32/i64 *t0*, *t1*, *t2*
 
-       muluh_i32/i64 *t0*, *t1*, *t2*
+       muluh *t0*, *t1*, *t2*
 
      - | Provide the high part of a signed or unsigned multiply, respectively.
        |
-- 
2.43.0


