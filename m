Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16B1D778AF
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 19:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjNFI-0003lh-03; Fri, 23 Jan 2026 14:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNFF-0003ix-OX
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:55:01 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjNFD-0003aC-RI
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 14:55:01 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1FB2A5BCC7;
 Fri, 23 Jan 2026 19:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBP99HjEEaobYKMdTt1XjdtLBJtwI6qoL14gQOQ+EGw=;
 b=mT6X8SMrs9A3YoCsUQDIGExyL94BTqjr2Uecv6uX/IFrNoNUNrYPFM5KBnvBXuPZhjMhFC
 H4IjNHJru79rzijBkZLrizrB9VUB3O5pqsZ3tiolu831M8fdbRXrhsGf5NcTRhkTk/QaH9
 xwLrN7TdFGpy8b3Wfbp8oJfa27o47eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198074;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBP99HjEEaobYKMdTt1XjdtLBJtwI6qoL14gQOQ+EGw=;
 b=R4Kd/md31R9B5y/JXJVaQexzQWxdAD3kBQGxqKHtqnz3Ww198NZ3rDW6Kb1SwJTmfKJ8vN
 JtS9UJni1Z0EjwBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mT6X8SMr;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="R4Kd/md3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769198074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBP99HjEEaobYKMdTt1XjdtLBJtwI6qoL14gQOQ+EGw=;
 b=mT6X8SMrs9A3YoCsUQDIGExyL94BTqjr2Uecv6uX/IFrNoNUNrYPFM5KBnvBXuPZhjMhFC
 H4IjNHJru79rzijBkZLrizrB9VUB3O5pqsZ3tiolu831M8fdbRXrhsGf5NcTRhkTk/QaH9
 xwLrN7TdFGpy8b3Wfbp8oJfa27o47eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769198074;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBP99HjEEaobYKMdTt1XjdtLBJtwI6qoL14gQOQ+EGw=;
 b=R4Kd/md31R9B5y/JXJVaQexzQWxdAD3kBQGxqKHtqnz3Ww198NZ3rDW6Kb1SwJTmfKJ8vN
 JtS9UJni1Z0EjwBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC8A31395E;
 Fri, 23 Jan 2026 19:54:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sHbiHvjRc2lFZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 19:54:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PULL 21/36] migration: yank: Move register instance earlier
Date: Fri, 23 Jan 2026 16:53:36 -0300
Message-ID: <20260123195352.12850-22-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123195352.12850-1-farosas@suse.de>
References: <20260123195352.12850-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1FB2A5BCC7
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Move the register_instance call to migrate_prepare() so it can be
paired with the unregister_instance at migration_cleanup(). Otherwise,
the cleanup cannot be run when cpr_state_save() fails because the
instance is registered only after it.

When resuming from a paused postcopy migration, migrate_prepare()
returns early, but migration_cleanup() doesn't run, so the yank will
remain paired.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
Link: https://lore.kernel.org/qemu-devel/20260123141656.6765-11-farosas@suse.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index a83edb39a0..fd67076b1d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2177,11 +2177,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
         return false;
     }
 
+    yank_register_instance(MIGRATION_YANK_INSTANCE, &error_abort);
+
     return true;
 }
 
-static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
-                               Error **errp);
+static void qmp_migrate_finish(MigrationAddress *addr, Error **errp);
 
 static void migrate_hup_add(MigrationState *s, QIOChannel *ioc, GSourceFunc cb,
                             void *opaque)
@@ -2206,7 +2207,7 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
 {
     MigrationAddress *addr = opaque;
 
-    qmp_migrate_finish(addr, false, NULL);
+    qmp_migrate_finish(addr, NULL);
 
     cpr_state_close();
     migrate_hup_delete(migrate_get_current());
@@ -2218,7 +2219,6 @@ void qmp_migrate(const char *uri, bool has_channels,
                  MigrationChannelList *channels,
                  bool has_resume, bool resume, Error **errp)
 {
-    bool resume_requested;
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
     g_autoptr(MigrationChannel) channel = NULL;
@@ -2271,8 +2271,7 @@ void qmp_migrate(const char *uri, bool has_channels,
         return;
     }
 
-    resume_requested = has_resume && resume;
-    if (!migrate_prepare(s, resume_requested, errp)) {
+    if (!migrate_prepare(s, has_resume && resume, errp)) {
         /* Error detected, put into errp */
         return;
     }
@@ -2296,28 +2295,22 @@ void qmp_migrate(const char *uri, bool has_channels,
                         QAPI_CLONE(MigrationAddress, addr));
 
     } else {
-        qmp_migrate_finish(addr, resume_requested, errp);
+        qmp_migrate_finish(addr, errp);
     }
 
 out:
     if (local_err) {
+        yank_unregister_instance(MIGRATION_YANK_INSTANCE);
         migration_connect_error_propagate(s, error_copy(local_err));
         error_propagate(errp, local_err);
     }
 }
 
-static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
-                               Error **errp)
+static void qmp_migrate_finish(MigrationAddress *addr, Error **errp)
 {
     MigrationState *s = migrate_get_current();
     Error *local_err = NULL;
 
-    if (!resume_requested) {
-        if (!yank_register_instance(MIGRATION_YANK_INSTANCE, errp)) {
-            return;
-        }
-    }
-
     if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
         SocketAddress *saddr = &addr->u.socket;
         if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
@@ -2340,9 +2333,6 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
     }
 
     if (local_err) {
-        if (!resume_requested) {
-            yank_unregister_instance(MIGRATION_YANK_INSTANCE);
-        }
         migration_connect_error_propagate(s, error_copy(local_err));
         error_propagate(errp, local_err);
         return;
-- 
2.51.0


