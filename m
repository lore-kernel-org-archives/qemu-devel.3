Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F48C3ABAD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 02:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfx8-0003wW-V0; Thu, 01 May 2025 22:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfx0-0003sj-5Q
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfwx-0007RA-Ui
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:29 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541KejPE021965;
 Fri, 2 May 2025 02:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=LUm2V
 q/WeHAJjlf5AOVnPlTL4VAxfriyUwKsntIOVVE=; b=rOnknRziHFZXfLuMGILOE
 wU8qIB9Y/KCyyF66mbn/uTGpXJ7NuNiG2wjYFwNZaZwenI/2PiELGLfeQ8DNkR7N
 ARFJbJ7h0pv8444OyLaaKx1TlL0Af8N9C89iKXAGV/S2pUcsaY9nYUGtwzZ1wZ76
 OuUxJ0OU7jfmoSZnqtlRQ2Assj+fc+NQ1MpF8LG5T1VW3zt93FJpSkgeLs6350fr
 ZKpdG6rdRjmhRqbtgrF+H/9e0cKd313a/UoNum6OcTrxqn4IkzdXOyBq5Iv68UB7
 P+r0KmUpuuyERFln3gQV1JVfAQlfS8k1UgwNaMb6x0iYAKpOV75sFtH0qqLZzu2e
 g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uqmdvj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:17 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 541NiQwq023819; Fri, 2 May 2025 02:16:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxkh029-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:15 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5422FEsE011525;
 Fri, 2 May 2025 02:16:15 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 468nxkgyvr-13; Fri, 02 May 2025 02:16:15 +0000
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
Subject: [PATCH v2 12/20] amd_iommu: Unmap all address spaces under the AMD
 IOMMU on reset
Date: Fri,  2 May 2025 02:15:57 +0000
Message-ID: <20250502021605.1795985-13-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-ORIG-GUID: 1ZNi22iJxpsT2G_GwvHp_ohu9Trh0XVe
X-Authority-Analysis: v=2.4 cv=Vq8jA/2n c=1 sm=1 tr=0 ts=68142af1 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=SEEq26f7jwHSYcXadsMA:9 cc=ntf
 awl=host:13130
X-Proofpoint-GUID: 1ZNi22iJxpsT2G_GwvHp_ohu9Trh0XVe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAxNSBTYWx0ZWRfXwI0JmyiHKGYp
 xcLJGVAZHY1bOxR03lQ6IvIxRU5Zm3zlW/S0Rn5HiuZ+eRA1Too2F+2vTaucdTVp1tPg2w/CJch
 4t6BO/6zYfbqAGQ97g9V4ooNc0cb+6DSwRTHWx3+sCwH/b1Lr+/yaxNkI27uYqLeulrhS5YTMtR
 pcdbP/3WBj8eKAIWKV7k62SatIXGiCHXwGI4qDqSt6cuh8ie2ydBt2t6T7L8eG06NUdLP5OW9ze
 nCt3Dt6QqqN6MDLmeRv7AtsDAaY9xEle+Zpa0nOX6cY4PSQyJ8rEusbUoFKiykcTnsfSakslHQH
 baxOmSzhxdma16Ajyt2bzXeYbntCoHLXBVhZpqhXgGpP8byjTfiqYWP4t7mRDiB47G95NZxxmmS
 CmmUPCmTNETMWBuNTXN7ej1Y4o4te4hfEquAK2XDqTcJgSImRqX4MIdtC+EGrhLKFV5hr//3
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Support dropping all existing mappings on reset. When the guest kernel
reboots it will create new ones, but other components that run before
the kernel (e.g. OVMF) should not be able to use existing mappings from
the previous boot.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 74 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 4f44ef159ff9..7bcba47a01ba 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -808,6 +808,77 @@ next:
     }
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
+    DMAMap map;
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
+
+    map.iova = n->start;
+    map.size = n->end - n->start;
+
+    iova_tree_remove(as->iova_tree, map);
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
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
@@ -2043,6 +2114,9 @@ static void amdvi_sysbus_reset(DeviceState *dev)
 
     msi_reset(&s->pci.dev);
     amdvi_init(s);
+
+    /* Discard all mappings on device reset */
+    amdvi_address_space_unmap_all(s);
 }
 
 static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
-- 
2.43.5


