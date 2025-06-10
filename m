Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCD6C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27l-0002rB-TZ; Tue, 10 Jun 2025 12:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15l-0004Yh-Si
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15j-0006EP-Et
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:49 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXbS1030425;
 Tue, 10 Jun 2025 15:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=b54vQVbYTF+1CEDXrIiZtUzGgPTjx/NGQ920jsNHbUU=; b=
 pYytMkv4NAqgVOI2MfPfU4YzJ+5+WOdNNlgJhk7UfO25FBpMapjy3O8Q50tbr17N
 h/CJ+M70BmZ9e1HvHPDQTtaWfbgKpIMDLEURJ6IZvuNKqmsNKqsfvKd9eIaOr0Ev
 PCMTNxd2co4gRaLSfAgTxr8dUq6OzUIBTuTt8cWa/50ErmPrOhxGmTEbnMGsoHz2
 RROSZEhIpv58V8HbxA8Hq2CAM1XFY2eIH8bgJWhLtg02MDCFMI1labdTlPr6oejr
 7BHsdAUv9+h5AidEc3TW5CsNDFzGpjw0BK5ky6w6BleCprToVvwa8/BJ2fRBnwZz
 zjPnrTj8K1eKcRLE40Eo6g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14cgwu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:34 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AEe0Ug003302; Tue, 10 Jun 2025 15:40:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wbne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:32 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrfv028825;
 Tue, 10 Jun 2025 15:40:31 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-26; Tue, 10 Jun 2025 15:40:31 +0000
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
Subject: [PATCH V5 25/38] vfio/iommufd: use IOMMU_IOAS_MAP_FILE
Date: Tue, 10 Jun 2025 08:39:38 -0700
Message-Id: <1749569991-25171-26-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Proofpoint-GUID: UgCszPUhckweis-Nxah_i71ay2Uu1J1g
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=684851f2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=-QcZ205ZjAmYhoUyRx0A:9
 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfXwbC0I2R4vjwj
 E/QzOPnWLhCl7GhEBz96pRDFp46/DJFNeR4ur796tXk+tjp+V5JMy6Pck3S5japAfVXRokQg5Vb
 UYw4Du5JpquMZv5aorQ08JjSSn+WW+OjBH1V9Oj3Ldx7UslKcUf+quD5DBW/MCRuOaj+aEsUG/r
 1rT8VTcEx785tV3e6iL5jDlKI3DLVM+DduecAhfNMKCRzwxlJ8egpO2lbk6I+lN9mj/fsbCwNBs
 2z6zXaom1hUIcixNqWqFV+z7LQTlfzSEig8/kWYdQkw18FPjXDIp0/6Zk6WksMyzupM61AXns/b
 gAosdUL6r8vU3FwbYei4E3fP1JARAvAHrI/sl5f/T6TlXhuyWq0HLDq3aMSXKThTG3KU71pXstT
 jAL/jmKzAW+NZOwOrKnU0MAT1caSsu9j3O0IfaUwuEUVns4jQCGRqwh02gPp73ku5dkbnhlJ
X-Proofpoint-ORIG-GUID: UgCszPUhckweis-Nxah_i71ay2Uu1J1g
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Use IOMMU_IOAS_MAP_FILE when the mapped region is backed by a file.
Such a mapping can be preserved without modification during CPR,
because it depends on the file's address space, which does not change,
rather than on the process's address space, which does change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-container-base.h | 15 +++++++++++++++
 hw/vfio/container-base.c              |  9 +++++++++
 hw/vfio/iommufd.c                     | 13 +++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index f023265..a49ef69 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -167,6 +167,21 @@ struct VFIOIOMMUClass {
                    hwaddr iova, ram_addr_t size,
                    void *vaddr, bool readonly, MemoryRegion *mr);
     /**
+     * @dma_map_file
+     *
+     * Map a file range for the container.
+     *
+     * @bcontainer: #VFIOContainerBase to use for map
+     * @iova: start address to map
+     * @size: size of the range to map
+     * @fd: descriptor of the file to map
+     * @start: starting file offset of the range to map
+     * @readonly: map read only if true
+     */
+    int (*dma_map_file)(const VFIOContainerBase *bcontainer,
+                        hwaddr iova, ram_addr_t size,
+                        int fd, unsigned long start, bool readonly);
+    /**
      * @dma_unmap
      *
      * Unmap an address range from the container.
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index d834bd4..5630497 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -78,7 +78,16 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            void *vaddr, bool readonly, MemoryRegion *mr)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    RAMBlock *rb = mr->ram_block;
+    int mfd = rb ? qemu_ram_get_fd(rb) : -1;
 
+    if (mfd >= 0 && vioc->dma_map_file) {
+        unsigned long start = vaddr - qemu_ram_get_host_addr(rb);
+        unsigned long offset = qemu_ram_get_fd_offset(rb);
+
+        return vioc->dma_map_file(bcontainer, iova, size, mfd, start + offset,
+                                  readonly);
+    }
     g_assert(vioc->dma_map);
     return vioc->dma_map(bcontainer, iova, size, vaddr, readonly, mr);
 }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index d3efef7..962a1e2 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -45,6 +45,18 @@ static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
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
@@ -807,6 +819,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, const void *data)
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
     vioc->dma_map = iommufd_cdev_map;
+    vioc->dma_map_file = iommufd_cdev_map_file;
     vioc->dma_unmap = iommufd_cdev_unmap;
     vioc->attach_device = iommufd_cdev_attach;
     vioc->detach_device = iommufd_cdev_detach;
-- 
1.8.3.1


