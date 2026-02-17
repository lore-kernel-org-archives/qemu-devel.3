Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BA0E909D5
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 16:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNj7-00015R-IE; Tue, 17 Feb 2026 11:15:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNj3-00011A-LK
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:02 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vsNiy-0002sp-MX
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 11:15:01 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2E02F5BD14;
 Tue, 17 Feb 2026 16:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xXsyLqugyk4Y2xMaV84xnYLMkiP6TjRpYpdyID4qv9w=;
 b=OqGIzSWhki3Txve+PSaiLr/nvVrly957cackGumxbzQtEEjjmC9sYw+mdttf5VmjJ4X33R
 uBwsOyEHcUKKsfxU33SYMRsINOd3KRReb4OUA375hTdSy2qOxvaxhMTQmxOVf2gY/9c+nK
 eynglctgBFNRb2xOabGDHOvYu2IlQU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344891;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xXsyLqugyk4Y2xMaV84xnYLMkiP6TjRpYpdyID4qv9w=;
 b=6C2BQrW82exN/tISkNsNbxP3e8Hj2IKZ2y776SKt0QDZl8PHIx6AsrsgbbVAmGWpD63QFE
 OExMX2rAJwURZVAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771344891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xXsyLqugyk4Y2xMaV84xnYLMkiP6TjRpYpdyID4qv9w=;
 b=OqGIzSWhki3Txve+PSaiLr/nvVrly957cackGumxbzQtEEjjmC9sYw+mdttf5VmjJ4X33R
 uBwsOyEHcUKKsfxU33SYMRsINOd3KRReb4OUA375hTdSy2qOxvaxhMTQmxOVf2gY/9c+nK
 eynglctgBFNRb2xOabGDHOvYu2IlQU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771344891;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xXsyLqugyk4Y2xMaV84xnYLMkiP6TjRpYpdyID4qv9w=;
 b=6C2BQrW82exN/tISkNsNbxP3e8Hj2IKZ2y776SKt0QDZl8PHIx6AsrsgbbVAmGWpD63QFE
 OExMX2rAJwURZVAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A1223EA66;
 Tue, 17 Feb 2026 16:14:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mLnbE/mTlGmHTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Feb 2026 16:14:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 02/32] migration: Fix double notification of DONE/FAIL for
 postcopy
Date: Tue, 17 Feb 2026 13:14:13 -0300
Message-ID: <20260217161443.12738-3-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260217161443.12738-1-farosas@suse.de>
References: <20260217161443.12738-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

Migration notifiers will notify at any of three places: (1) SETUP
phase, (2) migration completes, (3) migration fails.

There's actually a special case for spice: one can refer to
b82fc321bf ("Postcopy+spice: Pass spice migration data earlier").  It
doesn't need another 4th event because in commit 9d9babf78d ("migration:
MigrationEvent for notifiers") we merged it together with the DONE event.

The merge makes some sense if we treat "switchover" of postcopy as "DONE",
however that also means for postcopy we'll notify DONE twice..  The other
one at the end of postcopy when migration_cleanup().

In reality, the current code base will also notify FAILED for postcopy
twice.  It's because an (maybe accidental) change in commit
4af667f87c ("migration: notifier error checking").

First of all, we still need that notification when switchover as stated in
Dave's commit, however that's only needed for spice.  To fix it, introduce
POSTCOPY_START event to differenciate it from DONE.  Use that instead in
postcopy_start().  Then spice will need to capture this event too.

Then we remove the extra FAILED notification in postcopy_start().

If one wonder if other DONE users should also monitor POSTCOPY_START
event.. We have two more DONE users:

  - kvm_arm_gicv3_notifier
  - cpr_exec_notifier

Both of them do not need a notification for POSTCOPY_START, but only when
migration completed.  Actually, both of them are used in CPR, which doesn't
support postcopy.

When at this, update the notifier transition graph in the comment, and move
it from migration_add_notifier() to be closer to where the enum is defined.

I didn't attach Fixes: because I am not aware of any real bug on such
double reporting.  I'm wildly guessing the 2nd notify might be silently
ignored in many cases.  However this is still worth fixing.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/20260126213614.3815900-3-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/misc.h | 16 ++++++++++++----
 migration/migration.c    |  3 +--
 ui/spice-core.c          |  3 ++-
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index e26d418a6e..1cd6cfd7f7 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -59,10 +59,22 @@ void migration_shutdown(void);
 bool migration_is_running(void);
 bool migration_thread_is_self(void);
 
+/*
+ * Notifiers may receive events in any of the following orders:
+ *
+ *    - MIG_EVENT_PRECOPY_SETUP [-> MIG_EVENT_POSTCOPY_START]
+ *      -> MIG_EVENT_PRECOPY_DONE
+ *
+ *    - MIG_EVENT_PRECOPY_SETUP [-> MIG_EVENT_POSTCOPY_START]
+ *      -> MIG_EVENT_PRECOPY_FAILED
+ *
+ *    - MIG_EVENT_PRECOPY_FAILED
+ */
 typedef enum MigrationEventType {
     MIG_EVENT_PRECOPY_SETUP,
     MIG_EVENT_PRECOPY_DONE,
     MIG_EVENT_PRECOPY_FAILED,
+    MIG_EVENT_POSTCOPY_START,
     MIG_EVENT_MAX
 } MigrationEventType;
 
@@ -81,10 +93,6 @@ typedef int (*MigrationNotifyFunc)(NotifierWithReturn *notify,
 /*
  * Register the notifier @notify to be called when a migration event occurs
  * for MIG_MODE_NORMAL, as specified by the MigrationEvent passed to @func.
- * Notifiers may receive events in any of the following orders:
- *    - MIG_EVENT_PRECOPY_SETUP -> MIG_EVENT_PRECOPY_DONE
- *    - MIG_EVENT_PRECOPY_SETUP -> MIG_EVENT_PRECOPY_FAILED
- *    - MIG_EVENT_PRECOPY_FAILED
  */
 void migration_add_notifier(NotifierWithReturn *notify,
                             MigrationNotifyFunc func);
diff --git a/migration/migration.c b/migration/migration.c
index 341b9be80e..bd24006c1a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2591,7 +2591,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      * at the transition to postcopy and after the device state; in particular
      * spice needs to trigger a transition now
      */
-    migration_call_notifiers(MIG_EVENT_PRECOPY_DONE, NULL);
+    migration_call_notifiers(MIG_EVENT_POSTCOPY_START, NULL);
 
     migration_downtime_end(ms);
 
@@ -2640,7 +2640,6 @@ fail:
         migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
     }
     migration_block_activate(NULL);
-    migration_call_notifiers(MIG_EVENT_PRECOPY_FAILED, NULL);
     bql_unlock();
     return -1;
 }
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 8a6050f4ae..ce3c2954e3 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -585,7 +585,8 @@ static int migration_state_notifier(NotifierWithReturn *notifier,
 
     if (e->type == MIG_EVENT_PRECOPY_SETUP) {
         spice_server_migrate_start(spice_server);
-    } else if (e->type == MIG_EVENT_PRECOPY_DONE) {
+    } else if (e->type == MIG_EVENT_PRECOPY_DONE ||
+               e->type == MIG_EVENT_POSTCOPY_START) {
         spice_server_migrate_end(spice_server, true);
         spice_have_target_host = false;
     } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
-- 
2.51.0


