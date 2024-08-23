Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9E4C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 17:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shYGM-0000j1-QQ; Fri, 23 Aug 2024 13:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shYGC-000094-P4
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:39:43 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shYG9-0008WJ-F8
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:39:38 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 45DD3226F1;
 Fri, 23 Aug 2024 17:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724434776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Jr+HOGkMYcWF2YiEqUGvJYvmhhFs2+ydbQignoNGMA=;
 b=NngcJ5UfxPuBU8NfdrDSRc2w/p4GlZnk/sdmiI2barp8o4RrnGF0xcGDCTGxWrNrS0kkTW
 6FHL7Q55ECnQhxc8wweWayJgfNJBBmRIPfORjk2Gt6YMBTcPtFvE4R3DcNGHJHcs+Tx/TI
 gQ4HOqxyr9TTNjHepmfN752b7Wy3oak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724434776;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Jr+HOGkMYcWF2YiEqUGvJYvmhhFs2+ydbQignoNGMA=;
 b=HVu+OlZrbj3U5ZB1MotbPC+/s8p8j/Wka3FY+V5KKwBvqGYFzKV835RC5ElJYnLFJF1jxh
 cVNhlsBAjxJKdKBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NngcJ5Uf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HVu+OlZr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724434776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Jr+HOGkMYcWF2YiEqUGvJYvmhhFs2+ydbQignoNGMA=;
 b=NngcJ5UfxPuBU8NfdrDSRc2w/p4GlZnk/sdmiI2barp8o4RrnGF0xcGDCTGxWrNrS0kkTW
 6FHL7Q55ECnQhxc8wweWayJgfNJBBmRIPfORjk2Gt6YMBTcPtFvE4R3DcNGHJHcs+Tx/TI
 gQ4HOqxyr9TTNjHepmfN752b7Wy3oak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724434776;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Jr+HOGkMYcWF2YiEqUGvJYvmhhFs2+ydbQignoNGMA=;
 b=HVu+OlZrbj3U5ZB1MotbPC+/s8p8j/Wka3FY+V5KKwBvqGYFzKV835RC5ElJYnLFJF1jxh
 cVNhlsBAjxJKdKBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16BE01333E;
 Fri, 23 Aug 2024 17:39:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6LKQM1bJyGb2LwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Aug 2024 17:39:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v4 13/16] migration/multifd: Allow multifd sync without flush
Date: Fri, 23 Aug 2024 14:39:08 -0300
Message-Id: <20240823173911.6712-14-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240823173911.6712-1-farosas@suse.de>
References: <20240823173911.6712-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 45DD3226F1
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Separate the multifd sync from flushing the client data to the
channels. These two operations are closely related but not strictly
necessary to be executed together.

The multifd sync is intrinsic to how multifd works. The multiple
channels operate independently and may finish IO out of order in
relation to each other. This applies also between the source and
destination QEMU.

Flushing the data that is left in the client-owned data structures
(e.g. MultiFDPages_t) prior to sync is usually the right thing to do,
but that is particular to how the ram migration is implemented with
several passes over dirty data.

Make these two routines separate, allowing future code to call the
sync by itself if needed. This also allows the usage of
multifd_ram_send to be isolated to ram code.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 13 +++++++++----
 migration/multifd.h |  1 +
 migration/ram.c     |  8 ++++----
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index cb7a121eb0..ce08257706 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -914,11 +914,8 @@ static int multifd_zero_copy_flush(QIOChannel *c)
     return ret;
 }
 
-int multifd_send_sync_main(void)
+int multifd_ram_flush_and_sync(void)
 {
-    int i;
-    bool flush_zero_copy;
-
     if (!migrate_multifd()) {
         return 0;
     }
@@ -930,6 +927,14 @@ int multifd_send_sync_main(void)
         }
     }
 
+    return multifd_send_sync_main();
+}
+
+int multifd_send_sync_main(void)
+{
+    int i;
+    bool flush_zero_copy;
+
     flush_zero_copy = migrate_zero_copy_send();
 
     for (i = 0; i < migrate_multifd_channels(); i++) {
diff --git a/migration/multifd.h b/migration/multifd.h
index 5fa384d9af..00c872dfda 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -270,4 +270,5 @@ static inline uint32_t multifd_ram_page_count(void)
 
 void multifd_ram_save_setup(void);
 void multifd_ram_save_cleanup(void);
+int multifd_ram_flush_and_sync(void);
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index 1815b2557b..67ca3d5d51 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1326,7 +1326,7 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
                 (!migrate_multifd_flush_after_each_section() ||
                  migrate_mapped_ram())) {
                 QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
-                int ret = multifd_send_sync_main();
+                int ret = multifd_ram_flush_and_sync();
                 if (ret < 0) {
                     return ret;
                 }
@@ -3066,7 +3066,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
     }
 
     bql_unlock();
-    ret = multifd_send_sync_main();
+    ret = multifd_ram_flush_and_sync();
     bql_lock();
     if (ret < 0) {
         error_setg(errp, "%s: multifd synchronization failed", __func__);
@@ -3213,7 +3213,7 @@ out:
         && migration_is_setup_or_active()) {
         if (migrate_multifd() && migrate_multifd_flush_after_each_section() &&
             !migrate_mapped_ram()) {
-            ret = multifd_send_sync_main();
+            ret = multifd_ram_flush_and_sync();
             if (ret < 0) {
                 return ret;
             }
@@ -3285,7 +3285,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    ret = multifd_send_sync_main();
+    ret = multifd_ram_flush_and_sync();
     if (ret < 0) {
         return ret;
     }
-- 
2.35.3


