Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98553EB270B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 20:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vptwZ-0000uX-HF; Tue, 10 Feb 2026 15:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vptwF-0000os-Ln
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:02:25 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vptwA-00050l-QK
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:02:22 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 68C91596AE1;
 Tue, 10 Feb 2026 21:02:12 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id HLJiEWEvsFZ4; Tue, 10 Feb 2026 21:02:10 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 505F1596A0D; Tue, 10 Feb 2026 21:02:10 +0100 (CET)
Message-ID: <9ffcec7144e9ea954543ac241733504f5bc83836.1770753117.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1770753117.git.balaton@eik.bme.hu>
References: <cover.1770753117.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 2/6] memory: Update documentation for memory_region_new*()
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
Date: Tue, 10 Feb 2026 21:02:10 +0100 (CET)
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

Clarify the difference between memory_region_new() and
memory_region_init() with regard to region lifecycle.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 docs/devel/memory.rst   | 21 ++++-----
 include/system/memory.h | 98 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 10 deletions(-)

diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index 9083b18f08..988380c632 100644
--- a/docs/devel/memory.rst
+++ b/docs/devel/memory.rst
@@ -138,7 +138,8 @@ stability.
 Region lifecycle
 ----------------
 
-A region is created by one of the memory_region_init*() functions and
+A region is allocated by one of the memory_region_new*() functions or
+pre-allocated and initialized by memory_region_init*() functions and
 attached to an object, which acts as its owner or parent.  QEMU ensures
 that the owner object remains alive as long as the region is visible to
 the guest, or as long as the region is in use by a virtual CPU or another
@@ -154,16 +155,16 @@ ioeventfd) can be changed during the region lifecycle.  They take effect
 as soon as the region is made visible.  This can be immediately, later,
 or never.
 
-Destruction of a memory region happens automatically when the owner object
-dies.  When there are multiple memory regions under the same owner object,
-the memory API will guarantee all memory regions will be properly detached
-and finalized one by one.  The order in which memory regions will be
-finalized is not guaranteed.
+Destruction of a memory region allocated with memory_region_new*() functions
+happens automatically when the owner object dies.  When there are multiple
+memory regions under the same owner object, the memory API will guarantee all
+memory regions will be properly detached and finalized one by one.  The order
+in which memory regions will be finalized is not guaranteed.
 
-If however the memory region is part of a dynamically allocated data
-structure, you should free the memory region in the instance_finalize
-callback.  For an example see VFIOMSIXInfo and VFIOQuirk in
-hw/vfio/pci.c.
+If however the memory region is part of a separately allocated data structure
+and initialized with one of the memory_region_init*() functions, you may have
+to free the memory region e.g. in an instance_finalize callback.  For an
+example see VFIOMSIXInfo and VFIOQuirk in hw/vfio/pci.c.
 
 You must not destroy a memory region as long as it may be in use by a
 device or CPU.  In order to do this, as a general rule do not create or
diff --git a/include/system/memory.h b/include/system/memory.h
index ab76433c54..017c290f27 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1324,6 +1324,13 @@ void memory_region_init(MemoryRegion *mr,
                         const char *name,
                         uint64_t size);
 
+/**
+ * memory_region_new: Allocate and initialize a memory region
+ *
+ * Like memory_region_init() but @mr is allocated and managed by QOM.
+ *
+ * Return: Pointer to allocated #MemoryRegion.
+ */
 MemoryRegion *memory_region_new(Object *owner,
                                 const char *name,
                                 uint64_t size);
@@ -1378,6 +1385,13 @@ void memory_region_init_io(MemoryRegion *mr,
                            const char *name,
                            uint64_t size);
 
+/**
+ * memory_region_new_io: Allocate and initialize an I/O memory region.
+ *
+ * Like memory_region_init_io() but @mr is allocated and managed by QOM.
+ *
+ * Return: Pointer to allocated #MemoryRegion.
+ */
 MemoryRegion *memory_region_new_io(Object *owner,
                                    const MemoryRegionOps *ops,
                                    void *opaque,
@@ -1410,6 +1424,15 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr,
                                             uint32_t ram_flags,
                                             Error **errp);
 
+/**
+ * memory_region_new_ram_flags_nomigrate:  Allocate and initialize RAM memory
+ *                                         region with flags.
+ *
+ * Like memory_region_init_ram_flags_nomigrate() but @mr is allocated and
+ * managed by QOM.
+ *
+ * Return: Pointer to allocated #MemoryRegion.
+ */
 MemoryRegion *memory_region_new_ram_flags_nomigrate(Object *owner,
                                                     const char *name,
                                                     uint64_t size,
@@ -1449,6 +1472,15 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
                                                        void *host),
                                        Error **errp);
 
+/**
+ * memory_region_new_resizeable_ram:  Allocate and initialize memory region
+ *                                    with resizable RAM.
+ *
+ * Like memory_region_init_resizeable_ram() but @mr is allocated and managed
+ * by QOM.
+ *
+ * Return: Pointer to allocated #MemoryRegion.
+ */
 MemoryRegion *memory_region_new_resizeable_ram(Object *owner,
                                                const char *name,
                                                uint64_t size,
@@ -1493,6 +1525,15 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr,
                                       ram_addr_t offset,
                                       Error **errp);
 
+/**
+ * memory_region_new_ram_from_file:  Allocate and initialize RAM memory region
+ *                                   with a mmap-ed backend.
+ *
+ * Like memory_region_init_ram_from_file() but @mr is allocated and managed
+ * by QOM.
+ *
+ * Return: Pointer to allocated #MemoryRegion.
+ */
 MemoryRegion *memory_region_new_ram_from_file(Object *owner,
                                               const char *name,
                                               uint64_t size,
@@ -1531,6 +1572,15 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr,
                                     ram_addr_t offset,
                                     Error **errp);
 
+/**
+ * memory_region_new_ram_from_fd:  Allocate and initialize RAM memory region
+ *                                 with a mmap-ed backend.
+ *
+ * Like memory_region_init_ram_from_fd() but @mr is allocated and managed
+ * by QOM.
+ *
+ * Return: Pointer to allocated #MemoryRegion.
+ */
 MemoryRegion *memory_region_new_ram_from_fd(Object *owner,
                                             const char *name,
                                             uint64_t size,
@@ -1562,6 +1612,14 @@ void memory_region_init_ram_ptr(MemoryRegion *mr,
                                 uint64_t size,
                                 void *ptr);
 
+/**
+ * memory_region_new_ram_ptr:  Allocate and initialize RAM memory region from a
+ *                             user-provided pointer.
+ *
+ * Like memory_region_init_ram_ptr() but @mr is allocated and managed by QOM.
+ *
+ * Return: Pointer to allocated #MemoryRegion.
+ */
 MemoryRegion *memory_region_new_ram_ptr(Object *owner,
                                         const char *name,
                                         uint64_t size,
@@ -1595,6 +1653,15 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
                                        uint64_t size,
                                        void *ptr);
 
+/**
+ * memory_region_new_ram_device_ptr:  Allocate and initialize RAM device memory
+ *                                    region from a user-provided pointer.
+ *
+ * Like memory_region_init_ram_device_ptr() but @mr is allocated and managed
+ * by QOM.
+ *
+ * Return: Pointer to allocated #MemoryRegion.
+ */
 MemoryRegion *memory_region_new_ram_device_ptr(Object *owner,
                                                const char *name,
                                                uint64_t size,
@@ -1619,6 +1686,14 @@ void memory_region_init_alias(MemoryRegion *mr,
                               hwaddr offset,
                               uint64_t size);
 
+/**
+ * memory_region_new_alias: Allocate and initialize a memory region that
+ *                          aliases all or a part of another memory region.
+ *
+ * Like memory_region_init_alias() but @mr is allocated and managed by QOM.
+ *
+ * Return: Pointer to allocated #MemoryRegion.
+ */
 MemoryRegion *memory_region_new_alias(Object *owner,
                                       const char *name,
                                       MemoryRegion *orig,
@@ -1690,6 +1765,13 @@ bool memory_region_init_ram_guest_memfd(MemoryRegion *mr,
                                         uint64_t size,
                                         Error **errp);
 
+/**
+ * memory_region_new_ram: Allocate and initialize a RAM memory region.
+ *
+ * Like memory_region_init_ram() but @mr is allocated and managed by QOM.
+ *
+ * Return: Pointer to allocated #MemoryRegion.
+ */
 MemoryRegion *memory_region_new_ram(Object *owner,
                                     const char *name,
                                     uint64_t size,
@@ -1729,6 +1811,13 @@ bool memory_region_init_rom(MemoryRegion *mr,
                             uint64_t size,
                             Error **errp);
 
+/**
+ * memory_region_new_rom: Allocate and initialize a ROM memory region.
+ *
+ * Like memory_region_init_rom() but @mr is allocated and managed by QOM.
+ *
+ * Return: Pointer to allocated #MemoryRegion.
+ */
 MemoryRegion *memory_region_new_rom(Object *owner,
                                     const char *name,
                                     uint64_t size,
@@ -1769,6 +1858,15 @@ bool memory_region_init_rom_device(MemoryRegion *mr,
                                    uint64_t size,
                                    Error **errp);
 
+/**
+ * memory_region_new_rom_device:  Allocate and initialize a ROM memory region.
+ *                                Writes are handled via callbacks.
+ *
+ * Like memory_region_init_rom_device() but @mr is allocated and managed
+ * by QOM.
+ *
+ * Return: Pointer to allocated #MemoryRegion.
+ */
 MemoryRegion *memory_region_new_rom_device(Object *owner,
                                            const MemoryRegionOps *ops,
                                            void *opaque,
-- 
2.41.3


