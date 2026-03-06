Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AA9F513EB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 01:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyKBg-0008Ls-71; Thu, 05 Mar 2026 20:41:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vyKBe-0008Kq-4y
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 20:41:06 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vyKBc-0006Fi-44
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 20:41:05 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EDA85596DA7;
 Fri, 06 Mar 2026 02:41:02 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Dth5p-P0GPa2; Fri,  6 Mar 2026 02:41:00 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E7AA8596DA2; Fri, 06 Mar 2026 02:41:00 +0100 (CET)
Message-ID: <7af26ad5d94b87bed32af860cb3de8a3ca2ced12.1772760714.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1772760714.git.balaton@eik.bme.hu>
References: <cover.1772760714.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v8 8/8] memory: Factor out common ram region initialization
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Fri, 06 Mar 2026 02:41:00 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

Introduce internal helper function to remove duplicated code from
different memory_region_init_*ram functions. Remove locall err and
error_propagate and pass errp and check return values instead.
Also shorten some function prototypes while at it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 system/memory.c | 167 +++++++++++++++++-------------------------------
 1 file changed, 58 insertions(+), 109 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 9a12224555..7781d20d41 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1568,39 +1568,38 @@ static void memory_region_set_ops(MemoryRegion *mr,
     mr->terminates = true;
 }
 
-void memory_region_init_io(MemoryRegion *mr,
-                           Object *owner,
-                           const MemoryRegionOps *ops,
-                           void *opaque,
-                           const char *name,
-                           uint64_t size)
+void memory_region_init_io(MemoryRegion *mr, Object *owner,
+                           const MemoryRegionOps *ops, void *opaque,
+                           const char *name, uint64_t size)
 {
     memory_region_init(mr, owner, name, size);
     memory_region_set_ops(mr, ops, opaque);
 }
 
-bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
-                                            Object *owner,
-                                            const char *name,
-                                            uint64_t size,
-                                            uint32_t ram_flags,
-                                            Error **errp)
+static bool memory_region_set_ram_block(MemoryRegion *mr, RAMBlock *rb)
 {
-    Error *err = NULL;
-    memory_region_init(mr, owner, name, size);
     mr->ram = true;
     mr->terminates = true;
     mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc(size, ram_flags, mr, &err);
-    if (err) {
+    mr->ram_block = rb;
+    if (!rb) {
         mr->size = int128_zero();
         object_unparent(OBJECT(mr));
-        error_propagate(errp, err);
         return false;
     }
     return true;
 }
 
+bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr, Object *owner,
+                                            const char *name, uint64_t size,
+                                            uint32_t ram_flags, Error **errp)
+{
+    RAMBlock *rb = qemu_ram_alloc(size, ram_flags, mr, errp);
+
+    memory_region_init(mr, owner, name, size);
+    return memory_region_set_ram_block(mr, rb);
+}
+
 bool memory_region_init_resizeable_ram(MemoryRegion *mr,
                                        Object *owner,
                                        const char *name,
@@ -1611,116 +1610,70 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
                                                        void *host),
                                        Error **errp)
 {
-    Error *err = NULL;
+    RAMBlock *rb = qemu_ram_alloc_resizeable(size, max_size, resized, mr, errp);
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
+    return memory_region_set_ram_block(mr, rb);
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
-    Error *err = NULL;
+    RAMBlock *rb = qemu_ram_alloc_from_file(size, mr, ram_flags, path, offset,
+                                            errp);
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
+    return memory_region_set_ram_block(mr, rb);
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
-    Error *err = NULL;
+    RAMBlock *rb = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd,
+                                          offset, false, errp);
+
     memory_region_init(mr, owner, name, size);
-    mr->ram = true;
     mr->readonly = !!(ram_flags & RAM_READONLY);
-    mr->terminates = true;
-    mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd,
-                                           offset, false, &err);
-    if (err) {
-        mr->size = int128_zero();
-        object_unparent(OBJECT(mr));
-        error_propagate(errp, err);
-        return false;
-    }
-    return true;
+    return memory_region_set_ram_block(mr, rb);
 }
 #endif
 
-void memory_region_init_ram_ptr(MemoryRegion *mr,
-                                Object *owner,
-                                const char *name,
-                                uint64_t size,
+void memory_region_init_ram_ptr(MemoryRegion *mr, Object *owner,
+                                const char *name, uint64_t size,
                                 void *ptr)
 {
-    memory_region_init(mr, owner, name, size);
-    mr->ram = true;
-    mr->terminates = true;
-    mr->destructor = memory_region_destructor_ram;
-
     /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
     assert(ptr != NULL);
-    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
+    RAMBlock *rb = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
+
+    memory_region_init(mr, owner, name, size);
+    memory_region_set_ram_block(mr, rb);
 }
 
-void memory_region_init_ram_device_ptr(MemoryRegion *mr,
-                                       Object *owner,
-                                       const char *name,
-                                       uint64_t size,
+void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
+                                       const char *name, uint64_t size,
                                        void *ptr)
 {
-    memory_region_init_io(mr, owner, &ram_device_mem_ops, mr, name, size);
-    mr->ram = true;
-    mr->ram_device = true;
-    mr->destructor = memory_region_destructor_ram;
-
     /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
     assert(ptr != NULL);
-    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
+    RAMBlock *rb = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
+
+    memory_region_init_io(mr, owner, &ram_device_mem_ops, mr, name, size);
+    mr->ram_device = true;
+    memory_region_set_ram_block(mr, rb);
 }
 
-void memory_region_init_alias(MemoryRegion *mr,
-                              Object *owner,
-                              const char *name,
-                              MemoryRegion *orig,
-                              hwaddr offset,
-                              uint64_t size)
+void memory_region_init_alias(MemoryRegion *mr, Object *owner,
+                              const char *name, MemoryRegion *orig,
+                              hwaddr offset, uint64_t size)
 {
     memory_region_init(mr, owner, name, size);
     mr->alias = orig;
@@ -3732,21 +3685,17 @@ bool memory_region_init_rom_device(MemoryRegion *mr, Object *owner,
                                    const char *name, uint64_t size,
                                    Error **errp)
 {
-    Error *err = NULL;
+    RAMBlock *rb = qemu_ram_alloc(size, 0, mr, errp);
 
     assert(ops);
     memory_region_init_io(mr, owner, ops, opaque, name, size);
-    mr->rom_device = true;
-    mr->destructor = memory_region_destructor_ram;
-    mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
-    if (err) {
-        mr->size = int128_zero();
-        object_unparent(OBJECT(mr));
-        error_propagate(errp, err);
-        return false;
+    if (memory_region_set_ram_block(mr, rb)) {
+        mr->ram = false;
+        mr->rom_device = true;
+        memory_region_register_ram(mr, owner);
+        return true;
     }
-    memory_region_register_ram(mr, owner);
-    return true;
+    return false;
 }
 
 /*
-- 
2.41.3


