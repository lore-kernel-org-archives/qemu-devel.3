Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48668C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 12:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUmRp-0003BR-GT; Fri, 19 Jul 2024 08:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUmRh-0002cL-2R
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:10:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUmRe-0007fc-Kn
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:10:44 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JC5ZFK015782;
 Fri, 19 Jul 2024 12:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=d
 3InZZPKqwQj+5FqIQz9OCEKe3TvmN8jRvFc5PxWhAM=; b=BAmeYlljzGW14OpBl
 yLh/vp/vSLq+PSroHW0oWYIWKVzxZXh4m1vvXKyQUtaG1ANNkQla2Twxk+apVAns
 IMvF5Aak56BlqxugZRZcC5YaJ/03SF1P79BU6hdqBcUtdTE7WBhUDVPD2glUbZBQ
 QlyF4CLL0T6e5fUenI8zLKYA35BCm7uE/d881WPcLNZ/RpcOcMnjhTMBdnuDkit9
 Cndf+vwEyOs44EPd27UQC1B3VeHvYGjREfjkVYFUaW6IaJnjY+un/fR2X4r9B0Nw
 F2Qej6xzAEjTngOkufQ0PYh11vDFzWHnZuRGnZy0daBm5V2MFHnu+YX6Em8bPCQj
 2Vbbg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fquag0pb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 12:10:40 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46JBMRbu039507; Fri, 19 Jul 2024 12:05:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwexk3qk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 12:05:39 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46JC5DMT011010;
 Fri, 19 Jul 2024 12:05:39 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-12-11.vpn.oracle.com
 [10.175.12.11])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 40dwexk34j-10; Fri, 19 Jul 2024 12:05:38 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v5 09/13] vfio/iommufd: Probe and request hwpt dirty tracking
 capability
Date: Fri, 19 Jul 2024 13:04:57 +0100
Message-Id: <20240719120501.81279-10-joao.m.martins@oracle.com>
In-Reply-To: <20240719120501.81279-1-joao.m.martins@oracle.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407190093
X-Proofpoint-GUID: -dJONroY4nQhB8eLwh3l12zqsRd3NXBa
X-Proofpoint-ORIG-GUID: -dJONroY4nQhB8eLwh3l12zqsRd3NXBa
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
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/iommufd.c             | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 4e44b26d3c45..7e530c7869dc 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -97,6 +97,7 @@ typedef struct IOMMUFDBackend IOMMUFDBackend;
 
 typedef struct VFIOIOASHwpt {
     uint32_t hwpt_id;
+    uint32_t hwpt_flags;
     QLIST_HEAD(, VFIODevice) device_list;
     QLIST_ENTRY(VFIOIOASHwpt) next;
 } VFIOIOASHwpt;
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index bb44d948c735..2e5c207bbca0 100644
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
@@ -267,6 +284,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     vbasedev->hwpt = hwpt;
     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
     QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
+    container->bcontainer.dirty_pages_supported |=
+                              iommufd_hwpt_dirty_tracking(hwpt);
     return true;
 }
 
-- 
2.17.2


