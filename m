Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDD8E6FE51
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 21:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYAGh-0002ug-Ad; Tue, 23 Dec 2025 16:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vYAGf-0002tT-Kl
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 16:50:09 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vYAGc-000764-8u
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 16:50:09 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 69769597366;
 Tue, 23 Dec 2025 22:50:04 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id W6D93gmj164b; Tue, 23 Dec 2025 22:50:02 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4D7EC59731F; Tue, 23 Dec 2025 22:50:02 +0100 (CET)
Message-ID: <c4080a0fdb9fe225deb32f33770df731cdf45a77.1766525089.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1766525089.git.balaton@eik.bme.hu>
References: <cover.1766525089.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 6/6] memory: Add memory_region_new* functions
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael S. Tsirkin <mst@redhat.com>,
 philmd@linaro.org
Date: Tue, 23 Dec 2025 22:50:02 +0100 (CET)
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

These are counterparts of similar memory_region_init* functions but
differ in that these allocate the memory region with object_new so the
memory region will be managed by QOM and freed with the owner. This
behaviour was already documented and the reference tracking is
implemented but it could not be used without these functions because
memory_region_init* functions call object_initialize that resets the
free function of the object so it would not be freed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 include/system/memory.h | 360 ++++++++++++++++++++++++++++++++++++++++
 system/memory.c         | 212 +++++++++++++++++++++++
 2 files changed, 572 insertions(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index 3bd5ffa5e0..5bdaa52355 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1763,6 +1763,366 @@ bool memory_region_init_rom_device(MemoryRegion *mr,
                                    uint64_t size,
                                    Error **errp);
 
+/**
+ * memory_region_new: Allocate and initialize a memory region
+ *
+ * This is like memory_region_init() but allocates the #MemoryRegion and
+ * attaches it to the owner to free it when the owner is freed.
+ *
+ * @owner: the object that tracks the region's reference count
+ * @name: used for debugging; not visible to the user or ABI
+ * @size: size of the region; any subregions beyond this size will be clipped
+ *
+ * Return: Pointer to the allocated #MemoryRegion.
+ */
+MemoryRegion *memory_region_new(Object *owner,
+                                const char *name, uint64_t size);
+
+/**
+ * memory_region_new_io: Allocate and initialize an I/O memory region.
+ *
+ * This is like memory_region_init_io() but allocates the #MemoryRegion and
+ * attaches it to the owner to free it when the owner is freed.
+ *
+ * @owner: the object that tracks the region's reference count
+ * @ops: a structure containing read and write callbacks to be used when
+ *       I/O is performed on the region.
+ * @opaque: passed to the read and write callbacks of the @ops structure.
+ * @name: used for debugging; not visible to the user or ABI
+ * @size: size of the region.
+ *
+ * Return: Pointer to the allocated #MemoryRegion.
+ */
+MemoryRegion *memory_region_new_io(Object *owner,
+                                   const MemoryRegionOps *ops, void *opaque,
+                                   const char *name, uint64_t size);
+
+/**
+ * memory_region_new_ram_nomigrate:  Allocate and initialize RAM memory region.
+ *
+ * This is like memory_region_init_ram_nomigrate() but allocates the
+ * #MemoryRegion and attaches is to the owner to free when the owner is freed.
+ *
+ * @owner: the object that tracks the region's reference count
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
+ * @size: size of the region.
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Note that this function does not do anything to cause the data in the
+ * RAM memory region to be migrated; that is the responsibility of the caller.
+ *
+ * Return: Pointer to the allocated #MemoryRegion or NULL on error.
+ */
+MemoryRegion *memory_region_new_ram_nomigrate(Object *owner,
+                                              const char *name, uint64_t size,
+                                              Error **errp);
+
+/**
+ * memory_region_new_ram_flags_nomigrate:  Allocata and initialize RAM memory
+ *                                         region with flags.
+ *
+ * This is like memory_region_init_ram_flags_nomigrate() but allocates the
+ * #MemoryRegion and attaches is to the owner to free when the owner is freed.
+ *
+ * @owner: the object that tracks the region's reference count
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
+ * @size: size of the region.
+ * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_NORESERVE,
+ *             RAM_GUEST_MEMFD.
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Note that this function does not do anything to cause the data in the
+ * RAM memory region to be migrated; that is the responsibility of the caller.
+ *
+ * Return: Pointer to the allocated #MemoryRegion or NULL on error.
+ */
+MemoryRegion *memory_region_new_ram_flags_nomigrate(Object *owner,
+                                                    const char *name,
+                                                    uint64_t size,
+                                                    uint32_t ram_flags,
+                                                    Error **errp);
+
+/**
+ * memory_region_new_resizeable_ram:  Allocate and initialize memory region
+ *                                    with resizable RAM.
+ *
+ * This is like memory_region_init_resizable_ram() but allocates the
+ * #MemoryRegion and attaches is to the owner to free when the owner is freed.
+ *
+ * @owner: the object that tracks the region's reference count
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
+ * @size: used size of the region.
+ * @max_size: max size of the region.
+ * @resized: callback to notify owner about used size change.
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Note that this function does not do anything to cause the data in the
+ * RAM memory region to be migrated; that is the responsibility of the caller.
+ *
+ * Return: Pointer to the allocated #MemoryRegion or NULL on error.
+ */
+MemoryRegion *memory_region_new_resizeable_ram(Object *owner,
+                                               const char *name,
+                                               uint64_t size,
+                                               uint64_t max_size,
+                                               void (*resized)(const char*,
+                                                               uint64_t length,
+                                                               void *host),
+                                               Error **errp);
+
+/**
+ * memory_region_new_ram_from_file:  Allocate and initialize RAM memory region
+ *                                   with a mmap-ed backend.
+ *
+ * This is like memory_region_init_ram_from_file() but allocates the
+ * #MemoryRegion and attaches is to the owner to free when the owner is freed.
+ *
+ * @owner: the object that tracks the region's reference count
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
+ * @size: size of the region.
+ * @align: alignment of the region base address; if 0, the default alignment
+ *         (getpagesize()) will be used.
+ * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
+ *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
+ *             RAM_READONLY_FD, RAM_GUEST_MEMFD
+ * @path: the path in which to allocate the RAM.
+ * @offset: offset within the file referenced by path
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Note that this function does not do anything to cause the data in the
+ * RAM memory region to be migrated; that is the responsibility of the caller.
+ *
+ * Return: Pointer to the allocated #MemoryRegion or NULL on error.
+ */
+MemoryRegion *memory_region_new_ram_from_file(Object *owner,
+                                              const char *name,
+                                              uint64_t size,
+                                              uint64_t align,
+                                              uint32_t ram_flags,
+                                              const char *path,
+                                              ram_addr_t offset,
+                                              Error **errp);
+
+/**
+ * memory_region_new_ram_from_fd:  Allocate and initialize RAM memory region
+ *                                 with a mmap-ed backend.
+ *
+ * This is like memory_region_init_ram_from_fd() but allocates the
+ * #MemoryRegion and attaches is to the owner to free when the owner is freed.
+ *
+ * @owner: the object that tracks the region's reference count
+ * @name: the name of the region.
+ * @size: size of the region.
+ * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
+ *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
+ *             RAM_READONLY_FD, RAM_GUEST_MEMFD
+ * @fd: the fd to mmap.
+ * @offset: offset within the file referenced by fd
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Note that this function does not do anything to cause the data in the
+ * RAM memory region to be migrated; that is the responsibility of the caller.
+ *
+ * Return: Pointer to the allocated #MemoryRegion or NULL on error.
+ */
+MemoryRegion *memory_region_new_ram_from_fd(Object *owner,
+                                            const char *name, uint64_t size,
+                                            uint32_t ram_flags, int fd,
+                                            ram_addr_t offset, Error **errp);
+
+/**
+ * memory_region_new_ram_ptr:  Allocate and initialize RAM memory region from a
+ *                             user-provided pointer.
+ *
+ * This is like memory_region_init_ram_ptr() but allocates the
+ * #MemoryRegion and attaches is to the owner to free when the owner is freed.
+ *
+ * @owner: the object that tracks the region's reference count
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
+ * @size: size of the region.
+ * @ptr: memory to be mapped; must contain at least @size bytes.
+ *
+ * Note that this function does not do anything to cause the data in the
+ * RAM memory region to be migrated; that is the responsibility of the caller.
+ *
+ * Return: Pointer to the allocated #MemoryRegion
+ */
+MemoryRegion *memory_region_new_ram_ptr(Object *owner, const char *name,
+                                        uint64_t size, void *ptr);
+
+/**
+ * memory_region_new_ram_device_ptr:  Allocate and initialize RAM device memory
+ *                                    region from a user-provided pointer.
+ *
+ * This is like memory_region_init_ram_device_ptr() but allocates the
+ * #MemoryRegion and attaches is to the owner to free when the owner is freed.
+ *
+ * @owner: the object that tracks the region's reference count
+ * @name: the name of the region.
+ * @size: size of the region.
+ * @ptr: memory to be mapped; must contain at least @size bytes.
+ *
+ * Note that this function does not do anything to cause the data in the
+ * RAM memory region to be migrated; that is the responsibility of the caller.
+ * (For RAM device memory regions, migrating the contents rarely makes sense.)
+ *
+ * Return: Pointer to the allocated #MemoryRegion
+ */
+MemoryRegion *memory_region_new_ram_device_ptr(Object *owner, const char *name,
+                                               uint64_t size, void *ptr);
+
+/**
+ * memory_region_new_alias:  Allocate and initialize a memory region that
+ *                           aliases all or a part of another memory region.
+ *
+ * This is like memory_region_init_alias() but allocates the
+ * #MemoryRegion and attaches is to the owner to free when the owner is freed.
+ *
+ * @owner: the object that tracks the region's reference count
+ * @name: used for debugging; not visible to the user or ABI
+ * @orig: the region to be referenced; @mr will be equivalent to
+ *        @orig between @offset and @offset + @size - 1.
+ * @offset: start of the section in @orig to be referenced.
+ * @size: size of the region.
+ *
+ * Return: Pointer to the allocated #MemoryRegion
+ */
+MemoryRegion *memory_region_new_alias(Object *owner,
+                                      const char *name, MemoryRegion *orig,
+                                      hwaddr offset, uint64_t size);
+
+/**
+ * memory_region_new_rom_nomigrate:  Allocate and initialize a ROM memory
+ *                                   region.
+ *
+ * This is like memory_region_init_rom_nomigrate() but allocates the
+ * #MemoryRegion and attaches is to the owner to free when the owner is freed.
+ *
+ * @owner: the object that tracks the region's reference count
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
+ * @size: size of the region.
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Return: Pointer to the allocated #MemoryRegion or NULL on error.
+ */
+MemoryRegion *memory_region_new_rom_nomigrate(Object *owner,
+                                              const char *name, uint64_t size,
+                                              Error **errp);
+
+/**
+ * memory_region_new_rom_device_nomigrate:  Allocate and initialize a ROM
+ *                                          device memory region.
+ *
+ * This is like memory_region_init_rom_device_nomigrate() but allocates the
+ * #MemoryRegion and attaches is to the owner to free when the owner is freed.
+ *
+ * @owner: the object that tracks the region's reference count
+ * @ops: callbacks for write access handling (must not be NULL).
+ * @opaque: passed to the read and write callbacks of the @ops structure.
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
+ * @size: size of the region.
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Note that this function does not do anything to cause the data in the
+ * RAM side of the memory region to be migrated; that is the responsibility
+ * of the caller.
+ *
+ * Return: Pointer to the allocated #MemoryRegion or NULL on error.
+ */
+MemoryRegion *memory_region_new_rom_device_nomigrate(Object *owner,
+                                                     const MemoryRegionOps *ops,
+                                                     void *opaque,
+                                                     const char *name,
+                                                     uint64_t size,
+                                                     Error **errp);
+/**
+ * memory_region_new_ram - Allocate and initialize RAM memory region.
+ *
+ * This is like memory_region_init_ram() but allocates the
+ * #MemoryRegion and attaches is to the owner to free when the owner is freed.
+ *
+ * @owner: the object that tracks the region's reference count (must be
+ *         TYPE_DEVICE or a subclass of TYPE_DEVICE, or NULL)
+ * @name: name of the memory region
+ * @size: size of the region in bytes
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * TODO: Currently we restrict @owner to being either NULL (for
+ * global RAM regions with no owner) or devices, so that we can
+ * give the RAM block a unique name for migration purposes.
+ * We should lift this restriction and allow arbitrary Objects.
+ * If you pass a non-NULL non-device @owner then we will assert.
+ *
+ * Return: Pointer to the allocated #MemoryRegion or NULL on error.
+ */
+MemoryRegion *memory_region_new_ram(Object *owner,
+                                    const char *name, uint64_t size,
+                                    Error **errp);
+
+MemoryRegion *memory_region_new_ram_guest_memfd(Object *owner,
+                                                const char *name,
+                                                uint64_t size,
+                                                Error **errp);
+
+/**
+ * memory_region_new_rom: Allocate and initialize a ROM memory region.
+ *
+ * This is like memory_region_init_rom() but allocates the
+ * #MemoryRegion and attaches is to the owner to free when the owner is freed.
+ *
+ * TODO: Currently we restrict @owner to being either NULL (for
+ * global RAM regions with no owner) or devices, so that we can
+ * give the RAM block a unique name for migration purposes.
+ * We should lift this restriction and allow arbitrary Objects.
+ * If you pass a non-NULL non-device @owner then we will assert.
+ *
+ * @owner: the object that tracks the region's reference count
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
+ * @size: size of the region.
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Return: Pointer to the allocated #MemoryRegion or NULL on error.
+ */
+MemoryRegion *memory_region_new_rom(Object *owner,
+                                    const char *name, uint64_t size,
+                                    Error **errp);
+
+/**
+ * memory_region_new_rom_device:  Allocate and initialize a ROM device memory
+ *                                region.
+ *
+ * This is like memory_region_init_rom_device() but allocates the
+ * #MemoryRegion and attaches is to the owner to free when the owner is freed.
+ *
+ * TODO: Currently we restrict @owner to being either NULL (for
+ * global RAM regions with no owner) or devices, so that we can
+ * give the RAM block a unique name for migration purposes.
+ * We should lift this restriction and allow arbitrary Objects.
+ * If you pass a non-NULL non-device @owner then we will assert.
+ *
+ * @owner: the object that tracks the region's reference count
+ * @ops: callbacks for write access handling (must not be NULL).
+ * @opaque: passed to the read and write callbacks of the @ops structure.
+ * @name: Region name, becomes part of RAMBlock name used in migration stream
+ *        must be unique within any device
+ * @size: size of the region.
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Return: Pointer to the allocated #MemoryRegion or NULL on error.
+ */
+MemoryRegion *memory_region_new_rom_device(Object *owner,
+                                           const MemoryRegionOps *ops,
+                                           void *opaque,
+                                           const char *name, uint64_t size,
+                                           Error **errp);
 
 /**
  * memory_region_owner: get a memory region's owner.
diff --git a/system/memory.c b/system/memory.c
index 74244be130..c5fe65db03 100644
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
 static bool memory_region_do_init_ram(MemoryRegion *mr,
                                       Error *err, Error **errp)
 {
@@ -1610,6 +1629,26 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr, Object *owner,
                                                   errp);
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
+    mr->ram_block = qemu_ram_alloc(size, ram_flags, mr, &err);
+    return memory_region_do_init_ram(mr, err, errp) ? mr : NULL;
+}
+
+MemoryRegion *memory_region_new_ram_nomigrate(Object *owner,
+                                              const char *name, uint64_t size,
+                                              Error **errp)
+{
+    return memory_region_new_ram_flags_nomigrate(owner, name, size, 0, errp);
+}
+
 bool memory_region_init_resizeable_ram(MemoryRegion *mr,
                                        Object *owner,
                                        const char *name,
@@ -1628,6 +1667,23 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
     return memory_region_do_init_ram(mr, err, errp);
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
+    mr->ram_block = qemu_ram_alloc_resizeable(size, max_size, resized, mr,
+                                              &err);
+    return memory_region_do_init_ram(mr, err, errp) ? mr : NULL;
+}
+
 #if defined(CONFIG_POSIX) && !defined(EMSCRIPTEN)
 bool memory_region_init_ram_from_file(MemoryRegion *mr, Object *owner,
                                       const char *name, uint64_t size,
@@ -1645,6 +1701,25 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr, Object *owner,
     return memory_region_do_init_ram(mr, err, errp);
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
+    mr->readonly = !!(ram_flags & RAM_READONLY);
+    mr->align = align;
+    mr->ram_block = qemu_ram_alloc_from_file(size, mr, ram_flags, path, offset,
+                                             &err);
+    return memory_region_do_init_ram(mr, err, errp) ? mr : NULL;
+}
+
 bool memory_region_init_ram_from_fd(MemoryRegion *mr, Object *owner,
                                     const char *name, uint64_t size,
                                     uint32_t ram_flags, int fd,
@@ -1658,6 +1733,20 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr, Object *owner,
                                            offset, false, &err);
     return memory_region_do_init_ram(mr, err, errp);
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
+    mr->readonly = !!(ram_flags & RAM_READONLY);
+    mr->ram_block = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd,
+                                           offset, false, &err);
+    return memory_region_do_init_ram(mr, err, errp) ? mr : NULL;
+}
 #endif
 
 static void memory_region_do_init_ram_ptr(MemoryRegion *mr, uint64_t size,
@@ -1676,6 +1765,15 @@ void memory_region_init_ram_ptr(MemoryRegion *mr, Object *owner,
     memory_region_do_init_ram_ptr(mr, size, ptr);
 }
 
+MemoryRegion *memory_region_new_ram_ptr(Object *owner, const char *name,
+                                        uint64_t size, void *ptr)
+{
+    MemoryRegion *mr = memory_region_new(owner, name, size);
+
+    memory_region_do_init_ram_ptr(mr, size, ptr);
+    return mr;
+}
+
 void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
                                        const char *name, uint64_t size,
                                        void *ptr)
@@ -1686,6 +1784,17 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
     mr->ram_device = true;
 }
 
+MemoryRegion *memory_region_new_ram_device_ptr(Object *owner, const char *name,
+                                               uint64_t size, void *ptr)
+{
+    MemoryRegion *mr = memory_region_new(owner, name, size);
+
+    memory_region_set_ops(mr, &ram_device_mem_ops, mr);
+    memory_region_do_init_ram_ptr(mr, size, ptr);
+    mr->ram_device = true;
+    return mr;
+}
+
 void memory_region_init_alias(MemoryRegion *mr, Object *owner,
                               const char *name, MemoryRegion *orig,
                               hwaddr offset, uint64_t size)
@@ -1695,6 +1804,17 @@ void memory_region_init_alias(MemoryRegion *mr, Object *owner,
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
 bool memory_region_init_rom_nomigrate(MemoryRegion *mr, Object *owner,
                                       const char *name, uint64_t size,
                                       Error **errp)
@@ -1706,6 +1826,20 @@ bool memory_region_init_rom_nomigrate(MemoryRegion *mr, Object *owner,
     return true;
 }
 
+MemoryRegion *memory_region_new_rom_nomigrate(Object *owner,
+                                              const char *name, uint64_t size,
+                                              Error **errp)
+{
+    MemoryRegion *mr;
+
+    mr = memory_region_new_ram_nomigrate(owner, name, size, errp);
+    if (!mr) {
+        return NULL;
+    }
+    mr->readonly = true;
+    return mr;
+}
+
 bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
                                              Object *owner,
                                              const MemoryRegionOps *ops,
@@ -1729,6 +1863,27 @@ bool memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
     return ret;
 }
 
+MemoryRegion *memory_region_new_rom_device_nomigrate(Object *owner,
+                                                     const MemoryRegionOps *ops,
+                                                     void *opaque,
+                                                     const char *name,
+                                                     uint64_t size,
+                                                     Error **errp)
+{
+    MemoryRegion *mr = memory_region_new(owner, name, size);
+    Error *err = NULL;
+
+    assert(ops);
+    memory_region_set_ops(mr, ops, opaque);
+    mr->ram_block = qemu_ram_alloc(size, 0, mr, &err);
+    if (memory_region_do_init_ram(mr, err, errp)) {
+        mr->ram = false;
+        mr->rom_device = true;
+        return mr;
+    }
+    return NULL;
+}
+
 void memory_region_init_iommu(void *_iommu_mr,
                               size_t instance_size,
                               const char *mrtypename,
@@ -3703,6 +3858,19 @@ bool memory_region_init_ram(MemoryRegion *mr, Object *owner,
     return true;
 }
 
+MemoryRegion *memory_region_new_ram(Object *owner,
+                                    const char *name, uint64_t size,
+                                    Error **errp)
+{
+    MemoryRegion *mr;
+
+    mr = memory_region_new_ram_nomigrate(owner, name, size, errp);
+    if (mr) {
+        memory_region_register_ram(mr, owner);
+    }
+    return mr;
+}
+
 bool memory_region_init_ram_guest_memfd(MemoryRegion *mr, Object *owner,
                                         const char *name, uint64_t size,
                                         Error **errp)
@@ -3715,6 +3883,21 @@ bool memory_region_init_ram_guest_memfd(MemoryRegion *mr, Object *owner,
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
@@ -3726,6 +3909,19 @@ bool memory_region_init_rom(MemoryRegion *mr, Object *owner,
     return true;
 }
 
+MemoryRegion *memory_region_new_rom(Object *owner,
+                                    const char *name, uint64_t size,
+                                    Error **errp)
+{
+    MemoryRegion *mr;
+
+    mr = memory_region_new_rom_nomigrate(owner, name, size, errp);
+    if (mr) {
+        memory_region_register_ram(mr, owner);
+    }
+    return mr;
+}
+
 bool memory_region_init_rom_device(MemoryRegion *mr, Object *owner,
                                    const MemoryRegionOps *ops, void *opaque,
                                    const char *name, uint64_t size,
@@ -3739,6 +3935,22 @@ bool memory_region_init_rom_device(MemoryRegion *mr, Object *owner,
     return true;
 }
 
+MemoryRegion *memory_region_new_rom_device(Object *owner,
+                                           const MemoryRegionOps *ops,
+                                           void *opaque,
+                                           const char *name, uint64_t size,
+                                           Error **errp)
+{
+    MemoryRegion *mr;
+
+    mr = memory_region_new_rom_device_nomigrate(owner, ops, opaque, name, size,
+                                                errp);
+    if (mr) {
+        memory_region_register_ram(mr, owner);
+    }
+    return mr;
+}
+
 /*
  * Support system builds with CONFIG_FUZZ using a weak symbol and a stub for
  * the fuzz_dma_read_cb callback
-- 
2.41.3


