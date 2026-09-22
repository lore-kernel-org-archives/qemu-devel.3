Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67281C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 18:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x95Mt-0007ax-HZ; Tue, 22 Sep 2026 14:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x95Ma-0007Zy-O2; Tue, 22 Sep 2026 14:37:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x95MW-0005vA-Rc; Tue, 22 Sep 2026 14:37:06 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI77Qm1156891; Tue, 22 Sep 2026 18:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=dztpV4sHbP6jXWmT6
 PTrhJ71EXX91O3F0lfOYDQfLz8=; b=NJ9X+Or55m8y67+UlD9Qb/OK4rvax5Jio
 wTqkk/gu+F8svzkZN68NbI0k5jaoxJYu9CR92PXv4QQl8YiBi8xIwgpp1YywUorF
 6cwQ6Y6vyEreJFk4BbiIrYEwZjT42Xix/g7XBA3x7jYFfWwIi9VAncF6nwj139ar
 QSKSh01NNwRpsjqkm46w1vEYA9dJrvHhPy+NagJe6LSercZWcZYN4bB5InHcU8n6
 Q3Qj30qXpTj3VIdzZFp9fbwMztUQen+E5XdRXGX1qQHqkmTANdmpSb76X9P4ibHO
 JycBeg81f4Htz98stukUuoO3mzH3LKqzavG0f8lasCpF4huOGxtnQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv73wb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 18:36:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHWDm3198565; Tue, 22 Sep 2026 18:36:59 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qju12m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 18:36:59 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MIav4T27853562
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 18:36:58 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9723458068;
 Tue, 22 Sep 2026 18:36:57 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B3BE58067;
 Tue, 22 Sep 2026 18:36:57 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.251.122])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 18:36:57 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v9 02/16] s390x/pci: Create function to contain translation
 status check
Date: Tue, 22 Sep 2026 13:36:40 -0500
Message-Id: <20260922183654.798470-3-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922183654.798470-1-kshk@linux.ibm.com>
References: <20260922183654.798470-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: C_T_oO11ZnxEcKpQ5nvky_SRz-J4nj8v
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI3MyBTYWx0ZWRfX7mkxhAzkUAIe
 gPmukJw+ObCaWOn7+6yfb24mBvQSJMcsys0Eg6u7xWppTBxj3C2PVvXgwBhSHYEL8CuXwVp9a66
 rbs2V7fbGetl41BVruTxGPGw72I7XHI=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab2cacb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=aCv-BzsnQx_gTHabB28A:9
X-Proofpoint-GUID: C_T_oO11ZnxEcKpQ5nvky_SRz-J4nj8v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI3MyBTYWx0ZWRfXyNg/mapQPeGP
 ohF+X2DoHpbu7dNU8bHpwj4EOUx4LC+efRstzw5I1Mn8c2PqSVXMlKsePEx6fjBvLoyvB2BO8uQ
 tlXmtZb/lId05PgVt6rw2INlkW6RcOsyUFXK6qG9Q5Gjd7nXVyLftmzeNdlOz5/8XAEEaScDbid
 vbuUf/Pq4XrsrMBIOdBIjpbbfKJZXsD+F846P3iP8JYweZuo2BNSb5MtGiSp3TGcttSYcuRV6k3
 5K7AOs79VqaeFTN+ru35beatYmpSxDKwzq4MFKXz272lIz1dHgr6QoTOw4vRkpho4WbhnmMae2W
 89l1D1ztnkFh08gX6fbnwdW57HsAV7zXCZyQKmClL1oI8dMe5eEmzDo5Pqh0wLZBAkK+u7KWRgf
 aNq+2ONun2TzxUvuZhtEctUwmKUYU55MW2zyr1OWB93JmgLpToXcYXiHuYNEoFYvVJHsyLu8ZKQ
 +y3Cd5KLjhCLxPV25Cw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220273
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

Make it more clear what the bit means, and the new function will be called
from yet another place in the future.

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-inst.c        | 7 ++++++-
 include/hw/s390x/s390-pci-bus.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 37ca70dcf1..00a847f493 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1021,6 +1021,11 @@ int pci_dereg_irqs(S390PCIBusDevice *pbdev)
     return 0;
 }
 
+bool s390_pci_is_translation_enabled(uint64_t g_iota)
+{
+    return ((g_iota >> 11) & 0x1) != 0; /* "T" bit */
+}
+
 static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
                     uintptr_t ra)
 {
@@ -1029,7 +1034,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
     uint64_t pal = ldq_be_p(&fib.pal);
     uint64_t g_iota = ldq_be_p(&fib.iota);
     uint8_t dt = (g_iota >> 2) & 0x7;
-    uint8_t t = (g_iota >> 11) & 0x1;
+    bool t = s390_pci_is_translation_enabled(g_iota);
 
     pba &= ~0xfff;
     pal |= 0xfff;
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 9228523ce8..eb15cb8b2d 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -390,6 +390,7 @@ int pci_chsc_sei_nt2_get_event(void *res);
 int pci_chsc_sei_nt2_have_event(void);
 void s390_pci_sclp_configure(SCCB *sccb);
 void s390_pci_sclp_deconfigure(SCCB *sccb);
+bool s390_pci_is_translation_enabled(uint64_t g_iota);
 void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
 void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu);
 void s390_pci_iommu_disable(S390PCIIOMMU *iommu);
-- 
2.34.1


