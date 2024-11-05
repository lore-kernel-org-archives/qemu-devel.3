Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EC4D31778
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Nzm-00050h-3y; Tue, 05 Nov 2024 13:09:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8Nzg-0004yZ-Je
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:32 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8Nzd-0004wk-4R
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:31 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E54131F813;
 Tue,  5 Nov 2024 18:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nOEl5zagTj6S++WXrkOKf3Ugv4FFuGuGs4QUQaz4JHw=;
 b=cz6zgTB/f5cnOyXDKwDsiADcbGShdfXkilKqTZ/OCy5vQ59vx9rfyF+xUJ0qAE1popXha1
 Ep9ccV8Skpm680K+EvoV2ysJGE+1HvyWphHuKate4WLPjq1wK0uK5qkSF4D539O2ueEnOo
 2x17hWK9HNAbg5YJ3Y89XLfE9uM3JcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nOEl5zagTj6S++WXrkOKf3Ugv4FFuGuGs4QUQaz4JHw=;
 b=oAfOPyIqflaSWCX+WVDlEnu1Nuxx+nqhFmBjgmaM0eYgYUx6GTvEpYL3d5MEAYLbCmqsPg
 wCdQn1i71TwxLHDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nOEl5zagTj6S++WXrkOKf3Ugv4FFuGuGs4QUQaz4JHw=;
 b=nYcSd/j0icJWJBU+EabkFQGcjCUa7B9GE4F22WnUHWmv1iRa38+KaxT/DlAJQvfu8o9i7c
 JaRGMiXInQfYIYdIlsRxPAX5GqTJ9LlXV2AC98eUq62b3QpbbvOKmlHzftlJR4v0gZab+S
 tNaLbRgf4inU9oPd3Bem9VswJJcyc/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830167;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nOEl5zagTj6S++WXrkOKf3Ugv4FFuGuGs4QUQaz4JHw=;
 b=1pPWttkuWRooHcP4v+gtllvhKDZnRhBot/QY+65i6kbf2+85J/L1H2vDThF4rVgF9d8bML
 hBPKcUFhVTNHKEBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D597B1394A;
 Tue,  5 Nov 2024 18:09:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KIcvJlVfKmeCZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Nov 2024 18:09:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 15/22] tests/qtest/migration: Split file tests
Date: Tue,  5 Nov 2024 15:08:30 -0300
Message-Id: <20241105180837.5990-16-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241105180837.5990-1-farosas@suse.de>
References: <20241105180837.5990-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Split the file tests from migration-test.c. These are being moved to
their own file due to being special enough compared with the regular
stream migration. There is also the entire mapped-ram feature which
depends on file migration.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build                  |   1 +
 tests/qtest/migration-test.c             | 305 +--------------------
 tests/qtest/migration/file-tests.c       | 330 +++++++++++++++++++++++
 tests/qtest/migration/migration-common.h |   1 +
 4 files changed, 333 insertions(+), 304 deletions(-)
 create mode 100644 tests/qtest/migration/file-tests.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index bccfcc63ff..be37aeb65b 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -334,6 +334,7 @@ migration_files = [files(
   'migration/migration-qmp.c',
   'migration/migration-util.c',
   'migration/compression-tests.c',
+  'migration/file-tests.c',
   'migration/postcopy-tests.c',
 )]
 
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index ad7be589ef..dff194a134 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -214,92 +214,6 @@ static void test_ignore_shared(void)
 }
 #endif
 
-static void test_precopy_file(void)
-{
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-    };
-
-    test_file_common(&args, true);
-}
-
-#ifndef _WIN32
-static void fdset_add_fds(QTestState *qts, const char *file, int flags,
-                          int num_fds, bool direct_io)
-{
-    for (int i = 0; i < num_fds; i++) {
-        int fd;
-
-#ifdef O_DIRECT
-        /* only secondary channels can use direct-io */
-        if (direct_io && i != 0) {
-            flags |= O_DIRECT;
-        }
-#endif
-
-        fd = open(file, flags, 0660);
-        assert(fd != -1);
-
-        qtest_qmp_fds_assert_success(qts, &fd, 1, "{'execute': 'add-fd', "
-                                     "'arguments': {'fdset-id': 1}}");
-        close(fd);
-    }
-}
-
-static void *file_offset_fdset_start(QTestState *from, QTestState *to)
-{
-    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
-
-    fdset_add_fds(from, file, O_WRONLY, 1, false);
-    fdset_add_fds(to, file, O_RDONLY, 1, false);
-
-    return NULL;
-}
-
-static void test_precopy_file_offset_fdset(void)
-{
-    g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
-                                           FILE_TEST_OFFSET);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .start_hook = file_offset_fdset_start,
-    };
-
-    test_file_common(&args, false);
-}
-#endif
-
-static void test_precopy_file_offset(void)
-{
-    g_autofree char *uri = g_strdup_printf("file:%s/%s,offset=%d", tmpfs,
-                                           FILE_TEST_FILENAME,
-                                           FILE_TEST_OFFSET);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-    };
-
-    test_file_common(&args, false);
-}
-
-static void test_precopy_file_offset_bad(void)
-{
-    /* using a value not supported by qemu_strtosz() */
-    g_autofree char *uri = g_strdup_printf("file:%s/%s,offset=0x20M",
-                                           tmpfs, FILE_TEST_FILENAME);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .result = MIG_TEST_QMP_ERROR,
-    };
-
-    test_file_common(&args, false);
-}
-
 static void *test_mode_reboot_start(QTestState *from, QTestState *to)
 {
     migrate_set_parameter_str(from, "mode", "cpr-reboot");
@@ -311,14 +225,6 @@ static void *test_mode_reboot_start(QTestState *from, QTestState *to)
     return NULL;
 }
 
-static void *migrate_mapped_ram_start(QTestState *from, QTestState *to)
-{
-    migrate_set_capability(from, "mapped-ram", true);
-    migrate_set_capability(to, "mapped-ram", true);
-
-    return NULL;
-}
-
 static void test_mode_reboot(void)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
@@ -333,185 +239,6 @@ static void test_mode_reboot(void)
     test_file_common(&args, true);
 }
 
-static void test_precopy_file_mapped_ram_live(void)
-{
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .start_hook = migrate_mapped_ram_start,
-    };
-
-    test_file_common(&args, false);
-}
-
-static void test_precopy_file_mapped_ram(void)
-{
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .start_hook = migrate_mapped_ram_start,
-    };
-
-    test_file_common(&args, true);
-}
-
-static void *migrate_multifd_mapped_ram_start(QTestState *from, QTestState *to)
-{
-    migrate_mapped_ram_start(from, to);
-
-    migrate_set_parameter_int(from, "multifd-channels", 4);
-    migrate_set_parameter_int(to, "multifd-channels", 4);
-
-    migrate_set_capability(from, "multifd", true);
-    migrate_set_capability(to, "multifd", true);
-
-    return NULL;
-}
-
-static void test_multifd_file_mapped_ram_live(void)
-{
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .start_hook = migrate_multifd_mapped_ram_start,
-    };
-
-    test_file_common(&args, false);
-}
-
-static void test_multifd_file_mapped_ram(void)
-{
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .start_hook = migrate_multifd_mapped_ram_start,
-    };
-
-    test_file_common(&args, true);
-}
-
-static void *multifd_mapped_ram_dio_start(QTestState *from, QTestState *to)
-{
-    migrate_multifd_mapped_ram_start(from, to);
-
-    migrate_set_parameter_bool(from, "direct-io", true);
-    migrate_set_parameter_bool(to, "direct-io", true);
-
-    return NULL;
-}
-
-static void test_multifd_file_mapped_ram_dio(void)
-{
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .start_hook = multifd_mapped_ram_dio_start,
-    };
-
-    if (!probe_o_direct_support(tmpfs)) {
-        g_test_skip("Filesystem does not support O_DIRECT");
-        return;
-    }
-
-    test_file_common(&args, true);
-}
-
-#ifndef _WIN32
-static void multifd_mapped_ram_fdset_end(QTestState *from, QTestState *to,
-                                         void *opaque)
-{
-    QDict *resp;
-    QList *fdsets;
-
-    /*
-     * Remove the fdsets after migration, otherwise a second migration
-     * would fail due fdset reuse.
-     */
-    qtest_qmp_assert_success(from, "{'execute': 'remove-fd', "
-                             "'arguments': { 'fdset-id': 1}}");
-
-    /*
-     * Make sure no fdsets are left after migration, otherwise a
-     * second migration would fail due fdset reuse.
-     */
-    resp = qtest_qmp(from, "{'execute': 'query-fdsets', "
-                     "'arguments': {}}");
-    g_assert(qdict_haskey(resp, "return"));
-    fdsets = qdict_get_qlist(resp, "return");
-    g_assert(fdsets && qlist_empty(fdsets));
-    qobject_unref(resp);
-}
-
-static void *multifd_mapped_ram_fdset_dio_start(QTestState *from, QTestState *to)
-{
-    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
-
-    fdset_add_fds(from, file, O_WRONLY, 2, true);
-    fdset_add_fds(to, file, O_RDONLY, 2, true);
-
-    migrate_multifd_mapped_ram_start(from, to);
-    migrate_set_parameter_bool(from, "direct-io", true);
-    migrate_set_parameter_bool(to, "direct-io", true);
-
-    return NULL;
-}
-
-static void *multifd_mapped_ram_fdset_start(QTestState *from, QTestState *to)
-{
-    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
-
-    fdset_add_fds(from, file, O_WRONLY, 2, false);
-    fdset_add_fds(to, file, O_RDONLY, 2, false);
-
-    migrate_multifd_mapped_ram_start(from, to);
-
-    return NULL;
-}
-
-static void test_multifd_file_mapped_ram_fdset(void)
-{
-    g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
-                                           FILE_TEST_OFFSET);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .start_hook = multifd_mapped_ram_fdset_start,
-        .end_hook = multifd_mapped_ram_fdset_end,
-    };
-
-    test_file_common(&args, true);
-}
-
-static void test_multifd_file_mapped_ram_fdset_dio(void)
-{
-    g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
-                                           FILE_TEST_OFFSET);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .start_hook = multifd_mapped_ram_fdset_dio_start,
-        .end_hook = multifd_mapped_ram_fdset_end,
-    };
-
-    if (!probe_o_direct_support(tmpfs)) {
-        g_test_skip("Filesystem does not support O_DIRECT");
-        return;
-    }
-
-    test_file_common(&args, true);
-}
-#endif /* !_WIN32 */
-
 static void test_precopy_tcp_plain(void)
 {
     MigrateCommon args = {
@@ -1490,6 +1217,7 @@ int main(int argc, char **argv)
     migration_test_add_tls(env);
     migration_test_add_compression(env);
     migration_test_add_postcopy(env);
+    migration_test_add_file(env);
 
     migration_test_add("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
@@ -1505,17 +1233,6 @@ int main(int argc, char **argv)
 
     migration_test_add("/migration/precopy/unix/plain",
                        test_precopy_unix_plain);
-    migration_test_add("/migration/precopy/file",
-                       test_precopy_file);
-    migration_test_add("/migration/precopy/file/offset",
-                       test_precopy_file_offset);
-#ifndef _WIN32
-    migration_test_add("/migration/precopy/file/offset/fdset",
-                       test_precopy_file_offset_fdset);
-#endif
-    migration_test_add("/migration/precopy/file/offset/bad",
-                       test_precopy_file_offset_bad);
-
     /*
      * Our CI system has problems with shared memory.
      * Don't run this test until we find a workaround.
@@ -1524,26 +1241,6 @@ int main(int argc, char **argv)
         migration_test_add("/migration/mode/reboot", test_mode_reboot);
     }
 
-    migration_test_add("/migration/precopy/file/mapped-ram",
-                       test_precopy_file_mapped_ram);
-    migration_test_add("/migration/precopy/file/mapped-ram/live",
-                       test_precopy_file_mapped_ram_live);
-
-    migration_test_add("/migration/multifd/file/mapped-ram",
-                       test_multifd_file_mapped_ram);
-    migration_test_add("/migration/multifd/file/mapped-ram/live",
-                       test_multifd_file_mapped_ram_live);
-
-    migration_test_add("/migration/multifd/file/mapped-ram/dio",
-                       test_multifd_file_mapped_ram_dio);
-
-#ifndef _WIN32
-    migration_test_add("/migration/multifd/file/mapped-ram/fdset",
-                       test_multifd_file_mapped_ram_fdset);
-    migration_test_add("/migration/multifd/file/mapped-ram/fdset/dio",
-                       test_multifd_file_mapped_ram_fdset_dio);
-#endif
-
     migration_test_add("/migration/precopy/tcp/plain", test_precopy_tcp_plain);
 
     migration_test_add("/migration/precopy/tcp/plain/switchover-ack",
diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
new file mode 100644
index 0000000000..5942404807
--- /dev/null
+++ b/tests/qtest/migration/file-tests.c
@@ -0,0 +1,330 @@
+/*
+ * QTest testcases for migration to file
+ *
+ * Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
+ *   based on the vhost-user-test.c that is:
+ *      Copyright (c) 2014 Virtual Open Systems Sarl.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "migration/migration-common.h"
+#include "migration/migration-util.h"
+#include "qapi/qmp/qlist.h"
+
+
+static char *tmpfs;
+
+static void test_precopy_file(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+    };
+
+    test_file_common(&args, true);
+}
+
+#ifndef _WIN32
+static void fdset_add_fds(QTestState *qts, const char *file, int flags,
+                          int num_fds, bool direct_io)
+{
+    for (int i = 0; i < num_fds; i++) {
+        int fd;
+
+#ifdef O_DIRECT
+        /* only secondary channels can use direct-io */
+        if (direct_io && i != 0) {
+            flags |= O_DIRECT;
+        }
+#endif
+
+        fd = open(file, flags, 0660);
+        assert(fd != -1);
+
+        qtest_qmp_fds_assert_success(qts, &fd, 1, "{'execute': 'add-fd', "
+                                     "'arguments': {'fdset-id': 1}}");
+        close(fd);
+    }
+}
+
+static void *file_offset_fdset_start(QTestState *from, QTestState *to)
+{
+    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
+
+    fdset_add_fds(from, file, O_WRONLY, 1, false);
+    fdset_add_fds(to, file, O_RDONLY, 1, false);
+
+    return NULL;
+}
+
+static void test_precopy_file_offset_fdset(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
+                                           FILE_TEST_OFFSET);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = file_offset_fdset_start,
+    };
+
+    test_file_common(&args, false);
+}
+#endif
+
+static void test_precopy_file_offset(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s,offset=%d", tmpfs,
+                                           FILE_TEST_FILENAME,
+                                           FILE_TEST_OFFSET);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+    };
+
+    test_file_common(&args, false);
+}
+
+static void test_precopy_file_offset_bad(void)
+{
+    /* using a value not supported by qemu_strtosz() */
+    g_autofree char *uri = g_strdup_printf("file:%s/%s,offset=0x20M",
+                                           tmpfs, FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .result = MIG_TEST_QMP_ERROR,
+    };
+
+    test_file_common(&args, false);
+}
+
+static void *migrate_mapped_ram_start(QTestState *from, QTestState *to)
+{
+    migrate_set_capability(from, "mapped-ram", true);
+    migrate_set_capability(to, "mapped-ram", true);
+
+    return NULL;
+}
+
+static void test_precopy_file_mapped_ram_live(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = migrate_mapped_ram_start,
+    };
+
+    test_file_common(&args, false);
+}
+
+static void test_precopy_file_mapped_ram(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = migrate_mapped_ram_start,
+    };
+
+    test_file_common(&args, true);
+}
+
+static void *migrate_multifd_mapped_ram_start(QTestState *from, QTestState *to)
+{
+    migrate_mapped_ram_start(from, to);
+
+    migrate_set_parameter_int(from, "multifd-channels", 4);
+    migrate_set_parameter_int(to, "multifd-channels", 4);
+
+    migrate_set_capability(from, "multifd", true);
+    migrate_set_capability(to, "multifd", true);
+
+    return NULL;
+}
+
+static void test_multifd_file_mapped_ram_live(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = migrate_multifd_mapped_ram_start,
+    };
+
+    test_file_common(&args, false);
+}
+
+static void test_multifd_file_mapped_ram(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = migrate_multifd_mapped_ram_start,
+    };
+
+    test_file_common(&args, true);
+}
+
+static void *multifd_mapped_ram_dio_start(QTestState *from, QTestState *to)
+{
+    migrate_multifd_mapped_ram_start(from, to);
+
+    migrate_set_parameter_bool(from, "direct-io", true);
+    migrate_set_parameter_bool(to, "direct-io", true);
+
+    return NULL;
+}
+
+static void test_multifd_file_mapped_ram_dio(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = multifd_mapped_ram_dio_start,
+    };
+
+    if (!probe_o_direct_support(tmpfs)) {
+        g_test_skip("Filesystem does not support O_DIRECT");
+        return;
+    }
+
+    test_file_common(&args, true);
+}
+
+#ifndef _WIN32
+static void multifd_mapped_ram_fdset_end(QTestState *from, QTestState *to,
+                                         void *opaque)
+{
+    QDict *resp;
+    QList *fdsets;
+
+    /*
+     * Remove the fdsets after migration, otherwise a second migration
+     * would fail due fdset reuse.
+     */
+    qtest_qmp_assert_success(from, "{'execute': 'remove-fd', "
+                             "'arguments': { 'fdset-id': 1}}");
+
+    /*
+     * Make sure no fdsets are left after migration, otherwise a
+     * second migration would fail due fdset reuse.
+     */
+    resp = qtest_qmp(from, "{'execute': 'query-fdsets', "
+                     "'arguments': {}}");
+    g_assert(qdict_haskey(resp, "return"));
+    fdsets = qdict_get_qlist(resp, "return");
+    g_assert(fdsets && qlist_empty(fdsets));
+    qobject_unref(resp);
+}
+
+static void *multifd_mapped_ram_fdset_dio_start(QTestState *from, QTestState *to)
+{
+    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
+
+    fdset_add_fds(from, file, O_WRONLY, 2, true);
+    fdset_add_fds(to, file, O_RDONLY, 2, true);
+
+    migrate_multifd_mapped_ram_start(from, to);
+    migrate_set_parameter_bool(from, "direct-io", true);
+    migrate_set_parameter_bool(to, "direct-io", true);
+
+    return NULL;
+}
+
+static void *multifd_mapped_ram_fdset_start(QTestState *from, QTestState *to)
+{
+    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
+
+    fdset_add_fds(from, file, O_WRONLY, 2, false);
+    fdset_add_fds(to, file, O_RDONLY, 2, false);
+
+    migrate_multifd_mapped_ram_start(from, to);
+
+    return NULL;
+}
+
+static void test_multifd_file_mapped_ram_fdset(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
+                                           FILE_TEST_OFFSET);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = multifd_mapped_ram_fdset_start,
+        .end_hook = multifd_mapped_ram_fdset_end,
+    };
+
+    test_file_common(&args, true);
+}
+
+static void test_multifd_file_mapped_ram_fdset_dio(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
+                                           FILE_TEST_OFFSET);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = multifd_mapped_ram_fdset_dio_start,
+        .end_hook = multifd_mapped_ram_fdset_end,
+    };
+
+    if (!probe_o_direct_support(tmpfs)) {
+        g_test_skip("Filesystem does not support O_DIRECT");
+        return;
+    }
+
+    test_file_common(&args, true);
+}
+#endif /* !_WIN32 */
+
+void migration_test_add_file(MigrationTestEnv *env)
+{
+    tmpfs = env->tmpfs;
+
+    migration_test_add("/migration/precopy/file",
+                       test_precopy_file);
+
+    migration_test_add("/migration/precopy/file/offset",
+                       test_precopy_file_offset);
+#ifndef _WIN32
+    migration_test_add("/migration/precopy/file/offset/fdset",
+                       test_precopy_file_offset_fdset);
+#endif
+    migration_test_add("/migration/precopy/file/offset/bad",
+                       test_precopy_file_offset_bad);
+
+    migration_test_add("/migration/precopy/file/mapped-ram",
+                       test_precopy_file_mapped_ram);
+    migration_test_add("/migration/precopy/file/mapped-ram/live",
+                       test_precopy_file_mapped_ram_live);
+
+    migration_test_add("/migration/multifd/file/mapped-ram",
+                       test_multifd_file_mapped_ram);
+    migration_test_add("/migration/multifd/file/mapped-ram/live",
+                       test_multifd_file_mapped_ram_live);
+
+    migration_test_add("/migration/multifd/file/mapped-ram/dio",
+                       test_multifd_file_mapped_ram_dio);
+
+#ifndef _WIN32
+    migration_test_add("/migration/multifd/file/mapped-ram/fdset",
+                       test_multifd_file_mapped_ram_fdset);
+    migration_test_add("/migration/multifd/file/mapped-ram/fdset/dio",
+                       test_multifd_file_mapped_ram_fdset_dio);
+#endif
+}
diff --git a/tests/qtest/migration/migration-common.h b/tests/qtest/migration/migration-common.h
index 8ac6d2fa5d..8831b30cd9 100644
--- a/tests/qtest/migration/migration-common.h
+++ b/tests/qtest/migration/migration-common.h
@@ -218,5 +218,6 @@ static inline void migration_test_add_tls(MigrationTestEnv *env) {};
 #endif
 void migration_test_add_compression(MigrationTestEnv *env);
 void migration_test_add_postcopy(MigrationTestEnv *env);
+void migration_test_add_file(MigrationTestEnv *env);
 
 #endif /* MIGRATION_COMMON_H */
-- 
2.35.3


