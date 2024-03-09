Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C902C54E5D
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 07:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rirbe-00068w-A1; Sat, 09 Mar 2024 02:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rirbZ-00066O-Bj
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 02:58:53 -0500
Received: from out-174.mta1.migadu.com ([2001:41d0:203:375::ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@linux.dev>)
 id 1rirbX-00014H-Pw
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 02:58:53 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1709971130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cOs1PeLU/M6BfmOBHauhQFryX1tplw+VBeDONscOOAY=;
 b=Jfk4oASTF/uzpVZpPi/VtaHIdsfiFxg7qenfynl9wcOl2yUktUZb6urrVOBPuMv7iMCVtr
 Axo2HfzIjyh0m6wyK1GjyxUHeOy51U47mUosx3r5ayvevbNX8OgheTCIcW7/oIt8ijCLxd
 Mj9qICpKsNBKB8A8rqBXKNqDeT4cU8g=
From: Hao Xiang <hao.xiang@linux.dev>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v5 7/7] migration/multifd: Add new migration test cases for
 legacy zero page checking.
Date: Sat,  9 Mar 2024 07:57:28 +0000
Message-Id: <20240309075728.1487211-8-hao.xiang@linux.dev>
In-Reply-To: <20240309075728.1487211-1-hao.xiang@linux.dev>
References: <20240309075728.1487211-1-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::ae;
 envelope-from=hao.xiang@linux.dev; helo=out-174.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Hao Xiang <hao.xiang@bytedance.com>

Now that zero page checking is done on the multifd sender threads by
default, we still provide an option for backward compatibility. This
change adds a qtest migration test case to set the zero-page-detection
option to "legacy" and run multifd migration with zero page checking on the
migration main thread.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20240301022829.3390548-6-hao.xiang@bytedance.com>
---
 tests/qtest/migration-test.c | 52 ++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 4023d808f9..71895abb7f 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2771,6 +2771,24 @@ test_migrate_precopy_tcp_multifd_start(QTestState *from,
     return test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
 }
 
+static void *
+test_migrate_precopy_tcp_multifd_start_zero_page_legacy(QTestState *from,
+                                                        QTestState *to)
+{
+    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
+    migrate_set_parameter_str(from, "zero-page-detection", "legacy");
+    return NULL;
+}
+
+static void *
+test_migration_precopy_tcp_multifd_start_no_zero_page(QTestState *from,
+                                                      QTestState *to)
+{
+    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
+    migrate_set_parameter_str(from, "zero-page-detection", "none");
+    return NULL;
+}
+
 static void *
 test_migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
                                             QTestState *to)
@@ -2812,6 +2830,36 @@ static void test_multifd_tcp_none(void)
     test_precopy_common(&args);
 }
 
+static void test_multifd_tcp_zero_page_legacy(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migrate_precopy_tcp_multifd_start_zero_page_legacy,
+        /*
+         * Multifd is more complicated than most of the features, it
+         * directly takes guest page buffers when sending, make sure
+         * everything will work alright even if guest page is changing.
+         */
+        .live = true,
+    };
+    test_precopy_common(&args);
+}
+
+static void test_multifd_tcp_no_zero_page(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migration_precopy_tcp_multifd_start_no_zero_page,
+        /*
+         * Multifd is more complicated than most of the features, it
+         * directly takes guest page buffers when sending, make sure
+         * everything will work alright even if guest page is changing.
+         */
+        .live = true,
+    };
+    test_precopy_common(&args);
+}
+
 static void test_multifd_tcp_zlib(void)
 {
     MigrateCommon args = {
@@ -3729,6 +3777,10 @@ int main(int argc, char **argv)
     }
     migration_test_add("/migration/multifd/tcp/plain/none",
                        test_multifd_tcp_none);
+    migration_test_add("/migration/multifd/tcp/plain/zero-page/legacy",
+                       test_multifd_tcp_zero_page_legacy);
+    migration_test_add("/migration/multifd/tcp/plain/zero-page/none",
+                       test_multifd_tcp_no_zero_page);
     migration_test_add("/migration/multifd/tcp/plain/cancel",
                        test_multifd_tcp_cancel);
     migration_test_add("/migration/multifd/tcp/plain/zlib",
-- 
2.30.2


