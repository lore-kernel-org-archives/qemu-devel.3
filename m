Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50729CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 15:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRXXA-00038h-OH; Mon, 25 May 2026 11:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wRXX0-00035q-TR
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:47:56 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wRXWw-0006c0-Qo
 for qemu-devel@nongnu.org; Mon, 25 May 2026 11:47:54 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4613A596949;
 Mon, 25 May 2026 17:47:48 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id i4KOZh4BsUKX; Mon, 25 May 2026 17:47:46 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 38D12596942; Mon, 25 May 2026 17:47:46 +0200 (CEST)
Message-ID: <b92d499b73f6c8683c8d1311b2d2354985ef702a.1779723483.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1779723483.git.balaton@eik.bme.hu>
References: <cover.1779723483.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 2/7] memory: Add memory_region_new* functions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Mon, 25 May 2026 17:47:46 +0200 (CEST)
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

These are counterparts of similar memory_region_init* functions but
differ in that these allocate the memory region with object_new so the
memory region will be managed by QOM and freed with the owner. This
behaviour was already documented and the reference tracking is
implemented but it could not be used without these functions because
memory_region_init* functions call object_initialize that clears the
free function of the object so it would not be freed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 include/system/memory.h |  81 ++++++++++++++++++
 system/memory.c         | 179 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 260 insertions(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index da07b52885..31e555c624 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1314,6 +1314,10 @@ void memory_region_init(MemoryRegion *mr,
                         const char *name,
                         uint64_t size);
 
+MemoryRegion *memory_region_new(Object *owner,
+                                const char *name,
+                                uint64_t size);
+
 /**
  * memory_region_ref: Add 1 to a memory region's reference count
  *
@@ -1377,6 +1381,12 @@ void memory_region_init_io(MemoryRegion *mr,
                            const char *name,
                            uint64_t size);
 
+MemoryRegion *memory_region_new_io(Object *owner,
+                                   const MemoryRegionOps *ops,
+                                   void *opaque,
+                                   const char *name,
+                                   uint64_t size);
+
 /**
  * memory_region_init_ram_flags_nomigrate:  Initialize RAM memory region.
  *                                          Accesses into the region will
@@ -1403,6 +1413,12 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
                                             uint32_t ram_flags,
                                             Error **errp);
 
+MemoryRegion *memory_region_new_ram_flags_nomigrate(Object *owner,
+                                                    const char *name,
+                                                    uint64_t size,
+                                                    uint32_t ram_flags,
+                                                    Error **errp);
+
 /**
  * memory_region_init_resizeable_ram:  Initialize memory region with resizable
  *                                     RAM.  Accesses into the region will
@@ -1435,6 +1451,16 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
                                                        uint64_t length,
                                                        void *host),
                                        Error **errp);
+
+MemoryRegion *memory_region_new_resizeable_ram(Object *owner,
+                                               const char *name,
+                                               uint64_t size,
+                                               uint64_t max_size,
+                                               void (*resized)(const char*,
+                                                               uint64_t length,
+                                                               void *host),
+                                               Error **errp);
+
 #ifdef CONFIG_POSIX
 
 /**
@@ -1470,6 +1496,15 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr,
                                       ram_addr_t offset,
                                       Error **errp);
 
+MemoryRegion *memory_region_new_ram_from_file(Object *owner,
+                                              const char *name,
+                                              uint64_t size,
+                                              uint64_t align,
+                                              uint32_t ram_flags,
+                                              const char *path,
+                                              ram_addr_t offset,
+                                              Error **errp);
+
 /**
  * memory_region_init_ram_from_fd:  Initialize RAM memory region with a
  *                                  mmap-ed backend.
@@ -1498,6 +1533,15 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr,
                                     int fd,
                                     ram_addr_t offset,
                                     Error **errp);
+
+MemoryRegion *memory_region_new_ram_from_fd(Object *owner,
+                                            const char *name,
+                                            uint64_t size,
+                                            uint32_t ram_flags,
+                                            int fd,
+                                            ram_addr_t offset,
+                                            Error **errp);
+
 #endif
 
 /**
@@ -1521,6 +1565,11 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
                                 uint64_t size,
                                 void *ptr);
 
+MemoryRegion *memory_region_new_ram_ptr(Object *owner,
+                                        const char *name,
+                                        uint64_t size,
+                                        void *ptr);
+
 /**
  * memory_region_init_ram_device_ptr:  Initialize RAM device memory region from
  *                                     a user-provided pointer.
@@ -1549,6 +1598,11 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
                                        uint64_t size,
                                        void *ptr);
 
+MemoryRegion *memory_region_new_ram_device_ptr(Object *owner,
+                                               const char *name,
+                                               uint64_t size,
+                                               void *ptr);
+
 /**
  * memory_region_init_alias: Initialize a memory region that aliases all or a
  *                           part of another memory region.
@@ -1568,6 +1622,12 @@ void memory_region_init_alias(MemoryRegion *mr,
                               hwaddr offset,
                               uint64_t size);
 
+MemoryRegion *memory_region_new_alias(Object *owner,
+                                      const char *name,
+                                      MemoryRegion *orig,
+                                      hwaddr offset,
+                                      uint64_t size);
+
 /**
  * memory_region_init_iommu: Initialize a memory region of a custom type
  * that translates addresses
@@ -1633,6 +1693,16 @@ bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
                                         uint64_t size,
                                         Error **errp);
 
+MemoryRegion *memory_region_new_ram(Object *owner,
+                                    const char *name,
+                                    uint64_t size,
+                                    Error **errp);
+
+MemoryRegion *memory_region_new_ram_guest_memfd(Object *owner,
+                                                const char *name,
+                                                uint64_t size,
+                                                Error **errp);
+
 /**
  * memory_region_init_rom: Initialize a ROM memory region.
  *
@@ -1662,6 +1732,11 @@ bool memory_region_init_rom(MemoryRegion *mr,
                             uint64_t size,
                             Error **errp);
 
+MemoryRegion *memory_region_new_rom(Object *owner,
+                                    const char *name,
+                                    uint64_t size,
+                                    Error **errp);
+
 /**
  * memory_region_init_rom_device:  Initialize a ROM memory region.
  *                                 Writes are handled via callbacks.
@@ -1697,6 +1772,12 @@ bool memory_region_init_rom_device(MemoryRegion *mr,
                                    uint64_t size,
                                    Error **errp);
 
+MemoryRegion *memory_region_new_rom_device(Object *owner,
+                                           const MemoryRegionOps *ops,
+                                           void *opaque,
+                                           const char *name,
+                                           uint64_t size,
+                                           Error **errp);
 
 /**
  * memory_region_owner: get a memory region's owner.
diff --git a/system/memory.c b/system/memory.c
index edcdf91d48..19a9d1cd5d 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1252,6 +1252,15 @@ void memory_region_init(MemoryRegion *mr,
     memory_region_do_init(mr, owner, name, size);
 }
 
+MemoryRegion *memory_region_new(Object *owner, const char *name, uint64_t size)
+{
+    MemoryRegion *mr = MEMORY_REGION(object_new(TYPE_MEMORY_REGION));
+
+    g_assert(name); /* mr is attached to owner by name */
+    memory_region_do_init(mr, owner, name, size);
+    return mr;
+}
+
 static void memory_region_get_container(Object *obj, Visitor *v,
                                         const char *name, void *opaque,
                                         Error **errp)
@@ -1577,6 +1586,16 @@ void memory_region_init_io(MemoryRegion *mr, Object *owner,
     memory_region_set_ops(mr, ops, opaque);
 }
 
+MemoryRegion *memory_region_new_io(Object *owner,
+                                   const MemoryRegionOps *ops, void *opaque,
+                                   const char *name, uint64_t size)
+{
+    MemoryRegion *mr = memory_region_new(owner, name, size);
+
+    memory_region_set_ops(mr, ops, opaque);
+    return mr;
+}
+
 static bool memory_region_set_ram_block(MemoryRegion *mr, RAMBlock *rb)
 {
     mr->terminates = true;
@@ -1602,6 +1621,20 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr, Object *owner,
     return memory_region_set_ram_block(mr, rb);
 }
 
+MemoryRegion *memory_region_new_ram_flags_nomigrate(Object *owner,
+                                                    const char *name,
+                                                    uint64_t size,
+                                                    uint32_t ram_flags,
+                                                    Error **errp)
+{
+    MemoryRegion *mr = memory_region_new(owner, name, size);
+    RAMBlock *rb;
+
+    mr->ram = true;
+    rb = qemu_ram_alloc(size, ram_flags, mr, errp);
+    return memory_region_set_ram_block(mr, rb) ? mr : NULL;
+}
+
 bool memory_region_init_resizeable_ram(MemoryRegion *mr,
                                        Object *owner,
                                        const char *name,
@@ -1620,6 +1653,23 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
     return memory_region_set_ram_block(mr, rb);
 }
 
+MemoryRegion *memory_region_new_resizeable_ram(Object *owner,
+                                               const char *name,
+                                               uint64_t size,
+                                               uint64_t max_size,
+                                               void (*resized)(const char*,
+                                                               uint64_t length,
+                                                               void *host),
+                                               Error **errp)
+{
+    MemoryRegion *mr = memory_region_new(owner, name, size);
+    RAMBlock *rb;
+
+    mr->ram = true;
+    rb = qemu_ram_alloc_resizeable(size, max_size, resized, mr, errp);
+    return memory_region_set_ram_block(mr, rb) ? mr : NULL;
+}
+
 #if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
 bool memory_region_init_ram_from_file(MemoryRegion *mr, Object *owner,
                                       const char *name, uint64_t size,
@@ -1637,6 +1687,25 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr, Object *owner,
     return memory_region_set_ram_block(mr, rb);
 }
 
+MemoryRegion *memory_region_new_ram_from_file(Object *owner,
+                                              const char *name,
+                                              uint64_t size,
+                                              uint64_t align,
+                                              uint32_t ram_flags,
+                                              const char *path,
+                                              ram_addr_t offset,
+                                              Error **errp)
+{
+    MemoryRegion *mr = memory_region_new(owner, name, size);
+    RAMBlock *rb;
+
+    mr->ram = true;
+    mr->readonly = !!(ram_flags & RAM_READONLY);
+    mr->align = align;
+    rb = qemu_ram_alloc_from_file(size, mr, ram_flags, path, offset, errp);
+    return memory_region_set_ram_block(mr, rb) ? mr : NULL;
+}
+
 bool memory_region_init_ram_from_fd(MemoryRegion *mr, Object *owner,
                                     const char *name, uint64_t size,
                                     uint32_t ram_flags, int fd,
@@ -1651,6 +1720,21 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr, Object *owner,
                                 false, errp);
     return memory_region_set_ram_block(mr, rb);
 }
+
+MemoryRegion *memory_region_new_ram_from_fd(Object *owner,
+                                            const char *name, uint64_t size,
+                                            uint32_t ram_flags, int fd,
+                                            ram_addr_t offset, Error **errp)
+{
+    MemoryRegion *mr = memory_region_new(owner, name, size);
+    RAMBlock *rb;
+
+    mr->ram = true;
+    mr->readonly = !!(ram_flags & RAM_READONLY);
+    rb = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd, offset,
+                                false, errp);
+    return memory_region_set_ram_block(mr, rb) ? mr : NULL;
+}
 #endif
 
 static void memory_region_set_ram_ptr(MemoryRegion *mr, uint64_t size,
@@ -1671,6 +1755,16 @@ void memory_region_init_ram_ptr(MemoryRegion *mr, Object *owner,
     memory_region_set_ram_ptr(mr, size, ptr);
 }
 
+MemoryRegion *memory_region_new_ram_ptr(Object *owner, const char *name,
+                                        uint64_t size, void *ptr)
+{
+    MemoryRegion *mr = memory_region_new(owner, name, size);
+
+    mr->ram = true;
+    memory_region_set_ram_ptr(mr, size, ptr);
+    return mr;
+}
+
 void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
                                        const char *name, uint64_t size,
                                        void *ptr)
@@ -1681,6 +1775,18 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
     memory_region_set_ram_ptr(mr, size, ptr);
 }
 
+MemoryRegion *memory_region_new_ram_device_ptr(Object *owner, const char *name,
+                                               uint64_t size, void *ptr)
+{
+    MemoryRegion *mr = memory_region_new(owner, name, size);
+
+    memory_region_set_ops(mr, &ram_device_mem_ops, mr);
+    mr->ram = true;
+    mr->ram_device = true;
+    memory_region_set_ram_ptr(mr, size, ptr);
+    return mr;
+}
+
 void memory_region_init_alias(MemoryRegion *mr, Object *owner,
                               const char *name, MemoryRegion *orig,
                               hwaddr offset, uint64_t size)
@@ -1690,6 +1796,17 @@ void memory_region_init_alias(MemoryRegion *mr, Object *owner,
     mr->alias_offset = offset;
 }
 
+MemoryRegion *memory_region_new_alias(Object *owner,
+                                      const char *name, MemoryRegion *orig,
+                                      hwaddr offset, uint64_t size)
+{
+    MemoryRegion *mr = memory_region_new(owner, name, size);
+
+    mr->alias = orig;
+    mr->alias_offset = offset;
+    return mr;
+}
+
 void memory_region_init_iommu(void *_iommu_mr,
                               size_t instance_size,
                               const char *mrtypename,
@@ -3669,6 +3786,19 @@ bool memory_region_init_ram(MemoryRegion *mr, Object *owner,
     return true;
 }
 
+MemoryRegion *memory_region_new_ram(Object *owner,
+                                    const char *name, uint64_t size,
+                                    Error **errp)
+{
+    MemoryRegion *mr;
+
+    mr = memory_region_new_ram_flags_nomigrate(owner, name, size, 0, errp);
+    if (mr) {
+        memory_region_register_ram(mr, owner);
+    }
+    return mr;
+}
+
 bool memory_region_init_ram_guest_memfd(MemoryRegion *mr, Object *owner,
                                         const char *name, uint64_t size,
                                         Error **errp)
@@ -3681,6 +3811,21 @@ bool memory_region_init_ram_guest_memfd(MemoryRegion *mr, Object *owner,
     return true;
 }
 
+MemoryRegion *memory_region_new_ram_guest_memfd(Object *owner,
+                                                const char *name,
+                                                uint64_t size,
+                                                Error **errp)
+{
+    MemoryRegion *mr;
+
+    mr = memory_region_new_ram_flags_nomigrate(owner, name, size,
+                                               RAM_GUEST_MEMFD, errp);
+    if (mr) {
+        memory_region_register_ram(mr, owner);
+    }
+    return mr;
+}
+
 bool memory_region_init_rom(MemoryRegion *mr, Object *owner,
                             const char *name, uint64_t size,
                             Error **errp)
@@ -3694,6 +3839,20 @@ bool memory_region_init_rom(MemoryRegion *mr, Object *owner,
     return true;
 }
 
+MemoryRegion *memory_region_new_rom(Object *owner,
+                                    const char *name, uint64_t size,
+                                    Error **errp)
+{
+    MemoryRegion *mr;
+
+    mr = memory_region_new_ram_flags_nomigrate(owner, name, size, 0, errp);
+    if (mr) {
+        mr->readonly = true;
+        memory_region_register_ram(mr, owner);
+    }
+    return mr;
+}
+
 bool memory_region_init_rom_device(MemoryRegion *mr, Object *owner,
                                    const MemoryRegionOps *ops, void *opaque,
                                    const char *name, uint64_t size,
@@ -3712,6 +3871,26 @@ bool memory_region_init_rom_device(MemoryRegion *mr, Object *owner,
     return false;
 }
 
+MemoryRegion *memory_region_new_rom_device(Object *owner,
+                                           const MemoryRegionOps *ops,
+                                           void *opaque,
+                                           const char *name, uint64_t size,
+                                           Error **errp)
+{
+    MemoryRegion *mr;
+    RAMBlock *rb;
+
+    assert(ops);
+    mr = memory_region_new_io(owner, ops, opaque, name, size);
+    rb = qemu_ram_alloc(size, 0, mr, errp);
+    if (memory_region_set_ram_block(mr, rb)) {
+        mr->rom_device = true;
+        memory_region_register_ram(mr, owner);
+        return mr;
+    }
+    return NULL;
+}
+
 /*
  * Support system builds with CONFIG_FUZZ using a weak symbol and a stub for
  * the fuzz_dma_read_cb callback
-- 
2.41.3


