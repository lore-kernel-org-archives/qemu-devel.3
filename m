Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FA8C02194
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGYH-0006TX-46; Sat, 01 Feb 2025 11:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYD-0006Kq-1N
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:57 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYB-0001BR-AX
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:56 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43635796b48so18698575e9.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428054; x=1739032854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g0Z2ycNCf9W70DtwUEodSWkhpWcrCzYt5vzIvDPUjeo=;
 b=VoFoHhy8qZZXnM6B0j8IXgeejZrqnH+sEvqGB8Ms9nquAwZ9sTU9SYi10oQKck/Bnv
 6IxMEstg/62Sd0vkthW5EkJqGkkDVjG70+IxXM6HoXshnO+I/Iu4r/3TcPsMdBdG9UIM
 RYqhzT6cSFoMgSvBTBp91HFuuVjiOskh9E2/sar5eCZ6UNMq3Hdm1O0vUdtAq/tVPRu6
 Oju17dRks1QwwKt14J/lQXL9M8p/omRXTjUbq6k0mqA098e1R3PsNtVv0Q02dtXMOgsj
 OEzzlDwBM+dyxK6D1ePSF6I/stlaIRgkd2N51aF5TIAITKOS4nRJdZ2Gz8IakqPWpANd
 j7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428054; x=1739032854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g0Z2ycNCf9W70DtwUEodSWkhpWcrCzYt5vzIvDPUjeo=;
 b=m6JFX1+EedwJKFHQuxDglxCtn9me6fa/iUyDYLucGT4O4HQdlgReX57NaCNX5vvdxw
 smUeNvTU5eB/DUsNDY3wCVDygbfsdnpZlZnK8An026cmOrsH7/gMoIbALX+dx2DqeKBX
 n/AnYzXTNuUDh27VV8Vk3Is6A1rKDVGkUtqRDc9irlrJUK7iSxZJdQF5GeBDbtrLZZlA
 tCE9TELCqNImhR3duF+YwNnjHa9McKZeAAR1iYvuGU+DscdrgKkSU9+yS0Pa3APPdUnB
 IyJQ/xnvg3eUxmyw7xUfwy4caOZOZhfiIzgO+lY4GcBhxUmm8RiTGY7yT7tjRQDhgkhe
 KbVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1ennbz3M28ir5N/Ya3AjU62AQswxZeW7chXR31xyYUPuBPwD+cUr/m6oSMGxoL/ntPGbAT5TZRzKC@nongnu.org
X-Gm-Message-State: AOJu0Yz7wRpr5+AEC2tDzu5gb/E3kqfw4gaI+KgKDAu3NcLL3szQ6Pfs
 OYEqice3cStwVV+vZo9IcZqo85PDF2KmErqr+TOSl/rQ3HT56VzixvOc2zwDf2KDqYyn9U76eEj
 O
X-Gm-Gg: ASbGncu6CIo5qXGqhMoXxlrb6lHZv+IJgxrCZaPs/1/SZBTRH5bLAV9TlLSV32juu0l
 TQCeUEuCtYAtxLumDSxb8TUtSo1CzKiMedhlQrC4jYK8uY0llpLAAPVSXi1bl4K3KTuhJPdiqHg
 EIOg3W+q9yOcYjh4FrYv9JZdSt7OfwflAyrUerfxd7av2xMl8831H0LhAg22/yEJzyF9pELhjWG
 30Utd49ddWwgCBLsk4LXIJOFUWAzaAeRUUEtbHofRcq9+LizUy5sYONoIO01rLT4faYD/zDimqr
 7/3RhuSpLLkN9cqGF+k7
X-Google-Smtp-Source: AGHT+IEcrWdJqjbxinaEdyf7n7EvQ4W1ciTbOQf9sjJJJBQ3DSRYvrZiiBE7FGxqY81Lnck9siPbwA==
X-Received: by 2002:a05:600c:1913:b0:42c:b8c9:16c8 with SMTP id
 5b1f17b1804b1-438e16ebb49mr94166305e9.10.1738428053804; 
 Sat, 01 Feb 2025 08:40:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 29/69] target/arm: Implement FPCR.AH semantics for SVE
 FMIN/FMAX immediate
Date: Sat,  1 Feb 2025 16:39:32 +0000
Message-Id: <20250201164012.1660228-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Implement the FPCR.AH semantics for the SVE FMAX and FMIN operations
that take an immediate as the second operand.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 14 ++++++++++++++
 target/arm/tcg/sve_helper.c    |  8 ++++++++
 target/arm/tcg/translate-sve.c | 25 +++++++++++++++++++++++--
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 7ca95b8fa94..3c1d2624ed4 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -1231,6 +1231,20 @@ DEF_HELPER_FLAGS_6(sve_fmins_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_fmins_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, i64, fpst, i32)
 
+DEF_HELPER_FLAGS_6(sve_ah_fmaxs_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fmaxs_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fmaxs_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, fpst, i32)
+
+DEF_HELPER_FLAGS_6(sve_ah_fmins_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fmins_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fmins_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i64, fpst, i32)
+
 DEF_HELPER_FLAGS_5(sve_fcvt_sh, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fcvt_dh, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 3631d85f23a..2f6fc82ee4f 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4459,6 +4459,14 @@ DO_ZPZS_FP(sve_fmins_h, float16, H1_2, float16_min)
 DO_ZPZS_FP(sve_fmins_s, float32, H1_4, float32_min)
 DO_ZPZS_FP(sve_fmins_d, float64, H1_8, float64_min)
 
+DO_ZPZS_FP(sve_ah_fmaxs_h, float16, H1_2, helper_vfp_ah_maxh)
+DO_ZPZS_FP(sve_ah_fmaxs_s, float32, H1_4, helper_vfp_ah_maxs)
+DO_ZPZS_FP(sve_ah_fmaxs_d, float64, H1_8, helper_vfp_ah_maxd)
+
+DO_ZPZS_FP(sve_ah_fmins_h, float16, H1_2, helper_vfp_ah_minh)
+DO_ZPZS_FP(sve_ah_fmins_s, float32, H1_4, helper_vfp_ah_mins)
+DO_ZPZS_FP(sve_ah_fmins_d, float64, H1_8, helper_vfp_ah_mind)
+
 /* Fully general two-operand expander, controlled by a predicate,
  * With the extra float_status parameter.
  */
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 35f6d78a0e0..187bd647c29 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3821,14 +3821,35 @@ static bool do_fp_imm(DisasContext *s, arg_rpri_esz *a, uint64_t imm,
     TRANS_FEAT(NAME##_zpzi, aa64_sve, do_fp_imm, a,                     \
                name##_const[a->esz][a->imm], name##_fns[a->esz])
 
+#define DO_FP_AH_IMM(NAME, name, const0, const1)                        \
+    static gen_helper_sve_fp2scalar * const name##_fns[4] = {           \
+        NULL, gen_helper_sve_##name##_h,                                \
+        gen_helper_sve_##name##_s,                                      \
+        gen_helper_sve_##name##_d                                       \
+    };                                                                  \
+    static gen_helper_sve_fp2scalar * const name##_ah_fns[4] = {        \
+        NULL, gen_helper_sve_ah_##name##_h,                             \
+        gen_helper_sve_ah_##name##_s,                                   \
+        gen_helper_sve_ah_##name##_d                                    \
+    };                                                                  \
+    static uint64_t const name##_const[4][2] = {                        \
+        { -1, -1 },                                                     \
+        { float16_##const0, float16_##const1 },                         \
+        { float32_##const0, float32_##const1 },                         \
+        { float64_##const0, float64_##const1 },                         \
+    };                                                                  \
+    TRANS_FEAT(NAME##_zpzi, aa64_sve, do_fp_imm, a,                     \
+               name##_const[a->esz][a->imm],                            \
+               s->fpcr_ah ? name##_ah_fns[a->esz] : name##_fns[a->esz])
+
 DO_FP_IMM(FADD, fadds, half, one)
 DO_FP_IMM(FSUB, fsubs, half, one)
 DO_FP_IMM(FMUL, fmuls, half, two)
 DO_FP_IMM(FSUBR, fsubrs, half, one)
 DO_FP_IMM(FMAXNM, fmaxnms, zero, one)
 DO_FP_IMM(FMINNM, fminnms, zero, one)
-DO_FP_IMM(FMAX, fmaxs, zero, one)
-DO_FP_IMM(FMIN, fmins, zero, one)
+DO_FP_AH_IMM(FMAX, fmaxs, zero, one)
+DO_FP_AH_IMM(FMIN, fmins, zero, one)
 
 #undef DO_FP_IMM
 
-- 
2.34.1


