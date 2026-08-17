Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279BEC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvwcM-0003ht-BS; Mon, 17 Aug 2026 08:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvwcD-0003fX-SD
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 08:38:58 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvwc9-0001G1-2E
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 08:38:57 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so33892865e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 05:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786970331; x=1787575131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3gq1Eo4wLZLTsS7bzDUHtNahY0huOE486fmBMnq96pQ=;
 b=ebR6f1iOqtlME32vjCv1bh2ZFMnBkyy8LYgDpVt2iSC8EskjlzFrMpuFna2v6DwSZR
 3ugIlp8ghZtLUPZS7aY1SmiiWpDYMm8exAPkpEalytaBziFHBFH6vYpCLLNNRPg5ELO/
 8QmBza2GFI6PrP8YVJO6A3wch7QJD6unmojDTyJ/HfhTbdX0Mwc/cUe7v25swiDBa1o9
 Ira1l5SflcrWuS6oL2O9/dixp9ojcT0Ebe5uORDoiI4zXxHtjGGukWBIy7CMElzkxaS5
 +d9jI65/B1GxqMXi9RgXj8IFKcJRWcQEr5NBH1w6fduoPGp1pOd3N09N/esFmdFfHuEE
 1ZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786970331; x=1787575131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3gq1Eo4wLZLTsS7bzDUHtNahY0huOE486fmBMnq96pQ=;
 b=crAi6RjFo9e/+RwbwhI0vo6B0U7SDrg9yQbO0/F/rnSX9xtKYjoX0Yf7vAJt1hIbsq
 eU/T9XOEh7cA1UUGRJv3yD1qhCV7g0JbtIuJp4q9WmkfiAjB9s67JiZYBQ7hmiyA0hJ/
 DlLA0MQ8FQYN9GNMFjYRmjb0fe8XQw9yao1jGt+GpMteI7fmaqoe9ULllVUet+UZwjOw
 TWVtx1LQKvlqcYTywynDS32B1uT7aqxBHfQyR+NTW++NZOav8nFO+ccN4/5hUKpVtGxf
 VYnSlgAcqufOS80omjbkJv8CY0miYdtKtng70RQZNNdZvoEy3MJSUurJFmEk4GySxUPi
 7e0A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpRT1voI/Q+6G0J1igMcGVJJOUZKxiKxJAjYV4vo3bawJoDNZR7kblFi40ndQncbhJOQKpYTgaSuVKg@nongnu.org
X-Gm-Message-State: AOJu0YyZfXfbwt2uwNt6KWVQEcHq3FohCLAUK3FKogfXrganRsEPtOX8
 NkFlx5rKdW29KB2sME01d/XQ+SmfzuK6dRDUuFOopCkRduYaWFGgpoktQGn646nDfbtkE54JPpU
 Y9hUJ
X-Gm-Gg: AR+sD11XdqHkw+ZCSs6H3c5PuJIz2wiaQZixFsmM0iNb5lTtTkG4ZLLrpPezAKpEPj4
 2fu0ga4KY1XikaqXoM8df4L2RE8cVmmTHB/GjTd0JAs6EcBSZ9z1Fv/uAyoHKUfXRsNtWRz7BDf
 ZNtSPnlHvI8SANLNpPJITxoq4p0Fc0fsM/VABznDnwa1JwhqABNk4gpSXJZ2DfYxxHImSdNf8tj
 9YUAmcOgPiyOnoTHWAYxnbBei4FqQilL/dtPdz+n+wfiKlmZkVqekrYJinbtZXHNxsEkf8H7V4D
 Z0wdxvRRTs724vKjQeC3jZEigvXyhLLq1jvDvz/XIgYVrBekgBcuwA6hV8cWLan78VxlC/Q9+tF
 N+xE/6Vz/vwTiiaam8yiZgYXBpX7KJpjYGv0pKAU7Cq5o25N2aX63LPntH2ou68ffJdS/hHY6JD
 4sP9KvuO1N8Qi3Ipuj2woCqgSt5flfA681yqyu3lbo8TvkRjegpjeeTcLkUP9GIzShfoNiY8wUA
 DGwrOhRid3/pCgQK6LolHBHnrTRThGfl+reOI6ep82H0SNpv9ot7tn5msvOV22V/JrXyA==
X-Received: by 2002:a05:600c:4f52:b0:493:f5bf:4dc6 with SMTP id
 5b1f17b1804b1-4998793dafcmr389604195e9.7.1786970330786; 
 Mon, 17 Aug 2026 05:38:50 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998780397dsm120415055e9.3.2026.08.17.05.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:38:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 8/8] target/arm: Pull Neon dregs checks out into a function
Date: Mon, 17 Aug 2026 13:38:38 +0100
Message-ID: <20260817123838.1578060-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817123838.1578060-1-peter.maydell@linaro.org>
References: <20260817123838.1578060-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
---
 target/arm/tcg/translate-neon.c | 118 ++++++++++++++------------------
 target/arm/tcg/translate.c      |   1 +
 target/arm/tcg/translate.h      |   1 +
 3 files changed, 53 insertions(+), 67 deletions(-)

diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 50a44511d9..f811940f64 100644
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
index 1bf9d61035..a311abb0a5 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6410,6 +6410,7 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
     dc->invalid_vfp_dreg_mask =
         (d32dis || !dc_isar_feature(aa32_simd_r32, dc)) ? 0x10 : 0;
+    dc->invalid_neon_dreg_mask = !dc_isar_feature(aa32_simd_r32, dc) ? 0x10 : 0;
 
     dc->lse2 = false; /* applies only to aarch64 */
     dc->cp_regs = cpu->cp_regs;
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index b08bded398..31f52a34a6 100644
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


