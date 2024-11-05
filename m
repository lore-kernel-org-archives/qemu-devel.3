Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FED0D3E77D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SMb-0007kM-28; Tue, 05 Nov 2024 17:49:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SMN-00074m-DN
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:49:17 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SML-0004MS-Oj
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:49:15 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4314b316495so51661595e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846952; x=1731451752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DyXqCeyMzyWMkXhGNoMD/O7V9r2xwBHmziMl2tzMzbw=;
 b=MfQFXp0keDznGXT23gWaA4U0Yr+ufvbGT7/tZPAsB/jHUIEJ4cQ9mL1RHYjLf9EDF2
 iyXCHEXA9JexbmjczBs3PemKl4S1JJw9n5Lrmv5Kj4Z9R5iLaGpsuBbksT4LNdO5cZ0Q
 8B3mUFhjP/tYnYKJHdr2cF4UcyG0NEDzzDd276JW7ZebdKkoCzehv9BJOO0pxlOzeqdk
 rwx/cEIQge2JCd2fK7xphV6vO0yuejeOS7+/GBteF/ZQ2zOBoApd91eabPkeErzvGMv5
 W5b5HoomCdkNyIo1VQ0T1LmN1eaV0GPmDg03+jAbjBMHcBprgYBBa6Ccqz/v4wbqzRVj
 2rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846952; x=1731451752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DyXqCeyMzyWMkXhGNoMD/O7V9r2xwBHmziMl2tzMzbw=;
 b=sa2JgrmHdcG3WbtOSBfql1iSxDhCq7rjJ3OPlkDIOpz40VdXtc0DvbRoT39jKU+rB7
 5uOc37IJndzmB7HNIDh4l03n11h+4PzSOtnOTn6tXHArlCFDDneLI+gRg84P+1A081tD
 HjO9KBbvJEEfERR2NuDEEwK9p+UUA7dsfciITsr/+KUlQ7YAVOvw13s/IDIE/HpCat1Y
 bz6VlQex9xwbYDCQKNiIacPhX+bJskFKriydZdeUs3mbTyuZFj7QgUPC7fTigFQURfi4
 M3vkRezZOAF7mq5mNRW5ayViYYpKgOIa46oOBguzUCnSwg+PBdTEWf9t2ML4dVwrc2o4
 TX1g==
X-Gm-Message-State: AOJu0YyZX4TELJ5RR1NktOJ3CJK0d1OY2Xz1WS9R/joujXWVm1ThoiT/
 YWtBEg+W7BxBMcCvZyxey9yTra3RmdeCMtVnyTG9Rcl3B6koLrXpst57Bz9kj+4Kz6Wg+zmUvd6
 oQKnC/g==
X-Google-Smtp-Source: AGHT+IHx8w8/Ivhuk0c5m+8Hwa0ITnPaSB/JmIJV1riqX19J3h5p+S38zUSphSXE1Ulg0bd+GA3DWg==
X-Received: by 2002:a05:600c:a08:b0:431:4a83:2d80 with SMTP id
 5b1f17b1804b1-4327b6c1c78mr199565295e9.0.1730846951699; 
 Tue, 05 Nov 2024 14:49:11 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa70a1d8sm984705e9.27.2024.11.05.14.49.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:49:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/29] hw/pci-host/ppce500: Prefer DEFINE_TYPES() macro
Date: Tue,  5 Nov 2024 22:47:17 +0000
Message-ID: <20241105224727.53059-20-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20241103133412.73536-15-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/ppce500.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 5a4a924a2f0..b70631045a0 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -22,7 +22,6 @@
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
 #include "qemu/bswap.h"
-#include "qemu/module.h"
 #include "hw/pci-host/ppce500.h"
 #include "qom/object.h"
 
@@ -508,17 +507,6 @@ static void e500_host_bridge_class_init(ObjectClass *klass, void *data)
     dc->user_creatable = false;
 }
 
-static const TypeInfo e500_host_bridge_info = {
-    .name          = TYPE_PPC_E500_PCI_BRIDGE,
-    .parent        = TYPE_PCI_DEVICE,
-    .instance_size = sizeof(PPCE500PCIBridgeState),
-    .class_init    = e500_host_bridge_class_init,
-    .interfaces = (InterfaceInfo[]) {
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { },
-    },
-};
-
 static Property pcihost_properties[] = {
     DEFINE_PROP_UINT32("first_slot", PPCE500PCIState, first_slot, 0x11),
     DEFINE_PROP_UINT32("first_pin_irq", PPCE500PCIState, first_pin_irq, 0x1),
@@ -535,17 +523,23 @@ static void e500_pcihost_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_ppce500_pci;
 }
 
-static const TypeInfo e500_pcihost_info = {
-    .name          = TYPE_PPC_E500_PCI_HOST_BRIDGE,
-    .parent        = TYPE_PCI_HOST_BRIDGE,
-    .instance_size = sizeof(PPCE500PCIState),
-    .class_init    = e500_pcihost_class_init,
+static const TypeInfo e500_pci_types[] = {
+    {
+        .name          = TYPE_PPC_E500_PCI_BRIDGE,
+        .parent        = TYPE_PCI_DEVICE,
+        .instance_size = sizeof(PPCE500PCIBridgeState),
+        .class_init    = e500_host_bridge_class_init,
+        .interfaces    = (InterfaceInfo[]) {
+            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+            { },
+        },
+    },
+    {
+        .name          = TYPE_PPC_E500_PCI_HOST_BRIDGE,
+        .parent        = TYPE_PCI_HOST_BRIDGE,
+        .instance_size = sizeof(PPCE500PCIState),
+        .class_init    = e500_pcihost_class_init,
+    },
 };
 
-static void e500_pci_register_types(void)
-{
-    type_register_static(&e500_pcihost_info);
-    type_register_static(&e500_host_bridge_info);
-}
-
-type_init(e500_pci_register_types)
+DEFINE_TYPES(e500_pci_types)
-- 
2.45.2


