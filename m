Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F79C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMfr-0005Et-9K; Fri, 24 Jan 2025 11:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZ0-0005ir-NE
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:51 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYx-0005id-3t
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:45 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43626213fffso22182995e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736182; x=1738340982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3ps5knb3sFdf6P1gy0cvrFvUI+yUM1AgSFsV6YuWq8s=;
 b=Ls32xaMPpu+apW9Q4Oa+F2jIWXCpbP4br0mXSNAZFKlNVOdMMQ7p5MK5CQgzE5cwLc
 I++wsSpA0jDP14Wx7Hw0KBww/eGwU9kMMQHZ40TcMPVEb8111h3h7TmVKg9y2fDwQc6q
 mxr71+Iupptp9VIy9AD/HSODQ4JuYKCzCcJHJ4L5KbIYOarC1eqENfBEh88KBuca/pDt
 Vxo7HCv7QrxdL0n588bPUxdCXeASGipkty4F/b5zwxw3Oj6++ksXgA+hbNgL1+DXSlGl
 or/k6FdhR/tQEPakEc4o1NSHNpbFOfQlBxTfXOtEUDpmzeeIG/vbztN6H5mwITlHjB85
 9BVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736182; x=1738340982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ps5knb3sFdf6P1gy0cvrFvUI+yUM1AgSFsV6YuWq8s=;
 b=Z+wa7KmV3NLrf62JjMlSK5qMmVc3qNGcUCmneLXK9OZIvGP1OVFiJ5qrjCReTU/AZl
 S+ZMCh8bE1TZDPVHJ3VN97LFYDyGewh9e+cM05k1Gw9lX85VPzC/NSyMwEQUhwJJJNq1
 NVY8vrwP6DJ8qyY47hmkxmVreIVWgifJmLTXeKjc3qEic2hiovqmp10Mzxom9lWg3Fn7
 4W4NSj/VyWUVX6JTaxOr3uHnI2+aZmREsA6pGz6T+56+g9N1fqMsiTTdu9oyIdTe7Kl6
 uChf0kA9EZsnYd+ip05UM++GJQI43oWoG+5LIwY8oDyza7ka1TCVHZmjGy3H0mYrsz1U
 7JMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4JLJ1ay2K0rpbSb6BHiTC7/AdUEXAoLKjGcWpXnVhqSkTEGIdso0YlawBDk6VSpiXmwqkPdUOn68+@nongnu.org
X-Gm-Message-State: AOJu0YwOwY48I2IwZ9KPdqah2wjCVvA48v+g/0os4Q8kyE5FLV3zY25Y
 O0/uefcLNiN+sbX16l7f0qFg6y6a3gWuGsIulPF9/t66HnDOz8b/1vVaWe1EtpE3A/uJwF2DF8Y
 4
X-Gm-Gg: ASbGnctBSp1+sSAcmsjcDaQsl3uHnCiaNih/zARmKwUIU+kVyKL+zmX9BgPz93J5+9K
 wWS0yEneUvmpHCcqfaFdkM6FKy/plgTP2yDMNbCHPMUXux3Cbc0dCyO2DsXaUredf5Xl1+BLy34
 hN9EhA3fZxUu4EPCTx1y5Kbt3fGpChc4nLnhA1rnYOrdSnFyfHl+5YGmSErnPYLlzfghlhyM3al
 EWfHGmlXBG9XYljxaKXhAOHW9n7MsU9Qeh3ShqG99j0gqquwfhljF1CpHLj67+p8CiVNhxLY37M
 fyhK1azA0Cw=
X-Google-Smtp-Source: AGHT+IGet8aOC9i6GHMbEF4bxuWu+Jj5zs6tbSEtSEYEbHMJGZX6j5QRMdKwaHdy7zWmUBdl74VUtQ==
X-Received: by 2002:a05:600c:1d0c:b0:434:f9ad:7222 with SMTP id
 5b1f17b1804b1-438b885652fmr75931585e9.7.1737736181651; 
 Fri, 24 Jan 2025 08:29:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 51/76] target/arm: Implement FPCR.AH semantics for SVE
 FMIN/FMAX vector
Date: Fri, 24 Jan 2025 16:28:11 +0000
Message-Id: <20250124162836.2332150-52-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Implement the FPCR.AH semantics for the SVE FMAX and FMIN
operations that take two vector operands.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 14 ++++++++++++++
 target/arm/tcg/sve_helper.c    |  8 ++++++++
 target/arm/tcg/translate-sve.c | 17 +++++++++++++++--
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 3c1d2624ed4..918f2e61b7e 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -1140,6 +1140,20 @@ DEF_HELPER_FLAGS_6(sve_fmax_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(sve_fmax_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_6(sve_ah_fmin_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fmin_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fmin_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_6(sve_ah_fmax_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fmax_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(sve_ah_fmax_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_6(sve_fminnum_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sve_fminnum_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 2f6fc82ee4f..a688b98d284 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4347,6 +4347,14 @@ DO_ZPZZ_FP(sve_fmax_h, uint16_t, H1_2, float16_max)
 DO_ZPZZ_FP(sve_fmax_s, uint32_t, H1_4, float32_max)
 DO_ZPZZ_FP(sve_fmax_d, uint64_t, H1_8, float64_max)
 
+DO_ZPZZ_FP(sve_ah_fmin_h, uint16_t, H1_2, helper_vfp_ah_minh)
+DO_ZPZZ_FP(sve_ah_fmin_s, uint32_t, H1_4, helper_vfp_ah_mins)
+DO_ZPZZ_FP(sve_ah_fmin_d, uint64_t, H1_8, helper_vfp_ah_mind)
+
+DO_ZPZZ_FP(sve_ah_fmax_h, uint16_t, H1_2, helper_vfp_ah_maxh)
+DO_ZPZZ_FP(sve_ah_fmax_s, uint32_t, H1_4, helper_vfp_ah_maxs)
+DO_ZPZZ_FP(sve_ah_fmax_d, uint64_t, H1_8, helper_vfp_ah_maxd)
+
 DO_ZPZZ_FP(sve_fminnum_h, uint16_t, H1_2, float16_minnum)
 DO_ZPZZ_FP(sve_fminnum_s, uint32_t, H1_4, float32_minnum)
 DO_ZPZZ_FP(sve_fminnum_d, uint64_t, H1_8, float64_minnum)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 214aec7f83b..0fed92fa48a 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3759,11 +3759,24 @@ TRANS_FEAT_NONSTREAMING(FTSMUL, aa64_sve, gen_gvec_fpst_arg_zzz,
     };                                                          \
     TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz, name##_zpzz_fns[a->esz], a)
 
+#define DO_ZPZZ_AH_FP(NAME, FEAT, name, ah_name)                        \
+    static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = {         \
+        NULL,                  gen_helper_##name##_h,                   \
+        gen_helper_##name##_s, gen_helper_##name##_d                    \
+    };                                                                  \
+    static gen_helper_gvec_4_ptr * const name##_ah_zpzz_fns[4] = {      \
+        NULL,                  gen_helper_##ah_name##_h,                \
+        gen_helper_##ah_name##_s, gen_helper_##ah_name##_d              \
+    };                                                                  \
+    TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz,                      \
+               s->fpcr_ah ? name##_ah_zpzz_fns[a->esz] :                \
+               name##_zpzz_fns[a->esz], a)
+
 DO_ZPZZ_FP(FADD_zpzz, aa64_sve, sve_fadd)
 DO_ZPZZ_FP(FSUB_zpzz, aa64_sve, sve_fsub)
 DO_ZPZZ_FP(FMUL_zpzz, aa64_sve, sve_fmul)
-DO_ZPZZ_FP(FMIN_zpzz, aa64_sve, sve_fmin)
-DO_ZPZZ_FP(FMAX_zpzz, aa64_sve, sve_fmax)
+DO_ZPZZ_AH_FP(FMIN_zpzz, aa64_sve, sve_fmin, sve_ah_fmin)
+DO_ZPZZ_AH_FP(FMAX_zpzz, aa64_sve, sve_fmax, sve_ah_fmax)
 DO_ZPZZ_FP(FMINNM_zpzz, aa64_sve, sve_fminnum)
 DO_ZPZZ_FP(FMAXNM_zpzz, aa64_sve, sve_fmaxnum)
 DO_ZPZZ_FP(FABD, aa64_sve, sve_fabd)
-- 
2.34.1


