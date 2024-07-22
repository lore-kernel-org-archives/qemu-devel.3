Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E1FC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0ML-00029g-7k; Mon, 22 Jul 2024 17:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sW0MI-0001x5-2a
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:14:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sW0MG-0006Rd-Cw
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:14:13 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MKtWhe027864;
 Mon, 22 Jul 2024 21:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=Y
 C1WMdI0JndYGcGCaSMDcPAq/+OVRfSVO2R5/HJKHnc=; b=dRIhMAg4RVSFUiv23
 ZFkoy1XXxMPU/xvp1ReOKb5+4MS7JdlKPU2iEe5TR3a1p53Sf7AYgycEw+7rwNj4
 QejTf21cThtbXgf3hLHMGurkNGj2YgYa3BbBOCQuB+PrR9r11mLiBk2R2J88d6/L
 ImGIz1Hrj5RVPPFVYITvkUavG3u+G8rQLMqB7Evg521cX0xUNusVw2+PrOd5V1OC
 V0IBJKq0rd2L+W36g2/90vsWhnbV8TPjY6XAp2QZxMchxAzeh93ARa/f9byfyX0u
 fHG2GbCp1L7vry9THrqES6RI6i/QUvxeiRUX2I6hQ0TvpULddf5pYb1b71vxWYOD
 MIojQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgcrbmpv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 21:14:10 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46MKYVRl010981; Mon, 22 Jul 2024 21:14:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h29qa7n8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 21:14:08 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46ML6txJ040372;
 Mon, 22 Jul 2024 21:14:08 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-61-12.vpn.oracle.com
 [10.175.61.12])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 40h29qa7av-10; Mon, 22 Jul 2024 21:14:08 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v6 9/9] vfio/common: Allow disabling device dirty page tracking
Date: Mon, 22 Jul 2024 22:13:26 +0100
Message-Id: <20240722211326.70162-10-joao.m.martins@oracle.com>
In-Reply-To: <20240722211326.70162-1-joao.m.martins@oracle.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_14,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=955 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220157
X-Proofpoint-GUID: dmSpJwBQVBAk1bwbd_PWPNofHCWVYfJZ
X-Proofpoint-ORIG-GUID: dmSpJwBQVBAk1bwbd_PWPNofHCWVYfJZ
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

The property 'x-pre-copy-dirty-page-tracking' allows disabling the whole
tracking of VF pre-copy phase of dirty page tracking, though it means
that it will only be used at the start of the switchover phase.

Add an option that disables the VF dirty page tracking, and fall
back into container-based dirty page tracking. This also allows to
use IOMMU dirty tracking even on VFs with their own dirty
tracker scheme.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/hw/vfio/vfio-common.h | 1 +
 hw/vfio/common.c              | 3 +++
 hw/vfio/migration.c           | 4 +++-
 hw/vfio/pci.c                 | 3 +++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 1e02c98b09ba..fed499b199f0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -138,6 +138,7 @@ typedef struct VFIODevice {
     VFIOMigration *migration;
     Error *migration_blocker;
     OnOffAuto pre_copy_dirty_page_tracking;
+    OnOffAuto device_dirty_page_tracking;
     bool dirty_pages_supported;
     bool dirty_tracking;
     bool iommu_dirty_tracking;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index da12cbd56408..36d0cf6585b2 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -199,6 +199,9 @@ bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
     VFIODevice *vbasedev;
 
     QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
+        if (vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) {
+            return false;
+        }
         if (!vbasedev->dirty_pages_supported) {
             return false;
         }
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index cbfaef7afffe..262d42a46e58 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1036,7 +1036,9 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
         return !vfio_block_migration(vbasedev, err, errp);
     }
 
-    if (!vbasedev->dirty_pages_supported && !vbasedev->iommu_dirty_tracking) {
+    if ((!vbasedev->dirty_pages_supported ||
+         vbasedev->device_dirty_page_tracking == ON_OFF_AUTO_OFF) &&
+        !vbasedev->iommu_dirty_tracking) {
         if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
             error_setg(&err,
                        "%s: VFIO device doesn't support device and "
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8c0f212a163e..a0767de54b8d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3364,6 +3364,9 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", VFIOPCIDevice,
                             vbasedev.pre_copy_dirty_page_tracking,
                             ON_OFF_AUTO_ON),
+    DEFINE_PROP_ON_OFF_AUTO("x-device-dirty-page-tracking", VFIOPCIDevice,
+                            vbasedev.device_dirty_page_tracking,
+                            ON_OFF_AUTO_ON),
     DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
                             display, ON_OFF_AUTO_OFF),
     DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),
-- 
2.17.2


