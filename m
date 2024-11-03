Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6921D11041
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7al8-0006Yw-GU; Sun, 03 Nov 2024 08:35:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7al1-0006OZ-I1; Sun, 03 Nov 2024 08:35:07 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akz-0001Oo-86; Sun, 03 Nov 2024 08:35:07 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so392521466b.0; 
 Sun, 03 Nov 2024 05:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640903; x=1731245703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cFBJ0zSZIctgQGXUV1/Dx5zv1vWYaeefYYPzCtjTK4k=;
 b=O6wYNxwy8VD5DPeJeIS74b3j+JXMI0JQztfge7aQzdQnu4qq/PSZrKffsKpT2YQRQx
 vecJVrgJBQiPtSgfpOltt0BfEn7JUbxfwjZSAcRXFMBH1Qo8A8608LaCgm3rC549gB4u
 zgYklTdS9dlVfkrGl5XqFrcC48AC4JererqSpr7tjZme3eKKdzRQLwgVXrsj1L73Ly88
 KPxnBVM2l7a51iXjiukN/qw2OMVmgNHlOGzhgjbKdcLWj1MdzttDedF/0rZy68ZLqP4q
 Bklq8uQa+Gu4UpdV4l+iD6Ey4GnsjkQG9U1/W3pYhShcPOgM21wmce8x0DVleS/ugZ+l
 k4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640903; x=1731245703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cFBJ0zSZIctgQGXUV1/Dx5zv1vWYaeefYYPzCtjTK4k=;
 b=EtEcRFQ9wNti8z623WSBB0ncG6gBSt+vh9gY65vEsR+CQXnLURXrrRwP5j9cuvstjB
 IAs8DaUWD0zT0g+/EdVvyuhIznywyEnhNU+2J73s6yPax5cinix9a4TP1dKAYUxh7iv4
 5bev1isr0WxEtzizmPd6Y5/8AUGKdeCmoIWLwoMb3XvnTyxA9KWmEECdsykB7KE+nrTT
 W7F84DiVFvjXqe7EoP3L24Wi4MTG/PT3fgB22x/gfKRhPyjceURcaaT6glGj2qF3PhPs
 GhJHt4UEHGQowG1NQzKgDBCysKqnXE3GBPRdPksLw4DXW9kiKqVV9DpumIk3qKvDJzoJ
 UvKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPKtYwURpRlSgYnrZA1Ev/bE+5gZl8PEf9VVrdYdoESlrIAEOxtYFySivIRK5bJOnlzZyv6SbHS5Y=@nongnu.org,
 AJvYcCWHmwYwcxBkUg1uUGzX9gekTEjLCqhEw5s9zzwxzXxyxsaWgqP7ClO+DbibecLG89q1GOL63spY1dSf@nongnu.org
X-Gm-Message-State: AOJu0Yw7EViXtxrHAxru4C/ZmrBul666uOtq1dBcxnkI8oOQ1DG22Rxw
 /sdFY66muCU1oTCwnf9XnwH9hXlvDVAlNKYSR//qJkUxpINbkX+LXHDGfQ==
X-Google-Smtp-Source: AGHT+IFXj4j0Y10H5LIqoAwEtBBXj8psWXexpBTdoBmJgcDSvBL0d2TxaOMfGXPblOzLFo/UvK0uug==
X-Received: by 2002:a17:907:6e8a:b0:a99:5021:bcf0 with SMTP id
 a640c23a62f3a-a9e3a61eaa2mr1641429066b.34.1730640900969; 
 Sun, 03 Nov 2024 05:35:00 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:35:00 -0800 (PST)
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
Subject: [PATCH v4 14/26] hw/pci-host/ppce500: Prefer DEFINE_TYPES() macro
Date: Sun,  3 Nov 2024 14:34:00 +0100
Message-ID: <20241103133412.73536-15-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
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
 hw/pci-host/ppce500.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index d7ff2ba778..2dded696aa 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -21,7 +21,6 @@
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
2.47.0


