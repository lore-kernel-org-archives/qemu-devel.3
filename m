Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E06C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZT3-0000hI-Oj; Thu, 30 Jan 2025 13:40:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdZSk-0000dZ-3Q
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:40:27 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdZSg-0004wt-P5
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:40:25 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6D8E621171;
 Thu, 30 Jan 2025 18:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738262419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zRXPqVJyBx9sQGZ9iiIDPL+FITTHc5Pi/le2VFQQfls=;
 b=MEUH63OMvmCTWWKVQlMo37pUfLpEg3w76GznAnx0c15wk56ceWDJqSYhlWafQ4HBB4cY6Q
 C6ZXSEHGvmwuAD0sEFQ5n6Upszla7aStKgaeDwnbMAaaptu9U8cY2jtmEj2kYdCLgtEnRT
 37G/yK4gzX1sLlLPJu0WSGKBsW0kYQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738262419;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zRXPqVJyBx9sQGZ9iiIDPL+FITTHc5Pi/le2VFQQfls=;
 b=blUaQcjv+G8oIaktssJ1zw6qaJxHEf0tOhWrTEj1LKe1r10BgCNhDUDhgy/pac0HScJLyd
 mnbczeUsdJBB8lCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738262419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zRXPqVJyBx9sQGZ9iiIDPL+FITTHc5Pi/le2VFQQfls=;
 b=MEUH63OMvmCTWWKVQlMo37pUfLpEg3w76GznAnx0c15wk56ceWDJqSYhlWafQ4HBB4cY6Q
 C6ZXSEHGvmwuAD0sEFQ5n6Upszla7aStKgaeDwnbMAaaptu9U8cY2jtmEj2kYdCLgtEnRT
 37G/yK4gzX1sLlLPJu0WSGKBsW0kYQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738262419;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zRXPqVJyBx9sQGZ9iiIDPL+FITTHc5Pi/le2VFQQfls=;
 b=blUaQcjv+G8oIaktssJ1zw6qaJxHEf0tOhWrTEj1LKe1r10BgCNhDUDhgy/pac0HScJLyd
 mnbczeUsdJBB8lCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C15C1364B;
 Thu, 30 Jan 2025 18:40:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iBG4EpHHm2d2OwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 30 Jan 2025 18:40:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/2] tests/qtest/migration: Add --full option
Date: Thu, 30 Jan 2025 15:40:11 -0300
Message-Id: <20250130184012.5711-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250130184012.5711-1-farosas@suse.de>
References: <20250130184012.5711-1-farosas@suse.de>
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
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Add a new command line option to allow selecting between running the
full set of tests or a smaller set of tests. The default will be to
run the small set (i.e. no comand line option provided) so we can
reduce the amount of tests run by default. Only hosts which support
KVM for the target architecture being tested will run the complete set
of tests.

Adjust the meson.build file to pass in the --full option when
appropriate.

(for now, set the option unconditionally until the next patch actually
creates the small set)

Use cases:

configure --target-list=aarch64-softmmu,ppc64-softmmu,s390x-softmmu,x86_64-softmmu

                        | before - 615s/244 tests  | after - 244s/100 tests
------------------------+--------------------------+-----------------------------
make check              | full set for all archs   | full set for the KVM arch,
make check-qtest        |                          | small set for the rest
                        |                          |
qemu-system-$ARCH       | full set for $ARCH       | small set for $ARCH, KVM or
./migration-test        |                          | TCG automatically chosen
                        |                          |
qemu-system-$ARCH       | N/A                      | full set for $ARCH, KVM or
./migration-test --full |                          | TCG automatically chosen
                        |                          |
migration-compat-x86_64 | full set for x86_64      | small set for x86_64
CI job                  |                          |
------------------------+--------------------------+-----------------------------

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build                   | 11 +++++++++-
 tests/qtest/migration-test.c              | 26 +++++++++++++++++++++++
 tests/qtest/migration/compression-tests.c |  4 ++++
 tests/qtest/migration/cpr-tests.c         |  4 ++++
 tests/qtest/migration/file-tests.c        |  4 ++++
 tests/qtest/migration/framework.h         |  1 +
 tests/qtest/migration/misc-tests.c        |  4 ++++
 tests/qtest/migration/postcopy-tests.c    |  4 ++++
 tests/qtest/migration/precopy-tests.c     |  4 ++++
 tests/qtest/migration/tls-tests.c         |  4 ++++
 10 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 94b28e5a53..0219b90a70 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -402,6 +402,8 @@ foreach dir : target_dirs
   target_base = dir.split('-')[0]
   qtest_emulator = emulators['qemu-system-' + target_base]
   target_qtests = get_variable('qtests_' + target_base, []) + qtests_generic
+  has_kvm = ('CONFIG_KVM' in config_all_accel and host_os == 'linux'
+             and cpu == target_base and fs.exists('/dev/kvm'))
 
   test_deps = roms
   qtest_env = environment()
@@ -435,11 +437,18 @@ foreach dir : target_dirs
         test: executable(test, src, dependencies: deps)
       }
     endif
+
+    test_args = ['--tap', '-k']
+
+    if test == 'migration-test' and has_kvm
+      test_args += ['--full']
+    endif
+
     test('qtest-@0@/@1@'.format(target_base, test),
          qtest_executables[test],
          depends: [test_deps, qtest_emulator, emulator_modules],
          env: qtest_env,
-         args: ['--tap', '-k'],
+         args: test_args,
          protocol: 'tap',
          timeout: slow_qtests.get(test, 60),
          priority: slow_qtests.get(test, 60),
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 5cad5060b3..61180fcbd5 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -14,13 +14,39 @@
 #include "migration/framework.h"
 #include "qemu/module.h"
 
+static void parse_args(int *argc_p, char ***argv_p, bool *full_set)
+{
+    int argc = *argc_p;
+    char **argv = *argv_p;
+    int i, j;
+
+    j = 1;
+    for (i = 1; i < argc; i++) {
+        if (g_str_equal(argv[i], "--full")) {
+            *full_set = true;
+            continue;
+        }
+        argv[j++] = argv[i];
+        if (i >= j) {
+            argv[i] = NULL;
+        }
+    }
+    *argc_p = j;
+}
+
 int main(int argc, char **argv)
 {
     MigrationTestEnv *env;
     int ret;
+    bool full_set = false;
+
+    /* strip the --full option if it's present */
+    parse_args(&argc, &argv, &full_set);
 
     g_test_init(&argc, &argv, NULL);
     env = migration_get_env();
+    env->full_set = full_set;
+    env->full_set = true; /* temporary */
     module_call_init(MODULE_INIT_QOM);
 
     migration_test_add_tls(env);
diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index d78f1f11f1..9d0a258d51 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -155,6 +155,10 @@ void migration_test_add_compression(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
 
+    if (!env->full_set) {
+        return;
+    }
+
 #ifdef CONFIG_ZSTD
     migration_test_add("/migration/multifd/tcp/plain/zstd",
                        test_multifd_tcp_zstd);
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 44ce89aa5b..3faa180dfb 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -48,6 +48,10 @@ void migration_test_add_cpr(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
 
+    if (!env->full_set) {
+        return;
+    }
+
     /*
      * Our CI system has problems with shared memory.
      * Don't run this test until we find a workaround.
diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index 84225c8c33..5b190853a5 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -304,6 +304,10 @@ void migration_test_add_file(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
 
+    if (!env->full_set) {
+        return;
+    }
+
     migration_test_add("/migration/precopy/file",
                        test_precopy_file);
 
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 7991ee56b6..115f887f14 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -24,6 +24,7 @@ typedef struct MigrationTestEnv {
     bool uffd_feature_thread_id;
     bool has_dirty_ring;
     bool is_x86;
+    bool full_set;
     const char *arch;
     const char *qemu_src;
     const char *qemu_dst;
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 6173430748..1a57de409a 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -255,6 +255,10 @@ void migration_test_add_misc(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
 
+    if (!env->full_set) {
+        return;
+    }
+
     migration_test_add("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
     migration_test_add("/migration/analyze-script", test_analyze_script);
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index daf7449f2c..b08cde3270 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -81,6 +81,10 @@ static void test_postcopy_preempt_recovery(void)
 
 void migration_test_add_postcopy(MigrationTestEnv *env)
 {
+    if (!env->full_set) {
+        return;
+    }
+
     if (env->has_uffd) {
         migration_test_add("/migration/postcopy/plain", test_postcopy);
         migration_test_add("/migration/postcopy/recovery/plain",
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 23599b29ee..a3cf813579 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -955,6 +955,10 @@ void migration_test_add_precopy(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
 
+    if (!env->full_set) {
+        return;
+    }
+
     if (env->is_x86) {
         migration_test_add("/migration/precopy/unix/suspend/live",
                            test_precopy_unix_suspend_live);
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 5704a1f992..aee56930ac 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -726,6 +726,10 @@ void migration_test_add_tls(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
 
+    if (!env->full_set) {
+        return;
+    }
+
     migration_test_add("/migration/precopy/unix/tls/psk",
                        test_precopy_unix_tls_psk);
 
-- 
2.35.3


