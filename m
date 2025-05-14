Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FDEC3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHSM-0000lk-VE; Wed, 14 May 2025 15:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFHNB-0005ic-F2; Wed, 14 May 2025 15:02:35 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFHN9-0007o7-Cu; Wed, 14 May 2025 15:02:33 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 05493121D9E;
 Wed, 14 May 2025 22:00:33 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0C84520BA90;
 Wed, 14 May 2025 22:00:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.1 20/23] xen: mapcache: Split mapcache_grants by ro and
 rw
Date: Wed, 14 May 2025 22:00:32 +0300
Message-Id: <20250514190041.104759-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-10.0.1-20250514114019@cover.tls.msk.ru>
References: <qemu-stable-10.0.1-20250514114019@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Today, we don't track write-abiliy in the cache, if a user
requests a readable mapping followed by a writeable mapping
on the same page, the second lookup will incorrectly hit
the readable entry.

Split mapcache_grants by ro and rw access. Grants will now
have separate ways in the cache depending on writeability.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
(cherry picked from commit 88fb705600a3b612c571efc9f1a6aed923a18dcc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index 2c8f861fdb..e31d379702 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -75,7 +75,8 @@ typedef struct MapCache {
 } MapCache;
 
 static MapCache *mapcache;
-static MapCache *mapcache_grants;
+static MapCache *mapcache_grants_ro;
+static MapCache *mapcache_grants_rw;
 static xengnttab_handle *xen_region_gnttabdev;
 
 static inline void mapcache_lock(MapCache *mc)
@@ -176,9 +177,12 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
      * Grant mappings must use XC_PAGE_SIZE granularity since we can't
      * map anything beyond the number of pages granted to us.
      */
-    mapcache_grants = xen_map_cache_init_single(f, opaque,
-                                                XC_PAGE_SHIFT,
-                                                max_mcache_size);
+    mapcache_grants_ro = xen_map_cache_init_single(f, opaque,
+                                                   XC_PAGE_SHIFT,
+                                                   max_mcache_size);
+    mapcache_grants_rw = xen_map_cache_init_single(f, opaque,
+                                                   XC_PAGE_SHIFT,
+                                                   max_mcache_size);
 
     setrlimit(RLIMIT_AS, &rlimit_as);
 }
@@ -456,9 +460,13 @@ uint8_t *xen_map_cache(MemoryRegion *mr,
                        bool is_write)
 {
     bool grant = xen_mr_is_grants(mr);
-    MapCache *mc = grant ? mapcache_grants : mapcache;
+    MapCache *mc = mapcache;
     uint8_t *p;
 
+    if (grant) {
+        mc = is_write ? mapcache_grants_rw : mapcache_grants_ro;
+    }
+
     if (grant && !lock) {
         /*
          * Grants are only supported via address_space_map(). Anything
@@ -523,7 +531,10 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
 
     addr = xen_ram_addr_from_mapcache_single(mapcache, ptr);
     if (addr == RAM_ADDR_INVALID) {
-        addr = xen_ram_addr_from_mapcache_single(mapcache_grants, ptr);
+        addr = xen_ram_addr_from_mapcache_single(mapcache_grants_ro, ptr);
+    }
+    if (addr == RAM_ADDR_INVALID) {
+        addr = xen_ram_addr_from_mapcache_single(mapcache_grants_rw, ptr);
     }
 
     return addr;
@@ -626,7 +637,8 @@ static void xen_invalidate_map_cache_entry_single(MapCache *mc, uint8_t *buffer)
 static void xen_invalidate_map_cache_entry_all(uint8_t *buffer)
 {
     xen_invalidate_map_cache_entry_single(mapcache, buffer);
-    xen_invalidate_map_cache_entry_single(mapcache_grants, buffer);
+    xen_invalidate_map_cache_entry_single(mapcache_grants_ro, buffer);
+    xen_invalidate_map_cache_entry_single(mapcache_grants_rw, buffer);
 }
 
 static void xen_invalidate_map_cache_entry_bh(void *opaque)
-- 
2.39.5


