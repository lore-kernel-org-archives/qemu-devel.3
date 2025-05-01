Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B0EC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYkU-0004xO-55; Thu, 01 May 2025 14:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uAYkP-0004ui-VU; Thu, 01 May 2025 14:35:01 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uAYkN-0007W0-QH; Thu, 01 May 2025 14:35:01 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e5c7d6b96fso2220885a12.3; 
 Thu, 01 May 2025 11:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746124497; x=1746729297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RqUBQMIDvrWdaGrAbnq5K23B7hGYiXftBrPor930Aiw=;
 b=LuYvAbicz8iX8UuSzYp9fKmPdcwc1o7QN2nK8wRTiCjOCA59tQfOJgeU7cXU963/3B
 NwGKV3u0iol60yK4GL9/h0bZQT4ZKZ/MLb8xTbKxDRNK8bzEiNmqDbvipibCsTNpQqtc
 sZj0QGFiv3D+t0+BNKmuPgaZprg7qBh0R/67AjwcYZ+0KIhjl5fWs2iNByszyHn6+MWb
 POhjaETgq+LhSFHnrfYLxsjfqU8p9W2vmKQ34PtmARZAz2HNUWCrLbpOBcw7CnRKqLVt
 oMlueYXGROZCPX3lXuMWYYEpshjyEJIF6qQ8v466mUH6Bi+ERESnChTEIpXdw5BcZ5Vk
 UDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746124497; x=1746729297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RqUBQMIDvrWdaGrAbnq5K23B7hGYiXftBrPor930Aiw=;
 b=pPmGnYrNrYchWY9bZnR5bqcMCALTe3YetRSdlAmPiEFZpF9CR9ZRZyIxLxByfUZwqC
 im0/L6yVvLPxfqyR+h2qKbEDTG5uOLug/z4ewwlabM/Pe5JipTpOm8BZ2k0ZffxIPVq/
 Ubja/bomLJ7l0hK/xo0r5WtCGdF4RkVPSER0wQi4GXfUpLVhHy1eEOrUdS+UrBxoPyQd
 z+C+aDOaRHWHa95irIxVkQMpxySOu1j5iLuhSk+FrtuiiGEiHRnBElmg9OZ0EVuTPT76
 lJwn1v+If9ktwFbjNcJRDC6hAxxHKE0uxEmSwkc6zn6fQmlRboWxN5t1KNhXbUCvHbRq
 WVZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCAmhnKLCIFVXeZX5lfZiCTPLo1CKSjgsLcOi9dKoVobsJZIoZbbrOkaXqHBmjK1Az96dmhCAahg==@nongnu.org
X-Gm-Message-State: AOJu0YwbloDwPFSwl3aGtNK1Y/54T8OZI8FqMZ6lNMIZBbB6CKIgPdHM
 eNu9XIxIQrV6bl0g55HXXcYx5tTsZZyI62xwkXqpOhr0IXAueoManxGKrg==
X-Gm-Gg: ASbGncs8tM7LXwAiE0zR7tekBoA6kp/UYltPixEoANGeFi/ayn+GkLwoWA6Ur5FUuM7
 gFYp/BlUXa2eRM/dYykRJT0gzZM/hikPJsKNycOJjmxYhXdHwGCkQEli/pzb+pUvMZrkxpLChyQ
 wa/ZrgZT5pm2rEGikDL7fg9QSYzvxWc6JiKRpj2i4oGNxWbbQ7aORX8FQm7kesIXso6uMQPvOjh
 eqy/REwgMPHmx+0f2yXPS73GHt2zxtqdvCTeNx8tIeAoXMLry9SPS/rKJzwejL6XnVGq3JGehtn
 zT2f3ioo0elAp3L5DLE81U2wmDHjP5Uzhx2LAr9tQYOgx5quWZyc57vpglLnceSua6I3e++Ci3U
 u5vfe5oCrgtph6ZzZ5+bai2nQrz4tgg29HV/+hHVZNFTF+rus7hIIcU9DJ+3HgQ==
X-Google-Smtp-Source: AGHT+IF6luuiAmX/di/fru9iCSnBFuHBGw4XpbeWQWJCKLyNDt+ct5hz4TlaiFO3IkhNcl8wBY5/zQ==
X-Received: by 2002:a05:6402:2753:b0:5ec:cd52:27c9 with SMTP id
 4fb4d7f45d1cf-5f91944d7demr2773168a12.31.1746124497327; 
 Thu, 01 May 2025 11:34:57 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-2980-eb00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2980:eb00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f93000b272sm751709a12.68.2025.05.01.11.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 11:34:56 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 3/3] hw/gpio/imx_gpio: Fix interpretation of GDIR polarity
Date: Thu,  1 May 2025 20:34:45 +0200
Message-ID: <20250501183445.2389-4-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250501183445.2389-1-shentey@gmail.com>
References: <20250501183445.2389-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

According to the i.MX 8M Plus reference manual, a GPIO pin is configured as an
output when the corresponding bit in the GDIR register is set. The function
imx_gpio_set_int_line() is intended to be a no-op if the pin is configured as an
output, returning early in such cases. However, it inverts the condition. Fix
this by returning early when the bit is set.

Fixes: f44272809779 ("i.MX: Add GPIO device")
cc: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/gpio/imx_gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
index f23c52af26..450ece4548 100644
--- a/hw/gpio/imx_gpio.c
+++ b/hw/gpio/imx_gpio.c
@@ -72,7 +72,7 @@ static void imx_gpio_update_int(IMXGPIOState *s)
 static void imx_gpio_set_int_line(IMXGPIOState *s, int line, IMXGPIOLevel level)
 {
     /* if this signal isn't configured as an input signal, nothing to do */
-    if (!extract32(s->gdir, line, 1)) {
+    if (extract32(s->gdir, line, 1)) {
         return;
     }
 
-- 
2.49.0


