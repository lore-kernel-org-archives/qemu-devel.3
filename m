Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955F7E6FE51
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 21:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYAGe-0002st-Rm; Tue, 23 Dec 2025 16:50:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vYAGd-0002sJ-2j
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 16:50:07 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vYAGZ-0006sP-BT
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 16:50:06 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2002E596A0E;
 Tue, 23 Dec 2025 22:50:00 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id MT1E4ZRimBNP; Tue, 23 Dec 2025 22:49:58 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1B080596A07; Tue, 23 Dec 2025 22:49:58 +0100 (CET)
Message-ID: <c648e425d67ec3a7ebf51e40c2d149beb553569c.1766525089.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1766525089.git.balaton@eik.bme.hu>
References: <cover.1766525089.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 2/6] memory: Factor out common ram region initialization
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael S. Tsirkin <mst@redhat.com>,
 philmd@linaro.org
Date: Tue, 23 Dec 2025 22:49:58 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Introduce internal memory_region_do_init_ram() function to remove
duplicated code from different memory_region_init_*ram functions.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 system/memory.c | 147 +++++++++++++++++-------------------------------
 1 file changed, 53 insertions(+), 94 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index a003095632..87c8e78662 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1579,29 +1579,12 @@ void memory_region_init_io(MemoryRegion *mr,
     memory_region_set_ops(mr, ops, opaque);
 }
 
-bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
-                                      Object *owner,
-                                      const char *name,
-                                      uint64_t size,
-                                      Error **errp)
-{
-    return memory_region_init_ram_flags_nomigrate(mr, owner, name,
-                                                  size, 0, errp);
-}
-
-bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
-                                            Object *owner,
-                                            const char *name,
-                                            uint64_t size,
-                                            uint32_t ram_flags,
-                                            Error **errp)
+static bool memory_region_do_init_ram(MemoryRegion *mr,
+                                      Error *err, Error **errp)
 {
-    Error *err = NULL;
-    memory_region_init(mr, owner, name, size);
     mr->ram = true;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc(size, ram_flags, mr, &err);
     if (err) {
         mr->size = int128_zero();
         object_unparent(OBJECT(mr));
@@ -1611,6 +1594,25 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
     return true;
 }
 
+bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr, Object *owner,
+                                            const char *name, uint64_t size,
+                                            uint32_t ram_flags, Error **errp)
+{
+    Error *err = NULL;
+
+    memory_region_init(mr, owner, name, size);
+    mr->ram_block = qemu_ram_alloc(size, ram_flags, mr, &err);
+    return memory_region_do_init_ram(mr, err, errp);
+}
+
+bool memory_region_init_ram_nomigrate(MemoryRegion *mr, Object *owner,
+                                      const char *name, uint64_t size,
+                                      Error **errp)
+{
+    return memory_region_init_ram_flags_nomigrate(mr, owner, name, size, 0,
+                                                  errp);
+}
+
 bool memory_region_init_resizeable_ram(MemoryRegion *mr,
                                        Object *owner,
                                        const char *name,
@@ -1622,108 +1624,66 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
                                        Error **errp)
 {
     Error *err = NULL;
+
     memory_region_init(mr, owner, name, size);
-    mr->ram = true;
-    mr->terminates = true;
-    mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc_resizeable(size, max_size, resized,
-                                              mr, &err);
-    if (err) {
-        mr->size = int128_zero();
-        object_unparent(OBJECT(mr));
-        error_propagate(errp, err);
-        return false;
-    }
-    return true;
+    mr->ram_block = qemu_ram_alloc_resizeable(size, max_size, resized, mr,
+                                              &err);
+    return memory_region_do_init_ram(mr, err, errp);
 }
 
 #if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
-bool memory_region_init_ram_from_file(MemoryRegion *mr,
-                                      Object *owner,
-                                      const char *name,
-                                      uint64_t size,
-                                      uint64_t align,
-                                      uint32_t ram_flags,
-                                      const char *path,
-                                      ram_addr_t offset,
+bool memory_region_init_ram_from_file(MemoryRegion *mr, Object *owner,
+                                      const char *name, uint64_t size,
+                                      uint64_t align, uint32_t ram_flags,
+                                      const char *path, ram_addr_t offset,
                                       Error **errp)
 {
     Error *err = NULL;
+
     memory_region_init(mr, owner, name, size);
-    mr->ram = true;
     mr->readonly = !!(ram_flags & RAM_READONLY);
-    mr->terminates = true;
-    mr->destructor = memory_region_destructor_ram;
     mr->align = align;
-    mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags, path,
-                                             offset, &err);
-    if (err) {
-        mr->size = int128_zero();
-        object_unparent(OBJECT(mr));
-        error_propagate(errp, err);
-        return false;
-    }
-    return true;
+    mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags, path, offset,
+                                             &err);
+    return memory_region_do_init_ram(mr, err, errp);
 }
 
-bool memory_region_init_ram_from_fd(MemoryRegion *mr,
-                                    Object *owner,
-                                    const char *name,
-                                    uint64_t size,
-                                    uint32_t ram_flags,
-                                    int fd,
-                                    ram_addr_t offset,
-                                    Error **errp)
+bool memory_region_init_ram_from_fd(MemoryRegion *mr, Object *owner,
+                                    const char *name, uint64_t size,
+                                    uint32_t ram_flags, int fd,
+                                    ram_addr_t offset, Error **errp)
 {
     Error *err = NULL;
+
     memory_region_init(mr, owner, name, size);
-    mr->ram = true;
     mr->readonly = !!(ram_flags & RAM_READONLY);
-    mr->terminates = true;
-    mr->destructor = memory_region_destructor_ram;
     mr->ram_block = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd,
                                            offset, false, &err);
-    if (err) {
-        mr->size = int128_zero();
-        object_unparent(OBJECT(mr));
-        error_propagate(errp, err);
-        return false;
-    }
-    return true;
+    return memory_region_do_init_ram(mr, err, errp);
 }
 #endif
 
-void memory_region_init_ram_ptr(MemoryRegion *mr,
-                                Object *owner,
-                                const char *name,
-                                uint64_t size,
-                                void *ptr)
+void memory_region_init_ram_ptr(MemoryRegion *mr, Object *owner,
+                                const char *name, uint64_t size, void *ptr)
 {
     memory_region_init(mr, owner, name, size);
-    mr->ram = true;
-    mr->terminates = true;
-    mr->destructor = memory_region_destructor_ram;
-
     /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
     assert(ptr != NULL);
     mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
+    memory_region_do_init_ram(mr, NULL, NULL);
 }
 
-void memory_region_init_ram_device_ptr(MemoryRegion *mr,
-                                       Object *owner,
-                                       const char *name,
-                                       uint64_t size,
+void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
+                                       const char *name, uint64_t size,
                                        void *ptr)
 {
     memory_region_init(mr, owner, name, size);
-    mr->ram = true;
-    mr->ram_device = true;
     memory_region_set_ops(mr, &ram_device_mem_ops, mr);
-    mr->destructor = memory_region_destructor_ram;
-
     /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
     assert(ptr != NULL);
     mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
+    memory_region_do_init_ram(mr, NULL, NULL);
+    mr->ram_device = true;
 }
 
 void memory_region_init_alias(MemoryRegion *mr,
@@ -1762,19 +1722,18 @@ bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
                                              Error **errp)
 {
     Error *err = NULL;
+    bool ret;
+
     assert(ops);
     memory_region_init(mr, owner, name, size);
     memory_region_set_ops(mr, ops, opaque);
-    mr->rom_device = true;
-    mr->destructor = memory_region_destructor_ram;
     mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
-    if (err) {
-        mr->size = int128_zero();
-        object_unparent(OBJECT(mr));
-        error_propagate(errp, err);
-        return false;
+    ret = memory_region_do_init_ram(mr, err, errp);
+    if (ret) {
+        mr->ram = false;
+        mr->rom_device = true;
     }
-    return true;
+    return ret;
 }
 
 void memory_region_init_iommu(void *_iommu_mr,
-- 
2.41.3


