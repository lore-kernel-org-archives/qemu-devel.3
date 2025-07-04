Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7DDC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjjM-0007B8-86; Fri, 04 Jul 2025 12:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXjjI-000701-IG
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:57:40 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXjjG-0000PR-V8
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:57:40 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6face367320so11178326d6.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751648257; x=1752253057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EDVuCWCYI69exjDIpGVuKyVWGMzMFvFHCwD9EkVaeb0=;
 b=mU9JjJo8ifMeAuDAxZey1eRNYOEWt6EkwYFqrV+jyq+gZV4QondB6DtX8ABrAGbo/+
 v4ijVUcduIvx0xvnKuenB0PWbmPbNO9YV5dI/1evWTvbMn248NPnssUu/6nC2YywnDLL
 0l/dsG9zDD3m0+Cb3SQenveKNd3R+Yf8ai/sz+kSzakWdFeG4uzDv3sdemVBbufzmxDr
 RXmcCyjOVRhG9ZN0ffMWv2cWyrGdyQ5tDIS0oBJgTKBcw5DSlscdWPtIqFUuPZUh2Fgq
 8bIFsmuSMWiOnlqlO7nIcn2GTlmQuGI7bZDvmZGdkBp3KjsQlFsqyZAXt2ft3dOQrcfu
 1oIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751648257; x=1752253057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EDVuCWCYI69exjDIpGVuKyVWGMzMFvFHCwD9EkVaeb0=;
 b=GiJJJkglaf1oodmvmk/erGZB/UjritdXGQBxGSoTbW+Qm8qzxjuYyZBD5tLkvFjUYl
 J5sk8dydczDTqkspPu+gluBBEwI5xl9uYz9lMcF9DuANSwNZ5GUwgul8z1/SgCXGqKKq
 +ebTtPDnWddev0Ybxscr7ox1Xfb3wwZNssAHg15/AgkUpAfXMoRY7oME+ycdn7RHJkcM
 XaeyLc5CtPtfxIVdBO4kSX1nqff0cQNNlcs+3BA+MzJNXzD4oxf/xMWScTxF7vjRN93n
 TVx90oOoxtv9RP95DNZsjuKcSShALe7oPy4dR+xKTb0qoBIlSZHRVUpH5ZqICI3OVe0y
 xusQ==
X-Gm-Message-State: AOJu0YzElEwTU8B9c0ovU7BbFboClMr2hUIS0/a6KKhVti3ERAdTbInl
 shnwCDK1U1en2ulYHHueopTK0zEqDD120NAbywtbBRWGDnFIAqGThT9Fr1er4w==
X-Gm-Gg: ASbGncvr/W9QLecu/LBC3zYsq8wDIG8HsiDUwA0YoZgGJu5nPdt2T5l1Gu+aoRlNHON
 bbfEZl1RvU/fQSkUk/kyQZr+IqQp30KPylPyZVIUXqnKZVsn3WCOJrQJhvtOcCqS+cxAn2bCu02
 sktcCA+bwW9rDMMhxmX4/77QjvGanHmpHEqf8OM8YdLV3Iwd4ysLVrZSvEsMrKPNn8ROgegYq47
 Z6csRXZff7ccVSYcBCtGLBoUN1MVYj2J7fKuuXvu2DVKdpijsIo+1i2YG06NfgSGT6H0t2B6xpR
 AjW6PANlvRMS4+AxEwBxMVLfwSUUDOkFBYUOLcMhakfwR+hcUng4j5XiqUVPuGAaGJ44F3rJtlo
 vlreuGubCMv7Qfss=
X-Google-Smtp-Source: AGHT+IHfFKIWr/y3AD3qRHoV2ZkhuzMEBNPVEORtjyYHaIXJ8uvNegMm6/dfPWHep9dJmGGK1hTeXg==
X-Received: by 2002:ad4:5cc6:0:b0:700:bae3:e1a5 with SMTP id
 6a1803df08f44-702c6d3cf65mr44986456d6.19.1751648257495; 
 Fri, 04 Jul 2025 09:57:37 -0700 (PDT)
Received: from user-jcksn.myfiosgateway.com
 ([2600:4040:2bcd:3800:e3f4:4cee:828f:52d])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4ccc6easm15345826d6.26.2025.07.04.09.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:57:37 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 09/11] MAX78000: Add TRNG to SOC
Date: Fri,  4 Jul 2025 12:57:27 -0400
Message-Id: <20250704165729.208381-10-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704165729.208381-1-jcksn@duck.com>
References: <20250704165729.208381-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=jackson88044@gmail.com; helo=mail-qv1-xf35.google.com
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

This commit adds TRNG to max78000_soc

Signed-off-by: Jackson Donaldson
---
 hw/arm/max78000_soc.c         | 12 +++++++++++-
 include/hw/arm/max78000_soc.h |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index eddd9616f0..074fb1da8b 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -43,6 +43,8 @@ static void max78000_soc_initfn(Object *obj)
                                 TYPE_MAX78000_UART);
     }
 
+    object_initialize_child(obj, "trng", &s->trng, TYPE_MAX78000_TRNG);
+
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
 }
 
@@ -51,6 +53,7 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     MAX78000State *s = MAX78000_SOC(dev_soc);
     MemoryRegion *system_memory = get_system_memory();
     DeviceState *dev, *gcrdev, *armv7m;
+    g_autofree char *trng_link = NULL;
     SysBusDevice *busdev;
     Error *err = NULL;
     int i;
@@ -126,6 +129,14 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
                                                        max78000_uart_irq[i]));
     }
 
+    dev = DEVICE(&s->trng);
+    sysbus_realize(SYS_BUS_DEVICE(dev), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x4004d000);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(armv7m, 4));
+
+    trng_link = g_strdup("trng");
+    object_property_set_link(OBJECT(gcrdev), trng_link, OBJECT(dev), &err);
+
     dev = DEVICE(&s->gcr);
     sysbus_realize(SYS_BUS_DEVICE(dev), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40000000);
@@ -170,7 +181,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
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


