Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E99FC369B1
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 02:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u49B1-0007Ks-8C; Sun, 13 Apr 2025 22:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49Ag-0007CB-AE
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49Ae-0007Sf-Av
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:37 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E1lMCF003661;
 Mon, 14 Apr 2025 02:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=NhEFJ
 9I/rIk9t87EQSCGCNeGR82gtDLoF1IG1uhZtc8=; b=P24XeFTEpgKcXAr7QgcCl
 kT5lCmnqTfLypIaSkf0IE00evc6XPnWMkwclRkSvbSN/WvzsgO2nfwqXspZEpyq4
 9EIVZn3GP5ymCnw+xMYuQkMC86E1cn+1iqJF+bPRZHn9IRMm6LpvvAaequAw67zd
 kgGrvtilHOJlXuQqs9kdM+hdTT66mswUPIVzybaarHsN6Y5Qp5kFr44QZvauY5NH
 JO5lUlbIHVt6xJSBjvhHmr35g70gBgmmvIniJj0YCp7Dn8T6UNVbLH/ekFQn/C4t
 5vjc6DPZD8wZuB2EVYl67rJkh8l29H3+75r9Maj83+YZLSJSgd+WlddwskgXdOVf
 g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 460s0g00ba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:29 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53DN17F9009292; Mon, 14 Apr 2025 02:03:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d3fvqrn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:28 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53E22tYU035550;
 Mon, 14 Apr 2025 02:03:28 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 460d3fvqg0-5; Mon, 14 Apr 2025 02:03:27 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 04/18] amd_iommu: Unmap all address spaces under the AMD IOMMU
 on reset
Date: Mon, 14 Apr 2025 02:02:39 +0000
Message-ID: <20250414020253.443831-5-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-13_12,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504140014
X-Proofpoint-ORIG-GUID: 6Nftd8HEQsG04MuE-bT0D8eLpqiAykG9
X-Proofpoint-GUID: 6Nftd8HEQsG04MuE-bT0D8eLpqiAykG9
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.266,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Support dropping all existing mappings on reset. When the guest kernel
reboots it will create new ones, but other components that run before
the kernel (e.g. OVMF) should not be able to use existing mappings from
the previous boot.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 8dbb10d91339..ad5869e72fdc 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1109,6 +1109,71 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
     return ret;
 }
 
+/*
+ * Unmap entire range that the notifier registered for i.e. the full AS.
+ *
+ * This is seemingly technically equivalent to directly calling
+ * memory_region_unmap_iommu_notifier_range(), but it allows to check for
+ * notifier boundaries and issue notifications with ranges within those bounds.
+ */
+static void amdvi_address_space_unmap(AMDVIAddressSpace *as, IOMMUNotifier *n)
+{
+
+    hwaddr start = n->start;
+    hwaddr end = n->end;
+    hwaddr remain;
+
+    assert(start <= end);
+    remain = end - start + 1;
+
+    /*
+     * Divide the notifier range into chunks that are aligned and do not exceed
+     * the notifier boundaries.
+     */
+    while (remain >= AMDVI_PAGE_SIZE) {
+
+        IOMMUTLBEvent event;
+
+        uint64_t mask = dma_aligned_pow2_mask(start, end, 64);
+
+        event.type = IOMMU_NOTIFIER_UNMAP;
+
+        IOMMUTLBEntry entry = {
+            .target_as = &address_space_memory,
+            .iova = start,
+            .translated_addr = 0,   /* irrelevant for unmap case */
+            .addr_mask = mask,
+            .perm = IOMMU_NONE,
+        };
+        event.entry = entry;
+
+        /* Call notifier registered for updates on this address space */
+        memory_region_notify_iommu_one(n, &event);
+
+        start += mask + 1;
+        remain -= mask + 1;
+    }
+
+    assert(!remain);
+}
+
+/*
+ * For all the address spaces with notifiers registered, unmap the entire range
+ * the notifier registered for i.e. clear all the address spaces managed by the
+ * IOMMU.
+ */
+static void amdvi_address_space_unmap_all(AMDVIState *s)
+{
+    AMDVIAddressSpace *as;
+    IOMMUNotifier *n;
+
+    QLIST_FOREACH(as, &s->amdvi_as_with_notifiers, next) {
+        IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
+            amdvi_address_space_unmap(as, n);
+        }
+    }
+}
+
 static int amdvi_get_irte(AMDVIState *s, MSIMessage *origin, uint64_t *dte,
                           union irte *irte, uint16_t devid)
 {
@@ -1667,6 +1732,9 @@ static void amdvi_sysbus_reset(DeviceState *dev)
 
     msi_reset(&s->pci.dev);
     amdvi_init(s);
+
+    /* Discard all mappings on device reset */
+    amdvi_address_space_unmap_all(s);
 }
 
 static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
-- 
2.43.5


