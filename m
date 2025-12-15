Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6565FD5B16E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 14:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV9Ea-0001KN-MQ; Mon, 15 Dec 2025 09:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1vV9E3-00016k-1e
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 09:06:59 -0500
Received: from sg-1-100.ptr.blmpb.com ([118.26.132.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1vV9Dt-0000aq-MO
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 09:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1765807594; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=s0OFiVIW/yPXbHVyol+Lp25JjClNpszFFXFvE6ZWPt8=;
 b=kp41W3aH0+pYg8t5vF+jO3lQ23b6vK/NCd+unJsgDT+XhDqIo1LBWpa2gE1OvoiMT/3jE3
 SvrptCaDdcSqmchQojyXTAFCvyBMu6iqmUccQnlsaxK+OhgXqGtzWCKEnsua1GbUn3mbfr
 e5TX9Okqo5vqsQ/1kvQ8tjlVZ4YaHKu56HqKEehJyzOwZUx72RcI5YUmBlJ+IbRa7rZoAR
 2eR1MrR+99/C1v8kTxSYxD3R+E81NBMk0VJpG3G0HmAZfomRRl8x3vaaC/hjQMCBng1UO3
 r5fNe8C8n1Rk4MomogaMBUwja4RBd4LV1ZvhDojm02VLpaIsvBy2IR5qyggteg==
Subject: [PATCH v2 1/1] migration: merge fragmented clear_dirty ioctls
References: <20251215140611.16180-1-xuchuangxclwt@bytedance.com>
Cc: <mst@redhat.com>, <sgarzare@redhat.com>, <richard.henderson@linaro.org>, 
 <pbonzini@redhat.com>, <peterx@redhat.com>, <david@kernel.org>, 
 <philmd@linaro.org>, <farosas@suse.de>, 
 "xuchuangxclwt" <xuchuangxclwt@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
X-Original-From: Chuang Xu <xuchuangxclwt@bytedance.com>
From: "Chuang Xu" <xuchuangxclwt@bytedance.com>
Message-Id: <20251215140611.16180-2-xuchuangxclwt@bytedance.com>
X-Lms-Return-Path: <lba+2694015e9+d5bd72+nongnu.org+xuchuangxclwt@bytedance.com>
In-Reply-To: <20251215140611.16180-1-xuchuangxclwt@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
To: <qemu-devel@nongnu.org>
Mime-Version: 1.0
Date: Mon, 15 Dec 2025 22:06:11 +0800
Received-SPF: pass client-ip=118.26.132.100;
 envelope-from=xuchuangxclwt@bytedance.com; helo=sg-1-100.ptr.blmpb.com
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
clear_dirty ioctl occur (e.g. a 4MB misaligned memory can generate
2048 clear_dirty ioctls from two different memory_listener),
which increases the time required for bitmap_sync and makes it
more difficult for dirty pages to converge.

Attempt to merge those fragmented clear_dirty ioctls.

Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
---
 accel/tcg/cputlb.c       |  5 +++--
 include/system/physmem.h |  7 ++++---
 migration/ram.c          | 26 ++++++++++++------------
 system/memory.c          |  2 +-
 system/physmem.c         | 44 ++++++++++++++++++++++++----------------
 5 files changed, 48 insertions(+), 36 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index fd1606c856..c8827c8b0d 100644
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
+                                         NULL);
 }
 
 /* update the TLB so that writes in physical page 'phys_addr' are no longer
diff --git a/include/system/physmem.h b/include/system/physmem.h
index 879f6eae38..8eeace9d1f 100644
--- a/include/system/physmem.h
+++ b/include/system/physmem.h
@@ -39,9 +39,10 @@ uint64_t physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
 
 void physical_memory_dirty_bits_cleared(ram_addr_t start, ram_addr_t length);
 
-bool physical_memory_test_and_clear_dirty(ram_addr_t start,
-                                          ram_addr_t length,
-                                          unsigned client);
+uint64_t physical_memory_test_and_clear_dirty(ram_addr_t start,
+                                              ram_addr_t length,
+                                              unsigned client,
+                                              unsigned long *dest);
 
 DirtyBitmapSnapshot *
 physical_memory_snapshot_and_clear_dirty(MemoryRegion *mr, hwaddr offset,
diff --git a/migration/ram.c b/migration/ram.c
index 29f016cb25..2d5e979211 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -942,7 +942,6 @@ static uint64_t physical_memory_sync_dirty_bitmap(RAMBlock *rb,
                                                   ram_addr_t start,
                                                   ram_addr_t length)
 {
-    ram_addr_t addr;
     unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
     uint64_t num_dirty = 0;
     unsigned long *dest = rb->bmap;
@@ -995,18 +994,19 @@ static uint64_t physical_memory_sync_dirty_bitmap(RAMBlock *rb,
         }
     } else {
         ram_addr_t offset = rb->offset;
-
-        for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
-            if (physical_memory_test_and_clear_dirty(
-                        start + addr + offset,
-                        TARGET_PAGE_SIZE,
-                        DIRTY_MEMORY_MIGRATION)) {
-                long k = (start + addr) >> TARGET_PAGE_BITS;
-                if (!test_and_set_bit(k, dest)) {
-                    num_dirty++;
-                }
-            }
-        }
+        unsigned long end, start_page;
+        uint64_t mr_offset, mr_size;
+
+        num_dirty = physical_memory_test_and_clear_dirty(
+                        start + offset,
+                        length,
+                        DIRTY_MEMORY_MIGRATION,
+                        dest);
+        end = TARGET_PAGE_ALIGN(start + offset + length) >> TARGET_PAGE_BITS;
+        start_page = (start + offset) >> TARGET_PAGE_BITS;
+        mr_offset = (ram_addr_t)(start_page << TARGET_PAGE_BITS) - offset;
+        mr_size = (end - start_page) << TARGET_PAGE_BITS;
+        memory_region_clear_dirty_bitmap(rb->mr, mr_offset, mr_size);
     }
 
     return num_dirty;
diff --git a/system/memory.c b/system/memory.c
index 8b84661ae3..666364392d 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2424,7 +2424,7 @@ void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,
 {
     assert(mr->ram_block);
     physical_memory_test_and_clear_dirty(
-        memory_region_get_ram_addr(mr) + addr, size, client);
+        memory_region_get_ram_addr(mr) + addr, size, client, NULL);
 }
 
 int memory_region_get_fd(MemoryRegion *mr)
diff --git a/system/physmem.c b/system/physmem.c
index c9869e4049..d015eb2133 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1090,18 +1090,19 @@ void physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
 }
 
 /* Note: start and end must be within the same ram block.  */
-bool physical_memory_test_and_clear_dirty(ram_addr_t start,
+uint64_t physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
-                                              unsigned client)
+                                              unsigned client,
+                                              unsigned long *dest)
 {
     DirtyMemoryBlocks *blocks;
     unsigned long end, page, start_page;
-    bool dirty = false;
+    uint64_t num_dirty = 0;
     RAMBlock *ramblock;
     uint64_t mr_offset, mr_size;
 
     if (length == 0) {
-        return false;
+        return 0;
     }
 
     end = TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
@@ -1118,31 +1119,40 @@ bool physical_memory_test_and_clear_dirty(ram_addr_t start,
         while (page < end) {
             unsigned long idx = page / DIRTY_MEMORY_BLOCK_SIZE;
             unsigned long offset = page % DIRTY_MEMORY_BLOCK_SIZE;
-            unsigned long num = MIN(end - page,
-                                    DIRTY_MEMORY_BLOCK_SIZE - offset);
 
-            dirty |= bitmap_test_and_clear_atomic(blocks->blocks[idx],
-                                                  offset, num);
-            page += num;
+            if (bitmap_test_and_clear_atomic(blocks->blocks[idx], offset, 1)) {
+                if (dest) {
+                    unsigned long k = page - (ramblock->offset >> TARGET_PAGE_BITS);
+                    if (!test_and_set_bit(k, dest)) {
+                        num_dirty++;
+                    }
+                } else {
+                    num_dirty++;
+                }
+            }
+
+            page++;
         }
 
-        mr_offset = (ram_addr_t)(start_page << TARGET_PAGE_BITS) - ramblock->offset;
-        mr_size = (end - start_page) << TARGET_PAGE_BITS;
-        memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_size);
+        if (!dest && num_dirty) {
+            mr_offset = (ram_addr_t)(start_page << TARGET_PAGE_BITS) - ramblock->offset;
+            mr_size = (end - start_page) << TARGET_PAGE_BITS;
+            memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_size);
+        }
     }
 
-    if (dirty) {
+    if (num_dirty) {
         physical_memory_dirty_bits_cleared(start, length);
     }
 
-    return dirty;
+    return num_dirty;
 }
 
 static void physical_memory_clear_dirty_range(ram_addr_t addr, ram_addr_t length)
 {
-    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_MIGRATION);
-    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_VGA);
-    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_CODE);
+    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_MIGRATION, NULL);
+    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_VGA, NULL);
+    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_CODE, NULL);
 }
 
 DirtyBitmapSnapshot *physical_memory_snapshot_and_clear_dirty
-- 
2.39.3 (Apple Git-146)

