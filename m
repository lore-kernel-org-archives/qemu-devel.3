Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D04ACAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yrL-0005MS-P9; Wed, 01 Oct 2025 11:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yrD-0005FT-As
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:35:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3yqq-0006SB-Qd
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:35:05 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591FMkbd018422;
 Wed, 1 Oct 2025 15:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=UYKz8fe0ki4zWq5OQKsWokyeI0WdugQL825zVbg4P3Q=; b=
 fOBSY6KboeuR1r+6VcUpmpIbizS++OBDduEl8KgBpWbX3SqvNf+akrRtF6W7Yq/s
 oESK99vTUbtG+yK9g4rg8UpOubayp5t0gfdPe1RHWkq2M2YzxIEi743Th+x85l+K
 h8Mtc0bpwk5TK4BO8T6pJFyXXlINX83WvUXBkv8uDdBc9dd+QD5FLzhvJ5NRPK9P
 ruNkkNZ6cWx3zeWlmEgRjsXxvHO6WLCjXlOoj5SgrxbbwiQZGxmBsrO4/FXd7SE4
 m0F9h8DAlHygflE1Uvi5LLd15MMc31ou/glOVpiZKbzOo3gkDUMhH56peXzj585V
 cHeYzyRdYb8KtovdMdyxKw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmrfsmk0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 591Ep1PV023324; Wed, 1 Oct 2025 15:34:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6caaw8w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 Oct 2025 15:34:23 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 591FYCr6014790;
 Wed, 1 Oct 2025 15:34:22 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 49e6caaw0k-15; Wed, 01 Oct 2025 15:34:22 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 14/19] migration-test: only_source option
Date: Wed,  1 Oct 2025 08:34:06 -0700
Message-Id: <1759332851-370353-15-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510010134
X-Proofpoint-ORIG-GUID: ZP0uu2uRG3eT6vw59DEosQgSpJJnsvoc
X-Proofpoint-GUID: ZP0uu2uRG3eT6vw59DEosQgSpJJnsvoc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE3MCBTYWx0ZWRfX2EjUu/pHJHeL
 sFJqkPzWoWSbzLb+pj2TJWjFkdSMLldcJSzfirY2hWFnRspz8Jo/vp/izLeHjXXrZMU1V9hmJTw
 8RYuoDWNWI0t+5KlX3NdaTf74CPJ4bx2rr84/uzGd/LgMQYQD09D13pbtxC88B6lK9brgOPuNnk
 0PnWYzUzJUQTKGNwxNOdTYwbVI9LVJ4JJ/ypN4EHyhtElDCYzeHdyhBxK8IRZSkpW4TNlxgXl7X
 4zbe3VQ4FGp1xhOhr6YRtnqETZvJM9DsBzxGKrwKQyn96oXLHJo0EPENCDC4Gwi29RekBPeXcrn
 Kv6rL+JeoBQb09Dh00BgT6Jj6oQ6QncNcrXPPd9ksomSe4ENTz+GeV4rITRg/ltlYggPXXEzmmr
 9CKH/yrmvKQ2QPAQtKbuKRYn0nXvug==
X-Authority-Analysis: v=2.4 cv=VpMuwu2n c=1 sm=1 tr=0 ts=68dd4a00 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=JlHfyRBGxHf9ofkGAE4A:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add the only_source option, analogous to only_target.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
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


