Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7747FC71131
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27t-0003S0-Ug; Tue, 10 Jun 2025 12:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15r-0004ZO-Vg
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15o-0006Eg-BK
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:55 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXdBd031121;
 Tue, 10 Jun 2025 15:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=kXu4dBbH9l35rXfzTrg6dH4hjAXVYZWiONb2f9361AA=; b=
 BKSiac5AGrGlAHp0NjkxijOJxCjwdYgTTm/0WRQBkl4EZwcaI8sYrAWqBfZAT0Zr
 lDAgNNwbbcm8FURTQUgedtwiozTw/2nqyOpskPOYukbkqxVrWzRsMAlZS77cHdXg
 QWTcIuFz74L9rVW1QrgLJWf856raQ9QwrM3PhnHrTR01BtqqGOhwBpe2djzJcKrk
 LoRaqY5oFaCrdBiq7A20sIymwA/Yt8m59fDyMIiZsbvzzMOJ8/eYIxMvOgdlsBjs
 Ypm7KlBmooSIADSN3fT20xhT/cPs3l1FLQGlWcalxTFJBMcCaMAb5oi1vCIkFOug
 5GKTiGOcq9+AHEshkfsn8w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dywvgsx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:39 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AF2BAF003893; Tue, 10 Jun 2025 15:40:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wbt6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:38 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrg3028825;
 Tue, 10 Jun 2025 15:40:37 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-29; Tue, 10 Jun 2025 15:40:37 +0000
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
Subject: [PATCH V5 28/38] vfio/iommufd: device name blocker
Date: Tue, 10 Jun 2025 08:39:41 -0700
Message-Id: <1749569991-25171-29-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=684851f7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=lCvbenQQaY-lctwRflUA:9 cc=ntf
 awl=host:14714
X-Proofpoint-ORIG-GUID: MY6LzH3Tn8aRMxXYJJBRizO8x1gVUttl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfX4vXKtvw6zmt9
 tgmTQPDPcAc7zaIvqNAn09x265mJXG2njaP/m66qDMs54LLKrgtqWZ5/E/bAxrO1OpRu19/nKcU
 WBI3LBlJUHzgK6cxNF6H8Kn5fQmCZS+QeicjvrmmL6vN3KJxw8uUP7EHKfCtHqaAZ+40vcZ9FIX
 xpkgIwQ+daKtTOOZ1WcF6shFab6SMpdPexsWxXNcpmEtlvJug8T0ad1aL2uWWsjfdevzLnn4sYB
 zurTv8uhUNBiIVbpzyw23c8p0XMslk9totm0T6U8uL1ePGrE4a7jWJCcChiMDcVI9w613K1B3ch
 hfbquL1vQj1+UEOFDQ0/IzDxAF330rQIR89MtX8HxAFJaBM9YC087NPUx3njTR2RJg53GLeU1sq
 T2yHZki1aDY0Gbve/drXvRe/z2MhtEvZtL71Mxj/VMze4jwnUpK7e+Cou0hsiXpyrScY+a+y
X-Proofpoint-GUID: MY6LzH3Tn8aRMxXYJJBRizO8x1gVUttl
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

If an invariant device name cannot be created, block CPR.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/hw/vfio/vfio-cpr.h |  1 +
 hw/vfio/device.c           | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 25e74ee..170a116 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -29,6 +29,7 @@ typedef struct VFIOContainerCPR {
 
 typedef struct VFIODeviceCPR {
     Error *mdev_blocker;
+    Error *id_blocker;
 } VFIODeviceCPR;
 
 bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index a3603f5..8c3835b 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -28,6 +28,8 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
+#include "migration/cpr.h"
+#include "migration/blocker.h"
 #include "monitor/monitor.h"
 #include "vfio-helpers.h"
 
@@ -308,8 +310,16 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
             } else {
                 /*
                  * Assign a name so any function printing it will not break.
+                 * The fd number changes across processes, so this cannot be
+                 * used as an invariant name for CPR.
                  */
                 vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
+                error_setg(&vbasedev->cpr.id_blocker,
+                           "vfio device with fd=%d needs an id property",
+                           vbasedev->fd);
+                return migrate_add_blocker_modes(&vbasedev->cpr.id_blocker,
+                                                 errp, MIG_MODE_CPR_TRANSFER,
+                                                 -1) == 0;
             }
         }
     }
@@ -320,6 +330,7 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
 void vfio_device_free_name(VFIODevice *vbasedev)
 {
     g_clear_pointer(&vbasedev->name, g_free);
+    migrate_del_blocker(&vbasedev->cpr.id_blocker);
 }
 
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
-- 
1.8.3.1


