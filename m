Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0F3C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWRv-0005f9-LO; Mon, 10 Feb 2025 11:15:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR8-0004Eb-7P
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:06 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR4-0001W1-Ir
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:05 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5de4d3bbc76so5677339a12.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204100; x=1739808900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1wgsLERHHuZ71dnIxMpojeA2APBNTZ57iSA3i6scrhE=;
 b=CPCA7uUMLKrw7/qHknGYtgCPXWKI2UlABJfrfs/sZg9ILPE3BQFr7DNLMR1HZnll+Y
 5EAcwj9BSf9e4PlIq/1CMchmTcIQcgbmVIRbgpWzWfCChM7F2/9K1l76OfSIV49YlkWP
 M4wfgQJ4IOvOuyYJE87TKL0NC8JI6fTNmsQxZzZUcLQ6OBpa4E0XSmT7s6icngsC7GtM
 dJNRPYOnchOvxc3sZuw/kEi3gAZRqzxPVWfpxEcTGaCjopgkoo2nTG2vprIrvvejQJ4I
 XztZHo127fU44InpsbXstjKRdy3SN1OpFNKYaIsqaI16G3uHc8zlpoE2WuJEq6NK8aD/
 IV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204100; x=1739808900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1wgsLERHHuZ71dnIxMpojeA2APBNTZ57iSA3i6scrhE=;
 b=Jj6Aa78NbvEApPcVfyaDjESaZDdfRmY6CuccLNgsjotAILZWqw1ll4q3f58pES/+v+
 /zz7hXa82GlCXlwjYl+tH999D4DGvc8TCgNGMCobFxpm5580fVDiY4NtLEo9h1D266u7
 iRNFhgHMS/s+tb3weydx1jJ3sokKbLkTzdoBiQJ2Beb6XCPPUTaKzEgVHpe5r2w9xdgO
 imvhxQ35raVCVKsQuAcwILERR+0Nm7iXbrnSGf2GZIl4nbcqET2QFHpD0kTvVkzPTfcp
 tQgTIIg4CoLCOkF7NRbcECAoJsf090vVxPKX2NFDvk9LwwGWRdvg1LYMOJhHTqK5tUjH
 CiDg==
X-Gm-Message-State: AOJu0Yzm4MpkCQPdJmE0KZh7WukLPPMJQdwUsh3YpnwAiSaRyO4CYsue
 6fyDDHp40DzxS9k9IMVwlj1dq0MMEwBb16I1MC+PPG41Rn42L6XcpwxutTxVKJw=
X-Gm-Gg: ASbGncuPVuN9/VsPqGE6BxaZ/LVN8YMsKmSGf/WPYSbItVC/bm1GsW3XHv7nccH4R/y
 A4RTwpq7HK3kt5BInWUZnL9+pfoJU0uAtOI78uDoiKKiOtqwzoTT7hS0WmAWkiOsrTQtYTDeT6l
 vWLKKXjtV8MITL4bCdUgxqaF0ydqWR0ZUlYOhkjVdmrFSQGbMRaFao1vk9WJ3MgOxITCO/Mg0re
 kImh9eJUOzbi9RRa2fbXEfxKhowit97Dur/+NnJ0kHMYYK0n9Y4Ppxow599TypyDGvzOfr/ArKY
 Qd9cVLmivJozwMp3eg==
X-Google-Smtp-Source: AGHT+IHufHOT4/sLut4/aGvd+LMrR6n4Df27MJDm0SR1Kw1CbhXcegjSeSQnjqsnF2X4OLHibScEZA==
X-Received: by 2002:a05:6402:5409:b0:5dc:8ed9:6bc3 with SMTP id
 4fb4d7f45d1cf-5de450734d3mr13539900a12.26.1739204100277; 
 Mon, 10 Feb 2025 08:15:00 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5de5b2e4497sm5385155a12.47.2025.02.10.08.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:14:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9BDB660342;
 Mon, 10 Feb 2025 16:14:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 09/17] tests/qtest/migration: Pick smoke tests
Date: Mon, 10 Feb 2025 16:14:43 +0000
Message-Id: <20250210161451.3273284-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210161451.3273284-1-alex.bennee@linaro.org>
References: <20250210161451.3273284-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

Choose a few tests per group and move them from the full set to the
smoke set.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20250130184012.5711-3-farosas@suse.de>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250207153112.3939799-10-alex.bennee@linaro.org>

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 61180fcbd5..0893687174 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -46,7 +46,6 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
     env = migration_get_env();
     env->full_set = full_set;
-    env->full_set = true; /* temporary */
     module_call_init(MODULE_INIT_QOM);
 
     migration_test_add_tls(env);
diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index 9d0a258d51..8b58401b84 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -151,10 +151,18 @@ static void test_multifd_tcp_zlib(void)
     test_precopy_common(&args);
 }
 
+static void migration_test_add_compression_smoke(MigrationTestEnv *env)
+{
+    migration_test_add("/migration/multifd/tcp/plain/zlib",
+                       test_multifd_tcp_zlib);
+}
+
 void migration_test_add_compression(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
 
+    migration_test_add_compression_smoke(env);
+
     if (!env->full_set) {
         return;
     }
@@ -183,7 +191,4 @@ void migration_test_add_compression(MigrationTestEnv *env)
         migration_test_add("/migration/precopy/unix/xbzrle",
                            test_precopy_unix_xbzrle);
     }
-
-    migration_test_add("/migration/multifd/tcp/plain/zlib",
-                       test_multifd_tcp_zlib);
 }
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index b1651fe48c..4758841824 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -104,6 +104,8 @@ void migration_test_add_cpr(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
 
+    /* no tests in the smoke set for now */
+
     if (!env->full_set) {
         return;
     }
diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index 5b190853a5..f474b3590a 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -300,17 +300,25 @@ static void test_multifd_file_mapped_ram_fdset_dio(void)
 }
 #endif /* !_WIN32 */
 
+static void migration_test_add_file_smoke(MigrationTestEnv *env)
+{
+    migration_test_add("/migration/precopy/file",
+                       test_precopy_file);
+
+    migration_test_add("/migration/multifd/file/mapped-ram/dio",
+                       test_multifd_file_mapped_ram_dio);
+}
+
 void migration_test_add_file(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
 
+    migration_test_add_file_smoke(env);
+
     if (!env->full_set) {
         return;
     }
 
-    migration_test_add("/migration/precopy/file",
-                       test_precopy_file);
-
     migration_test_add("/migration/precopy/file/offset",
                        test_precopy_file_offset);
 #ifndef _WIN32
@@ -330,9 +338,6 @@ void migration_test_add_file(MigrationTestEnv *env)
     migration_test_add("/migration/multifd/file/mapped-ram/live",
                        test_multifd_file_mapped_ram_live);
 
-    migration_test_add("/migration/multifd/file/mapped-ram/dio",
-                       test_multifd_file_mapped_ram_dio);
-
 #ifndef _WIN32
     migration_test_add("/migration/multifd/file/mapped-ram/fdset",
                        test_multifd_file_mapped_ram_fdset);
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 996256ef87..d03199f3c5 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -258,18 +258,24 @@ static void test_validate_uri_channels_none_set(void)
     do_test_validate_uri_channel(&args);
 }
 
+static void migration_test_add_misc_smoke(MigrationTestEnv *env)
+{
+#ifndef _WIN32
+    migration_test_add("/migration/analyze-script", test_analyze_script);
+#endif
+}
+
 void migration_test_add_misc(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
 
+    migration_test_add_misc_smoke(env);
+
     if (!env->full_set) {
         return;
     }
 
     migration_test_add("/migration/bad_dest", test_baddest);
-#ifndef _WIN32
-    migration_test_add("/migration/analyze-script", test_analyze_script);
-#endif
 
     /*
      * Our CI system has problems with shared memory.
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index b08cde3270..7e84e60fea 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -79,18 +79,26 @@ static void test_postcopy_preempt_recovery(void)
     test_postcopy_recovery_common(&args);
 }
 
-void migration_test_add_postcopy(MigrationTestEnv *env)
+static void migration_test_add_postcopy_smoke(MigrationTestEnv *env)
 {
-    if (!env->full_set) {
-        return;
-    }
-
     if (env->has_uffd) {
         migration_test_add("/migration/postcopy/plain", test_postcopy);
         migration_test_add("/migration/postcopy/recovery/plain",
                            test_postcopy_recovery);
         migration_test_add("/migration/postcopy/preempt/plain",
                            test_postcopy_preempt);
+    }
+}
+
+void migration_test_add_postcopy(MigrationTestEnv *env)
+{
+    migration_test_add_postcopy_smoke(env);
+
+    if (!env->full_set) {
+        return;
+    }
+
+    if (env->has_uffd) {
         migration_test_add("/migration/postcopy/preempt/recovery/plain",
                            test_postcopy_preempt_recovery);
 
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index c99a487bf1..b16f10e908 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -951,14 +951,8 @@ static void test_dirty_limit(void)
     migrate_end(from, to, true);
 }
 
-void migration_test_add_precopy(MigrationTestEnv *env)
+static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
 {
-    tmpfs = env->tmpfs;
-
-    if (!env->full_set) {
-        return;
-    }
-
     if (env->is_x86) {
         migration_test_add("/migration/precopy/unix/suspend/live",
                            test_precopy_unix_suspend_live);
@@ -970,6 +964,21 @@ void migration_test_add_precopy(MigrationTestEnv *env)
                        test_precopy_unix_plain);
 
     migration_test_add("/migration/precopy/tcp/plain", test_precopy_tcp_plain);
+    migration_test_add("/migration/multifd/tcp/uri/plain/none",
+                       test_multifd_tcp_uri_none);
+    migration_test_add("/migration/multifd/tcp/plain/cancel",
+                       test_multifd_tcp_cancel);
+}
+
+void migration_test_add_precopy(MigrationTestEnv *env)
+{
+    tmpfs = env->tmpfs;
+
+    migration_test_add_precopy_smoke(env);
+
+    if (!env->full_set) {
+        return;
+    }
 
     migration_test_add("/migration/precopy/tcp/plain/switchover-ack",
                        test_precopy_tcp_switchover_ack);
@@ -993,16 +1002,12 @@ void migration_test_add_precopy(MigrationTestEnv *env)
                                test_dirty_limit);
         }
     }
-    migration_test_add("/migration/multifd/tcp/uri/plain/none",
-                       test_multifd_tcp_uri_none);
     migration_test_add("/migration/multifd/tcp/channels/plain/none",
                        test_multifd_tcp_channels_none);
     migration_test_add("/migration/multifd/tcp/plain/zero-page/legacy",
                        test_multifd_tcp_zero_page_legacy);
     migration_test_add("/migration/multifd/tcp/plain/zero-page/none",
                        test_multifd_tcp_no_zero_page);
-    migration_test_add("/migration/multifd/tcp/plain/cancel",
-                       test_multifd_tcp_cancel);
     if (g_str_equal(env->arch, "x86_64")
         && env->has_kvm && env->has_dirty_ring) {
 
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index aee56930ac..2cb4a44bcd 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -722,10 +722,18 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
 }
 #endif /* CONFIG_TASN1 */
 
+static void migration_test_add_tls_smoke(MigrationTestEnv *env)
+{
+    migration_test_add("/migration/precopy/tcp/tls/psk/match",
+                       test_precopy_tcp_tls_psk_match);
+}
+
 void migration_test_add_tls(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
 
+    migration_test_add_tls_smoke(env);
+
     if (!env->full_set) {
         return;
     }
@@ -755,8 +763,6 @@ void migration_test_add_tls(MigrationTestEnv *env)
                        test_precopy_unix_tls_x509_override_host);
 #endif /* CONFIG_TASN1 */
 
-    migration_test_add("/migration/precopy/tcp/tls/psk/match",
-                       test_precopy_tcp_tls_psk_match);
     migration_test_add("/migration/precopy/tcp/tls/psk/mismatch",
                        test_precopy_tcp_tls_psk_mismatch);
 #ifdef CONFIG_TASN1
-- 
2.39.5


