Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C718DC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 15:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfLlH-0006is-70; Wed, 28 Feb 2024 10:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLlF-0006ib-12
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:22:21 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLlA-0005IE-PZ
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:22:20 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7F49A1F796;
 Wed, 28 Feb 2024 15:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1X3EezqjeCVRYuQM0D38G10EkSktz2EOdCPnYICKyCo=;
 b=PK6j34o+jiv4v4wrhZtl9Pw6QDqooTrLgHS0oCkcIUCVFI1RqlHCCUX1SlgRGD+uT0K2nf
 shv8I0/8+DSbZCk8ZqE5KNVgNoJ9TQ0E8QmRCFtt8Zr3xnmFR/t+xtB6Zl2fDAVx0yaxVV
 +4ujV4ak6LKpQMlL34ULvtux05owQ70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133734;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1X3EezqjeCVRYuQM0D38G10EkSktz2EOdCPnYICKyCo=;
 b=ehp5O1T/YcoEoGUJQJYYHdtBfW6J4B6WdnJCjrpmf4DBYziPPPpjtKng+7RBCXzMZALrLk
 h27M95gpdP819+AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1X3EezqjeCVRYuQM0D38G10EkSktz2EOdCPnYICKyCo=;
 b=PK6j34o+jiv4v4wrhZtl9Pw6QDqooTrLgHS0oCkcIUCVFI1RqlHCCUX1SlgRGD+uT0K2nf
 shv8I0/8+DSbZCk8ZqE5KNVgNoJ9TQ0E8QmRCFtt8Zr3xnmFR/t+xtB6Zl2fDAVx0yaxVV
 +4ujV4ak6LKpQMlL34ULvtux05owQ70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133734;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1X3EezqjeCVRYuQM0D38G10EkSktz2EOdCPnYICKyCo=;
 b=ehp5O1T/YcoEoGUJQJYYHdtBfW6J4B6WdnJCjrpmf4DBYziPPPpjtKng+7RBCXzMZALrLk
 h27M95gpdP819+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDD4613A5D;
 Wed, 28 Feb 2024 15:22:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oJrYKKRP32UPAwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Feb 2024 15:22:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v5 19/23] migration/multifd: Prepare multifd sync for
 mapped-ram migration
Date: Wed, 28 Feb 2024 12:21:23 -0300
Message-Id: <20240228152127.18769-20-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240228152127.18769-1-farosas@suse.de>
References: <20240228152127.18769-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PK6j34o+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="ehp5O1T/"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 7F49A1F796
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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
- skipped all FLUSH flags
- added invalid flags
- skipped EOS
---
 migration/ram.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 18620784c6..250dcd110c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1368,8 +1368,11 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
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
@@ -3111,7 +3114,8 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
         return ret;
     }
 
-    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
+    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()
+        && !migrate_mapped_ram()) {
         qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
     }
 
@@ -3334,7 +3338,8 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
+    if (migrate_multifd() && !migrate_multifd_flush_after_each_section() &&
+        !migrate_mapped_ram()) {
         qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
     }
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
@@ -4137,6 +4142,12 @@ static int ram_load_precopy(QEMUFile *f)
         invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
     }
 
+    if (migrate_mapped_ram()) {
+        invalid_flags |= (RAM_SAVE_FLAG_EOS | RAM_SAVE_FLAG_HOOK |
+                          RAM_SAVE_FLAG_MULTIFD_FLUSH | RAM_SAVE_FLAG_PAGE |
+                          RAM_SAVE_FLAG_XBZRLE | RAM_SAVE_FLAG_ZERO);
+    }
+
     while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
         ram_addr_t addr;
         void *host = NULL, *host_bak = NULL;
@@ -4158,6 +4169,13 @@ static int ram_load_precopy(QEMUFile *f)
         addr &= TARGET_PAGE_MASK;
 
         if (flags & invalid_flags) {
+            if (invalid_flags & RAM_SAVE_FLAG_EOS) {
+                /* EOS is always present, just ignore it */
+                continue;
+            }
+
+            error_report("Unexpected RAM flags: %d", flags & invalid_flags);
+
             if (flags & invalid_flags & RAM_SAVE_FLAG_COMPRESS_PAGE) {
                 error_report("Received an unexpected compressed page");
             }
-- 
2.35.3


