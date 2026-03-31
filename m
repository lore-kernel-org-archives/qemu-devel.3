Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D8E10F92EE
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 18:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7eCY-0000DE-Hj; Tue, 31 Mar 2026 14:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7eCW-0000CU-C7
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:52:32 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7eCU-0001Xj-Kt
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:52:32 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8CB6B441E1;
 Tue, 31 Mar 2026 18:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C15C19424;
 Tue, 31 Mar 2026 18:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774983149;
 bh=E2rz4Mtc0I32yjCRAUlfEclsTcv2IlBoFfM9SwPj0S0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZJgqyPaaErcvsEgyQyAmV8HkzlHmPxEYV5oD1X3jAljVc1jvpa5tsLGBrgBpNqZEk
 dDhP9xCbPWe6q8foYGYy4PQtE/Y38rjWPNyU+X21j4R+RNwkOa/y9qPr3hmHf/yY3u
 4RPWWk/AFtiOOgUC9PQS52BbeYp6ee8V7wvGKyTruimp95fyfG4gO8VjmPD4MzUc2P
 cSTQ4BDAOzbaNCmaf94SIhEblR2A2JssynnjAs036jFNaonEgXk/oKcM41I12a0+n3
 qIFSg4D006ZkYFQn6VXrkNJ5rGDdqirjrASe9otSITkUXehh5q/rzx1PyJYuU5I3dh
 zzJeaXHHZHDPg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 5/8] hw/pci-host/astro: Add GMMIO mapping
Date: Tue, 31 Mar 2026 20:52:16 +0200
Message-ID: <20260331185219.12187-6-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331185219.12187-1-deller@kernel.org>
References: <20260331185219.12187-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Helge Deller <deller@gmx.de>

Implement the GMMIO mapping.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/pci-host/astro.c | 71 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index b7760c4b32..9e6386069b 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -14,7 +14,6 @@
  * - All user-added devices are currently attached to the first
  *   Elroy (PCI bus) only for now. To fix this additional work in
  *   SeaBIOS and this driver is needed. See "user_creatable" flag below.
- * - GMMIO (Greater than 4 GB MMIO) register
  */
 
 #define TYPE_ASTRO_IOMMU_MEMORY_REGION "astro-iommu-memory-region"
@@ -660,6 +659,73 @@ static void adjust_LMMIO_DIRECT_mapping(AstroState *s, unsigned int reg_index)
     memory_region_set_enabled(lmmio_alias, true);
 }
 
+static void adjust_GMMIO_mapping(AstroState *s)
+{
+    MemoryRegion *gmmio;
+    uint64_t map_addr, map_size, align_mask;
+    uint32_t map_route, map_enabled, i;
+
+    gmmio = &s->gmmio;
+    map_addr  = s->ioc_ranges[(0x378 - 0x300) / 8];       /* GMMIO_DIST_BASE */
+    map_enabled = map_addr & 1;
+    map_addr  &= MAKE_64BIT_MASK(32, 8);
+    s->ioc_ranges[(0x378 - 0x300) / 8] = map_addr | map_enabled;
+
+    map_route = s->ioc_ranges[(0x388 - 0x300) / 8] >> 58; /* GMMIO_DIST_ROUTE */
+    map_route = MIN(MAX(map_route, 29), 33); /* between 4-16 GB total */
+    map_size  = 1ULL << map_route;      /* size of each mapping */
+    align_mask = ~(map_size - 1);
+
+    /* make sure the lmmio region is initially turned off */
+    if (gmmio->enabled) {
+        memory_region_set_enabled(gmmio, false);
+    }
+
+    /* do sanity checks and calculate mmio size */
+    map_addr &= align_mask;
+
+    /* exit if disabled */
+    if (!map_enabled) {
+        return;
+    }
+
+    if (!gmmio->name) {
+        memory_region_init_io(gmmio, OBJECT(s), &unassigned_io_ops, s,
+                "GMMIO", ROPES_PER_IOC * map_size);
+        memory_region_add_subregion_overlap(get_system_memory(),
+                map_addr, gmmio, 1);
+    }
+
+    memory_region_set_address(gmmio, map_addr);
+    memory_region_set_size(gmmio, ROPES_PER_IOC * map_size);
+    memory_region_set_enabled(gmmio, true);
+
+    for (i = 0; i < ELROY_NUM; i++) {
+        MemoryRegion *alias;
+        ElroyState *elroy;
+        int rope;
+
+        elroy = s->elroy[i];
+        alias = &elroy->gmmio_alias;
+        rope = elroy_rope_nr[i];
+        if (alias->enabled) {
+            memory_region_set_enabled(alias, false);
+        }
+
+        if (!alias->name) {
+            memory_region_init_alias(alias, OBJECT(elroy),
+                 "gmmio-alias", &elroy->pci_mmio, 0, map_size);
+            memory_region_add_subregion_overlap(gmmio, rope * map_size,
+                 alias, 2);
+        }
+
+        memory_region_set_address(alias, rope * map_size);
+        memory_region_set_alias_offset(alias, map_addr + rope * map_size);
+        memory_region_set_size(alias, map_size);
+        memory_region_set_enabled(alias, true);
+    }
+}
+
 static MemTxResult astro_chip_read_with_attrs(void *opaque, hwaddr addr,
                                              uint64_t *data, unsigned size,
                                              MemTxAttrs attrs)
@@ -775,6 +841,9 @@ static MemTxResult astro_chip_write_with_attrs(void *opaque, hwaddr addr,
         if (addr >= 0x360 && addr <= 0x370 + 7) {
             adjust_LMMIO_mapping(s);
         }
+        if (addr >= 0x378 && addr <= 0x388 + 7) {
+            adjust_GMMIO_mapping(s);
+        }
         break;
     case 0x10200:
     case 0x10220:
-- 
2.53.0


