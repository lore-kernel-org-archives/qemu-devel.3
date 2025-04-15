Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B49C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lzO-0000Nm-Ly; Tue, 15 Apr 2025 15:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lz2-0007lU-2v
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:13 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lxp-0000hx-CM
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:08 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-301cda78d48so5400341a91.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745332; x=1745350132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/nYE1C3EM3uul1c/6fXXUGI41MfpY9F6VCb/KXKKRbw=;
 b=Z1Wr/E4kQUMkrScc4idX2aiblrDycd6sjBIkSDYd/q/ePAapMO2B/q48PIsucfWL0F
 T7k+XtfWEyg9cNC4JUQD4ADAQawlv89mS4AbcLVBEQ1msfNhx3kcHhPfNkOhDcX89Ps/
 8522qdOJpk4YY2o0j++XLLtLQEZYulRLQo5yDEAktifFoMM1pikwgtcQd53Vfsaxal95
 lA0dPXQ/MxeFS8KSmcMtMdMDvLDb+FWkHCmmoewE8rHGjyH1CPEjfkROSg2eA8nwg+cz
 PGMESMg2oUHSINOafnTGTZ4E2CBj286lW5Uvu/f1NokB3MSW2S+4lgRbsvkXJym/tVhS
 y8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745332; x=1745350132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/nYE1C3EM3uul1c/6fXXUGI41MfpY9F6VCb/KXKKRbw=;
 b=IbkliaV8rppj0noiiQmLJU/lwXLAF8gK56qjoJbslLOkx1iiNMWB0RkasxAVMLqrEW
 jc7a2ZDEh69nxesgvtQqVSMKYILtvFJABT0tHpJujziXnmkuqJDsMCuyqQs5gO6DG11G
 3rbcrnIyqvX0tWH70PmaKZE6/AVWe8rgmXd3LroDK+mTyGCWM4aocKKUHRuDYOrW2xb5
 H0o7mLcd65i2zJzbvdUxKJ4EFqr5W1deE5mMf5hnAgqHdBwJg6H3Lyodw9Ri7Fvynd7E
 R9/3qRfjaZa+pfIIB1wcheNmiZfanxVOHdnTLlyfealNG+nTR3ZwgI61/hFD3SOX7Eh6
 cIzw==
X-Gm-Message-State: AOJu0YyEXV30vX9y0AWtyxhoGK6ePV1JBtdeE3F+rtGlI2YuaTMRW4iH
 dy5ba2zjOnKkOmz33lZrCoifz5L2dv16rIrXKcoA0iTTV6nqyqOsHS+GFmDvMMr4gF6B6vz7U7w
 m
X-Gm-Gg: ASbGnctQbPVDIcL6AdTR9d7T+JPR6xKIqmcamEhuSkndNyfZlBi+yOiTKXRowfqgKhT
 Lzay8oAlVofStCaz5Jueq5k2Iox5GsfPdEgu+JNxWXqzjc6UCXM+briEum4mcqYoVhduEmYsQHg
 R+lZ1T/xOWz2PaRjHnRkvOQCL6Z31NHTexEWD1VsTP3fB0SWrFOc2xkPr3BIZRutnjOm1dssC9k
 NWqKifSLz5KjdBjGKEnUVVy9oYDZKLQU2E96Oq0usVT+sz+KAYVSBjAYNFbEUEXRJnaOkEOSFdv
 DbuanwV7+O85mfJNjJfzn6P6FuqDQ5rpIhW1fqf77reP2FXgjHyuioNkVDHvlkYYAjGlNAAJHp4
 =
X-Google-Smtp-Source: AGHT+IG5yuKcCYixCbDv0IH/6aw14Cle+OvSpEiRuB10TVtOhX8MnPvr518lJSGpSr3AGIqydu6uqg==
X-Received: by 2002:a17:90b:264d:b0:2ee:aed6:9ec2 with SMTP id
 98e67ed59e1d1-3085eeb4675mr571805a91.14.1744745332577; 
 Tue, 15 Apr 2025 12:28:52 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:28:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 040/163] tcg: Merge INDEX_op_mulsh_{i32,i64}
Date: Tue, 15 Apr 2025 12:23:11 -0700
Message-ID: <20250415192515.232910-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
 tcg/optimize.c         | 10 +++++-----
 tcg/tcg-op.c           |  8 ++++----
 tcg/tcg.c              | 14 ++++----------
 docs/devel/tcg-ops.rst |  2 +-
 5 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 28a5128537..a9d7938a52 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -44,6 +44,7 @@ DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
+DEF(mulsh, 1, 2, 0, TCG_OPF_INT)
 DEF(muluh, 1, 2, 0, TCG_OPF_INT)
 DEF(nand, 1, 2, 0, TCG_OPF_INT)
 DEF(neg, 1, 1, 0, TCG_OPF_INT)
@@ -90,7 +91,6 @@ DEF(add2_i32, 2, 4, 0, 0)
 DEF(sub2_i32, 2, 4, 0, 0)
 DEF(mulu2_i32, 2, 2, 0, 0)
 DEF(muls2_i32, 2, 2, 0, 0)
-DEF(mulsh_i32, 1, 2, 0, 0)
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
 
@@ -151,7 +151,6 @@ DEF(add2_i64, 2, 4, 0, 0)
 DEF(sub2_i64, 2, 4, 0, 0)
 DEF(mulu2_i64, 2, 2, 0, 0)
 DEF(muls2_i64, 2, 2, 0, 0)
-DEF(mulsh_i64, 1, 2, 0, 0)
 
 #define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
 
diff --git a/tcg/optimize.c b/tcg/optimize.c
index cd37a540ca..f8d9a4d90e 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -537,10 +537,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         mulu64(&l64, &h64, x, y);
         return h64;
 
-    case INDEX_op_mulsh_i32:
-        return ((int64_t)(int32_t)x * (int32_t)y) >> 32;
-
-    case INDEX_op_mulsh_i64:
+    case INDEX_op_mulsh:
+        if (type == TCG_TYPE_I32) {
+            return ((int64_t)(int32_t)x * (int32_t)y) >> 32;
+        }
         muls64(&l64, &h64, x, y);
         return h64;
 
@@ -2957,7 +2957,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_mul:
             done = fold_mul(&ctx, op);
             break;
-        CASE_OP_32_64(mulsh):
+        case INDEX_op_mulsh:
         case INDEX_op_muluh:
             done = fold_mul_highpart(&ctx, op);
             break;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a043c4554b..664c698187 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1156,10 +1156,10 @@ void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_muls2_i32) {
         tcg_gen_op4_i32(INDEX_op_muls2_i32, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_mulsh_i32, TCG_TYPE_I32, 0)) {
+    } else if (tcg_op_supported(INDEX_op_mulsh, TCG_TYPE_I32, 0)) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i32(INDEX_op_mulsh_i32, rh, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_mulsh, rh, arg1, arg2);
         tcg_gen_mov_i32(rl, t);
         tcg_temp_free_i32(t);
     } else if (TCG_TARGET_REG_BITS == 32) {
@@ -2861,10 +2861,10 @@ void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_HAS_muls2_i64) {
         tcg_gen_op4_i64(INDEX_op_muls2_i64, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_mulsh_i64, TCG_TYPE_I64, 0)) {
+    } else if (tcg_op_supported(INDEX_op_mulsh, TCG_TYPE_I64, 0)) {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
         tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i64(INDEX_op_mulsh_i64, rh, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_mulsh, rh, arg1, arg2);
         tcg_gen_mov_i64(rl, t);
         tcg_temp_free_i64(t);
     } else if (TCG_TARGET_HAS_mulu2_i64 ||
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e46e8638f4..e6c8fd0911 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1022,8 +1022,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
-    OUTOP(INDEX_op_mulsh_i32, TCGOutOpBinary, outop_mulsh),
-    OUTOP(INDEX_op_mulsh_i64, TCGOutOpBinary, outop_mulsh),
+    OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
     OUTOP(INDEX_op_muluh, TCGOutOpBinary, outop_muluh),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
     OUTOP(INDEX_op_neg, TCGOutOpUnary, outop_neg),
@@ -4028,18 +4027,14 @@ liveness_pass_1(TCGContext *s)
             goto do_not_remove;
 
         case INDEX_op_muls2_i32:
+        case INDEX_op_muls2_i64:
             opc_new = INDEX_op_mul;
-            opc_new2 = INDEX_op_mulsh_i32;
+            opc_new2 = INDEX_op_mulsh;
             goto do_mul2;
         case INDEX_op_mulu2_i32:
         case INDEX_op_mulu2_i64:
             opc_new = INDEX_op_mul;
             opc_new2 = INDEX_op_muluh;
-            goto do_mul2;
-        case INDEX_op_muls2_i64:
-            opc_new = INDEX_op_mul;
-            opc_new2 = INDEX_op_mulsh_i64;
-            goto do_mul2;
         do_mul2:
             nb_iargs = 2;
             nb_oargs = 2;
@@ -5421,8 +5416,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_andc:
     case INDEX_op_eqv:
     case INDEX_op_mul:
-    case INDEX_op_mulsh_i32:
-    case INDEX_op_mulsh_i64:
+    case INDEX_op_mulsh:
     case INDEX_op_muluh:
     case INDEX_op_nand:
     case INDEX_op_nor:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 4fed5a77c6..fe922d1dac 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -589,7 +589,7 @@ Multiword arithmetic support
 
      - | Similar to mulu2, except the two inputs *t1* and *t2* are signed.
 
-   * - mulsh_i32/i64 *t0*, *t1*, *t2*
+   * - mulsh *t0*, *t1*, *t2*
 
        muluh *t0*, *t1*, *t2*
 
-- 
2.43.0


