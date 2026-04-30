Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE327FF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEw0-0000iL-FC; Wed, 29 Apr 2026 20:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvN-00080P-4Y
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:39 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvK-0001vT-DN
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:35 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82f1f6103afso165005b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507592; x=1778112392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XQsQmqBug60W5wQ+I0sYpzrEPejG7N9ci3MFuR9QX14=;
 b=FEZtyX37tqBuKGxLQFQgtW/8QiqVDzAklh5ywrUpfTNZsB5y1UWt/uIdi8zN5JY4tG
 Zonu2qjpTSUhfmj1UOCcxeb67Ozs7gI+pwD91KzknO3lQHM0XN2SHXla4i/KqHErK85y
 2bRCsbpPQ35stsDsyCRJgU1GPgeDJkf6UVQNGEQDspC49/fyD64DTrJ/pAMQ36gC9Jpq
 TrZ6wVS/+aeUARbRwRFiEtY1wfvLLdPRHzII8m3g3Qoh3z/AsmfpwZf0Ck3VTcGsxnTQ
 sPJDOTgADdqXbo0V92kjA7s7mR1mpdcLLYAB1TGzdO5dds/l83bC7n+wicB/PUTCMCb7
 HE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507592; x=1778112392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XQsQmqBug60W5wQ+I0sYpzrEPejG7N9ci3MFuR9QX14=;
 b=e8jLtzikP/hi1wlEHSAtyd5JgWJy3M4Gai4HY7nA70Nz4mKwM0dU/5FKfK8Xl+o0Zw
 ODCEn70MPbOiOf6Of79+7gdbxfB6jVwAh8HG3j40uxvPB8SLA5UbZTKIa670bPAh5GMW
 MF5HcWUcEinPpAVWOBEE4lhIPyBxv7Fq200zcFntCxuDhFbXf1QAhyc96y5VJ1aXpJ0f
 4waB3kfktnm1qf0E0xqjnQ+GDkRCaZKmPast/fRTOFheUVS+0jlHoqAtyH7psnAHrsMM
 SpjEM2nykTD/1MEf9OyUtxozN0arN728CN3aqHIZLYHSnnjBWuSNb7wExgcbZf2L4lkl
 a+5g==
X-Gm-Message-State: AOJu0Yz41OVH44tF+AnfOBlfnDEDEQUvosFo2X+UB9pYifM1M1naY6HN
 D/tSNxfp/1Y+oJLfjE2B/5XIoVnhrVpajX5snAtag/CMPhFFi/NdbQe0TrWvhH4JmQoWEfKk5co
 xZoppU4Q=
X-Gm-Gg: AeBDietu38lNrZmbunDOOG4wMvVwmQShNonEFgJYYUme852LIoMZZgSDBxCqyW1bDZh
 3Ah7D4c/nPgvsWgP7IjUlTfJSuvn7HlbQEFoMIoaQddTr67cKbhC794OC7bNjuWYll6agk9KnLE
 ldAMeHj5NqPOHhhUbzw5Ya4wOhxDKElibgUX7Mt2KtQE0X5HGETDyDEd8KA/uogrsCowwKyBJsL
 tdl7EPGynVD2BCfZlAYi67paBfEb+Gbqhix7NEcP9SrU+f7l1Q70y/ShyMEq1Vg2vd3hx30Xoy5
 kLbVD7spt9eP+v7YbfF/XChg7kJnP+El0jTTkKD6Wgx2TZmn3uZdlir2DNHPiBIHWZXsXsInamb
 /27rfaBzzbA83dcDMFhQQE61ZZ+euBZlUmdW9CzOYRuYYoP0d7jOHSwIsG94r65uceM2al36EQf
 qpfso7fHuoVu9z6tCRxV8J6cyqqNO/mmiOrJEHfO0L
X-Received: by 2002:a05:6a00:3026:b0:82f:401f:2db7 with SMTP id
 d2e1a72fcca58-834fdb03ba1mr763131b3a.9.1777507592382; 
 Wed, 29 Apr 2026 17:06:32 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:06:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 28/40] fpu: Export parts{64,128}_compare
Date: Thu, 30 Apr 2026 10:05:11 +1000
Message-ID: <20260430000524.56046-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

At the same time, constify the inputs.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-parts.h | 5 +++++
 fpu/softfloat-parts.c.inc     | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/fpu/softfloat-parts.h b/include/fpu/softfloat-parts.h
index d54bd6bf62..3183c158eb 100644
--- a/include/fpu/softfloat-parts.h
+++ b/include/fpu/softfloat-parts.h
@@ -182,6 +182,11 @@ FloatParts128 parts128_return_nan(const FloatParts128 *a, float_status *s);
  * Operations
  */
 
+FloatRelation parts64_compare(const FloatParts64 *a, const FloatParts64 *b,
+                              float_status *s, bool quiet);
+FloatRelation parts128_compare(const FloatParts128 *a, const FloatParts128 *b,
+                               float_status *s, bool quiet);
+
 FloatParts64 parts64_div(const FloatParts64 *a, const FloatParts64 *b,
                          float_status *s);
 FloatParts128 parts128_div(const FloatParts128 *a, const FloatParts128 *b,
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 09b79f8d44..dfc0a22d98 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1554,8 +1554,8 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
 /*
  * Floating point compare
  */
-static FloatRelation partsN(compare)(FloatPartsN *a, FloatPartsN *b,
-                                     float_status *s, bool is_quiet)
+FloatRelation partsN(compare)(const FloatPartsN *a, const FloatPartsN *b,
+                              float_status *s, bool is_quiet)
 {
     int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
 
-- 
2.43.0


