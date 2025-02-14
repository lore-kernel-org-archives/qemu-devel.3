Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B2DC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwUp-0000Zp-V0; Fri, 14 Feb 2025 09:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTp-0006P4-3U
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:47 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTa-0004j2-9G
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:36 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtRB2011445;
 Fri, 14 Feb 2025 14:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=zurSjh+ycUk+qDKlD1hF4rXDMsLxZM0vRjOuN/brrwY=; b=
 fk/a4MZZGuMbCrSxeosBSjyAMdsF/l2zc7m/FBWNuwdoGLQ3W7lA9SPfNQwzEM1m
 Fv0cy9boUQPapFDi0eF9bYgIDaSdFT1X6R1TwIEf2HpHrlUaJHvcDLSAJbH/Zymv
 kDO/K8QRxwRlnonVb0GRW1OLXg0OMI9lk5mLfYodpZSCifAxCv76bTjSqwOyAoZb
 Gp5mh7ZFValnr3C8FrFH2dYQQ4wA1guIq3dZUS1wl0Ol0NogGnnlNllhw6Hepoyu
 hh/vXWEsBoIX7MVFvyVTJycqY/+aA1+pO+to7zXnx8b90Sc/X/AuPUwyGFGSREOg
 fywTinP9eoBivzNrVOJMBg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0sqbwnp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:16 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51ECZ4jA025433; Fri, 14 Feb 2025 14:15:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksh08-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:15 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETQL006920;
 Fri, 14 Feb 2025 14:15:14 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-35; Fri, 14 Feb 2025 14:15:14 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 34/45] vfio/iommufd: export iommufd_cdev_get_info_iova_range
Date: Fri, 14 Feb 2025 06:14:16 -0800
Message-Id: <1739542467-226739-35-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140104
X-Proofpoint-ORIG-GUID: kT9CuHhFyKTZH1ZSyTtmrRJNEp-9WHlI
X-Proofpoint-GUID: kT9CuHhFyKTZH1ZSyTtmrRJNEp-9WHlI
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Export iommufd_cdev_get_info_iova_range, for use by CPR in a subsequent
patch to reconstruct the userland device state.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/iommufd.c             | 4 ++--
 include/hw/vfio/vfio-common.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index ea40da5..a6e24a7 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -429,8 +429,8 @@ static int iommufd_cdev_ram_block_discard_disable(bool state)
     return ram_block_uncoordinated_discard_disable(state);
 }
 
-static bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
-                                             uint32_t ioas_id, Error **errp)
+bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
+                                      uint32_t ioas_id, Error **errp)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
     g_autofree struct iommu_ioas_iova_ranges *info = NULL;
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 78e4f12..9ca40d0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -264,6 +264,9 @@ void vfio_kvm_device_close(void);
 bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
 void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
 
+bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
+                                      uint32_t ioas_id, Error **errp);
+
 extern const MemoryRegionOps vfio_region_ops;
 typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
-- 
1.8.3.1


