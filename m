Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AB1C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzD7X-0007pO-F5; Wed, 26 Aug 2026 08:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7S-0007hi-9N; Wed, 26 Aug 2026 08:52:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7L-0002Uu-N5; Wed, 26 Aug 2026 08:52:42 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCW3o83893871; Wed, 26 Aug 2026 12:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=HH4l1ggSylDSfHc3f
 pEVFK7ZDxx9vMZH7iFqrp3lVQs=; b=tYrJvcJNZiGsv3Z/kC6YydUqG3SI4ftpS
 M5TqK5uUd7HifkB3Ffd7ZR8UDI18Yivyewjzi14SB4KWUsmEfXufBr74aMH0G9cM
 MKMmn5nTQcpjnmjgccWEmC3525FTyEF2HRPNkfdqBrQCDqju4nBS/z/mFUTtxtFJ
 ZcfnOWypDsGTVrKpLnzi6eUN2/GfiKE7s/aDSIksyEAAz5NsWgXLLQRueMKB8x35
 JnGz/bl8bYTwSzp383AqxqY8T6k/39eCOy2mDfG2XgCz5SR8nLzQaQ93BXIy5GrD
 o8js1gQasbreX7PvTZ1GXMjDYK9B1r8hR54P2AW+GOco7NgX7jYMQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hxs96-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCfNPR018852;
 Wed, 26 Aug 2026 12:52:33 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7raghsxx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QCqVtb56492388
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 12:52:31 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C44705805B;
 Wed, 26 Aug 2026 12:52:31 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C64E458059;
 Wed, 26 Aug 2026 12:52:30 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.78.161]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 12:52:30 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>,
 Farhan Ali <alifm@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 13/37] s390x/diag: Introduce DIAG 508 for secure IPL operations
Date: Wed, 26 Aug 2026 08:51:48 -0400
Message-ID: <20260826125213.1901252-14-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826125213.1901252-1-farman@linux.ibm.com>
References: <20260826125213.1901252-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfXxM8IjYgiyi13
 gDmBihxxHl5cVMibvgqFJ66tQceprFNd+N/wJLp81HBFVxYob1lVBKNWrEkfNKWjj/3nrcEhYcE
 A23Wf3LcJ5SdFramcNn/EERoY7Eh/Og=
X-Proofpoint-GUID: bd4giohPy7TjszdF7slFvunL45GemFub
X-Proofpoint-ORIG-GUID: bd4giohPy7TjszdF7slFvunL45GemFub
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfXzHFs3CWpYTNo
 ZSvuAihdj/oldKLg2hfuajgfv2Q9vhbrUz4F3I7o33K/LLpMfX+fYqwQRSPGmVrM6jauhQnAQOo
 iJ2OuCQR3i9z3CBX06Qpl/QESev/IMihnKM3TYmWuyS56s1xK7eOaDZuPrsRkBvjzG1E2GmwNV9
 p5eqt+5vm008L9jz0SkOhF6kRz4GdxNDQwG+ikIFO8mjv3Xb4otonPuRTEoJdDaTKAzwbvmwyaP
 u31HZaVY/LRvjiR5BSLZMY8BXUkf7o9OwGUgRy9zIjU/u5YmoNdqi4h4V3STJtnRfSsoJ1F11kX
 sqjiHjWCfVfjNsJIg+2+H5L7ZP7ep7n3q7W1uON+VfiJBIcMN6I/ethhhKXVvo3VbCBJjcQv2kN
 rKI8De2/vfRR7WF+xLyBQVBHRJuT/Yb5PnL73mEvNc3Qd/X4IAQQpCrBhzCAM3t6WqCjLMEZ29N
 eXuU6UXWDJdM96UbBZg==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8ee192 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=hXQcL9AfcS-IPDpH2m0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260104
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

From: Collin Walling <walling@linux.ibm.com>

In order to support secure IPL (aka secure boot) for the s390-ccw BIOS,
a new s390 DIAGNOSE instruction is introduced to leverage QEMU for
handling operations such as signature verification and certificate
retrieval.

Currently, only subcode 0 is supported with this patch, which is used to
query a bitmap of which subcodes are supported.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260730214624.2328883-12-zycai@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 docs/specs/s390x-secure-ipl.rst | 18 ++++++++++++++++++
 include/hw/s390x/ipl/diag508.h  | 15 +++++++++++++++
 target/s390x/diag.c             | 27 +++++++++++++++++++++++++++
 target/s390x/kvm/kvm.c          | 14 ++++++++++++++
 target/s390x/s390x-internal.h   |  2 ++
 target/s390x/tcg/misc_helper.c  |  7 +++++++
 6 files changed, 83 insertions(+)
 create mode 100644 include/hw/s390x/ipl/diag508.h

diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
index 99052041c1..776270d816 100644
--- a/docs/specs/s390x-secure-ipl.rst
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -66,3 +66,21 @@ Subcode 2 - store verification certificates
     contiguously in a VCE (with zero-padding). Following the header, the
     key-id is immediately stored. The hash and certificate data follow and
     may be accessed via the respective offset fields stored in the VCE.
+
+
+Secure IPL Data Structures, Facilities, and Functions
+-----------------------------------------------------
+
+DIAGNOSE function code 'X'508' - IPL extensions
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+DIAGNOSE 'X'508' is reserved for guest use in order to facilitate communication
+of additional IPL operations that cannot be handled by guest code, such as
+signature verification for secure IPL.
+
+If the function code specifies 0x508, IPL extension functions are performed.
+These functions are meant to provide extended functionality for s390 guest boot
+that requires assistance from QEMU.
+
+Subcode 0 - query installed subcodes
+    Returns a 64-bit mask indicating which subcodes are supported.
diff --git a/include/hw/s390x/ipl/diag508.h b/include/hw/s390x/ipl/diag508.h
new file mode 100644
index 0000000000..6281ad8299
--- /dev/null
+++ b/include/hw/s390x/ipl/diag508.h
@@ -0,0 +1,15 @@
+/*
+ * S/390 DIAGNOSE 508 definitions and structures
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Collin Walling <walling@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef S390X_DIAG508_H
+#define S390X_DIAG508_H
+
+#define DIAG_508_SUBC_QUERY_SUBC    0x0000
+
+#endif
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 4105ba299b..3e5ddc8c9a 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -20,6 +20,7 @@
 #include "hw/s390x/cert-store.h"
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/ipl/diag320.h"
+#include "hw/s390x/ipl/diag508.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "system/kvm.h"
 #include "kvm/kvm_s390x.h"
@@ -618,3 +619,29 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
         break;
     }
 }
+
+void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
+{
+    uint64_t subcode = env->regs[r3];
+    int rc;
+
+    if (env->psw.mask & PSW_MASK_PSTATE) {
+        s390_program_interrupt(env, PGM_PRIVILEGED, ra);
+        return;
+    }
+
+    if ((subcode & ~0x0ffffULL) || (r1 & 1)) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        return;
+    }
+
+    switch (subcode) {
+    case DIAG_508_SUBC_QUERY_SUBC:
+        rc = 0;
+        break;
+    default:
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        return;
+    }
+    env->regs[r1 + 1] = rc;
+}
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 70ef92f5ab..10cee19860 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -102,6 +102,7 @@
 #define DIAG_CERT_STORE                 0x320
 #define DIAG_KVM_HYPERCALL              0x500
 #define DIAG_KVM_BREAKPOINT             0x501
+#define DIAG_SECURE_IPL                 0x508
 
 #define ICPT_INSTRUCTION                0x04
 #define ICPT_PROGRAM                    0x08
@@ -1542,6 +1543,16 @@ static void kvm_handle_diag_320(S390CPU *cpu, struct kvm_run *run)
     handle_diag_320(&cpu->env, r1, r3, RA_IGNORED);
 }
 
+static void kvm_handle_diag_508(S390CPU *cpu, struct kvm_run *run)
+{
+    uint64_t r1, r3;
+
+    r1 = (run->s390_sieic.ipa & 0x00f0) >> 4;
+    r3 = run->s390_sieic.ipa & 0x000f;
+
+    handle_diag_508(&cpu->env, r1, r3, RA_IGNORED);
+}
+
 #define DIAG_KVM_CODE_MASK 0x000000000000ffff
 
 static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
@@ -1575,6 +1586,9 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
     case DIAG_CERT_STORE:
         kvm_handle_diag_320(cpu, run);
         break;
+    case DIAG_SECURE_IPL:
+        kvm_handle_diag_508(cpu, run);
+        break;
     default:
         trace_kvm_insn_diag(func_code);
         kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 1945bdf40c..81da207a5f 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -390,6 +390,8 @@ bool handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
                      uintptr_t ra);
 void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3,
                      uintptr_t ra);
+void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3,
+                     uintptr_t ra);
 
 
 /* translate.c */
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 403388145e..f1c8563af0 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -154,6 +154,13 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
         bql_unlock();
         r = 0;
         break;
+    case 0x508:
+        /* secure ipl operations */
+        bql_lock();
+        handle_diag_508(env, r1, r3, GETPC());
+        bql_unlock();
+        r = 0;
+        break;
     default:
         r = -1;
         break;
-- 
2.55.0


