Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A10C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDA5j-0004Hr-BT; Thu, 08 May 2025 18:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5Z-00047K-Gr; Thu, 08 May 2025 18:51:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5X-0006Ts-BF; Thu, 08 May 2025 18:51:37 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548LcoGb004203;
 Thu, 8 May 2025 22:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=XnMhed50OktfbiZSb
 +vUmhVJ1iRQHy8HVofDNnON/pM=; b=ScZlLQIfTbAgVZOunVZiVrcLHOQiUZ6kH
 eplpunvN94BbA97DoJiWplkBnJ7dT8vNCmVrIGQXmW5eGNE14B5IU53F1qM1lopl
 Kh9fGof36uXw1u4dHuLs5TLgZ2ZPnWaM9U2U9FixLubtO0mIgKmBr0iQpWxB+uZ+
 yO7ieSHtHHeV37iOCGzU8sq9EfWxH+UGH6X5XPx/vXGjdQZtxaUaJfTEyHTwLGCY
 BOmCaXy+jErFvRQAxcgZicowNDksZwAndSz7hToQjY71G/6UYpqb+IReTcF9a0YN
 UyheNCpf6ZCIjSsLVvEizjOXdl4yT+df4AGecwIZtmeUOBGz1oVbg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h4q8r8dm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548KWBs1001313;
 Thu, 8 May 2025 22:51:31 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dwftr946-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:31 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 548MpTr630999162
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 May 2025 22:51:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 674A458063;
 Thu,  8 May 2025 22:51:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 075DF58055;
 Thu,  8 May 2025 22:51:28 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.11.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 May 2025 22:51:27 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v2 09/25] s390x/diag: Implement DIAG 508 subcode 1 for
 signature verification
Date: Thu,  8 May 2025 18:50:25 -0400
Message-ID: <20250508225042.313672-10-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508225042.313672-1-zycai@linux.ibm.com>
References: <20250508225042.313672-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N6spF39B c=1 sm=1 tr=0 ts=681d3574 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=ljYFThA5NYKY8u4ZlFIA:9
X-Proofpoint-GUID: DDs6kPwfn9Z2V85Lf3sBwwOVNCwHQeSj
X-Proofpoint-ORIG-GUID: DDs6kPwfn9Z2V85Lf3sBwwOVNCwHQeSj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDIwNSBTYWx0ZWRfX7AbzUeETLY/c
 ClJl1uJ2ZPP9WPWZmM0ASskYx83Z+ISWHtNlqIu8PNX/+U6/iD+dvmfMymLWlRNn2kuVdx40aK2
 gIqRJMG4w//x7GAJBnm5kX9+lA6m7B4OPd6oCxGDYq+IjZvUfM0lWTSMSCEDa8jg9QNIGQDrMi0
 P4CjUVGZZ6S9Cv5pPYEnChbt/+V6EJeusVdZtvF5Sij9bC+fviCNNHI54AxqSK1ABejJCVxkZHd
 HlbTI5ytQ3bfI1PVl3y2oNvwv60z3oeRS7U5V57OPofRHz3asubgBD5ak9kPHIvhumrhAmcjmuN
 vvqFSYekjhsmQ8E1n9uVSFk0+2ccrA+9Pt7ke3x/2xeMJSVhhZC0tEJUeUEQ65yskprkInS9PA9
 7EaVlejJ4oPTvcrFacbD7kakXb1yDSctrhcSeOEu0Of6mVA/zDuNrwXEEW52axfQbAeCyTz5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_07,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080205
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
 crypto/x509-utils.c            | 54 +++++++++++++++++++++++
 include/crypto/x509-utils.h    |  4 ++
 include/hw/s390x/ipl/diag508.h | 22 +++++++++
 target/s390x/diag.c            | 81 +++++++++++++++++++++++++++++++++-
 4 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index 51bd75d4eb..56d9a42f39 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -20,6 +20,7 @@
 #include <gnutls/gnutls.h>
 #include <gnutls/crypto.h>
 #include <gnutls/x509.h>
+#include <gnutls/pkcs7.h>
 
 static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
     [QCRYPTO_HASH_ALGO_MD5] = GNUTLS_DIG_MD5,
@@ -373,6 +374,51 @@ cleanup:
     return ret;
 }
 
+int qcrypto_verify_x509_cert(uint8_t *cert, size_t cert_size,
+                            uint8_t *comp, size_t comp_size,
+                            uint8_t *sig, size_t sig_size, Error **errp)
+{
+    int rc = -1;
+    gnutls_x509_crt_t crt;
+    gnutls_pkcs7_t signature;
+    gnutls_datum_t cert_datum = {.data = cert, .size = cert_size};
+    gnutls_datum_t data_datum = {.data = comp, .size = comp_size};
+    gnutls_datum_t sig_datum = {.data = sig, .size = sig_size};
+    gnutls_x509_crt_fmt_t fmt;
+
+    fmt = qcrypto_get_x509_cert_fmt(cert, cert_size, errp);
+    if (fmt == -1) {
+        error_setg(errp, "Certificate is neither in DER or PEM format");
+        return rc;
+    }
+
+    if (gnutls_x509_crt_init(&crt) < 0) {
+        error_setg(errp, "Failed to initialize certificate");
+        return rc;
+    }
+
+    if (gnutls_x509_crt_import(crt, &cert_datum, fmt) != 0) {
+        error_setg(errp, "Failed to import certificate");
+        goto cleanup;
+    }
+
+    if (gnutls_pkcs7_init(&signature) < 0) {
+        error_setg(errp, "Failed to initalize pkcs7 data.");
+        return rc;
+    }
+
+    if (gnutls_pkcs7_import(signature, &sig_datum , fmt) != 0) {
+        error_setg(errp, "Failed to import signature");
+    }
+
+    rc = gnutls_pkcs7_verify_direct(signature, crt, 0, &data_datum, 0);
+
+cleanup:
+    gnutls_x509_crt_deinit(crt);
+    gnutls_pkcs7_deinit(signature);
+    return rc;
+}
+
 #else /* ! CONFIG_GNUTLS */
 
 int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
@@ -438,4 +484,12 @@ int qcrypto_get_x509_cert_key_id(uint8_t *cert, size_t size,
     return -ENOTSUP;
 }
 
+int qcrypto_verify_x509_cert(uint8_t *cert, size_t cert_size,
+                             uint8_t *comp, size_t comp_size,
+                             uint8_t *sig, size_t sig_size, Error **errp)
+{
+    error_setg(errp, "signature-verification support requires GNUTLS");
+    return -ENOTSUP;
+}
+
 #endif /* ! CONFIG_GNUTLS */
diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
index cf43de0b2c..ec90667376 100644
--- a/include/crypto/x509-utils.h
+++ b/include/crypto/x509-utils.h
@@ -35,4 +35,8 @@ int qcrypto_get_x509_cert_key_id(uint8_t *cert, size_t size,
                                  size_t *resultlen,
                                  Error **errp);
 
+int qcrypto_verify_x509_cert(uint8_t *cert, size_t cert_size,
+                             uint8_t *comp, size_t comp_size,
+                             uint8_t *sig, size_t sig_size, Error **errp);
+
 #endif
diff --git a/include/hw/s390x/ipl/diag508.h b/include/hw/s390x/ipl/diag508.h
index 6281ad8299..80a5bb906b 100644
--- a/include/hw/s390x/ipl/diag508.h
+++ b/include/hw/s390x/ipl/diag508.h
@@ -11,5 +11,27 @@
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
+    uint64_t len;
+} QEMU_PACKED;
+typedef struct Diag508CertificateStoreInfo Diag508CertificateStoreInfo;
+
+struct Diag508SignatureVerificationBlock {
+    Diag508CertificateStoreInfo csi;
+    uint64_t comp_len;
+    uint64_t comp_addr;
+    uint64_t sig_len;
+    uint64_t sig_addr;
+} QEMU_PACKED;
+typedef struct Diag508SignatureVerificationBlock Diag508SignatureVerificationBlock;
 
 #endif
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 954c95fe50..2171e3275d 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -494,7 +494,10 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
 void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
+    S390IPLCertificateStore *qcs = s390_ipl_get_certificate_store();
+    size_t csi_size = sizeof(Diag508CertificateStoreInfo);
     uint64_t subcode = env->regs[r3];
+    uint64_t addr = env->regs[r1];
     int rc;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
@@ -509,7 +512,83 @@ void handle_diag_508(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
     switch (subcode) {
     case DIAG_508_SUBC_QUERY_SUBC:
-        rc = 0;
+        rc = DIAG_508_SUBC_SIG_VERIF;
+        break;
+    case DIAG_508_SUBC_SIG_VERIF:
+        size_t svb_size = sizeof(Diag508SignatureVerificationBlock);
+        Diag508SignatureVerificationBlock *svb;
+        uint64_t comp_len, comp_addr;
+        uint64_t sig_len, sig_addr;
+        uint8_t *svb_comp;
+        uint8_t *svb_sig;
+        int verified;
+        Error *err = NULL;
+        int i;
+
+        if (!qcs || !qcs->count) {
+            rc = DIAG_508_RC_NO_CERTS;
+            break;
+        }
+
+        if (!diag_parm_addr_valid(addr, svb_size, false) ||
+            !diag_parm_addr_valid(addr, csi_size, true)) {
+            s390_program_interrupt(env, PGM_ADDRESSING, ra);
+            return;
+        }
+
+        svb = g_new0(Diag508SignatureVerificationBlock, 1);
+        cpu_physical_memory_read(addr, svb, svb_size);
+
+        comp_len = be64_to_cpu(svb->comp_len);
+        comp_addr = be64_to_cpu(svb->comp_addr);
+        sig_len = be64_to_cpu(svb->sig_len);
+        sig_addr = be64_to_cpu(svb->sig_addr);
+
+        if (!comp_len || !comp_addr) {
+            rc = DIAG_508_RC_INVAL_COMP_DATA;
+            g_free(svb);
+            break;
+        }
+
+        if (!sig_len || !sig_addr) {
+            rc = DIAG_508_RC_INVAL_PKCS7_SIG;
+            g_free(svb);
+            break;
+        }
+
+        svb_comp = g_malloc0(comp_len);
+        cpu_physical_memory_read(comp_addr, svb_comp, comp_len);
+
+        svb_sig = g_malloc0(sig_len);
+        cpu_physical_memory_read(sig_addr, svb_sig, sig_len);
+
+        rc = DIAG_508_RC_FAIL_VERIF;
+        /*
+         * It is uncertain which certificate contains
+         * the analogous key to verify the signed data
+         */
+        for (i = 0; i < qcs->count; i++) {
+            verified = qcrypto_verify_x509_cert((uint8_t *)qcs->certs[i].raw,
+                                                qcs->certs[i].size,
+                                                svb_comp, comp_len,
+                                                svb_sig, sig_len, &err);
+
+            /* return early if GNUTLS is not enabled */
+            if (verified == -ENOTSUP) {
+                g_free(svb);
+                break;
+            }
+
+            if (verified == 0) {
+                svb->csi.idx = i;
+                svb->csi.len = cpu_to_be64(qcs->certs[i].size);
+                cpu_physical_memory_write(addr, &svb->csi, be32_to_cpu(csi_size));
+                rc = DIAG_508_RC_OK;
+                break;
+           }
+        }
+
+        g_free(svb);
         break;
     default:
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
-- 
2.49.0


