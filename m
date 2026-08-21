Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DC9C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN16-0000h5-Fx; Fri, 21 Aug 2026 07:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0z-0000WU-RJ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:27 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0u-0007U5-Qj
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:22 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-499840a2575so4775435e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310139; x=1787914939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZhTa4gPey37Kb/POJTgaKRANSs+4AZwBwc9vJ063Ahw=;
 b=qXjcDXUF5UaXH5cmBFdVm/vFgnKTT0HiytGGEaHvk7ff2RglLXy0qfecqpGPo+Wc27
 oFb4PkV6aZ5W+Fk+GcbYeLBef/pWSsV16rMS9BeN/mtSTaoZ6AIVwxx+GI7NBVsDun6D
 P8VaCgC0Qqj1HAZITNplC7ZdJkkys28/ASxkcjyzJxOcT1JbJilu86t3ViLVBTMGYByO
 /kE2DlEEscD0d54XakErXEGVskbRd4wjsTYE5DsgaXgIkTvuB9+MD/bX5Cvh37rFRlwe
 LSkT0kgcPAyJksOORO1ADDxuWqBvnYnuFiTVpK98ZHab7PtVvQ2zyJqpzPeXLeFoS79G
 9s0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310139; x=1787914939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZhTa4gPey37Kb/POJTgaKRANSs+4AZwBwc9vJ063Ahw=;
 b=c/db8cMdIxxGMC+bQY3hO++A12ubk/7oIqhjkmnVK3mgIWFnA+Eyj2t9NBUaLTSNYi
 TE+lTXXLswgxQgqNBEPBG+oq/YdZdpaUGyoRlx8lMQ/w0ktIROVvWSjexdfoC1PTLjdL
 9U3DcptYTy+ayEL8sXYDebWR3wSdz7wB1cNOsy2P3oLvku14MdEY3ZYh9om9/gGJpFDk
 +x+b2W4vT3ifXvRz8RLfngasbma7rEW57jmKuoFrnPteyggA56QPwXKo3JIzOEDHQIFw
 RwxlMH3VriXdo7rdPTSslCFckh+Kpuf99DKW1JWoGnNGw4dorTCs86r46LiaeyQyTr7x
 6aUA==
X-Gm-Message-State: AOJu0YwUWWpxH5tPh7w/qX1oSVoQ0/deBPTCUYCxGk04U7B+S2ywBpHM
 yhcQOx41T92yw6AnzBvr0Y6I6b4W9Zt8He6czO+K42ieueECnz3dX1SCwaj+ms7Vtq0QXR0xKXh
 OsUFX
X-Gm-Gg: AR+sD10ACt5qhs0jnZScuU8TKq65+jHC+iZb1AAi6w0Bx1rupht1Es7CdBAwP+V4lng
 4/jAqUU8K3Lh0c5qSpQA49kvVnL3fKWqLd6IioM2hoJyM2rW9CZS+MaCMM2sAJT5Dalml4JrQC7
 W8vHfLfBY9VSJeBqVyCxmnty8gfjg0CDyUmJ/fTQdThPiYTm5Xm6WIO/mfOVU8wWEBsffJdr7Vf
 gXsYmAxnPTavKjsmU6elvjCclJLg/NL/+/iaKc0VRN4/QP7J7dMWLcgu3M/ncaFDmCWsaL1PlZD
 o4mL87YJsPBYMw5ZOnu1S4CcxnBOspRG2mRZaRg2447e33F0ZQCKULs0W5zd0/F1cVg9icGjAVf
 87fuSvLyOz3ZMZzOsNCtmSXahZrzBiM498A/nLJDBbMP3Wgl+TtajCfHzyxpqwrGIBZcg1swlhn
 cuYMzQGr90kH+2JQhmf9wUPOVaz/f5eu2he+T189Orr2Ezp4igwR4myEOwJS6D6ETrppYgSTBdG
 nKqgj5N3c1Ai3jRzT23i6h9acxMsVt4Uc0w+l4oBJThxeh48daM+2hn1PHyebBiHuKaHQ==
X-Received: by 2002:a05:600c:3492:b0:495:5890:8f6c with SMTP id
 5b1f17b1804b1-499b8339418mr82912465e9.7.1787310139298; 
 Fri, 21 Aug 2026 04:02:19 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/43] target/arm: Pull VFP dregs checks out into a function
Date: Fri, 21 Aug 2026 12:00:39 +0100
Message-ID: <20260821110101.3971391-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260817123838.1578060-7-peter.maydell@linaro.org
---
 target/arm/tcg/translate-vfp.c | 70 ++++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 4db4b14841d..a8d470ec49c 100644
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


