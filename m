Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABB6C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMcH-0005dP-9y; Fri, 24 Jan 2025 11:33:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZ5-0005og-MF
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:30:00 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMZ3-0005kG-W9
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:51 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4368a293339so25517045e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736188; x=1738340988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xa1fBo10CzOivkmHS7U9EDrLQS1MKeQCJwxUTgWHwhc=;
 b=a0JyjP0Wk31axheTgrALDgVeRt5IfD7Q9iJmPEX15vG75iFA8WjgpJGaPJKd2ORime
 G6iP3F6muCgf9amnA+CU3+n4a7qglu10ufGm2rhwdS9AALXI1CtUHgR4nIKOPzNggQUE
 jd1g4jJ8xE4Fi7iSNM/5epAl/Vbvf7sALxI3kk3UvmhlRkMdsEDOWhG7/w0K/yJL7IKL
 0vNavQK4g3SpSO6qFZ+STKBbAJxKfHXbENcXGF1m+0f+6aYWNMnKC4oreZMujK4aUVdI
 8OFvBzza8IQe86xYz9SzLVh3YuKhmaqRGYx7iugDLsH+CO7c1MRfnN2zzWstT4CIt731
 jBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736188; x=1738340988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xa1fBo10CzOivkmHS7U9EDrLQS1MKeQCJwxUTgWHwhc=;
 b=lqxChFPlEq0rCniJg6jJ7a0HA2lYQ7iHEDAVREaFCyOqP06EZZKlgvPOJvUSKZp7Y2
 58zoskgwExjrTIFuFITXn9AtHwVxiggj210kMGL/Uod0uc3PNPpjTqnZpK+/IwTeM1vE
 K+iUvvKX9zOSIF7XmF0hJUOa/himdSCKX5qKlB1Fe8n3v7B68M9FAJb4Lt2RuDJJRywS
 J2ZvNZS4BCnKFLCxUWbwB5k25M3gSOghBa2pmwbUPzSZuSMfmXxjaI4/qSTkrmihHfU8
 y9K+HZ9cy8zQE8n3CtRaFazPDVwrEQuhd/DOYWM7MB6+rGxxpXOf2bdjT6jIPS827gPS
 mkWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB64TmiD/qYWctk1943aYJ3UDl397lAdoI282fZnnt0fBsKNA0PjVX43ocMSb74I4L6S+xCayI3VI9@nongnu.org
X-Gm-Message-State: AOJu0Yxo/KuwpXLGv9G9FU9Q58e3ud+0q1SDjuZRGtC7rFgES/YmcJpI
 IQJJxKhq+yy0AMC0GcCfoiEJPKG1odvNCzOqXhOBnWRWl8PwMsHLmIkwIOl5Zegk4BoLA5Y7nsH
 Z
X-Gm-Gg: ASbGncvRat7o95qAz83bV//eS78ozbQDbo1tZPv3cEBEV2WCbNRCDimnVDzfSgkbgfb
 6BUWMepw3TtZvDbTlO1mqkt/hRT5RNSFB+bjTj8Ii7BRzqeYz6eDgxQf46a+G7QMI8XoYaih3e3
 2eNJi4AKZS04Xqj5jdDR1eeGONW9OaOpw9jyKgm5fMcQw0MU12TPanPqZrj2fY3jWmwqXtH2H5P
 zx67qLYNTz/zCFDbG5EyixH5iuw0rPG9981q3T2aJaFEwLFV/xto/Pv9b/5mZ2HIdHXnHbHJYN7
 7Ge6+qXvrmU=
X-Google-Smtp-Source: AGHT+IHhLeramctmE1Zi1jhJg3//MdIibvW86th2Q4WlTyEkFX1MpOtp6JZKPxzjBzieDAovkaylgg==
X-Received: by 2002:a05:600c:4e93:b0:436:1b81:b65c with SMTP id
 5b1f17b1804b1-438913df89fmr288197655e9.15.1737736187914; 
 Fri, 24 Jan 2025 08:29:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:29:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 55/76] target/arm: Handle FPCR.AH in SVE FNEG
Date: Fri, 24 Jan 2025 16:28:15 +0000
Message-Id: <20250124162836.2332150-56-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Make SVE FNEG honour the FPCR.AH "don't negate the sign of a NaN" semantics.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 4 ++++
 target/arm/tcg/sve_helper.c    | 8 ++++++++
 target/arm/tcg/translate-sve.c | 7 ++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 918f2e61b7e..867a6d96e04 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -545,6 +545,10 @@ DEF_HELPER_FLAGS_4(sve_fneg_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_fneg_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_fneg_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_ah_fneg_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_ah_fneg_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_ah_fneg_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve_not_zpz_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_not_zpz_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_not_zpz_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index a688b98d284..976f3be44e0 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -885,6 +885,14 @@ DO_ZPZ(sve_fneg_h, uint16_t, H1_2, DO_FNEG)
 DO_ZPZ(sve_fneg_s, uint32_t, H1_4, DO_FNEG)
 DO_ZPZ_D(sve_fneg_d, uint64_t, DO_FNEG)
 
+#define DO_AH_FNEG_H(N) (float16_is_any_nan(N) ? (N) : DO_FNEG(N))
+#define DO_AH_FNEG_S(N) (float32_is_any_nan(N) ? (N) : DO_FNEG(N))
+#define DO_AH_FNEG_D(N) (float64_is_any_nan(N) ? (N) : DO_FNEG(N))
+
+DO_ZPZ(sve_ah_fneg_h, uint16_t, H1_2, DO_AH_FNEG_H)
+DO_ZPZ(sve_ah_fneg_s, uint32_t, H1_4, DO_AH_FNEG_S)
+DO_ZPZ_D(sve_ah_fneg_d, uint64_t, DO_AH_FNEG_D)
+
 #define DO_NOT(N)    (~N)
 
 DO_ZPZ(sve_not_zpz_b, uint8_t, H1, DO_NOT)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 0fed92fa48a..c173627ad49 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -789,7 +789,12 @@ static gen_helper_gvec_3 * const fneg_fns[4] = {
     NULL,                  gen_helper_sve_fneg_h,
     gen_helper_sve_fneg_s, gen_helper_sve_fneg_d,
 };
-TRANS_FEAT(FNEG, aa64_sve, gen_gvec_ool_arg_zpz, fneg_fns[a->esz], a, 0)
+static gen_helper_gvec_3 * const fneg_ah_fns[4] = {
+    NULL,                  gen_helper_sve_ah_fneg_h,
+    gen_helper_sve_ah_fneg_s, gen_helper_sve_ah_fneg_d,
+};
+TRANS_FEAT(FNEG, aa64_sve, gen_gvec_ool_arg_zpz,
+           s->fpcr_ah ? fneg_ah_fns[a->esz] : fneg_fns[a->esz], a, 0)
 
 static gen_helper_gvec_3 * const sxtb_fns[4] = {
     NULL,                  gen_helper_sve_sxtb_h,
-- 
2.34.1


