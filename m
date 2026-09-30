Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCD5CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBvhz-0003B3-Jm; Wed, 30 Sep 2026 10:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xBvgJ-00014I-M3; Wed, 30 Sep 2026 10:53:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xBvgH-0006fe-5Z; Wed, 30 Sep 2026 10:53:15 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5VSF3203220; Wed, 30 Sep 2026 14:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=qfxvCYX16G+pGB0y0
 sS4/BdZcvGqc8oUq90Vp4m4GN0=; b=jGXoj5BIoYoJgMzx53FvgOJfie0tL2xKe
 9yWc0y36jeb5FJWNRj7VbzP+GJfzmec8Ncn87G87FXf7GiyabywtxBi+/+D+6l/W
 texp2DUPBKABZwKtpKaYTvy0/r9SHhD0VQhc6BUWqAYZdQI/5LqdnwREZWeyevAS
 EnEKAx0cGGVyrGH15O83BhRD5OcFmVLHtM3H82/chDM6E7jywkEwoOhB5lSPhq28
 op+23ozKRRcZKUOCYWHW2DfZvMZM1Ox+DqqqOpo0erEgfbjtmtVmmDTmdoAmR1UH
 VMSUrcqFVot08RnEsEbp9iNdad890a1nA/ofe04l84YZ+c22JvJbQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5dsh2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 14:53:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE396S2287814; Wed, 30 Sep 2026 14:53:08 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pay5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 14:53:08 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UEr7ti61997554
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 14:53:07 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 395E558059;
 Wed, 30 Sep 2026 14:53:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AFEF58055;
 Wed, 30 Sep 2026 14:53:06 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.60.171])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 14:53:06 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v11 14/16] s390x/pci: Factor ioat sanity checks into a
 separate function
Date: Wed, 30 Sep 2026 09:52:53 -0500
Message-Id: <20260930145255.140164-15-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930145255.140164-1-kshk@linux.ibm.com>
References: <20260930145255.140164-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1OCBTYWx0ZWRfX7F2jkeSNAQV/
 UTCH/ngdGEoks9Z5wZ6iJJeeIeBlEsw7QEwn+Bjw6T82db9iYKvc2noCghmVbbGkN9e+wfdj7Y3
 hSu+xtNK0K5rezQN5KJGd55MqXAkEQM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1OCBTYWx0ZWRfX+lVv2rg5Bvhg
 sqo20joOQM4f9WQY/UXlOaZQijflV5e4tgDXwB5StY8r5E55Jd7OufhbeXfbOoc1HFW+fHp5Tgx
 p5en1ZZ8NCI+hKWAKtCroValJpIVm04pClCZv/pT+grhM7N7mbs5KJziXs0t9S3N4jka7F0IUnw
 4Q8vCwFz+/lVKVowL6/U/e8rImnh2kox4N6VQMxK/tFln3GsAcOSD6TsFFw++HJAyuWkqB39+ll
 ke45sAnQo/IkfN5Krxw/Ev6WKLg/Anwy+A1xOcX2joM0PzidQkfb8XYciW8Q927v/45Ne1RpaLS
 FP0Zdx6tU0w1uezfGFxyAQMLfWbBRQgAS1Ipt6PbASyCTCbBe9ml6nonZWrsNb6inhkcEF7r5lF
 yoLf64U6htIxyNuUXE+eEvwgfXCXwmDoLJ8Nk7+M41jwpZffzi7wFEx2Xlu7O4drZUdhzeqhiMl
 +EbdpM743JImK/4K+3w==
X-Proofpoint-GUID: JUrhMWZagMPOV44tmlEG4HiEqaqf21V6
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abd2255 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=n2Egs-CTGoTGlbV73dQA:9
X-Proofpoint-ORIG-GUID: JUrhMWZagMPOV44tmlEG4HiEqaqf21V6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300058
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
 hw/s390x/s390-pci-inst.c         | 52 ++++++++++++++++++++------------
 include/hw/s390x/s390-pci-inst.h |  2 ++
 2 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 98380526d1..b0af15ff15 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1028,32 +1028,22 @@ bool s390_pci_is_translation_enabled(uint64_t g_iota)
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
@@ -1064,9 +1054,31 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
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
+        if (err) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s\n", error_get_pretty(err));
+            error_free(err);
+        }
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


