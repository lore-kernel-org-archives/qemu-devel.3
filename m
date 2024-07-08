Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DFAC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 14:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQpRy-0003qJ-0I; Mon, 08 Jul 2024 10:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sQpRv-0003dL-Ds
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:34:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sQpRu-0002Uw-0h
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:34:39 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fdY5017452;
 Mon, 8 Jul 2024 14:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=x
 3j0+sR/TAD6m8XQ92iblNU4/A1p/wrxZ1UPJ/XqQ7U=; b=oCHLkwh76FURm7pkR
 E6Lq0bRH9072f04Vw0jm2sowdO18m2KT63+z/yAM7jyfnM2Ah58bWu1c1JGR/w65
 gRM1+LVMiYXU915PdAiaDnR74l1mYKpleR81ZgSrR6N0nAj0KHyZeDwIrW2tFa2D
 GJXcPMwvvvVWXK1KNSFWD2yrpxjtApTaLje0TjsY/JQAocD/llgQZuq856Oal/zo
 dsYaZGr+CpmuPDKaqDzL25Azn/BqxF/02hrWpBhx1h7Du/ZamDO2/0Mgg/9OWwyF
 lsMmafEGK8tjnZZpUfzemUkopt9xQl78V1x5L5nbiXsN59IwvLAuHizddPo3io0i
 7WWbA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknjsrg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2024 14:34:35 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 468DIo26007172; Mon, 8 Jul 2024 14:34:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 407tu1r6tf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2024 14:34:35 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 468EXkZ9037381;
 Mon, 8 Jul 2024 14:34:34 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-56-128.vpn.oracle.com
 [10.175.56.128])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 407tu1r6ms-4; Mon, 08 Jul 2024 14:34:34 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v3 03/10] vfio/iommufd: Return errno in
 iommufd_cdev_attach_ioas_hwpt()
Date: Mon,  8 Jul 2024 15:34:13 +0100
Message-Id: <20240708143420.16953-4-joao.m.martins@oracle.com>
In-Reply-To: <20240708143420.16953-1-joao.m.martins@oracle.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=892
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080109
X-Proofpoint-GUID: bYwBZkItY7kcA10f4jMNK5kdqeE9y3z7
X-Proofpoint-ORIG-GUID: bYwBZkItY7kcA10f4jMNK5kdqeE9y3z7
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

In preparation to implement auto domains have the attach function
return the errno it got during domain attach instead of a bool.

-EINVAL is tracked to track domain incompatibilities, and decide whether
to create a new IOMMU domain.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/iommufd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 9cee71659b1c..5a5993b17c2e 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -172,7 +172,7 @@ out:
     return ret;
 }
 
-static bool iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
+static int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
                                          Error **errp)
 {
     int iommufd = vbasedev->iommufd->fd;
@@ -187,12 +187,12 @@ static bool iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
         error_setg_errno(errp, errno,
                          "[iommufd=%d] error attach %s (%d) to id=%d",
                          iommufd, vbasedev->name, vbasedev->fd, id);
-        return false;
+        return -errno;
     }
 
     trace_iommufd_cdev_attach_ioas_hwpt(iommufd, vbasedev->name,
                                         vbasedev->fd, id);
-    return true;
+    return 0;
 }
 
 static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
@@ -216,7 +216,7 @@ static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
                                           VFIOIOMMUFDContainer *container,
                                           Error **errp)
 {
-    return iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
+    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
 }
 
 static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
-- 
2.17.2


