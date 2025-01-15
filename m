Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F6CC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 19:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY8df-0007La-5o; Wed, 15 Jan 2025 14:01:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY8dZ-0007Gz-EA
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:01:09 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tY8dX-0005e1-S3
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:01:09 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHtpRl029098;
 Wed, 15 Jan 2025 19:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=MX2qG+lw7fozKpigUNOqpF9aNiAA2o+IhFwDjhb4sdM=; b=
 dXCiwWtB0pykzY2FLAN4nAP+lpJR/vtTOc354PRVSSokQVoqF6+pwmvp/veZl74g
 tkGQCaWIpNRqghW0GAArT1ZL2FKd0FpALYNoWgbZyOsaaAtWHeUwOiAhoVSiNP6v
 5lncOXHzhhYYDei2Ji/W6Qo7ThNkdEa5jAvIOOVR2E5yDZCuAZ75ds0ho0qbDnDE
 +hvkdDyBr5saSxu2s1TquIgWagF7cCrU7S3UyFdr1EBWTBhEauJdFiyRH/HAN+J0
 zvTRVON3rJbTzAhkdeKRQ676mbmd9Q+2Anh7rqmHwabEepxcPHiGx7P//23XO07a
 wBUKL751kaDdldVDT9elFw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443fe2gu3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 19:01:05 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50FHNT9C034806; Wed, 15 Jan 2025 19:01:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 443f39ur8d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 19:01:04 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50FJ0peR016497;
 Wed, 15 Jan 2025 19:01:03 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 443f39uqwr-18; Wed, 15 Jan 2025 19:01:03 +0000
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
Subject: [PATCH V7 17/24] migration-test: memory_backend
Date: Wed, 15 Jan 2025 11:00:43 -0800
Message-Id: <1736967650-129648-18-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501150138
X-Proofpoint-ORIG-GUID: _anWeijW7v1ToJRvS7XNjpktBK2_lUHY
X-Proofpoint-GUID: _anWeijW7v1ToJRvS7XNjpktBK2_lUHY
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 47ce078..81a0e49 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -210,6 +210,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     const char *machine_alias, *machine_opts = "";
     g_autofree char *machine = NULL;
     const char *bootpath;
+    g_autofree char *memory_backend = NULL;
 
     if (args->use_shmem) {
         if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
@@ -285,6 +286,12 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
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
@@ -303,12 +310,12 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-machine %s,%s "
                                  "-name source,debug-threads=on "
-                                 "-m %s "
+                                 "%s "
                                  "-serial file:%s/src_serial "
                                  "%s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
-                                 memory_size, tmpfs,
+                                 memory_backend, tmpfs,
                                  arch_opts ? arch_opts : "",
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_source ? args->opts_source : "",
@@ -323,13 +330,13 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-machine %s,%s "
                                  "-name target,debug-threads=on "
-                                 "-m %s "
+                                 "%s "
                                  "-serial file:%s/dest_serial "
                                  "-incoming %s "
                                  "%s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
-                                 memory_size, tmpfs, uri,
+                                 memory_backend, tmpfs, uri,
                                  arch_opts ? arch_opts : "",
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
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


