Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3718EE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:12:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkpm-0004F9-CT; Thu, 12 Dec 2024 10:10:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpf-00046r-1u
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:29 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpb-0003Et-Tm
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:26 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8C7211F383;
 Thu, 12 Dec 2024 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tamm/SU96bvowTIFlTSD5ZUMayUrGoSSdgctsjqW6HQ=;
 b=E9s/xlvzNsWwMP+mT4ZBhYR/UyQwgoOCfighNwfFKfCXopCgdoAUQQN9gDF4aCD/Uj/mFv
 et9UnNBcmTIzIA6a6GRcqWsOMJIACEWmk7KaIVJnDL/rvVPLo25nfWB/lIHWhlmxlZYs5u
 hH7YX+yTfeBVkeK/ioPS/LyjSInbgf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016222;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tamm/SU96bvowTIFlTSD5ZUMayUrGoSSdgctsjqW6HQ=;
 b=HlApDcakgOAeSZDR+D5UiBTyrUH2rfLEOVdGdizMg0Aod3+1RJr4ZnSCJKBsMWs7Lx4FOq
 znCeliNXCeUJ5hDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tamm/SU96bvowTIFlTSD5ZUMayUrGoSSdgctsjqW6HQ=;
 b=E9s/xlvzNsWwMP+mT4ZBhYR/UyQwgoOCfighNwfFKfCXopCgdoAUQQN9gDF4aCD/Uj/mFv
 et9UnNBcmTIzIA6a6GRcqWsOMJIACEWmk7KaIVJnDL/rvVPLo25nfWB/lIHWhlmxlZYs5u
 hH7YX+yTfeBVkeK/ioPS/LyjSInbgf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016222;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tamm/SU96bvowTIFlTSD5ZUMayUrGoSSdgctsjqW6HQ=;
 b=HlApDcakgOAeSZDR+D5UiBTyrUH2rfLEOVdGdizMg0Aod3+1RJr4ZnSCJKBsMWs7Lx4FOq
 znCeliNXCeUJ5hDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FFB613508;
 Thu, 12 Dec 2024 15:10:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iEZ9Cd38WmcTfQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Dec 2024 15:10:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 18/22] tests/qtest/migration: Split file tests
Date: Thu, 12 Dec 2024 12:09:45 -0300
Message-Id: <20241212150949.16806-19-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241212150949.16806-1-farosas@suse.de>
References: <20241212150949.16806-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build            |   1 +
 tests/qtest/migration-test.c       | 311 +-------------------------
 tests/qtest/migration/file-tests.c | 338 +++++++++++++++++++++++++++++
 tests/qtest/migration/framework.h  |   1 +
 4 files changed, 341 insertions(+), 310 deletions(-)
 create mode 100644 tests/qtest/migration/file-tests.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index ff33034ca6..ede5a9fb61 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -338,6 +338,7 @@ migration_files = [files(
   'migration/migration-qmp.c',
   'migration/migration-util.c',
   'migration/compression-tests.c',
+  'migration/file-tests.c',
   'migration/postcopy-tests.c',
 )]
 
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index fa759022d1..a2ce1c6b19 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -215,93 +215,6 @@ static void test_ignore_shared(void)
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
-static void *migrate_hook_start_file_offset_fdset(QTestState *from,
-                                                  QTestState *to)
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
-        .start_hook = migrate_hook_start_file_offset_fdset,
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
 static void *migrate_hook_start_mode_reboot(QTestState *from, QTestState *to)
 {
     migrate_set_parameter_str(from, "mode", "cpr-reboot");
@@ -313,14 +226,6 @@ static void *migrate_hook_start_mode_reboot(QTestState *from, QTestState *to)
     return NULL;
 }
 
-static void *migrate_hook_start_mapped_ram(QTestState *from, QTestState *to)
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
@@ -335,190 +240,6 @@ static void test_mode_reboot(void)
     test_file_common(&args, true);
 }
 
-static void test_precopy_file_mapped_ram_live(void)
-{
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_mapped_ram,
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
-        .start_hook = migrate_hook_start_mapped_ram,
-    };
-
-    test_file_common(&args, true);
-}
-
-static void *migrate_hook_start_multifd_mapped_ram(QTestState *from,
-                                                   QTestState *to)
-{
-    migrate_hook_start_mapped_ram(from, to);
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
-        .start_hook = migrate_hook_start_multifd_mapped_ram,
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
-        .start_hook = migrate_hook_start_multifd_mapped_ram,
-    };
-
-    test_file_common(&args, true);
-}
-
-static void *migrate_hook_start_multifd_mapped_ram_dio(QTestState *from,
-                                                       QTestState *to)
-{
-    migrate_hook_start_multifd_mapped_ram(from, to);
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
-        .start_hook = migrate_hook_start_multifd_mapped_ram_dio,
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
-static void migrate_hook_end_multifd_mapped_ram_fdset(QTestState *from,
-                                                      QTestState *to,
-                                                      void *opaque)
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
-static void *migrate_hook_start_multifd_mapped_ram_fdset_dio(QTestState *from,
-                                                             QTestState *to)
-{
-    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
-
-    fdset_add_fds(from, file, O_WRONLY, 2, true);
-    fdset_add_fds(to, file, O_RDONLY, 2, true);
-
-    migrate_hook_start_multifd_mapped_ram(from, to);
-    migrate_set_parameter_bool(from, "direct-io", true);
-    migrate_set_parameter_bool(to, "direct-io", true);
-
-    return NULL;
-}
-
-static void *migrate_hook_start_multifd_mapped_ram_fdset(QTestState *from,
-                                                         QTestState *to)
-{
-    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
-
-    fdset_add_fds(from, file, O_WRONLY, 2, false);
-    fdset_add_fds(to, file, O_RDONLY, 2, false);
-
-    migrate_hook_start_multifd_mapped_ram(from, to);
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
-        .start_hook = migrate_hook_start_multifd_mapped_ram_fdset,
-        .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
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
-        .start_hook = migrate_hook_start_multifd_mapped_ram_fdset_dio,
-        .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
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
@@ -1500,6 +1221,7 @@ int main(int argc, char **argv)
     migration_test_add_tls(env);
     migration_test_add_compression(env);
     migration_test_add_postcopy(env);
+    migration_test_add_file(env);
 
     migration_test_add("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
@@ -1515,17 +1237,6 @@ int main(int argc, char **argv)
 
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
@@ -1534,26 +1245,6 @@ int main(int argc, char **argv)
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
index 0000000000..84225c8c33
--- /dev/null
+++ b/tests/qtest/migration/file-tests.c
@@ -0,0 +1,338 @@
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
+#include "migration/framework.h"
+#include "migration/migration-qmp.h"
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
+static void *migrate_hook_start_file_offset_fdset(QTestState *from,
+                                                  QTestState *to)
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
+        .start_hook = migrate_hook_start_file_offset_fdset,
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
+static void *migrate_hook_start_mapped_ram(QTestState *from,
+                                           QTestState *to)
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
+        .start_hook = migrate_hook_start_mapped_ram,
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
+        .start_hook = migrate_hook_start_mapped_ram,
+    };
+
+    test_file_common(&args, true);
+}
+
+static void *migrate_hook_start_multifd_mapped_ram(QTestState *from,
+                                                   QTestState *to)
+{
+    migrate_hook_start_mapped_ram(from, to);
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
+        .start_hook = migrate_hook_start_multifd_mapped_ram,
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
+        .start_hook = migrate_hook_start_multifd_mapped_ram,
+    };
+
+    test_file_common(&args, true);
+}
+
+static void *migrate_hook_start_multifd_mapped_ram_dio(QTestState *from,
+                                                       QTestState *to)
+{
+    migrate_hook_start_multifd_mapped_ram(from, to);
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
+        .start_hook = migrate_hook_start_multifd_mapped_ram_dio,
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
+static void migrate_hook_end_multifd_mapped_ram_fdset(QTestState *from,
+                                                      QTestState *to,
+                                                      void *opaque)
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
+static void *migrate_hook_start_multifd_mapped_ram_fdset_dio(QTestState *from,
+                                                             QTestState *to)
+{
+    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
+
+    fdset_add_fds(from, file, O_WRONLY, 2, true);
+    fdset_add_fds(to, file, O_RDONLY, 2, true);
+
+    migrate_hook_start_multifd_mapped_ram(from, to);
+    migrate_set_parameter_bool(from, "direct-io", true);
+    migrate_set_parameter_bool(to, "direct-io", true);
+
+    return NULL;
+}
+
+static void *migrate_hook_start_multifd_mapped_ram_fdset(QTestState *from,
+                                                         QTestState *to)
+{
+    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
+
+    fdset_add_fds(from, file, O_WRONLY, 2, false);
+    fdset_add_fds(to, file, O_RDONLY, 2, false);
+
+    migrate_hook_start_multifd_mapped_ram(from, to);
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
+        .start_hook = migrate_hook_start_multifd_mapped_ram_fdset,
+        .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
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
+        .start_hook = migrate_hook_start_multifd_mapped_ram_fdset_dio,
+        .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
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
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 1ac3aea4b2..6be434c6bf 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -222,5 +222,6 @@ static inline void migration_test_add_tls(MigrationTestEnv *env) {};
 #endif
 void migration_test_add_compression(MigrationTestEnv *env);
 void migration_test_add_postcopy(MigrationTestEnv *env);
+void migration_test_add_file(MigrationTestEnv *env);
 
 #endif /* TEST_FRAMEWORK_H */
-- 
2.35.3


