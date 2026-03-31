Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5D110F92EB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 18:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7eCV-0000C7-5q; Tue, 31 Mar 2026 14:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7eCT-0000Ba-JN
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:52:29 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7eCR-0001XB-Ul
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:52:29 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D5FEA441E1;
 Tue, 31 Mar 2026 18:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01F0C2BCB2;
 Tue, 31 Mar 2026 18:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774983146;
 bh=j6YiKCcMaXbFyNLBwqSZZWBBp25B8LnAt2uk9epec7U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fFO72NZ2LJ3zML+GpJhXIpHvcR9249S/Ll0qeX4e78JlmOuIB+uRWnSV0LXvdJ3WD
 ndSdxhElf7q0uLyVZQ0udu+WaJx9f//MWUoB1PRlsbHxrrp8PSrFHr5UPVuqHYhedw
 C0V9/xmv+FDWmkIcOsM6seYp8bO3WR4J4Nr3F3ConH8LsWsWC7vqgeqTthWTib1H9L
 /fYnCNxrZJygiH5xU5AYBSVzlEMtlHmLKuzEPzS+1t9kPmlh5D4KOo84kbHWC2fAu4
 ghJRtX75TyRgP7qIIIO7OXRMJWkBXMSlhju8kmBbjIFQP+1khspj+XjdFPFjDZSxIH
 TKa/lZztTjtaw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 3/8] hw/pci-host/astro: Implement LMMIO registers
Date: Tue, 31 Mar 2026 20:52:14 +0200
Message-ID: <20260331185219.12187-4-deller@kernel.org>
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

Add code to adjust the memory mapping windows according to the LMMIO registers
in Astro.  This allows SeaBIOS-hppa to configure Astro depending on existing
PCI cards, and especially makes it possible to enable a VGA PCI card.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/pci-host/astro.c         | 84 +++++++++++++++++++++++++++++++++----
 include/hw/pci-host/astro.h |  8 +++-
 2 files changed, 81 insertions(+), 11 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index b3eec4a291..a0afa09198 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -530,6 +530,78 @@ static ElroyState *elroy_init(int num)
  * Astro Runway chip.
  */
 
+static void adjust_LMMIO_mapping(AstroState *s)
+{
+    MemoryRegion *lmmio;
+    uint64_t map_addr, map_size, align_mask;
+    uint32_t map_route, map_enabled, i;
+
+    lmmio = &s->lmmio;
+
+    /* read LMMIO distributed route and calculate size */
+    map_route = s->ioc_ranges[(0x370 - 0x300) / 8] >> 58;
+    map_route = MIN(MAX(map_route, 20), 23);
+
+    /* calculate size of each mapping, sum of all is 8-64 MB */
+    map_size  = 1ULL << map_route;
+    align_mask = ~(map_size - 1);
+
+    /* read LMMIO_DIST_BASE for mapping address */
+    map_addr  = s->ioc_ranges[(0x360 - 0x300) / 8];
+    map_enabled = map_addr & 1;
+    map_addr  &= MAKE_64BIT_MASK(24, 5);
+    map_addr  |= MAKE_64BIT_MASK(29, 36);
+    map_addr  &= align_mask;
+    s->ioc_ranges[(0x360 - 0x300) / 8] = map_addr | map_enabled;
+
+    /* make sure the lmmio region is initially turned off */
+    if (lmmio->enabled) {
+        memory_region_set_enabled(lmmio, false);
+    }
+
+    /* exit if range is not enabled */
+    if (!map_enabled) {
+        return;
+    }
+
+    if (!lmmio->name) {
+        memory_region_init_io(lmmio, OBJECT(s), &unassigned_io_ops, s,
+                    "LMMIO", ROPES_PER_IOC * map_size);
+        memory_region_add_subregion_overlap(get_system_memory(),
+                    map_addr, lmmio, 1);
+    }
+
+    memory_region_set_address(lmmio, map_addr);
+    memory_region_set_size(lmmio, ROPES_PER_IOC * map_size);
+    memory_region_set_enabled(lmmio, true);
+
+    for (i = 0; i < ELROY_NUM; i++) {
+        MemoryRegion *alias;
+        ElroyState *elroy;
+        int rope;
+
+        elroy = s->elroy[i];
+        alias = &elroy->lmmio_alias;
+        rope = elroy_rope_nr[i];
+        if (alias->enabled) {
+            memory_region_set_enabled(alias, false);
+        }
+
+        if (!alias->name) {
+            memory_region_init_alias(alias, OBJECT(elroy),
+                 "lmmio-alias", &elroy->pci_mmio, 0, map_size);
+            memory_region_add_subregion_overlap(lmmio, rope * map_size,
+                 alias, 2);
+        }
+
+        memory_region_set_address(alias, rope * map_size);
+        memory_region_set_alias_offset(alias,
+                (uint32_t) (map_addr + rope * map_size));
+        memory_region_set_size(alias, map_size);
+        memory_region_set_enabled(alias, true);
+    }
+}
+
 static void adjust_LMMIO_DIRECT_mapping(AstroState *s, unsigned int reg_index)
 {
     MemoryRegion *lmmio_alias;
@@ -689,6 +761,9 @@ static MemTxResult astro_chip_write_with_attrs(void *opaque, hwaddr addr,
         if (index < LMMIO_DIRECT_RANGES * 3) {
             adjust_LMMIO_DIRECT_mapping(s, index);
         }
+        if (addr >= 0x360 && addr <= 0x370 + 7) {
+            adjust_LMMIO_mapping(s);
+        }
         break;
     case 0x10200:
     case 0x10220:
@@ -892,15 +967,6 @@ static void astro_realize(DeviceState *obj, Error **errp)
         elroy->mmio_base[(0x0240 - 0x200) / 8] = rope * map_size | 0x01;
         elroy->mmio_base[(0x0248 - 0x200) / 8] = 0x0000e000;
 
-        /* map elroys mmio */
-        map_size = LMMIO_DIST_BASE_SIZE / ROPES_PER_IOC;
-        map_addr = F_EXTEND(LMMIO_DIST_BASE_ADDR + rope * map_size);
-        memory_region_init_alias(&elroy->pci_mmio_alias, OBJECT(elroy),
-                                 "pci-mmio-alias",
-                                 &elroy->pci_mmio, (uint32_t) map_addr, map_size);
-        memory_region_add_subregion(get_system_memory(), map_addr,
-                                 &elroy->pci_mmio_alias);
-
         /* map elroys io */
         map_size = IOS_DIST_BASE_SIZE / ROPES_PER_IOC;
         map_addr = F_EXTEND(IOS_DIST_BASE_ADDR + rope * map_size);
diff --git a/include/hw/pci-host/astro.h b/include/hw/pci-host/astro.h
index 5eb1fa57c1..0cd384bceb 100644
--- a/include/hw/pci-host/astro.h
+++ b/include/hw/pci-host/astro.h
@@ -61,9 +61,10 @@ struct ElroyState {
     MemoryRegion this_mem;
 
     MemoryRegion pci_mmio;
-    MemoryRegion pci_mmio_alias;
-    MemoryRegion pci_hole;
     MemoryRegion pci_io;
+
+    MemoryRegion gmmio_alias;
+    MemoryRegion lmmio_alias;
 };
 
 struct AstroState {
@@ -89,6 +90,9 @@ struct AstroState {
     MemoryRegion this_mem;
     MemoryRegion lmmio_direct[LMMIO_DIRECT_RANGES];
 
+    MemoryRegion lmmio;
+    MemoryRegion gmmio;
+
     IOMMUMemoryRegion iommu;
     AddressSpace iommu_as;
 };
-- 
2.53.0


