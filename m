Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5C8C369A5
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 16:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Be5-0006sR-3P; Tue, 08 Apr 2025 12:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BIh-0005Vk-51; Tue, 08 Apr 2025 11:55:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BIf-0005t1-48; Tue, 08 Apr 2025 11:55:46 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538Dn7HD029659;
 Tue, 8 Apr 2025 15:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KhcpAoFLb3PigqirD
 OeQhntYaXygDToANiKBmIsrRos=; b=Hjr+auVy6FQ6/j+bVlhO0Lz8oKK3EJQ1L
 RUs+AvIq2H1iCr2oErBdD01D9mkdK8fZTTpuW9pvkiDRt8KS0RBBCWl0kLactUdD
 OPBQfvlxarfeJrJSFFSl3J95ffP2oy90E6sJ2nDidcYqQ755Twg598QgWPV9MHD9
 x7SDFUcq3buiaNpeuHyjvSokUp6LeybhEfaK4YaQE4KdRe000f8DqLmMJxygOS6R
 CuoeGVkr6HegudvbpBACLO8M+Jlkzg7bImXrbOVXWs64r9SKTFlNJJVQabU/oRog
 LhPugJHEQc/nunzpNU9MfdOXBxcLMdhX8kPxllK6uZWjtdB8aBXNg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vv6a3amd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:55:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538FIOrJ011326;
 Tue, 8 Apr 2025 15:55:41 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45uf7ykgpc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:55:41 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 538FtdmL26346174
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 15:55:40 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C11065803F;
 Tue,  8 Apr 2025 15:55:39 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 570B55804E;
 Tue,  8 Apr 2025 15:55:38 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.125.94])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Apr 2025 15:55:38 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v1 06/24] s390x/diag: Implement DIAG 320 subcode 1
Date: Tue,  8 Apr 2025 11:55:08 -0400
Message-ID: <20250408155527.123341-7-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408155527.123341-1-zycai@linux.ibm.com>
References: <20250408155527.123341-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hf5_e_3w1wZFP0z3nJs2zvAQflC7UyIA
X-Proofpoint-GUID: hf5_e_3w1wZFP0z3nJs2zvAQflC7UyIA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 suspectscore=0 bulkscore=0 mlxlogscore=951 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080107
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
X-Mailman-Approved-At: Tue, 08 Apr 2025 12:17:33 -0400
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

DIAG 320 subcode 1 provides information needed to determine
the amount of storage to store one or more certificates.

The subcode value is denoted by setting the left-most bit
of an 8-byte field.

The verification-certificate-storage-size block (VCSSB) contains
the output data when the operation completes successfully.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 include/hw/s390x/ipl/diag320.h | 25 ++++++++++++++++++++++
 target/s390x/diag.c            | 39 +++++++++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
index d6f70c65df..ded336df25 100644
--- a/include/hw/s390x/ipl/diag320.h
+++ b/include/hw/s390x/ipl/diag320.h
@@ -13,7 +13,32 @@
 #define S390X_DIAG320_H
 
 #define DIAG_320_SUBC_QUERY_ISM     0
+#define DIAG_320_SUBC_QUERY_VCSI    1
 
 #define DIAG_320_RC_OK              0x0001
+#define DIAG_320_RC_NOMEM           0x0202
+
+#define VCSSB_MAX_LEN   128
+#define VCE_HEADER_LEN  128
+#define VCB_HEADER_LEN  64
+
+#define DIAG_320_ISM_QUERY_VCSI     0x4000000000000000
+
+struct VerificationCertificateStorageSizeBlock {
+    uint32_t length;
+    uint8_t reserved0[3];
+    uint8_t version;
+    uint32_t reserved1[6];
+    uint16_t totalvc;
+    uint16_t maxvc;
+    uint32_t reserved3[7];
+    uint32_t maxvcelen;
+    uint32_t reserved4[3];
+    uint32_t largestvcblen;
+    uint32_t totalvcblen;
+    uint32_t reserved5[10];
+} QEMU_PACKED;
+typedef struct VerificationCertificateStorageSizeBlock \
+VerificationCertificateStorageSizeBlock;
 
 #endif
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index c64b935c87..cc639819ec 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -194,6 +194,7 @@ out:
 void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     S390CPU *cpu = env_archcpu(env);
+    S390IPLCertificateStore *qcs = s390_ipl_get_certificate_store();
     uint64_t subcode = env->regs[r3];
     uint64_t addr = env->regs[r1];
     int rc;
@@ -210,7 +211,7 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
     switch (subcode) {
     case DIAG_320_SUBC_QUERY_ISM:
-        uint64_t ism =  0;
+        uint64_t ism = DIAG_320_ISM_QUERY_VCSI;
 
         if (s390_cpu_virt_mem_write(cpu, addr, (uint8_t)r1, &ism,
                                     be64_to_cpu(sizeof(ism)))) {
@@ -218,6 +219,42 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
             return;
         }
 
+        rc = DIAG_320_RC_OK;
+        break;
+    case DIAG_320_SUBC_QUERY_VCSI:
+        VerificationCertificateStorageSizeBlock vcssb;
+
+        if (!diag_parm_addr_valid(addr, sizeof(VerificationCertificateStorageSizeBlock),
+                                  true)) {
+            s390_program_interrupt(env, PGM_ADDRESSING, ra);
+            return;
+        }
+
+        if (!qcs || !qcs->count) {
+            vcssb.length = 4;
+        } else {
+            vcssb.length = VCSSB_MAX_LEN;
+            vcssb.version = 0;
+            vcssb.totalvc = qcs->count;
+            vcssb.maxvc = MAX_CERTIFICATES;
+            vcssb.maxvcelen = VCE_HEADER_LEN + qcs->max_cert_size;
+            vcssb.largestvcblen = VCB_HEADER_LEN + vcssb.maxvcelen;
+            vcssb.totalvcblen = VCB_HEADER_LEN + qcs->count * VCE_HEADER_LEN +
+                                qcs->total_bytes;
+        }
+
+        if (vcssb.length < 128) {
+            rc = DIAG_320_RC_NOMEM;
+            break;
+        }
+
+        if (s390_cpu_virt_mem_write(cpu, addr, (uint8_t)r1, &vcssb,
+                                    be64_to_cpu(
+                                        sizeof(VerificationCertificateStorageSizeBlock)
+                                    ))) {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
+            return;
+        }
         rc = DIAG_320_RC_OK;
         break;
     default:
-- 
2.49.0


