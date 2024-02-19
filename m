Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C623C48BC4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 01:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbsIG-0003Ie-H2; Sun, 18 Feb 2024 20:18:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsID-0003GG-In; Sun, 18 Feb 2024 20:18:01 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsIB-0004FI-Uv; Sun, 18 Feb 2024 20:18:01 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-60843233278so305507b3.3; 
 Sun, 18 Feb 2024 17:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708305478; x=1708910278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jCuXLoF/jYrUq9wGAd2LL4H1wbrYwKDhVdG2Nb+bSXk=;
 b=INWoe6BTS+zNuCFkg4lbi7H5ch1uSmTj0U4gU7RfYxp3h1Nb40qj8cxa8tw5ew/BUq
 iuxtABLJhZpUqU9WLyzbo79JKFwJBzHGo1SW53fLTnsVoHATpu8ZTlXoZGMsmZ/ei4UM
 UKPDD01IDybcILYDM8YDSodBuBCLt+3PmskClzpmILsHjBfznske8l7imRKUJSenIdCj
 QEaCl99lNurhXYK/ezPzqczxGz/yFSFdCKDPPsEsMYcMBfwC820jreHgdBZlIAw0Az6t
 o/tZBHPG7Fyg4o2gW46izYHaesZSmu8dE/cadfmHQD2a+GT6LrIzn+4b4xt4Yuw/BEy9
 HXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708305478; x=1708910278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jCuXLoF/jYrUq9wGAd2LL4H1wbrYwKDhVdG2Nb+bSXk=;
 b=vVhMR+TM1TsTMb8wf/c8HGXA+9fQJcpJwiszah2b/7qbQJ5Qv829UIGsnD5o89xky4
 RJ3LsBc/ypJoPx0qzHL6G6gFHIe0OdTZVhFLYo4mPUZtfAEMTixUCYWGnkoukwxsnqdz
 ay9rV4VJMqbuvjFSLlrBBDqGwqieub0pdz/VmUnRmToQiRSca8igZmqJmIFEy3S63g/S
 UkEOpKhKzWfkDZtlwaUNOhgdZp25oPVTmkDM2BUYW484s5XF2YzsW6PExmEaAK2Uu121
 YnEweATmQYuWT29i2Hh/cqRrl2xAG1vpxZnRR2LVqqcJgm0D+3lPSwhoeUcPuEJxdajg
 k0hQ==
X-Gm-Message-State: AOJu0YxOKtD5//eJAQiubgi4KEt6H/a7TRpuAczSGCJ5f5ZquGKSCaMJ
 eKH2GlPf9yqqa++h7s312klKtZWYlo6ERTgllyB56GYl7jFQg94LJBmueUxb2ig=
X-Google-Smtp-Source: AGHT+IF1aXXJHctNEOkVt324+yFBxoU8SsN6k0H+hbZy1oYbR2KJwJL40+SLboo0y515cRoOeiRtoQ==
X-Received: by 2002:a81:c252:0:b0:607:9e4b:f0e9 with SMTP id
 t18-20020a81c252000000b006079e4bf0e9mr11644068ywg.31.1708305478342; 
 Sun, 18 Feb 2024 17:17:58 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a819e0c000000b00607ff905ed3sm1204704ywj.58.2024.02.18.17.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 17:17:58 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v5 08/41] Connect SD controller to BCM2838 GPIO
Date: Sun, 18 Feb 2024 19:17:06 -0600
Message-Id: <20240219011739.2316619-9-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/gpio/bcm2838_gpio.c         | 52 +++++++++++++++++++++++++++++++++-
 include/hw/gpio/bcm2838_gpio.h |  5 ++++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/hw/gpio/bcm2838_gpio.c b/hw/gpio/bcm2838_gpio.c
index 69d15dbb49..2ddf62f695 100644
--- a/hw/gpio/bcm2838_gpio.c
+++ b/hw/gpio/bcm2838_gpio.c
@@ -17,6 +17,7 @@
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
+#include "hw/sd/sd.h"
 #include "hw/gpio/bcm2838_gpio.h"
 #include "hw/irq.h"
 
@@ -63,6 +64,16 @@
 
 #define BYTES_IN_WORD        4
 
+/* bcm,function property */
+#define BCM2838_FSEL_GPIO_IN    0
+#define BCM2838_FSEL_GPIO_OUT   1
+#define BCM2838_FSEL_ALT5       2
+#define BCM2838_FSEL_ALT4       3
+#define BCM2838_FSEL_ALT0       4
+#define BCM2838_FSEL_ALT1       5
+#define BCM2838_FSEL_ALT2       6
+#define BCM2838_FSEL_ALT3       7
+
 static uint32_t gpfsel_get(BCM2838GpioState *s, uint8_t reg)
 {
     int i;
@@ -86,6 +97,31 @@ static void gpfsel_set(BCM2838GpioState *s, uint8_t reg, uint32_t value)
             s->fsel[index] = fsel;
         }
     }
+
+    /* SD controller selection (48-53) */
+    if (s->sd_fsel != BCM2838_FSEL_GPIO_IN
+        && (s->fsel[48] == BCM2838_FSEL_GPIO_IN)
+        && (s->fsel[49] == BCM2838_FSEL_GPIO_IN)
+        && (s->fsel[50] == BCM2838_FSEL_GPIO_IN)
+        && (s->fsel[51] == BCM2838_FSEL_GPIO_IN)
+        && (s->fsel[52] == BCM2838_FSEL_GPIO_IN)
+        && (s->fsel[53] == BCM2838_FSEL_GPIO_IN)
+       ) {
+        /* SDHCI controller selected */
+        sdbus_reparent_card(s->sdbus_sdhost, s->sdbus_sdhci);
+        s->sd_fsel = BCM2838_FSEL_GPIO_IN;
+    } else if (s->sd_fsel != BCM2838_FSEL_ALT0
+               && (s->fsel[48] == BCM2838_FSEL_ALT0) /* SD_CLK_R */
+               && (s->fsel[49] == BCM2838_FSEL_ALT0) /* SD_CMD_R */
+               && (s->fsel[50] == BCM2838_FSEL_ALT0) /* SD_DATA0_R */
+               && (s->fsel[51] == BCM2838_FSEL_ALT0) /* SD_DATA1_R */
+               && (s->fsel[52] == BCM2838_FSEL_ALT0) /* SD_DATA2_R */
+               && (s->fsel[53] == BCM2838_FSEL_ALT0) /* SD_DATA3_R */
+              ) {
+        /* SDHost controller selected */
+        sdbus_reparent_card(s->sdbus_sdhci, s->sdbus_sdhost);
+        s->sd_fsel = BCM2838_FSEL_ALT0;
+    }
 }
 
 static int gpfsel_is_out(BCM2838GpioState *s, int index)
@@ -266,6 +302,11 @@ static void bcm2838_gpio_reset(DeviceState *dev)
 
     memset(s->fsel, 0, sizeof(s->fsel));
 
+    s->sd_fsel = 0;
+
+    /* SDHCI is selected by default */
+    sdbus_reparent_card(&s->sdbus, s->sdbus_sdhci);
+
     s->lev0 = 0;
     s->lev1 = 0;
 
@@ -304,6 +345,8 @@ static void bcm2838_gpio_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
+    qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS, DEVICE(s), "sd-bus");
+
     memory_region_init_io(&s->iomem, obj, &bcm2838_gpio_ops, s,
                           "bcm2838_gpio", BCM2838_GPIO_REGS_SIZE);
     sysbus_init_mmio(sbd, &s->iomem);
@@ -312,7 +355,14 @@ static void bcm2838_gpio_init(Object *obj)
 
 static void bcm2838_gpio_realize(DeviceState *dev, Error **errp)
 {
-    /* Temporary stub. Do nothing */
+    BCM2838GpioState *s = BCM2838_GPIO(dev);
+    Object *obj;
+
+    obj = object_property_get_link(OBJECT(dev), "sdbus-sdhci", &error_abort);
+    s->sdbus_sdhci = SD_BUS(obj);
+
+    obj = object_property_get_link(OBJECT(dev), "sdbus-sdhost", &error_abort);
+    s->sdbus_sdhost = SD_BUS(obj);
 }
 
 static void bcm2838_gpio_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/gpio/bcm2838_gpio.h b/include/hw/gpio/bcm2838_gpio.h
index 06d48e0c19..f2a57a697f 100644
--- a/include/hw/gpio/bcm2838_gpio.h
+++ b/include/hw/gpio/bcm2838_gpio.h
@@ -14,6 +14,7 @@
 #ifndef BCM2838_GPIO_H
 #define BCM2838_GPIO_H
 
+#include "hw/sd/sd.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
 
@@ -29,6 +30,10 @@ struct BCM2838GpioState {
 
     MemoryRegion iomem;
 
+    /* SDBus selector */
+    SDBus sdbus;
+    SDBus *sdbus_sdhci;
+    SDBus *sdbus_sdhost;
 
     uint8_t fsel[BCM2838_GPIO_NUM];
     uint32_t lev0, lev1;
-- 
2.34.1


