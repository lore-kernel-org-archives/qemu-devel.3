Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A4DC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnxH-00064Q-S2; Sun, 16 Feb 2025 18:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwl-0004Uj-Fa
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:12 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwh-0006U2-PA
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:10 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2fc1f410186so4938514a91.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748066; x=1740352866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SKYZ04ze7lAFLMGtiCvzp1lTZg3J5bVxwu6GXkvSIgs=;
 b=PDIXPN62NQQTHNUncwZNiHnUFWS4rcQGEP1Yzh+78PNQlTLrzqX0tmM3XuahddEB37
 Fbe1NUKnL/ZYmKY7a+FaSDiYsCYCcrcMgKHGLUdVJwRXs3Y8R8URlw2xkRc/PKcgsdF2
 OVdQ6MzCAMPtIuUHJw80oygdrQ0QWti2j/rZXeSCPkhvHkVT1f/Mdxx3A7mi9fnKIGO3
 bLTUGNEK6Q5l4MbzfJ2/qas8vIbMSUxvqiJ/wuWh1qbwrEiP5gU6QS2ZaAMG7Grjh6dX
 +Da4/LiAtckN3rZfwGXGI572PF6Stj0VsY3ldCvI8u1W0UsEcAH2mVt6n9a3F7W+mVVW
 LQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748066; x=1740352866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SKYZ04ze7lAFLMGtiCvzp1lTZg3J5bVxwu6GXkvSIgs=;
 b=FdrBhtbKCFW+mygb19uS0sKWRYJo1UeqvLfVPcyJzlFP5+8Gl7cwd/2CfiRh8fCAts
 BAazeQulAkOGOen19/ImmobOaX17Xsy0CR6DK1/iJ19z6lusf2I7bjmPbm/IdxmUNrKs
 XnapZ9JlMksczTbQTfJWTrYOmFOlrX57d1kYOUjTP787zdLPHes0Mz1eOCzkLUBCtCt9
 47WPkRy8c95XnCoaCAnfhjapiKOU4siC7/BvnaUT9KwGwh6OPiJ30so6iJmkdrGC0trD
 /f7aMYforYbOBhbwz18efrt+70yJpwY+EPjKRU+ciTRoQXBgdSzdLzm3a48jYIrJj0YT
 7kXA==
X-Gm-Message-State: AOJu0YySIlHjSs+eDdH2j0+jr4LjOWZbVngxrWtyyPXDEUJE/FTYxMr6
 3y2g4h770lOPtzxjcjepLzHEMHFDvF3dDaa4o8/I048YQ9dMXWuBj9ncme/BEUwwzhYBasK6emI
 q
X-Gm-Gg: ASbGncut0VeudF/cb6EW8NVfmuTveagpTEammetcqWn2j3lhxXDRwGF3idDP6MOG398
 B+KfyU5Psn2Tnw0X8xShQVIvpSmUirvPvAl9VI8aFHTqz0cJHl7p3/o5ro8iluhR9EL9rEEpOlY
 s0g2bnGRbSegB0gfo6Omm5iupYuWw6TKTPPuCFPy9Pr0KUrcCGUWWnFgelkYzBaUoJmDK7d9sBX
 2Y7FOl7A7pXp7kjq1APdDytgfzkB1XC8KTrkvGYMrFFA2u5GTnKQv42I7T/0edMOF//piY9FPUw
 Sz+JGhnGXt1/GpVWKswdzJ6WZxH5NtCJpd+WMPnwpPQDJYc=
X-Google-Smtp-Source: AGHT+IFVNS1KY5XF9tqORWnTxWpaNaQz09oRvDgC54L2ms+LRmAkg0bhDbEChwdX4juwFAKWEb3kfA==
X-Received: by 2002:a17:90b:3904:b0:2fa:30e9:2051 with SMTP id
 98e67ed59e1d1-2fc0f9555c0mr23802610a91.5.1739748065684; 
 Sun, 16 Feb 2025 15:21:05 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.21.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:21:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 145/162] tcg/sparc64: Remove support for add2/sub2
Date: Sun, 16 Feb 2025 15:09:54 -0800
Message-ID: <20250216231012.2808572-146-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
 tcg/sparc64/tcg-target-con-set.h |   6 +-
 tcg/sparc64/tcg-target-has.h     |   8 +-
 tcg/sparc64/tcg-target.c.inc     | 169 +++----------------------------
 3 files changed, 19 insertions(+), 164 deletions(-)

diff --git a/tcg/sparc64/tcg-target-con-set.h b/tcg/sparc64/tcg-target-con-set.h
index 37cb190450..1a57adc0e8 100644
--- a/tcg/sparc64/tcg-target-con-set.h
+++ b/tcg/sparc64/tcg-target-con-set.h
@@ -15,9 +15,7 @@ C_O0_I2(r, rJ)
 C_O1_I1(r, r)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, rJ)
-C_O1_I2(r, r, rZ)
-C_O1_I2(r, rZ, rJ)
-C_O1_I2(r, rZ, rZ)
+C_O1_I2(r, rz, rJ)
+C_O1_I2(r, rz, rz)
 C_O1_I4(r, r, rJ, rI, 0)
 C_O2_I2(r, r, r, r)
-C_O2_I4(r, r, rz, rz, rJ, rJ)
diff --git a/tcg/sparc64/tcg-target-has.h b/tcg/sparc64/tcg-target-has.h
index b8760dd154..caf7679595 100644
--- a/tcg/sparc64/tcg-target-has.h
+++ b/tcg/sparc64/tcg-target-has.h
@@ -14,13 +14,13 @@ extern bool use_vis3_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_add2_i32         0
+#define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 93bb88b05f..842ef68c54 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -919,74 +919,6 @@ static const TCGOutOpMovcond outop_movcond = {
     .out = tgen_movcond,
 };
 
-static void tcg_out_addsub2_i32(TCGContext *s, TCGReg rl, TCGReg rh,
-                                TCGReg al, TCGReg ah, int32_t bl, int blconst,
-                                int32_t bh, int bhconst, int opl, int oph)
-{
-    TCGReg tmp = TCG_REG_T1;
-
-    /* Note that the low parts are fully consumed before tmp is set.  */
-    if (rl != ah && (bhconst || rl != bh)) {
-        tmp = rl;
-    }
-
-    tcg_out_arithc(s, tmp, al, bl, blconst, opl);
-    tcg_out_arithc(s, rh, ah, bh, bhconst, oph);
-    tcg_out_mov(s, TCG_TYPE_I32, rl, tmp);
-}
-
-static void tcg_out_addsub2_i64(TCGContext *s, TCGReg rl, TCGReg rh,
-                                TCGReg al, TCGReg ah, int32_t bl, int blconst,
-                                int32_t bh, int bhconst, bool is_sub)
-{
-    TCGReg tmp = TCG_REG_T1;
-
-    /* Note that the low parts are fully consumed before tmp is set.  */
-    if (rl != ah && (bhconst || rl != bh)) {
-        tmp = rl;
-    }
-
-    tcg_out_arithc(s, tmp, al, bl, blconst, is_sub ? ARITH_SUBCC : ARITH_ADDCC);
-
-    if (use_vis3_instructions && !is_sub) {
-        /* Note that ADDXC doesn't accept immediates.  */
-        if (bhconst && bh != 0) {
-           tcg_out_movi_s13(s, TCG_REG_T2, bh);
-           bh = TCG_REG_T2;
-        }
-        tcg_out_arith(s, rh, ah, bh, ARITH_ADDXC);
-    } else if (bh == TCG_REG_G0) {
-	/* If we have a zero, we can perform the operation in two insns,
-           with the arithmetic first, and a conditional move into place.  */
-	if (rh == ah) {
-            tcg_out_arithi(s, TCG_REG_T2, ah, 1,
-			   is_sub ? ARITH_SUB : ARITH_ADD);
-            tcg_out_movcc(s, COND_CS, MOVCC_XCC, rh, TCG_REG_T2, 0);
-	} else {
-            tcg_out_arithi(s, rh, ah, 1, is_sub ? ARITH_SUB : ARITH_ADD);
-	    tcg_out_movcc(s, COND_CC, MOVCC_XCC, rh, ah, 0);
-	}
-    } else {
-        /*
-         * Otherwise adjust BH as if there is carry into T2.
-         * Note that constant BH is constrained to 11 bits for the MOVCC,
-         * so the adjustment fits 12 bits.
-         */
-        if (bhconst) {
-            tcg_out_movi_s13(s, TCG_REG_T2, bh + (is_sub ? -1 : 1));
-        } else {
-            tcg_out_arithi(s, TCG_REG_T2, bh, 1,
-                           is_sub ? ARITH_SUB : ARITH_ADD);
-        }
-        /* ... smoosh T2 back to original BH if carry is clear ... */
-        tcg_out_movcc(s, COND_CC, MOVCC_XCC, TCG_REG_T2, bh, bhconst);
-	/* ... and finally perform the arithmetic with the new operand.  */
-        tcg_out_arith(s, rh, ah, TCG_REG_T2, is_sub ? ARITH_SUB : ARITH_ADD);
-    }
-
-    tcg_out_mov(s, TCG_TYPE_I64, rl, tmp);
-}
-
 static void tcg_out_jmpl_const(TCGContext *s, const tcg_insn_unit *dest,
                                bool in_prologue, bool tail_call)
 {
@@ -1424,10 +1356,10 @@ static void tgen_addci_rri(TCGContext *s, TCGType type,
 {
     if (type == TCG_TYPE_I32) {
         tcg_out_arithi(s, a0, a1, a2, ARITH_ADDC);
-    } else if (use_vis3_instructions) {
-        tcg_debug_assert(a2 == 0);
-        tcg_out_arith(s, a0, a1, TCG_REG_G0, ARITH_ADDXC);
-    } else if (a2 != 0) {
+        return;
+    }
+    /* !use_vis3_instructions */
+    if (a2 != 0) {
         tcg_out_arithi(s, TCG_REG_T1, a1, a2, ARITH_ADD); /* for CC */
         tcg_out_arithi(s, a0, TCG_REG_T1, 1, ARITH_ADD);  /* for CS */
         tcg_out_movcc(s, COND_CC, MOVCC_XCC, a0, TCG_REG_T1, false);
@@ -1440,25 +1372,13 @@ static void tgen_addci_rri(TCGContext *s, TCGType type,
     }
 }
 
-static void tgen_addci_rir(TCGContext *s, TCGType type,
-                           TCGReg a0, tcg_target_long a1, TCGReg a2)
-{
-    tgen_addci_rri(s, type, a0, a2, a1);
-}
-
-static void tgen_addci_rii(TCGContext *s, TCGType type,
-                           TCGReg a0, tcg_target_long a1, tcg_target_long a2)
-{
-    tgen_addci_rri(s, type, a0, TCG_REG_G0, a2);
-}
-
 static TCGConstraintSetIndex cset_addci(TCGType type, unsigned flags)
 {
     if (use_vis3_instructions && type == TCG_TYPE_I64) {
         /* Note that ADDXC doesn't accept immediates.  */
-        return C_O1_I2(r, rZ, rZ);
+        return C_O1_I2(r, rz, rz);
     }
-    return C_O1_I2(r, rZ, rJ);
+    return C_O1_I2(r, rz, rJ);
 }
 
 static const TCGOutOpAddSubCarry outop_addci = {
@@ -1466,8 +1386,6 @@ static const TCGOutOpAddSubCarry outop_addci = {
     .base.dynamic_constraint = cset_addci,
     .out_rrr = tgen_addci_rrr,
     .out_rri = tgen_addci_rri,
-    .out_rir = tgen_addci_rir,
-    .out_rii = tgen_addci_rii,
 };
 
 /* Copy %xcc.c to %icc.c */
@@ -1487,10 +1405,7 @@ static void tgen_addcio_rrr(TCGContext *s, TCGType type,
                             TCGReg a0, TCGReg a1, TCGReg a2)
 {
     if (type != TCG_TYPE_I32) {
-        if (use_vis3_instructions) {
-            tcg_out_arith(s, a0, a1, a2, ARITH_ADDXCCC);
-            return;
-        }
+        /* !use_vis3_instructions */
         tcg_out_dup_xcc_c(s);
     }
     tcg_out_arith(s, a0, a1, a2, ARITH_ADDCCC);
@@ -1500,11 +1415,7 @@ static void tgen_addcio_rri(TCGContext *s, TCGType type,
                             TCGReg a0, TCGReg a1, tcg_target_long a2)
 {
     if (type != TCG_TYPE_I32) {
-        if (use_vis3_instructions) {
-            tcg_debug_assert(a2 == 0);
-            tcg_out_arith(s, a0, a1, TCG_REG_G0, ARITH_ADDXCCC);
-            return;
-        }
+        /* !use_vis3_instructions */
         tcg_out_dup_xcc_c(s);
     }
     tcg_out_arithi(s, a0, a1, a2, ARITH_ADDCCC);
@@ -1514,9 +1425,9 @@ static TCGConstraintSetIndex cset_addcio(TCGType type, unsigned flags)
 {
     if (use_vis3_instructions && type == TCG_TYPE_I64) {
         /* Note that ADDXC doesn't accept immediates.  */
-        return C_O1_I2(r, r, rZ);
+        return C_O1_I2(r, rz, rz);
     }
-    return C_O1_I2(r, r, rJ);
+    return C_O1_I2(r, rz, rJ);
 }
 
 static const TCGOutOpBinary outop_addcio = {
@@ -1881,7 +1792,7 @@ static void tgen_subbo_rri(TCGContext *s, TCGType type,
 }
 
 static const TCGOutOpAddSubCarry outop_subbo = {
-    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .base.static_constraint = C_O1_I2(r, rz, rJ),
     .out_rrr = tgen_subbo_rrr,
     .out_rri = tgen_subbo_rri,
 };
@@ -1917,24 +1828,10 @@ static void tgen_subbi_rri(TCGContext *s, TCGType type,
     }
 }
 
-static void tgen_subbi_rir(TCGContext *s, TCGType type,
-                           TCGReg a0, tcg_target_long a1, TCGReg a2)
-{
-    tgen_subbi_rrr(s, type, a0, TCG_REG_G0, a2);
-}
-
-static void tgen_subbi_rii(TCGContext *s, TCGType type,
-                           TCGReg a0, tcg_target_long a1, tcg_target_long a2)
-{
-    tgen_subbi_rri(s, type, a0, TCG_REG_G0, a2);
-}
-
 static const TCGOutOpAddSubCarry outop_subbi = {
-    .base.static_constraint = C_O1_I2(r, rZ, rJ),
+    .base.static_constraint = C_O1_I2(r, rz, rJ),
     .out_rrr = tgen_subbi_rrr,
     .out_rri = tgen_subbi_rri,
-    .out_rir = tgen_subbi_rir,
-    .out_rii = tgen_subbi_rii,
 };
 
 static void tgen_subbio_rrr(TCGContext *s, TCGType type,
@@ -1955,24 +1852,10 @@ static void tgen_subbio_rri(TCGContext *s, TCGType type,
     tcg_out_arithi(s, a0, a1, a2, ARITH_SUBCCC);
 }
 
-static void tgen_subbio_rir(TCGContext *s, TCGType type,
-                            TCGReg a0, tcg_target_long a1, TCGReg a2)
-{
-    tgen_subbio_rrr(s, type, a0, TCG_REG_G0, a2);
-}
-
-static void tgen_subbio_rii(TCGContext *s, TCGType type,
-                            TCGReg a0, tcg_target_long a1, tcg_target_long a2)
-{
-    tgen_subbio_rri(s, type, a0, TCG_REG_G0, a2);
-}
-
 static const TCGOutOpAddSubCarry outop_subbio = {
-    .base.static_constraint = C_O1_I2(r, rZ, rJ),
+    .base.static_constraint = C_O1_I2(r, rz, rJ),
     .out_rrr = tgen_subbio_rrr,
     .out_rri = tgen_subbio_rri,
-    .out_rir = tgen_subbio_rir,
-    .out_rii = tgen_subbio_rii,
 };
 
 static void tcg_out_set_borrow(TCGContext *s)
@@ -2114,17 +1997,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, a0, a1, a2, STW);
         break;
 
-    case INDEX_op_add2_i32:
-        tcg_out_addsub2_i32(s, args[0], args[1], args[2], args[3],
-                            args[4], const_args[4], args[5], const_args[5],
-                            ARITH_ADDCC, ARITH_ADDC);
-        break;
-    case INDEX_op_sub2_i32:
-        tcg_out_addsub2_i32(s, args[0], args[1], args[2], args[3],
-                            args[4], const_args[4], args[5], const_args[5],
-                            ARITH_SUBCC, ARITH_SUBC);
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I32);
         break;
@@ -2148,15 +2020,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, a0, a1, a2, STX);
         break;
 
-    case INDEX_op_add2_i64:
-        tcg_out_addsub2_i64(s, args[0], args[1], args[2], args[3], args[4],
-                            const_args[4], args[5], const_args[5], false);
-        break;
-    case INDEX_op_sub2_i64:
-        tcg_out_addsub2_i64(s, args[0], args[1], args[2], args[3], args[4],
-                            const_args[4], args[5], const_args[5], true);
-        break;
-
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
@@ -2203,12 +2066,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i32:
-    case INDEX_op_sub2_i64:
-        return C_O2_I4(r, r, rz, rz, rJ, rJ);
-
     default:
         return C_NotImplemented;
     }
-- 
2.43.0


