Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51197C02193
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 14:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td9Id-0000ft-Gq; Wed, 29 Jan 2025 09:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9Ib-0000f1-GH
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:44:13 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9IZ-0001Oa-Pj
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:44:13 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEXrKl011631;
 Wed, 29 Jan 2025 14:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=PngtgFNIRuTVuIU4bNtaaptebJWnixYeRD7cj95XLpM=; b=
 alQ9dzMPZQOuwhrOPePnLxSGUQVx1kSRN5mrheha007d9L+JZvGUe0bKG+0iADv9
 mNUubP4l5tiRrzpDIUjn8vdRwwluFystQTaA+XGGk4gdvceP17DDd/fgPt0D0JN+
 HdNN7Nipuqvx1O9IRn/1bdSA3rWuW1NFQ8BcUgDgsztevJdzY2/p/F4Nebf7jhrG
 borB2bsobX9ATMnKupmOngln16vf4lRk+iEYjCtUJs/ws+nDS+XtixPRC22kgIML
 AT6UF27AgHxlG6ayBiEFH7xCulIURJNizr/vIErbEruGbnHLoYHrVB2Ev/KG01mG
 DyzB7DSr+GPDaiUDt5e8PA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fnk9g3jf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:58 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50TDOoKI034428; Wed, 29 Jan 2025 14:43:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44cpd9s4um-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:57 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50TEhf8w003307;
 Wed, 29 Jan 2025 14:43:56 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 44cpd9s49q-23; Wed, 29 Jan 2025 14:43:56 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 22/26] vfio/iommufd: invariant device name
Date: Wed, 29 Jan 2025 06:43:18 -0800
Message-Id: <1738161802-172631-23-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290119
X-Proofpoint-ORIG-GUID: FUwrt4tULkEpuUXPbFJLxcZLc6lAhtKT
X-Proofpoint-GUID: FUwrt4tULkEpuUXPbFJLxcZLc6lAhtKT
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
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

cpr-transfer will use the device name as a key to find the value
of the device descriptor in new QEMU.  However, if the descriptor
number is specified by a command-line fd parameter, then
vfio_device_get_name creates a name that includes the fd number.
This causes a chicken-and-egg problem: new QEMU must know the fd
number to construct a name to find the fd number.

To fix, create an invariant name based on the id command-line
parameter.  If id is not defined, add a CPR blocker.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/helpers.c             | 18 +++++++++++++++---
 hw/vfio/iommufd.c             |  2 ++
 include/hw/vfio/vfio-common.h |  1 +
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 913796f..bd94b86 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -25,6 +25,8 @@
 #include "hw/vfio/vfio-common.h"
 #include "hw/hw.h"
 #include "trace.h"
+#include "migration/blocker.h"
+#include "migration/cpr.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
@@ -636,6 +638,7 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
 {
     ERRP_GUARD();
     struct stat st;
+    bool ret = true;
 
     if (vbasedev->fd < 0) {
         if (stat(vbasedev->sysfsdev, &st) < 0) {
@@ -653,15 +656,24 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
             return false;
         }
         /*
-         * Give a name with fd so any function printing out vbasedev->name
+         * Give a name so any function printing out vbasedev->name
          * will not break.
          */
         if (!vbasedev->name) {
-            vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
+            if (vbasedev->dev->id) {
+                vbasedev->name = g_strdup(vbasedev->dev->id);
+            } else {
+                vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
+                error_setg(&vbasedev->cpr_id_blocker,
+                           "vfio device with fd=%d needs an id property",
+                           vbasedev->fd);
+                ret = migrate_add_blocker_modes(&vbasedev->cpr_id_blocker, errp,
+                                                MIG_MODE_CPR_TRANSFER, -1) == 0;
+            }
         }
     }
 
-    return true;
+    return ret;
 }
 
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 2f888e5..8308715 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -24,6 +24,7 @@
 #include "system/reset.h"
 #include "qemu/cutils.h"
 #include "qemu/chardev_open.h"
+#include "migration/blocker.h"
 #include "pci.h"
 #include "exec/ram_addr.h"
 
@@ -657,6 +658,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
     iommufd_cdev_container_destroy(container);
     vfio_put_address_space(space);
 
+    migrate_del_blocker(&vbasedev->cpr_id_blocker);
     iommufd_cdev_unbind_and_disconnect(vbasedev);
     close(vbasedev->fd);
 }
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index ca10abc..37e7c26 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -147,6 +147,7 @@ typedef struct VFIODevice {
     VFIOMigration *migration;
     Error *migration_blocker;
     Error *cpr_mdev_blocker;
+    Error *cpr_id_blocker;
     OnOffAuto pre_copy_dirty_page_tracking;
     OnOffAuto device_dirty_page_tracking;
     bool dirty_pages_supported;
-- 
1.8.3.1


