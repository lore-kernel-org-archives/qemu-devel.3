Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E43C48260
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 03:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXC2B-0007Ia-3y; Mon, 05 Feb 2024 22:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXC28-0007IP-CC
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:22:04 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXC24-0006oF-CN
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:22:03 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-290fb65531eso3790235a91.2
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 19:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707189719; x=1707794519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q9oqNWXKjH3Nn1f4hE372yWXlayduoloL5amcRfRYLg=;
 b=qZ4tsNQ2A1I8tLnnc+N+lKN1K8uvg3ApzYs8Qbe3Ux+br/b3s/04u0T2MxHcn01Pl/
 Sx8L8ogYkqb46T9OkfPqv86frcKx8N+9svJBrCPAtfv9XPzphzN+u4O7GubvbYmtsOVY
 Esq9NrR//zncY1ZG86jEJxUzbiK6367DTdKLgAjFwva5Q0BKemMhG7v+OZ5k7exJbUOn
 2DIA9GAlELyTGe5jJgF4cJJFZeB8FjynQXYc1qj/ROUF2yyfYL4lfENJ3lSn4g/DgHeh
 W8au4Cp1NS6BkR7QR93+Hu6zS/IAHLNX4b/D3sK6Hjz5LrAA6ifhd+7v4QrPLCIgXDvF
 Ht/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707189719; x=1707794519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q9oqNWXKjH3Nn1f4hE372yWXlayduoloL5amcRfRYLg=;
 b=jKCJE7DaenGcZn8raRvYLUZOgAhs2IucNdGsbTNyhWM2gyDVCJiZmelxVMSbHOhzUB
 AHkdRFI9brwpyu5RLShcqnTAQ6U4W/TwlmEkrnAyeVPq3Cf5HNBqgGMHx24IVFplsCPi
 kRRExAaa0KyOmkKdqlk/fg+zulCxnKm52RkyrRzj9Ek01kBxeHdjT9NUbTaODTRp7Q2u
 /rdG2zSgwzX3F/K/hIwObZXJrwKhIcJUi6rAWCFlET92uennRTjx1jcxcZhTp5mppE6J
 4qXwmZXkxzt3VN54SYEwcaaC54s756r2PjoZR94x/r3RySOKsRKKfvLbYe2R4nf26FFe
 Iz9Q==
X-Gm-Message-State: AOJu0YwuFAbMGGURas6LZ/crQVWbXED3i++tdja41nWbG8XNPGEreXp5
 zlAO0TSyIVvVC+uljXGPE2nyiG9a2K1GB0DJydANU9qXJsj7sA7o+bRdBxX6v0j9jeKmSkQl0nX
 RZuM=
X-Google-Smtp-Source: AGHT+IFAJfTX8PMjEtODuf0uI23hwOBWAChcuUARDlQbaz4z/7S6S+zp1YdoQxjNikbYzniKQgpG/A==
X-Received: by 2002:a17:90b:4394:b0:295:1e7d:bc14 with SMTP id
 in20-20020a17090b439400b002951e7dbc14mr1372870pjb.20.1707189718692; 
 Mon, 05 Feb 2024 19:21:58 -0800 (PST)
Received: from stoup.. ([43.252.112.200]) by smtp.gmail.com with ESMTPSA id
 gz22-20020a17090b0ed600b00290ae3bf8d7sm264152pjb.21.2024.02.05.19.21.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 19:21:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 38/39] tcg/s390x: Support TCG_COND_TST{EQ,NE}
Date: Tue,  6 Feb 2024 13:21:51 +1000
Message-Id: <20240206032151.174516-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206032151.174516-1-richard.henderson@linaro.org>
References: <20240206032151.174516-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
index 7f97080f52..ad587325fc 100644
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
+            *inv_cc = c == TCG_COND_TSTEQ ? S390_TM_NE : S390_TM_EQ;
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


