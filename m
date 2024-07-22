Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D883C3DA64
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0ML-0002AN-BL; Mon, 22 Jul 2024 17:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sW0ME-0001ib-Gg
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:14:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sW0MA-0006NU-Ey
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:14:09 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MKtWsc011108;
 Mon, 22 Jul 2024 21:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 corp-2023-11-20; bh=FScN6vJ9o5kB6jsxhdHXnV2HRGNqzHmlMgZHf4cmUCc=; b=
 oIU7CGsAmfQKPxE+/xsEbAhmZ0q973uv4x0m3ckTFB67lqZp9quWF60tTf+/YKSB
 grbiYJGImjlihxl40zorCJAX9ha6xhcah05rTZ5eeXJyn77GXRSwEl0hUdRhQzX0
 JGrouXsOrxKfe5J6ZeUgPX8Vlju0OhQWt/N9N/Yf7jGJAN/io7GUWVc31+ZMAyiB
 Mfnw3zwJfwcgm4jcjC6z3QK3e2kAHv7bzmx+L2HACfN/KPhX3/2X6+hDCShwhAVc
 i2Z/8De/t6SPnemQ0yRBpdBa4Swg1j2r2parhYJyc17oMufE7VZib1VO5AQVkZuo
 jkjzi87INcZx2HoZ7Yjszw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkt3jj7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 21:13:58 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46ML7ijO011016; Mon, 22 Jul 2024 21:13:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h29qa7fh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 21:13:56 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46ML6tx7040372;
 Mon, 22 Jul 2024 21:13:56 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-61-12.vpn.oracle.com
 [10.175.61.12])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 40h29qa7av-4; Mon, 22 Jul 2024 21:13:56 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v6 3/9] vfio/iommufd: Add hw_caps field to HostIOMMUDeviceCaps
Date: Mon, 22 Jul 2024 22:13:20 +0100
Message-Id: <20240722211326.70162-4-joao.m.martins@oracle.com>
In-Reply-To: <20240722211326.70162-1-joao.m.martins@oracle.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_14,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220157
X-Proofpoint-GUID: EA2aVHy7MW7DimDQb4N7KcHK1S02jv9i
X-Proofpoint-ORIG-GUID: EA2aVHy7MW7DimDQb4N7KcHK1S02jv9i
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

Store the value of @caps returned by iommufd_backend_get_device_info()
in a new field HostIOMMUDeviceCaps::hw_caps. Right now the only value is
whether device IOMMU supports dirty tracking (IOMMU_HW_CAP_DIRTY_TRACKING).

This is in preparation for HostIOMMUDevice::realize() being called early
during attach_device().

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/sysemu/host_iommu_device.h | 4 ++++
 hw/vfio/iommufd.c                  | 1 +
 2 files changed, 5 insertions(+)

diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
index d1c10ff7c239..809cced4ba5c 100644
--- a/include/sysemu/host_iommu_device.h
+++ b/include/sysemu/host_iommu_device.h
@@ -19,9 +19,13 @@
  * struct HostIOMMUDeviceCaps - Define host IOMMU device capabilities.
  *
  * @type: host platform IOMMU type.
+ *
+ * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
+ *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
  */
 typedef struct HostIOMMUDeviceCaps {
     uint32_t type;
+    uint64_t hw_caps;
 } HostIOMMUDeviceCaps;
 
 #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 5bb623879abe..5e2fc1ce089d 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -724,6 +724,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
 
     hiod->name = g_strdup(vdev->name);
     caps->type = type;
+    caps->hw_caps = hw_caps;
 
     return true;
 }
-- 
2.17.2


