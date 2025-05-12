Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C04C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVA5-0005SN-No; Mon, 12 May 2025 11:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9k-0004aX-7y
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9g-0006jS-Oq
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:27 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9e3K029140;
 Mon, 12 May 2025 15:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=XM7zHmPk+as75y2v0NiCYdpQ6A9sOcxKzmc/NRj9KfA=; b=
 pHdvIlI0xetXtNyPXrFva4TafJR5S8DFM4I4z9DLpdA2OwWaghE5OBviKE8SR7iF
 sQhm9G4SddTgNWGbVNsz93815Q1T9ZSQMnCZrsMHO8WXj/FDEG5oXArVCPBLEElX
 kqWkm2BshSCQa+DMVS7SbfeJCguq7EEnPONPJZilNxBXw50t/02wNk00fm0jWJDc
 SAVUVdXSOXJ276Os7TloTqVfKjRLeb7D0r/L6Ub4JyU6z05AboMqwikLhhxDkF+x
 BPQSJ8WqyuJMcjqI6WgsxjOPvzMQfdA8k3RUKJV2kzhcJKo0Al8OSjpmPRlbCSgu
 v2+FWdeEyp/j7gO8jXPPiQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0gwju7f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:19 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CEFRT2002372; Mon, 12 May 2025 15:33:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366r3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:18 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk5e030605;
 Mon, 12 May 2025 15:33:18 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-32; Mon, 12 May 2025 15:33:17 +0000
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
Subject: [PATCH V3 31/42] vfio/iommufd: use IOMMU_IOAS_MAP_FILE
Date: Mon, 12 May 2025 08:32:42 -0700
Message-Id: <1747063973-124548-32-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120161
X-Authority-Analysis: v=2.4 cv=M8hNKzws c=1 sm=1 tr=0 ts=682214bf b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=-QcZ205ZjAmYhoUyRx0A:9
X-Proofpoint-GUID: vl6tlOX-Q5WlxAZVtcK7TSu5cLS8rfBb
X-Proofpoint-ORIG-GUID: vl6tlOX-Q5WlxAZVtcK7TSu5cLS8rfBb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX+Uo2gFXXmMZN
 7bJLhchf08KC6Gm5kAe0jxcgHrn45xjnCdCU9BzvtDpXOyUEKfVtYGIRTowcaJ7WSXii2anD+Ek
 SN1EUHDHBXJoCSNLQb18fC8ye1J9KbhWrpWTSAoesDeff16SZV3ATbZPd3tiVZdONRCFgrRseOd
 0umHNUzg3ARQbx+53Mw4jMNDYtyYJj4mFX2s8bMtuezJUdP1TOwigTR3s+rdnTx7LAA+TT2dF1Z
 szS43Pgp/ny+mBgzxrDtYCCeeQo3KNtpPdAgYlcoxtxBbc1qFUDo0qkKwK7pJcOZGvXJ+w95yDz
 K9x0hSEf7zrSP32M+YcQqB0Wqjw8CUkuVi/Hc+VFuZPpu79D/1HUoWHz31Y08Ks5rpF5ELXW8MT
 Nc5qyQXZ3Evmy5PzwNCnHYGtNhUgZ/c9oMBUjiMY4NnIqrStlVGmW7XN23dfK1W3Wxc2RJT+
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Use IOMMU_IOAS_MAP_FILE when the mapped region is backed by a file.
Such a mapping can be preserved without modification during CPR,
because it depends on the file's address space, which does not change,
rather than on the process's address space, which does change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/container-base.c              |  9 +++++++++
 hw/vfio/iommufd.c                     | 13 +++++++++++++
 include/hw/vfio/vfio-container-base.h |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 8f43bc8..72a51a6 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -79,7 +79,16 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            RAMBlock *rb)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    int mfd = rb ? qemu_ram_get_fd(rb) : -1;
 
+    if (mfd >= 0 && vioc->dma_map_file) {
+        unsigned long start = vaddr - qemu_ram_get_host_addr(rb);
+        unsigned long offset = qemu_ram_get_fd_offset(rb);
+
+        vioc->dma_map_file(bcontainer, iova, size, mfd, start + offset,
+                           readonly);
+        return 0;
+    }
     g_assert(vioc->dma_map);
     return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
 }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 167bda4..6eb417a 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -44,6 +44,18 @@ static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                                    iova, size, vaddr, readonly);
 }
 
+static int iommufd_cdev_map_file(const VFIOContainerBase *bcontainer,
+                                 hwaddr iova, ram_addr_t size,
+                                 int fd, unsigned long start, bool readonly)
+{
+    const VFIOIOMMUFDContainer *container =
+        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
+
+    return iommufd_backend_map_file_dma(container->be,
+                                        container->ioas_id,
+                                        iova, size, fd, start, readonly);
+}
+
 static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
                               hwaddr iova, ram_addr_t size,
                               IOMMUTLBEntry *iotlb, bool unmap_all)
@@ -802,6 +814,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, const void *data)
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
     vioc->dma_map = iommufd_cdev_map;
+    vioc->dma_map_file = iommufd_cdev_map_file;
     vioc->dma_unmap = iommufd_cdev_unmap;
     vioc->attach_device = iommufd_cdev_attach;
     vioc->detach_device = iommufd_cdev_detach;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 03b3f9c..f30f828 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -123,6 +123,9 @@ struct VFIOIOMMUClass {
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
                    void *vaddr, bool readonly);
+    int (*dma_map_file)(const VFIOContainerBase *bcontainer,
+                        hwaddr iova, ram_addr_t size,
+                        int fd, unsigned long start, bool readonly);
     /**
      * @dma_unmap
      *
-- 
1.8.3.1


