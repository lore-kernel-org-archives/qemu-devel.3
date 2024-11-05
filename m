Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C8FD3E77D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SNf-0001ql-2r; Tue, 05 Nov 2024 17:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SNC-0001GM-2d
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:50:11 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SNA-0004Vf-5k
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:50:05 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43159c9f617so47277835e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730847001; x=1731451801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZBNgReI8SUv50NFFndKDx8AuBJGKT1IeMS1OHe8BPE=;
 b=qYuKo+8VQDMN4lRAVZAnDH+U6yf3Frod8t5C9Bj4n0rHRhD38FKev/CKE9eEnGQBNO
 wqF65WXc+CZAmgUPHEFTFwL5bI91AqnDyLxAMYt69VQmBW53M6dlYXoD5DzaDk9jJ94n
 lcRt7q78Ayb6kYjbJrmlK0BXmZmOtdAdSkPrqvBRzsmdY4zUCpTyAQJy22pY/o/UizCa
 e1gCZuOxR2XCKa4RMLWSZfZEFFykuhpMjr9rAN9FrfeBKO8kfxZ1sV39XcSX2odVDxZ1
 uYqmJLq1Oi2hQHQQA+abLi2/B8yUpjqB5SA2vhKdk4o4aPkJEjhqKMT1EO4R84U42onX
 902Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730847001; x=1731451801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FZBNgReI8SUv50NFFndKDx8AuBJGKT1IeMS1OHe8BPE=;
 b=sUEhlrT5lg/nmlTZNC2Pc29eqbf9NvJl3W7/MFDoVYTg8Y0s0HuaQ5DHhv9lrntab8
 jlwtRyyQOieGzCZFCGR96f6smk9a+Z2pO5xrl/RRsKr2u9JrKKUAhRZy+TJ0HeRak/Cp
 o50fJ/C1S14aZb16PFSZAkm1s6sG2BudeqE0YlhzoJF4roo3mHiGN+1LebIK1sdQQ0On
 wLELugS7Mq+EruAC+b38k43YYwIYYlpf57AYQl9OPh6xC2ObBYe1WffgQk2eyS861WL6
 i4SsgOdHBThZNATY5O4lyQHjspewrdBCLRA+uGi8+5Fnm2twEUHSUjEW+40PQVkAx63Y
 40vw==
X-Gm-Message-State: AOJu0YzqbmfAaxDQHXhxW7d0MfkMI2bYqCB2/yVUu+GWOBUprGn1ZbGh
 vAgITCrWaYsBIGMQDAWLUKPr5igCOG5YFpOzKTAMcvxnU/+21rPaERRQdXEEC8OAeVBIPcccfK0
 X9FqlRQ==
X-Google-Smtp-Source: AGHT+IHG+aGkTksvzwhpNcCEZ2DioZMrm8mtadoSVauStNEXoQM/F7FVnFcbHTKaaaUkZY4ZP4acBA==
X-Received: by 2002:a5d:4bc4:0:b0:37d:528d:b8ad with SMTP id
 ffacd0b85a97d-380610f830cmr27452621f8f.6.1730847001241; 
 Tue, 05 Nov 2024 14:50:01 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e5cbsm17470035f8f.80.2024.11.05.14.49.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:50:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/29] hw/usb/hcd-ehci-sysbus: Prefer DEFINE_TYPES() macro
Date: Tue,  5 Nov 2024 22:47:26 +0000
Message-ID: <20241105224727.53059-29-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

The naming of the TypeInfo array is inspired by hcd-ohci-sysbus.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20241103133412.73536-25-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-ehci-sysbus.c | 118 +++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 68 deletions(-)

diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 2b1652f7a8b..eb7df93ac2d 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -19,7 +19,6 @@
 #include "hw/qdev-properties.h"
 #include "hw/usb/hcd-ehci.h"
 #include "migration/vmstate.h"
-#include "qemu/module.h"
 
 static const VMStateDescription vmstate_ehci_sysbus = {
     .name        = "ehci-sysbus",
@@ -97,17 +96,6 @@ static void ehci_sysbus_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
 }
 
-static const TypeInfo ehci_type_info = {
-    .name          = TYPE_SYS_BUS_EHCI,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(EHCISysBusState),
-    .instance_init = ehci_sysbus_init,
-    .instance_finalize = ehci_sysbus_finalize,
-    .abstract      = true,
-    .class_init    = ehci_sysbus_class_init,
-    .class_size    = sizeof(SysBusEHCIClass),
-};
-
 static void ehci_platform_class_init(ObjectClass *oc, void *data)
 {
     SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
@@ -118,12 +106,6 @@ static void ehci_platform_class_init(ObjectClass *oc, void *data)
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
 }
 
-static const TypeInfo ehci_platform_type_info = {
-    .name          = TYPE_PLATFORM_EHCI,
-    .parent        = TYPE_SYS_BUS_EHCI,
-    .class_init    = ehci_platform_class_init,
-};
-
 static void ehci_exynos4210_class_init(ObjectClass *oc, void *data)
 {
     SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
@@ -134,12 +116,6 @@ static void ehci_exynos4210_class_init(ObjectClass *oc, void *data)
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
 }
 
-static const TypeInfo ehci_exynos4210_type_info = {
-    .name          = TYPE_EXYNOS4210_EHCI,
-    .parent        = TYPE_SYS_BUS_EHCI,
-    .class_init    = ehci_exynos4210_class_init,
-};
-
 static void ehci_aw_h3_class_init(ObjectClass *oc, void *data)
 {
     SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
@@ -150,12 +126,6 @@ static void ehci_aw_h3_class_init(ObjectClass *oc, void *data)
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
 }
 
-static const TypeInfo ehci_aw_h3_type_info = {
-    .name          = TYPE_AW_H3_EHCI,
-    .parent        = TYPE_SYS_BUS_EHCI,
-    .class_init    = ehci_aw_h3_class_init,
-};
-
 static void ehci_npcm7xx_class_init(ObjectClass *oc, void *data)
 {
     SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
@@ -168,12 +138,6 @@ static void ehci_npcm7xx_class_init(ObjectClass *oc, void *data)
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
 }
 
-static const TypeInfo ehci_npcm7xx_type_info = {
-    .name          = TYPE_NPCM7XX_EHCI,
-    .parent        = TYPE_SYS_BUS_EHCI,
-    .class_init    = ehci_npcm7xx_class_init,
-};
-
 static void ehci_tegra2_class_init(ObjectClass *oc, void *data)
 {
     SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
@@ -184,12 +148,6 @@ static void ehci_tegra2_class_init(ObjectClass *oc, void *data)
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
 }
 
-static const TypeInfo ehci_tegra2_type_info = {
-    .name          = TYPE_TEGRA2_EHCI,
-    .parent        = TYPE_SYS_BUS_EHCI,
-    .class_init    = ehci_tegra2_class_init,
-};
-
 static void ehci_ppc4xx_init(Object *o)
 {
     EHCISysBusState *s = SYS_BUS_EHCI(o);
@@ -207,13 +165,6 @@ static void ehci_ppc4xx_class_init(ObjectClass *oc, void *data)
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
 }
 
-static const TypeInfo ehci_ppc4xx_type_info = {
-    .name          = TYPE_PPC4xx_EHCI,
-    .parent        = TYPE_SYS_BUS_EHCI,
-    .class_init    = ehci_ppc4xx_class_init,
-    .instance_init = ehci_ppc4xx_init,
-};
-
 /*
  * Faraday FUSBH200 USB 2.0 EHCI
  */
@@ -282,24 +233,55 @@ static void fusbh200_ehci_class_init(ObjectClass *oc, void *data)
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
 }
 
-static const TypeInfo ehci_fusbh200_type_info = {
-    .name          = TYPE_FUSBH200_EHCI,
-    .parent        = TYPE_SYS_BUS_EHCI,
-    .instance_size = sizeof(FUSBH200EHCIState),
-    .instance_init = fusbh200_ehci_init,
-    .class_init    = fusbh200_ehci_class_init,
+static const TypeInfo ehci_sysbus_types[] = {
+    {
+        .name          = TYPE_SYS_BUS_EHCI,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(EHCISysBusState),
+        .instance_init = ehci_sysbus_init,
+        .instance_finalize = ehci_sysbus_finalize,
+        .abstract      = true,
+        .class_init    = ehci_sysbus_class_init,
+        .class_size    = sizeof(SysBusEHCIClass),
+    },
+    {
+        .name          = TYPE_PLATFORM_EHCI,
+        .parent        = TYPE_SYS_BUS_EHCI,
+        .class_init    = ehci_platform_class_init,
+    },
+    {
+        .name          = TYPE_EXYNOS4210_EHCI,
+        .parent        = TYPE_SYS_BUS_EHCI,
+        .class_init    = ehci_exynos4210_class_init,
+    },
+    {
+        .name          = TYPE_AW_H3_EHCI,
+        .parent        = TYPE_SYS_BUS_EHCI,
+        .class_init    = ehci_aw_h3_class_init,
+    },
+    {
+        .name          = TYPE_NPCM7XX_EHCI,
+        .parent        = TYPE_SYS_BUS_EHCI,
+        .class_init    = ehci_npcm7xx_class_init,
+    },
+    {
+        .name          = TYPE_TEGRA2_EHCI,
+        .parent        = TYPE_SYS_BUS_EHCI,
+        .class_init    = ehci_tegra2_class_init,
+    },
+    {
+        .name          = TYPE_PPC4xx_EHCI,
+        .parent        = TYPE_SYS_BUS_EHCI,
+        .class_init    = ehci_ppc4xx_class_init,
+        .instance_init = ehci_ppc4xx_init,
+    },
+    {
+        .name          = TYPE_FUSBH200_EHCI,
+        .parent        = TYPE_SYS_BUS_EHCI,
+        .instance_size = sizeof(FUSBH200EHCIState),
+        .instance_init = fusbh200_ehci_init,
+        .class_init    = fusbh200_ehci_class_init,
+    },
 };
 
-static void ehci_sysbus_register_types(void)
-{
-    type_register_static(&ehci_type_info);
-    type_register_static(&ehci_platform_type_info);
-    type_register_static(&ehci_exynos4210_type_info);
-    type_register_static(&ehci_aw_h3_type_info);
-    type_register_static(&ehci_npcm7xx_type_info);
-    type_register_static(&ehci_tegra2_type_info);
-    type_register_static(&ehci_ppc4xx_type_info);
-    type_register_static(&ehci_fusbh200_type_info);
-}
-
-type_init(ehci_sysbus_register_types)
+DEFINE_TYPES(ehci_sysbus_types)
-- 
2.45.2


