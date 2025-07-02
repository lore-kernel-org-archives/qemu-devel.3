Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFAAC8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5U4-0003TN-LH; Wed, 02 Jul 2025 17:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5U0-0003Qf-TU
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5Tz-0003hW-9a
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:12 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LQdeY014113;
 Wed, 2 Jul 2025 21:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=TitFvc56HkOWjrcrEqoqdCJdYa2goL+4FG70llolu1E=; b=
 f0UP2bilvHzy9B2xyigr93jqJyAMoPqimoAgtgChFUY8F39HOq3g4cTHd+clcKmC
 xSr/v9xuVcF7GEtCjd/AZIwJAYdKJ0EVHUfONkdiSD1LWOgQacgzmFm62EcdJHIo
 f/7yS9sGsliPRV4vehKXsbX6Yym0IoPO8rhVrMJoNS/ZE/RDwH7mMmxC/dFd/Q6b
 5DLOlYZqBgw4/I5WkHkGqqYDBb2UhED6sy/HBU98XWu57tmbmt7xbhAGKRJEtJH3
 G45kPXZ3TdnZAn/E1eCuzYUmTmWoTRbCUGUN0fL6YyvPLq+5w/7QIe1AD4DN0jAo
 aLn1ClZqZfA+Na1e5KV8Kw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704fxkv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:08 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562LaXn1033615; Wed, 2 Jul 2025 21:59:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubtd3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:08 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562LwxgG020012;
 Wed, 2 Jul 2025 21:59:07 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47j6ubtcxb-12; Wed, 02 Jul 2025 21:59:07 +0000
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
Subject: [PATCH V6 11/21] vfio/iommufd: device name blocker
Date: Wed,  2 Jul 2025 14:58:48 -0700
Message-Id: <1751493538-202042-12-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020182
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE4MiBTYWx0ZWRfXxd/WdphKW3z7
 ti1E75YSrCP1SkBYWEuNN4d0Hjl0T08ywZfAYzFgLyanzWNzfzZfwcIAFjEXVSOdmEuwoxyFb8/
 YZFYmUOR/V28INqHngoE3FRbjdgOy8XttJ+klX3Z4UXWGeDFwaEk22+sQOmP6RFsAFcJb1h5fra
 HLXcoCw1k/Ei4WEkwqrrRZyo0Xft7NdEQjqaNRJ/vPkntN+di/kfiT6nLol1Y8S3MHUxFACuhRA
 htVpG6re4KBwY+YMC9o5WlniXbuS+qj4TtQ4gLy4+1PV2248hb753MBY/rNvQn3tVocNXfQU97O
 ifEyyuekdUpKUIYEuzevEcBwO62tGgDv1QJYMx+85PpPSEYATkhM41OdjpvNUQU6N8NO6ZcqG8I
 c2RM0iKaNWz+fmRYvf19DYAuGDmIR5tUIShSO7/XZLV8q9PjFPA4hpxYFTqzwlYEvOEU4iej
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=6865abac cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=lCvbenQQaY-lctwRflUA:9
X-Proofpoint-GUID: t4YLgHvNfz6JhSMYp2h6i9RS53-6eTWJ
X-Proofpoint-ORIG-GUID: t4YLgHvNfz6JhSMYp2h6i9RS53-6eTWJ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-cpr.h |  1 +
 hw/vfio/device.c           | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 099d54f..76eafc0 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -29,6 +29,7 @@ typedef struct VFIOContainerCPR {
 
 typedef struct VFIODeviceCPR {
     Error *mdev_blocker;
+    Error *id_blocker;
 } VFIODeviceCPR;
 
 bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 97eddd0..0ae3f3c 100644
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
 
@@ -324,8 +326,16 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
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
@@ -336,6 +346,7 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
 void vfio_device_free_name(VFIODevice *vbasedev)
 {
     g_clear_pointer(&vbasedev->name, g_free);
+    migrate_del_blocker(&vbasedev->cpr.id_blocker);
 }
 
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
-- 
1.8.3.1


