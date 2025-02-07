Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C66BC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 15:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQLX-0001AP-6Z; Fri, 07 Feb 2025 10:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQKJ-00087K-6g
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:33 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQK7-0003z1-QY
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:30 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5dccc90a4f1so4648741a12.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 07:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738942278; x=1739547078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/x9zyKNP0wyMOO0OkiqcKDY+CZg3kixX2J65CnFDQGk=;
 b=fFzn8Azyi/tOvnjtCSr/pHbD33c854QJmQJFUGkIwNNwT4rMasfRuXV4Y94YdPOSCP
 INsKNDneRyi+W85DVOh+HdyaqbMUs0GDyC7OFboa5y6Q0nODorRpk+XJtC6F3eLXX8Q+
 Xa5dDLKyXNDIV8g35TqbOwU+dyiCfJj0KSDu/d/Rb0s1SyQ6Dj3iXTZiyn/2ppqx7EAY
 GEvWh09nfnZaKlza1BpCkaxHQLNGFJ9yPdmDyyR97W5nTYpZfX3FGryjch4WlJyYOtsA
 u6OCUlLogTMRjbDIahlR6pQ/g2oxxcJGLCnCKK7KsVPyMW9Rmn/jgZfyuGz3FWFijL4c
 t02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738942278; x=1739547078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/x9zyKNP0wyMOO0OkiqcKDY+CZg3kixX2J65CnFDQGk=;
 b=WZ01V5MhMOHkg+exzf09mpzzxDaSzmzjDOTOVFQzs44otuhf9BiPMMCl5ndvYt6KR6
 vAY160u5PMPxoVXZTTh4dse0yF+zEZCd9k8Y1nrMvUP1JyExnGjYU9pHcObRsQuxH3Ux
 /hBZW5rsE40f1lmcF+e8rSl2FmWoIfJp8F/VEkvSpemtmPFoJ9Oe9sFSF/pIpns/U1v2
 t2HFpOZ/NzLlOjSNXGNnT00V3jSN/hzk6i/ZocstGDUPElHMRkTR3ItbEEd/aCuSV0eB
 oZ+B297xrArwns39spfgNA2Bd8htD0YwMwSp+8xAxeNCXSAl9zyG4u3pCHH9zC7bR4pc
 RmNg==
X-Gm-Message-State: AOJu0YzmXmFynN4rUELtre5NHU0CqIe/+Ndfo9Jzt2dPbjtSiXJNiDew
 JZpCJqxod0CBrezQfsg5l+nPmyrwRXPK4MUDqubrYQmNUcx1hc+s5QnIMeBoCZk=
X-Gm-Gg: ASbGncuSPDmPDZFUbOdlkfvAyF3xUUmA/1eR80x2rjoto5tvGOa71nDsMlFcKF2aF6I
 Vj0lEwZm/xsb6/f40vozgZUPayJfvvGDhd/N+XYTifPK085FLJBkxF3A079Yuxh8Q3epAsJitSz
 3/n1Y+cLlzF9XMbeMzpnIhFOKNFuGt7ZV/IxUc7BKLm66sEZ4ZX5ur+qvfOSE/HX7+7LyXm9uX9
 ezM08bm76lAOUBdSTjbqU0jAhGs/L7deMJSJmb5ZLOBRkyhz7KGjsCoHjWltgYcjsXJ+I9OyINV
 Gx7snN6nY9StPWcbwQ==
X-Google-Smtp-Source: AGHT+IE/Wb9xFEyQEGY/fexAq4wyTqqhN2crFWx1pL5YMiaIVLUr4jrpoh+vUyHFbuyO6Cu660O8mQ==
X-Received: by 2002:a17:907:7f08:b0:aae:fd36:f511 with SMTP id
 a640c23a62f3a-ab789d3431bmr417074066b.47.1738942278075; 
 Fri, 07 Feb 2025 07:31:18 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab772fd67c2sm283222166b.77.2025.02.07.07.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:31:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 203625FB91;
 Fri,  7 Feb 2025 15:31:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Kyle Evans <kevans@freebsd.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 08/17] tests/qtest/migration: Add --full option
Date: Fri,  7 Feb 2025 15:31:03 +0000
Message-Id: <20250207153112.3939799-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207153112.3939799-1-alex.bennee@linaro.org>
References: <20250207153112.3939799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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
index 5e062c752a..68316dbdc1 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -405,6 +405,8 @@ foreach dir : target_dirs
   target_base = dir.split('-')[0]
   qtest_emulator = emulators['qemu-system-' + target_base]
   target_qtests = get_variable('qtests_' + target_base, []) + qtests_generic
+  has_kvm = ('CONFIG_KVM' in config_all_accel and host_os == 'linux'
+             and cpu == target_base and fs.exists('/dev/kvm'))
 
   test_deps = roms
   qtest_env = environment()
@@ -438,11 +440,18 @@ foreach dir : target_dirs
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


