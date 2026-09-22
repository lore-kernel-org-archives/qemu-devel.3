Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AF0C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 18:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x95NG-0007im-Fr; Tue, 22 Sep 2026 14:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x95Mn-0007ad-MU; Tue, 22 Sep 2026 14:37:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x95Mc-0005w3-Uq; Tue, 22 Sep 2026 14:37:15 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7Ye14144342; Tue, 22 Sep 2026 18:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=RuTf9G6QWH24xQuiU
 Nx5w7dFeeNJjGUDNvO8sUeBJ4g=; b=cYWhXzmLDy0COmj+RjETP6SD74PGX2a8j
 tX7vdH2qgKUzbjgfeznI9b7sw2hjokvXTvRwAvjKZAQuwV8I4XUh7AinVPl7AbSt
 jVfFFrgOgnePBeKQE7aqnJTfCMHF8Uq6CEPsrizk4NBKvAcyY2Aq88JHZwauyoBO
 +fnQv+/isUk0fjbcBym53U0BAqE6/841b0QAZXus2KC1HThhXrccwNeIfHBA647r
 p674dsiZVhYJbn+lOIdnczFhOZkdjHZFzgw39N9GluGKiQbt1KBityG6YID2Uxmd
 PEKEkqjycuV8MtlermVCHNwqfKCyoFydQ6o3W5CvGdlOBY5qkqRfg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqf1mw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 18:37:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHU0U4187944; Tue, 22 Sep 2026 18:37:01 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dyasrm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 18:37:01 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MIb07K6554312
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 18:37:00 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FBC758067;
 Tue, 22 Sep 2026 18:37:00 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D72FF5805D;
 Tue, 22 Sep 2026 18:36:59 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.251.122])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 18:36:59 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v9 14/16] s390x/pci: Factor ioat sanity checks into a separate
 function
Date: Tue, 22 Sep 2026 13:36:52 -0500
Message-Id: <20260922183654.798470-15-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922183654.798470-1-kshk@linux.ibm.com>
References: <20260922183654.798470-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab2cacd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=wW6n-Ahcx9W_GWn2IWgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI3MyBTYWx0ZWRfX/WCj9PCI1rzf
 NTquT6T+J7z200o5RXtDuWk02AIKBrcNlA9doOwlsQxU6vMc+HzDfPrwmyFmXGioZ8g8TMcfpze
 zzqUZicol9SKw/zc3o3pkD3YeumwH7bEfx9fyQN3CRWcUOHTJD9cgDKC7KHUSSdztPtIcxM0f/N
 Z/1/YlEH+HeHUggUe/sg8yjW7Skw5gc0A5TZJG9InE2+I69CQF3WDvuwIP0+UQQ19hR5YRwa0VL
 cpl6NgRd28yHJ/1/5zw2io0v7Qpf2VG7ezLym+VCqEdtBJYBwyx09cE9AFtO3MJsH3PS42bBPfw
 yOq3L/juAtRrnrEYpBMKzJ+Y2H1PjExOSBxmDzYZ8dNJ154TK8PZE9z2nHjc0DCq2KU0Qy/+uls
 M7C03/g3TTM/epNAWIJGApqHrFe8cIum0ejj6F7Ea5NMfpuCI3E5X+sojrNQXS9Z2ZtuFbltO/Y
 jTtkTPNn9KFXGNGmcAg==
X-Proofpoint-ORIG-GUID: kCBr8sgAJO_E0QJcE-1zjYfI4RV_uf1s
X-Proofpoint-GUID: kCBr8sgAJO_E0QJcE-1zjYfI4RV_uf1s
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI3MyBTYWx0ZWRfX6SEiwUzegThs
 Au1BkfgfcFrBRnNLFMI1Y6ImeveXnDYF8BJs8u7ByZpWu1DRDVMXqSs05qx/NN6nr7axHvSdIVu
 ZD/jDJJW6LSwzcsyl2+CYoaOBuT/cK4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220273
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

Extract the pba, pal and g_iota checks from reg_ioat() into a function.
Make it external so that it can also be used in a follow up change.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-inst.c         | 42 +++++++++++++++++++++-----------
 include/hw/s390x/s390-pci-inst.h |  2 ++
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index f93db10c81..a1cd96f647 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1024,31 +1024,45 @@ bool s390_pci_is_translation_enabled(uint64_t g_iota)
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
+            error_report_err(err);
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


