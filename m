Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984BBD1A610
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 12:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veBne-0003MO-Mo; Fri, 09 Jan 2026 07:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBnc-0003M3-Ss
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:41:05 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1veBnb-0007F4-1o
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 07:41:04 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4D903337BA;
 Fri,  9 Jan 2026 12:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFGOeHScnw8iEsCunXW8i4HluIN89SgF28fJkpUUecc=;
 b=IvIBL2wDnUH1ZVgfwWXZUGQJOVXIdw/nto2uBxG3uCXgljAkzxzMgwkrdUuE5E+l6i2Pwp
 KZp+R4zQViBSwNd4gPmcD/lHZPMvBUjP+P56oHicgcO7N1gSuStPrTQsTFrsZYysmnIfLq
 1qW1lFlwXY5R6ao7Um7tTCYDHJMej+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962461;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFGOeHScnw8iEsCunXW8i4HluIN89SgF28fJkpUUecc=;
 b=FACjYZjbUDKyQOQzEFLmEJMP0EOTsbv/zf+sgodlmoS8Hu/3teU3FES3yH8o+NeXsQA2b+
 W1+kM6R/RiPXVIBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=g+Ifxvue;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UmvYDI6M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767962460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFGOeHScnw8iEsCunXW8i4HluIN89SgF28fJkpUUecc=;
 b=g+Ifxvuemk43JK+GstAEJZZsFHUrBEj7M02RrqdW806YV2UvR/jcnTeqFH2kjghMh9ib2E
 2werIM6DlIPRTTQDFLyLsjWORGwY4zPzRdFY+VhJTzxV1H0yJmnS3Rqrr0Xxbj6V9WKnY8
 ZbW4osON5nLUwpLEISxMid5C90h/E14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767962460;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFGOeHScnw8iEsCunXW8i4HluIN89SgF28fJkpUUecc=;
 b=UmvYDI6MW1O5WblOPx4Kty745lkSwbHsK0fAKYYmA1lfTnQ9zP+1dQ6mSTSt2zrDTwj4/I
 TQFpRc7At8OA9OBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76DE13EA63;
 Fri,  9 Jan 2026 12:40:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aEfADVr3YGkkQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 Jan 2026 12:40:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>
Subject: [PATCH v3 06/25] migration: Use migrate_mode() to query for
 cpr-transfer
Date: Fri,  9 Jan 2026 09:40:22 -0300
Message-ID: <20260109124043.25019-7-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109124043.25019-1-farosas@suse.de>
References: <20260109124043.25019-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4D903337BA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

cpr_set_incoming_mode() is only called on the target side, so
migrate_mode() on the source side is the same as s->parameters.mode.

Use the function to reduce explicit access to s->parameters, we have
options.c for that.

Cc: Mark Kanda <mark.kanda@oracle.com>
Cc: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/cpr-exec.c  |  2 +-
 migration/migration.c | 27 +++++++++++++--------------
 migration/migration.h |  5 ++---
 3 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index da287d8031..e315a30f92 100644
--- a/migration/cpr-exec.c
+++ b/migration/cpr-exec.c
@@ -164,7 +164,7 @@ static void cpr_exec_cb(void *opaque)
     err = NULL;
 
     /* Note, we can go from state COMPLETED to FAILED */
-    migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
+    migration_call_notifiers(MIG_EVENT_PRECOPY_FAILED, NULL);
 
     if (!migration_block_activate(&err)) {
         /* error was already reported */
diff --git a/migration/migration.c b/migration/migration.c
index 4af5baad59..388e0be5a2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1534,7 +1534,7 @@ static void migration_cleanup(MigrationState *s)
     }
     type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
                                      MIG_EVENT_PRECOPY_DONE;
-    migration_call_notifiers(s, type, NULL);
+    migration_call_notifiers(type, NULL);
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
 
@@ -1696,10 +1696,9 @@ void migration_remove_notifier(NotifierWithReturn *notify)
     }
 }
 
-int migration_call_notifiers(MigrationState *s, MigrationEventType type,
-                             Error **errp)
+int migration_call_notifiers(MigrationEventType type, Error **errp)
 {
-    MigMode mode = s->parameters.mode;
+    MigMode mode = migrate_mode();
     MigrationEvent e;
     NotifierWithReturn *notifier;
     GSList *elem, *next;
@@ -1780,9 +1779,9 @@ bool migration_thread_is_self(void)
     return qemu_thread_is_self(&s->thread);
 }
 
-bool migrate_mode_is_cpr(MigrationState *s)
+bool migrate_mode_is_cpr(void)
 {
-    MigMode mode = s->parameters.mode;
+    MigMode mode = migrate_mode();
     return mode == MIG_MODE_CPR_REBOOT ||
            mode == MIG_MODE_CPR_TRANSFER ||
            mode == MIG_MODE_CPR_EXEC;
@@ -2136,7 +2135,7 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
         }
     }
 
-    if (migrate_mode_is_cpr(s)) {
+    if (migrate_mode_is_cpr()) {
         const char *conflict = NULL;
 
         if (migrate_postcopy()) {
@@ -2252,7 +2251,7 @@ void qmp_migrate(const char *uri, bool has_channels,
         return;
     }
 
-    if (s->parameters.mode == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
+    if (migrate_mode() == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
         error_setg(errp, "missing 'cpr' migration channel");
         return;
     }
@@ -2277,7 +2276,7 @@ void qmp_migrate(const char *uri, bool has_channels,
      * in which case the target will not listen for the incoming migration
      * connection, so qmp_migrate_finish will fail to connect, and then recover.
      */
-    if (s->parameters.mode == MIG_MODE_CPR_TRANSFER) {
+    if (migrate_mode() == MIG_MODE_CPR_TRANSFER) {
         migrate_hup_add(s, cpr_state_ioc(), (GSourceFunc)qmp_migrate_finish_cb,
                         QAPI_CLONE(MigrationAddress, addr));
 
@@ -2852,7 +2851,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      * at the transition to postcopy and after the device state; in particular
      * spice needs to trigger a transition now
      */
-    migration_call_notifiers(ms, MIG_EVENT_PRECOPY_DONE, NULL);
+    migration_call_notifiers(MIG_EVENT_PRECOPY_DONE, NULL);
 
     migration_downtime_end(ms);
 
@@ -2901,7 +2900,7 @@ fail:
         migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
     }
     migration_block_activate(NULL);
-    migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
+    migration_call_notifiers(MIG_EVENT_PRECOPY_FAILED, NULL);
     bql_unlock();
     return -1;
 }
@@ -3003,7 +3002,7 @@ static int migration_completion_precopy(MigrationState *s)
 
     bql_lock();
 
-    if (!migrate_mode_is_cpr(s)) {
+    if (!migrate_mode_is_cpr()) {
         ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
         if (ret < 0) {
             goto out_unlock;
@@ -4049,7 +4048,7 @@ void migration_connect(MigrationState *s, Error *error_in)
         rate_limit = migrate_max_bandwidth();
 
         /* Notify before starting migration thread */
-        if (migration_call_notifiers(s, MIG_EVENT_PRECOPY_SETUP, &local_err)) {
+        if (migration_call_notifiers(MIG_EVENT_PRECOPY_SETUP, &local_err)) {
             goto fail;
         }
     }
@@ -4085,7 +4084,7 @@ void migration_connect(MigrationState *s, Error *error_in)
         return;
     }
 
-    if (migrate_mode_is_cpr(s)) {
+    if (migrate_mode_is_cpr()) {
         ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
         if (ret < 0) {
             error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
diff --git a/migration/migration.h b/migration/migration.h
index ccc4e536a5..8b55d4741a 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -538,8 +538,7 @@ bool migrate_has_error(MigrationState *s);
 
 void migration_connect(MigrationState *s, Error *error_in);
 
-int migration_call_notifiers(MigrationState *s, MigrationEventType type,
-                             Error **errp);
+int migration_call_notifiers(MigrationEventType type, Error **errp);
 
 int migrate_init(MigrationState *s, Error **errp);
 bool migration_is_blocked(Error **errp);
@@ -548,7 +547,7 @@ bool migration_in_postcopy(void);
 bool migration_postcopy_is_alive(MigrationStatus state);
 MigrationState *migrate_get_current(void);
 bool migration_has_failed(MigrationState *);
-bool migrate_mode_is_cpr(MigrationState *);
+bool migrate_mode_is_cpr(void);
 
 uint64_t ram_get_total_transferred_pages(void);
 
-- 
2.51.0


