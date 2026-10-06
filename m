Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D53CCA5FF5
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2026 00:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDstD-0004wH-Op; Mon, 05 Oct 2026 20:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xDsrg-0003zJ-Ms; Mon, 05 Oct 2026 20:17:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xDsrb-0001Fj-Kh; Mon, 05 Oct 2026 20:17:01 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695Ha7Ek1132014; Tue, 6 Oct 2026 00:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5FaXtDFyu4r7hcCbC
 4sCgN+JQ094mkCQ1XOMQc17SPs=; b=W2iT2o0sSy3E9Rz7FTQFBpuwG8k0Kn7gW
 IouViYysmLzrQwYr7Y1rfn3KQv8wtBe8tsXNkzXA97Udri0MjgOeptRuu2m6Nl5M
 bZK3ym1VlaBQ/VjDW9jMfKTuamUQSAIgzxSOgkAXRQJtkE4l5+B/lNe8ICaUP4gW
 TRsM86gNNZzfwdKKSp//wIuJIeNUkxYX60+WD1EQkkgzEg/byGrkraeO/ng3fZtn
 QHjDzIEeW/pAFKF0c4z3S9JEA1nPSXd35DBoeQM5PUjO6Zvpe8C9sbm7rEhKZsh1
 pBs+YCu2IZj7LzSVqDyHHbxRerRk8WRdFwIDyG+StOtaFJlotBeYA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jmq7q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 00:16:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695LsZgg3252065; Tue, 6 Oct 2026 00:16:55 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqy7gj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 00:16:55 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6960GsWt28836500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 00:16:54 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC8CC58043;
 Tue,  6 Oct 2026 00:16:53 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 186D958053;
 Tue,  6 Oct 2026 00:16:53 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.249.221])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 00:16:52 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v12 06/17] s390x/pci: Remove a ptr to S390PCIBusDevice from
 S390PCIIOMMU
Date: Mon,  5 Oct 2026 19:16:32 -0500
Message-Id: <20261006001643.420929-7-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006001643.420929-1-kshk@linux.ibm.com>
References: <20261006001643.420929-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6ykFEq79QhJd3ubrZfgI0T9yJr3lrYSY
X-Proofpoint-GUID: 6ykFEq79QhJd3ubrZfgI0T9yJr3lrYSY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAwMCBTYWx0ZWRfX0bJp6bKUhHn2
 ZZCgiz9e2g958Pa9XZ4I62G50A1FHCz9U8pYr6+XhjMqpKF3gmJOX/86/Lh9DvkG+okE4yfH6Cx
 e5xHhbmXyKbx3UmhU/4BXgXImnOJnfs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAwMCBTYWx0ZWRfX8prd8qJwldMr
 kgSflPxbzoWIOGPkG+Z64q7WsF7dQSMtklXCzZdNl19Em1QRxJbxCTA3D/ToG3Ckqe2mpA03E0i
 uiZ2y0eVUO7ks9odUCUM8h42A5MtshVfSkKpOn3oq37vWeeAUtLD7UegI8oiTFGZJ/z7mUKAebz
 1N5svUKYG8eAor6m7dCT/mnknUdpmhHHxHKt3RKK7zuHe9tkIypghy7NFX1aK1om+cs7sjDCTX2
 Rcnk4spuG1S3ihjXA4JXnjJ/IWvqm/PNJKwXjbTdGn7Tso991xXK6qyOwzzr64Q1ubMBB/BxzKR
 PqdeMenbe5yWQCrh3qBsiHp4uk8dLJsn770pV4c5bMEMRV2P9wyHFR7k8mCPDsQHkrvM0evi22R
 P+BT+1/Ubjdl56pZi7Iel+YwzYkGUWFhE85NCTsrLnN1a92iupamBm/b4S+Vm8/yBv+LnKNE/pW
 atG9uzcDaemhnlOWIsQ==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac43df8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=yINFAIt2aqTEABBYJGoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060000
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This pointer is no longer used, after fields were moved from S390PCIIOMMU
to S390PCIBusDevice.

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 15 +++++++--------
 include/hw/s390x/s390-pci-bus.h |  1 -
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 850b4452a5..d74d0c4925 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -552,7 +552,7 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
         .perm = IOMMU_NONE,
     };
 
-    switch (iommu->pbdev->state) {
+    switch (pbdev->state) {
     case ZPCI_FS_ENABLED:
     case ZPCI_FS_BLOCKED:
         if (!iommu->enabled) {
@@ -587,9 +587,9 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
     }
 err:
     if (error) {
-        iommu->pbdev->state = ZPCI_FS_ERROR;
-        s390_pci_generate_error_event(error, iommu->pbdev->fh,
-                                      iommu->pbdev->fid, addr, 0);
+        pbdev->state = ZPCI_FS_ERROR;
+        s390_pci_generate_error_event(error, pbdev->fh,
+                                      pbdev->fid, addr, 0);
     }
     return ret;
 }
@@ -790,7 +790,7 @@ void s390_pci_iommu_enable(S390PCIBusDevice *pbdev)
      * so the smallest IOMMU region we can define runs from 0 to the end
      * of the PCI address space.
      */
-    char *name = g_strdup_printf("iommu-s390-%04x", iommu->pbdev->uid);
+    char *name = g_strdup_printf("iommu-s390-%04x", pbdev->uid);
     memory_region_init_iommu(&pbdev->iommu_mr, sizeof(pbdev->iommu_mr),
                              TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
                              name, iommu->pal + 1);
@@ -811,14 +811,14 @@ void s390_pci_iommu_direct_map_enable(S390PCIBusDevice *pbdev)
      * IOVA X + SDMA.  VFIO will handle pinning via its memory listener.
      */
     g_autofree char *name = g_strdup_printf("iommu-dm-s390-%04x",
-                                            iommu->pbdev->uid);
+                                            pbdev->uid);
 
     pbdev->dm_mr = g_malloc0(sizeof(*pbdev->dm_mr));
     memory_region_init_alias(pbdev->dm_mr, OBJECT(&iommu->mr), name,
                              get_system_memory(), 0,
                              s390_get_memory_limit(s390ms));
     iommu->enabled = true;
-    memory_region_add_subregion(&iommu->mr, iommu->pbdev->zpci_fn.sdma,
+    memory_region_add_subregion(&iommu->mr, pbdev->zpci_fn.sdma,
                                 pbdev->dm_mr);
 }
 
@@ -1210,7 +1210,6 @@ static void s390_pcihost_plug(const HotplugHandler *hotplug_dev, DeviceState *de
 
         pbdev->pdev = pdev;
         pbdev->iommu = s390_pci_get_iommu(s, pci_get_bus(pdev), pdev->devfn);
-        pbdev->iommu->pbdev = pbdev;
         pbdev->state = ZPCI_FS_DISABLED;
         set_pbdev_info(pbdev);
 
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 7fbe80be16..d67daeb34d 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -274,7 +274,6 @@ typedef struct S390PCIDMACount {
 
 struct S390PCIIOMMU {
     Object parent_obj;
-    S390PCIBusDevice *pbdev;
     AddressSpace as;
     MemoryRegion mr;
     bool enabled;
-- 
2.34.1


