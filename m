Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093C5C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 02:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfxG-0003yv-2t; Thu, 01 May 2025 22:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfx6-0003vh-IS
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfx4-0007S0-KI
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:36 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541KeNeO007190;
 Fri, 2 May 2025 02:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=iSvFX
 rUnt5BCwNv+F15tyBfxMqFxabRuC6gv3QXwBhU=; b=g3jw3JpOo3xWkb9rec916
 9BxSNzM66Vw3JdZQ0EdycuNK0LD3X47ViQTl6GfRL7gxY9EcinA2fBIBJAz/rlGh
 PmIhHXw9y9amKEOVu8gadRhiUTUdK+MgYa1d0k2+DI2zFsltDgsJlTyV2X1NgXMx
 dDQuEMQ5TG+wJj62lwEoadv60o8EZ6sLS6o8bhJFuNFm79ff86vcKtWWkzJTJvDB
 vsCpNSXu/VHIWLRGxIBWFH0amGx05FZl2cTIOLbK9I5Jfs6tZQuj3vCQbFV6oJFe
 qCjqH9pi1g2yAIKUrc11f937IN9+gG4qVGN/WlWoMDdLyaf0NdLrHd8r2bij/gWW
 w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ucmdva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:25 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5420LMUG023762; Fri, 2 May 2025 02:16:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxkh00j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:13 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5422FEs6011525;
 Fri, 2 May 2025 02:16:12 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 468nxkgyvr-9; Fri, 02 May 2025 02:16:12 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 clement.mathieu--drif@eviden.com, ethan.milon@eviden.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH v2 08/20] amd_iommu: Add a page walker to sync shadow page
 tables on invalidation
Date: Fri,  2 May 2025 02:15:53 +0000
Message-ID: <20250502021605.1795985-9-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020015
X-Authority-Analysis: v=2.4 cv=ZsHtK87G c=1 sm=1 tr=0 ts=68142af9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=mMwD0hUo444mCu11VDkA:9 cc=ntf
 awl=host:13130
X-Proofpoint-ORIG-GUID: W9cZ4tkJS2s6JC0ZQJRnxjc_t8wb6hsU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAxNiBTYWx0ZWRfX7aCRQnMKiUM4
 7zqSNovpoaFqVnJVHQ/2Q3nfbzXTvFYEzawaH6atTLYGr6WVqd771qxbCqaEdPrVyGX89gweAv6
 wPANWb6gy6n58hW4ASL5ZTzpocWTLjt04WL4NXLhv21QKmp7T5ePClJ3+8y8TONJEYiRyCRO/gv
 z2ehReF4mKjV/Ge9jCsG5iMDenqHbPbx2H4rMh2JwhReb41brai/ostzjWuLUmBF8P4PuYsr26X
 muL29jy8EIbovWmAhdz8i9rd106qaBIF9C/lNKmXb7msm+Rwxatw4EsWbO/uudamrCG6lkFm3+F
 UC4f/keGwfeBg1op/mRxkf3v9CcMyAPNah/Nbm9cMRpX0jKkeNDywUXOjFxriWtzWnPHxDOT7Gi
 7qOJOgu62L0B77sba0i2TAbyWKPD/fyUHAKCIDZMePzXMtq4nVxQmcfyuzweq2kvt+I+ZrrP
X-Proofpoint-GUID: W9cZ4tkJS2s6JC0ZQJRnxjc_t8wb6hsU
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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

For the specified address range, walk the page table identifying regions
as mapped or unmapped and invoke registered notifiers with the
corresponding event type.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 75 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 44bf8ebe303e..6a2ba878dfa7 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -649,6 +649,81 @@ fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte, uint64_t *pte,
     return 0;
 }
 
+/*
+ * Walk the guest page table for an IOVA and range and signal the registered
+ * notifiers to sync the shadow page tables in the host.
+ * Must be called with a valid DTE for DMA remapping i.e. V=1,TV=1
+ */
+static void __attribute__((unused))
+amdvi_sync_shadow_page_table_range(AMDVIAddressSpace *as, uint64_t *dte,
+                                   hwaddr addr, uint64_t size, bool send_unmap)
+{
+    IOMMUTLBEvent event;
+
+    hwaddr iova_next, page_mask, pagesize;
+    hwaddr iova = addr;
+    hwaddr end = iova + size - 1;
+
+    uint64_t pte;
+    int ret;
+
+    while (iova < end) {
+
+        ret = fetch_pte(as, iova, dte[0], &pte, &pagesize);
+
+        if (ret == -AMDVI_FR_PT_ROOT_INV) {
+            /*
+             * Invalid conditions such as the IOVA being larger than supported
+             * by current page table mode as configured in the DTE, or a failure
+             * to fetch the Page Table from the Page Table Root Pointer in DTE.
+             */
+            assert(pagesize == 0);
+            return;
+        }
+        /* PTE has been validated for major errors and pagesize is set */
+        assert(pagesize);
+        page_mask = ~(pagesize - 1);
+        iova_next = (iova & page_mask) + pagesize;
+
+        if (ret == -AMDVI_FR_PT_ENTRY_INV) {
+            /*
+             * Failure to read PTE from memory, the pagesize matches the current
+             * level. Unable to determine the region type, so a safe strategy is
+             * to skip the range and continue the page walk.
+             */
+            goto next;
+        }
+
+        event.entry.target_as = &address_space_memory;
+        event.entry.iova = iova & page_mask;
+        /* translated_addr is irrelevant for the unmap case */
+        event.entry.translated_addr = (pte & AMDVI_DEV_PT_ROOT_MASK) &
+                                      page_mask;
+        event.entry.addr_mask = ~page_mask;
+        event.entry.perm = amdvi_get_perms(pte);
+
+        /*
+         * In cases where the leaf PTE is not found, or it has invalid
+         * permissions, an UNMAP type notification is sent, but only if the
+         * caller requested it.
+         */
+        if (!IOMMU_PTE_PRESENT(pte) || (event.entry.perm == IOMMU_NONE)) {
+            if (!send_unmap) {
+                goto next;
+            }
+            event.type = IOMMU_NOTIFIER_UNMAP;
+        } else {
+            event.type = IOMMU_NOTIFIER_MAP;
+        }
+
+        /* Invoke the notifiers registered for this address space */
+        memory_region_notify_iommu(&as->iommu, 0, event);
+
+next:
+        iova = iova_next;
+    }
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
-- 
2.43.5


