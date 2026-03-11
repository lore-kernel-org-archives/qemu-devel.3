Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2E4103E2E6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 21:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0RCr-0005Uk-O4; Wed, 11 Mar 2026 17:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0RCq-0005U5-RU
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:35:04 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w0RCo-00038b-FM
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 17:35:04 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 984125BDEC;
 Wed, 11 Mar 2026 21:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773264875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLxlWVB55Ex7WGdmcshjPBRAXrzJMBqpSVd7mYEbxxc=;
 b=eSSkjSyr53dhuDmLUYzi0MAYIeGbcjyotLpbnREudUxZ3zngfUwt7/rMI0C4HC/MmeMvSq
 ZwcP7Sk/cpkIgx7J/hCNcmQtORfIirmmFx4MZDR5xFn1jW2+IeSemefxoL8DVgoXrmc0BQ
 hrM2Wz+DLf8lusO7SX2AQR48VCwGMmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773264875;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLxlWVB55Ex7WGdmcshjPBRAXrzJMBqpSVd7mYEbxxc=;
 b=BSiJcIOPddbUlnANJbi0rmZufzgneWPHJWE93ua3LyV97bEcOLmXi5GTZchLDt3rCTDDcA
 NsXki/ZL74hjhgDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773264875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLxlWVB55Ex7WGdmcshjPBRAXrzJMBqpSVd7mYEbxxc=;
 b=eSSkjSyr53dhuDmLUYzi0MAYIeGbcjyotLpbnREudUxZ3zngfUwt7/rMI0C4HC/MmeMvSq
 ZwcP7Sk/cpkIgx7J/hCNcmQtORfIirmmFx4MZDR5xFn1jW2+IeSemefxoL8DVgoXrmc0BQ
 hrM2Wz+DLf8lusO7SX2AQR48VCwGMmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773264875;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLxlWVB55Ex7WGdmcshjPBRAXrzJMBqpSVd7mYEbxxc=;
 b=BSiJcIOPddbUlnANJbi0rmZufzgneWPHJWE93ua3LyV97bEcOLmXi5GTZchLDt3rCTDDcA
 NsXki/ZL74hjhgDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CB8B3FC1B;
 Wed, 11 Mar 2026 21:34:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MOpmC+nfsWngUgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 11 Mar 2026 21:34:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Prasad Pandit <ppandit@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 5/5] tests/qtest/migration: Force exit-on-error=false
Date: Wed, 11 Mar 2026 18:34:18 -0300
Message-ID: <20260311213418.16951-6-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260311213418.16951-1-farosas@suse.de>
References: <20260311213418.16951-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
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

Some tests can cause QEMU to exit(1) too early while the incoming
coroutine has not yielded for a first time yet. This trips ASAN
because resources related to dispatching the incoming process will
still be allocated in the io/channel.c layer without a
straight-forward way for the migration code to clean them up.

As an example of one such issue, the UUID validation happens early
enough that the temporary socket from qio_net_listener_channel_func()
still has an elevated refcount. If it fails, the listener dispatch
code never gets to free the resource:

Direct leak of 400 byte(s) in 1 object(s) allocated from:
    #0 0x55e668890a07 in malloc asan_malloc_linux.cpp:68:3
    #1 0x7f3c7e2b6648 in g_malloc ../glib/gmem.c:130
    #2 0x55e66a8ef05f in object_new_with_type ../qom/object.c:767:15
    #3 0x55e66a8ef178 in object_new ../qom/object.c:789:12
    #4 0x55e66a93bcc6 in qio_channel_socket_new ../io/channel-socket.c:70:31
    #5 0x55e66a93f34f in qio_channel_socket_accept ../io/channel-socket.c:401:12
    #6 0x55e66a96752a in qio_net_listener_channel_func ../io/net-listener.c:64:12
    #7 0x55e66a94bdac in qio_channel_fd_source_dispatch ../io/channel-watch.c:84:12
    #8 0x7f3c7e2adf4b in g_main_dispatch ../glib/gmain.c:3476
    #9 0x7f3c7e2adf4b in g_main_context_dispatch_unlocked ../glib/gmain.c:4284
    #10 0x7f3c7e2b00c8 in g_main_context_dispatch ../glib/gmain.c:4272

The exit(1) also requires some tests to setup qtest to expect a return
code of 1 from the QEMU process. Although we can check migration
status changes to be fairly certain where the failure happened, there
is always the possibility of QEMU exiting for another reason and the
test passing. This happens frequently with sanitizers enabled, but
also risks masking issues in the regular build.

Stop allowing the incoming migration to exit and instead require the
tests to wait for the FAILED state and end QEMU gracefully with
qtest_quit.

In practice this means setting exit-on-error=false for every incoming
migration, changing MIG_TEST_FAIL_DEST_QUIT_ERR to MIG_TEST_FAIL and
waiting for a change of state where necessary.

With this, the MIG_TEST_FAIL_DEST_QUIT_ERR error result is now unused,
remove it.

The affected tests are:
validate_uuid_error
multifd_tcp_cancel
dirty_limit
precopy_unix_tls_x509_default_host
precopy_tcp_tls_no_hostname
tcp_tls_x509_mismatch_host
dbus_vmstate_missing_src
dbus_vmstate_missing_dst

Also add a comment to QEMU source explaining that the incoming
coroutine might block for a while until it yields as this is the
actual root cause of the issue.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c                 |  5 +++++
 tests/qtest/dbus-vmstate-test.c       |  5 +++--
 tests/qtest/migration/framework.c     |  5 +----
 tests/qtest/migration/framework.h     |  2 --
 tests/qtest/migration/migration-qmp.c |  6 ++++++
 tests/qtest/migration/misc-tests.c    |  4 ++--
 tests/qtest/migration/precopy-tests.c | 12 +++++-------
 tests/qtest/migration/tls-tests.c     | 14 ++++++++------
 8 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f949708629..c77832f851 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -898,6 +898,11 @@ void migration_start_incoming(void)
 
     Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
     qemu_coroutine_enter(co);
+    /*
+     * This doesn't return right away. The coroutine will run
+     * unimpeded until its first yield, which may happen as late as
+     * the force yield at ram_load_precopy().
+     */
 }
 
 int migrate_send_rp_switchover_ack(MigrationIncomingState *mis)
diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
index 6c990864e3..0a82cc9f93 100644
--- a/tests/qtest/dbus-vmstate-test.c
+++ b/tests/qtest/dbus-vmstate-test.c
@@ -219,8 +219,8 @@ test_dbus_vmstate(Test *test)
 
     dstaddr = g_strsplit(g_test_dbus_get_bus_address(dstbus), ",", 2);
     dst_qemu_args =
-        g_strdup_printf("-object dbus-vmstate,id=dv,addr=%s -incoming %s",
-                        dstaddr[0], uri);
+        g_strdup_printf("-object dbus-vmstate,id=dv,addr=%s -incoming defer",
+                        dstaddr[0]);
 
     src_qemu = qtest_init(src_qemu_args);
     dst_qemu = qtest_init(dst_qemu_args);
@@ -229,6 +229,7 @@ test_dbus_vmstate(Test *test)
 
     thread = g_thread_new("dbus-vmstate-thread", dbus_vmstate_thread, loop);
 
+    migrate_incoming_qmp(dst_qemu, uri, NULL, "{}");
     migrate_qmp(src_qemu, uri, "{}");
     test->src_qemu = src_qemu;
     if (test->migrate_fail) {
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index b9371372de..9f71d51f1e 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -576,6 +576,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     migrate_prepare_for_dirty_mem(from);
     qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
                              "  'arguments': { "
+                             "      'exit-on-error': false,"
                              "      'channels': [ { 'channel-type': 'main',"
                              "      'addr': { 'transport': 'socket',"
                              "                'type': 'inet',"
@@ -906,10 +907,6 @@ int test_precopy_common(MigrateCommon *args)
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
         wait_for_migration_fail(from, allow_active);
-
-        if (args->result == MIG_TEST_FAIL_DEST_QUIT_ERR) {
-            qtest_set_expected_status(to, EXIT_FAILURE);
-        }
     } else {
         if (args->live) {
             /*
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 80eef75893..79604c60f5 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -208,8 +208,6 @@ typedef struct {
         MIG_TEST_SUCCEED = 0,
         /* This test should fail, dest qemu should keep alive */
         MIG_TEST_FAIL,
-        /* This test should fail, dest qemu should fail with abnormal status */
-        MIG_TEST_FAIL_DEST_QUIT_ERR,
         /* The QMP command for this migration should fail with an error */
         MIG_TEST_QMP_ERROR,
     } result;
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index 8279504db1..61cd7db6cc 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -173,6 +173,12 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, QObject *channels,
     /* This function relies on the event to work, make sure it's enabled */
     migrate_set_capability(to, "events", true);
 
+    /*
+     * Set the incoming migration to never exit QEMU abruptly during
+     * the tests. It causes issues when running sanitizers and
+     * expecting a failure exit code can mask other issues.
+     */
+    qdict_put_bool(args, "exit-on-error", false);
     rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
                     args);
 
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 810e9e6549..196f1ca842 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -131,7 +131,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
-    if (migrate_start(&from, &to, uri, args)) {
+    if (migrate_start(&from, &to, "defer", args)) {
         return;
     }
 
@@ -146,10 +146,10 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
+    migrate_incoming_qmp(to, uri, NULL, "{}");
     migrate_qmp(from, to, uri, NULL, "{}");
 
     if (should_fail) {
-        qtest_set_expected_status(to, EXIT_FAILURE);
         wait_for_migration_fail(from, true);
     } else {
         wait_for_migration_complete(from);
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index f17dc5176d..c6c8ae3004 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -545,8 +545,7 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
     migrate_cancel(from);
 
     /* Make sure QEMU process "to" exited */
-    qtest_set_expected_status(to, EXIT_FAILURE);
-    qtest_wait_qemu(to);
+    migration_event_wait(to, "failed");
     qtest_quit(to);
 
     /*
@@ -634,7 +633,7 @@ static void test_cancel_src_after_cancelled(QTestState *from, QTestState *to,
                                             const char *uri, const char *phase,
                                             MigrateStart *args)
 {
-    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
+    migrate_incoming_qmp(to, uri, NULL, "{}");
 
     wait_for_serial("src_serial");
     migrate_ensure_converge(from);
@@ -659,7 +658,7 @@ static void test_cancel_src_after_complete(QTestState *from, QTestState *to,
                                            const char *uri, const char *phase,
                                            MigrateStart *args)
 {
-    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
+    migrate_incoming_qmp(to, uri, NULL, "{}");
 
     wait_for_serial("src_serial");
     migrate_ensure_converge(from);
@@ -690,7 +689,7 @@ static void test_cancel_src_after_none(QTestState *from, QTestState *to,
     wait_for_serial("src_serial");
     migrate_cancel(from);
 
-    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
+    migrate_incoming_qmp(to, uri, NULL, "{}");
 
     migrate_ensure_converge(from);
     migrate_qmp(from, to, uri, NULL, "{}");
@@ -709,7 +708,7 @@ static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
     migrate_set_capability(from, "multifd", true);
     migrate_set_capability(to, "multifd", true);
 
-    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
+    migrate_incoming_qmp(to, uri, NULL, "{}");
 
     wait_for_serial("src_serial");
     migrate_ensure_converge(from);
@@ -1101,7 +1100,6 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
 
     /* destination always fails after cancel */
     migration_event_wait(to, "failed");
-    qtest_set_expected_status(to, EXIT_FAILURE);
     qtest_quit(to);
 
     /* Check if dirty limit throttle switched off, set timeout 1ms */
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 4ce7f6c676..87898af260 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -441,10 +441,10 @@ static void test_precopy_unix_tls_x509_default_host(char *name,
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
 
     args->connect_uri = uri;
-    args->listen_uri = uri;
+    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_tls_x509_default_host;
     args->end_hook = migrate_hook_end_tls_x509;
-    args->result = MIG_TEST_FAIL_DEST_QUIT_ERR;
+    args->result = MIG_TEST_FAIL;
 
     args->start.hide_stderr = true;
 
@@ -522,10 +522,11 @@ migrate_hook_start_tls_x509_no_host(QTestState *from, QTestState *to)
 
 static void test_precopy_tcp_tls_no_hostname(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
+    args->listen_uri = "defer";
+    args->connect_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_x509_no_host;
     args->end_hook = migrate_hook_end_tls_x509;
-    args->result = MIG_TEST_FAIL_DEST_QUIT_ERR;
+    args->result = MIG_TEST_FAIL;
 
     args->start.hide_stderr = true;
 
@@ -556,10 +557,11 @@ static void test_precopy_tcp_tls_x509_override_host(char *name,
 static void test_precopy_tcp_tls_x509_mismatch_host(char *name,
                                                     MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
+    args->listen_uri = "defer";
+    args->connect_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_x509_mismatch_host;
     args->end_hook = migrate_hook_end_tls_x509;
-    args->result = MIG_TEST_FAIL_DEST_QUIT_ERR;
+    args->result = MIG_TEST_FAIL;
 
     args->start.hide_stderr = true;
 
-- 
2.51.0


