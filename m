Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2457BE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDuH-0001O8-GG; Fri, 10 Jan 2025 07:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuF-0001Nb-SB
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:27 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuE-0003Jp-8T
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:27 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D018F210F2;
 Fri, 10 Jan 2025 12:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cT9esyw+BKO4BqKIxEXGP//k3pojL0kRa7xVgzl6K0Y=;
 b=teO6I02LVScLJ+RTRoTJotLNMQY4tGp3tbLDlxpN2TaTwPje9TabaEaXrChIomsdYbwUtE
 xR78dgrL7IRp6+KLWA9wH0VvGFQ2lr86MRN9JtYDqApqrXuxmayTuImxkodYslVL7t46dq
 FXBKmVR64Ve4bdvOqY/+tNL62sNbUN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511264;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cT9esyw+BKO4BqKIxEXGP//k3pojL0kRa7xVgzl6K0Y=;
 b=5dCSFMkII1Qn/CT5W4SJ44io2Ld6KDfydSmhs45LPmxNrv51zbY5sv2kr26eoDCVU74aY4
 MEuxwDIG6V3CEGDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cT9esyw+BKO4BqKIxEXGP//k3pojL0kRa7xVgzl6K0Y=;
 b=teO6I02LVScLJ+RTRoTJotLNMQY4tGp3tbLDlxpN2TaTwPje9TabaEaXrChIomsdYbwUtE
 xR78dgrL7IRp6+KLWA9wH0VvGFQ2lr86MRN9JtYDqApqrXuxmayTuImxkodYslVL7t46dq
 FXBKmVR64Ve4bdvOqY/+tNL62sNbUN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511264;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cT9esyw+BKO4BqKIxEXGP//k3pojL0kRa7xVgzl6K0Y=;
 b=5dCSFMkII1Qn/CT5W4SJ44io2Ld6KDfydSmhs45LPmxNrv51zbY5sv2kr26eoDCVU74aY4
 MEuxwDIG6V3CEGDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9A5413A86;
 Fri, 10 Jan 2025 12:14:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kPFMJx8PgWdURwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 10 Jan 2025 12:14:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 05/25] migration/multifd: Unify RAM_SAVE_FLAG_MULTIFD_FLUSH
 messages
Date: Fri, 10 Jan 2025 09:13:53 -0300
Message-Id: <20250110121413.12336-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250110121413.12336-1-farosas@suse.de>
References: <20250110121413.12336-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
index 01521de71f..ef683d11f0 100644
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


