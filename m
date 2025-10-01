Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE2CCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 18:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v415J-0004MP-JF; Wed, 01 Oct 2025 13:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v414z-0004AM-Eg
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:57:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4145-0001H7-Vq
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:57:28 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so919895e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759341383; x=1759946183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAa64ilovqHzU+iWkKyZBuuA80ebZBOrUY0XcTyBZGY=;
 b=YAobzrDyIWAxXHkWVB7ooN5dNpijLkxSLEg4Nk+OXuBS0ZCmLTcEphE9bWQxR1mKgr
 oXUz4v6cDMF6WrJn66yVlJKgJMiLDzKNNUJc0dWxYkfiT0W0PjAPgtRIHEJewFMrrC1w
 afiCk4H9vCiYio4HfJYoHZrWFc0hoMNd80PGhOmmP6ZUO7fnmOkbV97O7RCIO+2jAVDi
 3brrwEUpASeJa+TIR1hZ+OOmViR9FBUg0LmSWr9B0X9pqQ8BIwpDz331MWL3kbuolT00
 7NRVAETwcfW/cBsEyuAlwIFFibDjiiUf3khYqkeJdkrDte4dtw2btJUpvV5rJpTQlCvR
 MCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759341383; x=1759946183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NAa64ilovqHzU+iWkKyZBuuA80ebZBOrUY0XcTyBZGY=;
 b=settJBjfaHTncWPefLBeMu1Azo7vNq8mTmpg+/RBx1dXzEmkhjBcwBHZtJ13Gl29HL
 Lthsv7KqjROhvau34tc4M3IaVgxznN9pd2zJceeGUHFXI+Y3lhvOmc3qn4xA+zQB7VU9
 RrOkzznKEBJvXaihPHiCI7+Lc5m8L7BUwS7fGbh/PcduuGVxhLJ6rVdVB/lwSc56c5Vn
 XLwvPPiGhXd6t0PkhfeI1+edAZQd4hpemANBazy49RRtbo8ICuxr5lSrVbszt2prLgnp
 lrJT86eXU1gZxlk6AP6csa6Tho9RPhj1FK/Rww+53VmP2kzAMQXx5q6AIjDmILQajh4y
 91hw==
X-Gm-Message-State: AOJu0YxOhdfYbOZVQNogn6dWuBp0E8eN9oJEz4gqzt6SbuEmU5W9MLF2
 OBEHdyGQCY/S7omaY0IlAgFEQ/y2zm9+dT5XZH1eiBJfToH+TajOqaXGPz2eySbmLJPmS+jIlLj
 ha1O4Rt7oKg==
X-Gm-Gg: ASbGncvSCJrRIYinBO9LcOiBJFCtXPQmRG1wNJWOalVsgSq7o8SQHhQtkspWwLyloXD
 uD/83maCn7Bpq5om8IEQLUUh9PEp06c89/tbPxwNqS/8OMwR754DGa84WE5pz6SLr+y5NSfKzOj
 OxeONvsMM/TfqFNx9Zf3OGy/ZO9ETSghBUy3lepv1TDA8SAlad/H0IkWD+GIfwA6j4JidEnpc23
 wLZDyEVCNp91talqoo7FZenLyOByqKEft4ocjLlHkWelRWz6r1Yti+zSElK0d4vY/usensRINMW
 v2wXmAdb/Vlyd04/B7l9bC4aYcKrk9LMIglAWtbqPBsmuJNqIm6iYP1sr3b2o1SiQQxZ0TyO3kr
 Ia9Kgt7SzV/c7D10QvSsJG12bAedW2YA+9q+A90ILLQHseE2paN6wNAD5jXP1aG4YGEZy8rQ6PI
 lSx5LEbpfyERdbNAv3Pg9aT+r8xqwcPYLTtvUd
X-Google-Smtp-Source: AGHT+IEbaEDO/T7GJXJpxgavXbTCnr+zVBqDBdC/Mk2G5rRRoZke+dwu6XJdM3VdL5U6tvUcPWsbDQ==
X-Received: by 2002:a05:6000:60f:b0:3dc:1473:18bc with SMTP id
 ffacd0b85a97d-425577ccbc0mr3733490f8f.0.1759341383206; 
 Wed, 01 Oct 2025 10:56:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e693c33adsm1063565e9.18.2025.10.01.10.56.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 10:56:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jason Herne <jjherne@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Farman <farman@linux.ibm.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 17/18] system/physmem: Drop 'cpu_' prefix in Physical
 Memory API
Date: Wed,  1 Oct 2025 19:54:46 +0200
Message-ID: <20251001175448.18933-18-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001175448.18933-1-philmd@linaro.org>
References: <20251001175448.18933-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The functions related to the Physical Memory API declared
in "system/ram_addr.h" do not operate on vCPU. Remove the
'cpu_' prefix.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/ram_addr.h   | 24 +++++++++----------
 accel/kvm/kvm-all.c         |  2 +-
 accel/tcg/cputlb.c          | 12 +++++-----
 hw/vfio/container-legacy.c  |  8 +++----
 hw/vfio/container.c         |  4 ++--
 migration/ram.c             |  4 ++--
 system/memory.c             |  8 +++----
 system/physmem.c            | 48 ++++++++++++++++++-------------------
 target/arm/tcg/mte_helper.c |  2 +-
 system/memory_ldst.c.inc    |  2 +-
 tests/tsan/ignore.tsan      |  4 ++--
 11 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index d2d088bbea6..3894a84fb9c 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -136,39 +136,39 @@ static inline void qemu_ram_block_writeback(RAMBlock *block)
 #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
 #define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
 
-bool cpu_physical_memory_get_dirty_flag(ram_addr_t addr, unsigned client);
+bool physical_memory_get_dirty_flag(ram_addr_t addr, unsigned client);
 
-bool cpu_physical_memory_is_clean(ram_addr_t addr);
+bool physical_memory_is_clean(ram_addr_t addr);
 
-uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t start,
+uint8_t physical_memory_range_includes_clean(ram_addr_t start,
                                                  ram_addr_t length,
                                                  uint8_t mask);
 
-void cpu_physical_memory_set_dirty_flag(ram_addr_t addr, unsigned client);
+void physical_memory_set_dirty_flag(ram_addr_t addr, unsigned client);
 
-void cpu_physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
+void physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
                                          uint8_t mask);
 
 /*
- * Contrary to cpu_physical_memory_sync_dirty_bitmap() this function returns
+ * Contrary to physical_memory_sync_dirty_bitmap() this function returns
  * the number of dirty pages in @bitmap passed as argument. On the other hand,
- * cpu_physical_memory_sync_dirty_bitmap() returns newly dirtied pages that
+ * physical_memory_sync_dirty_bitmap() returns newly dirtied pages that
  * weren't set in the global migration bitmap.
  */
-uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
+uint64_t physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
                                                 ram_addr_t start,
                                                 ram_addr_t pages);
 
-void cpu_physical_memory_dirty_bits_cleared(ram_addr_t start, ram_addr_t length);
+void physical_memory_dirty_bits_cleared(ram_addr_t start, ram_addr_t length);
 
-bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
+bool physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
                                               unsigned client);
 
-DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
+DirtyBitmapSnapshot *physical_memory_snapshot_and_clear_dirty
     (MemoryRegion *mr, hwaddr offset, hwaddr length, unsigned client);
 
-bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
+bool physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
                                             ram_addr_t start,
                                             ram_addr_t length);
 
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 08b2b5a371c..a7ece7db964 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -758,7 +758,7 @@ static void kvm_slot_sync_dirty_pages(KVMSlot *slot)
     ram_addr_t start = slot->ram_start_offset;
     ram_addr_t pages = slot->memory_size / qemu_real_host_page_size();
 
-    cpu_physical_memory_set_dirty_lebitmap(slot->dirty_bmap, start, pages);
+    physical_memory_set_dirty_lebitmap(slot->dirty_bmap, start, pages);
 }
 
 static void kvm_slot_reset_dirty_pages(KVMSlot *slot)
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2a6aa01c57c..a721235dea6 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -858,7 +858,7 @@ void tlb_flush_page_bits_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
    can be detected */
 void tlb_protect_code(ram_addr_t ram_addr)
 {
-    cpu_physical_memory_test_and_clear_dirty(ram_addr & TARGET_PAGE_MASK,
+    physical_memory_test_and_clear_dirty(ram_addr & TARGET_PAGE_MASK,
                                              TARGET_PAGE_SIZE,
                                              DIRTY_MEMORY_CODE);
 }
@@ -867,7 +867,7 @@ void tlb_protect_code(ram_addr_t ram_addr)
    tested for self modifying code */
 void tlb_unprotect_code(ram_addr_t ram_addr)
 {
-    cpu_physical_memory_set_dirty_flag(ram_addr, DIRTY_MEMORY_CODE);
+    physical_memory_set_dirty_flag(ram_addr, DIRTY_MEMORY_CODE);
 }
 
 
@@ -1085,7 +1085,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
         if (prot & PAGE_WRITE) {
             if (section->readonly) {
                 write_flags |= TLB_DISCARD_WRITE;
-            } else if (cpu_physical_memory_is_clean(iotlb)) {
+            } else if (physical_memory_is_clean(iotlb)) {
                 write_flags |= TLB_NOTDIRTY;
             }
         }
@@ -1341,7 +1341,7 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
 
     trace_memory_notdirty_write_access(mem_vaddr, ram_addr, size);
 
-    if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)) {
+    if (!physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)) {
         tb_invalidate_phys_range_fast(cpu, ram_addr, size, retaddr);
     }
 
@@ -1349,10 +1349,10 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
      * Set both VGA and migration bits for simplicity and to remove
      * the notdirty callback faster.
      */
-    cpu_physical_memory_set_dirty_range(ram_addr, size, DIRTY_CLIENTS_NOCODE);
+    physical_memory_set_dirty_range(ram_addr, size, DIRTY_CLIENTS_NOCODE);
 
     /* We remove the notdirty callback only if the code has been flushed. */
-    if (!cpu_physical_memory_is_clean(ram_addr)) {
+    if (!physical_memory_is_clean(ram_addr)) {
         trace_memory_notdirty_set_dirty(mem_vaddr);
         tlb_set_dirty(cpu, mem_vaddr);
     }
diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
index 3a710d8265c..eb9911eaeaf 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -92,7 +92,7 @@ static int vfio_dma_unmap_bitmap(const VFIOLegacyContainer *container,
     bitmap = (struct vfio_bitmap *)&unmap->data;
 
     /*
-     * cpu_physical_memory_set_dirty_lebitmap() supports pages in bitmap of
+     * physical_memory_set_dirty_lebitmap() supports pages in bitmap of
      * qemu_real_host_page_size to mark those dirty. Hence set bitmap_pgsize
      * to qemu_real_host_page_size.
      */
@@ -108,7 +108,7 @@ static int vfio_dma_unmap_bitmap(const VFIOLegacyContainer *container,
 
     ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
     if (!ret) {
-        cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap,
+        physical_memory_set_dirty_lebitmap(vbmap.bitmap,
                 iotlb->translated_addr, vbmap.pages);
     } else {
         error_report("VFIO_UNMAP_DMA with DIRTY_BITMAP : %m");
@@ -284,7 +284,7 @@ static int vfio_legacy_query_dirty_bitmap(const VFIOContainer *bcontainer,
     range->size = size;
 
     /*
-     * cpu_physical_memory_set_dirty_lebitmap() supports pages in bitmap of
+     * physical_memory_set_dirty_lebitmap() supports pages in bitmap of
      * qemu_real_host_page_size to mark those dirty. Hence set bitmap's pgsize
      * to qemu_real_host_page_size.
      */
@@ -503,7 +503,7 @@ static void vfio_get_iommu_info_migration(VFIOLegacyContainer *container,
                             header);
 
     /*
-     * cpu_physical_memory_set_dirty_lebitmap() supports pages in bitmap of
+     * physical_memory_set_dirty_lebitmap() supports pages in bitmap of
      * qemu_real_host_page_size to mark those dirty.
      */
     if (cap_mig->pgsize_bitmap & qemu_real_host_page_size()) {
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 41de3439246..3fb19a1c8ad 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -255,7 +255,7 @@ int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
     int ret;
 
     if (!bcontainer->dirty_pages_supported && !all_device_dirty_tracking) {
-        cpu_physical_memory_set_dirty_range(translated_addr, size,
+        physical_memory_set_dirty_range(translated_addr, size,
                                             tcg_enabled() ? DIRTY_CLIENTS_ALL :
                                             DIRTY_CLIENTS_NOCODE);
         return 0;
@@ -280,7 +280,7 @@ int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
         goto out;
     }
 
-    dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap,
+    dirty_pages = physical_memory_set_dirty_lebitmap(vbmap.bitmap,
                                                          translated_addr,
                                                          vbmap.pages);
 
diff --git a/migration/ram.c b/migration/ram.c
index 52bdfec91d9..d09591c0600 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -976,7 +976,7 @@ static uint64_t physical_memory_sync_dirty_bitmap(RAMBlock *rb,
             }
         }
         if (num_dirty) {
-            cpu_physical_memory_dirty_bits_cleared(start, length);
+            physical_memory_dirty_bits_cleared(start, length);
         }
 
         if (rb->clear_bmap) {
@@ -995,7 +995,7 @@ static uint64_t physical_memory_sync_dirty_bitmap(RAMBlock *rb,
         ram_addr_t offset = rb->offset;
 
         for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
-            if (cpu_physical_memory_test_and_clear_dirty(
+            if (physical_memory_test_and_clear_dirty(
                         start + addr + offset,
                         TARGET_PAGE_SIZE,
                         DIRTY_MEMORY_MIGRATION)) {
diff --git a/system/memory.c b/system/memory.c
index cf8cad69611..dd045da60c0 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2275,7 +2275,7 @@ void memory_region_set_dirty(MemoryRegion *mr, hwaddr addr,
                              hwaddr size)
 {
     assert(mr->ram_block);
-    cpu_physical_memory_set_dirty_range(memory_region_get_ram_addr(mr) + addr,
+    physical_memory_set_dirty_range(memory_region_get_ram_addr(mr) + addr,
                                         size,
                                         memory_region_get_dirty_log_mask(mr));
 }
@@ -2379,7 +2379,7 @@ DirtyBitmapSnapshot *memory_region_snapshot_and_clear_dirty(MemoryRegion *mr,
     DirtyBitmapSnapshot *snapshot;
     assert(mr->ram_block);
     memory_region_sync_dirty_bitmap(mr, false);
-    snapshot = cpu_physical_memory_snapshot_and_clear_dirty(mr, addr, size, client);
+    snapshot = physical_memory_snapshot_and_clear_dirty(mr, addr, size, client);
     memory_global_after_dirty_log_sync();
     return snapshot;
 }
@@ -2388,7 +2388,7 @@ bool memory_region_snapshot_get_dirty(MemoryRegion *mr, DirtyBitmapSnapshot *sna
                                       hwaddr addr, hwaddr size)
 {
     assert(mr->ram_block);
-    return cpu_physical_memory_snapshot_get_dirty(snap,
+    return physical_memory_snapshot_get_dirty(snap,
                 memory_region_get_ram_addr(mr) + addr, size);
 }
 
@@ -2426,7 +2426,7 @@ void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,
                                hwaddr size, unsigned client)
 {
     assert(mr->ram_block);
-    cpu_physical_memory_test_and_clear_dirty(
+    physical_memory_test_and_clear_dirty(
         memory_region_get_ram_addr(mr) + addr, size, client);
 }
 
diff --git a/system/physmem.c b/system/physmem.c
index ad9705c7726..1a075da2bdd 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -901,7 +901,7 @@ void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length)
     }
 }
 
-void cpu_physical_memory_dirty_bits_cleared(ram_addr_t start, ram_addr_t length)
+void physical_memory_dirty_bits_cleared(ram_addr_t start, ram_addr_t length)
 {
     if (tcg_enabled()) {
         tlb_reset_dirty_range_all(start, length);
@@ -947,17 +947,17 @@ static bool physical_memory_get_dirty(ram_addr_t start, ram_addr_t length,
     return dirty;
 }
 
-bool cpu_physical_memory_get_dirty_flag(ram_addr_t addr, unsigned client)
+bool physical_memory_get_dirty_flag(ram_addr_t addr, unsigned client)
 {
     return physical_memory_get_dirty(addr, 1, client);
 }
 
-bool cpu_physical_memory_is_clean(ram_addr_t addr)
+bool physical_memory_is_clean(ram_addr_t addr)
 {
-    bool vga = cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_VGA);
-    bool code = cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_CODE);
+    bool vga = physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_VGA);
+    bool code = physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_CODE);
     bool migration =
-        cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_MIGRATION);
+        physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_MIGRATION);
     return !(vga && code && migration);
 }
 
@@ -1000,7 +1000,7 @@ static bool physical_memory_all_dirty(ram_addr_t start, ram_addr_t length,
     return dirty;
 }
 
-uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t start,
+uint8_t physical_memory_range_includes_clean(ram_addr_t start,
                                                  ram_addr_t length,
                                                  uint8_t mask)
 {
@@ -1021,7 +1021,7 @@ uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t start,
     return ret;
 }
 
-void cpu_physical_memory_set_dirty_flag(ram_addr_t addr, unsigned client)
+void physical_memory_set_dirty_flag(ram_addr_t addr, unsigned client)
 {
     unsigned long page, idx, offset;
     DirtyMemoryBlocks *blocks;
@@ -1039,7 +1039,7 @@ void cpu_physical_memory_set_dirty_flag(ram_addr_t addr, unsigned client)
     set_bit_atomic(offset, blocks->blocks[idx]);
 }
 
-void cpu_physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
+void physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
                                          uint8_t mask)
 {
     DirtyMemoryBlocks *blocks[DIRTY_MEMORY_NUM];
@@ -1091,7 +1091,7 @@ void cpu_physical_memory_set_dirty_range(ram_addr_t start, ram_addr_t length,
 }
 
 /* Note: start and end must be within the same ram block.  */
-bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
+bool physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
                                               unsigned client)
 {
@@ -1133,7 +1133,7 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
     }
 
     if (dirty) {
-        cpu_physical_memory_dirty_bits_cleared(start, length);
+        physical_memory_dirty_bits_cleared(start, length);
     }
 
     return dirty;
@@ -1141,12 +1141,12 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
 
 static void physical_memory_clear_dirty_range(ram_addr_t addr, ram_addr_t length)
 {
-    cpu_physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_MIGRATION);
-    cpu_physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_VGA);
-    cpu_physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_CODE);
+    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_MIGRATION);
+    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_VGA);
+    physical_memory_test_and_clear_dirty(addr, length, DIRTY_MEMORY_CODE);
 }
 
-DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
+DirtyBitmapSnapshot *physical_memory_snapshot_and_clear_dirty
     (MemoryRegion *mr, hwaddr offset, hwaddr length, unsigned client)
 {
     DirtyMemoryBlocks *blocks;
@@ -1193,14 +1193,14 @@ DirtyBitmapSnapshot *cpu_physical_memory_snapshot_and_clear_dirty
         }
     }
 
-    cpu_physical_memory_dirty_bits_cleared(start, length);
+    physical_memory_dirty_bits_cleared(start, length);
 
     memory_region_clear_dirty_bitmap(mr, offset, length);
 
     return snap;
 }
 
-bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
+bool physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
                                             ram_addr_t start,
                                             ram_addr_t length)
 {
@@ -1221,7 +1221,7 @@ bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
     return false;
 }
 
-uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
+uint64_t physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
                                                 ram_addr_t start,
                                                 ram_addr_t pages)
 {
@@ -1314,7 +1314,7 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
                     page_number = (i * HOST_LONG_BITS + j) * hpratio;
                     addr = page_number * TARGET_PAGE_SIZE;
                     ram_addr = start + addr;
-                    cpu_physical_memory_set_dirty_range(ram_addr,
+                    physical_memory_set_dirty_range(ram_addr,
                                        TARGET_PAGE_SIZE * hpratio, clients);
                 } while (c != 0);
             }
@@ -2082,7 +2082,7 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
 
     physical_memory_clear_dirty_range(block->offset, block->used_length);
     block->used_length = newsize;
-    cpu_physical_memory_set_dirty_range(block->offset, block->used_length,
+    physical_memory_set_dirty_range(block->offset, block->used_length,
                                         DIRTY_CLIENTS_ALL);
     memory_region_set_size(block->mr, unaligned_size);
     if (block->resized) {
@@ -2287,7 +2287,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     ram_list.version++;
     qemu_mutex_unlock_ramlist();
 
-    cpu_physical_memory_set_dirty_range(new_block->offset,
+    physical_memory_set_dirty_range(new_block->offset,
                                         new_block->used_length,
                                         DIRTY_CLIENTS_ALL);
 
@@ -3136,19 +3136,19 @@ static void invalidate_and_set_dirty(MemoryRegion *mr, hwaddr addr,
     addr += ramaddr;
 
     /* No early return if dirty_log_mask is or becomes 0, because
-     * cpu_physical_memory_set_dirty_range will still call
+     * physical_memory_set_dirty_range will still call
      * xen_modified_memory.
      */
     if (dirty_log_mask) {
         dirty_log_mask =
-            cpu_physical_memory_range_includes_clean(addr, length, dirty_log_mask);
+            physical_memory_range_includes_clean(addr, length, dirty_log_mask);
     }
     if (dirty_log_mask & (1 << DIRTY_MEMORY_CODE)) {
         assert(tcg_enabled());
         tb_invalidate_phys_range(NULL, addr, addr + length - 1);
         dirty_log_mask &= ~(1 << DIRTY_MEMORY_CODE);
     }
-    cpu_physical_memory_set_dirty_range(addr, length, dirty_log_mask);
+    physical_memory_set_dirty_range(addr, length, dirty_log_mask);
 }
 
 void memory_region_flush_rom_device(MemoryRegion *mr, hwaddr addr, hwaddr size)
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 7d80244788e..077ff4b2b2c 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -189,7 +189,7 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
      */
     if (tag_access == MMU_DATA_STORE) {
         ram_addr_t tag_ra = memory_region_get_ram_addr(mr) + xlat;
-        cpu_physical_memory_set_dirty_flag(tag_ra, DIRTY_MEMORY_MIGRATION);
+        physical_memory_set_dirty_flag(tag_ra, DIRTY_MEMORY_MIGRATION);
     }
 
     return memory_region_get_ram_ptr(mr) + xlat;
diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index 7f32d3d9ff3..333da209d1a 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -287,7 +287,7 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
 
         dirty_log_mask = memory_region_get_dirty_log_mask(mr);
         dirty_log_mask &= ~(1 << DIRTY_MEMORY_CODE);
-        cpu_physical_memory_set_dirty_range(memory_region_get_ram_addr(mr) + addr,
+        physical_memory_set_dirty_range(memory_region_get_ram_addr(mr) + addr,
                                             4, dirty_log_mask);
         r = MEMTX_OK;
     }
diff --git a/tests/tsan/ignore.tsan b/tests/tsan/ignore.tsan
index 423e482d2f9..8fa00a2c49b 100644
--- a/tests/tsan/ignore.tsan
+++ b/tests/tsan/ignore.tsan
@@ -4,7 +4,7 @@
 # The eventual goal would be to fix these warnings.
 
 # TSan is not happy about setting/getting of dirty bits,
-# for example, cpu_physical_memory_set_dirty_range,
-# and cpu_physical_memory_get_dirty.
+# for example, physical_memory_set_dirty_range,
+# and physical_memory_get_dirty.
 src:bitops.c
 src:bitmap.c
-- 
2.51.0


