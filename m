Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394A7CA601F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFFKz-0000al-2d; Fri, 09 Oct 2026 14:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKs-0000YL-IF; Fri, 09 Oct 2026 14:28:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKq-0001h1-L5; Fri, 09 Oct 2026 14:28:50 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699Ha4Um806487; Fri, 9 Oct 2026 18:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=L3dCY6wl3WogHd9XR
 Jq6dSFqSWcvR331enqF8OsDAx0=; b=N6qaKJDoJiHQeb57NCO2pGd4cEDGKORoe
 POA5H2aIwwNCmU25nPpbLPuA/bhJ4TyXVBqYZINlN7LBcjcmO9vKe8xVH9/2MPrc
 BIPYGDClpVwRaFKHFymYXSLTduswLPGJseZTxr9hlruJrrDFgz9U8YXZAbIEX7xO
 R2VHKlKIuI9QzDYiBSRXQoKmYPu7E2sdsI60FQb5KaqQa7UcEucv2K8nN1m7vyZv
 R4eqCiN7OEo5vBL61vZ9rQvD7VCsE6kMUDpqHRBrQRIvoS2kmp6ngMjVTlSjDK46
 MM4anWuev+ChYj5+uL4+pN5V8BDqQ02L2yxjlmVzu7kHzQ0SxnZbw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74tdg8rr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699H8E4a1162502; Fri, 9 Oct 2026 18:28:46 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h6v76t5fq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:46 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 699ISiYN26542754
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 18:28:44 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A46A358054;
 Fri,  9 Oct 2026 18:28:44 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B93315805A;
 Fri,  9 Oct 2026 18:28:43 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 18:28:43 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Konstantin Shkolnyy <kshk@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 14/19] s390x/pci: Move ioat sanity checks into new function,
 add error message
Date: Fri,  9 Oct 2026 14:28:20 -0400
Message-ID: <20261009182825.148054-15-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009182825.148054-1-farman@linux.ibm.com>
References: <20261009182825.148054-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LqkHWXdc c=1 sm=1 tr=0 ts=6ac9325e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=3pFs7uzPxsaeADVYgZ0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX8Fpp+J/B6C0f
 dSEBDYwKyb3YMqDx3+h3eqNWP+Y6ZVOoobqotQMILeLRND3IBh8tAd6An84Q+rcazbH3ustCjgI
 /9LgASX4isxzt+5XqL8ZB7p8rIobk+GLy3ARCeNKz3OBzZzuqo5ZkDLzdtXX7W+sPUpsUDGxvaY
 9ow4fSKWhYrtwJ7APYvFs9563Y6udnRNsuer1+l/Iw9DgeLR+Y0clypdOVvfeRUCEQ7tKsdqFBK
 NPwXIabvcNv4MlV47jk8kIEGgfLanKlIT7faKV1s9yjGTmvXttklEr0Evybf/HqanK6vWvpn6cW
 y3kHYyh7BLtjXSRkKHalUMy4XEVJ1i1lTI7tSYxAJEGqiRYPAuQ7plBmTvop32A6kTCslUygIW+
 Pg5+2ZPvMpLIn4l84AnkHNrgj6c5Fqf0HXPVbRafXS28u6xDeNUufzdLrD8iWGoZUroGVCWMJy5
 3K6jbf3PF+vHEoAuUxw==
X-Proofpoint-GUID: Bl_Jw4AZylTicMUrK926OoEz08JR5QyV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX8HYi6aM9lWzD
 ShkaYELWYSryMR96ksLAtsKUGK74ByKTLaV2b6EQxMIzi2hpwCN3iVa+ccQesD3vRHa/lopDYwL
 xXBDv8imp8yXpDIFgsOyO4tgiGdoXA4=
X-Proofpoint-ORIG-GUID: Bl_Jw4AZylTicMUrK926OoEz08JR5QyV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090072
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

From: Konstantin Shkolnyy <kshk@linux.ibm.com>

Extract the pba, pal and g_iota checks from reg_ioat() into a function.
Make it external so that it can also be used in a follow up change.
Provide a new error message to the path that didn't have it.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261006001643.420929-15-kshk@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
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
2.56.0


