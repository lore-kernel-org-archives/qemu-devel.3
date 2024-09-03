Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65902CD3448
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW59-0007GY-NR; Tue, 03 Sep 2024 12:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW58-00078R-5V
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:38 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW53-0002of-Hs
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:37 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42bb72a5e0bso48712475e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379712; x=1725984512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qIgySZe6cMgEDvvjEPG6NKleQ03CSEs1d9HS7DIWK3k=;
 b=xJvK2eCPT0vWJ2j+7zptTcDAHuOCl9VR11C4ejmsd4jzSBWcEMOdGPwDJzVEcodpXj
 z6cZyNSos9sk//vnBgGm3jtswjP7UO+JwGXGXlyBnR9PYsTZjHDJYu/cL6ZBpNXl6iVK
 hCVmbhjyLi6VVOim4BVRe1OvFDqlcy7e7I98d6/vXRVbxlEp5Z54YDL3ztHC7J11vsON
 L03YL6ndAHE/en8BdtbNw8Wt8BmGe3GCugYKHd6v0cggQFE9nDOA7s+whw8JYaI+i7jg
 dG0yUgpjszKhl3lpeZqkCfHXhplX5rJxDauc5+l0VfbErc6SyhlDpFTIfEJzt9uDOds1
 wjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379712; x=1725984512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qIgySZe6cMgEDvvjEPG6NKleQ03CSEs1d9HS7DIWK3k=;
 b=rVa7BQNbD1q4VqE8FAcZUSHXMDHA+WoTWG9Vz1lTcggR4shqxky+W5SbcBQyHOVULD
 RWgiZxZv18tA6i0PFeAoLL0/lfihWlOgzwI9Ig4WyoOuIPHlZLDAIkbsgcuYLxIttCmw
 imxUL9ISz1zJkOjlb0tJitZnFFieD5Yl0wSMc4gytYiF38ATz3wuCUhwre+RSoA4W9fR
 ZIMaqj5kft4E9pjaZGO0DI4rvd7qHQ+rX4/cajgJQ4gpy8LtkDo1LQZlskyl3WRpZvNA
 Es9ibafJeUpphu2xC54uYG0Uu0gJ3tbzn8N0o3X8jKXGyrFiWFn2BOVxq1tc1t4J7QqG
 gOTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM0QiuzBwHgvKko7/Klg20pkk5THzfYfJWl3Yc7JYRogtUrvbfeTJwki6uq1to09MYwVdqts+ICu27@nongnu.org
X-Gm-Message-State: AOJu0YzoNS2O373e23UTG10tI5JzIBX2uHCfvgSY9GHPygFC3856LPEa
 RYUUh3EqOhSNvTOR0ENipsdtslOgNLZhkA5hcU4zo82K4hM6XrpMADgMM1jEb+Y=
X-Google-Smtp-Source: AGHT+IFpsmip0hYEhjoA26NXwuUJluf+c8Aevs87QaTL6OY+2ZQCM1vFXqqn8RdOhSrCZZbNmjM1mw==
X-Received: by 2002:a05:600c:1c83:b0:426:5440:8541 with SMTP id
 5b1f17b1804b1-42bb01e5f83mr132661895e9.27.1725379712146; 
 Tue, 03 Sep 2024 09:08:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:08:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 23/53] hw/timer: Remove pxa27x-timer
Date: Tue,  3 Sep 2024 17:07:21 +0100
Message-Id: <20240903160751.4100218-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The pxa27x-timer can be removed now we have removed the PXA2xx
SoC models. The pxa25x-timer device must remain as it is still
used by strongarm.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/pxa2xx_timer.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index d1a3ecac2b5..3234bbb1f4a 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -54,7 +54,6 @@
 #define OSNR	0x20
 
 #define PXA25X_FREQ	3686400	/* 3.6864 MHz */
-#define PXA27X_FREQ	3250000	/* 3.25 MHz */
 
 static int pxa2xx_timer4_freq[8] = {
     [0] = 0,
@@ -572,28 +571,6 @@ static const TypeInfo pxa25x_timer_dev_info = {
     .class_init    = pxa25x_timer_dev_class_init,
 };
 
-static Property pxa27x_timer_dev_properties[] = {
-    DEFINE_PROP_UINT32("freq", PXA2xxTimerInfo, freq, PXA27X_FREQ),
-    DEFINE_PROP_BIT("tm4", PXA2xxTimerInfo, flags,
-                    PXA2XX_TIMER_HAVE_TM4, true),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void pxa27x_timer_dev_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->desc = "PXA27x timer";
-    device_class_set_props(dc, pxa27x_timer_dev_properties);
-}
-
-static const TypeInfo pxa27x_timer_dev_info = {
-    .name          = "pxa27x-timer",
-    .parent        = TYPE_PXA2XX_TIMER,
-    .instance_size = sizeof(PXA2xxTimerInfo),
-    .class_init    = pxa27x_timer_dev_class_init,
-};
-
 static void pxa2xx_timer_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -615,7 +592,6 @@ static void pxa2xx_timer_register_types(void)
 {
     type_register_static(&pxa2xx_timer_type_info);
     type_register_static(&pxa25x_timer_dev_info);
-    type_register_static(&pxa27x_timer_dev_info);
 }
 
 type_init(pxa2xx_timer_register_types)
-- 
2.34.1


