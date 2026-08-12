Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EF4C5CFC1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 00:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtwsp-00042m-Se; Tue, 11 Aug 2026 20:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtwso-000428-Ju
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 20:31:50 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtwsm-0000S8-DE
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 20:31:50 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-84e84a6c4bfso457978b3a.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 17:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786494707; x=1787099507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=n0Sq380F8CEtqmJwNPMBwWxWmJlUlcFSp9OvTFf/Jbk=;
 b=c2bm84RfPZdGwm0uDQXxD7HBXHn8MH7V2B5pnt6C5DdtV8XXJAztIokEDBxXJhFugO
 kFqgFmB2KBZUtg5ornsMAxsbazfE4NS1bf6mmF3GW+x/e1xein2v+BwcZ+KdDd1k485N
 hOwjY4uVST3heIcqx8SeOpwXVQYjxLvGmsksvVCHTusdWi9FtK88Gow9LyI4SgP/SMzW
 6vpyyjPrw112V45tbu0T2Q042KhZK+aFq/wD//mrNfXvMJXkukUiq0236ZHJGQzfDel4
 aLci31FTUfy+n0NBCMo4xPx1cQCFx4Rjfgp7SAzT3CbIHPMQVa7eT4rfnfRKkeaJTgoq
 jBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786494707; x=1787099507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=n0Sq380F8CEtqmJwNPMBwWxWmJlUlcFSp9OvTFf/Jbk=;
 b=U3i7MVF5N00/P1wi8jkVLKsj19QoV2NLmxFRJXiv2IrG5jipDwwZEz1E9HqEd3j3Qz
 8Kj1eGNqNgwgVcXcyEKmHNBnW/WXU8hu195+piH0wQ6lkwskPWD8P+QzlGpmCWBLyh6u
 KSGZ1k8X/OHk0/zcyKZEK/IweJzyAqcWel79aq/yameM28VbH6tCv6T37fzovF3Cst/J
 KqMI+dOQ5OGUKIvs2Wwb4SOwJ48Sg+HU/91ka1x7kghNA8dFzow6GiGlWXocIsr2BSY2
 JrCvBShpPyK5Virx1QgJW0MS3fOrIyBFW+qjq3vdnaFyHWLTsP3rF8dnEmV9BtFuQvO+
 0n3w==
X-Gm-Message-State: AOJu0YyVRZgPMitH0cKrNcCj07UzjUwaxk7dhBpSvkJQdbbeZbCLHqzm
 MZfbbhXk3103eM+2rYr2zerhMB/EIzycWF8ZAEj0xFCwPTo5rxZfZAOkjooDAQQSJsxKGuGEVXy
 aB/BX
X-Gm-Gg: AR+sD10HucfHnztjGXR5LAc9cMfHgzLbIjr0FUZctVR4/PCDEDugAmw0zujlD61MJhi
 k+wyQL0djqJUdEXNmwX7+kCSY0ntlqiPRsbw8a9DC50DO8aqADZVZHEqUNVWTHFUEGQioQ4WfSw
 bEtuzomJ44cBncMmr1fPZahlCdabof0u0LrkPqGtlvPL5hUIShNRJIe4z97lptI0apGVDsZJWMx
 b1Nnoiee6xiOnoTSOXZ5YX/5K9gLQg9Ssof72B9kcfelcOeCXs+vsmIFbU73PmD6FTzYVBE/cNu
 NzqyqFG3ao3t5hO/qccAcbWtksB+vS2WClrirh5tfHwaK37xgYtKK4GV/pXYSsDQL2T2Dw/4KFX
 LhKz+dzVX9Ge/uBzm6y1G+l+ztDd3yGAucG+ux+qUPBae50yFXK6HAzIW4TS1Cp2Lj8NRYk1VPx
 9fIuejlFOr+oj+4TiYVjKhjdZJb/zhHxc6XqliUwUMW+JlWW4J1W8SKo7CmNFRgCLdBX16YJ96H
 IhXrWE2I3xSTT8azB/A
X-Received: by 2002:a05:6a00:4fc4:b0:84e:242:4bb2 with SMTP id
 d2e1a72fcca58-84fb6481c1dmr784247b3a.4.1786494706594; 
 Tue, 11 Aug 2026 17:31:46 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fb1f2587fsm321466b3a.49.2026.08.11.17.31.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 17:31:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] tcg: Add integer min/max opcodes
Date: Tue, 11 Aug 2026 17:31:37 -0700
Message-ID: <20260812003143.225228-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812003143.225228-1-richard.henderson@linaro.org>
References: <20260812003143.225228-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            |  4 +++
 tcg/tcg-op.c                     | 48 ++++++++++++++++++++++++++------
 tcg/tcg.c                        |  4 +++
 docs/devel/tcg-ops.rst           | 14 +++++++++-
 tcg/aarch64/tcg-target.c.inc     | 16 +++++++++++
 tcg/loongarch64/tcg-target.c.inc | 16 +++++++++++
 tcg/ppc64/tcg-target.c.inc       | 16 +++++++++++
 tcg/riscv64/tcg-target.c.inc     | 16 +++++++++++
 tcg/s390x/tcg-target.c.inc       | 16 +++++++++++
 tcg/sparc64/tcg-target.c.inc     | 16 +++++++++++
 tcg/tci/tcg-target.c.inc         | 16 +++++++++++
 tcg/x86_64/tcg-target.c.inc      | 16 +++++++++++
 12 files changed, 189 insertions(+), 9 deletions(-)

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
index 4c2207c6af..54f7906cb7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -5512,6 +5512,10 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
index f2e9255dd9..d30db9ea65 100644
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
 
@@ -512,7 +524,7 @@ Misc
 
      - | Reverse the 64 bits of input *t1* with output in *dest*.
 
-Conditional moves
+Conditional motes
 -----------------
 
 .. list-table::
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


