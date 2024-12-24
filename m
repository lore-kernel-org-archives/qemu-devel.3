Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A6BE7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDz-0001eE-T7; Tue, 24 Dec 2024 15:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDg-0007Wn-Qr
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:33 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDf-00030k-0U
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:32 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21675fd60feso73587425ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070969; x=1735675769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zmgwYYyv+juXwg/CgaDAXGKo2B+5k9ACWJHCK3pXUJ4=;
 b=HL7R1URW8hSYKtS8mqC7XPJm3HLZ53Ggibg5hmtTiG9DAUnzfRO0iU9khoiSQc4hd/
 hZyFzx3aoyThexULHkC7cvtJiyUs8mFxW+X49ulvEwmpFmBchctfWVbozd1Njf1LODyw
 7L2Wc3oT6rGqlQMgltMDDEeejCHpcbRWlVf3PmXjytR6k6R5xhh7QCbOrvjcOjmFCc6G
 iVMXIdv2+W1yrzwQ9LysXOdplZezbq6LgjgQVTunz04ZtNBGKgW8Ulw29PUIvAtcy/SJ
 ItBjMotDVWDiA4a1sHEuX3kx79w+p4A+xDKK8HbnIuvOUrOXCk0dcznY0N0FB06garrE
 h3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070969; x=1735675769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zmgwYYyv+juXwg/CgaDAXGKo2B+5k9ACWJHCK3pXUJ4=;
 b=bUCIX/elFqyw1NGyrEEkBVzOzW1q1IXpk5McZ0HZDBGZZt4I52odqV25/CSSxE6Q2k
 moe9ovb9gwR3ERDzxg8hbbjUwIUkvBib/mwtNMo9vkJYoaWYVulkmTpMa6ljwGh5DCra
 dU7Qnl2xqSHiFmP9T0UMrzXEPt0whb9HgVluOqSRemSrU43qVQDXX/h8fVmGqvO+bGlP
 MX2FtYTH4EA+RxxGgUuRTXRMPZ/uOzHhpSwDQARh5zxCqDNHra+cZmDYwKpjuydm3qpp
 gbfy/46r2OV8WS9bNBRHAC5Q6qN0OToZC3HY8f+5tPLhDjfqSfB9M4bDALGBsqcZ6XGS
 Whmw==
X-Gm-Message-State: AOJu0YxT66L0OjJCJFWQmkZ1P6cQ2ghN3ZLdV6wW+0h4KeD+5TBea5NF
 CusoX8hkHsCMPAls4CzqWRQ6P83SAcY/+btcZxv5e1xTaqxYWrfvRrFoUcx0rxkFB3CRNsqxmdc
 vT9o=
X-Gm-Gg: ASbGncuYRURORK0eSSBDvjkuasB1wMc1ivOmi/9WyhDHaiUidN/hS1j4QBu0JMJR0im
 bFGUMsLU4UbMDaT7CTFrWDBG6mq3ap1JfExvrlPGdUlnJkheRPP2WoYpwHDX2zwz0ybTzyLLvdF
 9h10i8mPbb4OQ1IX7dlbLU2ZsKG06aGi8UD2cb6i610YX4eK2jUmpBkm1ioZ10At5rQG2NYDLVY
 9XuifzvAWVGy8HHdhndqtOz+y2tnB5tZUyAF/KPR91yr2m07QCfErrzHE1E9/prJRpSPeoXH9Ey
 ZKm+XAgN+ChzndBBvch4ItEUbA==
X-Google-Smtp-Source: AGHT+IEVS2yGwfGET3F2CBJPDM2m79vZwPbnMFrTSEP3CxXiTjd2wu9Cv4QqN4W5YysirLJP6kWvFQ==
X-Received: by 2002:a05:6a20:7289:b0:1e0:d4f4:5b39 with SMTP id
 adf61e73a8af0-1e5e04a0ee8mr31050261637.24.1735070969558; 
 Tue, 24 Dec 2024 12:09:29 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PULL 69/72] target/hexagon: Remove Double
Date: Tue, 24 Dec 2024 12:05:18 -0800
Message-ID: <20241224200521.310066-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

This structure, with bitfields, is incorrect for big-endian.
Use extract64 and deposit64 instead.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/fma_emu.c | 46 ++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
index 2a8f72fee3..ddc793fe14 100644
--- a/target/hexagon/fma_emu.c
+++ b/target/hexagon/fma_emu.c
@@ -43,39 +43,29 @@
 
 #define WAY_BIG_EXP 4096
 
-typedef union {
-    double f;
-    uint64_t i;
-    struct {
-        uint64_t mant:52;
-        uint64_t exp:11;
-        uint64_t sign:1;
-    };
-} Double;
-
 static uint64_t float64_getmant(float64 f64)
 {
-    Double a = { .i = f64 };
+    uint64_t mant = extract64(f64, 0, 52);
     if (float64_is_normal(f64)) {
-        return a.mant | 1ULL << 52;
+        return mant | 1ULL << 52;
     }
     if (float64_is_zero(f64)) {
         return 0;
     }
     if (float64_is_denormal(f64)) {
-        return a.mant;
+        return mant;
     }
     return ~0ULL;
 }
 
 int32_t float64_getexp(float64 f64)
 {
-    Double a = { .i = f64 };
+    int exp = extract64(f64, 52, 11);
     if (float64_is_normal(f64)) {
-        return a.exp;
+        return exp;
     }
     if (float64_is_denormal(f64)) {
-        return a.exp + 1;
+        return exp + 1;
     }
     return -1;
 }
@@ -346,6 +336,8 @@ float32 infinite_float32(uint8_t sign)
 /* Return a maximum finite value with the requested sign */
 static float64 accum_round_float64(Accum a, float_status *fp_status)
 {
+    uint64_t ret;
+
     if ((int128_gethi(a.mant) == 0) && (int128_getlo(a.mant) == 0)
         && ((a.guard | a.round | a.sticky) == 0)) {
         /* result zero */
@@ -455,22 +447,16 @@ static float64 accum_round_float64(Accum a, float_status *fp_status)
         }
     }
     /* Underflow? */
-    if (int128_getlo(a.mant) & (1ULL << DF_MANTBITS)) {
+    ret = int128_getlo(a.mant);
+    if (ret & (1ULL << DF_MANTBITS)) {
         /* Leading one means: No, we're normal. So, we should be done... */
-        Double ret;
-        ret.i = 0;
-        ret.sign = a.sign;
-        ret.exp = a.exp;
-        ret.mant = int128_getlo(a.mant);
-        return ret.i;
+        ret = deposit64(ret, 52, 11, a.exp);
+    } else {
+        assert(a.exp == 1);
+        ret = deposit64(ret, 52, 11, 0);
     }
-    assert(a.exp == 1);
-    Double ret;
-    ret.i = 0;
-    ret.sign = a.sign;
-    ret.exp = 0;
-    ret.mant = int128_getlo(a.mant);
-    return ret.i;
+    ret = deposit64(ret, 63, 1, a.sign);
+    return ret;
 }
 
 float64 internal_mpyhh(float64 a, float64 b,
-- 
2.43.0


