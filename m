Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D92D3B7E2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 12:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSa4r-00072c-5O; Mon, 08 Dec 2025 07:10:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1vSa4h-00071g-Pk
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 07:10:45 -0500
Received: from sg-1-104.ptr.blmpb.com ([118.26.132.104])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1vSa4d-0003RD-Vo
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 07:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1765195832; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=rHg3xnaKRqLE1X+9qqpvj71mFOVEcBAGM3Q//3nmbWY=;
 b=QT/Xgpx6gj4AqGCxhEI1GAfJu7tgMiLSO68JXnD+7yiEsghRW59rrXzgv2fnnHKWX520nJ
 qhf21l885Lu81JCe2s0VZLQNBTOg9aQMH2zJq9WvSBIwPuuBZjfwMdkStTHQYxm8Ve0qNC
 9cOQIagj6TcLK83uRz+elsPtryTheznhNPx3Yy/IkuFmDJ1JELwQZVNkuKeD5UXVFQYlzL
 iRrVnohISc3UgoEI+q2awNISs+ceXNCQ2I3/KNWTI8jOTk8IUtdyRa0yt4I5iIN0Z5hap8
 5XlWWUHZZd0/Dj12ay/Kx6HyBM2Qp9rLlcBh53iwytbrcXavw9EjW+uIamipXg==
To: <qemu-devel@nongnu.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
X-Original-From: Chuang Xu <xuchuangxclwt@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
From: "Chuang Xu" <xuchuangxclwt@bytedance.com>
Message-Id: <20251208120952.37563-3-xuchuangxclwt@bytedance.com>
Mime-Version: 1.0
Cc: <mst@redhat.com>, <sgarzare@redhat.com>, <richard.henderson@linaro.org>, 
 <pbonzini@redhat.com>, <peterx@redhat.com>, <david@kernel.org>, 
 <philmd@linaro.org>, <farosas@suse.de>, 
 "xuchuangxclwt" <xuchuangxclwt@bytedance.com>
Subject: [RFC v1 2/2] migration: merge fragmented clear_dirty ioctls
In-Reply-To: <20251208120952.37563-1-xuchuangxclwt@bytedance.com>
Date: Mon,  8 Dec 2025 20:09:52 +0800
X-Lms-Return-Path: <lba+26936c036+7c5de6+nongnu.org+xuchuangxclwt@bytedance.com>
References: <20251208120952.37563-1-xuchuangxclwt@bytedance.com>
Received-SPF: pass client-ip=118.26.132.104;
 envelope-from=xuchuangxclwt@bytedance.com; helo=sg-1-104.ptr.blmpb.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: xuchuangxclwt <xuchuangxclwt@bytedance.com>

When the addresses processed are not aligned, a large number of
clear_dirty ioctl occur (e.g. a 16MB misaligned memory can generate
4096 clear_dirty ioctls), which increases the time required for
bitmap_sync and makes it more difficult for dirty pages to converge.

Attempt to merge those fragmented clear_dirty ioctls.

Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
---
 accel/tcg/cputlb.c       |  5 +++--
 include/system/physmem.h |  3 ++-
 migration/ram.c          | 17 ++++++++++++++++-
 system/memory.c          |  2 +-
 system/physmem.c         | 19 +++++++++++--------
 5 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index fd1606c856..8a054cb545 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -857,8 +857,9 @@ void tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
 void tlb_protect_code(ram_addr_t ram_addr)
 {
     physical_memory_test_and_clear_dirty(ram_addr & TARGET_PAGE_MASK,
-                                             TARGET_PAGE_SIZE,
-                                             DIRTY_MEMORY_CODE);
+                                         TARGET_PAGE_SIZE,
+                                         DIRTY_MEMORY_CODE,
+                                         true);
 }
 
 /* update the TLB so that writes in physical page 'phys_addr' are no longer
diff --git a/include/system/physmem.h b/include/system/physmem.h
index 879f6eae38..8529f0510a 100644
--- a/include/system/physmem.h
+++ b/include/system/physmem.h
@@ -41,7 +41,8 @@ void physical_memory_dirty_bits_cleared(ram_addr_t start, ram_addr_t length);
 
 bool physical_memory_test_and_clear_dirty(ram_addr_t start,
                                           ram_addr_t length,
-                                          unsigned client);
+                                          unsigned client,
+                                          bool clear_dirty);
 
 DirtyBitmapSnapshot *
 physical_memory_snapshot_and_clear_dirty(MemoryRegion *mr, hwaddr offset,
diff --git a/migration/ram.c b/migration/ram.c
index 29f016cb25..329168d081 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -995,18 +995,33 @@ static uint64_t physical_memory_sync_dirty_bitmap(RAMBlock *rb,
         }
     } else {
         ram_addr_t offset = rb->offset;
+        unsigned long end, start_page;
+        uint64_t mr_offset, mr_size;
 
         for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
+            /*
+             * Here we don't expect so many clear_dirty, so we call
+             * physical_memory_test_and_clear_dirty with clear_dirty
+             * set to false. Later we'll do make an overall clear_dirty
+             * outside the loop.
+             */
             if (physical_memory_test_and_clear_dirty(
                         start + addr + offset,
                         TARGET_PAGE_SIZE,
-                        DIRTY_MEMORY_MIGRATION)) {
+                        DIRTY_MEMORY_MIGRATION,
+                        false)) {
                 long k = (start + addr) >> TARGET_PAGE_BITS;
                 if (!test_and_set_bit(k, dest)) {
                     num_dirty++;
                 }
             }
         }
+        end = TARGET_PAGE_ALIGN(start + addr + offset + TARGET_PAGE_SIZE)
+              >> TARGET_PAGE_BITS;
+        start_page = (start + offset) >> TARGET_PAGE_BITS;
+        mr_offset = (ram_addr_t)(start_page << TARGET_PAGE_BITS) - offset;
+        mr_size = (end - start_page) << TARGET_PAGE_BITS;
+        memory_region_clear_dirty_bitmap(rb->mr, mr_offset, mr_size);
     }
 
     return num_dirty;
diff --git a/system/memory.c b/system/memory.c
index 8b84661ae3..7b81b84f30 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2424,7 +2424,7 @@ void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,
 {
     assert(mr->ram_block);
     physical_memory_test_and_clear_dirty(
-        memory_region_get_ram_addr(mr) + addr, size, client);
+        memory_region_get_ram_addr(mr) + addr, size, client, true);
 }
 
 int memory_region_get_fd(MemoryRegion *mr)
diff --git a/system/physmem.c b/system/physmem.c
index c9869e4049..21b2db3884 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1091,8 +1091,9 @@ void physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
 
 /* Note: start and end must be within the same ram block.  */
 bool physical_memory_test_and_clear_dirty(ram_addr_t start,
-                                              ram_addr_t length,
-                                              unsigned client)
+                                          ram_addr_t length,
+                                          unsigned client,
+                                          bool clear_dirty)
 {
     DirtyMemoryBlocks *blocks;
     unsigned long end, page, start_page;
@@ -1126,9 +1127,11 @@ bool physical_memory_test_and_clear_dirty(ram_addr_t start,
             page += num;
         }
 
-        mr_offset = (ram_addr_t)(start_page << TARGET_PAGE_BITS) - ramblock->offset;
-        mr_size = (end - start_page) << TARGET_PAGE_BITS;
-        memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_size);
+        if (clear_dirty) {
+            mr_offset = (ram_addr_t)(start_page << TARGET_PAGE_BITS) - ramblock->offset;
+            mr_size = (end - start_page) << TARGET_PAGE_BITS;
+            memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_size);
+        }
     }
 
     if (dirty) {
@@ -1140,9 +1143,9 @@ bool physical_memory_test_and_clear_dirty(ram_addr_t start,
 
 static void physical_memory_clear_dirty_range(ram_addr_t addr, ram_addr_t length)
 {
-    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_MIGRATION);
-    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_VGA);
-    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_CODE);
+    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_MIGRATION, true);
+    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_VGA, true);
+    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_CODE, true);
 }
 
 DirtyBitmapSnapshot *physical_memory_snapshot_and_clear_dirty
-- 
2.20.1

