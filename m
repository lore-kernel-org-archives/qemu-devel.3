Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A103ECD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShGN-0005Ty-Ow; Thu, 28 May 2026 16:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShGD-0005Pq-8c
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:23:22 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShGB-0004NI-P7
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:23:21 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso115039895e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999798; x=1780604598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NCrNsYdpQ4POaRbQCB6mOx3g/coWeirmwIs30Ac2Ibg=;
 b=vj8zBRtU/5kS8MxEdVRjGZZfZJT5mLgIdWluqbN2PfPrUrit5C2is5F20FX+qEUkhC
 i+4/bhI/RFF/XOrI8ghSmwOay+dk/LY0JQ2AQgam1CAR1CVxgZECdBR0Qhe5bu/0FzOg
 Ckv9vwVKLG3x0wfy6V6WKgo4Qk32x+AZ/WELJ0Wl8rWQo2BbtRM1B5nbUG+/BsGhO1B0
 720qVC5r4yCuRM1oVpisa2T8Cw1rTV1r6r7zFmO3JBSd9rC5jFumOrn+OHYv62eaP8dY
 4rUTwo+INTTAYd8lvVDuN2MeissVVZrLOXZ5CJ1u7avFMynmYPcsY1/hSloJn1P4jKna
 zBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999798; x=1780604598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NCrNsYdpQ4POaRbQCB6mOx3g/coWeirmwIs30Ac2Ibg=;
 b=gILUybpVD4UR4EUMF7bKTThf3PUz9/ANZba15qcMJNt/wg/lOPTUNv9uX0WtVvXn3p
 ZYOwjKA7xXP53sugmsMcgFraBUl1s/bH98V4PSNod8R1yL4B6xowFS9brVdH5fQ/zkKN
 mlGaWcI2XFjS173gSFl0pC088mnwuIPB9DAmjfPwW9S4y3jCf3+aEK10awoWG+QNS+FA
 OiPWV0xj+md7JcDD1TxYuO49AONvCrG/ff92Jm+4TxFjaUHmMzTc08XlklU+VGtwUfNS
 i+AsjGbf/h1M0pHlgRD0RnBE0vqFxATq67qLQjZVt/19FFJp/NvsLJ7A6WmFfJezXqi2
 1zwA==
X-Gm-Message-State: AOJu0Yx/2v3mGtUremxdec9Y6eZQkotpRyEj2lYLbrlQtdtgIeSirybe
 UagabG15rGiSsT9L86NiRsWwCEQdfZdTgWXMCFfiORy53ZwvGfnYCQ+FZ9/8CNDrTPN9M4iekok
 EnswezNy9LQ==
X-Gm-Gg: Acq92OE5rq0yFMeiLwmIfKqy5ms3hIIQT1v4+SM0Z+DmOxlCSWXGdj5sd+dXjt3xoMx
 4vb/ODyHl1YGbZCLKM3IbWdu8nQPgCkLsc379Zf+J0brjsDR2dgXqP4TlJjON8cAcyX80Ekjeuz
 ov3/AKeH5A7AMXX7s4sPO6RUynnUhliN82uOOyDBWOjhoPt0fShefyHKEIcSHmEKHc5nv+iRLqg
 vUULs3P9K+7GlM+YIWzlobq6aCKPAbgT4PMN0Yj8uNNrWmDP+QcIF14f+1w0oQkkz7WDWALjTlt
 65E3b97tOE9bXaATzO4usL+k8zZgHxOv3myVdEPKj9WRGwbNHldi3+m4mTg/PKTqctGGQIm045v
 dXlklzhNzduDyNQ7YMUrZzxHgljpvNNYpSH25ausM81/3w4mcz3bw98EKwhUPgZzO9cQDfoM0s2
 /pW+MZO+d3h7RT+efCCMWCeZGNGbc7bluZi27meQTv4Q+5OS0PRUzpjBWtyDYeUP4ISA==
X-Received: by 2002:a05:600c:630f:b0:490:3c94:a3c6 with SMTP id
 5b1f17b1804b1-4909c0b6cc2mr487085e9.26.1779999797965; 
 Thu, 28 May 2026 13:23:17 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c09adedsm140105e9.2.2026.05.28.13.23.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:23:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/22] monitor: fix missing spaces in screendump help text
Date: Thu, 28 May 2026 22:22:33 +0200
Message-ID: <20260528202253.49122-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Knutsson Development <development@knutsson.it>

Signed-off-by: Knutsson Development <development@knutsson.it>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260410151818.817298-1-development@knutsson.it>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hmp-commands.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index c3a1a95c5fb..0d780e6da30 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -271,8 +271,8 @@ ERST
         .name       = "screendump",
         .args_type  = "filename:F,format:-fs,device:s?,head:i?",
         .params     = "filename [-f format] [device [head]]",
-        .help       = "save screen from head 'head' of display device 'device'"
-                      "in specified format 'format' as image 'filename'."
+        .help       = "save screen from head 'head' of display device 'device' "
+                      "in specified format 'format' as image 'filename'. "
                       "Currently only 'png' and 'ppm' formats are supported.",
          .cmd        = hmp_screendump,
         .coroutine  = true,
-- 
2.53.0


