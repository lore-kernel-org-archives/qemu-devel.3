Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B739BCFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAkU-0005Zz-0N; Sat, 05 Oct 2024 15:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkG-0005Ol-Cs; Sat, 05 Oct 2024 15:47:18 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkE-0007gs-Tj; Sat, 05 Oct 2024 15:47:16 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cb60aff1eso30988975e9.0; 
 Sat, 05 Oct 2024 12:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157632; x=1728762432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rIGcIV5oEe21ffMfXv8dxIlxwIuJMnLBjp2bLHMXYyE=;
 b=NfA3ItMRdKacBQGo7lUp+OU1NoQkH4pWzoJa33yLMzTnh6ZsWqM3LEKTmFI7wG6zGm
 v0B16dkBgAU4jD0GD4MhKRLHVpIr987orQGgJ07yVDn93ZI9r1tKFzdlkHHO0brsFCHr
 AgVaMHwGdWBKQrKAwIuP5a21a5q6UtXLXASMwdCr3njhQprs0jcurMFpOd0QB12kNTRS
 iUNKG600V/U0hVyiYt9NqobwTQNRV9IdgTE197gi13ny+Vyt0FLyKQH4TrOZ2UCHQLn3
 Uacn3oc/LD8i/G5440C3kf3g8TZEz04mw2ySMLCFt4dk5WrUzTCVgHufLMv0meXtWMNP
 0KPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157632; x=1728762432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rIGcIV5oEe21ffMfXv8dxIlxwIuJMnLBjp2bLHMXYyE=;
 b=fAhdX6DkXvu64QPYsGj/WbwpOsNYWgCJ2O8lz0qgHArpj1I7khjFSGcDoYaoUF0H+o
 6dBduQjopFhZnXLD5nvXHtlBcTN0K7cl3XaJvdWJqvD+AMA58zA+GTa9kEXHBRLFD4TA
 pN1+q3V4HiT9jZTxs1FqZPEsp5zTYhSqx3nYaWzPjif5AgkNrlRs3JrbpmBw2fTQp0AO
 HnTu3n2RiUDYgaBQsCn+VXpKg+JvAJKHfq+ZjCb8CRmBCRFrkJ3GKW783TMwEu2xaX2K
 sim2uiouv1xKo9gsaFsGqOJmIZrGtW5umnumJLetXjaxN9U9AGdfY1gQd2uoP5ULbNdH
 KVow==
X-Forwarded-Encrypted: i=1;
 AJvYcCU693SOcoc2NcJ9NNqhjuu61eav68u52a/aZup9k7ewSQW9qElm8iEUn687z3GoAwBw5u+GGeJ1RdTy@nongnu.org,
 AJvYcCWRsxPK6fDuQuj4zDR3VtSzbhkClaIm6sq2LQQFz5cn34NNo2wqPYHbDLjEeHOlROaVrZi8cVQ0kQg=@nongnu.org
X-Gm-Message-State: AOJu0YyZQ7h5ztpXuTXcjMfqQG6i8e3zxjPAFcpYVtNSGEyfuRedPbGS
 sj8HssjXiPVuuTBvfkRENBHE955hEEaVY7++1uyTCacjJB6U5HsR/rv5cw==
X-Google-Smtp-Source: AGHT+IFBb4h3bokBRGeh62r3lJN2PulGsDWevBVTB/zYylw5emGjhGnCRMYB1CELyd6DR+2zRo5v5w==
X-Received: by 2002:a05:600c:1906:b0:42c:c4c8:7090 with SMTP id
 5b1f17b1804b1-42f85aa7b0emr56531595e9.9.1728157631770; 
 Sat, 05 Oct 2024 12:47:11 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:47:11 -0700 (PDT)
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
Subject: [PATCH v2 13/23] hw/pci-host/ppce500: Prefer DEFINE_TYPES() macro
Date: Sat,  5 Oct 2024 21:45:53 +0200
Message-ID: <20241005194603.23139-14-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
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
2.46.2


