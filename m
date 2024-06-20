Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D17BC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 13:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKHkz-0004iE-N4; Thu, 20 Jun 2024 09:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cosocaf@gmail.com>) id 1sKEOE-0000rL-VZ
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:47:34 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cosocaf@gmail.com>) id 1sKEOC-000438-Nw
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 05:47:34 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f9b52ef481so6069215ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 02:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718876851; x=1719481651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DlQ1ZdaEW72AEw0w5wQIhPrBk0uOxMIbgXV2X0N47o0=;
 b=U/B3zb4h/hWUrhcwCiQFgjVd6+6/k02Y/fNKhqkyQX7iwrHeClSIgqayYUg8Tq0r94
 /ulnAxTM5hyVYMD579o34W+G7c26zmzSvM/qmKR1YfsxG7O7pUJBg+Sc3rboBPiFMbSj
 95K1kWOl+4WOXSYQMimEBEOzrBORqHCIiH2448+Cuf5/F5xuBP/t0dEOyyOI2PpL8AlW
 8uGsmRsRJOaLJetSfjFUEcI2M7DkapR93S+ugjOOV7UJ3uSTY4abVWDf+BX4/ycXG1BV
 CrHbAmhjs8Ruz7yKB6Yu577/0ZQTabAy2/HkMVeNd2Wh4ARHQseoz8ayztD5oB1lAAxy
 pt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718876851; x=1719481651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DlQ1ZdaEW72AEw0w5wQIhPrBk0uOxMIbgXV2X0N47o0=;
 b=nYDSdmDVEghwwcV7xr1baOv36BX4c6sMVPzYj7rlyep6n98c5UYnyAMRCwyQdRzY43
 vOQzZiOw8T1b2ngxho7m9LBdeASsyvjixWKiiEKvBr1Y6hSG6znZdvUJ4LuYYdGDpEm4
 ba+KpzPQppQYhTaDrJ3wzTHiO3inYql5Cr5eBZ/4Gn0lVHeXyonYag06aKw3RAAmbd6u
 tsmJwyFAOKV41IohCRUL6bY8dbyTDcVeoxGjPSi7wMOiNoE4GZ4Wj5xTj+8L0ls3V2AY
 2EkSrIx2QA56KPmsSLRz1TJ0+4yqnjAr3OIREEYnZOkgC1CR2ZCjbgGbL4iuJkbwbXa0
 xXMA==
X-Gm-Message-State: AOJu0YyYVwx8RdJYI4d5xF0ymWIHkO+/a3tBw87pMLAD9FbzzN26ZXNU
 RE9RG2aXDUFzHHf6hICNlMoSrIq3kEDxQzieosqaZWlEnDjNZ/9Hhq1Bzkys7cI=
X-Google-Smtp-Source: AGHT+IEttX9isHcwr7XQP9hkNHC6eZObyiRC6Fn4sW8L43Xb+GxiNK+81yeWaLHgAirxUZmaW8ICcA==
X-Received: by 2002:a17:902:e5ca:b0:1f6:a606:539e with SMTP id
 d9443c01a7336-1f9aa471fefmr51850235ad.61.1718876850953; 
 Thu, 20 Jun 2024 02:47:30 -0700 (PDT)
Received: from localhost.localdomain (KD175132079186.ppp-bb.dion.ne.jp.
 [175.132.79.186]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f993deb126sm49350585ad.219.2024.06.20.02.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 02:47:30 -0700 (PDT)
From: Shota Imamura <cosocaf@gmail.com>
To: qemu-devel@nongnu.org
Cc: Shota Imamura <cosocaf@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/2] qtest/migration: Add dirty ring tests
Date: Thu, 20 Jun 2024 18:47:14 +0900
Message-Id: <20240620094714.871727-3-cosocaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620094714.871727-1-cosocaf@gmail.com>
References: <20240620094714.871727-1-cosocaf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=cosocaf@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 20 Jun 2024 09:23:11 -0400
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

This commit adds tests for migration using the dirty ring. To avoid
confusion with KVM's dirty ring, use_dirty_ring has been changed to
use_kvm_dirty_ring, and use_qemu_dirty_ring has been added.

Signed-off-by: Shota Imamura <cosocaf@gmail.com>
---
 tests/qtest/migration-test.c | 78 ++++++++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 0dccb4beff..a8151b9470 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -556,7 +556,8 @@ typedef struct {
     /* only launch the target process */
     bool only_target;
     /* Use dirty ring if true; dirty logging otherwise */
-    bool use_dirty_ring;
+    bool use_kvm_dirty_ring;
+    bool use_qemu_dirty_ring;
     const char *opts_source;
     const char *opts_target;
     /* suspend the src before migrating to dest. */
@@ -675,6 +676,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     g_autofree char *shmem_opts = NULL;
     g_autofree char *shmem_path = NULL;
     const char *kvm_opts = NULL;
+    const char *migration_ops = NULL;
     const char *arch = qtest_get_arch();
     const char *memory_size;
     const char *machine_alias, *machine_opts = "";
@@ -754,10 +756,16 @@ static int test_migrate_start(QTestState **from, QTestState **to,
             memory_size, shmem_path);
     }
 
-    if (args->use_dirty_ring) {
+    if (args->use_kvm_dirty_ring) {
         kvm_opts = ",dirty-ring-size=4096";
     }
 
+    if (args->use_qemu_dirty_ring) {
+        migration_ops = "dirty-logging=ring,dirty-ring-size=32768";
+    } else {
+        migration_ops = "dirty-logging=bitmap";
+    }
+
     if (!qtest_has_machine(machine_alias)) {
         g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
         g_test_skip(msg);
@@ -774,10 +782,12 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  "-name source,debug-threads=on "
                                  "-m %s "
                                  "-serial file:%s/src_serial "
+                                 "-migration %s "
                                  "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
                                  memory_size, tmpfs,
+                                 migration_ops,
                                  arch_opts ? arch_opts : "",
                                  arch_source ? arch_source : "",
                                  shmem_opts ? shmem_opts : "",
@@ -1796,12 +1806,27 @@ static void test_precopy_unix_suspend_notlive(void)
     test_precopy_common(&args);
 }
 
-static void test_precopy_unix_dirty_ring(void)
+static void test_precopy_unix_qemu_dirty_ring(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     MigrateCommon args = {
         .start = {
-            .use_dirty_ring = true,
+            .use_qemu_dirty_ring = true,
+        },
+        .listen_uri = uri,
+        .connect_uri = uri,
+        .live = true,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void test_precopy_unix_kvm_dirty_ring(void)
+{
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    MigrateCommon args = {
+        .start = {
+            .use_kvm_dirty_ring = true,
         },
         .listen_uri = uri,
         .connect_uri = uri,
@@ -1815,6 +1840,22 @@ static void test_precopy_unix_dirty_ring(void)
     test_precopy_common(&args);
 }
 
+static void test_precopy_unix_kvm_and_qemu_dirty_ring(void)
+{
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    MigrateCommon args = {
+        .start = {
+            .use_kvm_dirty_ring = true,
+            .use_qemu_dirty_ring = true,
+        },
+        .listen_uri = uri,
+        .connect_uri = uri,
+        .live = true,
+    };
+
+    test_precopy_common(&args);
+}
+
 #ifdef CONFIG_GNUTLS
 static void test_precopy_unix_tls_psk(void)
 {
@@ -1942,6 +1983,21 @@ static void test_precopy_file(void)
     test_file_common(&args, true);
 }
 
+static void test_precopy_file_dirty_ring(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .start = {
+            .use_qemu_dirty_ring = true,
+        },
+        .connect_uri = uri,
+        .listen_uri = "defer",
+    };
+
+    test_file_common(&args, true);
+}
+
 static void file_offset_finish_hook(QTestState *from, QTestState *to,
                                     void *opaque)
 {
@@ -3298,7 +3354,7 @@ static void test_migrate_dirty_limit(void)
     MigrateCommon args = {
         .start = {
             .hide_stderr = true,
-            .use_dirty_ring = true,
+            .use_kvm_dirty_ring = true,
         },
         .listen_uri = uri,
         .connect_uri = uri,
@@ -3342,7 +3398,7 @@ static void test_migrate_dirty_limit(void)
     args = (MigrateCommon) {
         .start = {
             .only_target = true,
-            .use_dirty_ring = true,
+            .use_kvm_dirty_ring = true,
         },
         .listen_uri = uri,
         .connect_uri = uri,
@@ -3504,10 +3560,14 @@ int main(int argc, char **argv)
 
     migration_test_add("/migration/precopy/unix/plain",
                        test_precopy_unix_plain);
+    migration_test_add("/migration/precopy/unix/dirty_ring",
+                       test_precopy_unix_qemu_dirty_ring);
     migration_test_add("/migration/precopy/unix/xbzrle",
                        test_precopy_unix_xbzrle);
     migration_test_add("/migration/precopy/file",
                        test_precopy_file);
+    migration_test_add("/migration/precopy/file/dirty_ring",
+                       test_precopy_file_dirty_ring);
     migration_test_add("/migration/precopy/file/offset",
                        test_precopy_file_offset);
     migration_test_add("/migration/precopy/file/offset/bad",
@@ -3660,8 +3720,10 @@ int main(int argc, char **argv)
 #endif /* CONFIG_GNUTLS */
 
     if (g_str_equal(arch, "x86_64") && has_kvm && kvm_dirty_ring_supported()) {
-        migration_test_add("/migration/dirty_ring",
-                           test_precopy_unix_dirty_ring);
+        migration_test_add("/migration/precopy/unix/kvm_dirty_ring",
+                           test_precopy_unix_kvm_dirty_ring);
+        migration_test_add("/migration/precopy/unix/kvm_and_qemu_dirty_ring",
+                           test_precopy_unix_kvm_and_qemu_dirty_ring);
         migration_test_add("/migration/vcpu_dirty_limit",
                            test_vcpu_dirty_limit);
     }
-- 
2.34.1


