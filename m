Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698F0C369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R4K-0001di-Jq; Fri, 25 Apr 2025 17:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R46-0000lP-J6
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:35 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R43-0000mp-BV
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:34 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so43060455ad.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618309; x=1746223109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CD9TFLxad9NK9bxkbaQAfvFnhcPiGga6py7chYws8b4=;
 b=OlZl/mFiIMiRveELOZT2tJFZAhIeAJ+9NMXtCyTYDG1X6Hdl5BhAVdTmpfCrrJDxu5
 kvxJr1a6GMPbKJcysKVYAi2/rGKWTBUdcWLe4R/Esix6KgwWIiXjDkpGzeL/YmaXWABD
 WcULY85rBgfmbBZ5ZUktJ9L2jQ6PQt3EUlSlTAKbULhaNJllABWECMRkxNcJPmTT3Kuo
 99L+GeFko8Tz6DDrh9OGah/TWpTt8HQuSbCrp1xgjMCOSFFJzgLJuCXvMheAKPHEheDD
 NG60/SC/abeTU5GPUEtM/HzFBXMnT2z8Srsncx1QmePd3+bXYDzmPNj5w4qZTF2iLcPM
 bbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618309; x=1746223109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CD9TFLxad9NK9bxkbaQAfvFnhcPiGga6py7chYws8b4=;
 b=w2h5KxTkpmUhSAbbOtotNdlfefMCM20foUHu6oUlw/8wNNdlURYCmz5oc6hWKZRMOE
 RpAncSVQcnKkt079RQHqnjHZwbK9rk/15Fdma6Up6O4RnDzk7fA4xfBbm6s61JcubWxx
 tiNJdPA6Q4eWoorioY4VEZIQIFccDc+mELjvJYCmsAD3EzSbkVgqw4EKFjarrHvP/umj
 kdXS2BF3C+XBcEITt+xb9XD1xJV4183b+BEUI9m1I/qfzS7shhzfpDX+f7g7+iOGFoPm
 0GvRuNMAH2qU10KV1yte1a5vMrCRgXUwGK4ptvapARetYImXasvHFnBqBF+yNVIOZ8Sq
 IoJg==
X-Gm-Message-State: AOJu0Yy3R8PIc6CVCJL4So7PFt/CYpUUeeYV1fvs16+S7rXzRcpUJL8Z
 QlDiEgB4d2o5fBZoQm1ZRr8upjP9SYni7GI56EwQ+UjzTnViU/N9MXZxb78EHKXxGCMX3N+RbmW
 b
X-Gm-Gg: ASbGncvTcQY6uFWNnGT2eJXSYH0vvyss4+c41iMPudYz1Ifdkm379hPfwzXYumIab89
 M2luoF5qs41JtscQ9RxuTPVr9K7YvohU66aUEwdH9v4tc/GJD6IGj3QLRXJzPgssGegh7hSaIiN
 n0VslgQJEzPPm4lSKNN2dPG7LWWov2o0/7NjFQof2ER8cntXgJAJfHraKQ8YlnKve3+Z4uh1qAH
 Cc95mFQNoN84lGuLsny0OpyxhP/AaMwV4VzgKGgoGfig8gfYUCbgwcqryAN2s1OgE/VG7VFxCRz
 UaJ4Pth0CPzcBrOvGmvF0mF36eXvdX1QNmURhSTHdtCLTUbsN3U0BQ2YdthyoBm8F56EBt9sd+1
 goxLbUYBnqg==
X-Google-Smtp-Source: AGHT+IEl4ht7EiSJC1WiogRfB4l05FLiPQ0UycpPZRACuhk9B3o8VTH7PnT/LukK8EzKKs+CNeHvGA==
X-Received: by 2002:a17:903:1b23:b0:220:e5be:29c7 with SMTP id
 d9443c01a7336-22dbf63a2c2mr66060335ad.39.1745618309592; 
 Fri, 25 Apr 2025 14:58:29 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm37749595ad.17.2025.04.25.14.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:58:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 046/159] tcg: Merge INDEX_op_div_{i32,i64}
Date: Fri, 25 Apr 2025 14:53:00 -0700
Message-ID: <20250425215454.886111-47-richard.henderson@linaro.org>
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

Rename to INDEX_op_divs to emphasize signed inputs,
and mirroring INDEX_op_divu_*.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  3 +--
 tcg/optimize.c           | 12 +++++++-----
 tcg/tcg-op.c             | 16 ++++++++--------
 tcg/tcg.c                |  6 ++----
 tcg/tci.c                |  5 ++---
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index a9d7938a52..6d4edd0b16 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -42,6 +42,7 @@ DEF(mov, 1, 1, 0, TCG_OPF_INT | TCG_OPF_NOT_PRESENT)
 DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
+DEF(divs, 1, 2, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
 DEF(mulsh, 1, 2, 0, TCG_OPF_INT)
@@ -68,7 +69,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* arith */
-DEF(div_i32, 1, 2, 0, 0)
 DEF(divu_i32, 1, 2, 0, 0)
 DEF(rem_i32, 1, 2, 0, 0)
 DEF(remu_i32, 1, 2, 0, 0)
@@ -116,7 +116,6 @@ DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* arith */
-DEF(div_i64, 1, 2, 0, 0)
 DEF(divu_i64, 1, 2, 0, 0)
 DEF(rem_i64, 1, 2, 0, 0)
 DEF(remu_i64, 1, 2, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index fd446fc47d..af9054be37 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -556,13 +556,15 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         muls64(&l64, &h64, x, y);
         return h64;
 
-    case INDEX_op_div_i32:
+    case INDEX_op_divs:
         /* Avoid crashing on divide by zero, otherwise undefined.  */
-        return (int32_t)x / ((int32_t)y ? : 1);
+        if (type == TCG_TYPE_I32) {
+            return (int32_t)x / ((int32_t)y ? : 1);
+        }
+        return (int64_t)x / ((int64_t)y ? : 1);
+
     case INDEX_op_divu_i32:
         return (uint32_t)x / ((uint32_t)y ? : 1);
-    case INDEX_op_div_i64:
-        return (int64_t)x / ((int64_t)y ? : 1);
     case INDEX_op_divu_i64:
         return (uint64_t)x / ((uint64_t)y ? : 1);
 
@@ -2905,7 +2907,7 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(deposit):
             done = fold_deposit(&ctx, op);
             break;
-        CASE_OP_32_64(div):
+        case INDEX_op_divs:
         CASE_OP_32_64(divu):
             done = fold_divide(&ctx, op);
             break;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 69e50f968f..9dba520d40 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -601,8 +601,8 @@ void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_div_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_div_i32, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_divs, ret, arg1, arg2);
     } else if (TCG_TARGET_HAS_div2_i32) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_sari_i32(t0, arg1, 31);
@@ -617,9 +617,9 @@ void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_rem_i32) {
         tcg_gen_op3_i32(INDEX_op_rem_i32, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_div_i32, TCG_TYPE_I32, 0)) {
+    } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_div_i32, t0, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_divs, t0, arg1, arg2);
         tcg_gen_mul_i32(t0, t0, arg2);
         tcg_gen_sub_i32(ret, arg1, t0);
         tcg_temp_free_i32(t0);
@@ -1969,8 +1969,8 @@ void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (tcg_op_supported(INDEX_op_div_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_div_i64, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_divs, ret, arg1, arg2);
     } else if (TCG_TARGET_HAS_div2_i64) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_sari_i64(t0, arg1, 63);
@@ -1985,9 +1985,9 @@ void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_HAS_rem_i64) {
         tcg_gen_op3_i64(INDEX_op_rem_i64, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_div_i64, TCG_TYPE_I64, 0)) {
+    } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_div_i64, t0, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_divs, t0, arg1, arg2);
         tcg_gen_mul_i64(t0, t0, arg2);
         tcg_gen_sub_i64(ret, arg1, t0);
         tcg_temp_free_i64(t0);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index f99213a154..d4e30d0b33 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1020,8 +1020,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
-    OUTOP(INDEX_op_div_i32, TCGOutOpBinary, outop_divs),
-    OUTOP(INDEX_op_div_i64, TCGOutOpBinary, outop_divs),
+    OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
@@ -5417,8 +5416,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
-    case INDEX_op_div_i32:
-    case INDEX_op_div_i64:
+    case INDEX_op_divs:
     case INDEX_op_eqv:
     case INDEX_op_mul:
     case INDEX_op_mulsh:
diff --git a/tcg/tci.c b/tcg/tci.c
index 4ecbb2d335..4b3ca53bc5 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -720,7 +720,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
             /* Arithmetic operations (64 bit). */
 
-        case INDEX_op_div_i64:
+        case INDEX_op_divs:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (int64_t)regs[r1] / (int64_t)regs[r2];
             break;
@@ -1071,6 +1071,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_add:
     case INDEX_op_and:
     case INDEX_op_andc:
+    case INDEX_op_divs:
     case INDEX_op_eqv:
     case INDEX_op_mul:
     case INDEX_op_nand:
@@ -1079,8 +1080,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_orc:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_div_i32:
-    case INDEX_op_div_i64:
     case INDEX_op_rem_i32:
     case INDEX_op_rem_i64:
     case INDEX_op_divu_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index fe922d1dac..a833b3b7b2 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -277,7 +277,7 @@ Arithmetic
 
      - | *t0* = *t1* * *t2*
 
-   * - div_i32/i64 *t0*, *t1*, *t2*
+   * - divs *t0*, *t1*, *t2*
 
      - | *t0* = *t1* / *t2* (signed)
        | Undefined behavior if division by zero or overflow.
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index c8e86a3253..4a556e2ce7 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -651,7 +651,7 @@ static void tgen_divs(TCGContext *s, TCGType type,
 {
     TCGOpcode opc = (type == TCG_TYPE_I32
                      ? INDEX_op_tci_divs32
-                     : INDEX_op_div_i64);
+                     : INDEX_op_divs);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
 }
 
-- 
2.43.0


