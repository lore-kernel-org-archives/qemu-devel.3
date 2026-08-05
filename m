Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739ADC56201
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 10:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrZ0U-000467-9n; Wed, 05 Aug 2026 06:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1wrZ0L-00044s-Pf; Wed, 05 Aug 2026 06:37:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imbrenda@linux.ibm.com>)
 id 1wrZ0J-0004v5-O8; Wed, 05 Aug 2026 06:37:45 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6758lqAW1503380; Wed, 5 Aug 2026 10:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=jelpUAT3EMGvZL9A8
 pwTdusX4Cy6Zh9PA5uODLpoQWY=; b=PgG8+gDfECtqozv9vniuWVfR9NRnvqxlZ
 cg/22cFTNkNupcM5wQ/W6aV6zGpMU4DgDVrVKFJnlLLh7Y7J9jFLynw3KfS9uLcY
 zpc83ETOL1J3P+T3yRKaFRh87ojeJP05GCvsTVzwZafnFrOXUGO1sd0vvLoz6sjZ
 PDbHUatZKUnwZq2byLUDMYF5k7ORSuqBJ/wZx5G5mE2enebnfT33VLs2EHfE0iLr
 hWcAODbZTg+Kxo7tvgrzGEexLuCI0fNuk3ZSnIINCK3Xu+SMD8PS+yNPHQmK/vgj
 yhrJiBeEr6ePvseAErwlbVEJ2S6VoCBGif6fhYkK0EnYomJAERUfg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqtgfk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 10:37:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675AQVkN010120;
 Wed, 5 Aug 2026 10:37:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhe2e2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 10:37:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 675AbTR630606020
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Aug 2026 10:37:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C3A020043;
 Wed,  5 Aug 2026 10:37:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2026C2004E;
 Wed,  5 Aug 2026 10:37:29 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Aug 2026 10:37:29 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, mhartmay@linux.ibm.com, david@kernel.org,
 farman@linux.ibm.com, mjrosato@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v3 1/1] target/s390x: Allow 2G hugepages guest backing
Date: Wed,  5 Aug 2026 12:37:28 +0200
Message-ID: <20260805103728.97602-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805103728.97602-1-imbrenda@linux.ibm.com>
References: <20260805103728.97602-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MVHILpBoxKChicSsNCUToat4bk-fBHKI
X-Proofpoint-ORIG-GUID: MVHILpBoxKChicSsNCUToat4bk-fBHKI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4MSBTYWx0ZWRfX6bzg66CPvn2w
 Q5Yn/vTIGWg08RU68X82qE8eTbNek45O76xbtTwIZKIGPJI37hu5cmTdUWmCoCu4kmSLC+tZ18x
 OJKZdYbvOmGQMd5HpdpYWE9qwunPnJQ=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a731271 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=PXhQOlaz77BmCqgndx4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4MSBTYWx0ZWRfXwpSANtcLY+WT
 4DDO9KbqXkB7c9KclMXI94d3mKOHSHqTICE7SwWy27pQlilJrKv07BlX9XSrmeztzSJ8BV5kfcL
 0KUV9X9M1U4iGR8gD5Eu4gJQ4xsfpVS9fpXcrYlGyJ0+8OqZ6JpkDNtDq57pZAUzq7CMNspmV9e
 iamX4vSD5ixQnY7d48hO/mRweh6ayOBKYgwY2yiSF5S7ziTTdvEg6KUSAkdRPvpFJhJUhEXTdHq
 0HaeFeeuWmubva7HK96n0gIMrKdJOiRP2DzWEdFG9nRXQ8ecVS5XQZHXSIda0Iuq4F5OlCDj0tn
 f0aRVjDWv2cC8WeNCNCivbuhA7tRhH1uEXFn28ImG1WnNo+XBr2bdLZUQ5wD4XQ0Zsrg/WTI4In
 18DC5W5AJksFnu0/GC3+sRBRCNIeLTBKqe8jFeIV0LUQ2mckpPuxEpziI6v589PBNdq0MVuuc6S
 aN0nS/3i3F9h8jN9NSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050081
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

Rename kvm_s390_get_hpage_1m() to kvm_s390_get_hpage() to reflect that
it is not anymore limited only to 1m hpages.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 target/s390x/diag.c          |  2 +-
 target/s390x/kvm/kvm.c       | 36 +++++++++++++++++-------------------
 target/s390x/kvm/kvm_s390x.h |  2 +-
 target/s390x/kvm/stubs.c     |  2 +-
 4 files changed, 20 insertions(+), 22 deletions(-)

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
index 72031a5714..803b878b4f 100644
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
@@ -292,30 +292,28 @@ void kvm_s390_crypto_reset(void)
     }
 }
 
-void kvm_s390_set_max_pagesize(uint64_t pagesize, Error **errp)
+static bool kvm_s390_pgsize_cap(uint32_t capa, const char *s, Error **errp)
 {
-    if (pagesize == 4 * KiB) {
-        return;
-    }
-
-    if (pagesize != 1 * MiB) {
-        error_setg(errp, "Memory backing with 2G pages was specified, "
-                   "but KVM does not support this memory backing");
-        return;
+    if (kvm_vm_enable_cap(kvm_state, capa, 0)) {
+        error_setg(errp, "Memory backing with %s pages was specified, "
+                   "but KVM does not support this memory backing", s);
+        return false;
     }
+    return true;
+}
 
-    if (kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_HPAGE_1M, 0)) {
-        error_setg(errp, "Memory backing with 1M pages was specified, "
-                   "but KVM does not support this memory backing");
-        return;
+void kvm_s390_set_max_pagesize(uint64_t pagesize, Error **errp)
+{
+    if (pagesize == MiB) {
+        cap_hpage = kvm_s390_pgsize_cap(KVM_CAP_S390_HPAGE_1M, "1M", errp);
+    } else if (pagesize != 4 * KiB) {
+        cap_hpage = 2 * kvm_s390_pgsize_cap(KVM_CAP_S390_HPAGE_2G, "2G", errp);
     }
-
-    cap_hpage_1m = 1;
 }
 
-int kvm_s390_get_hpage_1m(void)
+int kvm_s390_get_hpage(void)
 {
-    return cap_hpage_1m;
+    return cap_hpage;
 }
 
 static void ccw_machine_class_foreach(ObjectClass *oc, void *opaque)
diff --git a/target/s390x/kvm/kvm_s390x.h b/target/s390x/kvm/kvm_s390x.h
index 7b1cce3e60..3c4fa0489c 100644
--- a/target/s390x/kvm/kvm_s390x.h
+++ b/target/s390x/kvm/kvm_s390x.h
@@ -25,7 +25,7 @@ void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code);
 int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
 void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
 int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
-int kvm_s390_get_hpage_1m(void);
+int kvm_s390_get_hpage(void);
 int kvm_s390_get_protected_dump(void);
 int kvm_s390_get_ri(void);
 int kvm_s390_get_zpci_op(void);
diff --git a/target/s390x/kvm/stubs.c b/target/s390x/kvm/stubs.c
index 196127baa5..ebf3c83994 100644
--- a/target/s390x/kvm/stubs.c
+++ b/target/s390x/kvm/stubs.c
@@ -143,7 +143,7 @@ int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
     g_assert_not_reached();
 }
 
-int kvm_s390_get_hpage_1m(void)
+int kvm_s390_get_hpage(void)
 {
     g_assert_not_reached();
 }
-- 
2.55.0


