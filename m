Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9905C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 02:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfxO-00040Z-1M; Thu, 01 May 2025 22:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfxH-0003za-A8
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfxE-0007Tf-WF
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:46 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541KeO6x021387;
 Fri, 2 May 2025 02:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=sq8N1
 tmEBnuc89ZXF5x+NX622u3iMOAM+l0QQHjgKUo=; b=fZsXWxEcdCJVQ891Ah/tZ
 Edcq1ZuoTL4yTFsYSi8JpkvEE+PrK2i/Iyo5LHaKnxDtdv477kU8htjiNjcyt1FU
 T9q8lRP2DlHfvNSWq5KI4seqwgopBlWA+b16MtFRu6hAyXdDHSbhgyOGTU9PtT8y
 gGoWyGp+NHbWt57EVyadxTkPQs9OcUXxnnPErg26/5aIK8euLEoqzUhKE/a+2Vcb
 SuBvGNJt75Isa2OGcoOS42nlvG3+IDvkLfzS0gNmddMrvnDHjPtAcuPZfEwrhh0H
 Xv1nOlnNV8UyJ1zu+rKqtlUNpjLcVk5Fye1MZW1zRB1WgmmPh1B1w2qobpJ3APKI
 w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uqmdvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:33 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5421iK55023812; Fri, 2 May 2025 02:16:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxkh02w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:17 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5422FEsI011525;
 Fri, 2 May 2025 02:16:16 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 468nxkgyvr-15; Fri, 02 May 2025 02:16:16 +0000
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
Subject: [PATCH v2 14/20] amd_iommu: Invalidate address translations on
 INVALIDATE_IOMMU_ALL
Date: Fri,  2 May 2025 02:15:59 +0000
Message-ID: <20250502021605.1795985-15-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-ORIG-GUID: e2Fyv8c8poE28u6Rg0qoX9EbvMjU7SW7
X-Authority-Analysis: v=2.4 cv=Vq8jA/2n c=1 sm=1 tr=0 ts=68142b01 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=_2-mevsZ5CH5rBQasQwA:9 cc=ntf
 awl=host:13130
X-Proofpoint-GUID: e2Fyv8c8poE28u6Rg0qoX9EbvMjU7SW7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAxNiBTYWx0ZWRfX+XqNIvohc4Sm
 0Yg8i42/HK/HUwW1Iki4hZm99pruGiECgaYn/YyHUOTa5NcbMkrXur3bpp7+F3N3Jto+C9wfSKN
 9BvYyQDsIOWL6X0KDKro4YMWhLxy2XrdinzgmWltkFQfSfJ1vAEFKy+o5gi4ybDmGN/Je/yZY7G
 6zd9bOQa+Esn/eApg+nf9YEECrPpDPFO0TRC4SifQGe60ptLEFHG95/FJCg9iAliwYffdHKM1l1
 ku1JLm6r+oAKFuX64qdhBCtRo0wRRvALW4On/nORNlnC54JjLU++lY87D5ANRR9OjI9d92/PvX2
 wS1GniHFBOeqADdARfpvnos2l1HdMxQHtPNhcVwWfrx1G1Lp5hOfZg0BQQgFP84xuMv97M3Cdw0
 Bdh1jwRWLagARTSn9WpAoy5ewFsLgnYaJk5qEMsh0g6TK8rhwRz6WLf0l+5Xi7KmVACLEZLh
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

When the kernel IOMMU driver issues an INVALIDATE_IOMMU_ALL, the address
translation and interrupt remapping information must be cleared for all
Device IDs and all domains. Introduce a helper to sync the shadow page table
for all the address spaces with registered notifiers, which replays both MAP
and UNMAP events.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 5ce74f2c052d..fa5dbc3cc700 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -902,6 +902,47 @@ static void amdvi_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
     amdvi_sync_shadow_page_table_range(as, &dte[0], 0, UINT64_MAX, false);
 }
 
+static void amdvi_address_space_sync(AMDVIAddressSpace *as)
+{
+    IOMMUNotifier *n;
+    uint64_t dte[4] = { 0 };
+
+    /* If only UNMAP notifiers are registered, drop all existing mappings */
+    if (!(as->notifier_flags & IOMMU_NOTIFIER_MAP)) {
+        IOMMU_NOTIFIER_FOREACH(n, &as->iommu) {
+            /*
+             * Directly calling memory_region_unmap_iommu_notifier_range() does
+             * not guarantee that the addr_mask eventually passed as parameter
+             * to the notifier is valid. Use amdvi_address_space_unmap() which
+             * ensures the notifier range is divided into properly aligned
+             * regions, and issues notifications for each one.
+             */
+            amdvi_address_space_unmap(as, n);
+        }
+        return;
+    }
+
+    if (amdvi_as_to_dte(as, dte)) {
+        return;
+    }
+
+    amdvi_sync_shadow_page_table_range(as, &dte[0], 0, UINT64_MAX, true);
+}
+
+/*
+ * This differs from the replay() method in that it issues both MAP and UNMAP
+ * notifications since it is called after global invalidation events in order to
+ * re-sync all address spaces.
+ */
+static void amdvi_iommu_address_space_sync_all(AMDVIState *s)
+{
+    AMDVIAddressSpace *as;
+
+    QLIST_FOREACH(as, &s->amdvi_as_with_notifiers, next) {
+        amdvi_address_space_sync(as);
+    }
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
@@ -944,6 +985,13 @@ static void amdvi_inval_all(AMDVIState *s, uint64_t *cmd)
     amdvi_intremap_inval_notify_all(s, true, 0, 0);
 
     amdvi_iotlb_reset(s);
+
+    /*
+     * Fully replay the address space i.e. send both UNMAP and MAP events in
+     * order to synchronize guest and host IO page tables tables.
+     */
+    amdvi_iommu_address_space_sync_all(s);
+
     trace_amdvi_all_inval();
 }
 
-- 
2.43.5


