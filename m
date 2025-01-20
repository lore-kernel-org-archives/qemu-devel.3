Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C902C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyXG-0003uB-VP; Mon, 20 Jan 2025 15:38:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXD-0003sm-Tx; Mon, 20 Jan 2025 15:38:12 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tZyXC-0002Vr-9T; Mon, 20 Jan 2025 15:38:11 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d3e6f6cf69so8015936a12.1; 
 Mon, 20 Jan 2025 12:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737405488; x=1738010288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dk4yhPHq4YZzlaSH8EBkC5hExkhjEj2J5c93kzLklPM=;
 b=RD12raj99Y62rEEQ2JBKF4poEdxktmnUmqScm346a7ybqE97N6hSGMyZuQAuwkJ8eC
 9f6JAmkTnSuUJOYukWECDZ85gZCVvQqpM6FepYX7bXG6o4ENejsGrYy9Wry5TfWXYo8m
 eKpadZsMniJgyOy7hHzQW8cBYvL+Sv5tdHKiAccgUtdZxtyQzMGmp/Dy7QVAytidLzuf
 9b3H3/wIw9J0KOzODsV0v00HumvU5yDWJFDn/yZWBdmPUYSyKaqfKOSX/wX+zTDP6/F0
 fzt+3IX6sc5kLZu9r8jDbEtvmFrKDT4+hEUlDBrJSonUcUudlx9defe2YPXyr4T3CYRx
 Y5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737405488; x=1738010288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dk4yhPHq4YZzlaSH8EBkC5hExkhjEj2J5c93kzLklPM=;
 b=AA9tGxM9KaHqkEMB8cDXts7FGNdUpirVnkL/lQvBymSD2iORjwSEb5BP8nXsmxNJiW
 F6ZSP/S90wd3JZuu+icx8f3wEfRp6bMVD74+EvMptLzGzY5pDREWVGHOfMPSi8wXYImA
 An7s7jqr6xQf0KdQyIoc8+SZbMA9qfqn5x9K4mAH8I0ibyngS33WWLz6dBIyYpZ3cn7H
 EskMvF84HWLCWuYkthhGtLZK+Tey/BeAU3N1USEYL/xbltMMMA2lLVer4ltj7yt8P94u
 1lZB/vdQTBn/geW4Tn3G/5ojdlWngd8r+O40cldiiFLKX0FpeWrGZs1sybXyORDDL24i
 soBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPBZTK1bx5WRVNElKnNr9zohejRFSeMehIMfjBGLYHJLVmSFCszG2Gem3crMhsvn2OedKRYAieBA==@nongnu.org
X-Gm-Message-State: AOJu0Yz3pEnJstCfdkXMF7ZeUkZdlgBpa7gTagv7/8XaXccfuM6+Vmqk
 wNibmo3fY2aSB3hbLxm4zm6pOEUNWwnmf0/s6KDFxMvtCoSFW2jh+TGQQ1xc
X-Gm-Gg: ASbGncsk2IpCf+/J7CNLpHyK8Ic30+8kDGuiJSWw3x6LK3Eud5icrTiq89NcXuq3lsU
 wLY1uhE/GU9U6knBXrTyv6vJav9yVKSDqT/jzhPGU5qJKx6NN6qKiqGFeqajBSiZ9rxWErOEfTh
 FECYhFP5SjM+V053HR7wHpHbV7qgCC+VgSVHtKfEK8IW5Ce7G/jSzksQEuWoJ6rD+ZrnSLPw8im
 XScoXbRjrhI7+WltSqAhxcXs1Kc7uY6YSiITEKFC38dBwG2eQCC89NK3s0NTd6YJwcdkK4Tnki2
 Ni7s3yayWdONTeCZyidaazbCydT//ZEiXR6bjb33PFQTGRdWxdluMHwpeLd2
X-Google-Smtp-Source: AGHT+IHhiQYeFJ6VQA0kAN/0J/2S4mOroe2htqBZ2UeQb8pXMziYVYO8KMEKcc+kUNJ4bH0vvvwDeQ==
X-Received: by 2002:a05:6402:50cb:b0:5d3:e45d:ba91 with SMTP id
 4fb4d7f45d1cf-5db7db12ccfmr13918379a12.32.1737405487849; 
 Mon, 20 Jan 2025 12:38:07 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-183-181-102.77.183.pool.telefonica.de. [77.183.181.102])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db7364258csm6021077a12.1.2025.01.20.12.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:38:07 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 07/21] hw/arm/fsl-imx8mp: Add SNVS
Date: Mon, 20 Jan 2025 21:37:34 +0100
Message-ID: <20250120203748.4687-8-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120203748.4687-1-shentey@gmail.com>
References: <20250120203748.4687-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
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

SNVS contains an RTC which allows Linux to deal correctly with time. This is
particularly useful when handling persistent storage which will be done in the
next patch.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    |  2 ++
 hw/arm/fsl-imx8mp.c            | 10 ++++++++++
 3 files changed, 13 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 3de4a73530..d7d08cc198 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -13,6 +13,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * Up to 4 Cortex-A53 Cores
  * Generic Interrupt Controller (GICv3)
  * 4 UARTs
+ * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
 Boot options
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 979cdbd8c4..9d2a757c2a 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -12,6 +12,7 @@
 #include "cpu.h"
 #include "hw/char/imx_serial.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_ccm.h"
 #include "qom/object.h"
 #include "qemu/units.h"
@@ -35,6 +36,7 @@ struct FslImx8mpState {
     GICv3State         gic;
     IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
+    IMX7SNVSState      snvs;
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
 };
 
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 311b8ee0cd..0abde2b1fc 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -204,6 +204,8 @@ static void fsl_imx8mp_init(Object *obj)
 
     object_initialize_child(obj, "analog", &s->analog, TYPE_IMX8MP_ANALOG);
 
+    object_initialize_child(obj, "snvs", &s->snvs, TYPE_IMX7_SNVS);
+
     for (i = 0; i < FSL_IMX8MP_NUM_UARTS; i++) {
         snprintf(name, NAME_SIZE, "uart%d", i + 1);
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
@@ -348,6 +350,13 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, serial_table[i].irq));
     }
 
+    /* SNVS */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->snvs), 0,
+                    fsl_imx8mp_memmap[FSL_IMX8MP_SNVS_HP].addr);
+
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(fsl_imx8mp_memmap); i++) {
         switch (i) {
@@ -356,6 +365,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
         case FSL_IMX8MP_RAM:
+        case FSL_IMX8MP_SNVS_HP:
         case FSL_IMX8MP_UART1 ... FSL_IMX8MP_UART4:
             /* device implemented and treated above */
             break;
-- 
2.48.1


