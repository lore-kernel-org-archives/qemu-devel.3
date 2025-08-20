Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50603CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 21:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoqDt-0005HA-5e; Wed, 20 Aug 2025 17:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqDp-0005Fq-SN; Wed, 20 Aug 2025 17:19:54 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uoqDn-0004zz-AV; Wed, 20 Aug 2025 17:19:53 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6188b7532f3so537711a12.2; 
 Wed, 20 Aug 2025 14:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755724788; x=1756329588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4G3K2gkclSW88h2LHkL12l0GlK0tBApNDxq2aVcq6zI=;
 b=GFNg3PKpoSFTX71fcATksrtT0lvCEvsxwHCfUKVtGctxF3vViXU8P5ieLIkKlJn3Jb
 eAgqi/H/H29Z9NH2bBOIT1SetYYhi1p1Y09MxBTL4TvkBvY8vQHWoAWl2dDQ3lmeYqXq
 Zr0CGqlPIisPLeQvn01OkfrLdNYSoLN4DirG8IH8uCrBUCEl7xpXjT443Gtf0iomVZuq
 3fKYa5GE+KuOpyZZXb8TBVdePmAV8OjqXFLPkp3iwWiSrSkZ6lSNUZ61FS3QgLMrKtTZ
 jE3hdMST0xzIkl4TGe6XPT1gqtmpTnP1tha5IcI3ODxuvmnBaiJQ82kaQz5zNAeULi/y
 P5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755724788; x=1756329588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4G3K2gkclSW88h2LHkL12l0GlK0tBApNDxq2aVcq6zI=;
 b=RlwTMmuW3Xw5CMV3vISGXcuT78iF1YvKPrSfj4B8V31ar5YDc3rlK/qTi0YpLtMgD+
 UbgMUFNQnutFWMg/+s0Vsr/NKd5eYguA+SgwliymvzHyzOoAb4gc+jhuvLtOuXSqnje6
 ffzJxQ+FiZLaPyXb5M+WaVTkqdUT7Qk9H7YgZkQW1jGWK6Krm0zMjPRNixVE4/1sBG1g
 y5ltu+y90bx0gumURnd1WpE5PuC52jDKWYX5xNOMEw4rYEgnMx1MnIDzcDaBUPikCA65
 AprQEtHqZNU57aeRfTx2pN2TZ6TqxKS7tqpoZLcnltMbO7a32i53IYuIyiFH5+7YbqIa
 6Azg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGsfRSJnPwX6NFmVaeRHxarAXDFRLDV0LTr3/NpyNv+Bgw/pY1/2A/UhQPOP4cLPoeu/9cfvTmlQ==@nongnu.org
X-Gm-Message-State: AOJu0YwdObUrsRGOTQNjgTE9j2Opub4EaJKZmL/K1y7k6nNa+0rs7lUK
 1TdIWkvV1lRaA5kwXU9nBh2Q7PGYr9BsPiXns76EkTDHVzne+uGzU+YTUbKgHQ==
X-Gm-Gg: ASbGncvpgJMzKW3Zozw3KdPMCgVd6bkVN6ZlmtTY0CiuY8BnoA0jIP/zSmZ7tQ7hUJt
 5MItWCFnYYBDLO1BZsqLCP4xLAyZO9tNqnkM2JeDCIk590oR+O9senjYVMBIXcg3i3r6SbsiYh8
 TYXVXWZqtwoeyKuSixmOvr0+I5s6oiyiLAnsgrFpGXZtl/Brra7NyjRFH74kBq1tD4Ir5V/COIr
 1SWniZUoz/ZyWVJA2rmgAzapIB78rVYvKhDncHu6s9ZZ9U2qw80Gr+r5zBHQfzCE6ETtzJ7Wi7N
 XaMCRvPytTzQ/F+xxgt3gV3+xhO1vKmap7lPAwd0cwtUbcHWg5eEaUmmHkiyxuL/lrBM4iPGxzv
 Qaq3aWeuQZgswP/2bVqX4ALUqV/9Z7HtU6ptXdB3eqnyYfXlEMMbaROEyqKnANny+M7Bdy3y6Lt
 iqrIPij/nT9dluMK1mzzef8srVblLztMunPN/Cik2H9h8=
X-Google-Smtp-Source: AGHT+IFNUTonibHs5jg62j+lYW/SrCfGHcW6GpO3rPt15i1LoL3PQsRfeGJtVUh5xqR0QmZfX7pX2w==
X-Received: by 2002:a05:6402:27ce:b0:618:138e:85b7 with SMTP id
 4fb4d7f45d1cf-61bf8743d29mr102096a12.33.1755724788269; 
 Wed, 20 Aug 2025 14:19:48 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-249c-be00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:249c:be00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61a755d9cfasm4161182a12.9.2025.08.20.14.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Aug 2025 14:19:47 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 01/10] hw/pci-host/designware: Eliminate some helper variables
Date: Wed, 20 Aug 2025 23:19:23 +0200
Message-ID: <20250820211932.27302-2-shentey@gmail.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

In the next step, code gets moved around where the helper variables aren't used
any longer. Eliminate them now to make the code movement clearer.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/pci-host/designware.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index f6e49ce9b8..3a10dc9f99 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -390,8 +390,6 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
 {
     DesignwarePCIERoot *root = DESIGNWARE_PCIE_ROOT(dev);
     DesignwarePCIEHost *host = designware_pcie_root_to_host(root);
-    MemoryRegion *host_mem = get_system_memory();
-    MemoryRegion *address_space = &host->pci.memory;
     PCIBridge *br = PCI_BRIDGE(dev);
     DesignwarePCIEViewport *viewport;
     /*
@@ -419,7 +417,6 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
     msi_init(dev, 0x50, 32, true, true, &error_fatal);
 
     for (i = 0; i < DESIGNWARE_PCIE_NUM_VIEWPORTS; i++) {
-        MemoryRegion *source, *destination, *mem;
         const char *direction;
         char *name;
 
@@ -430,20 +427,18 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
         viewport->limit   = UINT32_MAX;
         viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
 
-        source      = &host->pci.address_space_root;
-        destination = host_mem;
         direction   = "Inbound";
 
         /*
          * Configure MemoryRegion implementing PCI -> CPU memory
          * access
          */
-        mem  = &viewport->mem;
         name = designware_pcie_viewport_name(direction, i, "MEM");
-        memory_region_init_alias(mem, OBJECT(root), name, destination,
-                                 dummy_offset, dummy_size);
-        memory_region_add_subregion_overlap(source, dummy_offset, mem, -1);
-        memory_region_set_enabled(mem, false);
+        memory_region_init_alias(&viewport->mem, OBJECT(root), name,
+                                 get_system_memory(), dummy_offset, dummy_size);
+        memory_region_add_subregion_overlap(&host->pci.address_space_root,
+                                            dummy_offset, &viewport->mem, -1);
+        memory_region_set_enabled(&viewport->mem, false);
         g_free(name);
 
         viewport = &root->viewports[DESIGNWARE_PCIE_VIEWPORT_OUTBOUND][i];
@@ -454,33 +449,31 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
         viewport->limit   = UINT32_MAX;
         viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
 
-        destination = &host->pci.memory;
         direction   = "Outbound";
-        source      = host_mem;
 
         /*
          * Configure MemoryRegion implementing CPU -> PCI memory
          * access
          */
-        mem  = &viewport->mem;
         name = designware_pcie_viewport_name(direction, i, "MEM");
-        memory_region_init_alias(mem, OBJECT(root), name, destination,
-                                 dummy_offset, dummy_size);
-        memory_region_add_subregion(source, dummy_offset, mem);
-        memory_region_set_enabled(mem, false);
+        memory_region_init_alias(&viewport->mem, OBJECT(root), name,
+                                 &host->pci.memory, dummy_offset, dummy_size);
+        memory_region_add_subregion(get_system_memory(), dummy_offset,
+                                    &viewport->mem);
+        memory_region_set_enabled(&viewport->mem, false);
         g_free(name);
 
         /*
          * Configure MemoryRegion implementing access to configuration
          * space
          */
-        mem  = &viewport->cfg;
         name = designware_pcie_viewport_name(direction, i, "CFG");
         memory_region_init_io(&viewport->cfg, OBJECT(root),
                               &designware_pci_host_conf_ops,
                               viewport, name, dummy_size);
-        memory_region_add_subregion(source, dummy_offset, mem);
-        memory_region_set_enabled(mem, false);
+        memory_region_add_subregion(get_system_memory(), dummy_offset,
+                                    &viewport->cfg);
+        memory_region_set_enabled(&viewport->cfg, false);
         g_free(name);
     }
 
@@ -506,7 +499,8 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
      * in designware_pcie_root_update_msi_mapping() as a part of
      * initialization done by guest OS
      */
-    memory_region_add_subregion(address_space, dummy_offset, &root->msi.iomem);
+    memory_region_add_subregion(&host->pci.memory, dummy_offset,
+                                &root->msi.iomem);
     memory_region_set_enabled(&root->msi.iomem, false);
 }
 
-- 
2.50.1


