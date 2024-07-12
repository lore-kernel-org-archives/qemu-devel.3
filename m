Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400B2C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 11:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSEkq-0006Mw-7n; Fri, 12 Jul 2024 07:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sSEkR-0005XV-Bc
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:47:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sSEkP-0007eW-FV
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:47:34 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C1BY8R020921;
 Fri, 12 Jul 2024 11:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=5
 rzZgaurg3uuiaZ3o8czx3hGgHHFONmGGwlQtj3jByE=; b=hlb0TfRgXMiwS2EsN
 Cchq+687hhokU8ov+B/8U0wReaZNGTAP5b1ELNFPt+MC/lZYGSjwKujcapMUR1Xv
 ZOYU4yojKeTsJSeApA1sikKW2geGp5n8JybQLrRAhVJ1X6NRsWYz4K0B31umlL4W
 83VGe56D0ge2UZkEfo+sD5wm7+DSycQRcZ0fMnvZ0CxR5bjqr1VZcatOy3ekF6cp
 9u4lXG+XnDU0SwROToGCYtiGQiswqhBhyg/iXy1AZ/HjxsYcWkt705CnFISoJk1b
 vNyeiPilFPccE3ARfK/VD/2YKwOGEoOLRZXkP6Dxh8nBBlZsd2h3NRE73iW92qID
 Xxt+Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emt30ah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 11:47:30 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46CA6MoJ022627; Fri, 12 Jul 2024 11:47:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 409vv3pq5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 11:47:29 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CBlCCe008041;
 Fri, 12 Jul 2024 11:47:29 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-0-59.vpn.oracle.com
 [10.175.0.59])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 409vv3ppxv-7; Fri, 12 Jul 2024 11:47:28 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v4 06/12] vfio/{iommufd,container}: Remove caps::aw_bits
Date: Fri, 12 Jul 2024 12:46:58 +0100
Message-Id: <20240712114704.8708-7-joao.m.martins@oracle.com>
In-Reply-To: <20240712114704.8708-1-joao.m.martins@oracle.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_08,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0
 mlxlogscore=951 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120080
X-Proofpoint-GUID: ILbVIHpq5fYhkAY5lM2u1HWxf4XJAqLm
X-Proofpoint-ORIG-GUID: ILbVIHpq5fYhkAY5lM2u1HWxf4XJAqLm
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In preparation to moving HostIOMMUDevice realize() being able to called
early during attach_device(), remove properties that rely on container
being initialized.

This means removing caps::aw_bits which requires the
bcontainer::iova_ranges to be inititalized after device is actually
attached. Instead defer that to .get_cap() and call
vfio_device_get_aw_bits() directly.

Suggested-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/sysemu/host_iommu_device.h | 1 -
 backends/iommufd.c                 | 3 ++-
 hw/vfio/container.c                | 5 +----
 hw/vfio/iommufd.c                  | 1 -
 4 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
index ee6c813c8b22..20e77cf54568 100644
--- a/include/sysemu/host_iommu_device.h
+++ b/include/sysemu/host_iommu_device.h
@@ -24,7 +24,6 @@
  */
 typedef struct HostIOMMUDeviceCaps {
     uint32_t type;
-    uint8_t aw_bits;
 } HostIOMMUDeviceCaps;
 
 #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 5d3dfa917415..41a9dec3b2c5 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -18,6 +18,7 @@
 #include "qemu/error-report.h"
 #include "monitor/monitor.h"
 #include "trace.h"
+#include "hw/vfio/vfio-common.h"
 #include <sys/ioctl.h>
 #include <linux/iommufd.h>
 
@@ -270,7 +271,7 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
     case HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE:
         return caps->type;
     case HOST_IOMMU_DEVICE_CAP_AW_BITS:
-        return caps->aw_bits;
+        return vfio_device_get_aw_bits(hiod->agent);
     default:
         error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
         return -EINVAL;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 88ede913d6f7..c27f448ba26e 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1144,7 +1144,6 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     VFIODevice *vdev = opaque;
 
     hiod->name = g_strdup(vdev->name);
-    hiod->caps.aw_bits = vfio_device_get_aw_bits(vdev);
     hiod->agent = opaque;
 
     return true;
@@ -1153,11 +1152,9 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
 static int hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
                                     Error **errp)
 {
-    HostIOMMUDeviceCaps *caps = &hiod->caps;
-
     switch (cap) {
     case HOST_IOMMU_DEVICE_CAP_AW_BITS:
-        return caps->aw_bits;
+        return vfio_device_get_aw_bits(hiod->agent);
     default:
         error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
         return -EINVAL;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 325c7598d5a1..873c919e319c 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -722,7 +722,6 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
 
     hiod->name = g_strdup(vdev->name);
     caps->type = type;
-    caps->aw_bits = vfio_device_get_aw_bits(vdev);
 
     return true;
 }
-- 
2.17.2


