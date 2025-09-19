Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98633CAC5A9
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzimP-0006nF-8J; Fri, 19 Sep 2025 17:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzimM-0006m4-CX
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzim3-0002Xe-A3
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:23 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtoGp006928;
 Fri, 19 Sep 2025 21:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=czmOI
 Vm8IJFxG2aFS86VWQIMHOkpI/UpmZQAu9uwr5Q=; b=rho7QTJlDzHiVYZUIOkLA
 ZFgZxkl52LShIuUal/5fVJmAqrCddNlqzSm4AYWWBfpk2uqax7088owwdgZ64/53
 0W9Mn2uF/K1qEgu2SEK6QUFwFD35oPjnzsGrSB2h8edfeL0TTgb+A3PwAdJ/fJzY
 FfCQCilJNhsFrr9tn0w/ATKVkRLO4QzkCW6Cr185Wj7EAtBtq7Rcbmd8Q9yMoOev
 05qmrTYfqHHbP/k5UZFcxh1UTyF2RB5Cjqiz/lBWtOeRJ3WKoGVQNa6d3478bJ0w
 9fKZiEeya+orgoZN8gOI1lsBJZYB10kp5ahzafWEBU9Pu4/pAW0PqPJGmG7guj4y
 Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxd6bp9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:56 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JJV6UA033739; Fri, 19 Sep 2025 21:35:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwrt0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:55 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUm0T004301;
 Fri, 19 Sep 2025 21:35:54 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-16; Fri, 19 Sep 2025 21:35:54 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, clement.mathieu--drif@eviden.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 Ankit.Soni@amd.com, ethan.milon@eviden.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 15/22] amd_iommu: Toggle memory regions based on address
 translation mode
Date: Fri, 19 Sep 2025 21:35:08 +0000
Message-ID: <20250919213515.917111-16-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
References: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190201
X-Proofpoint-GUID: 6LKN6AcNJQApRn5_5AgmGOfLiBzCK43z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwD/lK4dn8ire
 QrpX55Qod2uNNzP3PioEc+D47NPu4YHiTVBMS/KQCWFNI2RbpfAzyBi6p2ch/wocHYjrc29kE3A
 OCcbn+bjuCn2D31ftBouyqISfCyRLV8MAeUsocER8OpS5/JLS3+nX2Iy/gqVN+4gx9TmjVGt4Au
 Otr5FGW3QDhNnz0rzBVhg28ajBizfKrwcTItMSVFaFL/ziUqlFWAYszDNYLdojaBzV16kM6hhbE
 ErJnpXr5sQrFUYaRF8TOsF4tvk72XlyMpqPf4zYnwCT1WqonaxI4lnQzp4eixxdtVJfWtZSzv+L
 VIsVtlELVdw8o4yh8ex4ppXR2ksTCxMzUKOK3f5F/3Hvx597VZACCGmKsaqLfr9+wIDZNOBWkOr
 g/DXthlz
X-Authority-Analysis: v=2.4 cv=cerSrmDM c=1 sm=1 tr=0 ts=68cdccbc b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=32A6OZY80-M_0kB5mjEA:9
X-Proofpoint-ORIG-GUID: 6LKN6AcNJQApRn5_5AgmGOfLiBzCK43z
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Enable the appropriate memory region for an address space depending on the
address translation mode selected for it. This is currently based on a
generic x86 IOMMU property, and only done during the address space
initialization. Extract the code into a helper and toggle the regions based
on whether the specific address space is using address translation (via the
newly introduced addr_translation field). Later, region activation will also
be controlled by availability of DMA remapping capability (via dma-remap
property to be introduced in follow up changes).

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index d74d42b3dda8e..67a26f524706b 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -74,6 +74,8 @@ struct AMDVIAddressSpace {
     QLIST_ENTRY(AMDVIAddressSpace) next;
     /* Record DMA translation ranges */
     IOVATree *iova_tree;
+    /* DMA address translation active */
+    bool addr_translation;
 };
 
 /* AMDVI cache entry */
@@ -982,6 +984,23 @@ static void amdvi_iommu_address_space_sync_all(AMDVIState *s)
     }
 }
 
+/*
+ * Toggle between address translation and passthrough modes by enabling the
+ * corresponding memory regions.
+ */
+static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
+{
+    if (amdvi_as->addr_translation) {
+        /* Enabling DMA region */
+        memory_region_set_enabled(&amdvi_as->iommu_nodma, false);
+        memory_region_set_enabled(MEMORY_REGION(&amdvi_as->iommu), true);
+    } else {
+        /* Disabling DMA region, using passthrough */
+        memory_region_set_enabled(MEMORY_REGION(&amdvi_as->iommu), false);
+        memory_region_set_enabled(&amdvi_as->iommu_nodma, true);
+    }
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
@@ -2070,6 +2089,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
         iommu_as[devfn]->iommu_state = s;
         iommu_as[devfn]->notifier_flags = IOMMU_NOTIFIER_NONE;
         iommu_as[devfn]->iova_tree = iova_tree_new();
+        iommu_as[devfn]->addr_translation = false;
 
         amdvi_dev_as = iommu_as[devfn];
 
@@ -2112,8 +2132,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
                                             AMDVI_INT_ADDR_FIRST,
                                             &amdvi_dev_as->iommu_ir, 1);
 
-        memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
-        memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu), true);
+        amdvi_switch_address_space(amdvi_dev_as);
     }
     return &iommu_as[devfn]->as;
 }
-- 
2.43.5


