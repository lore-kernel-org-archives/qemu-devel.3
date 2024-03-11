Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70ABC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjmb-0002M5-P0; Mon, 11 Mar 2024 13:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjmC-00027t-B7
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:49:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjm8-00004z-SY
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:49:26 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42BG40h5008069; Mon, 11 Mar 2024 17:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=8oG64oy8rob4doeu1Jctk8IZLA0fas24YY+2pZ6MU/Q=;
 b=bLZLRH0FW2jixS8d2KlmZBuW//74PC4naGGDG5L3QpfzKdV/6d4bBAbFINBSPWP8pt8z
 F3Gcj+69oVyZoQtawZWWdtxeqV2PnSLoaCQ/jnbICQpBNB7cnEhxU/WG4KpeRQsB2KQ6
 cwyiXdEVkpUXQq9E4oG6x9KC9fw0QMDTh0MjHSqv5isksq+VUFCPUc2rhEQk4QXylb3n
 yR+zGThFMfYj9ptDK8vHUQNLl+qIedkCLrzjUFVLwVGBK95AkZKHR7ZYiuv0rAJ7/kEG
 QUDnYxSuv/1scmlxdgZkh5UJwAVyUJ4o4AgJckR+CM521siIuA/TQAztea3gRj0+SZiB vg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrftdc23c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 17:49:18 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42BHkjb8028544; Mon, 11 Mar 2024 17:49:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre7633c0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 17:49:17 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BHlHcw020033;
 Mon, 11 Mar 2024 17:49:17 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wre763302-10; Mon, 11 Mar 2024 17:49:17 +0000
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
Subject: [PATCH V2 09/11] migration: privatize colo interfaces
Date: Mon, 11 Mar 2024 10:48:56 -0700
Message-Id: <1710179338-294359-10-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1710179338-294359-1-git-send-email-steven.sistare@oracle.com>
References: <1710179338-294359-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403110136
X-Proofpoint-ORIG-GUID: BnpMYTt_lkeVcdCB-Oe9F6fGBYj40-3u
X-Proofpoint-GUID: BnpMYTt_lkeVcdCB-Oe9F6fGBYj40-3u
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


