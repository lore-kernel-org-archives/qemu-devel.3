Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E82D7831F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Xe-0007iz-06; Mon, 02 Dec 2024 08:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6MA-0008CM-VD
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:56 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6M3-0005qY-VC
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:49 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2DJCO7023886;
 Mon, 2 Dec 2024 13:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=TWNSOPxczOSPwzHxzQ0Ytn0JQ6tNKAw9ubDxtoSqYm8=; b=
 XEsicbX1eO48bnUrJrE1LZehYmQQESXCamQDAGSIrDy9Be7tskN2nAQOoxnoh+cX
 9nRTT25fwCJ4BaMCeO4dtI8BIHrgJRD1atSSxYFyI2RrVbINRs7CJ5yM2/B+QWfm
 UgOj5I2saHJqy55aL/gbq4HJ3pwKgkScEGVSp0KguI/FFP2/A5M4cMS8waRflFJn
 8UQcCIo4G9rfIt0PC1+iXkARVUzs6/VIENa7dhwAG1TnQCJ8H4ZHm2zOveUzXEvC
 A9ZmYE1677zlHTkgBJGpVUv+1++/pQzWv1bfQrBXm5iMvIh9Xk18JPhtui1SzNaT
 +JFkKq8yNBY9uAOgYs/79w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437trbk4c3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:28 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4B2D44PA032669; Mon, 2 Dec 2024 13:20:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 437s56jtv5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:27 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4B2DKCF9032806;
 Mon, 2 Dec 2024 13:20:26 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 437s56jthv-19; Mon, 02 Dec 2024 13:20:26 +0000
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
Subject: [PATCH V4 18/19] migration-test: cpr-transfer
Date: Mon,  2 Dec 2024 05:20:10 -0800
Message-Id: <1733145611-62315-19-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_09,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412020116
X-Proofpoint-GUID: h5VqSifPlv8pnPAx06l9C18Cklmn0JpG
X-Proofpoint-ORIG-GUID: h5VqSifPlv8pnPAx06l9C18Cklmn0JpG
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.444,
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
 tests/qtest/migration-test.c | 72 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 8bc665d..4eb641c 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1729,6 +1729,7 @@ static void test_precopy_common(MigrateCommon *args)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
+    const char *connect_uri;
 
     if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
@@ -1766,11 +1767,16 @@ static void test_precopy_common(MigrateCommon *args)
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, args->connect_channels, "{}");
+    /* If has channels, then connect_uri is only used for listen defer */
+    connect_uri = args->connect_channels ? NULL : args->connect_uri;
+    migrate_qmp(from, to, connect_uri, args->connect_channels, "{}");
 
     if (args->start.defer_target_connect) {
         qtest_connect_deferred(to);
         qtest_qmp_handshake(to);
+        if (!strcmp(args->listen_uri, "defer")) {
+            migrate_incoming_qmp(to, args->connect_uri, "{}");
+        }
     }
 
     if (args->result != MIG_TEST_SUCCEED) {
@@ -2415,6 +2421,66 @@ static void test_multifd_file_mapped_ram_fdset_dio(void)
 }
 #endif /* !_WIN32 */
 
+static void *test_mode_transfer_start(QTestState *from, QTestState *to)
+{
+    migrate_set_parameter_str(from, "mode", "cpr-transfer");
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
+    g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
+    g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
+    g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
+
+    const char *opts = "-machine aux-ram-share=on -nodefaults";
+    g_autofree char *opts_target = g_strdup_printf(
+        "-incoming \\{\\\'channel-type\\\':\\\'cpr\\\',"
+        "\\\'addr\\\':\\{\\\'transport\\\':\\\'socket\\\',"
+        "\\\'type\\\':\\\'unix\\\',\\\'path\\\':\\\'%s\\\'\\}\\} %s",
+        cpr_path, opts);
+
+    g_autofree char *channels = g_strdup_printf(
+        "[ { 'channel-type': 'main',"
+        "    'addr': { 'transport': 'socket',"
+        "              'type': 'unix',"
+        "              'path': '%s' } },"
+        "  { 'channel-type': 'cpr',"
+        "    'addr': { 'transport': 'socket',"
+        "              'type': 'unix',"
+        "              'path': '%s' } } ]",
+        mig_path, cpr_path);
+
+    MigrateCommon args = {
+        .start.opts_source = opts,
+        .start.opts_target = opts_target,
+        .start.defer_target_connect = true,
+        .start.memory_backend = "-object memory-backend-memfd,id=pc.ram,size=%s"
+                                " -machine memory-backend=pc.ram",
+        .listen_uri = incoming_defer ? "defer" : uri,
+        .connect_uri = incoming_defer ? uri : NULL,
+        .connect_channels = channels,
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
@@ -3905,6 +3971,10 @@ int main(int argc, char **argv)
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


