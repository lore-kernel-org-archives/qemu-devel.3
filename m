Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91053C2BD05
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiTj-0003W3-Mi; Fri, 21 Jun 2024 13:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTi-0003Vp-HL
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:14 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTg-0003O8-Mb
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:55:14 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6AD7321B37;
 Fri, 21 Jun 2024 17:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MgVF8+WS1C+1Kgj090nmE1mi0TfygDEbDV5LO8SpQ18=;
 b=dgUkTz8n1Z/HyDRMkXmbVIA+NRlhpP5sI4YoMlBVz+qAuqFwQdM01P3t7Q6TnA/JgyJg7P
 rsBzUn0opXjMiehUvQMrstGoY1N4Uhq+eS3B6nJ5y/J57j4irG7PGoSOOaqHWEbLyBBXXF
 7DtB8syD6iO3jG8GTb4Gr8ZW13AYxTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992511;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MgVF8+WS1C+1Kgj090nmE1mi0TfygDEbDV5LO8SpQ18=;
 b=q0FJJGzh0wGnayL7OoHy8DrJD8ASzyGPQp9E0Yb4AcmRBjM0aT0X0a55b2V8ovnz11spjW
 yZ9AcuSZuDBhp/Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MgVF8+WS1C+1Kgj090nmE1mi0TfygDEbDV5LO8SpQ18=;
 b=dgUkTz8n1Z/HyDRMkXmbVIA+NRlhpP5sI4YoMlBVz+qAuqFwQdM01P3t7Q6TnA/JgyJg7P
 rsBzUn0opXjMiehUvQMrstGoY1N4Uhq+eS3B6nJ5y/J57j4irG7PGoSOOaqHWEbLyBBXXF
 7DtB8syD6iO3jG8GTb4Gr8ZW13AYxTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992511;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MgVF8+WS1C+1Kgj090nmE1mi0TfygDEbDV5LO8SpQ18=;
 b=q0FJJGzh0wGnayL7OoHy8DrJD8ASzyGPQp9E0Yb4AcmRBjM0aT0X0a55b2V8ovnz11spjW
 yZ9AcuSZuDBhp/Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 403E213ACD;
 Fri, 21 Jun 2024 17:55:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eGn0AX6+dWZNawAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 17:55:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 19/28] migration: Use MigrationStatus instead of int
Date: Fri, 21 Jun 2024 14:54:25 -0300
Message-Id: <20240621175434.31180-20-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240621175434.31180-1-farosas@suse.de>
References: <20240621175434.31180-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

QEMU uses "int" in most cases even if it stores MigrationStatus.  I don't
know why, so let's try to do that right and see what blows up..

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 24 +++++++-----------------
 migration/migration.h |  9 +++++----
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f9b69af62f..795b30f0d0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -413,7 +413,7 @@ void migration_incoming_state_destroy(void)
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
 
-static void migrate_generate_event(int new_state)
+static void migrate_generate_event(MigrationStatus new_state)
 {
     if (migrate_events()) {
         qapi_event_send_migration(new_state);
@@ -1296,8 +1296,6 @@ static void fill_destination_migration_info(MigrationInfo *info)
     }
 
     switch (mis->state) {
-    case MIGRATION_STATUS_NONE:
-        return;
     case MIGRATION_STATUS_SETUP:
     case MIGRATION_STATUS_CANCELLING:
     case MIGRATION_STATUS_CANCELLED:
@@ -1313,6 +1311,8 @@ static void fill_destination_migration_info(MigrationInfo *info)
         info->has_status = true;
         fill_destination_postcopy_migration_info(info);
         break;
+    default:
+        return;
     }
     info->status = mis->state;
 
@@ -1360,7 +1360,8 @@ void qmp_migrate_start_postcopy(Error **errp)
 
 /* shared migration helpers */
 
-void migrate_set_state(int *state, int old_state, int new_state)
+void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
+                       MigrationStatus new_state)
 {
     assert(new_state < MIGRATION_STATUS__MAX);
     if (qatomic_cmpxchg(state, old_state, new_state) == old_state) {
@@ -1567,7 +1568,7 @@ bool migration_in_postcopy(void)
     }
 }
 
-bool migration_postcopy_is_alive(int state)
+bool migration_postcopy_is_alive(MigrationStatus state)
 {
     switch (state) {
     case MIGRATION_STATUS_POSTCOPY_ACTIVE:
@@ -1612,20 +1613,9 @@ bool migration_is_idle(void)
     case MIGRATION_STATUS_COMPLETED:
     case MIGRATION_STATUS_FAILED:
         return true;
-    case MIGRATION_STATUS_SETUP:
-    case MIGRATION_STATUS_CANCELLING:
-    case MIGRATION_STATUS_ACTIVE:
-    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
-    case MIGRATION_STATUS_COLO:
-    case MIGRATION_STATUS_PRE_SWITCHOVER:
-    case MIGRATION_STATUS_DEVICE:
-    case MIGRATION_STATUS_WAIT_UNPLUG:
+    default:
         return false;
-    case MIGRATION_STATUS__MAX:
-        g_assert_not_reached();
     }
-
-    return false;
 }
 
 bool migration_is_active(void)
diff --git a/migration/migration.h b/migration/migration.h
index 6af01362d4..38aa1402d5 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -160,7 +160,7 @@ struct MigrationIncomingState {
     /* PostCopyFD's for external userfaultfds & handlers of shared memory */
     GArray   *postcopy_remote_fds;
 
-    int state;
+    MigrationStatus state;
 
     /*
      * The incoming migration coroutine, non-NULL during qemu_loadvm_state().
@@ -301,7 +301,7 @@ struct MigrationState {
     /* params from 'migrate-set-parameters' */
     MigrationParameters parameters;
 
-    int state;
+    MigrationStatus state;
 
     /* State related to return path */
     struct {
@@ -459,7 +459,8 @@ struct MigrationState {
     bool rdma_migration;
 };
 
-void migrate_set_state(int *state, int old_state, int new_state);
+void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
+                       MigrationStatus new_state);
 
 void migration_fd_process_incoming(QEMUFile *f);
 void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
@@ -479,7 +480,7 @@ int migrate_init(MigrationState *s, Error **errp);
 bool migration_is_blocked(Error **errp);
 /* True if outgoing migration has entered postcopy phase */
 bool migration_in_postcopy(void);
-bool migration_postcopy_is_alive(int state);
+bool migration_postcopy_is_alive(MigrationStatus state);
 MigrationState *migrate_get_current(void);
 bool migration_has_failed(MigrationState *);
 bool migrate_mode_is_cpr(MigrationState *);
-- 
2.35.3


