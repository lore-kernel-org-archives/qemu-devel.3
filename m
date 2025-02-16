Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88817C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnrl-0006DT-08; Sun, 16 Feb 2025 18:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnqA-00015T-V0
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:26 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpz-0005S2-Dy
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:14:15 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-220ca204d04so49334275ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747638; x=1740352438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YU8FVtY9H8mPWcyiSW+ijsHHmfc7Mx3ZCWCYRlbReR4=;
 b=SdkIHkc4CYPDYoTLhzqEUaGy2Zi9WTJFD2zf8Z5Hvs1Cd0mVDiH9vTiddzZJJXDUzz
 IxLzC7lP/8FrP4uI48191OdBkooAXZCQXqZp5se3mT664iz2o0J/QGe4TmgEflTiY7Ab
 AfXtustAQpdGOTuthaA4gxROAdMLQKMJCisL0/vGIVWc4hLIBdJWIsiEwghRO6WMEUZc
 Xe8KNBGW5PM5KaYAVers1siHjXnTIsIB9jgxkxu6KIqyCMu2Ctdy4SyHdmoWPvNjxH4r
 HKlD4IkoG8EJ4OHVJR9ToCWkRhV+uyKflzW0K4geGy1mheULNNUHbp94HxmYDzNyhECD
 6jEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747638; x=1740352438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YU8FVtY9H8mPWcyiSW+ijsHHmfc7Mx3ZCWCYRlbReR4=;
 b=qH6w/HC7OyucHfSmG4QNfP4ayTkqHhMFkISRU0gba0VxC7Ul02qKmi8mHMApQdV9is
 7MpzKgwZkseoYPQgXwIG0WPTX1fS/RNSUZ//kc6q+e1F/m61kslMuiOBUZmO2h+i4dws
 g3I4L0v0SjkCn+orapB9cESBOI3BPiTnyEXiujg01+/Wx08kltlz4MP0lOp4YltujCnC
 2KsQJgwn+KftZX9hA57685lkRPDG12XUyALIZyGQCLpDudwv2HDEVZOwDsjeKu+yiJ1+
 6QeO/aQqccmY4yjHJkCOFTwm66wDKDReaoWhnS1Y0sjqG/4kkIXIUKVUx7EpNs5evnsS
 qAXw==
X-Gm-Message-State: AOJu0YwewNW7/VE4NPM95+A1JUFgekSQKKU2ZP5E9c7Y5n3dIJMV0cQo
 PgCHA8N3dCeoq4fQ3Kgv+X7nQ/XddjvQjAeC0wRv+p3TZKI3fcsJTrq2Md9WGZZxXIqDq3DSsVV
 r
X-Gm-Gg: ASbGncuoTe/3UcsojV0lCiefGclySNlygBCSD3gGDC1LvQRxLE4v+bQfgV3qUeidlKL
 GJz1E6aucBhvqBzrXHNO2PKGs/lUbsDE8ahxJfxB//agYDWSNHc4R9QABUp7Lt5WZcOsl44wZRZ
 lGFmCEYC6297J+mMAFtrGg+xU//VTt7i842aKA1nNwdJNmOz4Xs1fY9Y0YShDV14Gg0Hi4cYXMr
 93x8DFi5BmG86L9lMF0VjVB9T9YiSg4LrED0nj5Ofkm6ztfDiYxVJ41DPoWvqmmjFcns/Sy5zJ9
 h2MC+COVXR/oNxMToA41ZueL+Z9MQMLlrA3U0aiAHo9EdfE=
X-Google-Smtp-Source: AGHT+IGtMdbW+82nJNROKMpPdXnmHRQc0LvlauiqReRRYpAPSixtWFF6bF/uwLtzDUNh+kdAB3Z92Q==
X-Received: by 2002:a17:903:2f88:b0:21f:8c08:94d2 with SMTP id
 d9443c01a7336-22103ef22fdmr97562715ad.8.1739747638253; 
 Sun, 16 Feb 2025 15:13:58 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.13.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:13:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 057/162] tcg: Merge INDEX_op_sar_{i32,i64}
Date: Sun, 16 Feb 2025 15:08:26 -0800
Message-ID: <20250216231012.2808572-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  3 +--
 tcg/optimize.c           | 12 ++++++------
 tcg/tcg-op.c             |  4 ++--
 tcg/tcg.c                |  6 ++----
 tcg/tci.c                | 12 ++++--------
 docs/devel/tcg-ops.rst   |  4 ++--
 tcg/tci/tcg-target.c.inc |  3 +--
 7 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 35e0be8f80..cb8c134e94 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -58,6 +58,7 @@ DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
 DEF(rems, 1, 2, 0, TCG_OPF_INT)
 DEF(remu, 1, 2, 0, TCG_OPF_INT)
+DEF(sar, 1, 2, 0, TCG_OPF_INT)
 DEF(shl, 1, 2, 0, TCG_OPF_INT)
 DEF(shr, 1, 2, 0, TCG_OPF_INT)
 DEF(sub, 1, 2, 0, TCG_OPF_INT)
@@ -76,7 +77,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* shifts/rotates */
-DEF(sar_i32, 1, 2, 0, 0)
 DEF(rotl_i32, 1, 2, 0, 0)
 DEF(rotr_i32, 1, 2, 0, 0)
 DEF(deposit_i32, 1, 2, 2, 0)
@@ -115,7 +115,6 @@ DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* shifts/rotates */
-DEF(sar_i64, 1, 2, 0, 0)
 DEF(rotl_i64, 1, 2, 0, 0)
 DEF(rotr_i64, 1, 2, 0, 0)
 DEF(deposit_i64, 1, 2, 2, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index a10fb67da8..edf5c1c77a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -446,10 +446,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         }
         return (uint64_t)x >> (y & 63);
 
-    case INDEX_op_sar_i32:
-        return (int32_t)x >> (y & 31);
-
-    case INDEX_op_sar_i64:
+    case INDEX_op_sar:
+        if (type == TCG_TYPE_I32) {
+            return (int32_t)x >> (y & 31);
+        }
         return (int64_t)x >> (y & 63);
 
     case INDEX_op_rotr_i32:
@@ -2588,7 +2588,7 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
     }
 
     switch (op->opc) {
-    CASE_OP_32_64(sar):
+    case INDEX_op_sar:
         /*
          * Arithmetic right shift will not reduce the number of
          * input sign repetitions.
@@ -3015,7 +3015,7 @@ void tcg_optimize(TCGContext *s)
             break;
         CASE_OP_32_64(rotl):
         CASE_OP_32_64(rotr):
-        CASE_OP_32_64(sar):
+        case INDEX_op_sar:
         case INDEX_op_shl:
         case INDEX_op_shr:
             done = fold_shift(&ctx, op);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ef8cf5a1ac..43848ebc4f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -511,7 +511,7 @@ void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_sar_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_sar, ret, arg1, arg2);
 }
 
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -1624,7 +1624,7 @@ void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_sar_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_sar, ret, arg1, arg2);
     } else {
         gen_helper_sar_i64(ret, arg1, arg2);
     }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 667d63edf9..0a7c9eb612 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1042,8 +1042,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
     OUTOP(INDEX_op_remu, TCGOutOpBinary, outop_remu),
-    OUTOP(INDEX_op_sar_i32, TCGOutOpBinary, outop_sar),
-    OUTOP(INDEX_op_sar_i64, TCGOutOpBinary, outop_sar),
+    OUTOP(INDEX_op_sar, TCGOutOpBinary, outop_sar),
     OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
     OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
@@ -5415,8 +5414,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_orc:
     case INDEX_op_rems:
     case INDEX_op_remu:
-    case INDEX_op_sar_i32:
-    case INDEX_op_sar_i64:
+    case INDEX_op_sar:
     case INDEX_op_shl:
     case INDEX_op_shr:
     case INDEX_op_xor:
diff --git a/tcg/tci.c b/tcg/tci.c
index 376b1b1ece..2a2f216898 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -625,9 +625,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] >> (regs[r2] % TCG_TARGET_REG_BITS);
             break;
-        case INDEX_op_sar_i32:
+        case INDEX_op_sar:
             tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = (int32_t)regs[r1] >> (regs[r2] & 31);
+            regs[r0] = ((tcg_target_long)regs[r1]
+                        >> (regs[r2] % TCG_TARGET_REG_BITS));
             break;
 #if TCG_TARGET_HAS_rot_i32
         case INDEX_op_rotl_i32:
@@ -787,10 +788,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
             /* Shift/rotate operations (64 bit). */
 
-        case INDEX_op_sar_i64:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = (int64_t)regs[r1] >> (regs[r2] & 63);
-            break;
 #if TCG_TARGET_HAS_rot_i64
         case INDEX_op_rotl_i64:
             tci_args_rrr(insn, &r0, &r1, &r2);
@@ -1073,12 +1070,11 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_orc:
     case INDEX_op_rems:
     case INDEX_op_remu:
+    case INDEX_op_sar:
     case INDEX_op_shl:
     case INDEX_op_shr:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_sar_i32:
-    case INDEX_op_sar_i64:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index f9fd4b0087..be82fed41a 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -389,10 +389,10 @@ Shifts/Rotates
      - | *t0* = *t1* >> *t2* (unsigned)
        | Unspecified behavior for negative or out-of-range shifts.
 
-   * - sar_i32/i64 *t0*, *t1*, *t2*
+   * - sar *t0*, *t1*, *t2*
 
      - | *t0* = *t1* >> *t2* (signed)
-       | Unspecified behavior if *t2* < 0 or *t2* >= 32 (resp 64)
+       | Unspecified behavior for negative or out-of-range shifts.
 
    * - rotl_i32/i64 *t0*, *t1*, *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index f50a2d6574..feaa13dff0 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -779,7 +779,7 @@ static void tgen_sar(TCGContext *s, TCGType type,
         tcg_out_ext32s(s, TCG_REG_TMP, a1);
         a1 = TCG_REG_TMP;
     }
-    tcg_out_op_rrr(s, glue(INDEX_op_sar_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_sar, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_sar = {
@@ -897,7 +897,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, opc, args[0], args[1], args[2]);
         break;
 
-    CASE_32_64(sar)
     CASE_32_64(rotl)     /* Optional (TCG_TARGET_HAS_rot_*). */
     CASE_32_64(rotr)     /* Optional (TCG_TARGET_HAS_rot_*). */
     CASE_32_64(clz)      /* Optional (TCG_TARGET_HAS_clz_*). */
-- 
2.43.0


