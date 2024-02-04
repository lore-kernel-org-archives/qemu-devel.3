Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E358AC4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkFo-0004cB-VS; Sun, 04 Feb 2024 16:42:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFm-0004RN-Sj
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:18 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFk-0003dJ-QZ
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:18 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d74045c463so29336185ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082935; x=1707687735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=diWYXbXbA8L+75njY+7GPUMLmiHt2XR0aqVQQ7E9HQ8=;
 b=QbEurLrb119FPE3vPOpTZ9qDRungCBTP2b3HS4L1HjNgxB98WgpXfgMDkxH13DgcGC
 fH/Lf7h/uARCcHc9IOdTWGT0M9J16u9PNrOCX47tZwrzrkiun4qLURpHMYkn/7kn9qy9
 QFjdkFNUkxKhq5XGfaOL31zagDv6FWq2l3ASTPUwlgmqTTrx/uMiSmFranX9zIRUDEZ3
 I85so8XSnDvBW5BNqetOV4/k3dYZfgT5lFa0tUFyd8/XXHYALpVKlUB6byu9Rq0eQgnF
 QuExhnkullmda7r3s61h4qu32RVH0/JdhbHBCzb7hLLbOW1WiSD7pIJO7bU/VimeIdRP
 u0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082935; x=1707687735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=diWYXbXbA8L+75njY+7GPUMLmiHt2XR0aqVQQ7E9HQ8=;
 b=rjVlFvFpOjAs7HTlYKER6v5bMDLwNWeQVr9GXT0cWxSatdBgMfHj6B2IZQgmZmnFx6
 CU1QqJv6tJo6bUtsTLgCxw+xuuJrSNx447OPLSIVq8JNv0E33Z5L9Iz1u6EeKnYABsaw
 5Qc0GvAHSRFhn1Kmx8GMngprB68XKyqMGIejYPXW9dFyQtaBRMqbAyJg07sjDN3Ujf2A
 kwXrC3BMj/b+0zU3+gjT1PZiFkC2lYCBaKKyev1zz5wMKFuCp+QBZ+6M4MSbTTFy87xV
 wBOZITIVDH8GcVsG2yKTO89HMpA72EtJgKWZm1Ib67bu+zgjvkGFearVeqCmnAutKHAK
 yeTg==
X-Gm-Message-State: AOJu0Yy2iOtkDzybhy0yYHqXXp7k9BjixNI/eJnEo2S55zUYmMvVOBoz
 PqUZQBUtiRo+KAWnFAzpnP9ewF71RV3qg3Uf69peRIvrC9JlGP1YE+1DMddgWalL+UEexux66fl
 yDIQ=
X-Google-Smtp-Source: AGHT+IG7Gb0CmrphEMKIMUXXCpHpsTFWiDKiJKaAzrKUOWB7VM0LkXJlE5yYcK+GxThwqrOLiCZF8A==
X-Received: by 2002:a17:902:b182:b0:1d9:7782:316f with SMTP id
 s2-20020a170902b18200b001d97782316fmr5489247plr.39.1707082935458; 
 Sun, 04 Feb 2024 13:42:15 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.42.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:42:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/39] tcg/s390x: Support TCG_COND_TST{EQ,NE}
Date: Mon,  5 Feb 2024 07:40:51 +1000
Message-Id: <20240204214052.5639-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 tcg/s390x/tcg-target.h     |   2 +-
 tcg/s390x/tcg-target.c.inc | 139 +++++++++++++++++++++++++------------
 2 files changed, 97 insertions(+), 44 deletions(-)

diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index 53bed8c8d2..ae448c3a3a 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -138,7 +138,7 @@ extern uint64_t s390_facilities[3];
 
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
 
-#define TCG_TARGET_HAS_tst            0
+#define TCG_TARGET_HAS_tst            1
 
 #define TCG_TARGET_HAS_v64            HAVE_FACILITY(VECTOR)
 #define TCG_TARGET_HAS_v128           HAVE_FACILITY(VECTOR)
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 7f97080f52..41f693ebbc 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -112,6 +112,9 @@ typedef enum S390Opcode {
     RI_OILH     = 0xa50a,
     RI_OILL     = 0xa50b,
     RI_TMLL     = 0xa701,
+    RI_TMLH     = 0xa700,
+    RI_TMHL     = 0xa703,
+    RI_TMHH     = 0xa702,
 
     RIEb_CGRJ    = 0xec64,
     RIEb_CLGRJ   = 0xec65,
@@ -404,10 +407,15 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define S390_CC_NEVER   0
 #define S390_CC_ALWAYS  15
 
+#define S390_TM_EQ      8  /* CC == 0 */
+#define S390_TM_NE      7  /* CC in {1,2,3} */
+
 /* Condition codes that result from a COMPARE and COMPARE LOGICAL.  */
-static const uint8_t tcg_cond_to_s390_cond[] = {
+static const uint8_t tcg_cond_to_s390_cond[16] = {
     [TCG_COND_EQ]  = S390_CC_EQ,
     [TCG_COND_NE]  = S390_CC_NE,
+    [TCG_COND_TSTEQ] = S390_CC_EQ,
+    [TCG_COND_TSTNE] = S390_CC_NE,
     [TCG_COND_LT]  = S390_CC_LT,
     [TCG_COND_LE]  = S390_CC_LE,
     [TCG_COND_GT]  = S390_CC_GT,
@@ -421,9 +429,11 @@ static const uint8_t tcg_cond_to_s390_cond[] = {
 /* Condition codes that result from a LOAD AND TEST.  Here, we have no
    unsigned instruction variation, however since the test is vs zero we
    can re-map the outcomes appropriately.  */
-static const uint8_t tcg_cond_to_ltr_cond[] = {
+static const uint8_t tcg_cond_to_ltr_cond[16] = {
     [TCG_COND_EQ]  = S390_CC_EQ,
     [TCG_COND_NE]  = S390_CC_NE,
+    [TCG_COND_TSTEQ] = S390_CC_ALWAYS,
+    [TCG_COND_TSTNE] = S390_CC_NEVER,
     [TCG_COND_LT]  = S390_CC_LT,
     [TCG_COND_LE]  = S390_CC_LE,
     [TCG_COND_GT]  = S390_CC_GT,
@@ -542,10 +552,13 @@ static bool risbg_mask(uint64_t c)
 static bool tcg_target_const_match(int64_t val, int ct,
                                    TCGType type, TCGCond cond, int vece)
 {
+    uint64_t uval = val;
+
     if (ct & TCG_CT_CONST) {
         return true;
     }
     if (type == TCG_TYPE_I32) {
+        uval = (uint32_t)val;
         val = (int32_t)val;
     }
 
@@ -567,6 +580,15 @@ static bool tcg_target_const_match(int64_t val, int ct,
         case TCG_COND_GTU:
             ct |= TCG_CT_CONST_U32;  /* CLGFI */
             break;
+        case TCG_COND_TSTNE:
+        case TCG_COND_TSTEQ:
+            if (is_const_p16(uval) >= 0) {
+                return true;  /* TMxx */
+            }
+            if (risbg_mask(uval)) {
+                return true;  /* RISBG */
+            }
+            break;
         default:
             g_assert_not_reached();
         }
@@ -588,10 +610,6 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if (ct & TCG_CT_CONST_INV) {
         val = ~val;
     }
-    /*
-     * Note that is_const_p16 is a subset of is_const_p32,
-     * so we don't need both constraints.
-     */
     if ((ct & TCG_CT_CONST_P32) && is_const_p32(val) >= 0) {
         return true;
     }
@@ -868,6 +886,9 @@ static const S390Opcode oi_insns[4] = {
 static const S390Opcode lif_insns[2] = {
     RIL_LLILF, RIL_LLIHF,
 };
+static const S390Opcode tm_insns[4] = {
+    RI_TMLL, RI_TMLH, RI_TMHL, RI_TMHH
+};
 
 /* load a register with an immediate value */
 static void tcg_out_movi(TCGContext *s, TCGType type,
@@ -1228,6 +1249,36 @@ static int tgen_cmp2(TCGContext *s, TCGType type, TCGCond c, TCGReg r1,
     TCGCond inv_c = tcg_invert_cond(c);
     S390Opcode op;
 
+    if (is_tst_cond(c)) {
+        tcg_debug_assert(!need_carry);
+
+        if (!c2const) {
+            if (type == TCG_TYPE_I32) {
+                tcg_out_insn(s, RRFa, NRK, TCG_REG_R0, r1, c2);
+            } else {
+                tcg_out_insn(s, RRFa, NGRK, TCG_REG_R0, r1, c2);
+            }
+            goto exit;
+        }
+
+        if (type == TCG_TYPE_I32) {
+            c2 = (uint32_t)c2;
+        }
+
+        int i = is_const_p16(c2);
+        if (i >= 0) {
+            tcg_out_insn_RI(s, tm_insns[i], r1, c2 >> (i * 16));
+            *inv_cc = TCG_COND_TSTEQ ? S390_TM_NE : S390_TM_EQ;
+            return *inv_cc ^ 15;
+        }
+
+        if (risbg_mask(c2)) {
+            tgen_andi_risbg(s, TCG_REG_R0, r1, c2);
+            goto exit;
+        }
+        g_assert_not_reached();
+    }
+
     if (c2const) {
         if (c2 == 0) {
             if (!(is_unsigned && need_carry)) {
@@ -1553,46 +1604,49 @@ static void tgen_brcond(TCGContext *s, TCGType type, TCGCond c,
                         TCGReg r1, TCGArg c2, int c2const, TCGLabel *l)
 {
     int cc;
-    bool is_unsigned = is_unsigned_cond(c);
-    bool in_range;
-    S390Opcode opc;
 
-    cc = tcg_cond_to_s390_cond[c];
+    if (!is_tst_cond(c)) {
+        bool is_unsigned = is_unsigned_cond(c);
+        bool in_range;
+        S390Opcode opc;
 
-    if (!c2const) {
-        opc = (type == TCG_TYPE_I32
-               ? (is_unsigned ? RIEb_CLRJ : RIEb_CRJ)
-               : (is_unsigned ? RIEb_CLGRJ : RIEb_CGRJ));
-        tgen_compare_branch(s, opc, cc, r1, c2, l);
-        return;
-    }
+        cc = tcg_cond_to_s390_cond[c];
 
-    /*
-     * COMPARE IMMEDIATE AND BRANCH RELATIVE has an 8-bit immediate field.
-     * If the immediate we've been given does not fit that range, we'll
-     * fall back to separate compare and branch instructions using the
-     * larger comparison range afforded by COMPARE IMMEDIATE.
-     */
-    if (type == TCG_TYPE_I32) {
-        if (is_unsigned) {
-            opc = RIEc_CLIJ;
-            in_range = (uint32_t)c2 == (uint8_t)c2;
-        } else {
-            opc = RIEc_CIJ;
-            in_range = (int32_t)c2 == (int8_t)c2;
+        if (!c2const) {
+            opc = (type == TCG_TYPE_I32
+                   ? (is_unsigned ? RIEb_CLRJ : RIEb_CRJ)
+                   : (is_unsigned ? RIEb_CLGRJ : RIEb_CGRJ));
+            tgen_compare_branch(s, opc, cc, r1, c2, l);
+            return;
         }
-    } else {
-        if (is_unsigned) {
-            opc = RIEc_CLGIJ;
-            in_range = (uint64_t)c2 == (uint8_t)c2;
+
+        /*
+         * COMPARE IMMEDIATE AND BRANCH RELATIVE has an 8-bit immediate field.
+         * If the immediate we've been given does not fit that range, we'll
+         * fall back to separate compare and branch instructions using the
+         * larger comparison range afforded by COMPARE IMMEDIATE.
+         */
+        if (type == TCG_TYPE_I32) {
+            if (is_unsigned) {
+                opc = RIEc_CLIJ;
+                in_range = (uint32_t)c2 == (uint8_t)c2;
+            } else {
+                opc = RIEc_CIJ;
+                in_range = (int32_t)c2 == (int8_t)c2;
+            }
         } else {
-            opc = RIEc_CGIJ;
-            in_range = (int64_t)c2 == (int8_t)c2;
+            if (is_unsigned) {
+                opc = RIEc_CLGIJ;
+                in_range = (uint64_t)c2 == (uint8_t)c2;
+            } else {
+                opc = RIEc_CGIJ;
+                in_range = (int64_t)c2 == (int8_t)c2;
+            }
+        }
+        if (in_range) {
+            tgen_compare_imm_branch(s, opc, cc, r1, c2, l);
+            return;
         }
-    }
-    if (in_range) {
-        tgen_compare_imm_branch(s, opc, cc, r1, c2, l);
-        return;
     }
 
     cc = tgen_cmp(s, type, c, r1, c2, c2const, false);
@@ -1871,11 +1925,10 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             ldst->oi = oi;
             ldst->addrlo_reg = addr_reg;
 
-            /* We are expecting a_bits to max out at 7, much lower than TMLL. */
             tcg_debug_assert(a_mask <= 0xffff);
             tcg_out_insn(s, RI, TMLL, addr_reg, a_mask);
 
-            tcg_out16(s, RI_BRC | (7 << 4)); /* CC in {1,2,3} */
+            tcg_out16(s, RI_BRC | (S390_TM_NE << 4));
             ldst->label_ptr[0] = s->code_ptr++;
         }
 
@@ -1956,7 +2009,7 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
             l2 = gen_new_label();
 
             tcg_out_insn(s, RI, TMLL, addr_reg, 15);
-            tgen_branch(s, 7, l1); /* CC in {1,2,3} */
+            tgen_branch(s, S390_TM_NE, l1);
         }
 
         tcg_debug_assert(!need_bswap);
-- 
2.34.1


