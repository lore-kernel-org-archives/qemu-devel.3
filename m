Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B091C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 12:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfeWd-0000LO-C2; Wed, 05 Feb 2025 07:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tfeWM-0008Qp-5p
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 07:28:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tfeWI-0000Fw-Jw
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 07:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738758521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5RHB0bzoLxrxCGJGGAhmKsLAlKfVe6DuQ2nSlO3/DxA=;
 b=Ma+RsvDEmmZb2sRaOLvfrP9Fp5eo2AeV04hnAOWEOawBLaZABReeI5cdCVVIpBzi3ltEqV
 DZG4wRX7EKM41uRUdkDoS3t+Wf0ch7RbZpVrfV9LQz+e2kYy6Bq8B+sZfdbfDvVarBQZbX
 iJBuzzM2K/SIjDY0bzuBS4xShyI0Yro=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-JekO0heiMt68_oUH8KD7Ww-1; Wed,
 05 Feb 2025 07:28:39 -0500
X-MC-Unique: JekO0heiMt68_oUH8KD7Ww-1
X-Mimecast-MFC-AGG-ID: JekO0heiMt68_oUH8KD7Ww
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD5B81800872; Wed,  5 Feb 2025 12:28:38 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.17.174])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1481519560A3; Wed,  5 Feb 2025 12:28:26 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v5 4/5] tests/qtest/migration: add postcopy tests with multifd
Date: Wed,  5 Feb 2025 17:57:11 +0530
Message-ID: <20250205122712.229151-5-ppandit@redhat.com>
In-Reply-To: <20250205122712.229151-1-ppandit@redhat.com>
References: <20250205122712.229151-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add new postcopy tests to run postcopy migration with
multifd channels enabled. Add a boolean fields 'multifd'
and 'postcopy_ram' to the MigrateCommon structure.
It helps to enable multifd channels and postcopy-ram
during migration tests.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 tests/qtest/migration/compression-tests.c | 13 ++++++++
 tests/qtest/migration/framework.c         | 13 ++++++++
 tests/qtest/migration/framework.h         |  4 +++
 tests/qtest/migration/postcopy-tests.c    | 23 +++++++++++++
 tests/qtest/migration/precopy-tests.c     | 19 +++++++++++
 tests/qtest/migration/tls-tests.c         | 40 +++++++++++++++++++++++
 6 files changed, 112 insertions(+)

v4: no change
- https://lore.kernel.org/qemu-devel/20250127120823.144949-1-ppandit@redhat.com/T/#t

diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index d78f1f11f1..3252ba2f73 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -39,6 +39,17 @@ static void test_multifd_tcp_zstd(void)
     };
     test_precopy_common(&args);
 }
+
+static void test_multifd_postcopy_tcp_zstd(void)
+{
+    MigrateCommon args = {
+        .postcopy_ram = true,
+        .listen_uri = "defer",
+        .start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
+    };
+
+    test_precopy_common(&args);
+}
 #endif /* CONFIG_ZSTD */
 
 #ifdef CONFIG_QATZIP
@@ -158,6 +169,8 @@ void migration_test_add_compression(MigrationTestEnv *env)
 #ifdef CONFIG_ZSTD
     migration_test_add("/migration/multifd/tcp/plain/zstd",
                        test_multifd_tcp_zstd);
+    migration_test_add("/migration/multifd+postcopy/tcp/plain/zstd",
+                       test_multifd_postcopy_tcp_zstd);
 #endif
 
 #ifdef CONFIG_QATZIP
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 4550cda129..00776f858c 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -427,6 +427,14 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
         migrate_set_capability(to, "postcopy-preempt", true);
     }
 
+    if (args->multifd) {
+        migrate_set_capability(from, "multifd", true);
+        migrate_set_capability(to, "multifd", true);
+
+        migrate_set_parameter_int(from, "multifd-channels", 8);
+        migrate_set_parameter_int(to, "multifd-channels", 8);
+    }
+
     migrate_ensure_non_converge(from);
 
     migrate_prepare_for_dirty_mem(from);
@@ -691,6 +699,11 @@ void test_precopy_common(MigrateCommon *args)
         return;
     }
 
+    if (args->postcopy_ram) {
+        migrate_set_capability(from, "postcopy-ram", true);
+        migrate_set_capability(to, "postcopy-ram", true);
+    }
+
     if (args->start_hook) {
         data_hook = args->start_hook(from, to);
     }
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 7991ee56b6..214288ca42 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -193,7 +193,11 @@ typedef struct {
      */
     bool live;
 
+    /* set multifd on */
+    bool multifd;
+
     /* Postcopy specific fields */
+    bool postcopy_ram;
     void *postcopy_data;
     bool postcopy_preempt;
     PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index daf7449f2c..212a5ea600 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -79,6 +79,25 @@ static void test_postcopy_preempt_recovery(void)
     test_postcopy_recovery_common(&args);
 }
 
+static void test_multifd_postcopy(void)
+{
+    MigrateCommon args = {
+        .multifd = true,
+    };
+
+    test_postcopy_common(&args);
+}
+
+static void test_multifd_postcopy_preempt(void)
+{
+    MigrateCommon args = {
+        .multifd = true,
+        .postcopy_preempt = true,
+    };
+
+    test_postcopy_common(&args);
+}
+
 void migration_test_add_postcopy(MigrationTestEnv *env)
 {
     if (env->has_uffd) {
@@ -98,6 +117,10 @@ void migration_test_add_postcopy(MigrationTestEnv *env)
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
index 23599b29ee..b1a4e7bbb1 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -33,6 +33,7 @@
 #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
 
 static char *tmpfs;
+static bool postcopy_ram = false;
 
 static void test_precopy_unix_plain(void)
 {
@@ -472,6 +473,11 @@ static void test_multifd_tcp_cancel(void)
     migrate_ensure_non_converge(from);
     migrate_prepare_for_dirty_mem(from);
 
+    if (postcopy_ram) {
+        migrate_set_capability(from, "postcopy-ram", true);
+        migrate_set_capability(to, "postcopy-ram", true);
+    }
+
     migrate_set_parameter_int(from, "multifd-channels", 16);
     migrate_set_parameter_int(to, "multifd-channels", 16);
 
@@ -513,6 +519,10 @@ static void test_multifd_tcp_cancel(void)
         return;
     }
 
+    if (postcopy_ram) {
+        migrate_set_capability(to2, "postcopy-ram", true);
+    }
+
     migrate_set_parameter_int(to2, "multifd-channels", 16);
 
     migrate_set_capability(to2, "multifd", true);
@@ -536,6 +546,13 @@ static void test_multifd_tcp_cancel(void)
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
@@ -999,6 +1016,8 @@ void migration_test_add_precopy(MigrationTestEnv *env)
                        test_multifd_tcp_no_zero_page);
     migration_test_add("/migration/multifd/tcp/plain/cancel",
                        test_multifd_tcp_cancel);
+    migration_test_add("migration/multifd+postcopy/tcp/plain/cancel",
+                       test_multifd_postcopy_tcp_cancel);
     if (g_str_equal(env->arch, "x86_64")
         && env->has_kvm && env->has_dirty_ring) {
 
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 5704a1f992..094dc1d814 100644
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
+        .multifd = true,
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
+        .multifd = true,
+    };
+
+    test_postcopy_recovery_common(&args);
+}
+
 static void test_precopy_unix_tls_psk(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
@@ -649,6 +671,18 @@ static void test_multifd_tcp_tls_psk_mismatch(void)
     test_precopy_common(&args);
 }
 
+static void test_multifd_postcopy_tcp_tls_psk_match(void)
+{
+    MigrateCommon args = {
+        .multifd = true,
+        .listen_uri = "defer",
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
@@ -743,6 +777,10 @@ void migration_test_add_tls(MigrationTestEnv *env)
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
@@ -776,6 +814,8 @@ void migration_test_add_tls(MigrationTestEnv *env)
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


