Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12DAD78323
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6a3-0005nT-Cd; Mon, 02 Dec 2024 08:35:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6M5-000871-BJ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6M0-0005qK-Pz
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:46 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26WvkD024799;
 Mon, 2 Dec 2024 13:20:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=djKZ8Tk2Z3XOin/4L7hl0xtlsXfXjyoXfa58BNaPARc=; b=
 LqR3qLvsM4C6VCvSuRP3XuMHFju5L9nW32P1DuJGgJX09NT4lGMKQpb1eFpOcRPa
 KGKkCGut+tTJnh8yWh3r1qtoC251ztFLbc6VdThAOXihx7MDouKD+bnbnZI/kPwX
 bTok3vD9MO6SuW3G31UDDcYIsuxSoHo50Hu/3+2pZoOdprNiikYXuYj6RFwkZRxh
 2tbdIKTS7eBUf3UNKVFLyiB80V08ZMYZIWzeXnCSVTuwA97vvR1zbc1IwmfuUxOU
 PZhnPpB2eeImsZ1coy9iK9K+B6ue3BODogLFfyfS1wNqh1LcnsToPHxrw9zAzqYm
 sJ1RqnyknItIb4UDY2sz8w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sg2347d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:27 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4B2CVsYs032908; Mon, 2 Dec 2024 13:20:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 437s56jtuq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:26 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4B2DKCF7032806;
 Mon, 2 Dec 2024 13:20:25 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 437s56jthv-18; Mon, 02 Dec 2024 13:20:25 +0000
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
Subject: [PATCH V4 17/19] tests/migration-test: defer connection
Date: Mon,  2 Dec 2024 05:20:09 -0800
Message-Id: <1733145611-62315-18-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: ODQ1lFjqfusBKUxsvONEamQfp11NKfs4
X-Proofpoint-GUID: ODQ1lFjqfusBKUxsvONEamQfp11NKfs4
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

Add an option to defer connection to the target monitor, needed by the
cpr-transfer test.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b7001b0..8bc665d 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -614,6 +614,9 @@ typedef struct {
      * size is plugged in.  If omitted, "-m %s" is used.
      */
     const char *memory_backend;
+
+    /* Do not connect to target monitor and qtest sockets in qtest_init */
+    bool defer_target_connect;
 } MigrateStart;
 
 /*
@@ -733,6 +736,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     const char *machine_alias, *machine_opts = "";
     g_autofree char *machine = NULL;
     g_autofree char *memory_backend = NULL;
+    const char *events;
 
     if (args->use_shmem) {
         if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
@@ -850,22 +854,31 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                      &src_state);
     }
 
+    /*
+     * If the monitor connection is deferred, enable events on the command line
+     * so none are missed.  This is for testing only, do not set migration
+     * options like this in general.
+     */
+    events = args->defer_target_connect ? "-global migration.x-events=on" : "";
+
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-machine %s,%s "
                                  "-name target,debug-threads=on "
                                  "%s "
                                  "-serial file:%s/dest_serial "
                                  "-incoming %s "
-                                 "%s %s %s %s %s",
+                                 "%s %s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
                                  memory_backend, tmpfs, uri,
+                                 events,
                                  arch_opts ? arch_opts : "",
                                  arch_target ? arch_target : "",
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
-    *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target, false);
+    *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target,
+                              args->defer_target_connect);
     qtest_qmp_set_event_callback(*to,
                                  migrate_watch_for_events,
                                  &dst_state);
@@ -883,7 +896,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
      * to mimic as closer as that.
      */
     migrate_set_capability(*from, "events", true);
-    migrate_set_capability(*to, "events", true);
+    if (!args->defer_target_connect) {
+        migrate_set_capability(*to, "events", true);
+    }
 
     return 0;
 }
@@ -1753,6 +1768,11 @@ static void test_precopy_common(MigrateCommon *args)
 
     migrate_qmp(from, to, args->connect_uri, args->connect_channels, "{}");
 
+    if (args->start.defer_target_connect) {
+        qtest_connect_deferred(to);
+        qtest_qmp_handshake(to);
+    }
+
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
         wait_for_migration_fail(from, allow_active);
-- 
1.8.3.1


