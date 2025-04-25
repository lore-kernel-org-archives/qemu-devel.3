Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5D1C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R4U-0002FI-5V; Fri, 25 Apr 2025 17:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4A-0000zG-9T
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:38 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R47-0000oH-9C
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:37 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-223fb0f619dso32093245ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618313; x=1746223113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NEcjh4ykQ9q0uBI2uMVSi64L7HzQUSGnpl2mE/nOKz4=;
 b=lxFXAyqRUPbH1L5MbPuIXrPsRelLprMorircurfP8Njmd4rKl+fclQrgHDJnM8q5eO
 HKG8ML6GgrAzvZ/gW6GeOdQ/srAnpZa90OM3VO7Hxk1686Bk75pwDbNaqknA9I9S5F35
 mG4+IyfYqrA3tG+flBByb9dxi4QiH+G6rUYh2Cs/YIRmhr45WV3N9vyFDcJTOdmX2Y7H
 xO1Ki8G3pPy0YRfEYYMfVzVDm5Mdr2MIm8oH6NHBcsGc9IkS0xCX8fiWhK8zdhqgndfs
 tww0pS3IhIcW3FZDP7B0bWs8jX4ryhv2iZhGKo7hsdP764pxwZp6qlG+Fv/3a5lJ5Iv/
 HoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618313; x=1746223113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NEcjh4ykQ9q0uBI2uMVSi64L7HzQUSGnpl2mE/nOKz4=;
 b=VK2hLMNFbOpbeNcDvY5vK34GWdZAoLCAhqFhjA2yXnMTJqhccrMtdoFrroJDgLfDij
 IidT1Xu4Y4tSB1cH7ZJR6+rTATdcDiQPzWJYRLwTohsqueY5xwqKSxzKscCq3UMGz7jt
 oHkojBLOPQBE8yofbv7p8Q7jQEBZev658dVxAHB/vM/NpPMkTbV0v28mtbRnscoUQUMR
 L0LQMw+HEctI3Wpy99XsFM5ZAKdU/i52mYfFw1sPvWadJiHlf84qNHTqrfwK1GiUPkVq
 sQeCngkZBtsgstmcBVGQuODM41issDb6bi2O9sNP6suaoh4Ed8dmNkXS3liVNl3K6TL7
 lZBg==
X-Gm-Message-State: AOJu0YxqfUVGxr0gHBq/NdV8iVTVWOaAuiFs9of8HzjBWd/fNycdd0hR
 qLOq3jWFfFEuYf37Xnhp5NyprrKYy1BfB0j4jTPzzPh3STULH77Gd3BLfvr+wkUh9tjv5sj3wwS
 t
X-Gm-Gg: ASbGnct873AILqQ5apGuPnWKi7StHG2+rfIjQgz46lrkVz/csuhafI+cpuoflHcgE38
 j72i2PY43EG7RriAJ4vVZbWcDY7F+iU5gXOlltuvdQ1d/PjDBsO6diIbxpJOK8i59qUQBTOTMBL
 xY8PaAGFjbC3zhG38kIKqRnXdZLNgKhM4HAU6FcXERupDjqYf/VMa0oGKNAPFUBmsLMbLM6w84G
 3XSp/CR6K9Fsl7EtWhxiHMZeGkiv+t6F8enboNG7AVI5dgvTGkbgMAAyTjq+gn9zzENsqzlvL6t
 YRYSDbwnmC0WWCBdIGL3wqbV6X2nMGNqK1+61qnM6mmWfErt4ZumbA4KSoVbvCfl7XnRoowrXNC
 zggPK+yibbQ==
X-Google-Smtp-Source: AGHT+IHFy10oDqIvJY68sEZv5p3WYEK3YUjBlBU2r/yPVD7NOELOTXr8hpUHiYtfMbtHkUtOKKmDtg==
X-Received: by 2002:a17:903:244e:b0:215:4a4e:9262 with SMTP id
 d9443c01a7336-22dbf5d9f1emr50515975ad.8.1745618313321; 
 Fri, 25 Apr 2025 14:58:33 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm37749595ad.17.2025.04.25.14.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:58:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 049/159] tcg: Convert div2 to TCGOutOpDivRem
Date: Fri, 25 Apr 2025 14:53:03 -0700
Message-ID: <20250425215454.886111-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
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
 tcg/tcg.c                        | 24 +++++++++++++++--
 tcg/aarch64/tcg-target.c.inc     |  4 +++
 tcg/arm/tcg-target.c.inc         |  4 +++
 tcg/i386/tcg-target.c.inc        | 17 ++++++++----
 tcg/loongarch64/tcg-target.c.inc |  4 +++
 tcg/mips/tcg-target.c.inc        |  4 +++
 tcg/ppc/tcg-target.c.inc         |  4 +++
 tcg/riscv/tcg-target.c.inc       |  4 +++
 tcg/s390x/tcg-target.c.inc       | 44 ++++++++++++++++----------------
 tcg/sparc64/tcg-target.c.inc     |  4 +++
 tcg/tci/tcg-target.c.inc         |  4 +++
 11 files changed, 88 insertions(+), 29 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 9aa6d40905..ef3af4157a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -986,6 +986,12 @@ typedef struct TCGOutOpBinary {
                     TCGReg a0, TCGReg a1, tcg_target_long a2);
 } TCGOutOpBinary;
 
+typedef struct TCGOutOpDivRem {
+    TCGOutOp base;
+    void (*out_rr01r)(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a4);
+} TCGOutOpDivRem;
+
 typedef struct TCGOutOpUnary {
     TCGOutOp base;
     void (*out_rr)(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1);
@@ -1022,6 +1028,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
     OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
+    OUTOP(INDEX_op_div2_i32, TCGOutOpDivRem, outop_divs2),
+    OUTOP(INDEX_op_div2_i64, TCGOutOpDivRem, outop_divs2),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
@@ -2265,7 +2273,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
         return TCG_TARGET_HAS_rem_i32;
-    case INDEX_op_div2_i32:
     case INDEX_op_divu2_i32:
         return TCG_TARGET_HAS_div2_i32;
     case INDEX_op_rotl_i32:
@@ -2325,7 +2332,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i64:
         return TCG_TARGET_HAS_rem_i64;
-    case INDEX_op_div2_i64:
     case INDEX_op_divu2_i64:
         return TCG_TARGET_HAS_div2_i64;
     case INDEX_op_rotl_i64:
@@ -5467,6 +5473,20 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_div2_i32:
+    case INDEX_op_div2_i64:
+        {
+            const TCGOutOpDivRem *out =
+                container_of(all_outop[op->opc], TCGOutOpDivRem, base);
+
+            /* Only used by x86 and s390x, which use matching constraints. */
+            tcg_debug_assert(new_args[0] == new_args[2]);
+            tcg_debug_assert(new_args[1] == new_args[3]);
+            tcg_debug_assert(!const_args[4]);
+            out->out_rr01r(s, type, new_args[0], new_args[1], new_args[4]);
+        }
+        break;
+
     default:
         if (def->flags & TCG_OPF_VECTOR) {
             tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 167c51c897..ea5766414d 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2168,6 +2168,10 @@ static const TCGOutOpBinary outop_divs = {
     .out_rrr = tgen_divs,
 };
 
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_divu(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 65d0ae83b2..ff750e2df8 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1880,6 +1880,10 @@ static const TCGOutOpBinary outop_divs = {
     .out_rrr = tgen_divs,
 };
 
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_divu(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index f258d6383b..9238e0e8e4 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2637,6 +2637,18 @@ static const TCGOutOpBinary outop_divs = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_divs2(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a4)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_IDIV, a4);
+}
+
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_O2_I3(a, d, 0, 1, r),
+    .out_rr01r = tgen_divs2,
+};
+
 static const TCGOutOpBinary outop_divu = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -2847,9 +2859,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(div2):
-        tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_IDIV, args[4]);
-        break;
     OP_32_64(divu2):
         tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_DIV, args[4]);
         break;
@@ -3789,8 +3798,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_movcond_i64:
         return C_O1_I4(r, r, reT, r, 0);
 
-    case INDEX_op_div2_i32:
-    case INDEX_op_div2_i64:
     case INDEX_op_divu2_i32:
     case INDEX_op_divu2_i64:
         return C_O2_I3(a, d, 0, 1, r);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index e82a62d09e..8ec46114b8 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1343,6 +1343,10 @@ static const TCGOutOpBinary outop_divs = {
     .out_rrr = tgen_divs,
 };
 
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_divu(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index ab9546f104..adbc7ee39d 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1733,6 +1733,10 @@ static const TCGOutOpBinary outop_divs = {
     .out_rrr = tgen_divs,
 };
 
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_divu(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index b347595131..1eb3e785c0 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2972,6 +2972,10 @@ static const TCGOutOpBinary outop_divs = {
     .out_rrr = tgen_divs,
 };
 
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_divu(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 74fa38d273..19c690c1c2 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2009,6 +2009,10 @@ static const TCGOutOpBinary outop_divs = {
     .out_rrr = tgen_divs,
 };
 
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_divu(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index f55309f48e..b434ce423a 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2246,6 +2246,28 @@ static const TCGOutOpBinary outop_divs = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_divs2(TCGContext *s, TCGType type,
+                       TCGReg a0, TCGReg a1, TCGReg a4)
+{
+    tcg_debug_assert((a1 & 1) == 0);
+    tcg_debug_assert(a0 == a1 + 1);
+    if (type == TCG_TYPE_I32) {
+        tcg_out_insn(s, RR, DR, a1, a4);
+    } else {
+        /*
+         * TODO: Move the sign-extend of the numerator from a2 into a3
+         * into the tcg backend, instead of in early expansion.  It is
+         * required for 32-bit DR, but not 64-bit DSGR.
+         */
+        tcg_out_insn(s, RRE, DSGR, a1, a4);
+    }
+}
+
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_O2_I3(o, m, 0, 1, r),
+    .out_rr01r = tgen_divs2,
+};
+
 static const TCGOutOpBinary outop_divu = {
     .base.static_constraint = C_NotImplemented,
 };
@@ -2527,13 +2549,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_div2_i32:
-        tcg_debug_assert(args[0] == args[2]);
-        tcg_debug_assert(args[1] == args[3]);
-        tcg_debug_assert((args[1] & 1) == 0);
-        tcg_debug_assert(args[0] == args[1] + 1);
-        tcg_out_insn(s, RR, DR, args[1], args[4]);
-        break;
     case INDEX_op_divu2_i32:
         tcg_debug_assert(args[0] == args[2]);
         tcg_debug_assert(args[1] == args[3]);
@@ -2702,19 +2717,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_insn(s, RRE, LRVGR, args[0], args[1]);
         break;
 
-    case INDEX_op_div2_i64:
-        /*
-         * ??? We get an unnecessary sign-extension of the dividend
-         * into op0 with this definition, but as we do in fact always
-         * produce both quotient and remainder using INDEX_op_div_i64
-         * instead requires jumping through even more hoops.
-         */
-        tcg_debug_assert(args[0] == args[2]);
-        tcg_debug_assert(args[1] == args[3]);
-        tcg_debug_assert((args[1] & 1) == 0);
-        tcg_debug_assert(args[0] == args[1] + 1);
-        tcg_out_insn(s, RRE, DSGR, args[1], args[4]);
-        break;
     case INDEX_op_divu2_i64:
         tcg_debug_assert(args[0] == args[2]);
         tcg_debug_assert(args[1] == args[3]);
@@ -3396,8 +3398,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_movcond_i64:
         return C_O1_I4(r, r, rC, rI, r);
 
-    case INDEX_op_div2_i32:
-    case INDEX_op_div2_i64:
     case INDEX_op_divu2_i32:
     case INDEX_op_divu2_i64:
         return C_O2_I3(o, m, 0, 1, r);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 3a3372d7aa..472ccd7608 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1352,6 +1352,10 @@ static const TCGOutOpBinary outop_divs = {
     .out_rri = tgen_divsi,
 };
 
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_divu_rJ(TCGContext *s, TCGType type,
                          TCGReg a0, TCGReg a1, TCGArg a2, bool c2)
 {
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index dfa8aecc7a..6646be224d 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -658,6 +658,10 @@ static const TCGOutOpBinary outop_divs = {
     .out_rrr = tgen_divs,
 };
 
+static const TCGOutOpDivRem outop_divs2 = {
+    .base.static_constraint = C_NotImplemented,
+};
+
 static void tgen_divu(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
-- 
2.43.0


