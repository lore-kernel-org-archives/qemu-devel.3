Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81057C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 16:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpXe-0004Gt-1T; Fri, 17 Jan 2025 11:49:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tYpXb-0004Eu-J3
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:49:51 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tYpXZ-0001FC-QW
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:49:51 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1BE722127D;
 Fri, 17 Jan 2025 16:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737132588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BjAj9j2Mu3ERmDGxPvM86EF0ypFQaroTiVtOoUfNLn0=;
 b=SAPuuMkSrsVhoJvfuRK46RPCcqi2Zvb33edYy/8bvjVNR0LroUPde9iOLi9io+yLehgsDx
 upJ4rHMyYWFnIuLru9Hq/r0N2P7EkGNQKf/XW3SXIo5tqkuppzNZFNsUsKneQR5MCt1EPM
 I/XBjDHfFtTKlcgeFC5rBB8VPfWZ3FA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737132588;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BjAj9j2Mu3ERmDGxPvM86EF0ypFQaroTiVtOoUfNLn0=;
 b=nXBXvStyYtLV9kS/6sEb/rMrz7dvYSeB50AUILhnbtd3H3NGhO9s9wLkLS7P8cFs63GYRO
 +fC/MW+HBbOmyPAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SAPuuMkS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nXBXvSty
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737132588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BjAj9j2Mu3ERmDGxPvM86EF0ypFQaroTiVtOoUfNLn0=;
 b=SAPuuMkSrsVhoJvfuRK46RPCcqi2Zvb33edYy/8bvjVNR0LroUPde9iOLi9io+yLehgsDx
 upJ4rHMyYWFnIuLru9Hq/r0N2P7EkGNQKf/XW3SXIo5tqkuppzNZFNsUsKneQR5MCt1EPM
 I/XBjDHfFtTKlcgeFC5rBB8VPfWZ3FA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737132588;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BjAj9j2Mu3ERmDGxPvM86EF0ypFQaroTiVtOoUfNLn0=;
 b=nXBXvStyYtLV9kS/6sEb/rMrz7dvYSeB50AUILhnbtd3H3NGhO9s9wLkLS7P8cFs63GYRO
 +fC/MW+HBbOmyPAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB6E613332;
 Fri, 17 Jan 2025 16:49:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OPsCGiqKimftQgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 17 Jan 2025 16:49:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 4/5] tests/qtest/migration: Use out-of-band execution for
 migrate-recover
Date: Fri, 17 Jan 2025 13:49:35 -0300
Message-Id: <20250117164936.22223-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250117164936.22223-1-farosas@suse.de>
References: <20250117164936.22223-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1BE722127D
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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

From: Juraj Marcin <jmarcin@redhat.com>

In real use cases, the migrate-recover command requires out-of-band
execution, because the thread processing normal commands is blocked by a
page fault in the guest memory. With this change, the tests will be
closer to real use cases and could help detect regressions and other
bugs in migration recovery.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c     | 23 +++++++++++++++++++++--
 tests/qtest/migration/framework.h     |  2 ++
 tests/qtest/migration/migration-qmp.c |  2 +-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 47ce07856e..4550cda129 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -194,6 +194,16 @@ static void cleanup(const char *filename)
     unlink(path);
 }
 
+static QList *migrate_start_get_qmp_capabilities(const MigrateStart *args)
+{
+    QList *capabilities = qlist_new();
+
+    if (args->oob) {
+        qlist_append_str(capabilities, "oob");
+    }
+    return capabilities;
+}
+
 int migrate_start(QTestState **from, QTestState **to, const char *uri,
                   MigrateStart *args)
 {
@@ -210,6 +220,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     const char *machine_alias, *machine_opts = "";
     g_autofree char *machine = NULL;
     const char *bootpath;
+    g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
 
     if (args->use_shmem) {
         if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
@@ -314,7 +325,8 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                  args->opts_source ? args->opts_source : "",
                                  ignore_stderr);
     if (!args->only_target) {
-        *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source);
+        *from = qtest_init_with_env_and_capabilities(QEMU_ENV_SRC, cmd_source,
+                                                     capabilities);
         qtest_qmp_set_event_callback(*from,
                                      migrate_watch_for_events,
                                      &src_state);
@@ -334,7 +346,8 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
-    *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target);
+    *to = qtest_init_with_env_and_capabilities(QEMU_ENV_DST, cmd_target,
+                                               capabilities);
     qtest_qmp_set_event_callback(*to,
                                  migrate_watch_for_events,
                                  &dst_state);
@@ -601,6 +614,12 @@ void test_postcopy_recovery_common(MigrateCommon *args)
     QTestState *from, *to;
     g_autofree char *uri = NULL;
 
+    /*
+     * Always enable OOB QMP capability for recovery tests, migrate-recover is
+     * executed out-of-band
+     */
+    args->start.oob = true;
+
     /* Always hide errors for postcopy recover tests since they're expected */
     args->start.hide_stderr = true;
 
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index e9fc4ec363..7991ee56b6 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -109,6 +109,8 @@ typedef struct {
     const char *opts_target;
     /* suspend the src before migrating to dest. */
     bool suspend_me;
+    /* enable OOB QMP capability */
+    bool oob;
 } MigrateStart;
 
 typedef enum PostcopyRecoveryFailStage {
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index 71b14b51b2..9431d2beda 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -464,7 +464,7 @@ void migrate_continue(QTestState *who, const char *state)
 void migrate_recover(QTestState *who, const char *uri)
 {
     qtest_qmp_assert_success(who,
-                             "{ 'execute': 'migrate-recover', "
+                             "{ 'exec-oob': 'migrate-recover', "
                              "  'id': 'recover-cmd', "
                              "  'arguments': { 'uri': %s } }",
                              uri);
-- 
2.35.3


