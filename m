Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E38DCD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1EM-0004Vu-0z; Thu, 07 May 2026 12:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EJ-0004VA-At
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:39 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1E9-0006ke-8J
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:39 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dbcb467f2bso920114a34.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169924; x=1778774724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uoINppTE/iumvn6oOKs4PlHUC4MYd9J7dJvuG0sU9XI=;
 b=Est4aa8mb62xQQIX059VVuvpfb6u5jYOzKl1f/Z0RvDKFpJ43CVFCA7QYjTONJ97Yo
 hHonHjQR0yPSdgx63hj9gCtYpErHmumMLxoeRKgmSDGkfi14HkyhKPzxjNHhB7TTsZLD
 fUFFKXKYnyV3HJl6pKcVlHSC6Yz1wTRRgLBPqFVN/0lOM/ifHVLcQxlQvoxFndzDdokq
 GEkyS7NCqJ4rJicIkZ2I587/SkPH+uY6YKQhU8MwQMKs5WbnW3vg+kUbPGnM0jyU02Hr
 dm7xjzRO3nOMEqly+8YZXxkaY/EbuP0WgvVWIvCfA4z95S+w7b7cCgPC7SfY5VEbKtSQ
 PFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169924; x=1778774724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uoINppTE/iumvn6oOKs4PlHUC4MYd9J7dJvuG0sU9XI=;
 b=Y+2Dqp15ZMqcvhz4ApuMXucz3/aGyPs7+zpJ3/Vu/npxx7CdPkBJt183Zn6ib5ZL7n
 wvV9M+IYZWNkPsytNioAUosuooD7rL+6ceTKnyiCM3DGvbriQKLqjPyHPUKqDmW2cs3m
 6t92IWUMxefl3kT4MWN2yw7KDRAmciZpgUnQNdXDzUcn9VPE8F1x2sBBxk3h+zAoeW43
 GBWVcHvjb311UQG4MiLQ2oq8gu/PDailN7xmYOpq2I+xIAHm31ETqa4OzFiu6vzqJUns
 5nMEEqz/baVNOHFs0zCi1ELu21d2YGgC8il1lqWBtOG7M3ddhyMriEdipxTO1uDuWrfB
 MKrw==
X-Gm-Message-State: AOJu0YxCD8nb+7ap0ZqTzGSRNDQDz6iuPXT2BigdwPUeT2Cot/7nObVl
 NqViU475KZxjJbwKFLgqFRhoXj81inXUsLyk8fKuxnFYyWgnU0VYOtjg3aYG8Df43T7+3eHOqPT
 87x3c
X-Gm-Gg: AeBDieu2WQg2zHjYyp3WoeRGii+h+CYFVEf4gyN+TB4R5X4AOblvsCM0PT7/6mSe7Nu
 6eouhQlUbBONqqgzpBXYFF9IKAXHxhFyS6QBcGMHt3sbIpsTsvLgBLRbtIyy12YylkEmAjIk2Wu
 g8pSsULYs+HZbKhUWl6ZmAAoEKysTjM4LvtikJR6r8dyannQieaxGEGMXhhPrOY9RCuXZZ18KjY
 ktx5acsAIDIOcWJOuw10iP5n0iKDVKffvOPXLpSQcjn/j4vcLZPgtHWpsyyt6m7QSDffGfsuPKF
 /S9QFQ5f1PrVHZpsnztALEUeXbwpbrIQB8Gp1GyxuOCjQBxqMWVvVlE7cJ2lxj8uLqgQvuSPCh7
 FHhrQPZybayr6AmgxvI2IzeNdt0rjrK7H5WOQ5cVywIWMwwgzNXAy+OC7p51hbfaz0NLiq9f4Gx
 D415uZnFWG1TGx9Uw3azvEsE1ciMdatO9/81CTNMA/p65B9fsD6dJtzABi
X-Received: by 2002:a05:6830:4981:b0:7d7:4fc9:5204 with SMTP id
 46e09a7af769-7e1deec7181mr5608979a34.2.1778169924239; 
 Thu, 07 May 2026 09:05:24 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/29] fpu: Inline float16_pack_raw into callers
Date: Thu,  7 May 2026 11:04:51 -0500
Message-ID: <20260507160518.444797-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


