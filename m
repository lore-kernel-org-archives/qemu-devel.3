Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDA9E6F095
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Ps-0001rz-OY; Tue, 23 Dec 2025 09:31:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3Pb-0001P2-57
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:31:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PT-0003qx-Je
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DCIAkPoZCfy6QtVMzxUWVZjrB/qkNczGej6JkiZHhTQ=;
 b=aB+iAyJTPUrEZUUqGQWcCoNqpWtPoqhUdurIWBK2G8pEtBnEbNT+ML+tVtJkjJiu7TkLfK
 ML+XTSSPlIxSqxXtMLxFPWNoeclAtQrOBT6npBD4qfT3jpWPW7l/rYT97biax4M6n1JNYc
 Cakqhz9mIs1mfwl+lwzxB1Cf3j+Jzmc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-zAn1yh5yO9aNavYE_942-w-1; Tue, 23 Dec 2025 09:30:42 -0500
X-MC-Unique: zAn1yh5yO9aNavYE_942-w-1
X-Mimecast-MFC-AGG-ID: zAn1yh5yO9aNavYE_942-w_1766500241
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b245c49d0cso1158076185a.3
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500241; x=1767105041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DCIAkPoZCfy6QtVMzxUWVZjrB/qkNczGej6JkiZHhTQ=;
 b=VM+GNHiRnwqqdfaGwACeXT6oQBl5tpOzpwHeewMof0WgAkQA31ltVyLW0/uyeIP7EN
 mCVnYmjeM8nHJuy/qXXtOMYHzIXjgE0x04XfhTGpavZyCQOgCiiQioOWpHdsucFbXhuM
 sTH7oqkeK2vNH7ybl+jb9M+bXrE7yRQa9ZUWJCa8YYFuj4ZCcydVbu4Y1Ea08jEKp2FY
 0cfrIuVO2Oz9b8yFtWYBWSt61NnQSPH4Zbv/sUps+XnjWMoYHX1Z6GEKjun06z258G4P
 NxRztKP6WeqpIzseS12rQfYMGvUIY4cj0KGO/AuKASqlJRFxteN/ducF3CoEkfRFaA0o
 t2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500241; x=1767105041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DCIAkPoZCfy6QtVMzxUWVZjrB/qkNczGej6JkiZHhTQ=;
 b=uW09jeJ6p3AU/pg2+7NHpL5RyhDmZ57yMjs1qLELp9mOlgWTBltL/SAQJPyWOlocXd
 N1DJh4H+WKsxoIys0BSwfj6HxRqLTM7kdu7zcn2aYeI1O0hPwqj7OjgD2xaQokKtCL7G
 MVhjyHnOlKCVe/Twe2Qg/+/fjJ5Tl2ghPanj8d6Aycbq0Ri+bh1HyyzKmxCiJS/KQ8If
 au1yyCdZdSatJAasthE0Ng1jYHzefa5WclBgIikiXSNHMv2EpJbkLq9nm0CfeP5Hr8uO
 l3X6zTu+kx5kJyA/XgXmWLKxRTzBRhVknOej3gKjuUlrOvpDl4ABUnkes9i36zVxqMXp
 6nVA==
X-Gm-Message-State: AOJu0Yyz/YtPo0pMZ/hONmrOU/T/iSAeyUhFJROs+ByJL4/rOsWGSSr5
 dJhvtdJOgOGAmr6NriEtXTDfMpKZm8SsyXmrV6oW6egOejY3MB2ychZX3kXPK8uftOYMydA4nMq
 C/3XKhrSpXo3UVLEZQ8w5eJ8pXUYacRrpQLZkpIix++ndDh/F0pwdYV2zGXei5zps9MJ5dhxjZf
 7OjiiSJZIqoosPNy6xMH4q4HD9yCnfgbxlkp8DMg==
X-Gm-Gg: AY/fxX5Y52g9zqY2GoqSrJKaOFvNaxlftbc/Np8cKprfNOhQJwNnIhZfOy32v1G+WTc
 097zC9hrF4mI4oxp7tcSLkj4YHCRqlocxBl5hcBx3gedWFwh92Zw9NX9ena3SEJG+5aCLTvx/z3
 ev0PGRokFouXK+XBrwcBpFvc3UEmBEAyaMzGJISg3NwOZvwCn7WV9mKTwf3OJSnWDsEmsqlfB1o
 7Mgbq/2GqkzS4eRBPPspsi5qmuF4QWN21kaAhIfmEzTjTgZ7au2MhNp1mWfPC2lQjg7HA5cyCx3
 h9z/F+nTd+a8X9KxO9ePSEh/h1KCKWo7rTxF5WjnguWNuKb21TMOPHqa4aOIgLGBQbbh/ef5Zuq
 BRJU=
X-Received: by 2002:a05:620a:29d3:b0:8b1:59d9:f1f2 with SMTP id
 af79cd13be357-8c08f667426mr1955963985a.24.1766500240585; 
 Tue, 23 Dec 2025 06:30:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnmNZlWx21tX5PSPF0NGo1pc9kuQXDaLZuw/cfWz7mqfucJxxRykWn+Tw3Pqmt2tUw4tQKwg==
X-Received: by 2002:a05:620a:29d3:b0:8b1:59d9:f1f2 with SMTP id
 af79cd13be357-8c08f667426mr1955941385a.24.1766500239052; 
 Tue, 23 Dec 2025 06:30:39 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:38 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Chuang Xu <xuchuangxclwt@bytedance.com>
Subject: [PULL 30/31] migration: merge fragmented clear_dirty ioctls
Date: Tue, 23 Dec 2025 09:29:58 -0500
Message-ID: <20251223142959.1460293-31-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Chuang Xu <xuchuangxclwt@bytedance.com>

In our long-term experience in Bytedance, we've found that under
the same load, live migration of larger VMs with more devices is
often more difficult to converge (requiring a larger downtime limit).

Through some testing and calculations, we conclude that bitmap sync time
affects the calculation of live migration bandwidth.

When the addresses processed are not aligned, a large number of
clear_dirty ioctl occur (e.g. a 4MB misaligned memory can generate
2048 clear_dirty ioctls from two different memory_listener),
which increases the time required for bitmap_sync and makes it
more difficult for dirty pages to converge.

For a 64C256G vm with 8 vhost-user-net(32 queue per nic) and
16 vhost-user-blk(4 queue per blk), the sync time is as high as *73ms*
(tested with 10GBps dirty rate, the sync time increases as the dirty
page rate increases), Here are each part of the sync time:

- sync from kvm to ram_list: 2.5ms
- vhost_log_sync:3ms
- sync aligned memory from ram_list to RAMBlock: 5ms
- sync misaligned memory from ram_list to RAMBlock: 61ms

Attempt to merge those fragmented clear_dirty ioctls, then syncing
misaligned memory from ram_list to RAMBlock takes only about 1ms,
and the total sync time is only *12ms*.

Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251218114220.83354-1-xuchuangxclwt@bytedance.com
[peterx: drop var "offset" in physical_memory_sync_dirty_bitmap]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/physmem.h |  7 +++---
 accel/tcg/cputlb.c       |  5 +++--
 migration/ram.c          | 19 +++++-----------
 system/memory.c          |  2 +-
 system/physmem.c         | 48 +++++++++++++++++++++++++++-------------
 5 files changed, 46 insertions(+), 35 deletions(-)

diff --git a/include/system/physmem.h b/include/system/physmem.h
index 879f6eae38..a59724ef10 100644
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
+                                              unsigned long *bmap);
 
 DirtyBitmapSnapshot *
 physical_memory_snapshot_and_clear_dirty(MemoryRegion *mr, hwaddr offset,
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
diff --git a/migration/ram.c b/migration/ram.c
index df7e154877..c403fd73a6 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -941,7 +941,6 @@ static uint64_t physical_memory_sync_dirty_bitmap(RAMBlock *rb,
                                                   ram_addr_t start,
                                                   ram_addr_t length)
 {
-    ram_addr_t addr;
     unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
     uint64_t num_dirty = 0;
     unsigned long *dest = rb->bmap;
@@ -993,19 +992,11 @@ static uint64_t physical_memory_sync_dirty_bitmap(RAMBlock *rb,
             memory_region_clear_dirty_bitmap(rb->mr, start, length);
         }
     } else {
-        ram_addr_t offset = rb->offset;
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
+        num_dirty = physical_memory_test_and_clear_dirty(
+                        start + rb->offset,
+                        length,
+                        DIRTY_MEMORY_MIGRATION,
+                        dest);
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
index c9869e4049..26bf30af17 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1089,19 +1089,30 @@ void physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
     }
 }
 
-/* Note: start and end must be within the same ram block.  */
-bool physical_memory_test_and_clear_dirty(ram_addr_t start,
+/*
+ * Note: start and end must be within the same ram block.
+ *
+ * @bmap usage:
+ * - When @bmap is provided, set bits for dirty pages, but
+ *   only count those pages if the bit wasn't already set in @bmap.
+ * - When @bmap is NULL, count all dirty pages in the range.
+ *
+ * @return:
+ * - Number of dirty guest pages found within [start, start + length).
+ */
+uint64_t physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
-                                              unsigned client)
+                                              unsigned client,
+                                              unsigned long *bmap)
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
@@ -1118,12 +1129,19 @@ bool physical_memory_test_and_clear_dirty(ram_addr_t start,
         while (page < end) {
             unsigned long idx = page / DIRTY_MEMORY_BLOCK_SIZE;
             unsigned long offset = page % DIRTY_MEMORY_BLOCK_SIZE;
-            unsigned long num = MIN(end - page,
-                                    DIRTY_MEMORY_BLOCK_SIZE - offset);
 
-            dirty |= bitmap_test_and_clear_atomic(blocks->blocks[idx],
-                                                  offset, num);
-            page += num;
+            if (bitmap_test_and_clear_atomic(blocks->blocks[idx], offset, 1)) {
+                if (bmap) {
+                    unsigned long k = page - (ramblock->offset >> TARGET_PAGE_BITS);
+                    if (!test_and_set_bit(k, bmap)) {
+                        num_dirty++;
+                    }
+                } else {
+                    num_dirty++;
+                }
+            }
+
+            page++;
         }
 
         mr_offset = (ram_addr_t)(start_page << TARGET_PAGE_BITS) - ramblock->offset;
@@ -1131,18 +1149,18 @@ bool physical_memory_test_and_clear_dirty(ram_addr_t start,
         memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_size);
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
2.50.1


