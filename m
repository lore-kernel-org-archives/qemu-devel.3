Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C81810F92EB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 18:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7eCW-0000Cf-Hg; Tue, 31 Mar 2026 14:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7eCU-0000Bz-Hp
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:52:30 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w7eCT-0001XX-1j
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:52:30 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 61234600AD;
 Tue, 31 Mar 2026 18:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F5CC19423;
 Tue, 31 Mar 2026 18:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774983148;
 bh=MSh2k1y7oTk1fTpRYev8xiXj57dzEDFrCo0wWi7Vuyk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=K8BEqOo/CAGiAWR26yId4trlB5gN2rZQ/FsxTcwAsdMTBs0U254lGowEDGxQ9IZ6l
 UW5w/I/q9LXQ3f0i+RfAOwXjGuVK0OYwqdu9ibfq8im8pbD52Wb8lQsK0jDN8Syx/B
 MevaiWjJWqZiS+dnOa1fFJs8df5eGM/S8RiNy/DZAOjvGBu6VjlrgiDgmxVBHqEddM
 H/eXJkAoLZHet6shGppHLrR6A8VMI8mD1k97UADr/ich2THmiQunSJ1xmmi6qpbM35
 rjoRUtkoGEhaKSvT1e5bPbwLHQSTvudfxF52ZgPR3uL3+Qq+VjWFiZisyPfPnG6iGQ
 tGgE+GEQgjDlQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 4/8] hw/pci-host/astro: Fix LMMIO DIRECT mappings
Date: Tue, 31 Mar 2026 20:52:15 +0200
Message-ID: <20260331185219.12187-5-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331185219.12187-1-deller@kernel.org>
References: <20260331185219.12187-1-deller@kernel.org>
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

Fix the existing code which has the mask wrong.
Implement the direct mapping via overlapping subregion with priority 3
to make sure the direct mapping gets precedence over the LMMIO region.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/pci-host/astro.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index a0afa09198..b7760c4b32 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -607,9 +607,13 @@ static void adjust_LMMIO_DIRECT_mapping(AstroState *s, unsigned int reg_index)
     MemoryRegion *lmmio_alias;
     unsigned int lmmio_index, map_route;
     hwaddr map_addr;
-    uint32_t map_size;
+    uint32_t map_size, map_enabled;
     struct ElroyState *elroy;
 
+    /* each LMMIO may access from 1 MB up to 64 MB */
+    const unsigned int lmmio_mask = ~(1 * MiB - 1);
+    const unsigned int lmmio_max_size = 64 * MiB;
+
     /* pointer to LMMIO_DIRECT entry */
     lmmio_index = reg_index / 3;
     lmmio_alias = &s->lmmio_direct[lmmio_index];
@@ -622,31 +626,38 @@ static void adjust_LMMIO_DIRECT_mapping(AstroState *s, unsigned int reg_index)
     map_route &= (ELROY_NUM - 1);
     elroy = s->elroy[map_route];
 
+    /* make sure the lmmio region is initially turned off */
     if (lmmio_alias->enabled) {
         memory_region_set_enabled(lmmio_alias, false);
     }
 
+    /* do sanity checks and calculate mmio size */
+    map_enabled = map_addr & 1;
+    map_addr &= lmmio_mask;
+    map_size &= lmmio_mask;
+    map_size = MIN(map_size, lmmio_max_size);
     map_addr = F_EXTEND(map_addr);
-    map_addr &= TARGET_PAGE_MASK;
-    map_size = (~map_size) + 1;
-    map_size &= TARGET_PAGE_MASK;
 
-    /* exit if disabled or zero map size */
-    if (!(map_addr & 1) || !map_size) {
+    /* exit if disabled or has zero size. */
+    if (!map_enabled || !map_size) {
         return;
     }
 
-    if (!memory_region_size(lmmio_alias)) {
+    if (!lmmio_alias->name) {
+        char lmmio_name[32];
+        snprintf(lmmio_name, sizeof(lmmio_name),
+                 "LMMIO-DIRECT-%u", lmmio_index);
         memory_region_init_alias(lmmio_alias, OBJECT(elroy),
-                        "pci-lmmmio-alias", &elroy->pci_mmio,
+                        lmmio_name, &elroy->pci_mmio,
                         (uint32_t) map_addr, map_size);
-        memory_region_add_subregion(get_system_memory(), map_addr,
-                                 lmmio_alias);
-    } else {
-        memory_region_set_alias_offset(lmmio_alias, map_addr);
-        memory_region_set_size(lmmio_alias, map_size);
-        memory_region_set_enabled(lmmio_alias, true);
+        memory_region_add_subregion_overlap(get_system_memory(),
+                        map_addr, lmmio_alias, 3);
     }
+
+    memory_region_set_address(lmmio_alias, map_addr);
+    memory_region_set_alias_offset(lmmio_alias, (uint32_t) map_addr);
+    memory_region_set_size(lmmio_alias, map_size);
+    memory_region_set_enabled(lmmio_alias, true);
 }
 
 static MemTxResult astro_chip_read_with_attrs(void *opaque, hwaddr addr,
-- 
2.53.0


