Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DB2C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 21:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMw7G-0002m7-4n; Wed, 04 Jun 2025 17:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw79-0002ht-Ol; Wed, 04 Jun 2025 17:57:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw77-0006zE-Lf; Wed, 04 Jun 2025 17:57:39 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554Kow9r027916;
 Wed, 4 Jun 2025 21:57:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=3CBYK+UEuG7OxBL2H
 12gVvOMtb6NPimHBQncLSvjWTY=; b=cc0AQpPqPWFYnLyrPgoxaYl/vbxnToyOG
 65jfmRyaXgosMxnjoYDc8xrxdDJYwcGsUA5mOQkqH2Cd4u+Lz0Cz8lr8Fbp+qdiW
 QlLqskwgTfcR61lKtsYVNFhGB5dH0DQFfnAi4ABA61tI+UBL845zA5TEdIkzBZsS
 rX/lYB9PVP7ReYw1BaWldDvi40CGeFbdm8XKjWGpBGOd3Hc+ZhqesQ8jZ0YvrQ6N
 2c7s9eg+k4V6fXYIJZXwv311jiuSPa05UmLSO5AmEtAF8Y0A0rQ0pcRu2gMgkcAs
 epD4bcjUHqtcy+ZW2eyCgdhNYOyfaCPjcFGuW+Afdimb5okqKUFlA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyddpr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 554Je3VQ022518;
 Wed, 4 Jun 2025 21:57:34 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 470c3tj1r4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:34 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 554LvWYo30081560
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jun 2025 21:57:33 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C81C758050;
 Wed,  4 Jun 2025 21:57:32 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA84158045;
 Wed,  4 Jun 2025 21:57:30 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.211])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jun 2025 21:57:30 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v3 12/28] s390x/diag: Implement DIAG 508 subcode 1 for
 signature verification
Date: Wed,  4 Jun 2025 17:56:40 -0400
Message-ID: <20250604215657.528142-13-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604215657.528142-1-zycai@linux.ibm.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=6840c14f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=-xtd8P_9Xh0oiWuInCYA:9
X-Proofpoint-GUID: wpsCq8Y5eqyTFKYL8mbiNvPJzk01MttB
X-Proofpoint-ORIG-GUID: wpsCq8Y5eqyTFKYL8mbiNvPJzk01MttB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE3NSBTYWx0ZWRfX8/Uy56CnYMU3
 r3IyryaJa+0cYqqH8des7k2E6MXZeuVI/HcqtGVqVx8JTC/6rb/a1BTqpMOfSpI/EhaifjIb2D1
 Hy5P4X1HqKCiTe3H02D724duvymMd2a8GUKZWBc64JF8QHVraeg3ek+EBB54X0+CQfYo4l0Uwf/
 iURK2SxZkOsnwbS3ct4tnd+wbgQENAZcUVVymt6k17iY+KUln3o2wzs5EiPENFhTyjloEBKRbGe
 RZjr4i7dctFRkYRQdZnoQSpIV/OG+aHQslBcTCfbzB1FNPMFTYaQvXt5cHNFN02MT32jUbIOvQX
 /JpNDnpfWsOmZfLZXYiQf7oAtsm9o/vdqYEsrs9gx6aZxFaOpsjWqS3e5h9gmXpU64wnMNNE6oH
 dZr0QoMZkCHZj1mvDO0oiYXpEqp1jBWGLY48OVuynKjUw/RzzY/s/LOQszNlHfNSlCGRffX1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040175
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

From: Collin Walling <walling@linux.ibm.com>

DIAG 508 subcode 1 performs signature-verification on signed components.
A signed component may be a Linux kernel image, or any other signed
binary. **Verification of initrd is not supported.**

The instruction call expects two item-pairs: an address of a device
component, an address of the analogous signature file (in PKCS#7 format),
and their respective lengths. All of this data should be encapsulated
within a Diag508SignatureVerificationBlock, with the CertificateStoreInfo
fields ignored. The DIAG handler will read from the provided addresses
to retrieve the necessary data, parse the signature file, then
perform the signature-verification. Because there is no way to
correlate a specific certificate to a component, each certificate
in the store is tried until either verification succeeds, or all
certs have been exhausted.

The subcode value is denoted by setting the second-to-left-most bit of
a 2-byte field.

A return code of 1 indicates success, and the index and length of the
corresponding certificate will be set in the CertificateStoreInfo
portion of the SigVerifBlock. The following values indicate failure:

	0x0202: component data is invalid
	0x0302: signature is not in PKCS#7 format
	0x0402: signature-verification failed

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 include/hw/s390x/ipl/diag508.h | 23 +++++++++
 target/s390x/diag.c            | 86 +++++++++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/include/hw/s390x/ipl/diag508.h b/include/hw/s390x/ipl/diag508.h
index 6281ad8299..c99c6705c0 100644
--- a/include/hw/s390x/ipl/diag508.h
+++ b/include/hw/s390x/ipl/diag508.h
@@ -11,5 +11,28 @@
 #define S390X_DIAG508_H
 
 #define DIAG_508_SUBC_QUERY_SUBC    0x0000
+#define DIAG_508_SUBC_SIG_VERIF     0x8000
+
+#define DIAG_508_RC_OK              0x0001
+#define DIAG_508_RC_NO_CERTS        0x0102
+#define DIAG_508_RC_INVAL_COMP_DATA 0x0202
+#define DIAG_508_RC_INVAL_PKCS7_SIG 0x0302
+#define DIAG_508_RC_FAIL_VERIF      0x0402
+
+struct Diag508CertificateStoreInfo {
+    uint8_t  idx;
+    uint8_t  reserved[7];
+    uint64_t len;
+};
+typedef struct Diag508CertificateStoreInfo Diag508CertificateStoreInfo;
+
+struct Diag508SignatureVerificationBlock {
+    Diag508CertificateStoreInfo csi;
+    uint64_t comp_len;
+    uint64_t comp_addr;
+    uint64_t sig_len;
+    uint64_t sig_addr;
+};
+typedef struct Diag508SignatureVerificationBlock Diag508SignatureVerificationBlock;
 
 #endif
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 1ef1eb5299..ca7dd0f2e6 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -526,9 +526,81 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
     env->regs[r1 + 1] = rc;
 }
 
+static int handle_diag508_sig_verif(uint64_t addr, size_t csi_size, size_t svb_size,
+                                    S390IPLCertificateStore *qcs)
+{
+    int rc;
+    int verified;
+    Error *err;
+    uint64_t comp_len, comp_addr;
+    uint64_t sig_len, sig_addr;
+    g_autofree uint8_t *svb_comp;
+    g_autofree uint8_t *svb_sig;
+    g_autofree Diag508SignatureVerificationBlock *svb;
+
+    if (!qcs || !qcs->count) {
+        return DIAG_508_RC_NO_CERTS;
+    }
+
+    svb = g_new0(Diag508SignatureVerificationBlock, 1);
+    cpu_physical_memory_read(addr, svb, svb_size);
+
+    comp_len = be64_to_cpu(svb->comp_len);
+    comp_addr = be64_to_cpu(svb->comp_addr);
+    sig_len = be64_to_cpu(svb->sig_len);
+    sig_addr = be64_to_cpu(svb->sig_addr);
+
+    if (!comp_len || !comp_addr) {
+        return DIAG_508_RC_INVAL_COMP_DATA;
+    }
+
+    if (!sig_len || !sig_addr) {
+        return DIAG_508_RC_INVAL_PKCS7_SIG;
+    }
+
+    svb_comp = g_malloc0(comp_len);
+    cpu_physical_memory_read(comp_addr, svb_comp, comp_len);
+
+    svb_sig = g_malloc0(sig_len);
+    cpu_physical_memory_read(sig_addr, svb_sig, sig_len);
+
+    rc = DIAG_508_RC_FAIL_VERIF;
+    /*
+     * It is uncertain which certificate contains
+     * the analogous key to verify the signed data
+     */
+    for (int i = 0; i < qcs->count; i++) {
+        err = NULL;
+        verified = qcrypto_verify_x509_cert((uint8_t *)qcs->certs[i].raw,
+                                            qcs->certs[i].size,
+                                            svb_comp, comp_len,
+                                            svb_sig, sig_len, &err);
+
+        /* return early if GNUTLS is not enabled */
+        if (verified == -ENOTSUP) {
+            break;
+        }
+
+        if (verified == 0) {
+            svb->csi.idx = i;
+            svb->csi.len = cpu_to_be64(qcs->certs[i].size);
+            cpu_physical_memory_write(addr, &svb->csi, be32_to_cpu(csi_size));
+            rc = DIAG_508_RC_OK;
+            break;
+       }
+    }
+
+    return rc;
+}
+
+QEMU_BUILD_BUG_MSG(sizeof(Diag508SignatureVerificationBlock) != 48,
+                   "size of Diag508SignatureVerificationBlock is wrong");
+
 void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
+    S390IPLCertificateStore *qcs = s390_ipl_get_certificate_store();
     uint64_t subcode = env->regs[r3];
+    uint64_t addr = env->regs[r1];
     int rc;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
@@ -543,7 +615,19 @@ void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
     switch (subcode) {
     case DIAG_508_SUBC_QUERY_SUBC:
-        rc = 0;
+        rc = DIAG_508_SUBC_SIG_VERIF;
+        break;
+    case DIAG_508_SUBC_SIG_VERIF:
+        size_t csi_size = sizeof(Diag508CertificateStoreInfo);
+        size_t svb_size = sizeof(Diag508SignatureVerificationBlock);
+
+        if (!diag_parm_addr_valid(addr, svb_size, false) ||
+            !diag_parm_addr_valid(addr, csi_size, true)) {
+            s390_program_interrupt(env, PGM_ADDRESSING, ra);
+            return;
+        }
+
+        rc = handle_diag508_sig_verif(addr, csi_size, svb_size, qcs);
         break;
     default:
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-- 
2.49.0


