Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70952C7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7zH-0005E9-Pc; Sat, 21 Jun 2025 19:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7zA-00059O-8S
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:51:00 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z8-0004VI-DP
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:59 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-748e81d37a7so1840548b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549856; x=1751154656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bgT8k2Fh4ol5NJOIIsQXh+0Tw9ZLXo9iAD2wBE7oMlo=;
 b=IOd7jN/scqhgZo4COlr/EKzpTRhoztQYEWSEc7XryenU+sq/1pPdrgJUoj863HvTnP
 bjviARKh3cfXSxlvesFwcjiGYEdFlNtOfunVLdunLpWriwMfjEKcGauNVrFBcn2tzjtZ
 jBJvaZ8SuHpy/npWeZVRZri6SaGoNi3iFlhgwEI8JhmRSEroC7ZxQgE+j8FmlcGIB1xb
 n5vmu4SvzYAEwOSqmWIClvorMtHAmYksTOZFPTXR8HKXBfaojDygFCOtsO6R83Jj5+vd
 xq55ynA0VD4tT3yGJMQnRkw+oM+/Yk8gUcdanhjMXv/WIwu5/OD3WeOxZ0hjlQYq4NOz
 B2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549856; x=1751154656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bgT8k2Fh4ol5NJOIIsQXh+0Tw9ZLXo9iAD2wBE7oMlo=;
 b=VvUsgEkN6+tLcO2iGUsEnXVe1/zOq/N9OwnJwnKXYqjzNKBlyvG01FMT/ifRTxBeKo
 O4Dd5DSooCW8h/6m+kjB7b8gxnZ4vWVrti+Br56a707CxW6gwYY69uHDBZ//NW7BH9DM
 IYaz33BY0aCiYYX+Y6aPv2bSxQJbnUKWIhCBxUXaVja+M4622XFfym+C8gtaTLzMcLtT
 wX8ZtxhY27ufjXUyD50VDsJukv8BUbwZ6BOgEoL9bxcQygwONp7Hn3Z2QZSEc2VYL7Vk
 ac40BrgW/FAnzB/AB2e4tedHeO6nXETL5ANFqBMS3GG+iTlvMO77goR3MnerBufmxfeI
 SEDQ==
X-Gm-Message-State: AOJu0YyeeRpwlIIYjESNyof2E8RkZGe7TaD3BJVAQ3uuWgkh1rww7eSE
 LJ2K2NleUu42JzCB09WBkTpFO0O8PIRmDhj/0n7ZReXsowwGO93WX/BKfLfmrv9eU8XuBA1d+aH
 FI1tU
X-Gm-Gg: ASbGnctiWTXNkNPvVm1n7HUFbcU4Im901Ea/FnyYmlt07eZtSqfa07eO7bcHxoSDsXh
 W7YhAPP5BCnbaJngBgLlIbgfTgquzyISFrZHgVWy+ggHAqD8mlomwia6YlPAfEF4CvqW+Q+pdhW
 ydRYjwxThPAD6ytkklIVtfRJxpsVIogB9DcgkLE1DRSVJRkcAk/m5PSLwI7Py3PW6c5UabqY8xy
 UunQvazecBGaw8H25xo/DKUuuZOTGGFHaiO86YYo/td35xRb4VdKLaFgsShBGy6sWnN44SsS8Jv
 3Q5xGDBLf7bWmCnlNd8sGct/TKlGFB6Z4fCNZlv4eJn5aincYYb9bfcZao7Qvsbfr2GmgsjAL2q
 gox3AgzmbXFCSk2NSgLal
X-Google-Smtp-Source: AGHT+IG4SF9RAfiv6bu0Bv6E/jtYdlgfa9r75HPOZ+C7s8ORjEvInYuUq3rtt/RMzK4Z6gFcd1A8wg==
X-Received: by 2002:a05:6a00:3cca:b0:749:421:efcc with SMTP id
 d2e1a72fcca58-7490d74f563mr9066711b3a.5.1750549856533; 
 Sat, 21 Jun 2025 16:50:56 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 027/101] target/arm: Implement SME2 SMOPS, UMOPS (2-way)
Date: Sat, 21 Jun 2025 16:49:23 -0700
Message-ID: <20250621235037.74091-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  4 ++++
 target/arm/tcg/sme_helper.c    | 37 +++++++++++++++++++++++++---------
 target/arm/tcg/translate-sme.c |  2 ++
 target/arm/tcg/sme.decode      |  2 ++
 4 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 17d1a7c102..ecd06f2cd1 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -156,3 +156,7 @@ DEF_HELPER_FLAGS_6(sme_usmopa_d, TCG_CALL_NO_RWG,
 
 DEF_HELPER_FLAGS_6(sme2_bmopa_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sme2_smopa2_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_6(sme2_umopa2_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 20a3fafdb6..194560eafa 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1231,7 +1231,7 @@ static inline void do_imopa_d(uint64_t *za, uint64_t *zn, uint64_t *zm,
     }
 }
 
-#define DEF_IMOP_32(NAME, NTYPE, MTYPE) \
+#define DEF_IMOP_8x4_32(NAME, NTYPE, MTYPE) \
 static uint32_t NAME(uint32_t n, uint32_t m, uint32_t a, uint8_t p, bool neg) \
 {                                                                           \
     uint32_t sum = 0;                                                       \
@@ -1244,7 +1244,7 @@ static uint32_t NAME(uint32_t n, uint32_t m, uint32_t a, uint8_t p, bool neg) \
     return neg ? a - sum : a + sum;                                         \
 }
 
-#define DEF_IMOP_64(NAME, NTYPE, MTYPE) \
+#define DEF_IMOP_16x4_64(NAME, NTYPE, MTYPE) \
 static uint64_t NAME(uint64_t n, uint64_t m, uint64_t a, uint8_t p, bool neg) \
 {                                                                           \
     uint64_t sum = 0;                                                       \
@@ -1257,15 +1257,15 @@ static uint64_t NAME(uint64_t n, uint64_t m, uint64_t a, uint8_t p, bool neg) \
     return neg ? a - sum : a + sum;                                         \
 }
 
-DEF_IMOP_32(smopa_s, int8_t, int8_t)
-DEF_IMOP_32(umopa_s, uint8_t, uint8_t)
-DEF_IMOP_32(sumopa_s, int8_t, uint8_t)
-DEF_IMOP_32(usmopa_s, uint8_t, int8_t)
+DEF_IMOP_8x4_32(smopa_s, int8_t, int8_t)
+DEF_IMOP_8x4_32(umopa_s, uint8_t, uint8_t)
+DEF_IMOP_8x4_32(sumopa_s, int8_t, uint8_t)
+DEF_IMOP_8x4_32(usmopa_s, uint8_t, int8_t)
 
-DEF_IMOP_64(smopa_d, int16_t, int16_t)
-DEF_IMOP_64(umopa_d, uint16_t, uint16_t)
-DEF_IMOP_64(sumopa_d, int16_t, uint16_t)
-DEF_IMOP_64(usmopa_d, uint16_t, int16_t)
+DEF_IMOP_16x4_64(smopa_d, int16_t, int16_t)
+DEF_IMOP_16x4_64(umopa_d, uint16_t, uint16_t)
+DEF_IMOP_16x4_64(sumopa_d, int16_t, uint16_t)
+DEF_IMOP_16x4_64(usmopa_d, uint16_t, int16_t)
 
 #define DEF_IMOPH(P, NAME, S) \
     void HELPER(P##_##NAME##_##S)(void *vza, void *vzn, void *vzm,          \
@@ -1295,3 +1295,20 @@ static uint32_t bmopa_s(uint32_t n, uint32_t m, uint32_t a, uint8_t p, bool neg)
 }
 
 DEF_IMOPH(sme2, bmopa, s)
+
+#define DEF_IMOP_16x2_32(NAME, NTYPE, MTYPE) \
+static uint32_t NAME(uint32_t n, uint32_t m, uint32_t a, uint8_t p, bool neg) \
+{                                                                           \
+    uint32_t sum = 0;                                                       \
+    /* Apply P to N as a mask, making the inactive elements 0. */           \
+    n &= expand_pred_h(p);                                                  \
+    sum += (NTYPE)(n >> 0) * (MTYPE)(m >> 0);                               \
+    sum += (NTYPE)(n >> 16) * (MTYPE)(m >> 16);                             \
+    return neg ? a - sum : a + sum;                                         \
+}
+
+DEF_IMOP_16x2_32(smopa2_s, int16_t, int16_t)
+DEF_IMOP_16x2_32(umopa2_s, uint16_t, uint16_t)
+
+DEF_IMOPH(sme2, smopa2, s)
+DEF_IMOPH(sme2, umopa2, s)
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 25139cb7aa..57c7aacb6d 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -509,3 +509,5 @@ TRANS_FEAT(SUMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_sumop
 TRANS_FEAT(USMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_usmopa_d)
 
 TRANS_FEAT(BMOPA, aa64_sme2, do_outprod, a, MO_32, gen_helper_sme2_bmopa_s)
+TRANS_FEAT(SMOPA2_s, aa64_sme2, do_outprod, a, MO_32, gen_helper_sme2_smopa2_s)
+TRANS_FEAT(UMOPA2_s, aa64_sme2, do_outprod, a, MO_32, gen_helper_sme2_umopa2_s)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index de8d04cb87..36f369d02a 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -167,3 +167,5 @@ USMOPA_d        1010000 1 11 0 ..... ... ... ..... . 0 ...      @op_64
 UMOPA_d         1010000 1 11 1 ..... ... ... ..... . 0 ...      @op_64
 
 BMOPA           1000000 0 10 0 ..... ... ... ..... . 10 ..      @op_32
+SMOPA2_s        1010000 0 10 0 ..... ... ... ..... . 10 ..      @op_32
+UMOPA2_s        1010000 1 10 0 ..... ... ... ..... . 10 ..      @op_32
-- 
2.43.0


