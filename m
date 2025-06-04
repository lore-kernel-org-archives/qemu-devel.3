Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D91C61CE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 21:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMw6v-0002cY-7v; Wed, 04 Jun 2025 17:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw6q-0002b1-NK; Wed, 04 Jun 2025 17:57:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw6o-0006vv-5G; Wed, 04 Jun 2025 17:57:20 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554LFg26027896;
 Wed, 4 Jun 2025 21:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=HMt1/XtjGQpWHbM72
 dfm5MI4PIBTniNtt9e+0EV0ll0=; b=As2lCjDknR6ORtL2QqyJooitEdzGA5qCW
 YFspx4zzxmCL8ebxjlm2lwfqfxOCHadlRTSHOfW9Kv3Fz5hHl1W7bOVkIpKQOkPa
 8dyD5+lPrmlJalHK1Ir6s8CkyMpOt8wKQBn164GbW5MASoLH8JQdtC9PviyjP4RP
 G5VbMj+fKEDz5YzvAPlERFSI4UbUwBEFXKxKyjRXZUDkts0zPBypSLNRaTkei4Hl
 THoHoXHFJW2MfzccaZicTM+LUgxJRbTrVmhVPrAbB0dgMpYLHzv+xZ2Z2tSIYGNS
 n5HOChXjvnHSpWGtBP32eKPTyiaWbfwJk2sqX78soRAcpmxsVpkRg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyddp2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 554JTWTi024914;
 Wed, 4 Jun 2025 21:57:14 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470dkmhs4u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:14 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 554LvCZX41419408
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jun 2025 21:57:12 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE99958050;
 Wed,  4 Jun 2025 21:57:12 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF32358045;
 Wed,  4 Jun 2025 21:57:10 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.211])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jun 2025 21:57:10 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v3 02/28] crypto/x509-utils: Add helper functions for
 certificate store
Date: Wed,  4 Jun 2025 17:56:30 -0400
Message-ID: <20250604215657.528142-3-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604215657.528142-1-zycai@linux.ibm.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=6840c13b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=9G5Loy1b0T46bdGjvBMA:9
X-Proofpoint-GUID: UUmZrBF5H_hm_hU366W3xcrGLTiRZtQJ
X-Proofpoint-ORIG-GUID: UUmZrBF5H_hm_hU366W3xcrGLTiRZtQJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE3NSBTYWx0ZWRfX6b5zOWo/0OVz
 GkuPDPLEpBXYfaoA2O0uWQL/5A2gI0ICCTAy60ECIhr7AziN8SPHe8H/MkWSvKZ3ywgdIF62F0/
 u5m+pLYeSb49bpAGYIHYTv5Vvet183ZPPHnf0yVaeLaVUrz9mKtkF+Lu5W5XzCnYFkLYSwK8R9I
 G6HGejgDyba3WFPQEg7KZ7ITTGktpIwNeBq79N5Fz6Oyyfkm5n4n9fPZsfAIyP3kff2vKLz6xL1
 OM7mI8gbtgClxho3juSyB0YEYaEgXRntQL7RsJL7GmcThgQuT67HcQC8t0hdJtzeVfJfM7zjiu5
 wfni45viwsrvcPp8xw1eFcm1kkO8FWeWR5Q/vCZuBEBD98sfiZNQ28lb7KIbqiXsf9DryMGMkrg
 vvXOV0AXQuihTtPIYB9TA26sWAsEtaKvQa+xHVVqVRytv9hT4z6o29Gx7YubuWb4O4Gzusxo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=962 bulkscore=0
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

Add helper functions for x509 certificate which will be used in the next
patch for the certificate store.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 crypto/meson.build          |   5 +-
 crypto/x509-utils.c         | 166 ++++++++++++++++++++++++++++++++++++
 include/crypto/x509-utils.h |  54 ++++++++++++
 qapi/crypto.json            |  80 +++++++++++++++++
 4 files changed, 301 insertions(+), 4 deletions(-)

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
index 8bad00a51b..7a7f12c111 100644
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
@@ -25,6 +27,109 @@ static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
     [QCRYPTO_HASH_ALGO_RIPEMD160] = GNUTLS_DIG_RMD160,
 };
 
+static const int qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS__MAX] = {
+    [QCRYPTO_KEYID_FLAGS_SHA1] = GNUTLS_KEYID_USE_SHA1,
+    [QCRYPTO_KEYID_FLAGS_SHA256] = GNUTLS_KEYID_USE_SHA256,
+    [QCRYPTO_KEYID_FLAGS_SHA512] = GNUTLS_KEYID_USE_SHA512,
+    [QCRYPTO_KEYID_FLAGS_BEST_KNOWN] = GNUTLS_KEYID_USE_BEST_KNOWN,
+};
+
+static const int qcrypto_to_gnutls_cert_fmt_map[QCRYPTO_CERT_FMT__MAX] = {
+    [QCRYPTO_CERT_FMT_DER] = GNUTLS_X509_FMT_DER,
+    [QCRYPTO_CERT_FMT_PEM] = GNUTLS_X509_FMT_PEM,
+};
+
+static const int gnutls_to_qcrypto_sig_alg_map[QCRYPTO_SIG_ALGO__MAX] = {
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
+int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
+                                QCryptoCertFmt fmt, Error **errp)
+{
+    int rc;
+    int ret = -1;
+    gnutls_x509_crt_t crt;
+    gnutls_datum_t datum = {.data = cert, .size = size};
+
+    if (fmt >= G_N_ELEMENTS(qcrypto_to_gnutls_cert_fmt_map)) {
+        error_setg(errp, "Unknown certificate format");
+        return ret;
+    }
+
+    if (gnutls_x509_crt_init(&crt) < 0) {
+        error_setg(errp, "Failed to initialize certificate");
+        return ret;
+    }
+
+    rc = gnutls_x509_crt_import(crt, &datum, qcrypto_to_gnutls_cert_fmt_map[fmt]);
+    if (rc == GNUTLS_E_ASN1_TAG_ERROR) {
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
+int qcrypto_get_x509_hash_len(QCryptoHashAlgo alg)
+{
+    if (alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
+        return 0;
+    }
+
+    return gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[alg]);
+}
+
+int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag)
+{
+    QCryptoHashAlgo alg;
+
+    if (flag >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map)) {
+        return 0;
+    }
+
+    alg = QCRYPTO_HASH_ALGO_SHA1;
+    if ((flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_SHA512]) ||
+        (flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_BEST_KNOWN])) {
+        alg = QCRYPTO_HASH_ALGO_SHA512;
+    } else if (flag & qcrypto_to_gnutls_keyid_flags_map[QCRYPTO_KEYID_FLAGS_SHA256]) {
+        alg = QCRYPTO_HASH_ALGO_SHA256;
+    }
+
+    return qcrypto_get_x509_hash_len(alg);
+}
+
+static int qcrypto_import_x509_cert(gnutls_x509_crt_t crt, gnutls_datum_t *datum)
+{
+    int rc;
+
+    rc = gnutls_x509_crt_import(crt, datum, GNUTLS_X509_FMT_PEM);
+    if (rc) {
+        rc = gnutls_x509_crt_import(crt, datum, GNUTLS_X509_FMT_DER);
+    }
+
+    return rc;
+}
+
 int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
                                       QCryptoHashAlgo alg,
                                       uint8_t *result,
@@ -74,3 +179,64 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
     gnutls_x509_crt_deinit(crt);
     return ret;
 }
+
+int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **errp)
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
+    rc = gnutls_x509_crt_get_signature_algorithm(crt);
+    rc = gnutls_to_qcrypto_sig_alg_map[rc];
+
+cleanup:
+    gnutls_x509_crt_deinit(crt);
+    return rc;
+}
+
+#else /* ! CONFIG_GNUTLS */
+
+int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
+                                QCryptoCertFmt fmt, Error **errp)
+{
+    error_setg(errp, "GNUTLS is required to get certificate format");
+    return -ENOTSUP;
+}
+
+int qcrypto_get_x509_hash_len(QCryptoHashAlgo alg)
+{
+    return -ENOTSUP;
+}
+
+int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag)
+{
+    return -ENOTSUP;
+}
+
+int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
+                                      QCryptoHashAlgo hash,
+                                      uint8_t *result,
+                                      size_t *resultlen,
+                                      Error **errp)
+{
+    error_setg(errp, "GNUTLS is required to get fingerprint");
+    return -ENOTSUP;
+}
+
+int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **errp)
+{
+    error_setg(errp, "GNUTLS is required to get signature algorithm");
+    return -ENOTSUP;
+}
+
+#endif /* ! CONFIG_GNUTLS */
diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
index 1e99661a71..d7be57c8ce 100644
--- a/include/crypto/x509-utils.h
+++ b/include/crypto/x509-utils.h
@@ -19,4 +19,58 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
                                       size_t *resultlen,
                                       Error **errp);
 
+/**
+ * qcrypto_check_x509_cert_fmt
+ * @cert: pointer to the raw certiricate data
+ * @size: size of the certificate
+ * @fmt: expected certificate format
+ * @errp: error pointer
+ *
+ * Check whether the format of @cert matches @fmt.
+ *
+ * Returns: 0 if the format of @cert matches @fmt,
+           -1 if the format does not match,
+ *         -ENOTSUP if GNUTLS is not enabled.
+ */
+int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
+                                QCryptoCertFmt fmt, Error **errp);
+
+/**
+ * qcrypto_get_x509_hash_len
+ * @alg: the hash algorithm
+ *
+ * Determine the length of the hash of the given @alg.
+ *
+ * Returns: the length on success,
+            0 on error,
+            -ENOTSUP if GNUTLS is not enabled.
+ */
+int qcrypto_get_x509_hash_len(QCryptoHashAlgo alg);
+
+/**
+ * qcrypto_get_x509_keyid_len
+ * @flag: the key ID flag
+ *
+ * Determine the length of the key ID of the given @flag.
+ *
+ * Returns: the length on success,
+            0 on error,
+            -ENOTSUP if GNUTLS is not enabled.
+ */
+int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag);
+
+/**
+ * qcrypto_get_x509_signature_algorithm
+ * @cert: pointer to the raw certiricate data
+ * @size: size of the certificate
+ * @errp: error pointer
+ *
+ * Determine the signature algorithm used to sign the @cert.
+ *
+ * Returns: a value from the QCryptoSigAlgo enum on success,
+ *          -1 on error,
+ *          -ENOTSUP if GNUTLS is not enabled.
+ */
+int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **errp);
+
 #endif
diff --git a/qapi/crypto.json b/qapi/crypto.json
index c9d967d782..af487dcecd 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -612,3 +612,83 @@
   'base': { 'alg': 'QCryptoAkCipherAlgo' },
   'discriminator': 'alg',
   'data': { 'rsa': 'QCryptoAkCipherOptionsRSA' }}
+
+##
+# @QCryptoKeyidFlags:
+#
+# The supported flags for the key ID
+#
+# @sha1: SHA-1
+#
+# @sha256: SHA-256
+#
+# @sha512: SHA-512
+#
+# @best-known: BEST-KNOWN
+#
+# Since: 10.1
+##
+{ 'enum': 'QCryptoKeyidFlags',
+  'data': ['sha1', 'sha256', 'sha512', 'best-known']}
+
+##
+# @QCryptoCertFmt:
+#
+# The supported certificate encoding formats
+#
+# @der: DER
+#
+# @pem: PEM
+#
+# Since: 10.1
+##
+{ 'enum': 'QCryptoCertFmt',
+  'data': ['der', 'pem']}
+
+##
+# @QCryptoSigAlgo:
+#
+# Algorithms for digital signature
+#
+# @unknown: UNKNOWN
+#
+# @rsa-sha1: RSA-SHA1 or RSA-SHA
+#
+# @dsa-sha1: DSA-SHA1 or DSA-SHA
+#
+# @rsa-md5: RSA-MD5
+#
+# @rsa-md2: RSA-MD2
+#
+# @rsa-rmd160: RSA-RMD160
+#
+# @rsa-sha256: RSA-SHA256
+#
+# @rsa-sha384: RSA-SHA384
+#
+# @rsa-sha512: RSA-SHA512
+#
+# @rsa-sha224: RSA-SHA224
+#
+# @dsa-sha224: DSA-SHA224
+#
+# @dsa-sha256: DSA-SHA256
+#
+# @ecdsa-sha1: ECDSA-SHA1
+#
+# @ecdsa-sha224: ECDSA-SHA224
+#
+# @ecdsa-sha256: ECDSA-SHA256
+#
+# @ecdsa-sha384: ECDSA-SHA384
+#
+# @ecdsa-sha512: ECDSA-SHA512
+#
+# Since: 10.1
+##
+{ 'enum': 'QCryptoSigAlgo',
+  'data': ['unknown', 'rsa-sha1', 'dsa-sha1',
+           'rsa-md5', 'rsa-md2', 'rsa-rmd160',
+           'rsa-sha256', 'rsa-sha384', 'rsa-sha512', 'rsa-sha224',
+           'dsa-sha224', 'dsa-sha256',
+           'ecdsa-sha1', 'ecdsa-sha224', 'ecdsa-sha256', 'ecdsa-sha384', 'ecdsa-sha512']}
-- 
2.49.0


