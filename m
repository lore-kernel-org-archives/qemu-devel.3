Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C73E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 13:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNXMO-0006D1-K0; Tue, 17 Dec 2024 08:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tNXMD-0006Ci-Oc
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 08:11:26 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tNXMA-0000Mz-Af
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 08:11:25 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YCHCq57qRz67j73;
 Tue, 17 Dec 2024 21:07:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 957AA140B2F;
 Tue, 17 Dec 2024 21:11:08 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 17 Dec 2024 14:11:05 +0100
To: <qemu-devel@nongnu.org>, <peterx@redhat.com>, <farosas@suse.de>
CC: <linuxarm@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH] tests/qtest/migration: Fix compile errors when CONFIG_UADK is
 set
Date: Tue, 17 Dec 2024 13:10:46 +0000
Message-ID: <20241217131046.83844-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) AC_FROM_MANY_DOTS=2.497, BAYES_00=-1.9,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1.116,
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
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Removes accidental inclusion of unrelated functions within CONFIG_UADK
as this causes compile errors like:

error: redefinition of ‘migrate_hook_start_xbzrle’

Fixes: 932f74f3fe6e ("tests/qtest/migration: Split compression tests from migration-test.c")
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 tests/qtest/migration/compression-tests.c | 54 -----------------------
 1 file changed, 54 deletions(-)

diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index 6de87bc47d..d78f1f11f1 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -88,59 +88,6 @@ migrate_hook_start_precopy_tcp_multifd_uadk(QTestState *from,
     return migrate_hook_start_precopy_tcp_multifd_common(from, to, "uadk");
 }
 
-static void *
-migrate_hook_start_xbzrle(QTestState *from,
-                          QTestState *to)
-{
-    migrate_set_parameter_int(from, "xbzrle-cache-size", 33554432);
-
-    migrate_set_capability(from, "xbzrle", true);
-    migrate_set_capability(to, "xbzrle", true);
-
-    return NULL;
-}
-
-static void test_precopy_unix_xbzrle(void)
-{
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = uri,
-        .start_hook = migrate_hook_start_xbzrle,
-        .iterations = 2,
-        /*
-         * XBZRLE needs pages to be modified when doing the 2nd+ round
-         * iteration to have real data pushed to the stream.
-         */
-        .live = true,
-    };
-
-    test_precopy_common(&args);
-}
-
-static void *
-migrate_hook_start_precopy_tcp_multifd_zlib(QTestState *from,
-                                            QTestState *to)
-{
-    /*
-     * Overloading this test to also check that set_parameter does not error.
-     * This is also done in the tests for the other compression methods.
-     */
-    migrate_set_parameter_int(from, "multifd-zlib-level", 2);
-    migrate_set_parameter_int(to, "multifd-zlib-level", 2);
-
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "zlib");
-}
-
-static void test_multifd_tcp_zlib(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_precopy_tcp_multifd_zlib,
-    };
-    test_precopy_common(&args);
-}
-
 static void test_multifd_tcp_uadk(void)
 {
     MigrateCommon args = {
@@ -151,7 +98,6 @@ static void test_multifd_tcp_uadk(void)
 }
 #endif /* CONFIG_UADK */
 
-
 static void *
 migrate_hook_start_xbzrle(QTestState *from,
                           QTestState *to)
-- 
2.34.1


