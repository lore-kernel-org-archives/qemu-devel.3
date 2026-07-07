Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C292DC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 23:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whExW-0006pK-Q6; Tue, 07 Jul 2026 19:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whExT-0006ox-CK; Tue, 07 Jul 2026 19:12:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1whExR-0008IA-A7; Tue, 07 Jul 2026 19:12:07 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667Mneie823543; Tue, 7 Jul 2026 23:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=YkYXpk4cvWwWvydYk
 xaIr3OLQytxXhDE5yf/YstEINw=; b=fZWaHDpeO9/t/01sgUF2VVlzmajkxo2+S
 +CLAAZb2DbYUm+yJ3MCgNqYebG82pzS0pWSYdi6TjsS2iXI8Kg4v9Lgw975/Ozhr
 rnvzdjjSQzu2L/IRP9R5Fq49iQWsh8NyV8c60UmqVx/nCwvEd+79rRKioP66nBe8
 V0dJdLpMyDE5bteog61gQjLtVIMdp4I0W+7Qm2UpL+WM1593XYKvTTY9O8DXuqpD
 yGX+a5uc1gUnK+AePnCGb6bTKV/pzFwc0uWTFUUx2SW8QvHawv3NSl0s1aUk4Cy1
 TU9FdD5DLywI/Ly+dZhFDPfxuO0o6juMlwoTtXIWKB5l04zpUr20A==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4sr0r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:12:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667N578i014724;
 Tue, 7 Jul 2026 23:12:00 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq598a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:12:00 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667NBxvW22807242
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 23:12:00 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92A2958052;
 Tue,  7 Jul 2026 23:11:59 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AC2C58050;
 Tue,  7 Jul 2026 23:11:56 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.32.2])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 23:11:56 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v16 07/33] s390x/diag: Implement DIAG 320 subcode 1
Date: Tue,  7 Jul 2026 19:11:05 -0400
Message-ID: <20260707231132.2492104-8-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707231132.2492104-1-zycai@linux.ibm.com>
References: <20260707231132.2492104-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IwnsiruxWA_ex5CbkqDVlwSyJadptsz3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIyNCBTYWx0ZWRfX9JEdBHk9FKHp
 6icQu04K6jZRCNA8/GSH1CBwaB1Z+AF0mwfWBwQsan80J+UIz+mtAE0b/bwL06+bM/h7ewrmyFW
 biP5iwvriVHY17vp7TdbXJacSWtcMMKRXpCHFrq6qdut6ESct3fBZxbRyKM6Cz1CaHeOg3WM+yf
 vO1cEfry7Bb5OrCUm7kvsCI6wl1hCCk6mEDvYmt11OURO/eXDgnhp8H6JIPzzKJhKDnUziK1C5H
 cdZNFhQV+bItQLva7ktBPA+kZSUxdWoI9abDs3XMMfB91jEFIX7epIMaxrGuZcYkt2wbvVwsE/V
 bsEUx9JnNdq7zeN/4TDcx8hPYN0O6POCVJz/33FGe181ScS7p20Rc14w5FfuIt9UwSEo7eq+4/d
 2jrwnOOkUJvNivoGInKuWpIKKFl3h95oCdYkE9vcgQjgGV0FtPGf3dHTH1E5j9iLbzSlF3+Qg47
 3ZgvWY1p70rQzIdVoIQ==
X-Proofpoint-ORIG-GUID: IwnsiruxWA_ex5CbkqDVlwSyJadptsz3
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4d87c1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=MguaJt8dR91BFOVN_IAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIyNCBTYWx0ZWRfX/ktXGEmbBXid
 NcFsipCfOFz18yq4x6P5vyK+BPl0ui31egYdIASSyBgq3mWZNPFfCvaQjOiIC4sP1ctUE+60afG
 NlqbYX1Wlhyi8s3oKtYbD1mwGLM1Rn4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070224
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
2.54.0


