Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F78C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1I-00010u-Jj; Fri, 21 Aug 2026 07:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN12-0000g8-Nt
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:30 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0z-0007UW-H6
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:28 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-499a4d1d7f1so5211795e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310142; x=1787914942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pwfXB2bdg1qQX8wSnPwGkq8fuWB+6wmYD1feA0ku2tc=;
 b=WMk0ao+pkFvWhNt4LAZ1r45G8ee1F1oE/AxV7vxE1rXHjUxowqHGe21SLNo4SoSwY1
 xLpWkDpAZJUFIk4BkM5CXk9AG0GBZkAOFJjgJKHkUnLZutWeDSk8cIluvakIyNgvqc9K
 TC839Sa3/yvAL2ueWUSPDDnwzgeBH3C+o/iwv+VfaIUbUQ/HE0xQ6FwiS15g4wLIchOl
 aGM5p4EvD8SnVVKobZSSyJqkS5hx7gttMSArWkqR7DVqpSPJkYhCHcXUnzhoRx4cqdqX
 OxlG5tExDcPQm1vNrDkUSr26p/0NGYVtGL/TzO+KTMTzBxL/usR2qcV8ySp0+WVy1AnH
 9sQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310142; x=1787914942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pwfXB2bdg1qQX8wSnPwGkq8fuWB+6wmYD1feA0ku2tc=;
 b=rkNTxSTUJWr4eD+/DE1Lfb2M2agturKQGi7vFLMKnvw3JsBRDxazIwt30D0uK29Emy
 Qehv29xN77i6CCpyswmx+6327d8TR4foy6xUXal1LTFYJterX+UUZ7LFl68K1HAHpY73
 q1GkXSzR9cPF/rfpC+TDx+UDVu6Q08KdrrcnGe+q+juobuVB1Zb+w8ZmL4z6N5+ByBrt
 ae+UnQwqqCLaomG/qTOC6VzyAiEOYyuzR6A8ROV8ygYTuGBD1qZm/RI9JagpSKJlBpj6
 V7Rk+yLAPSn86FESrfGTZQ7WPYOxrqmHTXDXvpuJQrEAOf68e36t1NBC6DEukBLbZd00
 j8VA==
X-Gm-Message-State: AOJu0YzfwAeoHE0PhVhaIRruaxSyPftnpDc3bgMR6ojLzLzI0nTs+ant
 omhTjX9E2rivGSYk8+nQMZjU4ymsdtazN0SzXyS5DMRnTaPwUZ1kDWRV5VBJRHzXaWvzXNuyjqI
 rjYWZ
X-Gm-Gg: AR+sD129Ov6K2kaSm3dxds9a4GfJmO0uORVhanc5e5eButejBm0MKc5f7OnwaQNH3XF
 r/6acxu/reu2z7sp6cLMdsz1RdB359SkfTNprxUXLxjsAhXQGHx+shP5cx4TP52CNe7VX1pFO0E
 wFMc6u8gVNKLNqBXd+lXUFRZr2TsRD+POa4iQdIDFQgl9sXhnFbdccpydrvJiX4nWKAKbwhAL8R
 3Za0cLrSErIwS+td6YLEf7x2mpWAJFo5ShlB2YLWcYAA4x06LjaqmidohqyjGUah7C5EZHcsiN+
 kMq2b712X+BhxPS0lUzp/+uYWJA1IxpAYMmFQW6LS+t02nkMFKZzMaCL/ubc4dk+wdEksNfXASu
 jCWvSXp7K2c9ESphr41f5mM7340N3qX3z17dIy4YqR94x5Y5FdZjcs7h89sNygOhTC6DhR+a4p9
 bK6Fx0WZ0rPKtGtlWbfOGA7HCgj45TpP4cTxnsle2wCy4KgDjUgDZK6du6UkXqSPTvHda/QfECi
 WrAFqQoda0jVzMGtR+ky9kvS+ktEYmBpwg4DIocJsmiBc7K33jVBCQeD9QBGRFEE0jAQw==
X-Received: by 2002:a05:600c:c172:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-499b8464e46mr87458515e9.12.1787310141843; 
 Fri, 21 Aug 2026 04:02:21 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/43] target/arm: Pull Neon dregs checks out into a function
Date: Fri, 21 Aug 2026 12:00:41 +0100
Message-ID: <20260821110101.3971391-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

Abstract out the register check for Neon insns into a new function,
similarly to what we have for VFP.  We don't have any extra checks
that we need to add here, but having a neon_dregs_ok() is cleaner and
means the Neon decode isn't oddly different to the VFP decode.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260817123838.1578060-9-peter.maydell@linaro.org
---
 target/arm/tcg/translate-neon.c | 118 ++++++++++++++------------------
 target/arm/tcg/translate.c      |   1 +
 target/arm/tcg/translate.h      |   1 +
 3 files changed, 53 insertions(+), 67 deletions(-)

diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 50a44511d98..f811940f642 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -118,11 +118,24 @@ static void neon_store_element64(int reg, int ele, MemOp size, TCGv_i64 var)
     }
 }
 
+/*
+ * Return true if a Neon insn is OK to access the registers indicated
+ * by regmask, false if it should UNDEF. This checks whether the
+ * D16-D31 regs are implemented by the CPU.
+ * Note that Neon insns accessing D16..D31 do not need to check D32DIS.
+ *
+ * @regmask should be the logical OR of the Dregs being accessed.
+ */
+static bool neon_dregs_ok(DisasContext *s, int dregmask)
+{
+    return !(dregmask & s->invalid_neon_dreg_mask);
+}
+
 static bool do_neon_ddda(DisasContext *s, int q, int vd, int vn, int vm,
                          int data, gen_helper_gvec_4 *fn_gvec)
 {
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (((vd | vn | vm) & 0x10) && !dc_isar_feature(aa32_simd_r32, s)) {
+    if (!neon_dregs_ok(s, vd | vn | vm)) {
         return false;
     }
 
@@ -152,7 +165,7 @@ static bool do_neon_ddda_env(DisasContext *s, int q, int vd, int vn, int vm,
                              int data, gen_helper_gvec_4_ptr *fn_gvec)
 {
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (((vd | vn | vm) & 0x10) && !dc_isar_feature(aa32_simd_r32, s)) {
+    if (!neon_dregs_ok(s, vd | vn | vm)) {
         return false;
     }
 
@@ -184,7 +197,7 @@ static bool do_neon_ddda_fpst(DisasContext *s, int q, int vd, int vn, int vm,
                               gen_helper_gvec_4_ptr *fn_gvec_ptr)
 {
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (((vd | vn | vm) & 0x10) && !dc_isar_feature(aa32_simd_r32, s)) {
+    if (!neon_dregs_ok(s, vd | vn | vm)) {
         return false;
     }
 
@@ -240,8 +253,7 @@ static bool trans_VCADD(DisasContext *s, arg_VCADD *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vn | a->vm)) {
         return false;
     }
 
@@ -310,8 +322,7 @@ static bool trans_VFML(DisasContext *s, arg_VFML *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        (a->vd & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd)) {
         return false;
     }
 
@@ -398,14 +409,14 @@ static bool trans_VDOT_b16_scal(DisasContext *s, arg_VDOT_b16_scal *a)
 static bool trans_VFML_scalar(DisasContext *s, arg_VFML_scalar *a)
 {
     int opr_sz;
+    int dregmask = a->vd | (a->q ? a->vn : 0);
 
     if (!dc_isar_feature(aa32_fhm, s)) {
         return false;
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd & 0x10) || (a->q && (a->vn & 0x10)))) {
+    if (!neon_dregs_ok(s, dregmask)) {
         return false;
     }
 
@@ -478,7 +489,7 @@ static bool trans_VLDST_multiple(DisasContext *s, arg_VLDST_multiple *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd)) {
         return false;
     }
     if (a->itype > 10) {
@@ -580,7 +591,7 @@ static bool trans_VLD_all_lanes(DisasContext *s, arg_VLD_all_lanes *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd)) {
         return false;
     }
 
@@ -672,7 +683,7 @@ static bool trans_VLDST_single(DisasContext *s, arg_VLDST_single *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd)) {
         return false;
     }
 
@@ -789,8 +800,7 @@ static bool do_3same(DisasContext *s, arg_3same *a, GVecGen3Fn fn)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vn | a->vm)) {
         return false;
     }
 
@@ -1067,8 +1077,7 @@ static bool do_vector_2sh(DisasContext *s, arg_2reg_shift *a, GVecGen2iFn *fn)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vm)) {
         return false;
     }
 
@@ -1117,8 +1126,7 @@ static bool do_2shift_narrow_64(DisasContext *s, arg_2reg_shift *a,
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vm)) {
         return false;
     }
 
@@ -1168,8 +1176,7 @@ static bool do_2shift_narrow_32(DisasContext *s, arg_2reg_shift *a,
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vm)) {
         return false;
     }
 
@@ -1293,8 +1300,7 @@ static bool do_vshll_2sh(DisasContext *s, arg_2reg_shift *a,
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vm)) {
         return false;
     }
 
@@ -1383,8 +1389,7 @@ static bool do_fp_2sh(DisasContext *s, arg_2reg_shift *a,
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vm)) {
         return false;
     }
 
@@ -1428,7 +1433,7 @@ static bool do_1reg_imm(DisasContext *s, arg_1reg_imm *a,
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd)) {
         return false;
     }
 
@@ -1485,8 +1490,7 @@ static bool do_prewiden_3d(DisasContext *s, arg_3diff *a,
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vn | a->vm)) {
         return false;
     }
 
@@ -1592,8 +1596,7 @@ static bool do_narrow_3d(DisasContext *s, arg_3diff *a,
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vn | a->vm)) {
         return false;
     }
 
@@ -1682,8 +1685,7 @@ static bool do_long_3d(DisasContext *s, arg_3diff *a,
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vn | a->vm)) {
         return false;
     }
 
@@ -1944,8 +1946,7 @@ static bool trans_VMULL_P_3d(DisasContext *s, arg_3diff *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vn | a->vm)) {
         return false;
     }
 
@@ -2027,8 +2028,7 @@ static bool do_2scalar(DisasContext *s, arg_2scalar *a,
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vn | a->vm)) {
         return false;
     }
 
@@ -2125,8 +2125,7 @@ static bool do_2scalar_fp_vec(DisasContext *s, arg_2scalar *a,
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vn | a->vm)) {
         return false;
     }
 
@@ -2222,8 +2221,7 @@ static bool do_vqrdmlah_2sc(DisasContext *s, arg_2scalar *a,
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vn | a->vm)) {
         return false;
     }
 
@@ -2293,8 +2291,7 @@ static bool do_2scalar_long(DisasContext *s, arg_2scalar *a,
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vn | a->vm)) {
         return false;
     }
 
@@ -2438,8 +2435,7 @@ static bool trans_VEXT(DisasContext *s, arg_VEXT *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vn | a->vm)) {
         return false;
     }
 
@@ -2507,8 +2503,7 @@ static bool trans_VTBL(DisasContext *s, arg_VTBL *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vn | a->vm)) {
         return false;
     }
 
@@ -2546,8 +2541,7 @@ static bool trans_VDUP_scalar(DisasContext *s, arg_VDUP_scalar *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vm)) {
         return false;
     }
 
@@ -2577,8 +2571,7 @@ static bool do_zip_uzp(DisasContext *s, arg_2misc *a,
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vm)) {
         return false;
     }
 
@@ -2647,8 +2640,7 @@ static bool do_vmovn(DisasContext *s, arg_2misc *a,
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vm)) {
         return false;
     }
 
@@ -2711,8 +2703,7 @@ static bool trans_VSHLL(DisasContext *s, arg_2misc *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vm)) {
         return false;
     }
 
@@ -2755,8 +2746,7 @@ static bool trans_VCVT_B16_F32(DisasContext *s, arg_2misc *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vm)) {
         return false;
     }
 
@@ -2795,8 +2785,7 @@ static bool trans_VCVT_F16_F32(DisasContext *s, arg_2misc *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vm)) {
         return false;
     }
 
@@ -2841,8 +2830,7 @@ static bool trans_VCVT_F32_F16(DisasContext *s, arg_2misc *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vm)) {
         return false;
     }
 
@@ -2887,8 +2875,7 @@ static bool do_2misc_vec(DisasContext *s, arg_2misc *a, GVecGen2Fn *fn)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vm)) {
         return false;
     }
 
@@ -3015,8 +3002,7 @@ static bool do_2misc(DisasContext *s, arg_2misc *a, NeonGenOneOpFn *fn)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vm)) {
         return false;
     }
 
@@ -3219,8 +3205,7 @@ static bool trans_VSWP(DisasContext *s, arg_2misc *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vm)) {
         return false;
     }
 
@@ -3292,8 +3277,7 @@ static bool trans_VTRN(DisasContext *s, arg_2misc *a)
     }
 
     /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vm) & 0x10)) {
+    if (!neon_dregs_ok(s, a->vd | a->vm)) {
         return false;
     }
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 90eb6f30058..c866148383f 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6410,6 +6410,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
     dc->invalid_vfp_dreg_mask =
         (d32dis || !dc_isar_feature(aa32_simd_r32, dc)) ? 0x10 : 0;
+    dc->invalid_neon_dreg_mask = !dc_isar_feature(aa32_simd_r32, dc) ? 0x10 : 0;
 
     dc->lse2 = false; /* applies only to aarch64 */
     dc->cp_regs = cpu->cp_regs;
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index b08bded3981..31f52a34a68 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -95,6 +95,7 @@ typedef struct DisasContext {
     int max_any_vl;  /* maximum implemented vector length */
     bool vfp_enabled; /* FP enabled via FPSCR.EN */
     int invalid_vfp_dreg_mask; /* mask for whether VFP D16..D31 should UNDEF */
+    int invalid_neon_dreg_mask; /* ditto, for Neon */
     int vec_len;
     int vec_stride;
     bool v7m_handler_mode;
-- 
2.43.0


