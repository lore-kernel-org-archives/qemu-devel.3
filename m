Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D61E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 17:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXkel-0004uB-PW; Tue, 14 Jan 2025 12:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXked-0004q6-5N
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:24:40 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tXkea-0004cE-Co
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:24:38 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EC0qkd020953;
 Tue, 14 Jan 2025 17:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=4sqPIe077jSiTYY4RuU7SRIkW66pRMpC1kEZJKBDSzA=; b=
 G1SI1RD2huKUEua/yzftdX32juSV1wZ0KLle7VDMrStJTYldM3A7eJVC4gdXxlSr
 Hnj5VHotklcu4xTCutkwU9r9pp1wRez00Qysttp5seURvxdZCQUFAD8S6xbnHsm0
 W5BZgUk+nbzlqSruuwtiXv7uKcUDl4xYFOZSCkkuQv7uQIA15FtF8qSbKDJcj+xg
 WbguqNZQxd5vivNnt1VjxxVXvBCYXRHRPorUnneYB+3V9EQ9CQRpGMI3DKfnpxQ6
 oBNeK8l1SpI817hBQWVP1dnb0p0TGp9Z4pGS2oa/wOwQyye56PBatnG1Y1FCUj6p
 xp1q2IF6/21ppZsaFY9avQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443h6sx559-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:24:30 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50EHArUs020486; Tue, 14 Jan 2025 17:24:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 443f3eq6qn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jan 2025 17:24:28 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50EHNtYA013352;
 Tue, 14 Jan 2025 17:24:28 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 443f3eq5us-21; Tue, 14 Jan 2025 17:24:28 +0000
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
Subject: [PATCH V6 20/24] migration-test: defer connection
Date: Tue, 14 Jan 2025 09:23:50 -0800
Message-Id: <1736875434-106563-21-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
References: <1736875434-106563-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_05,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501140133
X-Proofpoint-GUID: BS0WXK2OdD7JFhcD7PTM5lCm_Ytshijn
X-Proofpoint-ORIG-GUID: BS0WXK2OdD7JFhcD7PTM5lCm_Ytshijn
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.794,
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

Add an option to defer connection to the target monitor, needed by the
cpr-transfer test.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c | 23 ++++++++++++++++++++---
 tests/qtest/migration/framework.h |  3 +++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 44ff901..03640e4 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -211,6 +211,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     g_autofree char *machine = NULL;
     const char *bootpath;
     g_autofree char *memory_backend = NULL;
+    const char *events;
 
     if (args->use_shmem) {
         if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
@@ -327,21 +328,30 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
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
-                                 "%s %s %s %s",
+                                 "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
                                  memory_backend, tmpfs, uri,
+                                 events,
                                  arch_opts ? arch_opts : "",
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
-    *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target, true);
+    *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target,
+                              !args->defer_target_connect);
     qtest_qmp_set_event_callback(*to,
                                  migrate_watch_for_events,
                                  &dst_state);
@@ -359,7 +369,9 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
      * to mimic as closer as that.
      */
     migrate_set_capability(*from, "events", true);
-    migrate_set_capability(*to, "events", true);
+    if (!args->defer_target_connect) {
+        migrate_set_capability(*to, "events", true);
+    }
 
     return 0;
 }
@@ -713,6 +725,11 @@ void test_precopy_common(MigrateCommon *args)
 
     migrate_qmp(from, to, args->connect_uri, args->connect_channels, "{}");
 
+    if (args->start.defer_target_connect) {
+        qtest_connect(to);
+        qtest_qmp_handshake(to);
+    }
+
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
         wait_for_migration_fail(from, allow_active);
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index d368fcf..1341368 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -114,6 +114,9 @@ typedef struct {
      * size is plugged in.  If omitted, "-m %s" is used.
      */
     const char *memory_backend;
+
+    /* Do not connect to target monitor and qtest sockets in qtest_init */
+    bool defer_target_connect;
 } MigrateStart;
 
 typedef enum PostcopyRecoveryFailStage {
-- 
1.8.3.1


