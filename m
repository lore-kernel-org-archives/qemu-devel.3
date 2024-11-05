Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B88CD3177B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8O03-0005cE-Fv; Tue, 05 Nov 2024 13:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8Nzq-00057C-1Q
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:44 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8Nzn-0004yK-Jp
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:41 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 63A5321E81;
 Tue,  5 Nov 2024 18:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=och+KVQ+FO2G5ucyAPNVcWOBDjg0EslBAa8xYh5u9Z4=;
 b=Yz3qQh5xyLolTHR7DfENZfbzOrc4usHrSdKN+40wPXrF/zUvd1bLKxR6Wvj03zCt72QzeO
 FcGIrqK7p0lM81JZ0IR8/KcEKxnfFxdsq5yOTQ3DttfYGlMBU+hWc/wVEyfjnELZPBJYqz
 o1Trr+xY14ex3DKioy+FpIjJJPdsOoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830178;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=och+KVQ+FO2G5ucyAPNVcWOBDjg0EslBAa8xYh5u9Z4=;
 b=PhXJ7TPuv8TAYiSaNZGrJtH5664GrR+WNMhdEykUamY6HJYWlwqfIqfO0AJWnC/vFpk9Sn
 7dC4voUjRQLc1SDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=och+KVQ+FO2G5ucyAPNVcWOBDjg0EslBAa8xYh5u9Z4=;
 b=Yz3qQh5xyLolTHR7DfENZfbzOrc4usHrSdKN+40wPXrF/zUvd1bLKxR6Wvj03zCt72QzeO
 FcGIrqK7p0lM81JZ0IR8/KcEKxnfFxdsq5yOTQ3DttfYGlMBU+hWc/wVEyfjnELZPBJYqz
 o1Trr+xY14ex3DKioy+FpIjJJPdsOoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830178;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=och+KVQ+FO2G5ucyAPNVcWOBDjg0EslBAa8xYh5u9Z4=;
 b=PhXJ7TPuv8TAYiSaNZGrJtH5664GrR+WNMhdEykUamY6HJYWlwqfIqfO0AJWnC/vFpk9Sn
 7dC4voUjRQLc1SDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DA571394A;
 Tue,  5 Nov 2024 18:09:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CPwfBGBfKmeCZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Nov 2024 18:09:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 19/22] tests/qtest/migration: Add migration-test-smoke
Date: Tue,  5 Nov 2024 15:08:34 -0300
Message-Id: <20241105180837.5990-20-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241105180837.5990-1-farosas@suse.de>
References: <20241105180837.5990-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL17uas3ff86ioo43146mh3mef)];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Add a new migration test to be ran as smoke test for each QEMU
target. This test will run only when the QEMU binary being used has no
KVM support, i.e. smoke tests run only on TCG.

Also modify the existing migration-test to run only when KVM is
present, i.e. the full set of tests will only run on a KVM host. To
still enable the full set to be ran anywhere for debug, ignore the
accel restriction when -m thorough is used.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build                   |  7 +++-
 tests/qtest/migration-test-smoke.c        | 40 +++++++++++++++++++++++
 tests/qtest/migration-test.c              | 12 +++++++
 tests/qtest/migration/compression-tests.c |  8 ++++-
 tests/qtest/migration/cpr-tests.c         |  8 ++++-
 tests/qtest/migration/file-tests.c        |  8 ++++-
 tests/qtest/migration/migration-common.h  |  8 +++++
 tests/qtest/migration/misc-tests.c        |  8 ++++-
 tests/qtest/migration/postcopy-tests.c    |  7 ++++
 tests/qtest/migration/precopy-tests.c     |  8 ++++-
 tests/qtest/migration/tls-tests.c         |  7 +++-
 11 files changed, 114 insertions(+), 7 deletions(-)
 create mode 100644 tests/qtest/migration-test-smoke.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 6bfed0553d..806af512d0 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -5,6 +5,7 @@ slow_qtests = {
   'cdrom-test' : 610,
   'device-introspect-test' : 720,
   'ide-test' : 120,
+  'migration-test-smoke' : 480,
   'migration-test' : 480,
   'npcm7xx_pwm-test': 300,
   'npcm7xx_watchdog_timer-test': 120,
@@ -110,6 +111,7 @@ qtests_i386 = \
    'device-plug-test',
    'drive_del-test',
    'cpu-plug-test',
+   'migration-test-smoke',
    'migration-test',
   ]
 
@@ -183,7 +185,7 @@ qtests_ppc64 = \
   (slirp.found() ? ['pxe-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_USB_UHCI') ? ['usb-hcd-uhci-test'] : []) +             \
   (config_all_devices.has_key('CONFIG_USB_XHCI_NEC') ? ['usb-hcd-xhci-test'] : []) +         \
-  qtests_pci + ['migration-test', 'cpu-plug-test', 'drive_del-test']
+  qtests_pci + ['migration-test-smoke', 'migration-test', 'cpu-plug-test', 'drive_del-test']
 
 qtests_sh4 = (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : [])
 qtests_sh4eb = (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : [])
@@ -255,6 +257,7 @@ qtests_aarch64 = \
   ['arm-cpu-features',
    'numa-test',
    'boot-serial-test',
+   'migration-test-smoke',
    'migration-test']
 
 qtests_s390x = \
@@ -264,6 +267,7 @@ qtests_s390x = \
    'device-plug-test',
    'virtio-ccw-test',
    'cpu-plug-test',
+   'migration-test-smoke',
    'migration-test']
 
 qtests_riscv32 = \
@@ -357,6 +361,7 @@ qtests = {
   'dbus-vmstate-test': files('migration/migration-qmp.c', 'migration/migration-util.c') + dbus_vmstate1,
   'erst-test': files('erst-test.c'),
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
+  'migration-test-smoke': migration_files + migration_tls_files,
   'migration-test': migration_files + migration_tls_files,
   'pxe-test': files('boot-sector.c'),
   'qos-test': [chardev, io, qos_test_ss.apply({}).sources()],
diff --git a/tests/qtest/migration-test-smoke.c b/tests/qtest/migration-test-smoke.c
new file mode 100644
index 0000000000..d2129121b5
--- /dev/null
+++ b/tests/qtest/migration-test-smoke.c
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "migration/bootfile.h"
+#include "migration/migration-common.h"
+#include "qemu/module.h"
+
+int main(int argc, char **argv)
+{
+    MigrationTestEnv *env;
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+    env = migration_get_env();
+    module_call_init(MODULE_INIT_QOM);
+
+    if (env->has_kvm) {
+        g_test_message("Smoke tests already run as part of the full suite on KVM hosts");
+        goto out;
+    }
+
+    migration_test_add_tls_smoke(env);
+    migration_test_add_compression_smoke(env);
+    migration_test_add_postcopy_smoke(env);
+    migration_test_add_file_smoke(env);
+    migration_test_add_precopy_smoke(env);
+    migration_test_add_cpr_smoke(env);
+    migration_test_add_misc_smoke(env);
+
+out:
+    ret = g_test_run();
+
+    g_assert_cmpint(ret, ==, 0);
+
+    bootfile_delete();
+    ret = migration_env_clean(env);
+
+    return ret;
+}
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 38a4a78c5c..9ca6f2a785 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -26,6 +26,17 @@ int main(int argc, char **argv)
     env = migration_get_env();
     module_call_init(MODULE_INIT_QOM);
 
+    /*
+     * Restrict the full set of tests to KVM hosts only. For tests
+     * that run in all platforms, see migration-test-smoke.c. Ignore
+     * the restriction if -m thorough was passed in the command line.
+     */
+    if (!g_test_thorough() && !env->has_kvm) {
+        g_test_message("Full test suite only runs on KVM hosts "
+                       "(override with -m thorough)");
+        goto out;
+    }
+
     migration_test_add_tls(env);
     migration_test_add_compression(env);
     migration_test_add_postcopy(env);
@@ -34,6 +45,7 @@ int main(int argc, char **argv)
     migration_test_add_cpr(env);
     migration_test_add_misc(env);
 
+out:
     ret = g_test_run();
 
     g_assert_cmpint(ret, ==, 0);
diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index 32f3d44586..87629e3b44 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -204,9 +204,15 @@ static void test_multifd_tcp_zlib(void)
     test_precopy_common(&args);
 }
 
-void migration_test_add_compression(MigrationTestEnv *env)
+void migration_test_add_compression_smoke(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
+    /* TODO: add smoke tests */
+}
+
+void migration_test_add_compression(MigrationTestEnv *env)
+{
+    migration_test_add_compression_smoke(env);
 
 #ifdef CONFIG_ZSTD
     migration_test_add("/migration/multifd/tcp/plain/zstd",
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index a3b4e6dac1..905b74f8dc 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -43,9 +43,15 @@ static void test_mode_reboot(void)
     test_file_common(&args, true);
 }
 
-void migration_test_add_cpr(MigrationTestEnv *env)
+void migration_test_add_cpr_smoke(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
+    /* TODO: add smoke tests */
+}
+
+void migration_test_add_cpr(MigrationTestEnv *env)
+{
+    migration_test_add_cpr_smoke(env);
 
     /*
      * Our CI system has problems with shared memory.
diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index 5942404807..011404e08c 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -292,9 +292,15 @@ static void test_multifd_file_mapped_ram_fdset_dio(void)
 }
 #endif /* !_WIN32 */
 
-void migration_test_add_file(MigrationTestEnv *env)
+void migration_test_add_file_smoke(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
+    /* TODO: add smoke tests */
+}
+
+void migration_test_add_file(MigrationTestEnv *env)
+{
+    migration_test_add_file_smoke(env);
 
     migration_test_add("/migration/precopy/file",
                        test_precopy_file);
diff --git a/tests/qtest/migration/migration-common.h b/tests/qtest/migration/migration-common.h
index 293371e200..05bf8ca3b6 100644
--- a/tests/qtest/migration/migration-common.h
+++ b/tests/qtest/migration/migration-common.h
@@ -213,14 +213,22 @@ int migration_env_clean(MigrationTestEnv *env);
 
 #ifdef CONFIG_GNUTLS
 void migration_test_add_tls(MigrationTestEnv *env);
+void migration_test_add_tls_smoke(MigrationTestEnv *env);
 #else
 static inline void migration_test_add_tls(MigrationTestEnv *env) {};
+static inline void migration_test_add_tls_smoke(MigrationTestEnv *env) {}
 #endif
 void migration_test_add_compression(MigrationTestEnv *env);
+void migration_test_add_compression_smoke(MigrationTestEnv *env);
 void migration_test_add_postcopy(MigrationTestEnv *env);
+void migration_test_add_postcopy_smoke(MigrationTestEnv *env);
 void migration_test_add_file(MigrationTestEnv *env);
+void migration_test_add_file_smoke(MigrationTestEnv *env);
 void migration_test_add_precopy(MigrationTestEnv *env);
+void migration_test_add_precopy_smoke(MigrationTestEnv *env);
 void migration_test_add_cpr(MigrationTestEnv *env);
+void migration_test_add_cpr_smoke(MigrationTestEnv *env);
 void migration_test_add_misc(MigrationTestEnv *env);
+void migration_test_add_misc_smoke(MigrationTestEnv *env);
 
 #endif /* MIGRATION_COMMON_H */
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 03d11e9599..12736e4184 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -249,9 +249,15 @@ static void test_validate_uri_channels_none_set(void)
     do_test_validate_uri_channel(&args);
 }
 
-void migration_test_add_misc(MigrationTestEnv *env)
+void migration_test_add_misc_smoke(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
+    /* TODO: add smoke tests */
+}
+
+void migration_test_add_misc(MigrationTestEnv *env)
+{
+    migration_test_add_misc_smoke(env);
 
     migration_test_add("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index 30ce54339c..d08b61f12f 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -79,8 +79,15 @@ static void test_postcopy_preempt_recovery(void)
     test_postcopy_recovery_common(&args);
 }
 
+void migration_test_add_postcopy_smoke(MigrationTestEnv *env)
+{
+    /* TODO: add smoke tests */
+}
+
 void migration_test_add_postcopy(MigrationTestEnv *env)
 {
+    migration_test_add_postcopy_smoke(env);
+
     if (env->has_uffd) {
         migration_test_add("/migration/postcopy/plain", test_postcopy);
         migration_test_add("/migration/postcopy/recovery/plain",
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index d73245ed37..743ecf281b 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -939,9 +939,15 @@ static void test_dirty_limit(void)
     migrate_end(from, to, true);
 }
 
-void migration_test_add_precopy(MigrationTestEnv *env)
+void migration_test_add_precopy_smoke(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
+    /* TODO: add smoke tests */
+}
+
+void migration_test_add_precopy(MigrationTestEnv *env)
+{
+    migration_test_add_precopy_smoke(env);
 
     if (env->is_x86) {
         migration_test_add("/migration/precopy/unix/suspend/live",
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 07d8d376f2..e923edbe7b 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -721,10 +721,15 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
 }
 #endif /* CONFIG_TASN1 */
 
-void migration_test_add_tls(MigrationTestEnv *env)
+void migration_test_add_tls_smoke(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
+    /* TODO: add smoke tests */
+}
 
+void migration_test_add_tls(MigrationTestEnv *env)
+{
+    migration_test_add_tls_smoke(env);
     migration_test_add("/migration/precopy/unix/tls/psk",
                        test_precopy_unix_tls_psk);
 
-- 
2.35.3


