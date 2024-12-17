Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E71E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbhC-0005rp-3f; Tue, 17 Dec 2024 12:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNbgz-0005nE-SU
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:49:10 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNbgx-0007cs-7u
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:49:08 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0EBFD1F394;
 Tue, 17 Dec 2024 17:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734457746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C7ju9WUYUrhtDIHb6GxJtHHmdbvNh6h1pBtWTdgYnOI=;
 b=eJALIosV/bQejzz9g0w9KbVB7//enSZIt/nxCXHt+cWcVrwKP1nz5Se27EwEyE1yGO4StI
 0g/b+uX6AZIC5n7HWs99bwCgp9PZy1ipSg9c++Dder84Tadh346f2prECYdQ+35LmhPGyr
 lIZY+WioJL56ByzUv0WFBizXidMTWYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734457746;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C7ju9WUYUrhtDIHb6GxJtHHmdbvNh6h1pBtWTdgYnOI=;
 b=1axILWL9PXq//l8pputGu/Kse1eJDAXnhiMU1lBrjfqcoyrvmgXBCoNmEMVNMvv3OGrDOZ
 H6UKsdMvL+K02yCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eJALIosV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1axILWL9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734457746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C7ju9WUYUrhtDIHb6GxJtHHmdbvNh6h1pBtWTdgYnOI=;
 b=eJALIosV/bQejzz9g0w9KbVB7//enSZIt/nxCXHt+cWcVrwKP1nz5Se27EwEyE1yGO4StI
 0g/b+uX6AZIC5n7HWs99bwCgp9PZy1ipSg9c++Dder84Tadh346f2prECYdQ+35LmhPGyr
 lIZY+WioJL56ByzUv0WFBizXidMTWYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734457746;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C7ju9WUYUrhtDIHb6GxJtHHmdbvNh6h1pBtWTdgYnOI=;
 b=1axILWL9PXq//l8pputGu/Kse1eJDAXnhiMU1lBrjfqcoyrvmgXBCoNmEMVNMvv3OGrDOZ
 H6UKsdMvL+K02yCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B6F613A3C;
 Tue, 17 Dec 2024 17:49:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yO92MJC5YWd1TwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Dec 2024 17:49:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 05/17] migration/multifd: Unify RAM_SAVE_FLAG_MULTIFD_FLUSH
 messages
Date: Tue, 17 Dec 2024 14:48:43 -0300
Message-Id: <20241217174855.24971-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241217174855.24971-1-farosas@suse.de>
References: <20241217174855.24971-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0EBFD1F394
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Peter Xu <peterx@redhat.com>

RAM_SAVE_FLAG_MULTIFD_FLUSH message should always be correlated to a sync
request on src.  Unify such message into one place, and conditionally send
the message only if necessary.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20241206224755.1108686-5-peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-nocomp.c | 27 +++++++++++++++++++++++++--
 migration/multifd.h        |  2 +-
 migration/ram.c            | 18 ++++--------------
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index 219f9e58ef..58372db0f4 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -20,6 +20,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "trace.h"
+#include "qemu-file.h"
 
 static MultiFDSendData *multifd_ram_send;
 
@@ -343,9 +344,10 @@ retry:
     return true;
 }
 
-int multifd_ram_flush_and_sync(void)
+int multifd_ram_flush_and_sync(QEMUFile *f)
 {
     MultiFDSyncReq req;
+    int ret;
 
     if (!migrate_multifd()) {
         return 0;
@@ -361,7 +363,28 @@ int multifd_ram_flush_and_sync(void)
     /* File migrations only need to sync with threads */
     req = migrate_mapped_ram() ? MULTIFD_SYNC_LOCAL : MULTIFD_SYNC_ALL;
 
-    return multifd_send_sync_main(req);
+    ret = multifd_send_sync_main(req);
+    if (ret) {
+        return ret;
+    }
+
+    /* If we don't need to sync with remote at all, nothing else to do */
+    if (req == MULTIFD_SYNC_LOCAL) {
+        return 0;
+    }
+
+    /*
+     * Old QEMUs don't understand RAM_SAVE_FLAG_MULTIFD_FLUSH, it relies
+     * on RAM_SAVE_FLAG_EOS instead.
+     */
+    if (migrate_multifd_flush_after_each_section()) {
+        return 0;
+    }
+
+    qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
+    qemu_fflush(f);
+
+    return 0;
 }
 
 bool multifd_send_prepare_common(MultiFDSendParams *p)
diff --git a/migration/multifd.h b/migration/multifd.h
index 6493512305..0fef431f6b 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -354,7 +354,7 @@ static inline uint32_t multifd_ram_page_count(void)
 
 void multifd_ram_save_setup(void);
 void multifd_ram_save_cleanup(void);
-int multifd_ram_flush_and_sync(void);
+int multifd_ram_flush_and_sync(QEMUFile *f);
 size_t multifd_ram_payload_size(void);
 void multifd_ram_fill_packet(MultiFDSendParams *p);
 int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp);
diff --git a/migration/ram.c b/migration/ram.c
index 44010ff325..90811aabd4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1306,15 +1306,10 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
                 (!migrate_multifd_flush_after_each_section() ||
                  migrate_mapped_ram())) {
                 QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
-                int ret = multifd_ram_flush_and_sync();
+                int ret = multifd_ram_flush_and_sync(f);
                 if (ret < 0) {
                     return ret;
                 }
-
-                if (!migrate_mapped_ram()) {
-                    qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
-                    qemu_fflush(f);
-                }
             }
 
             /* Hit the end of the list */
@@ -3044,18 +3039,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
     }
 
     bql_unlock();
-    ret = multifd_ram_flush_and_sync();
+    ret = multifd_ram_flush_and_sync(f);
     bql_lock();
     if (ret < 0) {
         error_setg(errp, "%s: multifd synchronization failed", __func__);
         return ret;
     }
 
-    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()
-        && !migrate_mapped_ram()) {
-        qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
-    }
-
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     ret = qemu_fflush(f);
     if (ret < 0) {
@@ -3190,7 +3180,7 @@ out:
     if (ret >= 0 && migration_is_running()) {
         if (migrate_multifd() && migrate_multifd_flush_after_each_section() &&
             !migrate_mapped_ram()) {
-            ret = multifd_ram_flush_and_sync();
+            ret = multifd_ram_flush_and_sync(f);
             if (ret < 0) {
                 return ret;
             }
@@ -3268,7 +3258,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
          * Only the old dest QEMU will need this sync, because each EOS
          * will require one SYNC message on each channel.
          */
-        ret = multifd_ram_flush_and_sync();
+        ret = multifd_ram_flush_and_sync(f);
         if (ret < 0) {
             return ret;
         }
-- 
2.35.3


