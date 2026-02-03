Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D70E87846
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 16:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnJAX-0004Et-2l; Tue, 03 Feb 2026 11:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vnJAT-0004BU-V4
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:22:21 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vnJAR-0008Fl-Vy
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:22:21 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E365E596EA1;
 Tue, 03 Feb 2026 17:22:16 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id aLgZPOZdV8mM; Tue,  3 Feb 2026 17:22:14 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DB65E596E8E; Tue, 03 Feb 2026 17:22:14 +0100 (CET)
Message-ID: <3443aa58705abff242c618e6c4077b210cc05d29.1770131168.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1770131168.git.balaton@eik.bme.hu>
References: <cover.1770131168.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 4/7] memory: Factor out common ram region initialization
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
Date: Tue, 03 Feb 2026 17:22:14 +0100 (CET)
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

Introduce internal memory_region_do_init_ram() function to remove
duplicated code from different memory_region_init_*ram functions.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 system/memory.c | 129 ++++++++++++++++++------------------------------
 1 file changed, 47 insertions(+), 82 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index e15f931a8a..2c5e8b2a15 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1579,19 +1579,18 @@ void memory_region_init_io(MemoryRegion *mr,
     memory_region_set_ops(mr, ops, opaque);
 }
 
-bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
-                                            Object *owner,
-                                            const char *name,
-                                            uint64_t size,
-                                            uint32_t ram_flags,
-                                            Error **errp)
+/*
+ * Called after allocating mr->ram_block with a qemu_ram_alloc_* function it
+ * finishes setting memory region as ram and checks for err,  returns true on
+ * success or propagates error to errp and frees memory region on error
+ * returning false.
+ */
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
@@ -1601,6 +1600,17 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
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
 bool memory_region_init_resizeable_ram(MemoryRegion *mr,
                                        Object *owner,
                                        const char *name,
@@ -1612,108 +1622,66 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
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
@@ -3764,15 +3732,12 @@ bool memory_region_init_rom_device(MemoryRegion *mr,
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
+    if (!memory_region_do_init_ram(mr, err, errp)) {
         return false;
     }
+    mr->ram = false;
+    mr->rom_device = true;
     /* This will assert if owner is neither NULL nor a DeviceState.
      * We only want the owner here for the purposes of defining a
      * unique name for migration. TODO: Ideally we should implement
-- 
2.41.3


