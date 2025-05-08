Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CEBC3ABC5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDA5d-0004AS-Ba; Thu, 08 May 2025 18:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5O-00042l-9r; Thu, 08 May 2025 18:51:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5M-0006ST-Ij; Thu, 08 May 2025 18:51:26 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548LgFfA031151;
 Thu, 8 May 2025 22:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=dkeH7NUefZpx3JhjG
 KDWfa/F4WYO/HBDRkR2X7F4chs=; b=gg6BADrCWueF2wH+CAH/SpnB5+4rPD4SX
 U3cmilpRpBNQc4j0GoYujRHrUryBBx+Li3DF+f2ut/GhS2c0pywEEVMMQwWAmT5d
 lrvgmCgIilE1SmuFmdLV6sZ9XDgRFHF3umiqWVxhWjzawq9SY+r6nkKuFbVg4j9C
 TFjAps8UyXqyfSz1+TY/SRkeOWSwvT/Hz4hNeTNiJLlLH9wIoKQyCzyCZW728nmb
 Qox4pTMHXR9JoETJpptVprgixQNjDJ9pHvYRau8y563sUhX5Js25udvYKCjJ9YAL
 tt+yBHhFVwNgBQGzniM+vMUDisypYxI3adUIdGGjJx4JG3U+nAcQA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h4rw87xj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548M2wWj014122;
 Thu, 8 May 2025 22:51:22 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dypkyuwt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:22 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 548MpKgQ33096276
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 May 2025 22:51:21 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D11C65804B;
 Thu,  8 May 2025 22:51:20 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6202958055;
 Thu,  8 May 2025 22:51:19 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.11.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 May 2025 22:51:19 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v2 06/25] s390x/diag: Implement DIAG 320 subcode 1
Date: Thu,  8 May 2025 18:50:22 -0400
Message-ID: <20250508225042.313672-7-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508225042.313672-1-zycai@linux.ibm.com>
References: <20250508225042.313672-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QIxoRhLL c=1 sm=1 tr=0 ts=681d356a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=ytmiVwLZkrhPdcJ3E8IA:9
X-Proofpoint-GUID: AiwB4YBYhIfZ0COmgPzMyC_OpgZL9aFw
X-Proofpoint-ORIG-GUID: AiwB4YBYhIfZ0COmgPzMyC_OpgZL9aFw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDIwNSBTYWx0ZWRfX0yb1bgS83ccF
 KlUw/++NNg6ATiO1c4N6NiYqMs7h26LuYFCnTkZlC5nSkSrTNpkqvN4cZtYcxl8dku9jJgRrf5n
 3GXyn+vrfkhc3FiSAbs3DnXlRhL8Zafs9MiVNLf+90DczRAF7oMKZlb4lLG9J3MfJdB9milSIMF
 gkz27xbddH6W+EO1ezLeWjfAKAdCvQnruKsjV3etj1iPerN5/LqDFjyDDoXRO/eVIer8rW3Wneh
 hyolRKBBksid56Deogs6KzlzvyQmKLlzNOh+mrJ/pjrJNgHauRc1eWBabyateNTgmawFdULv9n4
 +ilvxDGLeEy6F9qd0b10sgbEl5nadMiUaI7bUqLQSwmB3ex17FPLGd7a/OAAKxNgKbQ57AS6opg
 Cq25q16WOJIVBhPUX7x/BwbzS7qhPzpNfPoPmJgOoLdN1f41f12k1wgeLVk8A0u6y73dtowR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_07,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=922 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080205
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 include/hw/s390x/ipl/diag320.h | 25 ++++++++++++++++++++++
 target/s390x/diag.c            | 38 +++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
index 713570545d..e91eb7238c 100644
--- a/include/hw/s390x/ipl/diag320.h
+++ b/include/hw/s390x/ipl/diag320.h
@@ -11,7 +11,32 @@
 #define S390X_DIAG320_H
 
 #define DIAG_320_SUBC_QUERY_ISM     0
+#define DIAG_320_SUBC_QUERY_VCSI    1
 
 #define DIAG_320_RC_OK              0x0001
+#define DIAG_320_RC_INVAL_VCSSB_LEN 0x0202
+
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
+} QEMU_PACKED;
+typedef struct VCStorageSizeBlock \
+VCStorageSizeBlock;
 
 #endif
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 9d249831b3..0743f5ec0e 100644
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
@@ -215,13 +216,48 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
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
+            vcssb.length = 4;
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
+        if (be32_to_cpu(vcssb.length) > 4 && be32_to_cpu(vcssb.length) < 128) {
+            rc = DIAG_320_RC_INVAL_VCSSB_LEN;
+            break;
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


