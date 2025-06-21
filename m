Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17382C7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT83d-0006dD-TQ; Sat, 21 Jun 2025 19:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82P-0002D4-I2
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:21 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82N-00057w-TJ
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:21 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-748f5a4a423so1829693b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550058; x=1751154858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=orsxG4rs9FtH+hzDD4WeCDCtjgD4SnzwwyW7O92dK2w=;
 b=WTHsUktJoN7R7GWfVaf48IyKrEq3U1/qI/+kcLAqPA0IJWcXpraGTyHYy3/bjqX1Oz
 g5tfJtFv0/Tv2RwGJF+Irg0sEwxaz4kLFRCJXo51JWhJmzwChPVx4jt5m4tTrfJUyjcc
 ZNgD6MSag4wAAVBX1hg9fiR8Y8CMCBN9O0M1izs80AU0/D+1qMPCpith2uyuSBwbgdWi
 rbmkWG8r4XBTRnH01SRAE35Hpj0i9gnJ1v/sVV16uJMoEHO1v8aTL75xhLE/LLVboCWY
 DAQ3Vccxuc+1hPoMNl3gxeoE4j5PiTK+JuPHv2NL+yYl4ql0VY4i1U0BM+Cfm7/Bh8ne
 HQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550058; x=1751154858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=orsxG4rs9FtH+hzDD4WeCDCtjgD4SnzwwyW7O92dK2w=;
 b=CX1eAUtCfmKJZUqIqixVGqtrOAQnYcTxi2ONGZ1tNE2lUgZM1gCL+DZsYqxZsReFSY
 kiTb3ojkKYsRFb6wgJZReMNNHhHWIRKxEZp6C8lvAzrT1ANhJ+zLAQVvlx1+ip5YFvRB
 EX5pTBrkW7TXyeMROrUlr4pUlXGEbv0AIFeOIQeLrgoHIbimqBiEbhiacAFqM/NnAlNH
 EZPNPGDyrHEu7lb85MmkAnAEoj3al6bIbc2bV+2P+hTrsNVpwawmB14qUkAF9B9u2i6D
 oEkQhF8MsUjFNiEKuCzXmMnYY65rnk6hBrfxh4Tx7C51qGMomvZlXLhSLGQT9jhB3xCY
 POiA==
X-Gm-Message-State: AOJu0YypYinH5QZf2PjYWLjUTvmyrHbAFgSVUqg8PzNKZkSsZmjZjmOT
 XvtgLXVh55CzJ8B5g5TROXRSHVnONKzw5SUu4ILCAc+B0/MnnClOdahNJxUKcwGKBJ9TyBL2meH
 nr0QrN7g=
X-Gm-Gg: ASbGncsEO0Gb+ciFZ94wjd0lT00xl+aicMOtHcccGABwWPB4nBmfK5t437PYdP6Tohe
 o9lf9V6Mxm0BAv5gFnPRi7lpIxHtnLel3suKrUfj90IUxaF4v610RKgfglZ59h6BzyIChIZXQnX
 z24GCBmhZ4kNkhvj83FPl9Bk+M5dQHdXu6tVt4/1dSzIvcxtpAg28mfh0MNwsmEQZPORRVmylnW
 6dlvr88tsTTrvaOIjllBKLM+qM+GJ1hzJSlG34E7yCcDKxInz4hDCRjZr7Ew6iri7eVIVtcoXT9
 +YkEeJjRus1AQEPZkNiSx8jFLIF60wz2NPNq4GH7DHw5ijiNbAg4VZJAtuLJ2I3vDA9JDCTeyGZ
 wDnIALXq+2Ppi03rBWD02
X-Google-Smtp-Source: AGHT+IFlSpyfi+wwf2eNoAURQag+DBRV+JFrD6nLWUe7VtjcyKkJqdkKzN4p6h6yDA/wYzknnUEKZA==
X-Received: by 2002:a05:6a20:ce43:b0:21e:f2c4:7743 with SMTP id
 adf61e73a8af0-22026d5f209mr12653611637.7.1750550058534; 
 Sat, 21 Jun 2025 16:54:18 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 062/101] target/arm: Move do_urshr,
 do_srshr to vec_internal.h
Date: Sat, 21 Jun 2025 16:49:58 -0700
Message-ID: <20250621235037.74091-63-richard.henderson@linaro.org>
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

Unify two copies of these inline functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_internal.h | 21 +++++++++++++++++++++
 target/arm/tcg/mve_helper.c   | 21 ---------------------
 target/arm/tcg/sve_helper.c   | 21 ---------------------
 3 files changed, 21 insertions(+), 42 deletions(-)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index c0ccf6da7a..0d806b73c4 100644
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
index 67e1fe543c..e78d807ce1 100644
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


