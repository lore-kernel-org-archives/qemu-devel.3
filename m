Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FF0C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHC-0002Er-FU; Fri, 26 Jan 2024 09:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHA-0002Dg-8m
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:48 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNH8-0007rh-AP
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:47 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-339208f5105so571829f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279624; x=1706884424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ul4GmzC0vbtgvuz9Q5o0fiW1gb75AZUpep615Cah9j8=;
 b=dik3LNKts1pbzovz2Jfmig3A3qg6U6X28L49TGqAr6A81o0TTfWwiH0SqD/EZsCZv4
 ANksVjGsQLsQP2egxSsX5O9QNcQCKoK8LmlgXy9m8L+6y26WPIUujqIyXiBeNuSIwGMo
 cgpGyC6yiC/HgboV9lnnF6CObp/sWlYSD3HfGZWSruluP+6YLTirVM48PHdggYsvv13u
 8Glz0FlqnLuSvY0icQdWiGtMqo2xJkPNMcRNuPNWl1fLWZ6e0rNWzXBN+mkZe7Rlg1d7
 SYse1ndym0pOXtTrzMDUGbKOyr1AbbsbwTCVcin9giwoZxeeXfQ0xrVrAPKVhPSRVHOw
 Y9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279624; x=1706884424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ul4GmzC0vbtgvuz9Q5o0fiW1gb75AZUpep615Cah9j8=;
 b=Py39lWFc1oReNzvHNdRXUA6zE6Mgv6rsxuPH47tqK043/utPYY8YSae5W1qenTBOeJ
 Q4CXRJsKspgRaY2GOtwruBWDufwttOWNG117Bj9J7737WqOe1vtp1qAENC8kfznVURbK
 Ao8kFzO9cWPyHt8q3RDop5hpfvO8WpQlZOC099mhBoQyW7oZkxuwIEMvuXs6pjcb64AG
 hnuWPCef86eKzyFfyypl0iBDy6Cj7SlM2sGgSoS2+N1XYb1Tp+YrgIzKB6LeyXZP4hmO
 eWlQ9UrslGubJggPmg2w6CmFF+378QJLYxrr8j/loDHY64PS05dJwkLwECv/JgQVZZOK
 eJcQ==
X-Gm-Message-State: AOJu0YzM0ETP21O2/yExfGZVrZgFwDEHm9wz9Bok9PEGl+cSkMYSXXxc
 cjRB8JP6Spyz3OIIH0QDIEgpPnhw6II7AhSLrJKpE55ztAjGFbjf2StFkcW6KIVOVCMNlF8OQDq
 a
X-Google-Smtp-Source: AGHT+IHGS6q0AE2aKgPC9AuhhQ1kq31o1d5Y7N1/ZPkDDigp8xpiNzkzyJ00v8kfp/ZdMPpNsmJ1Sw==
X-Received: by 2002:adf:e889:0:b0:337:c829:9838 with SMTP id
 d9-20020adfe889000000b00337c8299838mr744340wrm.69.1706279624730; 
 Fri, 26 Jan 2024 06:33:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/36] hw/arm/allwinner-a10: Unconditionally map the USB Host
 controllers
Date: Fri, 26 Jan 2024 14:33:10 +0000
Message-Id: <20240126143341.2101237-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The USB Controllers are part of the chipset, thus are
always present and mapped in memory.

This is a migration compatibility break for the cubieboard
machine started with the '-usb none' option.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20240119215106.45776-2-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/allwinner-a10.c | 49 +++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index b0ea3f7f662..0135632996c 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -79,15 +79,10 @@ static void aw_a10_init(Object *obj)
 
     object_initialize_child(obj, "i2c0", &s->i2c0, TYPE_AW_I2C);
 
-    if (machine_usb(current_machine)) {
-        int i;
-
-        for (i = 0; i < AW_A10_NUM_USB; i++) {
-            object_initialize_child(obj, "ehci[*]", &s->ehci[i],
-                                    TYPE_PLATFORM_EHCI);
-            object_initialize_child(obj, "ohci[*]", &s->ohci[i],
-                                    TYPE_SYSBUS_OHCI);
-        }
+    for (size_t i = 0; i < AW_A10_NUM_USB; i++) {
+        object_initialize_child(obj, "ehci[*]", &s->ehci[i],
+                                TYPE_PLATFORM_EHCI);
+        object_initialize_child(obj, "ohci[*]", &s->ohci[i], TYPE_SYSBUS_OHCI);
     }
 
     object_initialize_child(obj, "mmc0", &s->mmc0, TYPE_AW_SDHOST_SUN4I);
@@ -165,28 +160,24 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
                    qdev_get_gpio_in(dev, 1),
                    115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
 
-    if (machine_usb(current_machine)) {
-        int i;
+    for (size_t i = 0; i < AW_A10_NUM_USB; i++) {
+        g_autofree char *bus = g_strdup_printf("usb-bus.%zu", i);
 
-        for (i = 0; i < AW_A10_NUM_USB; i++) {
-            g_autofree char *bus = g_strdup_printf("usb-bus.%d", i);
+        object_property_set_bool(OBJECT(&s->ehci[i]), "companion-enable",
+                                 true, &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
+                        AW_A10_EHCI_BASE + i * 0x8000);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
+                           qdev_get_gpio_in(dev, 39 + i));
 
-            object_property_set_bool(OBJECT(&s->ehci[i]), "companion-enable",
-                                     true, &error_fatal);
-            sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), &error_fatal);
-            sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
-                            AW_A10_EHCI_BASE + i * 0x8000);
-            sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
-                               qdev_get_gpio_in(dev, 39 + i));
-
-            object_property_set_str(OBJECT(&s->ohci[i]), "masterbus", bus,
-                                    &error_fatal);
-            sysbus_realize(SYS_BUS_DEVICE(&s->ohci[i]), &error_fatal);
-            sysbus_mmio_map(SYS_BUS_DEVICE(&s->ohci[i]), 0,
-                            AW_A10_OHCI_BASE + i * 0x8000);
-            sysbus_connect_irq(SYS_BUS_DEVICE(&s->ohci[i]), 0,
-                               qdev_get_gpio_in(dev, 64 + i));
-        }
+        object_property_set_str(OBJECT(&s->ohci[i]), "masterbus", bus,
+                                &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(&s->ohci[i]), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ohci[i]), 0,
+                        AW_A10_OHCI_BASE + i * 0x8000);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ohci[i]), 0,
+                           qdev_get_gpio_in(dev, 64 + i));
     }
 
     /* SD/MMC */
-- 
2.34.1


