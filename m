Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8493BC5B552
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKiso-0004Jw-2Q; Thu, 29 May 2025 15:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisV-0004FH-T8
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisT-0000RI-Jw
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:23 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfsE5009707;
 Thu, 29 May 2025 19:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=IQTEp6hi6Ni9Cepf9+bpi+V5tvxBXRUb1vnyoqzQ0gY=; b=
 ZGWmLBUdjpjITaGyeRrrfK/HsLY2zhtzg3bNFweE0DZCnUyu36Y8CUqv1/hDq9MZ
 j4NFHsTPCAi9YC3tAYGCUvPB1YbKFzfFSUncdKqJFmMZX78pRB3NNzMNegqgwLcO
 gmx5Se7d1jpCxQtXjAkRL3kd15nmXVlv9xfL0OJGIUaHun67r9iJIa5+Pk/uODRU
 ai9JPxJQCbEwbzpFJ8Xs8lKxz2lJmwGPJrCioZCUsI8WISO3qqQjazI04ynyhYzz
 74Pahyf48c+G6bT7bgqQuZr2G3n8ldISRpGFIo3vax/2W5izUvS9OHFcGyCq2Rq3
 qYv+C1HZ7VGVILXTZamDew==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46u0yva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:07 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54THdf8r020385; Thu, 29 May 2025 19:25:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4w2s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:25:06 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeRn022158;
 Thu, 29 May 2025 19:25:05 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-32; Thu, 29 May 2025 19:25:05 +0000
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
Subject: [PATCH V4 31/43] vfio/iommufd: use IOMMU_IOAS_MAP_FILE
Date: Thu, 29 May 2025 12:24:27 -0700
Message-Id: <1748546679-154091-32-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-GUID: uRWGUCdVIyL6bPkNed_vgxGUIAYTu6H2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX/dh4BkisILUE
 oMYK1mcONxVnXuoHG/bBRGRAe3hpqfIJQlUJ1AyPsfYTGY7VsFEj3Zh9aStYKkQ/1snqIPQ1T7J
 aHQC3QWMbzwF5Qogsk+zkWicVOfKD7HRKbPnH00E1MdEXEzW4y3H2YRYKAEfkQ5ioQdgMPK3FW9
 /H2Setnw2g/4Srvp4r0a8IYRsmnXJFKEeBE6upZhFcyE4leeLJYueDHgr+GrI/m4YnqOrLXnoXu
 0TRjy4kEuZ/WXT/DZAPdC6dA8Je7p5ugQRMyJ4aW4ojn/IUXzFJR7aEp2/Ujv44Lu6w2cyphzn7
 JjlvCHPB7mOfk1vJiGK+UtMC6u3m2qmW5MnST/GWyWzTu+Q0Ksio+llK3NZqVvvEZ/+PzZnPATF
 6719TYH+NJpRgZXGQCuIjpwSx/pPRw6YSerYgi0O7wEwHdjRfAQf6uBai50QmKLuEmO0s/oK
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=6838b493 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=-QcZ205ZjAmYhoUyRx0A:9
X-Proofpoint-ORIG-GUID: uRWGUCdVIyL6bPkNed_vgxGUIAYTu6H2
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-container-base.h | 15 +++++++++++++++
 hw/vfio/container-base.c              |  9 +++++++++
 hw/vfio/iommufd.c                     | 13 +++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index dbbe87d..91ffafc 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -136,6 +136,21 @@ struct VFIOIOMMUClass {
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
index eb2f88d..ca00d08 100644
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
@@ -803,6 +815,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, const void *data)
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
     vioc->dma_map = iommufd_cdev_map;
+    vioc->dma_map_file = iommufd_cdev_map_file;
     vioc->dma_unmap = iommufd_cdev_unmap;
     vioc->attach_device = iommufd_cdev_attach;
     vioc->detach_device = iommufd_cdev_detach;
-- 
1.8.3.1


