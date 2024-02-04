Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038C7C48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkF7-0002Bg-Ra; Sun, 04 Feb 2024 16:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkF6-00028L-Cb
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:36 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkF4-0003XZ-FX
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:36 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d7232dcb3eso27235795ad.2
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082892; x=1707687692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8UBGb+wxegdURiW3iZlXgf7tcUJqtD8TzwZuo64Djqc=;
 b=dRBvIkdO76d6W1HDDBhYfXDti68+DEX6OfrFcxuvfQWlAxIKatwxPfIHlzw6t6914z
 cSXM1oXOqP9pRkb9bY3Yo4XkToAl9ZKCR0lAe9Nx+NAFRGnea1gQC+9RzKzZqZk8X5E6
 A2Z2VSdgLJnolO7HqKNn5ZegxbVSwH3OJ840546HmW18EhjUMEooeR0aC0FF/h/hrsb2
 ekTsk4PUC9UFZucB8Wp4AXjc43U/xgOi1GWErx2YHYfVILW80DlAfk/uIoYIzVHFZB5a
 AvbI561PYh9u7pJhWojUE6C/DvEbR7wHDDG9BgxbFAFOP8XRLUvoWHpG96LwysHjQr79
 vNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082892; x=1707687692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8UBGb+wxegdURiW3iZlXgf7tcUJqtD8TzwZuo64Djqc=;
 b=F2nrNbbDy+eY1igpHa9i/yvuaJqw2kmBB9oPFFmDJKTZ9iriX0i4hZdiLowut3nP5a
 XdNEMZ+N8WpV1a/5Huxk4WmEYWCSsd1twDT/2lLcUcILqFnEnXTMcQzRqM58B/HTyhDY
 0+NJsQ6Q/wm7whCSDB7m2SQZBiYOwbb/F+W+ghp932vkyoELPpGsH303y0l86H1Kn7m5
 9VnWLAVijSDT+rms/xUxgKNBzKM9bF4DX6D/YtQaKClNdSlgvzTJMMVCZ2gp3t/P1HtW
 lE+phsbSZMgwPlDgTghW0r3vxf5HZey5+A7HCZ7lmCxU6Uebt0BEIVE1xbS454C2U9pH
 TcCw==
X-Gm-Message-State: AOJu0Yy1mIT9+aZ8/JSiE4XP9KGlb8D3tOUqi5Vgy6zJMHaWxfgB+EcI
 f8IAhbWuTu5kU4L+IQhB9sGmx2T4pnyJTCM4X331bzBKtDyIkOqekBSrWNKIqdA9/z/Z+Lf2h1J
 cOEg=
X-Google-Smtp-Source: AGHT+IGdITkr1UuItT6qdDAdVQ5U2X1DyyIZjNJSB0xArZv87aOhcx7K4ukSMb9waboZGh6ustFVXg==
X-Received: by 2002:a17:902:db07:b0:1d8:cd7b:85fa with SMTP id
 m7-20020a170902db0700b001d8cd7b85famr9084561plx.68.1707082892205; 
 Sun, 04 Feb 2024 13:41:32 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/39] tcg/aarch64: Support TCG_COND_TST{EQ,NE}
Date: Mon,  5 Feb 2024 07:40:30 +1000
Message-Id: <20240204214052.5639-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-con-set.h |  5 +--
 tcg/aarch64/tcg-target-con-str.h |  1 +
 tcg/aarch64/tcg-target.h         |  2 +-
 tcg/aarch64/tcg-target.c.inc     | 56 ++++++++++++++++++++++----------
 4 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/tcg/aarch64/tcg-target-con-set.h b/tcg/aarch64/tcg-target-con-set.h
index 3fdee26a3d..44fcc1206e 100644
--- a/tcg/aarch64/tcg-target-con-set.h
+++ b/tcg/aarch64/tcg-target-con-set.h
@@ -10,7 +10,7 @@
  * tcg-target-con-str.h; the constraint combination is inclusive or.
  */
 C_O0_I1(r)
-C_O0_I2(r, rA)
+C_O0_I2(r, rC)
 C_O0_I2(rZ, r)
 C_O0_I2(w, r)
 C_O0_I3(rZ, rZ, r)
@@ -22,6 +22,7 @@ C_O1_I2(r, 0, rZ)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, rA)
 C_O1_I2(r, r, rAL)
+C_O1_I2(r, r, rC)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rL)
 C_O1_I2(r, rZ, rZ)
@@ -31,6 +32,6 @@ C_O1_I2(w, w, wN)
 C_O1_I2(w, w, wO)
 C_O1_I2(w, w, wZ)
 C_O1_I3(w, w, w, w)
-C_O1_I4(r, r, rA, rZ, rZ)
+C_O1_I4(r, r, rC, rZ, rZ)
 C_O2_I1(r, r, r)
 C_O2_I4(r, r, rZ, rZ, rA, rMZ)
diff --git a/tcg/aarch64/tcg-target-con-str.h b/tcg/aarch64/tcg-target-con-str.h
index fb1a845b4f..48e1722c68 100644
--- a/tcg/aarch64/tcg-target-con-str.h
+++ b/tcg/aarch64/tcg-target-con-str.h
@@ -16,6 +16,7 @@ REGS('w', ALL_VECTOR_REGS)
  * CONST(letter, TCG_CT_CONST_* bit set)
  */
 CONST('A', TCG_CT_CONST_AIMM)
+CONST('C', TCG_CT_CONST_CMP)
 CONST('L', TCG_CT_CONST_LIMM)
 CONST('M', TCG_CT_CONST_MONE)
 CONST('O', TCG_CT_CONST_ORRI)
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index b4ac13be7b..ef5ebe91bd 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -138,7 +138,7 @@ typedef enum {
 #define TCG_TARGET_HAS_qemu_ldst_i128   1
 #endif
 
-#define TCG_TARGET_HAS_tst              0
+#define TCG_TARGET_HAS_tst              1
 
 #define TCG_TARGET_HAS_v64              1
 #define TCG_TARGET_HAS_v128             1
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 420e4a35ea..70df250c04 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -126,6 +126,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
 #define TCG_CT_CONST_MONE 0x800
 #define TCG_CT_CONST_ORRI 0x1000
 #define TCG_CT_CONST_ANDI 0x2000
+#define TCG_CT_CONST_CMP  0x4000
 
 #define ALL_GENERAL_REGS  0xffffffffu
 #define ALL_VECTOR_REGS   0xffffffff00000000ull
@@ -279,6 +280,15 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if (type == TCG_TYPE_I32) {
         val = (int32_t)val;
     }
+
+    if (ct & TCG_CT_CONST_CMP) {
+        if (is_tst_cond(cond)) {
+            ct |= TCG_CT_CONST_LIMM;
+        } else {
+            ct |= TCG_CT_CONST_AIMM;
+        }
+    }
+
     if ((ct & TCG_CT_CONST_AIMM) && (is_aimm(val) || is_aimm(-val))) {
         return 1;
     }
@@ -345,6 +355,9 @@ static const enum aarch64_cond_code tcg_cond_to_aarch64[] = {
     [TCG_COND_GTU] = COND_HI,
     [TCG_COND_GEU] = COND_HS,
     [TCG_COND_LEU] = COND_LS,
+    /* bit test */
+    [TCG_COND_TSTEQ] = COND_EQ,
+    [TCG_COND_TSTNE] = COND_NE,
 };
 
 typedef enum {
@@ -1342,19 +1355,26 @@ static inline void tcg_out_dep(TCGContext *s, TCGType ext, TCGReg rd,
     tcg_out_bfm(s, ext, rd, rn, a, b);
 }
 
-static void tcg_out_cmp(TCGContext *s, TCGType ext, TCGReg a,
+static void tcg_out_cmp(TCGContext *s, TCGType ext, TCGCond cond, TCGReg a,
                         tcg_target_long b, bool const_b)
 {
-    if (const_b) {
-        /* Using CMP or CMN aliases.  */
-        if (b >= 0) {
-            tcg_out_insn(s, 3401, SUBSI, ext, TCG_REG_XZR, a, b);
+    if (is_tst_cond(cond)) {
+        if (!const_b) {
+            tcg_out_insn(s, 3510, ANDS, ext, TCG_REG_XZR, a, b);
         } else {
-            tcg_out_insn(s, 3401, ADDSI, ext, TCG_REG_XZR, a, -b);
+            tcg_debug_assert(is_limm(b));
+            tcg_out_logicali(s, I3404_ANDSI, 0, TCG_REG_XZR, a, b);
         }
     } else {
-        /* Using CMP alias SUBS wzr, Wn, Wm */
-        tcg_out_insn(s, 3502, SUBS, ext, TCG_REG_XZR, a, b);
+        if (!const_b) {
+            tcg_out_insn(s, 3502, SUBS, ext, TCG_REG_XZR, a, b);
+        } else if (b >= 0) {
+            tcg_debug_assert(is_aimm(b));
+            tcg_out_insn(s, 3401, SUBSI, ext, TCG_REG_XZR, a, b);
+        } else {
+            tcg_debug_assert(is_aimm(-b));
+            tcg_out_insn(s, 3401, ADDSI, ext, TCG_REG_XZR, a, -b);
+        }
     }
 }
 
@@ -1402,7 +1422,7 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
         need_cmp = false;
     } else {
         need_cmp = true;
-        tcg_out_cmp(s, ext, a, b, b_const);
+        tcg_out_cmp(s, ext, c, a, b, b_const);
     }
 
     if (!l->has_value) {
@@ -1575,7 +1595,7 @@ static void tcg_out_cltz(TCGContext *s, TCGType ext, TCGReg d,
     } else {
         AArch64Insn sel = I3506_CSEL;
 
-        tcg_out_cmp(s, ext, a0, 0, 1);
+        tcg_out_cmp(s, ext, TCG_COND_NE, a0, 0, 1);
         tcg_out_insn(s, 3507, CLZ, ext, TCG_REG_TMP0, a1);
 
         if (const_b) {
@@ -1720,7 +1740,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                          addr_adj, compare_mask);
 
         /* Perform the address comparison. */
-        tcg_out_cmp(s, addr_type, TCG_REG_TMP0, TCG_REG_TMP2, 0);
+        tcg_out_cmp(s, addr_type, TCG_COND_NE, TCG_REG_TMP0, TCG_REG_TMP2, 0);
 
         /* If not equal, we jump to the slow path. */
         ldst->label_ptr[0] = s->code_ptr;
@@ -2276,7 +2296,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         a2 = (int32_t)a2;
         /* FALLTHRU */
     case INDEX_op_setcond_i64:
-        tcg_out_cmp(s, ext, a1, a2, c2);
+        tcg_out_cmp(s, ext, args[3], a1, a2, c2);
         /* Use CSET alias of CSINC Wd, WZR, WZR, invert(cond).  */
         tcg_out_insn(s, 3506, CSINC, TCG_TYPE_I32, a0, TCG_REG_XZR,
                      TCG_REG_XZR, tcg_invert_cond(args[3]));
@@ -2286,7 +2306,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         a2 = (int32_t)a2;
         /* FALLTHRU */
     case INDEX_op_negsetcond_i64:
-        tcg_out_cmp(s, ext, a1, a2, c2);
+        tcg_out_cmp(s, ext, args[3], a1, a2, c2);
         /* Use CSETM alias of CSINV Wd, WZR, WZR, invert(cond).  */
         tcg_out_insn(s, 3506, CSINV, ext, a0, TCG_REG_XZR,
                      TCG_REG_XZR, tcg_invert_cond(args[3]));
@@ -2296,7 +2316,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         a2 = (int32_t)a2;
         /* FALLTHRU */
     case INDEX_op_movcond_i64:
-        tcg_out_cmp(s, ext, a1, a2, c2);
+        tcg_out_cmp(s, ext, args[5], a1, a2, c2);
         tcg_out_insn(s, 3506, CSEL, ext, a0, REG0(3), REG0(4), args[5]);
         break;
 
@@ -2896,11 +2916,13 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_add_i64:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
+        return C_O1_I2(r, r, rA);
+
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i32:
     case INDEX_op_negsetcond_i64:
-        return C_O1_I2(r, r, rA);
+        return C_O1_I2(r, r, rC);
 
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
@@ -2950,11 +2972,11 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return C_O0_I2(r, rA);
+        return C_O0_I2(r, rC);
 
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
-        return C_O1_I4(r, r, rA, rZ, rZ);
+        return C_O1_I4(r, r, rC, rZ, rZ);
 
     case INDEX_op_qemu_ld_a32_i32:
     case INDEX_op_qemu_ld_a64_i32:
-- 
2.34.1


