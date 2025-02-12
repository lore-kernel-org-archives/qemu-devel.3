Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B6EC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 21:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKNM-0005Sg-9n; Wed, 12 Feb 2025 16:34:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKNI-0005Gx-Sj
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:34:28 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKNG-0000aS-Nf
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:34:28 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38dc6d55ebaso898172f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 13:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739396065; x=1740000865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gWUMYVWKZSu2OSfc0MXilpdxQiaoa1PiI/aXL88osMc=;
 b=uWkkOoE+a06xCCFBx+DO8hToI3NbwyEkMzuvm8qWqz12Hxkz5nIXKoMeiL/ylpIUL5
 L5r/G4MMUV8aK5M1wzvbUd6cq/fpYKMd5yKgN9ZeHpDTSNshBgvIeDzmkANAHHw/XHKp
 +M8cmkztv59bpv1H40x3C0XUkgt3IshW9t6YxZwBWDaIQ56Ufjz8Lur+2RMMRG5cii/S
 oPi++1/GJFNX5v8pSfuiD2OzL9H9RLzaDPPSXyzCBZ2zcxxT6mcnv1cU1M21j/VyzO5z
 M+0D+lnV2XNzYaYkfm3LeCRh+7poXJAFMQq/8GH+ndqZxlAIg3zgSfxJBhEWEw+wt2/M
 XrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739396065; x=1740000865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gWUMYVWKZSu2OSfc0MXilpdxQiaoa1PiI/aXL88osMc=;
 b=lwRINCF3SYnMT7C1nfl+oxhbX31SnufnfXLtTZ5fgn+d3SokciutXpcpaPq8ogqvis
 ED6UvGuy2a9Dgg0ikuPrnEyrZ76pqJWH5UfU6MHT4mydEfcOZKGTl0zDas/poje7O7uM
 MWAZmtU1KlCZxVBh4Hnlm/XfjYym5Yb6Yp7ubpqeNzgb/dB6cyYbROk6lSB0mfUQzFHm
 KYBtAbG+jOTDmy5uDfxcvfe5AAF+1ZOz2sCM4stf8p5NVFgcn52v4yzAA4IaF2+8Unqw
 UXqKnTyscw0dJpLYTe21CB4FK1GbD14g7pcMpGmXwJbHN45b47jCqhZhTKGVFl6Z2DWN
 e4Mg==
X-Gm-Message-State: AOJu0YymQ7dVk7GlKeaN+wyNbfiiGB9TTjkKLsZanKjj7+eBFo95wX8n
 BS4z8+kKRJZEg4jcrGvi6AWyZxXPZ3fb8VY/p1KV3/TzVlQptyRPsYzvC9RG3KPH4UwmVgcO6E8
 mD+M=
X-Gm-Gg: ASbGncukOLHEtrgtsY/v26p+fbDsybdaWR7txB7mpgu7ANg6O9RDUE1Z5kJDc2VFCqE
 6G92migahl4fuN1INVTgMxxkgXtRwamsIVRYLr3SYCHZmzudJibiSo1cyqxTwlm51ofBQ1OxjUP
 +gOOck40D4qTSZnKj7raYR9WVhMcTV4SlXkM0w7jz7CBs6x6zXEeql7D9AFr7g5vCRB10d0SnIr
 GgK/Rynm/S28mKBcrBpsKXyIZk/eopfLfwM9RrPVPA0gj0tGuPzy3QgvLsJtF13lgB6cOZcg1v0
 IHbkMm5O/05iZpPxJM6lRTHdqzrfoRMuKMX1DFgJiheA18uqD2HM8l183dTnFoN8nw==
X-Google-Smtp-Source: AGHT+IER81hBzlIvzMsEvHZz2n7YPOmC7B3RIPMUkIO4YO6lK/ZfxkOOdSvTecLfPq0Fh8tKtyDozw==
X-Received: by 2002:a05:6000:144b:b0:38d:b028:d906 with SMTP id
 ffacd0b85a97d-38f24f90c32mr287319f8f.21.1739396064911; 
 Wed, 12 Feb 2025 13:34:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259fe1efsm20089f8f.97.2025.02.12.13.34.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 13:34:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 18/19] hw: Constify various TypeInfo and associated
 structures
Date: Wed, 12 Feb 2025 22:32:48 +0100
Message-ID: <20250212213249.45574-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212213249.45574-1-philmd@linaro.org>
References: <20250212213249.45574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Constify various TypeInfo structures.

When they are generated from an array, also constify the array.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/e1000.c             | 12 ++++++------
 hw/rtc/m48t59-isa.c        | 22 +++++++++++-----------
 hw/rtc/m48t59.c            | 22 +++++++++++-----------
 hw/scsi/megasas.c          | 16 ++++++++--------
 hw/usb/hcd-ehci-pci.c      | 20 ++++++++++----------
 hw/usb/hcd-uhci.c          | 20 ++++++++++----------
 hw/usb/vt82c686-uhci-pci.c |  6 +++---
 7 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index cba4999e6d0..4436c2ce0cc 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1766,12 +1766,12 @@ static void e1000_register_types(void)
     type_register_static(&e1000_base_info);
     for (i = 0; i < ARRAY_SIZE(e1000_devices); i++) {
         const E1000Info *info = &e1000_devices[i];
-        TypeInfo type_info = {};
-
-        type_info.name = info->name;
-        type_info.parent = TYPE_E1000_BASE;
-        type_info.class_data = info;
-        type_info.class_init = e1000_class_init;
+        const TypeInfo type_info = {
+            .name       = info->name,
+            .parent     = TYPE_E1000_BASE,
+            .class_data = info,
+            .class_init = e1000_class_init,
+        };
 
         type_register_static(&type_info);
     }
diff --git a/hw/rtc/m48t59-isa.c b/hw/rtc/m48t59-isa.c
index 9e2f6563a0a..152208d931e 100644
--- a/hw/rtc/m48t59-isa.c
+++ b/hw/rtc/m48t59-isa.c
@@ -51,7 +51,7 @@ struct M48txxISADeviceClass {
     M48txxInfo info;
 };
 
-static M48txxInfo m48txx_isa_info[] = {
+static const M48txxInfo m48txx_isa_info[] = {
     {
         .bus_name = "isa-m48t59",
         .model = 59,
@@ -148,18 +148,18 @@ static const TypeInfo m48txx_isa_type_info = {
 
 static void m48t59_isa_register_types(void)
 {
-    TypeInfo isa_type_info = {
-        .parent = TYPE_M48TXX_ISA,
-        .class_size = sizeof(M48txxISADeviceClass),
-        .class_init = m48txx_isa_concrete_class_init,
-    };
-    int i;
-
     type_register_static(&m48txx_isa_type_info);
 
-    for (i = 0; i < ARRAY_SIZE(m48txx_isa_info); i++) {
-        isa_type_info.name = m48txx_isa_info[i].bus_name;
-        isa_type_info.class_data = &m48txx_isa_info[i];
+    for (unsigned i = 0; i < ARRAY_SIZE(m48txx_isa_info); i++) {
+        const M48txxInfo *info = &m48txx_isa_info[i];
+        const TypeInfo isa_type_info = {
+            .name       = info->bus_name,
+            .parent     = TYPE_M48TXX_ISA,
+            .class_size = sizeof(M48txxISADeviceClass),
+            .class_init = m48txx_isa_concrete_class_init,
+            .class_data = info,
+        };
+
         type_register_static(&isa_type_info);
     }
 }
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index 68be2dad6f3..967331401a7 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -66,7 +66,7 @@ struct M48txxSysBusDeviceClass {
     M48txxInfo info;
 };
 
-static M48txxInfo m48txx_sysbus_info[] = {
+static const M48txxInfo m48txx_sysbus_info[] = {
     {
         .bus_name = "sysbus-m48t02",
         .model = 2,
@@ -666,19 +666,19 @@ static const TypeInfo m48txx_sysbus_type_info = {
 
 static void m48t59_register_types(void)
 {
-    TypeInfo sysbus_type_info = {
-        .parent = TYPE_M48TXX_SYS_BUS,
-        .class_size = sizeof(M48txxSysBusDeviceClass),
-        .class_init = m48txx_sysbus_concrete_class_init,
-    };
-    int i;
-
     type_register_static(&nvram_info);
     type_register_static(&m48txx_sysbus_type_info);
 
-    for (i = 0; i < ARRAY_SIZE(m48txx_sysbus_info); i++) {
-        sysbus_type_info.name = m48txx_sysbus_info[i].bus_name;
-        sysbus_type_info.class_data = &m48txx_sysbus_info[i];
+    for (unsigned i = 0; i < ARRAY_SIZE(m48txx_sysbus_info); i++) {
+        const M48txxInfo *info = &m48txx_sysbus_info[i];
+        const TypeInfo sysbus_type_info = {
+            .name       = info->bus_name,
+            .parent     = TYPE_M48TXX_SYS_BUS,
+            .class_size = sizeof(M48txxSysBusDeviceClass),
+            .class_init = m48txx_sysbus_concrete_class_init,
+            .class_data = info,
+        };
+
         type_register_static(&sysbus_type_info);
     }
 }
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 03cd837b44f..ccd87fb0604 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2490,7 +2490,7 @@ typedef struct MegasasInfo {
     const InterfaceInfo *interfaces;
 } MegasasInfo;
 
-static struct MegasasInfo megasas_devices[] = {
+static const struct MegasasInfo megasas_devices[] = {
     {
         .name = TYPE_MEGASAS_GEN1,
         .desc = "LSI MegaRAID SAS 1078",
@@ -2569,13 +2569,13 @@ static void megasas_register_types(void)
     type_register_static(&megasas_info);
     for (i = 0; i < ARRAY_SIZE(megasas_devices); i++) {
         const MegasasInfo *info = &megasas_devices[i];
-        TypeInfo type_info = {};
-
-        type_info.name = info->name;
-        type_info.parent = TYPE_MEGASAS_BASE;
-        type_info.class_data = info;
-        type_info.class_init = megasas_class_init;
-        type_info.interfaces = info->interfaces;
+        const TypeInfo type_info = {
+            .name       = info->name,
+            .parent     = TYPE_MEGASAS_BASE,
+            .class_data = info,
+            .class_init = megasas_class_init,
+            .interfaces = info->interfaces,
+        };
 
         type_register_static(&type_info);
     }
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 38ad3406b32..5a96c15c67c 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -193,7 +193,7 @@ static void ehci_data_class_init(ObjectClass *klass, const void *data)
     }
 }
 
-static struct EHCIPCIInfo ehci_pci_info[] = {
+static const struct EHCIPCIInfo ehci_pci_info[] = {
     {
         .name      = "usb-ehci",
         .vendor_id = PCI_VENDOR_ID_INTEL,
@@ -216,17 +216,17 @@ static struct EHCIPCIInfo ehci_pci_info[] = {
 
 static void ehci_pci_register_types(void)
 {
-    TypeInfo ehci_type_info = {
-        .parent        = TYPE_PCI_EHCI,
-        .class_init    = ehci_data_class_init,
-    };
-    int i;
-
     type_register_static(&ehci_pci_type_info);
 
-    for (i = 0; i < ARRAY_SIZE(ehci_pci_info); i++) {
-        ehci_type_info.name = ehci_pci_info[i].name;
-        ehci_type_info.class_data = ehci_pci_info + i;
+    for (unsigned i = 0; i < ARRAY_SIZE(ehci_pci_info); i++) {
+        const EHCIPCIInfo *info = &ehci_pci_info[i];
+        const TypeInfo ehci_type_info = {
+            .name       = info->name,
+            .parent     = TYPE_PCI_EHCI,
+            .class_data = info,
+            .class_init = ehci_data_class_init,
+        };
+
         type_register_static(&ehci_type_info);
     }
 }
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 4822c704f69..9c671f53684 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1309,7 +1309,7 @@ void uhci_data_class_init(ObjectClass *klass, const void *data)
     u->info = *info;
 }
 
-static UHCIInfo uhci_info[] = {
+static const UHCIInfo uhci_info[] = {
     {
         .name      = TYPE_PIIX3_USB_UHCI,
         .vendor_id = PCI_VENDOR_ID_INTEL,
@@ -1371,17 +1371,17 @@ static UHCIInfo uhci_info[] = {
 
 static void uhci_register_types(void)
 {
-    TypeInfo uhci_type_info = {
-        .parent        = TYPE_UHCI,
-        .class_init    = uhci_data_class_init,
-    };
-    int i;
-
     type_register_static(&uhci_pci_type_info);
 
-    for (i = 0; i < ARRAY_SIZE(uhci_info); i++) {
-        uhci_type_info.name = uhci_info[i].name;
-        uhci_type_info.class_data = uhci_info + i;
+    for (unsigned i = 0; i < ARRAY_SIZE(uhci_info); i++) {
+        const UHCIInfo *info = &uhci_info[i];
+        const TypeInfo uhci_type_info = {
+            .name       = info->name,
+            .parent     = TYPE_UHCI,
+            .class_data = info,
+            .class_init = uhci_data_class_init,
+        };
+
         type_register_static(&uhci_type_info);
     }
 }
diff --git a/hw/usb/vt82c686-uhci-pci.c b/hw/usb/vt82c686-uhci-pci.c
index 61628061722..cd5ca9c8850 100644
--- a/hw/usb/vt82c686-uhci-pci.c
+++ b/hw/usb/vt82c686-uhci-pci.c
@@ -26,7 +26,7 @@ static void usb_uhci_vt82c686b_realize(PCIDevice *dev, Error **errp)
     s->irq = qemu_allocate_irq(uhci_isa_set_irq, s, 0);
 }
 
-static UHCIInfo uhci_info[] = {
+static const UHCIInfo uhci_info[] = {
     {
         .name      = TYPE_VT82C686B_USB_UHCI,
         .vendor_id = PCI_VENDOR_ID_VIA,
@@ -37,14 +37,14 @@ static UHCIInfo uhci_info[] = {
         .unplug    = true,
         /* Reason: only works as USB function of VT82xx superio chips */
         .notuser   = true,
-    }
+    },
 };
 
 static const TypeInfo vt82c686b_usb_uhci_type_info = {
     .parent         = TYPE_UHCI,
     .name           = TYPE_VT82C686B_USB_UHCI,
     .class_init     = uhci_data_class_init,
-    .class_data     = uhci_info,
+    .class_data     = &uhci_info[0],
 };
 
 static void vt82c686b_usb_uhci_register_types(void)
-- 
2.47.1


