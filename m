Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06406C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfMLH-0007B9-MX; Thu, 02 Jul 2026 14:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfMKo-0006zh-B9
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfMKl-0005KW-HU
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:26 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so14931375e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783017622; x=1783622422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lpwBOWPVMATfbpndlLRvz9T6HcOtZn2wa3F6Vcr3xJ0=;
 b=yQxj0Y8647pI+FVvSaBw3TywVXTlV8FBZxHA/65FMidLjKDxoFmsPBgZcngrUYoMRn
 Gg+jebs+Vua1gU7/MhQDXif1XfBu+NeorHtRjtQgbr3BTmPqRFuB4Kd+hwhjLwV6U0wj
 V+W4fo3Xc0Ytl9NuaaTBfojsxlfUDENe1HLHq9qEuD2oIyW+ei4heGmZN0+D+4JQG1WO
 bHyfx15n+SrEySHDN7FH7NAMyx0gFxF8YjvZ1Vrk9AAMVmhUevyzlty28k2SCfgco+Sk
 cOM+bD8bjewPApgRaa/lI38j0MG/I4+4K+i+LwdUdBjIfIaZbAv0E45b8ve0IwdfP147
 06wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783017622; x=1783622422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lpwBOWPVMATfbpndlLRvz9T6HcOtZn2wa3F6Vcr3xJ0=;
 b=RH5EDixqvFKzYShGJ6d6+3IxD2PFcc11kTaMCqjxoMa71trOJECjCBUN+mlnMBsRk0
 jfxfF5u/UhRTiqTpRhFEBixUYoDM5ncN9NQ+wmA/NiDdxR47ezGsqc15rdYO8s49U7Ze
 8RZlwsesUF9/saxNCP4oTduqcI9FIAyOB5+aLlICJNUIuUZzUtw5eRZ2tKgQQ+It/DBY
 5WqkWBTyqt57uajDjt6rAGG2GTYpaetLtWHF5nRrnxZK/UcKTGHzftp5qkIhbo6HZTqJ
 4HD5A6pRsb+nZdp1wRC2mJm4iR1qNZwwyHQJ5Pu3/ohNeqnhsC26XiIqU17AVUNGAzt5
 h9AQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8pWTYeC03EjZ09otBWK/ThLyBXZazLinZqokyfRkH9VkD04cHEC2a7Vq47NTaCU/korxbtuPb/5I6x@nongnu.org
X-Gm-Message-State: AOJu0YySvj471EgMNMmRqPgwgWY/zSXiv8v655vEO74ntJ9A4v7aWLWL
 y/qW6VfXqrvoHOWv0Et0NmT5TwKvjAnILVDJpJcW3VZmTKMlTrP7dFYC0y09VZnJSB27DSo5ohd
 QIT4Z2ewtYw==
X-Gm-Gg: AfdE7cnlzyYEewjbrH4/O9UbKppfd0n7p8ZPpmgBSL3vgYR0GoeoBO9u4JaKyrKSBBR
 laixoJfQpNZJhpQejenxshTCn5R3E00vFElTSZ4veHKou7BFFcx+j8yFsoUkdCleSz+abMce1wk
 mIfUUnkjcNPU+K6uvJyOPz0zbhFwCasTsYpU95n8/Vm15cr6eVAzvAFP3xRZRbU/WIlhxmWS4cH
 tLFt1bzcXhcBeFV58JleRgzD/m2qK+WRkv1rrcwLYcjYyCY7F8M0urvUKVXY/hy6B8BJbmXCg40
 1JSVebGppaNfBM08hcNVd9dSewJhf68HxotZW3E5NoP/NUv4LI8PkjBPJslZtjJRF2+4OPgHtCw
 U+iUrFM0f5CUxCeJmKBzSjj8lDGyDaPQqE63uj3N6Lm9BIpX4XB6cbAGDPNhYudVY6h/seHqGyy
 jNAU5Y0G1mYrfj5zRcy9dDOIfSBTJedWi2ycELB/6tqp2orWbQhUj09o+sU7fir8nHuUkWTG3xA
 4bS4WYde+IhNtS+9QmuXA==
X-Received: by 2002:a05:600c:8590:b0:492:4e1c:120 with SMTP id
 5b1f17b1804b1-493c2ba4360mr86893615e9.32.1783017621648; 
 Thu, 02 Jul 2026 11:40:21 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a4a09sm11628213f8f.13.2026.07.02.11.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 11:40:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/11] target/arm: Separate out Neon from VFP access checks
Date: Thu,  2 Jul 2026 19:40:09 +0100
Message-ID: <20260702184019.3431139-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702184019.3431139-1-peter.maydell@linaro.org>
References: <20260702184019.3431139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Currently we use vfp_access_check() for AArch32 VFP and Neon
instructions.  This is not quite right:
 * there are optional CPACR.ASEDIS and HCPTR.TASE controls that allow
   trapping of just the Neon and not VFP instructions
 * Neon instructions are supposed to report a slightly different
   syndrome in HCR when they trap to AArch32 EL2

As a preliminary refactor so we have somewhere we can make this
distinction, separate out Neon access checks into a separate
neon_access_check(), which initially just calls vfp_access_check().

The set of insns this needs to cover are those described in section
E1.3.9 of the DDI0487M.b Arm ARM.  For us this corresponds to
everything in neon-dp.decode and neon-ls.decode and thus in
translate-neon.c, plus three insns that we handle in translate-vfp.c:
 - VDUP (general-purpose register)
 - VMOV (general-purpose register to scalar) byte and halfword
 - VMOV (scalar to general-purpose register) byte and halfword
(which are the ones in that file with ARM_FEATURE_NEON checks).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a32.h  |  1 +
 target/arm/tcg/translate-neon.c | 74 ++++++++++++++++-----------------
 target/arm/tcg/translate-vfp.c  | 33 +++++++++++----
 3 files changed, 62 insertions(+), 46 deletions(-)

diff --git a/target/arm/tcg/translate-a32.h b/target/arm/tcg/translate-a32.h
index a8df364171..1023cddab5 100644
--- a/target/arm/tcg/translate-a32.h
+++ b/target/arm/tcg/translate-a32.h
@@ -33,6 +33,7 @@ void load_reg_var(DisasContext *s, TCGv_i32 var, int reg);
 void arm_gen_condlabel(DisasContext *s);
 bool vfp_access_check(DisasContext *s);
 bool vfp_access_check_m(DisasContext *s, bool skip_context_update);
+bool neon_access_check(DisasContext *s);
 void read_neon_element32(TCGv_i32 dest, int reg, int ele, MemOp memop);
 void read_neon_element64(TCGv_i64 dest, int reg, int ele, MemOp memop);
 void write_neon_element32(TCGv_i32 src, int reg, int ele, MemOp memop);
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index e3c7d9217b..50a44511d9 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -135,7 +135,7 @@ static bool do_neon_ddda(DisasContext *s, int q, int vd, int vn, int vm,
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -165,7 +165,7 @@ static bool do_neon_ddda_env(DisasContext *s, int q, int vd, int vn, int vm,
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -197,7 +197,7 @@ static bool do_neon_ddda_fpst(DisasContext *s, int q, int vd, int vn, int vm,
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -249,7 +249,7 @@ static bool trans_VCADD(DisasContext *s, arg_VCADD *a)
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -319,7 +319,7 @@ static bool trans_VFML(DisasContext *s, arg_VFML *a)
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -413,7 +413,7 @@ static bool trans_VFML_scalar(DisasContext *s, arg_VFML_scalar *a)
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -506,7 +506,7 @@ static bool trans_VLDST_multiple(DisasContext *s, arg_VLDST_multiple *a)
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -617,7 +617,7 @@ static bool trans_VLD_all_lanes(DisasContext *s, arg_VLD_all_lanes *a)
         }
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -714,7 +714,7 @@ static bool trans_VLDST_single(DisasContext *s, arg_VLDST_single *a)
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -798,7 +798,7 @@ static bool do_3same(DisasContext *s, arg_3same *a, GVecGen3Fn fn)
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -1076,7 +1076,7 @@ static bool do_vector_2sh(DisasContext *s, arg_2reg_shift *a, GVecGen2iFn *fn)
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -1126,7 +1126,7 @@ static bool do_2shift_narrow_64(DisasContext *s, arg_2reg_shift *a,
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -1177,7 +1177,7 @@ static bool do_2shift_narrow_32(DisasContext *s, arg_2reg_shift *a,
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -1302,7 +1302,7 @@ static bool do_vshll_2sh(DisasContext *s, arg_2reg_shift *a,
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -1392,7 +1392,7 @@ static bool do_fp_2sh(DisasContext *s, arg_2reg_shift *a,
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -1436,7 +1436,7 @@ static bool do_1reg_imm(DisasContext *s, arg_1reg_imm *a,
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -1499,7 +1499,7 @@ static bool do_prewiden_3d(DisasContext *s, arg_3diff *a,
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -1606,7 +1606,7 @@ static bool do_narrow_3d(DisasContext *s, arg_3diff *a,
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -1696,7 +1696,7 @@ static bool do_long_3d(DisasContext *s, arg_3diff *a,
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -1967,7 +1967,7 @@ static bool trans_VMULL_P_3d(DisasContext *s, arg_3diff *a)
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -2041,7 +2041,7 @@ static bool do_2scalar(DisasContext *s, arg_2scalar *a,
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -2139,7 +2139,7 @@ static bool do_2scalar_fp_vec(DisasContext *s, arg_2scalar *a,
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -2236,7 +2236,7 @@ static bool do_vqrdmlah_2sc(DisasContext *s, arg_2scalar *a,
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -2307,7 +2307,7 @@ static bool do_2scalar_long(DisasContext *s, arg_2scalar *a,
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -2451,7 +2451,7 @@ static bool trans_VEXT(DisasContext *s, arg_VEXT *a)
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -2520,7 +2520,7 @@ static bool trans_VTBL(DisasContext *s, arg_VTBL *a)
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -2555,7 +2555,7 @@ static bool trans_VDUP_scalar(DisasContext *s, arg_VDUP_scalar *a)
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -2591,7 +2591,7 @@ static bool do_zip_uzp(DisasContext *s, arg_2misc *a,
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -2660,7 +2660,7 @@ static bool do_vmovn(DisasContext *s, arg_2misc *a,
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -2724,7 +2724,7 @@ static bool trans_VSHLL(DisasContext *s, arg_2misc *a)
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -2764,7 +2764,7 @@ static bool trans_VCVT_B16_F32(DisasContext *s, arg_2misc *a)
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -2804,7 +2804,7 @@ static bool trans_VCVT_F16_F32(DisasContext *s, arg_2misc *a)
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -2850,7 +2850,7 @@ static bool trans_VCVT_F32_F16(DisasContext *s, arg_2misc *a)
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -2900,7 +2900,7 @@ static bool do_2misc_vec(DisasContext *s, arg_2misc *a, GVecGen2Fn *fn)
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -3028,7 +3028,7 @@ static bool do_2misc(DisasContext *s, arg_2misc *a, NeonGenOneOpFn *fn)
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -3232,7 +3232,7 @@ static bool trans_VSWP(DisasContext *s, arg_2misc *a)
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
@@ -3305,7 +3305,7 @@ static bool trans_VTRN(DisasContext *s, arg_2misc *a)
         return false;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 8d9d1ab877..6f6b234c9a 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -303,6 +303,17 @@ bool vfp_access_check(DisasContext *s)
     }
 }
 
+/*
+ * Access check for Neon; this is for instructions which can be
+ * trapped by CPACR.ASEDIS and HCPTR.TASE. Support for those traps
+ * is optional and we currently do not implement them, so this
+ * is identical to a VFP access check for now.
+ */
+bool neon_access_check(DisasContext *s)
+{
+    return vfp_access_check(s);
+}
+
 static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
 {
     uint32_t rd, rn, rm;
@@ -620,15 +631,17 @@ static bool trans_VMOV_to_gp(DisasContext *s, arg_VMOV_to_gp *a)
 {
     /* VMOV scalar to general purpose register */
     TCGv_i32 tmp;
+    bool insn_is_neon = false;
 
     /*
      * SIZE == MO_32 is a VFP instruction; otherwise NEON. MVE has
      * all sizes, whether the CPU has fp or not.
      */
     if (!dc_isar_feature(aa32_mve, s)) {
-        if (a->size == MO_32
-            ? !dc_isar_feature(aa32_fpsp_v2, s)
-            : !arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        insn_is_neon = a->size != MO_32;
+        if (insn_is_neon
+            ? !arm_dc_feature(s, ARM_FEATURE_NEON)
+            : !dc_isar_feature(aa32_fpsp_v2, s)) {
             return false;
         }
     }
@@ -644,7 +657,7 @@ static bool trans_VMOV_to_gp(DisasContext *s, arg_VMOV_to_gp *a)
         }
     }
 
-    if (!vfp_access_check(s)) {
+    if (!(insn_is_neon ? neon_access_check(s) : vfp_access_check(s))) {
         return true;
     }
 
@@ -665,15 +678,17 @@ static bool trans_VMOV_from_gp(DisasContext *s, arg_VMOV_from_gp *a)
 {
     /* VMOV general purpose register to scalar */
     TCGv_i32 tmp;
+    bool insn_is_neon = false;
 
     /*
      * SIZE == MO_32 is a VFP instruction; otherwise NEON. MVE has
      * all sizes, whether the CPU has fp or not.
      */
     if (!dc_isar_feature(aa32_mve, s)) {
-        if (a->size == MO_32
-            ? !dc_isar_feature(aa32_fpsp_v2, s)
-            : !arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        insn_is_neon = a->size != MO_32;
+        if (insn_is_neon
+            ? !arm_dc_feature(s, ARM_FEATURE_NEON)
+            : !dc_isar_feature(aa32_fpsp_v2, s)) {
             return false;
         }
     }
@@ -689,7 +704,7 @@ static bool trans_VMOV_from_gp(DisasContext *s, arg_VMOV_from_gp *a)
         }
     }
 
-    if (!vfp_access_check(s)) {
+    if (!(insn_is_neon ? neon_access_check(s) : vfp_access_check(s))) {
         return true;
     }
 
@@ -736,7 +751,7 @@ static bool trans_VDUP(DisasContext *s, arg_VDUP *a)
         size = 2;
     }
 
-    if (!vfp_access_check(s)) {
+    if (!neon_access_check(s)) {
         return true;
     }
 
-- 
2.43.0


