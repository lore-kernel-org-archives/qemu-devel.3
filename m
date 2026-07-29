Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515ADC53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp7BM-0003ev-Bl; Wed, 29 Jul 2026 12:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1wp7BK-0003eM-OZ; Wed, 29 Jul 2026 12:30:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1wp7BI-0002hI-Us; Wed, 29 Jul 2026 12:30:58 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TFHdx0388661; Wed, 29 Jul 2026 16:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KLj+9efMW6Dbcz1Ec
 LDnrFRq7apC/LI+1LslC0FXaxQ=; b=YHTz0+XZwmnXLWWSbzgQoXwVLris0sNSU
 cwSzlviAWF5RRw4/yWvzNN0EBoCniip+PbohTTRh/azAfJn4ikOd+ym1TIoywuoj
 ThxhvlgbCBQOd4jw8dkJh7gUxNOCGQbb/RxLvKWkXN5yODzoKzZiVHF/y/g5CaxU
 GR0BQRj82FXrG4qReffSFTREBrhQlr/tyB/y/SgIT2BJ0Qvr3rxcyXNSt2+KzJe9
 VrzFQgZzyxWyJeW3jqsVT3hPgUUtsBwXLREAZNG9PVoJPjCwytspPBBNir9fbwXs
 YuPnrv6tLbibNOzlf5GftW8JPzeRtKuyf+sxJ4hWgk+m/jsv9cnIQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xupey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 16:30:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TGQHrK001393;
 Wed, 29 Jul 2026 16:30:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw7m6m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 16:30:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66TGUipa31195526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jul 2026 16:30:44 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88D8720040;
 Wed, 29 Jul 2026 16:30:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C62B2004D;
 Wed, 29 Jul 2026 16:30:44 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Jul 2026 16:30:44 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, mhartmay@linux.ibm.com, david@kernel.org,
 farman@linux.ibm.com, mjrosato@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v2 1/1] target/s390x: Allow 2G hugepages guest backing
Date: Wed, 29 Jul 2026 18:30:43 +0200
Message-ID: <20260729163043.843517-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729163043.843517-1-imbrenda@linux.ibm.com>
References: <20260729163043.843517-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: O2nlvfCUf6WXMBtc6lp26hHKDgEdzgKF
X-Proofpoint-ORIG-GUID: O2nlvfCUf6WXMBtc6lp26hHKDgEdzgKF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyOSBTYWx0ZWRfX7lZ5jGK66Y48
 p/8sXTv/lZ8KHNM8fIGGBpXh4ZU64Obs3zIHqhalMXnUHUxtBKI3iT4Oz1FiZAJ3cxeXTRlSGJm
 2ggQYGJV5rcxj44Ft1CMNN/duCVSLUE=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6a2abb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=RpK2uShi9j4Msmr7ABsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyOSBTYWx0ZWRfX/Z9Wb0EO216W
 khuC1qP1TrxT1ncwU+b8FQrhLu8mTGPAgALbBwODO2tjU6O5sMlf+q4A40a6OQRmjfUNWNdgTVW
 Qa+5415x96L9pm3/iZAbjLnoXRsUasfAsyB5US7XPMCz1ofLSRQFUjc9P9Hk8s3TL9Rywru2ZTl
 E7sM6tyzVqGTAbDZN1VGtarxwRkuAQ6hx8QR3uD6MR+583eZ2l4mzfO1IZdlTEsRjCufF4R6A33
 pO5YjO2Ur6sotxS/TSiECR6ObXJ4sVHiWaGLEtwf3Em4rCTB6DtheqMtYr7istiE/EHZbKrC+EO
 aaylFAKs1oAttfCdHPEAY+iy3V9GPNQQzwAitFZvbOKxM5fzVOi5Z+wDfYvZ5IgTdAtylgY9Ecm
 uD9ALTQJSf0asok45pIoxuicbUsEFuItmInNh/HaLDNRRX1rp5Y0FIu1t4llukRQvE5XewYEuZt
 FZs1HhKwfqtxvm3XKUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290129
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=imbrenda@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Allow mapping guest with 2G hugepages on hosts that support it.

Add new helper functions to check whether hpages are in effect, and
which size.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 target/s390x/diag.c          |  2 +-
 target/s390x/kvm/kvm.c       | 40 +++++++++++++++++++++++-------------
 target/s390x/kvm/kvm_s390x.h |  2 ++
 target/s390x/kvm/stubs.c     | 10 +++++++++
 4 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 80f0958478..46d191b87d 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -185,7 +185,7 @@ out:
             return false;
         }
 
-        if (kvm_enabled() && kvm_s390_get_hpage_1m()) {
+        if (kvm_enabled() && kvm_s390_get_hpage()) {
             error_report("Protected VMs can currently not be backed with "
                          "huge pages");
             env->regs[r1 + 1] = DIAG_308_RC_INVAL_FOR_PV;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 72031a5714..0d04e940ef 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -145,7 +145,7 @@ static int cap_mem_op;
 static int cap_mem_op_extension;
 static int cap_s390_irq;
 static int cap_ri;
-static int cap_hpage_1m;
+static int cap_hpage;
 static int cap_vcpu_resets;
 static int cap_protected;
 static int cap_zpci_op;
@@ -231,7 +231,7 @@ static void kvm_s390_enable_cmma(void)
         .attr = KVM_S390_VM_MEM_ENABLE_CMMA,
     };
 
-    if (cap_hpage_1m) {
+    if (cap_hpage) {
         warn_report("CMM will not be enabled because it is not "
                     "compatible with huge memory backings.");
         return;
@@ -298,24 +298,36 @@ void kvm_s390_set_max_pagesize(uint64_t pagesize, Error **errp)
         return;
     }
 
-    if (pagesize != 1 * MiB) {
-        error_setg(errp, "Memory backing with 2G pages was specified, "
-                   "but KVM does not support this memory backing");
-        return;
-    }
-
-    if (kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_HPAGE_1M, 0)) {
-        error_setg(errp, "Memory backing with 1M pages was specified, "
-                   "but KVM does not support this memory backing");
-        return;
+    if (pagesize == 2 * GiB) {
+        if (kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_HPAGE_2G, 0)) {
+            error_setg(errp, "Memory backing with 2G pages was specified, "
+                       "but KVM does not support this memory backing");
+            return;
+        }
+        cap_hpage = 2;
+    } else if (pagesize == MiB) {
+        if (kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_HPAGE_1M, 0)) {
+            error_setg(errp, "Memory backing with 1M pages was specified, "
+                       "but KVM does not support this memory backing");
+            return;
+        }
+        cap_hpage = 1;
     }
+}
 
-    cap_hpage_1m = 1;
+int kvm_s390_get_hpage(void)
+{
+    return cap_hpage;
 }
 
 int kvm_s390_get_hpage_1m(void)
 {
-    return cap_hpage_1m;
+    return cap_hpage == 1;
+}
+
+int kvm_s390_get_hpage_2g(void)
+{
+    return cap_hpage == 2;
 }
 
 static void ccw_machine_class_foreach(ObjectClass *oc, void *opaque)
diff --git a/target/s390x/kvm/kvm_s390x.h b/target/s390x/kvm/kvm_s390x.h
index 7b1cce3e60..ccc615abed 100644
--- a/target/s390x/kvm/kvm_s390x.h
+++ b/target/s390x/kvm/kvm_s390x.h
@@ -25,7 +25,9 @@ void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code);
 int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
 void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
 int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
+int kvm_s390_get_hpage(void);
 int kvm_s390_get_hpage_1m(void);
+int kvm_s390_get_hpage_2g(void);
 int kvm_s390_get_protected_dump(void);
 int kvm_s390_get_ri(void);
 int kvm_s390_get_zpci_op(void);
diff --git a/target/s390x/kvm/stubs.c b/target/s390x/kvm/stubs.c
index 196127baa5..06e865f806 100644
--- a/target/s390x/kvm/stubs.c
+++ b/target/s390x/kvm/stubs.c
@@ -143,11 +143,21 @@ int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
     g_assert_not_reached();
 }
 
+int kvm_s390_get_hpage(void)
+{
+    g_assert_not_reached();
+}
+
 int kvm_s390_get_hpage_1m(void)
 {
     g_assert_not_reached();
 }
 
+int kvm_s390_get_hpage_2g(void)
+{
+    g_assert_not_reached();
+}
+
 void kvm_s390_enable_css_support(S390CPU *cpu)
 {
     g_assert_not_reached();
-- 
2.55.0


