Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCD0C27C5F
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 13:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFa3l-0006Kc-1Q; Fri, 07 Jun 2024 09:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sFa3j-0006JD-2j
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 09:55:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sFa3g-0008QT-UK
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 09:55:10 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VwjNK1FB7z6D8rX;
 Fri,  7 Jun 2024 21:53:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 26B0C140C98;
 Fri,  7 Jun 2024 21:55:07 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.202.227.28) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 14:54:58 +0100
To: <qemu-devel@nongnu.org>, <peterx@redhat.com>, <farosas@suse.de>
CC: <yuan1.liu@intel.com>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <marcandre.lureau@redhat.com>, <thuth@redhat.com>, <armbru@redhat.com>,
 <lvivier@redhat.com>, <linuxarm@huawei.com>, <linwenkai6@hisilicon.com>,
 <zhangfei.gao@linaro.org>, <huangchenghai2@huawei.com>
Subject: [PATCH v2 7/7] tests/migration-test: add uadk compression test
Date: Fri, 7 Jun 2024 14:53:10 +0100
Message-ID: <20240607135310.46320-8-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20240607135310.46320-1-shameerali.kolothum.thodi@huawei.com>
References: <20240607135310.46320-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.28]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 tests/qtest/migration-test.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index ef0c3f5e28..056d8790ec 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2669,6 +2669,14 @@ test_migrate_precopy_tcp_multifd_qpl_start(QTestState *from,
     return test_migrate_precopy_tcp_multifd_start_common(from, to, "qpl");
 }
 #endif /* CONFIG_QPL */
+#ifdef CONFIG_UADK
+static void *
+test_migrate_precopy_tcp_multifd_uadk_start(QTestState *from,
+                                            QTestState *to)
+{
+    return test_migrate_precopy_tcp_multifd_start_common(from, to, "uadk");
+}
+#endif /* CONFIG_UADK */
 
 static void test_multifd_tcp_uri_none(void)
 {
@@ -2761,6 +2769,17 @@ static void test_multifd_tcp_qpl(void)
 }
 #endif
 
+#ifdef CONFIG_UADK
+static void test_multifd_tcp_uadk(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migrate_precopy_tcp_multifd_uadk_start,
+    };
+    test_precopy_common(&args);
+}
+#endif
+
 #ifdef CONFIG_GNUTLS
 static void *
 test_migrate_multifd_tcp_tls_psk_start_match(QTestState *from,
@@ -3650,6 +3669,10 @@ int main(int argc, char **argv)
     migration_test_add("/migration/multifd/tcp/plain/qpl",
                        test_multifd_tcp_qpl);
 #endif
+#ifdef CONFIG_UADK
+    migration_test_add("/migration/multifd/tcp/plain/uadk",
+                       test_multifd_tcp_uadk);
+#endif
 #ifdef CONFIG_GNUTLS
     migration_test_add("/migration/multifd/tcp/tls/psk/match",
                        test_multifd_tcp_tls_psk_match);
-- 
2.34.1


