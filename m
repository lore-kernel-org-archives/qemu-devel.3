Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24AFC5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 21:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMw79-0002hs-Th; Wed, 04 Jun 2025 17:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw6w-0002db-Qg; Wed, 04 Jun 2025 17:57:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw6t-0006wr-QM; Wed, 04 Jun 2025 17:57:26 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554DilRv017727;
 Wed, 4 Jun 2025 21:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=aQzBqdS5PBbWmKWp0
 +nJDhQ+6wDR0JTC68Kdqf6ClVI=; b=NkqpMNn24P8FQ724f/yTBxwFKlVipOQB5
 lIaJMowyNzhee86jDIuZVV0MgppC2TqU00S3rSan+BaUq+HnvjvkPuV3MYCnm6wt
 GLSLcpmi5xEDc8Dvcc+nDyiG4xC4+7R2B+h+karjC9N6haL4boW/CM/rfBUHoVRS
 7zW4zkFKEK9nrTvYUMQ5nPZk2zf1mQgSOOG062UW0nA4d2tAuR3Eg6idxGza1vGm
 6HIx5BHuOLYn4edj0DruIUp7azs4OxRhegAudNHtTHAw48dUzgg1TUdcOV0q6EWn
 OLUwcOtJeLANmXptNu3aAZePCm9/7IQP7AAcy5Xicbz4JMQxy1LEw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 472fwums1d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 554IuTro031750;
 Wed, 4 Jun 2025 21:57:20 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470cg01ynk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:20 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 554LvI1W11010574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jun 2025 21:57:18 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8576B58050;
 Wed,  4 Jun 2025 21:57:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9C1A58045;
 Wed,  4 Jun 2025 21:57:16 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.211])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jun 2025 21:57:16 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v3 05/28] s390x/diag: Introduce DIAG 320 for certificate store
 facility
Date: Wed,  4 Jun 2025 17:56:33 -0400
Message-ID: <20250604215657.528142-6-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604215657.528142-1-zycai@linux.ibm.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE3NSBTYWx0ZWRfXwVOQEKHxNDs+
 /4aCQTVcUZSDznSssrv2g1Di2N22SVPNqa8CGud9znH3wWjn6u6CtJptwwjMT4GjGsLp9z8Ff02
 Il7obV2aBPrzBLgjPatDUKnlfQIuRdmU4MxqC0CxaXcXFLCVtsv8CYY9qVLwJd09PUrNq9M5Y6X
 VrHsVSzXyGWRF2chUlTVcIBy3Z6zv+zkSgh/TmoaBN0YiQyjDjlUithxNyeICFDrb6IOxWsIujs
 Xc+C9bnVwR53kUVNLs4omcu4KcLJW2gg+nIKLRVGz+TWYjpxWykvyDBA8CTwoG143CnQznFV8Oo
 0sUtRtVsyi8dNZMV5c86vtIyoTcEAv6wBV7bhYdanHCjXDED433S4zCZMon1FzUtN19g37vMITa
 ZSmX8jUaPlWba9XE+pyZxAUxouLp1ungFbR6oeOvz/b+OhgAZZU1JLMPunA/PV56H+aPwzeG
X-Proofpoint-GUID: 7GDIIeH6S91ZXM9t_wnsAmAku4zsSx0D
X-Proofpoint-ORIG-GUID: 7GDIIeH6S91ZXM9t_wnsAmAku4zsSx0D
X-Authority-Analysis: v=2.4 cv=QtVe3Uyd c=1 sm=1 tr=0 ts=6840c140 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=IdV6647qc9uNKfmhuy4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040175
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 include/hw/s390x/ipl/diag320.h | 17 ++++++++++++++
 target/s390x/diag.c            | 41 ++++++++++++++++++++++++++++++++++
 target/s390x/kvm/kvm.c         | 14 ++++++++++++
 target/s390x/s390x-internal.h  |  2 ++
 target/s390x/tcg/misc_helper.c |  7 ++++++
 5 files changed, 81 insertions(+)
 create mode 100644 include/hw/s390x/ipl/diag320.h

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
index cff9fbc4b0..d33c5daf38 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -18,6 +18,7 @@
 #include "hw/watchdog/wdt_diag288.h"
 #include "system/cpus.h"
 #include "hw/s390x/ipl.h"
+#include "hw/s390x/ipl/diag320.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "system/kvm.h"
 #include "kvm/kvm_s390x.h"
@@ -191,3 +192,43 @@ out:
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
index 8f655a4b7f..d5b3694600 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -98,6 +98,7 @@
 #define DIAG_TIMEREVENT                 0x288
 #define DIAG_IPL                        0x308
 #define DIAG_SET_CONTROL_PROGRAM_CODES  0x318
+#define DIAG_CERT_STORE                 0x320
 #define DIAG_KVM_HYPERCALL              0x500
 #define DIAG_KVM_BREAKPOINT             0x501
 
@@ -1560,6 +1561,16 @@ static void handle_diag_318(S390CPU *cpu, struct kvm_run *run)
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
@@ -1590,6 +1601,9 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
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
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index f7101be574..412c34ed93 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -142,6 +142,13 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
         /* time bomb (watchdog) */
         r = handle_diag_288(env, r1, r3);
         break;
+    case 0x320:
+        /* cert store */
+        bql_lock();
+        handle_diag_320(env, r1, r3, GETPC());
+        bql_unlock();
+        r = 0;
+        break;
     default:
         r = -1;
         break;
-- 
2.49.0


