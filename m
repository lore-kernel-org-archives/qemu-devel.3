Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B39DE8FDB9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 21:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZFEb-0001Zt-Bu; Fri, 26 Dec 2025 16:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFEY-0001Wn-6V
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:20:26 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vZFEW-00049C-HC
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 16:20:25 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3CDF55BCE5;
 Fri, 26 Dec 2025 21:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766783993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CpioNFBDFseAudiqE/+vF5sojicQMZ0mCcG2JfPLxZM=;
 b=MWoKprGX8cqXJ518tBywc/9qIEEWzUcWjvBEuTcKZGIVQXkwJ3oq+0ouw28B1scUK31FTR
 0YlDVpeGgG8/zfJk51d+ZeZi0RA/A0gxl1peiV+gC7LpOuUZXWzyhpE5tRPIace4qGjfbk
 WF0jhYGRk+cCudO9Ka0lYunbv0HpslM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766783993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CpioNFBDFseAudiqE/+vF5sojicQMZ0mCcG2JfPLxZM=;
 b=bdLwD60T8DjKTOTRPswePsoQ5Y6u/Cc8uvCApbnLX1b1tXfjEwHC2NX7NfTrxLClm3SICx
 m0I/KPb81lnzw6Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766783993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CpioNFBDFseAudiqE/+vF5sojicQMZ0mCcG2JfPLxZM=;
 b=MWoKprGX8cqXJ518tBywc/9qIEEWzUcWjvBEuTcKZGIVQXkwJ3oq+0ouw28B1scUK31FTR
 0YlDVpeGgG8/zfJk51d+ZeZi0RA/A0gxl1peiV+gC7LpOuUZXWzyhpE5tRPIace4qGjfbk
 WF0jhYGRk+cCudO9Ka0lYunbv0HpslM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766783993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CpioNFBDFseAudiqE/+vF5sojicQMZ0mCcG2JfPLxZM=;
 b=bdLwD60T8DjKTOTRPswePsoQ5Y6u/Cc8uvCApbnLX1b1tXfjEwHC2NX7NfTrxLClm3SICx
 m0I/KPb81lnzw6Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3403E3EA63;
 Fri, 26 Dec 2025 21:19:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CIIZOff7TmnwJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 26 Dec 2025 21:19:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: [RFC PATCH 12/25] migration: Fold migration_cleanup() into
 migration_connect_error_propagate()
Date: Fri, 26 Dec 2025 18:19:14 -0300
Message-ID: <20251226211930.27565-13-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251226211930.27565-1-farosas@suse.de>
References: <20251226211930.27565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.984];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
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

Whenever an error occurs between migrate_init() and the start of
migration_thread, do cleanup immediately after.

This allows the special casing for resume to be removed from
migration_connect(), that check is now done at
migration_connect_error_propagate() which already had a case for
resume.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 0f1644b276..a66b2d7aaf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1576,15 +1576,21 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
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
@@ -1609,6 +1615,10 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
     }
 
     migrate_error_propagate(s, error);
+
+    if (!resume) {
+        migration_cleanup(s);
+    }
 }
 
 void migration_cancel(void)
@@ -2209,12 +2219,19 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
                                       GIOCondition cond,
                                       void *opaque)
 {
+    MigrationState *s = migrate_get_current();
     MigrationAddress *addr = opaque;
+    Error *local_err = NULL;
+
+    qmp_migrate_finish(addr, &local_err);
+
+    if (local_err) {
+        migration_connect_error_propagate(s, local_err);
+    }
 
-    qmp_migrate_finish(addr, NULL);
 
     cpr_state_close();
-    migrate_hup_delete(migrate_get_current());
+    migrate_hup_delete(s);
     qapi_free_MigrationAddress(addr);
     return G_SOURCE_REMOVE;
 }
@@ -2223,7 +2240,6 @@ void qmp_migrate(const char *uri, bool has_channels,
                  MigrationChannelList *channels, bool has_detach, bool detach,
                  bool has_resume, bool resume, Error **errp)
 {
-    Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
     g_autoptr(MigrationChannel) channel = NULL;
     MigrationAddress *addr = NULL;
@@ -2280,6 +2296,13 @@ void qmp_migrate(const char *uri, bool has_channels,
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
@@ -2299,12 +2322,11 @@ void qmp_migrate(const char *uri, bool has_channels,
                         QAPI_CLONE(MigrationAddress, addr));
 
     } else {
-        qmp_migrate_finish(addr, errp);
+        qmp_migrate_finish(addr, &local_err);
     }
 
 out:
     if (local_err) {
-        yank_unregister_instance(MIGRATION_YANK_INSTANCE);
         migration_connect_error_propagate(s, error_copy(local_err));
         error_propagate(errp, local_err);
     }
@@ -2335,12 +2357,6 @@ static void qmp_migrate_finish(MigrationAddress *addr, Error **errp)
     } else {
         error_setg(&local_err, "uri is not a valid migration protocol");
     }
-
-    if (local_err) {
-        migration_connect_error_propagate(s, error_copy(local_err));
-        error_propagate(errp, local_err);
-        return;
-    }
 }
 
 void qmp_migrate_cancel(Error **errp)
@@ -4027,9 +4043,6 @@ void migration_connect(MigrationState *s, Error *error_in)
     s->expected_downtime = migrate_downtime_limit();
     if (error_in) {
         migration_connect_error_propagate(s, error_in);
-        if (!resume) {
-            migration_cleanup(s);
-        }
         if (s->error) {
             error_report_err(error_copy(s->error));
         }
@@ -4108,7 +4121,6 @@ void migration_connect(MigrationState *s, Error *error_in)
 
 fail:
     migration_connect_error_propagate(s, local_err);
-    migration_cleanup(s);
     if (s->error) {
         error_report_err(error_copy(s->error));
     }
-- 
2.51.0


