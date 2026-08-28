Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE5FC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzyz4-0001MJ-DU; Fri, 28 Aug 2026 11:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyz0-0001Km-Si
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:10 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzyyx-0008Du-FF
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:59:10 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2109022144;
 Fri, 28 Aug 2026 15:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NjkvZi9dCnM5PxlLXQzt4cvVIzMJFOAlxM7emsEzxpY=;
 b=nr14Hy4n/E1U9NPrCi9UgZpxwDvVhc2ogxyPxaJ5TdTV5mTioBayY9Phvd8F8bdCdl0591
 Omfw8Vz72MQdlljWmggnj0RlcKKkbXWe1QxVA/rfoYfi9Uk3zexUPBoh+V2HRH49v6sRym
 MGXfk/pck0j7Qc15nyBhSkYSVAZkR4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NjkvZi9dCnM5PxlLXQzt4cvVIzMJFOAlxM7emsEzxpY=;
 b=YM1hyUiKWf9axe5fcdts8TrmybEkr2n7KicstMX80l9KhY7qFVZleXpcvsLTNH3hGoKxGa
 QpgWQJP69L971OBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tiA0kkkR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yF6HGchB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787932738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NjkvZi9dCnM5PxlLXQzt4cvVIzMJFOAlxM7emsEzxpY=;
 b=tiA0kkkR/FjuZm/BlHhmfeGBdVx4W8LDxTYIKYirB77zKZabQg0xqta95KhRtTxgH5eYQ1
 TSbchsKR7tclzsCy/LOJTmsb3Bt32h21fag+RI0VMx7s44gIPE9Twm6pIoWO3C/g0hOTkp
 DSOPba7XvGheOfaE4z3oq2ntnps1Lvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787932738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NjkvZi9dCnM5PxlLXQzt4cvVIzMJFOAlxM7emsEzxpY=;
 b=yF6HGchBFzl/uQFmHNpXKogxuUQZwz/P8gGN5QXCH8R3X2o1f5SdExNWPHe7Q2l8yMykDL
 ZZQMirvoJOxI59Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 179F813691;
 Fri, 28 Aug 2026 15:58:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8KBlNkCwkWpoBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 28 Aug 2026 15:58:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PULL v2 06/30] migration: add RAMBlock field and helper for fast
 snapshot load
Date: Fri, 28 Aug 2026 12:58:21 -0300
Message-ID: <20260828155845.2874508-7-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828155845.2874508-1-farosas@suse.de>
References: <20260828155845.2874508-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2109022144
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_THREE(0.00)[3];
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

Add pending_bmap field per RAMBlock which is a Bitmap to store
internal state of which pages have been read by some thread to ensure
coordination between fault thread and eager load thread.

Modify parse_ramblock_mapped_ram(), to not load the actual RAMBlocks
data in postcopy case as that will be loaded by fault thread and eager
thread after the VM starts running.

Change ram_load() to use new function ram_should_load_postcopy_pages()
to decide how to load/read RAM.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/system/ramblock.h |  6 ++++
 migration/ram.c           | 66 +++++++++++++++++++++++++++++++++++----
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index f0639287bf0..84624aca2c9 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -60,6 +60,12 @@ struct RAMBlock {
 
     /* Bitmap of already received pages.  Only used on destination side. */
     unsigned long *receivedmap;
+    /*
+     * Bitmap for pages that are yet to be read from disk. It is required for
+     * fault thread and eager thread to keep note of which pages are currently
+     * being read. Used by fast snapshot load.
+     */
+    unsigned long *pending_bmap;
 
     /*
      * bitmap to track already cleared dirty bitmap.  When the bit is
diff --git a/migration/ram.c b/migration/ram.c
index 60ad4352150..b7c406428e2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -263,6 +263,25 @@ static void ramblock_file_bmap_init(void)
     }
 }
 
+static void ramblock_pending_bmap_init(void)
+{
+    RAMBlock *rb;
+
+    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
+        assert(!rb->pending_bmap);
+        /*
+         * The pending_bmap granularity must match the maximum of host and guest
+         * page sizes. This ensures that every load operation checks for one
+         * bit, allowing lockless thread coordination via a single-bit atomic
+         * test-and-clear.
+         */
+        size_t size = rb->max_length /
+                      MAX(qemu_ram_pagesize(rb), qemu_target_page_size());
+        rb->pending_bmap = bitmap_new(size);
+        bitmap_set(rb->pending_bmap, 0, size);
+    }
+}
+
 static void ramblock_recv_map_init(void)
 {
     RAMBlock *rb;
@@ -3768,6 +3787,10 @@ static int ram_load_setup(QEMUFile *f, void *opaque, Error **errp)
     ramblock_recv_map_init();
     if (migrate_mapped_ram()) {
         ramblock_file_bmap_init();
+        if (migrate_postcopy_ram()) {
+            /* fast snapshot load */
+            ramblock_pending_bmap_init();
+        }
     }
 
     return 0;
@@ -3788,6 +3811,7 @@ static int ram_load_cleanup(void *opaque)
     RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
         g_clear_pointer(&rb->receivedmap, g_free);
         g_clear_pointer(&rb->file_bmap, g_free);
+        g_clear_pointer(&rb->pending_bmap, g_free);
     }
 
     return 0;
@@ -4207,9 +4231,12 @@ static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
         return;
     }
 
-    if (!read_ramblock_mapped_ram(f, block, num_pages, block->file_bmap,
-                                  errp)) {
-        return;
+    if (!migrate_postcopy_ram()) {
+        /* Do not load RAM during setup for fast snapshot load */
+        if (!read_ramblock_mapped_ram(f, block, num_pages, block->file_bmap,
+                                      errp)) {
+            return;
+        }
     }
 
     /* Skip pages array */
@@ -4488,15 +4515,42 @@ static int ram_load_precopy(QEMUFile *f)
     return ret;
 }
 
+static bool ram_should_load_postcopy_pages(void)
+{
+    /* This is pure precopy, we don't need to load pages in postcopy way */
+    if (!postcopy_is_running()) {
+        return false;
+    }
+
+    /*
+     * This is postcopy, but when with mapped-ram, pages are not loaded in the
+     * migration stream here, but done separately in a thread eagerly reading
+     * pages from the snapshot.  Here, we only need to read the ram headers,
+     * reusing the precopy code.
+     * TODO: when we have separate function to parse RAM headers we should
+     * switch to that.
+     */
+    if (migrate_mapped_ram()) {
+        return false;
+    }
+
+    /*
+     * Genuine network postcopy, we will load pages in this current stream and
+     * they need to be done in postcopy way.
+     */
+    return true;
+}
+
 static int ram_load(QEMUFile *f, void *opaque, int version_id)
 {
     int ret = 0;
     static uint64_t seq_iter;
     /*
      * If system is running in postcopy mode, page inserts to host memory must
-     * be atomic
+     * be atomic. However, fast snapshot load uses the mapped ram precopy like
+     * path to read block headers and populating bitmaps.
      */
-    bool postcopy_running = postcopy_is_running();
+    bool load_postcopy_pages = ram_should_load_postcopy_pages();
 
     seq_iter++;
 
@@ -4512,7 +4566,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
      */
     trace_ram_load_start();
     WITH_RCU_READ_LOCK_GUARD() {
-        if (postcopy_running) {
+        if (load_postcopy_pages) {
             /*
              * Note!  Here RAM_CHANNEL_PRECOPY is the precopy channel of
              * postcopy migration, we have another RAM_CHANNEL_POSTCOPY to
-- 
2.53.0


