Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F668D74ED3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjHzc-0002D6-4F; Fri, 23 Jan 2026 09:18:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjHz0-0000UE-62
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:17:56 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjHyy-0003h3-C4
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:17:53 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 883CD33812;
 Fri, 23 Jan 2026 14:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769177847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCayuFmc9Ylos3QSBYyrLOGg1tnSbP2u2gpw6OUOL5g=;
 b=pRy1VoxdexH278u5dwFcxtd3rdgxqH31o7xSJL1Jfw2xi/jXDRkxT8Uc/wxUqCqAniws4v
 J1h9cRWY+nTai/fdWPRNzZZ9itpSHC9L84sDvJBjh98PkqqgnhDnnRTEz2dE6kfCpXI0Ww
 M1f2iZNOA2JvfiXNqs+uKkm12pDatio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769177847;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCayuFmc9Ylos3QSBYyrLOGg1tnSbP2u2gpw6OUOL5g=;
 b=nRFiqxXBtPV0UtZc42OJdd5she1W9jEE2XW36PR12YCF/oFKtARIFfJbE7fsw2zL6IKK5I
 FoNVd1zhQzVTyyCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pRy1Voxd;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nRFiqxXB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769177847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCayuFmc9Ylos3QSBYyrLOGg1tnSbP2u2gpw6OUOL5g=;
 b=pRy1VoxdexH278u5dwFcxtd3rdgxqH31o7xSJL1Jfw2xi/jXDRkxT8Uc/wxUqCqAniws4v
 J1h9cRWY+nTai/fdWPRNzZZ9itpSHC9L84sDvJBjh98PkqqgnhDnnRTEz2dE6kfCpXI0Ww
 M1f2iZNOA2JvfiXNqs+uKkm12pDatio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769177847;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCayuFmc9Ylos3QSBYyrLOGg1tnSbP2u2gpw6OUOL5g=;
 b=nRFiqxXBtPV0UtZc42OJdd5she1W9jEE2XW36PR12YCF/oFKtARIFfJbE7fsw2zL6IKK5I
 FoNVd1zhQzVTyyCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B02211395E;
 Fri, 23 Jan 2026 14:17:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wPojHPWCc2m8HAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 14:17:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, berrange@redhat.com, ppandit@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v4 11/25] migration: Fold migration_cleanup() into
 migration_connect_error_propagate()
Date: Fri, 23 Jan 2026 11:16:41 -0300
Message-ID: <20260123141656.6765-12-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123141656.6765-1-farosas@suse.de>
References: <20260123141656.6765-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL3zxdrj4h6o64essgck3rrntz)];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email,fedoraproject.org:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 883CD33812
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
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 2605eb2d10..c3c1a09a6e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1574,15 +1574,21 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
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
@@ -1607,6 +1613,10 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
     }
 
     migrate_error_propagate(s, error);
+
+    if (!resume) {
+        migration_cleanup(s);
+    }
 }
 
 void migration_cancel(void)
@@ -2209,9 +2219,6 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
     MigrationAddress *addr = opaque;
 
     qmp_migrate_finish(addr, NULL);
-
-    cpr_state_close();
-    migrate_hup_delete(migrate_get_current());
     qapi_free_MigrationAddress(addr);
     return G_SOURCE_REMOVE;
 }
@@ -2220,7 +2227,6 @@ void qmp_migrate(const char *uri, bool has_channels,
                  MigrationChannelList *channels, bool has_detach, bool detach,
                  bool has_resume, bool resume, Error **errp)
 {
-    Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
     g_autoptr(MigrationChannel) channel = NULL;
     MigrationAddress *addr = NULL;
@@ -2277,6 +2283,13 @@ void qmp_migrate(const char *uri, bool has_channels,
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
@@ -2301,7 +2314,6 @@ void qmp_migrate(const char *uri, bool has_channels,
 
 out:
     if (local_err) {
-        yank_unregister_instance(MIGRATION_YANK_INSTANCE);
         migration_connect_error_propagate(s, error_copy(local_err));
         error_propagate(errp, local_err);
     }
@@ -4024,9 +4036,6 @@ void migration_connect(MigrationState *s, Error *error_in)
     s->expected_downtime = migrate_downtime_limit();
     if (error_in) {
         migration_connect_error_propagate(s, error_in);
-        if (!resume) {
-            migration_cleanup(s);
-        }
         if (s->error) {
             error_report_err(error_copy(s->error));
         }
@@ -4105,7 +4114,6 @@ void migration_connect(MigrationState *s, Error *error_in)
 
 fail:
     migration_connect_error_propagate(s, local_err);
-    migration_cleanup(s);
     if (s->error) {
         error_report_err(error_copy(s->error));
     }
-- 
2.51.0


