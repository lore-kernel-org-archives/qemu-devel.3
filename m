Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FD0C282CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 12:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnzK2-0004UE-O3; Fri, 28 Feb 2025 07:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tnzK0-0004PH-6u
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:18:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tnzJx-0001H7-Vn
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 07:18:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740745104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NspCqIF6EkMAo/PsJWgsVgmYR+MCIC1H39YMCmein1A=;
 b=WlYMoexO9aOxRCQJqJpf+hDnDxeN4nqzdFolKsRjY9fSLWIaPvAvM8vZfCw/TDmS9tsyUH
 1Cgk0DPofREw8blIgzAgbvsKqffD0mNUSUCH2Q66K1t0B7rxz5ZRoRONQQ8+P46rtbjTfq
 LfQN00tOI8yYtm0qZndQAEujUdpMqHM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-88KZq4OBOFywJSQx-F4pfA-1; Fri,
 28 Feb 2025 07:18:22 -0500
X-MC-Unique: 88KZq4OBOFywJSQx-F4pfA-1
X-Mimecast-MFC-AGG-ID: 88KZq4OBOFywJSQx-F4pfA_1740745101
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46C851800373; Fri, 28 Feb 2025 12:18:21 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.175])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 515AB180087F; Fri, 28 Feb 2025 12:18:16 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v7 4/5] tests/qtest/migration: add postcopy tests with multifd
Date: Fri, 28 Feb 2025 17:47:48 +0530
Message-ID: <20250228121749.553184-5-ppandit@redhat.com>
In-Reply-To: <20250228121749.553184-1-ppandit@redhat.com>
References: <20250228121749.553184-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 tests/qtest/migration/compression-tests.c | 15 ++++++++
 tests/qtest/migration/postcopy-tests.c    | 27 +++++++++++++
 tests/qtest/migration/precopy-tests.c     | 19 ++++++++++
 tests/qtest/migration/tls-tests.c         | 46 +++++++++++++++++++++++
 4 files changed, 107 insertions(+)

v6: Move .caps initialisations to .start object.
- https://lore.kernel.org/qemu-devel/20250215123119.814345-1-ppandit@redhat.com/T/#t

diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index 41e79f031b..592e85d69d 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -42,6 +42,19 @@ static void test_multifd_tcp_zstd(void)
     };
     test_precopy_common(&args);
 }
+
+static void test_multifd_postcopy_tcp_zstd(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start = {
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true,
+        },
+        .start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
+    };
+
+    test_precopy_common(&args);
+}
 #endif /* CONFIG_ZSTD */
 
 #ifdef CONFIG_QATZIP
@@ -184,6 +197,8 @@ void migration_test_add_compression(MigrationTestEnv *env)
 #ifdef CONFIG_ZSTD
     migration_test_add("/migration/multifd/tcp/plain/zstd",
                        test_multifd_tcp_zstd);
+    migration_test_add("/migration/multifd+postcopy/tcp/plain/zstd",
+                       test_multifd_postcopy_tcp_zstd);
 #endif
 
 #ifdef CONFIG_QATZIP
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index 483e3ff99f..eb637f94f7 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -94,6 +94,29 @@ static void migration_test_add_postcopy_smoke(MigrationTestEnv *env)
     }
 }
 
+static void test_multifd_postcopy(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
+    };
+
+    test_postcopy_common(&args);
+}
+
+static void test_multifd_postcopy_preempt(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+            .caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true,
+        },
+    };
+
+    test_postcopy_common(&args);
+}
+
 void migration_test_add_postcopy(MigrationTestEnv *env)
 {
     migration_test_add_postcopy_smoke(env);
@@ -114,6 +137,10 @@ void migration_test_add_postcopy(MigrationTestEnv *env)
             "/migration/postcopy/recovery/double-failures/reconnect",
             test_postcopy_recovery_fail_reconnect);
 
+        migration_test_add("/migration/postcopy/multifd/plain",
+                           test_multifd_postcopy);
+        migration_test_add("/migration/postcopy/multifd/preempt/plain",
+                           test_multifd_postcopy_preempt);
         if (env->is_x86) {
             migration_test_add("/migration/postcopy/suspend",
                                test_postcopy_suspend);
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index f8404793b8..b2b0db8076 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -34,6 +34,7 @@
 #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
 
 static char *tmpfs;
+static bool postcopy_ram = false;
 
 static void test_precopy_unix_plain(void)
 {
@@ -476,6 +477,11 @@ static void test_multifd_tcp_cancel(void)
     migrate_ensure_non_converge(from);
     migrate_prepare_for_dirty_mem(from);
 
+    if (postcopy_ram) {
+        migrate_set_capability(from, "postcopy-ram", true);
+        migrate_set_capability(to, "postcopy-ram", true);
+    }
+
     migrate_set_parameter_int(from, "multifd-channels", 16);
     migrate_set_parameter_int(to, "multifd-channels", 16);
 
@@ -517,6 +523,10 @@ static void test_multifd_tcp_cancel(void)
         return;
     }
 
+    if (postcopy_ram) {
+        migrate_set_capability(to2, "postcopy-ram", true);
+    }
+
     migrate_set_parameter_int(to2, "multifd-channels", 16);
 
     migrate_set_capability(to2, "multifd", true);
@@ -540,6 +550,13 @@ static void test_multifd_tcp_cancel(void)
     migrate_end(from, to2, true);
 }
 
+static void test_multifd_postcopy_tcp_cancel(void)
+{
+    postcopy_ram = true;
+    test_multifd_tcp_cancel();
+    postcopy_ram = false;
+}
+
 static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
                                          const char *uri, const char *phase)
 {
@@ -1127,6 +1144,8 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
                        test_multifd_tcp_uri_none);
     migration_test_add("/migration/multifd/tcp/plain/cancel",
                        test_multifd_tcp_cancel);
+    migration_test_add("/migration/multifd+postcopy/tcp/plain/cancel",
+                       test_multifd_postcopy_tcp_cancel);
 }
 
 void migration_test_add_precopy(MigrationTestEnv *env)
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 72f44defbb..81a2faf4c0 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -395,6 +395,19 @@ static void test_postcopy_recovery_tls_psk(void)
     test_postcopy_recovery_common(&args);
 }
 
+static void test_multifd_postcopy_recovery_tls_psk(void)
+{
+    MigrateCommon args = {
+        .start_hook = migrate_hook_start_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
+    };
+
+    test_postcopy_recovery_common(&args);
+}
+
 /* This contains preempt+recovery+tls test altogether */
 static void test_postcopy_preempt_all(void)
 {
@@ -409,6 +422,19 @@ static void test_postcopy_preempt_all(void)
     test_postcopy_recovery_common(&args);
 }
 
+static void test_multifd_postcopy_preempt_recovery_tls_psk(void)
+{
+    MigrateCommon args = {
+        .start_hook = migrate_hook_start_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
+    };
+
+    test_postcopy_recovery_common(&args);
+}
+
 static void test_precopy_unix_tls_psk(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
@@ -657,6 +683,20 @@ static void test_multifd_tcp_tls_psk_mismatch(void)
     test_precopy_common(&args);
 }
 
+static void test_multifd_postcopy_tcp_tls_psk_match(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
+        },
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
@@ -774,6 +814,10 @@ void migration_test_add_tls(MigrationTestEnv *env)
                            test_postcopy_preempt_tls_psk);
         migration_test_add("/migration/postcopy/preempt/recovery/tls/psk",
                            test_postcopy_preempt_all);
+        migration_test_add("/migration/postcopy/multifd/recovery/tls/psk",
+                           test_multifd_postcopy_recovery_tls_psk);
+        migration_test_add("/migration/postcopy/multifd/preempt/recovery/tls/psk",
+                           test_multifd_postcopy_preempt_recovery_tls_psk);
     }
 #ifdef CONFIG_TASN1
     migration_test_add("/migration/precopy/unix/tls/x509/default-host",
@@ -805,6 +849,8 @@ void migration_test_add_tls(MigrationTestEnv *env)
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


