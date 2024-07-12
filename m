Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A62EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 11:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSEkl-00066e-VM; Fri, 12 Jul 2024 07:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sSEkc-0005ZR-3B
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:47:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sSEkV-0007oF-52
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:47:43 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C1Brt3018742;
 Fri, 12 Jul 2024 11:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=P
 aYmX+yn5KPsFmi4XTB1nAQuBi/DtSh0BCtwzQmnuas=; b=QaWOizty1g0iw1aF9
 zWBM4E8mVOn7G8M2FVUomZOfSeatE78qaEItbjZpxWUNHNAU7NtPZs4ZjKfH6USJ
 HVGhAarjzwK5R6H/rpmPXijZL3BbzTGAMfHgmK74J5vwgLfC6r9lRGTfMIMxp8c5
 wg3eAyHrnxPGqdHqjqFZ30iCRRUZyQNpHzanFETTIyVuYI06CUB0W+Yt++HAtT9r
 cttWBsZczg3781wLMY2cJ0YbAYHIGZjaT4Lw9SeheUU5eaDWdgu47RpjpI0FBOMO
 aMxRjfryMKaFRZ9aheMCW1/wolLGBA47oRkNAHNrQyzIC1ai0Nmoumf1QsgUUvRV
 pV0wA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkckm8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 11:47:35 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46CAFTj9022608; Fri, 12 Jul 2024 11:47:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 409vv3pq7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 11:47:34 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CBlCCi008041;
 Fri, 12 Jul 2024 11:47:34 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-0-59.vpn.oracle.com
 [10.175.0.59])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 409vv3ppxv-9; Fri, 12 Jul 2024 11:47:34 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v4 08/12] vfio/iommufd: Probe and request hwpt dirty tracking
 capability
Date: Fri, 12 Jul 2024 12:47:00 +0100
Message-Id: <20240712114704.8708-9-joao.m.martins@oracle.com>
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
X-Proofpoint-ORIG-GUID: bKfSXWAYz6Ey-Q9F6UTOUh6clR4lcBbp
X-Proofpoint-GUID: bKfSXWAYz6Ey-Q9F6UTOUh6clR4lcBbp
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Probe hardware dirty tracking support by querying device hw capabilities via
IOMMUFD_GET_HW_INFO.

In preparation to using the dirty tracking UAPI, request dirty tracking in the
HWPT flags when the IOMMU supports dirty tracking.

The auto domain logic allows different IOMMU domains to be created when DMA
dirty tracking is not desired (and VF can provide it) while others doesn't have
it and want the IOMMU capability. This is not used in this way here given how
VFIODevice migration capability checking takes place *after* the device
attachment.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/iommufd.c             | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 2dd468ce3c02..760f31d84ac8 100644
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
index d34dc88231ec..edc8f97d8f3d 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -246,6 +246,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
         }
     }
 
+    /*
+     * This is quite early and VFIODevice isn't yet fully initialized,
+     * thus rely on IOMMU hardware capabilities as to whether IOMMU dirty
+     * tracking is going to be needed.
+     */
+    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
+        flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+    }
+
     if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
                                     container->ioas_id, flags,
                                     IOMMU_HWPT_DATA_NONE, 0, NULL,
@@ -255,6 +264,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
 
     hwpt = g_malloc0(sizeof(*hwpt));
     hwpt->hwpt_id = hwpt_id;
+    hwpt->hwpt_flags = flags;
     QLIST_INIT(&hwpt->device_list);
 
     ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
@@ -267,6 +277,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     vbasedev->hwpt = hwpt;
     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
     QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
+    container->bcontainer.dirty_pages_supported |=
+                              (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
     return true;
 }
 
-- 
2.17.2


