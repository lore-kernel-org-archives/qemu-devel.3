Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF6ACCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ywf-0003QV-LE; Wed, 01 Oct 2025 11:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1v3ywV-0003NK-NQ; Wed, 01 Oct 2025 11:40:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1v3ywI-0007Zt-US; Wed, 01 Oct 2025 11:40:34 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591F7MYW020525;
 Wed, 1 Oct 2025 15:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=z9Un1s6m4Mvu0bPYYaSfMhmYHBTg9RLCwlTgHDwgU
 Ko=; b=Vppt2qwBAKg1ZUvsaCdFOeUmJn5sOfWg8STIJrkxuGHj2y/U5tBUtGsTY
 bE9HAb1THLEYH2RBNwJ8nOf/2ioFrYMucAAbnVFyEGvCOoX2WCL04ZwvNW6yu9NI
 8LEKp18B+GfZ41DZowN1WhUe9F8UzUIefgL21qnIj5EiM1iCe6SQ3nP45XSVtzBt
 pyQWR4Imj5wuAidYHI4tI8vw7JYkIVRju1njDwVRPVkYBKHgS1fTpEzH65chzM97
 vh53E9bt6EIuJLRjctEOP3JmLwb/K2Hsr0A4GKFN1yLBpsJEGttdK6VP9bTEL9th
 mx1uEQEwP8g2MKdEs3mnUdPPPk4Iw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7jwqebs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Oct 2025 15:40:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 591D74Cl026752;
 Wed, 1 Oct 2025 15:40:07 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eu8n1hk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Oct 2025 15:40:07 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 591Fe6DX51183978
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Oct 2025 15:40:06 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2C6458052;
 Wed,  1 Oct 2025 15:40:05 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4E6058069;
 Wed,  1 Oct 2025 15:40:05 +0000 (GMT)
Received: from IBM-GLTZVH3.austin.ibm.com (unknown [9.24.20.98])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Oct 2025 15:40:05 +0000 (GMT)
From: Jaehoon Kim <jhkim@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 Jaehoon Kim <jhkim@linux.ibm.com>
Subject: [PATCH v1] s390x/pci: fix interrupt blocking by returning only the
 device's summary bit
Date: Wed,  1 Oct 2025 10:39:38 -0500
Message-ID: <20251001154004.71917-1-jhkim@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfXwpzYyoRWk1OE
 PVXi5SiZ0/SbLfIXPeoxbk0EMVQT0oRGogpSIVRnQdBdo+E4lXmXXiNaIMSvdXePQ2/dkFafLNo
 wbRN3/tl9HrwRThFm+m3xj7yhOBf/KseF72bhyk5n5U6rILGRFdMCJORpecO9KDxG2MN3+vczKB
 Ec6Bs4B/v7mSGiaKK2qzdKIYgOzQThE8jL4ERLT7VoY5S+nL+EsjHC2BeqC1qlBzMT0BRlQHxXI
 4KTF6g/+U2iN63M2oP2GHLTSreu08uJiux0qUNzA4TCdHR8dOzua3Y9vaKXzxEeMO6sHe5xDZsL
 ik6f2zlj2f3N/xm8LC7mvXpYSKos0BH/c8PHgssYYrPBCLwhDNl22hTVFDdvjMA+93T95sAnSm9
 N8jNIi6QhS5DkU6mRdDIfTqT222VBA==
X-Proofpoint-ORIG-GUID: Ou7hkLN23_xcYud0A5Y8xcv7HSE-M5uP
X-Proofpoint-GUID: Ou7hkLN23_xcYud0A5Y8xcv7HSE-M5uP
X-Authority-Analysis: v=2.4 cv=GdUaXAXL c=1 sm=1 tr=0 ts=68dd4b57 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=eREyYmBtXGGudL_Iqe0A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 phishscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jhkim@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Previously, set_ind_atomic() returned the entire byte containing
multiple summary bits. This meant that if any other summary bit in the
byte was set, interrupt injection could be incorrectly blocked, even
when the current device's summary bit was not set. As a result, the
guest could remain blocked after I/O completion during FIO tests.

This patch replaces set_ind_atomic() with set_ind_bit_atomic(), which
returns true if the bit was set by this function, and false if it was
already set or mapping failed. Interrupts are now blocked only when
the device's own summary bit was not previously set, avoiding
unintended blocking when multiple PCI summary bits exist within the
same byte.

Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index f87d2748b6..e8e41c8a9a 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -652,7 +652,16 @@ static const PCIIOMMUOps s390_iommu_ops = {
     .get_address_space = s390_pci_dma_iommu,
 };
 
-static uint8_t set_ind_atomic(uint64_t ind_loc, uint8_t to_be_set)
+/**
+ * set_ind_bit_atomic - Atomically set a bit in an indicator
+ *
+ * @ind_loc:   Address of the indicator
+ * @to_be_set: Bit to set
+ *
+ * Returns true if the bit was set by this function, false if it was
+ * already set or mapping failed.
+ */
+static bool set_ind_bit_atomic(uint64_t ind_loc, uint8_t to_be_set)
 {
     uint8_t expected, actual;
     hwaddr len = 1;
@@ -662,7 +671,7 @@ static uint8_t set_ind_atomic(uint64_t ind_loc, uint8_t to_be_set)
     ind_addr = cpu_physical_memory_map(ind_loc, &len, true);
     if (!ind_addr) {
         s390_pci_generate_error_event(ERR_EVENT_AIRERR, 0, 0, 0, 0);
-        return -1;
+        return false;
     }
     actual = *ind_addr;
     do {
@@ -671,7 +680,7 @@ static uint8_t set_ind_atomic(uint64_t ind_loc, uint8_t to_be_set)
     } while (actual != expected);
     cpu_physical_memory_unmap((void *)ind_addr, len, 1, len);
 
-    return actual;
+    return (actual & to_be_set) ? false : true;
 }
 
 static void s390_msi_ctrl_write(void *opaque, hwaddr addr, uint64_t data,
@@ -693,10 +702,10 @@ static void s390_msi_ctrl_write(void *opaque, hwaddr addr, uint64_t data,
     ind_bit = pbdev->routes.adapter.ind_offset;
     sum_bit = pbdev->routes.adapter.summary_offset;
 
-    set_ind_atomic(pbdev->routes.adapter.ind_addr + (ind_bit + vec) / 8,
+    set_ind_bit_atomic(pbdev->routes.adapter.ind_addr + (ind_bit + vec) / 8,
                    0x80 >> ((ind_bit + vec) % 8));
-    if (!set_ind_atomic(pbdev->routes.adapter.summary_addr + sum_bit / 8,
-                                       0x80 >> (sum_bit % 8))) {
+    if (set_ind_bit_atomic(pbdev->routes.adapter.summary_addr + sum_bit / 8,
+                   0x80 >> (sum_bit % 8))) {
         css_adapter_interrupt(CSS_IO_ADAPTER_PCI, pbdev->isc);
     }
 }
-- 
2.43.0


