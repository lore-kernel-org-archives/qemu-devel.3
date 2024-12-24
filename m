Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA90AE7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 16:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ7bW-0003V4-LK; Tue, 24 Dec 2024 11:17:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tQ7bF-0003K2-8M
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:17:39 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tQ7bD-0003CN-By
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 11:17:36 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOEfkII021231;
 Tue, 24 Dec 2024 16:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=4gIWxPFgf2h3M9o/MJFnfwJS+kybBOrOWFfnyKyvziU=; b=
 GYdSJiEiw6GzR/JL9NCHESiMlds7xzXzZW1n6N5gapIrhY1OA+m07Dz8ztxpRWoh
 vvptwYRwgVk+j1l/OteeAIqd4iV+relnLvsMktzF6mP1H5/m033CgybyPA85s61Q
 HpQ5dEkWL6gjax9kkdFB4eTdUh6z0WGi1CDnf15VEkvk+vaRM+fpdJDXR0F7bCG7
 v+mUBijy8yWejjC+PGHrOTDLJWwC2/+dOfUfRlFFORAGjhrKayq28SQcqsrunO6I
 oavrK/i4236Pfwktk4HakBMFCRxsovuuPRDBs8LwTvvM8U+GyguPPsHSM7XAjHPK
 yixJDMJdBLs7qinZ0DWJqw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq7c4f11-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Dec 2024 16:17:21 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BODQVRQ023281; Tue, 24 Dec 2024 16:17:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43nm484gn9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Dec 2024 16:17:20 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BOGH9Xm021973;
 Tue, 24 Dec 2024 16:17:20 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 43nm484ggj-17; Tue, 24 Dec 2024 16:17:20 +0000
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
Subject: [PATCH V5 16/23] migration-test: memory_backend
Date: Tue, 24 Dec 2024 08:17:01 -0800
Message-Id: <1735057028-308595-17-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_06,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412240141
X-Proofpoint-GUID: i4hRZZAurqp5yb5cmWQsA1J6RHDAKO4U
X-Proofpoint-ORIG-GUID: i4hRZZAurqp5yb5cmWQsA1J6RHDAKO4U
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

Allow each migration test to define its own memory backend, replacing
the standard "-m <size>" specification.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c | 15 +++++++++++----
 tests/qtest/migration/framework.h |  5 +++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index a902936..89a3344 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -212,6 +212,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     const char *machine_alias, *machine_opts = "";
     g_autofree char *machine = NULL;
     const char *bootpath;
+    g_autofree char *memory_backend = NULL;
 
     if (args->use_shmem) {
         if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
@@ -287,6 +288,12 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
             memory_size, shmem_path);
     }
 
+    if (args->memory_backend) {
+        memory_backend = g_strdup_printf(args->memory_backend, memory_size);
+    } else {
+        memory_backend = g_strdup_printf("-m %s ", memory_size);
+    }
+
     if (args->use_dirty_ring) {
         kvm_opts = ",dirty-ring-size=4096";
     }
@@ -305,12 +312,12 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-machine %s,%s "
                                  "-name source,debug-threads=on "
-                                 "-m %s "
+                                 "%s "
                                  "-serial file:%s/src_serial "
                                  "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
-                                 memory_size, tmpfs,
+                                 memory_backend, tmpfs,
                                  arch_opts ? arch_opts : "",
                                  arch_source ? arch_source : "",
                                  shmem_opts ? shmem_opts : "",
@@ -326,13 +333,13 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-machine %s,%s "
                                  "-name target,debug-threads=on "
-                                 "-m %s "
+                                 "%s "
                                  "-serial file:%s/dest_serial "
                                  "-incoming %s "
                                  "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
-                                 memory_size, tmpfs, uri,
+                                 memory_backend, tmpfs, uri,
                                  arch_opts ? arch_opts : "",
                                  arch_target ? arch_target : "",
                                  shmem_opts ? shmem_opts : "",
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index e9fc4ec..d368fcf 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -109,6 +109,11 @@ typedef struct {
     const char *opts_target;
     /* suspend the src before migrating to dest. */
     bool suspend_me;
+    /*
+     * Format string for the main memory backend, containing one %s where the
+     * size is plugged in.  If omitted, "-m %s" is used.
+     */
+    const char *memory_backend;
 } MigrateStart;
 
 typedef enum PostcopyRecoveryFailStage {
-- 
1.8.3.1


