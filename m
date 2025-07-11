Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EC9C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 21:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaL1s-0000dJ-DX; Fri, 11 Jul 2025 17:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL1m-0000Wd-S6; Fri, 11 Jul 2025 17:11:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL1k-0002qe-Da; Fri, 11 Jul 2025 17:11:30 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BGJtVk012960;
 Fri, 11 Jul 2025 21:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=15Qp48VAJSbYqXrc0
 iLqAqTXkPZaGC/vs4R7iqs1+hQ=; b=Po4nWFNtGhIRbYSTqK/dZ4MJSaNA8412d
 uVBQK46cZKaMQ89OA225oAkqPz12cLYF5dDQM10ND5rRdbiDbkcMJ6O1gefsqsB0
 6TmwaB2hHXZZNjkdIKkhpA49aGJHZO0r7NVqG7jx1obxrvCGulJ+Van0Vk1+teig
 mfCC2adfKZqFep+ZOStRNUyRVgruhz5Im6z7a4WWvBEZcsUkR92S07AY6LFVTNtM
 6fei0gKwyfwAuJTzlEWH0lY20m6JRErGH9/c5LSieEOSugkAUp5mNO5n5Mx1JcdN
 CiN159E4F59DhvhBwkzXOYU6tNP0yjWADHDUTo5ZE8EM0miDJBCyw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47t3xdk8wg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56BJaQon025528;
 Fri, 11 Jul 2025 21:11:24 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfcpmk4x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:24 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56BLBNhn33489610
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 21:11:23 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56DF258059;
 Fri, 11 Jul 2025 21:11:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8AA95805B;
 Fri, 11 Jul 2025 21:11:21 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.25.251])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Jul 2025 21:11:21 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 08/28] crypto/x509-utils: Add helper functions for DIAG 320
 subcode 2
Date: Fri, 11 Jul 2025 17:10:44 -0400
Message-ID: <20250711211105.439554-9-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711211105.439554-1-zycai@linux.ibm.com>
References: <20250711211105.439554-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Di2ZtziODWQYTBMjDavJdxTioqBVmyH1
X-Authority-Analysis: v=2.4 cv=MLRgmNZl c=1 sm=1 tr=0 ts=68717dfd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=94PFMrfvruhaK23DsHYA:9
X-Proofpoint-GUID: Di2ZtziODWQYTBMjDavJdxTioqBVmyH1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE1NiBTYWx0ZWRfX6q5X/dcgox6E
 JhNyewTH/L6DSIwafyQRIhSyQlIkRuJx8I8JlCuXO1g1DLKvw5Gn8i6rydsLD8PluFAwyg1t6wS
 PvmlJiyk/FqdFdF4CKvossu2zx2LFrheiEFgMFuY1dlFImO3krHq0fB/kxQpgABA2e1PIuYtH0z
 /9IukpxvvsUxqICeeeqkdQo5lepk6DpTMe0LIbw6gWtEDieLA0WOMdVQuAZlsAG+iArOxaMNlC4
 fzhmUDb6JHlTnhOLpn4Rjd5GIOaMgBNhTMWy4UBaC2A+5QRr2PAL1kgX6sosvWLfV/PQYud77IN
 cjgnMx6+9uUqCS0ILEBNmVD+Brio/g1NifbC9mQYi2qbOI6swGscAbVn1FUXhNq3rx2oOR0JWsD
 nxWaUEvP2nQRiAH6mxd3oQ7Do6DFhYy+sInEAjq8D3w/tIvonnhjgSkUDnBspFBWLFfqpM6X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_06,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110156
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Introduce new helper functions to extract certificate metadata needed for
DIAG 320 subcode 2:

qcrypto_x509_get_cert_version() - retrieves version of a certificate
qcrypto_x509_check_cert_times() - validates the certificate's validity period against the current time
qcrypto_x509_get_pk_algorithm() - returns the public key algorithm used in the certificate
qcrypto_x509_get_cert_key_id() - extracts the key ID from the certificate

These functions provide support for metadata extraction and validity checking
for X.509 certificates.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 crypto/x509-utils.c         | 199 ++++++++++++++++++++++++++++++++++++
 include/crypto/x509-utils.h |  76 +++++++++++++-
 2 files changed, 272 insertions(+), 3 deletions(-)

diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index d2cf790d5b..135f83f55e 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -55,6 +55,14 @@ static const int gnutls_to_qcrypto_sig_alg_map[] = {
     [GNUTLS_SIGN_ECDSA_SHA512] = QCRYPTO_SIG_ALGO_ECDSA_SHA512,
 };
 
+static const int gnutls_to_qcrypto_pk_alg_map[] = {
+    [GNUTLS_PK_UNKNOWN] = QCRYPTO_PK_ALGO_UNKNOWN,
+    [GNUTLS_PK_RSA] = QCRYPTO_PK_ALGO_RSA,
+    [GNUTLS_PK_DSA] = QCRYPTO_PK_ALGO_DSA,
+    [GNUTLS_PK_DH] = QCRYPTO_PK_ALGO_DH,
+    [GNUTLS_PK_ECDSA] = QCRYPTO_PK_ALGO_ECDSA,
+};
+
 int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
                                   uint8_t **result, size_t *resultlen,
                                   Error **errp)
@@ -195,6 +203,169 @@ cleanup:
     return ret;
 }
 
+int qcrypto_x509_get_cert_version(uint8_t *cert, size_t size, Error **errp)
+{
+    int rc;
+    int ret = -1;
+    gnutls_x509_crt_t crt;
+    gnutls_datum_t datum = {.data = cert, .size = size};
+
+    rc = gnutls_x509_crt_init(&crt);
+    if (rc < 0) {
+        error_setg(errp, "Failed to initialize certificate: %s", gnutls_strerror(rc));
+        return ret;
+    }
+
+    rc = gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM);
+    if (rc != 0) {
+        error_setg(errp, "Failed to import certificate: %s", gnutls_strerror(rc));
+        goto cleanup;
+    }
+
+    rc = gnutls_x509_crt_get_version(crt);
+    if (rc < 0) {
+        error_setg(errp, "Failed to get certificate version: %s", gnutls_strerror(rc));
+        goto cleanup;
+    }
+
+    ret = rc;
+
+cleanup:
+    gnutls_x509_crt_deinit(crt);
+    return ret;
+}
+
+int qcrypto_x509_check_cert_times(uint8_t *cert, size_t size, Error **errp)
+{
+    int rc;
+    int ret = -1;
+    gnutls_x509_crt_t crt;
+    gnutls_datum_t datum = {.data = cert, .size = size};
+    time_t now = time(0);
+    time_t exp_time;
+    time_t act_time;
+
+    if (now == ((time_t)-1)) {
+        error_setg_errno(errp, errno, "Cannot get current time");
+        return ret;
+    }
+
+    rc = gnutls_x509_crt_init(&crt);
+    if (rc < 0) {
+        error_setg(errp, "Failed to initialize certificate: %s", gnutls_strerror(rc));
+        return ret;
+    }
+
+    rc = gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM);
+    if (rc != 0) {
+        error_setg(errp, "Failed to import certificate: %s", gnutls_strerror(rc));
+        goto cleanup;
+    }
+
+    exp_time = gnutls_x509_crt_get_expiration_time(crt);
+    if (exp_time == ((time_t)-1)) {
+        error_setg(errp, "Failed to get certificate expiration time");
+        goto cleanup;
+    }
+    if (exp_time < now) {
+        error_setg(errp, "The certificate has expired");
+        goto cleanup;
+    }
+
+    act_time = gnutls_x509_crt_get_activation_time(crt);
+    if (act_time == ((time_t)-1)) {
+        error_setg(errp, "Failed to get certificate activation time");
+        goto cleanup;
+    }
+    if (act_time > now) {
+        error_setg(errp, "The certificate is not yet active");
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
+int qcrypto_x509_get_pk_algorithm(uint8_t *cert, size_t size, Error **errp)
+{
+    int rc;
+    int ret = -1;
+    unsigned int bits;
+    gnutls_x509_crt_t crt;
+    gnutls_datum_t datum = {.data = cert, .size = size};
+
+    rc = gnutls_x509_crt_init(&crt);
+    if (rc < 0) {
+        error_setg(errp, "Failed to initialize certificate: %s", gnutls_strerror(rc));
+        return ret;
+    }
+
+    rc = gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM);
+    if (rc != 0) {
+        error_setg(errp, "Failed to import certificate: %s", gnutls_strerror(rc));
+        goto cleanup;
+    }
+
+    rc = gnutls_x509_crt_get_pk_algorithm(crt, &bits);
+    if (rc >= G_N_ELEMENTS(gnutls_to_qcrypto_pk_alg_map)) {
+        error_setg(errp, "Unknown public key algorithm %d", rc);
+        goto cleanup;
+    }
+
+    ret = gnutls_to_qcrypto_pk_alg_map[rc];
+
+cleanup:
+    gnutls_x509_crt_deinit(crt);
+    return ret;
+}
+
+int qcrypto_x509_get_cert_key_id(uint8_t *cert, size_t size,
+                                 QCryptoKeyidFlags flag,
+                                 uint8_t **result,
+                                 size_t *resultlen,
+                                 Error **errp)
+{
+    int rc;
+    int ret = -1;
+    gnutls_x509_crt_t crt;
+    gnutls_datum_t datum = {.data = cert, .size = size};
+
+    *resultlen = qcrypto_x509_get_keyid_len(qcrypto_to_gnutls_keyid_flags_map[flag],
+                                            errp);
+    if (*resultlen == -1) {
+        return ret;
+    }
+
+    rc = gnutls_x509_crt_init(&crt);
+    if (rc < 0) {
+        error_setg(errp, "Failed to initialize certificate: %s", gnutls_strerror(rc));
+        return ret;
+    }
+
+    rc = gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM);
+    if (rc != 0) {
+        error_setg(errp, "Failed to import certificate: %s", gnutls_strerror(rc));
+        goto cleanup;
+    }
+
+    *result = g_malloc0(*resultlen);
+    if (gnutls_x509_crt_get_key_id(crt,
+                                   qcrypto_to_gnutls_keyid_flags_map[flag],
+                                   *result, resultlen) != 0) {
+        error_setg(errp, "Failed to get key ID from certificate");
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
 
 int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
@@ -228,4 +399,32 @@ int qcrypto_x509_get_signature_algorithm(uint8_t *cert, size_t size, Error **err
     return -1;
 }
 
+int qcrypto_x509_get_cert_version(uint8_t *cert, size_t size, Error **errp)
+{
+    error_setg(errp, "GNUTLS is required to get certificate version");
+    return -1;
+}
+
+int qcrypto_x509_check_cert_times(uint8_t *cert, size_t size, Error **errp)
+{
+    error_setg(errp, "GNUTLS is required to get certificate times");
+    return -1;
+}
+
+int qcrypto_x509_get_pk_algorithm(uint8_t *cert, size_t size, Error **errp)
+{
+    error_setg(errp, "GNUTLS is required to get public key algorithm");
+    return -1;
+}
+
+int qcrypto_x509_get_cert_key_id(uint8_t *cert, size_t size,
+                                 QCryptoKeyidFlags flag,
+                                 uint8_t **result,
+                                 size_t *resultlen,
+                                 Error **errp)
+{
+    error_setg(errp, "GNUTLS is required to get key ID");
+    return -1;
+}
+
 #endif /* ! CONFIG_GNUTLS */
diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
index d916d248bb..c122df0a98 100644
--- a/include/crypto/x509-utils.h
+++ b/include/crypto/x509-utils.h
@@ -40,6 +40,14 @@ typedef enum {
     QCRYPTO_SIG_ALGO_ECDSA_SHA512,
 } QCryptoSigAlgo;
 
+typedef enum {
+    QCRYPTO_PK_ALGO_UNKNOWN,
+    QCRYPTO_PK_ALGO_RSA,
+    QCRYPTO_PK_ALGO_DSA,
+    QCRYPTO_PK_ALGO_DH,
+    QCRYPTO_PK_ALGO_ECDSA,
+} QCryptoPkAlgo;
+
 int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
                                       QCryptoHashAlgo hash,
                                       uint8_t *result,
@@ -53,10 +61,10 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
  * @result: output location for the allocated buffer for the certificate in DER format
             (the function allocates memory which must be freed by the caller)
  * @resultlen: pointer to the size of the buffer
-               (will be replaced by the actual size of the DER-encoded certificate)
+               (will be updated with the actual size of the DER-encoded certificate)
  * @errp: error pointer
  *
- * Convert given @cert from PEM to DER format.
+ * Convert the given @cert from PEM to DER format.
  *
  * Returns: 0 on success,
  *         -1 on error.
@@ -70,7 +78,7 @@ int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
  * qcrypto_x509_get_keyid_len
  * @flag: the key ID flag
  *
- * Determine the length of the key ID of the given @flag.
+ * Determine the length of the key ID corresponding to the given @flag.
  *
  * Returns: the length on success,
  *          -1 on error.
@@ -90,4 +98,66 @@ int qcrypto_x509_get_keyid_len(QCryptoKeyidFlags flag, Error **errp);
  */
 int qcrypto_x509_get_signature_algorithm(uint8_t *cert, size_t size, Error **errp);
 
+/**
+ * qcrypto_x509_get_cert_version
+ * @cert: pointer to the raw certificate data
+ * @size: size of the certificate
+ * @errp: error pointer
+ *
+ * Determine the version of the @cert.
+ *
+ * Returns: the version on success,
+ *          -1 on error.
+ */
+int qcrypto_x509_get_cert_version(uint8_t *cert, size_t size, Error **errp);
+
+/**
+ * qcrypto_x509_check_cert_times
+ * @cert: pointer to the raw certificate data
+ * @size: size of the certificate
+ * @errp: error pointer
+ *
+ * Check whether the activation and expiration times of @cert
+ * are valid at the current time.
+ *
+ * Returns: 0 if the certificate times are valid,
+ *         -1 on error.
+ */
+int qcrypto_x509_check_cert_times(uint8_t *cert, size_t size, Error **errp);
+
+/**
+ * qcrypto_x509_get_pk_algorithm
+ * @cert: pointer to the raw certificate data
+ * @size: size of the certificate
+ * @errp: error pointer
+ *
+ * Determine the public key algorithm of the @cert.
+ *
+ * Returns: a value from the QCryptoPkAlgo enum on success,
+ *          -1 on error.
+ */
+int qcrypto_x509_get_pk_algorithm(uint8_t *cert, size_t size, Error **errp);
+
+/**
+ * qcrypto_x509_get_cert_key_id
+ * @cert: pointer to the raw certificate data
+ * @size: size of the certificate
+ * @flag: the key ID flag
+ * @result: output location for the allocated buffer for key ID
+            (the function allocates memory which must be freed by the caller)
+ * @resultlen: pointer to the size of the buffer
+               (will be updated with the actual size of key id)
+ * @errp: error pointer
+ *
+ * Retrieve the key ID from the @cert based on the specified @flag.
+ *
+ * Returns: 0 if key ID was successfully stored in @result,
+ *         -1 on error.
+ */
+int qcrypto_x509_get_cert_key_id(uint8_t *cert, size_t size,
+                                 QCryptoKeyidFlags flag,
+                                 uint8_t **result,
+                                 size_t *resultlen,
+                                 Error **errp);
+
 #endif
-- 
2.49.0


