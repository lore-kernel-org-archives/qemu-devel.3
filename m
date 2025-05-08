Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D56C3ABC5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDA5f-0004DS-Mi; Thu, 08 May 2025 18:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5S-000460-6A; Thu, 08 May 2025 18:51:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5O-0006Su-Pu; Thu, 08 May 2025 18:51:29 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548KEFMD011690;
 Thu, 8 May 2025 22:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=RtdXI4BwukCJjH2rf
 wJgiGKWwqX77gxqX75i5A+21X4=; b=hevo8/yg0lsbbkJcBbn6z2X+lJYOW9TkA
 +iPH+dPXxQv9++xNx7IlQH5dkipHsnFNpSpO88hYre1BuOzEdz/o2U0YPgtWap8Q
 hqoJot3PyWFkH0ENRAY0gcWj2MiVPjV9YcHxdMyvu0cuejNL5lWzyrw7pvVKwG3h
 S3J34RVvKgAQn1ebultG/GoYA8soTOfMSXF5DteHNAeIfrbhijLNtJlDTa5LMz5i
 7VXxx1ive5XOgF1C3pVCtvBJh+/0oeIniynsX/PcWGnvFbf85mE26m/7nB96PJvN
 Y/JMC397VZqi7VLOsd9FsTlzCH2SMeCowCRsXL7YEFbvmxuUp70Aw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gu2t3atp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548LVTM5025798;
 Thu, 8 May 2025 22:51:24 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwv0886d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:24 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 548MpN4022413800
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 May 2025 22:51:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32E505805B;
 Thu,  8 May 2025 22:51:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AEFF458055;
 Thu,  8 May 2025 22:51:21 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.11.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 May 2025 22:51:21 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v2 07/25] s390x/diag: Implement DIAG 320 subcode 2
Date: Thu,  8 May 2025 18:50:23 -0400
Message-ID: <20250508225042.313672-8-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508225042.313672-1-zycai@linux.ibm.com>
References: <20250508225042.313672-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NLnV+16g c=1 sm=1 tr=0 ts=681d356d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=U5Kxr4yU-FAgF73suGkA:9
X-Proofpoint-ORIG-GUID: QMZGUsOY3ipNKJzKuRS2f5ufPyQ7j3sX
X-Proofpoint-GUID: QMZGUsOY3ipNKJzKuRS2f5ufPyQ7j3sX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDIwNSBTYWx0ZWRfXyDUIIYzvFT6k
 rsbTgx6/tEyIJOp1JIQFBQqjffL7zkv8Ep1qafMo+0p72EEG4zFaZGtlKB0l5kfxRqwEKClm4/F
 g+q9NT03BpA1fdfLDzIEzRL5MR8zv8arQ8D4lQHq/NrykGrmqqeDmxoVzf5DNPuGoiRjjWi/UtX
 P2K+Ut/16TuJlB+ebG4Dsa6C4N0fwxFd0IJJO7JqJ0lyqs/vVeGLI3hPLpQL/W6m+MDHzkSR7LB
 g51X1u1OctA54XVUDrIb3jVrXPNHfOZAp8iNc6kBmIlANuqAVeSE1SPIYKm0BXNnMYRoywiYLlS
 v7h1sn9/7VFsCb72XRpSgQoLer4BfJvkmz8MUQ8/SabL8/h8WQ2E3f01Up2/4QG/N5vVkmi2w5o
 vIAmkCP4IuC8J/FqP400g27m5/fRFmqqGBvTLusc0yJQ+eP942C3vSNg64zUjf3DuMRn87s5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_07,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
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

DIAG 320 subcode 2 provides verification-certificates (VCs) that are in the
certificate store. Only X509 certificates in DER format and SHA-256 hash
type are recognized.

The subcode value is denoted by setting the second-left-most bit
of an 8-byte field.

The Verification Certificate Block (VCB) contains the output data
when the operation completes successfully. It includes a common
header followed by zero or more Verification Certificate Entries (VCEs),
depending on the VCB input length and the VC range (from the first VC
index to the last VC index) in the certificate store.

Each VCE contains information about a certificate retrieved from
the S390IPLCertificateStore, such as the certificate name, key type,
key ID length, hash length, and the raw certificate data.
The key ID and hash are extracted from the raw certificate by the crypto API.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 crypto/x509-utils.c            | 204 ++++++++++++++++++++++++++++-
 include/crypto/x509-utils.h    |  10 ++
 include/hw/s390x/ipl/diag320.h |  47 +++++++
 qapi/crypto.json               |  20 +++
 target/s390x/diag.c            | 227 ++++++++++++++++++++++++++++++++-
 5 files changed, 506 insertions(+), 2 deletions(-)

diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index 0b8cfc9022..51bd75d4eb 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -129,6 +129,7 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
     int hlen;
     gnutls_x509_crt_t crt;
     gnutls_datum_t datum = {.data = cert, .size = size};
+    gnutls_x509_crt_fmt_t fmt;
 
     if (alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
         error_setg(errp, "Unknown hash algorithm");
@@ -140,9 +141,15 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
         return -1;
     }
 
+    fmt = qcrypto_get_x509_cert_fmt(cert, size, errp);
+    if (fmt == -1) {
+        error_setg(errp, "Certificate is neither in DER or PEM format");
+        return -1;
+    }
+
     gnutls_x509_crt_init(&crt);
 
-    if (gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM) != 0) {
+    if (gnutls_x509_crt_import(crt, &datum, fmt) != 0) {
         error_setg(errp, "Failed to import certificate");
         goto cleanup;
     }
@@ -199,6 +206,173 @@ cleanup:
     return rc;
 }
 
+int qcrypto_get_x509_cert_version(uint8_t *cert, size_t size, Error **errp)
+{
+    int rc = -1;
+    gnutls_x509_crt_t crt;
+    gnutls_datum_t datum = {.data = cert, .size = size};
+    gnutls_x509_crt_fmt_t fmt;
+
+    fmt = qcrypto_get_x509_cert_fmt(cert, size, errp);
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
+    if (gnutls_x509_crt_import(crt, &datum, fmt) != 0) {
+        error_setg(errp, "Failed to import certificate");
+        goto cleanup;
+    }
+
+    rc = gnutls_x509_crt_get_version(crt);
+
+cleanup:
+    gnutls_x509_crt_deinit(crt);
+    return rc;
+}
+
+int qcrypto_check_x509_cert_times(uint8_t *cert, size_t size, Error **errp)
+{
+    int rc = -1;
+    gnutls_x509_crt_t crt;
+    gnutls_datum_t datum = {.data = cert, .size = size};
+    time_t now = time(0);
+    gnutls_x509_crt_fmt_t fmt;
+
+    if (now == ((time_t)-1)) {
+        error_setg(errp, "Cannot get current time");
+        return rc;
+    }
+
+    fmt = qcrypto_get_x509_cert_fmt(cert, size, errp);
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
+    if (gnutls_x509_crt_import(crt, &datum, fmt) != 0) {
+        error_setg(errp, "Failed to import certificate");
+        goto cleanup;
+    }
+
+    if (gnutls_x509_crt_get_expiration_time(crt) < now) {
+        error_setg(errp, "The certificate has expired");
+        goto cleanup;
+    }
+
+    if (gnutls_x509_crt_get_activation_time(crt) > now) {
+        error_setg(errp, "The certificate is not yet active");
+        goto cleanup;
+    }
+
+    rc = 0;
+
+cleanup:
+    gnutls_x509_crt_deinit(crt);
+    return rc;
+}
+
+int qcrypto_get_x509_pk_algorithm(uint8_t *cert, size_t size, Error **errp)
+{
+    int rc = -1;
+    unsigned int bits;
+    gnutls_x509_crt_t crt;
+    gnutls_datum_t datum = {.data = cert, .size = size};
+    gnutls_x509_crt_fmt_t fmt;
+
+    fmt = qcrypto_get_x509_cert_fmt(cert, size, errp);
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
+    if (gnutls_x509_crt_import(crt, &datum, fmt) != 0) {
+        error_setg(errp, "Failed to import certificate");
+        goto cleanup;
+    }
+
+    rc = gnutls_x509_crt_get_pk_algorithm(crt, &bits);
+
+cleanup:
+    gnutls_x509_crt_deinit(crt);
+    return rc;
+}
+
+int qcrypto_get_x509_cert_key_id(uint8_t *cert, size_t size,
+                                 QCryptoKeyidFlags flag,
+                                 uint8_t *result,
+                                 size_t *resultlen,
+                                 Error **errp)
+{
+    int ret = -1;
+    int keyid_len;
+    gnutls_x509_crt_t crt;
+    gnutls_datum_t datum = {.data = cert, .size = size};
+    gnutls_x509_crt_fmt_t fmt;
+
+    if (flag >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map)) {
+        error_setg(errp, "Unknown key id flag");
+        return -1;
+    }
+
+    if (result == NULL) {
+        error_setg(errp, "No valid buffer given");
+        return -1;
+    }
+
+    fmt = qcrypto_get_x509_cert_fmt(cert, size, errp);
+    if (fmt == -1) {
+        error_setg(errp, "Certificate is neither in DER or PEM format");
+        return -1;
+    }
+
+    if (gnutls_x509_crt_init(&crt)) {
+        error_setg(errp, "Failed to initialize certificate");
+        return -1;
+    }
+
+    if (gnutls_x509_crt_import(crt, &datum, fmt) != 0) {
+        error_setg(errp, "Failed to import certificate");
+        goto cleanup;
+    }
+
+    keyid_len = qcrypto_get_x509_keyid_len(QCRYPTO_KEYID_FLAGS_SHA256, errp);
+    if (*resultlen < keyid_len) {
+        error_setg(errp,
+                   "Result buffer size %zu is smaller than key id %d",
+                   *resultlen, keyid_len);
+        goto cleanup;
+    }
+
+    if (gnutls_x509_crt_get_key_id(crt,
+                                   qcrypto_to_gnutls_keyid_flags_map[flag],
+                                   result, resultlen) != 0) {
+        error_setg(errp, "Failed to get fingerprint from certificate");
+        goto cleanup;
+    }
+
+    ret = 0;
+
+cleanup:
+    gnutls_x509_crt_deinit(crt);
+    return ret;
+}
+
 #else /* ! CONFIG_GNUTLS */
 
 int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
@@ -236,4 +410,32 @@ int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **err
     return -ENOTSUP;
 }
 
+int qcrypto_get_x509_cert_version(uint8_t *cert, size_t size, Error **errp)
+{
+    error_setg(errp, "To get certificate version requires GNUTLS");
+    return -ENOTSUP;
+}
+
+int qcrypto_check_x509_cert_times(uint8_t *cert, size_t size, Error **errp)
+{
+    error_setg(errp, "To get certificate times requires GNUTLS");
+    return -ENOTSUP;
+}
+
+int qcrypto_get_x509_pk_algorithm(uint8_t *cert, size_t size, Error **errp)
+{
+    error_setg(errp, "To get public key algorithm requires GNUTLS");
+    return -ENOTSUP;
+}
+
+int qcrypto_get_x509_cert_key_id(uint8_t *cert, size_t size,
+                                 QCryptoKeyidFlags flag,
+                                 uint8_t *result,
+                                 size_t *resultlen,
+                                 Error **errp)
+{
+    error_setg(errp, "To get key ID requires GNUTLS");
+    return -ENOTSUP;
+}
+
 #endif /* ! CONFIG_GNUTLS */
diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
index 8fb263b9e1..cf43de0b2c 100644
--- a/include/crypto/x509-utils.h
+++ b/include/crypto/x509-utils.h
@@ -25,4 +25,14 @@ int qcrypto_get_x509_hash_len(QCryptoHashAlgo alg, Error **errp);
 int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag, Error **errp);
 int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **errp);
 
+int qcrypto_get_x509_cert_version(uint8_t *cert, size_t size, Error **errp);
+int qcrypto_check_x509_cert_times(uint8_t *cert, size_t size, Error **errp);
+int qcrypto_get_x509_pk_algorithm(uint8_t *cert, size_t size, Error **errp);
+
+int qcrypto_get_x509_cert_key_id(uint8_t *cert, size_t size,
+                                 QCryptoKeyidFlags flag,
+                                 uint8_t *result,
+                                 size_t *resultlen,
+                                 Error **errp);
+
 #endif
diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
index e91eb7238c..dc1dae1d76 100644
--- a/include/hw/s390x/ipl/diag320.h
+++ b/include/hw/s390x/ipl/diag320.h
@@ -12,15 +12,24 @@
 
 #define DIAG_320_SUBC_QUERY_ISM     0
 #define DIAG_320_SUBC_QUERY_VCSI    1
+#define DIAG_320_SUBC_STORE_VC      2
 
 #define DIAG_320_RC_OK              0x0001
 #define DIAG_320_RC_INVAL_VCSSB_LEN 0x0202
+#define DIAG_320_RC_INVAL_VCB_LEN   0x0204
+#define DIAG_320_RC_BAD_RANGE       0x0302
 
 #define VCSSB_MAX_LEN   128
 #define VCE_HEADER_LEN  128
 #define VCB_HEADER_LEN  64
 
 #define DIAG_320_ISM_QUERY_VCSI     0x4000000000000000
+#define DIAG_320_ISM_STORE_VC       0x2000000000000000
+
+#define DIAG_320_VCE_FLAGS_VALID                0x80
+#define DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING    0
+#define DIAG_320_VCE_FORMAT_X509_DER            1
+#define DIAG_320_VCE_HASHTYPE_SHA2_256          1
 
 struct VCStorageSizeBlock {
     uint32_t length;
@@ -39,4 +48,42 @@ struct VCStorageSizeBlock {
 typedef struct VCStorageSizeBlock \
 VCStorageSizeBlock;
 
+struct VCBlock {
+    uint32_t in_len;
+    uint32_t reserved0;
+    uint16_t first_vc_index;
+    uint16_t last_vc_index;
+    uint32_t reserved1[5];
+    uint32_t out_len;
+    uint8_t reserved2[3];
+    uint8_t version;
+    uint16_t stored_ct;
+    uint16_t remain_ct;
+    uint32_t reserved3[5];
+    uint8_t vce_buf[];
+} QEMU_PACKED;
+typedef struct VCBlock VCBlock;
+
+struct VCEntry {
+    uint32_t len;
+    uint8_t flags;
+    uint8_t key_type;
+    uint16_t cert_idx;
+    uint32_t name[16];
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
+    uint8_t cert_buf[];
+} QEMU_PACKED;
+typedef struct VCEntry VCEntry;
+
 #endif
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 2bbf29affe..4757bcd3db 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -692,3 +692,23 @@
            'rsa-sha256', 'rsa-sha384', 'rsa-sha512', 'rsa-sha224',
            'dsa-sha224', 'dsa-sha256',
            'ecdsa-sha1', 'ecdsa-sha224', 'ecdsa-sha256', 'ecdsa-sha384', 'ecdsa-sha512']}
+
+##
+# @QCryptoPkAlgo:
+#
+# Algorithms for public-key
+#
+# @unknown: UNKNOWN
+#
+# @rsa: RSA
+#
+# @dsa: DSA
+#
+# @dh: DH
+#
+# @ecdsa: ECDSA
+#
+# Since: 9.2
+##
+{ 'enum': 'QCryptoPkAlgo',
+  'data': ['unknown', 'rsa', 'dsa', 'dh', 'ecdsa']}
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 0743f5ec0e..6fd59ac863 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -17,12 +17,14 @@
 #include "s390x-internal.h"
 #include "hw/watchdog/wdt_diag288.h"
 #include "system/cpus.h"
+#include "hw/s390x/cert-store.h"
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "system/kvm.h"
 #include "kvm/kvm_s390x.h"
 #include "target/s390x/kvm/pv.h"
 #include "qemu/error-report.h"
+#include "crypto/x509-utils.h"
 
 
 int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
@@ -191,6 +193,87 @@ out:
     }
 }
 
+static int diag_320_is_cert_valid(S390IPLCertificate qcert, Error **errp)
+{
+    int version;
+    int rc;
+
+    version = qcrypto_get_x509_cert_version((uint8_t *)qcert.raw, qcert.size, errp);
+    if (version < 0) {
+        return version == -ENOTSUP ? -ENOTSUP : 0;
+    }
+
+    rc = qcrypto_check_x509_cert_times((uint8_t *)qcert.raw, qcert.size, errp);
+    if (rc) {
+        return 0;
+    }
+
+    return 1;
+}
+
+static int diag_320_get_cert_info(VCEntry *vce, S390IPLCertificate qcert, int *is_valid,
+                                  unsigned char **key_id_data, void **hash_data)
+{
+    int algo;
+    int rc;
+    Error *err = NULL;
+
+    /* VCE flag (validity) */
+    *is_valid = diag_320_is_cert_valid(qcert, &err);
+    /* return early if GNUTLS is not enabled */
+    if (*is_valid == -ENOTSUP) {
+        error_report("GNUTLS is not supported");
+        return -1;
+    }
+
+    /* key-type */
+    algo = qcrypto_get_x509_pk_algorithm((uint8_t *)qcert.raw, qcert.size, &err);
+    if (algo == QCRYPTO_PK_ALGO_RSA) {
+        vce->key_type = DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING;
+    }
+
+    /* VC format */
+    if (qcert.format == QCRYPTO_CERT_FMT_DER) {
+        vce->format = DIAG_320_VCE_FORMAT_X509_DER;
+    }
+
+    /* key id and key id len */
+    *key_id_data = g_malloc0(qcert.key_id_size);
+    rc = qcrypto_get_x509_cert_key_id((uint8_t *)qcert.raw, qcert.size,
+                                      QCRYPTO_KEYID_FLAGS_SHA256,
+                                      *key_id_data, &qcert.key_id_size, &err);
+    if (rc < 0) {
+        error_report("Fail to retrieve certificate key ID");
+        goto out;
+    }
+    vce->keyid_len = cpu_to_be16(qcert.key_id_size);
+
+    /* hash type */
+    if (qcert.hash_type == QCRYPTO_SIG_ALGO_RSA_SHA256) {
+        vce->hash_type = DIAG_320_VCE_HASHTYPE_SHA2_256;
+    }
+
+    /* hash and hash len */
+    *hash_data = g_malloc0(qcert.hash_size);
+    rc = qcrypto_get_x509_cert_fingerprint((uint8_t *)qcert.raw, qcert.size,
+                                           QCRYPTO_HASH_ALGO_SHA256,
+                                           *hash_data, &qcert.hash_size, &err);
+    if (rc < 0) {
+        error_report("Fail to retrieve certificate hash");
+        goto out;
+    }
+    vce->hash_len = cpu_to_be16(qcert.hash_size);
+
+    return 0;
+
+out:
+    g_free(*key_id_data);
+    g_free(*hash_data);
+
+    return -1;
+}
+
+
 void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     S390CPU *cpu = env_archcpu(env);
@@ -216,7 +299,7 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
     switch (subcode) {
     case DIAG_320_SUBC_QUERY_ISM:
-        uint64_t ism = cpu_to_be64(DIAG_320_ISM_QUERY_VCSI);
+        uint64_t ism = cpu_to_be64(DIAG_320_ISM_QUERY_VCSI | DIAG_320_ISM_STORE_VC);
 
         if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism, sizeof(ism))) {
             s390_cpu_virt_mem_handle_exc(cpu, ra);
@@ -260,6 +343,148 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
         }
         rc = DIAG_320_RC_OK;
         break;
+    case DIAG_320_SUBC_STORE_VC:
+        VCBlock *vcb;
+        size_t vce_offset;
+        size_t remaining_space;
+        size_t keyid_buf_size;
+        size_t hash_buf_size;
+        size_t cert_buf_size;
+        uint32_t vce_len;
+        unsigned char *key_id_data = NULL;
+        void *hash_data = NULL;
+        int is_valid = 0;
+        uint16_t first_vc_index;
+        uint16_t last_vc_index;
+        uint32_t in_len;
+
+        vcb = g_new0(VCBlock, 1);
+        if (s390_cpu_virt_mem_read(cpu, addr, r1, vcb, sizeof(*vcb))) {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
+            return;
+        }
+
+        in_len = be32_to_cpu(vcb->in_len);
+        first_vc_index = be16_to_cpu(vcb->first_vc_index);
+        last_vc_index = be16_to_cpu(vcb->last_vc_index);
+
+        if (in_len % TARGET_PAGE_SIZE != 0) {
+            rc = DIAG_320_RC_INVAL_VCB_LEN;
+            g_free(vcb);
+            break;
+        }
+
+        if (first_vc_index > last_vc_index) {
+            rc = DIAG_320_RC_BAD_RANGE;
+            g_free(vcb);
+            break;
+        }
+
+        if (first_vc_index == 0) {
+            /*
+             * Zero is a valid index for the first and last VC index.
+             * Zero index results in the VCB header and zero certificates returned.
+             */
+            if (last_vc_index == 0) {
+                goto out;
+            }
+
+            /* DIAG320 certificate store remains a one origin for cert entries */
+            vcb->first_vc_index = 1;
+        }
+
+        vce_offset = VCB_HEADER_LEN;
+        vcb->out_len = VCB_HEADER_LEN;
+        remaining_space = in_len - VCB_HEADER_LEN;
+
+        for (int i = first_vc_index - 1; i < last_vc_index && i < qcs->count; i++) {
+            VCEntry *vce;
+            S390IPLCertificate qcert = qcs->certs[i];
+            /*
+             * Each VCE is word aligned.
+             * Each variable length field within the VCE is also word aligned.
+             */
+            keyid_buf_size = ROUND_UP(qcert.key_id_size, 4);
+            hash_buf_size = ROUND_UP(qcert.hash_size, 4);
+            cert_buf_size = ROUND_UP(qcert.size, 4);
+            vce_len = VCE_HEADER_LEN + cert_buf_size + keyid_buf_size + hash_buf_size;
+
+            /*
+             * If there is no more space to store the cert,
+             * set the remaining verification cert count and
+             * break early.
+             */
+            if (remaining_space < vce_len) {
+                vcb->remain_ct = cpu_to_be16(last_vc_index - i);
+                break;
+            }
+
+            /*
+             * Construct VCE
+             * Unused area following the VCE field contains zeros.
+             */
+            vce = g_malloc0(vce_len);
+            vce->len = cpu_to_be32(vce_len);
+            vce->cert_idx = cpu_to_be16(i + 1);
+            vce->cert_len = cpu_to_be32(qcert.size);
+
+            strncpy((char *)vce->name, (char *)qcert.vc_name, VC_NAME_LEN_BYTES);
+
+            rc = diag_320_get_cert_info(vce, qcert, &is_valid, &key_id_data, &hash_data);
+            if (rc) {
+                g_free(vce);
+                continue;
+            }
+
+            /* VCE field offset is also word aligned */
+            vce->hash_offset = cpu_to_be16(VCE_HEADER_LEN + keyid_buf_size);
+            vce->cert_offset = cpu_to_be16(VCE_HEADER_LEN + keyid_buf_size +
+                                           hash_buf_size);
+
+            /* Write Key ID */
+            memcpy(vce->cert_buf, key_id_data, qcert.key_id_size);
+            /* Write Hash key */
+            memcpy(vce->cert_buf + keyid_buf_size, hash_data, qcert.hash_size);
+            /* Write VCE cert data */
+            memcpy(vce->cert_buf + keyid_buf_size + hash_buf_size, qcert.raw, qcert.size);
+
+            /* The certificate is valid and VCE contains the certificate */
+            if (is_valid) {
+                vce->flags |= DIAG_320_VCE_FLAGS_VALID;
+            }
+
+            /* Write VCE Header */
+            if (s390_cpu_virt_mem_write(cpu, addr + vce_offset, r1, vce, vce_len)) {
+                s390_cpu_virt_mem_handle_exc(cpu, ra);
+                return;
+            }
+
+            vce_offset += vce_len;
+            vcb->out_len += vce_len;
+            remaining_space -= vce_len;
+            vcb->stored_ct++;
+
+            g_free(vce);
+            g_free(key_id_data);
+            g_free(hash_data);
+        }
+
+        vcb->out_len = cpu_to_be32(vcb->out_len);
+        vcb->stored_ct = cpu_to_be16(vcb->stored_ct);
+
+    out:
+        /*
+         * Write VCB header
+         * All VCEs have been populated with the latest information
+         * and write VCB header last.
+         */
+        if (s390_cpu_virt_mem_write(cpu, addr, r1, vcb, VCB_HEADER_LEN)) {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
+            return;
+        }
+        rc = DIAG_320_RC_OK;
+        g_free(vcb);
+        break;
     default:
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
-- 
2.49.0


