Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBB8CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 13:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3woF-0007Sl-4N; Wed, 01 Oct 2025 09:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3woC-0007SA-Ow
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 09:23:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3wo1-0006IH-53
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 09:23:51 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591CrGWx001067;
 Wed, 1 Oct 2025 13:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2025-04-25; bh=H2N5EvVs
 GFkZCA9WQjihAqYrhYyVGzqm9YdZGkiILYQ=; b=J6b+I5cD4lKm1ih66RHULB+G
 rpgIdWRHjH2+OIoWChmtVL9KN0rV4Vl5K7nSxf815gDXOc2E6zfseXMdvhl6Un+C
 BbLTWATeekwneOK04XNZBPJvs7jGUoOlN6fjZF5eqOnd8apJgZEJt8M3cQq37q3u
 rIJbVW/FArSycIDKmMZKYSK3SbACQd6+NAxeKkpeu+nx32G81MbNne7gd/6saFTq
 AAOjDGoP7dr+IxNZvVTVW+9wDOSS6FxBX9ArrBAh+sG8EcHJZLzufQ47QAS2Fr0x
 S8dSA244wd1tQQ1qy/ZcPD5sDRXQzICUjbnc6M659/wLRbfI3LbWD4rnw7PTnA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmcq1drm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 13:23:33 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 591D1m7x004202; Wed, 1 Oct 2025 13:23:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6c964tw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 13:23:32 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 591DNUAj010031;
 Wed, 1 Oct 2025 13:23:30 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 49e6c964e2-1; Wed, 01 Oct 2025 13:23:30 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH] migration-test: fix migrate_args
Date: Wed,  1 Oct 2025 06:23:05 -0700
Message-Id: <1759324985-369944-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010116
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NiBTYWx0ZWRfX6lFiykWwV2Ct
 zkhOVhgOrMg3HSuQPXittm5z1q+ADW7W+gjt67HfHTRnYcpdVlgV0jBS3vCOhrFOT6ofbW2kXy6
 bafPjieuC/tx2U+QtRBsH9UkQC08wu5h1tb1L6SEuMdA9xw2v1iReBvI4UDrxWROzosMjbZz3ar
 NyRUppJo0lU0TO+qk3VpvlDti5pdF92hpwlNOQ8dt6WX1xHT/XOs3DsWAqLsODymfyqCE+sJwQB
 Lom19r/KEpNoj2hkIXG410f4jzb5u58gTMlQznF+jUMl9w3XyoZrK1k0tlEyUSnVPTqQBA5LX8a
 zZ5M16QjlqwIthrf5eReEAiYy3seFxVj53zZgoLlXjXMcseREM2lm4x8KDhwA5OkWOVaJsnK3Tj
 yhC6a8NueBaNd5LYrQ29BfMgD3CIUQ==
X-Proofpoint-ORIG-GUID: N2DNVbruPWdZLAiRWJPz9_7wsCPMf0Bu
X-Authority-Analysis: v=2.4 cv=c7amgB9l c=1 sm=1 tr=0 ts=68dd2b55 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=Ajjz2F2qt-e2BLgdxDEA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: N2DNVbruPWdZLAiRWJPz9_7wsCPMf0Bu
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

migrate_args calls g_test_skip, but that does not end the test.
It must also return an error code.  This fixes the queued patch
"migration-test: migrate_args".

Suggested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/migration/framework.c | 9 ++++++---
 tests/qtest/migration/framework.h | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 2dfb1ee..8044b2a 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -258,7 +258,7 @@ static char *test_shmem_path(void)
     return g_strdup_printf("/dev/shm/qemu-%d", getpid());
 }
 
-void migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
+int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
 {
     /* options for source and target */
     g_autofree gchar *arch_opts = NULL;
@@ -351,7 +351,7 @@ void migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
     if (!qtest_has_machine(machine_alias)) {
         g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
         g_test_skip(msg);
-        return;
+        return -1;
     }
 
     machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
@@ -398,6 +398,7 @@ void migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
 
     *from = cmd_source;
     *to = cmd_target;
+    return 0;
 }
 
 int migrate_start(QTestState **from, QTestState **to, const char *uri,
@@ -419,7 +420,9 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     bootfile_create(qtest_get_arch(), tmpfs, args->suspend_me);
     src_state.suspend_me = args->suspend_me;
 
-    migrate_args(&cmd_source, &cmd_target, uri, args);
+    if (migrate_args(&cmd_source, &cmd_target, uri, args)) {
+        return -1;
+    }
 
     if (!args->only_target) {
         *from = qtest_init_ext(QEMU_ENV_SRC, cmd_source, capabilities, true);
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 51a8a7e..ad5ca57 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -227,7 +227,7 @@ void wait_for_serial(const char *side);
 void migrate_prepare_for_dirty_mem(QTestState *from);
 void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to);
 
-void migrate_args(char **from, char **to, const char *uri, MigrateStart *args);
+int migrate_args(char **from, char **to, const char *uri, MigrateStart *args);
 int migrate_start(QTestState **from, QTestState **to, const char *uri,
                   MigrateStart *args);
 void migrate_end(QTestState *from, QTestState *to, bool test_dest);
-- 
1.8.3.1


