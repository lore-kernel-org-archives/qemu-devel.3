Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3A2C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfiN1-0005YW-30; Thu, 29 Feb 2024 10:30:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfiMy-0005Y6-78
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:30:48 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfiMw-0005yH-Bb
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:30:47 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DA6512200C;
 Thu, 29 Feb 2024 15:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709220644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pC13tBeXORti+dcydaM//5PqpaE/nmYEgsRjjtZwzWc=;
 b=VOXsZiOuiTcLBUKlk3wtVP02ICR/9TY28YICl6GHHM+2O+0zOoHCGXN76ost8szmLitKfX
 VO6q0eLYcAxO+KDB5QrTzBmMGqJ2le+J2/swOECPPk+oBMfSUoEWOqcNah3ILkmkROaFss
 Lnz0S+djDsLvcTnsfCPalL/z5YPq0+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709220644;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pC13tBeXORti+dcydaM//5PqpaE/nmYEgsRjjtZwzWc=;
 b=6qRkFdmTkx6S6VVqfEZCHgz3d69SXhNaXFOzIi+4KBh+4pYfMGHLr6H/htumD5RUfI78Qe
 k+7avZTVmcwqLkDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709220644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pC13tBeXORti+dcydaM//5PqpaE/nmYEgsRjjtZwzWc=;
 b=VOXsZiOuiTcLBUKlk3wtVP02ICR/9TY28YICl6GHHM+2O+0zOoHCGXN76ost8szmLitKfX
 VO6q0eLYcAxO+KDB5QrTzBmMGqJ2le+J2/swOECPPk+oBMfSUoEWOqcNah3ILkmkROaFss
 Lnz0S+djDsLvcTnsfCPalL/z5YPq0+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709220644;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pC13tBeXORti+dcydaM//5PqpaE/nmYEgsRjjtZwzWc=;
 b=6qRkFdmTkx6S6VVqfEZCHgz3d69SXhNaXFOzIi+4KBh+4pYfMGHLr6H/htumD5RUfI78Qe
 k+7avZTVmcwqLkDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A25613503;
 Thu, 29 Feb 2024 15:30:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eFmtMCKj4GU/MAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 29 Feb 2024 15:30:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v6 10/23] migration/ram: Add incoming 'mapped-ram' migration
Date: Thu, 29 Feb 2024 12:30:04 -0300
Message-Id: <20240229153017.2221-11-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240229153017.2221-1-farosas@suse.de>
References: <20240229153017.2221-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add the necessary code to parse the format changes for the
'mapped-ram' capability.

One of the more notable changes in behavior is that in the
'mapped-ram' case ram pages are restored in one go rather than
constantly looping through the migration stream.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
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
2.35.3


