Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BFEC369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R49-0000sD-B7; Fri, 25 Apr 2025 17:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R44-0000a8-7a
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:32 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R41-0000mE-C2
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:31 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-223fd89d036so36382605ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618307; x=1746223107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tO0/nm5uYY3SqelT1TJBJeoK4kbQJotTKACux9jndPs=;
 b=qNAjvMrhHe1pPJXtSwCgwQCW+teBZnhHizHzFGQRvwZSIa4U5IGjE0lj8Ctd6euL0M
 xf6ARxZZxO6ZkTw9RBO+sgpYm/wOY0Tb9Ndb+SqWyj9RXK3KX0wIALl8PtJDlbktmxkb
 +cnYcHmN89Cxwt96ixbR3Nc+3qeW/4QliHEJIKNpT/btXGk/KVzdQYJK2YQPbQqX1FNC
 UH5rwwL+BWgzSwrjlvCcn2JoR6M+MQJJNZhqRBOhyOtif8hhFkr5NlWZXf3OchjuuaAt
 LTc+sontdPYj46OR9sSHtA2jFLDiW2KNpUNQr/ue9H4syfc4sZSO2kfy/hdNz3HSU/P6
 HAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618307; x=1746223107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tO0/nm5uYY3SqelT1TJBJeoK4kbQJotTKACux9jndPs=;
 b=PVpVTfC4y5ug33ix9OoTkCwpIAM4l92/BaAow1veLGLfXwtLQbXMDdQBpBfHJs85h1
 Ge/3vsF8i2lGvit7zHUS+ijoG9FCQ+9ZOXYOJtgo/WXGA2gQtISt7BLfjtskoLbN+1x/
 kPb1IDVLLvj8l7vuBsuukYYMyRI5nduTuzVFUdMW3CnOzJ7GVBVZZC7XdzD0rBAAE/2j
 0XGNxtNXdBdABj0aqHNJeUhY6rSUHnO3/wkRajXj1jRoZ4U/u5/6yA5dl1RKk7E63BL0
 ubYpFpeYiY6ktieMLHOrIHfWX0eL+gOeyFYASlE4hDh1wrlHenNwzXy5jZd478vF+s6x
 EARQ==
X-Gm-Message-State: AOJu0YylBs6X/VEdXiWC/HRMymsKUFt582hFjjrdhh/sGZhqFso//c4o
 5sATOodik4yX2Qk3nlRN52WrW8Mwniv8ncKuwOtQ/enpifOniDH8ipOYSz+SxvaS/1fq3O9Nn/w
 c
X-Gm-Gg: ASbGncupS5/6W/3sB+Dy4l7GmikcccIa0xIszxGIIZ8YFQmd5EqAicEGKSfN979BOQz
 yI7pEqA7Q8iLCV23W8ugHFHsApt0u427mCdxlHGXWcD0ySHa03+tXJWGI42tS/zS3NFbgUIqHGL
 03Nn445oe6ETD8VKMNT1oWBLb4pUAj0APiPZA3O3To7vrjsIxSS1eve5UBEGNhqbK0bodUoyYIj
 QARr59bgxLG2O6TMFg4jx1sj5+4eaH8WeqWp46tCEn6mG2uXTtvAa56789a8uKp6FZXl3AkTbUJ
 yJX+yStQo6MRjnUIcmrYUcc57QjlJGDUcrgBtm25I2Z1eMQ7JHdOP5kHlcJh+Us+xyGuNh2i0in
 2d7JTW+1oJg==
X-Google-Smtp-Source: AGHT+IEO4kO9opP7a52bIBeLDIStYSDWwmMRcCg5sGV1uAzOZ7RNSfg2uhnVrOE/J2kiUHWlNdBuIQ==
X-Received: by 2002:a17:903:2306:b0:223:628c:199 with SMTP id
 d9443c01a7336-22dc6a83602mr14947175ad.52.1745618306726; 
 Fri, 25 Apr 2025 14:58:26 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm37749595ad.17.2025.04.25.14.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:58:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 042/159] tcg: Merge INDEX_op_muluh_{i32,i64}
Date: Fri, 25 Apr 2025 14:52:56 -0700
Message-ID: <20250425215454.886111-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
index 653246f3d2..e19bccf906 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -419,7 +419,8 @@ static bool tcg_opt_gen_movi(OptContext *ctx, TCGOp *op,
     return tcg_opt_gen_mov(ctx, op, dst, arg_new_constant(ctx, val));
 }
 
-static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
+static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
+                                      uint64_t x, uint64_t y)
 {
     uint64_t l64, h64;
 
@@ -541,14 +542,16 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
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
@@ -580,7 +583,7 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
 static uint64_t do_constant_folding(TCGOpcode op, TCGType type,
                                     uint64_t x, uint64_t y)
 {
-    uint64_t res = do_constant_folding_2(op, x, y);
+    uint64_t res = do_constant_folding_2(op, type, x, y);
     if (type == TCG_TYPE_I32) {
         res = (int32_t)res;
     }
@@ -2967,7 +2970,7 @@ void tcg_optimize(TCGContext *s)
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
index cd85967229..808ac8c431 100644
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
@@ -5430,8 +5426,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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


