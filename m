Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D57C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Nm2-0008AS-Uq; Wed, 23 Sep 2026 10:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x9Nlc-0007pB-QY; Wed, 23 Sep 2026 10:16:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x9NlX-0005xT-AW; Wed, 23 Sep 2026 10:16:10 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8Zomn1031364; Wed, 23 Sep 2026 14:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=iN02cPUFYxDL/APWG
 rAnklAVDDr234tyjmOsedzmKeQ=; b=ASOFmo4wj6oWaqyC5ezjCjIafoZ+ROom4
 do1YxIyzqVojGG7rvxYn9SsKP3N8eZ15AxDuGQsl2iDWLwFk1fPDqImWlkE66qpY
 zMuJUySCH5zBs8ImiSTZcAYDGZnvtMo+BwDvVFSUAy8BWYI5R3aYUj3rPsBsUFJI
 uKDawzkYBuYYwaJ5kI8OVxxCn+3JNraZY6Y17yAolnA7U9yIS1Hgr8UECoFqsI3t
 GbOlcvt6h6Z2jpw+Oyc4UQ7t2hLT1jW3fPL7GRwB8ONs9BKF0zZnZ9/xKCdGaskP
 VyvA0wgeaFwZi2IXWocRULdO/EH2jghHlp17K8IRbQ+8U1enh91Pw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1ury6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 14:15:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NCSPbR008222; Wed, 23 Sep 2026 14:15:35 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8jsbfn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 14:15:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68NEFXMc13173404
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 14:15:33 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 563935805B;
 Wed, 23 Sep 2026 14:15:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A5CED58058;
 Wed, 23 Sep 2026 14:15:32 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.60.171])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 14:15:32 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v10 14/16] s390x/pci: Factor ioat sanity checks into a
 separate function
Date: Wed, 23 Sep 2026 09:15:16 -0500
Message-Id: <20260923141518.960364-15-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923141518.960364-1-kshk@linux.ibm.com>
References: <20260923141518.960364-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ptm-BY7PVzDAsEGzdp0s0XSLrGHNzLTc
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab3df07 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=wW6n-Ahcx9W_GWn2IWgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfX73ShJC8KGw2C
 rwopV61qGrZ5Ocl16Xg5x6hYW6DPE1ENmuznE0FwgnLTW2gmVqjCNlAKVJ1OozmKrOtQ8guVusK
 GJaER0wy9PAvvT0X/nPKGAwNha9oxio=
X-Proofpoint-GUID: ptm-BY7PVzDAsEGzdp0s0XSLrGHNzLTc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfXxXGQuPeoymLn
 BxKomS4zjq/YUPmUzmIFstIb+rrfUkPz4pgcjcvbGF1juq0JKcXXqMpa8fxziscIMtawaKlWs6L
 Ah+8yyDTSEbK5UKcnqbPXlgEJaodMU1KKnMcm0LJPaRVibBlOyTlSR5GGS/+fnxvzxL3iwyj94Z
 7TTZGbr33ala06ubnPK9L8/Z96jdpa1jG/ae8Uw2rkrC+nYLWso72zw2IR737vgcdHFuXxsMnle
 6JiPQuM3duacbpkKXsO8DDB0PNSHyrktm1hmk1sTiEOc/wpldIhq3MdxHGfiXTtW2VfTkEiB9Ap
 jIlEcYRckngukYP6XN/EwM6sTf4xXvGTCFV+IyUzhDIU5bWMAlw4WMuzvyZO14RDPCjfqEdbgxR
 FEaxTM/SJiRiHNrDVotHazmKUjzlKWeNNZ1h672fUHlbufpSdH3gSptpzvbkXtSU/X9vmz3eQEW
 xeX3StTHI7KWxAUnGvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230056
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
 hw/s390x/s390-pci-inst.c         | 44 ++++++++++++++++++++++----------
 include/hw/s390x/s390-pci-inst.h |  2 ++
 2 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index f93db10c81..cc55804473 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1024,31 +1024,47 @@ bool s390_pci_is_translation_enabled(uint64_t g_iota)
     return ((g_iota >> 11) & 0x1) != 0; /* "T" bit */
 }
 
+bool s390_pci_ioat_validate(S390PCIBusDevice *pbdev, uint64_t pba,
+                             uint64_t pal, uint64_t g_iota, Error **errp)
+{
+    uint8_t dt = (g_iota >> 2) & 0x7;
+    bool t = s390_pci_is_translation_enabled(g_iota);
+
+    if (pba > pal || pba < pbdev->zpci_fn.sdma || pal > pbdev->zpci_fn.edma) {
+        return false;
+    }
+    /* currently we only support designation type 1 with translation */
+    if (t && dt != ZPCI_IOTA_RTTO) {
+        error_setg(errp, "unsupported ioat dt %d t %d", dt, t);
+        return false;
+    }
+    if (!t && !pbdev->rtr_avail) {
+        error_setg(errp, "relaxed translation not allowed");
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
+    {
+        Error *err = NULL;
 
-    /* currently we only support designation type 1 with translation */
-    if (t && dt != ZPCI_IOTA_RTTO) {
-        error_report("unsupported ioat dt %d t %d", dt, t);
-        s390_program_interrupt(env, PGM_OPERAND, ra);
-        return -EINVAL;
-    } else if (!t && !pbdev->rtr_avail) {
-        error_report("relaxed translation not allowed");
-        s390_program_interrupt(env, PGM_OPERAND, ra);
-        return -EINVAL;
+        if (!s390_pci_ioat_validate(pbdev, pba, pal, g_iota, &err)) {
+            if (err) {
+                error_report_err(err);
+            }
+            s390_program_interrupt(env, PGM_OPERAND, ra);
+            return -EINVAL;
+        }
     }
 
     pbdev->pba = pba;
diff --git a/include/hw/s390x/s390-pci-inst.h b/include/hw/s390x/s390-pci-inst.h
index 38268c256e..3493d2ced0 100644
--- a/include/hw/s390x/s390-pci-inst.h
+++ b/include/hw/s390x/s390-pci-inst.h
@@ -100,6 +100,8 @@ typedef struct ZpciFib {
 
 int pci_dereg_irqs(S390PCIBusDevice *pbdev);
 void pci_dereg_ioat(S390PCIBusDevice *pbdev);
+bool s390_pci_ioat_validate(S390PCIBusDevice *pbdev, uint64_t pba,
+                             uint64_t pal, uint64_t g_iota, Error **errp);
 int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra);
 int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra);
 int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra);
-- 
2.34.1


