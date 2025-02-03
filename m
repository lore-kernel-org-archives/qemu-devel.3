Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1CAC02196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texdd-0003sx-Vn; Mon, 03 Feb 2025 09:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texdL-0003fY-QQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:41:09 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texdB-0002O8-3b
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:41:06 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso792551666b.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 06:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738593655; x=1739198455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NqkvdbJVB8UnpcPUocH0maI2AO9mRVOLCVcPRrsvb5A=;
 b=AG5z2bCO3EoN92hSjtSanaYGrJqEvQ/Q52ptcQUuJesoF+dwISVzQ40cQ1bMbBTxI7
 77jY6w+34lygSFm1xnxuj9bjwaVhfEzRMnyBAXWKWtsDfhSNnpz7nCEWjx/hLoxTK1hy
 AXuQczhGRYtaHkDMUYBbmgr3enJP6b1eohCf2OS/NdBBMjyzip9YBL2fkKZoWrM/RnjG
 msyiChC0kZ3RyMaCcKLaEsL/tZBnF+wNsBSq2Ga/zp2hgsX611rBJyfXWeFI7DnbB2/n
 F5dlGHiVxMTOG5aB4aTuf/1jjvqCx4ZPppFYHfUNBonv+FUV4wDerazEsu3hN0/bYVNT
 FUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738593655; x=1739198455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NqkvdbJVB8UnpcPUocH0maI2AO9mRVOLCVcPRrsvb5A=;
 b=KqL5aDBkjtPcgZwS0UDowWRpgKuAKyULCmY2cMywoJGgCZ0/PG71uRK4N/7qhJGsj+
 h16P19ZDIGqkL39vHtwB/fVGQXttQIgbewRnhR3cANWkrQkBsrttoaK9S/5OS4FT0734
 vjPIsifP5q/aY6vd09Pytlkcg6E6b1QQul5pTzhpDbB7cXvBB7WetxgYFU51/tpPm5Xj
 I2l2FqdtW1WMP8iTmBz/XRzmnj/+l4NU+U1kQyH1C4JdNH3JbmpbJrsgTdqadmN8l7Wa
 OH51m2/AdWxZ5/ksCys4LQL9xu+HJTQ5Si3okqG1MGlyQk5IBeaHrHHBPYAjPg4s7/3t
 AreQ==
X-Gm-Message-State: AOJu0YxzAWe1En/u1y12u6HIfDAbSogYXCMJRpv85u12Vwc7H3xSZDnp
 xWmYCanCD/a1bJEl5k95F/dRevR7rjYIk/EQ86Tqa+5IdzEWGWp+PwJ/H6DAmmg=
X-Gm-Gg: ASbGncuQs158dvhB+E/VSEf9Dh9xeNeyh8YSKoJMWyxOPdJkH6FP2bms55IIIZjzui2
 gzjcsfGMwvMqvagdsIDI8TdoSvqzB0GELK7E8paI8RzbDZhv97d8J1bK7FxXVVoVurTkHbAstz3
 eu27tQeQhQo++zKv303N0uJalRS3Eu6dznLka1X928sJBs+xZ0YELalac/xlzdxvN8/J3dgdVZm
 OYxkYvW5xv1PbJyAfQQLDvc+C31Zbp4RfcZ88E0HIDqsuxLOnsPuQxVprebUmt/O6Jk+jv/+Men
 +eZQBDUvVqxMWNUO+g==
X-Google-Smtp-Source: AGHT+IEQdSsQBFqNvTf5x0rLvejw32f8+W18KIN47jGJS7+Q76a4wDMDkjs3VbipYSz8xDczWXWgHw==
X-Received: by 2002:a17:907:7d8a:b0:ab6:eeb4:504f with SMTP id
 a640c23a62f3a-ab6eeb457a8mr1558116566b.21.1738593655326; 
 Mon, 03 Feb 2025 06:40:55 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e4a59855sm763310266b.180.2025.02.03.06.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 06:40:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 673165FB89;
 Mon,  3 Feb 2025 14:40:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Hao Wu <wuhaotsh@google.com>, Peter Xu <peterx@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-rust@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Tyrone Ting <kfting@nuvoton.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 08/18] tests/qtest/migration: Add --full option
Date: Mon,  3 Feb 2025 14:40:38 +0000
Message-Id: <20250203144048.2131117-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250203144048.2131117-1-alex.bennee@linaro.org>
References: <20250203144048.2131117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

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
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20250130184012.5711-2-farosas@suse.de>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/migration/framework.h         |  1 +
 tests/qtest/migration-test.c              | 26 +++++++++++++++++++++++
 tests/qtest/migration/compression-tests.c |  4 ++++
 tests/qtest/migration/cpr-tests.c         |  4 ++++
 tests/qtest/migration/file-tests.c        |  4 ++++
 tests/qtest/migration/misc-tests.c        |  4 ++++
 tests/qtest/migration/postcopy-tests.c    |  4 ++++
 tests/qtest/migration/precopy-tests.c     |  4 ++++
 tests/qtest/migration/tls-tests.c         |  4 ++++
 tests/qtest/meson.build                   | 11 +++++++++-
 10 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index cb4a984700..e4a11870f6 100644
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
index 215b0df8c0..b1651fe48c 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -104,6 +104,10 @@ void migration_test_add_cpr(MigrationTestEnv *env)
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
 
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index dda3707cf3..996256ef87 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -262,6 +262,10 @@ void migration_test_add_misc(MigrationTestEnv *env)
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
index 436dbd98e8..c99a487bf1 100644
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
 
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index e60e92fe9d..1fa05e53a2 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -404,6 +404,8 @@ foreach dir : target_dirs
   target_base = dir.split('-')[0]
   qtest_emulator = emulators['qemu-system-' + target_base]
   target_qtests = get_variable('qtests_' + target_base, []) + qtests_generic
+  has_kvm = ('CONFIG_KVM' in config_all_accel and host_os == 'linux'
+             and cpu == target_base and fs.exists('/dev/kvm'))
 
   test_deps = roms
   qtest_env = environment()
@@ -437,11 +439,18 @@ foreach dir : target_dirs
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
-- 
2.39.5


