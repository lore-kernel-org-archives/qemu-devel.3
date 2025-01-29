Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BF5C02193
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAWV-0004Sa-27; Wed, 29 Jan 2025 11:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAW0-0003Y8-A1
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:11 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVy-0005NA-B3
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:08 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2AAEA210F9;
 Wed, 29 Jan 2025 16:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bz2X1Ng/UOKlgvXiz8YFkvu7ufXJHZOTKdxGOmIPJxQ=;
 b=ujfMyhWxfCHqDziUgtCSqnJarE9a47QtDWBEB5PA7M1yYQrDBhZMPdP4qldsY37kLOKZB1
 av7B0ZIim1cHecwxWS83w29QLHrCY9qtPbkKHDXMCgvKa0wL+1RBOhuxing5swNhWM6x6d
 xTRbZ9IH6cyWYSu/dlH551SeH71zLrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166525;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bz2X1Ng/UOKlgvXiz8YFkvu7ufXJHZOTKdxGOmIPJxQ=;
 b=6iI5BdlWrOa0pQc1pb+xJ/2wIr9RMTYTwei8QbHc5z/4ESdUUP5dQbEXRSVHmbPQr/dlVV
 6VAbO56S+RnO45Bg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ujfMyhWx;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6iI5BdlW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bz2X1Ng/UOKlgvXiz8YFkvu7ufXJHZOTKdxGOmIPJxQ=;
 b=ujfMyhWxfCHqDziUgtCSqnJarE9a47QtDWBEB5PA7M1yYQrDBhZMPdP4qldsY37kLOKZB1
 av7B0ZIim1cHecwxWS83w29QLHrCY9qtPbkKHDXMCgvKa0wL+1RBOhuxing5swNhWM6x6d
 xTRbZ9IH6cyWYSu/dlH551SeH71zLrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166525;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bz2X1Ng/UOKlgvXiz8YFkvu7ufXJHZOTKdxGOmIPJxQ=;
 b=6iI5BdlWrOa0pQc1pb+xJ/2wIr9RMTYTwei8QbHc5z/4ESdUUP5dQbEXRSVHmbPQr/dlVV
 6VAbO56S+RnO45Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A18713AA6;
 Wed, 29 Jan 2025 16:02:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6CPEFvtQmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:02:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 30/42] migration: Drop inactivate_disk param in
 qemu_savevm_state_complete*
Date: Wed, 29 Jan 2025 13:00:47 -0300
Message-Id: <20250129160059.6987-31-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2AAEA210F9
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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

This parameter is only used by one caller, which is the genuine precopy
complete path (migration_completion_precopy).

The parameter was introduced in a1fbe750fd ("migration: Fix race of image
locking between src and dst") to make sure the inactivate will happen
before EOF to make sure dest will always be able to activate the disk
properly.  However there's no limitation on how early we inactivate the
disk.  For precopy completion path, we can always do that as long as VM is
stopped.

Move the disk inactivate there, then we can remove this inactivate_disk
parameter in the whole call stack, because all the rest users pass in false
always.

Signed-off-by: Peter Xu <peterx@redhat.com>
Tested-by: Jiri Denemark <jdenemar@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20250114230746.3268797-6-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 24 +++++++++++++++++-------
 migration/savevm.c    | 27 +++++----------------------
 migration/savevm.h    |  5 ++---
 3 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 07b6b730b7..d8a6bc12e0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2682,7 +2682,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      * Cause any non-postcopiable, but iterative devices to
      * send out their final data.
      */
-    qemu_savevm_state_complete_precopy(ms->to_dst_file, true, false);
+    qemu_savevm_state_complete_precopy(ms->to_dst_file, true);
 
     /*
      * in Finish migrate and with the io-lock held everything should
@@ -2727,7 +2727,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      */
     qemu_savevm_send_postcopy_listen(fb);
 
-    qemu_savevm_state_complete_precopy(fb, false, false);
+    qemu_savevm_state_complete_precopy(fb, false);
     if (migrate_postcopy_ram()) {
         qemu_savevm_send_ping(fb, 3);
     }
@@ -2859,11 +2859,21 @@ static int migration_completion_precopy(MigrationState *s,
         goto out_unlock;
     }
 
-    migration_rate_set(RATE_LIMIT_DISABLED);
-
     /* Inactivate disks except in COLO */
-    ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
-                                             !migrate_colo());
+    if (!migrate_colo()) {
+        /*
+         * Inactivate before sending QEMU_VM_EOF so that the
+         * bdrv_activate_all() on the other end won't fail.
+         */
+        if (!migration_block_inactivate()) {
+            ret = -EFAULT;
+            goto out_unlock;
+        }
+    }
+
+    migration_rate_set(RATE_LIMIT_DISABLED);
+
+    ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false);
 out_unlock:
     bql_unlock();
     return ret;
@@ -3744,7 +3754,7 @@ static void *bg_migration_thread(void *opaque)
      * save their state to channel-buffer along with devices.
      */
     cpu_synchronize_all_states();
-    if (qemu_savevm_state_complete_precopy_non_iterable(fb, false, false)) {
+    if (qemu_savevm_state_complete_precopy_non_iterable(fb, false)) {
         goto fail;
     }
     /*
diff --git a/migration/savevm.c b/migration/savevm.c
index cfe9dfaf5c..5e56a5d9fc 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1521,8 +1521,7 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
 }
 
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
-                                                    bool in_postcopy,
-                                                    bool inactivate_disks)
+                                                    bool in_postcopy)
 {
     MigrationState *ms = migrate_get_current();
     int64_t start_ts_each, end_ts_each;
@@ -1553,20 +1552,6 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
                                     end_ts_each - start_ts_each);
     }
 
-    if (inactivate_disks) {
-        /*
-         * Inactivate before sending QEMU_VM_EOF so that the
-         * bdrv_activate_all() on the other end won't fail.
-         */
-        if (!migration_block_inactivate()) {
-            error_setg(&local_err, "%s: bdrv_inactivate_all() failed",
-                       __func__);
-            migrate_set_error(ms, local_err);
-            error_report_err(local_err);
-            qemu_file_set_error(f, -EFAULT);
-            return -1;
-        }
-    }
     if (!in_postcopy) {
         /* Postcopy stream will still be going */
         qemu_put_byte(f, QEMU_VM_EOF);
@@ -1587,8 +1572,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     return 0;
 }
 
-int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
-                                       bool inactivate_disks)
+int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
 {
     int ret;
     Error *local_err = NULL;
@@ -1613,8 +1597,7 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
         goto flush;
     }
 
-    ret = qemu_savevm_state_complete_precopy_non_iterable(f, in_postcopy,
-                                                          inactivate_disks);
+    ret = qemu_savevm_state_complete_precopy_non_iterable(f, in_postcopy);
     if (ret) {
         return ret;
     }
@@ -1717,7 +1700,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
 
     ret = qemu_file_get_error(f);
     if (ret == 0) {
-        qemu_savevm_state_complete_precopy(f, false, false);
+        qemu_savevm_state_complete_precopy(f, false);
         ret = qemu_file_get_error(f);
     }
     if (ret != 0) {
@@ -1743,7 +1726,7 @@ cleanup:
 void qemu_savevm_live_state(QEMUFile *f)
 {
     /* save QEMU_VM_SECTION_END section */
-    qemu_savevm_state_complete_precopy(f, true, false);
+    qemu_savevm_state_complete_precopy(f, true);
     qemu_put_byte(f, QEMU_VM_EOF);
 }
 
diff --git a/migration/savevm.h b/migration/savevm.h
index 9ec96a995c..c48a53e95e 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -39,8 +39,7 @@ void qemu_savevm_state_header(QEMUFile *f);
 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
 void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
-int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
-                                       bool inactivate_disks);
+int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only);
 void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
                                      uint64_t *can_postcopy);
 void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
@@ -68,6 +67,6 @@ int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
 int qemu_load_device_state(QEMUFile *f);
 int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
-        bool in_postcopy, bool inactivate_disks);
+        bool in_postcopy);
 
 #endif
-- 
2.35.3


