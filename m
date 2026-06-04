Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D60CD6E6E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHoH-0006pt-0v; Thu, 04 Jun 2026 19:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHoE-0006mA-3K
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:10 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHoB-0007wR-A2
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:09 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2c0a5354da1so10500785ad.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780616946; x=1781221746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6nA2YiQhG++AMTvXj+mmEfp459VqpwutOWbksti+JQ=;
 b=F/RaKhLtt9Fq0PIR56AArkzzKiUKE9kGDWbHeDQSUXEZ6AEOv4RegZyMdKLsqJFBx6
 0CcMSie7TxaKU0rmqphFJ8iKzELrWAVnUXXhp9PeO0yXwFhrAvYGcZKHZgZQr+jALaE1
 fjFC4RcURjwL7F8PjIk6DZC4QsXw7tUIjfHq3Tga+52k8S4sju34E5FQBqMTb17+MCXh
 YPTE/uegp8GH2mk416xuQZDQfePL57gUvmyIvR0eAqd0ll9PEUOFLMBqRi6zrwvGVlMa
 iYIE61glw13pggiuT1uGalrqqO8yXQcZHIi9ainkFNNovj8UZziLPRm3Q4biOmtQSqYz
 JlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780616946; x=1781221746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W6nA2YiQhG++AMTvXj+mmEfp459VqpwutOWbksti+JQ=;
 b=I9bnvi2qlyrsMSPoap/uEMChOmeMXtr2hIBLpZebmto3IQooj5binVDXoXuo1ueOAa
 xi2BSzbFJk+7OePSZAicTsm4gqRqXHAKG8sqwUjj4888P8Clk0bDbw3qA/0MsSnbL5rw
 O5T8R79to30e6tHee+Ki+kzRFenWlqbzafgrHVVp/G6/mZzUmIdoeC+AdlJyGQF3sb1j
 4DjW9b/xyBbyPdt9xPiXRtm7LM8yuLUnm6xGZZBfhxknNEA2eUUmejs+XnbTX+MUrui7
 uQVPT+ijEQ/DmTh3Yx52iTblQ3DMz5JEKv1zPQb5p/8IERWUnS/JMZ9OOvDhtd3+gijt
 V/hQ==
X-Gm-Message-State: AOJu0YxD6cfS/fZcYUETy/FJGdp+8Pg7QjV5PP1Uy9Kt5FrhOXc/R6cD
 w8LN86GmMnU5WUjmrSGdzwVwISrELZ0U/Gpya7v5Gqz8w3fWpiebFhwcFx+6syMeNryTrABy/cL
 cza8ML6A=
X-Gm-Gg: Acq92OG/c0uSJ7VHuMSHKI+Abe63MDvVpyOtLS0KxmCG8ByU/09k0SCxmCwa5h7hKiX
 5RPVxln/J3eXelmu5Dn+SQrAKpH7yXV1LINSZOKMGZpnPMIB5i8EgAuyeOkef3D6gD/q8PFcTex
 uIKNMtvu8zj6tQ5ZFjrVPMdWtzcMagBExdQCA3mDEkqtZ2kMz45PdYxKkBEnQoBcIhNMOeo2e+9
 CgSYkhmWuVF9jlUJcA3A6nexpX16tPSGMLT+z5eGqb2v7cIUBV+RxMTfypcIdxP1zli4/mT7B8L
 zVJ/SXL5c/gLI95JpwGrvv/kaS8/hQw0uoxHHJvclTi7/ohDSPcGECW1DyV/dvxIuEOFaCbUMh2
 2lru9U1r1JJWRjgkx7HLuc83Rav0gZTIsvmiA/XWcSexC8YjwkLZY0SJsPrasiqtuH1lJoH0STZ
 7LdbwBssGONP5gA12LfmmsRRzMJYY1nNzrrfRED04=
X-Received: by 2002:a17:902:c403:b0:2c0:c262:b924 with SMTP id
 d9443c01a7336-2c1ec920ec1mr1487065ad.13.1780616945832; 
 Thu, 04 Jun 2026 16:49:05 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1664950aesm66541465ad.69.2026.06.04.16.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:49:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 16/25] target/arm: Enable zeroing in DO_FCVT{N,
 L}T macros in sve_helper.c
Date: Thu,  4 Jun 2026 16:48:43 -0700
Message-ID: <20260604234852.573178-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604234852.573178-1-richard.henderson@linaro.org>
References: <20260604234852.573178-1-richard.henderson@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use the low bit of simd_data to hold a 'zeroing' bit.
The simd_data field is currently unused and always 0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index fa4bf02278..c2b3162084 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -8595,6 +8595,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vg,                               \
                   float_status *status, uint32_t desc)                        \
 {                                                                             \
     intptr_t i = simd_oprsz(desc);                                            \
+    bool zeroing = simd_data(desc) & 1;                                       \
     uint64_t *g = vg;                                                         \
     do {                                                                      \
         uint64_t pg = g[(i - 1) >> 6];                                        \
@@ -8603,6 +8604,8 @@ void HELPER(NAME)(void *vd, void *vn, void *vg,                               \
             if (likely((pg >> (i & 63)) & 1)) {                               \
                 TYPEW nn = *(TYPEW *)(vn + HW(i));                            \
                 *(TYPEN *)(vd + HN(i + sizeof(TYPEN))) = OP(nn, status);      \
+            } else if (zeroing) {                                             \
+                *(TYPEN *)(vd + HN(i + sizeof(TYPEN))) = 0;                   \
             }                                                                 \
         } while (i & 63);                                                     \
     } while (i != 0);                                                         \
@@ -8617,6 +8620,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vg,                               \
                   float_status *status, uint32_t desc)                        \
 {                                                                             \
     intptr_t i = simd_oprsz(desc);                                            \
+    bool zeroing = simd_data(desc) & 1;                                       \
     uint64_t *g = vg;                                                         \
     do {                                                                      \
         uint64_t pg = g[(i - 1) >> 6];                                        \
@@ -8625,6 +8629,8 @@ void HELPER(NAME)(void *vd, void *vn, void *vg,                               \
             if (likely((pg >> (i & 63)) & 1)) {                               \
                 TYPEN nn = *(TYPEN *)(vn + HN(i + sizeof(TYPEN)));            \
                 *(TYPEW *)(vd + HW(i)) = OP(nn, status);                      \
+            } else if (zeroing) {                                             \
+                *(TYPEW *)(vd + HW(i)) = 0;                                   \
             }                                                                 \
         } while (i & 63);                                                     \
     } while (i != 0);                                                         \
-- 
2.43.0


