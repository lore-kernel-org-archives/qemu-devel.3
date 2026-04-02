Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6221112276
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 02:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w87pF-0004YB-OV; Wed, 01 Apr 2026 22:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1w87or-0004Ds-HJ; Wed, 01 Apr 2026 22:30:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1w87op-0001mg-Q7; Wed, 01 Apr 2026 22:30:05 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631IfKqc3065805; Thu, 2 Apr 2026 02:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=9O2dwSdCOQfpP/HIU
 7CH820qFNISS0WlI/zjHFURx38=; b=iXmb37Wg4K1XvBZUMspqDFyTQo/SZHUUz
 9jeVTidFCCxYaW4Ye9lWbhL1JfKTJeSMr2enzfH73HGHeA57ayccpU6s7OaBIb+J
 H7DAncXyjZDI4gfZ0oLxH/LXHh/NbGYGuKcFjh320ZCIx2qumEW5Iyfm6rCcFbaT
 VLGMeMgrULxNP4fSNUbMcQncVPTfbWA1mEppoM0c91hDL1xU6m6Es2iYYX65SW7X
 gZVh52ZQcAdkk0Kaj/x+bHhRenHZNHgqNGQZ/U8os/9PJWc2zK53dm2SnzDGh8bp
 YO7hWRruxE6BxuoajlWLSRe29f6B9JRhu9Hx7fKTv7A+wjPPpVRAg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcj6d4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 02:29:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6321EPoh013922;
 Thu, 2 Apr 2026 02:29:59 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkr8eb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 02:29:59 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6322TvV256623598
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2026 02:29:57 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88EC5580F4;
 Thu,  2 Apr 2026 02:29:57 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01B3A580F6;
 Thu,  2 Apr 2026 02:29:57 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.247.119])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2026 02:29:56 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH 09/15] s390x/pci: Move g_iota from S390PCIIOMMU to
 S390PCIBusDevice
Date: Wed,  1 Apr 2026 21:29:15 -0500
Message-Id: <20260402022921.298818-10-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402022921.298818-1-kshk@linux.ibm.com>
References: <20260402022921.298818-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cdd4a7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=FDQAEqGjsTQLeQouP1gA:9
X-Proofpoint-GUID: Lo5hnMoeq4bZtqKhzvWkS5Ll7SYtyEoi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAxOSBTYWx0ZWRfX27ZhpbLpY2ql
 uGpZlh/yFmmlNeYBxij7VaRCSV7XZ+3/LeC9B0tCaMycZtTa/ZLWP9Uu58MlL+t0FfMGk1eiCGR
 BnbCUeSzoDztxJN8PdN9Y4mfhU47nX6XsvVpCeCvx3okECXqlykPRKkCa21NJ50fZkhstGT6mND
 7Q8EX6H7HnkzfIWL6ppSIr79DUAGNyOIUMkxUQmGD3+T8aZKi2ThpcUCYS27OQjacTyu5RZQdnK
 rcizL1QPj123Kb93w3rlOP0x+HWOGZTf6Ajnt84v8nMiXUIL6XmWeTWVzI3hVYxOdF3wgytQyiK
 SAMgfrxLqxvot0MeBAN6S5SCQUGEujJBRv5HRO6UkrGwPP0QPTsJXw1UgYCHA8lD7YnpjFeg8VL
 J2LRG3DngRZsnZbB0CTCL0GY5saH9FlRmE5AnvcopZT8fVapx4MoeSgstbBI/wbB9f/l6qFj/Dh
 Qarsc26jXMxDLsnixDw==
X-Proofpoint-ORIG-GUID: Lo5hnMoeq4bZtqKhzvWkS5Ll7SYtyEoi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_05,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020019
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

This field is only used when S390PCIBusDevice exists, so it can be moved
there to simplify S390PCIIOMMU which purpose is just to store the "root"
AddressSpace.

This also allows to save/restore this field during migration.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         |  2 +-
 hw/s390x/s390-pci-inst.c        | 10 +++++-----
 include/hw/s390x/s390-pci-bus.h |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 4a0b31b98b..b784196c9e 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -616,7 +616,7 @@ static void s390_pci_ioat_replay(S390PCIBusDevice *pbdev)
     }
 
     while (curr < end) {
-        error = s390_guest_io_table_walk(iommu->g_iota, curr, &entry);
+        error = s390_guest_io_table_walk(pbdev->g_iota, curr, &entry);
         if (error) {
             error_report("Failure to walk table during iommu remap");
             return;
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index ac4e7f412d..f4ec299614 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -748,7 +748,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     } else {
         dma_avail = 1;
     }
-    if (!iommu->g_iota) {
+    if (!pbdev->g_iota) {
         error = ERR_EVENT_INVALAS;
         goto err;
     }
@@ -762,7 +762,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
     start = sstart;
     again = false;
     while (start < end) {
-        error = s390_guest_io_table_walk(iommu->g_iota, start, &entry);
+        error = s390_guest_io_table_walk(pbdev->g_iota, start, &entry);
         if (error) {
             break;
         }
@@ -1028,7 +1028,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
 
     iommu->pba = pba;
     iommu->pal = pal;
-    iommu->g_iota = g_iota;
+    pbdev->g_iota = g_iota;
 
     if (t) {
         s390_pci_iommu_enable(pbdev);
@@ -1045,7 +1045,7 @@ void pci_dereg_ioat(S390PCIBusDevice *pbdev)
     s390_pci_iommu_disable(pbdev);
     iommu->pba = 0;
     iommu->pal = 0;
-    iommu->g_iota = 0;
+    pbdev->g_iota = 0;
 }
 
 void fmb_timer_free(S390PCIBusDevice *pbdev)
@@ -1418,7 +1418,7 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
 
     stq_be_p(&fib.pba, pbdev->iommu->pba);
     stq_be_p(&fib.pal, pbdev->iommu->pal);
-    stq_be_p(&fib.iota, pbdev->iommu->g_iota);
+    stq_be_p(&fib.iota, pbdev->g_iota);
     stq_be_p(&fib.aibv, pbdev->routes.adapter.ind_addr);
     stq_be_p(&fib.aisb, pbdev->routes.adapter.summary_addr);
     stq_be_p(&fib.fmb_addr, pbdev->fmb_addr);
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 126a50c98b..a7d1f1ade2 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -275,7 +275,6 @@ struct S390PCIIOMMU {
     Object parent_obj;
     AddressSpace as;
     MemoryRegion mr;
-    uint64_t g_iota;
     uint64_t pba;
     uint64_t pal;
     uint64_t max_dma_limit;
@@ -352,6 +351,7 @@ struct S390PCIBusDevice {
     IOMMUMemoryRegion iommu_mr;
     MemoryRegion *dm_mr;
     GHashTable *iotlb;
+    uint64_t g_iota;
     S390PCIDMACount *dma_limit;
     MemoryRegion msix_notify_mr;
     IndAddr *summary_ind;
-- 
2.34.1


