Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089D0C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 22:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMw7A-0002if-RP; Wed, 04 Jun 2025 17:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw76-0002fE-E9; Wed, 04 Jun 2025 17:57:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw70-0006y7-IS; Wed, 04 Jun 2025 17:57:36 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554IMdnN032741;
 Wed, 4 Jun 2025 21:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=07+5TldIYSJe/JtMh
 F3aWPzb/ySHMdCGRpVbNWz38/s=; b=siYF62ANxvTYGYXH75eGROx59DYVDC6I8
 V1MIyPlaIK8KABxbiDbWNrCk8kokxDnFtooqWd1pI4j96R6lRSI5XdYogLXGHscv
 Fn/fJucjGInW7wBKRf3kqd2EX8P+UAJsxWv0JKp60rxpMC1RhSBWtsaCjmDFXB9h
 VMmiekAKvIGGfZlWSF3/XugWE3ZBFxClkgRtJZHCiXonsYlTzMUzm3fCGYtX5fmF
 yRQ4VCTPDeLwPnfMdxipCq/dZRNcSMHJ2ML3IPVvyOm+5zW4od+ZPyPtu1ZEvxXL
 Xx10ux09SdudwfDmzdWSo1rk+LO14EZLIo+I42hnJ25BU0JGkD0ig==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyw6jm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 554JMDGV028437;
 Wed, 4 Jun 2025 21:57:26 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 470eakhmpy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:26 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 554LvK9U3146396
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jun 2025 21:57:20 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D15C358050;
 Wed,  4 Jun 2025 21:57:24 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D84C158045;
 Wed,  4 Jun 2025 21:57:22 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.211])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jun 2025 21:57:22 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v3 08/28] crypto/x509-utils: Add helper functions for DIAG 320
 subcode 2
Date: Wed,  4 Jun 2025 17:56:36 -0400
Message-ID: <20250604215657.528142-9-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604215657.528142-1-zycai@linux.ibm.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fMOmhH-GANzAazw9WNjV7KtYKc3nDa8x
X-Proofpoint-ORIG-GUID: fMOmhH-GANzAazw9WNjV7KtYKc3nDa8x
X-Authority-Analysis: v=2.4 cv=X4dSKHTe c=1 sm=1 tr=0 ts=6840c147 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=m1npDw3cYSwZ3_DRQmoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE3NSBTYWx0ZWRfX6608QgTuY+LT
 RhmKvrLKHf/cBN1ECn3lDMMnH1zWjgkrfg0speT1K2VwpcVJPst4yQ8ATY5V1nrGdTZfmqsjEMB
 0tkd2Vji/yDcZgEsOol93uQHpLrzGINP06aqkGfdhDRjjcESgb00vyTfVrVvAcpU+5PqTbz6vFe
 BHBdqckHq3oKbjoGPZAl3Om0NfIhn2J/SzKKk43vxtUKVNXns1OpwFQ8Kbo+vt1SuVd1rmS4or4
 km0LpWrxeJ6ZpbyGYzNv50GSn5+7h2i9r9trUHtb4z4YFbVWChZ2KzEzEz6bCm1S9BTBBEnU8Nn
 CeaTraHQJf1sxdBEEtjI2m03e8Gy+WIR5/Fd6ABYAgsnFiLs+iJTFIrTDNB61wY8kjBLlOpsXwc
 xeJSoZDy3EQkVitCj8ixdBiM1apNUtt9YK4JMnu7SGd0BgwyqbBnuCssWco3aqmKk/6BCAxm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 clxscore=1011 phishscore=0 bulkscore=0
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

Add helper functions for x509 certificate which will be used in the next
patch for DIAG 320 subcode 2.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 crypto/x509-utils.c         | 190 +++++++++++++++++++++++++++++++++++-
 include/crypto/x509-utils.h |  63 ++++++++++++
 qapi/crypto.json            |  20 ++++
 3 files changed, 272 insertions(+), 1 deletion(-)

diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index 7a7f12c111..dd8137210c 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -60,6 +60,14 @@ static const int gnutls_to_qcrypto_sig_alg_map[QCRYPTO_SIG_ALGO__MAX] = {
     [GNUTLS_SIGN_ECDSA_SHA512] = QCRYPTO_SIG_ALGO_ECDSA_SHA512,
 };
 
+static const int gnutls_to_qcrypto_pk_alg_map[QCRYPTO_PK_ALGO__MAX] = {
+    [GNUTLS_PK_UNKNOWN] = QCRYPTO_PK_ALGO_UNKNOWN,
+    [GNUTLS_PK_RSA] = QCRYPTO_PK_ALGO_RSA,
+    [GNUTLS_PK_DSA] = QCRYPTO_PK_ALGO_DSA,
+    [GNUTLS_PK_DH] = QCRYPTO_PK_ALGO_DH,
+    [GNUTLS_PK_ECDSA] = QCRYPTO_PK_ALGO_ECDSA,
+};
+
 int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
                                 QCryptoCertFmt fmt, Error **errp)
 {
@@ -153,7 +161,7 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
 
     gnutls_x509_crt_init(&crt);
 
-    if (gnutls_x509_crt_import(crt, &datum, GNUTLS_X509_FMT_PEM) != 0) {
+    if (qcrypto_import_x509_cert(crt, &datum) != 0) {
         error_setg(errp, "Failed to import certificate");
         goto cleanup;
     }
@@ -204,6 +212,158 @@ cleanup:
     return rc;
 }
 
+int qcrypto_get_x509_cert_version(uint8_t *cert, size_t size, Error **errp)
+{
+    int rc = -1;
+    gnutls_x509_crt_t crt;
+    gnutls_datum_t datum = {.data = cert, .size = size};
+
+    if (gnutls_x509_crt_init(&crt) < 0) {
+        error_setg(errp, "Failed to initialize certificate");
+        return rc;
+    }
+
+    if (qcrypto_import_x509_cert(crt, &datum) != 0) {
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
+    time_t exp_time;
+    time_t act_time;
+
+    if (now == ((time_t)-1)) {
+        error_setg_errno(errp, errno, "Cannot get current time");
+        return rc;
+    }
+
+    if (gnutls_x509_crt_init(&crt) < 0) {
+        error_setg(errp, "Failed to initialize certificate");
+        return rc;
+    }
+
+    if (qcrypto_import_x509_cert(crt, &datum) != 0) {
+        error_setg(errp, "Failed to import certificate");
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
+
+    if (gnutls_x509_crt_init(&crt) < 0) {
+        error_setg(errp, "Failed to initialize certificate");
+        return rc;
+    }
+
+    if (qcrypto_import_x509_cert(crt, &datum) != 0) {
+        error_setg(errp, "Failed to import certificate");
+        goto cleanup;
+    }
+
+    rc = gnutls_x509_crt_get_pk_algorithm(crt, &bits);
+    rc = gnutls_to_qcrypto_pk_alg_map[rc];
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
+    if (gnutls_x509_crt_init(&crt)) {
+        error_setg(errp, "Failed to initialize certificate");
+        return -1;
+    }
+
+    if (qcrypto_import_x509_cert(crt, &datum) != 0) {
+        error_setg(errp, "Failed to import certificate");
+        goto cleanup;
+    }
+
+    keyid_len = qcrypto_get_x509_keyid_len(qcrypto_to_gnutls_keyid_flags_map[flag]);
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
@@ -239,4 +399,32 @@ int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **err
     return -ENOTSUP;
 }
 
+int qcrypto_get_x509_cert_version(uint8_t *cert, size_t size, Error **errp)
+{
+    error_setg(errp, "GNUTLS is required to get certificate version");
+    return -ENOTSUP;
+}
+
+int qcrypto_check_x509_cert_times(uint8_t *cert, size_t size, Error **errp)
+{
+    error_setg(errp, "GNUTLS is required to get certificate times")
+    return -ENOTSUP;
+}
+
+int qcrypto_get_x509_pk_algorithm(uint8_t *cert, size_t size, Error **errp)
+{
+    error_setg(errp, "GNUTLS is required to get public key algorithm");
+    return -ENOTSUP;
+}
+
+int qcrypto_get_x509_cert_key_id(uint8_t *cert, size_t size,
+                                 QCryptoKeyidFlags flag,
+                                 uint8_t *result,
+                                 size_t *resultlen,
+                                 Error **errp)
+{
+    error_setg(errp, "GNUTLS is required to get key ID");
+    return -ENOTSUP;
+}
+
 #endif /* ! CONFIG_GNUTLS */
diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
index d7be57c8ce..4a9941b33d 100644
--- a/include/crypto/x509-utils.h
+++ b/include/crypto/x509-utils.h
@@ -73,4 +73,67 @@ int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag);
  */
 int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **errp);
 
+/**
+ * qcrypto_get_x509_cert_version
+ * @cert: pointer to the raw certiricate data
+ * @size: size of the certificate
+ * @errp: error pointer
+ *
+ * Determine the version of the @cert.
+ *
+ * Returns: version of certificate on success,
+ *          negative error code on error,
+ *          -ENOTSUP if GNUTLS is not enabled.
+ */
+int qcrypto_get_x509_cert_version(uint8_t *cert, size_t size, Error **errp);
+
+/**
+ * qcrypto_check_x509_cert_times
+ * @cert: pointer to the raw certiricate data
+ * @size: size of the certificate
+ * @errp: error pointer
+ *
+ * Check whether the @cert activation and expiration times are valid at the current time.
+ *
+ * Returns: 0 if the certificate times are valid,
+ *         -1 on error,
+ *         -ENOTSUP if GNUTLS is not enabled.
+ */
+int qcrypto_check_x509_cert_times(uint8_t *cert, size_t size, Error **errp);
+
+/**
+ * qcrypto_get_x509_pk_algorithm
+ * @cert: pointer to the raw certiricate data
+ * @size: size of the certificate
+ * @errp: error pointer
+ *
+ * Determine the public key algorithm of the @cert.
+ *
+ * Returns: a value from the QCryptoPkAlgo enum on success,
+ *          -1 on error,
+ *          -ENOTSUP if GNUTLS is not enabled.
+ */
+int qcrypto_get_x509_pk_algorithm(uint8_t *cert, size_t size, Error **errp);
+
+/**
+ * qcrypto_get_x509_cert_key_id
+ * @cert: pointer to the raw certiricate data
+ * @size: size of the certificate
+ * @flag: the key ID flag
+ * @result: pointer to a buffer to store output key ID (may not be null)
+ * @resultlen: pointer to the size of the buffer
+ * @errp: error pointer
+ *
+ * Retrieve the key ID from the @cert based on the specified @flag.
+ *
+ * Returns: 0 if key ID was successfully stored in @result,
+ *         -1 on error,
+ *         -ENOTSUP if GNUTLS is not enabled.
+ */
+int qcrypto_get_x509_cert_key_id(uint8_t *cert, size_t size,
+                                 QCryptoKeyidFlags flag,
+                                 uint8_t *result,
+                                 size_t *resultlen,
+                                 Error **errp);
+
 #endif
diff --git a/qapi/crypto.json b/qapi/crypto.json
index af487dcecd..0262ccee34 100644
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
+# Since: 10.1
+##
+{ 'enum': 'QCryptoPkAlgo',
+  'data': ['unknown', 'rsa', 'dsa', 'dh', 'ecdsa']}
-- 
2.49.0


