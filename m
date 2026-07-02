Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9839EC43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfMLM-0007Nk-0v; Thu, 02 Jul 2026 14:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfMLH-0007Bp-OS
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:55 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfMLB-0005NY-NQ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:55 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-472326ca506so1535163f8f.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783017630; x=1783622430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ERT5FGdTM2la0VXNAKarQCU8EPQ7kfgNCQO83CFn2Vo=;
 b=UR6PAXGUcJZAJkLSFXacYP2r97VRxUyh62WNiyAqVnSX7J1wyqL8UYkNGRb/83f4Rh
 J0n/S+Do/pp7tSiyS4XXSJTlrRDjYXuH7Sy8bOxBRReOcIITCiXw/7Yl5WK2Ub0il7Ez
 kQlnCrzYX3wdlB85b9mSZO4emguX9xTFpEp48AVQspFWU1Gp3fwLGMDocXVY5fdRhy4n
 5ePCPDFIMl8PHPbEJOOD4z/E1AzUgJgnJyAp+T6rLYod0xAv0Vp1USNolLbPaKNwuR3a
 xUc6Lie7hMMW4y2LzIiUmg/bfDfhmuPsuQmFIawnRDITtBRe7BNbEz0beKjw7bQvQExw
 2DCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783017630; x=1783622430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ERT5FGdTM2la0VXNAKarQCU8EPQ7kfgNCQO83CFn2Vo=;
 b=sfnC1EsXM9Q9QpYqb/wapc8tEfkxRE2ZHwOKnHH0mAToHjs23O1lu5AA+vx28rgtO0
 wqQa/B5e72klTA4N2wlf/V/NabFy2Pnns/XBDv4MR8nkpDTJaqxeLLjfgi+F+r+S1b6c
 M35iG60H9LA/mOgMqUCY2DmlotX1eOEq9WpFY2Ny0aQuIFotgFx1s1cbmXc+mDhOZXQm
 CNU3nf9HjyskJLsizeEZLrtZ8I/8buHc7UOdgTx/blSRFL00K2FyoF+eNN2bSOURC3uV
 Y6Y7rH7DIZqEXExTAA7MDAN4eeUREVl7xaaRNXw5ZNNO87U+ohGtATkdFryWCErCDhsU
 pV2A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3a8Affxf7xyeB1u4NOvjCfFJY2b72OeUTHe+ssE4r5VhVYWdkmVBoa7vCMMbJVibm7GpMnuKqZNVB@nongnu.org
X-Gm-Message-State: AOJu0YxRANAuwfKVOzY9fBtwMP26520J4Pso0BrnFIKm2waF0EDuR5x/
 9ATgnSqcAb9ejDXaL+jcMC/ridVPUxXiCFOCyi9wieikKbkb8WqRJ7sYoWJL+CZtES4=
X-Gm-Gg: AfdE7cn4836LqA9uuGufLqr0SLTQsIAzd5AEnrPgfgPSAKHMhFJDq16a+Q/pudQVhhB
 ALyuJyN0Nn9bMy63vf2APd63COzXOH3JXCRcY5jHfWHmzIsDgLDk37a8qNAwYLMlC5AUgFAEGst
 AbTsWw3bXY8pgeg7Ne0PWh4dsnQncPi2ZQMC4K5m+9xSY/Z7U61H0xY7KKwiNXXD3OF6INy9BO1
 60DqB0lY08PlTkKFAb8CmILEqG1xMS2hZxCcglQI3ByJGA8ZmrtZtN2xg/ZGf2ufOLL+BMAzARh
 jShrEPqtzV5BGvOBwdhBcNI18qXuHxx+M0qlO6V7rFfZTylVJgv5vhqNX62wj5wCAOQNWvcLCgg
 CCcQpvpfP3EKTcNkcMHo62bKMuKuq5DMr6OrFyly2ppXHz1SQGbNr+EcX3RPA6epDMwmQLoSvze
 3hYdnIPQr8OvwNoO9wungK2fYu3qNskIMelBJs5hbrF6zcUEzc6zj+dUNl0/hr7ybWEo1uFUXBG
 vtdZ6qMK1BbZBTz9XJTv5WdNP246279
X-Received: by 2002:a05:6000:240c:b0:46e:6210:ad4a with SMTP id
 ffacd0b85a97d-47757e57e77mr10943105f8f.5.1783017630044; 
 Thu, 02 Jul 2026 11:40:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a4a09sm11628213f8f.13.2026.07.02.11.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 11:40:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 10/11] target/arm: Pull VFP "can we use D16-D31" checks out
 into a function
Date: Thu,  2 Jul 2026 19:40:18 +0100
Message-ID: <20260702184019.3431139-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702184019.3431139-1-peter.maydell@linaro.org>
References: <20260702184019.3431139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

Pull out a function vfp_d16_d31_ok() that currently just does the
feature check but which will provide us a place where we can make
this check.  Since D32DIS takes precedence over traps to EL2 and EL3
and simply makes the insns UNDEF, we are OK to do this early rather
than having to wait until vfp_access_check().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-vfp.c | 61 ++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 4db4b14841..3d6c67efb9 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -207,6 +207,17 @@ static void gen_update_fp_context(DisasContext *s)
     }
 }
 
+/*
+ * Return true if a VFP insn is OK to access D16..D31, false if
+ * it should UNDEF. This checks whether the D16-D31 regs are
+ * implemented by the CPU. Eventually we will also check CPACR.D32DIS.
+ * Note that Neon insns accessing D16..D31 do not need to check D32DIS.
+ */
+static bool vfp_d16_d31_ok(DisasContext *s)
+{
+    return dc_isar_feature(aa32_simd_r32, s);
+}
+
 /*
  * Check that VFP access is enabled, A-profile specific version.
  *
@@ -347,7 +358,7 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (sz == 3 && !dc_isar_feature(aa32_simd_r32, s) &&
+    if (sz == 3 && !vfp_d16_d31_ok(s) &&
         ((a->vm | a->vn | a->vd) & 0x10)) {
         return false;
     }
@@ -473,7 +484,7 @@ static bool trans_VRINT(DisasContext *s, arg_VRINT *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (sz == 3 && !dc_isar_feature(aa32_simd_r32, s) &&
+    if (sz == 3 && !vfp_d16_d31_ok(s) &&
         ((a->vm | a->vd) & 0x10)) {
         return false;
     }
@@ -541,7 +552,7 @@ static bool trans_VCVT(DisasContext *s, arg_VCVT *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (sz == 3 && !dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
+    if (sz == 3 && !vfp_d16_d31_ok(s) && (a->vm & 0x10)) {
         return false;
     }
 
@@ -662,7 +673,7 @@ static bool trans_VMOV_to_gp(DisasContext *s, arg_VMOV_to_gp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vn & 0x10)) {
+    if (!vfp_d16_d31_ok(s) && (a->vn & 0x10)) {
         return false;
     }
 
@@ -709,7 +720,7 @@ static bool trans_VMOV_from_gp(DisasContext *s, arg_VMOV_from_gp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vn & 0x10)) {
+    if (!vfp_d16_d31_ok(s) && (a->vn & 0x10)) {
         return false;
     }
 
@@ -745,7 +756,7 @@ static bool trans_VDUP(DisasContext *s, arg_VDUP *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vn & 0x10)) {
+    if (!vfp_d16_d31_ok(s) && (a->vn & 0x10)) {
         return false;
     }
 
@@ -1030,7 +1041,7 @@ static bool trans_VMOV_64_dp(DisasContext *s, arg_VMOV_64_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
+    if (!vfp_d16_d31_ok(s) && (a->vm & 0x10)) {
         return false;
     }
 
@@ -1132,7 +1143,7 @@ static bool trans_VLDR_VSTR_dp(DisasContext *s, arg_VLDR_VSTR_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+    if (!vfp_d16_d31_ok(s) && (a->vd & 0x10)) {
         return false;
     }
 
@@ -1261,7 +1272,7 @@ static bool trans_VLDM_VSTM_dp(DisasContext *s, arg_VLDM_VSTM_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd + n) > 16) {
+    if (!vfp_d16_d31_ok(s) && (a->vd + n) > 16) {
         return false;
     }
 
@@ -1513,7 +1524,7 @@ static bool do_vfp_3op_dp(DisasContext *s, VFPGen3OpDPFn *fn,
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && ((vd | vn | vm) & 0x10)) {
+    if (!vfp_d16_d31_ok(s) && ((vd | vn | vm) & 0x10)) {
         return false;
     }
 
@@ -1685,7 +1696,7 @@ static bool do_vfp_2op_dp(DisasContext *s, VFPGen2OpDPFn *fn, int vd, int vm)
     /* Note that the caller must check the aa32_fpdp_v2 feature. */
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && ((vd | vm) & 0x10)) {
+    if (!vfp_d16_d31_ok(s) && ((vd | vm) & 0x10)) {
         return false;
     }
 
@@ -2252,7 +2263,7 @@ static bool do_vfm_dp(DisasContext *s, arg_VFMA_dp *a, bool neg_n, bool neg_d)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
+    if (!vfp_d16_d31_ok(s) &&
         ((a->vd | a->vn | a->vm) & 0x10)) {
         return false;
     }
@@ -2380,7 +2391,7 @@ static bool trans_VMOV_imm_dp(DisasContext *s, arg_VMOV_imm_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (vd & 0x10)) {
+    if (!vfp_d16_d31_ok(s) && (vd & 0x10)) {
         return false;
     }
 
@@ -2555,7 +2566,7 @@ static bool trans_VCMP_dp(DisasContext *s, arg_VCMP_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && ((a->vd | a->vm) & 0x10)) {
+    if (!vfp_d16_d31_ok(s) && ((a->vd | a->vm) & 0x10)) {
         return false;
     }
 
@@ -2621,7 +2632,7 @@ static bool trans_VCVT_f64_f16(DisasContext *s, arg_VCVT_f64_f16 *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd  & 0x10)) {
+    if (!vfp_d16_d31_ok(s) && (a->vd  & 0x10)) {
         return false;
     }
 
@@ -2702,7 +2713,7 @@ static bool trans_VCVT_f16_f64(DisasContext *s, arg_VCVT_f16_f64 *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm  & 0x10)) {
+    if (!vfp_d16_d31_ok(s) && (a->vm  & 0x10)) {
         return false;
     }
 
@@ -2777,7 +2788,7 @@ static bool trans_VRINTR_dp(DisasContext *s, arg_VRINTR_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && ((a->vd | a->vm) & 0x10)) {
+    if (!vfp_d16_d31_ok(s) && ((a->vd | a->vm) & 0x10)) {
         return false;
     }
 
@@ -2856,7 +2867,7 @@ static bool trans_VRINTZ_dp(DisasContext *s, arg_VRINTZ_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && ((a->vd | a->vm) & 0x10)) {
+    if (!vfp_d16_d31_ok(s) && ((a->vd | a->vm) & 0x10)) {
         return false;
     }
 
@@ -2930,7 +2941,7 @@ static bool trans_VRINTX_dp(DisasContext *s, arg_VRINTX_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && ((a->vd | a->vm) & 0x10)) {
+    if (!vfp_d16_d31_ok(s) && ((a->vd | a->vm) & 0x10)) {
         return false;
     }
 
@@ -2956,7 +2967,7 @@ static bool trans_VCVT_sp(DisasContext *s, arg_VCVT_sp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+    if (!vfp_d16_d31_ok(s) && (a->vd & 0x10)) {
         return false;
     }
 
@@ -2982,7 +2993,7 @@ static bool trans_VCVT_dp(DisasContext *s, arg_VCVT_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
+    if (!vfp_d16_d31_ok(s) && (a->vm & 0x10)) {
         return false;
     }
 
@@ -3063,7 +3074,7 @@ static bool trans_VCVT_int_dp(DisasContext *s, arg_VCVT_int_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+    if (!vfp_d16_d31_ok(s) && (a->vd & 0x10)) {
         return false;
     }
 
@@ -3100,7 +3111,7 @@ static bool trans_VJCVT(DisasContext *s, arg_VJCVT *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
+    if (!vfp_d16_d31_ok(s) && (a->vm & 0x10)) {
         return false;
     }
 
@@ -3240,7 +3251,7 @@ static bool trans_VCVT_fix_dp(DisasContext *s, arg_VCVT_fix_dp *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+    if (!vfp_d16_d31_ok(s) && (a->vd & 0x10)) {
         return false;
     }
 
@@ -3369,7 +3380,7 @@ static bool trans_VCVT_dp_int(DisasContext *s, arg_VCVT_dp_int *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vm & 0x10)) {
+    if (!vfp_d16_d31_ok(s) && (a->vm & 0x10)) {
         return false;
     }
 
-- 
2.43.0


