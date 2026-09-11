Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63886C88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x534v-0008MA-DJ; Fri, 11 Sep 2026 11:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x534d-0007yZ-IN; Fri, 11 Sep 2026 11:21:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x534Z-0004lB-Sf; Fri, 11 Sep 2026 11:21:55 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BF1PST2126785; Fri, 11 Sep 2026 15:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=3/DOB8EnrxHQiH9xr
 YsGZ+re8eNzeVKb7ux+FIMrmOo=; b=APA2TJFBelvq7NRSxXjWT0hL+ivnXME/v
 51NqNiIHWedx9EmI5UQ8iNJE/KaG2TLoeOojbCB4C6H7zLb/fQfvvh5owSlk1AJi
 zzcqLLEbPP6HJ29vS5lxuWOrDFmM5+GHc11AeS+NjwtdE6796zsZXKU8Df9n+/IK
 EIJY5PMBYDlgwvNBpTsYa1ipGTPYcL9bfP2GYzG79Y1BiaJdot/mUk+R/nvX8RC3
 0DQvcUNkGnYa4gPivaJYIdDKyqFe5Q4nclnvoka3QHwcF811yb+MFhj5gq1X1F/o
 EHYqYXhLVtWDX8NJOYHHGpE6b199NU1AKhwDZdZN/cA1g4eq+lqMQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8qvbb1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:21:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEo7In1808726; Fri, 11 Sep 2026 15:21:45 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvq2y35q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:21:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68BFLhin28508820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2026 15:21:43 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 541C858061;
 Fri, 11 Sep 2026 15:21:43 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D2BE5805D;
 Fri, 11 Sep 2026 15:21:43 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.62.165])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Sep 2026 15:21:43 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v8 14/16] s390x/pci: Factor ioat sanity checks into a separate
 function
Date: Fri, 11 Sep 2026 10:21:35 -0500
Message-Id: <20260911152137.676602-15-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911152137.676602-1-kshk@linux.ibm.com>
References: <20260911152137.676602-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SpUFe/O0 c=1 sm=1 tr=0 ts=6aa41c8a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=tFIIGk-Z8APL5VWaAH4A:9
X-Proofpoint-ORIG-GUID: mIwVUSfsMtM58m0Pu9IwSzOE9OKKn1qE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfX3podRgozahDj
 lLc3w3WczwWnKCeqJCk4lQa07GHa4dKEgxMFjseXmU3IIXWt72utw1jAlKH9Vs5jyk31Ae+ohn3
 n0fa08mZqMD9y77oWyPRgMnhaYE8E6ppz7CQG1bd6d0xDk/tQahkCqkhuskuILVMIlTbIQnpAuO
 uz7TFVmm3WCsF5oPZ1zBbin9YyXjGFW5+BPk/478zULRsdxN1qi4B6H/D6+OcqAWXWNlvdYAjEj
 I1PyENwAxExFSHzQ/qDcn4cpgVIlvqcFf+lCtTqh7nqYID6VQ3Vpltv3Pwla1jNUPyLIMfNVcmI
 Vhh6wHeyepbMLznloO6TDEtGt4LRtkJtw6jnj4mJxqN66DfEpn+AP9WzO4rIlk/znPOkNTZ2xur
 +lu3aS57t6zqh3/TRmX80EpZpMZauVHse4YLj2zAqOKc3kW90d6KyjDfUEUDYIt9nJ3IUvGu7Ng
 5eOc0Odx8tlGL/QuoLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfX7NR3jqA9R3Mi
 yhrx5r/bhx5Bva/859Q7gyJKkEMA+APs/CP6uq/hqTqx/CJg1qZU/uGSBguS6fNbNnC7t3KwLKS
 Av7YaZbbZislp64m5XIyYQa4rlsCj20=
X-Proofpoint-GUID: mIwVUSfsMtM58m0Pu9IwSzOE9OKKn1qE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110210
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Extract the pba, pal and g_iota checks from reg_ioat() into a function.
Make it external so that it can also be used in a follow up change.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-inst.c         | 39 +++++++++++++++++++++-----------
 include/hw/s390x/s390-pci-inst.h |  2 ++
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index f93db10c81..c7f96417cc 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1024,29 +1024,42 @@ bool s390_pci_is_translation_enabled(uint64_t g_iota)
     return ((g_iota >> 11) & 0x1) != 0; /* "T" bit */
 }
 
+bool s390_pci_ioat_validate(S390PCIBusDevice *pbdev, uint64_t pba,
+                             uint64_t pal, uint64_t g_iota, bool report)
+{
+    uint8_t dt = (g_iota >> 2) & 0x7;
+    bool t = s390_pci_is_translation_enabled(g_iota);
+
+    if (pba > pal || pba < pbdev->zpci_fn.sdma || pal > pbdev->zpci_fn.edma) {
+        return false;
+    }
+    /* currently we only support designation type 1 with translation */
+    if (t && dt != ZPCI_IOTA_RTTO) {
+        if (report) {
+            error_report("unsupported ioat dt %d t %d", dt, t);
+        }
+        return false;
+    }
+    if (!t && !pbdev->rtr_avail) {
+        if (report) {
+            error_report("relaxed translation not allowed");
+        }
+        return false;
+    }
+    return true;
+}
+
 static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
                     uintptr_t ra)
 {
     uint64_t pba = ldq_be_p(&fib.pba);
     uint64_t pal = ldq_be_p(&fib.pal);
     uint64_t g_iota = ldq_be_p(&fib.iota);
-    uint8_t dt = (g_iota >> 2) & 0x7;
     bool t = s390_pci_is_translation_enabled(g_iota);
 
     pba &= ~0xfff;
     pal |= 0xfff;
-    if (pba > pal || pba < pbdev->zpci_fn.sdma || pal > pbdev->zpci_fn.edma) {
-        s390_program_interrupt(env, PGM_OPERAND, ra);
-        return -EINVAL;
-    }
-
-    /* currently we only support designation type 1 with translation */
-    if (t && dt != ZPCI_IOTA_RTTO) {
-        error_report("unsupported ioat dt %d t %d", dt, t);
-        s390_program_interrupt(env, PGM_OPERAND, ra);
-        return -EINVAL;
-    } else if (!t && !pbdev->rtr_avail) {
-        error_report("relaxed translation not allowed");
+    if (!s390_pci_ioat_validate(pbdev, pba, pal, g_iota, /*report=*/true)) {
         s390_program_interrupt(env, PGM_OPERAND, ra);
         return -EINVAL;
     }
diff --git a/include/hw/s390x/s390-pci-inst.h b/include/hw/s390x/s390-pci-inst.h
index 38268c256e..b53113ddbc 100644
--- a/include/hw/s390x/s390-pci-inst.h
+++ b/include/hw/s390x/s390-pci-inst.h
@@ -100,6 +100,8 @@ typedef struct ZpciFib {
 
 int pci_dereg_irqs(S390PCIBusDevice *pbdev);
 void pci_dereg_ioat(S390PCIBusDevice *pbdev);
+bool s390_pci_ioat_validate(S390PCIBusDevice *pbdev, uint64_t pba,
+                             uint64_t pal, uint64_t g_iota, bool report);
 int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra);
 int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra);
 int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra);
-- 
2.34.1


