Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513A3C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjjG-0006uU-Vt; Fri, 04 Jul 2025 12:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXjjF-0006ru-5t
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:57:37 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXjjD-0000O4-ID
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:57:36 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6facf4d8ea8so8635466d6.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751648254; x=1752253054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s8W/BesSrkXf8T/cfZLdQ2jvqfqfxvtyZB9Yq+bGkmE=;
 b=bq8phWl9/PHW1cloe48wBAgnruAcWj9dL5zxLaotLnBqBg6XabK29h/H91FOionyOO
 x6YSSejZn2iJkvOcLSsXLTGJCJwP1yi3ir8ycdu2QvEu5oLwV8ntF3ayXv6kZ3u2So5Z
 JPWYyKi63bYIMSPxf+C6mIVr1KVwR6pAzyLZIcCqqulwBN2uWUCPl+OAH/GJ5evePZ1k
 Y/9rJaRfCDtk/x1gdI5u9w+J564ZFs9TQ1dWl/JTl64pCfWqDqKlaPaJlfeD5mX/ARnR
 ONq/siVF0VDvYVr5dVVAp7+wGgbup1YXqYtLd+DERLwN5DcjDvp1eDAgySX8vsb60ozt
 x1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751648254; x=1752253054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s8W/BesSrkXf8T/cfZLdQ2jvqfqfxvtyZB9Yq+bGkmE=;
 b=XTyEUNoK6geSh4RaoCkENuEbs2BzrJanRCZoaxBHXknociSYBdPihYjtUFv7Mt6ICC
 C2LlVHZEJDyDnJNR9HNBnyeH6ESp5ZEPUKH8CDeEpFAcq3UrbiG5yoDE3ZFjVCdGmf8Q
 mdXsTkC3Nv/y6Ls6yGAIv11Of3V1bSiiF9scvhES/gy49uANbx7tpaJBMBwvvWTREfv3
 pTYHCXTmCNqDj1JXT0pZ3fg2uKz4Uva2FBI/z4L2VA/VVqTYHo+TGa//E+Bm/oxkBMK7
 YgPvpGC9VPvb++/SRbx3arHs/PR1IR0FFBAAqdhbzAPGDQANY7TwWs7xt2j4HJRAIhka
 UYFw==
X-Gm-Message-State: AOJu0YwxAAU3G27EOSLNegC+YHmPTi+LM/UFWZp3DpFR/Wzk6qZrZzVS
 +KqOIYdY4cWV1REC3M4y0OZiAhXunUP/xW7moWvV7TXeMdIL49GUFDynIhm8yg==
X-Gm-Gg: ASbGnctBjKETCh2RJ9A+s1l7Bd6p1exrkhur8xKG55jvys890lC191LrmMtO/N0Y7q9
 GekH6PHg3k5sjwXHVGB/IFXAOcZvnCtD16hefMmw3x22ZY31m4xqvqHFRyRtHH5L8kIu0hduTXf
 x4HW8paEJQFzFGmN7oDIDFu3sZk02UIVC0thv+DnPCvSXb3mZnFLOqQz11REjlUBZVGyFQbw6eG
 evjr5yrjIHL256nN1LvnRR2UZ8/eBe6SNJ/VNlWitiMwEp5tjK7SnHSrJIfr2t9xZ30+VZpbQvQ
 FR4gzR4gNyMTB/NWa6MJCtQogPZ615guI7YCWi0LTMXrq10eXUBZ+N+2ik3wBLzqKKlF07W1uEp
 ih1wE
X-Google-Smtp-Source: AGHT+IHU9nBuWmJXXcBoXYsFf9QBQXX2SLSjku4LpxyRDhV4hUgYefLYLvk0aSkRwTtXnSwMY6Di8A==
X-Received: by 2002:ad4:5e8d:0:b0:6fa:acc1:f077 with SMTP id
 6a1803df08f44-702c6db2100mr44428376d6.35.1751648254432; 
 Fri, 04 Jul 2025 09:57:34 -0700 (PDT)
Received: from user-jcksn.myfiosgateway.com
 ([2600:4040:2bcd:3800:e3f4:4cee:828f:52d])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4ccc6easm15345826d6.26.2025.07.04.09.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:57:34 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 05/11] MAX78000: Add UART to SOC
Date: Fri,  4 Jul 2025 12:57:23 -0400
Message-Id: <20250704165729.208381-6-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704165729.208381-1-jcksn@duck.com>
References: <20250704165729.208381-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=jackson88044@gmail.com; helo=mail-qv1-xf2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This commit adds UART to max78000_soc

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
---
 hw/arm/max78000_soc.c         | 28 ++++++++++++++++++++++++----
 include/hw/arm/max78000_soc.h |  3 +++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 0c83b08eca..2f93ab882d 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -18,6 +18,10 @@
 #include "hw/misc/unimp.h"
 
 static const uint32_t max78000_icc_addr[] = {0x4002a000, 0x4002a800};
+static const uint32_t max78000_uart_addr[] = {0x40042000, 0x40043000,
+                                              0x40044000};
+
+static const int max78000_uart_irq[] = {14, 15, 34};
 
 static void max78000_soc_initfn(Object *obj)
 {
@@ -31,6 +35,12 @@ static void max78000_soc_initfn(Object *obj)
         object_initialize_child(obj, name, &s->icc[i], TYPE_MAX78000_ICC);
     }
 
+    for (i = 0; i < MAX78000_NUM_UART; i++) {
+        g_autofree char *name = g_strdup_printf("uart%d", i);
+        object_initialize_child(obj, name, &s->uart[i],
+                                TYPE_MAX78000_UART);
+    }
+
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
 }
 
@@ -39,6 +49,7 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     MAX78000State *s = MAX78000_SOC(dev_soc);
     MemoryRegion *system_memory = get_system_memory();
     DeviceState *dev, *armv7m;
+    SysBusDevice *busdev;
     Error *err = NULL;
     int i;
 
@@ -89,6 +100,19 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, max78000_icc_addr[i]);
     }
 
+    for (i = 0; i < MAX78000_NUM_UART; i++) {
+        dev = DEVICE(&(s->uart[i]));
+        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
+            return;
+        }
+
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0, max78000_uart_addr[i]);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m,
+                                                       max78000_uart_irq[i]));
+    }
+
     create_unimplemented_device("globalControl",        0x40000000, 0x400);
     create_unimplemented_device("systemInterface",      0x40000400, 0x400);
     create_unimplemented_device("functionControl",      0x40000800, 0x400);
@@ -127,10 +151,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("oneWireMaster",        0x4003d000, 0x1000);
     create_unimplemented_device("semaphore",            0x4003e000, 0x1000);
 
-    create_unimplemented_device("uart0",                0x40042000, 0x1000);
-    create_unimplemented_device("uart1",                0x40043000, 0x1000);
-    create_unimplemented_device("uart2",                0x40044000, 0x1000);
-
     create_unimplemented_device("spi1",                 0x40046000, 0x2000);
     create_unimplemented_device("trng",                 0x4004d000, 0x1000);
     create_unimplemented_device("i2s",                  0x40060000, 0x1000);
diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index 27b506d6ee..57894f0035 100644
--- a/include/hw/arm/max78000_soc.h
+++ b/include/hw/arm/max78000_soc.h
@@ -12,6 +12,7 @@
 #include "hw/or-irq.h"
 #include "hw/arm/armv7m.h"
 #include "hw/misc/max78000_icc.h"
+#include "hw/char/max78000_uart.h"
 #include "qom/object.h"
 
 #define TYPE_MAX78000_SOC "max78000-soc"
@@ -24,6 +25,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(MAX78000State, MAX78000_SOC)
 
 /* The MAX78k has 2 instruction caches; only icc0 matters, icc1 is for RISC */
 #define MAX78000_NUM_ICC 2
+#define MAX78000_NUM_UART 3
 
 struct MAX78000State {
     SysBusDevice parent_obj;
@@ -34,6 +36,7 @@ struct MAX78000State {
     MemoryRegion flash;
 
     Max78000IccState icc[MAX78000_NUM_ICC];
+    Max78000UartState uart[MAX78000_NUM_UART];
 
     Clock *sysclk;
 };
-- 
2.34.1


