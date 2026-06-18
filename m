Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3707ACD98F6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 16:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waFgP-0006kb-GE; Thu, 18 Jun 2026 12:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1waFg5-0006eX-AR
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:33:17 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1waFg3-0006NE-PS
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:33:17 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-46066e640easo756046f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 09:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781800394; x=1782405194; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4a+8aPCTN0sYynZsFAHEe+whp+fkeVx0KadfV1ixOEc=;
 b=dB5Wynre4ZakszK6d2wAeFMJq8pqetA6WDFgC06mCbgrMsSoOxKF4SeZdAV2/VRg+7
 pnMFoQDY+bxkV5T2v7akx5z5D820PNdvEMMkmFFQvrsw7nJQAPW3KSFP1zlZMPY2javC
 W3bTA2nOFOW+SW850zriKol8G5OTBAts+SS5N6ktXyhakY8KIm6c8ynz6HXrRq0KYdwe
 LQc8AZym5t4XOcH9miBUEf3ukVar/nOpx9AWafbOBdPRl6LEVtbzOinphtJ9tLscuXQ/
 45VbVK4DEYnrfdIGfZlv86z6+dA2BDeLQ6597GI5Lmh8b2jG9MW+uNIzK2NfGPdoR+io
 EIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781800394; x=1782405194;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4a+8aPCTN0sYynZsFAHEe+whp+fkeVx0KadfV1ixOEc=;
 b=PjU6AFc6Eny/x0czNnFPmwpC6YHiAuymfcN4k13n9y8OXrwpvqYTPg6BA1pNJLZ8Gs
 GIhiRnGx2onF1krea8OE0d5Op4Sg+xGi6EH7MrPYFeVM7g4IVrwCyBZ+EQWKHCBsSw6l
 vs6MCnnT44CvgiPf0HvGi2ytfyW28l+oYzi2mmBRByIBqRqirFyhlu6GBfUgwLEJiso1
 2LXen4pqwBNuxjicaAodP0ftWuX/L3gLfPUCYrMfGKrBunf8dL1q2kjCPm1zGTTGnh6r
 A4zVNov2313aN5zfzvt0kuKrTPgj0620BEzDTsyzJcWWFqZ+L96HjLM4ELPB7zmrIa7k
 VLmQ==
X-Gm-Message-State: AOJu0YwrdfvqNlgAhclU7VN7FVehqpDMyyxDUK7V/XvhrZnLwD87xmzY
 jQQ414hlx8STKa0RCi8yJJaZdHkHDwVcPCzUdXkyc8OHyOAIPJ6UnahjShorPIy4hdA=
X-Gm-Gg: AfdE7cnFkKMl0nkt0Qky4bx6IAlccAGpgyH8e2W8tmvWZIaVKIRxYesiDtCzSz9+Ydp
 mh6GR4VlxB9/kWt45AZkcWVmqtRdwHMp6qv1WFXKbF7DoNP8LPgK5qvJMby3E1B28KWMUZwNReJ
 b3jWZ7F4OQwR4QZzTXfrGWyTbIaLELpOGm/yrV7t5+yqbpOMvnfifS1tpoZNLqrcjnU1MsPeX5R
 AEoGQ9Uu3y0MAbUDw+BGkx7R2n6Ea3+Ta0V8fKxyxrfw1lnb9hjVObf76QcQIHEUGC8UHaIDlOL
 XZ8Qnve4BOfJS7QZiDzZBfRCun1QflUB0fAN+QtyMA+u0bw/kr4bC764fpAdhPW4hZDxt9n0mMn
 rYpMpHrA3vZ8NWqxJTfly/fU4cSRwsHAhJIRuCQHmZ/8b2ZeF+Kquw0vxFwQftgh8cHbQ7xP1hL
 blbDAC1QpBQ+QT+Q==
X-Received: by 2002:a05:6000:2209:b0:460:1a36:deac with SMTP id
 ffacd0b85a97d-4650978665amr100939f8f.24.1781800394188; 
 Thu, 18 Jun 2026 09:33:14 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:b52:6a9:569d:e33e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4650bc426e1sm26942f8f.29.2026.06.18.09.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 09:33:13 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Thu, 18 Jun 2026 17:33:07 +0100
Subject: [PATCH v3 4/6] target/arm/cpu-features.h: x-rme now means GPC3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-jmac-gpc3b-v3-4-353e546067e7@linaro.org>
References: <20260618-jmac-gpc3b-v3-0-353e546067e7@linaro.org>
In-Reply-To: <20260618-jmac-gpc3b-v3-0-353e546067e7@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x435.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/tcg/cpu64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index f7a920a202..75c2027900 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -159,8 +159,8 @@ static void cpu_arm_set_rme(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
-    /* Enable FEAT_RME_GPC2 */
-    FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, RME, value ? 2 : 0);
+    /* Enable FEAT_RME_GPC3 */
+    FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, RME, value ? 3 : 0);
 }
 
 static void cpu_max_set_l0gptsz(Object *obj, Visitor *v, const char *name,

-- 
2.43.0


