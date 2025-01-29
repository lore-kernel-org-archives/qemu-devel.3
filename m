Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBA4C02194
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAXZ-0006E4-4M; Wed, 29 Jan 2025 11:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAWP-0004By-1O
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:33 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAWM-0005Rj-S8
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:32 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A2C631F38C;
 Wed, 29 Jan 2025 16:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+9TPyvjnE3kDrY7MJFLMeXGUdl4urV7i313lRCU8Acc=;
 b=1WKUoo/EKYAEcFLAf3/Wd3ItMa2SYsPjgMHoTV3M7ey05s38enNxVfEAd0K/L7G6Ckq//O
 54Z5kh+nEEj910zrs45YE/BDykJ+90LN4texQDU49ZT2f2Ryzh4eJGNtyiJ6bwkypJ2RJQ
 4/ap83nkZ9W9t2+nbb8XcMhaFgqEr4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166549;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+9TPyvjnE3kDrY7MJFLMeXGUdl4urV7i313lRCU8Acc=;
 b=CvBqu4FnB57KVRMw4j8XLg8CqxeoMs9v85Au+/JCIBlBnOqyE7ta5RG3bPrjFVxyM15km4
 DBGkwWFHlUSoWNDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="1WKUoo/E";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CvBqu4Fn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+9TPyvjnE3kDrY7MJFLMeXGUdl4urV7i313lRCU8Acc=;
 b=1WKUoo/EKYAEcFLAf3/Wd3ItMa2SYsPjgMHoTV3M7ey05s38enNxVfEAd0K/L7G6Ckq//O
 54Z5kh+nEEj910zrs45YE/BDykJ+90LN4texQDU49ZT2f2Ryzh4eJGNtyiJ6bwkypJ2RJQ
 4/ap83nkZ9W9t2+nbb8XcMhaFgqEr4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166549;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+9TPyvjnE3kDrY7MJFLMeXGUdl4urV7i313lRCU8Acc=;
 b=CvBqu4FnB57KVRMw4j8XLg8CqxeoMs9v85Au+/JCIBlBnOqyE7ta5RG3bPrjFVxyM15km4
 DBGkwWFHlUSoWNDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D47E137DB;
 Wed, 29 Jan 2025 16:02:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8Fa7BxRRmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:02:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 42/42] migration: refactor ram_save_target_page functions
Date: Wed, 29 Jan 2025 13:00:59 -0300
Message-Id: <20250129160059.6987-43-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A2C631F38C
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Prasad Pandit <pjp@fedoraproject.org>

Refactor ram_save_target_page legacy and multifd
functions into one. Other than simplifying it,
it frees 'migration_ops' object from usage, so it
is expunged.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20250127120823.144949-3-ppandit@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/ram.c | 67 +++++++++++++------------------------------------
 1 file changed, 17 insertions(+), 50 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5aace00bf1..6f460fd22d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -448,13 +448,6 @@ void ram_transferred_add(uint64_t bytes)
     }
 }
 
-struct MigrationOps {
-    int (*ram_save_target_page)(RAMState *rs, PageSearchStatus *pss);
-};
-typedef struct MigrationOps MigrationOps;
-
-MigrationOps *migration_ops;
-
 static int ram_save_host_page_urgent(PageSearchStatus *pss);
 
 /* NOTE: page is the PFN not real ram_addr_t. */
@@ -1960,55 +1953,36 @@ int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len,
 }
 
 /**
- * ram_save_target_page_legacy: save one target page
- *
- * Returns the number of pages written
+ * ram_save_target_page: save one target page to the precopy thread
+ * OR to multifd workers.
  *
  * @rs: current RAM state
  * @pss: data about the page we want to send
  */
-static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
+static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
 {
     ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
     int res;
 
+    if (!migrate_multifd()
+        || migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
+        if (save_zero_page(rs, pss, offset)) {
+            return 1;
+        }
+    }
+
+    if (migrate_multifd()) {
+        RAMBlock *block = pss->block;
+        return ram_save_multifd_page(block, offset);
+    }
+
     if (control_save_page(pss, offset, &res)) {
         return res;
     }
 
-    if (save_zero_page(rs, pss, offset)) {
-        return 1;
-    }
-
     return ram_save_page(rs, pss);
 }
 
-/**
- * ram_save_target_page_multifd: send one target page to multifd workers
- *
- * Returns 1 if the page was queued, -1 otherwise.
- *
- * @rs: current RAM state
- * @pss: data about the page we want to send
- */
-static int ram_save_target_page_multifd(RAMState *rs, PageSearchStatus *pss)
-{
-    RAMBlock *block = pss->block;
-    ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
-
-    /*
-     * While using multifd live migration, we still need to handle zero
-     * page checking on the migration main thread.
-     */
-    if (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
-        if (save_zero_page(rs, pss, offset)) {
-            return 1;
-        }
-    }
-
-    return ram_save_multifd_page(block, offset);
-}
-
 /* Should be called before sending a host page */
 static void pss_host_page_prepare(PageSearchStatus *pss)
 {
@@ -2095,7 +2069,7 @@ static int ram_save_host_page_urgent(PageSearchStatus *pss)
 
         if (page_dirty) {
             /* Be strict to return code; it must be 1, or what else? */
-            if (migration_ops->ram_save_target_page(rs, pss) != 1) {
+            if (ram_save_target_page(rs, pss) != 1) {
                 error_report_once("%s: ram_save_target_page failed", __func__);
                 ret = -1;
                 goto out;
@@ -2164,7 +2138,7 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss)
             if (preempt_active) {
                 qemu_mutex_unlock(&rs->bitmap_mutex);
             }
-            tmppages = migration_ops->ram_save_target_page(rs, pss);
+            tmppages = ram_save_target_page(rs, pss);
             if (tmppages >= 0) {
                 pages += tmppages;
                 /*
@@ -2362,8 +2336,6 @@ static void ram_save_cleanup(void *opaque)
     xbzrle_cleanup();
     multifd_ram_save_cleanup();
     ram_state_cleanup(rsp);
-    g_free(migration_ops);
-    migration_ops = NULL;
 }
 
 static void ram_state_reset(RAMState *rs)
@@ -3029,13 +3001,8 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
         return ret;
     }
 
-    migration_ops = g_malloc0(sizeof(MigrationOps));
-
     if (migrate_multifd()) {
         multifd_ram_save_setup();
-        migration_ops->ram_save_target_page = ram_save_target_page_multifd;
-    } else {
-        migration_ops->ram_save_target_page = ram_save_target_page_legacy;
     }
 
     /*
-- 
2.35.3


