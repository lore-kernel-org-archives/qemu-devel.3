Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F25CC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 15:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzyz1-0001Ko-0N; Fri, 28 Aug 2026 11:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyyz-0001KO-7S
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:09 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyyw-0008CG-3X
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:08 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8216F221E6;
 Fri, 28 Aug 2026 15:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1OFQJUWDbKjObiV52ezMiOfXjlvswKMRphGWikfDBLk=;
 b=B2Ccvgd1ABNUkiTeoLSaU0icwjY5g2ts7/7U+mbGC97q1DKRnvcbrKWduFBnJdYiyDm6d+
 cJgWsB2a2T9fam/EshOTFsDu7vRYAxKZYUNgEKlesDc1bDKRRgFpojrzjiNgd49+znGkqO
 7xBIqBYlnp/TVDYQtXy732ScQjh+Ajw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1OFQJUWDbKjObiV52ezMiOfXjlvswKMRphGWikfDBLk=;
 b=n0wA3laYV0t1Rt+X7PPjF3HKbCg04ad1QewwkXKmpy8AGMyJlDLt/ZbmZm3vM8xr5bjt4M
 j4ySbglNrANqIQCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kBMVoUJ2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qALlR4VF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1OFQJUWDbKjObiV52ezMiOfXjlvswKMRphGWikfDBLk=;
 b=kBMVoUJ28uMPoKq0sQI8RNtdgAvzJYW92+as/mwstig/MSesHCEyZyFFzAPYZ7WMV8GC8L
 wdPpRoHOmKInI2y62//msqVl54MLnjS/+A7lRJd/dJxCYt97cT0kpuhqPXABDDavvTXoCX
 wSH6LqWuercrlLCbLP2TFF4gZ/JiVRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1OFQJUWDbKjObiV52ezMiOfXjlvswKMRphGWikfDBLk=;
 b=qALlR4VFyxC7KrpCIbM6mR358wUGTmuIQuUfRKHMGvblcOZOwcJfITDPcMS2FTM7L+Lqj/
 Dt9FfOpYpFPC5dDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 215B413687;
 Fri, 28 Aug 2026 15:58:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KFHGOD2wkWpoBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 28 Aug 2026 15:58:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Aadeshveer Singh <aadeshveer07@gmail.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL v2 04/30] migration: Use file_bmap for RAMBlock during incoming
 file load
Date: Fri, 28 Aug 2026 12:58:19 -0300
Message-ID: <20260828155845.2874508-5-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828155845.2874508-1-farosas@suse.de>
References: <20260828155845.2874508-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8216F221E6
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_CC(0.00)[redhat.com,gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Aadeshveer Singh <aadeshveer07@gmail.com>

Replace the temporary bitmap with the existing file_bmap attribute of
the RAMBlock. This acts as a preparatory change for the upcoming fast
snapshot load feature.

Reusing this bitmap allows the destination to track page types during
a postcopy load, enabling faster, direct placement of zero pages.

Since file_bmap is currently only utilized during the migration save
phase, it can be safely repurposed during the load phase without
introducing conflicts.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index b6eb842746a..7fa4774246a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -252,6 +252,17 @@ int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque)
     return ret;
 }
 
+static void ramblock_file_bmap_init(void)
+{
+    RAMBlock *rb;
+
+    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
+        assert(!rb->file_bmap);
+        size_t size = rb->max_length >> qemu_target_page_bits();
+        rb->file_bmap = bitmap_new(size);
+    }
+}
+
 static void ramblock_recv_map_init(void)
 {
     RAMBlock *rb;
@@ -3755,6 +3766,9 @@ static int ram_load_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     xbzrle_load_setup();
     ramblock_recv_map_init();
+    if (migrate_mapped_ram()) {
+        ramblock_file_bmap_init();
+    }
 
     return 0;
 }
@@ -3772,8 +3786,8 @@ static int ram_load_cleanup(void *opaque)
     xbzrle_load_cleanup();
 
     RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
-        g_free(rb->receivedmap);
-        rb->receivedmap = NULL;
+        g_clear_pointer(&rb->receivedmap, g_free);
+        g_clear_pointer(&rb->file_bmap, g_free);
     }
 
     return 0;
@@ -4148,11 +4162,18 @@ err:
 static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
                                       ram_addr_t length, Error **errp)
 {
-    g_autofree unsigned long *bitmap = NULL;
     MappedRamHeader header;
     size_t bitmap_size;
     long num_pages;
 
+    if (length > block->max_length) {
+        error_setg(errp,
+                   "mapped-ram header length %" PRIu64 " exceeds "
+                   "RAMBlock(\"%s\") max_length %" PRIu64,
+                   (uint64_t)length, block->idstr, (uint64_t)block->max_length);
+        return;
+    }
+
     if (!mapped_ram_read_header(f, &header, errp)) {
         return;
     }
@@ -4180,14 +4201,14 @@ static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
     num_pages = length / header.page_size;
     bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);
 
-    bitmap = g_malloc0(bitmap_size);
-    if (qemu_get_buffer_at(f, (uint8_t *)bitmap, bitmap_size,
+    if (qemu_get_buffer_at(f, (uint8_t *)block->file_bmap, bitmap_size,
                            header.bitmap_offset) != bitmap_size) {
         error_setg(errp, "Error reading dirty bitmap");
         return;
     }
 
-    if (!read_ramblock_mapped_ram(f, block, num_pages, bitmap, errp)) {
+    if (!read_ramblock_mapped_ram(f, block, num_pages, block->file_bmap,
+                                  errp)) {
         return;
     }
 
-- 
2.53.0


