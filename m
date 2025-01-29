Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436BAC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAW6-0003j7-KK; Wed, 29 Jan 2025 11:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVj-0003Jj-BW
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:52 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVh-0005K0-6P
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:51 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0BDD61F365;
 Wed, 29 Jan 2025 16:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W0hKLwNtge3IEeKEZWAzFdq1zJGNWX+FsIZwPUvFO8Y=;
 b=JVO3iea4zC4c00+wN7eNPi9gxliTMyzai5xc7/umwEFYrOML3ssXa1yMzZONmPO3IShX8t
 BcspNtlnVvmHgIUvDuT6enASIwOAbWN+Sn+c8Lf9EXoq0LBpQ5weeG4hZ3P9brHjmoUowk
 vFR00obe+J0hu91w70/sX2EW4PM+fxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166508;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W0hKLwNtge3IEeKEZWAzFdq1zJGNWX+FsIZwPUvFO8Y=;
 b=RF6lANcxNtvS7Bp5YQvDRG30eDF0BxW1wysFAlgiLMoEnpU/8dTCkQdArBFORqIKbvN/xU
 iuCWDf0DHmBNWjDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JVO3iea4;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RF6lANcx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W0hKLwNtge3IEeKEZWAzFdq1zJGNWX+FsIZwPUvFO8Y=;
 b=JVO3iea4zC4c00+wN7eNPi9gxliTMyzai5xc7/umwEFYrOML3ssXa1yMzZONmPO3IShX8t
 BcspNtlnVvmHgIUvDuT6enASIwOAbWN+Sn+c8Lf9EXoq0LBpQ5weeG4hZ3P9brHjmoUowk
 vFR00obe+J0hu91w70/sX2EW4PM+fxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166508;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W0hKLwNtge3IEeKEZWAzFdq1zJGNWX+FsIZwPUvFO8Y=;
 b=RF6lANcxNtvS7Bp5YQvDRG30eDF0BxW1wysFAlgiLMoEnpU/8dTCkQdArBFORqIKbvN/xU
 iuCWDf0DHmBNWjDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD951137DB;
 Wed, 29 Jan 2025 16:01:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +IeHG+pQmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 21/42] migration-test: defer connection
Date: Wed, 29 Jan 2025 13:00:38 -0300
Message-Id: <20250129160059.6987-22-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0BDD61F365
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.de:email,suse.de:dkim,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

From: Steve Sistare <steven.sistare@oracle.com>

Add an option to defer connection to the target monitor, needed by the
cpr-transfer test.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/1736967650-129648-21-git-send-email-steven.sistare@oracle.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c | 22 +++++++++++++++++++---
 tests/qtest/migration/framework.h |  3 +++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index f7add75ed5..2611c31c1b 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -223,6 +223,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     const char *bootpath;
     g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
     g_autofree char *memory_backend = NULL;
+    const char *events;
 
     if (args->use_shmem) {
         if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
@@ -340,22 +341,30 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                      &src_state);
     }
 
+    /*
+     * If the monitor connection is deferred, enable events on the command line
+     * so none are missed.  This is for testing only, do not set migration
+     * options like this in general.
+     */
+    events = args->defer_target_connect ? "-global migration.x-events=on" : "";
+
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-machine %s,%s "
                                  "-name target,debug-threads=on "
                                  "%s "
                                  "-serial file:%s/dest_serial "
                                  "-incoming %s "
-                                 "%s %s %s %s",
+                                 "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
                                  memory_backend, tmpfs, uri,
+                                 events,
                                  arch_opts ? arch_opts : "",
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
     *to = qtest_init_with_env_and_capabilities(QEMU_ENV_DST, cmd_target,
-                                               capabilities, true);
+                                               capabilities, !args->defer_target_connect);
     qtest_qmp_set_event_callback(*to,
                                  migrate_watch_for_events,
                                  &dst_state);
@@ -373,7 +382,9 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
      * to mimic as closer as that.
      */
     migrate_set_capability(*from, "events", true);
-    migrate_set_capability(*to, "events", true);
+    if (!args->defer_target_connect) {
+        migrate_set_capability(*to, "events", true);
+    }
 
     return 0;
 }
@@ -733,6 +744,11 @@ void test_precopy_common(MigrateCommon *args)
 
     migrate_qmp(from, to, args->connect_uri, args->connect_channels, "{}");
 
+    if (args->start.defer_target_connect) {
+        qtest_connect(to);
+        qtest_qmp_handshake(to, NULL);
+    }
+
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
         wait_for_migration_fail(from, allow_active);
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index dd2db1c000..32f3a93632 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -116,6 +116,9 @@ typedef struct {
      * size is plugged in.  If omitted, "-m %s" is used.
      */
     const char *memory_backend;
+
+    /* Do not connect to target monitor and qtest sockets in qtest_init */
+    bool defer_target_connect;
 } MigrateStart;
 
 typedef enum PostcopyRecoveryFailStage {
-- 
2.35.3


