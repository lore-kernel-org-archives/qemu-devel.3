Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4A2C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGYI-0006V6-J3; Sat, 01 Feb 2025 11:41:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYG-0006Rx-8J
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:00 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYE-0001CD-A2
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:59 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso31077995e9.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428056; x=1739032856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/xkRxRbu6XTXfHnP/CQAM/9gqluRLNGg6MmpZPzNQ/s=;
 b=grnvHR6P78YinOrTdawVAozM7kM6QVN8QL9qbacaChKcR10bRBUATT8Q3GzL35tPGj
 s8Gs8JW/GIaKQ3sDwZkmg4Emzo4WI8NcTzjk7yS0hVkgtyrQfV6zNQPM90uiPdIfO3FY
 1Z7KPpwB9Z6DOj18KxdG0VXFj7ynnW8xBr1ZuqA2O1HkT4GO9LB6/qSS9irczHromzP9
 eu0K6SC2MqlZtFde0P6HIgM+m+hyJy5JAWezNeciw9shr8pZME1Y+wIdQu1WjYtfNhWe
 fc62rae+3WoWRGZM1CsE3M0wEi1Gc5S0HtawEjJa5eBB0+4sGhOWi/A6e+6g4Smb2699
 zUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428056; x=1739032856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/xkRxRbu6XTXfHnP/CQAM/9gqluRLNGg6MmpZPzNQ/s=;
 b=hHoZETmYx6avLFsSxb6zLI9/8rTWnDE8GATOxPsjeLTiPQDFU3ak2DlaQCh4/4jkFZ
 0fhEheHo/8HEIkGVqucWIWp+oJWah7mhPefPHnhArCP4sfij1vZcm8PCy6a41OKF+X8v
 IvBhE982l2J3E0IXL7U5NabWeB/g8LftJ6DLoD3lBmyGYPqM7LqXpcspnz/bzrBvh/Df
 UAf9wz1IVDM0CTloZ+5VuZJeBYgD7fgE1tx1lX14zMdCAG6T5et0kZo9kVrSfRhH49DR
 YpDqMfN0uXaxYoipXKYwskf7q1TG7ih4zJmUrEhX+3dx/fdZtisCtKoH4sIzZMFrFKvQ
 mAww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVN1u52MY2IVz1sxQjjfaBiKbPZpCHtqoCiNpIJTxMQ6CnlqU09FguFYEPb6cFvYVOcKgxmWRdHRuH@nongnu.org
X-Gm-Message-State: AOJu0YzB2CumHomLtEqwryu4T6s+e34bWNBbCS/29AXFRYoK51s6HRXc
 T2Nlyy6eZ8iO+Wck1MnoAKdbG742FE9AkHb7MP1tp+w1Gds9AuuByrYujkqPJz1CWUgJWQbs2wz
 s
X-Gm-Gg: ASbGnctCzRWkRd7IJdLqQc+sXN4qwSkSRuNKSL77aGpfVFKSF4KQUNvzYG0aIX6+Ueq
 1rRd/Dmlmt642BoD/aLYlw2eK6hxHFYqcho1qvvJbxPXXaZLXIpRH411tUCjrlQOzcvu1eEdMan
 hT3IdIjJqPEOfVGY9sAS0vaRlxLxTRmfQqoPi0+MmCJpg14v7Rkcy2+/aVCtcKvsCrDK84GG4pa
 Ko+XCBDEuHECmPtl6su8S6M/AM2hm5m7kSHKNm1ZOVBBRgy0FGy3PQAzLpvEJ8cKQHGpg6zIDiU
 YhGirf+URw6N0XX4s0mJ
X-Google-Smtp-Source: AGHT+IGh+jgk02TNBCzPX4te6UYZyobgfoJ1DEg4VWuWzMcEzIfzmnbmFCow9bN6WS+QqD2pWg7N3A==
X-Received: by 2002:a5d:47ca:0:b0:38a:87cc:fb42 with SMTP id
 ffacd0b85a97d-38c5195b5dfmr15941801f8f.21.1738428056408; 
 Sat, 01 Feb 2025 08:40:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 31/69] target/arm: Implement FPCR.AH handling of negation
 of NaN
Date: Sat,  1 Feb 2025 16:39:34 +0000
Message-Id: <20250201164012.1660228-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

FPCR.AH == 1 mandates that negation of a NaN value should not flip
its sign bit.  This means we can no longer use gen_vfp_neg*()
everywhere but must instead generate slightly more complex code when
FPCR.AH is set.

Make this change for the scalar FNEG and for those places in
translate-a64.c which were previously directly calling
gen_vfp_neg*().

This change in semantics also affects any other instruction whose
pseudocode calls FPNeg(); in following commits we extend this
change to the other affected instructions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 125 ++++++++++++++++++++++++++++++---
 1 file changed, 114 insertions(+), 11 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7af727b606d..aee2e1307e4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -839,6 +839,74 @@ static void gen_gvec_op4_fpst(DisasContext *s, bool is_q, int rd, int rn,
                        is_q ? 16 : 8, vec_full_reg_size(s), data, fn);
 }
 
+/*
+ * When FPCR.AH == 1, NEG and ABS do not flip the sign bit of a NaN.
+ * These functions implement
+ *   d = floatN_is_any_nan(s) ? s : floatN_chs(s)
+ * which for float32 is
+ *   d = (s & ~(1 << 31)) > 0x7f800000UL) ? s : (s ^ (1 << 31))
+ * and similarly for the other float sizes.
+ */
+static void gen_vfp_ah_negh(TCGv_i32 d, TCGv_i32 s)
+{
+    TCGv_i32 abs_s = tcg_temp_new_i32(), chs_s = tcg_temp_new_i32();
+
+    gen_vfp_negh(chs_s, s);
+    gen_vfp_absh(abs_s, s);
+    tcg_gen_movcond_i32(TCG_COND_GTU, d,
+                        abs_s, tcg_constant_i32(0x7c00),
+                        s, chs_s);
+}
+
+static void gen_vfp_ah_negs(TCGv_i32 d, TCGv_i32 s)
+{
+    TCGv_i32 abs_s = tcg_temp_new_i32(), chs_s = tcg_temp_new_i32();
+
+    gen_vfp_negs(chs_s, s);
+    gen_vfp_abss(abs_s, s);
+    tcg_gen_movcond_i32(TCG_COND_GTU, d,
+                        abs_s, tcg_constant_i32(0x7f800000UL),
+                        s, chs_s);
+}
+
+static void gen_vfp_ah_negd(TCGv_i64 d, TCGv_i64 s)
+{
+    TCGv_i64 abs_s = tcg_temp_new_i64(), chs_s = tcg_temp_new_i64();
+
+    gen_vfp_negd(chs_s, s);
+    gen_vfp_absd(abs_s, s);
+    tcg_gen_movcond_i64(TCG_COND_GTU, d,
+                        abs_s, tcg_constant_i64(0x7ff0000000000000ULL),
+                        s, chs_s);
+}
+
+static void gen_vfp_maybe_ah_negh(DisasContext *dc, TCGv_i32 d, TCGv_i32 s)
+{
+    if (dc->fpcr_ah) {
+        gen_vfp_ah_negh(d, s);
+    } else {
+        gen_vfp_negh(d, s);
+    }
+}
+
+static void gen_vfp_maybe_ah_negs(DisasContext *dc, TCGv_i32 d, TCGv_i32 s)
+{
+    if (dc->fpcr_ah) {
+        gen_vfp_ah_negs(d, s);
+    } else {
+        gen_vfp_negs(d, s);
+    }
+}
+
+static void gen_vfp_maybe_ah_negd(DisasContext *dc, TCGv_i64 d, TCGv_i64 s)
+{
+    if (dc->fpcr_ah) {
+        gen_vfp_ah_negd(d, s);
+    } else {
+        gen_vfp_negd(d, s);
+    }
+}
+
 /* Set ZF and NF based on a 64 bit result. This is alas fiddlier
  * than the 32 bit equivalent.
  */
@@ -5252,12 +5320,35 @@ static void gen_fnmul_d(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_ptr s)
     gen_vfp_negd(d, d);
 }
 
+static void gen_fnmul_ah_h(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_ptr s)
+{
+    gen_helper_vfp_mulh(d, n, m, s);
+    gen_vfp_ah_negh(d, d);
+}
+
+static void gen_fnmul_ah_s(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_ptr s)
+{
+    gen_helper_vfp_muls(d, n, m, s);
+    gen_vfp_ah_negs(d, d);
+}
+
+static void gen_fnmul_ah_d(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_ptr s)
+{
+    gen_helper_vfp_muld(d, n, m, s);
+    gen_vfp_ah_negd(d, d);
+}
+
 static const FPScalar f_scalar_fnmul = {
     gen_fnmul_h,
     gen_fnmul_s,
     gen_fnmul_d,
 };
-TRANS(FNMUL_s, do_fp3_scalar, a, &f_scalar_fnmul, a->rn)
+static const FPScalar f_scalar_ah_fnmul = {
+    gen_fnmul_ah_h,
+    gen_fnmul_ah_s,
+    gen_fnmul_ah_d,
+};
+TRANS(FNMUL_s, do_fp3_scalar_2fn, a, &f_scalar_fnmul, &f_scalar_ah_fnmul, a->rn)
 
 static const FPScalar f_scalar_fcmeq = {
     gen_helper_advsimd_ceq_f16,
@@ -6399,7 +6490,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
 
             read_vec_element(s, t2, a->rm, a->idx, MO_64);
             if (neg) {
-                gen_vfp_negd(t1, t1);
+                gen_vfp_maybe_ah_negd(s, t1, t1);
             }
             gen_helper_vfp_muladdd(t0, t1, t2, t0, fpstatus_ptr(FPST_A64));
             write_fp_dreg_merging(s, a->rd, a->rd, t0);
@@ -6413,7 +6504,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
 
             read_vec_element_i32(s, t2, a->rm, a->idx, MO_32);
             if (neg) {
-                gen_vfp_negs(t1, t1);
+                gen_vfp_maybe_ah_negs(s, t1, t1);
             }
             gen_helper_vfp_muladds(t0, t1, t2, t0, fpstatus_ptr(FPST_A64));
             write_fp_sreg_merging(s, a->rd, a->rd, t0);
@@ -6430,7 +6521,7 @@ static bool do_fmla_scalar_idx(DisasContext *s, arg_rrx_e *a, bool neg)
 
             read_vec_element_i32(s, t2, a->rm, a->idx, MO_16);
             if (neg) {
-                gen_vfp_negh(t1, t1);
+                gen_vfp_maybe_ah_negh(s, t1, t1);
             }
             gen_helper_advsimd_muladdh(t0, t1, t2, t0,
                                        fpstatus_ptr(FPST_A64_F16));
@@ -6913,10 +7004,10 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             TCGv_i64 ta = read_fp_dreg(s, a->ra);
 
             if (neg_a) {
-                gen_vfp_negd(ta, ta);
+                gen_vfp_maybe_ah_negd(s, ta, ta);
             }
             if (neg_n) {
-                gen_vfp_negd(tn, tn);
+                gen_vfp_maybe_ah_negd(s, tn, tn);
             }
             fpst = fpstatus_ptr(FPST_A64);
             gen_helper_vfp_muladdd(ta, tn, tm, ta, fpst);
@@ -6931,10 +7022,10 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             TCGv_i32 ta = read_fp_sreg(s, a->ra);
 
             if (neg_a) {
-                gen_vfp_negs(ta, ta);
+                gen_vfp_maybe_ah_negs(s, ta, ta);
             }
             if (neg_n) {
-                gen_vfp_negs(tn, tn);
+                gen_vfp_maybe_ah_negs(s, tn, tn);
             }
             fpst = fpstatus_ptr(FPST_A64);
             gen_helper_vfp_muladds(ta, tn, tm, ta, fpst);
@@ -6952,10 +7043,10 @@ static bool do_fmadd(DisasContext *s, arg_rrrr_e *a, bool neg_a, bool neg_n)
             TCGv_i32 ta = read_fp_hreg(s, a->ra);
 
             if (neg_a) {
-                gen_vfp_negh(ta, ta);
+                gen_vfp_maybe_ah_negh(s, ta, ta);
             }
             if (neg_n) {
-                gen_vfp_negh(tn, tn);
+                gen_vfp_maybe_ah_negh(s, tn, tn);
             }
             fpst = fpstatus_ptr(FPST_A64_F16);
             gen_helper_advsimd_muladdh(ta, tn, tm, ta, fpst);
@@ -8544,6 +8635,13 @@ static bool do_fp1_scalar_int(DisasContext *s, arg_rr_e *a,
     return true;
 }
 
+static bool do_fp1_scalar_int_2fn(DisasContext *s, arg_rr_e *a,
+                                  const FPScalar1Int *fnormal,
+                                  const FPScalar1Int *fah)
+{
+    return do_fp1_scalar_int(s, a, s->fpcr_ah ? fah : fnormal, true);
+}
+
 static const FPScalar1Int f_scalar_fmov = {
     tcg_gen_mov_i32,
     tcg_gen_mov_i32,
@@ -8563,7 +8661,12 @@ static const FPScalar1Int f_scalar_fneg = {
     gen_vfp_negs,
     gen_vfp_negd,
 };
-TRANS(FNEG_s, do_fp1_scalar_int, a, &f_scalar_fneg, true)
+static const FPScalar1Int f_scalar_ah_fneg = {
+    gen_vfp_ah_negh,
+    gen_vfp_ah_negs,
+    gen_vfp_ah_negd,
+};
+TRANS(FNEG_s, do_fp1_scalar_int_2fn, a, &f_scalar_fneg, &f_scalar_ah_fneg)
 
 typedef struct FPScalar1 {
     void (*gen_h)(TCGv_i32, TCGv_i32, TCGv_ptr);
-- 
2.34.1


