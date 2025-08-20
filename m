Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E87CA0FE0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 21:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoqE2-0005O2-2j; Wed, 20 Aug 2025 17:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqE0-0005N0-42; Wed, 20 Aug 2025 17:20:04 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqDy-00052D-7d; Wed, 20 Aug 2025 17:20:03 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-61a94bd82a5so607537a12.1; 
 Wed, 20 Aug 2025 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755724800; x=1756329600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1wUmDXrznirFi3ssCzqlRjHMYNyodcpLnP8rDITPzM=;
 b=aFH6F4S5iD8fjAIPTLj7Z8pIcUpzMbS2O96Qqoh0qk0kJgEV8+EQiMvUe8YJJe0Non
 uW67rc5JOnmXTbmk8N8OJx+86ToI5hvHxuM5jPDvckHLSTIGjtECs10zTdZdwG/APnFJ
 nBheU/RkKv6+KwX1qD8PREZLVexVwPuUkr+DmEd5mnFX9DBvPS+/MZ2i9E3in0mZAZme
 cJyZNsfJTk4R28tXnWAfFm4o3qsc5hNRXT2/nXzgpNKCluZz3rOv46mh5uT0ifQgMCA4
 y4bMqCVCeYlTlbS0vUfA/RPmPBhd7wfY1E5VLpnOZqsaMNRVuQtbVQxzpL87JHGtS0aL
 K15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755724800; x=1756329600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l1wUmDXrznirFi3ssCzqlRjHMYNyodcpLnP8rDITPzM=;
 b=aba4i8z9h76R4wHWYZu0ASJEDRvre3vr/ho1T3J9NoCG+f4syUL7QqG5+dtSYtRBxH
 Uaxw6SI8mfGgXhPl5de2kPAtB72PVbqIejwSSr9YJ9mRFqhnGXurDji1PJcmRcQeV70q
 W8Wtq/XO9uIra5lSohYEq1BqowxUrrWEjx2kD8tqgw65FxPLuSgB+gakgHtZGIqCGOHs
 InrFD7Hmq1IUNUubwnqVBnx9Wc2zh0AhFkON6L6XN7sHe/2+c1CZlzRI1atzmxPWjzll
 VNcD8CJvGdmYz41P7FkKFx+tqmqth/bVwYXkikB6Mgxnqxb8XEr1XHhFPZqKQXcWTtXr
 skPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+A0vuveszxZMTDLv1oXLKDqj/KPCWcj8JTJG6iHK+FwxPw9Doav6nCO5tp5veXOkqZF9bWhIL3Q==@nongnu.org
X-Gm-Message-State: AOJu0Yyz54EpAiV/TFtb5l0iIBJGBx/npRIP+tnmwKN/M7SsSABjEPlD
 I15wInZ19+kuKWZm66jC0PdAvTLGmXb8o3rmj8IgExFQ1Bwl6Jz4M3McJrouuvwo
X-Gm-Gg: ASbGnctlAWX8OVoSwYUJd4t+BTuCoYzkDtp76kI/Si5dOvwrlFYAD3xkNkrCWPU+mJR
 XsUx5F4E75OXVFullJGd9xrJxKd0BXHdeRKGhWIWYhPb0nX5po84bjDj8xBZ9TnUyU9HMrbCKKm
 JGr539Wx4UaFRyfIgbifS16of3+UZI2ws4iJ3db1l/eHJoMSzmlNIksT1Bzm5clsMdc79TzGNfn
 PI5ipCl3Gc2K2VprovyzD9UAzaRAjKzHrzVNq2VROxEQ7Dqy4CMmBkiCOI6jO5EfZPb/rhWa+yM
 fYGsABwcw9fXBNeD23x12G8oVe44dTlD5ztVFPquWYpRY3fz3vawLXMQGgSY9QI4v6OWYafz/wV
 RlxWktqTI8muDFOMmu23p7F3Rqv2z+/xfTU//8d/7TZ3crIZS+WDgDHo8KtTVZFVTQdyn+Dao6B
 9/I92USuggBsLkV1Q8n9MmUGsQgBMnziKZ0EkhTuZMp8A=
X-Google-Smtp-Source: AGHT+IGqmvMcMH9RDtXumyLD7pc3S1CLzkg9GzC1R7mQvyqCdG+00MsmwT/hcqQZby3HK1aYyiSXJg==
X-Received: by 2002:a05:6402:3511:b0:61a:1fb2:3278 with SMTP id
 4fb4d7f45d1cf-61bf87362a8mr101791a12.30.1755724799982; 
 Wed, 20 Aug 2025 14:19:59 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-249c-be00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:249c:be00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61a755d9cfasm4161182a12.9.2025.08.20.14.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 14:19:58 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 09/10] hw/pci-host/designware: Implement device reset
Date: Wed, 20 Aug 2025 23:19:31 +0200
Message-ID: <20250820211932.27302-10-shentey@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820211932.27302-1-shentey@gmail.com>
References: <20250820211932.27302-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
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

Fixes the memory mapping to be cleared during reset, like real hardware would
do.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/pci-host/designware.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index d71133a456..2dd4937e52 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -442,11 +442,6 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
     DesignwarePCIERoot *root = DESIGNWARE_PCIE_ROOT(dev);
     DesignwarePCIEHost *host = designware_pcie_root_to_host(root);
     PCIBridge *br = PCI_BRIDGE(dev);
-    /*
-     * Dummy values used for initial configuration of MemoryRegions
-     * that belong to a given viewport
-     */
-    const hwaddr dummy_offset = 0;
 
     br->bus_name  = "dw-pcie";
 
@@ -484,6 +479,26 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
             DesignwarePCIEViewport *viewport = &root->viewports[i][j];
             viewport->name    = names[i][j];
             viewport->inbound = i == DESIGNWARE_PCIE_VIEWPORT_INBOUND;
+        }
+    }
+
+    memory_region_init_io(&root->msi.iomem, OBJECT(root),
+                          &designware_pci_host_msi_ops,
+                          root, "pcie-msi", 0x4);
+    memory_region_add_subregion(&host->pci.memory, 0, &root->msi.iomem);
+}
+
+static void designware_pcie_root_reset(DeviceState *dev)
+{
+    DesignwarePCIERoot *root = DESIGNWARE_PCIE_ROOT(dev);
+    DesignwarePCIEViewport *viewport;
+
+    pci_bridge_reset(dev);
+
+    for (int i = 0; i < ARRAY_SIZE(root->viewports); i++) {
+        for (int j = 0; j < DESIGNWARE_PCIE_NUM_VIEWPORTS; j++) {
+            viewport = &root->viewports[i][j];
+
             viewport->base    = 0x0000000000000000ULL;
             viewport->target  = 0x0000000000000000ULL;
             viewport->limit   = UINT32_MAX;
@@ -494,17 +509,13 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
         }
     }
 
-    memory_region_init_io(&root->msi.iomem, OBJECT(root),
-                          &designware_pci_host_msi_ops,
-                          root, "pcie-msi", 0x4);
     /*
      * We initially place MSI interrupt I/O region at address 0 and
      * disable it. It'll be later moved to correct offset and enabled
      * in designware_pcie_root_update_msi_mapping() as a part of
      * initialization done by guest OS
      */
-    memory_region_add_subregion(&host->pci.memory, dummy_offset,
-                                &root->msi.iomem);
+    memory_region_set_address(&root->msi.iomem, 0);
     memory_region_set_enabled(&root->msi.iomem, false);
 }
 
@@ -602,7 +613,7 @@ static void designware_pcie_root_class_init(ObjectClass *klass,
     k->config_read = designware_pcie_root_config_read;
     k->config_write = designware_pcie_root_config_write;
 
-    device_class_set_legacy_reset(dc, pci_bridge_reset);
+    device_class_set_legacy_reset(dc, designware_pcie_root_reset);
     /*
      * PCI-facing part of the host bridge, not usable without the
      * host-facing part, which can't be device_add'ed, yet.
-- 
2.50.1


