Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1D9CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 21:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoqDt-0005Hq-Mj; Wed, 20 Aug 2025 17:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqDr-0005GW-Pu; Wed, 20 Aug 2025 17:19:55 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqDo-000503-Vo; Wed, 20 Aug 2025 17:19:55 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6188b5f620dso460167a12.0; 
 Wed, 20 Aug 2025 14:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755724789; x=1756329589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y+UQCFWknK6f91RyhUWITH0g3rvLznbMkc/gVbj0ysQ=;
 b=KKbADwGBGMN3uKyrXrHFnZ4MtAHp01xcchrER1HtRtzJ6cFBM9AzazydKPMh/37Ux7
 KfaXIfxtnH4RSSes5fI6PJ1yWlopbxbTHqswx64kHa37/IsH9v1qgLghH/Av/ZleoBBe
 QB5F4HXeWgU/BpMNULdY4MjHcvQVX2HfdMSTIXicLnOnbnWTo8pvWsVDg4ekhpI1jqI1
 hKFWnhfKy8JrCBZM38kBUOykCAXyq5ZlAr6jO57pixoLvX6oHETfZFzIrJmRL0SJTq4E
 e0RUx34Ef6U9n5o/p7VRXmZpNdygpQVINR/obI6XydMP7hdDv1zZwZtpNbviYXvwzG2Z
 3bmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755724789; x=1756329589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y+UQCFWknK6f91RyhUWITH0g3rvLznbMkc/gVbj0ysQ=;
 b=OPZQajvZP/3aooqK3llexNOEcGr2ygOxvCct3tBXUH0Xg4pkT9zs7t5CdMBaOkIVqE
 MTgDxtMyqH09sz/RuclgxBwpN5L4DFzUYZ0YPz5Vz/OzaO+GcpXJG0E2qhnEF8A8zkdF
 qWZfZvIgv55M7X7Kmz6JI0eTR1WY/NZBcys5OSvwXnh9A1Xb1COu2+5MBlG5uBFh0XD5
 oOeY8uXMz3ls6srGLsHQVhrVgs4WcVQOiEU+guOq7R494uxfI5BFbA3ve2A1aV7rJv2P
 lnxO5waguXAOUb3VJyhMaefUp9zKXYwces5qB7F6PKEozzlYwqw80r4NhI+OnRFyBmhC
 K7yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkQH8pB8eRza/7Jwd0ou0IWBDyGXyVvZwyWc6LNsNdHArUo+1QMWOCFHJPp+ULPBhtyOd4hePKQA==@nongnu.org
X-Gm-Message-State: AOJu0YyKoRl7y/d8Qr4l8GSFPXnCkM/pFVJUCzcYgCfQowAi4dVIW1jq
 zj91cHaIA6qDV5LvtzYlKUPIEKyUs+MOdGXzJ71wSdjf3mG8hQ6znBpvz4t1Q6WG
X-Gm-Gg: ASbGncsWr+8svQqdnNAoPpHymF3rAlwgkKeQi8j4W7k+iWB4hMQPp5k4B8tfZSqL7+V
 cQ/ffV0g6bf/WrfFnrLe361rOx3gGPwD2B8GTpIFAFm2uxtFjBME9kKtkHNqUdZ3BQmz6JexhVo
 7uka4bY1sfuwo3pI0tIYJQYyiKiA8H5QJVIM4ds3ixehf1Hh7C83vFSC9/Mj5/3I4n+woqLT76z
 KZBdaS26r/MwHnt5y9+dKcE3TQ82L/3ASoi1SjUFgAOdfRvnOP4B47wvvxymTaMdPvsfqL80Jd+
 ZWeSUX+2SRy4FjCVdxQ84fwzOBU8NoWRAFpx4+8x7tTfUC3GAQkN9Dqqwk8FKHapJxRUD5dqH5R
 8O5OoUTIm6MsGyVLoEFAz9acIx92U3r0R8nZDHPzre0Q6Tnc8xyU3d5aBRKa/dKUOFdm9VhvKtZ
 MJ5c9io0efmssSs2rIizgW6W2WqVb/bI4tVQgp4FHlhF4=
X-Google-Smtp-Source: AGHT+IEdKhISJfpkcMjudbrUWUks730Qh4elkEHnPwN6TOBNomza2xPvI4cWYwA74+4cBHGa+eobGw==
X-Received: by 2002:a05:6402:1ec1:b0:61a:9385:c780 with SMTP id
 4fb4d7f45d1cf-61bf884ecabmr99771a12.37.1755724789265; 
 Wed, 20 Aug 2025 14:19:49 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-249c-be00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:249c:be00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61a755d9cfasm4161182a12.9.2025.08.20.14.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 14:19:48 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 02/10] hw/pci-host/designware: Create viewport memory regions
 on demand
Date: Wed, 20 Aug 2025 23:19:24 +0200
Message-ID: <20250820211932.27302-3-shentey@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820211932.27302-1-shentey@gmail.com>
References: <20250820211932.27302-1-shentey@gmail.com>
MIME-Version: 1.0
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

Currently, all viewport memory regions are created upfront in the realize phase.
This has several drawbacks: First, two MemoryRegion members are needed per
viewport while maximum only one is ever used at a time. Second, for inbound
viewports, the `cfg` member is never used nor initialized. Third, adding
support for other types of memory such as I/O space would require adding even
more MemoryRegion members, one for each type. Fix these limiations by having
just one MemoryRegion member which gets configured on demand.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/pci-host/designware.h |   3 +-
 hw/pci-host/designware.c         | 181 ++++++++++++++-----------------
 2 files changed, 81 insertions(+), 103 deletions(-)

diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
index a35a3bd06c..7dc8af049d 100644
--- a/include/hw/pci-host/designware.h
+++ b/include/hw/pci-host/designware.h
@@ -40,8 +40,7 @@ struct DesignwarePCIERootBus {
 
 typedef struct DesignwarePCIEViewport {
     DesignwarePCIERoot *root;
-
-    MemoryRegion cfg;
+    const char *name;
     MemoryRegion mem;
 
     uint64_t base;
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 3a10dc9f99..7d47d8228f 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -272,33 +272,54 @@ static const MemoryRegionOps designware_pci_host_conf_ops = {
 static void designware_pcie_update_viewport(DesignwarePCIERoot *root,
                                             DesignwarePCIEViewport *viewport)
 {
+    DesignwarePCIEHost *host = designware_pcie_root_to_host(root);
     const uint64_t target = viewport->target;
     const uint64_t base   = viewport->base;
     const uint64_t size   = (uint64_t)viewport->limit - base + 1;
     const bool enabled    = viewport->cr[1] & DESIGNWARE_PCIE_ATU_ENABLE;
 
-    MemoryRegion *current, *other;
-
-    if (viewport->cr[0] == DESIGNWARE_PCIE_ATU_TYPE_MEM) {
-        current = &viewport->mem;
-        other   = &viewport->cfg;
-        memory_region_set_alias_offset(current, target);
-    } else {
-        current = &viewport->cfg;
-        other   = &viewport->mem;
+    if (memory_region_is_mapped(&viewport->mem)) {
+        memory_region_del_subregion(viewport->mem.container, &viewport->mem);
     }
+    object_unparent(OBJECT(&viewport->mem));
 
-    /*
-     * An outbound viewport can be reconfigure from being MEM to CFG,
-     * to account for that we disable the "other" memory region that
-     * becomes unused due to that fact.
-     */
-    memory_region_set_enabled(other, false);
     if (enabled) {
-        memory_region_set_size(current, size);
-        memory_region_set_address(current, base);
+        if (viewport->cr[0] == DESIGNWARE_PCIE_ATU_TYPE_MEM) {
+            if (viewport->inbound) {
+                /*
+                 * Configure MemoryRegion implementing PCI -> CPU memory
+                 * access
+                 */
+                memory_region_init_alias(&viewport->mem, OBJECT(root),
+                                         viewport->name, get_system_memory(),
+                                         target, size);
+                memory_region_add_subregion_overlap(&host->pci.address_space_root,
+                                                    base, &viewport->mem, -1);
+            } else {
+                /*
+                 * Configure MemoryRegion implementing CPU -> PCI memory
+                 * access
+                 */
+                memory_region_init_alias(&viewport->mem, OBJECT(root),
+                                         viewport->name, &host->pci.memory,
+                                         target, size);
+                memory_region_add_subregion(get_system_memory(), base,
+                                            &viewport->mem);
+            }
+        } else {
+            if (!viewport->inbound) {
+                /*
+                 * Configure MemoryRegion implementing access to configuration
+                 * space
+                 */
+                memory_region_init_io(&viewport->mem, OBJECT(root),
+                                      &designware_pci_host_conf_ops,
+                                      viewport, viewport->name, size);
+                memory_region_add_subregion(get_system_memory(), base,
+                                            &viewport->mem);
+            }
+        }
     }
-    memory_region_set_enabled(current, enabled);
 }
 
 static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
@@ -378,27 +399,16 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
     }
 }
 
-static char *designware_pcie_viewport_name(const char *direction,
-                                           unsigned int i,
-                                           const char *type)
-{
-    return g_strdup_printf("PCI %s Viewport %u [%s]",
-                           direction, i, type);
-}
-
 static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
 {
     DesignwarePCIERoot *root = DESIGNWARE_PCIE_ROOT(dev);
     DesignwarePCIEHost *host = designware_pcie_root_to_host(root);
     PCIBridge *br = PCI_BRIDGE(dev);
-    DesignwarePCIEViewport *viewport;
     /*
      * Dummy values used for initial configuration of MemoryRegions
      * that belong to a given viewport
      */
     const hwaddr dummy_offset = 0;
-    const uint64_t dummy_size = 4;
-    size_t i;
 
     br->bus_name  = "dw-pcie";
 
@@ -416,80 +426,49 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
     msi_nonbroken = true;
     msi_init(dev, 0x50, 32, true, true, &error_fatal);
 
-    for (i = 0; i < DESIGNWARE_PCIE_NUM_VIEWPORTS; i++) {
-        const char *direction;
-        char *name;
-
-        viewport = &root->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND][i];
-        viewport->inbound = true;
-        viewport->base    = 0x0000000000000000ULL;
-        viewport->target  = 0x0000000000000000ULL;
-        viewport->limit   = UINT32_MAX;
-        viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
-
-        direction   = "Inbound";
-
-        /*
-         * Configure MemoryRegion implementing PCI -> CPU memory
-         * access
-         */
-        name = designware_pcie_viewport_name(direction, i, "MEM");
-        memory_region_init_alias(&viewport->mem, OBJECT(root), name,
-                                 get_system_memory(), dummy_offset, dummy_size);
-        memory_region_add_subregion_overlap(&host->pci.address_space_root,
-                                            dummy_offset, &viewport->mem, -1);
-        memory_region_set_enabled(&viewport->mem, false);
-        g_free(name);
-
-        viewport = &root->viewports[DESIGNWARE_PCIE_VIEWPORT_OUTBOUND][i];
-        viewport->root    = root;
-        viewport->inbound = false;
-        viewport->base    = 0x0000000000000000ULL;
-        viewport->target  = 0x0000000000000000ULL;
-        viewport->limit   = UINT32_MAX;
-        viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
-
-        direction   = "Outbound";
-
-        /*
-         * Configure MemoryRegion implementing CPU -> PCI memory
-         * access
-         */
-        name = designware_pcie_viewport_name(direction, i, "MEM");
-        memory_region_init_alias(&viewport->mem, OBJECT(root), name,
-                                 &host->pci.memory, dummy_offset, dummy_size);
-        memory_region_add_subregion(get_system_memory(), dummy_offset,
-                                    &viewport->mem);
-        memory_region_set_enabled(&viewport->mem, false);
-        g_free(name);
-
-        /*
-         * Configure MemoryRegion implementing access to configuration
-         * space
-         */
-        name = designware_pcie_viewport_name(direction, i, "CFG");
-        memory_region_init_io(&viewport->cfg, OBJECT(root),
-                              &designware_pci_host_conf_ops,
-                              viewport, name, dummy_size);
-        memory_region_add_subregion(get_system_memory(), dummy_offset,
-                                    &viewport->cfg);
-        memory_region_set_enabled(&viewport->cfg, false);
-        g_free(name);
+    for (size_t i = 0; i < ARRAY_SIZE(root->viewports); i++) {
+        static const char *names[][DESIGNWARE_PCIE_NUM_VIEWPORTS] = {
+            {
+                "PCI Outbound Viewport 0",
+                "PCI Outbound Viewport 1",
+                "PCI Outbound Viewport 2",
+                "PCI Outbound Viewport 3"
+            },
+            {
+                "PCI Inbound Viewport 0",
+                "PCI Inbound Viewport 1",
+                "PCI Inbound Viewport 2",
+                "PCI Inbound Viewport 3"
+            },
+        };
+
+        for (size_t j = 0; j < DESIGNWARE_PCIE_NUM_VIEWPORTS; j++) {
+            DesignwarePCIEViewport *viewport = &root->viewports[i][j];
+            viewport->root    = root;
+            viewport->name    = names[i][j];
+            viewport->inbound = i == DESIGNWARE_PCIE_VIEWPORT_INBOUND;
+            viewport->base    = 0x0000000000000000ULL;
+            viewport->target  = 0x0000000000000000ULL;
+            viewport->limit   = UINT32_MAX;
+            viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
+
+            /*
+             * If no inbound iATU windows are configured, HW defaults to
+             * letting inbound TLPs to pass in. We emulate that by explicitly
+             * configuring first inbound window to cover all of target's
+             * address space.
+             *
+             * NOTE: This will not work correctly for the case when first
+             * configured inbound window is window 0
+             */
+            viewport->cr[1]   = (viewport->inbound && j == 0)
+                                  ? DESIGNWARE_PCIE_ATU_ENABLE
+                                  : 0;
+
+            designware_pcie_update_viewport(root, viewport);
+        }
     }
 
-    /*
-     * If no inbound iATU windows are configured, HW defaults to
-     * letting inbound TLPs to pass in. We emulate that by explicitly
-     * configuring first inbound window to cover all of target's
-     * address space.
-     *
-     * NOTE: This will not work correctly for the case when first
-     * configured inbound window is window 0
-     */
-    viewport = &root->viewports[DESIGNWARE_PCIE_VIEWPORT_INBOUND][0];
-    viewport->cr[1] = DESIGNWARE_PCIE_ATU_ENABLE;
-    designware_pcie_update_viewport(root, viewport);
-
     memory_region_init_io(&root->msi.iomem, OBJECT(root),
                           &designware_pci_host_msi_ops,
                           root, "pcie-msi", 0x4);
-- 
2.50.1


