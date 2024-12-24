Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D50E7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDo-0000Mn-Ok; Tue, 24 Dec 2024 15:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDW-000732-Jv
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:23 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDU-0002yf-Tp
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:22 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-216634dd574so40016175ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070960; x=1735675760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qMWHCU8E787jJTfENdcTGiVxd4zzSlvdX30p3jl01M4=;
 b=GffYiqBNLAzxx3KVZWPF2Dj7oSAR+LbBeZkxm7SDygpT4kYdh37DH7aO8rDMykmEyQ
 iVAyJ1NAiRsCGpIPQxMugFyt65Daprwv2dJz3oSgnM2uG3JlK1rEiZxtdmUfg6jVseet
 o9rWkaUeY6/8vmFqY4yJtvzgYMYpB8UKom/4rL1nNv8WHrGWqHyHpwQb1KCDSfMSzFGp
 q8zV11EihlFqEGxLFMNsHmucUdvIS2H+gfkLVEBz8cJVBEZybMBBYid3e/EncpDhqydS
 9KaIB8V4f/I8JIRygOJDHvAaE/xCOI8+hynTlWmf1NftX1h+oQJMeyUlJa7eIXh+DizD
 cCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070960; x=1735675760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qMWHCU8E787jJTfENdcTGiVxd4zzSlvdX30p3jl01M4=;
 b=WCtj3/uewzLnK9FHss2dCGWIS6R0SD6GpV7CVR7DgWz12eFW5ZcTZESsamcbWz48WY
 Sbv7TDMp+ru+noiKaHozqG3WUCcSFDozGDAgWJfijkWLYFB5hyxBY2u8+ogjKBYtvVIl
 BezkvyoKZKdDxdf9XpYAeH5Zh18EJUAzqeP9TIItXInz01Ld/4GZDSNXpbYxA3cu3SQA
 ZrkP/garK5s5q59S5RHGqIhGx6y+mzvCmFmmtwTZSv+yi/c2ILLsRbBf5upo31tWFXwn
 bQ60nHOFPAcFmFJ7Qre039I3UmIr6zWIIkG0PPyLEElZuFwZN6C6bkXR6+vpJoOpJd2K
 tzdA==
X-Gm-Message-State: AOJu0Yw9bn0h6GMn+sitm2SMKk8X0ywEJ05PfUv1OeXK9DrR+roafQXt
 n+QCK+hsENcZMxlyYZ11jdTDMHnb0PQlqp/8w+KtOZIHnwa35hlTNv5aVZSN3KnaYEpCgR4SRkw
 yNwA=
X-Gm-Gg: ASbGncvAOqoNs49svkejSzHMNH0epRhNbK/2siSNljhNMy2JEHah7cZmsHaQ+eb5vUA
 ZrfShC9nNeDXxLnO6WDEcCXAQqxY/wjUkTblHE2OC78HLtoxbMIXt91R1bww5jHuqj1hObeaPwx
 wQ+zErjKPgULD/jw6TYHHcdtMPcZgiWWR6g5xIn8C4FHRTtuj77i08eOOCIqQOd0CGC5R56ACN1
 4gUudfZLoguaLzcTaLfxeb/2OjJQjyc7M98VlyGCj3Fpk3VzIL/0gVElC6oqfV5yuKrEgcGBy5s
 s9yqqhd/wGn+vsIMBygYeJFs0w==
X-Google-Smtp-Source: AGHT+IFdtV4HZG6C5IKjSmTWi7b+ImB6uEVWHa9QsEgWvkjEBxTZvCGOAzp+zpRtgGJOQ9Slu6e7fQ==
X-Received: by 2002:a05:6a21:6f87:b0:1db:c20f:2c4d with SMTP id
 adf61e73a8af0-1e5e044b1c1mr27570093637.2.1735070959723; 
 Tue, 24 Dec 2024 12:09:19 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 60/72] softfloat: Add float_muladd_suppress_add_product_zero
Date: Tue, 24 Dec 2024 12:05:09 -0800
Message-ID: <20241224200521.310066-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Certain Hexagon instructions suppress changes to the result
when the product of fma() is a true zero.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h   | 5 +++++
 fpu/softfloat.c           | 3 +++
 fpu/softfloat-parts.c.inc | 4 +++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index aa69aecfb0..09a40b4310 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -120,11 +120,16 @@ bfloat16 bfloat16_squash_input_denormal(bfloat16 a, float_status *status);
 | Using these differs from negating an input or output before calling
 | the muladd function in that this means that a NaN doesn't have its
 | sign bit inverted before it is propagated.
+|
+| With float_muladd_suppress_add_product_zero, if A or B is zero
+| such that the product is a true zero, then return C without addition.
+| This preserves the sign of C when C is +/- 0.  Used for Hexagon.
 *----------------------------------------------------------------------------*/
 enum {
     float_muladd_negate_c = 1,
     float_muladd_negate_product = 2,
     float_muladd_negate_result = 4,
+    float_muladd_suppress_add_product_zero = 8,
 };
 
 /*----------------------------------------------------------------------------
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6967fb5c9f..8d75d66817 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2274,6 +2274,9 @@ float32_muladd(float32 xa, float32 xb, float32 xc, int flags, float_status *s)
     if (unlikely(!can_use_fpu(s))) {
         goto soft;
     }
+    if (unlikely(flags & float_muladd_suppress_add_product_zero)) {
+        goto soft;
+    }
 
     float32_input_flush3(&ua.s, &ub.s, &uc.s, s);
     if (unlikely(!f32_is_zon3(ua, ub, uc))) {
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 37d046cfe9..ebde42992f 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -615,7 +615,9 @@ static FloatPartsN *partsN(muladd_scalbn)(FloatPartsN *a, FloatPartsN *b,
             goto return_normal;
         }
         if (c->cls == float_class_zero) {
-            if (a->sign != c->sign) {
+            if (flags & float_muladd_suppress_add_product_zero) {
+                a->sign = c->sign;
+            } else if (a->sign != c->sign) {
                 goto return_sub_zero;
             }
             goto return_zero;
-- 
2.43.0


