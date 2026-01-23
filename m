Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FEBD778B3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjNFN-0004Js-69; Fri, 23 Jan 2026 14:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNFL-00048j-9a
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:55:07 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNFJ-0003m3-C8
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:55:07 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E107C5BCD2;
 Fri, 23 Jan 2026 19:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjukEcgl+gQCfY31fWpmdzDxbrNvPcADxA8CPWKzUHo=;
 b=QHhZQno2XYkdN30CwfzgVIHcVa9hGelZxja4zI+fsC8o7xjxDtBx4zTT7GAscet+OT3bwK
 /K7u99U9xrzYRfLkFDK/2nZWRlmDl01t3CHDV95tgf6cvzSyuyLiYW+sTvnBdqqr7LQ49d
 /sEyxEtEptUYIOUWohbO7bn9+PLxMb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjukEcgl+gQCfY31fWpmdzDxbrNvPcADxA8CPWKzUHo=;
 b=5OZX/XfwMgh8F3mkLnLtGMMeO4JRJV5doQLJ8o61+6VklTA5rnOaVw/3g5ZMn+BMqkZAq7
 0Cm1Scy9ZTpV4sAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjukEcgl+gQCfY31fWpmdzDxbrNvPcADxA8CPWKzUHo=;
 b=QHhZQno2XYkdN30CwfzgVIHcVa9hGelZxja4zI+fsC8o7xjxDtBx4zTT7GAscet+OT3bwK
 /K7u99U9xrzYRfLkFDK/2nZWRlmDl01t3CHDV95tgf6cvzSyuyLiYW+sTvnBdqqr7LQ49d
 /sEyxEtEptUYIOUWohbO7bn9+PLxMb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MjukEcgl+gQCfY31fWpmdzDxbrNvPcADxA8CPWKzUHo=;
 b=5OZX/XfwMgh8F3mkLnLtGMMeO4JRJV5doQLJ8o61+6VklTA5rnOaVw/3g5ZMn+BMqkZAq7
 0Cm1Scy9ZTpV4sAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D68D1395E;
 Fri, 23 Jan 2026 19:54:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yEFHE/rRc2lFZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 19:54:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 22/36] migration: Fold migration_cleanup() into
 migration_connect_error_propagate()
Date: Fri, 23 Jan 2026 16:53:37 -0300
Message-ID: <20260123195352.12850-23-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123195352.12850-1-farosas@suse.de>
References: <20260123195352.12850-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
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

Whenever an error occurs between migrate_init() and the start of
migration_thread, do cleanup immediately.

This allows the special casing for resume to be removed from
migration_connect(), that check is now done at
migration_connect_error_propagate() which already had a case for
resume.

The cleanup at qmp_migrate_finish_cb can also be removed because it
will always be reached either via the error path at
qmp_migrate_finish->migration_connect_error_propagate or via the
migrate_cleanup_bh.

The yank_unregister_instance at qmp_migrate() is now replaced by the
one at migration_cleanup().

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Link: https://lore.kernel.org/qemu-devel/20260123141656.6765-12-farosas@suse.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index fd67076b1d..a78c2f4840 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1573,15 +1573,21 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
 {
     MigrationStatus current = s->state;
     MigrationStatus next = MIGRATION_STATUS_NONE;
+    bool resume = false;
 
     switch (current) {
     case MIGRATION_STATUS_SETUP:
         next = MIGRATION_STATUS_FAILED;
         break;
 
+    case MIGRATION_STATUS_POSTCOPY_PAUSED:
+        resume = true;
+        break;
+
     case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
         /* Never fail a postcopy migration; switch back to PAUSED instead */
         next = MIGRATION_STATUS_POSTCOPY_PAUSED;
+        resume = true;
         break;
 
     case MIGRATION_STATUS_CANCELLING:
@@ -1606,6 +1612,10 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
     }
 
     migrate_error_propagate(s, error);
+
+    if (!resume) {
+        migration_cleanup(s);
+    }
 }
 
 void migration_cancel(void)
@@ -2208,9 +2218,6 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
     MigrationAddress *addr = opaque;
 
     qmp_migrate_finish(addr, NULL);
-
-    cpr_state_close();
-    migrate_hup_delete(migrate_get_current());
     qapi_free_MigrationAddress(addr);
     return G_SOURCE_REMOVE;
 }
@@ -2219,7 +2226,6 @@ void qmp_migrate(const char *uri, bool has_channels,
                  MigrationChannelList *channels,
                  bool has_resume, bool resume, Error **errp)
 {
-    Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
     g_autoptr(MigrationChannel) channel = NULL;
     MigrationAddress *addr = NULL;
@@ -2276,6 +2282,13 @@ void qmp_migrate(const char *uri, bool has_channels,
         return;
     }
 
+    /*
+     * The migrate_prepare() above calls migrate_init(). From this
+     * point on, until the end of migration, make sure any failures
+     * eventually result in a call to migration_cleanup().
+     */
+    Error *local_err = NULL;
+
     if (!cpr_state_save(cpr_channel, &local_err)) {
         goto out;
     }
@@ -2300,7 +2313,6 @@ void qmp_migrate(const char *uri, bool has_channels,
 
 out:
     if (local_err) {
-        yank_unregister_instance(MIGRATION_YANK_INSTANCE);
         migration_connect_error_propagate(s, error_copy(local_err));
         error_propagate(errp, local_err);
     }
@@ -4018,9 +4030,6 @@ void migration_connect(MigrationState *s, Error *error_in)
     s->expected_downtime = migrate_downtime_limit();
     if (error_in) {
         migration_connect_error_propagate(s, error_in);
-        if (!resume) {
-            migration_cleanup(s);
-        }
         if (s->error) {
             error_report_err(error_copy(s->error));
         }
@@ -4099,7 +4108,6 @@ void migration_connect(MigrationState *s, Error *error_in)
 
 fail:
     migration_connect_error_propagate(s, local_err);
-    migration_cleanup(s);
     if (s->error) {
         error_report_err(error_copy(s->error));
     }
-- 
2.51.0


