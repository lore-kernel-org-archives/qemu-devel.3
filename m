Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8D7C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWRp-0005Gl-Ox; Mon, 10 Feb 2025 11:15:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR5-0004C2-P9
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:05 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR2-0001VH-7R
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:02 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ab7cc0c1a37so142657466b.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204098; x=1739808898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VG//uhabKjRFgO3Unu/weU5aBAHUld/kAOriyLnP5SU=;
 b=B2pwEjDVJEEsCqLic+YxOAHak0TY1ynLSh+63rmafVhsukwMrNsHCDpBQtInbPo2C2
 YSd5+H6+k9yZ2AAq1VUBZqnd/4WP7KVGkbzkGDiWbruhBT/NXoWPk+SwPh+xUvRRMr0t
 BoE+ndQu6VfsocGoZzkzzQRTcFW0Oqx9TsUf7ZC1UtSrrNVdOuJ6dnnE9S5AYMbrSGKx
 mfKW/epWb2DiNcz6S8vYuwJWWSI4iOa3/v04YgTLqm+GpU33gnWtqXRzmqlXPADlVpwx
 0qht4AQPyojy9uCPVZk6VcQWRH/dMJnMnrfuSajKB3C/1TPDDNsS9Z7aYb78l/zE9cy8
 3WFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204098; x=1739808898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VG//uhabKjRFgO3Unu/weU5aBAHUld/kAOriyLnP5SU=;
 b=MLvu5XZICUcyM+s224kSz/p98aZ099+1lzhVUdaxlaalHRjEnYgiV4Vftth9qkHQZ2
 ZcUVVQU5uYW1CfjrfvG3iuP0ieVTh9BqIJyTr9lnvmL9auWBMVs5isjnuYOgdl/hRnUy
 vKtEXkiJmWz8UFebUNkSL38lD/bP0VNqm+LXPNS3GQWNm7Pt6b0LtSg/2EmE4UeYY4HF
 SMRFL85Zxstm7Q0IspLoQ5Mz357uKR4QowuY0ehdlPXsc4Guxj/74MCbwYvp4PFonclX
 wb/owRJSaskgvVVJB1uBXfz9WPNK4JKAk5eFGSmmAN9XPbpS0OeHfDXUMDkUxwxYiuAK
 z6BA==
X-Gm-Message-State: AOJu0YyhNAbzzcY6qzCri4Nykp+ujTHJDuFAGXinxDTmGr1S5gtHJd63
 P1rsgYCnEQ+foxJDnbww32QJFUwMXJDO/plnTH30/4e+/01p1/+QNcBwLfbuDVBNSpIXugSmz4u
 vWlY=
X-Gm-Gg: ASbGnctORLh6z/gSD4ecD1n+Z6NgDkFqkHKtxY3PpJh6LzkDfSGBfPn6Mm4yJHHIpUE
 xRF9lIAA4nexx8YeWicM/UI85flSK3zanRIB9vklfPdG0VE0JP6YxUZKeIbnZw8I5DbytbuSkgn
 XW1Ms7fZmxA5ZKJQuMGfZk3HXUNwseTpj1eHHZu6iUIs0pQfGeX42YElAjo7Q5UHDObE55iQX58
 WLmbhieKWHlxH/o4koa9klSJ8TH3K0RN83Jq/vexciNPd8BVWc8PItWxbiypzuAt0AyY7hc2hfk
 BOZEX2xCQPLDxxCTrg==
X-Google-Smtp-Source: AGHT+IGkG762GIprzXT0Tcs53sVwjaLZe1qhPWjnQnjdOdaa7Zwe8m/QlWgGhKSPeIo5W2/Mj5o0fw==
X-Received: by 2002:a17:907:da6:b0:ab7:877d:ec47 with SMTP id
 a640c23a62f3a-ab789bf95e3mr1310677566b.41.1739204098518; 
 Mon, 10 Feb 2025 08:14:58 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7c01cba8asm252173766b.0.2025.02.10.08.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:14:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7EA5D60335;
 Mon, 10 Feb 2025 16:14:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 08/17] tests/qtest/migration: Add --full option
Date: Mon, 10 Feb 2025 16:14:42 +0000
Message-Id: <20250210161451.3273284-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210161451.3273284-1-alex.bennee@linaro.org>
References: <20250210161451.3273284-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Message-Id: <20250207153112.3939799-9-alex.bennee@linaro.org>

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


