Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC998C369B1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 19:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Jrf-0005o6-S1; Fri, 11 Apr 2025 15:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3Jr5-00050W-Jt
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 15:16:04 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3Jr3-0006LF-N8
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 15:15:59 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 15E6B21195;
 Fri, 11 Apr 2025 19:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744398914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMSYZrglyZ0bVCrbEJjpGUCI3SzYAtQY0LUNx1m5Tfc=;
 b=P58p2MLKytH/D+lg/4KMLQr5vFmc7Q2ufi8oIYKKotcMH6b+M/2UVXs+/pscQfWEaGfPZg
 tl9D9pX0UFPEvQgjvY8Lyv5MukLDdbZvUBNvlsQ/wIDqZKO+uz6F2ZBxoPdcq4POkd+cfT
 9b0KS//2NN/JetAyxD9Or7Epka5eeY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744398914;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMSYZrglyZ0bVCrbEJjpGUCI3SzYAtQY0LUNx1m5Tfc=;
 b=7JsoBV/7E18D+oPbkw4ZEjR7wUE3AM38g/4Sl3frk3uHK00oj5GF4xP3tL9nWvKEzWFf7w
 CV3/HiJf7g5Q4tAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=P58p2MLK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="7JsoBV/7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744398914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMSYZrglyZ0bVCrbEJjpGUCI3SzYAtQY0LUNx1m5Tfc=;
 b=P58p2MLKytH/D+lg/4KMLQr5vFmc7Q2ufi8oIYKKotcMH6b+M/2UVXs+/pscQfWEaGfPZg
 tl9D9pX0UFPEvQgjvY8Lyv5MukLDdbZvUBNvlsQ/wIDqZKO+uz6F2ZBxoPdcq4POkd+cfT
 9b0KS//2NN/JetAyxD9Or7Epka5eeY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744398914;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMSYZrglyZ0bVCrbEJjpGUCI3SzYAtQY0LUNx1m5Tfc=;
 b=7JsoBV/7E18D+oPbkw4ZEjR7wUE3AM38g/4Sl3frk3uHK00oj5GF4xP3tL9nWvKEzWFf7w
 CV3/HiJf7g5Q4tAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F2FD13886;
 Fri, 11 Apr 2025 19:15:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ID7eE0Bq+We5WQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Apr 2025 19:15:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 13/13] [PoC] migration: Allow migrate commands to provide
 the migration config
Date: Fri, 11 Apr 2025 16:14:43 -0300
Message-Id: <20250411191443.22565-14-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250411191443.22565-1-farosas@suse.de>
References: <20250411191443.22565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 15E6B21195
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Allow the migrate and migrate_incoming commands to pass the migration
configuration options all at once, dispensing the use of
migrate-set-parameters and migrate-set-capabilities.

The motivation of this is to simplify the interface with the
management layer and avoid the usage of several command invocations to
configure a migration. It also avoids stale parameters from a previous
migration to influence the current migration.

The options that are changed during the migration can still be set
with the existing commands.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c |  5 +++--
 migration/migration.c          |  8 ++++----
 qapi/migration.json            | 10 ++++++++++
 system/vl.c                    |  3 ++-
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 49c26daed3..44d2265002 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -429,7 +429,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
     }
     QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
 
-    qmp_migrate_incoming(NULL, true, caps, true, false, &err);
+    qmp_migrate_incoming(NULL, true, caps, NULL, true, false, &err);
     qapi_free_MigrationChannelList(caps);
 
 end:
@@ -715,7 +715,8 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     }
     QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
 
-    qmp_migrate(NULL, true, caps, false, false, true, resume, &err);
+    qmp_migrate(NULL, true, caps, NULL, false, false, true, resume,
+                &err);
     if (hmp_handle_error(mon, err)) {
         return;
     }
diff --git a/migration/migration.c b/migration/migration.c
index 55d839abd0..a1f04cef32 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1894,8 +1894,8 @@ void migrate_del_blocker(Error **reasonp)
 
 void qmp_migrate_incoming(const char *uri, bool has_channels,
                           MigrationChannelList *channels,
-                          bool has_exit_on_error, bool exit_on_error,
-                          Error **errp)
+                          MigrationConfig *config, bool has_exit_on_error,
+                          bool exit_on_error, Error **errp)
 {
     Error *local_err = NULL;
     static bool once = true;
@@ -2159,8 +2159,8 @@ static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
     return G_SOURCE_REMOVE;
 }
 
-void qmp_migrate(const char *uri, bool has_channels,
-                 MigrationChannelList *channels, bool has_detach, bool detach,
+void qmp_migrate(const char *uri, bool has_channels, MigrationChannelList *channels,
+                 MigrationConfig *config, bool has_detach, bool detach,
                  bool has_resume, bool resume, Error **errp)
 {
     bool resume_requested;
diff --git a/qapi/migration.json b/qapi/migration.json
index bb2487dbc6..5bd8f0f1b2 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1638,6 +1638,10 @@
 #
 # @resume: resume one paused migration, default "off".  (since 3.0)
 #
+# @config: migration configuration options, previously set via
+#     @migrate-set-parameters and @migrate-set-capabilities.  (since
+#     10.1)
+#
 # Since: 0.14
 #
 # .. admonition:: Notes
@@ -1702,6 +1706,7 @@
 { 'command': 'migrate',
   'data': {'*uri': 'str',
            '*channels': [ 'MigrationChannel' ],
+           '*config': 'MigrationConfig',
            '*detach': 'bool', '*resume': 'bool' } }
 
 ##
@@ -1721,6 +1726,10 @@
 #     error details could be retrieved with query-migrate.
 #     (since 9.1)
 #
+# @config: migration configuration options, previously set via
+#     @migrate-set-parameters and @migrate-set-capabilities.  (since
+#     10.1)
+#
 # Since: 2.3
 #
 # .. admonition:: Notes
@@ -1774,6 +1783,7 @@
 { 'command': 'migrate-incoming',
              'data': {'*uri': 'str',
                       '*channels': [ 'MigrationChannel' ],
+                      '*config': 'MigrationConfig',
                       '*exit-on-error': 'bool' } }
 
 ##
diff --git a/system/vl.c b/system/vl.c
index ec93988a03..ea7040ef8d 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2826,7 +2826,8 @@ void qmp_x_exit_preconfig(Error **errp)
                 g_new0(MigrationChannelList, 1);
 
             channels->value = incoming_channels[MIGRATION_CHANNEL_TYPE_MAIN];
-            qmp_migrate_incoming(NULL, true, channels, true, true, &local_err);
+            qmp_migrate_incoming(NULL, true, channels, NULL, true, true,
+                                 &local_err);
             if (local_err) {
                 error_reportf_err(local_err, "-incoming %s: ", incoming);
                 exit(1);
-- 
2.35.3


