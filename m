Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2656DCAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 09:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3WMp-0001cH-EE; Tue, 30 Sep 2025 05:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3WMo-0001c3-7l
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:09:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3WMi-0005mF-4s
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759223381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=H/r0sxL0ET5RaQd8HZAwmuk720/Me9faAIngCxS64zI=;
 b=XWji+9NTFeXgmOuQvXkbYRSin887C3xSOgsuYu4M5URHIIrE5Awty06qDBeQxusPnss6Xf
 zAP795/QjT+v0JtZSX3Oc7Qpr8k0yO+D0fQNqpU3jRZP/mTA+W6b5+UiJh4XovzkyXe/AB
 Ncw5use2J6ytFXQxguQixKOQZyrYGgY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-Z6m090z7PuWlveyQ53CLLw-1; Tue,
 30 Sep 2025 05:09:37 -0400
X-MC-Unique: Z6m090z7PuWlveyQ53CLLw-1
X-Mimecast-MFC-AGG-ID: Z6m090z7PuWlveyQ53CLLw_1759223376
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5682F1956053; Tue, 30 Sep 2025 09:09:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.89])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 478C819560B4; Tue, 30 Sep 2025 09:09:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org
Cc: Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH] tests/qtest/migration: Fix cpr-tests in case the machine is
 not available
Date: Tue, 30 Sep 2025 11:09:32 +0200
Message-ID: <20250930090932.235151-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

When QEMU has been compiled with "--without-default-devices", the
migration cpr-tests are currently failing since the first test leaves
a socket file behind that avoids that the second test can be initialized
correctly. Make sure that we delete the socket file in case that the
migrate_start() failed due to the missing machine.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/migration/framework.h | 2 +-
 tests/qtest/migration/cpr-tests.c | 5 ++++-
 tests/qtest/migration/framework.c | 6 ++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 01e425e64e2..744040d53a1 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -227,7 +227,7 @@ void migrate_end(QTestState *from, QTestState *to, bool test_dest);
 
 void test_postcopy_common(MigrateCommon *args);
 void test_postcopy_recovery_common(MigrateCommon *args);
-void test_precopy_common(MigrateCommon *args);
+int test_precopy_common(MigrateCommon *args);
 void test_file_common(MigrateCommon *args, bool stop_src);
 void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
                                                     QTestState *to,
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 5e764a67876..c4ce60ff66b 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -97,7 +97,10 @@ static void test_mode_transfer_common(bool incoming_defer)
         .start_hook = test_mode_transfer_start,
     };
 
-    test_precopy_common(&args);
+    if (test_precopy_common(&args) < 0) {
+        close(cpr_sockfd);
+        unlink(cpr_path);
+    }
 }
 
 static void test_mode_transfer(void)
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 407c9023c05..a044b354658 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -736,7 +736,7 @@ void test_postcopy_recovery_common(MigrateCommon *args)
     migrate_postcopy_complete(from, to, args);
 }
 
-void test_precopy_common(MigrateCommon *args)
+int test_precopy_common(MigrateCommon *args)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
@@ -746,7 +746,7 @@ void test_precopy_common(MigrateCommon *args)
     g_assert(!args->cpr_channel || args->connect_channels);
 
     if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
-        return;
+        return -1;
     }
 
     if (args->start_hook) {
@@ -869,6 +869,8 @@ finish:
     }
 
     migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
+
+    return 0;
 }
 
 static void file_dirty_offset_region(void)
-- 
2.51.0


