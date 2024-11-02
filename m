Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4C4E677FC
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E15-0003KJ-Av; Sat, 02 Nov 2024 09:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0m-000372-Te; Sat, 02 Nov 2024 09:17:54 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0l-0001zV-AR; Sat, 02 Nov 2024 09:17:52 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c9404c0d50so3216098a12.3; 
 Sat, 02 Nov 2024 06:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553469; x=1731158269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0Kw1RPTj8Nz7cZMeaQp/Ezl77GlQeYj69gIDIMTTxE=;
 b=eEBU0QWITOgVeN8Tk3NJFZG8+LeWrlwBLZqMyZykuF5ei3/z/jZQ28iSek4h7Zvwut
 k7Rv4hk5Mnm+kFsM2k7XZ0LzQb9rSgYkQ5qw3Fna5yNLmccVpyElHvr1gW8GjI2IPUeO
 A2vS7kKGsicJEdnhFLq0pnMqjxYiypeINcrEdKnrP3NKZ/wB5YGLW8qX/7NvGsyd6HN6
 Fpy1T8wdQv4RqF+e0Nq5iGZU9i1osUcsMUnFg/WS+fReuPvrjt59bjr9Dd8g0EtrOCwq
 4UAHcGTmiWodHBDf8sNwAXHT8Q4ACW/8QGzse2zAqDRwFGggbbK4w4H8v+/1jnWvNsE1
 XewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553469; x=1731158269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J0Kw1RPTj8Nz7cZMeaQp/Ezl77GlQeYj69gIDIMTTxE=;
 b=T7e+sBrQzvED8ZRy/IhOGl33FXi0CvURV+YgGlfVDdB3/oIT4DjmHEH7tgTElfKLIx
 qNGwyxYyGa8kGXkn/4Dg/dT/gQ0bfYfPZh1DQ/3gTdc2Bd1Xo73TWjJND35kaf7mReK+
 B/I+2wKWh2kfvsNK/++aEKUhqEmg7KM1N76KlcnVi1O2cowB0VRZkHC2878NMr6S3oSp
 09RpEouG//fJvZcSqaiQrj7aMpcOoBvQTyuqwdfCIpO8jHbeNzq5/RLv8q9bibPBGGBn
 DD5L+3ILFx518BhKMJXiXwVYp1bVuK5Vr2OLiT5vfGG/p9VsZsxgMs2Vygtyz3Ij5Kuz
 9pGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX6a9MNm7NDHM3PwF8ivgJxqcTk7Y2gIRlaxBF1vQgQMN8YCv/DwXI6voSQngcQbG5FyFKnlMRDZs=@nongnu.org,
 AJvYcCXDBhtdk4pth9ohkgfK+I9PSYAArQr2IQ9Mst5b3z+4MnMjjCQhddYq7C/B6CQaJ8dC9dQeo98RZ+hG@nongnu.org
X-Gm-Message-State: AOJu0Yx6d6BtWVj2NSNL5EC87OJwfdhzNeiNcGfzcmKnNdZ26Q7ufDT7
 nAzaHLsTGNQq0EkJnyE39mKBdKl3enbuLCSo0fwFYGCNxI7m6iIIhK+CxA==
X-Google-Smtp-Source: AGHT+IELY7UBHI4VOSJQkl3jqiquusfrGZoRJ2Dd/2s2Om+3vynANJgOG8Xe7wml05gqO6OJ4UfywA==
X-Received: by 2002:a17:906:c106:b0:a99:ff43:ca8f with SMTP id
 a640c23a62f3a-a9de5d659cdmr2566919966b.10.1730553468807; 
 Sat, 02 Nov 2024 06:17:48 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:47 -0700 (PDT)
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
Subject: [PATCH v3 14/26] hw/pci-host/ppce500: Prefer DEFINE_TYPES() macro
Date: Sat,  2 Nov 2024 14:17:03 +0100
Message-ID: <20241102131715.548849-15-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
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
index d7ff2ba778..1ce79ea20c 100644
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
+static const TypeInfo types[] = {
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
+DEFINE_TYPES(types)
-- 
2.47.0


