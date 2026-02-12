Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44ED9EEA84B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 20:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqdXv-0000gB-LU; Thu, 12 Feb 2026 15:44:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdXs-0000ej-Iq; Thu, 12 Feb 2026 15:44:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdXq-0007Va-Nh; Thu, 12 Feb 2026 15:44:16 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CD0fYd3344155; Thu, 12 Feb 2026 20:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=JEqhTVSlgYZPIsMBP
 XqqfesOYW070ykvooRDsqZWbXc=; b=BKbxvLooi4QERQSYoqzFNeE+X+EuTfOh9
 ol9m3OYau4E9xjodUyU+F6J6dw2+FTqdhJcqlR0saWW9kgWvgetrQ2FsRa9j4p89
 1iBFJaftTm1BjEYNwC1EAIlFtfGJ9OZTVpj/vMSD/RLzBGsZnbiJMvPkxoCQj9Z1
 IsuxwTOat0sgO5hpQgOuiu5dn3ro7ny4D7uSOfkAINEKZigIqHf3JVtyXH2Yz7MW
 zAFb5ag1xOiYsQG7q0PROfRVHjrLQXJz2R7ZTydGHaGdmTkVVwWKKYnSPD/c/9+C
 ahcdRpapW4eYpn9NSzryBvR+ou3eK/lwob9yjcy0jH7rtTiHoHbjA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696v5b9u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61CKclrg008378;
 Thu, 12 Feb 2026 20:44:10 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3ym7uf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:10 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61CKi8BP26870516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Feb 2026 20:44:09 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0C0258054;
 Thu, 12 Feb 2026 20:44:08 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E42885804E;
 Thu, 12 Feb 2026 20:44:06 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.112.15])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Feb 2026 20:44:06 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com
Subject: [PATCH v8 07/30] s390x/diag: Implement DIAG 320 subcode 1
Date: Thu, 12 Feb 2026 15:43:28 -0500
Message-ID: <20260212204352.1044699-8-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212204352.1044699-1-zycai@linux.ibm.com>
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE1NyBTYWx0ZWRfX9cq6Y/6FBldn
 cdVlTp10hvWUmxIliJmiAj0S4EfIIL4BOnBw3Hm//CsiYmNNgaesm389F/6h9rpv+TSSF3sBT/x
 2Nk/ZSg+RFxVRgJmIOMP0ElRFyBjwgeoZd9ivoRlB/D5zkYWjjjHxatuFciaXHIi8ChyEAQc9aF
 mf4ExY9/Wcv9ha5IVyz5MJxKpYo8qH6o9KGVa075BSeaxtQM/Ie7QMI78ONApfzLzLNgoghwbVo
 JjPt6p+AO34hfgkOz1ZcQVJGuZ0Y2nSGYJwwp++/DxH5yRXn6OaeJe0HSUYuNxsa22qiR9zpyAo
 RnYt855L3IXO4J0qoT2nilfP5IhbApvIzoCBeBZF0gyR1YVlPInYcLDkgbrJJ1XyyA8nQZrHoUw
 7+LrAYwv6WpdEY8vtWbWMrXdDbEuaFZGZ3kR8ibT5TcHzHq7nqIOe085AYarHPWSpt/kFKc80xc
 miPCEFsJ80YpSSc69Fg==
X-Proofpoint-ORIG-GUID: u8WPbZoEHhgQd18dneV4_VTDCyXGKbHw
X-Proofpoint-GUID: u8WPbZoEHhgQd18dneV4_VTDCyXGKbHw
X-Authority-Analysis: v=2.4 cv=O+Y0fR9W c=1 sm=1 tr=0 ts=698e3b9a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=vmAlfMB145uIY6ZofiUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120157
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index c2e8f7aba5..d3ece8a82d 100644
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
index e867fc2156..3c7e64eb05 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -197,11 +197,54 @@ out:
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
+        return -1;
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
@@ -223,7 +266,8 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
          * but the current set of subcodes can fit within a single word
          * for now.
          */
-        uint32_t ism_word0 = cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES);
+        uint32_t ism_word0 = cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES |
+                                         DIAG_320_ISM_QUERY_VCSI);
 
         if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism_word0, sizeof(ism_word0))) {
             s390_cpu_virt_mem_handle_exc(cpu, ra);
@@ -232,6 +276,23 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
         env->regs[r1 + 1] = DIAG_320_RC_OK;
         break;
+    case DIAG_320_SUBC_QUERY_VCSI:
+        if (!diag_parm_addr_valid(addr, sizeof(VCStorageSizeBlock), true)) {
+            s390_program_interrupt(env, PGM_ADDRESSING, ra);
+            return;
+        }
+
+        if (addr & 0x7) {
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
2.52.0


