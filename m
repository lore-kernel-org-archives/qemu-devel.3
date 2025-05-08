Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF594C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDA5e-0004B9-AU; Thu, 08 May 2025 18:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5M-00042V-8f; Thu, 08 May 2025 18:51:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5F-0006Rp-Pf; Thu, 08 May 2025 18:51:23 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548LgOkx031808;
 Thu, 8 May 2025 22:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=wlwDnIR3QsT2T/X2a
 oP7EFGRUXEETI9in93kt6MGQSg=; b=N5sWE0Xp5+vGbkkoiJ8aZ8HK0i1Oi2OSE
 LLj1rzqqvvnQLEwTrZiKNFI1dBI8839bDOfoID7C+t1uyQ/JAIlOZw/h3lXw9tn2
 F6uEfrA+xPBSObNxxkEmKroI97AA65ZZmqYBQqVtEW1RTc89IvnWgODhBYT95wHx
 30kprnUYeJ126xExV4o/Erq7Wqjj5c+l2xODCVHbc4ujN66sms7fFTT+qL1ftxMd
 KW9/z48LWnnYU+KTllDaqr0Em4utDnbwnCz3CkdCFx6NlWCjdNGe/0Tp6uspMbTQ
 aAr0HJQMY3yfSsFG/sKxVVCs47TQB9CGrW2X26a+PPZfL59Yl9EUA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h4rw87x9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548MoVu7013880;
 Thu, 8 May 2025 22:51:15 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46e062qrf2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:15 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 548MpDSr28836474
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 May 2025 22:51:14 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCADD5805B;
 Thu,  8 May 2025 22:51:13 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 614655804B;
 Thu,  8 May 2025 22:51:12 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.11.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 May 2025 22:51:12 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v2 04/25] s390x/diag: Introduce DIAG 320 for certificate store
 facility
Date: Thu,  8 May 2025 18:50:20 -0400
Message-ID: <20250508225042.313672-5-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508225042.313672-1-zycai@linux.ibm.com>
References: <20250508225042.313672-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QIxoRhLL c=1 sm=1 tr=0 ts=681d3563 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=_5qUkosOvRWCt7dKJYMA:9
X-Proofpoint-GUID: fSB1Vvh-2oMlQDofr942Lq30ZvcEET_H
X-Proofpoint-ORIG-GUID: fSB1Vvh-2oMlQDofr942Lq30ZvcEET_H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDIwNSBTYWx0ZWRfX7qWpiF0Zg50X
 9NcTOHpqXRJSe2X0JP/ow2jp4R9gIO89RvMQ20R/laCwYj01baclZ6LFWE6bcDbasWGWgrT9Ogb
 pgO/kTQ1AK7DBaKiEtEtNV3vfLAga3S5nEqK2OxHZBd+1pwqb9y9wPBbQvmWxofSnRcwb84MPSk
 V8HYxFb/m9E54TgCeOilml7Orsl3tUY7crMwJYi0O1fEG9ogNOT+6B34Th4jQFY4kVAO8UrbJtA
 nOHd4PU1n0y24FNj4JeVK1puANTbm1N97fU24Vhu/wRxGIg7lUh+gMgkJ5dgudIEq4vZC3Ngoe7
 LkLYVVm06ASCGudMKqLJyg7m1nqhAmvrRdSniMaT6kqZMe8ymavKJ5T4vWpZuls3q5Z7WKjNMd8
 DOAGMGvImr2+7j4tB7a/+nJUlOc3f9FZUCR/9rMRUJ86exJHw777X1UERiqUm8Nn8nrl9K+7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_07,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=899 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080205
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

DIAGNOSE 320 is introduced to support certificate store facility,
which includes operations such as query certificate storage
information and provide certificates in the certificate store.

Currently, only subcode 0 is supported with this patch, which is
used to query a bitmap of which subcodes are supported.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/s390x/ipl.h                 |  1 +
 include/hw/s390x/ipl/diag320.h | 17 +++++++++++++++
 target/s390x/diag.c            | 40 ++++++++++++++++++++++++++++++++++
 target/s390x/kvm/kvm.c         | 14 ++++++++++++
 target/s390x/s390x-internal.h  |  2 ++
 5 files changed, 74 insertions(+)
 create mode 100644 include/hw/s390x/ipl/diag320.h

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index ac1f7517ea..d9c089928e 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -19,6 +19,7 @@
 #include "system/address-spaces.h"
 #include "system/memory.h"
 #include "hw/qdev-core.h"
+#include "hw/s390x/ipl/diag320.h"
 #include "hw/s390x/ipl/qipl.h"
 #include "qom/object.h"
 #include "target/s390x/kvm/pv.h"
diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
new file mode 100644
index 0000000000..713570545d
--- /dev/null
+++ b/include/hw/s390x/ipl/diag320.h
@@ -0,0 +1,17 @@
+/*
+ * S/390 DIAGNOSE 320 definitions and structures
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef S390X_DIAG320_H
+#define S390X_DIAG320_H
+
+#define DIAG_320_SUBC_QUERY_ISM     0
+
+#define DIAG_320_RC_OK              0x0001
+
+#endif
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index da44b0133e..21129dbc91 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -192,3 +192,43 @@ out:
         break;
     }
 }
+
+void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
+{
+    S390CPU *cpu = env_archcpu(env);
+    uint64_t subcode = env->regs[r3];
+    uint64_t addr = env->regs[r1];
+    int rc;
+
+    if (env->psw.mask & PSW_MASK_PSTATE) {
+        s390_program_interrupt(env, PGM_PRIVILEGED, ra);
+        return;
+    }
+
+    if (!s390_has_feat(S390_FEAT_DIAG_320)) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        return;
+    }
+
+    if (r1 & 1) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        return;
+    }
+
+    switch (subcode) {
+    case DIAG_320_SUBC_QUERY_ISM:
+        uint64_t ism =  0;
+
+        if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism, sizeof(ism))) {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
+            return;
+        }
+
+        rc = DIAG_320_RC_OK;
+        break;
+    default:
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        return;
+    }
+    env->regs[r1 + 1] = rc;
+}
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 6bad1713d2..3ae00b9a6d 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -98,6 +98,7 @@
 #define DIAG_TIMEREVENT                 0x288
 #define DIAG_IPL                        0x308
 #define DIAG_SET_CONTROL_PROGRAM_CODES  0x318
+#define DIAG_CERT_STORE                 0x320
 #define DIAG_KVM_HYPERCALL              0x500
 #define DIAG_KVM_BREAKPOINT             0x501
 
@@ -1561,6 +1562,16 @@ static void handle_diag_318(S390CPU *cpu, struct kvm_run *run)
     }
 }
 
+static void kvm_handle_diag_320(S390CPU *cpu, struct kvm_run *run)
+{
+    uint64_t r1, r3;
+
+    r1 = (run->s390_sieic.ipa & 0x00f0) >> 4;
+    r3 = run->s390_sieic.ipa & 0x000f;
+
+    handle_diag_320(&cpu->env, r1, r3, RA_IGNORED);
+}
+
 #define DIAG_KVM_CODE_MASK 0x000000000000ffff
 
 static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
@@ -1591,6 +1602,9 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
     case DIAG_KVM_BREAKPOINT:
         r = handle_sw_breakpoint(cpu, run);
         break;
+    case DIAG_CERT_STORE:
+        kvm_handle_diag_320(cpu, run);
+        break;
     default:
         trace_kvm_insn_diag(func_code);
         kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index a4ba6227ab..86a652f833 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -400,6 +400,8 @@ int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
 int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3);
 void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
                      uintptr_t ra);
+void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3,
+                     uintptr_t ra);
 
 
 /* translate.c */
-- 
2.49.0


