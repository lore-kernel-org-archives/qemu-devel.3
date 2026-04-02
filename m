Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCFDD6AAE7
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8QJy-0000lc-Qb; Thu, 02 Apr 2026 18:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1w8QJw-0000jx-Mi; Thu, 02 Apr 2026 18:15:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1w8QJu-0004mh-U5; Thu, 02 Apr 2026 18:15:24 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 632CYH1l3941833; Thu, 2 Apr 2026 22:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=39Aj+pBu0pWqFpxG9
 1Dpbyl4JiYetEEQGGcVLcibH9Y=; b=DaKR/hhKnxhDG0CNeGry2+o/sAM40mFDc
 Qp2+Xb1kMypD4Ui4B7ogVkyTzqsVY4DmnoosriB4WFVROZsNi14n++qG22kpLNB1
 +/lEP/S/6EZVPpBQRQu5UZCM12qHxrpjAxMdG9+Wat+6xbwSbnLexGsPFcJktKnt
 OM2HJaOpgFg0ursLdTZkAokmQGkAEIjgyyiIYLUP2pp8YPcWJEKMegNavUBiG/me
 YW1NoJ9nAvqPu5D96Yt6+6g/vYufo2d58Mk6NbdGr9E/NwsSJgqeKAUzq854903/
 wTkGFpEl9rbc9mDCMA+Nq40FukDKxrRjhW1DmRtrvUmVD+FWDcOPw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66msdtfm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 22:15:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632KcXUr014339;
 Thu, 2 Apr 2026 22:15:18 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkuurd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 22:15:18 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 632MFG9W65536428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2026 22:15:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6A3458065;
 Thu,  2 Apr 2026 22:15:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8320158052;
 Thu,  2 Apr 2026 22:15:15 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.183.185])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2026 22:15:15 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, jdaley@linux.ibm.com
Subject: [PATCH v10 07/30] s390x/diag: Implement DIAG 320 subcode 1
Date: Thu,  2 Apr 2026 18:14:29 -0400
Message-ID: <20260402221453.1602899-8-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402221453.1602899-1-zycai@linux.ibm.com>
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69ceea77 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=vmAlfMB145uIY6ZofiUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE5NSBTYWx0ZWRfX1Yt0ETosCDBB
 oKvU1XFunU8sxgPy5EAFlw1XGoIWDwb0OVWs4qQBf9kttbJEkPXwfBgIvOnYXBWfOVGHicZ55pC
 9tYkewVW3jIpM16/rPOdm6+TkfKvLyGxX3NiOUT58zdVfmWAyq8DGZDprRzYBB95p9OEAdiW1PG
 SbVWFCtVlsO8H0lF1K5ax2dNjl22q2l+vhDdK5TLE1Bob9sxbgryQLrwaiJ/UynKc9uQGuHzCH+
 orm9iP1bPxTZu5vX6R6yTyt6SyFqa2rrSf5zltJLR9D3cKhj/5pyhVUIG//1UvwsV0vaQqhwbsf
 /c7nb8eS1xwwlBz5zvHYk4pSaqGiQdL4ldOSyniAzSR54QyFbFgSIIxfH2YkOey/RutubDiTps+
 rBxNrfPCA8q0Lk50FIYYRJ/hP3ta3S96IzGk0MU4Z/2jHKgZLvetFzDWmE/rDyr7hH+/vozsEHc
 75mG2WGeBpS8J5qCT1A==
X-Proofpoint-GUID: cOyLiYOuMOnJl8UYzhe42aRmApEElghd
X-Proofpoint-ORIG-GUID: cOyLiYOuMOnJl8UYzhe42aRmApEElghd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020195
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 docs/specs/s390x-secure-ipl.rst | 12 +++++++
 include/hw/s390x/ipl/diag320.h  | 22 ++++++++++++
 target/s390x/diag.c             | 63 ++++++++++++++++++++++++++++++++-
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
index 96a8d0fb83..52661fab00 100644
--- a/docs/specs/s390x-secure-ipl.rst
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -26,3 +26,15 @@ Subcode 0 - query installed subcodes
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
diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
index aa04b699c6..6e4779c699 100644
--- a/include/hw/s390x/ipl/diag320.h
+++ b/include/hw/s390x/ipl/diag320.h
@@ -11,10 +11,32 @@
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
+#define VCSSB_MIN_LEN   128
+#define VCE_HEADER_LEN  128
+#define VCB_HEADER_LEN  64
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
 
 #endif
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 8ab40437a2..c44624e1e6 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -198,11 +198,54 @@ out:
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
+    if (be32_to_cpu(vcssb->length) > sizeof(*vcssb)) {
+        return DIAG_320_RC_INVAL_VCSSB_LEN;
+    }
+
+    if (be32_to_cpu(vcssb->length) < VCSSB_MIN_LEN) {
+        return DIAG_320_RC_INVAL_VCSSB_LEN;
+    }
+
+    if (!cs->count) {
+        vcssb->length = cpu_to_be32(VCSSB_NO_VC);
+    } else {
+        vcssb->version = 0;
+        vcssb->total_vc_ct = cpu_to_be16(cs->count);
+        vcssb->max_vc_ct = cpu_to_be16(MAX_CERTIFICATES);
+        vcssb->max_single_vcb_len = cpu_to_be32(VCB_HEADER_LEN + VCE_HEADER_LEN +
+                                                cs->largest_cert_size);
+        vcssb->total_vcb_len = cpu_to_be32(VCB_HEADER_LEN + cs->count * VCE_HEADER_LEN +
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
+QEMU_BUILD_BUG_MSG(sizeof(VCStorageSizeBlock) != VCSSB_MIN_LEN,
+                   "size of VCStorageSizeBlock is wrong");
+
 void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     S390CPU *cpu = env_archcpu(env);
+    S390IPLCertificateStore *cs = s390_ipl_get_certificate_store();
     uint64_t subcode = env->regs[r3];
     uint64_t addr = env->regs[r1];
+    int rc;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
         s390_program_interrupt(env, PGM_PRIVILEGED, ra);
@@ -224,7 +267,8 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
          * but the current set of subcodes can fit within a single word
          * for now.
          */
-        uint32_t ism_word0 = cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES);
+        uint32_t ism_word0 = cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES |
+                                         DIAG_320_ISM_QUERY_VCSI);
 
         if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism_word0, sizeof(ism_word0))) {
             s390_cpu_virt_mem_handle_exc(cpu, ra);
@@ -233,6 +277,23 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
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
2.53.0


