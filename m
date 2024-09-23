Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69A1CF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfPm-00039I-BV; Mon, 23 Sep 2024 05:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPj-0002yf-N3; Mon, 23 Sep 2024 05:31:27 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPh-0006zl-Si; Mon, 23 Sep 2024 05:31:27 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a8d24f98215so558192966b.1; 
 Mon, 23 Sep 2024 02:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083882; x=1727688682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mHGjpUSmV1BY/gesAqJRCAT6c0HlF78YEs0jV0SsyRc=;
 b=RezEmTP+0B9V9xAQlssH/HvqrlhtUVxB5C3jyeQwA+rWKt8Qw6Drf5kChjwSXQ6N3G
 0txnLf3P0eb7xMAdmxx2+6SckolIP6N3tSWUFuoGbwgy/xdWS2cXQuFtXEvfD9nmiVnE
 oZbP04aF4YBNda7X2FZr7F4mf1Zeiu6dQA7uMqKtvEeUu3nwgeZTiHW6iAntaNv110HU
 TlVsq5fRQjzRI06KdZcYTgHGJsneLuHK77UreWLRCdc+w+Jnzx+U8xULR7gMuitJlzJC
 bCuVlHMYH17h8FFcNbVi2JIxZ+kINP2H+KMa0LRHdGog5HFgeb7h6RJG8e1EoxgwUKcc
 epPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083882; x=1727688682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mHGjpUSmV1BY/gesAqJRCAT6c0HlF78YEs0jV0SsyRc=;
 b=rVg3ZMq0fYmn40JJ+MKLumcfvw4gc8Idee9gbaRbJURfP/lEOtzdT2iGtyABW7AqK/
 i7AVK8iBN4SjKuU6Z7fo3wd/+bWuqMbw+C0sd2jppq31HRua1d+ZfjURDvDOwjRhYHhc
 ohx4b/D2w7FMBPJXZTunzCDneIKSFPrjyVCx8ZVaZ6SWOheL6r6dxNWTggCB+4BPjnaZ
 EaigOHKbzw9Md5kPtYRQg0OPAXMRWJR2UtHPgJDkpuWTqw69j/5zYH8nWLN8ISm0Bclm
 w3qoeK7M0T+4MciT3BqEAiQmdPHsejf9KDaAnyUYbNwRx/pzfq6Sd1BifLyMBzWkAsE6
 d4wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrZhP0StLAXq9PjRTZVRnnD8+F4bPjz66U15j4oM2YWqj5jNGdfvTCAgAQalqcRcnDcgQnVyKxvsU=@nongnu.org,
 AJvYcCXTjghBkQC7b8qmGgYzX1dAxGIEPRBdlpBYSON/eAM6sUdVnQpKI8e9svSRMneTcnsyQazB+odtyxrw@nongnu.org
X-Gm-Message-State: AOJu0YxrddgaffZDTHBRik9BTdYsX5dizhzuS+HOy+1JA6CeolP5GXaO
 GZcL/6PR6gB7k07JuAmPKZlLRgNKNYEymJ/Vfh57AgRc5gRWha3ut7hFmA==
X-Google-Smtp-Source: AGHT+IE9itsyK/LlKe4r9Sa82Dr7vX3q9d1qBslDtDQJTMKiRyiljh/d26vV1d5PbCDgs7EEI/Z2ag==
X-Received: by 2002:a17:907:d2db:b0:a8d:f04:b19b with SMTP id
 a640c23a62f3a-a90d4fbcfd5mr1101262466b.2.1727083882399; 
 Mon, 23 Sep 2024 02:31:22 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:21 -0700 (PDT)
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
Subject: [PATCH 13/23] hw/pci-host/ppce500: Prefer DEFINE_TYPES() macro
Date: Mon, 23 Sep 2024 11:30:06 +0200
Message-ID: <20240923093016.66437-14-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
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
2.46.1


