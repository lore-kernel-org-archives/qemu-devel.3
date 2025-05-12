Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E12C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVA5-0005Rz-51; Mon, 12 May 2025 11:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9p-0004pC-Oz
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9l-0006iG-Lo
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:33 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9gUM003877;
 Mon, 12 May 2025 15:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=jjITDnlRw8hcan9JA1uT1MjM0sRa0i3dCqyVL+KoUFw=; b=
 O5QegXKwH17JKGua/C/ONPx/Z8+Ez+LRnghcbYRNdIqQm9g/4sRU3jkbjnAki57J
 jXdneYpdguIRTr9zK7XdZyfHUD2pxnLfyzXlQd2phXP12SAqB4IwhEamYrXUEBFb
 PNDtO2yEVyvsq6SOOB1dI5IxodeRMKVNUcCFAQ6YDgpBXIOfklvLwLQWCunl55jm
 3atQDeyGV5nGTcO0M417eHU35toV1iRNFgQ5VbsFCrP3311oREfKfwJFrS1g0e6P
 c2dbYr4RPOWaD6VTAAy5P7HwFUS1koxY8chVnJ8wbGAJEeYwS4Iop/LeKLeNNx5X
 JJ9nYpjTaYru/SluPjRLsQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0epjsce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:17 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CEEdwq002446; Mon, 12 May 2025 15:33:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366pj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:16 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk5Y030605;
 Mon, 12 May 2025 15:33:15 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-29; Mon, 12 May 2025 15:33:15 +0000
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
Subject: [PATCH V3 28/42] backends/iommufd: iommufd_backend_map_file_dma
Date: Mon, 12 May 2025 08:32:39 -0700
Message-Id: <1747063973-124548-29-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX/cdwOiZ5Qy2l
 Sv6Pu95KSIYNLL9g/TE/kCgUEsWVcCGt5EZh6ALVuNkI4Ozmm1PF7wnd+/Y/D5B/Gq4IXaYYOp6
 WWNTVDQPUb7vU/fN+Z31bpOJeCVCDKTWKHvJ3FsPxabgfLgMgDrBLySYbBOkyylZj50W0g0ye3x
 PUNwhAmqyaG6alBcHCwK3ooC/QqB3ZHzCWPYL0Nd064E5L+ATGj1T2I/1IfizVc7/mbpGB8nmaC
 CFQAAueSxU67yOYnJrcvR1yK39jihmNtuGPb2+Se4XjZ95Zl7h6717uuEyxFq2W/MnrhGAgHxc3
 X1Ey65UMqUdjk5lJX8Z3WQbYmLZHA1UVlLX915qTO6pRJhrcw9CEMx9BS8tc4eGeb0sHaraUi5n
 atM0DWuGm42BHAnFCoyjYCvfH2BZ0yvax7SLSalXsxNs8iTeczrKK0IKfmhK7ttNQ9YqTTNm
X-Authority-Analysis: v=2.4 cv=DO6P4zNb c=1 sm=1 tr=0 ts=682214bd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=uB58oH_1KMGY2pLkT90A:9
X-Proofpoint-ORIG-GUID: NfOww3-_YNfbpt8q5Vk-uw2jGfb6L7ta
X-Proofpoint-GUID: NfOww3-_YNfbpt8q5Vk-uw2jGfb6L7ta
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

Define iommufd_backend_map_file_dma to implement IOMMU_IOAS_MAP_FILE.
This will be called as a substitute for iommufd_backend_map_dma, so
the error conditions for BARs are copied as-is from that function.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 backends/iommufd.c       | 36 ++++++++++++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 include/system/iommufd.h |  3 +++
 3 files changed, 40 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index b73f75c..5c1958f 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -172,6 +172,42 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
     return ret;
 }
 
+int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
+                                 hwaddr iova, ram_addr_t size,
+                                 int mfd, unsigned long start, bool readonly)
+{
+    int ret, fd = be->fd;
+    struct iommu_ioas_map_file map = {
+        .size = sizeof(map),
+        .flags = IOMMU_IOAS_MAP_READABLE |
+                 IOMMU_IOAS_MAP_FIXED_IOVA,
+        .ioas_id = ioas_id,
+        .fd = mfd,
+        .start = start,
+        .iova = iova,
+        .length = size,
+    };
+
+    if (!readonly) {
+        map.flags |= IOMMU_IOAS_MAP_WRITEABLE;
+    }
+
+    ret = ioctl(fd, IOMMU_IOAS_MAP_FILE, &map);
+    trace_iommufd_backend_map_file_dma(fd, ioas_id, iova, size, mfd, start,
+                                       readonly, ret);
+    if (ret) {
+        ret = -errno;
+
+        /* TODO: Not support mapping hardware PCI BAR region for now. */
+        if (errno == EFAULT) {
+            warn_report("IOMMU_IOAS_MAP_FILE failed: %m, PCI BAR?");
+        } else {
+            error_report("IOMMU_IOAS_MAP_FILE failed: %m");
+        }
+    }
+    return ret;
+}
+
 int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
                               hwaddr iova, ram_addr_t size)
 {
diff --git a/backends/trace-events b/backends/trace-events
index 40811a3..f478e18 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -11,6 +11,7 @@ iommufd_backend_connect(int fd, bool owned, uint32_t users) "fd=%d owned=%d user
 iommufd_backend_disconnect(int fd, uint32_t users) "fd=%d users=%d"
 iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
 iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, void *vaddr, bool readonly, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" addr=%p readonly=%d (%d)"
+iommufd_backend_map_file_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int fd, unsigned long start, bool readonly, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" fd=%d start=%ld readonly=%d (%d)"
 iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
 iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index cbab75b..ac700b8 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -43,6 +43,9 @@ void iommufd_backend_disconnect(IOMMUFDBackend *be);
 bool iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
                                 Error **errp);
 void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id);
+int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
+                                 hwaddr iova, ram_addr_t size, int fd,
+                                 unsigned long start, bool readonly);
 int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly);
 int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
-- 
1.8.3.1


