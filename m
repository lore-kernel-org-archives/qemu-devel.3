Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49327C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvwcD-0003fE-3m; Mon, 17 Aug 2026 08:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvwcA-0003eb-W6
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 08:38:55 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvwc8-0001FZ-Sc
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 08:38:54 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so2215203f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 05:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786970328; x=1787575128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a4mTZ5g0cy4LmSJNT3iPqkHoIAe+oQQRsZB2eCpXAsU=;
 b=I8FIRWZNkd1F4UVUzJWOwFPca1iSZuJNn7KlExlMSgexVrZj0HL9YlMcEsWM80iV9T
 355BQgVf6Ldz7Nmrj0bxF6w/fXFZcVD/WvT5+7aG92sy4N0eEVUDXogVKKag2UlSK+0l
 fcEaqNRs9s/rpRsw6tbRlN9fsmFXNgsSQ0CkygZbM1VI9t09Cgfb/a3WjqyYC1MaSaRk
 NaMT/z6qV4cx0lJqETtKX251+Hh63x5rRtFshCaS73ynWXegDm43wDjuiZmD+uxC1/Gx
 oo6TXOO5PC/QFBx3Ai4fYvsH810Ue5VO1a3C2m40HFFrMzNgueCfVenjqWNCvoGkQl93
 9VaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786970328; x=1787575128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=a4mTZ5g0cy4LmSJNT3iPqkHoIAe+oQQRsZB2eCpXAsU=;
 b=Rg9I2LI2imKBYsIHQIeIOK7tOpnf2i9MDRAfX4l8Rw5kbn7zNXU6kChknn0oGkeccZ
 2qoz9sfr5nMw0XG3uVInOMr+qdSXDG5TAC18mha12aIWfxMyBV9p4K0OYKtTzIXtHnRF
 GhLUkBvJ1kZ7WY1AO6S70M2w5DPiRq8lvl0gTEiPKO+VyxsRQP3ULZi7mEtuPg9AAleg
 5hWnrHDwp/km+moBKp62Wv831Bhg+lNZy445PioxDEEp+ZHuwY5tJ8LuBmgguPqL9A63
 OLbDgvERunsylR1qHYtdosPVxwx3WDvrsJ5ST+jeQT0Ll+yJqOZ2G1yBDzKEp5s2VQ6n
 JaXw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0D8uU8P375lQemH8wOUOL1p5Y89UNfG+hGtkornZ0unPSa7iE+O0+9Qn+gA1gxoPimTkrxtRd78/C@nongnu.org
X-Gm-Message-State: AOJu0YxYlSdVWPNW2D++Hro4JE1N/91cq4CxrvIP/2mKpLQYHBiqGmMz
 lYL+Lyg5EP3YC3cpbpidpjsAcDAhNdnhRQDOx9hJadmLU+GQWs9AXV8vA28T9AXSXZ4=
X-Gm-Gg: AR+sD127gnLPYXd8iOEsNlIz9mK+YdAksy3eH3TQWAOHC6IZU/oJNKDkP7hkQyFCvOj
 Kk8BdcpVWYu0eOnBj2sgEC8gV4x6gYAjF3kZkLQiWW3xbFWwNiMjeL2+b4Cswu/H9Plkg/ZUDfe
 GbK2e3VmLgBjAUTzx57JBIGdCdiQJE/rg6iwsz1vnTnOEZAR0JrPWtOVO6HAykUGmRmV3XDarot
 KNG9b9H80Smu16tyxy6yN57n/a7usbukX9R6MBTMBpWqh+PslE3+D+FvrKS84IlkjZGDmbBWGie
 96Z8Uz84PNBcUVxGxfyUFYtyMNZcZw2ziPsvjG9UVWr/7ZqAWhgaw+5l9B+F/51DX0slEko4sbn
 1CEEXT/efAh4BJoUaIBv0xosj09K2tht2Bh6xgPERKKQHbxohL3GSR8bhKfRxa12XryvySjVlyA
 WM6WCpoNW/I+l7at7tno4OfnrmbbwB899DfU/EdoKC3JDfhOtZ3YXv9OHbWBqBvSCOX3wf50+WL
 X9ZRc/pYQ/DpcglSLCOqnqynaNSIabE/T3GEOJTz3EmPHHcaC6LPWvQuYGC4C3V320f8w==
X-Received: by 2002:a05:600c:5307:b0:499:8c68:a3aa with SMTP id
 5b1f17b1804b1-4998c68a830mr376387265e9.13.1786970328543; 
 Mon, 17 Aug 2026 05:38:48 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998780397dsm120415055e9.3.2026.08.17.05.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:38:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 6/8] target/arm: Pull VFP dregs checks out into a function
Date: Mon, 17 Aug 2026 13:38:36 +0100
Message-ID: <20260817123838.1578060-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817123838.1578060-1-peter.maydell@linaro.org>
References: <20260817123838.1578060-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently we directly call dc_isar_feature(aa32_simd_r32, s) for VFP
insns that use D16-D31 to see if they should UNDEF.  For some v7A
CPUs (Cortex-A7, Cortex-A9) there is also a CPACR.D32DIS trap bit
that will make VFP (and only VFP, not Neon) insns using D16-D31
UNDEF.

Abstract out the register check for VFP insns into a new function
which will provide us a place where we can make this check.

Since D32DIS takes precedence over traps to EL2 and EL3 and simply
makes the insns UNDEF, we are OK to check it at the same point when
we do the CPU feature check, rather than having to wait until
vfp_access_check().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-vfp.c | 70 ++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 4db4b14841..a8d470ec49 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -207,6 +207,23 @@ static void gen_update_fp_context(DisasContext *s)
     }
 }
 
+/*
+ * Return true if a VFP insn is OK to access the registers indicated
+ * by regmask, false if it should UNDEF. This checks whether the
+ * D16-D31 regs are implemented by the CPU. Eventually we will also check
+ * CPACR.D32DIS.
+ * Note that Neon insns accessing D16..D31 do not need to check D32DIS,
+ * so this function is for VFP insns only.
+ *
+ * @regmask should be the logical OR of the VFP Dregs being accessed.
+ */
+static bool vfp_dregs_ok(DisasContext *s, int dregmask)
+{
+    int invalid_dreg_mask = dc_isar_feature(aa32_simd_r32, s) ? 0 : 0x10;
+
+    return !(dregmask & invalid_dreg_mask);
+}
+
 /*
  * Check that VFP access is enabled, A-profile specific version.
  *
@@ -347,8 +364,7 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (sz == 3 && !dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vm | a->vn | a->vd) & 0x10)) {
+    if (sz == 3 && !vfp_dregs_ok(s, a->vm | a->vn | a->vd)) {
         return false;
     }
 
@@ -473,8 +489,7 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (sz == 3 && !dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vm | a->vd) & 0x10)) {
+    if (sz == 3 && !vfp_dregs_ok(s, a->vm | a->vd)) {
         return false;
     }
 
@@ -541,7 +556,7 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (sz == 3 && !dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
+    if (sz == 3 && !vfp_dregs_ok(s, a->vm)) {
         return false;
     }
 
@@ -662,7 +677,7 @@ static bool trans_VMOV_to_gp(DisasContext *s, arg_VMOV_to_gp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vn & 0x10)) {
+    if (!vfp_dregs_ok(s, a->vn & 0x10)) {
         return false;
     }
 
@@ -709,7 +724,7 @@ static bool trans_VMOV_from_gp(DisasContext *s, arg_VMOV_from_gp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vn & 0x10)) {
+    if (!vfp_dregs_ok(s, a->vn & 0x10)) {
         return false;
     }
 
@@ -745,7 +760,7 @@ static bool trans_VDUP(DisasContext *s, arg_VDUP *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vn & 0x10)) {
+    if (!vfp_dregs_ok(s, a->vn)) {
         return false;
     }
 
@@ -1030,7 +1045,7 @@ static bool trans_VMOV_64_dp(DisasContext *s, arg_VMOV_64_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
+    if (!vfp_dregs_ok(s, a->vm)) {
         return false;
     }
 
@@ -1132,7 +1147,7 @@ static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+    if (!vfp_dregs_ok(s, a->vd)) {
         return false;
     }
 
@@ -1261,7 +1276,7 @@ static bool trans_VLDM_VSTM_dp(DisasContext *s, arg_VLDM_VSTM_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd + n) > 16) {
+    if (!vfp_dregs_ok(s, a->vd + n - 1)) {
         return false;
     }
 
@@ -1513,7 +1528,7 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && ((vd | vn | vm) & 0x10)) {
+    if (!vfp_dregs_ok(s, vd | vn | vm)) {
         return false;
     }
 
@@ -1685,7 +1700,7 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
     /* Note that the caller must check the aa32_fpdp_v2 feature. */
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && ((vd | vm) & 0x10)) {
+    if (!vfp_dregs_ok(s, vd | vm)) {
         return false;
     }
 
@@ -2252,8 +2267,7 @@ static bool do_vfm_dp(DisasContext *s, arg_VFMA_dp *a, bool neg_n, bool neg_d)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
+    if (!vfp_dregs_ok(s, a->vd | a->vn | a->vm)) {
         return false;
     }
 
@@ -2380,7 +2394,7 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (vd & 0x10)) {
+    if (!vfp_dregs_ok(s, vd)) {
         return false;
     }
 
@@ -2555,7 +2569,7 @@ static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && ((a->vd | a->vm) & 0x10)) {
+    if (!vfp_dregs_ok(s, a->vd | a->vm)) {
         return false;
     }
 
@@ -2621,7 +2635,7 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd  & 0x10)) {
+    if (!vfp_dregs_ok(s, a->vd)) {
         return false;
     }
 
@@ -2702,7 +2716,7 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm  & 0x10)) {
+    if (!vfp_dregs_ok(s, a->vm)) {
         return false;
     }
 
@@ -2777,7 +2791,7 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && ((a->vd | a->vm) & 0x10)) {
+    if (!vfp_dregs_ok(s, a->vd | a->vm)) {
         return false;
     }
 
@@ -2856,7 +2870,7 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && ((a->vd | a->vm) & 0x10)) {
+    if (!vfp_dregs_ok(s, a->vd | a->vm)) {
         return false;
     }
 
@@ -2930,7 +2944,7 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && ((a->vd | a->vm) & 0x10)) {
+    if (!vfp_dregs_ok(s, a->vd | a->vm)) {
         return false;
     }
 
@@ -2956,7 +2970,7 @@ static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+    if (!vfp_dregs_ok(s, a->vd)) {
         return false;
     }
 
@@ -2982,7 +2996,7 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
+    if (!vfp_dregs_ok(s, a->vm)) {
         return false;
     }
 
@@ -3063,7 +3077,7 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+    if (!vfp_dregs_ok(s, a->vd)) {
         return false;
     }
 
@@ -3100,7 +3114,7 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
+    if (!vfp_dregs_ok(s, a->vm)) {
         return false;
     }
 
@@ -3240,7 +3254,7 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+    if (!vfp_dregs_ok(s, a->vd)) {
         return false;
     }
 
@@ -3369,7 +3383,7 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
+    if (!vfp_dregs_ok(s, a->vm)) {
         return false;
     }
 
-- 
2.43.0


