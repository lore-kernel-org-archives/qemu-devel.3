Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062BFC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhOa-0001lE-F0; Fri, 04 Jul 2025 10:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM1-0004Oh-LK
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:32 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLv-00082z-84
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:29 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-61208b86da2so283837eaf.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639122; x=1752243922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e72HPrwLrbdL1jX39eQb8H3bN7lS2PKV0Eo2nzZUj34=;
 b=CnRhtyfUKAYMCFJnHcvwatmRobwlUO9nJrk53Ez213vK32NbDW8S7ZjZXfCUkTlvmZ
 n4EfWTD5TOhypx8tJA6jJNPoOpEN47h21FRxSzNWmFiD61RceEydec20fcLWCE1vFzUV
 DRUg29CrfoxXbwfn/6Z0A8MYGQvgHM7u7zghUYrAXGLkePh3Fr4NK3lS/UmwRsYVAQW1
 ZdurxAnSz0LM4TQDUjjbkONtugS8H64nK0LgRxa4cLCHc1j1Y2tEA+uY1otVWwo2w42N
 8UpGXnPcIZDEbg4e9TdmdR/qgw/WbI82MNdZ7Czt/hV7K0wE37aLNCRCYoSoWfD9g8dR
 J6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639122; x=1752243922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e72HPrwLrbdL1jX39eQb8H3bN7lS2PKV0Eo2nzZUj34=;
 b=cP9NnST29HW2uI7k1iyC1staArInlLDEnmeN9QnxEUr5PyyezfKqZZYNnzXhMXW8EK
 kfjTFN2fiuDv4/Ss2YJLSFz190zqRZg+F4962RCK7NUhmLiRUYLdvs32zbJDhf1+90zb
 EqBaNJaBvJxkq4QBV5ZHLEp6nCr0maNDTL8r/WTKiz3uONWi5K/uT+CDsWbEYCqkPtJC
 XIzRdX5rSanCJhDkxAyvsxQHDvJmDPcJsYjLC/N8NybzHYDhbpCNjIIHGnDY2zQrVvCR
 15gHCw72PzdOZ+IBoJlNt6sLAmWCmbiaxdrum85Lk3qRW8Xf4WlmO+kNuKrL6ggg4XLQ
 fsrw==
X-Gm-Message-State: AOJu0YwJxi03ESZqsL/Lcs3FDxBmxWSIeCYWAuqoF0/97YK1CJf0FiyH
 T5J1asBDVfekeDJ7zg/6AVY8gRDX2s/wPKb68hO/2enDEYrSdyvPbcEnvVQIrxUqgEshgJlgV4J
 x9zL4cr4=
X-Gm-Gg: ASbGncsWbKXGGpa8sRfj1h0SBOciTmwwrE3Y+Sx0k4IJTKU9uhAFD1y0q9Bu1o3NIDi
 XJnw6thp/PIcTJhSVf2GJOdcoFtLl2Bjb3DqOl8aJqbr/Ruc5MV6+1PIR/filoxG1BUEy6umwEn
 LJUIGvGR2NbqRTTpPkceACERACHXG1J7nVCEYisjjMVITsrItClXK2Y3Kdwf6U71D7wxZQ7s5VC
 DhhTGmSbIp+b+EFJe4FMBx7boSA6lRt+7po3HFddRr2KVkS2Cz6l1NLc17NcreuHph/CQasVQr9
 m9sFYSQ7W9r2r6tzJwooh/pWm66xvJMCYqstO7kEStQHJbQoC8mwHTDj7ygsW9xKqAjBcTKWNsT
 X2Y80Ux8UyeCxOjJo9+LY1x9YWWdioaMZqerijqj4vwGie94j
X-Google-Smtp-Source: AGHT+IEtjVH5p8R/Wv/5Z0KTrbNLK0WHaEfh4Eeq8fVU9b3F/mXY3Z8IIIA+s30Ugf+6VCzzWhG+7Q==
X-Received: by 2002:a4a:ee0a:0:b0:613:87ee:10e with SMTP id
 006d021491bc7-613900eb5dcmr1926617eaf.5.1751639121898; 
 Fri, 04 Jul 2025 07:25:21 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 063/108] target/arm: Move do_urshr,
 do_srshr to vec_internal.h
Date: Fri,  4 Jul 2025 08:20:26 -0600
Message-ID: <20250704142112.1018902-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

Unify two copies of these inline functions.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


