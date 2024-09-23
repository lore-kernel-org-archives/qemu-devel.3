Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B47ECF9C5B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfQL-0005pO-Io; Mon, 23 Sep 2024 05:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPy-00042u-LM; Mon, 23 Sep 2024 05:31:42 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPw-00072Z-F2; Mon, 23 Sep 2024 05:31:42 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9018103214so599346466b.3; 
 Mon, 23 Sep 2024 02:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083897; x=1727688697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=30eSo8wCFe2NZUhIuWQhfIj7OMLCKiEi3QH07KcC8x4=;
 b=i/TFk/XowvGZ/frzUMxod7uB6tbasZRpJw+80z8wr/rGP+k6A5b3IAuK/vgW+vOj8O
 CV2Nd8B72JSOJmuvupvg7eKTgavUmY1ImpzrL0540p517JOrg8G++sNPJP6Z7GIRTG0z
 pVRhotYZsnfsbNdeNIWKO+QZ+tW5RdWcIwkjbIb8ZmUov9EG4L/aEVLUPAle/ZAAVscU
 lsaJMrFUw+1NT9QQlEuAJuJZVoGgjQQ9k2SPv5SUFnQ+Qa47DuRubdJeUsbWlcFdz0M8
 Z1P7sYKdfUp5WoB7iaj5KrUtpv+MJdEuNirRAw/cYV17fb6VmsQ5CVRh6nAlVT3u6u8M
 5CEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083897; x=1727688697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=30eSo8wCFe2NZUhIuWQhfIj7OMLCKiEi3QH07KcC8x4=;
 b=w1/n5j2cXRtUhRXwBYAPTHqLqBAoJuHZ7Elo3/H4Nu91W7z2SvCwKWTBhJMCbGbCJT
 Q102dkSdly7uFR/s1O3AXSn5eEAoPgfZJTvRHfsTmhV3K4oNXFlSbSwZaS4URTIUZe86
 DA8VWJn5TWJZJOr+slMpwX0UC2G0GG93Imx1lBce/VA01HdGkwrbji1Ily3xoYQsIfnt
 wJ5WCZP0EY9RN0Ze6RlZORlCeyIn7gjCOC2B9TXJd43jyvuxhgffc29+uM7i2BeBzhlA
 NadczrkguOWK28Byl7GD0UEFWTt7o/5iIghxcZnZZBpBhHc+4Di8D7iSbXC/0GOXPoyK
 flsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3868bDJJXHK5Guf1h5YO47t4DHfRAkNNHyZoaPIMAh3C3nAXPrmjRFZ5YzLlQcMiQ0cw9/ofQtCA=@nongnu.org,
 AJvYcCX7ZKsAvSXX+yeUDKt+micY4stGnT9FCGdAGytvwGzmYpXeBgPGlIKXniRTBmLcGkbXSvfTi9Obg6HG@nongnu.org
X-Gm-Message-State: AOJu0YzGv/B9G//3PCUGrs9vyb42pLtDTTuwRFt8BIwSyaHfqGPRYCor
 ItGMjKEGg9QrCYjdUFGsXE83iZOgx25ZF/8wQ+SIP5AxKnF5d/VKKMv/ug==
X-Google-Smtp-Source: AGHT+IH5LZepyt+o7dPH941kY+02WS75I1ORGhmukoVSfVBAFZh6YGn5Gsyx2vJZv3ycCXenhdkJnA==
X-Received: by 2002:a17:907:1b23:b0:a86:88f7:679c with SMTP id
 a640c23a62f3a-a90d592576fmr1244998366b.41.1727083897230; 
 Mon, 23 Sep 2024 02:31:37 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:36 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 22/23] hw/usb/hcd-ehci-sysbus: Prefer DEFINE_TYPES() macro
Date: Mon, 23 Sep 2024 11:30:15 +0200
Message-ID: <20240923093016.66437-23-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
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
2.46.1


