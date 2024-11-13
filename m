Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C75D637AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 19:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBJKR-0006N0-Fp; Wed, 13 Nov 2024 14:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJKP-0006MP-Mp
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:47:01 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJKN-0003A9-P2
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:47:01 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9AA3121133;
 Wed, 13 Nov 2024 19:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UqQEXV7yMOhrZ2BaUhgZ4+onUFlCWLRZaSn+/swrflw=;
 b=NMT/9T24HZCvBiR/i/OvybvEp6el7hXJLSjFgjqkZmFXysM6T17HTagCA+DlU7eK2qPvFt
 TbPYuUItMGNIrZ4CW+Uiz+WqBnlEEaXTy5hMruTK52Y9FL+6ApZKrKpNbxaimDV9NPmli5
 2GuIoAEmmoOzQkIPZnUQ0s2l1iCjzQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527218;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UqQEXV7yMOhrZ2BaUhgZ4+onUFlCWLRZaSn+/swrflw=;
 b=9d14pFwaWIXSNgNsf56uNiuTWG6IbfIsysX2Ag46Zdn2Bg9YrCIOTFumnrZ4cE4EUeaoOG
 qMCJb0x82WLd4NDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UqQEXV7yMOhrZ2BaUhgZ4+onUFlCWLRZaSn+/swrflw=;
 b=NMT/9T24HZCvBiR/i/OvybvEp6el7hXJLSjFgjqkZmFXysM6T17HTagCA+DlU7eK2qPvFt
 TbPYuUItMGNIrZ4CW+Uiz+WqBnlEEaXTy5hMruTK52Y9FL+6ApZKrKpNbxaimDV9NPmli5
 2GuIoAEmmoOzQkIPZnUQ0s2l1iCjzQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527218;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UqQEXV7yMOhrZ2BaUhgZ4+onUFlCWLRZaSn+/swrflw=;
 b=9d14pFwaWIXSNgNsf56uNiuTWG6IbfIsysX2Ag46Zdn2Bg9YrCIOTFumnrZ4cE4EUeaoOG
 qMCJb0x82WLd4NDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E75E113301;
 Wed, 13 Nov 2024 19:46:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KJzPKjACNWfLcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Nov 2024 19:46:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 10/22] tests/qtest/migration: Isolate test initialization
Date: Wed, 13 Nov 2024 16:46:18 -0300
Message-Id: <20241113194630.3385-11-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241113194630.3385-1-farosas@suse.de>
References: <20241113194630.3385-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
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

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 122 ++++++++++++++++++++++++-----------
 1 file changed, 86 insertions(+), 36 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 01ef0014bd..5e426a8885 100644
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
 
@@ -3424,63 +3441,99 @@ static void test_dirty_limit(void)
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
@@ -3492,7 +3545,7 @@ int main(int argc, char **argv)
                            test_postcopy_recovery_fail_handshake);
         migration_test_add("/migration/postcopy/recovery/double-failures/reconnect",
                            test_postcopy_recovery_fail_reconnect);
-        if (is_x86) {
+        if (env->is_x86) {
             migration_test_add("/migration/postcopy/suspend",
                                test_postcopy_suspend);
         }
@@ -3547,7 +3600,7 @@ int main(int argc, char **argv)
     migration_test_add("/migration/precopy/unix/tls/psk",
                        test_precopy_unix_tls_psk);
 
-    if (has_uffd) {
+    if (env->has_uffd) {
         /*
          * NOTE: psk test is enough for postcopy, as other types of TLS
          * channels are tested under precopy.  Here what we want to test is the
@@ -3622,9 +3675,9 @@ int main(int argc, char **argv)
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
@@ -3675,7 +3728,9 @@ int main(int argc, char **argv)
 #endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
-    if (g_str_equal(arch, "x86_64") && has_kvm && kvm_dirty_ring_supported()) {
+    if (g_str_equal(env->arch, "x86_64") &&
+        env->has_kvm && env->has_dirty_ring) {
+
         migration_test_add("/migration/dirty_ring",
                            test_precopy_unix_dirty_ring);
         if (qtest_has_machine("pc") && g_test_slow()) {
@@ -3688,13 +3743,8 @@ int main(int argc, char **argv)
 
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


