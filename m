Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A25D6ACFD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 18:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGMn5-0006ah-Oi; Wed, 27 Nov 2024 13:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tGMn1-0006ZU-P7
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:29:27 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tGMmz-0001we-Md
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:29:27 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BC0F51F38D;
 Wed, 27 Nov 2024 18:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732732163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3FKzBhvFbVGPd7Xi9EDLpKgdZy2KFQqE73Wu2zrVhgU=;
 b=m8Y6yGia0rvQwxjTTWuP011MrnHT3wGSHv/p2i4UKqsCsFJqUWjuyWs4O8B9t8FtS7WKMb
 oO9dphhhC8vQkUnVNwA9IzlVYI9zFtTvG3IRWR8Yj10RHfnxu6/n2PXzlO/r4wF3gkoThM
 5m0qnWSXWCAFn9ArnCTzF0K/AqBRhkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732732163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3FKzBhvFbVGPd7Xi9EDLpKgdZy2KFQqE73Wu2zrVhgU=;
 b=5xwvYQ6AVOeVrGbj/njXzDNhmqyAMSe9Yo/5gcXZRw5fdSxlscXPzX9gBN0sDLzYFm43Xg
 58AQxKxcaHEINWAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=m8Y6yGia;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5xwvYQ6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732732163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3FKzBhvFbVGPd7Xi9EDLpKgdZy2KFQqE73Wu2zrVhgU=;
 b=m8Y6yGia0rvQwxjTTWuP011MrnHT3wGSHv/p2i4UKqsCsFJqUWjuyWs4O8B9t8FtS7WKMb
 oO9dphhhC8vQkUnVNwA9IzlVYI9zFtTvG3IRWR8Yj10RHfnxu6/n2PXzlO/r4wF3gkoThM
 5m0qnWSXWCAFn9ArnCTzF0K/AqBRhkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732732163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3FKzBhvFbVGPd7Xi9EDLpKgdZy2KFQqE73Wu2zrVhgU=;
 b=5xwvYQ6AVOeVrGbj/njXzDNhmqyAMSe9Yo/5gcXZRw5fdSxlscXPzX9gBN0sDLzYFm43Xg
 58AQxKxcaHEINWAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C9DD13941;
 Wed, 27 Nov 2024 18:29:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SHCXFAJlR2faYQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 27 Nov 2024 18:29:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 09/17] tests/qtest/migration: Isolate test initialization
Date: Wed, 27 Nov 2024 15:28:53 -0300
Message-Id: <20241127182901.529-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241127182901.529-1-farosas@suse.de>
References: <20241127182901.529-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC0F51F38D
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

We currently have some environment validation to perform and flags to
set during the initialization of the tests. To be able to add more
migration test binaries, we'll need these tasks to be in their own
function so they can be called from more than one place.

Move the initialization code to a function and introduce the
MigrationTestEnv structure to hold the flags that are accessed during
test registration.

Make the env object static to avoid have to change all the code to
pass it around. Similarly with the tmpfs variable, which is used
extensively.

Note: I'm keeping the new functions in migration-test.c because they
are going to be moved in the next patch to the correct place.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 122 ++++++++++++++++++++++++-----------
 1 file changed, 86 insertions(+), 36 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index ab7cbb8251..5617445e6f 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -34,7 +34,6 @@
 
 unsigned start_address;
 unsigned end_address;
-static bool uffd_feature_thread_id;
 static QTestMigrationState src_state;
 static QTestMigrationState dst_state;
 
@@ -86,6 +85,22 @@ typedef enum PostcopyRecoveryFailStage {
 static char *tmpfs;
 static char *bootpath;
 
+typedef struct MigrationTestEnv {
+    bool has_kvm;
+    bool has_tcg;
+    bool has_uffd;
+    bool uffd_feature_thread_id;
+    bool has_dirty_ring;
+    bool is_x86;
+    const char *arch;
+    const char *qemu_src;
+    const char *qemu_dst;
+    char *tmpfs;
+} MigrationTestEnv;
+
+
+MigrationTestEnv *migration_get_env(void);
+
 /*
  * Wait for some output in the serial output file,
  * we get an 'A' followed by an endless string of 'B's
@@ -972,6 +987,8 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 static void migrate_postcopy_complete(QTestState *from, QTestState *to,
                                       MigrateCommon *args)
 {
+    MigrationTestEnv *env = migration_get_env();
+
     wait_for_migration_complete(from);
 
     if (args->start.suspend_me) {
@@ -982,7 +999,7 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
     /* Make sure we get at least one "B" on destination */
     wait_for_serial("dest_serial");
 
-    if (uffd_feature_thread_id) {
+    if (env->uffd_feature_thread_id) {
         read_blocktime(to);
     }
 
@@ -3429,63 +3446,99 @@ static void test_dirty_limit(void)
     migrate_end(from, to, true);
 }
 
-int main(int argc, char **argv)
+MigrationTestEnv *migration_get_env(void)
 {
-    bool has_kvm, has_tcg;
-    bool has_uffd, is_x86;
-    const char *arch;
+    static MigrationTestEnv *env;
     g_autoptr(GError) err = NULL;
-    const char *qemu_src = getenv(QEMU_ENV_SRC);
-    const char *qemu_dst = getenv(QEMU_ENV_DST);
-    int ret;
 
-    g_test_init(&argc, &argv, NULL);
+    if (env) {
+        return env;
+    }
+
+    env = g_new0(MigrationTestEnv, 1);
+    env->qemu_src = getenv(QEMU_ENV_SRC);
+    env->qemu_dst = getenv(QEMU_ENV_DST);
 
     /*
      * The default QTEST_QEMU_BINARY must always be provided because
      * that is what helpers use to query the accel type and
      * architecture.
      */
-    if (qemu_src && qemu_dst) {
+    if (env->qemu_src && env->qemu_dst) {
         g_test_message("Only one of %s, %s is allowed",
                        QEMU_ENV_SRC, QEMU_ENV_DST);
         exit(1);
     }
 
-    has_kvm = qtest_has_accel("kvm");
-    has_tcg = qtest_has_accel("tcg");
+    env->has_kvm = qtest_has_accel("kvm");
+    env->has_tcg = qtest_has_accel("tcg");
 
-    if (!has_tcg && !has_kvm) {
+    if (!env->has_tcg && !env->has_kvm) {
         g_test_skip("No KVM or TCG accelerator available");
-        return 0;
+        return env;
     }
 
-    has_uffd = ufd_version_check(&uffd_feature_thread_id);
-    arch = qtest_get_arch();
-    is_x86 = !strcmp(arch, "i386") || !strcmp(arch, "x86_64");
+    env->has_dirty_ring = kvm_dirty_ring_supported();
+    env->has_uffd = ufd_version_check(&env->uffd_feature_thread_id);
+    env->arch = qtest_get_arch();
+    env->is_x86 = !strcmp(env->arch, "i386") || !strcmp(env->arch, "x86_64");
 
-    tmpfs = g_dir_make_tmp("migration-test-XXXXXX", &err);
-    if (!tmpfs) {
+    env->tmpfs = g_dir_make_tmp("migration-test-XXXXXX", &err);
+    if (!env->tmpfs) {
         g_test_message("Can't create temporary directory in %s: %s",
                        g_get_tmp_dir(), err->message);
     }
-    g_assert(tmpfs);
+    g_assert(env->tmpfs);
 
+    return env;
+}
+
+static int migration_env_clean(MigrationTestEnv *env)
+{
+    char *tmpfs;
+    int ret = 0;
+
+    if (!env) {
+        return ret;
+    }
+
+    bootfile_delete();
+
+    tmpfs = env->tmpfs;
+    ret = rmdir(tmpfs);
+    if (ret != 0) {
+        g_test_message("unable to rmdir: path (%s): %s",
+                       tmpfs, strerror(errno));
+    }
+    g_free(tmpfs);
+
+    return ret;
+}
+
+int main(int argc, char **argv)
+{
+    MigrationTestEnv *env;
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+    env = migration_get_env();
     module_call_init(MODULE_INIT_QOM);
 
+    tmpfs = env->tmpfs;
+
     migration_test_add("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
     migration_test_add("/migration/analyze-script", test_analyze_script);
 #endif
 
-    if (is_x86) {
+    if (env->is_x86) {
         migration_test_add("/migration/precopy/unix/suspend/live",
                            test_precopy_unix_suspend_live);
         migration_test_add("/migration/precopy/unix/suspend/notlive",
                            test_precopy_unix_suspend_notlive);
     }
 
-    if (has_uffd) {
+    if (env->has_uffd) {
         migration_test_add("/migration/postcopy/plain", test_postcopy);
         migration_test_add("/migration/postcopy/recovery/plain",
                            test_postcopy_recovery);
@@ -3497,7 +3550,7 @@ int main(int argc, char **argv)
                            test_postcopy_recovery_fail_handshake);
         migration_test_add("/migration/postcopy/recovery/double-failures/reconnect",
                            test_postcopy_recovery_fail_reconnect);
-        if (is_x86) {
+        if (env->is_x86) {
             migration_test_add("/migration/postcopy/suspend",
                                test_postcopy_suspend);
         }
@@ -3552,7 +3605,7 @@ int main(int argc, char **argv)
     migration_test_add("/migration/precopy/unix/tls/psk",
                        test_precopy_unix_tls_psk);
 
-    if (has_uffd) {
+    if (env->has_uffd) {
         /*
          * NOTE: psk test is enough for postcopy, as other types of TLS
          * channels are tested under precopy.  Here what we want to test is the
@@ -3627,9 +3680,9 @@ int main(int argc, char **argv)
     if (g_test_slow()) {
         migration_test_add("/migration/auto_converge",
                            test_auto_converge);
-        if (g_str_equal(arch, "x86_64") &&
-            has_kvm && kvm_dirty_ring_supported()) {
-            migration_test_add("/migration/dirty_limit",
+        if (g_str_equal(env->arch, "x86_64") &&
+            env->has_kvm && env->has_dirty_ring) {
+            migration_test_add("/dirty_limit",
                                test_dirty_limit);
         }
     }
@@ -3680,7 +3733,9 @@ int main(int argc, char **argv)
 #endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
-    if (g_str_equal(arch, "x86_64") && has_kvm && kvm_dirty_ring_supported()) {
+    if (g_str_equal(env->arch, "x86_64") &&
+        env->has_kvm && env->has_dirty_ring) {
+
         migration_test_add("/migration/dirty_ring",
                            test_precopy_unix_dirty_ring);
         if (qtest_has_machine("pc") && g_test_slow()) {
@@ -3693,13 +3748,8 @@ int main(int argc, char **argv)
 
     g_assert_cmpint(ret, ==, 0);
 
-    bootfile_delete();
-    ret = rmdir(tmpfs);
-    if (ret != 0) {
-        g_test_message("unable to rmdir: path (%s): %s",
-                       tmpfs, strerror(errno));
-    }
-    g_free(tmpfs);
+    tmpfs = NULL;
+    ret = migration_env_clean(env);
 
     return ret;
 }
-- 
2.35.3


