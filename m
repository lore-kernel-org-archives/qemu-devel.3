Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EDECA5FF0
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2026 00:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDstF-000529-Lm; Mon, 05 Oct 2026 20:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xDsrn-000402-AR; Mon, 05 Oct 2026 20:17:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xDsrk-0001If-1D; Mon, 05 Oct 2026 20:17:09 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HZLlU3658102; Tue, 6 Oct 2026 00:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=wjecVddne9bSYR1MV
 kyKWicsRMXicckJvrDqa5RsSt8=; b=PX8vjXDqaOko9z0vi+XIuaFYgIPXOKEA+
 Yeb2jyn+4egk7PMTy6WSh+wVFEDqBZLBc9XH2VYUbSRjrExcsmT/7TzBYTSPwZ2+
 QDEV/WOsi5hgzu3XSIFCpMZOGgw5IL5vi5aSjnsdmGqe+6ubZz+EH1mA2/Jui2Zl
 vCHSdtOXnW7jlLiyUccAIXh8OjQ6FiaKP64Z9rq7Rt+PJ930NQyY4oXjMNUvhIil
 92ME0LQhfDT4LRzy26379iv2iM2wYwMkTpm56/uVznSMlat3lRTTC4VhexsXtsn9
 qpsXxxR7d5XwFad+jkbs9m8mpUAwtJGhIwGYgdaUz6ILLGh7soQtA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrd3w8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 00:17:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695Lt70l3280699; Tue, 6 Oct 2026 00:17:03 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgqnku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 00:17:03 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6960H2Sm33555134
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 00:17:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0220358053;
 Tue,  6 Oct 2026 00:17:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 213DA5805D;
 Tue,  6 Oct 2026 00:17:01 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.249.221])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 00:17:01 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v12 14/17] s390x/pci: Move ioat sanity checks into new
 function, add error message
Date: Mon,  5 Oct 2026 19:16:40 -0500
Message-Id: <20261006001643.420929-15-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006001643.420929-1-kshk@linux.ibm.com>
References: <20261006001643.420929-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAwMCBTYWx0ZWRfX0qtceCCxBS6j
 iTb+xlkekks8ZoA+Vfnu/SbI29/hNWe1MiWdNnWQstQhNGwBEV/ljFKw6PoYChPUjrWUhZfINdO
 MN7MbNGJWrNgNBzvGK1ZyyIjqJVViYc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAwMCBTYWx0ZWRfXx+vF+NCqCm8X
 IHbzYdj05i+OBdH73lnYTCuP3Nz6zcXU+hKTCWL1cXmHmUTGbAMcX4f1b5P/h4XEDlqdcGVPfp2
 ZxA8SUKXCN6cN9Oi/kM8K0Hk1hBxDNo+Yw/9D/er4B9HXOFsxC73F0RGqy7EVsTr/AXy3FSYj6T
 rLxm9E7hIV/JWddjwWXvCe8oBFu/8+weqMvInf/od4+sKt615vOSQrbdhicKQTmKfU0KeavFkka
 ewJ4+ETeIvS6e6rfHaWPK7JEj5Q/jX81GA8rsRli46VSyFolkqxhYl33jH9CQkvYyEoNa6f1Zon
 oHO5T+YhjRTuM1CIJZY9ZF4Q9W1GNuiCAHj2gSjMBt/jBQbKltQ6FDX1XsfaT16T9wFfdnX+D8k
 LDXJDwJQHSZK3+eUBCXNZaOZU8wpI5HQRe/DvXj90AvPJtTPrC75M/wtWkXo4T2sJYVCbh1s2Bv
 edUKPROzVoPb/wI57/Q==
X-Proofpoint-GUID: rXsdGWQ8cIOiDEbOfUUJpPoW3VzAlXRl
X-Proofpoint-ORIG-GUID: rXsdGWQ8cIOiDEbOfUUJpPoW3VzAlXRl
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac43e00 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=3pFs7uzPxsaeADVYgZ0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060000
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
Provide a new error message to the path that didn't have it.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-inst.c         | 54 ++++++++++++++++++++------------
 include/hw/s390x/s390-pci-inst.h |  2 ++
 2 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 98380526d1..98b0ac4990 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1028,32 +1028,26 @@ bool s390_pci_is_translation_enabled(uint64_t g_iota)
     return ((g_iota >> 11) & 0x1) != 0; /* "T" bit */
 }
 
-static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
-                    uintptr_t ra)
+bool s390_pci_ioat_validate(S390PCIBusDevice *pbdev, uint64_t pba,
+                             uint64_t pal, uint64_t g_iota, Error **errp)
 {
-    uint64_t pba = ldq_be_p(&fib.pba);
-    uint64_t pal = ldq_be_p(&fib.pal);
-    uint64_t g_iota = ldq_be_p(&fib.iota);
     uint8_t dt = (g_iota >> 2) & 0x7;
     bool t = s390_pci_is_translation_enabled(g_iota);
 
-    pba &= ~0xfff;
-    pal |= 0xfff;
     if (pba > pal || pba < pbdev->zpci_fn.sdma || pal > pbdev->zpci_fn.edma) {
-        s390_program_interrupt(env, PGM_OPERAND, ra);
-        return -EINVAL;
+        error_setg(errp,
+                   "ioat pba 0x%"PRIx64" pal 0x%"PRIx64" out of device dma range"
+                   " [0x%"PRIx64" 0x%"PRIx64"]",
+                   pba, pal, pbdev->zpci_fn.sdma, pbdev->zpci_fn.edma);
+        return false;
     }
-
     /* currently we only support designation type 1 with translation */
     if (t && dt != ZPCI_IOTA_RTTO) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "unsupported ioat dt %d t %d\n", dt, t);
-        s390_program_interrupt(env, PGM_OPERAND, ra);
-        return -EINVAL;
+        error_setg(errp, "unsupported ioat dt %d t %d", dt, t);
+        return false;
     } else if (!t && !pbdev->rtr_avail) {
-        qemu_log_mask(LOG_GUEST_ERROR, "relaxed translation not allowed\n");
-        s390_program_interrupt(env, PGM_OPERAND, ra);
-        return -EINVAL;
+        error_setg(errp, "relaxed translation not allowed");
+        return false;
     }
 
     /*
@@ -1064,9 +1058,29 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
      * to QEMU for additional IOAT regions.
      */
     if (t && pal >= ZPCI_TABLE_SIZE_RT) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "ioat pal 0x%"PRIx64" exceeds max translatable address\n",
-                      pal);
+        error_setg(errp,
+                   "ioat pal 0x%"PRIx64" exceeds max translatable address",
+                   pal);
+        return false;
+    }
+    return true;
+}
+
+static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
+                    uintptr_t ra)
+{
+    Error *err = NULL;
+    uint64_t pba = ldq_be_p(&fib.pba);
+    uint64_t pal = ldq_be_p(&fib.pal);
+    uint64_t g_iota = ldq_be_p(&fib.iota);
+    bool t = s390_pci_is_translation_enabled(g_iota);
+
+    pba &= ~0xfff;
+    pal |= 0xfff;
+
+    if (!s390_pci_ioat_validate(pbdev, pba, pal, g_iota, &err)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s\n", error_get_pretty(err));
+        error_free(err);
         s390_program_interrupt(env, PGM_OPERAND, ra);
         return -EINVAL;
     }
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


