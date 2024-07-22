Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80D9C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0MG-0001qG-Id; Mon, 22 Jul 2024 17:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sW0MC-0001bD-Jz
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:14:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sW0MA-0006OW-1n
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:14:08 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MKtYLl018376;
 Mon, 22 Jul 2024 21:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=Q
 pr6hb8fTB9D70FbXEQt7WQ10riZ70uViyxqSIl0fOY=; b=knKL27JUztaXIYN/E
 OitwGJr5ht0aF0+PzjE69QoAmYF6qfzZ7SQ6nQ1o3Ji6ivkXQNKJTi7GYUtW5S3v
 lBcstGvnTBJnf5Iao8zeHJZUMYyR3VRQmzkmZfGa+h5rY5IvLWfViH84E+IpjnS1
 n+6xf7pw7IRrHdUREy5rPNu7u8pY+Y6Ujk5nUpbqUjJn0dYZlLmHs1RL2htJKgii
 Rg/EkqIFGFJ7GFs25dnZ6pzniAZwS4RqrRtfVxyb8j18RKZ31UeRilReD8/L+yK+
 7QdIF6ay9VmA6s1Z8MF2o4+ebYgOjmk1je8+7vv7YxNlZp4KpUunQZ2YEaTks8uQ
 WqZoA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft0bnpq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 21:14:02 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46MKUlBM011001; Mon, 22 Jul 2024 21:14:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40h29qa7ht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 21:14:00 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46ML6txB040372;
 Mon, 22 Jul 2024 21:14:00 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-61-12.vpn.oracle.com
 [10.175.61.12])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 40h29qa7av-6; Mon, 22 Jul 2024 21:14:00 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v6 5/9] vfio/iommufd: Probe and request hwpt dirty tracking
 capability
Date: Mon, 22 Jul 2024 22:13:22 +0100
Message-Id: <20240722211326.70162-6-joao.m.martins@oracle.com>
In-Reply-To: <20240722211326.70162-1-joao.m.martins@oracle.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_14,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220157
X-Proofpoint-GUID: VvpX8PXp7Va8_-3P9XYIL5xp-TZ114hH
X-Proofpoint-ORIG-GUID: VvpX8PXp7Va8_-3P9XYIL5xp-TZ114hH
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

In preparation to using the dirty tracking UAPI, probe whether the IOMMU
supports dirty tracking. This is done via the data stored in
hiod::caps::hw_caps initialized from GET_HW_INFO.

Qemu doesn't know if VF dirty tracking is supported when allocating
hardware pagetable in iommufd_cdev_autodomains_get(). This is because
VFIODevice migration state hasn't been initialized *yet* hence it can't pick
between VF dirty tracking vs IOMMU dirty tracking. So, if IOMMU supports
dirty tracking it always creates HWPTs with IOMMU_HWPT_ALLOC_DIRTY_TRACKING
even if later on VFIOMigration decides to use VF dirty tracking instead.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/iommufd.c             | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 4e44b26d3c45..1e02c98b09ba 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -97,6 +97,7 @@ typedef struct IOMMUFDBackend IOMMUFDBackend;
 
 typedef struct VFIOIOASHwpt {
     uint32_t hwpt_id;
+    uint32_t hwpt_flags;
     QLIST_HEAD(, VFIODevice) device_list;
     QLIST_ENTRY(VFIOIOASHwpt) next;
 } VFIOIOASHwpt;
@@ -139,6 +140,7 @@ typedef struct VFIODevice {
     OnOffAuto pre_copy_dirty_page_tracking;
     bool dirty_pages_supported;
     bool dirty_tracking;
+    bool iommu_dirty_tracking;
     HostIOMMUDevice *hiod;
     int devid;
     IOMMUFDBackend *iommufd;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 2324bf892c56..7afea0b041ed 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -110,6 +110,11 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
     iommufd_backend_disconnect(vbasedev->iommufd);
 }
 
+static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
+{
+    return hwpt && hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+}
+
 static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
 {
     ERRP_GUARD();
@@ -246,6 +251,17 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
         }
     }
 
+    /*
+     * This is quite early and VFIO Migration state isn't yet fully
+     * initialized, thus rely only on IOMMU hardware capabilities as to
+     * whether IOMMU dirty tracking is going to be requested. Later
+     * vfio_migration_realize() may decide to use VF dirty tracking
+     * instead.
+     */
+    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
+        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+    }
+
     if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
                                     container->ioas_id, flags,
                                     IOMMU_HWPT_DATA_NONE, 0, NULL,
@@ -255,6 +271,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
 
     hwpt = g_malloc0(sizeof(*hwpt));
     hwpt->hwpt_id = hwpt_id;
+    hwpt->hwpt_flags = flags;
     QLIST_INIT(&hwpt->device_list);
 
     ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
@@ -265,8 +282,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     }
 
     vbasedev->hwpt = hwpt;
+    vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
     QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
+    container->bcontainer.dirty_pages_supported |=
+                                vbasedev->iommu_dirty_tracking;
     return true;
 }
 
-- 
2.17.2


