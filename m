Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146A0C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 21:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgVXv-0005Qg-Ne; Fri, 07 Feb 2025 16:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tgVXu-0005QO-01
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:05:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tgVXs-0001tS-83
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:05:53 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A95435C110C;
 Fri,  7 Feb 2025 21:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1233AC4CEE2;
 Fri,  7 Feb 2025 21:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738962351;
 bh=Stz/PkE+RsExG68z0c7Y2GO5tU8XrxTcb9wEAxlyp6M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lFIaStmALRcgaxGrIvcweERWgROIUSW/7n61KGCAAIyYsAJhS1/94LpH/jQXH3Ggt
 8PjVByJO3Q6kCB/36OIeUAppmuyjOT1TxYNogfjtF+a3uScpld7PbpsLUy1IeWML9W
 xuxmtmBbmEW33lXQhpuR9ywx2+gIDsewQbbHKw5YaTOeyv/JKQEGAso5CcO3FR5CV5
 rIYLW5dlWcKR2XJeOaWonCu9qyaIaSjGdl2VDJkETHSlN5riwcoUWcnJ9/nIhWJn1j
 v9YfgQWdoLmCXgNbRuoaip3xMjlAkNSKjiBUBtwU3sT6Fwcp9NziW1J1b5cIYZB0K4
 pCRkKkINhNgYg==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 5/6] hw/pci-host/astro: Add LMMIO range support
Date: Fri,  7 Feb 2025 22:05:39 +0100
Message-ID: <20250207210540.24594-6-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250207210540.24594-1-deller@kernel.org>
References: <20250207210540.24594-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

Each Astro on 64-bit machines supports up to four LMMIO regions.
Those regions are used by graphic cards and other PCI devices which
need to map huge memory areas. The LMMIO regions are configured and
set up by SeaBIOS-hppa and then used as-is by the operating systems
(Linux, HP-UX).

With this addition it's now possible to add other PCI graphic
cards on the command line, e.g. with "-device ati-vga".

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/pci-host/astro.c         | 52 +++++++++++++++++++++++++++++++++++++
 include/hw/pci-host/astro.h |  6 ++---
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 62e9c8acbf..039cc3ad01 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -521,6 +521,53 @@ static ElroyState *elroy_init(int num)
  * Astro Runway chip.
  */
 
+static void adjust_LMMIO_DIRECT_mapping(AstroState *s, unsigned int reg_index)
+{
+    MemoryRegion *lmmio_alias;
+    unsigned int lmmio_index, map_route;
+    hwaddr map_addr;
+    uint32_t map_size;
+    struct ElroyState *elroy;
+
+    /* pointer to LMMIO_DIRECT entry */
+    lmmio_index = reg_index / 3;
+    lmmio_alias = &s->lmmio_direct[lmmio_index];
+
+    map_addr  = s->ioc_ranges[3 * lmmio_index + 0];
+    map_size  = s->ioc_ranges[3 * lmmio_index + 1];
+    map_route = s->ioc_ranges[3 * lmmio_index + 2];
+
+    /* find elroy to which this address is routed */
+    map_route &= (ELROY_NUM - 1);
+    elroy = s->elroy[map_route];
+
+    if (lmmio_alias->enabled) {
+        memory_region_set_enabled(lmmio_alias, false);
+    }
+
+    map_addr = F_EXTEND(map_addr);
+    map_addr &= TARGET_PAGE_MASK;
+    map_size = (~map_size) + 1;
+    map_size &= TARGET_PAGE_MASK;
+
+    /* exit if disabled or zero map size */
+    if (!(map_addr & 1) || !map_size) {
+        return;
+    }
+
+    if (!memory_region_size(lmmio_alias)) {
+        memory_region_init_alias(lmmio_alias, OBJECT(elroy),
+                        "pci-lmmmio-alias", &elroy->pci_mmio,
+                        (uint32_t) map_addr, map_size);
+        memory_region_add_subregion(get_system_memory(), map_addr,
+                                 lmmio_alias);
+    } else {
+        memory_region_set_alias_offset(lmmio_alias, map_addr);
+        memory_region_set_size(lmmio_alias, map_size);
+        memory_region_set_enabled(lmmio_alias, true);
+    }
+}
+
 static MemTxResult astro_chip_read_with_attrs(void *opaque, hwaddr addr,
                                              uint64_t *data, unsigned size,
                                              MemTxAttrs attrs)
@@ -628,6 +675,11 @@ static MemTxResult astro_chip_write_with_attrs(void *opaque, hwaddr addr,
         break;
     case 0x0300 ... 0x03d8 - 1: /* LMMIO_DIRECT0_BASE... */
         put_val_in_arrary(s->ioc_ranges, 0x300, addr, size, val);
+        unsigned int index = (addr - 0x300) / 8;
+        /* check if one of the 4 LMMIO_DIRECT regs, each using 3 entries. */
+        if (index < LMMIO_DIRECT_RANGES * 3) {
+            adjust_LMMIO_DIRECT_mapping(s, index);
+        }
         break;
     case 0x10200:
     case 0x10220:
diff --git a/include/hw/pci-host/astro.h b/include/hw/pci-host/astro.h
index e2966917cd..832125a05a 100644
--- a/include/hw/pci-host/astro.h
+++ b/include/hw/pci-host/astro.h
@@ -24,6 +24,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(ElroyState, ELROY_PCI_HOST_BRIDGE)
 #define LMMIO_DIST_BASE_ADDR      0xf4000000ULL
 #define LMMIO_DIST_BASE_SIZE       0x4000000ULL
 
+#define LMMIO_DIRECT_RANGES     4
+
 #define IOS_DIST_BASE_ADDR      0xfffee00000ULL
 #define IOS_DIST_BASE_SIZE           0x10000ULL
 
@@ -83,9 +85,7 @@ struct AstroState {
     struct ElroyState *elroy[ELROY_NUM];
 
     MemoryRegion this_mem;
-
-    MemoryRegion pci_mmio;
-    MemoryRegion pci_io;
+    MemoryRegion lmmio_direct[LMMIO_DIRECT_RANGES];
 
     IOMMUMemoryRegion iommu;
     AddressSpace iommu_as;
-- 
2.47.0


