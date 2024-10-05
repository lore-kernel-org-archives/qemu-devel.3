Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7DBCFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAkb-0005iw-Jw; Sat, 05 Oct 2024 15:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkT-0005aC-MT; Sat, 05 Oct 2024 15:47:29 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkR-0007ka-F1; Sat, 05 Oct 2024 15:47:28 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso41078795e9.2; 
 Sat, 05 Oct 2024 12:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157645; x=1728762445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+ds0AjfWm1BLDzVoFKcfUneoqAfmU7A0JJkdajhZMM=;
 b=GUV/+oky+zFP1wJGx4G7S8LMTGR1CAoEI9Bd/e6vROmfAoB/k9xQ+4acIgiUjxJGn6
 dPOyTZl2SAZFhYaPFlDbEt4VKAuae8reyun+AkyBG8P+x0+ehDiUOzTngSi8/S/4C5od
 /ZGIzg0khsKfR01egx8N5pxVcRQ84ipsPfSInkArf+/O+NQaQ/g/RKXKhMIH51HMrc2o
 ygEJvTNzRTT1PCmWsEXiUV4gca8j8x8Ub4A8qdDfmW5/pBkG26sFSq0HS0ZsiwUDWbb2
 reU0fOoX3XJPSWVaPaUub4WJ16ob+5ze9n/5sA5SQiIAeV0ASpcUCBPYcW+KcYH3Nwoo
 fJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157645; x=1728762445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+ds0AjfWm1BLDzVoFKcfUneoqAfmU7A0JJkdajhZMM=;
 b=wOwEOu7LMVWcTkNdb7OkijcoNXUnvsa5bv5mUj/daXTpevtP7+Bnol0Sv0zC5/DzSZ
 AT8k+lvHibHfxLwKKhNCF1syT6ya1pBpSLEdeHD4/jcAxkGIlBKHMqEwwUzNdW/dR6tb
 2SceZwbdKjRuE5Tp6ct68Q52vPyFknnyLR+IsEKUfwDmuTzyVeAdhs06nsJSzI04wdGF
 Gp68ImpbneRPx10elbbDeGgaMXmUPUOiZ1ubZcsBsmQjd1W7WEmyUCndhbgJBPZpLVYt
 RWXlspms2ohZoFG88oRZFxUhz2PQEjlz1bNNdlC/3CZU57TmVbSrFsWv9SsvY5iRLPjj
 0k6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcE4zh72FlS4rj11NzDH+R55ZgYYVnBfjBikvFDVYVn+XvbpFzg3pijJwr23EcEbQRn8MSmOgbvEmv@nongnu.org,
 AJvYcCVjQ/PUh97E9ApAc28/fT+IEyU/ky975nUuQZ4Qyy3jCvyCC5XanqUd9mw7fsWoADIxoB8m9vmxHN0=@nongnu.org
X-Gm-Message-State: AOJu0YzbUSxIkiW8hFJ2MINwwmKGb2gO2hZyaNyJwH7C64FD/Vu/N4kv
 7d9VEssSAgNEUacJgAI/xKXtdb5VHtASUUpTTu8bYA11jVhVNzaIYVzlBA==
X-Google-Smtp-Source: AGHT+IHQTEdgyboeDMKJIvP6gZk+8jyoasEg7+flxtNb8L+/Ps8gusx8Q8mWQoK0bMuu0rOSaIi2Uw==
X-Received: by 2002:a05:600c:3c9c:b0:42c:bae0:f05f with SMTP id
 5b1f17b1804b1-42f85aa98ddmr67367565e9.13.1728157644510; 
 Sat, 05 Oct 2024 12:47:24 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:47:23 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 22/23] hw/usb/hcd-ehci-sysbus: Prefer DEFINE_TYPES() macro
Date: Sat,  5 Oct 2024 21:46:02 +0200
Message-ID: <20241005194603.23139-23-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
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
2.46.2


