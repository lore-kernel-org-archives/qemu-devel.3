Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED0AC369B1
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 02:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u49B8-0007Md-20; Sun, 13 Apr 2025 22:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49Aj-0007Dv-Kf
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u49Ah-0007T8-SI
 for qemu-devel@nongnu.org; Sun, 13 Apr 2025 22:03:41 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E17Mqn023470;
 Mon, 14 Apr 2025 02:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=QtWzE
 2qz3k9i1WVNgzsmCHeokzAu03u+0ILqSg4ZPo8=; b=iLuQ0Qt271bDe4/IJBrAm
 lcwpEYnBCZwRHpPvnwbNaZXLYQBGv1bf8SOwSeXtg9LwTfjPYtXHzhHLjsIE8Qn6
 fTKwXlPfF4yeP+zIPg3DW1nqIfC31VpS7WoJBPSoi25L9BYq5gdFZL0u8vb+Clk4
 r6XUE7mNGwAr57ExD+slZ05IWhERuggCrvMRcjd65aPjVeOFd6p1fo7J0wnC4DVI
 5j4jg00YNSPzkFycaHikq38sYt2UojlDZXcqFSMVDGhkTk8oe7W8t+Qd6bByhlAR
 LqLPm7QgpZbSCBS5vVTNYRTMq0LRn6M++C4l4W5E4FdXCGV7FRoQpdvMOc3CANsg
 A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 460rdr01fe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:33 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53DNFDKQ009267; Mon, 14 Apr 2025 02:03:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d3fvqs6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 02:03:32 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53E22tYY035550;
 Mon, 14 Apr 2025 02:03:32 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 460d3fvqg0-7; Mon, 14 Apr 2025 02:03:31 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 06/18] amd_iommu: Set all address spaces to default
 translation mode on reset
Date: Mon, 14 Apr 2025 02:02:41 +0000
Message-ID: <20250414020253.443831-7-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-GUID: qiDQKSgKjHkDdxONWhhxr7C2qTxq8lAJ
X-Proofpoint-ORIG-GUID: qiDQKSgKjHkDdxONWhhxr7C2qTxq8lAJ
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

On reset, restore the default address translation mode for all the
address spaces managed by the vIOMMU.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 3f9aa2cc8d31..0df658712ec0 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1548,6 +1548,33 @@ static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
     }
 }
 
+/*
+ * For all existing address spaces managed by the IOMMU, enable/disable the
+ * corresponding memory regions depending on the address translation mode
+ * as determined by the global and individual address space settings.
+ */
+static void amdvi_switch_address_space_all(AMDVIState *s)
+{
+    AMDVIAddressSpace **iommu_as;
+
+    for (int bus_num = 0; bus_num < PCI_BUS_MAX; bus_num++) {
+
+        /* Nothing to do if there are no devices on the current bus */
+        if (!s->address_spaces[bus_num]) {
+            continue;
+        }
+        iommu_as = s->address_spaces[bus_num];
+
+        for (int devfn = 0; devfn < PCI_DEVFN_MAX; devfn++) {
+
+            if (!iommu_as[devfn]) {
+                continue;
+            }
+            amdvi_switch_address_space(iommu_as[devfn]);
+        }
+    }
+}
+
 static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 {
     char name[128];
@@ -1745,6 +1772,7 @@ static void amdvi_sysbus_reset(DeviceState *dev)
 
     /* Discard all mappings on device reset */
     amdvi_address_space_unmap_all(s);
+    amdvi_switch_address_space_all(s);
 }
 
 static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
-- 
2.43.5


