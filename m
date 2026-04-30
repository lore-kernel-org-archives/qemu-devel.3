Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F0CCCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEwQ-000242-Gk; Wed, 29 Apr 2026 20:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvJ-000808-Hf
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:39 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvH-0001uA-JI
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:33 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso98005a12.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507590; x=1778112390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0UzcxTTvEsTE79pjxq8kUABoPISr81drtrWFClL7oT0=;
 b=mWtFQ+INa7GD62s2jjCkKCnTiEzekgCND1TIM6PoccVoxyyBXvC3fnJdW3lsfH98ng
 vnwDKe0CzEoqcKaXdzaSWDV+puOVB16OKCSS2vPimR0iZxmsDwQxbuztc0S4pepFyL0c
 E1siWwaWwylc0279wsnyIEpPa4BVGpeX4B1Mjziw0wjoInLRZ/YqUwaYxtEY1hglBkLR
 6fXlQ3nkTtFTJnVEdKslDWeOT558gdjWFtGS36UmkWJB0Hb41wRB+BHOq5v8efbBhdOp
 vcEoo1iWsr1oIcApnZn192dkP622LhFIzMcYIHEZ4e3aN9MiMe2iJoleal6rTLiMt2S+
 zeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507590; x=1778112390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0UzcxTTvEsTE79pjxq8kUABoPISr81drtrWFClL7oT0=;
 b=E6YwN5wJBh8VZGkJa/kcvOK9tHo+0QJWGTnTXl4Rt+AgKpnBtvmsPpP8RZEQ977KMY
 BB2+cgV30kVSsBOT1bcCoqcKku6HSCeTzl0Tsf+LpkYKjnRQJ1whwbZeC0Zx+aYE6aoE
 QwNMyZhsopf07yaBb/xEg19VtUmB7GV8dYTjLyW5aHmm34Ryh9QtZ3m6xtrtNZjxYCVX
 2tdlMwpO11h5mFoJNynaa/v2g/YIG6Cwsn84TjLYN8aitQs2uOZmHkz1cmrpGoabdfGH
 xM4W19XQ8oxi4s3yAGGBf9mOAI51yVxp1IYbe2vQxKsJrrtK7Xi1hO34YkmWNlXZHWr+
 1cig==
X-Gm-Message-State: AOJu0Yw+ayxSv/0JIAHpxV28yA4Ey/OXOfdc5wQYGq3VcdFHiwYgXsdo
 5pOpnWNXBOskHEpUuNEKHWgIL9g1vgj+a40rzhJsAcjPGkmsQeMRiqJ9iMaum3GtLwV8tlDhCG7
 C3rewetw=
X-Gm-Gg: AeBDiesLWwg6hE4IEL+YlsHV2pJSs5FEcVBVpb5mKFDwowaZ+C8kDuv19ZjDn7wErZI
 yqYDv8bQb9Ne0MklDyY3QnWAypql+9HKxGTGCqAyHzuIt3e9j/wBRCucOcDdKfevLkfyn8ZCnxx
 ELmL8fr9Tun9vSzUBU0nsDyqh45sdN+VQMxoFStRKcEjTo/WDftCAjL8OS0ECTNkZ51/q3NH8wa
 KeqtqsM3qLElbGwnNOcuyk65sEhlNPkTLPDSsuB0bFPvK76G1cMFiCuN5SLyKGmfGhUwlwacmxU
 6LXZnEHmi4OaCToAAE000Pmn/EeA5Em919p0AUpHFtHcW6S6NqHoKrv40lDNfoCxb2xtyN355yi
 gJYyKNGgrAx1qG8jCtUIAiispTdo6OxCPwgpVqayRlF25G8Uobgyp0iZdCQnX2HyCuHrIAxm78w
 1qvXUKUOLu80JfewI6ot46s8WULQi6VE0fKVo7dpR4
X-Received: by 2002:a05:6a00:23ca:b0:827:433c:ba7e with SMTP id
 d2e1a72fcca58-834fdd4198emr685585b3a.41.1777507590035; 
 Wed, 29 Apr 2026 17:06:30 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:06:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 27/40] fpu: Drop QEMU_FLATTEN from muladd routines
Date: Thu, 30 Apr 2026 10:05:10 +1000
Message-ID: <20260430000524.56046-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

The float16, bfloat16 and float128 paths are not so
important that they require forced optimization.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index c5a27e562f..c2450bc078 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1900,9 +1900,8 @@ floatx80_mul(floatx80 a, floatx80 b, float_status *status)
  * Fused multiply-add
  */
 
-float16 QEMU_FLATTEN
-float16_muladd_scalbn(float16 a, float16 b, float16 c,
-                      int scale, int flags, float_status *status)
+float16 float16_muladd_scalbn(float16 a, float16 b, float16 c,
+                              int scale, int flags, float_status *status)
 {
     FloatParts64 pa = float16_unpack_canonical(a, status);
     FloatParts64 pb = float16_unpack_canonical(b, status);
@@ -2126,8 +2125,8 @@ float64 float64r32_muladd(float64 a, float64 b, float64 c,
     return float64r32_pack_raw(&pr);
 }
 
-bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
-                                      int flags, float_status *status)
+bfloat16 bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
+                         int flags, float_status *status)
 {
     FloatParts64 pa = bfloat16_unpack_canonical(a, status);
     FloatParts64 pb = bfloat16_unpack_canonical(b, status);
@@ -2142,8 +2141,8 @@ bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
     return pack_raw64(&pr, &bfloat16_params);
 }
 
-float128 QEMU_FLATTEN float128_muladd(float128 a, float128 b, float128 c,
-                                      int flags, float_status *status)
+float128 float128_muladd(float128 a, float128 b, float128 c,
+                         int flags, float_status *status)
 {
     FloatParts128 pa = float128_unpack_canonical(a, status);
     FloatParts128 pb = float128_unpack_canonical(b, status);
-- 
2.43.0


