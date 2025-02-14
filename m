Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65820C021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwUh-0008Nh-KA; Fri, 14 Feb 2025 09:16:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTs-0006Vy-7E
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:48 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTq-0004ks-An
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:47 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtShd001883;
 Fri, 14 Feb 2025 14:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=FnKrXU1jKMTtQwUQPGYZ/6nNzRzuGuz84bj4pjqq8bE=; b=
 JVkOHXAb86/8pJz6Wsw3G/QPDGdnit56USrxf6V09WsBWt9pCYhHnC8nEVjQ+EMj
 3mul0ejgA67rtBSIvl7GUH3UQpTPf+IeRwCzQlzs0OPeEEaE1wz3fKZ3Wi1EVarx
 hPk7N3mg0G3V4i40VMhA72JX8vErTxZ6pwAR5QfH3++I3ByKag8jz7+AkBqZpnVz
 2/I3D6BuiUGcQeY+KqIIKkjMdFpl6yhZEWjZe2MuL0e7OiIjqaMKj7PgAlVmTaCm
 r1Kk9d290wt9DnG8+XSqnuD6+Lkuzlm/s2NPbJCa29p1K2QSZ/rpF5xfTC7i7oCp
 8UUG4GS36vXrD8A3eVyDhA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qyusxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:29 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51ECfZOX025148; Fri, 14 Feb 2025 14:15:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqkshc1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:29 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETQf006920;
 Fri, 14 Feb 2025 14:15:28 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-45; Fri, 14 Feb 2025 14:15:28 +0000
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
Subject: [PATCH V2 44/45] iommufd: preserve DMA mappings
Date: Fri, 14 Feb 2025 06:14:26 -0800
Message-Id: <1739542467-226739-45-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: _92L9w1fwTF1OGNEKE3SYZbz6Z__w70v
X-Proofpoint-GUID: _92L9w1fwTF1OGNEKE3SYZbz6Z__w70v
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

During cpr-transfer load in new QEMU, the vfio_memory_listener causes
spurious calls to map and unmap DMA regions, as devices are created and
the address space is built.  This memory was already already mapped by the
device in old QEMU, so suppress the map and unmap callbacks during CPR --
eg, if the reused flag is set.  The reused flag is cleared in the post_load
handler.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 backends/iommufd.c    | 8 ++++++++
 hw/vfio/cpr-iommufd.c | 1 +
 2 files changed, 9 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index da90b21..dfcfd6b 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -209,6 +209,10 @@ int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
         .length = size,
     };
 
+    if (be->cpr_reused) {
+        return 0;
+    }
+
     if (!readonly) {
         map.flags |= IOMMU_IOAS_MAP_WRITEABLE;
     }
@@ -240,6 +244,10 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
         .length = size,
     };
 
+    if (be->cpr_reused) {
+        return 0;
+    }
+
     ret = ioctl(fd, IOMMU_IOAS_UNMAP, &unmap);
     /*
      * IOMMUFD takes mapping as some kind of object, unmapping
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 92b101d..286597a 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -66,6 +66,7 @@ static const VMStateDescription vfio_container_vmstate = {
     .name = "vfio-iommufd-container",
     .version_id = 0,
     .minimum_version_id = 0,
+    .priority = MIG_PRI_LOW,   /* Must happen after devices and groups */
     .pre_save = vfio_container_pre_save,
     .post_load = vfio_container_post_load,
     .needed = cpr_needed_for_reuse,
-- 
1.8.3.1


