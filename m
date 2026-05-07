Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EACCD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 16:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL1EH-0004Th-GC; Thu, 07 May 2026 12:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1EF-0004TA-Go
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:35 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL1E3-0006k5-5t
 for qemu-devel@nongnu.org; Thu, 07 May 2026 12:05:25 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7de4ed0593fso518273a34.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 09:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169922; x=1778774722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8PrlanBakDW1aJjxZgN4Ch42cudiBjZCS7+sWrmaubM=;
 b=X1kldZWstm8ZhLX7DhdjwlvbLNKY5GJ6uCfuWpzas+82po7fsP/AsFvzlV5HNrTumb
 KKREnlJSt99TXGqve+G5jnT36mLLFoEpGwiFfjiHAQl0mdu5QqubN4d65cNQPGBQRoR7
 41bmbvgEVBFgLEGVthxjkKfi/N5u1DZYOaOkc7yyypDmv0s3+8HnfgLwvb2kae+rh/9/
 K5Okq/r565Edh/ZikKXV3pR+vE/MfT+MIPutojgEOldFLp7AjfjrPep1pxGmPELxTr/V
 wXFpF9Qyzmkc+Jp08ZeZ9JTi3HjHFjvP73US8cMCr4KR3OBH/8DV6+5a7L3IOagsTKbX
 bkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169922; x=1778774722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8PrlanBakDW1aJjxZgN4Ch42cudiBjZCS7+sWrmaubM=;
 b=D3hYsE5U9kg3IBs1p9ekNPYSwqUkrEGch/1loYHrznvZs07SBuOh3onZcpQxNK8IZf
 bZwALPKQYaslzzqw9j5GRJLBUOfZczYzUCKCmBmC0rkk/3UR54fbhW4CbhiuwUULcKCB
 jL33xYkoIcqIL4BOdoCZQ4KbRc5IfiJvInM+cuJ+fHoKguLt54fS3sfUAIJCIZr2voqn
 3O98AQFqJItdF1042crMlJuB8CR7b2joYH+QFyOihla4Lt+OMcmZoidOjGUvG9ttUlfL
 uWes069T2ZAKiDYwQDaOvOEIB3TJIDaSHiTM9GrgWuK7Y4lM26aYcde9mllo9aAbzb2c
 1DBg==
X-Gm-Message-State: AOJu0YwybnQAVQb7niaZQf7ZiokBv8CKuWDjrzNCFW4OZuU91Y9ZGYrh
 yINrMsG3Hezfbyjf4j1Xv587BKPg9WpL4LUdEJC/CvUAgmAegfoDfwrqQauRdIFMLTFyZdiX3Y/
 I6+ee
X-Gm-Gg: AeBDiesCOpWqYbWhGkB6PhVr8qUaRe3WyHRNpsiLKsAVynAjpC+GS+HJCBAFedmEOcz
 r+LfBwWy96uvJNKetv4UAprpgHczWn8k0UaxtPiWaUA+mgZt4XP9ve56VfudPaqJs8aszJI4vN8
 cuIzCVZbhCwAwRHFz29/z/9ETFIhDdzZu20u9kki3tmiFDnHvidktRCWi3TstlYEfY2dWhVz3Da
 FyvfYHCWZ8aH7l4QTNuMR9S9mPml7s1U8RW9tMgTPnT+oiHaKlM4BeGH2gdczKewJHNtCz6RNW8
 yH0wbEJsSanJTYI5C3Fd2A0R1N7hvzqbJ/YtM2avap7JqqRo4TPxNIVE5QSdn2HV5BH/ibSC474
 dD+hKGoSXiIfsPLLpAjxyonKI3hsxVm4wgIZpRWPtT5QwJ8ROsnjMaaLDMifpbdClu0KPPGl8cb
 lSsWyObSixjfDL+EycFZTKJdrQwA/OoZhIlNOJRIduT0q62FPAJGNLzb5g
X-Received: by 2002:a05:6830:2b29:b0:7de:c6b8:2349 with SMTP id
 46e09a7af769-7e1defe86abmr4865105a34.14.1778169921640; 
 Thu, 07 May 2026 09:05:21 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decae680bdsm14647398a34.27.2026.05.07.09.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 09:05:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/29] fpu: Inline float8_e4m3_pack_raw to single caller
Date: Thu,  7 May 2026 11:04:49 -0500
Message-ID: <20260507160518.444797-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507160518.444797-1-richard.henderson@linaro.org>
References: <20260507160518.444797-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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
 fpu/softfloat.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 5d58caf5ea..18f2ca900f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -673,11 +673,6 @@ static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
     return ret;
 }
 
-static float8_e4m3 QEMU_FLATTEN float8_e4m3_pack_raw(const FloatParts64 *p)
-{
-    return pack_raw64(p, &float8_e4m3_params);
-}
-
 static float8_e5m2 QEMU_FLATTEN float8_e5m2_pack_raw(const FloatParts64 *p)
 {
     return pack_raw64(p, &float8_e5m2_params);
@@ -1474,7 +1469,7 @@ static float8_e4m3 float8_e4m3_round_pack_canonical(FloatParts64 *p,
                                                     bool saturate)
 {
     parts64_uncanon(p, s, &float8_e4m3_params, saturate);
-    return float8_e4m3_pack_raw(p);
+    return pack_raw64(p, &float8_e4m3_params);
 }
 
 static float8_e5m2 float8_e5m2_round_pack_canonical(FloatParts64 *p,
-- 
2.43.0


