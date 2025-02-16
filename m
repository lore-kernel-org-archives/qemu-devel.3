Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8A0C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjntc-0003L8-1g; Sun, 16 Feb 2025 18:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnt3-0001xY-6n
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:22 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnsz-000600-RJ
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:20 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-220c92c857aso58818515ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747836; x=1740352636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wVP6hrz4GA0t71shfxl/LLR2DqKf8izwR4xVE+Uc7f8=;
 b=gkyth0cwkjo4zj7YGGTU/Gz6fmbH3TUvLI6JmcFLoM/7vQ1NOddlCmyA3rOJ0aSNRo
 j+slv0bENxSF/i1pZ6M9vWheJBx9Z3Dx8YBnv4lrS8zgP1otLpqRDJOmQywf2Y6G9tkG
 oDUQxlZMbfWhT8VgpLYYKwb26mraWZaNm35LMfc8/qrhsnhnZaWbLaRQGq9QTDoOX4bY
 N6B7WCI53V7//erkTTmfSsYiAO2rAwzRBnmk10QFgtWkZByg9iF5+IuOSXTh4f/fK6IM
 01DuSBM4fEhcS0gMDn2Gv2jnEKSAYdT3V2p8m0DRuSLBpiJKzE54d+Xjyo0N5Z1S1dqb
 Y20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747836; x=1740352636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVP6hrz4GA0t71shfxl/LLR2DqKf8izwR4xVE+Uc7f8=;
 b=AsHR7aLpa05Wl6iuuC8kIUQzK0y9YhS8lhb8LAnq5KHxqQ3vZkNsh0r+UmkmkS3Qrr
 QSoszDwdxZL4EvPUUZqnITqrnLaxD4Iikqdp5h0rnqoNazOuO0cc1rxvIwgwTWPDPE5D
 EO5EiZfNQH8zyffupjSuUVCEAhRAf2tPwfXL25hJ7zxA5X50PWvtPWUrkdLkrrf8DCRM
 4+3U9aFB8K5iFc9d68RCypxfcvi92eE2uPmE/h0t6gszJ/w2G2gbFtRt/6ZnyR7/Xkqf
 +wcmHTV6ss/VWPp40w50pISyAJ4WqMeiq1DcAaeEHqnDMqKClG4tTITB/B2tGlaauLaT
 654g==
X-Gm-Message-State: AOJu0YzGouN/rly/puGOeu24byhqcGDMZHuwbU3Z9q1rMcHMxO9cCz07
 bnQy48OdZefPo1Tr3vSWlyPmP4pGN7jF1p4qJoaJsUmh+JgpYHnmz9XAUEwKHdtsVM5IV9lZryj
 D
X-Gm-Gg: ASbGncvJ4x6cbIQcJVxNwypGa+FkTyts7AtM8H/0B/KgjX09zDsoXW8/16VFTfZKdba
 r+MAbzj4vrjlv1a6CzAiiDt6jcMJhHCn3bR1H9LZUNrxTvEWJZHSEdYxZPgvWo4sqm1vkO2vHGh
 w5e1z+5TG3FO/g730InddZ71xbY2z15D7/8SXksJEBUcvI3GsRrevLAeVfn23CGmc/KIKAQ+y+m
 XA8yDpSI2WumP6joUr1qMJ6lFv5SIB2faX8ctl9VY/YjH3T+8runPG/OW001LdAYaQl7V8OmLXP
 BMrZ6d2K3CWxxQdLhRcfkjgzifDaV+HW/bWq7thqfSXJ09Y=
X-Google-Smtp-Source: AGHT+IEmxdtH6lVMMD5z+gvw9Kp+9vq2oDmVygiHo4Q0LnOCgocLcfy4ur2Zm67/AYAaQppptDniMg==
X-Received: by 2002:a17:902:ce89:b0:216:5db1:5dc1 with SMTP id
 d9443c01a7336-221043951fbmr115300455ad.1.1739747836025; 
 Sun, 16 Feb 2025 15:17:16 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 084/162] tcg: Convert brcond2_i32 to TCGOutOpBrcond2
Date: Sun, 16 Feb 2025 15:08:53 -0800
Message-ID: <20250216231012.2808572-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
 tcg/mips/tcg-target-con-set.h |  2 +-
 tcg/tcg.c                     | 30 +++++++++++++++++
 tcg/arm/tcg-target.c.inc      | 20 +++++++----
 tcg/i386/tcg-target.c.inc     | 62 ++++++++++++++++++-----------------
 tcg/mips/tcg-target.c.inc     | 19 ++++++-----
 tcg/ppc/tcg-target.c.inc      | 25 +++++++-------
 tcg/tci/tcg-target.c.inc      | 30 +++++++++--------
 7 files changed, 118 insertions(+), 70 deletions(-)

diff --git a/tcg/mips/tcg-target-con-set.h b/tcg/mips/tcg-target-con-set.h
index f5e4852b56..9d0ea73f4f 100644
--- a/tcg/mips/tcg-target-con-set.h
+++ b/tcg/mips/tcg-target-con-set.h
@@ -13,7 +13,7 @@ C_O0_I1(r)
 C_O0_I2(r, rz)
 C_O0_I2(rz, r)
 C_O0_I3(rz, rz, r)
-C_O0_I4(rz, rz, rz, rz)
+C_O0_I4(r, r, rz, rz)
 C_O1_I1(r, r)
 C_O1_I2(r, 0, rz)
 C_O1_I2(r, r, r)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 4d8803e1c2..4e092ccf2e 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -994,6 +994,13 @@ typedef struct TCGOutOpBrcond {
                    TCGReg a1, tcg_target_long a2, TCGLabel *label);
 } TCGOutOpBrcond;
 
+typedef struct TCGOutOpBrcond2 {
+    TCGOutOp base;
+    void (*out)(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
+                TCGArg bl, bool const_bl,
+                TCGArg bh, bool const_bh, TCGLabel *l);
+} TCGOutOpBrcond2;
+
 typedef struct TCGOutOpDivRem {
     TCGOutOp base;
     void (*out_rr01r)(TCGContext *s, TCGType type,
@@ -1087,6 +1094,10 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
+
+#if TCG_TARGET_REG_BITS == 32
+    OUTOP(INDEX_op_brcond2_i32, TCGOutOpBrcond2, outop_brcond2),
+#endif
 };
 
 #undef OUTOP
@@ -5528,6 +5539,25 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+#if TCG_TARGET_REG_BITS == 32
+    case INDEX_op_brcond2_i32:
+        {
+            const TCGOutOpBrcond2 *out = &outop_brcond2;
+            TCGCond cond = new_args[4];
+            TCGLabel *label = arg_label(new_args[5]);
+
+            tcg_debug_assert(!const_args[0]);
+            tcg_debug_assert(!const_args[1]);
+            out->out(s, cond, new_args[0], new_args[1],
+                     new_args[2], const_args[2],
+                     new_args[3], const_args[3], label);
+        }
+        break;
+#else
+    case INDEX_op_brcond2_i32:
+        g_assert_not_reached();
+#endif
+
     default:
         if (def->flags & TCG_OPF_VECTOR) {
             tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 993564d424..23b62671c7 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2259,6 +2259,19 @@ static const TCGOutOpMovcond outop_movcond = {
     .out = tgen_movcond,
 };
 
+static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
+                         TCGArg bl, bool const_bl, TCGArg bh, bool const_bh,
+                         TCGLabel *l)
+{
+    cond = tcg_out_cmp2(s, cond, al, ah, bl, const_bl, bh, const_bh);
+    tcg_out_goto_label(s, tcg_cond_to_arm_cond[cond], l);
+}
+
+static const TCGOutOpBrcond2 outop_brcond2 = {
+    .base.static_constraint = C_O0_I4(r, r, rI, rI),
+    .out = tgen_brcond2,
+};
+
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -2341,11 +2354,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mov_reg(s, COND_AL, args[0], a0);
         break;
 
-    case INDEX_op_brcond2_i32:
-        c = tcg_out_cmp2(s, args[4], args[0], args[1], args[2], const_args[2],
-                         args[3], const_args[3]);
-        tcg_out_goto_label(s, tcg_cond_to_arm_cond[c], arg_label(args[5]));
-        break;
     case INDEX_op_setcond2_i32:
         c = tcg_out_cmp2(s, args[5], args[1], args[2], args[3], const_args[3],
                          args[4], const_args[4]);
@@ -2450,8 +2458,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         return C_O2_I4(r, r, r, r, rIN, rIK);
     case INDEX_op_sub2_i32:
         return C_O2_I4(r, r, rI, rI, rIN, rIK);
-    case INDEX_op_brcond2_i32:
-        return C_O0_I4(r, r, rI, rI);
     case INDEX_op_setcond2_i32:
         return C_O1_I4(r, r, r, rI, rI);
 
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 465f03e864..cd552b329b 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1662,42 +1662,52 @@ static const TCGOutOpBrcond outop_brcond = {
     .out_ri = tgen_brcondi,
 };
 
-#if TCG_TARGET_REG_BITS == 32
-static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
-                            const int *const_args, bool small)
+static void tcg_out_brcond2(TCGContext *s, TCGCond cond, TCGReg al,
+                            TCGReg ah, TCGArg bl, bool blconst,
+                            TCGArg bh, bool bhconst,
+                            TCGLabel *label_this, bool small)
 {
     TCGLabel *label_next = gen_new_label();
-    TCGLabel *label_this = arg_label(args[5]);
-    TCGCond cond = args[4];
 
     switch (cond) {
     case TCG_COND_EQ:
     case TCG_COND_TSTEQ:
         tcg_out_brcond(s, 0, tcg_invert_cond(cond),
-                       args[0], args[2], const_args[2], label_next, 1);
-        tcg_out_brcond(s, 0, cond, args[1], args[3], const_args[3],
-                       label_this, small);
+                       al, bl, blconst, label_next, true);
+        tcg_out_brcond(s, 0, cond, ah, bh, bhconst, label_this, small);
         break;
 
     case TCG_COND_NE:
     case TCG_COND_TSTNE:
-        tcg_out_brcond(s, 0, cond, args[0], args[2], const_args[2],
-                       label_this, small);
-        tcg_out_brcond(s, 0, cond, args[1], args[3], const_args[3],
-                       label_this, small);
+        tcg_out_brcond(s, 0, cond, al, bl, blconst, label_this, small);
+        tcg_out_brcond(s, 0, cond, ah, bh, bhconst, label_this, small);
         break;
 
     default:
-        tcg_out_brcond(s, 0, tcg_high_cond(cond), args[1],
-                       args[3], const_args[3], label_this, small);
+        tcg_out_brcond(s, 0, tcg_high_cond(cond),
+                       ah, bh, bhconst, label_this, small);
         tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond(s, 0, tcg_unsigned_cond(cond), args[0],
-                       args[2], const_args[2], label_this, small);
+        tcg_out_brcond(s, 0, tcg_unsigned_cond(cond),
+                       al, bl, blconst, label_this, small);
         break;
     }
     tcg_out_label(s, label_next);
 }
+
+static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al,
+                         TCGReg ah, TCGArg bl, bool blconst,
+                         TCGArg bh, bool bhconst, TCGLabel *l)
+{
+    tcg_out_brcond2(s, cond, al, ah, bl, blconst, bh, bhconst, l, false);
+}
+
+#if TCG_TARGET_REG_BITS != 32
+__attribute__((unused))
 #endif
+static const TCGOutOpBrcond2 outop_brcond2 = {
+    .base.static_constraint = C_O0_I4(r, r, ri, ri),
+    .out = tgen_brcond2,
+};
 
 static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
                             TCGReg dest, TCGReg arg1, TCGArg arg2,
@@ -1854,11 +1864,8 @@ static const TCGOutOpSetcond outop_negsetcond = {
 static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
                              const int *const_args)
 {
-    TCGArg new_args[6];
     TCGLabel *label_true, *label_over;
 
-    memcpy(new_args, args+1, 5*sizeof(TCGArg));
-
     if (args[0] == args[1] || args[0] == args[2]
         || (!const_args[3] && args[0] == args[3])
         || (!const_args[4] && args[0] == args[4])) {
@@ -1867,8 +1874,8 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
         label_true = gen_new_label();
         label_over = gen_new_label();
 
-        new_args[5] = label_arg(label_true);
-        tcg_out_brcond2(s, new_args, const_args+1, 1);
+        tcg_out_brcond2(s, args[5], args[1], args[2], args[3], const_args[3],
+                        args[4], const_args[4], label_true, true);
 
         tcg_out_movi(s, TCG_TYPE_I32, args[0], 0);
         tcg_out_jxx(s, JCC_JMP, label_over, 1);
@@ -1884,9 +1891,10 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
         tcg_out_movi(s, TCG_TYPE_I32, args[0], 0);
 
         label_over = gen_new_label();
-        new_args[4] = tcg_invert_cond(new_args[4]);
-        new_args[5] = label_arg(label_over);
-        tcg_out_brcond2(s, new_args, const_args+1, 1);
+        tcg_out_brcond2(s, tcg_invert_cond(args[5]), args[1], args[2],
+                        args[3], const_args[3],
+                        args[4], const_args[4], label_over, true);
+
 
         tgen_arithi(s, ARITH_ADD, args[0], 1, 0);
         tcg_out_label(s, label_over);
@@ -3233,9 +3241,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         break;
 
 #if TCG_TARGET_REG_BITS == 32
-    case INDEX_op_brcond2_i32:
-        tcg_out_brcond2(s, args, const_args, 0);
-        break;
     case INDEX_op_setcond2_i32:
         tcg_out_setcond2(s, args, const_args);
         break;
@@ -4007,9 +4012,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
         return C_O0_I3(L, L, L);
 
-    case INDEX_op_brcond2_i32:
-        return C_O0_I4(r, r, ri, ri);
-
     case INDEX_op_setcond2_i32:
         return C_O1_I4(r, r, r, ri, ri);
 
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 2b48a0b3bf..776c34f349 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1074,8 +1074,9 @@ static void tcg_out_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
     tcg_out_setcond_end(s, ret, tmpflags);
 }
 
-static void tcg_out_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
-                            TCGReg bl, TCGReg bh, TCGLabel *l)
+static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
+                         TCGArg bl, bool const_bl,
+                         TCGArg bh, bool const_bh, TCGLabel *l)
 {
     int tmpflags = tcg_out_setcond2_int(s, cond, TCG_TMP0, al, ah, bl, bh);
     TCGReg tmp = tmpflags & ~SETCOND_FLAGS;
@@ -1086,6 +1087,14 @@ static void tcg_out_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
     tcg_out_nop(s);
 }
 
+#if TCG_TARGET_REG_BITS != 32
+__attribute__((unused))
+#endif
+static const TCGOutOpBrcond2 outop_brcond2 = {
+    .base.static_constraint = C_O0_I4(r, r, rz, rz),
+    .out = tgen_brcond2,
+};
+
 static void tgen_movcond(TCGContext *s, TCGType type, TCGCond cond,
                          TCGReg ret, TCGReg c1, TCGArg c2, bool const_c2,
                          TCGArg v1, bool const_v1, TCGArg v2, bool const_v2)
@@ -2303,10 +2312,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_brcond2_i32:
-        tcg_out_brcond2(s, args[4], a0, a1, a2, args[3], arg_label(args[5]));
-        break;
-
     case INDEX_op_setcond2_i32:
         tcg_out_setcond2(s, args[5], a0, a1, a2, args[3], args[4]);
         break;
@@ -2407,8 +2412,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         return C_O2_I4(r, r, rz, rz, rN, rN);
     case INDEX_op_setcond2_i32:
         return C_O1_I4(r, rz, rz, rz, rz);
-    case INDEX_op_brcond2_i32:
-        return C_O0_I4(rz, rz, rz, rz);
 
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, r);
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 669c5eae4a..cde8a55918 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2283,14 +2283,23 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
     tcg_out_rlw(s, RLWINM, args[0], TCG_REG_R0, CR_EQ + 0*4 + 1, 31, 31);
 }
 
-static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
-                            const int *const_args)
+static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
+                         TCGArg bl, bool const_bl,
+                         TCGArg bh, bool const_bh, TCGLabel *l)
 {
-    tcg_out_cmp2(s, args[4], args[0], args[1], args[2], const_args[2],
-                 args[3], const_args[3]);
-    tcg_out_bc_lab(s, TCG_COND_EQ, arg_label(args[5]));
+    assert(TCG_TARGET_REG_BITS == 32);
+    tcg_out_cmp2(s, cond, al, ah, bl, const_bl, bh, const_bh);
+    tcg_out_bc_lab(s, TCG_COND_EQ, l);
 }
 
+#if TCG_TARGET_REG_BITS != 32
+__attribute__((unused))
+#endif
+static const TCGOutOpBrcond2 outop_brcond2 = {
+    .base.static_constraint = C_O0_I4(r, r, rU, rC),
+    .out = tgen_brcond2,
+};
+
 static void tcg_out_mb(TCGContext *s, TCGArg a0)
 {
     uint32_t insn;
@@ -3450,10 +3459,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mem_long(s, STD, STDX, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_brcond2_i32:
-        tcg_out_brcond2(s, args, const_args);
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
         break;
@@ -4272,8 +4277,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
         return C_O1_I2(r, 0, rZ);
-    case INDEX_op_brcond2_i32:
-        return C_O0_I4(r, r, rU, rC);
     case INDEX_op_setcond2_i32:
         return C_O1_I4(r, r, r, rU, rC);
     case INDEX_op_add2_i64:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 99a5744ab4..0fe365e2d4 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -87,11 +87,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub2_i64:
         return C_O2_I4(r, r, r, r, r, r);
 
-#if TCG_TARGET_REG_BITS == 32
-    case INDEX_op_brcond2_i32:
-        return C_O0_I4(r, r, r, r);
-#endif
-
     case INDEX_op_setcond2_i32:
         return C_O1_I4(r, r, r, r, r);
 
@@ -985,6 +980,23 @@ static const TCGOutOpMovcond outop_movcond = {
     .out = tgen_movcond,
 };
 
+static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
+                         TCGArg bl, bool const_bl,
+                         TCGArg bh, bool const_bh, TCGLabel *l)
+{
+    tcg_out_op_rrrrrc(s, INDEX_op_setcond2_i32, TCG_REG_TMP,
+                      al, ah, bl, bh, cond);
+    tcg_out_op_rl(s, INDEX_op_brcond, TCG_REG_TMP, l);
+}
+
+#if TCG_TARGET_REG_BITS != 32
+__attribute__((unused))
+#endif
+static const TCGOutOpBrcond2 outop_brcond2 = {
+    .base.static_constraint = C_O0_I4(r, r, r, r),
+    .out = tgen_brcond2,
+};
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -1055,14 +1067,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                           args[3], args[4], args[5]);
         break;
 
-#if TCG_TARGET_REG_BITS == 32
-    case INDEX_op_brcond2_i32:
-        tcg_out_op_rrrrrc(s, INDEX_op_setcond2_i32, TCG_REG_TMP,
-                          args[0], args[1], args[2], args[3], args[4]);
-        tcg_out_op_rl(s, INDEX_op_brcond, TCG_REG_TMP, arg_label(args[5]));
-        break;
-#endif
-
     case INDEX_op_qemu_ld_i64:
     case INDEX_op_qemu_st_i64:
         if (TCG_TARGET_REG_BITS == 32) {
-- 
2.43.0


