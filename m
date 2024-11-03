Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FD9D11040
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7alG-0006iz-S9; Sun, 03 Nov 2024 08:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7alC-0006dn-Iy; Sun, 03 Nov 2024 08:35:18 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7alA-0001XS-QP; Sun, 03 Nov 2024 08:35:18 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5cebcf96fabso2304244a12.3; 
 Sun, 03 Nov 2024 05:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640914; x=1731245714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hys/7KjvfIPIAYUIaZOYNBC8Ed9q/VILcwQ4ObN64sY=;
 b=h1/YkUMgCeR2g72D97l70MLgGnAzrXnh84qbxup/wgwXJbqQ4TiDIXp+GclcraKlA+
 qwfyMXs48m5M6tQM+wUMS9GCSIjAO7/tp4dryAQAQzrcx+XK9zwj6gK055h9FZXgqujT
 MWKO8798kt9zRAuHaaQmmWijOF+fyGPWYjkz/dfyBiynsqV08lPCOlTE5sjSts9OV7kj
 IxJmdbhE3seHOcG3dB1qrp3gLoGAe1zhG0w/isGvnDHOzzNHV4GaENeuv3QF7gsT5z5Y
 S7UKfT7CqXTRHv4Yz0B8ySybhOrTU4UPUd8x/bU1aN5lHm3ebgUrr5uDgjHymMw/xSx+
 wVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640914; x=1731245714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hys/7KjvfIPIAYUIaZOYNBC8Ed9q/VILcwQ4ObN64sY=;
 b=KCfbuOUcyv0D4dHk9yf4KCi1mfVeqr8JIqnvWhT3HhZA2aLWCim76Y0M1vsiRby45k
 7mJDxpk6DkmotPAg4JCldiAeftO7q6Y59Xp5pEgLmipmoJpH35YQoibwCiEA4HVYoCuJ
 PsbNUOLSDHL0a/5S/5dSstkPc+Ryb8Q2WSxZoaokRIZyimwMxk/cybCIxs+5jgVQzFNx
 iq2/SteT8qWq/0xYEnjBSUBHF7NAxcHTHrjErPujwjQlLo7cDdFaOpjA9A+QZGS9SEhO
 44mFxAH4Duzb9b6rNRHQW8DwBFH3Rk1fOWhYFrFMDbdCO+ohg67KkEdo1rvV9Vdx51Vm
 1rwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxii9lc4FUi8l6+ki6iQJ4VOSab86PNuEo6c6IpTuPRthtwj0zO0MpvaerFbgenOxNsHgHq0tLNaQ=@nongnu.org,
 AJvYcCVATMhQ4sAIg5UwQyhW6S/Nb30VER4nmzb5u5O8+tYP4CsLyso9esGkPxIX+M4vKwJnekrzA9m4DUkM@nongnu.org
X-Gm-Message-State: AOJu0YzV3hk4fGBy/6ly/yIkCO5utESfZJu7l4xnlNRBKamuF9FyEACA
 VotEdKwXd4qxYHVQRJ/fPvBQYYSI57U7Q9x8+p+tSk6xDFRMLeNpXY9wDA==
X-Google-Smtp-Source: AGHT+IHwqqTdl88p6B2thIs7lnXeozEZZcKdLjFr19fMDQeKLzhh4hmeXCQPtJHMoudFFufGJhWU8Q==
X-Received: by 2002:a17:907:6e94:b0:a9a:67aa:31f5 with SMTP id
 a640c23a62f3a-a9e508aaa56mr1256145166b.10.1730640914015; 
 Sun, 03 Nov 2024 05:35:14 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:35:13 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v4 24/26] hw/usb/hcd-ehci-sysbus: Prefer DEFINE_TYPES() macro
Date: Sun,  3 Nov 2024 14:34:10 +0100
Message-ID: <20241103133412.73536-25-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52f.google.com
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

The naming of the TypeInfo array is inspired by hcd-ohci-sysbus.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/usb/hcd-ehci-sysbus.c | 118 +++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 68 deletions(-)

diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 2b1652f7a8..eb7df93ac2 100644
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
2.47.0


