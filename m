Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F028C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwls-00065D-EY; Wed, 02 Jul 2025 08:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjP-0004Js-RB
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:36 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjG-00026C-27
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:31 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2d09d495c6cso1492015fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459899; x=1752064699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WwLn3WhHlvytYPJIhgkaCdKN0x2bjUBia0lEYjEMXSA=;
 b=Dltj1ZJ7/pyH75O3zYGrn5JEk5TIUEmooRHQ6P0KA2KFItYS1uidOHK2hb9y3+Zzch
 pPBF1aOqZ9pTTXHiIvB/a32Zdt8sQEbBH/xh2ZnrKoQf3jcSENCDAz7rcO/6TPveQLKn
 CHf8plSr+dc+fc9kTZwCgBfraJ2Xtm8leiHitVsP891aO5jYr7IDhUTqioe91RsuZja+
 2SdGOLx+wKduTynb8+F757KJz+d7l8tTqCIVvN2KH2QBL69SEZA+KFN0cOsINegQs76I
 oExijX2eAn1nnUUaXey+G8H/IPyrhSUA8vUg5/ymHdo2SuNj50n3fUmqSE1zOO8cG55H
 XRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459899; x=1752064699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WwLn3WhHlvytYPJIhgkaCdKN0x2bjUBia0lEYjEMXSA=;
 b=nNZ5BOx9BtzDO21R/NVX/m2FF7bnsXDBrtGBGWlYG8AcfOdd+YLreOBWqAcPucEwdq
 eYj8vqazFzqvZdkIHKkR03lvvtPFtnNDvMRnlxV15DDyYmzmmfbqAAYFnUURrDWv2VFc
 b49gflJCEVjWe5T+/Y7M8lSR8G3lehTjWHANlu6Y0w81y78q14R2icAGN1Cy5KqPYYTQ
 x5xHQBV38zGvwNDaCsJ6qF+yXksSB+hw3va7pMqhTrOkuD/bD3zAQze5AE1sQ+5nDj4J
 S/nkJx8U+7DLvra7ijr+BS5G+Moz5lk8eYRfp2fiiFMgAmRHEPJo30eqo9WyI8xkXIOE
 fj4w==
X-Gm-Message-State: AOJu0Yyg1uqcHGOqPKKnM+mhMDkggSBOAg/8b/rAlkTJIzGu+L/ABn7Z
 V7NrmMQXxXELTUZTaqJAgxxy0zWoatTftk5+nfJSUix2oN9andcawK+mG1/hVvfxaQpHMBMMKfY
 4pXfcS1E=
X-Gm-Gg: ASbGncsGLuYPMR3A9ppmhMzJXQ9smX+yrTsx5uJibN9LSQA1QT/abGxnqi564fsyFjt
 Ec/wC6tyHyvtr2tVIPPT/Xl6cKhm8n3dbgKeKSYgMJVnV+RwjwDSR0FNgNUmY+a/rYMD0ZsGQx6
 RtDpJVZyaypmfM/hny991c25fHAAOccqL99/3JRNG3obKfhVL6WcC8psCTVI7Ria/x0mX+iYl++
 pgrfjqBCjvzLl47DQ3HIGU1EQBzupb7qjc5Kp5NpCv+leNfPoFDkdF9yhz1lxhgLYEka3LJu+oM
 6rFQcaksbUVM6R0jOzV9eIJizNh0OsJTj77rmMmzavG7KI+HTTC5HWPyI6IVRpvQGUQtGw==
X-Google-Smtp-Source: AGHT+IGO2yk3kMmgfrkpe7v6oNyXET6XXH9uKqNUMSmVpLFUqiypZH1E/7LRrYGWyxAOTu98TrRDVQ==
X-Received: by 2002:a05:6870:a1a8:b0:2d4:ce45:6993 with SMTP id
 586e51a60fabf-2f5c7d80446mr2144549fac.30.1751459899370; 
 Wed, 02 Jul 2025 05:38:19 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 53/97] target/arm: Move do_urshr, do_srshr to vec_internal.h
Date: Wed,  2 Jul 2025 06:33:26 -0600
Message-ID: <20250702123410.761208-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

Unify two copies of these inline functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_internal.h | 21 +++++++++++++++++++++
 target/arm/tcg/mve_helper.c   | 21 ---------------------
 target/arm/tcg/sve_helper.c   | 21 ---------------------
 3 files changed, 21 insertions(+), 42 deletions(-)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index a1c10c60a1..5efd257c50 100644
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
index 506d1c3475..b9b2faa3a7 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -2164,27 +2164,6 @@ DO_VSHLL_ALL(vshllt, true)
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
index f9052f2164..0e59ad2262 100644
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


