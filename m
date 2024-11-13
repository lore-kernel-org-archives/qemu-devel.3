Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4878AD637AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 19:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBJKp-0006ke-FI; Wed, 13 Nov 2024 14:47:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJKo-0006j9-2j
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:47:26 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJKl-0003Cq-SX
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:47:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9CD361F44E;
 Wed, 13 Nov 2024 19:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iOid0kfN7iDAuZ1MWoYtJ5bJDZg039RZU6H8lADuay8=;
 b=XoR93qQxEAEi9zHJ/uQ985Exs6C56bDf3ybpcuZg611XCge+RRCWzuk3ovEKi8/d1yxJaV
 NM6oidqHsiBHNZX8+xGnrs3g1kfNstImL19SjhL4NS6fyUum09BX6+y3F68Od8qfcVf/1h
 ZOHq6PZKBzL6lMRDuAkEATdaFkTlIcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527242;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iOid0kfN7iDAuZ1MWoYtJ5bJDZg039RZU6H8lADuay8=;
 b=IPNNOSURtbgHn09s4x8zrRCHCd+Lr2cCj2vYdX89h3JQexas6lLaKTeQPhug1PwgMoB4Ui
 rLFI4hr0RabRS1Aw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XoR93qQx;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IPNNOSUR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iOid0kfN7iDAuZ1MWoYtJ5bJDZg039RZU6H8lADuay8=;
 b=XoR93qQxEAEi9zHJ/uQ985Exs6C56bDf3ybpcuZg611XCge+RRCWzuk3ovEKi8/d1yxJaV
 NM6oidqHsiBHNZX8+xGnrs3g1kfNstImL19SjhL4NS6fyUum09BX6+y3F68Od8qfcVf/1h
 ZOHq6PZKBzL6lMRDuAkEATdaFkTlIcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527242;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iOid0kfN7iDAuZ1MWoYtJ5bJDZg039RZU6H8lADuay8=;
 b=IPNNOSURtbgHn09s4x8zrRCHCd+Lr2cCj2vYdX89h3JQexas6lLaKTeQPhug1PwgMoB4Ui
 rLFI4hr0RabRS1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77C7613301;
 Wed, 13 Nov 2024 19:47:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eHQ8DkgCNWfLcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Nov 2024 19:47:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 19/22] tests/qtest/migration: Add migration-test-smoke
Date: Wed, 13 Nov 2024 16:46:27 -0300
Message-Id: <20241113194630.3385-20-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241113194630.3385-1-farosas@suse.de>
References: <20241113194630.3385-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9CD361F44E
X-Rspamd-Action: no action
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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
 tests/qtest/migration-test-smoke.c        | 39 +++++++++++++++++++++++
 tests/qtest/migration-test.c              | 12 +++++++
 tests/qtest/migration/compression-tests.c |  8 ++++-
 tests/qtest/migration/cpr-tests.c         |  8 ++++-
 tests/qtest/migration/file-tests.c        |  8 ++++-
 tests/qtest/migration/misc-tests.c        |  8 ++++-
 tests/qtest/migration/postcopy-tests.c    |  7 ++++
 tests/qtest/migration/precopy-tests.c     |  8 ++++-
 tests/qtest/migration/test-framework.h    |  8 +++++
 tests/qtest/migration/tls-tests.c         |  7 +++-
 11 files changed, 113 insertions(+), 7 deletions(-)
 create mode 100644 tests/qtest/migration-test-smoke.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 2b12a4d263..811117d264 100644
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
@@ -111,6 +112,7 @@ qtests_i386 = \
    'device-plug-test',
    'drive_del-test',
    'cpu-plug-test',
+   'migration-test-smoke',
    'migration-test',
   ]
 
@@ -185,7 +187,7 @@ qtests_ppc64 = \
   (slirp.found() ? ['pxe-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_USB_UHCI') ? ['usb-hcd-uhci-test'] : []) +             \
   (config_all_devices.has_key('CONFIG_USB_XHCI_NEC') ? ['usb-hcd-xhci-test'] : []) +         \
-  qtests_pci + ['migration-test', 'cpu-plug-test', 'drive_del-test']
+  qtests_pci + ['migration-test-smoke', 'migration-test', 'cpu-plug-test', 'drive_del-test']
 
 qtests_sh4 = (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : [])
 qtests_sh4eb = (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : [])
@@ -257,6 +259,7 @@ qtests_aarch64 = \
   ['arm-cpu-features',
    'numa-test',
    'boot-serial-test',
+   'migration-test-smoke',
    'migration-test']
 
 qtests_s390x = \
@@ -266,6 +269,7 @@ qtests_s390x = \
    'device-plug-test',
    'virtio-ccw-test',
    'cpu-plug-test',
+   'migration-test-smoke',
    'migration-test']
 
 qtests_riscv32 = \
@@ -359,6 +363,7 @@ qtests = {
   'dbus-vmstate-test': files('migration/migration-qmp.c', 'migration/migration-util.c') + dbus_vmstate1,
   'erst-test': files('erst-test.c'),
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
+  'migration-test-smoke': migration_files + migration_tls_files,
   'migration-test': migration_files + migration_tls_files,
   'pxe-test': files('boot-sector.c'),
   'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c'),
diff --git a/tests/qtest/migration-test-smoke.c b/tests/qtest/migration-test-smoke.c
new file mode 100644
index 0000000000..ff2d72881f
--- /dev/null
+++ b/tests/qtest/migration-test-smoke.c
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "migration/test-framework.h"
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
+        g_test_message(
+            "Smoke tests already run as part of the full suite on KVM hosts");
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
+    ret = migration_env_clean(env);
+
+    return ret;
+}
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 4c8ea397ec..73cb0bdfe6 100644
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
index 1b4c59338c..b48dc87239 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -205,9 +205,15 @@ static void test_multifd_tcp_zlib(void)
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
index 92bd42e61a..4fe6eefe86 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -44,9 +44,15 @@ static void test_mode_reboot(void)
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
index 90b0386f58..10a5cb648d 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -294,9 +294,15 @@ static void test_multifd_file_mapped_ram_fdset_dio(void)
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
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 6f2bc5cca1..480fbda1c9 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -250,9 +250,15 @@ static void test_validate_uri_channels_none_set(void)
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
index 9e2032bbf3..90d2d0820c 100644
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
index c7c802f812..393c7e226a 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -946,9 +946,15 @@ static void test_dirty_limit(void)
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
diff --git a/tests/qtest/migration/test-framework.h b/tests/qtest/migration/test-framework.h
index 207a11edb9..10cc4e524c 100644
--- a/tests/qtest/migration/test-framework.h
+++ b/tests/qtest/migration/test-framework.h
@@ -215,14 +215,22 @@ QTestMigrationState *get_src(void);
 
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
 
 #endif /* TEST_FRAMEWORK_H */
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 7609183474..264b54f352 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -722,10 +722,15 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
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


