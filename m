Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20440EB2705
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 20:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vptwT-0000re-Nb; Tue, 10 Feb 2026 15:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vptwG-0000oz-AJ
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:02:25 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vptwA-00050d-QD
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:02:22 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 581D0596A10;
 Tue, 10 Feb 2026 21:02:11 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id BnPQAovbLwJZ; Tue, 10 Feb 2026 21:02:09 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 441775969F6; Tue, 10 Feb 2026 21:02:09 +0100 (CET)
Message-ID: <db602a83022c69230080087539e4b68d6b9107ee.1770753117.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1770753117.git.balaton@eik.bme.hu>
References: <cover.1770753117.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 1/6] memory: Add memory_region_new* functions
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
Date: Tue, 10 Feb 2026 21:02:09 +0100 (CET)
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
 system/memory.c         | 181 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 262 insertions(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index d4793a08a7..ab76433c54 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1324,6 +1324,10 @@ void memory_region_init(MemoryRegion *mr,
                         const char *name,
                         uint64_t size);
 
+MemoryRegion *memory_region_new(Object *owner,
+                                const char *name,
+                                uint64_t size);
+
 /**
  * memory_region_ref: Add 1 to a memory region's reference count
  *
@@ -1374,6 +1378,12 @@ void memory_region_init_io(MemoryRegion *mr,
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
@@ -1400,6 +1410,12 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
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
@@ -1432,6 +1448,16 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
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
@@ -1467,6 +1493,15 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr,
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
@@ -1495,6 +1530,15 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr,
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
@@ -1518,6 +1562,11 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
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
@@ -1546,6 +1595,11 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
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
@@ -1565,6 +1619,12 @@ void memory_region_init_alias(MemoryRegion *mr,
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
@@ -1630,6 +1690,16 @@ bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
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
@@ -1659,6 +1729,11 @@ bool memory_region_init_rom(MemoryRegion *mr,
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
@@ -1694,6 +1769,12 @@ bool memory_region_init_rom_device(MemoryRegion *mr,
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
index fa3e19e1fd..d125e8102b 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1251,6 +1251,15 @@ void memory_region_init(MemoryRegion *mr,
     memory_region_do_init(mr, owner, name, size);
 }
 
+MemoryRegion *memory_region_new(Object *owner, const char *name, uint64_t size)
+{
+    MemoryRegion *mr = MEMORY_REGION(object_new(TYPE_MEMORY_REGION));
+
+    assert(name); /* mr is attached to owner by name */
+    memory_region_do_init(mr, owner, name, size);
+    return mr;
+}
+
 static void memory_region_get_container(Object *obj, Visitor *v,
                                         const char *name, void *opaque,
                                         Error **errp)
@@ -1576,6 +1585,16 @@ void memory_region_init_io(MemoryRegion *mr, Object *owner,
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
 static void memory_region_setup_ram(MemoryRegion *mr)
 {
     mr->ram = true;
@@ -1607,6 +1626,20 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr, Object *owner,
     return memory_region_error_propagate(mr, err, errp);
 }
 
+MemoryRegion *memory_region_new_ram_flags_nomigrate(Object *owner,
+                                                    const char *name,
+                                                    uint64_t size,
+                                                    uint32_t ram_flags,
+                                                    Error **errp)
+{
+    MemoryRegion *mr = memory_region_new(owner, name, size);
+    Error *err = NULL;
+
+    memory_region_setup_ram(mr);
+    mr->ram_block = qemu_ram_alloc(size, ram_flags, mr, &err);
+    return memory_region_error_propagate(mr, err, errp) ? mr : NULL;
+}
+
 bool memory_region_init_resizeable_ram(MemoryRegion *mr,
                                        Object *owner,
                                        const char *name,
@@ -1626,6 +1659,24 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
     return memory_region_error_propagate(mr, err, errp);
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
+    Error *err = NULL;
+
+    memory_region_setup_ram(mr);
+    mr->ram_block = qemu_ram_alloc_resizeable(size, max_size, resized, mr,
+                                              &err);
+    return memory_region_error_propagate(mr, err, errp) ? mr : NULL;
+}
+
 #if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
 bool memory_region_init_ram_from_file(MemoryRegion *mr, Object *owner,
                                       const char *name, uint64_t size,
@@ -1644,6 +1695,26 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr, Object *owner,
     return memory_region_error_propagate(mr, err, errp);
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
+    Error *err = NULL;
+
+    memory_region_setup_ram(mr);
+    mr->readonly = !!(ram_flags & RAM_READONLY);
+    mr->align = align;
+    mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags, path, offset,
+                                             &err);
+    return memory_region_error_propagate(mr, err, errp) ? mr : NULL;
+}
+
 bool memory_region_init_ram_from_fd(MemoryRegion *mr, Object *owner,
                                     const char *name, uint64_t size,
                                     uint32_t ram_flags, int fd,
@@ -1658,6 +1729,21 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr, Object *owner,
                                            offset, false, &err);
     return memory_region_error_propagate(mr, err, errp);
 }
+
+MemoryRegion *memory_region_new_ram_from_fd(Object *owner,
+                                            const char *name, uint64_t size,
+                                            uint32_t ram_flags, int fd,
+                                            ram_addr_t offset, Error **errp)
+{
+    MemoryRegion *mr = memory_region_new(owner, name, size);
+    Error *err = NULL;
+
+    memory_region_setup_ram(mr);
+    mr->readonly = !!(ram_flags & RAM_READONLY);
+    mr->ram_block = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd,
+                                           offset, false, &err);
+    return memory_region_error_propagate(mr, err, errp) ? mr : NULL;
+}
 #endif
 
 static void memory_region_setup_ram_ptr(MemoryRegion *mr, uint64_t size,
@@ -1676,6 +1762,15 @@ void memory_region_init_ram_ptr(MemoryRegion *mr, Object *owner,
     memory_region_setup_ram_ptr(mr, size, ptr);
 }
 
+MemoryRegion *memory_region_new_ram_ptr(Object *owner, const char *name,
+                                        uint64_t size, void *ptr)
+{
+    MemoryRegion *mr = memory_region_new(owner, name, size);
+
+    memory_region_setup_ram_ptr(mr, size, ptr);
+    return mr;
+}
+
 void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
                                        const char *name, uint64_t size,
                                        void *ptr)
@@ -1685,6 +1780,17 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
     mr->ram_device = true;
 }
 
+MemoryRegion *memory_region_new_ram_device_ptr(Object *owner, const char *name,
+                                               uint64_t size, void *ptr)
+{
+    MemoryRegion *mr = memory_region_new(owner, name, size);
+
+    memory_region_set_ops(mr, &ram_device_mem_ops, mr);
+    memory_region_setup_ram_ptr(mr, size, ptr);
+    mr->ram_device = true;
+    return mr;
+}
+
 void memory_region_init_alias(MemoryRegion *mr, Object *owner,
                               const char *name, MemoryRegion *orig,
                               hwaddr offset, uint64_t size)
@@ -1694,6 +1800,17 @@ void memory_region_init_alias(MemoryRegion *mr, Object *owner,
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
@@ -3714,6 +3873,28 @@ bool memory_region_init_rom_device(MemoryRegion *mr, Object *owner,
     return true;
 }
 
+MemoryRegion *memory_region_new_rom_device(Object *owner,
+                                           const MemoryRegionOps *ops,
+                                           void *opaque,
+                                           const char *name, uint64_t size,
+                                           Error **errp)
+{
+    MemoryRegion *mr;
+    Error *err = NULL;
+
+    assert(ops);
+    mr = memory_region_new_io(owner, ops, opaque, name, size);
+    memory_region_setup_ram(mr);
+    mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
+    if (!memory_region_error_propagate(mr, err, errp)) {
+        return NULL;
+    }
+    mr->ram = false;
+    mr->rom_device = true;
+    memory_region_register_ram(mr, owner);
+    return mr;
+}
+
 /*
  * Support system builds with CONFIG_FUZZ using a weak symbol and a stub for
  * the fuzz_dma_read_cb callback
-- 
2.41.3


