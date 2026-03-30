Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C411061B22
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 21:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7K0w-0000p2-RR; Mon, 30 Mar 2026 17:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7K0v-0000oU-6u
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:19:13 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7K0t-0003kP-My
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:19:12 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4D62D6013C;
 Mon, 30 Mar 2026 21:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26590C2BCB1;
 Mon, 30 Mar 2026 21:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774905551;
 bh=sg/+n0PQffkkyD0RFYrCjE0ggu+1Qtabt56HcTC9mb8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IQAB5j75dPHQrDJOBgWyJC1p3p6jKUHoFvs9vQ27X6r7D0U4VIEmtRIXZq2XnRaDK
 GEYYj9hgbgzT2+XNEqEyI+g/uegEdprMVyZwRRlXZK1u8q3DSQzLSe62Zve5mLhy0B
 CGQH82KmiYDl0iC2aWMKLn0RTQdMpVB61lF6vIf7HvkOfwTFfgMFlLaPCYL7ZMmh8t
 dQbm9J2l7ScZaC1ltvQCDUjzTedFJW9VjMGsewEnzhtTiNplQpsddfFKgCyNEBSI9z
 M3+xrGfYsrEExAJv6Pb7dfqyONVkZf8J5/BmpY11m769/v0yWr6O7LaxQGL/OfN7SR
 jYuxmsXPcptlQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 07/11] hw/pci-host/astro: Add GMMIO mapping
Date: Mon, 30 Mar 2026 23:18:54 +0200
Message-ID: <20260330211859.19317-8-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330211859.19317-1-deller@kernel.org>
References: <20260330211859.19317-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index e1d73258c4..8c61c696bd 100644
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


