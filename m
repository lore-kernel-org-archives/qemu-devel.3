Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85651C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lNZ-0002WF-O7; Wed, 08 May 2024 13:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lNP-0001bG-BC
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:47 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lNM-0008D3-7O
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:46 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52006fbae67so6406817e87.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190400; x=1715795200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GPE5QkM3UVuJG2oSH/R/5VD41xXCvV77aOjIZTcxo54=;
 b=TUWuxB08d6y1AyGl/eo4K0nkMolHUr6gHdD5nzYkiC8xcJPfbOVr6R366I4L2QZBV4
 apyIEOwK3lw6jYLmpvfZLuETj8PXwdV/hdgfxnUmEvmu0lAZvwt0zhj58l4K2XhtQU6u
 LuNfy4HvZBlXmUBpCyByx+AxQhy/5NIPOZ/DtnjGtiXr832uPaiIdBVFALKhICXy9ptj
 OVGxfHK8DdUlZOV4Kv7ooFuA7pE0YT8cFATzBk8ZDl7celFioGtVDmDQkcyVox44Fpf2
 f5pcusD6ZL9qwPD8umAr1W/D+i3TQkbDEt9ZELrqrmOQICVTRgC+HQKRb7AQqmLs7JQk
 lN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190400; x=1715795200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GPE5QkM3UVuJG2oSH/R/5VD41xXCvV77aOjIZTcxo54=;
 b=XLf5504jJQ2KVRwRpMB0nD2jrKZVN0/O8kZ+mkGBvUxPTs3WGbcBOLGzrMEe/0k7kf
 1OpP7mbxqs5xD8JzOMywhKQ52k4ZjxkGdwuCK1djouNOYd4I1hZOvgv8NF3tc+KgjNf9
 wsi3ovbnBeRq3KtX7uqNOhrd0meAqnZ8GIJ3UPnyOCPK+2NWvxyacAWtW8a0nLDewJy7
 KA0VUX8j2GB6oD6yglogacD4WgvvcD6D630GB4zvYl9RzK9mpsygzNkLUtB8tRHkKfK8
 50JE9QDswmBVv7ZRyVPAE5OGjo6yteGEbgvzbPdSl1jgCEhJ9ulJCFDJMbsk7SQEsmVf
 DoGg==
X-Gm-Message-State: AOJu0YyMxqvCLHJENsxC/pnkcWnHmc1ZomlU+lp96o+l6ZQZIx6ulzxM
 Rk7KYCy7GsSXJzDS6SM5qmkoMS70DAL3AyLrzvuJCs6V/GelRjnPM71UelcqEJYxNPpLfi8M/Kw
 +
X-Google-Smtp-Source: AGHT+IGcm7HmIryW+8B1YXF0I2Q5Qg9mUyJ+OLx11aQQRuCnJRd8gZWP1Q2ZJefh2fUzDia+pIkqPw==
X-Received: by 2002:ac2:4c9a:0:b0:51b:9254:91e2 with SMTP id
 2adb3069b0e04-5217cd497f9mr1944854e87.55.1715190399963; 
 Wed, 08 May 2024 10:46:39 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 t16-20020a170906609000b00a59d7505366sm3418640ejj.62.2024.05.08.10.46.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:46:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/26] hw/gpio: Handle clock migration in STM32L4x5 gpios
Date: Wed,  8 May 2024 19:45:00 +0200
Message-ID: <20240508174510.60470-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

From: Inès Varhol <ines.varhol@telecom-paris.fr>

STM32L4x5 GPIO wasn't migrating its clock.

Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240507185854.34572-3-ines.varhol@telecom-paris.fr>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/gpio/stm32l4x5_gpio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/gpio/stm32l4x5_gpio.c b/hw/gpio/stm32l4x5_gpio.c
index 71bf5fddb2..30d8d6cba4 100644
--- a/hw/gpio/stm32l4x5_gpio.c
+++ b/hw/gpio/stm32l4x5_gpio.c
@@ -20,6 +20,7 @@
 #include "qemu/log.h"
 #include "hw/gpio/stm32l4x5_gpio.h"
 #include "hw/irq.h"
+#include "hw/clock.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "qapi/visitor.h"
@@ -426,8 +427,8 @@ static void stm32l4x5_gpio_realize(DeviceState *dev, Error **errp)
 
 static const VMStateDescription vmstate_stm32l4x5_gpio = {
     .name = TYPE_STM32L4X5_GPIO,
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]){
         VMSTATE_UINT32(moder, Stm32l4x5GpioState),
         VMSTATE_UINT32(otyper, Stm32l4x5GpioState),
@@ -441,6 +442,7 @@ static const VMStateDescription vmstate_stm32l4x5_gpio = {
         VMSTATE_UINT32(ascr, Stm32l4x5GpioState),
         VMSTATE_UINT16(disconnected_pins, Stm32l4x5GpioState),
         VMSTATE_UINT16(pins_connected_high, Stm32l4x5GpioState),
+        VMSTATE_CLOCK(clk, Stm32l4x5GpioState),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.41.0


