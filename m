Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3064DC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx7O-0001aa-Rv; Sun, 03 Mar 2024 20:27:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7N-0001YH-1h
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7K-0002Nr-77
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FRP4T2d9MQuOlNmDtUAae05kNAQSZL4VMQhQOX0mt1U=;
 b=T5P6iQ1PVW7TnGfGXdtEMsZJ9pDqgxTnPxpT3uTBn/BsaWDV/jAtBKfcGMKmGsPeCY6Yno
 QeqfynxcijQx6nwgUUYfCF5YSvqhbzWtGCq3LjsR0QU3xZm7bNh6SUvI/OSDG6oFVNPizo
 xCijBQUuu8EkCUP7GvvYBwcwHariM5k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-AElsu5s9O1C9bMXNHEx87w-1; Sun,
 03 Mar 2024 20:27:39 -0500
X-MC-Unique: AElsu5s9O1C9bMXNHEx87w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 494A73814E90;
 Mon,  4 Mar 2024 01:27:39 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78D3E40C6EBA;
 Mon,  4 Mar 2024 01:27:35 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Nikolay Borisov <nborisov@suse.com>
Subject: [PULL 13/27] migration/ram: Add incoming 'mapped-ram' migration
Date: Mon,  4 Mar 2024 09:26:20 +0800
Message-ID: <20240304012634.95520-14-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add the necessary code to parse the format changes for the
'mapped-ram' capability.

One of the more notable changes in behavior is that in the
'mapped-ram' case ram pages are restored in one go rather than
constantly looping through the migration stream.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240229153017.2221-11-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 143 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 141 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index f807824d49..18620784c6 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -106,6 +106,12 @@
  */
 #define MAPPED_RAM_FILE_OFFSET_ALIGNMENT 0x100000
 
+/*
+ * When doing mapped-ram migration, this is the amount we read from
+ * the pages region in the migration file at a time.
+ */
+#define MAPPED_RAM_LOAD_BUF_SIZE 0x100000
+
 XBZRLECacheStats xbzrle_counters;
 
 /* used by the search for pages to send */
@@ -2998,6 +3004,35 @@ static void mapped_ram_setup_ramblock(QEMUFile *file, RAMBlock *block)
     qemu_set_offset(file, block->pages_offset + block->used_length, SEEK_SET);
 }
 
+static bool mapped_ram_read_header(QEMUFile *file, MappedRamHeader *header,
+                                   Error **errp)
+{
+    size_t ret, header_size = sizeof(MappedRamHeader);
+
+    ret = qemu_get_buffer(file, (uint8_t *)header, header_size);
+    if (ret != header_size) {
+        error_setg(errp, "Could not read whole mapped-ram migration header "
+                   "(expected %zd, got %zd bytes)", header_size, ret);
+        return false;
+    }
+
+    /* migration stream is big-endian */
+    header->version = be32_to_cpu(header->version);
+
+    if (header->version > MAPPED_RAM_HDR_VERSION) {
+        error_setg(errp, "Migration mapped-ram capability version not "
+                   "supported (expected <= %d, got %d)", MAPPED_RAM_HDR_VERSION,
+                   header->version);
+        return false;
+    }
+
+    header->page_size = be64_to_cpu(header->page_size);
+    header->bitmap_offset = be64_to_cpu(header->bitmap_offset);
+    header->pages_offset = be64_to_cpu(header->pages_offset);
+
+    return true;
+}
+
 /*
  * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
  * long-running RCU critical section.  When rcu-reclaims in the code
@@ -3899,22 +3934,126 @@ void colo_flush_ram_cache(void)
     trace_colo_flush_ram_cache_end();
 }
 
+static bool read_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
+                                     long num_pages, unsigned long *bitmap,
+                                     Error **errp)
+{
+    ERRP_GUARD();
+    unsigned long set_bit_idx, clear_bit_idx;
+    ram_addr_t offset;
+    void *host;
+    size_t read, unread, size;
+
+    for (set_bit_idx = find_first_bit(bitmap, num_pages);
+         set_bit_idx < num_pages;
+         set_bit_idx = find_next_bit(bitmap, num_pages, clear_bit_idx + 1)) {
+
+        clear_bit_idx = find_next_zero_bit(bitmap, num_pages, set_bit_idx + 1);
+
+        unread = TARGET_PAGE_SIZE * (clear_bit_idx - set_bit_idx);
+        offset = set_bit_idx << TARGET_PAGE_BITS;
+
+        while (unread > 0) {
+            host = host_from_ram_block_offset(block, offset);
+            if (!host) {
+                error_setg(errp, "page outside of ramblock %s range",
+                           block->idstr);
+                return false;
+            }
+
+            size = MIN(unread, MAPPED_RAM_LOAD_BUF_SIZE);
+
+            read = qemu_get_buffer_at(f, host, size,
+                                      block->pages_offset + offset);
+            if (!read) {
+                goto err;
+            }
+            offset += read;
+            unread -= read;
+        }
+    }
+
+    return true;
+
+err:
+    qemu_file_get_error_obj(f, errp);
+    error_prepend(errp, "(%s) failed to read page " RAM_ADDR_FMT
+                  "from file offset %" PRIx64 ": ", block->idstr, offset,
+                  block->pages_offset + offset);
+    return false;
+}
+
+static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
+                                      ram_addr_t length, Error **errp)
+{
+    g_autofree unsigned long *bitmap = NULL;
+    MappedRamHeader header;
+    size_t bitmap_size;
+    long num_pages;
+
+    if (!mapped_ram_read_header(f, &header, errp)) {
+        return;
+    }
+
+    block->pages_offset = header.pages_offset;
+
+    /*
+     * Check the alignment of the file region that contains pages. We
+     * don't enforce MAPPED_RAM_FILE_OFFSET_ALIGNMENT to allow that
+     * value to change in the future. Do only a sanity check with page
+     * size alignment.
+     */
+    if (!QEMU_IS_ALIGNED(block->pages_offset, TARGET_PAGE_SIZE)) {
+        error_setg(errp,
+                   "Error reading ramblock %s pages, region has bad alignment",
+                   block->idstr);
+        return;
+    }
+
+    num_pages = length / header.page_size;
+    bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
+
+    bitmap = g_malloc0(bitmap_size);
+    if (qemu_get_buffer_at(f, (uint8_t *)bitmap, bitmap_size,
+                           header.bitmap_offset) != bitmap_size) {
+        error_setg(errp, "Error reading dirty bitmap");
+        return;
+    }
+
+    if (!read_ramblock_mapped_ram(f, block, num_pages, bitmap, errp)) {
+        return;
+    }
+
+    /* Skip pages array */
+    qemu_set_offset(f, block->pages_offset + length, SEEK_SET);
+
+    return;
+}
+
 static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
 {
     int ret = 0;
     /* ADVISE is earlier, it shows the source has the postcopy capability on */
     bool postcopy_advised = migration_incoming_postcopy_advised();
+    Error *local_err = NULL;
 
     assert(block);
 
+    if (migrate_mapped_ram()) {
+        parse_ramblock_mapped_ram(f, block, length, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return -EINVAL;
+        }
+        return 0;
+    }
+
     if (!qemu_ram_is_migratable(block)) {
         error_report("block %s should not be migrated !", block->idstr);
         return -EINVAL;
     }
 
     if (length != block->used_length) {
-        Error *local_err = NULL;
-
         ret = qemu_ram_resize(block, length, &local_err);
         if (local_err) {
             error_report_err(local_err);
-- 
2.44.0


