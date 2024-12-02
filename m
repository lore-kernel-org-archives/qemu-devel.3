Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADC2E69E97
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 22:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIEUK-00075w-9m; Mon, 02 Dec 2024 17:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIEUI-00075D-6K
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 17:01:50 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIEUG-0003c8-JM
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 17:01:49 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5FD5921182;
 Mon,  2 Dec 2024 22:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733176905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ERIkhefWi5WqvYg6rz3y2qvknoGc8ppkoMUD2uu3uw=;
 b=W8VuTXpZTPQPP5g4URweH0IgYOztwdlDWloDecBp1xEjSI9g91S55rAgaNdvypo1TSDhQv
 WPe5vvyydbzFnpj3tXYdTrC7xNDDh2X8uIMJxveX2iEy2aWg99Qjz6borMxumoBkWgnmPs
 RzLJrUPzI9xvznJcUJzWYJJ0E6fLDJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733176905;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ERIkhefWi5WqvYg6rz3y2qvknoGc8ppkoMUD2uu3uw=;
 b=fqgHsPcIx8JSH+dbPHRSOgV4TWvdoi7AZn6WMYkS8KNp+l8rW7ClNMlQccaij8+kDvRyJh
 Hwen3Q2Lq0SsNRBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=W8VuTXpZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fqgHsPcI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733176905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ERIkhefWi5WqvYg6rz3y2qvknoGc8ppkoMUD2uu3uw=;
 b=W8VuTXpZTPQPP5g4URweH0IgYOztwdlDWloDecBp1xEjSI9g91S55rAgaNdvypo1TSDhQv
 WPe5vvyydbzFnpj3tXYdTrC7xNDDh2X8uIMJxveX2iEy2aWg99Qjz6borMxumoBkWgnmPs
 RzLJrUPzI9xvznJcUJzWYJJ0E6fLDJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733176905;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ERIkhefWi5WqvYg6rz3y2qvknoGc8ppkoMUD2uu3uw=;
 b=fqgHsPcIx8JSH+dbPHRSOgV4TWvdoi7AZn6WMYkS8KNp+l8rW7ClNMlQccaij8+kDvRyJh
 Hwen3Q2Lq0SsNRBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3155913A31;
 Mon,  2 Dec 2024 22:01:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AFbjOUcuTmdlIAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Dec 2024 22:01:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/6] migration: Kick postcopy threads on cancel
Date: Mon,  2 Dec 2024 19:01:33 -0300
Message-Id: <20241202220137.32584-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241202220137.32584-1-farosas@suse.de>
References: <20241202220137.32584-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5FD5921182
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Make sure postcopy threads are released when migrate_cancel is
issued. Kick the postcopy_pause semaphore and have the fault thread
read 'fault_thread_quit' when joining.

While here fix the comment mentioning userfault_event_fd.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c    | 14 +++++++++++---
 migration/postcopy-ram.c | 14 ++++++++++++--
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8c5bd0a75c..07fbb5c9f4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -105,7 +105,7 @@ static bool migration_object_check(MigrationState *ms, Error **errp);
 static int migration_maybe_pause(MigrationState *s,
                                  int *current_active_state,
                                  int new_state);
-static void migrate_fd_cancel(MigrationState *s);
+static void migrate_fd_cancel(MigrationState *s, MigrationIncomingState *mis);
 static bool close_return_path_on_source(MigrationState *s);
 static void migration_completion_end(MigrationState *s);
 
@@ -317,7 +317,7 @@ void migration_cancel(const Error *error)
     if (migrate_dirty_limit()) {
         qmp_cancel_vcpu_dirty_limit(false, -1, NULL);
     }
-    migrate_fd_cancel(current_migration);
+    migrate_fd_cancel(current_migration, current_incoming);
 }
 
 void migration_shutdown(void)
@@ -1502,7 +1502,7 @@ static void migrate_fd_error(MigrationState *s, const Error *error)
     migrate_set_error(s, error);
 }
 
-static void migrate_fd_cancel(MigrationState *s)
+static void migrate_fd_cancel(MigrationState *s, MigrationIncomingState *mis)
 {
     int old_state ;
 
@@ -1515,6 +1515,12 @@ static void migrate_fd_cancel(MigrationState *s)
         }
     }
 
+    if (mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+        migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_PAUSED,
+                          MIGRATION_STATUS_CANCELLING);
+        qemu_sem_post(&mis->postcopy_pause_sem_dst);
+    }
+
     do {
         old_state = s->state;
         if (!migration_is_running()) {
@@ -1523,6 +1529,8 @@ static void migrate_fd_cancel(MigrationState *s)
         /* If the migration is paused, kick it out of the pause */
         if (old_state == MIGRATION_STATUS_PRE_SWITCHOVER) {
             qemu_sem_post(&s->pause_sem);
+        } else if (old_state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+            qemu_sem_post(&s->postcopy_pause_sem);
         }
         migrate_set_state(&s->state, old_state, MIGRATION_STATUS_CANCELLING);
     } while (s->state != MIGRATION_STATUS_CANCELLING);
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index a535fd2e30..6882ef977d 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -634,6 +634,7 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
         qatomic_set(&mis->fault_thread_quit, 1);
         postcopy_fault_thread_notify(mis);
         trace_postcopy_ram_incoming_cleanup_join();
+        qemu_sem_post(&mis->postcopy_pause_sem_fault);
         qemu_thread_join(&mis->fault_thread);
 
         if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_END, &local_err)) {
@@ -991,8 +992,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
 
         /*
          * We're mainly waiting for the kernel to give us a faulting HVA,
-         * however we can be told to quit via userfault_quit_fd which is
-         * an eventfd
+         * however we can be told to quit via userfault_event_fd.
          */
 
         poll_result = poll(pfd, pfd_len, -1 /* Wait forever */);
@@ -1008,6 +1008,11 @@ static void *postcopy_ram_fault_thread(void *opaque)
              * the channel is rebuilt.
              */
             postcopy_pause_fault_thread(mis);
+
+            if (qatomic_read(&mis->fault_thread_quit)) {
+                trace_postcopy_ram_fault_thread_quit();
+                break;
+            }
         }
 
         if (pfd[1].revents) {
@@ -1082,6 +1087,11 @@ retry:
             if (ret) {
                 /* May be network failure, try to wait for recovery */
                 postcopy_pause_fault_thread(mis);
+
+                if (qatomic_read(&mis->fault_thread_quit)) {
+                    trace_postcopy_ram_fault_thread_quit();
+                    break;
+                }
                 goto retry;
             }
         }
-- 
2.35.3


