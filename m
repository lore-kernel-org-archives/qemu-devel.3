Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7741EC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texda-0003pT-Gs; Mon, 03 Feb 2025 09:41:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texdP-0003gg-H6
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:41:12 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texdC-0002PA-Lr
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:41:09 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aaedd529ba1so624566866b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 06:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738593657; x=1739198457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pPUDkSmMPYbLWvU17ZzS5yeDzam6zW4TjOrPUFAUhlo=;
 b=oDMcGp52sMaT41Uhbt/AijUmdLSwvFIyKciJgrKPvm5/K6rhyXG2nCUydjd4jnPjgR
 REoZADm+yJ+ndTviXQllERpiWv1bPg0eVeLInFDEgZT7R2WsLuAImwgsJYxUlY7n71zr
 Uh1/+GZs9uLY1UEmBRMYlKThpT34u7aDHmu2PG8BJr0uJr5B1t674fLN7Vyb2Xb1EkhE
 wKrOtHaXgboD+djNpOFb1Yo6CjIYug6nCAQCMG1Sx0Qs77ymCDunwyGAMBkANQDzA4o9
 aNESt2EU8BgCdRhbRGZr5YYRdkb7X6Q0VZEg5gRQL9e2T0U6x+fjvEGFXrNaLjyMUp6q
 n7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738593657; x=1739198457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pPUDkSmMPYbLWvU17ZzS5yeDzam6zW4TjOrPUFAUhlo=;
 b=OKOCbQZsKKOMqJcdcCQubmzxarR2TP4n5uKGFmzZ4WnvDS32+Jky1nCbtBEurIn1Ep
 Yi6cSchF4OHIRHWKRYD79tQj7KTxrRe+Ebn3+BgVb6/lZOS2qLlpQ0Yf0rAkjsb2GE2q
 KYHtcVRPCqQaMZlbc9E/Y5QwDdc3AwLUzXOOltAvtS57GAg8ZPCo0OqhiyXcMX0+L6Gb
 35fYqYHgcL5ugbu+goarMYqcyorkbAhnjNpo+dq+opJzXeZUid2vye4nghogLT4kC1xk
 ZWOMr2qyHhU4o2xFSc4z5lQiAhrQ9WTfMs9toIrGVbmDlOFqtka0OtHiUllIQaWPvBMR
 +0Xg==
X-Gm-Message-State: AOJu0YzTJcUkhCouGkvixoBQZ32cO/J62a8FQ903CBkoLGMTR9ThnmQK
 Itda7KHAc3NxusL5xN1PYSmzjSyTRh4m/CAWh1Nw0DhIQaQItIcyKpMrdIFLK+A=
X-Gm-Gg: ASbGncun+Bvpvi7klQB3Sn3+kMITj91ipa13YU4tQ/aiocMWua/xYylewr2tjsVtFGY
 ItcLmj9HX1BTCdkYM4kxnL3hqjQmBmBJheSnyqzveAj4VRyUVzpjNffbRqO0DfIIfCUUh5IF5PY
 +DnFDwFICqQcXCJ1vs8Ab/Jz7V3KONkkdDXf0m7BEramlFEpM5J4umo3JImeqB78D1b68JPVI+e
 XfYrnV3ctiwKm1MLrAxQWl0slCYjLsmRle1Wt2CsV0qEARHNZEg65kM8XTuecMSNsc0D+EIxZ5N
 Ff8yKJOJZq++4w4j3w==
X-Google-Smtp-Source: AGHT+IGs4TtMsodgRCityQoHXDyQ+1wIkOHuoOhLukXnKOn6h1eademV+oT0/tFcGeZ424JyOnSQbQ==
X-Received: by 2002:a05:6402:4149:b0:5dc:a44e:7644 with SMTP id
 4fb4d7f45d1cf-5dca44e779fmr12991043a12.2.1738593656729; 
 Mon, 03 Feb 2025 06:40:56 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e4a314casm762664466b.127.2025.02.03.06.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 06:40:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 89A145FB91;
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
Subject: [PATCH 09/18] tests/qtest/migration: Pick smoke tests
Date: Mon,  3 Feb 2025 14:40:39 +0000
Message-Id: <20250203144048.2131117-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250203144048.2131117-1-alex.bennee@linaro.org>
References: <20250203144048.2131117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

From: Fabiano Rosas <farosas@suse.de>

Choose a few tests per group and move them from the full set to the
smoke set.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20250130184012.5711-3-farosas@suse.de>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/qtest/migration-test.c              |  1 -
 tests/qtest/migration/compression-tests.c | 11 ++++++---
 tests/qtest/migration/cpr-tests.c         |  2 ++
 tests/qtest/migration/file-tests.c        | 17 +++++++++-----
 tests/qtest/migration/misc-tests.c        | 12 +++++++---
 tests/qtest/migration/postcopy-tests.c    | 18 ++++++++++-----
 tests/qtest/migration/precopy-tests.c     | 27 ++++++++++++++---------
 tests/qtest/migration/tls-tests.c         | 10 +++++++--
 8 files changed, 67 insertions(+), 31 deletions(-)

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


