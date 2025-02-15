Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE24DC021A0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 12:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjHLB-00066k-4T; Sat, 15 Feb 2025 07:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tjHKy-00065A-50
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 07:32:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tjHKv-0002pM-Ex
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 07:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739622716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xW/oi6Gxop3g0IdpDTZKixwh9RwaV8vJ8X83N82Jv78=;
 b=E1cwTbC1O23EneLS+vcCJpgW0aZUuJ6Xnji5KeUGhipFu2FqI/5/vTeeoqK0UgECqck2Tm
 hpfFZdNPpIBk8A1V4yRI5bsxRQUXHOZNF9E7Y2bG6Ox2fyq6opGs+KC3T/5D8QQ4UD2Kmm
 uMzDaYLcf3hHg+2Iae80WX/Dr//1PUQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-BJqoBmwaPpuiYXO-Wj4JoA-1; Sat,
 15 Feb 2025 07:31:51 -0500
X-MC-Unique: BJqoBmwaPpuiYXO-Wj4JoA-1
X-Mimecast-MFC-AGG-ID: BJqoBmwaPpuiYXO-Wj4JoA_1739622710
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A720D1975AFC; Sat, 15 Feb 2025 12:31:50 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.149])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 222FD1800360; Sat, 15 Feb 2025 12:31:46 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v6 4/4] tests/qtest/migration: add postcopy tests with multifd
Date: Sat, 15 Feb 2025 18:01:19 +0530
Message-ID: <20250215123119.814345-5-ppandit@redhat.com>
In-Reply-To: <20250215123119.814345-1-ppandit@redhat.com>
References: <20250215123119.814345-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.195,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Prasad Pandit <pjp@fedoraproject.org>

Add new qtests to run postcopy migration with multifd
channels enabled.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 tests/qtest/migration/compression-tests.c | 13 ++++++++
 tests/qtest/migration/framework.c         |  4 +++
 tests/qtest/migration/postcopy-tests.c    | 23 +++++++++++++
 tests/qtest/migration/precopy-tests.c     | 19 +++++++++++
 tests/qtest/migration/tls-tests.c         | 40 +++++++++++++++++++++++
 5 files changed, 99 insertions(+)

v6:
- Reorder, make this the second patch in this series.

v5:
- https://lore.kernel.org/qemu-devel/20250205122712.229151-1-ppandit@redhat.com/T/#t

diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index 4558a7b9ff..d4d6b3c4de 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -40,6 +40,17 @@ static void test_multifd_tcp_zstd(void)
     };
     test_precopy_common(&args);
 }
+
+static void test_multifd_postcopy_tcp_zstd(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true,
+        .start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
+    };
+
+    test_precopy_common(&args);
+}
 #endif /* CONFIG_ZSTD */
 
 #ifdef CONFIG_QATZIP
@@ -172,6 +183,8 @@ void migration_test_add_compression(MigrationTestEnv *env)
 #ifdef CONFIG_ZSTD
     migration_test_add("/migration/multifd/tcp/plain/zstd",
                        test_multifd_tcp_zstd);
+    migration_test_add("/migration/multifd+postcopy/tcp/plain/zstd",
+                       test_multifd_postcopy_tcp_zstd);
 #endif
 
 #ifdef CONFIG_QATZIP
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 82aaa13e85..2396405b51 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -469,6 +469,10 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     args->caps[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME] = true;
     args->caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
     set_migration_capabilities(from, to, args);
+    if (args->caps[MIGRATION_CAPABILITY_MULTIFD]) {
+        migrate_set_parameter_int(from, "multifd-channels", 8);
+        migrate_set_parameter_int(to, "multifd-channels", 8);
+    }
 
     migrate_ensure_non_converge(from);
     migrate_prepare_for_dirty_mem(from);
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index b0e70a6367..32fe7b0324 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -90,6 +90,25 @@ static void migration_test_add_postcopy_smoke(MigrationTestEnv *env)
     }
 }
 
+static void test_multifd_postcopy(void)
+{
+    MigrateCommon args = {
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+    };
+
+    test_postcopy_common(&args);
+}
+
+static void test_multifd_postcopy_preempt(void)
+{
+    MigrateCommon args = {
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+    };
+
+    test_postcopy_common(&args);
+}
+
 void migration_test_add_postcopy(MigrationTestEnv *env)
 {
     migration_test_add_postcopy_smoke(env);
@@ -110,6 +129,10 @@ void migration_test_add_postcopy(MigrationTestEnv *env)
             "/migration/postcopy/recovery/double-failures/reconnect",
             test_postcopy_recovery_fail_reconnect);
 
+        migration_test_add("/migration/multifd+postcopy/plain",
+                           test_multifd_postcopy);
+        migration_test_add("/migration/multifd+postcopy/preempt/plain",
+                           test_multifd_postcopy_preempt);
         if (env->is_x86) {
             migration_test_add("/migration/postcopy/suspend",
                                test_postcopy_suspend);
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index e5d8c49dbe..2126cb8e2c 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -33,6 +33,7 @@
 #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
 
 static char *tmpfs;
+static bool postcopy_ram = false;
 
 static void test_precopy_unix_plain(void)
 {
@@ -465,6 +466,11 @@ static void test_multifd_tcp_cancel(void)
     migrate_ensure_non_converge(from);
     migrate_prepare_for_dirty_mem(from);
 
+    if (postcopy_ram) {
+        migrate_set_capability(from, "postcopy-ram", true);
+        migrate_set_capability(to, "postcopy-ram", true);
+    }
+
     migrate_set_parameter_int(from, "multifd-channels", 16);
     migrate_set_parameter_int(to, "multifd-channels", 16);
 
@@ -506,6 +512,10 @@ static void test_multifd_tcp_cancel(void)
         return;
     }
 
+    if (postcopy_ram) {
+        migrate_set_capability(to2, "postcopy-ram", true);
+    }
+
     migrate_set_parameter_int(to2, "multifd-channels", 16);
 
     migrate_set_capability(to2, "multifd", true);
@@ -529,6 +539,13 @@ static void test_multifd_tcp_cancel(void)
     migrate_end(from, to2, true);
 }
 
+static void test_multifd_postcopy_tcp_cancel(void)
+{
+    postcopy_ram = true;
+    test_multifd_tcp_cancel();
+    postcopy_ram = false;
+}
+
 static void calc_dirty_rate(QTestState *who, uint64_t calc_time)
 {
     qtest_qmp_assert_success(who,
@@ -1001,6 +1018,8 @@ void migration_test_add_precopy(MigrationTestEnv *env)
                        test_multifd_tcp_zero_page_legacy);
     migration_test_add("/migration/multifd/tcp/plain/zero-page/none",
                        test_multifd_tcp_no_zero_page);
+    migration_test_add("migration/multifd+postcopy/tcp/plain/cancel",
+                       test_multifd_postcopy_tcp_cancel);
     if (g_str_equal(env->arch, "x86_64")
         && env->has_kvm && env->has_dirty_ring) {
 
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 30ab79e058..ce57f0cb5d 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -393,6 +393,17 @@ static void test_postcopy_recovery_tls_psk(void)
     test_postcopy_recovery_common(&args);
 }
 
+static void test_multifd_postcopy_recovery_tls_psk(void)
+{
+    MigrateCommon args = {
+        .start_hook = migrate_hook_start_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+    };
+
+    test_postcopy_recovery_common(&args);
+}
+
 /* This contains preempt+recovery+tls test altogether */
 static void test_postcopy_preempt_all(void)
 {
@@ -405,6 +416,17 @@ static void test_postcopy_preempt_all(void)
     test_postcopy_recovery_common(&args);
 }
 
+static void test_multifd_postcopy_preempt_recovery_tls_psk(void)
+{
+    MigrateCommon args = {
+        .start_hook = migrate_hook_start_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+    };
+
+    test_postcopy_recovery_common(&args);
+}
+
 static void test_precopy_unix_tls_psk(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
@@ -651,6 +673,18 @@ static void test_multifd_tcp_tls_psk_mismatch(void)
     test_precopy_common(&args);
 }
 
+static void test_multifd_postcopy_tcp_tls_psk_match(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        .start_hook = migrate_hook_start_multifd_tcp_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
+    };
+
+    test_precopy_common(&args);
+}
+
 #ifdef CONFIG_TASN1
 static void test_multifd_tcp_tls_x509_default_host(void)
 {
@@ -762,6 +796,10 @@ void migration_test_add_tls(MigrationTestEnv *env)
                            test_postcopy_preempt_tls_psk);
         migration_test_add("/migration/postcopy/preempt/recovery/tls/psk",
                            test_postcopy_preempt_all);
+        migration_test_add("/migration/multifd+postcopy/recovery/tls/psk",
+                           test_multifd_postcopy_recovery_tls_psk);
+        migration_test_add("/migration/multifd+postcopy/preempt/recovery/tls/psk",
+                           test_multifd_postcopy_preempt_recovery_tls_psk);
     }
 #ifdef CONFIG_TASN1
     migration_test_add("/migration/precopy/unix/tls/x509/default-host",
@@ -793,6 +831,8 @@ void migration_test_add_tls(MigrationTestEnv *env)
                        test_multifd_tcp_tls_psk_match);
     migration_test_add("/migration/multifd/tcp/tls/psk/mismatch",
                        test_multifd_tcp_tls_psk_mismatch);
+    migration_test_add("/migration/multifd+postcopy/tcp/tls/psk/match",
+                       test_multifd_postcopy_tcp_tls_psk_match);
 #ifdef CONFIG_TASN1
     migration_test_add("/migration/multifd/tcp/tls/x509/default-host",
                        test_multifd_tcp_tls_x509_default_host);
--
2.48.1


