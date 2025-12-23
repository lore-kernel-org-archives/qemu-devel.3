Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA586E748F7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 21:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYAGf-0002tz-Ux; Tue, 23 Dec 2025 16:50:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vYAGe-0002sm-JV
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 16:50:08 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vYAGc-000763-Qr
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 16:50:08 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4B555597323;
 Tue, 23 Dec 2025 22:50:03 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id BgyKRMGzgd0W; Tue, 23 Dec 2025 22:50:01 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 43BB3596A0D; Tue, 23 Dec 2025 22:50:01 +0100 (CET)
Message-ID: <cb3aaafb264b8f85f57549019163ac1728583d1a.1766525089.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1766525089.git.balaton@eik.bme.hu>
References: <cover.1766525089.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 5/6] memory: Add internal memory_region_register_ram function
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael S. Tsirkin <mst@redhat.com>,
 philmd@linaro.org
Date: Tue, 23 Dec 2025 22:50:01 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Factor out common operation from memory_region_init_{ram,rom}
functions to register the region for migration. This avoids
duplicating the long comment in several functions.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 system/memory.c | 75 +++++++++++++------------------------------------
 1 file changed, 20 insertions(+), 55 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index bff9677f7a..74244be130 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3678,17 +3678,10 @@ void mtree_info(bool flatview, bool dispatch_tree, bool owner, bool disabled)
     }
 }
 
-bool memory_region_init_ram(MemoryRegion *mr,
-                            Object *owner,
-                            const char *name,
-                            uint64_t size,
-                            Error **errp)
+static void memory_region_register_ram(MemoryRegion *mr, Object *owner)
 {
     DeviceState *owner_dev;
 
-    if (!memory_region_init_ram_nomigrate(mr, owner, name, size, errp)) {
-        return false;
-    }
     /* This will assert if owner is neither NULL nor a DeviceState.
      * We only want the owner here for the purposes of defining a
      * unique name for migration. TODO: Ideally we should implement
@@ -3697,80 +3690,52 @@ bool memory_region_init_ram(MemoryRegion *mr,
      */
     owner_dev = DEVICE(owner);
     vmstate_register_ram(mr, owner_dev);
+}
 
+bool memory_region_init_ram(MemoryRegion *mr, Object *owner,
+                            const char *name, uint64_t size,
+                            Error **errp)
+{
+    if (!memory_region_init_ram_nomigrate(mr, owner, name, size, errp)) {
+        return false;
+    }
+    memory_region_register_ram(mr, owner);
     return true;
 }
 
-bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
-                                        Object *owner,
-                                        const char *name,
-                                        uint64_t size,
+bool memory_region_init_ram_guest_memfd(MemoryRegion *mr, Object *owner,
+                                        const char *name, uint64_t size,
                                         Error **errp)
 {
-    DeviceState *owner_dev;
-
     if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
                                                 RAM_GUEST_MEMFD, errp)) {
         return false;
     }
-    /* This will assert if owner is neither NULL nor a DeviceState.
-     * We only want the owner here for the purposes of defining a
-     * unique name for migration. TODO: Ideally we should implement
-     * a naming scheme for Objects which are not DeviceStates, in
-     * which case we can relax this restriction.
-     */
-    owner_dev = DEVICE(owner);
-    vmstate_register_ram(mr, owner_dev);
-
+    memory_region_register_ram(mr, owner);
     return true;
 }
 
-bool memory_region_init_rom(MemoryRegion *mr,
-                            Object *owner,
-                            const char *name,
-                            uint64_t size,
+bool memory_region_init_rom(MemoryRegion *mr, Object *owner,
+                            const char *name, uint64_t size,
                             Error **errp)
 {
-    DeviceState *owner_dev;
-
     if (!memory_region_init_rom_nomigrate(mr, owner, name, size, errp)) {
         return false;
     }
-    /* This will assert if owner is neither NULL nor a DeviceState.
-     * We only want the owner here for the purposes of defining a
-     * unique name for migration. TODO: Ideally we should implement
-     * a naming scheme for Objects which are not DeviceStates, in
-     * which case we can relax this restriction.
-     */
-    owner_dev = DEVICE(owner);
-    vmstate_register_ram(mr, owner_dev);
-
+    memory_region_register_ram(mr, owner);
     return true;
 }
 
-bool memory_region_init_rom_device(MemoryRegion *mr,
-                                   Object *owner,
-                                   const MemoryRegionOps *ops,
-                                   void *opaque,
-                                   const char *name,
-                                   uint64_t size,
+bool memory_region_init_rom_device(MemoryRegion *mr, Object *owner,
+                                   const MemoryRegionOps *ops, void *opaque,
+                                   const char *name, uint64_t size,
                                    Error **errp)
 {
-    DeviceState *owner_dev;
-
     if (!memory_region_init_rom_device_nomigrate(mr, owner, ops, opaque,
                                                  name, size, errp)) {
         return false;
     }
-    /* This will assert if owner is neither NULL nor a DeviceState.
-     * We only want the owner here for the purposes of defining a
-     * unique name for migration. TODO: Ideally we should implement
-     * a naming scheme for Objects which are not DeviceStates, in
-     * which case we can relax this restriction.
-     */
-    owner_dev = DEVICE(owner);
-    vmstate_register_ram(mr, owner_dev);
-
+    memory_region_register_ram(mr, owner);
     return true;
 }
 
-- 
2.41.3


