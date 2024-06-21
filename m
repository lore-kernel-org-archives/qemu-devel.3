Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02086C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiTo-0003Xq-Sb; Fri, 21 Jun 2024 13:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTm-0003XQ-Lv
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:18 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTk-0003Om-Bm
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:18 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 23F8C21B37;
 Fri, 21 Jun 2024 17:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMbd/ElX3CkcMwgl0EpCXiqh6IT/R7fJ6N/RrAdDXlA=;
 b=On+Sx1EK3cOKU0akIEYLs8HaCQEurGqz4yVONW5l2alUmOv1wkZXy6BGU26/9O6+QA82rm
 i5RM6hTZ4GydirqzPvfa18ntQiYar4ipxOuY2ulxIrYGtZ6IGxFwPeCmbU86i2jdxQAtfx
 9Zlzbs8vjcD5svDvnXHyPQeeOgjX/zI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992515;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMbd/ElX3CkcMwgl0EpCXiqh6IT/R7fJ6N/RrAdDXlA=;
 b=lPPVUlNXfAHmLoqsn1VXsoYghT02aszY1wuLxnPJBiG9NAkRsf7Em2p3sERtvW6mK8u199
 6hYxOHrWzfh7ToAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=On+Sx1EK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lPPVUlNX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMbd/ElX3CkcMwgl0EpCXiqh6IT/R7fJ6N/RrAdDXlA=;
 b=On+Sx1EK3cOKU0akIEYLs8HaCQEurGqz4yVONW5l2alUmOv1wkZXy6BGU26/9O6+QA82rm
 i5RM6hTZ4GydirqzPvfa18ntQiYar4ipxOuY2ulxIrYGtZ6IGxFwPeCmbU86i2jdxQAtfx
 9Zlzbs8vjcD5svDvnXHyPQeeOgjX/zI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992515;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMbd/ElX3CkcMwgl0EpCXiqh6IT/R7fJ6N/RrAdDXlA=;
 b=lPPVUlNXfAHmLoqsn1VXsoYghT02aszY1wuLxnPJBiG9NAkRsf7Em2p3sERtvW6mK8u199
 6hYxOHrWzfh7ToAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79CF913AAA;
 Fri, 21 Jun 2024 17:55:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KBP2D4G+dWZNawAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 17:55:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Subject: [PULL 21/28] migration/postcopy: Add postcopy-recover-setup phase
Date: Fri, 21 Jun 2024 14:54:27 -0300
Message-Id: <20240621175434.31180-22-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240621175434.31180-1-farosas@suse.de>
References: <20240621175434.31180-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 23F8C21B37
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

From: Peter Xu <peterx@redhat.com>

This patch adds a migration state on src called "postcopy-recover-setup".
The new state will describe the intermediate step starting from when the
src QEMU received a postcopy recovery request, until the migration channels
are properly established, but before the recovery process take place.

The request came from Libvirt where Libvirt currently rely on the migration
state events to detect migration state changes.  That works for most of the
migration process but except postcopy recovery failures at the beginning.

Currently postcopy recovery only has two major states:

  - postcopy-paused: this is the state that both sides of QEMU will be in
    for a long time as long as the migration channel was interrupted.

  - postcopy-recover: this is the state where both sides of QEMU handshake
    with each other, preparing for a continuation of postcopy which used to
    be interrupted.

The issue here is when the recovery port is invalid, the src QEMU will take
the URI/channels, noticing the ports are not valid, and it'll silently keep
in the postcopy-paused state, with no event sent to Libvirt.  In this case,
the only thing Libvirt can do is to poll the migration status with a proper
interval, however that's less optimal.

Considering that this is the only case where Libvirt won't get a
notification from QEMU on such events, let's add postcopy-recover-setup
state to mimic what we have with the "setup" state of a newly initialized
migration, describing the phase of connection establishment.

With that, postcopy recovery will have two paths to go now, and either path
will guarantee an event generated.  Now the events will look like this
during a recovery process on src QEMU:

  - Initially when the recovery is initiated on src, QEMU will go from
    "postcopy-paused" -> "postcopy-recover-setup".  Old QEMUs don't have
    this event.

  - Depending on whether the channel re-establishment is succeeded:

    - In succeeded case, src QEMU will move from "postcopy-recover-setup"
      to "postcopy-recover".  Old QEMUs also have this event.

    - In failure case, src QEMU will move from "postcopy-recover-setup" to
      "postcopy-paused" again.  Old QEMUs don't have this event.

This guarantees that Libvirt will always receive a notification for
recovery process properly.

One thing to mention is, such new status is only needed on src QEMU not
both.  On dest QEMU, the state machine doesn't change.  Hence the events
don't change either.  It's done like so because dest QEMU may not have an
explicit point of setup start.  E.g., it can happen that when dest QEMUs
doesn't use migrate-recover command to use a new URI/channel, but the old
URI/channels can be reused in recovery, in which case the old ports simply
can work again after the network routes are fixed up.

Add a new helper postcopy_is_paused() detecting whether postcopy is still
paused, taking RECOVER_SETUP into account too.  When using it on both
src/dst, a slight change is done altogether to always wait for the
semaphore before checking the status, because for both sides a sem_post()
will be required for a recovery.

Cc: Jiri Denemark <jdenemar@redhat.com>
Cc: Prasad Pandit <ppandit@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Buglink: https://issues.redhat.com/browse/RHEL-38485
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c    | 40 ++++++++++++++++++++++++++++++++++------
 migration/postcopy-ram.c |  6 ++++++
 migration/postcopy-ram.h |  3 +++
 migration/savevm.c       |  4 ++--
 qapi/migration.json      |  4 ++++
 5 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 41a88fc50a..3dea06d577 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1117,6 +1117,7 @@ bool migration_is_setup_or_active(void)
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
     case MIGRATION_STATUS_SETUP:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
@@ -1139,6 +1140,7 @@ bool migration_is_running(void)
     case MIGRATION_STATUS_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
     case MIGRATION_STATUS_SETUP:
     case MIGRATION_STATUS_PRE_SWITCHOVER:
@@ -1276,6 +1278,7 @@ static void fill_source_migration_info(MigrationInfo *info)
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
         /* TODO add some postcopy stats */
         populate_time_info(info, s);
@@ -1482,9 +1485,30 @@ static void migrate_error_free(MigrationState *s)
 
 static void migrate_fd_error(MigrationState *s, const Error *error)
 {
+    MigrationStatus current = s->state;
+    MigrationStatus next;
+
     assert(s->to_dst_file == NULL);
-    migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
-                      MIGRATION_STATUS_FAILED);
+
+    switch (current) {
+    case MIGRATION_STATUS_SETUP:
+        next = MIGRATION_STATUS_FAILED;
+        break;
+    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
+        /* Never fail a postcopy migration; switch back to PAUSED instead */
+        next = MIGRATION_STATUS_POSTCOPY_PAUSED;
+        break;
+    default:
+        /*
+         * This really shouldn't happen. Just be careful to not crash a VM
+         * just for this.  Instead, dump something.
+         */
+        error_report("%s: Illegal migration status (%s) detected",
+                     __func__, MigrationStatus_str(current));
+        return;
+    }
+
+    migrate_set_state(&s->state, current, next);
     migrate_set_error(s, error);
 }
 
@@ -1585,6 +1609,7 @@ bool migration_in_postcopy(void)
     switch (s->state) {
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
     case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
     case MIGRATION_STATUS_POSTCOPY_RECOVER:
         return true;
     default:
@@ -1972,6 +1997,9 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
             return false;
         }
 
+        migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_PAUSED,
+                          MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
+
         /* This is a resume, skip init status */
         return true;
     }
@@ -3004,9 +3032,9 @@ static MigThrError postcopy_pause(MigrationState *s)
          * We wait until things fixed up. Then someone will setup the
          * status back for us.
          */
-        while (s->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+        do {
             qemu_sem_wait(&s->postcopy_pause_sem);
-        }
+        } while (postcopy_is_paused(s->state));
 
         if (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
             /* Woken up by a recover procedure. Give it a shot */
@@ -3702,7 +3730,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
 {
     Error *local_err = NULL;
     uint64_t rate_limit;
-    bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
+    bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
     int ret;
 
     /*
@@ -3769,7 +3797,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
 
     if (resume) {
         /* Wakeup the main migration thread to do the recovery */
-        migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_PAUSED,
+        migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP,
                           MIGRATION_STATUS_POSTCOPY_RECOVER);
         qemu_sem_post(&s->postcopy_pause_sem);
         return;
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 97701e6bb2..1c374b7ea1 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1770,3 +1770,9 @@ void *postcopy_preempt_thread(void *opaque)
 
     return NULL;
 }
+
+bool postcopy_is_paused(MigrationStatus status)
+{
+    return status == MIGRATION_STATUS_POSTCOPY_PAUSED ||
+        status == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP;
+}
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index ecae941211..a6df1b2811 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -13,6 +13,8 @@
 #ifndef QEMU_POSTCOPY_RAM_H
 #define QEMU_POSTCOPY_RAM_H
 
+#include "qapi/qapi-types-migration.h"
+
 /* Return true if the host supports everything we need to do postcopy-ram */
 bool postcopy_ram_supported_by_host(MigrationIncomingState *mis,
                                     Error **errp);
@@ -193,5 +195,6 @@ enum PostcopyChannels {
 void postcopy_preempt_new_channel(MigrationIncomingState *mis, QEMUFile *file);
 void postcopy_preempt_setup(MigrationState *s);
 int postcopy_preempt_establish_channel(MigrationState *s);
+bool postcopy_is_paused(MigrationStatus status);
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index e71410d8c1..deb57833f8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2864,9 +2864,9 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
     error_report("Detected IO failure for postcopy. "
                  "Migration paused.");
 
-    while (mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
+    do {
         qemu_sem_wait(&mis->postcopy_pause_sem_dst);
-    }
+    } while (postcopy_is_paused(mis->state));
 
     trace_postcopy_pause_incoming_continued();
 
diff --git a/qapi/migration.json b/qapi/migration.json
index de6c8b0444..0f24206bce 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -142,6 +142,9 @@
 #
 # @postcopy-paused: during postcopy but paused.  (since 3.0)
 #
+# @postcopy-recover-setup: setup phase for a postcopy recovery process,
+#     preparing for a recovery phase to start.  (since 9.1)
+#
 # @postcopy-recover: trying to recover from a paused postcopy.  (since
 #     3.0)
 #
@@ -166,6 +169,7 @@
 { 'enum': 'MigrationStatus',
   'data': [ 'none', 'setup', 'cancelling', 'cancelled',
             'active', 'postcopy-active', 'postcopy-paused',
+            'postcopy-recover-setup',
             'postcopy-recover', 'completed', 'failed', 'colo',
             'pre-switchover', 'device', 'wait-unplug' ] }
 ##
-- 
2.35.3


