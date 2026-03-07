Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C7FF55113
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 23:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz0j0-0006hp-1g; Sat, 07 Mar 2026 18:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vz0iq-0006a5-8J
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 18:06:12 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vz0io-0002xo-6b
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 18:06:11 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EB50A596D9D;
 Sun, 08 Mar 2026 00:06:08 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id IU5FvFJJlFIO; Sun,  8 Mar 2026 00:06:06 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E80C3596DA3; Sun, 08 Mar 2026 00:06:06 +0100 (CET)
Message-ID: <d6db01c283149b46023ffeb9c5b368c67f6acc8d.1772924151.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1772924151.git.balaton@eik.bme.hu>
References: <cover.1772924151.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v10 8/9] memory: Factor out common ram region initialization
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
Date: Sun, 08 Mar 2026 00:06:06 +0100 (CET)
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
different memory_region_init_*ram functions. Remove local err and
error_propagate and pass errp and check return value instead.
Also shorten some function prototypes while at it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 system/memory.c | 167 ++++++++++++++++++------------------------------
 1 file changed, 61 insertions(+), 106 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 9a12224555..2cda814bd6 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1568,39 +1568,39 @@ static void memory_region_set_ops(MemoryRegion *mr,
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
+    RAMBlock *rb;
+
+    memory_region_init(mr, owner, name, size);
+    rb = qemu_ram_alloc(size, ram_flags, mr, errp);
+    return memory_region_set_ram_block(mr, rb);
+}
+
 bool memory_region_init_resizeable_ram(MemoryRegion *mr,
                                        Object *owner,
                                        const char *name,
@@ -1611,116 +1611,74 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
                                                        void *host),
                                        Error **errp)
 {
-    Error *err = NULL;
+    RAMBlock *rb;
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
+    rb = qemu_ram_alloc_resizeable(size, max_size, resized, mr, errp);
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
+    RAMBlock *rb;
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
+    rb = qemu_ram_alloc_from_file(size, mr, ram_flags, path, offset, errp);
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
+    RAMBlock *rb;
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
+    rb = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd, offset,
+                                false, errp);
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
+    RAMBlock *rb;
 
+    memory_region_init(mr, owner, name, size);
     /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
     assert(ptr != NULL);
-    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
+    rb = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
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
+    RAMBlock *rb;
+
     memory_region_init_io(mr, owner, &ram_device_mem_ops, mr, name, size);
-    mr->ram = true;
     mr->ram_device = true;
-    mr->destructor = memory_region_destructor_ram;
-
     /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
     assert(ptr != NULL);
-    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
+    rb = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
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
@@ -3732,21 +3690,18 @@ bool memory_region_init_rom_device(MemoryRegion *mr, Object *owner,
                                    const char *name, uint64_t size,
                                    Error **errp)
 {
-    Error *err = NULL;
+    RAMBlock *rb;
 
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
+    rb = qemu_ram_alloc(size, 0, mr, errp);
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


