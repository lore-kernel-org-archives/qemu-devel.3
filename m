Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96763C0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg88l-0005ad-On; Thu, 06 Feb 2025 15:06:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83n-0007w6-KT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:19 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83i-0001AT-5o
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:15 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2f833af7a09so1897679a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738872058; x=1739476858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9uMU1ZpbA1QScox1sAJ2B3widhOf2/CmEsmX0Sv02I=;
 b=ala9qftjBxZXgs6mUqrdWPDY8Gyl3APefjQNEyBF3cKA6i8VjtsY6Ka+yls7d6DwP9
 EliSC3IouUtsvqxLM2Enlq6E7zu4qQtWOBzAJ+P/6B9WTgI1noQxSXlxssAXu+/tEGY/
 zOvbTvRmn7QzrlO/Z8LzyJ/1kH64HGZsdCInJyTWVsHInhoJ2nN50VclUtsDtG96RTqf
 qAhsZUJEaKoO7R0DutzPljdp2K3bo1H9GI2cqyLF4D7KTZLKaoC0Qr3GbDmZjML/kLQx
 WoToSbjgkzSAWhKhOXmlLROeyZCniWatMRT3GqUdz3DP/rK227v3CghWofTTwVgL40Ns
 xWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872058; x=1739476858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F9uMU1ZpbA1QScox1sAJ2B3widhOf2/CmEsmX0Sv02I=;
 b=ap2qxjPlf5Jnu0yOXhkXh/0w80FTgBEW4y1GTydtcmgDbnytlO3hQFrXpVMTNJkma2
 utEURiIwvFctqc9izA60US4upP+pCJGa7mIm8sMlK1pmf98vMdb0QbqPoknYrEjcFtOM
 L+4RVDIcbWC5ZAQju6booHHPCDfm/AMglD092oJ7F8HVumnUxdKk15roe0nvfmbcEFlu
 r5NHzTXny52XQ534zzBQp5z1n4ERRr8CtKPj7LLB7aJtNPEDuLeIWLUBUSe8UKVJSamK
 U/LwjXAfi21ln1tk+1dMhIObXIagVfn4kLDvoAUUotsrbj2Wgx9kpTBj7e7rltrLuM79
 2WDg==
X-Gm-Message-State: AOJu0YwGDYPJ3+1/dGL53Phu2wGLsRo0S+kRZHBeY3gqn3kpiZ9NUkjp
 JpoN+Y0aRqKTC2eJl1Rcc3p4OiDUGOGFcCctCjT5M3dMsvPBYWV31E3XA70TIMmeNbH2QEZFW8N
 r
X-Gm-Gg: ASbGncsiFpu4oRQUoOYRiQF/+qG9NjUjW6XW6SZCi8/BWKbbPZwoC8WR6Q2NymK3pF3
 jxka7XVWlZDiTELWQcqrhlDEgDelURgxVyZorVI3xt3psiYTg5zMzfYw44YhMKppsHowGvxPedd
 IbpZ0zxYJl7NNNtRDVqXAizFzkqtkHpKGsHw262cpPYEe17N0SW4GC/5c88FH054HwJcG0J3TUF
 illlMzaTzJlflPFXdyX/Bu/q6SjFp/C4VwiQh6P2nfj/GigbELHSqdiCbA1QuamimbMjCr4gy7A
 TfgyvuH024wl5YudkZamfD6GoitmhI/zyEpdfSwsm8LZJds=
X-Google-Smtp-Source: AGHT+IHrOTYUkZbBTlHI/wxElwWr2RmwuhpfLI8ZwvsqHqK/pAvjy0hEJ45POtKwf6rZm3WPXfG6Lg==
X-Received: by 2002:a17:90b:4fd1:b0:2ee:d7d3:3008 with SMTP id
 98e67ed59e1d1-2fa24064f04mr602649a91.12.1738872058451; 
 Thu, 06 Feb 2025 12:00:58 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09b3ee24sm1808857a91.36.2025.02.06.12.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 12:00:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 56/61] target/arm: Move do_urshr, do_srshr to vec_internal.h
Date: Thu,  6 Feb 2025 11:57:10 -0800
Message-ID: <20250206195715.2150758-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
index ad6fef03e6..b33a0ec2fc 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -228,6 +228,27 @@ int64_t do_sqrdmlah_d(int64_t, int64_t, int64_t, bool, bool);
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
index 274003e2e5..49353369fe 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -2165,27 +2165,6 @@ DO_VSHLL_ALL(vshllt, true)
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
index e84cffd0b0..0973463735 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -2046,27 +2046,6 @@ void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)  \
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


