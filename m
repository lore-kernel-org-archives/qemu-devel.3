Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719B0C021A6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnxL-0006Os-I2; Sun, 16 Feb 2025 18:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwi-0004Rb-4D
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:11 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwb-0006SN-QL
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:06 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fc11834404so5075899a91.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748058; x=1740352858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D1EyruBkD+NBUce366c/Rl8XGoQXLo57MbsM21RJNHc=;
 b=VKdjdeFbVLQM+l5kJcnUC1nMsWWQWlojo8owojIxEw/0Zmp7D6OVZ1tSVuv4TSPTVE
 IEhEs2Kj70SJvOhzyFBfHR8oanUjc9aFHj4fA0R5vunseHSvwSeisiuteCG4sdF8fBzl
 +1sFC0+dLa+wSbw0PWJDuluXO5/Uk5DHSP/xPm9DEkimW+FrivDHCw/tdQZig4JZfK/i
 2L3X0UolP9pZD6qIg7msd9C/EO96700RbdpVDMK5eZZy1Km/QZwC8OIXWhxIE38vlSrW
 7ROZEUUZyguZwGTujMB9/46mUv+bZpy2t0s5ut480Ph2j6AbFrb6by9tBeJGRVOKSdBW
 5mMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748058; x=1740352858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1EyruBkD+NBUce366c/Rl8XGoQXLo57MbsM21RJNHc=;
 b=wkCytIijpyN+JznNRLJ2CQJVHsiuzd6Xm8VkIDaDVM3G7miUnbeIO3GWUFN8mh34LK
 H79cnCYMPX68xSKkcGmLHufrRtuuSpcYMkKA4Z2phdZpkXGo5eTbSJi+rZNdtns4ffba
 AY1YECw8kRTJ3HLQotdkVt0Gj8FrQ2bXyMRCqzMpXiBsXRdvAeFw3ayCOc3avysn/ziF
 Mp722RbEaKXPjdovFySoCer6M17WfZw2Qbus8Rr3TJzDyz7BHZuQhTjwprYsEUmFS+HS
 XiNscnhTud2t05cKhoFnsdck8Tc6NUqkZyfKg19aL9rNNsa/h+T66UiUb1X/D3qOtTM9
 46ug==
X-Gm-Message-State: AOJu0Yw0sG/U7Cna7b0OmeyMWo8stHyYIt5m2b3WlD2WsMrbgyv1q+3q
 d/OsLK0W+Fg+G3PiiiYPGz47nrWvEbCUjaZVR2rbNmKOTIaghwnU22f+6+ZflnW8hiz4BGk9yrU
 3
X-Gm-Gg: ASbGnct9n0BcmYOvC83zw6d6pnCwuzKk1dE/XtOwKjqcs1TwJNhvroWlqrp8N34JP6N
 Jd1zhEMr8kgho8aM34veKbyROBYg4puziPoNVGNDGV1uobEW9vc+aHzESvOt46k2zzb1GlpCq2K
 Mhq2WDwkZooI+dgW6G4tvvSbTAOXSFa2Lo1OAiBmDp7P09RnhbwrDlzRBVubiCAY+fGxtar7+BP
 pTQEK9AdUYY1zFLjDQtmdUqbbArnhKjtVl1klPzFiNLs9E5BXBK5awhraH+q3obNmEOt1MRonIs
 /KFcXIQHjcifUtvrWbN0matODnfk1+e43c2fAxcel92MHjw=
X-Google-Smtp-Source: AGHT+IHEYkGC277g/yqwKpMlWfQ9DX172Ue+ajlOeDndMRlcDO7RE3h3W97Q37l7ZEPj92WZoCbJjg==
X-Received: by 2002:a17:90b:1b46:b0:2ee:edae:780 with SMTP id
 98e67ed59e1d1-2fc40f22bd3mr11757002a91.15.1739748058052; 
 Sun, 16 Feb 2025 15:20:58 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.20.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:20:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 136/162] tcg/ppc: Implement add/sub carry opcodes
Date: Sun, 16 Feb 2025 15:09:45 -0800
Message-ID: <20250216231012.2808572-137-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
 tcg/ppc/tcg-target-con-set.h |   3 +
 tcg/ppc/tcg-target-con-str.h |   1 +
 tcg/ppc/tcg-target.c.inc     | 167 ++++++++++++++++++++++++++++++-----
 3 files changed, 150 insertions(+), 21 deletions(-)

diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
index 14cd217287..9ea26c40ae 100644
--- a/tcg/ppc/tcg-target-con-set.h
+++ b/tcg/ppc/tcg-target-con-set.h
@@ -29,7 +29,10 @@ C_O1_I2(r, r, rC)
 C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rT)
 C_O1_I2(r, r, rU)
+C_O1_I2(r, r, rZM)
 C_O1_I2(r, r, rZW)
+C_O1_I2(r, rI, rN)
+C_O1_I2(r, rZM, rZM)
 C_O1_I2(v, v, v)
 C_O1_I3(v, v, v, v)
 C_O1_I4(v, v, v, vZM, v)
diff --git a/tcg/ppc/tcg-target-con-str.h b/tcg/ppc/tcg-target-con-str.h
index 16b687216e..faf92da47f 100644
--- a/tcg/ppc/tcg-target-con-str.h
+++ b/tcg/ppc/tcg-target-con-str.h
@@ -19,6 +19,7 @@ REGS('v', ALL_VECTOR_REGS)
 CONST('C', TCG_CT_CONST_CMP)
 CONST('I', TCG_CT_CONST_S16)
 CONST('M', TCG_CT_CONST_MONE)
+CONST('N', TCG_CT_CONST_N16)
 CONST('T', TCG_CT_CONST_S32)
 CONST('U', TCG_CT_CONST_U32)
 CONST('W', TCG_CT_CONST_WSZ)
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 5b04655f3b..0b151db0e4 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -89,14 +89,15 @@
 /* Shorthand for size of a register.  */
 #define SZR  (TCG_TARGET_REG_BITS / 8)
 
-#define TCG_CT_CONST_S16  0x100
-#define TCG_CT_CONST_U16  0x200
-#define TCG_CT_CONST_S32  0x400
-#define TCG_CT_CONST_U32  0x800
-#define TCG_CT_CONST_ZERO 0x1000
-#define TCG_CT_CONST_MONE 0x2000
-#define TCG_CT_CONST_WSZ  0x4000
-#define TCG_CT_CONST_CMP  0x8000
+#define TCG_CT_CONST_S16     0x00100
+#define TCG_CT_CONST_U16     0x00200
+#define TCG_CT_CONST_N16     0x00400
+#define TCG_CT_CONST_S32     0x00800
+#define TCG_CT_CONST_U32     0x01000
+#define TCG_CT_CONST_ZERO    0x02000
+#define TCG_CT_CONST_MONE    0x04000
+#define TCG_CT_CONST_WSZ     0x08000
+#define TCG_CT_CONST_CMP     0x10000
 
 #define ALL_GENERAL_REGS  0xffffffffu
 #define ALL_VECTOR_REGS   0xffffffff00000000ull
@@ -342,6 +343,9 @@ static bool tcg_target_const_match(int64_t sval, int ct,
     if ((ct & TCG_CT_CONST_U16) && uval == (uint16_t)uval) {
         return 1;
     }
+    if ((ct & TCG_CT_CONST_N16) && -sval == (int16_t)-sval) {
+        return 1;
+    }
     if ((ct & TCG_CT_CONST_S32) && sval == (int32_t)sval) {
         return 1;
     }
@@ -2863,21 +2867,69 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_addco_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, ADDC | TAB(a0, a1, a2));
+}
+
+static void tgen_addco_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out32(s, ADDIC | TAI(a0, a1, a2));
+}
+
+static TCGConstraintSetIndex cset_addco(TCGType type, unsigned flags)
+{
+    /*
+     * Note that the CA bit is defined based on the word size of the
+     * environment.  So in 64-bit mode it's always carry-out of bit 63.
+     * The fallback code using deposit works just as well for TCG_TYPE_I32.
+     */
+    return type == TCG_TYPE_REG ? C_O1_I2(r, r, rI) : C_NotImplemented;
+}
+
 static const TCGOutOpBinary outop_addco = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addco,
+    .out_rrr = tgen_addco_rrr,
+    .out_rri = tgen_addco_rri,
+};
+
+static void tgen_addcio_rrr(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, ADDE | TAB(a0, a1, a2));
+}
+
+static void tgen_addcio_rri(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out32(s, (a2 ? ADDME : ADDZE) | RT(a0) | RA(a1));
+}
+
+static TCGConstraintSetIndex cset_addcio(TCGType type, unsigned flags)
+{
+    return type == TCG_TYPE_REG ? C_O1_I2(r, r, rZM) : C_NotImplemented;
+}
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addcio,
+    .out_rrr = tgen_addcio_rrr,
+    .out_rri = tgen_addcio_rri,
 };
 
 static const TCGOutOpAddSubCarry outop_addci = {
-    .base.static_constraint = C_NotImplemented,
-};
-
-static const TCGOutOpBinary outop_addcio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addcio,
+    .out_rrr = tgen_addcio_rrr,
+    .out_rri = tgen_addcio_rri,
 };
 
 static void tcg_out_set_carry(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out32(s, SUBFC | TAB(TCG_REG_R0, TCG_REG_R0, TCG_REG_R0));
 }
 
 static void tgen_and(TCGContext *s, TCGType type,
@@ -3284,21 +3336,94 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rir = tgen_subfi,
 };
 
+static void tgen_subbo_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, SUBFC | TAB(a0, a2, a1));
+}
+
+static void tgen_subbo_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (a2 == 0) {
+        tcg_out_movi(s, type, TCG_REG_R0, 0);
+        tgen_subbo_rrr(s, type, a0, a1, TCG_REG_R0);
+    } else {
+        tgen_addco_rri(s, type, a0, a1, -a2);
+    }
+}
+
+/* The underlying insn for subfi is subfic. */
+#define tgen_subbo_rir  tgen_subfi
+
+static void tgen_subbo_rii(TCGContext *s, TCGType type,
+                           TCGReg a0, tcg_target_long a1, tcg_target_long a2)
+{
+    tcg_out_movi(s, type, TCG_REG_R0, a2);
+    tgen_subbo_rir(s, type, a0, a1, TCG_REG_R0);
+}
+
+static TCGConstraintSetIndex cset_subbo(TCGType type, unsigned flags)
+{
+    /* Recall that the CA bit is defined based on the host word size. */
+    return type == TCG_TYPE_REG ? C_O1_I2(r, rI, rN) : C_NotImplemented;
+}
+
 static const TCGOutOpAddSubCarry outop_subbo = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_subbo,
+    .out_rrr = tgen_subbo_rrr,
+    .out_rri = tgen_subbo_rri,
+    .out_rir = tgen_subbo_rir,
+    .out_rii = tgen_subbo_rii,
 };
 
-static const TCGOutOpAddSubCarry outop_subbi = {
-    .base.static_constraint = C_NotImplemented,
-};
+static void tgen_subbio_rrr(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, SUBFE | TAB(a0, a2, a1));
+}
+
+static void tgen_subbio_rri(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tgen_addcio_rri(s, type, a0, a1, ~a2);
+}
+
+static void tgen_subbio_rir(TCGContext *s, TCGType type,
+                            TCGReg a0, tcg_target_long a1, TCGReg a2)
+{
+    tcg_debug_assert(a1 == 0 || a1 == -1);
+    tcg_out32(s, (a1 ? SUBFME : SUBFZE) | RT(a0) | RA(a2));
+}
+
+static void tgen_subbio_rii(TCGContext *s, TCGType type,
+                            TCGReg a0, tcg_target_long a1, tcg_target_long a2)
+{
+    tcg_out_movi(s, type, TCG_REG_R0, a2);
+    tgen_subbio_rir(s, type, a0, a1, TCG_REG_R0);
+}
+
+static TCGConstraintSetIndex cset_subbio(TCGType type, unsigned flags)
+{
+    return type == TCG_TYPE_REG ? C_O1_I2(r, rZM, rZM) : C_NotImplemented;
+}
 
 static const TCGOutOpAddSubCarry outop_subbio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_subbio,
+    .out_rrr = tgen_subbio_rrr,
+    .out_rri = tgen_subbio_rri,
+    .out_rir = tgen_subbio_rir,
+    .out_rii = tgen_subbio_rii,
 };
 
+#define outop_subbi  outop_subbio
+
 static void tcg_out_set_borrow(TCGContext *s)
 {
-    g_assert_not_reached();
+    /* borrow = !carry */
+    tcg_out32(s, ADDIC | TAI(TCG_REG_R0, TCG_REG_R0, 0));
 }
 
 static void tgen_xor(TCGContext *s, TCGType type,
-- 
2.43.0


