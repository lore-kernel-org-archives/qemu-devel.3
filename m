Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C92C3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVFZ9-00074U-Hg; Sat, 20 Jul 2024 15:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFYv-0006px-O4
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFYj-0000pU-2O
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:05 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KJC5S6024759;
 Sat, 20 Jul 2024 19:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=WWHM+SubOAqNkb6b1haldRvEsQO00N7M97eRzHUiLPc=; b=
 JzOFMrhF7trCRzoi1AFbiTfbosSZZC8d7OX5nUxu6Os7LG4P9+6WAEzSZWHtB+RS
 BQMbINdy41ItCb8QGbXdJUDlTeCdQ0zJMnmJE66Aehe91KUHSCqni01uxQqqVzro
 o0IgEQwQvncTlavjsl9UC3tFdz/Yybgxz5ifN9A0ddDak1XHZMM2Nj1GoiS2rW3t
 nZxRLDjiCUWp2KtTIcqlFp0sFi95Nq/8mTQgttnhLNfacMDFfdVycgcBUXBAwmMt
 r57Aor2ZCxXPlbG3UkUVpnNFv4PzdBxtCZm4+whOCQW72iG9AFJi6N+Q54sNzY2R
 +xMVGQBY8JTzj4W6xRGpbw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gk5jr04c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:43 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46KI0BUH027428; Sat, 20 Jul 2024 19:15:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40g3p5putk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:42 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46KJFdf5028365;
 Sat, 20 Jul 2024 19:15:42 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 40g3p5pusv-3; Sat, 20 Jul 2024 19:15:41 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 02/12] iommufd: no DMA to BARs
Date: Sat, 20 Jul 2024 12:15:27 -0700
Message-Id: <1721502937-87102-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
References: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_16,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200140
X-Proofpoint-GUID: HXuqmKPOJMNoYFbNfgIxL0MGKtfSuRCO
X-Proofpoint-ORIG-GUID: HXuqmKPOJMNoYFbNfgIxL0MGKtfSuRCO
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Do not map VFIO PCI BARs for DMA.  This stops a raft of warnings of the
following form at QEMU start time when using -object iommufd:

qemu-kvm: warning: IOMMU_IOAS_MAP failed: Bad address, PCI BAR?
qemu-kvm: vfio_container_dma_map(0x555558282db0, 0x8800010000, 0x4000, 0x7ffff7ff0000) = -14 (Bad address)

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/common.c      | 3 ++-
 hw/vfio/helpers.c     | 1 +
 include/exec/memory.h | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index da2e0ec..403d45a 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -248,7 +248,8 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
             * are never accessed by the CPU and beyond the address width of
             * some IOMMU hardware.  TODO: VFIO should tell us the IOMMU width.
             */
-           section->offset_within_address_space & (1ULL << 63);
+           section->offset_within_address_space & (1ULL << 63) ||
+           section->mr->no_dma;
 }
 
 /* Called with rcu_read_lock held.  */
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index b14edd4..e4cfdd2 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -435,6 +435,7 @@ int vfio_region_mmap(VFIORegion *region)
                                           memory_region_owner(region->mem),
                                           name, region->mmaps[i].size,
                                           region->mmaps[i].mmap);
+        region->mmaps[i].mem.no_dma = true;
         g_free(name);
         memory_region_add_subregion(region->mem, region->mmaps[i].offset,
                                     &region->mmaps[i].mem);
diff --git a/include/exec/memory.h b/include/exec/memory.h
index ea03ef2..850cc8c 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -794,6 +794,7 @@ struct MemoryRegion {
     bool unmergeable;
     uint8_t dirty_log_mask;
     bool is_iommu;
+    bool no_dma;
     RAMBlock *ram_block;
     Object *owner;
     /* owner as TYPE_DEVICE. Used for re-entrancy checks in MR access hotpath */
-- 
1.8.3.1


