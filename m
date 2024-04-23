Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713D3C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnW-0006Um-0I; Tue, 23 Apr 2024 11:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnE-0004sw-VI
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHnC-0000J0-4p
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zYOQDTdcQau2pKzHm8Oi+B1/Sl4LHvhZlFrexDKMw2g=;
 b=BDc9aLWNSnMRFZFt+2EvGNPwjdNwDuO6CVmb+8JjLvorfJC/zyW1yp67mLYGG8/GtM/jKq
 L6Zc0L3Mbi1FB1T/vZ6SSRyCirEYnC1wF2Oi58bs6QngTWVdSPZdBr/3kmRLRQG0yeNZ7R
 moAYS+D5LNNlK4e9x2xn60V/jwndTGU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-2PpCNyUQNgy5qyhmYOE3eQ-1; Tue,
 23 Apr 2024 11:10:41 -0400
X-MC-Unique: 2PpCNyUQNgy5qyhmYOE3eQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB2471C0C64F;
 Tue, 23 Apr 2024 15:10:41 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB7FC2033979;
 Tue, 23 Apr 2024 15:10:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PULL 49/63] RAMBlock: Add support of KVM private guest memfd
Date: Tue, 23 Apr 2024 17:09:37 +0200
Message-ID: <20240423150951.41600-50-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Add KVM guest_memfd support to RAMBlock so both normal hva based memory
and kvm guest memfd based private memory can be associated in one RAMBlock.

Introduce new flag RAM_GUEST_MEMFD. When it's set, it calls KVM ioctl to
create private guest_memfd during RAMBlock setup.

Allocating a new RAM_GUEST_MEMFD flag to instruct the setup of guest memfd
is more flexible and extensible than simply relying on the VM type because
in the future we may have the case that not all the memory of a VM need
guest memfd. As a benefit, it also avoid getting MachineState in memory
subsystem.

Note, RAM_GUEST_MEMFD is supposed to be set for memory backends of
confidential guests, such as TDX VM. How and when to set it for memory
backends will be implemented in the following patches.

Introduce memory_region_has_guest_memfd() to query if the MemoryRegion has
KVM guest_memfd allocated.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-ID: <20240320083945.991426-7-michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h   | 20 +++++++++++++++++---
 include/exec/ram_addr.h |  2 +-
 include/exec/ramblock.h |  1 +
 include/sysemu/kvm.h    |  2 ++
 accel/kvm/kvm-all.c     | 28 ++++++++++++++++++++++++++++
 accel/stubs/kvm-stub.c  |  5 +++++
 system/memory.c         |  5 +++++
 system/physmem.c        | 34 +++++++++++++++++++++++++++++++---
 8 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 8626a355b31..679a8476852 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -243,6 +243,9 @@ typedef struct IOMMUTLBEvent {
 /* RAM FD is opened read-only */
 #define RAM_READONLY_FD (1 << 11)
 
+/* RAM can be private that has kvm guest memfd backend */
+#define RAM_GUEST_MEMFD   (1 << 12)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
@@ -1307,7 +1310,8 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
  * @name: Region name, becomes part of RAMBlock name used in migration stream
  *        must be unique within any device
  * @size: size of the region.
- * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_NORESERVE.
+ * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_NORESERVE,
+ *             RAM_GUEST_MEMFD.
  * @errp: pointer to Error*, to store an error if it happens.
  *
  * Note that this function does not do anything to cause the data in the
@@ -1369,7 +1373,7 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
  *         (getpagesize()) will be used.
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
- *             RAM_READONLY_FD
+ *             RAM_READONLY_FD, RAM_GUEST_MEMFD
  * @path: the path in which to allocate the RAM.
  * @offset: offset within the file referenced by path
  * @errp: pointer to Error*, to store an error if it happens.
@@ -1399,7 +1403,7 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr,
  * @size: size of the region.
  * @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *             RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
- *             RAM_READONLY_FD
+ *             RAM_READONLY_FD, RAM_GUEST_MEMFD
  * @fd: the fd to mmap.
  * @offset: offset within the file referenced by fd
  * @errp: pointer to Error*, to store an error if it happens.
@@ -1722,6 +1726,16 @@ static inline bool memory_region_is_romd(MemoryRegion *mr)
  */
 bool memory_region_is_protected(MemoryRegion *mr);
 
+/**
+ * memory_region_has_guest_memfd: check whether a memory region has guest_memfd
+ *     associated
+ *
+ * Returns %true if a memory region's ram_block has valid guest_memfd assigned.
+ *
+ * @mr: the memory region being queried
+ */
+bool memory_region_has_guest_memfd(MemoryRegion *mr);
+
 /**
  * memory_region_get_iommu: check whether a memory region is an iommu
  *
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index de45ba7bc96..07c8f863750 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -110,7 +110,7 @@ long qemu_maxrampagesize(void);
  *  @mr: the memory region where the ram block is
  *  @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
  *              RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
- *              RAM_READONLY_FD
+ *              RAM_READONLY_FD, RAM_GUEST_MEMFD
  *  @mem_path or @fd: specify the backing file or device
  *  @offset: Offset into target file
  *  @errp: pointer to Error*, to store an error if it happens
diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 848915ea5bf..459c8917de2 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -41,6 +41,7 @@ struct RAMBlock {
     QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
     int fd;
     uint64_t fd_offset;
+    int guest_memfd;
     size_t page_size;
     /* dirty bitmap used during migration */
     unsigned long *bmap;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 594ae9b4605..217f3fe17ba 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -537,6 +537,8 @@ void kvm_mark_guest_state_protected(void);
  */
 bool kvm_hwpoisoned_mem(void);
 
+int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
+
 int kvm_set_memory_attributes_private(hwaddr start, uint64_t size);
 int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
 
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index db0b1a16edd..1b7bbd838c4 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -92,6 +92,7 @@ static bool kvm_has_guest_debug;
 static int kvm_sstep_flags;
 static bool kvm_immediate_exit;
 static uint64_t kvm_supported_memory_attributes;
+static bool kvm_guest_memfd_supported;
 static hwaddr kvm_max_slot_size = ~0;
 
 static const KVMCapabilityInfo kvm_required_capabilites[] = {
@@ -2419,6 +2420,11 @@ static int kvm_init(MachineState *ms)
     }
 
     kvm_supported_memory_attributes = kvm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
+    kvm_guest_memfd_supported =
+        kvm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
+        kvm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
+        (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
+
     kvm_immediate_exit = kvm_check_extension(s, KVM_CAP_IMMEDIATE_EXIT);
     s->nr_slots = kvm_check_extension(s, KVM_CAP_NR_MEMSLOTS);
 
@@ -4138,3 +4144,25 @@ void kvm_mark_guest_state_protected(void)
 {
     kvm_state->guest_state_protected = true;
 }
+
+int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
+{
+    int fd;
+    struct kvm_create_guest_memfd guest_memfd = {
+        .size = size,
+        .flags = flags,
+    };
+
+    if (!kvm_guest_memfd_supported) {
+        error_setg(errp, "KVM does not support guest_memfd");
+        return -1;
+    }
+
+    fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_GUEST_MEMFD, &guest_memfd);
+    if (fd < 0) {
+        error_setg_errno(errp, errno, "Error creating KVM guest_memfd");
+        return -1;
+    }
+
+    return fd;
+}
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index ca381728840..8e0eb22e61c 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -129,3 +129,8 @@ bool kvm_hwpoisoned_mem(void)
 {
     return false;
 }
+
+int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
+{
+    return -ENOSYS;
+}
diff --git a/system/memory.c b/system/memory.c
index a229a79988f..c756950c0c0 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1850,6 +1850,11 @@ bool memory_region_is_protected(MemoryRegion *mr)
     return mr->ram && (mr->ram_block->flags & RAM_PROTECTED);
 }
 
+bool memory_region_has_guest_memfd(MemoryRegion *mr)
+{
+    return mr->ram_block && mr->ram_block->guest_memfd >= 0;
+}
+
 uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
 {
     uint8_t mask = mr->dirty_log_mask;
diff --git a/system/physmem.c b/system/physmem.c
index a4fe3d2bf89..f5dfa20e57e 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1808,6 +1808,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     const bool shared = qemu_ram_is_shared(new_block);
     RAMBlock *block;
     RAMBlock *last_block = NULL;
+    bool free_on_error = false;
     ram_addr_t old_ram_size, new_ram_size;
     Error *err = NULL;
 
@@ -1837,6 +1838,19 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                 return;
             }
             memory_try_enable_merging(new_block->host, new_block->max_length);
+            free_on_error = true;
+        }
+    }
+
+    if (new_block->flags & RAM_GUEST_MEMFD) {
+        assert(kvm_enabled());
+        assert(new_block->guest_memfd < 0);
+
+        new_block->guest_memfd = kvm_create_guest_memfd(new_block->max_length,
+                                                        0, errp);
+        if (new_block->guest_memfd < 0) {
+            qemu_mutex_unlock_ramlist();
+            goto out_free;
         }
     }
 
@@ -1888,6 +1902,13 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         ram_block_notify_add(new_block->host, new_block->used_length,
                              new_block->max_length);
     }
+    return;
+
+out_free:
+    if (free_on_error) {
+        qemu_anon_ram_free(new_block->host, new_block->max_length);
+        new_block->host = NULL;
+    }
 }
 
 #ifdef CONFIG_POSIX
@@ -1902,7 +1923,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     /* Just support these ram flags by now. */
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
                           RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
-                          RAM_READONLY_FD)) == 0);
+                          RAM_READONLY_FD | RAM_GUEST_MEMFD)) == 0);
 
     if (xen_enabled()) {
         error_setg(errp, "-mem-path not supported with Xen");
@@ -1939,6 +1960,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     new_block->used_length = size;
     new_block->max_length = size;
     new_block->flags = ram_flags;
+    new_block->guest_memfd = -1;
     new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
                                      errp);
     if (!new_block->host) {
@@ -2018,7 +2040,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     int align;
 
     assert((ram_flags & ~(RAM_SHARED | RAM_RESIZEABLE | RAM_PREALLOC |
-                          RAM_NORESERVE)) == 0);
+                          RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
     assert(!host ^ (ram_flags & RAM_PREALLOC));
 
     align = qemu_real_host_page_size();
@@ -2033,6 +2055,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     new_block->max_length = max_size;
     assert(max_size >= size);
     new_block->fd = -1;
+    new_block->guest_memfd = -1;
     new_block->page_size = qemu_real_host_page_size();
     new_block->host = host;
     new_block->flags = ram_flags;
@@ -2055,7 +2078,7 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
 RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags,
                          MemoryRegion *mr, Error **errp)
 {
-    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE)) == 0);
+    assert((ram_flags & ~(RAM_SHARED | RAM_NORESERVE | RAM_GUEST_MEMFD)) == 0);
     return qemu_ram_alloc_internal(size, size, NULL, NULL, ram_flags, mr, errp);
 }
 
@@ -2083,6 +2106,11 @@ static void reclaim_ramblock(RAMBlock *block)
     } else {
         qemu_anon_ram_free(block->host, block->max_length);
     }
+
+    if (block->guest_memfd >= 0) {
+        close(block->guest_memfd);
+    }
+
     g_free(block);
 }
 
-- 
2.44.0



