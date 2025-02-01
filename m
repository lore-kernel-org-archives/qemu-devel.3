Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4F5C02192
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGYO-0006fL-N9; Sat, 01 Feb 2025 11:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYL-0006ag-R5
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:05 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYJ-0001Dj-Px
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:05 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so35343965e9.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428062; x=1739032862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ltVozOB1txcRK3IvpG6N/vre3VyLEVZMby7Yj63zzG4=;
 b=Vepi+5GlxyOXxyEi+L7kofhN/MyxsSqHMk21wS5sTXahNS/KCaWdYxVKW+5uLcTk6R
 GIUiQi81t/QZherrKtjOVCcFbrDitEcEDZlMd0G8Ldk7X6mu2hCeiUdv48pzIxBKummO
 OAcIF3ab0gPp4ZL1Af16XOizAO9J8JoQUjD4UvhFMp6ocAmPdGJfF3X4kCLWD9rgZoe6
 YWxWlkVYzqZXe41RodfyVW1zDZBijjVDdSxAVWIyrUop76eO2zITawAresD9hXiKn5OT
 VfMMrh8pUr89c/yHGBlG/NGx8VHHOaj1pcRteRm9rcQjy53vTtc/A0IkMHpc1s3Vq30x
 lnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428062; x=1739032862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ltVozOB1txcRK3IvpG6N/vre3VyLEVZMby7Yj63zzG4=;
 b=g+GK+iwaUIvSEliZmx0CcKMM0/AajQrooD83YZJJqbhbY7SU0zbsI7D8IggWsZtVez
 VxS1vLFtjGZ221pFnid3OGlgk2xt15mRBururqjdg0Ym9W3Jzdofe29wDZFP/kqNan5R
 356dMZayrbX7poW/FfmzsrjRhAjW7ZXTjH74h3ltdfJgT5suZhEza4kO7CsMMYxs5mcE
 4Fa75IE4uj3HOqQLxrxA9er9w5/rnz9Hnl2oS6BPCZJu7RCqMOamVj6gct+JprUmpCP2
 xf/gyl/RtUpy4XQ8MnYuYzZUq6RXR/8dejq4QLzdSzvQKUnaUJG1KEg59lxw1k9FoOt6
 Hi8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOR5GpfIW9y8g37zNxFmkS3Afu07Faw9DNlWzN/fTCYyVzDWknTDuMCPneFX0t0YdZbXRROJ7FyGTV@nongnu.org
X-Gm-Message-State: AOJu0YxDHGJfbK0H2+JqIQRyEBbRT9RQ7xsWOaAGp10FeZ0JyRcUIeTL
 A+eRifikXKFYMwZUZ/s0oS+9cB/0thEcDNF/3hfGSCi06+edBRYHusmM/zS8f2g=
X-Gm-Gg: ASbGnctqjWEyLiiLj4FfrtMsP6wi/s8CP9ywdT0a1cPGZOzp9vR5QpvKpoNVU2HZuDR
 IcZ1/CABa210FCJdioLTUEvyU6/EANnHNoVJ5P8gd8mTWizMCi/0qVEld+q5+IqvaiCFGLPh7VO
 quR3OaVUsUUVCN5OiQ/Dn2Iyy2MMc2FzOyAkE1ybd1kHIs1HyZFu3SoZcO2ESL0JXb3NGSPuM/i
 kpmzXXFutiINSGoxWojm59OWvGiDyaR+3AsNTYR+B4VPJBw8WSKw4lv8zYadVS3YSrOJywt8ifQ
 F3HeDMmbw4ix77oPXCmB
X-Google-Smtp-Source: AGHT+IG4X3mcUppOwd1LYQgyrJtK+OKFOeXAXfikgoqlB5oO05uM5/FzWSS4VNypWv4OLcP9IS8S2Q==
X-Received: by 2002:a05:600c:4d26:b0:434:f131:1e71 with SMTP id
 5b1f17b1804b1-438e01febebmr148973575e9.8.1738428062401; 
 Sat, 01 Feb 2025 08:41:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 35/69] target/arm: Handle FPCR.AH in SVE FABS
Date: Sat,  1 Feb 2025 16:39:38 +0000
Message-Id: <20250201164012.1660228-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
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

Make SVE FABS honour the FPCR.AH "don't negate the sign of a NaN"
semantics.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 4 ++++
 target/arm/tcg/sve_helper.c    | 8 ++++++++
 target/arm/tcg/translate-sve.c | 7 ++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 867a6d96e04..ff12f650c87 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -541,6 +541,10 @@ DEF_HELPER_FLAGS_4(sve_fabs_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_fabs_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_fabs_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_ah_fabs_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_ah_fabs_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_ah_fabs_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve_fneg_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_fneg_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_fneg_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 976f3be44e0..5ce7d736475 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -879,6 +879,14 @@ DO_ZPZ(sve_fabs_h, uint16_t, H1_2, DO_FABS)
 DO_ZPZ(sve_fabs_s, uint32_t, H1_4, DO_FABS)
 DO_ZPZ_D(sve_fabs_d, uint64_t, DO_FABS)
 
+#define DO_AH_FABS_H(N) (float16_is_any_nan(N) ? (N) : DO_FABS(N))
+#define DO_AH_FABS_S(N) (float32_is_any_nan(N) ? (N) : DO_FABS(N))
+#define DO_AH_FABS_D(N) (float64_is_any_nan(N) ? (N) : DO_FABS(N))
+
+DO_ZPZ(sve_ah_fabs_h, uint16_t, H1_2, DO_AH_FABS_H)
+DO_ZPZ(sve_ah_fabs_s, uint32_t, H1_4, DO_AH_FABS_S)
+DO_ZPZ_D(sve_ah_fabs_d, uint64_t, DO_AH_FABS_D)
+
 #define DO_FNEG(N)    (N ^ ~((__typeof(N))-1 >> 1))
 
 DO_ZPZ(sve_fneg_h, uint16_t, H1_2, DO_FNEG)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 4d5de2004f0..646d0171d99 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -783,7 +783,12 @@ static gen_helper_gvec_3 * const fabs_fns[4] = {
     NULL,                  gen_helper_sve_fabs_h,
     gen_helper_sve_fabs_s, gen_helper_sve_fabs_d,
 };
-TRANS_FEAT(FABS, aa64_sve, gen_gvec_ool_arg_zpz, fabs_fns[a->esz], a, 0)
+static gen_helper_gvec_3 * const fabs_ah_fns[4] = {
+    NULL,                  gen_helper_sve_ah_fabs_h,
+    gen_helper_sve_ah_fabs_s, gen_helper_sve_ah_fabs_d,
+};
+TRANS_FEAT(FABS, aa64_sve, gen_gvec_ool_arg_zpz,
+           s->fpcr_ah ? fabs_ah_fns[a->esz] : fabs_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const fneg_fns[4] = {
     NULL,                  gen_helper_sve_fneg_h,
-- 
2.34.1


