Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06957C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rec37-0000wJ-C6; Mon, 26 Feb 2024 09:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rec35-0000vr-Ph
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:33:43 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rec33-0006Cl-NO
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:33:43 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E2251224F8;
 Mon, 26 Feb 2024 14:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708958020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hM5mnMIObkv+sFV22ZAHx3tsxUqEnwCDhsuuDjoGvRI=;
 b=d522xle2Etf1f8RSnblPx3wtXXSpsfi21ONCyCgwEWJ8YiXbdAo3vfZpDAgzELx/9tpTTU
 mbdU8sm84chgfXNJfYVccckrRomjG/ZkRp5/CIMM9W1tD9SjFG8Xn7h1g4l42K+FyAaoMx
 vAu2qdlC0KHWSG4sVvV9qLewzRBq7kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708958020;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hM5mnMIObkv+sFV22ZAHx3tsxUqEnwCDhsuuDjoGvRI=;
 b=xQUtD3eMHUhNXVRJghj5/LLbBpmkVq1BUtz9jKumIoAcCErbzPBXWZ+yNQ2s38NhTrjzTt
 CzSAtpZDw41JqwAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708958018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hM5mnMIObkv+sFV22ZAHx3tsxUqEnwCDhsuuDjoGvRI=;
 b=frgDT/hChVDy6y6M2pLJ5Jm0Je8XUnyywTKcARFg96HNACbVrVee9avFMi/62N2X9qR9b8
 8pFLb2OnizVX+mSRW2ptt8C/xFEtY5Nmk8L1PWkKtbl/PlUnIkPYNgr01mlsJK7pkpHZzd
 ep2KOvO+LzaFKvx4ZxrmwEdv9vQm4y0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708958018;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hM5mnMIObkv+sFV22ZAHx3tsxUqEnwCDhsuuDjoGvRI=;
 b=PVC0uHDHq4XIJtPbk4s8KL56x81vp5/eJodsJ2uGj6z650A4HZZ5RBxXBI+MjEtZvIoBeU
 8NRK64Ey/4DM9xCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F32C513A58;
 Mon, 26 Feb 2024 14:33:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bpHsLUGh3GUhcAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Feb 2024 14:33:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH v2] migration: Fix qmp_query_migrate mbps value
Date: Mon, 26 Feb 2024 11:33:35 -0300
Message-Id: <20240226143335.14282-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="frgDT/hC";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PVC0uHDH
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.51 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,gitlab.com:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: E2251224F8
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

The QMP command query_migrate might see incorrect throughput numbers
if it runs after we've set the migration completion status but before
migration_calculate_complete() has updated s->total_time and s->mbps.

The migration status would show COMPLETED, but the throughput value
would be the one from the last iteration and not the one from the
whole migration. This will usually be a larger value due to the time
period being smaller (one iteration).

Move migration_calculate_complete() earlier so that the status
MIGRATION_STATUS_COMPLETED is only emitted after the final counters
update. Keep everything under the BQL so the QMP thread sees the
updates as atomic.

Rename migration_calculate_complete to migration_completion_end to
reflect its new purpose of also updating s->state.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
v2:
- improved comments;
- took the suggestion of creating a new function but used 'end'
  instead of 'finalize' to avoid possible confusion with QOM.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/1191024660
---
 migration/migration.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ab21de2cad..7b0e528d01 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -102,6 +102,7 @@ static int migration_maybe_pause(MigrationState *s,
                                  int new_state);
 static void migrate_fd_cancel(MigrationState *s);
 static bool close_return_path_on_source(MigrationState *s);
+static void migration_completion_end(MigrationState *s);
 
 static void migration_downtime_start(MigrationState *s)
 {
@@ -2746,8 +2747,7 @@ static void migration_completion(MigrationState *s)
         migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
                           MIGRATION_STATUS_COLO);
     } else {
-        migrate_set_state(&s->state, current_active_state,
-                          MIGRATION_STATUS_COMPLETED);
+        migration_completion_end(s);
     }
 
     return;
@@ -2784,8 +2784,7 @@ static void bg_migration_completion(MigrationState *s)
         goto fail;
     }
 
-    migrate_set_state(&s->state, current_active_state,
-                      MIGRATION_STATUS_COMPLETED);
+    migration_completion_end(s);
     return;
 
 fail:
@@ -2987,18 +2986,28 @@ static MigThrError migration_detect_error(MigrationState *s)
     }
 }
 
-static void migration_calculate_complete(MigrationState *s)
+static void migration_completion_end(MigrationState *s)
 {
     uint64_t bytes = migration_transferred_bytes();
     int64_t end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     int64_t transfer_time;
 
+    /*
+     * Take the BQL here so that query-migrate on the QMP thread sees:
+     * - atomic update of s->total_time and s->mbps;
+     * - correct ordering of s->mbps update vs. s->state;
+     */
+    bql_lock();
     migration_downtime_end(s);
     s->total_time = end_time - s->start_time;
     transfer_time = s->total_time - s->setup_time;
     if (transfer_time) {
         s->mbps = ((double) bytes * 8.0) / transfer_time / 1000;
     }
+
+    migrate_set_state(&s->state, s->state,
+                      MIGRATION_STATUS_COMPLETED);
+    bql_unlock();
 }
 
 static void update_iteration_initial_status(MigrationState *s)
@@ -3145,7 +3154,6 @@ static void migration_iteration_finish(MigrationState *s)
     bql_lock();
     switch (s->state) {
     case MIGRATION_STATUS_COMPLETED:
-        migration_calculate_complete(s);
         runstate_set(RUN_STATE_POSTMIGRATE);
         break;
     case MIGRATION_STATUS_COLO:
@@ -3189,9 +3197,6 @@ static void bg_migration_iteration_finish(MigrationState *s)
     bql_lock();
     switch (s->state) {
     case MIGRATION_STATUS_COMPLETED:
-        migration_calculate_complete(s);
-        break;
-
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_FAILED:
     case MIGRATION_STATUS_CANCELLED:
-- 
2.35.3


