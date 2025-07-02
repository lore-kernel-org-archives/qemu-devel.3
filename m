Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04A8C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5Tz-0003OS-17; Wed, 02 Jul 2025 17:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5Tx-0003NZ-J6
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5Tv-0003et-FD
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:09 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LQes7014128;
 Wed, 2 Jul 2025 21:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=Xh+z0nbS8xSROVDDIpfHjaehlmXWMmCGbceWpSNFiR0=; b=
 hp0KjF0LjbukAdVfHT3oDmdBWy8//H0SkF0h/ijP1xCVnOAorP0vIdECyDTt6GWR
 wBe4w7sALem2Qn0etLolvZS633F3DA8ylIuYNRV+bepY/dcoKClNHBFyOETC4Aj0
 48ksQXDWhBaVzf+P7H6a4IKUhpQ+MiNbkdueSuunKKkxZQBqmmUzdTpndrCuDQCj
 rF//5qWBAhLU3qGWypygin23aS9gaZU1pswFnu1cubJHyoc7G2+4pXhGKKROvW1o
 pBzQciWSWXm+Ch0DxPn/YILj7/+A8593go1lsvJckxcdzwPHGUnZ+DHG/5pmzPS6
 xioVgdjo2kEEj4FExo6peQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704fxkt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:04 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562LZpPD033602; Wed, 2 Jul 2025 21:59:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubtd19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:03 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562Lwxg4020012;
 Wed, 2 Jul 2025 21:59:03 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47j6ubtcxb-6; Wed, 02 Jul 2025 21:59:03 +0000
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
Subject: [PATCH V6 05/21] backends/iommufd: iommufd_backend_map_file_dma
Date: Wed,  2 Jul 2025 14:58:42 -0700
Message-Id: <1751493538-202042-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020182
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE4MiBTYWx0ZWRfX3VA15558d/qT
 cKTYssMU3sCnehrzp/TMkoK056CKDsCKTGZ8scGqzNaQqZAXBfyCW9aF2hwHE+fI8ltZC41qUuY
 JeHeUxU4h1UbVB7Qeob1RaXTJOp+569Eju0wy3gO/1acEqhWV0Rs/wG59V0mZSSEVq1q5vu6hiI
 157K00tBqUIz+rexE1IHhQ/TZsqkTwTfkZIOIq/hq6AowSx5LZXGT+L7z+Uu/E0kl0Lzcl602xF
 yZNAhg7iD0V8HjHzMGA97cH70aQRSeuzmEvbkgkkEYiyTkW2/nCfSqgSLfVJFToG/yrJopKgFgf
 BMMuoldRjEEWKNuFOYWkL98cxn4tgoHjrrduOX1hIVgv1AvvAmgT8MzdbsRB380sDPj8qmXD61v
 miNClvORXQPG7h0AaAS4oPcyHS67vBUw3jKCD5JTkNvTIAqfZ/VQTf6/hcX7NpjRje03m/vW
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=6865aba8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=uB58oH_1KMGY2pLkT90A:9
X-Proofpoint-GUID: ZQywwcirCqkBjWOeq5LkUVWJyw5ryUQh
X-Proofpoint-ORIG-GUID: ZQywwcirCqkBjWOeq5LkUVWJyw5ryUQh
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/system/iommufd.h |  3 +++
 backends/iommufd.c       | 34 ++++++++++++++++++++++++++++++++++
 backends/trace-events    |  1 +
 3 files changed, 38 insertions(+)

diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index 283861b..2d24d93 100644
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
diff --git a/backends/iommufd.c b/backends/iommufd.c
index c2c47ab..3a2ecc7 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -172,6 +172,40 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
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
+        }
+    }
+    return ret;
+}
+
 int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
                               hwaddr iova, ram_addr_t size)
 {
diff --git a/backends/trace-events b/backends/trace-events
index 7278214..e5f3e70 100644
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
-- 
1.8.3.1


