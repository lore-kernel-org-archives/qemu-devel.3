Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559F5D637AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 19:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBJKn-0006fn-Kz; Wed, 13 Nov 2024 14:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJKd-0006WG-Q9
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:47:17 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJKb-0003BV-7D
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:47:15 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0BE1421111;
 Wed, 13 Nov 2024 19:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=baFNZPBJE1NyBySm8YSPo94ZZBf1IZW67w9ra5c6F7Q=;
 b=gBsTA7ypl/1TLFGvn6KxATV3biIGWSP55pHCYO7AKU9eWF6sIagZHjW2ZuMPiufU12K/JE
 m6X0JYYh0S5ZimD9tI1GeIO+lC8e5d5OO/XxyWpPqGeZeXlYtkUNY3oe4n+DR1Y2ag+utg
 aqE9l7knmxhVKuZFtizCddA+uAtsrp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527232;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=baFNZPBJE1NyBySm8YSPo94ZZBf1IZW67w9ra5c6F7Q=;
 b=8Aq26U5iOkulgk2Mwa0ZVV6H/xZAA68nm9eUAzry8t7Rd3rPsClYBaJQ1hCI88PeRriS+1
 W1wBbousjP6SfdBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gBsTA7yp;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8Aq26U5i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=baFNZPBJE1NyBySm8YSPo94ZZBf1IZW67w9ra5c6F7Q=;
 b=gBsTA7ypl/1TLFGvn6KxATV3biIGWSP55pHCYO7AKU9eWF6sIagZHjW2ZuMPiufU12K/JE
 m6X0JYYh0S5ZimD9tI1GeIO+lC8e5d5OO/XxyWpPqGeZeXlYtkUNY3oe4n+DR1Y2ag+utg
 aqE9l7knmxhVKuZFtizCddA+uAtsrp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527232;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=baFNZPBJE1NyBySm8YSPo94ZZBf1IZW67w9ra5c6F7Q=;
 b=8Aq26U5iOkulgk2Mwa0ZVV6H/xZAA68nm9eUAzry8t7Rd3rPsClYBaJQ1hCI88PeRriS+1
 W1wBbousjP6SfdBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E539913301;
 Wed, 13 Nov 2024 19:47:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8AAhKj0CNWfLcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Nov 2024 19:47:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 15/22] tests/qtest/migration: Split file tests
Date: Wed, 13 Nov 2024 16:46:23 -0300
Message-Id: <20241113194630.3385-16-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241113194630.3385-1-farosas@suse.de>
References: <20241113194630.3385-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0BE1421111
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RL6tyf6sue6knz55rs3us8rsc3)];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:email, suse.de:dkim, suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
 tests/qtest/meson.build                |   1 +
 tests/qtest/migration-test.c           | 306 +----------------------
 tests/qtest/migration/file-tests.c     | 332 +++++++++++++++++++++++++
 tests/qtest/migration/test-framework.h |   1 +
 4 files changed, 335 insertions(+), 305 deletions(-)
 create mode 100644 tests/qtest/migration/file-tests.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 23b600e6ec..ba07ca89bb 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -336,6 +336,7 @@ migration_files = [files(
   'migration/migration-qmp.c',
   'migration/migration-util.c',
   'migration/compression-tests.c',
+  'migration/file-tests.c',
   'migration/postcopy-tests.c',
 )]
 
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index d1d67fc42f..4138a2ebd8 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -215,92 +215,6 @@ static void test_ignore_shared(void)
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
@@ -312,14 +226,6 @@ static void *test_mode_reboot_start(QTestState *from, QTestState *to)
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
@@ -334,186 +240,6 @@ static void test_mode_reboot(void)
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
-static void *multifd_mapped_ram_fdset_dio_start(QTestState *from,
-                                                QTestState *to)
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
@@ -1495,6 +1221,7 @@ int main(int argc, char **argv)
     migration_test_add_tls(env);
     migration_test_add_compression(env);
     migration_test_add_postcopy(env);
+    migration_test_add_file(env);
 
     migration_test_add("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
@@ -1510,17 +1237,6 @@ int main(int argc, char **argv)
 
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
@@ -1529,26 +1245,6 @@ int main(int argc, char **argv)
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
index 0000000000..90b0386f58
--- /dev/null
+++ b/tests/qtest/migration/file-tests.c
@@ -0,0 +1,332 @@
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
+#include "migration/migration-qmp.h"
+#include "migration/migration-util.h"
+#include "migration/test-framework.h"
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
+static void *multifd_mapped_ram_fdset_dio_start(QTestState *from,
+                                                QTestState *to)
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
diff --git a/tests/qtest/migration/test-framework.h b/tests/qtest/migration/test-framework.h
index d5197e8da1..59f9da18ed 100644
--- a/tests/qtest/migration/test-framework.h
+++ b/tests/qtest/migration/test-framework.h
@@ -220,5 +220,6 @@ static inline void migration_test_add_tls(MigrationTestEnv *env) {};
 #endif
 void migration_test_add_compression(MigrationTestEnv *env);
 void migration_test_add_postcopy(MigrationTestEnv *env);
+void migration_test_add_file(MigrationTestEnv *env);
 
 #endif /* TEST_FRAMEWORK_H */
-- 
2.35.3


