Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DCCFEFB53
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 13:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvyLw-0006GK-Vm; Fri, 27 Feb 2026 08:58:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvyLi-0006A6-DE
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:57:47 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvyLf-0007V6-Oy
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:57:45 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4399dd8d7b3so646964f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 05:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772200662; x=1772805462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GtW5nIwjsUl0K9zrg6YDJidQv+NEIvOZPyQaRuLPPXs=;
 b=CUYpBT98EHQF8CWI2TaqeTG53+GC2ubxAEaY0/6AATNNsVqgzGqqq+BqLK7aTuTO+0
 AqtEZ/DH80pIBWIyPdyseog26n68XniEgdeQZYN8CC+vCoLSp0pNBeJk11DKYz1GvE2X
 Rrex1nwURAhfTv3C3C3BuDRKWc291dvA+wknlK+jgZngN4HMQhKpVI/9cC7rALnM9gTq
 11uv56NqUkZjebmYfbHRw7lIcdkbcmD1rd75Bx8YCytgPvdMR2seD7ayPZNhktyUwYCn
 21e78TFp5lEtmv6WsvMiatq0Vkc5rvdLvfYwL0gt8ZR4fIgpNP+Zsg/nrSoyOTW130fu
 pJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772200662; x=1772805462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GtW5nIwjsUl0K9zrg6YDJidQv+NEIvOZPyQaRuLPPXs=;
 b=I3Z1ZjAuoDhKayLHZd0VNGeWGi3YeAgmHhMYtX2FK2oHWlNHVdeucv5rv1JGguHajt
 6FkRAqL4909VCDU7GMvyI4gyeWfGUMAWIBMXzDU60H218GkZE6BjY2gaNoODCP+z+I+Z
 Tf65rWgrm8fzh3sewMUt1L2daGp9FnLusSi54GoauQs2HlV97SOcoXz5z4rO2VVZp4ZL
 1PWgA0HZCQMsYhiWnDXV9PUiXK79JJcGgtr+J5pARw239HYcaWvwgfmGp1xUN+Ms82pQ
 HRgTLdkff2OgB7PtNz1Lj5UuTXjA2LjFg7qiDx0xR1eFWJa/AjqO5f5w/zJ4XmAsfwCI
 PzXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVsp7FXXvG1Hyg+270Or+70PdizlRB9IKYnk5tkEpso0OPOglr9VkxJMwYw+bq6taYWGIwEf+OOV8d@nongnu.org
X-Gm-Message-State: AOJu0YziqRJNg7Um05WtCkJQFhF9QGZV3BqQ6AzzBG/HITc9iLn6xXpT
 ScMxi1uLh7U1yDqfY5n9pxShCi+zD7eG+cyrOr1NJ0bsCZGbnIjGPAei3Cl19wzYYvJfKzVk/rL
 8Frdg
X-Gm-Gg: ATEYQzzfcoQ9kJy5mGGHbwV9ydjNlXkwtZUz++QMO1hd4lQQt4sK8Pznvig+0ihUX55
 dbWwJ8aDePVFfeSvAHE2TpnQ/ZIkMFI4tk4t0LTnZrMQBjk1LgI71MCHbmfJ+32SxDMzVgNRpUM
 ss2tvPQRrLD6ihiLAoekyNLo3m10OvXRAojebIB6/bDr/P2PvSj7ZvkRWCphsLKosWfCh4bRyvO
 UnHuv9c9dAxOJOGkEtNyvqIH50m4AygbZVuUiGQIsBEW2nMiFveB5qQckgauK5ehA1Pa89prgnp
 H1XW1dSbfMFouzVlhMxyyctTrTrEFNN6UwoXJbwLmSH2buX88mn3Qv4sF+upXhihtm/ICI0vBnV
 hQqtH8P+lrLdI2HNXYqw1h0RFIjQU0OcKId9y/PBHTnnk1jRGmVNt72Hke5Uk+zn1n8sL7bXDoq
 bRuAybh0evERTeEcL7UBxtfm3WuuxfhCvBaZnp4i3g86F08b7cNNwh8ISqCZpyPZ5YA3I4QsMaY
 m3rXHCRikrbVzCEvJQdlsDg1T3lcQw=
X-Received: by 2002:a05:6000:1846:b0:430:f593:aa34 with SMTP id
 ffacd0b85a97d-439971f152cmr13395657f8f.17.1772200661506; 
 Fri, 27 Feb 2026 05:57:41 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b327sm7655163f8f.20.2026.02.27.05.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 05:57:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 3/4] hw/arm/aspeed_gpio: Don't leak string in
 aspeed_gpio_init()
Date: Fri, 27 Feb 2026 13:57:35 +0000
Message-ID: <20260227135736.2280161-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227135736.2280161-1-peter.maydell@linaro.org>
References: <20260227135736.2280161-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

We allocate the string for the GPIO property name, but never free it.
Use g_autofree to avoid this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/gpio/aspeed_gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index d9237d4360..7d0f87e90c 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -1488,7 +1488,7 @@ static void aspeed_gpio_init(Object *obj)
     }
 
     for (int i = 0; i < agc->nr_gpio_sets; i++) {
-        char *name = g_strdup_printf("gpio-set[%d]", i);
+        g_autofree char *name = g_strdup_printf("gpio-set[%d]", i);
         object_property_add(obj, name, "uint32", aspeed_gpio_get_set,
         aspeed_gpio_set_set, NULL, NULL);
     }
-- 
2.43.0


