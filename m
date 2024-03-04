Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E861C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx7L-0001XQ-Pp; Sun, 03 Mar 2024 20:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7J-0001Vu-Op
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7D-0002Mw-F8
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wOw9cV6G1FdBgmpEqntI7YB8cm83Rvin9BHTLXvzNUg=;
 b=JR2DxA8wSjPP2v5TDtBGnmSYWf77buhtC2BYYLAvFo3weRlHwi7SY2uYzhs96N6Kd31WLP
 uRNWAA2K0d4NR47CIJASwa9iPfY5TBYoTbEh2uAggtOIFj99iZCI2tsEbgQeh35ONyUMg4
 /Ywn74p673c1sGAJ13myORiYNceDp58=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-k8h3Ra-WMguixpHVj4FoTA-1; Sun, 03 Mar 2024 20:27:35 -0500
X-MC-Unique: k8h3Ra-WMguixpHVj4FoTA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9AF487A9EC;
 Mon,  4 Mar 2024 01:27:34 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 319A940C6EBA;
 Mon,  4 Mar 2024 01:27:30 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Nikolay Borisov <nborisov@suse.com>
Subject: [PULL 12/27] migration/ram: Add outgoing 'mapped-ram' migration
Date: Mon,  4 Mar 2024 09:26:19 +0800
Message-ID: <20240304012634.95520-13-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

Implement the outgoing migration side for the 'mapped-ram' capability.

A bitmap is introduced to track which pages have been written in the
migration file. Pages are written at a fixed location for every
ramblock. Zero pages are ignored as they'd be zero in the destination
migration as well.

The migration stream is altered to put the dirty pages for a ramblock
after its header instead of having a sequential stream of pages that
follow the ramblock headers.

Without mapped-ram (current):        With mapped-ram (new):

 ---------------------               --------------------------------
 | ramblock 1 header |               | ramblock 1 header            |
 ---------------------               --------------------------------
 | ramblock 2 header |               | ramblock 1 mapped-ram header |
 ---------------------               --------------------------------
 | ...               |               | padding to next 1MB boundary |
 ---------------------               | ...                          |
 | ramblock n header |               --------------------------------
 ---------------------               | ramblock 1 pages             |
 | RAM_SAVE_FLAG_EOS |               | ...                          |
 ---------------------               --------------------------------
 | stream of pages   |               | ramblock 2 header            |
 | (iter 1)          |               --------------------------------
 | ...               |               | ramblock 2 mapped-ram header |
 ---------------------               --------------------------------
 | RAM_SAVE_FLAG_EOS |               | padding to next 1MB boundary |
 ---------------------               | ...                          |
 | stream of pages   |               --------------------------------
 | (iter 2)          |               | ramblock 2 pages             |
 | ...               |               | ...                          |
 ---------------------               --------------------------------
 | ...               |               | ...                          |
 ---------------------               --------------------------------
                                     | RAM_SAVE_FLAG_EOS            |
                                     --------------------------------
                                     | ...                          |
                                     --------------------------------

where:
 - ramblock header: the generic information for a ramblock, such as
   idstr, used_len, etc.

 - ramblock mapped-ram header: the new information added by this
   feature: bitmap of pages written, bitmap size and offset of pages
   in the migration file.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240229153017.2221-10-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/ramblock.h |  13 ++++
 migration/ram.c         | 131 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 135 insertions(+), 9 deletions(-)

diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 3eb79723c6..848915ea5b 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -44,6 +44,19 @@ struct RAMBlock {
     size_t page_size;
     /* dirty bitmap used during migration */
     unsigned long *bmap;
+
+    /*
+     * Below fields are only used by mapped-ram migration
+     */
+    /* bitmap of pages present in the migration file */
+    unsigned long *file_bmap;
+    /*
+     * offset in the file pages belonging to this ramblock are saved,
+     * used only during migration to a file.
+     */
+    off_t bitmap_offset;
+    uint64_t pages_offset;
+
     /* bitmap of already received pages in postcopy */
     unsigned long *receivedmap;
 
diff --git a/migration/ram.c b/migration/ram.c
index 45a00b45ed..f807824d49 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -94,6 +94,18 @@
 #define RAM_SAVE_FLAG_MULTIFD_FLUSH    0x200
 /* We can't use any flag that is bigger than 0x200 */
 
+/*
+ * mapped-ram migration supports O_DIRECT, so we need to make sure the
+ * userspace buffer, the IO operation size and the file offset are
+ * aligned according to the underlying device's block size. The first
+ * two are already aligned to page size, but we need to add padding to
+ * the file to align the offset.  We cannot read the block size
+ * dynamically because the migration file can be moved between
+ * different systems, so use 1M to cover most block sizes and to keep
+ * the file offset aligned at page size as well.
+ */
+#define MAPPED_RAM_FILE_OFFSET_ALIGNMENT 0x100000
+
 XBZRLECacheStats xbzrle_counters;
 
 /* used by the search for pages to send */
@@ -1126,12 +1138,18 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
         return 0;
     }
 
+    stat64_add(&mig_stats.zero_pages, 1);
+
+    if (migrate_mapped_ram()) {
+        /* zero pages are not transferred with mapped-ram */
+        clear_bit(offset >> TARGET_PAGE_BITS, pss->block->file_bmap);
+        return 1;
+    }
+
     len += save_page_header(pss, file, pss->block, offset | RAM_SAVE_FLAG_ZERO);
     qemu_put_byte(file, 0);
     len += 1;
     ram_release_page(pss->block->idstr, offset);
-
-    stat64_add(&mig_stats.zero_pages, 1);
     ram_transferred_add(len);
 
     /*
@@ -1189,14 +1207,20 @@ static int save_normal_page(PageSearchStatus *pss, RAMBlock *block,
 {
     QEMUFile *file = pss->pss_channel;
 
-    ram_transferred_add(save_page_header(pss, pss->pss_channel, block,
-                                         offset | RAM_SAVE_FLAG_PAGE));
-    if (async) {
-        qemu_put_buffer_async(file, buf, TARGET_PAGE_SIZE,
-                              migrate_release_ram() &&
-                              migration_in_postcopy());
+    if (migrate_mapped_ram()) {
+        qemu_put_buffer_at(file, buf, TARGET_PAGE_SIZE,
+                           block->pages_offset + offset);
+        set_bit(offset >> TARGET_PAGE_BITS, block->file_bmap);
     } else {
-        qemu_put_buffer(file, buf, TARGET_PAGE_SIZE);
+        ram_transferred_add(save_page_header(pss, pss->pss_channel, block,
+                                             offset | RAM_SAVE_FLAG_PAGE));
+        if (async) {
+            qemu_put_buffer_async(file, buf, TARGET_PAGE_SIZE,
+                                  migrate_release_ram() &&
+                                  migration_in_postcopy());
+        } else {
+            qemu_put_buffer(file, buf, TARGET_PAGE_SIZE);
+        }
     }
     ram_transferred_add(TARGET_PAGE_SIZE);
     stat64_add(&mig_stats.normal_pages, 1);
@@ -2411,6 +2435,8 @@ static void ram_save_cleanup(void *opaque)
         block->clear_bmap = NULL;
         g_free(block->bmap);
         block->bmap = NULL;
+        g_free(block->file_bmap);
+        block->file_bmap = NULL;
     }
 
     xbzrle_cleanup();
@@ -2778,6 +2804,9 @@ static void ram_list_init_bitmaps(void)
              */
             block->bmap = bitmap_new(pages);
             bitmap_set(block->bmap, 0, pages);
+            if (migrate_mapped_ram()) {
+                block->file_bmap = bitmap_new(pages);
+            }
             block->clear_bmap_shift = shift;
             block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
         }
@@ -2915,6 +2944,60 @@ void qemu_guest_free_page_hint(void *addr, size_t len)
     }
 }
 
+#define MAPPED_RAM_HDR_VERSION 1
+struct MappedRamHeader {
+    uint32_t version;
+    /*
+     * The target's page size, so we know how many pages are in the
+     * bitmap.
+     */
+    uint64_t page_size;
+    /*
+     * The offset in the migration file where the pages bitmap is
+     * stored.
+     */
+    uint64_t bitmap_offset;
+    /*
+     * The offset in the migration file where the actual pages (data)
+     * are stored.
+     */
+    uint64_t pages_offset;
+} QEMU_PACKED;
+typedef struct MappedRamHeader MappedRamHeader;
+
+static void mapped_ram_setup_ramblock(QEMUFile *file, RAMBlock *block)
+{
+    g_autofree MappedRamHeader *header = NULL;
+    size_t header_size, bitmap_size;
+    long num_pages;
+
+    header = g_new0(MappedRamHeader, 1);
+    header_size = sizeof(MappedRamHeader);
+
+    num_pages = block->used_length >> TARGET_PAGE_BITS;
+    bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
+
+    /*
+     * Save the file offsets of where the bitmap and the pages should
+     * go as they are written at the end of migration and during the
+     * iterative phase, respectively.
+     */
+    block->bitmap_offset = qemu_get_offset(file) + header_size;
+    block->pages_offset = ROUND_UP(block->bitmap_offset +
+                                   bitmap_size,
+                                   MAPPED_RAM_FILE_OFFSET_ALIGNMENT);
+
+    header->version = cpu_to_be32(MAPPED_RAM_HDR_VERSION);
+    header->page_size = cpu_to_be64(TARGET_PAGE_SIZE);
+    header->bitmap_offset = cpu_to_be64(block->bitmap_offset);
+    header->pages_offset = cpu_to_be64(block->pages_offset);
+
+    qemu_put_buffer(file, (uint8_t *) header, header_size);
+
+    /* prepare offset for next ramblock */
+    qemu_set_offset(file, block->pages_offset + block->used_length, SEEK_SET);
+}
+
 /*
  * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
  * long-running RCU critical section.  When rcu-reclaims in the code
@@ -2964,6 +3047,10 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
             if (migrate_ignore_shared()) {
                 qemu_put_be64(f, block->mr->addr);
             }
+
+            if (migrate_mapped_ram()) {
+                mapped_ram_setup_ramblock(f, block);
+            }
         }
     }
 
@@ -2997,6 +3084,20 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     return qemu_fflush(f);
 }
 
+static void ram_save_file_bmap(QEMUFile *f)
+{
+    RAMBlock *block;
+
+    RAMBLOCK_FOREACH_MIGRATABLE(block) {
+        long num_pages = block->used_length >> TARGET_PAGE_BITS;
+        long bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
+
+        qemu_put_buffer_at(f, (uint8_t *)block->file_bmap, bitmap_size,
+                           block->bitmap_offset);
+        ram_transferred_add(bitmap_size);
+    }
+}
+
 /**
  * ram_save_iterate: iterative stage for migration
  *
@@ -3186,6 +3287,18 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         return ret;
     }
 
+    if (migrate_mapped_ram()) {
+        ram_save_file_bmap(f);
+
+        if (qemu_file_get_error(f)) {
+            Error *local_err = NULL;
+            int err = qemu_file_get_error_obj(f, &local_err);
+
+            error_reportf_err(local_err, "Failed to write bitmap to file: ");
+            return -err;
+        }
+    }
+
     if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
         qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
     }
-- 
2.44.0


