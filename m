Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FE4CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBw0U-0002Uw-Bf; Wed, 30 Sep 2026 11:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0J-0002TH-C4
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:13:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0G-0000gd-6E
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790781231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzXXBfHGQcvgtdh3Dg0ExgY6+4z4PmR3YA+bAO8qOHc=;
 b=IbcouEExI15T+1Ek1fvpUg0q6X9f9mX5/RMW9oFZxCluaIWLL0jYfJfMU8bvspuLxPAvLE
 zqlxQwmOoshQlFU1gPCsklDVZWYdSKKsA58Gw9ih3bcqEVrPp9ALEv7C+fO/f+KlSqdV+Z
 uCpXBKgeWP6Hdk9lmluEi/+EP0iZx68=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-QDBbzL4PN_OokzFRXFM9hg-1; Wed, 30 Sep 2026 11:13:50 -0400
X-MC-Unique: QDBbzL4PN_OokzFRXFM9hg-1
X-Mimecast-MFC-AGG-ID: QDBbzL4PN_OokzFRXFM9hg_1790781229
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-917a438816dso7963196d6.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 08:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790781229; x=1791386029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vzXXBfHGQcvgtdh3Dg0ExgY6+4z4PmR3YA+bAO8qOHc=;
 b=aeUiVTZXos1uAHcpicaiJw8lqB3kKtnViS2jbDOw/63nHDZOs1iLQMvapmh7ulTjro
 79DboZ3Gbn7RdaTeQbC7kJBT4aMmIu3t2v5vWbLjAf+9so1840qkZWi7FP8fK7iLVVs4
 P2KmvSxMVpkMVt+HfRqkyuEbQoO+QppjE3dHkpgfmyQIakI+qI/m1igt4AaZne6L/zpr
 UfqZ/CFX0nG44piVlR3RSb0gBuFMV5JMj18Ei2jk10rdxNK54HEr10ku4z4pfQhCKRgB
 wx+Fy+/ku5QufJogw1KRzFIwHNWVLdFqMmHpgiwRpU9lz/HrkjdLjz3jmjIZkRgWnB8X
 jXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790781229; x=1791386029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vzXXBfHGQcvgtdh3Dg0ExgY6+4z4PmR3YA+bAO8qOHc=;
 b=SA6uyNAFH2Awve5wkXkHVh3RgAowCAjd4C5vAXqwH/pY6RMBnRbbGBX/mPCPoN9jHj
 I7AwcUXdCa0AkpVPZe0mQKMZ/rwLbUuqG3b+OFavOZho8JecN+zUrOLe/ACX+81b1glv
 TponotqhpeWo1hftIEjqA7FIzaUp5tZBuhOOp66g7JiTh4B1xI3ZNP7p6Yh9B7Hw0M2I
 XkKHatCabkh+/ctQOFk0S0m+42BRn8GlUSE5PJGuYa4aiE8SnuntEU/WkGBYxXJAq2DB
 6vIWQp8U7yBJZYWFyl+5M8Psx1YXkezAlsyRlSFgLDa0GbB3gLGpuN3A97ZARK/Ze2zs
 UVkA==
X-Gm-Message-State: AFq9FYKVciVdGmSyV1EPnSf3qaVlm3KHOSuCoYUBL9ijvLx3OduTcEQ8
 u/rWkMuCtpCCUjOSeEVxqSUY62r8O5ulmCfzq8biaONpAw91PepZ5KvPtnEjCm8WaKjj7rEWxS5
 2hN3DdsSrlbqV+lzOxTVzm2/pdqTk5W1kYgbIxbXBAS7/duu/deb+eehOvEw+7I0gZKh/XtDKFR
 j2lCBz8TTnZlsB28UWOe0j7ZoSejaK6/ZNI2OZsrnS
X-Gm-Gg: AYBFou0QPBmskzmHc7pf3V6hDd0IeB0kem0aVR93WLCYB/lkIy0Ezy1hkccjrQp7cRe
 qrOq9WjULkEIl3vaO9m9nQXXudVmtjwrlGdVno1riffcV6bPiNkTgF4F5wEIKR3lqfuUPGuhG8h
 bBtaOrb7a8lnE1gLePG5Js85ZYM23BZWpiiy4xWMiE7gh3AAvUGhaW6736pXbTW34yKcOULo7ig
 3gZqMIUkAcOTC3ZIW+VwZDZ5SXvqF2JdJ+/dQrIgFGhIdo1TOL2y+ikK8rC/JKX9QM65JAHbN0r
 2cxsJX1VDfmDok6N9XMuafws3aghFYJ8yv393YBBunvCNmprPcwoTxR6ZHd9+9RGMnWJA6M=
X-Received: by 2002:a05:6214:21c1:b0:915:e8dd:4c02 with SMTP id
 6a1803df08f44-917a0b8bcf6mr30587176d6.23.1790781229162; 
 Wed, 30 Sep 2026 08:13:49 -0700 (PDT)
X-Received: by 2002:a05:6214:21c1:b0:915:e8dd:4c02 with SMTP id
 6a1803df08f44-917a0b8bcf6mr30586366d6.23.1790781228487; 
 Wed, 30 Sep 2026 08:13:48 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917a8a642ebsm1547976d6.41.2026.09.30.08.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:13:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Michael Roth <michael.roth@amd.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PULL 04/12] ramblock: Rename guest_memfd to guest_memfd_private
Date: Wed, 30 Sep 2026 11:13:32 -0400
Message-ID: <20260930151340.2817042-5-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930151340.2817042-1-peterx@redhat.com>
References: <20260930151340.2817042-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Rename the field to reflect the fact that the guest_memfd in this case only
backs private portion of the ramblock rather than all of it.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Link: https://lore.kernel.org/r/20260929235109.1398509-5-michael.roth@amd.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h   |  7 ++++---
 include/system/ramblock.h |  7 ++++++-
 accel/kvm/kvm-all.c       |  2 +-
 system/memory.c           |  2 +-
 system/physmem.c          | 33 +++++++++++++++++----------------
 5 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index a7e03fc3e7..aef555af80 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1507,10 +1507,11 @@ bool memory_region_skip_iommu_map(const MemoryRegion *mr);
 void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip);
 
 /**
- * memory_region_has_guest_memfd: check whether a memory region has guest_memfd
- *     associated
+ * memory_region_has_guest_memfd: check whether a memory region has
+ *     guest_memfd_private associated
  *
- * Returns %true if a memory region's ram_block has valid guest_memfd assigned.
+ * Returns %true if a memory region's ram_block has valid guest_memfd_private
+ * assigned.
  *
  * @mr: the memory region being queried
  */
diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 84624aca2c..0388d6cc6b 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -40,7 +40,12 @@ struct RAMBlock {
     Error *cpr_blocker;
     int fd;
     uint64_t fd_offset;
-    int guest_memfd;
+    /*
+     * When RAM_GUEST_MEMFD_PRIVATE flag is set, this ramblock can have
+     * private pages backed by guest_memfd_private specified, while shared
+     * pages are backed by the ramblock on its own.
+     */
+    int guest_memfd_private;
     RamBlockAttributes *attributes;
     size_t page_size;
     /* dirty bitmap used during migration */
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 0b1407e4ea..a29b1d7a3c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1729,7 +1729,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         mem->ram_start_offset = ram_start_offset;
         mem->ram = ram;
         mem->flags = kvm_mem_flags(mr);
-        mem->guest_memfd = mr->ram_block->guest_memfd;
+        mem->guest_memfd = mr->ram_block->guest_memfd_private;
         mem->guest_memfd_offset = mem->guest_memfd >= 0 ?
                                   (uint8_t*)ram - mr->ram_block->host : 0;
 
diff --git a/system/memory.c b/system/memory.c
index 264dc90c0a..b07d5dc542 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1780,7 +1780,7 @@ void memory_region_set_skip_iommu_map(MemoryRegion *mr, bool skip)
 
 bool memory_region_has_guest_memfd(const MemoryRegion *mr)
 {
-    return mr->ram_block && mr->ram_block->guest_memfd >= 0;
+    return mr->ram_block && mr->ram_block->guest_memfd_private >= 0;
 }
 
 uint8_t memory_region_get_dirty_log_mask(const MemoryRegion *mr)
diff --git a/system/physmem.c b/system/physmem.c
index 1b3f327ed5..156853c8db 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2201,7 +2201,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             goto out_free;
         }
 
-        assert(new_block->guest_memfd < 0);
+        assert(new_block->guest_memfd_private < 0);
 
         ret = ram_block_coordinated_discard_require(true);
         if (ret < 0) {
@@ -2211,9 +2211,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
             goto out_free;
         }
 
-        new_block->guest_memfd = kvm_create_guest_memfd(new_block->max_length,
-                                                        0, errp);
-        if (new_block->guest_memfd < 0) {
+        new_block->guest_memfd_private =
+            kvm_create_guest_memfd(new_block->max_length, 0, errp);
+        if (new_block->guest_memfd_private < 0) {
             qemu_mutex_unlock_ramlist();
             goto out_free;
         }
@@ -2230,7 +2230,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         new_block->attributes = ram_block_attributes_create(new_block);
         if (!new_block->attributes) {
             error_setg(errp, "Failed to create ram block attribute");
-            close(new_block->guest_memfd);
+            close(new_block->guest_memfd_private);
             ram_block_coordinated_discard_require(false);
             qemu_mutex_unlock_ramlist();
             goto out_free;
@@ -2366,7 +2366,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
     new_block->max_length = max_size;
     new_block->resized = resized;
     new_block->flags = ram_flags;
-    new_block->guest_memfd = -1;
+    new_block->guest_memfd_private = -1;
     new_block->host = file_ram_alloc(new_block, max_size, fd,
                                      file_size < offset + max_size,
                                      offset, errp);
@@ -2539,7 +2539,7 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     new_block->used_length = size;
     new_block->max_length = max_size;
     new_block->fd = -1;
-    new_block->guest_memfd = -1;
+    new_block->guest_memfd_private = -1;
     new_block->page_size = qemu_real_host_page_size();
     new_block->host = host;
     new_block->flags = ram_flags;
@@ -2590,8 +2590,8 @@ static void reclaim_ramblock(RAMBlock *block)
         qemu_anon_ram_free(block->host, block->max_length);
     }
 
-    if (block->guest_memfd >= 0) {
-        close(block->guest_memfd);
+    if (block->guest_memfd_private >= 0) {
+        close(block->guest_memfd_private);
         ram_block_coordinated_discard_require(false);
     }
 
@@ -2839,12 +2839,12 @@ int ram_block_rebind(Error **errp)
 
     RAMBLOCK_FOREACH(block) {
         if (block->flags & RAM_GUEST_MEMFD) {
-            if (block->guest_memfd >= 0) {
-                close(block->guest_memfd);
+            if (block->guest_memfd_private >= 0) {
+                close(block->guest_memfd_private);
             }
-            block->guest_memfd = kvm_create_guest_memfd(block->max_length,
-                                                        0, errp);
-            if (block->guest_memfd < 0) {
+            block->guest_memfd_private = kvm_create_guest_memfd(
+                block->max_length, 0, errp);
+            if (block->guest_memfd_private < 0) {
                 qemu_mutex_unlock_ramlist();
                 return -1;
             }
@@ -4272,7 +4272,7 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t offset, size_t length)
         return ret;
     }
 
-    if (rb->guest_memfd >= 0) {
+    if (rb->guest_memfd_private >= 0) {
         ret = ram_block_discard_guest_memfd_range(rb, offset, length);
     }
 
@@ -4286,7 +4286,8 @@ int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t offset,
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
     /* ignore fd_offset with guest_memfd */
-    ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+    ret = fallocate(rb->guest_memfd_private,
+                    FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                     offset, length);
 
     if (ret) {
-- 
2.55.0


