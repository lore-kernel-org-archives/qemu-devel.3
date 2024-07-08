Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7E2C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 14:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQpSF-0005Hb-KX; Mon, 08 Jul 2024 10:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sQpS7-0004cJ-EB
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:34:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sQpS5-0002XM-B1
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:34:51 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fUAp004411;
 Mon, 8 Jul 2024 14:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=V
 ZFYf2w9uH843EDbavDX3kXTkQ2ntOH2OQJYTwoWxPY=; b=gS8DVRPTuiz8/dCj7
 n5CgSqr07yQIBbNXamLfFEdB6QSlT2KYvYwKEnvDiqfEHYHY8Ya8wSwPw4mufgqi
 BbGv7eUMGcwqxpCj6rW/sxqgzBnJiv1dZauQ9j93EeR0G2hH5M1OJlD6U8/3SpA1
 hUigspf3JRo7IES3nFWwTkHVcpLZ2PEB0bXV8SUNLU0Pri04WHVob4ZMPR1PDj81
 qPcBpYrpPN2huElsYZUzC8ytp1bdE/x0TrvqVMeJynMLioBrpJsvxa/+8vKSm+28
 /K51phNjVfPSU7bVJWrcD9MMrQ8ce1kN5YQm2pDcvcL7WHd8jl3uLNtGUVSk70OI
 f3DJA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfsjsm0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2024 14:34:47 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 468DM5TM007590; Mon, 8 Jul 2024 14:34:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 407tu1r73j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2024 14:34:45 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 468EXkZJ037381;
 Mon, 8 Jul 2024 14:34:45 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-56-128.vpn.oracle.com
 [10.175.56.128])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 407tu1r6ms-9; Mon, 08 Jul 2024 14:34:45 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v3 08/10] vfio/iommufd: Parse hw_caps and store dirty tracking
 support
Date: Mon,  8 Jul 2024 15:34:18 +0100
Message-Id: <20240708143420.16953-9-joao.m.martins@oracle.com>
In-Reply-To: <20240708143420.16953-1-joao.m.martins@oracle.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=951
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080109
X-Proofpoint-ORIG-GUID: JvqJKc-6J1A_vl2dZOV5RUwK0a4O7RjT
X-Proofpoint-GUID: JvqJKc-6J1A_vl2dZOV5RUwK0a4O7RjT
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fetch capabilities from IOMMU device and add a capability to
host-iommu-device to reflect whether backing IOMMU has dirty tracking.

This is in preparation to relax the migration eligibility when device
doesn't have dirty tracking.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/sysemu/host_iommu_device.h | 2 ++
 backends/iommufd.c                 | 2 ++
 hw/vfio/iommufd.c                  | 1 +
 3 files changed, 5 insertions(+)

diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
index ee6c813c8b22..d38a31693482 100644
--- a/include/sysemu/host_iommu_device.h
+++ b/include/sysemu/host_iommu_device.h
@@ -25,6 +25,7 @@
 typedef struct HostIOMMUDeviceCaps {
     uint32_t type;
     uint8_t aw_bits;
+    bool dirty_tracking;
 } HostIOMMUDeviceCaps;
 
 #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
@@ -97,6 +98,7 @@ struct HostIOMMUDeviceClass {
  */
 #define HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE        0
 #define HOST_IOMMU_DEVICE_CAP_AW_BITS           1
+#define HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING    2
 
 #define HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX       64
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index b2d3bbd7c31b..9400d51004f0 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -314,6 +314,8 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
     switch (cap) {
     case HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE:
         return caps->type;
+    case HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING:
+        return caps->dirty_tracking;
     case HOST_IOMMU_DEVICE_CAP_AW_BITS:
         return caps->aw_bits;
     default:
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 9fad47baed9e..2678801f1cad 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -832,6 +832,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
         hiod->name = g_strdup(vdev->name);
         caps->type = type;
         caps->aw_bits = vfio_device_get_aw_bits(vdev);
+        caps->dirty_tracking = (hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING);
     }
 
     return true;
-- 
2.17.2


