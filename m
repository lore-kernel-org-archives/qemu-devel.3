Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6502BC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 21:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaL1q-0000aZ-6x; Fri, 11 Jul 2025 17:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL1d-0000Pe-5h; Fri, 11 Jul 2025 17:11:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL1a-0002ld-9h; Fri, 11 Jul 2025 17:11:20 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BL9isN029472;
 Fri, 11 Jul 2025 21:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=xENZSkc9sR5aRZR7Q
 f4Si40UpLYs/z/QpgB/cZDLE0M=; b=bGoMcvibOXMNP52un+sM9HVUIdUNYNLdT
 175sqY462H8WktgUUYRKZzjc3LeRXUOoDo1neuLG/pjCOTnlo+L5bo6/QqcUEr3t
 olB2IlmdbO81U4Wf52ome4XV3cTDs6KELWWbpbWNbj97XwTBiJ0rH4xA5TQd3OBP
 3BfMRQglXkE3cEP77qqHxVYceXg+rzgYNjb0/kPfdWbtMBUcctcQu99n89WzQHCF
 2SB4TwJXEis8+faopRloCxhzIv0v9/obZumvS+m6c0zpXJYLai09CU+D9WR/KZV3
 1jBN6A206Ud6vHtS8Ha3MZbN+j6HxUlaJ2p1kDxAMsRxhGmFe4PhA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptjrm30h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56BIxoWF010826;
 Fri, 11 Jul 2025 21:11:14 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qes0mr56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:14 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56BLBDtF21299936
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 21:11:13 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06FF25805D;
 Fri, 11 Jul 2025 21:11:13 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8267C5805C;
 Fri, 11 Jul 2025 21:11:11 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.25.251])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Jul 2025 21:11:11 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 02/28] crypto/x509-utils: Add helper functions for
 certificate store
Date: Fri, 11 Jul 2025 17:10:38 -0400
Message-ID: <20250711211105.439554-3-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711211105.439554-1-zycai@linux.ibm.com>
References: <20250711211105.439554-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=GL8IEvNK c=1 sm=1 tr=0 ts=68717df3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=R4umFo0n0uxdEK4-sBMA:9
X-Proofpoint-ORIG-GUID: PWpe8d_F5DhNFgB4Hff8CzYql51oobYT
X-Proofpoint-GUID: PWpe8d_F5DhNFgB4Hff8CzYql51oobYT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE1MiBTYWx0ZWRfX8DW+MZsYTzHA
 3nRu3tDEHm36LL38iIdAqdYm82jA+BFKqvab895Za6OQL5V0/og0x2mZZlEEaU1MQcTvhD/Bf4i
 LFyjAKP7ZZ75j1NHswLcBiNiVfVDMXvFogcp1F1imW95Oq+sXLQO4+ma7IyEhrlA3cjVWXDSgOS
 0fdI/SYlRJdwk8iUHMrTJtxMJZkumkJlsLgKq51XDvmZoGVoNmW9hkSs/MkeTwSHOgkefUo5d+4
 52HEZKsyzcs31W9LgBiq/8WH8U2Fxtqqb/NnqAPgyPfBa9EOIADuVQKaqbNYZmYX0Tl1cehS9Up
 Izp/2HnnPb7pL5lqmb6/WsKD+UB1YVn9ngX0n9O9/daGgkHLrKQHboL1P1gxpsZ4utmSeQASoh2
 MnzATRDc1JDa+d5FQj3F1PswXRJfIsSU9jrmVfhWMNFDZEPjH3tlIUo2X5yA7rizAqA/HYXp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_06,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110152
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

Introduce new helper functions for x509 certificate, which will be used
by the certificate store:

qcrypto_x509_convert_cert_der() - converts a certificate from PEM to DER format
qcrypto_x509_get_keyid_len() - returns the length of the key ID
qcrypto_x509_get_signature_algorithm() - returns signature algorithm of the certificate

These functions provide support for certificate format conversion and
metadata extraction.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 crypto/meson.build          |   5 +-
 crypto/x509-utils.c         | 155 ++++++++++++++++++++++++++++++++++++
 include/crypto/x509-utils.h |  71 +++++++++++++++++
 3 files changed, 227 insertions(+), 4 deletions(-)

diff --git a/crypto/meson.build b/crypto/meson.build
index 735635de1f..0614bfa914 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -22,12 +22,9 @@ crypto_ss.add(files(
   'tlscredsx509.c',
   'tlssession.c',
   'rsakey.c',
+  'x509-utils.c',
 ))
 
-if gnutls.found()
-  crypto_ss.add(files('x509-utils.c'))
-endif
-
 if nettle.found()
   crypto_ss.add(nettle, files('hash-nettle.c', 'hmac-nettle.c', 'pbkdf-nettle.c'))
   if hogweed.found()
diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index 8bad00a51b..d2cf790d5b 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -11,6 +11,8 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "crypto/x509-utils.h"
+
+#ifdef CONFIG_GNUTLS
 #include <gnutls/gnutls.h>
 #include <gnutls/crypto.h>
 #include <gnutls/x509.h>
@@ -25,6 +27,87 @@ static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
     [QCRYPTO_HASH_ALGO_RIPEMD160] = GNUTLS_DIG_RMD160,
 };
 
+static const int qcrypto_to_gnutls_keyid_flags_map[] = {
+    [QCRYPTO_KEYID_FLAGS_SHA1] = GNUTLS_KEYID_USE_SHA1,
+    [QCRYPTO_KEYID_FLAGS_SHA256] = GNUTLS_KEYID_USE_SHA256,
+    [QCRYPTO_KEYID_FLAGS_SHA512] = GNUTLS_KEYID_USE_SHA512,
+    [QCRYPTO_KEYID_FLAGS_BEST_KNOWN] = GNUTLS_KEYID_USE_BEST_KNOWN,
+};
+
+static const int gnutls_to_qcrypto_sig_alg_map[] = {
+    [GNUTLS_SIGN_UNKNOWN] = QCRYPTO_SIG_ALGO_UNKNOWN,
+    [GNUTLS_SIGN_RSA_SHA1] = QCRYPTO_SIG_ALGO_RSA_SHA1,
+    [GNUTLS_SIGN_RSA_SHA] = QCRYPTO_SIG_ALGO_RSA_SHA1,
+    [GNUTLS_SIGN_DSA_SHA1] = QCRYPTO_SIG_ALGO_DSA_SHA1,
+    [GNUTLS_SIGN_RSA_MD5] = QCRYPTO_SIG_ALGO_RSA_MD5,
+    [GNUTLS_SIGN_RSA_MD2] = QCRYPTO_SIG_ALGO_RSA_MD2,
+    [GNUTLS_SIGN_RSA_RMD160] = QCRYPTO_SIG_ALGO_RSA_RMD160,
+    [GNUTLS_SIGN_RSA_SHA256] = QCRYPTO_SIG_ALGO_RSA_SHA256,
+    [GNUTLS_SIGN_RSA_SHA384] = QCRYPTO_SIG_ALGO_RSA_SHA384,
+    [GNUTLS_SIGN_RSA_SHA512] = QCRYPTO_SIG_ALGO_RSA_SHA512,
+    [GNUTLS_SIGN_RSA_SHA224] = QCRYPTO_SIG_ALGO_RSA_SHA224,
+    [GNUTLS_SIGN_DSA_SHA224] = QCRYPTO_SIG_ALGO_DSA_SHA224,
+    [GNUTLS_SIGN_DSA_SHA256] = QCRYPTO_SIG_ALGO_DSA_SHA256,
+    [GNUTLS_SIGN_ECDSA_SHA1] = QCRYPTO_SIG_ALGO_ECDSA_SHA1,
+    [GNUTLS_SIGN_ECDSA_SHA224] = QCRYPTO_SIG_ALGO_ECDSA_SHA224,
+    [GNUTLS_SIGN_ECDSA_SHA256] = QCRYPTO_SIG_ALGO_ECDSA_SHA256,
+    [GNUTLS_SIGN_ECDSA_SHA384] = QCRYPTO_SIG_ALGO_ECDSA_SHA384,
+    [GNUTLS_SIGN_ECDSA_SHA512] = QCRYPTO_SIG_ALGO_ECDSA_SHA512,
+};
+
+int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
+                                  uint8_t **result, size_t *resultlen,
+                                  Error **errp)
+{
+    int ret = -1;
+    int rc;
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
+    *result = g_malloc0(*resultlen);
+    rc = gnutls_x509_crt_export(crt, GNUTLS_X509_FMT_DER, *result, resultlen);
+    if (rc != 0) {
+        error_setg(errp, "Failed to convert certificate to DER format: %s",
+                   gnutls_strerror(rc));
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
+int qcrypto_x509_get_keyid_len(QCryptoKeyidFlags flag, Error **errp)
+{
+    if (flag >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map)) {
+        error_setg(errp, "Unknow key ID flag %d", flag);
+        return -1;
+    }
+
+    if ((flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_SHA512]) ||
+        (flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_BEST_KNOWN])) {
+        return QCRYPTO_HASH_DIGEST_LEN_SHA512;
+    } else if (flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_SHA256]) {
+        return QCRYPTO_HASH_DIGEST_LEN_SHA256;
+    } else {
+        return QCRYPTO_HASH_DIGEST_LEN_SHA1;
+    }
+}
+
 int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
                                       QCryptoHashAlgo alg,
                                       uint8_t *result,
@@ -74,3 +157,75 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
     gnutls_x509_crt_deinit(crt);
     return ret;
 }
+
+int qcrypto_x509_get_signature_algorithm(uint8_t *cert, size_t size, Error **errp)
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
+    /*
+     * This function never returns a negative error code.
+     * Error cases and unknown/unsupported signature algorithms
+     * are mapped to GNUTLS_SIGN_UNKNOWN.
+     */
+    rc = gnutls_x509_crt_get_signature_algorithm(crt);
+    if (rc >= G_N_ELEMENTS(gnutls_to_qcrypto_sig_alg_map)) {
+        error_setg(errp, "Unknown signature algorithm %d", rc);
+        goto cleanup;
+    }
+
+    ret = gnutls_to_qcrypto_sig_alg_map[rc];
+
+cleanup:
+    gnutls_x509_crt_deinit(crt);
+    return ret;
+}
+
+#else /* ! CONFIG_GNUTLS */
+
+int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
+                                  uint8_t **result,
+                                  size_t *resultlen,
+                                  Error **errp)
+{
+    error_setg(errp, "GNUTLS is required to export X.509 certificate");
+    return -1;
+}
+
+int qcrypto_x509_get_keyid_len(QCryptoKeyidFlags flag, Error **errp)
+{
+    error_setg(errp, "GNUTLS is required to get key ID length");
+    return -1;
+}
+
+int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
+                                      QCryptoHashAlgo hash,
+                                      uint8_t *result,
+                                      size_t *resultlen,
+                                      Error **errp)
+{
+    error_setg(errp, "GNUTLS is required to get fingerprint");
+    return -1;
+}
+
+int qcrypto_x509_get_signature_algorithm(uint8_t *cert, size_t size, Error **errp)
+{
+    error_setg(errp, "GNUTLS is required to get signature algorithm");
+    return -1;
+}
+
+#endif /* ! CONFIG_GNUTLS */
diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
index 1e99661a71..d916d248bb 100644
--- a/include/crypto/x509-utils.h
+++ b/include/crypto/x509-utils.h
@@ -13,10 +13,81 @@
 
 #include "crypto/hash.h"
 
+typedef enum {
+    QCRYPTO_KEYID_FLAGS_SHA1,
+    QCRYPTO_KEYID_FLAGS_SHA256,
+    QCRYPTO_KEYID_FLAGS_SHA512,
+    QCRYPTO_KEYID_FLAGS_BEST_KNOWN,
+} QCryptoKeyidFlags;
+
+typedef enum {
+    QCRYPTO_SIG_ALGO_UNKNOWN,
+    QCRYPTO_SIG_ALGO_RSA_SHA1,
+    QCRYPTO_SIG_ALGO_DSA_SHA1,
+    QCRYPTO_SIG_ALGO_RSA_MD5,
+    QCRYPTO_SIG_ALGO_RSA_MD2,
+    QCRYPTO_SIG_ALGO_RSA_RMD160,
+    QCRYPTO_SIG_ALGO_RSA_SHA256,
+    QCRYPTO_SIG_ALGO_RSA_SHA384,
+    QCRYPTO_SIG_ALGO_RSA_SHA512,
+    QCRYPTO_SIG_ALGO_RSA_SHA224,
+    QCRYPTO_SIG_ALGO_DSA_SHA224,
+    QCRYPTO_SIG_ALGO_DSA_SHA256,
+    QCRYPTO_SIG_ALGO_ECDSA_SHA1,
+    QCRYPTO_SIG_ALGO_ECDSA_SHA224,
+    QCRYPTO_SIG_ALGO_ECDSA_SHA256,
+    QCRYPTO_SIG_ALGO_ECDSA_SHA384,
+    QCRYPTO_SIG_ALGO_ECDSA_SHA512,
+} QCryptoSigAlgo;
+
 int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
                                       QCryptoHashAlgo hash,
                                       uint8_t *result,
                                       size_t *resultlen,
                                       Error **errp);
 
+/**
+ * qcrypto_x509_convert_cert_der
+ * @cert: pointer to the raw certificate data in PEM format
+ * @size: size of the certificate
+ * @result: output location for the allocated buffer for the certificate in DER format
+            (the function allocates memory which must be freed by the caller)
+ * @resultlen: pointer to the size of the buffer
+               (will be replaced by the actual size of the DER-encoded certificate)
+ * @errp: error pointer
+ *
+ * Convert given @cert from PEM to DER format.
+ *
+ * Returns: 0 on success,
+ *         -1 on error.
+ */
+int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
+                                  uint8_t **result,
+                                  size_t *resultlen,
+                                  Error **errp);
+
+/**
+ * qcrypto_x509_get_keyid_len
+ * @flag: the key ID flag
+ *
+ * Determine the length of the key ID of the given @flag.
+ *
+ * Returns: the length on success,
+ *          -1 on error.
+ */
+int qcrypto_x509_get_keyid_len(QCryptoKeyidFlags flag, Error **errp);
+
+/**
+ * qcrypto_x509_get_signature_algorithm
+ * @cert: pointer to the raw certificate data
+ * @size: size of the certificate
+ * @errp: error pointer
+ *
+ * Determine the signature algorithm used to sign the @cert.
+ *
+ * Returns: a value from the QCryptoSigAlgo enum on success,
+ *          -1 on error.
+ */
+int qcrypto_x509_get_signature_algorithm(uint8_t *cert, size_t size, Error **errp);
+
 #endif
-- 
2.49.0


