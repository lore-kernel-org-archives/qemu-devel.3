Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996FEC369BD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4m8h-00043k-E4; Tue, 15 Apr 2025 15:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m2p-0004rZ-PL
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:34:11 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m1g-0002vY-Vc
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:34:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso11255ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745565; x=1745350365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNNzDv3njLLxRmiQdFN5Ax7cHEkjlNNoeMOP33XytAk=;
 b=otyOJE9y800+Zp8FIV8CN2nJ4U6i2HHpRxvrkG077EBFxclIlrshSWiwFlQfIsNqJs
 1yzsTvRCJTNINPtJFs0MxP0vXprzRKArwSyT5/0EPsuiAPRoHW3AluoHtsXCrV21Q8Zn
 /c+xmL9tAwmukWL5hVvxxbOgq2OxkPYlHWvbBrceqE3gS8kbUeAIJYgWdPSJeXoeWhmX
 RF5QjL0/uR+SMgzmuZiqCfz+U58EkERKDwLMxZ2wPMy6LesxzRt8hNmIB/bZr+Gq2Qxf
 wVlWKxwP9zVNBty/TiZxyMOte8/7CJ4s313rQrzwgFAWA3TaIO+KkpZNfRwB15EuwbU+
 YmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745565; x=1745350365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nNNzDv3njLLxRmiQdFN5Ax7cHEkjlNNoeMOP33XytAk=;
 b=SqTF8cdUCZvOY3rN58JBapRzo4ApTWgjstnts59F+uBs0oJ5zxvl5DE8wQZCpXtMs4
 vL3hIMI1gbgSjzuM2vuCEbNQHePIKLYEqMPPEAMxd9YAW/bMoi8sVf0RNU1ULO0AFVfJ
 nDXAK7B8aiEeZ9H9QxihYt0YCwXZfiihXU0GotP/b2UNmLGkTWBJ/IcIXFZTV3ohXA9F
 ZoGLFZZzCax10rUpo1nsYg2plb+j+Yfw5OwLScOiyKP1BIm92HwRzTHs7+hTmhdZYVV8
 VduVQh9N/wkXUlf1/qmeOvP8/HIJazUq+pkovH5nREmJTSXEGIZFm9mSIT4/xX5GaBCf
 zwqA==
X-Gm-Message-State: AOJu0YzqqNz0fetHG+H9jfg7ege/INnZ0dZ6lS94NdDKYsbCQYlNEZaI
 x9Ut6BNQd5x93aygYN0A5SbSGn3RCOYou+wEkKt+OYabRdU/uKIQuOC1KqPvGw/dHItROEFMMlx
 t
X-Gm-Gg: ASbGnctySqMGzoKVWTgY42TzMvlcyBPdNOEG2uFxaFmFXov/u0eqDXSfVDgBV+5htxr
 sKLO4BVj7Ew7vfFL27zMEbAsMeXk7xaWi5TpL5Xl+4+lzcroJnIOG7EhyyKOySud3ovI7nTl3oT
 9GIDQQAIxPfcrgYk5PNoCutDMju/fVN2awE5zN1rJTh8i+YKwh+Yeuzs84fv6bv18DLU61SAsM2
 kfsN9np1Hn4KCIJzQ2G3+WMPeDxkn8Kv60nsdn1HD5sGMGYlllCs0g6NiMXux/8gwecyNIi98al
 kCqXwQUDR5dvW9l+AFxeQ9akmBzJxtYGbo7JSqaC+OA5JafEMoVX+ygiWqEU+ckOWm+HDKLDJxY
 =
X-Google-Smtp-Source: AGHT+IG9i9TV3EMSHpYw1B9jP68mTDxRmY0RiNUOXTc/eYxuXgd5Qicah3cKe15CKJuZkWngGtEcQA==
X-Received: by 2002:a17:902:d502:b0:223:3394:3a2e with SMTP id
 d9443c01a7336-22c30d71f82mr8376575ad.18.1744745565473; 
 Tue, 15 Apr 2025 12:32:45 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 105/163] tcg: Merge INDEX_op_extract2_{i32,i64}
Date: Tue, 15 Apr 2025 12:24:16 -0700
Message-ID: <20250415192515.232910-106-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h      |  5 +----
 tcg/optimize.c             | 10 +++++-----
 tcg/tcg-op.c               | 16 ++++++++--------
 tcg/tcg.c                  |  6 ++----
 docs/devel/tcg-ops.rst     |  4 ++--
 target/i386/tcg/emit.c.inc | 12 +-----------
 6 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index c6848b3c63..1f995c54be 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -56,6 +56,7 @@ DEF(divu, 1, 2, 0, TCG_OPF_INT)
 DEF(divu2, 2, 3, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(extract, 1, 1, 2, TCG_OPF_INT)
+DEF(extract2, 1, 2, 1, TCG_OPF_INT)
 DEF(movcond, 1, 4, 1, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
 DEF(muls2, 2, 2, 0, TCG_OPF_INT)
@@ -90,8 +91,6 @@ DEF(ld_i32, 1, 1, 1, 0)
 DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
-/* shifts/rotates */
-DEF(extract2_i32, 1, 2, 1, 0)
 
 DEF(add2_i32, 2, 4, 0, 0)
 DEF(sub2_i32, 2, 4, 0, 0)
@@ -110,8 +109,6 @@ DEF(st8_i64, 0, 2, 1, 0)
 DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
-/* shifts/rotates */
-DEF(extract2_i64, 1, 2, 1, 0)
 
 /* size changing ops */
 DEF(ext_i32_i64, 1, 1, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index f1adea829b..9595b32d54 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1861,12 +1861,12 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
         uint64_t v2 = arg_info(op->args[2])->val;
         int shr = op->args[3];
 
-        if (op->opc == INDEX_op_extract2_i64) {
-            v1 >>= shr;
-            v2 <<= 64 - shr;
-        } else {
+        if (ctx->type == TCG_TYPE_I32) {
             v1 = (uint32_t)v1 >> shr;
             v2 = (uint64_t)((int32_t)v2 << (32 - shr));
+        } else {
+            v1 >>= shr;
+            v2 <<= 64 - shr;
         }
         return tcg_opt_gen_movi(ctx, op, op->args[0], v1 | v2);
     }
@@ -2866,7 +2866,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_extract:
             done = fold_extract(&ctx, op);
             break;
-        CASE_OP_32_64(extract2):
+        case INDEX_op_extract2:
             done = fold_extract2(&ctx, op);
             break;
         case INDEX_op_ext_i32_i64:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5f95350d5d..edbb214f7c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -921,7 +921,7 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
 
     t1 = tcg_temp_ebb_new_i32();
 
-    if (tcg_op_supported(INDEX_op_extract2_i32, TCG_TYPE_I32, 0)) {
+    if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
         if (ofs + len == 32) {
             tcg_gen_shli_i32(t1, arg1, len);
             tcg_gen_extract2_i32(ret, t1, arg2, len);
@@ -1077,8 +1077,8 @@ void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
         tcg_gen_mov_i32(ret, ah);
     } else if (al == ah) {
         tcg_gen_rotri_i32(ret, al, ofs);
-    } else if (tcg_op_supported(INDEX_op_extract2_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op4i_i32(INDEX_op_extract2_i32, ret, al, ah, ofs);
+    } else if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
+        tcg_gen_op4i_i32(INDEX_op_extract2, ret, al, ah, ofs);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_shri_i32(t0, al, ofs);
@@ -1799,7 +1799,7 @@ static inline void tcg_gen_shifti_i64(TCGv_i64 ret, TCGv_i64 arg1,
             tcg_gen_movi_i32(TCGV_LOW(ret), 0);
         }
     } else if (right) {
-        if (tcg_op_supported(INDEX_op_extract2_i32, TCG_TYPE_I32, 0)) {
+        if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
             tcg_gen_extract2_i32(TCGV_LOW(ret),
                                  TCGV_LOW(arg1), TCGV_HIGH(arg1), c);
         } else {
@@ -1813,7 +1813,7 @@ static inline void tcg_gen_shifti_i64(TCGv_i64 ret, TCGv_i64 arg1,
             tcg_gen_shri_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), c);
         }
     } else {
-        if (tcg_op_supported(INDEX_op_extract2_i32, TCG_TYPE_I32, 0)) {
+        if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I32, 0)) {
             tcg_gen_extract2_i32(TCGV_HIGH(ret),
                                  TCGV_LOW(arg1), TCGV_HIGH(arg1), 32 - c);
         } else {
@@ -2553,7 +2553,7 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
 
     t1 = tcg_temp_ebb_new_i64();
 
-    if (tcg_op_supported(INDEX_op_extract2_i64, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I64, 0)) {
         if (ofs + len == 64) {
             tcg_gen_shli_i64(t1, arg1, len);
             tcg_gen_extract2_i64(ret, t1, arg2, len);
@@ -2781,8 +2781,8 @@ void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
         tcg_gen_mov_i64(ret, ah);
     } else if (al == ah) {
         tcg_gen_rotri_i64(ret, al, ofs);
-    } else if (tcg_op_supported(INDEX_op_extract2_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op4i_i64(INDEX_op_extract2_i64, ret, al, ah, ofs);
+    } else if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_I64, 0)) {
+        tcg_gen_op4i_i64(INDEX_op_extract2, ret, al, ah, ofs);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_shri_i64(t0, al, ofs);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index f34f9cdd13..ed03840988 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1146,8 +1146,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_divu2, TCGOutOpDivRem, outop_divu2),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_extract, TCGOutOpExtract, outop_extract),
-    OUTOP(INDEX_op_extract2_i32, TCGOutOpExtract2, outop_extract2),
-    OUTOP(INDEX_op_extract2_i64, TCGOutOpExtract2, outop_extract2),
+    OUTOP(INDEX_op_extract2, TCGOutOpExtract2, outop_extract2),
     OUTOP(INDEX_op_movcond, TCGOutOpMovcond, outop_movcond),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_muls2, TCGOutOpMul2, outop_muls2),
@@ -5594,8 +5593,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_extract2_i32:
-    case INDEX_op_extract2_i64:
+    case INDEX_op_extract2:
         {
             const TCGOutOpExtract2 *out = &outop_extract2;
 
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index aea8a897bd..9392d88069 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -476,9 +476,9 @@ Misc
        |
        | (using an arithmetic right shift) on TCG_TYPE_I32.
 
-   * - extract2_i32/i64 *dest*, *t1*, *t2*, *pos*
+   * - extract2 *dest*, *t1*, *t2*, *pos*
 
-     - | For N = {32,64}, extract an N-bit quantity from the concatenation
+     - | For TCG_TYPE_I{N}, extract an N-bit quantity from the concatenation
          of *t2*:*t1*, beginning at *pos*. The tcg_gen_extract2_{i32,i64} expander
          accepts 0 <= *pos* <= N as inputs. The backend code generator will
          not see either 0 or N as inputs for these opcodes.
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 0fa1664a24..a3cba8d791 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -19,16 +19,6 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-/*
- * Sometimes, knowing what the backend has can produce better code.
- * The exact opcode to check depends on 32- vs. 64-bit.
- */
-#ifdef TARGET_X86_64
-#define INDEX_op_extract2_tl            INDEX_op_extract2_i64
-#else
-#define INDEX_op_extract2_tl            INDEX_op_extract2_i32
-#endif
-
 #define MMX_OFFSET(reg)                        \
   ({ assert((reg) >= 0 && (reg) <= 7);         \
      offsetof(CPUX86State, fpregs[reg].mmx); })
@@ -2997,7 +2987,7 @@ static void gen_PMOVMSKB(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_ld8u_tl(s->T0, tcg_env, offsetof(CPUX86State, xmm_t0.ZMM_B(vec_len - 1)));
     while (vec_len > 8) {
         vec_len -= 8;
-        if (tcg_op_supported(INDEX_op_extract2_tl, TCG_TYPE_TL, 0)) {
+        if (tcg_op_supported(INDEX_op_extract2, TCG_TYPE_TL, 0)) {
             /*
              * Load the next byte of the result into the high byte of T.
              * TCG does a similar expansion of deposit to shl+extract2; by
-- 
2.43.0


