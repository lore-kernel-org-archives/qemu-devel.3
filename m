Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE1EE677FC
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E16-0003Kt-Jl; Sat, 02 Nov 2024 09:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E10-0003FR-0q; Sat, 02 Nov 2024 09:18:06 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0y-00023F-5Q; Sat, 02 Nov 2024 09:18:05 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9a2cdc6f0cso397990366b.2; 
 Sat, 02 Nov 2024 06:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553482; x=1731158282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8EgEQlxpALUpuI+hbJduRS0cA3mxUkzxDFRDbbfbr3U=;
 b=i4fzzXvdDphOF9pTttn6gQaVKk2Ac0g3BFeJn2SF6LKMExMrE/8ujG+iH8IHwTumIO
 djFVUC9zg/Sw4GnCwiS1eoyVX9QoWJ6IgTs67Zb4RU5uWGwWFl5EB/xB/sRxdEraERSh
 8/xsrNRRhk4xZ1DoxMR5+6P63EcUUnHHczQgDhoGPbMyWfkAP1EMhd/qzXjd1C3GPoZm
 aPQdEdSOFK6qB0UEeNS2rmh+vR65+bV5PFB/tkOr/Dm6es5Tz2hb3S9i1lHvCQ7xRCKG
 vO/1lznzL4iZA0knret14KDHhxC/WP3uSTzXBkWX/+klF+1wIcQqViXXlxcJSSB8IkJ9
 ZHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553482; x=1731158282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8EgEQlxpALUpuI+hbJduRS0cA3mxUkzxDFRDbbfbr3U=;
 b=lWuw+gP8W7bKc0tYv8eD23mac3c8H1j3CJXMRJUlJGR4iEeGbL3kPGXvUfori1F68c
 jK9jDvvIWqkiQsiPMDtY4aJK+JV4wHL/Lcgb0WqSCPIroSDM2szfsFuqlAO1dk6WCnFe
 9CvjGNVDy1wkjrFcS4TFLgjSQzHoHB/2PVgcFloqd6iNjQaksouV2k4gx5ARCalmRx7h
 MWWatoMhhqxviFN1RV/m5CLVToWCVSsSF8XY9UtOymMkpvDmvi8p43raidCnmAYrTrMV
 d325f6zXuxq3S4XpUS5jdb2yfKalgM5aXIraMBrv11o/nLbN1XxQRKEfnlnrRIEsiB6y
 IyhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJmO36dNkRjYajBnggPKv2WnZFL+mCEYYpB5rGUWn9lNbFv64VytDIAYgN8WXVpHpeccFZ9nxGuag=@nongnu.org,
 AJvYcCXnDAiRSgtwMGKFkIp63vE/fbvPIamMyiuWRWk3ixhG9UZ5EHnUzqgA3aOpJDiurKfZQOivdpoLRTBD@nongnu.org
X-Gm-Message-State: AOJu0YxoXYWj6uythZwrh4qa2MHqFad0uGSqjUJe9Prt4EIJfFCIFR2u
 P+tvROXGnYXXoBoDIzq/aZjqMzVjLwxxMfXc7tmOfZnvuUgx4U6RHbifGg==
X-Google-Smtp-Source: AGHT+IGjYismwkMa8WykNrz3odcA+GIEeIv28ItGF69z4MfB05nvmt9eDudRgDFV7r80fyLbyOkNXg==
X-Received: by 2002:a17:907:72d6:b0:a9a:14fc:9868 with SMTP id
 a640c23a62f3a-a9e5089b6b2mr873736866b.4.1730553481475; 
 Sat, 02 Nov 2024 06:18:01 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:18:00 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v3 24/26] hw/usb/hcd-ehci-sysbus: Prefer DEFINE_TYPES() macro
Date: Sat,  2 Nov 2024 14:17:13 +0100
Message-ID: <20241102131715.548849-25-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/usb/hcd-ehci-sysbus.c | 118 +++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 68 deletions(-)

diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 2b1652f7a8..87a3bebe3e 100644
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
+static const TypeInfo types[] = {
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
+DEFINE_TYPES(types)
-- 
2.47.0


