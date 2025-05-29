Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05456C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKit2-0004x2-J1; Thu, 29 May 2025 15:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisY-0004FU-9c
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisV-0000SP-Ag
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:24 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGft7Z031417;
 Thu, 29 May 2025 19:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=mA9mEIN317m/EpQDwKdK+MdOFVhaaz32PVPPdPOfWVU=; b=
 iuLPNAQcr80BB9G6DvSw3+YD5V93cOknyLPhhaMX1jKpwnHJNHEcDMiFbePUn/jD
 7elArPyg2GfHI3/67UCqn114I+ZtXaJLEgQ0Zwf5dU+kMpGsechv+ANAzb4gKtP0
 a1mCMOQkzMdXRBzmIoiKQB7JyumYBuK0ldIumG/AO1c/JdHVBkbfQxg0wkc5ly8g
 QMRFPI0DM048GlWvDUAJvxQHE+3/fuMDTmury3tUHPgToo42Mnqz4xV5zCYRfzlV
 VhrdgaaiICtqjSSq5/9mRHtxLHJdR6I0pA972SYmxz8ZwgD9lQXHlKTvJQ0a3NZh
 96fnid31L/xA/lQQFcaQiA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v33n0yd7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:09 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54THe8D5020394; Thu, 29 May 2025 19:25:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4w5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:09 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeRt022158;
 Thu, 29 May 2025 19:25:08 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-35; Thu, 29 May 2025 19:25:08 +0000
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
Subject: [PATCH V4 34/43] vfio/iommufd: device name blocker
Date: Thu, 29 May 2025 12:24:30 -0700
Message-Id: <1748546679-154091-35-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfXyLoA6NYrYQ2J
 AUoVaAcetJD7VBzuwKspRU/Rmzv57RI80b2/8IFtqc7sYhxxflxus0Zipxv6adJj0AbvSzvZHKF
 57FYL0kgDNC4Dbh+2cSoyQvQzTCxkcQ4WEGri7+99pV9+pl6BrC8Yq0hbe6Uy06yX08uLLEfZOU
 g2Yg3x8Cg97D+EViGGUsZVSZqeUedv3VTQUsrVvM6SGnd7oBqfX1k3GXVJ2NoGjkcuUuN7TE3Bu
 qjIMuIdMT7934ZO4e0tAxtYWm/E/A3ldj0pB5f+328GMlR267nEqZQepsjwx5o5BUuHy47YJIA6
 iweY6evMtDAI1vADb6eVmbBlM+c/pDQIKftlBo+MGfkxjGzHFiJ60F8ZI1PrGeYccmLyVGhrXf8
 C4Gzn/7+fZKvErCEvUJiEvqDta2YxBAjaxJAaP+bQVeIxhZEd3gxfsgTP6PgFSz7jLBcdlw2
X-Proofpoint-GUID: XSmV4CtMdNKzGVL-bqVdbb9q92Y2Qtrl
X-Authority-Analysis: v=2.4 cv=aO/wqa9m c=1 sm=1 tr=0 ts=6838b495 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=lCvbenQQaY-lctwRflUA:9
X-Proofpoint-ORIG-GUID: XSmV4CtMdNKzGVL-bqVdbb9q92Y2Qtrl
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 151c618..0f29063 100644
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
     g_free(vbasedev->name);
+    migrate_del_blocker(&vbasedev->cpr.id_blocker);
 }
 
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
-- 
1.8.3.1


