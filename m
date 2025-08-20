Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2222CA0EF8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 21:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoqDu-0005Ia-S8; Wed, 20 Aug 2025 17:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqDr-0005GX-Q4; Wed, 20 Aug 2025 17:19:55 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqDp-00050E-5N; Wed, 20 Aug 2025 17:19:55 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-61a8f452c43so512339a12.0; 
 Wed, 20 Aug 2025 14:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755724790; x=1756329590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PV5PRLX0fBzyIDbGMvnzpIIGMqO5fU+XNvrNfSXHklc=;
 b=j+jjt9fff78ItN54mRreGHI+YPSk+0Z7sIfVYOUzhnYT9P6C8whyd0QKzqFB29iqOp
 VqqCcr/6QPscgCmI0yOjx7MOgmMBu6lYlN50oShR+N8U3LtGuBIuPuRO9yTyD00zZTpi
 01O74rPVkf254mKLfH2bJkkoJV6FcOn/XifwgPHZzA/j+CMeINdkBtmcouW7u2qENieB
 G7HMMsIDq5yRrfVkVAhFXBBTUdFvSnTpXEE0JjcdArxmnDoGRkE8O8aPA6sW0O4xy/Be
 sqP1P9tYHPMi+VDdkS9810w53XWKHU+mr/x3Fr1dl58hx1nPOeOOZfic8R6lWoJ7/ycb
 hsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755724790; x=1756329590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PV5PRLX0fBzyIDbGMvnzpIIGMqO5fU+XNvrNfSXHklc=;
 b=REl1KULVh25jMLIdIntiMoCxLHTS0sU3hdNrNf2YK1CGq2zD80jhTLy2Mhm8mhZXDH
 dgIZt7eSQN6ldsCFBoHWXufk4jqfpNtasABG6hL/1yrzsT396P2QISoMNqfmbNnj/RE8
 Pel4oZeFjuNOJY4ij3u7g+PdkrqYXNCs9550OVZnWixftULaVjtIdIr3xndXOvGFzWIv
 omzFr6/y14SXFfX45/W+r+2slI4SGPkJAeo8TmfrdQCJxc0y5pQeL/lwuQb+7t+9NOc2
 VBYI7b3s4iTqWOuO03IMUOfTwPI3JDxMsRNqL8f0cZ9+i94VzwR0PAAELh1ACMugDUkJ
 qb+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb7YGlIm7rvXx+j3EeX8KGok0n6FILIs+qFs1oIGlPP0GXinTvicaaWZ2wLYxUsl6ljIuLj4ML+w==@nongnu.org
X-Gm-Message-State: AOJu0YzO88wOAEGm+nT5/p/DP1+JNUXBQ3t1TVKY3pNyfTlDdaDoxoZe
 OHwcOZNAKvXYWC2PbsaSdSxSP2JuGGudKToLmaAGfrDoM35VWUtLI3IObFaUjQIu
X-Gm-Gg: ASbGncu6TDNOXrP4EFS01/chuFnvMFK2YrGSPnpEa0V7UE5tQekLpH3N7UWjTA7rSPL
 LecNHr+PKrkERxL2ZC7/uH0l1KEVAKmdOXkve7qdr3k3PHk51Q6soNzxIX7duVxVx1JIby2SWCm
 HYC4uw8SFOnSCvKYUwJ3yWEoCh2NYoIvOXmKuHPMKFGyMIRK4LHB0QMXpxS9Cw0P0ehV/XYDTKG
 SizyGxn+zOdZVjQBhx9sRodleb47TAgcSG/xeYvHmJqj9f8LGbDwsynEmaRye0cYDba3/FGGcaA
 s03mIezNad4TUsZ5nMXGVHTz9+KwHTVO1yeyVwasyLPQKS25kFERPPlGFq4Oo/NOxTDFa9Vpxbn
 g1ChmXFTFzj3vcFzuocQmUUQES4twLnhH1DZPkRfg8T2ZjvE0VFk+KMdSUscbsm2KA3YL2QOt+/
 Yg1kLJK3Ewl/yoCvGJGDBbaRQp0eWQcfwvBGw90Km5XgY=
X-Google-Smtp-Source: AGHT+IH0/mg1YQnuKK3R4JPPY9Q3s2DGchgeLtQQIClwTrsYkegLbUNZXCXfuNBfwcf21GHXE5VThw==
X-Received: by 2002:a05:6402:1e93:b0:613:5257:6cad with SMTP id
 4fb4d7f45d1cf-61bf98daec0mr18071a12.11.1755724790390; 
 Wed, 20 Aug 2025 14:19:50 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-249c-be00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:249c:be00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61a755d9cfasm4161182a12.9.2025.08.20.14.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 14:19:49 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 03/10] hw/pci-host/designware: Determine PCIDevice of
 configuration region once
Date: Wed, 20 Aug 2025 23:19:25 +0200
Message-ID: <20250820211932.27302-4-shentey@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820211932.27302-1-shentey@gmail.com>
References: <20250820211932.27302-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x531.google.com
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

Now that viewport memory regions are created on demand, the PCIDevice of the
configuration memory can be determined once upon creation of the memory region
rather than dynamically resolving it upon each access. This is both more
efficient at runtime and resolves an attribute. Furthermore, if an invalid PCI
device is configured, a guest error is now logged since the error is now
direclty related to a guest action.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/pci-host/designware.h |  1 -
 hw/pci-host/designware.c         | 54 +++++++++++++++++---------------
 2 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
index 7dc8af049d..34beee1285 100644
--- a/include/hw/pci-host/designware.h
+++ b/include/hw/pci-host/designware.h
@@ -39,7 +39,6 @@ struct DesignwarePCIERootBus {
 };
 
 typedef struct DesignwarePCIEViewport {
-    DesignwarePCIERoot *root;
     const char *name;
     MemoryRegion mem;
 
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 7d47d8228f..2a676c65a2 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -222,26 +222,18 @@ designware_pcie_root_config_read(PCIDevice *d, uint32_t address, int len)
 static uint64_t designware_pcie_root_data_access(void *opaque, hwaddr addr,
                                                  uint64_t *val, unsigned len)
 {
-    DesignwarePCIEViewport *viewport = opaque;
-    DesignwarePCIERoot *root = viewport->root;
-
-    const uint8_t busnum = DESIGNWARE_PCIE_ATU_BUS(viewport->target);
-    const uint8_t devfn  = DESIGNWARE_PCIE_ATU_DEVFN(viewport->target);
-    PCIBus    *pcibus    = pci_get_bus(PCI_DEVICE(root));
-    PCIDevice *pcidev    = pci_find_device(pcibus, busnum, devfn);
-
-    if (pcidev) {
-        addr &= pci_config_size(pcidev) - 1;
-
-        if (val) {
-            pci_host_config_write_common(pcidev, addr,
-                                         pci_config_size(pcidev),
-                                         *val, len);
-        } else {
-            return pci_host_config_read_common(pcidev, addr,
-                                               pci_config_size(pcidev),
-                                               len);
-        }
+    PCIDevice *pcidev = opaque;
+
+    addr &= pci_config_size(pcidev) - 1;
+
+    if (val) {
+        pci_host_config_write_common(pcidev, addr,
+                                     pci_config_size(pcidev),
+                                     *val, len);
+    } else {
+        return pci_host_config_read_common(pcidev, addr,
+                                           pci_config_size(pcidev),
+                                           len);
     }
 
     return UINT64_MAX;
@@ -312,11 +304,22 @@ static void designware_pcie_update_viewport(DesignwarePCIERoot *root,
                  * Configure MemoryRegion implementing access to configuration
                  * space
                  */
-                memory_region_init_io(&viewport->mem, OBJECT(root),
-                                      &designware_pci_host_conf_ops,
-                                      viewport, viewport->name, size);
-                memory_region_add_subregion(get_system_memory(), base,
-                                            &viewport->mem);
+                const uint8_t busnum = DESIGNWARE_PCIE_ATU_BUS(viewport->target);
+                const uint8_t devfn = DESIGNWARE_PCIE_ATU_DEVFN(viewport->target);
+                PCIBus *pcibus = pci_get_bus(PCI_DEVICE(root));
+                PCIDevice *pcidev = pci_find_device(pcibus, busnum, devfn);
+
+                if (pcidev) {
+                    memory_region_init_io(&viewport->mem, OBJECT(root),
+                                          &designware_pci_host_conf_ops,
+                                          pcidev, viewport->name, size);
+                    memory_region_add_subregion(get_system_memory(), base,
+                                                &viewport->mem);
+                } else {
+                    qemu_log_mask(LOG_GUEST_ERROR, "%s: No PCI device attached"
+                                  " under busnum: %d, devfn: %d\n", __func__,
+                                  (int)busnum, (int)devfn);
+                }
             }
         }
     }
@@ -444,7 +447,6 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
 
         for (size_t j = 0; j < DESIGNWARE_PCIE_NUM_VIEWPORTS; j++) {
             DesignwarePCIEViewport *viewport = &root->viewports[i][j];
-            viewport->root    = root;
             viewport->name    = names[i][j];
             viewport->inbound = i == DESIGNWARE_PCIE_VIEWPORT_INBOUND;
             viewport->base    = 0x0000000000000000ULL;
-- 
2.50.1


