Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A15C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 17:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf1Vr-0005R1-6J; Tue, 27 Feb 2024 12:45:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rf1Vq-0005Q0-2N
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:45:06 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rf1Vo-0005fd-Bp
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 12:45:05 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41RFYlJF009938; Tue, 27 Feb 2024 17:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=8oG64oy8rob4doeu1Jctk8IZLA0fas24YY+2pZ6MU/Q=;
 b=nIZFNoUNq6/J1K+r2mhsabBvQ2Fn5DF3t12C7CRNHMivzQNgES566xqr4rBB2tBRfFiH
 jxfjl9djdcqTtOFvDgQLmCAGid3PbXjpHAJ874go/zoaMdhmc2prAk9V+6T2WGi2dxo4
 I9M1ku/28N4n3J0L/oSFzPl4DxD9tKmuHwDrreHw5u7dAIR8B1+wRa5GVWZrvzpRlnvK
 gyXi46cl9oF9xMXrn+jhHoSXx5mVS4Bhv6IdDCXOeGF1p7rUKZbui9IXFUi5UxZqyzZ3
 9yO8433ZLLqnXjhIay79mXNX/33mkdISHQ1dnUxX6+W4Io70YPB1tIm8YnkSQQeUYfWu fQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf82u7smx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 17:44:55 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41RHY3sD025619; Tue, 27 Feb 2024 17:43:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6we2vdn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Feb 2024 17:43:48 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41RHfGVY000491;
 Tue, 27 Feb 2024 17:43:48 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wf6we2v1c-10; Tue, 27 Feb 2024 17:43:48 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Jason Wang <jasowang@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Song Gao <gaosong@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 09/10] migration: privatize colo interfaces
Date: Tue, 27 Feb 2024 09:43:26 -0800
Message-Id: <1709055807-315099-10-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1709055807-315099-1-git-send-email-steven.sistare@oracle.com>
References: <1709055807-315099-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_05,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402270137
X-Proofpoint-GUID: fRbd9qaVR3igFnwdmfEM2B0ygzQR5Yot
X-Proofpoint-ORIG-GUID: fRbd9qaVR3igFnwdmfEM2B0ygzQR5Yot
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Remove private migration interfaces from net/colo-compare.c and push them
to migration/colo.c.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/colo.c   | 17 +++++++++++------
 net/colo-compare.c |  3 +--
 stubs/colo.c       |  1 -
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 315e31f..84632a6 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -63,9 +63,9 @@ static bool colo_runstate_is_stopped(void)
     return runstate_check(RUN_STATE_COLO) || !runstate_is_running();
 }
 
-static void colo_checkpoint_notify(void *opaque)
+static void colo_checkpoint_notify(void)
 {
-    MigrationState *s = opaque;
+    MigrationState *s = migrate_get_current();
     int64_t next_notify_time;
 
     qemu_event_set(&s->colo_checkpoint_event);
@@ -74,10 +74,15 @@ static void colo_checkpoint_notify(void *opaque)
     timer_mod(s->colo_delay_timer, next_notify_time);
 }
 
+static void colo_checkpoint_notify_timer(void *opaque)
+{
+    colo_checkpoint_notify();
+}
+
 void colo_checkpoint_delay_set(void)
 {
     if (migration_in_colo_state()) {
-        colo_checkpoint_notify(migrate_get_current());
+        colo_checkpoint_notify();
     }
 }
 
@@ -162,7 +167,7 @@ static void primary_vm_do_failover(void)
      * kick COLO thread which might wait at
      * qemu_sem_wait(&s->colo_checkpoint_sem).
      */
-    colo_checkpoint_notify(s);
+    colo_checkpoint_notify();
 
     /*
      * Wake up COLO thread which may blocked in recv() or send(),
@@ -518,7 +523,7 @@ out:
 
 static void colo_compare_notify_checkpoint(Notifier *notifier, void *data)
 {
-    colo_checkpoint_notify(data);
+    colo_checkpoint_notify();
 }
 
 static void colo_process_checkpoint(MigrationState *s)
@@ -642,7 +647,7 @@ void migrate_start_colo_process(MigrationState *s)
     bql_unlock();
     qemu_event_init(&s->colo_checkpoint_event, false);
     s->colo_delay_timer =  timer_new_ms(QEMU_CLOCK_HOST,
-                                colo_checkpoint_notify, s);
+                                colo_checkpoint_notify_timer, NULL);
 
     qemu_sem_init(&s->colo_exit_sem, 0);
     colo_process_checkpoint(s);
diff --git a/net/colo-compare.c b/net/colo-compare.c
index f2dfc0e..c4ad0ab 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -28,7 +28,6 @@
 #include "sysemu/iothread.h"
 #include "net/colo-compare.h"
 #include "migration/colo.h"
-#include "migration/migration.h"
 #include "util.h"
 
 #include "block/aio-wait.h"
@@ -189,7 +188,7 @@ static void colo_compare_inconsistency_notify(CompareState *s)
         notify_remote_frame(s);
     } else {
         notifier_list_notify(&colo_compare_notifiers,
-                             migrate_get_current());
+                             NULL);
     }
 }
 
diff --git a/stubs/colo.c b/stubs/colo.c
index 08c9f98..f8c069b 100644
--- a/stubs/colo.c
+++ b/stubs/colo.c
@@ -2,7 +2,6 @@
 #include "qemu/notify.h"
 #include "net/colo-compare.h"
 #include "migration/colo.h"
-#include "migration/migration.h"
 #include "qemu/error-report.h"
 #include "qapi/qapi-commands-migration.h"
 
-- 
1.8.3.1


