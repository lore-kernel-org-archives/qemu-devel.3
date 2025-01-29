Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED9AC02190
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAZZ-0001Lt-NR; Wed, 29 Jan 2025 11:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAWM-0004Be-JP
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:30 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAWI-0005Qt-DP
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:29 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D31A71F365;
 Wed, 29 Jan 2025 16:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p3PJnQXb49kwu/e6E7+wSku8ur8PGiwNoMMpAHYKoXg=;
 b=FGizqL/Jzh/S0qKRxEHUjdNdiPN/GrSsNRCY9LtBr71MhyM5g18I1f1OzlX/BMj3fa0NPv
 IYNpeeIWmGFVdq5zBIi4wpP9f+9noGUCN9lcdVXpYLd09VdPvGSShu3xJT7W2oaljv9iYP
 OP8Jaudp3ejBTmKR5SBSNC/4ch7NAyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166544;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p3PJnQXb49kwu/e6E7+wSku8ur8PGiwNoMMpAHYKoXg=;
 b=O07tkrbf1TUX/3buiTsyvHmVWOrZvkagKuuxXDypfoLiaU4fkjdH7RoSBQdMTGxhV/Yw11
 QRHI8vek65zZdyAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NFbf7Vwx;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MDKMboVG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p3PJnQXb49kwu/e6E7+wSku8ur8PGiwNoMMpAHYKoXg=;
 b=NFbf7Vwx96AxIDQu0NbTx1HCvolJDq5w5CuL7ywn50L9o9NrVJhgQxBN9uYQ5TB4tGxnZ7
 H+3Ecba+NnMDffjMTEiO2phRSvySI6/fiLM3OoZ88JPsDbNKQBSu5BSDAzweJ/G7FesHYA
 907hmob8iGlToN5NwoktkLuPpNPE/Eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166543;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p3PJnQXb49kwu/e6E7+wSku8ur8PGiwNoMMpAHYKoXg=;
 b=MDKMboVGYDc6lAeilean8wKFDMPvi/YKL6rtSx7A3XaVfcoERvzonfbUu49HZnxZK9Ty7h
 YQ0Rf0TvzD92cJAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA6BD137DB;
 Wed, 29 Jan 2025 16:02:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yIu3IQ1RmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:02:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 39/42] migration: Always set DEVICE state
Date: Wed, 29 Jan 2025 13:00:56 -0300
Message-Id: <20250129160059.6987-40-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D31A71F365
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLi3368pnyb3ujpcs6u1hud8b3)];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DEVICE state was introduced back in 2017:

https://lore.kernel.org/qemu-devel/20171020090556.18631-1-dgilbert@redhat.com/

Quote from Dave's cover letter, when the pre-switchover phase was enabled,
the state transition looks like this:

  The precopy flow is:
  active->pre-switchover->device->completed

  The postcopy flow is:
  active->pre-switchover->postcopy-active->completed

To supplement above, when the cap is not enabled:

  The precopy flow is:
  active->completed

  The postcopy flow is:
  active->postcopy-active->completed

It works for us, though we have some code just to special case these state
transitions, so the DEVICE state currently is special only to precopy, and
only conditionally.

I had a quick discussion with Libvirt developers, it turns out that this
may not be necessary. IOW, it seems okay we can have DEVICE state to be
generic, so that we don't have over-complicated state machines.  It not
only helps align all the migration state machine, help cleanup the code
path especially on pre-switchover handling (see the patch itself), another
side benefit is we can unconditionally have a specific state to mark the
switchover phase, which might be helpful for debugging too.

This patch makes the DEVICE state to be present always, marking that source
QEMU is switching over.  Then the state machine will be always as simple
as:

  active-> [pre-switchover->] -> device -> [postcopy-active->] -> complete

After the change, no matter whether pre-switchover or postcopy is enabled
or not, we always have DEVICE state showing the switchover phase.  When
pre-switchover enabled, we'll have an extra stage before that.  When
postcopy is enabled, we'll have an extra stage after that.

A few qtests need touch up in QEMU tree for this change:

  - A few iotest outputs (194, 203, 234, 262, 280)
  - Teach libqos's migrate() on "device" state

Cc: Jiri Denemark <jdenemar@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Tested-by: Jiri Denemark <jdenemar@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20250114230746.3268797-15-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c       | 82 +++++++++++++++++++++++--------------
 qapi/migration.json         |  7 +++-
 tests/qemu-iotests/194.out  |  1 +
 tests/qemu-iotests/203.out  |  1 +
 tests/qemu-iotests/234.out  |  2 +
 tests/qemu-iotests/262.out  |  1 +
 tests/qemu-iotests/280.out  |  1 +
 tests/qtest/libqos/libqos.c |  3 +-
 8 files changed, 64 insertions(+), 34 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d29f7448bd..5302b7b91b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -105,7 +105,7 @@ static MigrationIncomingState *current_incoming;
 static GSList *migration_blockers[MIG_MODE__MAX];
 
 static bool migration_object_check(MigrationState *ms, Error **errp);
-static int migration_maybe_pause(MigrationState *s, int new_state);
+static bool migration_switchover_start(MigrationState *s);
 static void migrate_fd_cancel(MigrationState *s);
 static bool close_return_path_on_source(MigrationState *s);
 static void migration_completion_end(MigrationState *s);
@@ -2657,11 +2657,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         }
     }
 
-    if (!migrate_pause_before_switchover()) {
-        migrate_set_state(&ms->state, MIGRATION_STATUS_ACTIVE,
-                          MIGRATION_STATUS_POSTCOPY_ACTIVE);
-    }
-
     trace_postcopy_start();
     bql_lock();
     trace_postcopy_start_set_run();
@@ -2672,10 +2667,8 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         goto fail;
     }
 
-    ret = migration_maybe_pause(ms, MIGRATION_STATUS_POSTCOPY_ACTIVE);
-    if (ret < 0) {
-        error_setg_errno(errp, -ret, "%s: Failed in migration_maybe_pause()",
-                         __func__);
+    if (!migration_switchover_start(ms)) {
+        error_setg(errp, "migration_switchover_start() failed");
         goto fail;
     }
 
@@ -2800,6 +2793,10 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      */
     migration_rate_set(migrate_max_postcopy_bandwidth());
 
+    /* Now, switchover looks all fine, switching to postcopy-active */
+    migrate_set_state(&ms->state, MIGRATION_STATUS_DEVICE,
+                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
+
     bql_unlock();
 
     return ret;
@@ -2816,14 +2813,39 @@ fail:
 }
 
 /**
- * migration_maybe_pause: Pause if required to by
- * migrate_pause_before_switchover called with the BQL locked
- * Returns: 0 on success
+ * @migration_switchover_start: Start VM switchover procedure
+ *
+ * @s: The migration state object pointer
+ *
+ * Prepares for the switchover, depending on "pause-before-switchover"
+ * capability.
+ *
+ * If cap set, state machine goes like:
+ *   [postcopy-]active -> pre-switchover -> device
+ *
+ * If cap not set:
+ *   [postcopy-]active -> device
+ *
+ * Returns: true on success, false on interruptions.
  */
-static int migration_maybe_pause(MigrationState *s, int new_state)
+static bool migration_switchover_start(MigrationState *s)
 {
+    /* Concurrent cancellation?  Quit */
+    if (s->state == MIGRATION_STATUS_CANCELLING) {
+        return false;
+    }
+
+    /*
+     * No matter precopy or postcopy, since we still hold BQL it must not
+     * change concurrently to CANCELLING, so it must be either ACTIVE or
+     * POSTCOPY_ACTIVE.
+     */
+    assert(migration_is_active());
+
+    /* If the pre stage not requested, directly switch to DEVICE */
     if (!migrate_pause_before_switchover()) {
-        return 0;
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_DEVICE);
+        return true;
     }
 
     /* Since leaving this state is not atomic with posting the semaphore
@@ -2836,23 +2858,22 @@ static int migration_maybe_pause(MigrationState *s, int new_state)
         /* This block intentionally left blank */
     }
 
+    /* Update [POSTCOPY_]ACTIVE to PRE_SWITCHOVER */
+    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_PRE_SWITCHOVER);
+    bql_unlock();
+
+    qemu_sem_wait(&s->pause_sem);
+
+    bql_lock();
     /*
-     * If the migration is cancelled when it is in the completion phase,
-     * the migration state is set to MIGRATION_STATUS_CANCELLING.
-     * So we don't need to wait a semaphore, otherwise we would always
-     * wait for the 'pause_sem' semaphore.
+     * After BQL released and retaken, the state can be CANCELLING if it
+     * happend during sem_wait().. Only change the state if it's still
+     * pre-switchover.
      */
-    if (s->state != MIGRATION_STATUS_CANCELLING) {
-        migrate_set_state(&s->state, s->state,
-                          MIGRATION_STATUS_PRE_SWITCHOVER);
-        bql_unlock();
-        qemu_sem_wait(&s->pause_sem);
-        bql_lock();
-        migrate_set_state(&s->state, MIGRATION_STATUS_PRE_SWITCHOVER,
-                          new_state);
-    }
+    migrate_set_state(&s->state, MIGRATION_STATUS_PRE_SWITCHOVER,
+                      MIGRATION_STATUS_DEVICE);
 
-    return s->state == new_state ? 0 : -EINVAL;
+    return s->state == MIGRATION_STATUS_DEVICE;
 }
 
 static int migration_completion_precopy(MigrationState *s)
@@ -2868,8 +2889,7 @@ static int migration_completion_precopy(MigrationState *s)
         }
     }
 
-    ret = migration_maybe_pause(s, MIGRATION_STATUS_DEVICE);
-    if (ret < 0) {
+    if (!migration_switchover_start(s)) {
         goto out_unlock;
     }
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 4679ce9f2a..43babd1df4 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -158,8 +158,11 @@
 #
 # @pre-switchover: Paused before device serialisation.  (since 2.11)
 #
-# @device: During device serialisation when pause-before-switchover is
-#     enabled (since 2.11)
+# @device: During device serialisation (also known as switchover phase).
+#     Before 9.2, this is only used when (1) in precopy, and (2) when
+#     pre-switchover capability is enabled.  After 10.0, this state will
+#     always be present for every migration procedure as the switchover
+#     phase.  (since 2.11)
 #
 # @wait-unplug: wait for device unplug request by guest OS to be
 #     completed.  (since 4.2)
diff --git a/tests/qemu-iotests/194.out b/tests/qemu-iotests/194.out
index 376ed1d2e6..6940e809cd 100644
--- a/tests/qemu-iotests/194.out
+++ b/tests/qemu-iotests/194.out
@@ -14,6 +14,7 @@ Starting migration...
 {"return": {}}
 {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "device"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 Gracefully ending the `drive-mirror` job on source...
 {"return": {}}
diff --git a/tests/qemu-iotests/203.out b/tests/qemu-iotests/203.out
index 9d4abba8c5..8e58705e51 100644
--- a/tests/qemu-iotests/203.out
+++ b/tests/qemu-iotests/203.out
@@ -8,4 +8,5 @@ Starting migration...
 {"return": {}}
 {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "device"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
diff --git a/tests/qemu-iotests/234.out b/tests/qemu-iotests/234.out
index ac8b64350c..be3e138b58 100644
--- a/tests/qemu-iotests/234.out
+++ b/tests/qemu-iotests/234.out
@@ -10,6 +10,7 @@ Starting migration to B...
 {"return": {}}
 {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "device"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
@@ -27,6 +28,7 @@ Starting migration back to A...
 {"return": {}}
 {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "device"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
diff --git a/tests/qemu-iotests/262.out b/tests/qemu-iotests/262.out
index b8a2d3598d..bd7706b84b 100644
--- a/tests/qemu-iotests/262.out
+++ b/tests/qemu-iotests/262.out
@@ -8,6 +8,7 @@ Starting migration to B...
 {"return": {}}
 {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "device"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
diff --git a/tests/qemu-iotests/280.out b/tests/qemu-iotests/280.out
index 546dbb4a68..37411144ca 100644
--- a/tests/qemu-iotests/280.out
+++ b/tests/qemu-iotests/280.out
@@ -7,6 +7,7 @@ Enabling migration QMP events on VM...
 {"return": {}}
 {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"status": "device"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 VM is now stopped:
diff --git a/tests/qtest/libqos/libqos.c b/tests/qtest/libqos/libqos.c
index 5c0fa1f7c5..28a0901a0a 100644
--- a/tests/qtest/libqos/libqos.c
+++ b/tests/qtest/libqos/libqos.c
@@ -117,13 +117,14 @@ void migrate(QOSState *from, QOSState *to, const char *uri)
         g_assert(qdict_haskey(sub, "status"));
         st = qdict_get_str(sub, "status");
 
-        /* "setup", "active", "completed", "failed", "cancelled" */
+        /* "setup", "active", "device", "completed", "failed", "cancelled" */
         if (strcmp(st, "completed") == 0) {
             qobject_unref(rsp);
             break;
         }
 
         if ((strcmp(st, "setup") == 0) || (strcmp(st, "active") == 0)
+            || (strcmp(st, "device") == 0)
             || (strcmp(st, "wait-unplug") == 0)) {
             qobject_unref(rsp);
             g_usleep(5000);
-- 
2.35.3


