Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B14CC5516D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpYae-0001Q5-2u; Thu, 30 Jul 2026 17:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wpYaZ-0001CQ-Dm; Thu, 30 Jul 2026 17:46:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wpYaX-0002Ll-Ab; Thu, 30 Jul 2026 17:46:51 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UJlxwK3942881; Thu, 30 Jul 2026 21:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0rdS1B0791E3+CyFg
 SItuKIzjEE2vSZ8J7NI045kCbU=; b=O3VcBgLBce6kRvcKbDl1XR12CO29fhChs
 QWUyEkvebyYX3ADIJfaaTVS2ei7rWO+X4x4qvpTCk+9zwL5Vv5rt5p0B8N6hYRW+
 SkfuG4zqNLcuhwayWv09eZc03EMX7h2/jfuQObGixKNju923ny47QO+VRUsMRNba
 3LyQOnaRC3rm4pedyyeuEk+xNaC/LyTsSQXuH3+tMnzoyvuTX9CVTZsTsZ/oJl+h
 +ZLoIjUlY2GAVHY9Y+f0oCEgLXxrM+vJgQnHhLKhF8mUMksluEWQYi8oQ9jJiAsm
 i01wIro9R0ks3Zp5b2xEs2kZaYaONUEaVA+rlWQWVxloPRDO7aSIw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7t245-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:46:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ULfI8B005446;
 Thu, 30 Jul 2026 21:46:44 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwddxs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 21:46:44 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ULkgKv12452500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2026 21:46:43 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8C5B5805F;
 Thu, 30 Jul 2026 21:46:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E2CA758043;
 Thu, 30 Jul 2026 21:46:40 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.77.192])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Jul 2026 21:46:40 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v17 07/34] s390x/diag: Implement DIAG 320 subcode 1
Date: Thu, 30 Jul 2026 17:45:56 -0400
Message-ID: <20260730214624.2328883-8-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730214624.2328883-1-zycai@linux.ibm.com>
References: <20260730214624.2328883-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LHUoDoS8lcX4LI9wRcAoXNOiB3oNFdZZ
X-Proofpoint-ORIG-GUID: LHUoDoS8lcX4LI9wRcAoXNOiB3oNFdZZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE1NCBTYWx0ZWRfX7tG8R5Sgk6b5
 OaYJE58Zl3cgUmMwvGRF+9ktpre2mo0g+QE48XkmJyrKt7MkFVSbg7D6eMExXyFLzr1ZDE0idCI
 +ZtJFUbhiMRX36pZcmQdJ0zIZzLejr995ja9OVofAClIvVI5YPkUqFTBkeKs+a3QmlGqUSre8VN
 eM9p2ZL1lbcA6yHL+AZ6FRwNPiiGHEJHioJCdpAr2F0iGfGDInibTNynIQaSxL5f0Fny8oKyRZa
 b+aePXfEtx/pcGQnjbBSHkQ41vrrZ5nZcLU7VzSIXsm545cgquojbW7bI4/0vVXOxd2VUzoe+4L
 gZxwvC4M2BVTwb8Us0Aren8lRmbwCfeRW6A4IJWU7ThXxsvYIwngdXxVxqWlw0wq8Y6A3RnDMxQ
 6rexAUl/hVz/fHNP3iEFq9bHVKHmTr0J4fPfHTGDNz37nWo2s6vJkkElqg5mQCuZ8QxhmksELhw
 uVkZypoYTN7jQgvBveA==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6bc645 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=MguaJt8dR91BFOVN_IAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE1NCBTYWx0ZWRfX20s9rKtml31e
 GSMXiO21HpFO05CFnmjMYaa39c+BSQh++2nokxHf3fLMBG2PDqMzF9YL0s4EUDbSRPi4E4ZmrIv
 mV49I/DwQJDwCnQrdsX3kmwmSS4H9So=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300154
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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

DIAG 320 subcode 1 provides information needed to determine
the amount of storage to store one or more certificates from the
certificate store.

Upon successful completion, this subcode returns information of the current
cert store, such as the number of certificates stored and allowed in the cert
store, amount of space may need to be allocate to store a certificate,
etc for verification-certificate blocks (VCBs).

The subcode value is denoted by setting the left-most bit
of an 8-byte field.

The verification-certificate-storage-size block (VCSSB) contains
the output data when the operation completes successfully. A VCSSB
length of 4 indicates that no certificate are available in the cert
store.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
---
 docs/specs/s390x-secure-ipl.rst | 12 +++++++
 hw/s390x/cert-store.h           |  3 +-
 include/hw/s390x/ipl/diag320.h  | 57 ++++++++++++++++++++++++++++++
 target/s390x/diag.c             | 61 ++++++++++++++++++++++++++++++++-
 4 files changed, 130 insertions(+), 3 deletions(-)

diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
index cc497ea09a..201cc74c7c 100644
--- a/docs/specs/s390x-secure-ipl.rst
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -30,3 +30,15 @@ Subcode 0 - query installed subcodes
     Returns a 256-bit installed subcodes mask (ISM) stored in the installed
     subcodes block (ISB). This mask indicates which subcodes are currently
     installed and available for use.
+
+Subcode 1 - query verification certificate storage information
+    Provides the information required to determine the amount of memory needed
+    to store one or more verification-certificates (VCs) from the certificate
+    store (CS).
+
+    Upon successful completion, this subcode returns various storage size values
+    for verification-certificate blocks (VCBs).
+
+    The output is returned in the verification-certificate-storage-size block
+    (VCSSB). A VCSSB length of 4 indicates that no certificates are available
+    in the CS.
diff --git a/hw/s390x/cert-store.h b/hw/s390x/cert-store.h
index 7fc9503cb9..6f5ee63177 100644
--- a/hw/s390x/cert-store.h
+++ b/hw/s390x/cert-store.h
@@ -11,10 +11,9 @@
 #define HW_S390_CERT_STORE_H
 
 #include "hw/s390x/ipl/qipl.h"
+#include "hw/s390x/ipl/diag320.h"
 #include "crypto/x509-utils.h"
 
-#define CERT_NAME_MAX_LEN  64
-
 #define CERT_KEY_ID_LEN    QCRYPTO_HASH_DIGEST_LEN_SHA256
 #define CERT_HASH_LEN      QCRYPTO_HASH_DIGEST_LEN_SHA256
 
diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
index aa04b699c6..d37d8eaa86 100644
--- a/include/hw/s390x/ipl/diag320.h
+++ b/include/hw/s390x/ipl/diag320.h
@@ -11,10 +11,67 @@
 #define S390X_DIAG320_H
 
 #define DIAG_320_SUBC_QUERY_ISM     0
+#define DIAG_320_SUBC_QUERY_VCSI    1
 
 #define DIAG_320_RC_OK              0x0001
 #define DIAG_320_RC_NOT_SUPPORTED   0x0102
+#define DIAG_320_RC_INVAL_VCSSB_LEN 0x0202
 
 #define DIAG_320_ISM_QUERY_SUBCODES 0x80000000
+#define DIAG_320_ISM_QUERY_VCSI     0x40000000
+
+#define VCSSB_NO_VC     4
+#define VCSSB_LEN_VALID   128
+
+#define CERT_NAME_MAX_LEN  64
+
+struct VCStorageSizeBlock {
+    uint32_t length;
+    uint8_t reserved0[3];
+    uint8_t version;
+    uint32_t reserved1[6];
+    uint16_t total_vc_ct;
+    uint16_t max_vc_ct;
+    uint32_t reserved3[11];
+    uint32_t max_single_vcb_len;
+    uint32_t total_vcb_len;
+    uint32_t reserved4[10];
+};
+typedef struct VCStorageSizeBlock VCStorageSizeBlock;
+
+struct VCEntryHeader {
+    uint32_t len;
+    uint8_t flags;
+    uint8_t key_type;
+    uint16_t cert_idx;
+    uint8_t name[CERT_NAME_MAX_LEN];
+    uint8_t format;
+    uint8_t reserved0;
+    uint16_t keyid_len;
+    uint8_t reserved1;
+    uint8_t hash_type;
+    uint16_t hash_len;
+    uint32_t reserved2;
+    uint32_t cert_len;
+    uint32_t reserved3[2];
+    uint16_t hash_offset;
+    uint16_t cert_offset;
+    uint32_t reserved4[7];
+};
+typedef struct VCEntryHeader VCEntryHeader;
+
+struct VCBlockHeader {
+    uint32_t in_len;
+    uint32_t reserved0;
+    uint16_t first_vc_index;
+    uint16_t last_vc_index;
+    uint32_t reserved1[5];
+    uint32_t out_len;
+    uint8_t reserved2[4];
+    uint16_t stored_ct;
+    uint16_t remain_ct;
+    uint32_t reserved3[5];
+};
+typedef struct VCBlockHeader VCBlockHeader;
 
 #endif
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index b42a5e769d..6eff77fc5b 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -205,12 +205,53 @@ out:
     }
 }
 
+static int handle_diag320_query_vcsi(S390CPU *cpu, uint64_t addr, uint64_t r1,
+                                     uintptr_t ra, S390IPLCertificateStore *cs)
+{
+    g_autofree VCStorageSizeBlock *vcssb = NULL;
+
+    vcssb = g_new0(VCStorageSizeBlock, 1);
+    if (s390_cpu_virt_mem_read(cpu, addr, r1, vcssb, sizeof(*vcssb))) {
+        s390_cpu_virt_mem_handle_exc(cpu, ra);
+        return -1;
+    }
+
+    if (be32_to_cpu(vcssb->length) != VCSSB_LEN_VALID) {
+        return DIAG_320_RC_INVAL_VCSSB_LEN;
+    }
+
+    if (!cs->count) {
+        vcssb->length = cpu_to_be32(VCSSB_NO_VC);
+    } else {
+        vcssb->version = 0;
+        vcssb->total_vc_ct = cpu_to_be16(cs->count);
+        vcssb->max_vc_ct = cpu_to_be16(MAX_CERTIFICATES);
+        vcssb->max_single_vcb_len = cpu_to_be32(sizeof(VCBlockHeader) +
+                                                sizeof(VCEntryHeader) +
+                                                cs->largest_cert_size);
+        vcssb->total_vcb_len = cpu_to_be32(sizeof(VCBlockHeader) +
+                                           cs->count * sizeof(VCEntryHeader) +
+                                           cs->total_bytes);
+    }
+
+    if (s390_cpu_virt_mem_write(cpu, addr, r1, vcssb, be32_to_cpu(vcssb->length))) {
+        s390_cpu_virt_mem_handle_exc(cpu, ra);
+        return -1;
+    }
+    return DIAG_320_RC_OK;
+}
+
+QEMU_BUILD_BUG_MSG(sizeof(VCStorageSizeBlock) != VCSSB_LEN_VALID,
+                   "size of VCStorageSizeBlock is wrong");
+
 void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     S390CPU *cpu = env_archcpu(env);
+    S390IPLCertificateStore *cs = s390_ipl_get_certificate_store();
     uint64_t subcode = env->regs[r3];
     uint64_t addr = env->regs[r1];
     uint32_t ism_word0;
+    int rc;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
         s390_program_interrupt(env, PGM_PRIVILEGED, ra);
@@ -231,7 +272,8 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
          * but the current set of subcodes can fit within a single word
          * for now.
          */
-        ism_word0 = cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES);
+        ism_word0 = cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES |
+                                         DIAG_320_ISM_QUERY_VCSI);
 
         if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism_word0, sizeof(ism_word0))) {
             s390_cpu_virt_mem_handle_exc(cpu, ra);
@@ -240,6 +282,23 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
         env->regs[r1 + 1] = DIAG_320_RC_OK;
         break;
+    case DIAG_320_SUBC_QUERY_VCSI:
+        if (addr & 0x7) {
+            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+            return;
+        }
+
+        if (!diag_parm_addr_valid(addr, sizeof(VCStorageSizeBlock), true)) {
+            s390_program_interrupt(env, PGM_ADDRESSING, ra);
+            return;
+        }
+
+        rc = handle_diag320_query_vcsi(cpu, addr, r1, ra, cs);
+        if (rc == -1) {
+            return;
+        }
+        env->regs[r1 + 1] = rc;
+        break;
     default:
         env->regs[r1 + 1] = DIAG_320_RC_NOT_SUPPORTED;
         break;
-- 
2.55.0


