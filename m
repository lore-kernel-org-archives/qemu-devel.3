Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7351AC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 23:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whExO-0006nK-Bi; Tue, 07 Jul 2026 19:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whExM-0006n1-Se; Tue, 07 Jul 2026 19:12:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whExK-0008HI-MO; Tue, 07 Jul 2026 19:12:00 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667MnawD186337; Tue, 7 Jul 2026 23:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=67ONtZt2Qv6+ZdYZi
 +v04kyk6VqVMDzlt8oCuJTyrVQ=; b=APjiz6VgtuLFgrWiic6/UGhdGR+iPGiRZ
 xHCSu+a7jwXf+P7rJWcxuWj1f9HUgk/V5nTuzjdYq30Thjco3dkuMraEtlCXNEE9
 MuIGlT10EXaYADzt2WRRhsQUWZhvsXOg+O08vpK4YH+8UcPKfW8Da6rVDK0fB7UP
 RLyh+IwW+/97KrONGpo6jeid7bb7qpLG54I4cbT2OKmI4QI4d0Uy2u2pO3vJTMDi
 Pe+xp9VaROIfinLgSAG+MMHVQY0uLfr0YiYox482NMWc4U5x5zSuLmL/OwYEXBJz
 l/l9l21QEK+guXN0n/CIwVRR9SzeBA7hT3hpivRtWT0VPU2SPgHNQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdt8gp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:11:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667N4kGZ017966;
 Tue, 7 Jul 2026 23:11:54 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgk52pw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:11:54 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667NBJlB5898896
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 23:11:19 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D0F458045;
 Tue,  7 Jul 2026 23:11:53 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37E9A58050;
 Tue,  7 Jul 2026 23:11:50 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.32.2])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 23:11:50 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v16 05/33] s390x/diag: Introduce DIAG 320 for Certificate
 Store Facility
Date: Tue,  7 Jul 2026 19:11:03 -0400
Message-ID: <20260707231132.2492104-6-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707231132.2492104-1-zycai@linux.ibm.com>
References: <20260707231132.2492104-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4d87bb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=mM8oulnVqnlOJU-pfAMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIyNCBTYWx0ZWRfX+aHkyaf+EjZV
 Vivvb+S9PCjpxIeTqA2OY7s8ucQUse4xuPO1l+zs/bnXjje3wltsv50UDGw4mslKffdNU/kkLAa
 o9V6NNhfmpoVDYBiB6NjM2nPG1kQJHeJ8+9p7m2Asi+gnPkWg5xJzY1CLJfue/Y0iQku9BwYhat
 kqdwaXJ6LVyKap78qB/bsq2kY8kL+ZSvlAgixNszZal0oag5ipEZSQtHmijzt0sBoA7oBPPpOvN
 VHAaUiM8h7t+LrwnTIXybIumtA/HcQ4jUjurhNczYWNorA2rjhdZjt+6bdeucFOHgB7qYZ6NrVz
 ASBv/dErKTpT4IWElhFfAoWycrazNedYtF348/UUs0qyJQEUUqZZYmtIb3K3ZMpGTUj8c9hpois
 1+SJT74yAncMwcXwIs/1HJawMy5FCaNnKLkGgW0lYn1f/CdeopJweoEKGFs8T20lNprzBGq3WMg
 EZNL+PraFAytNBEdtfQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIyNCBTYWx0ZWRfX96X+qWEnVKRU
 k+fSyw4onW5Ao8bLoYWt4D4OVa2KkSPHQoTPTFtm3YXCkh6jTfI1d7Zs9wkI48ATxSQk2c9KcSx
 bmZD1zHAdLw/ujlV/K8ZrLgJVeoxp98=
X-Proofpoint-GUID: VmiRjGMOBdiNJpycDHtB3x2t-PTVlfMj
X-Proofpoint-ORIG-GUID: VmiRjGMOBdiNJpycDHtB3x2t-PTVlfMj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070224
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

DIAGNOSE 320 is introduced to support Certificate Store (CS)
Facility, which includes operations such as query certificate
storage information and provide certificates in the certificate
store.

Currently, only subcode 0 is supported with this patch, which is
used to query the Installed Subcodes Mask (ISM).

This subcode is only supported when the CS facility is enabled.

Availability of CS facility is determined by byte 134 bit 5 of the
SCLP Read Info block. Byte 134's facilities cannot be represented
without the availability of the extended-length-SCCB, so add it as
a check for consistency.

Note: secure IPL is not available for Secure Execution (SE) guests,
as their images are already integrity protected, and an additional
protection of the kernel by secure IPL is not necessary.

This feature is available starting with the gen16 CPU model.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 docs/specs/s390x-secure-ipl.rst     | 12 +++++++++
 include/hw/s390x/ipl/diag320.h      | 20 ++++++++++++++
 target/s390x/cpu_features.c         |  1 +
 target/s390x/cpu_features_def.h.inc |  1 +
 target/s390x/cpu_models.c           |  2 ++
 target/s390x/diag.c                 | 42 +++++++++++++++++++++++++++++
 target/s390x/gen-features.c         |  3 +++
 target/s390x/kvm/kvm.c              | 16 +++++++++++
 target/s390x/s390x-internal.h       |  2 ++
 target/s390x/tcg/misc_helper.c      |  7 +++++
 10 files changed, 106 insertions(+)
 create mode 100644 include/hw/s390x/ipl/diag320.h

diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
index 9222ad9c12..cc497ea09a 100644
--- a/docs/specs/s390x-secure-ipl.rst
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -18,3 +18,15 @@ PEM Base64 data.
 
 Note: A maximum of 64 certificates are allowed to be stored in the certificate
 store.
+
+DIAGNOSE function code 'X'320' - Certificate Store Facility
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+DIAGNOSE 'X'320' is used to provide support for guest code to directly
+query the s390 certificate store. Guest code may be the s390-ccw BIOS or
+the guest kernel.
+
+Subcode 0 - query installed subcodes
+    Returns a 256-bit installed subcodes mask (ISM) stored in the installed
+    subcodes block (ISB). This mask indicates which subcodes are currently
+    installed and available for use.
diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
new file mode 100644
index 0000000000..aa04b699c6
--- /dev/null
+++ b/include/hw/s390x/ipl/diag320.h
@@ -0,0 +1,20 @@
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
+#define DIAG_320_RC_NOT_SUPPORTED   0x0102
+
+#define DIAG_320_ISM_QUERY_SUBCODES 0x80000000
+
+#endif
diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 896914888a..c6cd411e04 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -147,6 +147,7 @@ void s390_fill_feat_block(const S390FeatBitmap features, S390FeatType type,
         break;
     case S390_FEAT_TYPE_SCLP_FAC134:
         clear_be_bit(s390_feat_def(S390_FEAT_DIAG_318)->bit, data);
+        clear_be_bit(s390_feat_def(S390_FEAT_CERT_STORE)->bit, data);
         break;
     case S390_FEAT_TYPE_SCLP_FAC139:
         clear_be_bit(s390_feat_def(S390_FEAT_SIE_ASTFLEIE2)->bit, data);
diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index a822f0f2fe..ae96f2381f 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -138,6 +138,7 @@ DEF_FEAT(SIE_IBS, "ibs", SCLP_CONF_CHAR_EXT, 10, "SIE: Interlock-and-broadcast-s
 
 /* Features exposed via SCLP SCCB Facilities byte 134 (bit numbers relative to byte-134) */
 DEF_FEAT(DIAG_318, "diag318", SCLP_FAC134, 0, "Control program name and version codes")
+DEF_FEAT(CERT_STORE, "cstore", SCLP_FAC134, 5, "Certificate Store functions")
 
 /* Features exposed via SCLP SCCB Facilities byte 139 (bit numbers relative to byte-139) */
 DEF_FEAT(SIE_ASTFLEIE2, "astfleie2", SCLP_FAC139, 1, "SIE: ASTFLE interpretation execution facility 2")
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 2dd9aac807..14db9c085e 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -248,6 +248,7 @@ bool s390_has_feat(S390Feat feat)
     if (s390_is_pv()) {
         switch (feat) {
         case S390_FEAT_DIAG_318:
+        case S390_FEAT_CERT_STORE:
         case S390_FEAT_HPMA2:
         case S390_FEAT_SIE_F2:
         case S390_FEAT_SIE_SKEY:
@@ -506,6 +507,7 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_PTFF_STOUE, S390_FEAT_MULTIPLE_EPOCH },
         { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
         { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
+        { S390_FEAT_CERT_STORE, S390_FEAT_EXTENDED_LENGTH_SCCB },
         { S390_FEAT_NNPA, S390_FEAT_VECTOR },
         { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
         { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 80f0958478..db0ceea09f 100644
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
@@ -199,3 +200,44 @@ out:
         return false;
     }
 }
+
+void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
+{
+    S390CPU *cpu = env_archcpu(env);
+    uint64_t subcode = env->regs[r3];
+    uint64_t addr = env->regs[r1];
+    uint32_t ism_word0;
+
+    if (env->psw.mask & PSW_MASK_PSTATE) {
+        s390_program_interrupt(env, PGM_PRIVILEGED, ra);
+        return;
+    }
+
+    if (!s390_has_feat(S390_FEAT_CERT_STORE) ||
+        (subcode & ~0x000ffULL) ||
+        (r1 & 1)) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+        return;
+    }
+
+    switch (subcode) {
+    case DIAG_320_SUBC_QUERY_ISM:
+        /*
+         * The Installed Subcode Block (ISB) can be up 8 words in size,
+         * but the current set of subcodes can fit within a single word
+         * for now.
+         */
+        ism_word0 = cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES);
+
+        if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism_word0, sizeof(ism_word0))) {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
+            return;
+        }
+
+        env->regs[r1 + 1] = DIAG_320_RC_OK;
+        break;
+    default:
+        env->regs[r1 + 1] = DIAG_320_RC_NOT_SUPPORTED;
+        break;
+    }
+}
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index a309dc2c09..e6a586bce7 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -721,6 +721,7 @@ static uint16_t full_GEN16_GA1[] = {
     S390_FEAT_UV_FEAT_AP,
     S390_FEAT_UV_FEAT_AP_INTR,
     S390_FEAT_SIE_ASTFLEIE2,
+    S390_FEAT_CERT_STORE,
 };
 
 static uint16_t full_GEN17_GA1[] = {
@@ -920,6 +921,8 @@ static uint16_t qemu_MAX[] = {
     S390_FEAT_KIMD_SHA_512,
     S390_FEAT_KLMD_SHA_512,
     S390_FEAT_PRNO_TRNG,
+    S390_FEAT_EXTENDED_LENGTH_SCCB,
+    S390_FEAT_CERT_STORE,
 };
 
 /****** END FEATURE DEFS ******/
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 9af2a397f5..2ef4734559 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -99,6 +99,7 @@
 #define DIAG_TIMEREVENT                 0x288
 #define DIAG_IPL                        0x308
 #define DIAG_SET_CONTROL_PROGRAM_CODES  0x318
+#define DIAG_CERT_STORE                 0x320
 #define DIAG_KVM_HYPERCALL              0x500
 #define DIAG_KVM_BREAKPOINT             0x501
 
@@ -1531,6 +1532,16 @@ static void handle_diag_318(S390CPU *cpu, struct kvm_run *run)
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
@@ -1561,6 +1572,9 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
     case DIAG_KVM_BREAKPOINT:
         r = handle_sw_breakpoint(cpu, run);
         break;
+    case DIAG_CERT_STORE:
+        kvm_handle_diag_320(cpu, run);
+        break;
     default:
         trace_kvm_insn_diag(func_code);
         kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
@@ -2472,6 +2486,8 @@ bool kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
         set_bit(S390_FEAT_DIAG_318, model->features);
     }
 
+    set_bit(S390_FEAT_CERT_STORE, model->features);
+
     /* Test for Ultravisor features that influence secure guest behavior */
     query_uv_feat_guest(model->features);
 
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 35d1e34ef4..1945bdf40c 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -388,6 +388,8 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3);
 /* Return whether a CPU reset is pending */
 bool handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3,
                      uintptr_t ra);
+void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3,
+                     uintptr_t ra);
 
 
 /* translate.c */
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 09a45e58a5..403388145e 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -147,6 +147,13 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
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
2.54.0


