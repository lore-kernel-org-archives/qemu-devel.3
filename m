Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57BDC83F0B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFN-0004FU-MZ; Fri, 04 Jul 2025 12:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEw-0001jy-5v
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEu-0006gf-Cq
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:17 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so9792925e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646375; x=1752251175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=snpF41TkMg+FAn1H/KoHXR01j1pFxBXmKwS7HVGOoYs=;
 b=p5rAQP1j6kDUhV4cbt4rKp/Ip0kwg3XxJxikBNlxjb/ibLZD0lWJ5625I9vpvptzyV
 apvsB9fgWr6PP2Sxacw8Wadu8/sEsi7RxgyAwfxO4WFflFzUrzwY13e5Ye7D+6iywUXq
 8eU/YA/RswhROVo0hvuMvFuQiWnV9+WDkDYYIsf6j7PxzKl94dlzzKQDGgTdQvmA5qSo
 ksMofxXHkxDTACBXORkVKGvFzSOsLXzt4Gw4syw+JsMOc8n/Vr5Ic5wyM7CEgRup/nmm
 4qYrpfC+kiw9Xm2mW6sUsHN+93ju2PvUpWJ6IeSSg6GBUYWL3/EBtQnYdthbyJC47g+/
 k/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646375; x=1752251175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=snpF41TkMg+FAn1H/KoHXR01j1pFxBXmKwS7HVGOoYs=;
 b=I3ITs/3LZjLQ1fFAOdPXCxhXlpQ1C+080G5mPobXH+SBsFfawd0LuPFu2ssnME/P7o
 t2dhw2vUGAJq/9Ub7d5X2BXK+bYiit4UPC3BLK1OlNMfgsMOgVAUfScPXLHjNNim9ioF
 rysRTIloow3ayo2bTP4jRWcUGOrToP5B8aN8XgJM0yVHLNkXHypu9Myfd4PY7KJK/MZS
 GPvjOaLLIwxVAldPVhIfiIMdVJygH9M2tBZV3/fNV1VWzgpRXg9vtmA+a1oM48Ckfd2N
 SixPK0U8kQyHhF6SOt4UotHxQezk6XX8zT0jlpYnKoMkaC2DYFo6fiEpSUKp0wbTgiXj
 iCWA==
X-Gm-Message-State: AOJu0YxujuNm9znIiPJMqUNTUp5zdRv5LpBz/xwZjh8ZWC0kz1KMvBRx
 8qoqNvtV6oQxZTRpybtxtnPjbsP1bYKb1u6N7PpgPWqvhruX8bck6OPRWzjBgYTeUI9+8YCdxf5
 m8VJB
X-Gm-Gg: ASbGncuq8zcnR6FBSrvXLlcZDiyUK8DRic1eN3C69k//HQcZirttS5CKem/P/iwuAfq
 mSMrraluYzT2j+YxjSRNA26OxCIgqVZCup/BKKLRSwupKx/QphchIYCs033qXqDYVXl8CfaEZmX
 fGi8cSKJCmn5ZTCwSy/CWns9/ej9TpNM9/BOjrEaDc24qM/mRZ2qdFyEsHtqzIE2EHFOMmA4D83
 LMyL004l2UuGpiIUEG8IZLr3eSiWhLAXtLd/gCx0b9/RMiLmL4K9b76KkvnHljZVneUK8xZkoRq
 pcCSQZQ4PvPA+TfzZzOfmGljLfrdt6sZ7aP9eaYyz/sAWQ9RSSeujpxn9HcNlwvRiIjP
X-Google-Smtp-Source: AGHT+IGIAz9P43O9C3qlYcAH8Okz3OB9qUSU2YYhJcfhTfiAC6x45mH6toF5Hyw6+Aum1eAHwlTOoQ==
X-Received: by 2002:a05:600c:6092:b0:44b:1f5b:8c85 with SMTP id
 5b1f17b1804b1-454b4e74877mr30114215e9.13.1751646374975; 
 Fri, 04 Jul 2025 09:26:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 075/119] target/arm: Move do_urshr, do_srshr to vec_internal.h
Date: Fri,  4 Jul 2025 17:24:15 +0100
Message-ID: <20250704162501.249138-76-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

Unify two copies of these inline functions.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-64-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/vec_internal.h | 21 +++++++++++++++++++++
 target/arm/tcg/mve_helper.c   | 21 ---------------------
 target/arm/tcg/sve_helper.c   | 21 ---------------------
 3 files changed, 21 insertions(+), 42 deletions(-)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index a1c10c60a1c..5efd257c50d 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -230,6 +230,27 @@ int64_t do_sqrdmlah_d(int64_t, int64_t, int64_t, bool, bool);
 #define do_usat_h(val)  MIN(MAX(val, 0), UINT16_MAX)
 #define do_usat_s(val)  MIN(MAX(val, 0), UINT32_MAX)
 
+static inline uint64_t do_urshr(uint64_t x, unsigned sh)
+{
+    if (likely(sh < 64)) {
+        return (x >> sh) + ((x >> (sh - 1)) & 1);
+    } else if (sh == 64) {
+        return x >> 63;
+    } else {
+        return 0;
+    }
+}
+
+static inline int64_t do_srshr(int64_t x, unsigned sh)
+{
+    if (likely(sh < 64)) {
+        return (x >> sh) + ((x >> (sh - 1)) & 1);
+    } else {
+        /* Rounding the sign bit always produces 0. */
+        return 0;
+    }
+}
+
 /**
  * bfdotadd:
  * @sum: addend
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 42bb3b979b5..63ddcf3fecf 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -2204,27 +2204,6 @@ DO_VSHLL_ALL(vshllt, true)
     DO_VSHRN(OP##tb, true, 1, uint8_t, 2, uint16_t, FN)         \
     DO_VSHRN(OP##th, true, 2, uint16_t, 4, uint32_t, FN)
 
-static inline uint64_t do_urshr(uint64_t x, unsigned sh)
-{
-    if (likely(sh < 64)) {
-        return (x >> sh) + ((x >> (sh - 1)) & 1);
-    } else if (sh == 64) {
-        return x >> 63;
-    } else {
-        return 0;
-    }
-}
-
-static inline int64_t do_srshr(int64_t x, unsigned sh)
-{
-    if (likely(sh < 64)) {
-        return (x >> sh) + ((x >> (sh - 1)) & 1);
-    } else {
-        /* Rounding the sign bit always produces 0. */
-        return 0;
-    }
-}
-
 DO_VSHRN_ALL(vshrn, DO_SHR)
 DO_VSHRN_ALL(vrshrn, do_urshr)
 
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index f9052f21644..0e59ad22624 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -2050,27 +2050,6 @@ void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)  \
    when N is negative, add 2**M-1.  */
 #define DO_ASRD(N, M) ((N + (N < 0 ? ((__typeof(N))1 << M) - 1 : 0)) >> M)
 
-static inline uint64_t do_urshr(uint64_t x, unsigned sh)
-{
-    if (likely(sh < 64)) {
-        return (x >> sh) + ((x >> (sh - 1)) & 1);
-    } else if (sh == 64) {
-        return x >> 63;
-    } else {
-        return 0;
-    }
-}
-
-static inline int64_t do_srshr(int64_t x, unsigned sh)
-{
-    if (likely(sh < 64)) {
-        return (x >> sh) + ((x >> (sh - 1)) & 1);
-    } else {
-        /* Rounding the sign bit always produces 0. */
-        return 0;
-    }
-}
-
 DO_ZPZI(sve_asr_zpzi_b, int8_t, H1, DO_SHR)
 DO_ZPZI(sve_asr_zpzi_h, int16_t, H1_2, DO_SHR)
 DO_ZPZI(sve_asr_zpzi_s, int32_t, H1_4, DO_SHR)
-- 
2.43.0


