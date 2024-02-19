Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D162C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 19:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc9Ze-00006d-7o; Mon, 19 Feb 2024 14:45:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rc9Zc-00005y-PE
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 14:45:09 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rc9ZZ-00061w-Tm
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 14:45:08 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 962081F81C;
 Mon, 19 Feb 2024 19:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708371900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Sks2JFeUF9PfTW2IGZp0Yr9KBnfVSOjSU4rOkcPoRic=;
 b=l3JhJYIwobp3esOKWnA3OuzM3qONMzPRv6sOGTx7ARIXVOR1+AfFZZqF+bpyPJ7wxlwPFX
 YBBZo8QjeBAoZ4IVXcKGAJIEodssrAcNCUnIff4Xnp99tlccSQ9A86rtxp6uZ9aqfUHkNx
 iW0+Q3oArF6qif9Nuk/irBAI+XzX7yU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708371900;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Sks2JFeUF9PfTW2IGZp0Yr9KBnfVSOjSU4rOkcPoRic=;
 b=D21ASuyx8QcBpKMfVV2JwQls4i3SHK3AtFCcrMdKn8DQN5vAnuglzQrmEBMiQIT/aMJLp4
 ktKlO07rJvCTnNDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708371900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Sks2JFeUF9PfTW2IGZp0Yr9KBnfVSOjSU4rOkcPoRic=;
 b=l3JhJYIwobp3esOKWnA3OuzM3qONMzPRv6sOGTx7ARIXVOR1+AfFZZqF+bpyPJ7wxlwPFX
 YBBZo8QjeBAoZ4IVXcKGAJIEodssrAcNCUnIff4Xnp99tlccSQ9A86rtxp6uZ9aqfUHkNx
 iW0+Q3oArF6qif9Nuk/irBAI+XzX7yU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708371900;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Sks2JFeUF9PfTW2IGZp0Yr9KBnfVSOjSU4rOkcPoRic=;
 b=D21ASuyx8QcBpKMfVV2JwQls4i3SHK3AtFCcrMdKn8DQN5vAnuglzQrmEBMiQIT/aMJLp4
 ktKlO07rJvCTnNDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FF2E13647;
 Mon, 19 Feb 2024 19:44:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7YKFGbuv02VzLgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 19 Feb 2024 19:44:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH] migration: Fix qmp_query_migrate mbps value
Date: Mon, 19 Feb 2024 16:44:57 -0300
Message-Id: <20240219194457.26923-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.92 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-2.78)[99.06%]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
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

The QMP command query_migrate might see incorrect throughput numbers
if it runs after we've set the migration completion status but before
migration_calculate_complete() has updated s->total_time and s->mbps.

The migration status would show COMPLETED, but the throughput value
would be the one from the last iteration and not the one from the
whole migration. This will usually be a larger value due to the time
period being smaller (one iteration).

Move migration_calculate_complete() earlier so that the status
MIGRATION_STATUS_COMPLETED is only emitted after the final counters
update.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
CI run: https://gitlab.com/farosas/qemu/-/pipelines/1182405776
---
 migration/migration.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ab21de2cad..7486d59da0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -102,6 +102,7 @@ static int migration_maybe_pause(MigrationState *s,
                                  int new_state);
 static void migrate_fd_cancel(MigrationState *s);
 static bool close_return_path_on_source(MigrationState *s);
+static void migration_calculate_complete(MigrationState *s);
 
 static void migration_downtime_start(MigrationState *s)
 {
@@ -2746,6 +2747,7 @@ static void migration_completion(MigrationState *s)
         migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
                           MIGRATION_STATUS_COLO);
     } else {
+        migration_calculate_complete(s);
         migrate_set_state(&s->state, current_active_state,
                           MIGRATION_STATUS_COMPLETED);
     }
@@ -2784,6 +2786,7 @@ static void bg_migration_completion(MigrationState *s)
         goto fail;
     }
 
+    migration_calculate_complete(s);
     migrate_set_state(&s->state, current_active_state,
                       MIGRATION_STATUS_COMPLETED);
     return;
@@ -2993,12 +2996,15 @@ static void migration_calculate_complete(MigrationState *s)
     int64_t end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     int64_t transfer_time;
 
+    /* QMP could read from these concurrently */
+    bql_lock();
     migration_downtime_end(s);
     s->total_time = end_time - s->start_time;
     transfer_time = s->total_time - s->setup_time;
     if (transfer_time) {
         s->mbps = ((double) bytes * 8.0) / transfer_time / 1000;
     }
+    bql_unlock();
 }
 
 static void update_iteration_initial_status(MigrationState *s)
@@ -3145,7 +3151,6 @@ static void migration_iteration_finish(MigrationState *s)
     bql_lock();
     switch (s->state) {
     case MIGRATION_STATUS_COMPLETED:
-        migration_calculate_complete(s);
         runstate_set(RUN_STATE_POSTMIGRATE);
         break;
     case MIGRATION_STATUS_COLO:
@@ -3189,9 +3194,6 @@ static void bg_migration_iteration_finish(MigrationState *s)
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


