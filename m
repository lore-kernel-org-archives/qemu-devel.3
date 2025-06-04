Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4185EC5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 21:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMw79-0002gv-1I; Wed, 04 Jun 2025 17:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw6y-0002dh-HP; Wed, 04 Jun 2025 17:57:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw6w-0006xX-4H; Wed, 04 Jun 2025 17:57:27 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554KNvMv032653;
 Wed, 4 Jun 2025 21:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=uE38BmxaOBFngUZnx
 g99HVV1TWXtN8r3dofuEhxFp7E=; b=WbO0adPjuYZyC6qi37KO2qipNj5ZG6Swq
 2oD8yyCd4ZKaD1gIHZsKq7UO0eWb23R+PhXwe8RTmNjGYCB0enfuv2OdKFTFgtKw
 4YUAprjSMW1NNfBnklF8smDUmmaUzSdPyaxAohxiU23lk2eXBRBDgM22oSn76amn
 ARzPfbUzHuDpuVsp5idPIjjSKAWpVMIXez1eRa7wFCs9cAU4RtgPlX3D2+OYIiMU
 yFLazqcfW1OewZOEcIBkd1tytlcbNNSuytVFfvHRJf7HviaZeAUMo9R6E1LiCqk2
 VRtfVq9R1CSAC0r4JvNg3ZwOHxsGBCZC9yViFv8ITa7c8EWbf1tOw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyw6jj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 554J9Mbm019886;
 Wed, 4 Jun 2025 21:57:23 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470d3p1urm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:23 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 554LvMpv26280470
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jun 2025 21:57:22 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F9C058050;
 Wed,  4 Jun 2025 21:57:22 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9238658045;
 Wed,  4 Jun 2025 21:57:20 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.211])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jun 2025 21:57:20 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v3 07/28] s390x/diag: Implement DIAG 320 subcode 1
Date: Wed,  4 Jun 2025 17:56:35 -0400
Message-ID: <20250604215657.528142-8-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604215657.528142-1-zycai@linux.ibm.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lwY4GXuXDbyALKmm2c-p_kohmcoXeZAt
X-Proofpoint-ORIG-GUID: lwY4GXuXDbyALKmm2c-p_kohmcoXeZAt
X-Authority-Analysis: v=2.4 cv=X4dSKHTe c=1 sm=1 tr=0 ts=6840c144 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=e_kuu1gU4TaIW1Qv6wwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE3NSBTYWx0ZWRfX78E6YD5pOnXg
 woJojAasEs0BPbP+fte8miq98e9qnIBrg7K3VRImUhtBTlLn5Y0ym1FJ2iS9lv74fWkR1ajDBdb
 Vejk73l/u7+mZBtALVdoGJFcmoT3zXmsUQkRsedqxcV93+1VCV8ZKY6j/zkceWs8ieDxW0IL1pC
 Y8oqJeQE8oNoMQlE0RDjVzwYHm+zUvCtJtUZcpvGnCtJam9kPIvB8JQ6ks1HxD6HWExQYmcBW7l
 LTexD+lrt2wuirD5Ti0NvlQ7VppupofKSLOMzFwCpGwCHZz9krTNGiV9MBq0V6I5hBUUBMT7txP
 +zeL40f44kg3IRoTNVQU8+ywAL4jEH1QIt4QySb2UnJaYrsB7xHC6olvx5PWUirc5V0OtCHeKtX
 NOa7zyX7AMPNLpwyrL/+RzyYjw5GK4jBMUyZeb/Gaon1RjEOFBIngaUsyLmW1cROhC7uXRFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=977 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
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

DIAG 320 subcode 1 provides information needed to determine
the amount of storage to store one or more certificates.

The subcode value is denoted by setting the left-most bit
of an 8-byte field.

The verification-certificate-storage-size block (VCSSB) contains
the output data when the operation completes successfully.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 include/hw/s390x/ipl/diag320.h | 23 ++++++++++++++++++++++
 target/s390x/diag.c            | 36 +++++++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
index 713570545d..3916a2915e 100644
--- a/include/hw/s390x/ipl/diag320.h
+++ b/include/hw/s390x/ipl/diag320.h
@@ -11,7 +11,30 @@
 #define S390X_DIAG320_H
 
 #define DIAG_320_SUBC_QUERY_ISM     0
+#define DIAG_320_SUBC_QUERY_VCSI    1
 
 #define DIAG_320_RC_OK              0x0001
 
+#define VCSSB_MAX_LEN   128
+#define VCE_HEADER_LEN  128
+#define VCB_HEADER_LEN  64
+
+#define DIAG_320_ISM_QUERY_VCSI     0x4000000000000000
+
+struct VCStorageSizeBlock {
+    uint32_t length;
+    uint8_t reserved0[3];
+    uint8_t version;
+    uint32_t reserved1[6];
+    uint16_t total_vc_ct;
+    uint16_t max_vc_ct;
+    uint32_t reserved3[7];
+    uint32_t max_vce_len;
+    uint32_t reserved4[3];
+    uint32_t max_single_vcb_len;
+    uint32_t total_vcb_len;
+    uint32_t reserved5[10];
+};
+typedef struct VCStorageSizeBlock VCStorageSizeBlock;
+
 #endif
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 7b9b47a171..1f7d0cb2f6 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -191,9 +191,13 @@ out:
     }
 }
 
+QEMU_BUILD_BUG_MSG(sizeof(VCStorageSizeBlock) != 128,
+                   "size of VCStorageSizeBlock is wrong");
+
 void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     S390CPU *cpu = env_archcpu(env);
+    S390IPLCertificateStore *qcs = s390_ipl_get_certificate_store();
     uint64_t subcode = env->regs[r3];
     uint64_t addr = env->regs[r1];
     int rc;
@@ -215,13 +219,43 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
     switch (subcode) {
     case DIAG_320_SUBC_QUERY_ISM:
-        uint64_t ism =  0;
+        uint64_t ism = cpu_to_be64(DIAG_320_ISM_QUERY_VCSI);
 
         if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism, sizeof(ism))) {
             s390_cpu_virt_mem_handle_exc(cpu, ra);
             return;
         }
 
+        rc = DIAG_320_RC_OK;
+        break;
+    case DIAG_320_SUBC_QUERY_VCSI:
+        VCStorageSizeBlock vcssb;
+
+        if (!diag_parm_addr_valid(addr, sizeof(VCStorageSizeBlock),
+                                  true)) {
+            s390_program_interrupt(env, PGM_ADDRESSING, ra);
+            return;
+        }
+
+        if (!qcs || !qcs->count) {
+            vcssb.length = cpu_to_be32(4);
+        } else {
+            vcssb.length = cpu_to_be32(VCSSB_MAX_LEN);
+            vcssb.version = 0;
+            vcssb.total_vc_ct = cpu_to_be16(qcs->count);
+            vcssb.max_vc_ct = cpu_to_be16(MAX_CERTIFICATES);
+            vcssb.max_vce_len = cpu_to_be32(VCE_HEADER_LEN + qcs->max_cert_size);
+            vcssb.max_single_vcb_len = cpu_to_be32(VCB_HEADER_LEN + VCE_HEADER_LEN +
+                                                   qcs->max_cert_size);
+            vcssb.total_vcb_len = cpu_to_be32(VCB_HEADER_LEN +
+                                              qcs->count * VCE_HEADER_LEN +
+                                              qcs->total_bytes);
+        }
+
+        if (s390_cpu_virt_mem_write(cpu, addr, r1, &vcssb, sizeof(VCStorageSizeBlock))) {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
+            return;
+        }
         rc = DIAG_320_RC_OK;
         break;
     default:
-- 
2.49.0


