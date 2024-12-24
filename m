Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CA2E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDy-0001Wv-On; Tue, 24 Dec 2024 15:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDT-0006dQ-QV
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:20 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDS-0002xz-4W
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:19 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2165cb60719so57760375ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070956; x=1735675756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MKoswZ0+HzjatCwvvzude3nDWSM8RUV02VuNA19m0ac=;
 b=kp847CNw7g5ZE2ZUZgWnGD8MT8kNil/Lh3RycQJn1/Lrn4UI9EuL81BR6k6j9TamFa
 4A6OaE3xsd+rORv6FOriyyGWsBP+yQiYd/N9+ooy0r8aQt3lUDBiTajjbWJnRCCb33oz
 fasUEoCHmefLmMIfSqvudN3fLLwf50nT/BqOQduBe0PDlg7eVGgjmkr6xvPOVCv0v3bT
 MiBxYaX5tSQYXYhakAHI6fAci769Q6RZ9LoyV+9w0JgMdSIDrQXzpGIeV11eFE8gSNAO
 aWkjzg719+GMdQQW7tvhaXGp2vo6K7A8toHhAHjDl933T4YhJtTlT1e3yi6BaYB6f3uR
 EhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070956; x=1735675756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MKoswZ0+HzjatCwvvzude3nDWSM8RUV02VuNA19m0ac=;
 b=QPi1nKl1VvUvxXj7SSusa6T+xxXYu4rrshdjJTEanjQpz2j1gT10slk1XSYZOwXJli
 ErXbPdR/rKLdpGC7+wbDgXJfucyTA91QiNzkF8Kbh7+mk7r41Z2uQbvA9tOfKF+U3Cbv
 CH9Ym7LZNPN6WIWAMDiUo7skK2zbzaVcisoyo52Xz3KqraE4rA4wNAtET1oUQS9plc98
 QDQjybB6HVH3o1a5cy2z1ZvoKQZueaSqt6DpCeEMA14E5Lupk1nMvBPIFJwGFFm05GJb
 dEptHo5sveDTyulmsoJY8AdVfCwfaWgVs+uZgLPM9y7LzqhLNl3KoEeDjPYSyDb81bPX
 DpZQ==
X-Gm-Message-State: AOJu0YzqhaBngt8+bXeb9zhzOl39LQrfjdGow3YFVrBbPNIw3KVzhTja
 ccTKQbSZSKQV9VIi4B54AGw4L61E+fCYFrGNk4uvOAnc4d4U/8oPqIG6R3yG63TJfOCdNAyf8DG
 FKns=
X-Gm-Gg: ASbGnctKio1B2n2FPkIsjV+0ZRZDT3crY8wUaQCCj9PRo7ZRpOlFTX7Q/1Qhv6HAeAR
 2MG1enM4VfB1uYAjJ5++BypyskwYFjYSrQaMKBn4synOfKQ+z8Q/qVnq2S0OtYN+ShANS7xPfa6
 IUTb845tJrX7QRsvSsFGdbBUEjVNXm3xD9FQptvehlhwa/Dww0hnrAwII9N3btUwmQp8gGIcpAT
 dXCZ335Aa+0u5/OZZDx3dS/8hnhSVEnFg7SifU+YSNEKoke2lcz4LytxlqD4g8IOq3iZJZsQlpZ
 5dqQPuIFr0lVpZIagE2EPstFfg==
X-Google-Smtp-Source: AGHT+IEDblHEA9wUfsjiGcRIfKSQv0eqZVzS/4gR+pavyf6iJ2fh8GFr9GZTAUbzFqoBFVfNnuxbWg==
X-Received: by 2002:a05:6a20:6a25:b0:1d9:6c9c:75ea with SMTP id
 adf61e73a8af0-1e5e0448930mr28347558637.5.1735070956205; 
 Tue, 24 Dec 2024 12:09:16 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 56/72] target/arm: Use float*_muladd_scalbn
Date: Tue, 24 Dec 2024 12:05:05 -0800
Message-ID: <20241224200521.310066-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Use the scalbn interface instead of float_muladd_halve_result.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 0e130501fd..3b226daee7 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -262,7 +262,7 @@ uint32_t HELPER(rsqrtsf_f16)(uint32_t a, uint32_t b, float_status *fpst)
         (float16_is_infinity(b) && float16_is_zero(a))) {
         return float16_one_point_five;
     }
-    return float16_muladd(a, b, float16_three, float_muladd_halve_result, fpst);
+    return float16_muladd_scalbn(a, b, float16_three, -1, 0, fpst);
 }
 
 float32 HELPER(rsqrtsf_f32)(float32 a, float32 b, float_status *fpst)
@@ -275,7 +275,7 @@ float32 HELPER(rsqrtsf_f32)(float32 a, float32 b, float_status *fpst)
         (float32_is_infinity(b) && float32_is_zero(a))) {
         return float32_one_point_five;
     }
-    return float32_muladd(a, b, float32_three, float_muladd_halve_result, fpst);
+    return float32_muladd_scalbn(a, b, float32_three, -1, 0, fpst);
 }
 
 float64 HELPER(rsqrtsf_f64)(float64 a, float64 b, float_status *fpst)
@@ -288,7 +288,7 @@ float64 HELPER(rsqrtsf_f64)(float64 a, float64 b, float_status *fpst)
         (float64_is_infinity(b) && float64_is_zero(a))) {
         return float64_one_point_five;
     }
-    return float64_muladd(a, b, float64_three, float_muladd_halve_result, fpst);
+    return float64_muladd_scalbn(a, b, float64_three, -1, 0, fpst);
 }
 
 /* Floating-point reciprocal exponent - see FPRecpX in ARM ARM */
-- 
2.43.0


