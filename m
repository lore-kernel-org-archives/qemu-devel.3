Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF47CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbrW-0000ot-Jm; Fri, 19 Sep 2025 10:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbr8-0000Uv-Gw
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:13:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbqz-0007TJ-JH
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:12:57 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtpX9003410;
 Fri, 19 Sep 2025 14:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=dY2NOTNkw1LjEzXQTZCL2DtK3kEwH8IcYpiFjp8CfxM=; b=
 k8sa82QiK3976rkh6i0m43eg760SAnqJV8YBAMme0qgfgWCV0PSdwms3Xnex3j8D
 pxhSHUZSy+VpvgFjCNpAObZTfngNDfd1pXgSCnyw1SJIxTaraOZm9dUdFctuImjP
 2m5U+QzakmX0vIdbhN0uzjm2oUF8ahQ8z72UH3oTOKT4bDiWijAsIkZyGeBIp90q
 4ITF3deHNw95Yn6Vm+FqdI863+cqpyIu4+toppv1rQDhofLXdqMs1iLPOqWpZUD7
 JHpUzQn/fb0oguq+tRAYD6W9yaR+VFQaRMjdvsvVu4uqZJNBM/G7ZI03xAYQrYZU
 A/A6T/OVhy8UgcR6Udf82w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx8ng7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:41 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JCXkqs035167; Fri, 19 Sep 2025 14:12:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2pu95u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:41 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JECYXD003357;
 Fri, 19 Sep 2025 14:12:40 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 494y2pu924-7; Fri, 19 Sep 2025 14:12:40 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 06/11] migration-test: only_source option
Date: Fri, 19 Sep 2025 07:12:28 -0700
Message-Id: <1758291153-349744-7-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
References: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190132
X-Authority-Analysis: v=2.4 cv=JNU7s9Kb c=1 sm=1 tr=0 ts=68cd64d9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=lri74naOo4n2Vg3VkkMA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 cc=ntf awl=host:13614
X-Proofpoint-ORIG-GUID: -F1OK8KguzKzoD50y86U8us4W40un250
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXycaHVw+XlYPK
 CN0kKyaM8xvyKwGxoBh8hbgYJEu7OXKWyQzTWaVMkJumIicEqU1PJWlu3FFwxuF8wP4Q6BpFXNn
 mMalrKn5JmnksJ3KzcDBD+ffc+57cuU2eeW1sgr6vOGfHlkwlKYdHwNhm7jBkbqUGkzPGCp5g94
 +L5Wa3jED8/DKCBYqpdsPJrveuTGWEWqvCNoGwtQjC8/Fckr1rrE+CqKYPXIRaX+tFmScEuxQ69
 P1AL0ahK81lK3vOcaVEK6DA74CAtuWUihgfwPOb9k3oMzl36kcEf3EEYL8z0GfhVXa9rqqkONn0
 K3XsPAY32MQ+7zXz4SLvKxuMfX3GqyWZ0Uva/YILHwO4CW8794MPyOe8WKYEP0XCS6YH+Z9Hu+k
 0GE9IiVcrpMMiIuJ34eU1skBcyyHdg==
X-Proofpoint-GUID: -F1OK8KguzKzoD50y86U8us4W40un250
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add the only_source option, analogous to only_target.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/migration/framework.h |  2 ++
 tests/qtest/migration/framework.c | 24 +++++++++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 01e425e..f1bb9d4 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -103,6 +103,8 @@ typedef struct {
      */
     bool hide_stderr;
     bool use_shmem;
+    /* only launch the source process */
+    bool only_source;
     /* only launch the target process */
     bool only_target;
     /* Use dirty ring if true; dirty logging otherwise */
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 407c902..9564293 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -234,7 +234,7 @@ static void migrate_start_set_capabilities(QTestState *from, QTestState *to,
      * to mimic as closer as that.
      */
     migrate_set_capability(from, "events", true);
-    if (!args->defer_target_connect) {
+    if (!args->defer_target_connect && to) {
         migrate_set_capability(to, "events", true);
     }
 
@@ -246,8 +246,10 @@ static void migrate_start_set_capabilities(QTestState *from, QTestState *to,
     if (args->caps[MIGRATION_CAPABILITY_MULTIFD]) {
         migrate_set_parameter_int(from, "multifd-channels",
                                   MULTIFD_TEST_CHANNELS);
-        migrate_set_parameter_int(to, "multifd-channels",
-                                  MULTIFD_TEST_CHANNELS);
+        if (to) {
+            migrate_set_parameter_int(to, "multifd-channels",
+                                      MULTIFD_TEST_CHANNELS);
+        }
     }
 
     return;
@@ -410,11 +412,13 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
-    *to = qtest_init_ext(QEMU_ENV_DST, cmd_target, capabilities,
-                         !args->defer_target_connect);
-    qtest_qmp_set_event_callback(*to,
-                                 migrate_watch_for_events,
-                                 &dst_state);
+    if (!args->only_source) {
+        *to = qtest_init_ext(QEMU_ENV_DST, cmd_target, capabilities,
+                             !args->defer_target_connect);
+        qtest_qmp_set_event_callback(*to,
+                                     migrate_watch_for_events,
+                                     &dst_state);
+    }
 
     /*
      * Remove shmem file immediately to avoid memory leak in test failed case.
@@ -424,7 +428,9 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
         unlink(shmem_path);
     }
 
-    migrate_start_set_capabilities(*from, *to, args);
+    migrate_start_set_capabilities(*from,
+                                   args->only_source ? NULL : *to,
+                                   args);
 
     return 0;
 }
-- 
1.8.3.1


