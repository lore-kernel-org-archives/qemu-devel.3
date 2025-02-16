Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E753C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjntv-0003gf-80; Sun, 16 Feb 2025 18:18:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnt4-00021b-VZ
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:26 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnt1-000604-HW
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:22 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2211cd4463cso11954345ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747837; x=1740352637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uXymZB/v48LtBalzgauUtiZ8l5/X5ghc+qsnj6D8nCg=;
 b=lkcM3aPfvvl1rotcT9vTetfkeHzNnoUsRipcoO8B2qyTYCIFvWDV6YDL4yhxvO22Qh
 IC3lmxMWh/wu/RMdMsbqxcALomDwWLT7ROCvMuKRMedEqt2UGwdLLQ5xpEJuZPgwuyGR
 GPHhBcG0DEC7Byh90P3xYbPPxBeHYx5vQT5AIbmTizShCEvOdCJ7rca/Vx8SLk4Akraf
 uTUfwglR+YCcUYkOASnOrdD7v81c55pyQkmb1vWrDxTgURrsS3Xe1VFq8v/xCDX3eQ5T
 oRiAr2l+C5o51qQMXChxgAgmjjxj1TWMtlOkj74HpwbJrCp4562qnsTnL6i4JCERIgH2
 c3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747837; x=1740352637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uXymZB/v48LtBalzgauUtiZ8l5/X5ghc+qsnj6D8nCg=;
 b=a0kPdS6PEIyPn2ZBTEF8tL38vBZcRBQeUgsEXno/ZnzM6ezcVlvMgXwfouRHmGEitn
 9sNSGQm/ZHdWzj/IZSH7GvWnTP1h5hbECkE8d3GaTKYkEq1ILnA0gOXDOZWa2EVhmq1f
 s4gVt6ilvEIOaSVbyXh9gISaQTGln4sDdcRH+K7ZFoyRRl3ZrEjcJ6IhwrhZhon8GS/G
 n69vFd9EXhoj2wXpXODtvi6INk7H4Frmi5g7vzCm4RT+oNwzrHqbV/fJz+Yrzwdm8NHB
 cUVekFi8L0F6SBheNEdBsUNYWonGSU+i5aQCRTI3E4HLjC8K1gcxiN19KCqw0i1U8F1Q
 fWMg==
X-Gm-Message-State: AOJu0YzFMKeFoFqf+t4g8u8ZDh5sYNf34SZBkYibjDBklMVq2bu8ua6M
 eZWEcv9CFQw09S/xKAcSObQbNwDlv+dCQGVqbCi5dwMrTDFGJoBrJ9mkhtGhqbUgyWgol0kCvIi
 T
X-Gm-Gg: ASbGncuR9ShNL3tm16Kd2dZ4HL2s3G8ttCmI6AHd6Lw6dR7yAralG3FAyRFJbztYFOc
 4LnN5auoYFap/XmEpErCH3/9sS21spimrIFYgve9t6P1tP4wZcn/kudvoXI7ieSNdHZjdM3Jnq1
 C9H53CJBiXDSZ1RU2JfdrPhegOMvMQ77G20MZ4lsb5ZMvl8bleyY5YUrIowA4V0F1uaytyKDD2T
 iZN7NKcEH2c7TJtQkGD3Vk87Z/woyfEJgrsBSvtuXhRDtMZ0FMJDudBMGTpq6VOYD495UGgqT8i
 fPfKvr3HcejgXnMYlYZsNgK+2KNkxM272Lmayiyjre75eA8=
X-Google-Smtp-Source: AGHT+IHHLzqXHE1skp99z+pUIc9e/i+lbycKEP3cIUN+wJ3JGgMXCs37BE0EMCdKKx50L2kHdh5lcg==
X-Received: by 2002:a17:903:60d:b0:215:aee1:7e3e with SMTP id
 d9443c01a7336-2210401368dmr96301665ad.5.1739747836740; 
 Sun, 16 Feb 2025 15:17:16 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 085/162] tcg: Convert setcond2_i32 to TCGOutOpSetcond2
Date: Sun, 16 Feb 2025 15:08:54 -0800
Message-ID: <20250216231012.2808572-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
 tcg/tcg.c                     | 19 ++++++++++
 tcg/arm/tcg-target.c.inc      | 25 ++++++------
 tcg/i386/tcg-target.c.inc     | 71 +++++++++++++++++------------------
 tcg/mips/tcg-target.c.inc     | 20 ++++++----
 tcg/ppc/tcg-target.c.inc      | 25 ++++++------
 tcg/tci/tcg-target.c.inc      | 24 ++++++++----
 7 files changed, 110 insertions(+), 76 deletions(-)

diff --git a/tcg/mips/tcg-target-con-set.h b/tcg/mips/tcg-target-con-set.h
index 9d0ea73f4f..4e09c9a400 100644
--- a/tcg/mips/tcg-target-con-set.h
+++ b/tcg/mips/tcg-target-con-set.h
@@ -25,7 +25,7 @@ C_O1_I2(r, r, rz)
 C_O1_I2(r, r, rzW)
 C_O1_I4(r, r, rz, rz, 0)
 C_O1_I4(r, r, rz, rz, rz)
-C_O1_I4(r, rz, rz, rz, rz)
+C_O1_I4(r, r, r, rz, rz)
 C_O2_I1(r, r, r)
 C_O2_I2(r, r, r, r)
 C_O2_I4(r, r, rz, rz, rN, rN)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 4e092ccf2e..d920a3158e 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1033,6 +1033,12 @@ typedef struct TCGOutOpSetcond {
                     TCGReg ret, TCGReg a1, tcg_target_long a2);
 } TCGOutOpSetcond;
 
+typedef struct TCGOutOpSetcond2 {
+    TCGOutOp base;
+    void (*out)(TCGContext *s, TCGCond cond, TCGReg ret, TCGReg al, TCGReg ah,
+                TCGArg bl, bool const_bl, TCGArg bh, bool const_bh);
+} TCGOutOpSetcond2;
+
 typedef struct TCGOutOpSubtract {
     TCGOutOp base;
     void (*out_rrr)(TCGContext *s, TCGType type,
@@ -1097,6 +1103,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
 
 #if TCG_TARGET_REG_BITS == 32
     OUTOP(INDEX_op_brcond2_i32, TCGOutOpBrcond2, outop_brcond2),
+    OUTOP(INDEX_op_setcond2_i32, TCGOutOpSetcond2, outop_setcond2),
 #endif
 };
 
@@ -5553,8 +5560,20 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
                      new_args[3], const_args[3], label);
         }
         break;
+    case INDEX_op_setcond2_i32:
+        {
+            const TCGOutOpSetcond2 *out = &outop_setcond2;
+            TCGCond cond = new_args[5];
+
+            tcg_debug_assert(!const_args[1]);
+            tcg_debug_assert(!const_args[2]);
+            out->out(s, cond, new_args[0], new_args[1], new_args[2],
+                     new_args[3], const_args[3], new_args[4], const_args[4]);
+        }
+        break;
 #else
     case INDEX_op_brcond2_i32:
+    case INDEX_op_setcond2_i32:
         g_assert_not_reached();
 #endif
 
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 23b62671c7..884d057177 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2272,13 +2272,25 @@ static const TCGOutOpBrcond2 outop_brcond2 = {
     .out = tgen_brcond2,
 };
 
+static void tgen_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
+                          TCGReg al, TCGReg ah,
+                          TCGArg bl, bool const_bl,
+                          TCGArg bh, bool const_bh)
+{
+    cond = tcg_out_cmp2(s, cond, al, ah, bl, const_bl, bh, const_bh);
+    finish_setcond(s, cond, ret, false);
+}
+
+static const TCGOutOpSetcond2 outop_setcond2 = {
+    .base.static_constraint = C_O1_I4(r, r, r, rI, rI),
+    .out = tgen_setcond2,
+};
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
     TCGArg a0, a1, a2, a3, a4, a5;
-    int c;
 
     switch (opc) {
     case INDEX_op_goto_ptr:
@@ -2354,14 +2366,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mov_reg(s, COND_AL, args[0], a0);
         break;
 
-    case INDEX_op_setcond2_i32:
-        c = tcg_out_cmp2(s, args[5], args[1], args[2], args[3], const_args[3],
-                         args[4], const_args[4]);
-        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[c], ARITH_MOV, args[0], 0, 1);
-        tcg_out_dat_imm(s, tcg_cond_to_arm_cond[tcg_invert_cond(c)],
-                        ARITH_MOV, args[0], 0, 0);
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
         break;
@@ -2458,9 +2462,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         return C_O2_I4(r, r, r, r, rIN, rIK);
     case INDEX_op_sub2_i32:
         return C_O2_I4(r, r, rI, rI, rIN, rIK);
-    case INDEX_op_setcond2_i32:
-        return C_O1_I4(r, r, r, rI, rI);
-
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, q);
     case INDEX_op_qemu_ld_i64:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index cd552b329b..6bd7e2663b 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1860,47 +1860,53 @@ static const TCGOutOpSetcond outop_negsetcond = {
     .out_rri = tgen_negsetcondi,
 };
 
-#if TCG_TARGET_REG_BITS == 32
-static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
-                             const int *const_args)
+static void tgen_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
+                          TCGReg al, TCGReg ah,
+                          TCGArg bl, bool const_bl,
+                          TCGArg bh, bool const_bh)
 {
-    TCGLabel *label_true, *label_over;
+    TCGLabel *label_over = gen_new_label();
 
-    if (args[0] == args[1] || args[0] == args[2]
-        || (!const_args[3] && args[0] == args[3])
-        || (!const_args[4] && args[0] == args[4])) {
-        /* When the destination overlaps with one of the argument
-           registers, don't do anything tricky.  */
-        label_true = gen_new_label();
-        label_over = gen_new_label();
+    if (ret == al || ret == ah
+        || (!const_bl && ret == bl)
+        || (!const_bh && ret == bh)) {
+        /*
+         * When the destination overlaps with one of the argument
+         * registers, don't do anything tricky.
+         */
+        TCGLabel *label_true = gen_new_label();
 
-        tcg_out_brcond2(s, args[5], args[1], args[2], args[3], const_args[3],
-                        args[4], const_args[4], label_true, true);
+        tcg_out_brcond2(s, cond, al, ah, bl, const_bl,
+                        bh, const_bh, label_true, true);
 
-        tcg_out_movi(s, TCG_TYPE_I32, args[0], 0);
+        tcg_out_movi(s, TCG_TYPE_I32, ret, 0);
         tcg_out_jxx(s, JCC_JMP, label_over, 1);
         tcg_out_label(s, label_true);
 
-        tcg_out_movi(s, TCG_TYPE_I32, args[0], 1);
-        tcg_out_label(s, label_over);
+        tcg_out_movi(s, TCG_TYPE_I32, ret, 1);
     } else {
-        /* When the destination does not overlap one of the arguments,
-           clear the destination first, jump if cond false, and emit an
-           increment in the true case.  This results in smaller code.  */
+        /*
+         * When the destination does not overlap one of the arguments,
+         * clear the destination first, jump if cond false, and emit an
+         * increment in the true case.  This results in smaller code.
+         */
+        tcg_out_movi(s, TCG_TYPE_I32, ret, 0);
 
-        tcg_out_movi(s, TCG_TYPE_I32, args[0], 0);
+        tcg_out_brcond2(s, tcg_invert_cond(cond), al, ah, bl, const_bl,
+                        bh, const_bh, label_over, true);
 
-        label_over = gen_new_label();
-        tcg_out_brcond2(s, tcg_invert_cond(args[5]), args[1], args[2],
-                        args[3], const_args[3],
-                        args[4], const_args[4], label_over, true);
-
-
-        tgen_arithi(s, ARITH_ADD, args[0], 1, 0);
-        tcg_out_label(s, label_over);
+        tgen_arithi(s, ARITH_ADD, ret, 1, 0);
     }
+    tcg_out_label(s, label_over);
 }
+
+#if TCG_TARGET_REG_BITS != 32
+__attribute__((unused))
 #endif
+static const TCGOutOpSetcond2 outop_setcond2 = {
+    .base.static_constraint = C_O1_I4(r, r, r, ri, ri),
+    .out = tgen_setcond2,
+};
 
 static void tcg_out_cmov(TCGContext *s, int jcc, int rexw,
                          TCGReg dest, TCGReg v1)
@@ -3240,11 +3246,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-#if TCG_TARGET_REG_BITS == 32
-    case INDEX_op_setcond2_i32:
-        tcg_out_setcond2(s, args, const_args);
-        break;
-#else /* TCG_TARGET_REG_BITS == 64 */
+#if TCG_TARGET_REG_BITS == 64
     case INDEX_op_ld32s_i64:
         tcg_out_modrm_offset(s, OPC_MOVSLQ, a0, a1, a2);
         break;
@@ -4012,9 +4014,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
         return C_O0_I3(L, L, L);
 
-    case INDEX_op_setcond2_i32:
-        return C_O1_I4(r, r, r, ri, ri);
-
     case INDEX_op_ld_vec:
     case INDEX_op_dupm_vec:
         return C_O1_I1(x, r);
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 776c34f349..83a45f4a33 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1067,13 +1067,23 @@ static int tcg_out_setcond2_int(TCGContext *s, TCGCond cond, TCGReg ret,
     return ret | flags;
 }
 
-static void tcg_out_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
-                             TCGReg al, TCGReg ah, TCGReg bl, TCGReg bh)
+static void tgen_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
+                          TCGReg al, TCGReg ah,
+                          TCGArg bl, bool const_bl,
+                          TCGArg bh, bool const_bh)
 {
     int tmpflags = tcg_out_setcond2_int(s, cond, ret, al, ah, bl, bh);
     tcg_out_setcond_end(s, ret, tmpflags);
 }
 
+#if TCG_TARGET_REG_BITS != 32
+__attribute__((unused))
+#endif
+static const TCGOutOpSetcond2 outop_setcond2 = {
+    .base.static_constraint = C_O1_I4(r, r, r, rz, rz),
+    .out = tgen_setcond2,
+};
+
 static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
                          TCGArg bl, bool const_bl,
                          TCGArg bh, bool const_bh, TCGLabel *l)
@@ -2312,10 +2322,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_setcond2_i32:
-        tcg_out_setcond2(s, args[5], a0, a1, a2, args[3], args[4]);
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, a0, 0, a1, a2, TCG_TYPE_I32);
         break;
@@ -2410,8 +2416,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_add2_i32:
     case INDEX_op_sub2_i32:
         return C_O2_I4(r, r, rz, rz, rN, rN);
-    case INDEX_op_setcond2_i32:
-        return C_O1_I4(r, rz, rz, rz, rz);
 
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, r);
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index cde8a55918..4cdbf246d2 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2274,15 +2274,24 @@ static void tcg_out_cmp2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
     }
 }
 
-static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
-                             const int *const_args)
+static void tgen_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
+                          TCGReg al, TCGReg ah,
+                          TCGArg bl, bool const_bl,
+                          TCGArg bh, bool const_bh)
 {
-    tcg_out_cmp2(s, args[5], args[1], args[2], args[3], const_args[3],
-                 args[4], const_args[4]);
+    tcg_out_cmp2(s, cond, al, ah, bl, const_bl, bh, const_bh);
     tcg_out32(s, MFOCRF | RT(TCG_REG_R0) | FXM(0));
-    tcg_out_rlw(s, RLWINM, args[0], TCG_REG_R0, CR_EQ + 0*4 + 1, 31, 31);
+    tcg_out_rlw(s, RLWINM, ret, TCG_REG_R0, CR_EQ + 0*4 + 1, 31, 31);
 }
 
+#if TCG_TARGET_REG_BITS != 32
+__attribute__((unused))
+#endif
+static const TCGOutOpSetcond2 outop_setcond2 = {
+    .base.static_constraint = C_O1_I4(r, r, r, rU, rC),
+    .out = tgen_setcond2,
+};
+
 static void tgen_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
                          TCGArg bl, bool const_bl,
                          TCGArg bh, bool const_bh, TCGLabel *l)
@@ -3491,10 +3500,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
 
-    case INDEX_op_setcond2_i32:
-        tcg_out_setcond2(s, args, const_args);
-        break;
-
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
         tcg_out_bswap16(s, args[0], args[1], args[2]);
@@ -4277,8 +4282,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
         return C_O1_I2(r, 0, rZ);
-    case INDEX_op_setcond2_i32:
-        return C_O1_I4(r, r, r, rU, rC);
     case INDEX_op_add2_i64:
     case INDEX_op_add2_i32:
         return C_O2_I4(r, r, r, r, rI, rZM);
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 0fe365e2d4..88dc7e24e3 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -87,9 +87,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub2_i64:
         return C_O2_I4(r, r, r, r, r, r);
 
-    case INDEX_op_setcond2_i32:
-        return C_O1_I4(r, r, r, r, r);
-
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, r);
     case INDEX_op_qemu_ld_i64:
@@ -997,6 +994,22 @@ static const TCGOutOpBrcond2 outop_brcond2 = {
     .out = tgen_brcond2,
 };
 
+static void tgen_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
+                          TCGReg al, TCGReg ah,
+                          TCGArg bl, bool const_bl,
+                          TCGArg bh, bool const_bh)
+{
+    tcg_out_op_rrrrrc(s, INDEX_op_setcond2_i32, ret, al, ah, bl, bh, cond);
+}
+
+#if TCG_TARGET_REG_BITS != 32
+__attribute__((unused))
+#endif
+static const TCGOutOpSetcond2 outop_setcond2 = {
+    .base.static_constraint = C_O1_I4(r, r, r, r, r),
+    .out = tgen_setcond2,
+};
+
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
@@ -1012,11 +1025,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_l(s, opc, arg_label(args[0]));
         break;
 
-    case INDEX_op_setcond2_i32:
-        tcg_out_op_rrrrrc(s, opc, args[0], args[1], args[2],
-                          args[3], args[4], args[5]);
-        break;
-
     CASE_32_64(ld8u)
     CASE_32_64(ld8s)
     CASE_32_64(ld16u)
-- 
2.43.0


