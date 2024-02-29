Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9976C54E49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfiNM-0005oi-Mc; Thu, 29 Feb 2024 10:31:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfiNI-0005hs-HA
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:31:08 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfiNF-00062C-L3
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:31:07 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 73DD41F7F9;
 Thu, 29 Feb 2024 15:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709220664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=noZ1McYbhZV75JxMGEAyyIZFvhxqU9ZQ7hLfOheZmC4=;
 b=0iEMTVwxjOxiGmKiJk1vwgvcJzd3Y3I3bckGcVcIZ4ccDisfV1Z0sDX97nKppfjLexROFq
 8aonV9jbJa0l3lEHeWnQi3dsEoL/qNfGrxRLp98Hityo6dyJg3kTa/vGH+5/yGIxPGcuK7
 Zt/esAioOop+lMs64MkUDWjrRcJu2Lg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709220664;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=noZ1McYbhZV75JxMGEAyyIZFvhxqU9ZQ7hLfOheZmC4=;
 b=8rzJWr4QO+wJ+Li54cY4Zuux3VDT/we8CGOcNKpWviK+TKF1xOX1yRRvIvE0R4N6wnfGMR
 EFUWoBjz97WU8/Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709220664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=noZ1McYbhZV75JxMGEAyyIZFvhxqU9ZQ7hLfOheZmC4=;
 b=0iEMTVwxjOxiGmKiJk1vwgvcJzd3Y3I3bckGcVcIZ4ccDisfV1Z0sDX97nKppfjLexROFq
 8aonV9jbJa0l3lEHeWnQi3dsEoL/qNfGrxRLp98Hityo6dyJg3kTa/vGH+5/yGIxPGcuK7
 Zt/esAioOop+lMs64MkUDWjrRcJu2Lg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709220664;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=noZ1McYbhZV75JxMGEAyyIZFvhxqU9ZQ7hLfOheZmC4=;
 b=8rzJWr4QO+wJ+Li54cY4Zuux3VDT/we8CGOcNKpWviK+TKF1xOX1yRRvIvE0R4N6wnfGMR
 EFUWoBjz97WU8/Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D121513503;
 Thu, 29 Feb 2024 15:31:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gAR5JTaj4GU/MAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 29 Feb 2024 15:31:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v6 19/23] migration/multifd: Prepare multifd sync for
 mapped-ram migration
Date: Thu, 29 Feb 2024 12:30:13 -0300
Message-Id: <20240229153017.2221-20-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240229153017.2221-1-farosas@suse.de>
References: <20240229153017.2221-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0iEMTVwx;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8rzJWr4Q
X-Spamd-Result: default: False [1.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 73DD41F7F9
X-Spamd-Bar: +
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

The mapped-ram migration can be performed live or non-live, but it is
always asynchronous, i.e. the source machine and the destination
machine are not migrating at the same time. We only need some pieces
of the multifd sync operations.

multifd_send_sync_main()
------------------------
  Issued by the ram migration code on the migration thread, causes the
  multifd send channels to synchronize with the migration thread and
  makes the sending side emit a packet with the MULTIFD_FLUSH flag.

  With mapped-ram we want to maintain the sync on the sending side
  because that provides ordering between the rounds of dirty pages when
  migrating live.

MULTIFD_FLUSH
-------------
  On the receiving side, the presence of the MULTIFD_FLUSH flag on a
  packet causes the receiving channels to start synchronizing with the
  main thread.

  We're not using packets with mapped-ram, so there's no MULTIFD_FLUSH
  flag and therefore no channel sync on the receiving side.

multifd_recv_sync_main()
------------------------
  Issued by the migration thread when the ram migration flag
  RAM_SAVE_FLAG_MULTIFD_FLUSH is received, causes the migration thread
  on the receiving side to start synchronizing with the recv
  channels. Due to compatibility, this is also issued when
  RAM_SAVE_FLAG_EOS is received.

  For mapped-ram we only need to synchronize the channels at the end of
  migration to avoid doing cleanup before the channels have finished
  their IO.

Make sure the multifd syncs are only issued at the appropriate times.

Note that due to pre-existing backward compatibility issues, we have
the multifd_flush_after_each_section property that can cause a sync to
happen at EOS. Since the EOS flag is needed on the stream, allow
mapped-ram to just ignore it.

Also emit an error if any other unexpected flags are found on the
stream.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- skipped the flush at ram_save_iterate
- added a mapped-ram guard at find_dirty_block
- moved EOS skip to the switch statement
- added flush after parse_ramblocks
---
 migration/ram.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 18620784c6..329153d97d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1362,14 +1362,18 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
         pss->block = QLIST_NEXT_RCU(pss->block, next);
         if (!pss->block) {
             if (migrate_multifd() &&
-                !migrate_multifd_flush_after_each_section()) {
+                (!migrate_multifd_flush_after_each_section() ||
+                 migrate_mapped_ram())) {
                 QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
                 int ret = multifd_send_sync_main();
                 if (ret < 0) {
                     return ret;
                 }
-                qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
-                qemu_fflush(f);
+
+                if (!migrate_mapped_ram()) {
+                    qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
+                    qemu_fflush(f);
+                }
             }
             /*
              * If memory migration starts over, we will meet a dirtied page
@@ -3111,7 +3115,8 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
         return ret;
     }
 
-    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
+    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()
+        && !migrate_mapped_ram()) {
         qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
     }
 
@@ -3242,7 +3247,8 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 out:
     if (ret >= 0
         && migration_is_setup_or_active(migrate_get_current()->state)) {
-        if (migrate_multifd() && migrate_multifd_flush_after_each_section()) {
+        if (migrate_multifd() && migrate_multifd_flush_after_each_section() &&
+            !migrate_mapped_ram()) {
             ret = multifd_send_sync_main();
             if (ret < 0) {
                 return ret;
@@ -3334,7 +3340,8 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
+    if (migrate_multifd() && !migrate_multifd_flush_after_each_section() &&
+        !migrate_mapped_ram()) {
         qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
     }
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
@@ -4137,6 +4144,12 @@ static int ram_load_precopy(QEMUFile *f)
         invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
     }
 
+    if (migrate_mapped_ram()) {
+        invalid_flags |= (RAM_SAVE_FLAG_HOOK | RAM_SAVE_FLAG_MULTIFD_FLUSH |
+                          RAM_SAVE_FLAG_PAGE | RAM_SAVE_FLAG_XBZRLE |
+                          RAM_SAVE_FLAG_ZERO);
+    }
+
     while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
         ram_addr_t addr;
         void *host = NULL, *host_bak = NULL;
@@ -4158,6 +4171,8 @@ static int ram_load_precopy(QEMUFile *f)
         addr &= TARGET_PAGE_MASK;
 
         if (flags & invalid_flags) {
+            error_report("Unexpected RAM flags: %d", flags & invalid_flags);
+
             if (flags & invalid_flags & RAM_SAVE_FLAG_COMPRESS_PAGE) {
                 error_report("Received an unexpected compressed page");
             }
@@ -4210,6 +4225,10 @@ static int ram_load_precopy(QEMUFile *f)
         switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
         case RAM_SAVE_FLAG_MEM_SIZE:
             ret = parse_ramblocks(f, addr);
+
+            if (migrate_mapped_ram()) {
+                multifd_recv_sync_main();
+            }
             break;
 
         case RAM_SAVE_FLAG_ZERO:
@@ -4250,7 +4269,12 @@ static int ram_load_precopy(QEMUFile *f)
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
             if (migrate_multifd() &&
-                migrate_multifd_flush_after_each_section()) {
+                migrate_multifd_flush_after_each_section() &&
+                /*
+                 * Mapped-ram migration flushes once and for all after
+                 * parsing ramblocks. Always ignore EOS for it.
+                 */
+                !migrate_mapped_ram()) {
                 multifd_recv_sync_main();
             }
             break;
-- 
2.35.3


