Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B46CFF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGzol-0006LN-CS; Sun, 26 Apr 2026 09:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznj-0005e6-Sh
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:38 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGzne-0001NY-BS
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:33 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2b0afa0210bso42655815ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211129; x=1777815929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6nFkQ6KIlNZ8kekfBTy8MBT9tZYGdlcL2ADdOiZc9I=;
 b=wR5nZyG+zXlCj4BgeRgYoB5pE8+GzvC4wMS0Y/HPiC6x5mM86A1rCvDgvKkErH23dP
 bsY1w/gvSzsaB4cLJgVkLsE9EGBpBNiJQOiwdPOsgHHQrrVYPCpNGz+LL1asZi4hvNhD
 U/FBTEAWUEfg4hLhpch1CC7RiJ02FQYv4ZRg3oK4cLkQq+0RbtxKq24rukmyIxvGxpXO
 CCaePIiEquLbg9B4eo8bcSdlDrsjP/XHWDzlBPG1VCjN6O0RMGyQkRR0Pri44B1g8pnV
 DkkL+960Ao4yBLT5l87Dv75bm65xTfSxAvi1vKZTxWZ4UiQ1yWFt7vfc7OFbfbluhD2G
 2bCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211129; x=1777815929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R6nFkQ6KIlNZ8kekfBTy8MBT9tZYGdlcL2ADdOiZc9I=;
 b=XYKp9MQ5/AqItjg+2Po0JxYkGO66+hKyGY6Uf9aV91crAbFp2g5yzZsvCcVK5SsP1f
 p2Hwk45a8EMZoZ8UMm+frXGN9mNWXw9VwxlPJm3nZ+ur2M6K2zh3Hs6AXmS2C7ES/nkM
 iANC4VzPF4xsWJQ6vqSRd+qQJxP+kFgzNZABCmoxo6iavplrB1+LCvKKrLrxIkK/0phu
 vqNq0TbSfG7CFwJYBvx62/IHn+ZAP6PZ6RDALSj6TRM8//tcE8kSPZIvbP8KAVdeZKEW
 yCmWgOqNMFbB9wRgJmKRWrRpBY6avFY9pg1F1R5tt6QCY7v/HtCW1NZ/g43nVFedhzkK
 p5tQ==
X-Gm-Message-State: AOJu0Yz8cmRIGmUJK5gcqOi9YarNoGHWC4hfq6aIVCkGPFJCJp2eEQpn
 nvMGh9tOy3En7x6Ph1UpUZKghHqWvv/h1AQKFlyfIFy9m5+CVxjKalWL0xzxJBu0ryKGQhd0VuM
 mB2W9RKI=
X-Gm-Gg: AeBDiesvrZ5WVMzcd5MDCih8LeS/7lzIOg4Ts08AWGrIi6/aeE/QL1AcENApBg9Gzsa
 qSZrZYEazwmgcE5NTCkonX2BD6SNNMlnXeYTJilKwKv+wkwuhgrXN/MybcitYU6olqUJD1u19si
 jMDpksOziZro2NEiNbAbHffHUFtxdz2VE/nLei7DyGt6Ek4LJPe0hijqZYki5aG/N0SfXjQ99oW
 oiRF7AftR5nHjWHSDL0p3U/5RnNqfUgzPWdIzpPM4vQHTxgom2rTtc5uKpk0Eo1wx3Ls4TKbM01
 Ik3ndkUqSSZ9xePdE0KAwRn2MHeue7FGoG6NWBL47jBGPuDtuD4vAJ4wsW05dEr2sFYRYwx2Qne
 CtjEi5m1VPJsSWDTjfR+lxFGPfxoXIjJ/rvRPpqAMxIn0HYDtYaC4Vt2419+7C26Uw4qa9+0EBY
 Ywd4+nbzwx/4aKBRR7g7NjkLphorIVW5O2UfcP1Fn1
X-Received: by 2002:a17:903:3805:b0:2b0:6e6a:8504 with SMTP id
 d9443c01a7336-2b5f9f539ccmr421099585ad.27.1777211128956; 
 Sun, 26 Apr 2026 06:45:28 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:45:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 51/84] fpu: Inline float16_pack_raw into callers
Date: Sun, 26 Apr 2026 23:39:28 +1000
Message-ID: <20260426134002.865628-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 5269e5f977..8cfe7f8f4b 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -673,11 +673,6 @@ static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
     return ret;
 }
 
-static float16 QEMU_FLATTEN float16_pack_raw(const FloatParts64 *p)
-{
-    return make_float16(pack_raw64(p, &float16_params));
-}
-
 static bfloat16 QEMU_FLATTEN bfloat16_pack_raw(const FloatParts64 *p)
 {
     return pack_raw64(p, &bfloat16_params);
@@ -1480,7 +1475,7 @@ static float16 float16a_round_pack_canonical(FloatParts64 *p,
                                              const FloatFmt *params)
 {
     parts64_uncanon(p, s, params, false);
-    return float16_pack_raw(p);
+    return pack_raw64(p, &float16_params);
 }
 
 static float16 float16_round_pack_canonical(FloatParts64 *p,
@@ -2022,7 +2017,7 @@ float16_muladd_scalbn(float16 a, float16 b, float16 c,
     if ((flags & float_muladd_negate_result) && !is_nan(pr->cls)) {
         pr->sign ^= 1;
     }
-    return float16_pack_raw(pr);
+    return pack_raw64(pr, &float16_params);
 }
 
 float16 float16_muladd(float16 a, float16 b, float16 c,
@@ -4722,7 +4717,7 @@ float16 float16_default_nan(float_status *status)
 
     parts64_default_nan(&p, status);
     p.frac >>= float16_params.frac_shift;
-    return float16_pack_raw(&p);
+    return pack_raw64(&p, &float16_params);
 }
 
 float32 float32_default_nan(float_status *status)
@@ -4772,7 +4767,7 @@ float16 float16_silence_nan(float16 a, float_status *status)
     p.frac <<= float16_params.frac_shift;
     parts64_silence_nan(&p, status);
     p.frac >>= float16_params.frac_shift;
-    return float16_pack_raw(&p);
+    return pack_raw64(&p, &float16_params);
 }
 
 float32 float32_silence_nan(float32 a, float_status *status)
-- 
2.43.0


