Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B07CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzilr-0006AH-5C; Fri, 19 Sep 2025 17:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilp-0006A6-Jk
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzilk-0002WD-E5
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:35:57 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtpfd017687;
 Fri, 19 Sep 2025 21:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=ACc/1
 SWjzzTeIMOGVyVMbhfNDav4wfD0zlbYkdldaJA=; b=jiS4ZJHzW+XQKE2xGuXK5
 Xhx51Ty8MVfPc1w+kxMwV4X42Ui+OgHS3U2p01ni70W+LytkuDpb6bgIMKU5hOT6
 8iVneUwlmVwDCQu06Um3ikEkLOBgHXxdVVfSp7dhBy2ns7Ie2mNmK6jNd+XEuQ+J
 6N0GxaM7sHwCFESSCdWqeh5LwCfiFmmy5LnczwdGsAJyHXShHS5PLb0DmgQz3CLy
 HJH0/3k/WgcJoiLO6ormr4hZFV7UkvvEy6e9khnI5zWvnvrhSQlVeJGl8AT8yoTw
 blOkNMhLbECknDfWl08eZsWPbxRMtUd0HoqjqXQ55nYGiecVt4j2ix7OmJUMdnEW
 Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx9xenq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:41 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JL6GRJ033768; Fri, 19 Sep 2025 21:35:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwrp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:41 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUm0F004301;
 Fri, 19 Sep 2025 21:35:40 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-10; Fri, 19 Sep 2025 21:35:40 +0000
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
Subject: [PATCH v3 09/22] amd_iommu: Add basic structure to support IOMMU
 notifier updates
Date: Fri, 19 Sep 2025 21:35:02 +0000
Message-ID: <20250919213515.917111-10-alejandro.j.jimenez@oracle.com>
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
X-Proofpoint-ORIG-GUID: aRQ_i5j7Qxd-Nfl6rXqoFbKUu1mM5wyJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX7hbmdDDRMdvo
 kb7D/ROh9HMPSb+neyv4d0muvBG9nvHMCEy9ioJNMRfjNsfQGNQnuoeYSc0GiDaNSydPYSaCFJH
 D4wPak0JKa4c6qZcILHw4sRztECn1UoIDH+oACklmTyz7C1OTMuRFX0xVTKpi/AUQmtpSBUt2UX
 yT8aaDz3UGKik8AQv5AwaPe6DRi3/yEl2ddjo7M2gfRCnoAJE4DvP5mDoq/D6/Z3hK7DSYxUJx0
 3w0bUPr4qANycANpbnbQRbjUs/yjxA3jSzMBNTcjmPlAVW19jyTTa/QB5Jkz3afyzFqE5UULPIe
 5KAbrE9rlSbL47UmvTmuG4e6BI5Pbyfvbtgkzxf4crZ9U0MjAIyFvmzl+jG4Jh1HUIOQOB0ozwL
 V5rEOvI4
X-Proofpoint-GUID: aRQ_i5j7Qxd-Nfl6rXqoFbKUu1mM5wyJ
X-Authority-Analysis: v=2.4 cv=C7vpyRP+ c=1 sm=1 tr=0 ts=68cdccae b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=UbPaZh0v1LDklAgaRMEA:9
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add the minimal data structures required to maintain a list of address
spaces (i.e. devices) with registered notifiers, and to update the type of
events that require notifications.
Note that the ability to register for MAP notifications is not available.
It will be unblocked by following changes that enable the synchronization of
guest I/O page tables with host IOMMU state, at which point an amd-iommu
device property will be introduced to control this capability.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 20 ++++++++++++++++++++
 hw/i386/amd_iommu.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 0e45435c77be9..d8a451b3a5ff1 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -66,6 +66,11 @@ struct AMDVIAddressSpace {
     MemoryRegion iommu_nodma;   /* Alias of shared nodma memory region  */
     MemoryRegion iommu_ir;      /* Device's interrupt remapping region  */
     AddressSpace as;            /* device's corresponding address space */
+
+    /* DMA address translation support */
+    IOMMUNotifierFlag notifier_flags;
+    /* entry in list of Address spaces with registered notifiers */
+    QLIST_ENTRY(AMDVIAddressSpace) next;
 };
 
 /* AMDVI cache entry */
@@ -1773,6 +1778,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
         iommu_as[devfn]->bus_num = (uint8_t)bus_num;
         iommu_as[devfn]->devfn = (uint8_t)devfn;
         iommu_as[devfn]->iommu_state = s;
+        iommu_as[devfn]->notifier_flags = IOMMU_NOTIFIER_NONE;
 
         amdvi_dev_as = iommu_as[devfn];
 
@@ -1846,6 +1852,7 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
                                            Error **errp)
 {
     AMDVIAddressSpace *as = container_of(iommu, AMDVIAddressSpace, iommu);
+    AMDVIState *s = as->iommu_state;
 
     if (new & IOMMU_NOTIFIER_MAP) {
         error_setg(errp,
@@ -1854,6 +1861,19 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
                    PCI_FUNC(as->devfn));
         return -EINVAL;
     }
+
+    /*
+     * Update notifier flags for address space and the list of address spaces
+     * with registered notifiers.
+     */
+    as->notifier_flags = new;
+
+    if (old == IOMMU_NOTIFIER_NONE) {
+        QLIST_INSERT_HEAD(&s->amdvi_as_with_notifiers, as, next);
+    } else if (new == IOMMU_NOTIFIER_NONE) {
+        QLIST_REMOVE(as, next);
+    }
+
     return 0;
 }
 
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 9f833b297d25c..b51aa74368995 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -409,6 +409,9 @@ struct AMDVIState {
     /* for each served device */
     AMDVIAddressSpace **address_spaces[PCI_BUS_MAX];
 
+    /* list of address spaces with registered notifiers */
+    QLIST_HEAD(, AMDVIAddressSpace) amdvi_as_with_notifiers;
+
     /* IOTLB */
     GHashTable *iotlb;
 
-- 
2.43.5


