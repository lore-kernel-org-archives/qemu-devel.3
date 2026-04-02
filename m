Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45796111227A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 02:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w87pD-0004UJ-Vy; Wed, 01 Apr 2026 22:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1w87op-0004DH-Hk; Wed, 01 Apr 2026 22:30:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1w87on-0001kq-Kd; Wed, 01 Apr 2026 22:30:03 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631KC0Nu4107161; Thu, 2 Apr 2026 02:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=W0304v40uMg9cvp2E
 1tL4dSTvNqIXAhMIqxF4i8Fq+s=; b=I5G5G6CFG+y+L1WNlTnzq4oJ2d7Wa3fIr
 +YFtHyMefA0k1U4HbL37FrFf6ipzI83Ltr/MnAIiXRuQ5+hJh3hK/g9ppODgHMQW
 vpUoFZSBvAanzqBOPP1TjBV7N3LrcigxwApBo99Ie9CHX14I+8BwQbe9C0W4TaIk
 YzH+NLVL1OWXXXJAstHRJOnlrtexZrr702qIwXfmHIkgPFiKS3cS7DBu4YWv3iOB
 A7lsSp0Q7hEm6S7L6mmcV5D3SmpK6yOHiEG9iRgR79GE7AcvQB234Zz+1A1xqDun
 HYhw4FAuTgyjC7BWXT7yUv48yZjwdKDY4jnawbG77f1vljmKwGSLA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dgtajr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 02:29:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6321ea0c030955;
 Thu, 2 Apr 2026 02:29:57 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhk05hw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 02:29:57 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6322TtYY32309768
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2026 02:29:55 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DF73580F4;
 Thu,  2 Apr 2026 02:29:55 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 152A6580F6;
 Thu,  2 Apr 2026 02:29:55 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.247.119])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2026 02:29:55 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH 06/15] s390x/pci: Remove a ptr to S390PCIBusDevice from
 S390PCIIOMMU
Date: Wed,  1 Apr 2026 21:29:12 -0500
Message-Id: <20260402022921.298818-7-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402022921.298818-1-kshk@linux.ibm.com>
References: <20260402022921.298818-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAxOSBTYWx0ZWRfX4xuM1kw4TAcw
 U45OiW1g4Zlxe6nMetJhxQLdrLyLKb29lKMPWC98mY8WCYYy+vA18g5O7TKJxGitNl0JAGAIWHR
 7ok4daBTwY2S4Q2//RmXQcotHblI8prfT0rdiJ11EIROwjyHysW9Cf3JcPX71o5O/+3oC3gG4Ut
 k9a2t2kHM8merzj6pWPtyJRsL17i10HGvS39HbPBdiJgrjSBu1Lsl6+kpDRpJn2ktE+O6STakO+
 FdHvICFxYgvOzdPw+sGen2LRlG2cvvOtUPv927KYgDLmQwYRHHq/SGVIcoQw6GDn3gZerkCQQ0F
 WH+4Pn1lXjgdSOvefaJkvyAsPJ3uJPAEl4sdQFfJdcuoiWcZCXnylfrIbnaZh6JZwYSM04s0PIn
 L1lqjSWn/YlPl3r73uID0BpeFbzsqc7R+U1oJIN34CXSRoSvBWZlTLmUvQkEnPdyNgTolrpI/jC
 35Z1y+dYnZDl9qNjilw==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cdd4a6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=yINFAIt2aqTEABBYJGoA:9
X-Proofpoint-GUID: 4OsIh1I2fb5h98jDnNJMo0WeibUnNbMd
X-Proofpoint-ORIG-GUID: 4OsIh1I2fb5h98jDnNJMo0WeibUnNbMd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_05,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1011
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020019
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         | 15 +++++++--------
 include/hw/s390x/s390-pci-bus.h |  1 -
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 3f3123e62a..83e9ca99f3 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -551,7 +551,7 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
         .perm = IOMMU_NONE,
     };
 
-    switch (iommu->pbdev->state) {
+    switch (pbdev->state) {
     case ZPCI_FS_ENABLED:
     case ZPCI_FS_BLOCKED:
         if (!iommu->enabled) {
@@ -586,9 +586,9 @@ static IOMMUTLBEntry s390_translate_iommu(IOMMUMemoryRegion *mr, hwaddr addr,
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
@@ -767,7 +767,7 @@ void s390_pci_iommu_enable(S390PCIBusDevice *pbdev)
      * so the smallest IOMMU region we can define runs from 0 to the end
      * of the PCI address space.
      */
-    char *name = g_strdup_printf("iommu-s390-%04x", iommu->pbdev->uid);
+    char *name = g_strdup_printf("iommu-s390-%04x", pbdev->uid);
     memory_region_init_iommu(&pbdev->iommu_mr, sizeof(pbdev->iommu_mr),
                              TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
                              name, iommu->pal + 1);
@@ -788,14 +788,14 @@ void s390_pci_iommu_direct_map_enable(S390PCIBusDevice *pbdev)
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
 
@@ -1187,7 +1187,6 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
         pbdev->pdev = pdev;
         pbdev->iommu = s390_pci_get_iommu(s, pci_get_bus(pdev), pdev->devfn);
-        pbdev->iommu->pbdev = pbdev;
         pbdev->state = ZPCI_FS_DISABLED;
         set_pbdev_info(pbdev);
 
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index d9bafd6859..fcaaf19512 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -273,7 +273,6 @@ typedef struct S390PCIDMACount {
 
 struct S390PCIIOMMU {
     Object parent_obj;
-    S390PCIBusDevice *pbdev;
     AddressSpace as;
     MemoryRegion mr;
     bool enabled;
-- 
2.34.1


