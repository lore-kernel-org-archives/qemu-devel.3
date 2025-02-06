Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF4FC02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80n-0007m0-MH; Thu, 06 Feb 2025 14:58:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80J-0007GT-JS
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:41 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80G-0000Ye-1N
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:38 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21f0bc811dbso36350605ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871854; x=1739476654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNPnjhD3814Gs1xn4ma+5ZPmap0lsuvPNcbHHHlt2AY=;
 b=c/nRTUixmN8MzZ+Oo3mc0f5RpF+augSWVcTSJkTQFdUweoNzliGeoDZGvjjVX2QcBx
 SXBWtZflH1AC1QBvE5DaWC+33AO1kkGRzFzi8C4wEQEfEQ1tL9PHFqlk+Sw/yPHdflPH
 aBjXj5zbePNe1Xqp2HmO/nVfTNQ8EZGUOi6Oh7W+hPRlyXeAuj8JjuL71C4dY+o1Ja1B
 EynFBd8m1swJispT3/JfhQCJfji4X6M1dwbO0krU5gskbNmKr1etzxBwaz6+3YRj0mJF
 F8D7Si5jTz7Ir62pZXD7MbLK6bqgDeJ4k5viJt0ZK+9DZV+l0HvFAfZgn8MyqdceWfPX
 24wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871854; x=1739476654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JNPnjhD3814Gs1xn4ma+5ZPmap0lsuvPNcbHHHlt2AY=;
 b=sHsh3TzkkBFAlMlzv/4Arbjfrhstm3BfCU6fw2RLIlIJKbZmpsiZpfpBmUsI8M5LbH
 xIYCpKX/+4fFw0BGtIm++75deXAYWuNvew+BEpfc41PdbY1kD6kZSIluRfkyEfPAp0+U
 fHDG9X3l8uJ7QLxdCL3E65uLAkNORCZ4JzmpP2gVGEBn1p8jGJkyffJ7Pg3GheVKMHHP
 pr4ktzkc/+XoRxvoLvWnw01i01dTSOXiRnWtW/xwzIFx7MSGxeDXmtlUHpUj6sx8u79u
 6W+oDPhz7RctvkQA/uOTANujzi7bnNniOmndsyQbz2CWBgFYuSDZA0tX0zO9RXWEvMOe
 BcWg==
X-Gm-Message-State: AOJu0Yw/mRtTOii0dZfS3wUYIqcSp/Qyvu/YT3BO4exKrVTdtu3b02oy
 DxXN5GrCm+4kGPwXPTNAGa5E62UKaAk0Ub5QmlA75SsN8zEkTt+tdimTkRjIUUfbP7gUxlpA1uz
 4
X-Gm-Gg: ASbGnctXkzboC5Tm2TVn7wEGsTyzewdQcyFGijsBYA150JCp2/xSGj+CXl4TYK48uQy
 jV+tEzugVZAtD5ogOMuE96qfwNgaIXdnnkcS8wQlJ3I6aj9TsgnU2DSZneJjLsGlMTC/KHNVoXH
 PutqSD5YswcR6sBopv69Uc9S8318SJiKNJ1l0trw+4jk2ydVB2PV/T5/jICn/EwlxA7xs+GinK0
 wmOwQj9J1MtcCiH/uaSMkyy3ITYpC2zO72/mGrkNtbtc09xR45I+BSb4nLYHGxbhfxugKQxFWYx
 aj23auAbZM13EgBg/yQns/VMVe/1fa+e1T0tp8t5wdZwrr0=
X-Google-Smtp-Source: AGHT+IGUtkcJBrsUcfMv9Bs8VF4j+fJGKjGtspZzdnVyO7ufHDDcPFLAKhiDXrhUGyrw7oOMRc7SZA==
X-Received: by 2002:a05:6a00:3910:b0:725:4915:c10 with SMTP id
 d2e1a72fcca58-73042cb59c1mr8884309b3a.10.1738871854384; 
 Thu, 06 Feb 2025 11:57:34 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 24/61] target/arm: Implement SME2 SMOPS, UMOPS (2-way)
Date: Thu,  6 Feb 2025 11:56:38 -0800
Message-ID: <20250206195715.2150758-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
index 6d8e2cedc9..d973d83957 100644
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


