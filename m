Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C73E6B278
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6s15-0004TK-Lw; Fri, 01 Nov 2024 09:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t6s15-0004PE-01
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:48:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t6s12-0002Ji-S4
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 09:48:42 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1Dfe93002483;
 Fri, 1 Nov 2024 13:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=VOkxPPuTOnYY8RIIFWn2R7GdnHJAr8Vt81EQDGD0vA4=; b=
 G6CXDMhpOgNt9nXvaWaFUdlPNxmGL5iMMEpeIwO4FYNDR+Mq5h2rBW5JnUzI8Rdb
 FlWq4Ozn984vBYVWLmCrpS2HTCKZ5vNZM6KvgBLL4RanktPoQ+MGOqmplD+Qh9ji
 LyoZ9RhRoG4Ss7kpcS2ISah+CM9WvnDSFotM/jxgDoZBsQ1vUOCvEs5lkwgQsAr7
 XrIrffWIvBmrtBIeD8+0Lw8i6mFTONKVOWkDxeXL5ltcQHzUfJbMdMs7a9rqWLqI
 e+bWtaZnVX3sKshj0yA20hXPJ4/kGFw3OpkosYv6tpi3dH1w+mom1w3CKZJQscnX
 tc0089e/DpQk/gbGFIQE3Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdqm6n7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Nov 2024 13:48:38 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A1C3RTS010191; Fri, 1 Nov 2024 13:48:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42hn91ptn9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 01 Nov 2024 13:48:37 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A1DhuOU006031;
 Fri, 1 Nov 2024 13:48:36 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 42hn91pt43-16; Fri, 01 Nov 2024 13:48:36 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 15/16] migration-test: cpr-transfer
Date: Fri,  1 Nov 2024 06:47:54 -0700
Message-Id: <1730468875-249970-16-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_08,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010100
X-Proofpoint-GUID: E49JGIyCjDAsu-LYjq3voq3xxlaeCMRD
X-Proofpoint-ORIG-GUID: E49JGIyCjDAsu-LYjq3voq3xxlaeCMRD
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a migration test for cpr-transfer mode.  Defer the connection to the
target monitor, else the test hangs because in cpr-transfer mode QEMU does
not listen for monitor connections until we send the migrate command to
source QEMU.

To test -incoming defer, send a migrate incoming command to the target,
after sending the migrate command to the source, as required by
cpr-transfer mode.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/migration-test.c | 59 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index dfeb8d2..e364e9b 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1769,6 +1769,9 @@ static void test_precopy_common(MigrateCommon *args)
     if (args->start.defer_target_connect) {
         qtest_connect_deferred(to);
         qtest_qmp_handshake(to);
+        if (!strcmp(args->listen_uri, "defer")) {
+            migrate_incoming_qmp(to, args->connect_uri, "{}");
+        }
     }
 
     if (args->result != MIG_TEST_SUCCEED) {
@@ -2413,6 +2416,58 @@ static void test_multifd_file_mapped_ram_fdset_dio(void)
 }
 #endif /* !_WIN32 */
 
+static char *get_cpr_uri(void)
+{
+    return g_strdup_printf("unix:%s/cpr.sock", tmpfs);
+}
+
+static void *test_mode_transfer_start(QTestState *from, QTestState *to)
+{
+    g_autofree char *cpr_uri = get_cpr_uri();
+
+    migrate_set_parameter_str(from, "mode", "cpr-transfer");
+    migrate_set_parameter_str(from, "cpr-uri", cpr_uri);
+    return NULL;
+}
+
+/*
+ * cpr-transfer mode cannot use the target monitor prior to starting the
+ * migration, and cannot connect synchronously to the monitor, so defer
+ * the target connection.
+ */
+static void test_mode_transfer_common(bool incoming_defer)
+{
+    g_autofree char *cpr_uri = get_cpr_uri();
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+
+    const char *opts = "-machine anon-alloc=memfd -nodefaults";
+    g_autofree char *opts_target = g_strdup_printf("-cpr-uri %s %s",
+                                                   cpr_uri, opts);
+
+    MigrateCommon args = {
+        .start.opts_source = opts,
+        .start.opts_target = opts_target,
+        .start.defer_target_connect = true,
+        .start.memory_backend = "-object memory-backend-memfd,id=pc.ram,size=%s"
+                                " -machine memory-backend=pc.ram",
+        .listen_uri = incoming_defer ? "defer" : uri,
+        .connect_uri = uri,
+        .start_hook = test_mode_transfer_start,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void test_mode_transfer(void)
+{
+    test_mode_transfer_common(NULL);
+}
+
+static void test_mode_transfer_defer(void)
+{
+    test_mode_transfer_common(true);
+}
+
 static void test_precopy_tcp_plain(void)
 {
     MigrateCommon args = {
@@ -3866,6 +3921,10 @@ int main(int argc, char **argv)
         migration_test_add("/migration/mode/reboot", test_mode_reboot);
     }
 
+    migration_test_add("/migration/mode/transfer", test_mode_transfer);
+    migration_test_add("/migration/mode/transfer/defer",
+                       test_mode_transfer_defer);
+
     migration_test_add("/migration/precopy/file/mapped-ram",
                        test_precopy_file_mapped_ram);
     migration_test_add("/migration/precopy/file/mapped-ram/live",
-- 
1.8.3.1


