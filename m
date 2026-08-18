Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AA8C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCq-0007fi-6Y; Tue, 18 Aug 2026 13:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCn-0007d0-Vq
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:30 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCl-0004pS-HQ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:29 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-84867f07d63so175625b3a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072546; x=1787677346; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=meRpk4HIgZo/gaZ4CbrgzmeOnyzqJ4mXEzM6ce03Ox8=;
 b=qvX3bnqUZmHsb45Sf51oa8o/hHEEvGhQnVTz/q7PbJjPNuH5wbPwU+l8VEA8MzjdhP
 G9UVb+lwoSuBMoKqIL/HoFlf9gFBPp2v2OhHl2zIAabmku8chkgq12x8SVQmIqt/lQqQ
 G4flbi3j8EdW74+cuX+IyV/xP0ageozhMWAovQycyRS15Ak389ElUbe3NjK2rT7SGX1n
 wzXIrk3cq7O/x/8LdBUz7rUfXwtVlTV86hn+Q9HrX2JBsDPkp0+Gp/Am04nxCw0jH0gm
 3zWlgAgl3F2FHMun3ALuqHq79ER2SNUe0GD3j04THhZoFczlbz9wLA2L3skAUuzHKUK3
 lOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072546; x=1787677346;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=meRpk4HIgZo/gaZ4CbrgzmeOnyzqJ4mXEzM6ce03Ox8=;
 b=aw+Jfa2gDhRRICpKTQ7zqcU1f2jUGrW0m20+8tKPQIgLG7P7R7PR0NH2p2vfsYbXgo
 UPxlFbVhyLMNMJz40YKFP7Bnv2u/z5ud0M6A6Td9uJd8l2smPPwrQ37GtfTjeagyJRZZ
 P3RaRsZsp8qXc1WwWZvPCDrr4xKcGyf5wtTKwl/3Rr7En1bI72J2aBXb1Wo0/A9R3AG5
 bjn55Xk/3BKO+dmBwGtY5E7mSIDQO3SAHCysUrC6embKyu5Hj5eZFIoImlp95qhDB1ps
 XO2R8SyBGtAU6oHpXPrLoBLVLyjfQpHBx826bK3/6seZ8dvgkoCzCaalEJVJLgqU05cs
 p0ww==
X-Gm-Message-State: AOJu0YyhDpVAwo2g03CnIhFAi4Bpj6cMcp6JTD3f9ZbdxoNxFLcSC4t3
 Vm1UAJ6BNMcjXJOKJYvX3NQtuN07pmK6jtTHCLexhRrpK/zLgJQFBhaNcpRWHchVVJdZb19/PZP
 DYLipz3Q=
X-Gm-Gg: AR+sD12fWVdXhUcxdUPb2z9en+y/Ofs6HHMJV3/jxI+U9ZUqFa+mFv3/NSi1e3oHpfW
 uYLYuCHfE+gAg7LGHYF/64DWpfUn3OWgfjnNBaY6LPDNKCC5wairWAiqxf1w2JbxY+PpFV5/c4o
 Oa0GAqSrWOigVadqxtyrOrpxpKSU9hxJcrIDOpDZb29y9+YCm3a70Kt1sSpigulM3MGZuQDcxj+
 g6LKgbCFb09zo/JU51Y3kY2pbg5XqRByC24F1UAcD0IJXMwuGZMubS0jmR9qXxq94MGAa0rWYZI
 0Cbjs3vEq4sqKp5st/Cq3K8jv98CtS9cXawr7HGahgn1jBCRdjJ4SzGG2WG92D3nX5NBNIVrQWy
 2gjOEzC0mPhMah2PRqnXEW0N7/znUfHsbJ7+QtKGexVKFO15E7cexXl8s6oV7c4h6mD/BqosL7v
 3ao8gH/NxZg3gRl0CHHQF5VJoZhAW8Fh58ZvslaKc12ZZcYjfo13dPTAn+UhbOzuK3EQboHFh6T
 +xXD3/WtOdr8w5W2m9X3BYHfqdyLvthM+o=
X-Received: by 2002:a05:6a00:2308:b0:84a:60a4:2651 with SMTP id
 d2e1a72fcca58-84fddfa84f0mr35514157b3a.6.1787072545863; 
 Tue, 18 Aug 2026 10:02:25 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 23/38] tcg: Add integer min/max opcodes
Date: Tue, 18 Aug 2026 10:01:40 -0700
Message-ID: <20260818170155.1907006-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We already have these for vectors; replicate for integers.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  4 +++
 tcg/tcg-op.c                     | 48 ++++++++++++++++++++++++++------
 tcg/tcg.c                        |  8 ++++++
 docs/devel/tcg-ops.rst           | 12 ++++++++
 tcg/aarch64/tcg-target.c.inc     | 16 +++++++++++
 tcg/loongarch64/tcg-target.c.inc | 16 +++++++++++
 tcg/ppc64/tcg-target.c.inc       | 16 +++++++++++
 tcg/riscv64/tcg-target.c.inc     | 16 +++++++++++
 tcg/s390x/tcg-target.c.inc       | 16 +++++++++++
 tcg/sparc64/tcg-target.c.inc     | 16 +++++++++++
 tcg/tci/tcg-target.c.inc         | 16 +++++++++++
 tcg/x86_64/tcg-target.c.inc      | 16 +++++++++++
 12 files changed, 192 insertions(+), 8 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 13c7f17f76..f3a81d5d7f 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -89,11 +89,15 @@ DEF(setcond, 1, 2, 1, TCG_OPF_INT)
 DEF(sextract, 1, 1, 2, TCG_OPF_INT)
 DEF(shl, 1, 2, 0, TCG_OPF_INT)
 DEF(shr, 1, 2, 0, TCG_OPF_INT)
+DEF(smax, 1, 2, 0, TCG_OPF_INT)
+DEF(smin, 1, 2, 0, TCG_OPF_INT)
 DEF(st8, 0, 2, 1, TCG_OPF_INT)
 DEF(st16, 0, 2, 1, TCG_OPF_INT)
 DEF(st32, 0, 2, 1, TCG_OPF_INT)
 DEF(st, 0, 2, 1, TCG_OPF_INT)
 DEF(sub, 1, 2, 0, TCG_OPF_INT)
+DEF(umax, 1, 2, 0, TCG_OPF_INT)
+DEF(umin, 1, 2, 0, TCG_OPF_INT)
 DEF(xor, 1, 2, 0, TCG_OPF_INT)
 
 DEF(addco, 1, 2, 0, TCG_OPF_INT | TCG_OPF_CARRY_OUT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c302a484cd..e28944cf72 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1294,22 +1294,38 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
 
 void tcg_gen_smin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
-    tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, a, b);
+    if (tcg_op_supported(INDEX_op_smin, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_smin, ret, a, b);
+    } else {
+        tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, a, b);
+    }
 }
 
 void tcg_gen_umin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
-    tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, a, b);
+    if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_umin, ret, a, b);
+    } else {
+        tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, a, b);
+    }
 }
 
 void tcg_gen_smax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
-    tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, b, a);
+    if (tcg_op_supported(INDEX_op_smax, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_smax, ret, a, b);
+    } else {
+        tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, b, a);
+    }
 }
 
 void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
-    tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, b, a);
+    if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_umax, ret, a, b);
+    } else {
+        tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, b, a);
+    }
 }
 
 void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
@@ -2473,22 +2489,38 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_smin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
-    tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, a, b);
+    if (tcg_op_supported(INDEX_op_smin, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_smin, ret, a, b);
+    } else {
+        tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, a, b);
+    }
 }
 
 void tcg_gen_umin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
-    tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, a, b);
+    if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_umin, ret, a, b);
+    } else {
+        tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, a, b);
+    }
 }
 
 void tcg_gen_smax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
-    tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, b, a);
+    if (tcg_op_supported(INDEX_op_smax, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_smax, ret, a, b);
+    } else {
+        tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, b, a);
+    }
 }
 
 void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
-    tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, b, a);
+    if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_umax, ret, a, b);
+    } else {
+        tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, b, a);
+    }
 }
 
 void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 8a324ce885..489df0e738 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1211,6 +1211,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_sextract, TCGOutOpExtract, outop_sextract),
     OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
     OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
+    OUTOP(INDEX_op_smax, TCGOutOpBinary, outop_smax),
+    OUTOP(INDEX_op_smin, TCGOutOpBinary, outop_smin),
     OUTOP(INDEX_op_st, TCGOutOpStore, outop_st),
     OUTOP(INDEX_op_st8, TCGOutOpStore, outop_st8),
     OUTOP(INDEX_op_st16, TCGOutOpStore, outop_st16),
@@ -1220,6 +1222,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_subbo, TCGOutOpAddSubCarry, outop_subbo),
     /* subb1o is implemented with set_borrow + subbio */
     OUTOP(INDEX_op_subb1o, TCGOutOpAddSubCarry, outop_subbio),
+    OUTOP(INDEX_op_umax, TCGOutOpBinary, outop_umax),
+    OUTOP(INDEX_op_umin, TCGOutOpBinary, outop_umin),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 
     [INDEX_op_goto_ptr] = &outop_goto_ptr,
@@ -5518,6 +5522,10 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_sar:
     case INDEX_op_shl:
     case INDEX_op_shr:
+    case INDEX_op_smax:
+    case INDEX_op_smin:
+    case INDEX_op_umax:
+    case INDEX_op_umin:
     case INDEX_op_xor:
         {
             const TCGOutOpBinary *out =
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index f2e9255dd9..88d48a1f99 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -317,6 +317,18 @@ Arithmetic
          pass 0 to *nh* to make a simple zero-extension of *nl*,
          so overflow should never occur.
 
+   * - smax *t0*, *t1*, *t2*
+
+       umax *t0*, *t1*, *t2*
+
+     - | *t0* = MAX(*t1*, *t2*), for signed and unsigned integers.
+
+   * - smin *t0*, *t1*, *t2*
+
+       umin *t0*, *t1*, *t2*
+
+     - | *t0* = MIN(*t1*, *t2*), for signed and unsigned integers.
+
 Logical
 -------
 
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 80995403e4..f5c185bbf4 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2592,6 +2592,22 @@ static void tcg_out_set_borrow(TCGContext *s)
                  TCG_REG_XZR, TCG_REG_XZR, TCG_REG_XZR);
 }
 
+static const TCGOutOpBinary outop_smax = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_smin = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_umax = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_umin = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 7d89e80886..f65496a040 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1804,6 +1804,22 @@ static void tcg_out_set_borrow(TCGContext *s)
     g_assert_not_reached();
 }
 
+static const TCGOutOpBinary outop_smax = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_smin = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_umax = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_umin = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/ppc64/tcg-target.c.inc b/tcg/ppc64/tcg-target.c.inc
index 07dff67e84..cd1c234367 100644
--- a/tcg/ppc64/tcg-target.c.inc
+++ b/tcg/ppc64/tcg-target.c.inc
@@ -3281,6 +3281,22 @@ static void tcg_out_set_borrow(TCGContext *s)
     tcg_out32(s, ADDIC | TAI(TCG_REG_R0, TCG_REG_R0, 0));
 }
 
+static const TCGOutOpBinary outop_smax = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_smin = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_umax = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_umin = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 8fd32644fe..723c21b3da 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -2404,6 +2404,22 @@ static void tcg_out_set_borrow(TCGContext *s)
     g_assert_not_reached();
 }
 
+static const TCGOutOpBinary outop_smax = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_smin = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_umax = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_umin = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index c481745c3f..4d1a779c47 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2950,6 +2950,22 @@ static void tcg_out_set_borrow(TCGContext *s)
     tcg_out_insn(s, RR, CLR, TCG_REG_R0, TCG_REG_R0); /* cc = 0 */
 }
 
+static const TCGOutOpBinary outop_smax = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_smin = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_umax = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_umin = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index d6ed9d3362..35cd14a5b6 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1917,6 +1917,22 @@ static void tcg_out_set_borrow(TCGContext *s)
     tcg_out_set_carry(s);  /* borrow == carry */
 }
 
+static const TCGOutOpBinary outop_smax = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_smin = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_umax = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_umin = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 1b61668517..4cd1c1431c 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -894,6 +894,22 @@ static void tcg_out_set_borrow(TCGContext *s)
     tcg_out_op_v(s, INDEX_op_tci_setcarry);  /* borrow == carry */
 }
 
+static const TCGOutOpBinary outop_smax = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_smin = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_umax = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_umin = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
index 37acba9045..2c8f1f3e58 100644
--- a/tcg/x86_64/tcg-target.c.inc
+++ b/tcg/x86_64/tcg-target.c.inc
@@ -2977,6 +2977,22 @@ static void tcg_out_set_borrow(TCGContext *s)
     tcg_out8(s, OPC_STC);
 }
 
+static const TCGOutOpBinary outop_smax = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_smin = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_umax = {
+    .base.static_constraint = C_NotImplemented,
+};
+
+static const TCGOutOpBinary outop_umin = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-- 
2.43.0


