Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2426DC5475B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx8S-0003d0-LD; Sun, 03 Mar 2024 20:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx89-0002jf-Qg
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx88-0002SX-30
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VGsaTKXYi4p8i16mdNER8UjgI9dBQlyWyaXYcRxh438=;
 b=Cf/kMAuUUNn9wNt1kuVAppiy9KYzZnc65UJ3IS8TYURw6j68E0uwNiJisq51VVqFhO2Drr
 xe1soJZag1/3rhR4OwOXxZE6oGKeQEchUhXWLO5lA1RKs5VByL2f8hYCAKmEch8APo4b0Y
 8Hw6bMpDZV6cLNGUWLjETBNL+7X1eSM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-miqb2J0RPwaBjBt6fb5HgQ-1; Sun,
 03 Mar 2024 20:28:34 -0500
X-MC-Unique: miqb2J0RPwaBjBt6fb5HgQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40FD63C0DD0A;
 Mon,  4 Mar 2024 01:28:33 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4A6B40C6EBA;
 Mon,  4 Mar 2024 01:28:29 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 26/27] tests/qtest/migration: Add a multifd + mapped-ram
 migration test
Date: Mon,  4 Mar 2024 09:26:33 +0800
Message-ID: <20240304012634.95520-27-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240229153017.2221-24-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 68 ++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 4c5551f7d0..4023d808f9 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2248,6 +2248,46 @@ static void test_precopy_file_mapped_ram(void)
     test_file_common(&args, true);
 }
 
+static void *migrate_multifd_mapped_ram_start(QTestState *from, QTestState *to)
+{
+    migrate_mapped_ram_start(from, to);
+
+    migrate_set_parameter_int(from, "multifd-channels", 4);
+    migrate_set_parameter_int(to, "multifd-channels", 4);
+
+    migrate_set_capability(from, "multifd", true);
+    migrate_set_capability(to, "multifd", true);
+
+    return NULL;
+}
+
+static void test_multifd_file_mapped_ram_live(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = migrate_multifd_mapped_ram_start,
+    };
+
+    test_file_common(&args, false);
+}
+
+static void test_multifd_file_mapped_ram(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = migrate_multifd_mapped_ram_start,
+    };
+
+    test_file_common(&args, true);
+}
+
+
 static void test_precopy_tcp_plain(void)
 {
     MigrateCommon args = {
@@ -2524,6 +2564,25 @@ static void test_migrate_precopy_fd_file_mapped_ram(void)
     };
     test_file_common(&args, true);
 }
+
+static void *migrate_multifd_fd_mapped_ram_start(QTestState *from,
+                                                QTestState *to)
+{
+    migrate_multifd_mapped_ram_start(from, to);
+    return migrate_precopy_fd_file_start(from, to);
+}
+
+static void test_multifd_fd_mapped_ram(void)
+{
+    MigrateCommon args = {
+        .connect_uri = "fd:fd-mig",
+        .listen_uri = "defer",
+        .start_hook = migrate_multifd_fd_mapped_ram_start,
+        .finish_hook = test_migrate_fd_finish_hook
+    };
+
+    test_file_common(&args, true);
+}
 #endif /* _WIN32 */
 
 static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
@@ -3576,6 +3635,15 @@ int main(int argc, char **argv)
     migration_test_add("/migration/precopy/file/mapped-ram/live",
                        test_precopy_file_mapped_ram_live);
 
+    migration_test_add("/migration/multifd/file/mapped-ram",
+                       test_multifd_file_mapped_ram);
+    migration_test_add("/migration/multifd/file/mapped-ram/live",
+                       test_multifd_file_mapped_ram_live);
+#ifndef _WIN32
+    migration_test_add("/migration/multifd/fd/mapped-ram",
+                       test_multifd_fd_mapped_ram);
+#endif
+
 #ifdef CONFIG_GNUTLS
     migration_test_add("/migration/precopy/unix/tls/psk",
                        test_precopy_unix_tls_psk);
-- 
2.44.0


