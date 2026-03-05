Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17A7F513E1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyHOb-00016z-7u; Thu, 05 Mar 2026 17:42:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vyHOY-00014g-2D; Thu, 05 Mar 2026 17:42:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vyHOW-00076R-70; Thu, 05 Mar 2026 17:42:13 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 625BU8dN725327; Thu, 5 Mar 2026 22:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Op2RTpVwIPg4w0X+r
 n8Jodj6j9xRnIzY4eEPbZmN0LU=; b=J6Ib7l2wl20Mbpnl5P65ZDJKEPkcKHcOg
 oU7IF7v948jTS4ux+C4sCsey6r4kUN2JLa3bZYq4KJSadTD/5SOW/7bVsEHHKHPa
 ZN96PWIkGhThJrDstNasVS9uovzM9BkgO4by9KRt+POGlM3W1/RjmSwbnA/cPCsU
 xctJbdypton8wcPQTcSChzNYg67p644ht4HZrr26mRzqSrjoKRoiTZwBFp9mlNBs
 m04uvvdCNtyMr9iDllS66a2252XMVWO0RInrn+R18+SAywAgtCrlC78wAPtlwvIS
 4KWNQESqYs8YAWV7ofCfO8ZcFo9jDhfXK0bT0e6X8PuFlVFV4ustg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjdnx93-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 22:42:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 625JXM91027733;
 Thu, 5 Mar 2026 22:42:07 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwjn4ke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 22:42:06 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 625Mg6Ea27066898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2026 22:42:06 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 079E658061;
 Thu,  5 Mar 2026 22:42:06 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF29E58059;
 Thu,  5 Mar 2026 22:42:04 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.36.214])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2026 22:42:04 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, jdaley@linux.ibm.com
Subject: [PATCH v9 10/30] s390x/diag: Introduce DIAG 508 for secure IPL
 operations
Date: Thu,  5 Mar 2026 17:41:25 -0500
Message-ID: <20260305224146.664053-11-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305224146.664053-1-zycai@linux.ibm.com>
References: <20260305224146.664053-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69aa06bf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=hXQcL9AfcS-IPDpH2m0A:9
X-Proofpoint-ORIG-GUID: VHFqEpd89ciFb-_AoZAImu8CvMxsDnWj
X-Proofpoint-GUID: VHFqEpd89ciFb-_AoZAImu8CvMxsDnWj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE5NCBTYWx0ZWRfXyuKQk7gVcvOY
 M/PgjlaKZT1BEwbOAJZFJZTB4YVBl/BUCHMLt4dvC8ZhLcQGf0sTkHYvXkBiN94vaS8vn/blKMb
 mWDuDL4WA24XsfnpIrRiAOXUnNSSo+16edRPR4wMXn7ehqB6IlRMg1Iw236pcvjpbmmmLAybmFr
 /Rd47GmZlgQpMtElklZIN2ekLCvnba4U44JKkp5pJdpn1QY0wYx/B2NqTUajLnAQiik3Od50jEb
 dKmrBMvq8JMO3NVZcbOWeqFXaJB5N++S3xkz/P7ULm7z2bk9Oc+LF48nbu03ZTpN1FVLynEP1WG
 LS9fdrujcuvz/9rfWiVWD+o8QgdILFg/33uuZM6SqXQiqqWg/toO82CXE9VOAxPalrV62f4+C/Q
 jRwVcEdKmTggdvlrdlPS5iKLRtmWDNmmxVTNHxScYYuEC5WknRCFn1PspOSEH2m+At2OMTksCeZ
 psdMhRN6AFR5Y90KCpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_06,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050194
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 708253ac91..9a3decef69 100644
--- a/docs/specs/s390x-secure-ipl.rst
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -60,3 +60,21 @@ Subcode 2 - store verification certificates
     contiguously in a VCE (with zero-padding). Following the header, the
     key-id is immediately stored. The hash and certificate data follow and
     may be accessed via the respective offset fields stored in the VCE.
+
+
+Secure IPL Data Structures, Facilities, and Functions
+=====================================================
+
+DIAGNOSE function code 'X'508' - IPL extensions
+---------------------------------------------------
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
index 5326522fda..6d9bdee7e3 100644
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
@@ -640,3 +641,29 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
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
index fb7a99f380..cba431688b 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -101,6 +101,7 @@
 #define DIAG_CERT_STORE                 0x320
 #define DIAG_KVM_HYPERCALL              0x500
 #define DIAG_KVM_BREAKPOINT             0x501
+#define DIAG_SECURE_IPL                 0x508
 
 #define ICPT_INSTRUCTION                0x04
 #define ICPT_PROGRAM                    0x08
@@ -1571,6 +1572,16 @@ static void kvm_handle_diag_320(S390CPU *cpu, struct kvm_run *run)
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
@@ -1604,6 +1615,9 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
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
index b16490bce6..367df65970 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -390,6 +390,8 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
                      uintptr_t ra);
 void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3,
                      uintptr_t ra);
+void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3,
+                     uintptr_t ra);
 
 
 /* translate.c */
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 4d73475d95..562dde9cb3 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -149,6 +149,13 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
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
2.53.0


