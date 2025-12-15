Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC82AD5B872
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGes-0006th-7a; Mon, 15 Dec 2025 17:03:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGeb-0005lO-9e
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:59 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGeY-0002y0-Jj
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:02:52 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7BAA133748;
 Mon, 15 Dec 2025 22:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IqI0X7oXn5B9kGsqSF6ZqoV37V/bdDXnVUVjvBEXCqM=;
 b=dWmYDWrFfCcXvgef9DRDAd8MvZCRhC/21O2jUOK1hb9LfX/KObE6+jv+qK3uBkQwqUECHk
 cu/PrtUwE+gVtrpWNsOnbKBHCIZX+Qv936XM0FFc6EyZuaS1+YXQLUAp76VOZ4HZu37d6y
 iX8yIn1Oww++2UpdmGI5N1m+heafyOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836138;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IqI0X7oXn5B9kGsqSF6ZqoV37V/bdDXnVUVjvBEXCqM=;
 b=cxeelZb+8lyb3qdFbj7s/PGloRcTLRG4j+Kuz7OLvgF8TCl+SttDPpQKiKM8NIWqa4yPQd
 tPPoCMIZanrUFZAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IqI0X7oXn5B9kGsqSF6ZqoV37V/bdDXnVUVjvBEXCqM=;
 b=dWmYDWrFfCcXvgef9DRDAd8MvZCRhC/21O2jUOK1hb9LfX/KObE6+jv+qK3uBkQwqUECHk
 cu/PrtUwE+gVtrpWNsOnbKBHCIZX+Qv936XM0FFc6EyZuaS1+YXQLUAp76VOZ4HZu37d6y
 iX8yIn1Oww++2UpdmGI5N1m+heafyOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836138;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IqI0X7oXn5B9kGsqSF6ZqoV37V/bdDXnVUVjvBEXCqM=;
 b=cxeelZb+8lyb3qdFbj7s/PGloRcTLRG4j+Kuz7OLvgF8TCl+SttDPpQKiKM8NIWqa4yPQd
 tPPoCMIZanrUFZAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 772403EA63;
 Mon, 15 Dec 2025 22:02:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +KEqDmiFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:02:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 35/51] tests/qtest/migration: Add a config parameter to
 migrate_qmp functions
Date: Mon, 15 Dec 2025 19:00:21 -0300
Message-ID: <20251215220041.12657-36-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.991];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
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

Add a config parameter to all migrate_qmp functions. All tests will be
converted in the next patches to use the config instead of calling
migrate_set_*.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/cpr-tests.c     |  3 ++-
 tests/qtest/migration/framework.c     | 33 ++++++++++++++----------
 tests/qtest/migration/migration-qmp.c | 27 ++++++++++++++++---
 tests/qtest/migration/migration-qmp.h | 13 +++++-----
 tests/qtest/migration/misc-tests.c    | 11 ++++----
 tests/qtest/migration/precopy-tests.c | 37 +++++++++++++++------------
 tests/qtest/virtio-net-failover.c     | 24 +++++++++++------
 7 files changed, 96 insertions(+), 52 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 280e671e4b..9883616cb5 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -201,7 +201,7 @@ static void test_cpr_exec(MigrateCommon *args)
     wait_for_serial("src_serial");
     set_cpr_exec_args(from, args);
     migrate_set_capability(from, "events", true);
-    migrate_qmp(from, NULL, connect_uri, NULL, "{}");
+    migrate_qmp(from, NULL, connect_uri, NULL, args->start.config, "{}");
     wait_for_migration_event(from, "completed");
 
     to = qtest_init_after_exec(from);
@@ -214,6 +214,7 @@ static void test_cpr_exec(MigrateCommon *args)
 
     migrate_incoming_qmp(to, NULL,
                          qobject_from_json(channels, &error_abort),
+                         args->start.config,
                          "{}");
     wait_for_migration_complete(to);
 
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 227bc39303..f740228cf2 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -602,13 +602,13 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
                                  "              'host': '127.0.0.1',"
                                  "              'port': '0' } } ]",
                                  &error_abort);
-    migrate_incoming_qmp(to, NULL, channels, "{}");
+    migrate_incoming_qmp(to, NULL, channels, args->start.config, "{}");
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
     wait_for_suspend(from, &src_state);
 
-    migrate_qmp(from, to, NULL, NULL, "{}");
+    migrate_qmp(from, to, NULL, NULL, args->start.config, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -666,9 +666,10 @@ static void wait_for_postcopy_status(QTestState *one, const char *status)
 }
 
 static void postcopy_recover_fail(QTestState *from, QTestState *to,
-                                  PostcopyRecoveryFailStage stage)
+                                  MigrateCommon *args)
 {
 #ifndef _WIN32
+    PostcopyRecoveryFailStage stage = args->postcopy_recovery_fail_stage;
     bool fail_early = (stage == POSTCOPY_FAIL_CHANNEL_ESTABLISH);
     int ret, pair1[2], pair2[2];
     char c;
@@ -717,7 +718,8 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to,
     }
 
     migrate_recover(to, "fd:fd-mig");
-    migrate_qmp(from, to, "fd:fd-mig", NULL, "{'resume': true}");
+    migrate_qmp(from, to, "fd:fd-mig", NULL, args->start.config,
+                "{'resume': true}");
 
     /*
      * Source QEMU has an extra RECOVER_SETUP phase, dest doesn't have it.
@@ -824,7 +826,7 @@ void test_postcopy_recovery_common(MigrateCommon *args)
          * Test when a wrong socket specified for recover, and then the
          * ability to kick it out, and continue with a correct socket.
          */
-        postcopy_recover_fail(from, to, args->postcopy_recovery_fail_stage);
+        postcopy_recover_fail(from, to, args);
         /* continue with a good recovery */
     }
 
@@ -840,7 +842,7 @@ void test_postcopy_recovery_common(MigrateCommon *args)
      * Try to rebuild the migration channel using the resume flag and
      * the newly created channel
      */
-    migrate_qmp(from, to, uri, NULL, "{'resume': true}");
+    migrate_qmp(from, to, uri, NULL, args->start.config, "{'resume': true}");
 
     /* Restore the postcopy bandwidth to unlimited */
     migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
@@ -873,7 +875,8 @@ int test_precopy_common(MigrateCommon *args)
             in_channels = qobject_from_json(args->connect_channels,
                                             &error_abort);
         }
-        migrate_incoming_qmp(to, args->listen_uri, in_channels, "{}");
+        migrate_incoming_qmp(to, args->listen_uri, in_channels,
+                             args->start.config, "{}");
     }
 
     /* Wait for the first serial output from the source */
@@ -919,17 +922,20 @@ int test_precopy_common(MigrateCommon *args)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, out_channels, "{}");
+        migrate_qmp_fail(from, args->connect_uri, out_channels,
+                         args->start.config, "{}");
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, out_channels, "{}");
+    migrate_qmp(from, to, args->connect_uri, out_channels,
+                args->start.config, "{}");
 
     if (args->start.defer_target_connect) {
         qtest_connect(to);
         qtest_qmp_handshake(to, NULL);
         if (args->start.incoming_defer) {
-            migrate_incoming_qmp(to, NULL, in_channels, "{}");
+            migrate_incoming_qmp(to, args->connect_uri, in_channels,
+                                 args->start.config, "{}");
         }
     }
 
@@ -1067,18 +1073,19 @@ void test_file_common(MigrateCommon *args, bool stop_src)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, NULL, "{}");
+        migrate_qmp_fail(from, args->connect_uri, NULL,
+                         args->start.config, "{}");
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
+    migrate_qmp(from, to, args->connect_uri, NULL, args->start.config, "{}");
     wait_for_migration_complete(from);
 
     /*
      * We need to wait for the source to finish before starting the
      * destination.
      */
-    migrate_incoming_qmp(to, args->listen_uri, NULL, "{}");
+    migrate_incoming_qmp(to, args->listen_uri, NULL, args->start.config, "{}");
     wait_for_migration_complete(to);
 
     if (stop_src) {
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index 7fe47a5793..a4dde029ee 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -77,7 +77,7 @@ QObject *migrate_str_to_channel(const char *str)
 }
 
 void migrate_qmp_fail(QTestState *who, const char *uri,
-                      QObject *channels, const char *fmt, ...)
+                      QObject *channels, QDict *config, const char *fmt, ...)
 {
     va_list ap;
     QDict *args, *err;
@@ -96,12 +96,19 @@ void migrate_qmp_fail(QTestState *who, const char *uri,
         qdict_put_obj(args, "channels", channels);
     }
 
+    config = config_load(config);
+    if (config) {
+        qdict_put_obj(args, "config", QOBJECT(config));
+        qobject_ref(config);
+    }
+
     err = qtest_qmp_assert_failure_ref(
         who, "{ 'execute': 'migrate', 'arguments': %p}", args);
 
     g_assert(qdict_haskey(err, "desc"));
 
     qobject_unref(err);
+    config_put(config);
 }
 
 /*
@@ -110,7 +117,7 @@ void migrate_qmp_fail(QTestState *who, const char *uri,
  * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
  */
 void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
-                 QObject *channels, const char *fmt, ...)
+                 QObject *channels, QDict *config, const char *fmt, ...)
 {
     va_list ap;
     QDict *args;
@@ -135,8 +142,15 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
         qdict_put_obj(args, "channels", channels);
     }
 
+    config = config_load(config);
+    if (config) {
+        qdict_put_obj(args, "config", QOBJECT(config));
+        qobject_ref(config);
+    }
+
     qtest_qmp_assert_success(who,
                              "{ 'execute': 'migrate', 'arguments': %p}", args);
+    config_put(config);
 }
 
 void migrate_set_capability(QTestState *who, const char *capability,
@@ -151,7 +165,7 @@ void migrate_set_capability(QTestState *who, const char *capability,
 }
 
 void migrate_incoming_qmp(QTestState *to, const char *uri, QObject *channels,
-                          const char *fmt, ...)
+                          QDict *config, const char *fmt, ...)
 {
     va_list ap;
     QDict *args, *rsp;
@@ -173,6 +187,12 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, QObject *channels,
     /* This function relies on the event to work, make sure it's enabled */
     migrate_set_capability(to, "events", true);
 
+    config = config_load(config);
+    if (config) {
+        qdict_put_obj(args, "config", QOBJECT(config));
+        qobject_ref(config);
+    }
+
     rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
                     args);
 
@@ -185,6 +205,7 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, QObject *channels,
     qobject_unref(rsp);
 
     migration_event_wait(to, "setup");
+    config_put(config);
 }
 
 static bool check_migration_status(QTestState *who, const char *goal,
diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
index e465c69094..7daeb913fa 100644
--- a/tests/qtest/migration/migration-qmp.h
+++ b/tests/qtest/migration/migration-qmp.h
@@ -6,17 +6,18 @@
 
 QObject *migrate_str_to_channel(const char *str);
 
-G_GNUC_PRINTF(4, 5)
+G_GNUC_PRINTF(5, 6)
 void migrate_qmp_fail(QTestState *who, const char *uri,
-                      QObject *channels, const char *fmt, ...);
+                      QObject *channels, QDict *config, const char *fmt, ...);
 
-G_GNUC_PRINTF(5, 6)
+G_GNUC_PRINTF(6, 7)
 void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
-                 QObject *channels, const char *fmt, ...);
+                 QObject *channels, QDict *config, const char *fmt, ...);
 
-G_GNUC_PRINTF(4, 5)
+G_GNUC_PRINTF(5, 6)
 void migrate_incoming_qmp(QTestState *who, const char *uri,
-                          QObject *channels, const char *fmt, ...);
+                          QObject *channels, QDict *config,
+                          const char *fmt, ...);
 
 void migration_event_wait(QTestState *s, const char *target);
 void migrate_set_capability(QTestState *who, const char *capability,
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 0a737cb54f..c62fd1e3f9 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -31,7 +31,7 @@ static void test_baddest(char *name, MigrateCommon *args)
     if (migrate_start(&from, &to, "tcp:127.0.0.1:0", &args->start)) {
         return;
     }
-    migrate_qmp(from, to, "tcp:127.0.0.1:0", NULL, "{}");
+    migrate_qmp(from, to, "tcp:127.0.0.1:0", NULL, args->start.config, "{}");
     wait_for_migration_fail(from, false);
     migrate_end(from, to, false);
 }
@@ -69,7 +69,7 @@ static void test_analyze_script(char *name, MigrateCommon *args)
     uri = g_strdup_printf("exec:cat > %s", file);
 
     migrate_ensure_converge(from, args->start.config);
-    migrate_qmp(from, to, uri, NULL, "{}");
+    migrate_qmp(from, to, uri, NULL, args->start.config, "{}");
     wait_for_migration_complete(from);
 
     pid = fork();
@@ -108,7 +108,7 @@ static void test_ignore_shared(char *name, MigrateCommon *args)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, uri, NULL, "{}");
+    migrate_qmp(from, to, uri, NULL, args->start.config, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -146,7 +146,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, uri, NULL, "{}");
+    migrate_qmp(from, to, uri, NULL, args->config, "{}");
 
     if (should_fail) {
         qtest_set_expected_status(to, EXIT_FAILURE);
@@ -210,7 +210,8 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
     channels = args->connect_channels ?
                qobject_from_json(args->connect_channels, &error_abort) :
                NULL;
-    migrate_qmp_fail(from, args->connect_uri, channels, "{}");
+    migrate_qmp_fail(from, args->connect_uri, channels,
+                     args->start.config, "{}");
 
     migrate_end(from, to, false);
 }
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index eabbbf39c3..0b0f04bf19 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -382,7 +382,7 @@ static void test_auto_converge(char *name, MigrateCommon *args)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, uri, NULL, "{}");
+    migrate_qmp(from, to, uri, NULL, args->start.config, "{}");
 
     /* Wait for throttling begins */
     percentage = 0;
@@ -577,12 +577,12 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
     migrate_set_capability(to, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, args->start.config, "{}");
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, NULL, NULL, "{}");
+    migrate_qmp(from, to, NULL, NULL, args->start.config, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -621,11 +621,12 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
     migrate_set_capability(to2, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", NULL, "{}");
+    migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", NULL, args->start.config,
+                         "{}");
 
     migrate_ensure_non_converge(from, args->start.config);
 
-    migrate_qmp(from, to2, NULL, NULL, "{}");
+    migrate_qmp(from, to2, NULL, NULL, args->start.config, "{}");
 
     migrate_wait_for_dirty_mem(from, to2);
     migrate_ongoing_ensure_converge(from);
@@ -659,7 +660,7 @@ static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
     wait_for_serial("src_serial");
     migrate_ensure_converge(from, args->config);
 
-    migrate_qmp(from, to, uri, NULL, "{}");
+    migrate_qmp(from, to, uri, NULL, args->config, "{}");
 
     migration_event_wait(from, phase);
     migrate_cancel(from);
@@ -679,12 +680,13 @@ static void test_cancel_src_after_cancelled(QTestState *from, QTestState *to,
                                             const char *uri, const char *phase,
                                             MigrateStart *args)
 {
-    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
+    migrate_incoming_qmp(to, uri, NULL, args->config,
+                         "{ 'exit-on-error': false }");
 
     wait_for_serial("src_serial");
     migrate_ensure_converge(from, args->config);
 
-    migrate_qmp(from, to, uri, NULL, "{}");
+    migrate_qmp(from, to, uri, NULL, args->config, "{}");
 
     /* To move to cancelled/cancelling */
     migrate_cancel(from);
@@ -704,12 +706,13 @@ static void test_cancel_src_after_complete(QTestState *from, QTestState *to,
                                            const char *uri, const char *phase,
                                            MigrateStart *args)
 {
-    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
+    migrate_incoming_qmp(to, uri, NULL, args->config,
+                         "{ 'exit-on-error': false }");
 
     wait_for_serial("src_serial");
     migrate_ensure_converge(from, args->config);
 
-    migrate_qmp(from, to, uri, NULL, "{}");
+    migrate_qmp(from, to, uri, NULL, args->config, "{}");
 
     migration_event_wait(from, phase);
     migrate_cancel(from);
@@ -735,10 +738,11 @@ static void test_cancel_src_after_none(QTestState *from, QTestState *to,
     wait_for_serial("src_serial");
     migrate_cancel(from);
 
-    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
+    migrate_incoming_qmp(to, uri, NULL, args->config,
+                         "{ 'exit-on-error': false }");
 
     migrate_ensure_converge(from, args->config);
-    migrate_qmp(from, to, uri, NULL, "{}");
+    migrate_qmp(from, to, uri, NULL, args->config, "{}");
 
     wait_for_migration_complete(from);
     wait_for_migration_complete(to);
@@ -754,12 +758,13 @@ static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
     migrate_set_capability(from, "multifd", true);
     migrate_set_capability(to, "multifd", true);
 
-    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
+    migrate_incoming_qmp(to, uri, NULL, args->config,
+                         "{ 'exit-on-error': false }");
 
     wait_for_serial("src_serial");
     migrate_ensure_converge(from, args->config);
 
-    migrate_qmp(from, to, uri, NULL, "{}");
+    migrate_qmp(from, to, uri, NULL, args->config, "{}");
 
     migration_event_wait(from, phase);
     migrate_cancel(from);
@@ -1127,7 +1132,7 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
+    migrate_qmp(from, to, args->connect_uri, NULL, args->start.config, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -1172,7 +1177,7 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
     }
 
     /* Start migrate */
-    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
+    migrate_qmp(from, to, args->connect_uri, NULL, args->start.config, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
diff --git a/tests/qtest/virtio-net-failover.c b/tests/qtest/virtio-net-failover.c
index 5baf81c3e6..e3edcfc9b7 100644
--- a/tests/qtest/virtio-net-failover.c
+++ b/tests/qtest/virtio-net-failover.c
@@ -741,7 +741,7 @@ static void test_migrate_out(gconstpointer opaque)
 static void test_migrate_in(gconstpointer opaque)
 {
     QTestState *qts;
-    QDict *resp, *ret;
+    QDict *resp, *ret, *config;
     g_autofree gchar *uri = g_strdup_printf("exec: cat %s", (gchar *)opaque);
 
     qts = machine_start(BASE_MACHINE
@@ -773,7 +773,9 @@ static void test_migrate_in(gconstpointer opaque)
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, false, "primary0", MAC_PRIMARY0);
 
-    migrate_incoming_qmp(qts, uri, NULL, "{}");
+    config = qdict_new();
+    migrate_incoming_qmp(qts, uri, NULL, config, "{}");
+    qdict_unref(config);
 
     resp = get_failover_negociated_event(qts);
     g_assert_cmpstr(qdict_get_str(resp, "device-id"), ==, "standby0");
@@ -863,7 +865,7 @@ static void test_off_migrate_out(gconstpointer opaque)
 static void test_off_migrate_in(gconstpointer opaque)
 {
     QTestState *qts;
-    QDict *ret;
+    QDict *ret, *config;
     g_autofree gchar *uri = g_strdup_printf("exec: cat %s", (gchar *)opaque);
 
     qts = machine_start(BASE_MACHINE
@@ -895,7 +897,9 @@ static void test_off_migrate_in(gconstpointer opaque)
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, true, "primary0", MAC_PRIMARY0);
 
-    migrate_incoming_qmp(qts, uri, NULL, "{}");
+    config = qdict_new();
+    migrate_incoming_qmp(qts, uri, NULL, config, "{}");
+    qdict_unref(config);
 
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, true, "primary0", MAC_PRIMARY0);
@@ -990,7 +994,7 @@ static void test_guest_off_migrate_out(gconstpointer opaque)
 static void test_guest_off_migrate_in(gconstpointer opaque)
 {
     QTestState *qts;
-    QDict *ret;
+    QDict *ret, *config;
     g_autofree gchar *uri = g_strdup_printf("exec: cat %s", (gchar *)opaque);
 
     qts = machine_start(BASE_MACHINE
@@ -1022,7 +1026,9 @@ static void test_guest_off_migrate_in(gconstpointer opaque)
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, false, "primary0", MAC_PRIMARY0);
 
-    migrate_incoming_qmp(qts, uri, NULL, "{}");
+    config = qdict_new();
+    migrate_incoming_qmp(qts, uri, NULL, config, "{}");
+    qdict_unref(config);
 
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, false, "primary0", MAC_PRIMARY0);
@@ -1681,7 +1687,7 @@ static void test_multi_out(gconstpointer opaque)
 static void test_multi_in(gconstpointer opaque)
 {
     QTestState *qts;
-    QDict *resp, *ret;
+    QDict *resp, *ret, *config;
     g_autofree gchar *uri = g_strdup_printf("exec: cat %s", (gchar *)opaque);
 
     qts = machine_start(BASE_MACHINE
@@ -1747,7 +1753,9 @@ static void test_multi_in(gconstpointer opaque)
     check_one_card(qts, true, "standby1", MAC_STANDBY1);
     check_one_card(qts, false, "primary1", MAC_PRIMARY1);
 
-    migrate_incoming_qmp(qts, uri, NULL, "{}");
+    config = qdict_new();
+    migrate_incoming_qmp(qts, uri, NULL, config, "{}");
+    qdict_unref(config);
 
     resp = get_failover_negociated_event(qts);
     g_assert_cmpstr(qdict_get_str(resp, "device-id"), ==, "standby0");
-- 
2.51.0


