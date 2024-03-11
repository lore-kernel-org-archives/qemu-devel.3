Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B51C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjmb-0002PQ-Tj; Mon, 11 Mar 2024 13:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjm9-000249-DN
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:49:26 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjjm7-0008WP-2h
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:49:24 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42BG3r5r021055; Mon, 11 Mar 2024 17:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=CuhO/cQkNxrFoaRQrZcF9qAKyADhyJaFMiQAufOkxlk=;
 b=HWUYbgalM+oUaMWOy/5HwbyAR/NVkQlMu2YDowSiB6RMmLSNZsUi4x2nZgwB+8AmXs0P
 uTKy1Q5JnTqMR4tV8m8ZCyDRnNf5NgAwJB3CqY9RBr8bCtmdTQyJnweoC8ahXH94UEUj
 qpayMu371lJ0keCs/VOi9wWyza2n4jNgXcl8sGYEKUZ+9FwL5oPXqZiUjiyN7Z4fqCEt
 H9/tYdjofqcsBdeWBM2zCaRPMvfUXQcoyKGKpChTxbnz+Cq3w6U+n0vJmK/08Pv9xsBO
 wwwXV6E68K2u1vuW7h+3DZYZDStIL8hpAUnetlVNapgxqH7SQfYatC8nC4sW67HKU0G7 iA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfcuc10r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 17:49:16 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42BHNlvm028520; Mon, 11 Mar 2024 17:49:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre7633af-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 17:49:15 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BHlHcu020033;
 Mon, 11 Mar 2024 17:49:15 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3wre763302-9; Mon, 11 Mar 2024 17:49:15 +0000
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
Subject: [PATCH V2 08/11] migration: migration_file_set_error
Date: Mon, 11 Mar 2024 10:48:55 -0700
Message-Id: <1710179338-294359-9-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: yFvKnZxwAW5ZcnkGPnygLfPQGMKLhloe
X-Proofpoint-GUID: yFvKnZxwAW5ZcnkGPnygLfPQGMKLhloe
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

Define and export migration_file_set_error to eliminate a dependency
on MigrationState.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/common.c         |  9 +--------
 hw/vfio/migration.c      | 11 +++--------
 include/migration/misc.h |  2 ++
 migration/migration.c    | 11 +++++++++++
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index de01068..b44204e 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -39,7 +39,6 @@
 #include "sysemu/runstate.h"
 #include "trace.h"
 #include "qapi/error.h"
-#include "migration/migration.h"
 #include "migration/misc.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
@@ -150,14 +149,8 @@ bool vfio_viommu_preset(VFIODevice *vbasedev)
 
 static void vfio_set_migration_error(int err)
 {
-    MigrationState *ms = migrate_get_current();
-
     if (migration_is_setup_or_active()) {
-        WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
-            if (ms->to_dst_file) {
-                qemu_file_set_error(ms->to_dst_file, err);
-            }
-        }
+        migration_file_set_error(err);
     }
 }
 
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 5d4a23c..c5cb61d 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -17,13 +17,12 @@
 
 #include "sysemu/runstate.h"
 #include "hw/vfio/vfio-common.h"
-#include "migration/migration.h"
+#include "migration/misc.h"
 #include "migration/savevm.h"
 #include "migration/vmstate.h"
 #include "migration/qemu-file.h"
 #include "migration/register.h"
 #include "migration/blocker.h"
-#include "migration/misc.h"
 #include "qapi/error.h"
 #include "exec/ramlist.h"
 #include "exec/ram_addr.h"
@@ -712,9 +711,7 @@ static void vfio_vmstate_change_prepare(void *opaque, bool running,
          * Migration should be aborted in this case, but vm_state_notify()
          * currently does not support reporting failures.
          */
-        if (migrate_get_current()->to_dst_file) {
-            qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
-        }
+        migration_file_set_error(ret);
     }
 
     trace_vfio_vmstate_change_prepare(vbasedev->name, running,
@@ -744,9 +741,7 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
          * Migration should be aborted in this case, but vm_state_notify()
          * currently does not support reporting failures.
          */
-        if (migrate_get_current()->to_dst_file) {
-            qemu_file_set_error(migrate_get_current()->to_dst_file, ret);
-        }
+        migration_file_set_error(ret);
     }
 
     trace_vfio_vmstate_change(vbasedev->name, running, RunState_str(state),
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 28cfaed..e521cd5 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -109,6 +109,8 @@ bool migration_in_setup(MigrationState *);
 bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
 bool migration_is_running(void);
+void migration_file_set_error(int err);
+
 /* ...and after the device transmission */
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
 bool migration_in_incoming_postcopy(void);
diff --git a/migration/migration.c b/migration/migration.c
index db1e627..216f63d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3038,6 +3038,17 @@ static MigThrError postcopy_pause(MigrationState *s)
     }
 }
 
+void migration_file_set_error(int err)
+{
+    MigrationState *s = current_migration;
+
+    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
+        if (s->to_dst_file) {
+            qemu_file_set_error(s->to_dst_file, err);
+        }
+    }
+}
+
 static MigThrError migration_detect_error(MigrationState *s)
 {
     int ret;
-- 
1.8.3.1


