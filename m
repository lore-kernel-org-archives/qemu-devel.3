Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1959EC71136
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 05:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS7ig-0003Hk-J0; Thu, 19 Jun 2025 01:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uS1r7-0006wU-PD
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 19:06:09 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uS1r6-00066d-7j
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 19:06:09 -0400
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-87611ac3456so4986539f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 16:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750287966; x=1750892766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AtSSDzCzP4vwLmL/8RerFdCo8WTmKn978LGUT6OIuTY=;
 b=aHDcVB6bH1sh5X8Z8SYCO2/kSkti07IsunM+8ma6FFj6Zpv12IU/7I+MhDUYYJsjw6
 SdoC+T0HY0bbkGUMjPXIs1+GpAtaF6OHlEcPCx3JpQNGXghM9+P6Oc727bGj9E8sz793
 L+Rv0u4KsmqilXQL499YpVe5uLk5U9r+/vinyW8eTbFRHNqz5cotMAg4sAB2KWL5FAV8
 19B+WBcrrRHOOa7eNANYesyjubZB2/7+1mJaCeaAZe4ckhJNCAhccWfi/ExApfcaN7zJ
 v/AJBSJbOj1YSC5bL01h7x5wVZtmyGXFu6/XIwjnOgwJ/NM2oUiDfNaSC6+rKU5/3uXu
 wEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750287967; x=1750892767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AtSSDzCzP4vwLmL/8RerFdCo8WTmKn978LGUT6OIuTY=;
 b=vcHeeLAexD6sxaofcmDQzG3mzFMpyWKJWjP1JeP5trEkR42ilWfQQYIgZgGw6OiNfd
 H14qXJA9YHh25VRXFWEWy3asLdh1Wcwjb+uBlII8isEyDTMVpNfwDKdISXSpevXb1F/a
 Ra1UTUFY4zE8haZhr5CNOIBIyNZ+c/g6dPyUzaxAdzdGAHnwcRzklE3mOviBhjnJ/DvU
 xJ74QhBhsWo5d3lgCgSct36Q9resZgiaIVT1UdPVakg9Dzw08JaWefQHtMoI6eF2KTY3
 XrZpbRpPoFj17IK99T9mUXhClsp+by1xc+zO1boFvgmfO4/8Ux9gdfRu6UiSVpQGecxv
 inwA==
X-Gm-Message-State: AOJu0Yz15qKvQmtb9Ft+MboUOxGlHHd10/hwh2BmyNCeDp0THbcltI8+
 k2PMTFcalr9MFAd5cLIy8mm9IwjkXz1d2GcOxEhv8SNH6ynJu5hOdK+hXlPtibC8Uyo=
X-Gm-Gg: ASbGncsXS1cyYbG2wujVntBrLKIqeJTRuGTaLCFz641jsK2YyEuDiZs0JeXWXdSFnHL
 +KilWoZrAzP5EAOVK2wtKwSSuQcnroy8W1hwkdMJi6RZksV5vMW8m/KqLfvXAd3VSS1g/ZBV0Du
 buXdplYCvgOav0pASLjU3IehAvhswVsHT+feQdEyuvEIkK+6hQ/aB/1AtBffxSmFMPtf9pdvusC
 gqzwDlvGM+jY1AwhG72ouGDr5FPpB1zft/8B8p6tYgaFvAR2HfHfvV/peuCVfOqlhpEBobIy2xd
 2Z0sFv3BJpF422U9yIEL5cCx/47Mdk+T6idbkbkrmqScTbQZGgLHsFKm/NnxNavSTUOA2ZY1l5y
 q16rl
X-Google-Smtp-Source: AGHT+IHo0yEFki1gRFvQ5EKSSjYZrBmEJmnImnyeBI8P4L9ASnGvDAlflORZNPpLSvuH+5Rg5hl76Q==
X-Received: by 2002:a05:6602:3d3:b0:86d:60:702f with SMTP id
 ca18e2360f4ac-875dec74af9mr2171582439f.0.1750287966604; 
 Wed, 18 Jun 2025 16:06:06 -0700 (PDT)
Received: from user-jcksn.hsd1.mi.comcast.net
 ([2601:401:101:1070:b57:773f:14d7:807b])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50149b9df11sm3036915173.54.2025.06.18.16.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 16:06:06 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 09/11] MAX78000: Add TRNG to SOC
Date: Wed, 18 Jun 2025 19:05:47 -0400
Message-Id: <20250618230549.3351152-10-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250618230549.3351152-1-jcksn@duck.com>
References: <20250618230549.3351152-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=jackson88044@gmail.com; helo=mail-io1-xd2e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Jun 2025 01:21:41 -0400
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

This commit adds TRNG to max78000_soc

Signed-off-by: Jackson Donaldson
---
 hw/arm/max78000_soc.c         | 10 +++++++++-
 include/hw/arm/max78000_soc.h |  2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 1a36bba2fc..09667b578c 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -41,6 +41,8 @@ static void max78000_soc_initfn(Object *obj)
                                 TYPE_MAX78000_UART);
     }
 
+    object_initialize_child(obj, "trng", &s->trng, TYPE_MAX78000_TRNG);
+
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
 }
 
@@ -124,6 +126,13 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
                                                        max78000_uart_irq[i]));
     }
 
+    dev = DEVICE(&s->trng);
+    sysbus_realize(SYS_BUS_DEVICE(dev), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x4004d000);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(armv7m, 4));
+    dev->id = g_strdup("trng");
+    object_property_set_link(OBJECT(gcrdev), "trng", OBJECT(dev), &err);
+
     dev = DEVICE(&s->gcr);
     sysbus_realize(SYS_BUS_DEVICE(dev), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40000000);
@@ -168,7 +177,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("semaphore",            0x4003e000, 0x1000);
 
     create_unimplemented_device("spi1",                 0x40046000, 0x2000);
-    create_unimplemented_device("trng",                 0x4004d000, 0x1000);
     create_unimplemented_device("i2s",                  0x40060000, 0x1000);
     create_unimplemented_device("lowPowerControl",      0x40080000, 0x400);
     create_unimplemented_device("gpio2",                0x40080400, 0x200);
diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index 919aca0855..528598cfcb 100644
--- a/include/hw/arm/max78000_soc.h
+++ b/include/hw/arm/max78000_soc.h
@@ -14,6 +14,7 @@
 #include "hw/misc/max78000_gcr.h"
 #include "hw/misc/max78000_icc.h"
 #include "hw/char/max78000_uart.h"
+#include "hw/misc/max78000_trng.h"
 #include "qom/object.h"
 
 #define TYPE_MAX78000_SOC "max78000-soc"
@@ -39,6 +40,7 @@ struct MAX78000State {
     Max78000GcrState gcr;
     Max78000IccState icc[MAX78000_NUM_ICC];
     Max78000UartState uart[MAX78000_NUM_UART];
+    Max78000TrngState trng;
 
     Clock *sysclk;
 };
-- 
2.34.1


