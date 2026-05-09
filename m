Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8917BCD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 07:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLcEs-0003vv-Oa; Sat, 09 May 2026 03:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcEq-0003vc-Rj
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLcEo-0006rv-Rf
 for qemu-devel@nongnu.org; Sat, 09 May 2026 03:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778312197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OcCC3z+riZQvSpqKsnPiN5LbEl+xDrQhhXWVurattKQ=;
 b=Pxwg3S+JimyEEyiK2E8b6wWm/KP8k5jvawV7eo6IQwKBdusrEQZXaOttKpB+a1lisddcrY
 XqZlrF88Ehd/+6S+tnLlSI4l8EYgKng0A/SyYzdrR1I9evD40y/lCmAr6IvtrAD1UIrGRm
 U3C0/0XXe4lv+YunVFTYX/VW0i3LFIQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-c2MkiP28Ng-EE6SkyAECuA-1; Sat,
 09 May 2026 03:36:33 -0400
X-MC-Unique: c2MkiP28Ng-EE6SkyAECuA-1
X-Mimecast-MFC-AGG-ID: c2MkiP28Ng-EE6SkyAECuA_1778312192
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0EEA180034C; Sat,  9 May 2026 07:36:32 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 736C8180034E; Sat,  9 May 2026 07:36:30 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 01/32] tests/qtest/dbus-vmstate: Bring the test up-to-date
Date: Sat,  9 May 2026 11:35:47 +0400
Message-ID: <20260509073621.1011778-2-marcandre.lureau@redhat.com>
In-Reply-To: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
References: <20260509073621.1011778-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

The dbus-vmstate-test has been disabled for years. Here's the things
that have changed in the meantime and how to update the test:

- Migration tests got new headers.
Update the includes.

- migrate_qmp got new parameters.
Update the caller.

- migrate_incoming_qmp is now used instead of -incoming URL.
Use -incoming defer.

- Tests expecting failure should not check non-zero return code.
Check for failed migration state instead.

- The test result enum was introduced.
Replace the migration_fail flag with the enum.

- The DEVICE state was added.
Replace wait_for_migration_complete with migration_event_wait, which
won't trip on intermediary states.

- Migration completion was reworked.
Explicitly wait for the RESUME event before asserting runstate is
RUNNING to avoid checking too quickly and seeing FINISH_MIGRATE
instead.

- The FAILING state was added.
Wait for it before waiting for the RESUME event.

- Sanity checks were added to migration_get_env().
Start calling that function in main.

- qtest_add_func now has a wrapper.
Replace qtest_add_func with migration_test_add. Update tests'
signatures to take MigrationCommon, although it's unused.

- meson now sets up G_TEST_DBUS_DAEMON.
Remove the logic around it.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260429190550.20122-2-farosas@suse.de>
---
 tests/qtest/dbus-vmstate-test.c | 71 +++++++++++++++++++--------------
 tests/qtest/meson.build         |  7 +++-
 2 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
index 0a82cc9f935..90c050b4480 100644
--- a/tests/qtest/dbus-vmstate-test.c
+++ b/tests/qtest/dbus-vmstate-test.c
@@ -2,8 +2,8 @@
 #include <glib/gstdio.h>
 #include <gio/gio.h>
 #include "libqtest.h"
+#include "migration/migration-qmp.h"
 #include "dbus-vmstate1.h"
-#include "migration-helpers.h"
 
 static char *workdir;
 
@@ -29,7 +29,7 @@ typedef struct TestServer {
 
 typedef struct Test {
     const char *id_list;
-    bool migrate_fail;
+    int result;
     bool without_dst_b;
     TestServer srcA;
     TestServer dstA;
@@ -190,6 +190,7 @@ test_dbus_vmstate(Test *test)
     g_autofree char *uri = NULL;
     QTestState *src_qemu = NULL, *dst_qemu = NULL;
     guint ownsrcA, ownsrcB, owndstA, owndstB;
+    QTestMigrationState src_state = { };
 
     uri = g_strdup_printf("unix:%s/migsocket", workdir);
 
@@ -224,17 +225,33 @@ test_dbus_vmstate(Test *test)
 
     src_qemu = qtest_init(src_qemu_args);
     dst_qemu = qtest_init(dst_qemu_args);
+
+    migrate_set_capability(src_qemu, "events", true);
+    qtest_qmp_set_event_callback(src_qemu, migrate_watch_for_events,
+                                 &src_state);
+
     set_id_list(test, src_qemu);
     set_id_list(test, dst_qemu);
 
     thread = g_thread_new("dbus-vmstate-thread", dbus_vmstate_thread, loop);
 
     migrate_incoming_qmp(dst_qemu, uri, NULL, "{}");
-    migrate_qmp(src_qemu, uri, "{}");
+    migrate_ensure_converge(src_qemu);
+    migrate_qmp(src_qemu, NULL, uri, NULL, "{}");
     test->src_qemu = src_qemu;
-    if (test->migrate_fail) {
-        wait_for_migration_fail(src_qemu, true);
-        qtest_set_expected_status(dst_qemu, EXIT_FAILURE);
+
+    if (test->result != MIG_TEST_SUCCEED) {
+        QDict *rsp;
+
+        migration_event_wait(src_qemu, "failing");
+        wait_for_resume(src_qemu, &src_state);
+        migration_event_wait(src_qemu, "failed");
+
+        rsp = qtest_qmp_assert_success_ref(src_qemu,
+                                           "{ 'execute': 'query-status' }");
+        g_assert(qdict_haskey(rsp, "running"));
+        g_assert(qdict_get_bool(rsp, "running"));
+        qobject_unref(rsp);
     } else {
         wait_for_migration_complete(src_qemu);
     }
@@ -270,7 +287,7 @@ check_migrated(TestServer *s, TestServer *d)
 }
 
 static void
-test_dbus_vmstate_without_list(void)
+test_dbus_vmstate_without_list(char *name, MigrateCommon *args)
 {
     Test test = { 0, };
 
@@ -281,7 +298,7 @@ test_dbus_vmstate_without_list(void)
 }
 
 static void
-test_dbus_vmstate_with_list(void)
+test_dbus_vmstate_with_list(char *name, MigrateCommon *args)
 {
     Test test = { .id_list = "idA,idB" };
 
@@ -292,7 +309,7 @@ test_dbus_vmstate_with_list(void)
 }
 
 static void
-test_dbus_vmstate_only_a(void)
+test_dbus_vmstate_only_a(char *name, MigrateCommon *args)
 {
     Test test = { .id_list = "idA" };
 
@@ -303,9 +320,10 @@ test_dbus_vmstate_only_a(void)
 }
 
 static void
-test_dbus_vmstate_missing_src(void)
+test_dbus_vmstate_missing_src(char *name, MigrateCommon *args)
 {
-    Test test = { .id_list = "idA,idC", .migrate_fail = true };
+    Test test = { .id_list = "idA,idC",
+        .result = MIG_TEST_FAIL };
 
     /* run in subprocess to silence QEMU error reporting */
     if (g_test_subprocess()) {
@@ -320,11 +338,11 @@ test_dbus_vmstate_missing_src(void)
 }
 
 static void
-test_dbus_vmstate_missing_dst(void)
+test_dbus_vmstate_missing_dst(char *name, MigrateCommon *args)
 {
     Test test = { .id_list = "idA,idB",
                   .without_dst_b = true,
-                  .migrate_fail = true };
+                  .result = MIG_TEST_FAIL };
 
     /* run in subprocess to silence QEMU error reporting */
     if (g_test_subprocess()) {
@@ -343,15 +361,8 @@ int
 main(int argc, char **argv)
 {
     GError *err = NULL;
-    g_autofree char *dbus_daemon = NULL;
     int ret;
 
-    dbus_daemon = g_build_filename(G_STRINGIFY(SRCDIR),
-                                   "tests",
-                                   "dbus-vmstate-daemon.sh",
-                                   NULL);
-    g_setenv("G_TEST_DBUS_DAEMON", dbus_daemon, true);
-
     g_test_init(&argc, &argv, NULL);
 
     workdir = g_dir_make_tmp("dbus-vmstate-test-XXXXXX", &err);
@@ -362,16 +373,16 @@ main(int argc, char **argv)
 
     g_setenv("DBUS_VMSTATE_TEST_TMPDIR", workdir, true);
 
-    qtest_add_func("/dbus-vmstate/without-list",
-                   test_dbus_vmstate_without_list);
-    qtest_add_func("/dbus-vmstate/with-list",
-                   test_dbus_vmstate_with_list);
-    qtest_add_func("/dbus-vmstate/only-a",
-                   test_dbus_vmstate_only_a);
-    qtest_add_func("/dbus-vmstate/missing-src",
-                   test_dbus_vmstate_missing_src);
-    qtest_add_func("/dbus-vmstate/missing-dst",
-                   test_dbus_vmstate_missing_dst);
+    migration_test_add("/dbus-vmstate/without-list",
+                       test_dbus_vmstate_without_list);
+    migration_test_add("/dbus-vmstate/with-list",
+                       test_dbus_vmstate_with_list);
+    migration_test_add("/dbus-vmstate/only-a",
+                       test_dbus_vmstate_only_a);
+    migration_test_add("/dbus-vmstate/missing-src",
+                       test_dbus_vmstate_missing_src);
+    migration_test_add("/dbus-vmstate/missing-dst",
+                       test_dbus_vmstate_missing_dst);
 
     ret = g_test_run();
 
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 43f83ffd3aa..ba890c2b554 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -128,10 +128,12 @@ if dbus_daemon.found() and gdbus_codegen.found()
   # Temporarily disabled due to Patchew failures:
   #qtests_i386 += ['dbus-vmstate-test']
   dbus_vmstate1 = custom_target('dbus-vmstate description',
-                                output: ['dbus-vmstate1.h', 'dbus-vmstate1.c'],
+                                build_by_default: true,
+                                output: [ 'dbus-vmstate1.h', 'dbus-vmstate1.c'],
                                 input: meson.project_source_root() / 'backends/dbus-vmstate1.xml',
                                 command: [gdbus_codegen, '@INPUT@',
                                           '--interface-prefix', 'org.qemu',
+                                          '--output-directory', meson.current_build_dir(),
                                           '--generate-c-code', '@BASENAME@']).to_list()
 else
   dbus_vmstate1 = []
@@ -387,7 +389,8 @@ qtests = {
   'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],
   'cdrom-test': files('boot-sector.c'),
   'dbus-vmstate-test': files('migration/migration-qmp.c',
-                             'migration/migration-util.c') + dbus_vmstate1,
+                             'migration/migration-util.c') + dbus_vmstate1 +
+                       [gio],
   'erst-test': files('erst-test.c'),
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
   'migration-test': test_migration_files + migration_tls_files + migration_colo_files,
-- 
2.54.0


