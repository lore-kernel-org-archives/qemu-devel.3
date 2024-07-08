Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3CBC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 14:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQpSC-0004s6-W6; Mon, 08 Jul 2024 10:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sQpRz-00041n-V5
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:34:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sQpRy-0002W3-5M
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:34:43 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fTnO000623;
 Mon, 8 Jul 2024 14:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=o
 mqdz6LORkl10HF1VrY2ibkkdtQlMHKO6ZlqBDCrQ0I=; b=dMrf+hnMDFUoNX3Om
 eDWppRsAPVkZDjU9SpJHIjwKwV9PoaHEPIDqgcg6gJgboypVp3KUz5VXMyIfdfSj
 gZzRMppkHXvo8qN3r9WUnoDp+2gQFf+6lupbRDwNIXO3zwIadP4j+Jpspovefv5w
 yPD3XR7pwlz0lMhOXlxHQstjG9YEHntKN8g/HqAZu37+fIqzEzeGky8bBZ9qV5K+
 AhtpidFB2ykqNBbjXMzrzl6e9O7XZynXbw9YkZE4IjJRQCYg0Tz97xa9oGBcUPrB
 uzWpCV2Y5LFlmRSpfVHM0n0Ssjw/sCR0UYN8uIP8Y1BnxwxM0JXbWxCYIXwJkDTO
 i0hwQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcas77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2024 14:34:39 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 468DAx3n007229; Mon, 8 Jul 2024 14:34:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 407tu1r6wc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2024 14:34:39 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 468EXkZD037381;
 Mon, 8 Jul 2024 14:34:38 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-56-128.vpn.oracle.com
 [10.175.56.128])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 407tu1r6ms-6; Mon, 08 Jul 2024 14:34:38 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v3 05/10] vfio/iommufd: Probe and request hwpt dirty tracking
 capability
Date: Mon,  8 Jul 2024 15:34:15 +0100
Message-Id: <20240708143420.16953-6-joao.m.martins@oracle.com>
In-Reply-To: <20240708143420.16953-1-joao.m.martins@oracle.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080109
X-Proofpoint-ORIG-GUID: _HyqfmvQ3PIn2gxoSWlybGAuMma1mNBs
X-Proofpoint-GUID: _HyqfmvQ3PIn2gxoSWlybGAuMma1mNBs
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

Probe hardware dirty tracking support by querying device hw capabilities via
IOMMUFD_GET_HW_INFO.

In preparation to using the dirty tracking UAPI, request dirty tracking in the
HWPT flags when the IOMMU supports dirty tracking.

The auto domain logic allows different IOMMU domains to be created when DMA
dirty tracking is not desired (and VF can provide it) while others doesn't have
it and want the IOMMU capability. This is not used in this way here given how
VFIODevice migration capability checking takes place *after* the device
attachment. But such granularity is a nice property that can be implemented
later on.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/iommufd.c             | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 82c5a4aaa61e..7ce925cfab19 100644
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
index 2ca9a32cc7b6..1b5b46d28ed6 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -212,6 +212,20 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
     return true;
 }
 
+static bool iommufd_device_dirty_tracking(IOMMUFDBackend *iommufd,
+                                          VFIODevice *vbasedev)
+{
+    enum iommu_hw_info_type type;
+    uint64_t caps;
+
+    if (!iommufd_backend_get_device_info(iommufd, vbasedev->devid, &type,
+                                         NULL, 0, &caps, NULL)) {
+        return false;
+    }
+
+    return caps & IOMMU_HW_CAP_DIRTY_TRACKING;
+}
+
 static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
                                          VFIOIOMMUFDContainer *container,
                                          Error **errp)
@@ -239,6 +253,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
         }
     }
 
+    /*
+     * This is quite early and VFIODevice isn't yet fully initialized,
+     * thus rely on IOMMU hardware capabilities as to whether IOMMU dirty
+     * tracking is going to be needed.
+     */
+    if (iommufd_device_dirty_tracking(iommufd, vbasedev)) {
+        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+    }
+
     ret = iommufd_backend_alloc_hwpt(iommufd,
                                      vbasedev->devid,
                                      container->ioas_id, flags,
@@ -255,6 +278,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
 
     hwpt = g_malloc0(sizeof(*hwpt));
     hwpt->hwpt_id = hwpt_id;
+    hwpt->hwpt_flags = flags;
     QLIST_INIT(&hwpt->device_list);
 
     ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
@@ -267,6 +291,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     vbasedev->hwpt = hwpt;
     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
     QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
+    container->bcontainer.dirty_pages_supported |=
+                              (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
     return true;
 }
 
-- 
2.17.2


