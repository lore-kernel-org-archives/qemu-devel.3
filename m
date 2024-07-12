Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E45C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 11:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSEke-0005c2-88; Fri, 12 Jul 2024 07:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sSEkH-0005R1-ED
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:47:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sSEkF-0007cG-HH
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:47:25 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C1CCf3021960;
 Fri, 12 Jul 2024 11:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=Y
 jjFfcqjRtgmHhj9Eg+zpRZFG+1Mm3L/QLMYuy0OMY4=; b=kmyYSYNoIKAyUADh6
 gKwhlx0E5rb25ttTrqvWkGrDD8C2S+w+xXfXfXT16Us6RZ2bepXxCU2m0qXhxrd0
 8OqduqAuquhGyCTzF9HazKJJQ6pn5qXwHbs9K9IgPcWiYQrX98eOLQu3UIi8GBtw
 8dBUwssJtKtMS4z/u3vVxEqjJCJAXOAdkuw9hw4zNkqpcwskofgK3fhFobdjxum1
 RR1y9jUGrWwGVXpSAuxbALqUuHG4Ulkix/YAujUcUoVFT9xLbwnhMlJnFAoVzK4w
 UilGHYNWceDnyMm6x5oB5EOzyGU2Kp+rVeOWHqumnj6Ul9lVROmIQ+A4HSQyP8ZP
 yTHzw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emt30a1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 11:47:17 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46CBMAQP022638; Fri, 12 Jul 2024 11:47:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 409vv3pq09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 11:47:16 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CBlCCU008041;
 Fri, 12 Jul 2024 11:47:15 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-0-59.vpn.oracle.com
 [10.175.0.59])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 409vv3ppxv-2; Fri, 12 Jul 2024 11:47:15 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v4 01/12] vfio/pci: Extract mdev check into an helper
Date: Fri, 12 Jul 2024 12:46:53 +0100
Message-Id: <20240712114704.8708-2-joao.m.martins@oracle.com>
In-Reply-To: <20240712114704.8708-1-joao.m.martins@oracle.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_08,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120080
X-Proofpoint-GUID: WJRmkkI9-9sxudRMDafjwItU4aH9cr8-
X-Proofpoint-ORIG-GUID: WJRmkkI9-9sxudRMDafjwItU4aH9cr8-
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

In preparation to skip initialization of the HostIOMMUDevice for mdev,
extract the checks that validate if a device is an mdev into helpers.

A vfio_set_mdev() is created, and subsystems consult VFIODevice::mdev
to check if it's mdev or not.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/helpers.c             | 18 ++++++++++++++++++
 hw/vfio/pci.c                 |  9 ++-------
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index e8ddf92bb185..7419466bca92 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -116,6 +116,7 @@ typedef struct VFIODevice {
     DeviceState *dev;
     int fd;
     int type;
+    bool mdev;
     bool reset_works;
     bool needs_reset;
     bool no_mmap;
@@ -231,6 +232,7 @@ void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
 void vfio_reset_handler(void *opaque);
 struct vfio_device_info *vfio_get_device_info(int fd);
+void vfio_set_mdev(VFIODevice *vbasedev);
 bool vfio_attach_device(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp);
 void vfio_detach_device(VFIODevice *vbasedev);
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index b14edd46edc9..bace0e788a09 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -675,3 +675,21 @@ int vfio_device_get_aw_bits(VFIODevice *vdev)
 
     return HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX;
 }
+
+void vfio_set_mdev(VFIODevice *vbasedev)
+{
+    g_autofree char *tmp = NULL;
+    char *subsys;
+    bool is_mdev;
+
+    if (!vbasedev->sysfsdev) {
+        return;
+    }
+
+    tmp = g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
+    subsys = realpath(tmp, NULL);
+    is_mdev = subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
+    free(subsys);
+
+    vbasedev->mdev = is_mdev;
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e03d9f3ba546..585f23a18406 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2963,12 +2963,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     ERRP_GUARD();
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
-    char *subsys;
     int i, ret;
     bool is_mdev;
     char uuid[UUID_STR_LEN];
     g_autofree char *name = NULL;
-    g_autofree char *tmp = NULL;
 
     if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
@@ -2997,11 +2995,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
      * stays in sync with the active working set of the guest driver.  Prevent
      * the x-balloon-allowed option unless this is minimally an mdev device.
      */
-    tmp = g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
-    subsys = realpath(tmp, NULL);
-    is_mdev = subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
-    free(subsys);
-
+    vfio_set_mdev(vbasedev);
+    is_mdev = vbasedev->mdev;
     trace_vfio_mdev(vbasedev->name, is_mdev);
 
     if (vbasedev->ram_block_discard_allowed && !is_mdev) {
-- 
2.17.2


