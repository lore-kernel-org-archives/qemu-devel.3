Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10298C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAXS-0005aL-8r; Wed, 29 Jan 2025 11:03:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAW8-0003rk-BF
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:16 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAW6-0005Od-Di
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:02:16 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 408931F387;
 Wed, 29 Jan 2025 16:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTRQtWFUFJVm6xsbgty07pAWu9rR9ojTVsMJzKOEOa0=;
 b=163hRYts1r7ZGNHRzMe+2wDox2J29pg78PDIhTKIvsOUDLBfvBp9m9WfX0eICHt07CUNe9
 vxpcTHip0djLzWNvCtWQTfgdpuFRXPu4/OAVcRu0ybSP4m1oR/akjHKtpO6j+N5pxkZ/Bh
 Ir+iIuO8tyMhZKmJmgc0jJAspGm2C0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166533;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTRQtWFUFJVm6xsbgty07pAWu9rR9ojTVsMJzKOEOa0=;
 b=62jrYBCmcQaaS9TRm5dy6r/56d8F+Miab7wG7w+Dga5hH7ueq+Uk3abavGw8PAPfrcGC8z
 TBiinUSL6ZGA2DCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTRQtWFUFJVm6xsbgty07pAWu9rR9ojTVsMJzKOEOa0=;
 b=163hRYts1r7ZGNHRzMe+2wDox2J29pg78PDIhTKIvsOUDLBfvBp9m9WfX0eICHt07CUNe9
 vxpcTHip0djLzWNvCtWQTfgdpuFRXPu4/OAVcRu0ybSP4m1oR/akjHKtpO6j+N5pxkZ/Bh
 Ir+iIuO8tyMhZKmJmgc0jJAspGm2C0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166533;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QTRQtWFUFJVm6xsbgty07pAWu9rR9ojTVsMJzKOEOa0=;
 b=62jrYBCmcQaaS9TRm5dy6r/56d8F+Miab7wG7w+Dga5hH7ueq+Uk3abavGw8PAPfrcGC8z
 TBiinUSL6ZGA2DCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3564137DB;
 Wed, 29 Jan 2025 16:02:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GG3RHANRmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:02:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 34/42] migration: Drop cached migration state in
 migration_maybe_pause()
Date: Wed, 29 Jan 2025 13:00:51 -0300
Message-Id: <20250129160059.6987-35-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]
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

From: Peter Xu <peterx@redhat.com>

I can't see why we must cache the state now after we avoided possible
CANCEL race: that's the only thing I can think of that can modify the
migration state concurrently with the migration thread itself.  Make all
the state updates to happen always, then we don't need to cache the state
anymore.

Signed-off-by: Peter Xu <peterx@redhat.com>
Tested-by: Jiri Denemark <jdenemar@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20250114230746.3268797-10-peterx@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 4e4bf8ffed..5a3d0750ec 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -105,9 +105,7 @@ static MigrationIncomingState *current_incoming;
 static GSList *migration_blockers[MIG_MODE__MAX];
 
 static bool migration_object_check(MigrationState *ms, Error **errp);
-static int migration_maybe_pause(MigrationState *s,
-                                 int *current_active_state,
-                                 int new_state);
+static int migration_maybe_pause(MigrationState *s, int new_state);
 static void migrate_fd_cancel(MigrationState *s);
 static bool close_return_path_on_source(MigrationState *s);
 static void migration_completion_end(MigrationState *s);
@@ -2629,7 +2627,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     int ret;
     QIOChannelBuffer *bioc;
     QEMUFile *fb;
-    int cur_state = MIGRATION_STATUS_ACTIVE;
 
     /*
      * Now we're 100% sure to switch to postcopy, so JSON writer won't be
@@ -2664,8 +2661,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         goto fail;
     }
 
-    ret = migration_maybe_pause(ms, &cur_state,
-                                MIGRATION_STATUS_POSTCOPY_ACTIVE);
+    ret = migration_maybe_pause(ms, MIGRATION_STATUS_POSTCOPY_ACTIVE);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "%s: Failed in migration_maybe_pause()",
                          __func__);
@@ -2803,9 +2799,7 @@ fail:
  * migrate_pause_before_switchover called with the BQL locked
  * Returns: 0 on success
  */
-static int migration_maybe_pause(MigrationState *s,
-                                 int *current_active_state,
-                                 int new_state)
+static int migration_maybe_pause(MigrationState *s, int new_state)
 {
     if (!migrate_pause_before_switchover()) {
         return 0;
@@ -2828,21 +2822,19 @@ static int migration_maybe_pause(MigrationState *s,
      * wait for the 'pause_sem' semaphore.
      */
     if (s->state != MIGRATION_STATUS_CANCELLING) {
-        migrate_set_state(&s->state, *current_active_state,
+        migrate_set_state(&s->state, s->state,
                           MIGRATION_STATUS_PRE_SWITCHOVER);
         bql_unlock();
         qemu_sem_wait(&s->pause_sem);
         bql_lock();
         migrate_set_state(&s->state, MIGRATION_STATUS_PRE_SWITCHOVER,
                           new_state);
-        *current_active_state = new_state;
     }
 
     return s->state == new_state ? 0 : -EINVAL;
 }
 
-static int migration_completion_precopy(MigrationState *s,
-                                        int *current_active_state)
+static int migration_completion_precopy(MigrationState *s)
 {
     int ret;
 
@@ -2855,8 +2847,7 @@ static int migration_completion_precopy(MigrationState *s,
         }
     }
 
-    ret = migration_maybe_pause(s, current_active_state,
-                                MIGRATION_STATUS_DEVICE);
+    ret = migration_maybe_pause(s, MIGRATION_STATUS_DEVICE);
     if (ret < 0) {
         goto out_unlock;
     }
@@ -2909,11 +2900,10 @@ static void migration_completion_postcopy(MigrationState *s)
 static void migration_completion(MigrationState *s)
 {
     int ret = 0;
-    int current_active_state = s->state;
     Error *local_err = NULL;
 
     if (s->state == MIGRATION_STATUS_ACTIVE) {
-        ret = migration_completion_precopy(s, &current_active_state);
+        ret = migration_completion_precopy(s);
     } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
         migration_completion_postcopy(s);
     } else {
@@ -2953,8 +2943,7 @@ fail:
         error_free(local_err);
     }
 
-    migrate_set_state(&s->state, current_active_state,
-                      MIGRATION_STATUS_FAILED);
+    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
 }
 
 /**
-- 
2.35.3


