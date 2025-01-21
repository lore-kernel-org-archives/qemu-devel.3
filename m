Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990A5C0218C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 13:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taE4a-0007vr-SS; Tue, 21 Jan 2025 08:13:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1taE44-0007fs-EN
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 08:13:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1taE3x-0000hG-Tp
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 08:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737465181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSmXbIuthQ5KZ/L/P0aPs8pK7yQi8o9F1AVTcpkvKqw=;
 b=G0OYJzL8R+9jRmcqdqgjojtA6Yo1QY5mDpXuw2c6vBheOoB9pHbRQdqahQmtoVH8V7Y6w0
 13YruGq/e1mOuwsjGCDoNmTqR/s3E5oD9PrX++NhKoim2OQmosrquZNZe6V7e2p74OMSuw
 W9PphCSfhSn6wprAC8zpFfodJYbWaok=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-9_7tNtagNjuh6aeK3Yi8bg-1; Tue,
 21 Jan 2025 08:11:07 -0500
X-MC-Unique: 9_7tNtagNjuh6aeK3Yi8bg-1
X-Mimecast-MFC-AGG-ID: 9_7tNtagNjuh6aeK3Yi8bg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 513EC1956087; Tue, 21 Jan 2025 13:11:06 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.17.45])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B267F19560A7; Tue, 21 Jan 2025 13:11:02 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v3 4/4] tests/qtest/migration: add postcopy test with multifd
Date: Tue, 21 Jan 2025 18:40:32 +0530
Message-ID: <20250121131032.1611245-5-ppandit@redhat.com>
In-Reply-To: <20250121131032.1611245-1-ppandit@redhat.com>
References: <20250121131032.1611245-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

Add a new postcopy test 'migration/postcopy/multifd'
to run postcopy migration with multifd channels enabled.
Add a boolean field 'multifd' to the MigrateCommon struct.
It helps to enable multifd channels.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 tests/qtest/migration/framework.c      |  8 ++++++++
 tests/qtest/migration/framework.h      |  3 +++
 tests/qtest/migration/postcopy-tests.c | 10 ++++++++++
 3 files changed, 21 insertions(+)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 4550cda129..7f5abd760e 100644
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
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 7991ee56b6..1b2320ebef 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -193,6 +193,9 @@ typedef struct {
      */
     bool live;
 
+    /* set multifd on */
+    bool multifd;
+
     /* Postcopy specific fields */
     void *postcopy_data;
     bool postcopy_preempt;
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index daf7449f2c..6eada6ccbc 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -27,6 +27,15 @@ static void test_postcopy(void)
     test_postcopy_common(&args);
 }
 
+static void test_postcopy_multifd(void)
+{
+    MigrateCommon args = {
+        .multifd = true,
+    };
+
+    test_postcopy_common(&args);
+}
+
 static void test_postcopy_suspend(void)
 {
     MigrateCommon args = {
@@ -83,6 +92,7 @@ void migration_test_add_postcopy(MigrationTestEnv *env)
 {
     if (env->has_uffd) {
         migration_test_add("/migration/postcopy/plain", test_postcopy);
+        migration_test_add("/migration/postcopy/multifd", test_postcopy_multifd);
         migration_test_add("/migration/postcopy/recovery/plain",
                            test_postcopy_recovery);
         migration_test_add("/migration/postcopy/preempt/plain",
--
2.48.1


