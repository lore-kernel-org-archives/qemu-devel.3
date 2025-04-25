Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DC7C369DF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R9P-0007nw-Oh; Fri, 25 Apr 2025 18:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7a-0004ub-Bc
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:10 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7V-0001K4-Lk
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:09 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ff6cf448b8so3790768a91.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618523; x=1746223323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jfNBV8B38fj0nY0KAprU+nzkvacgdMj8EkpqHWiJoQE=;
 b=ZEE8Q4y5Y4Ju6plpYQfCKP2P6LXsNAdaD3pn34TD2lzGGnv6+60t/ZR4uxr/kURT33
 toWFOSr3x6QIRvdK/nyipCcx7x6giV0Q56e0u7cswMLtgy90PrfrPE4isuY6MwtggzEX
 3XczW4D+u2bTwAKzNOOS/vdHgt+650Jwdz9BH8/XuVRFqOp6jH60hJWhJmm8jMVeA+en
 ZOLK1uf8NQGB7XqZjCQWibDOFuy8HfkL+YrAcl01TX4eePZDq1hfM1KY/wbA38TRKhO6
 wJ1jgUgbbKwOEBTgsGFJsT1TlEs6e7Wdn06+pYfEWtZBMb3jL69+2W/ysLTp9GxBEGHe
 L85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618523; x=1746223323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jfNBV8B38fj0nY0KAprU+nzkvacgdMj8EkpqHWiJoQE=;
 b=igGfEO5rVpTcD8vfuW+Utl9+xMb1Pm81uZTQtDhM8gd+ZpvADAlgw5hTuzoA7JQvee
 8QF5jcnjzaRL83z/m+ymZEUdirhxAqPpC7cDBZI3aNPI2LLPD5ApT4uQ53TtCkD/9uR6
 JNiDasIORTIm0lQ+/C3TtRVKof55LNYh5bwYev/NwW6Nn+9xBqI7Z2xKhuFbv5NtYCNS
 ElIsaS6fDYuKl3IXe/Q+1pfG/OWo4+C6lqTw3t9emR74On6tiHQ+3/EuLkCwM2a9/ChG
 POJQN7hqDVkU+8FsF34WghoKyrkKNt5aNp79idQthdk9EtF479eDPQEIcHsvXa/jgiVa
 YcqQ==
X-Gm-Message-State: AOJu0YydLA0NmnhVf4OB8dnZjmogUyTAWt9G3VARs6xgcn6GmtvZ612U
 2Q35S9d9lyVOopHDjbtiz1AT0sBvm3ArCC4EKCq57+jonoZhZzf784hFCWJjzHG0tabNzkL3IGM
 K
X-Gm-Gg: ASbGnctfaW/LngOVRNTFrocXrAgncXRgtOUVfP/N3TCyVW5pJXdu40ygy85HNMxHfX0
 4SMeTXpESAFwSKJXdoNst/i4uaNls1qR4usN45wVLiAlzps/rTDTrKwdLM+pzvW2LcwR10Fz3G2
 OaXvWlfmDimk36yOtQ/uet+fGg6ohT8kUQtEMv3WoZtHEYaKiBBz6PWv2rJcSv1ibpBPhoQZIJj
 WO+jzcguoXTuhHtM0Jj2H8D9aCoojUYptvnzQkaoKOlw/fK5SFRiofR+vL4ly463cgeEQ9dbyJn
 KCZI3S/+zcDxg2rrPJuHKwbQziG5Y4n3mnSFxhNzW+neFnueAbeTkCL+R8rmgJn3mXCpdY4Eqzc
 =
X-Google-Smtp-Source: AGHT+IHqgbcu2lftpkAa2g/mPYeAK6ZvufqHmGkGrzJZHmdz34aOuUpbVQRX0F0Stl8jDVM7urdV5w==
X-Received: by 2002:a17:90b:2d48:b0:309:d115:b5f7 with SMTP id
 98e67ed59e1d1-309f7e702b7mr6323669a91.24.1745618523275; 
 Fri, 25 Apr 2025 15:02:03 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 089/159] tcg: Convert brcond2_i32 to TCGOutOpBrcond2
Date: Fri, 25 Apr 2025 14:53:43 -0700
Message-ID: <20250425215454.886111-90-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index 3f57f6aafd..2a39ce3665 100644
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
@@ -5540,6 +5551,25 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
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
index cebd783285..1c42df1092 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2253,6 +2253,19 @@ static const TCGOutOpMovcond outop_movcond = {
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
@@ -2335,11 +2348,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
@@ -2444,8 +2452,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         return C_O2_I4(r, r, r, r, rIN, rIK);
     case INDEX_op_sub2_i32:
         return C_O2_I4(r, r, rI, rI, rIN, rIK);
-    case INDEX_op_brcond2_i32:
-        return C_O0_I4(r, r, rI, rI);
     case INDEX_op_setcond2_i32:
         return C_O1_I4(r, r, r, rI, rI);
 
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index ae3a53a18a..b7708c945f 100644
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
index 3ce71a1c8d..9a9b1bb09a 100644
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
@@ -2297,10 +2306,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_brcond2_i32:
-        tcg_out_brcond2(s, args[4], a0, a1, a2, args[3], arg_label(args[5]));
-        break;
-
     case INDEX_op_setcond2_i32:
         tcg_out_setcond2(s, args[5], a0, a1, a2, args[3], args[4]);
         break;
@@ -2401,8 +2406,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
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


