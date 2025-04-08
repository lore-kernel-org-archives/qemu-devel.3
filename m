Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFCDC369A5
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 16:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Bdt-0006pB-09; Tue, 08 Apr 2025 12:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BIn-0005XC-8K; Tue, 08 Apr 2025 11:55:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BIl-0005u4-AZ; Tue, 08 Apr 2025 11:55:52 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538E39d6013856;
 Tue, 8 Apr 2025 15:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=9usmbva3RcXyJXBXB
 +SlmSXPo9062uECSIZMgZFgyFw=; b=DxOFSvadKQMJS3hhFvM0V8NbpJ48GXRbw
 mSl3G50SkeDxgs2Qofzs4GLQwssQEZDGxtUAo6X1EdnOY4MOeGueyF9rOUyKySkv
 Tmdmx1+WeLe+d7BRoWdK1UN8Tj6U7qm88Sp7SefuM/by5XdqiGU5Jen1HhwFwVuz
 PiS6Xfj7+5a+lZ7DSAl2mzR8CMXdAGq7dnMyZ4iQeW2DN5E22mWkYLA8OS7uKv8Q
 qpFFd0sNprL7l7I2TxnKMIUSsxuC5msHi3jvqRZUeSRf8X2pccxn7fNMSTCIjv49
 uFPlca550gbSF8jqUJiQqwRo1Yumcx+SF3QGDA25vvFKn3AV24Pcg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45w57prkvw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:55:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538DA81E018432;
 Tue, 8 Apr 2025 15:55:44 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2kk5bh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:55:44 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 538FthB020775622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 15:55:43 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C2645803F;
 Tue,  8 Apr 2025 15:55:43 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D36758055;
 Tue,  8 Apr 2025 15:55:41 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.125.94])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Apr 2025 15:55:41 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v1 08/24] s390x/diag: Introduce DIAG 508 for secure IPL
 operations
Date: Tue,  8 Apr 2025 11:55:10 -0400
Message-ID: <20250408155527.123341-9-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408155527.123341-1-zycai@linux.ibm.com>
References: <20250408155527.123341-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ReabiHjhRYRiPOfJ6bnhKLNstPXVoZXv
X-Proofpoint-GUID: ReabiHjhRYRiPOfJ6bnhKLNstPXVoZXv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080107
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 08 Apr 2025 12:17:35 -0400
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

From: Collin Walling <walling@linux.ibm.com>

In order to support secure IPL (aka secure boot) for the s390-ccw BIOS,
a new s390 DIAGNOSE instruction is introduced to leverage QEMU for
handling operations such as signature verification and certificate
retrieval.

Currently, only subcode 0 is supported with this patch, which is used to
query a bitmap of which subcodes are supported.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---
 hw/s390x/ipl.h                 |  1 +
 include/hw/s390x/ipl/diag508.h | 17 +++++++++++++++++
 target/s390x/diag.c            | 26 ++++++++++++++++++++++++++
 target/s390x/kvm/kvm.c         | 14 ++++++++++++++
 target/s390x/s390x-internal.h  |  2 ++
 5 files changed, 60 insertions(+)
 create mode 100644 include/hw/s390x/ipl/diag508.h

diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 822535ad76..e9ef8ddccd 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -18,6 +18,7 @@
 #include "exec/address-spaces.h"
 #include "hw/qdev-core.h"
 #include "hw/s390x/ipl/diag320.h"
+#include "hw/s390x/ipl/diag508.h"
 #include "hw/s390x/ipl/qipl.h"
 #include "qom/object.h"
 
diff --git a/include/hw/s390x/ipl/diag508.h b/include/hw/s390x/ipl/diag508.h
new file mode 100644
index 0000000000..83c4439cb2
--- /dev/null
+++ b/include/hw/s390x/ipl/diag508.h
@@ -0,0 +1,17 @@
+/*
+ * S/390 DIAGNOSE 508 definitions and structures
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Collin Walling <walling@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef S390X_DIAG508_H
+#define S390X_DIAG508_H
+
+#define DIAG_508_SUBC_QUERY_SUBC    0x0000
+
+#endif
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 82e4dc9e1e..ad7f4b5025 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -488,3 +488,29 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
     }
     env->regs[r1 + 1] = rc;
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
index b013751478..a5c5150c04 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -101,6 +101,7 @@
 #define DIAG_CERT_STORE                 0x320
 #define DIAG_KVM_HYPERCALL              0x500
 #define DIAG_KVM_BREAKPOINT             0x501
+#define DIAG_SECURE_IPL                 0x508
 
 #define ICPT_INSTRUCTION                0x04
 #define ICPT_PROGRAM                    0x08
@@ -1572,6 +1573,16 @@ static void kvm_handle_diag_320(S390CPU *cpu, struct kvm_run *run)
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
@@ -1605,6 +1616,9 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
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
index 86a652f833..df0973266a 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -402,6 +402,8 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
                      uintptr_t ra);
 void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3,
                      uintptr_t ra);
+void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3,
+                     uintptr_t ra);
 
 
 /* translate.c */
-- 
2.49.0


