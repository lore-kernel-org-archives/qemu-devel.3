Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56AAC54787
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYow-0004O8-H9; Tue, 20 Feb 2024 17:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYot-0004BC-Le
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:35 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYor-0006Mu-VB
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:35 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BFF852226D;
 Tue, 20 Feb 2024 22:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T38rM69ROJQVSeYZIjGBwQIEL5BPGuUihlczQiACezo=;
 b=cwHgLiroF/31HlEiA2Avkm60PaKPL8rUIixuml9C+HMf6WoJi0eMHe2P2hYUGefaKDmn08
 i6zZiRY+EbACM10I5tRzJ7uX1B0H4bBT+7rwY4bksj+evlU3Xo3OjCmgl51ZKupajiaWym
 caxoDKLJQvDdGhAJTgBn7lZAY7+3a4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468952;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T38rM69ROJQVSeYZIjGBwQIEL5BPGuUihlczQiACezo=;
 b=0RAew5s9p07FZEKUBwO82/6oeSrRdtVsaHulue3ONIcEJ/XDXeUfnW3uEIHhXBQzxmraBC
 uKoyWhxDbmGIFiCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T38rM69ROJQVSeYZIjGBwQIEL5BPGuUihlczQiACezo=;
 b=cwHgLiroF/31HlEiA2Avkm60PaKPL8rUIixuml9C+HMf6WoJi0eMHe2P2hYUGefaKDmn08
 i6zZiRY+EbACM10I5tRzJ7uX1B0H4bBT+7rwY4bksj+evlU3Xo3OjCmgl51ZKupajiaWym
 caxoDKLJQvDdGhAJTgBn7lZAY7+3a4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468952;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T38rM69ROJQVSeYZIjGBwQIEL5BPGuUihlczQiACezo=;
 b=0RAew5s9p07FZEKUBwO82/6oeSrRdtVsaHulue3ONIcEJ/XDXeUfnW3uEIHhXBQzxmraBC
 uKoyWhxDbmGIFiCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F660139D0;
 Tue, 20 Feb 2024 22:42:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kPCKNdYq1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:42:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v4 22/34] migration/multifd: Prepare multifd sync for
 fixed-ram migration
Date: Tue, 20 Feb 2024 19:41:26 -0300
Message-Id: <20240220224138.24759-23-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cwHgLiro;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0RAew5s9
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
X-Rspamd-Queue-Id: BFF852226D
X-Spamd-Bar: +
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

The fixed-ram migration can be performed live or non-live, but it is
always asynchronous, i.e. the source machine and the destination
machine are not migrating at the same time. We only need some pieces
of the multifd sync operations.

multifd_send_sync_main()
------------------------
  Issued by the ram migration code on the migration thread, causes the
  multifd send channels to synchronize with the migration thread and
  makes the sending side emit a packet with the MULTIFD_FLUSH flag.

  With fixed-ram we want to maintain the sync on the sending side
  because that provides ordering between the rounds of dirty pages when
  migrating live.

MULTIFD_FLUSH
-------------
  On the receiving side, the presence of the MULTIFD_FLUSH flag on a
  packet causes the receiving channels to start synchronizing with the
  main thread.

  We're not using packets with fixed-ram, so there's no MULTIFD_FLUSH
  flag and therefore no channel sync on the receiving side.

multifd_recv_sync_main()
------------------------
  Issued by the migration thread when the ram migration flag
  RAM_SAVE_FLAG_MULTIFD_FLUSH is received, causes the migration thread
  on the receiving side to start synchronizing with the recv
  channels. Due to compatibility, this is also issued when
  RAM_SAVE_FLAG_EOS is received.

  For fixed-ram we only need to synchronize the channels at the end of
  migration to avoid doing cleanup before the channels have finished
  their IO.

Make sure the multifd syncs are only issued at the appropriate
times. Note that due to pre-existing backward compatibility issues, we
have the multifd_flush_after_each_section property that enables an
older behavior of synchronizing channels more frequently (and
inefficiently). Fixed-ram should always run with that property
disabled (default).

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5932e1b8e1..c7050f6f68 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1369,8 +1369,11 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
                 if (ret < 0) {
                     return ret;
                 }
-                qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
-                qemu_fflush(f);
+
+                if (!migrate_fixed_ram()) {
+                    qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
+                    qemu_fflush(f);
+                }
             }
             /*
              * If memory migration starts over, we will meet a dirtied page
@@ -3112,7 +3115,8 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
         return ret;
     }
 
-    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
+    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()
+        && !migrate_fixed_ram()) {
         qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
     }
 
@@ -4253,6 +4257,15 @@ static int ram_load_precopy(QEMUFile *f)
             break;
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
+            if (migrate_fixed_ram()) {
+                /*
+                 * The EOS flag appears multiple times on the
+                 * stream. Fixed-ram needs only one sync at the
+                 * end. It will be done on the flush flag above.
+                 */
+                break;
+            }
+
             if (migrate_multifd() &&
                 migrate_multifd_flush_after_each_section()) {
                 multifd_recv_sync_main();
-- 
2.35.3


