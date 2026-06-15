Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B4ECD98DE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 22:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZFcA-0001ym-Pd; Mon, 15 Jun 2026 18:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wZFc9-0001xt-2A
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:17:05 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wZFc6-0007pe-0X
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:17:04 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2B2625969B3;
 Tue, 16 Jun 2026 00:17:00 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id f4rz0DJMie1A; Tue, 16 Jun 2026 00:16:58 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1984E59697E; Tue, 16 Jun 2026 00:16:58 +0200 (CEST)
Message-ID: <27481c145715a0574c634508c4dcef3250625ffd.1781561370.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1781561370.git.balaton@eik.bme.hu>
References: <cover.1781561370.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 2/7] memory: Add memory_region_new* functions
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 philmd@mailo.com
Date: Tue, 16 Jun 2026 00:16:58 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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
index 1417132f6d..109300b773 100644
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
@@ -1364,6 +1368,12 @@ void memory_region_init_io(MemoryRegion *mr,
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
@@ -1390,6 +1400,12 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
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
@@ -1422,6 +1438,16 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
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
@@ -1457,6 +1483,15 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr,
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
@@ -1485,6 +1520,15 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr,
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
@@ -1508,6 +1552,11 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
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
@@ -1536,6 +1585,11 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
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
@@ -1555,6 +1609,12 @@ void memory_region_init_alias(MemoryRegion *mr,
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
@@ -1620,6 +1680,16 @@ bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
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
@@ -1649,6 +1719,11 @@ bool memory_region_init_rom(MemoryRegion *mr,
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
@@ -1684,6 +1759,12 @@ bool memory_region_init_rom_device(MemoryRegion *mr,
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
index 9abdaedce0..620cbf0399 100644
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
@@ -1578,6 +1587,16 @@ void memory_region_init_io(MemoryRegion *mr, Object *owner,
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
@@ -1603,6 +1622,20 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr, Object *owner,
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
@@ -1621,6 +1654,23 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
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
@@ -1638,6 +1688,25 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr, Object *owner,
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
@@ -1652,6 +1721,21 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr, Object *owner,
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
@@ -1672,6 +1756,16 @@ void memory_region_init_ram_ptr(MemoryRegion *mr, Object *owner,
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
@@ -1682,6 +1776,18 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
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
@@ -1691,6 +1797,17 @@ void memory_region_init_alias(MemoryRegion *mr, Object *owner,
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
@@ -3670,6 +3787,19 @@ bool memory_region_init_ram(MemoryRegion *mr, Object *owner,
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
@@ -3682,6 +3812,21 @@ bool memory_region_init_ram_guest_memfd(MemoryRegion *mr, Object *owner,
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
@@ -3695,6 +3840,20 @@ bool memory_region_init_rom(MemoryRegion *mr, Object *owner,
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
@@ -3713,6 +3872,26 @@ bool memory_region_init_rom_device(MemoryRegion *mr, Object *owner,
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


