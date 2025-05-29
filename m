Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7168CC5B552
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKisK-00049Y-GL; Thu, 29 May 2025 15:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisF-00044V-5A
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKisC-0000Dl-92
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:25:06 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGftnd031416;
 Thu, 29 May 2025 19:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=+svB142r9zV75dduoRqdfA6uAF8G0kSKd5i31Uw3KPQ=; b=
 Nc+IQc7TONUbtVyZrcEXLEK8sGU7AMwPpXpmS3xxobqUj1b812kH72Asr74OfQ42
 VCY6u/VQw9+kMHElh2qfgitg9YzSA1+KUCgnZF30eKidZhKcp4FoHQqfHfBxhsXq
 yavxHI//+khBBpGEGqqDgy7xqFZenyAxccOvRB74sxPI8pK2GgEFp7JwVplAh8oO
 qoNTmUzc2tJn+PoZlUfVkmhC45bD2dztFohsvDruBtHunYw9Mk0HhmLlljWDc4n3
 yDTbDWhMAXBuzEJ1xaPUiqAFzCcNlogwFwEYS5K4h6n/K+KQ5bBi0HD5ycK4ppp1
 Nsiy4bynkEZTSpYwryK/Zg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v33n0yc2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:51 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54THjBKL020311; Thu, 29 May 2025 19:24:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4vr7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:50 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeR9022158;
 Thu, 29 May 2025 19:24:49 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-12; Thu, 29 May 2025 19:24:49 +0000
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
Subject: [PATCH V4 11/43] vfio/container: discard old DMA vaddr
Date: Thu, 29 May 2025 12:24:07 -0700
Message-Id: <1748546679-154091-12-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfX9T93nRqKGyki
 X5qCZ6ClXGOSyStCZYMSw2+Y5HLFv/5QJTAj1KjuT5FliFHDCci+7wFxxaQot53LNU8GM7wm+6J
 q857efHjMPrusOAO+FrYMAgOVfj0AG6zmoK7Hclp/5YZhb1ef8fnbqjm/yWvHNImrB1kNN0nBMC
 sB0UYTpMrz2QdWbUtFa1drPaQ6Ct43hhc/DHbL7ZjlXqj61NJGSjKPtnZ5Vj7HfFBPOFmY5h2yC
 f+EUjxW8zvhRHsUftdZRmGXyR7nAzr1dDEyymDIk+4/8IsfEbaUvhJpK3vPA3Z3B3uvI/No2vZ7
 ZQCQT4iBnuTD03t3Dk07A5sTLHh0Yk1uxi4KGCwX2usYUxgXCxZvEx+XsPcI4PqpJsvEI7cILZh
 /1CcMwedmyQ3HZ/dCXVZ215h0k8nrwAqNQb1Kf3Jrnr91ghFtDHPHtWrzGaCUnJ9oHrepkkW
X-Proofpoint-GUID: BdVTDUEx1B161LGjpb1O7JHaqcv2YKJX
X-Authority-Analysis: v=2.4 cv=aO/wqa9m c=1 sm=1 tr=0 ts=6838b483 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=PtZ4Ye-5RDd9JDMWK00A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BdVTDUEx1B161LGjpb1O7JHaqcv2YKJX
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

In the container pre_save handler, discard the virtual addresses in DMA
mappings with VFIO_DMA_UNMAP_FLAG_VADDR, because guest RAM will be
remapped at a different VA after in new QEMU.  DMA to already-mapped
pages continues.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/cpr-legacy.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 29be64f..cf80332 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -16,6 +16,22 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 
+static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
+{
+    struct vfio_iommu_type1_dma_unmap unmap = {
+        .argsz = sizeof(unmap),
+        .flags = VFIO_DMA_UNMAP_FLAG_VADDR | VFIO_DMA_UNMAP_FLAG_ALL,
+        .iova = 0,
+        .size = 0,
+    };
+    if (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
+        error_setg_errno(errp, errno, "vfio_dma_unmap_vaddr_all");
+        return false;
+    }
+    return true;
+}
+
+
 static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
 {
     if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
@@ -31,10 +47,23 @@ static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
     }
 }
 
+static int vfio_container_pre_save(void *opaque)
+{
+    VFIOContainer *container = opaque;
+    Error *local_err = NULL;
+
+    if (!vfio_dma_unmap_vaddr_all(container, &local_err)) {
+        error_report_err(local_err);
+        return -1;
+    }
+    return 0;
+}
+
 static const VMStateDescription vfio_container_vmstate = {
     .name = "vfio-container",
     .version_id = 0,
     .minimum_version_id = 0,
+    .pre_save = vfio_container_pre_save,
     .needed = cpr_incoming_needed,
     .fields = (VMStateField[]) {
         VMSTATE_END_OF_LIST()
-- 
1.8.3.1


