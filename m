Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F125CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 23:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz1TK-0005Xc-GZ; Wed, 17 Sep 2025 19:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uz1TD-0005TN-FN; Wed, 17 Sep 2025 19:21:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uz1TB-0002P9-9n; Wed, 17 Sep 2025 19:21:51 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HKFM6j021247;
 Wed, 17 Sep 2025 23:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9dZPpp
 fjO+b19mtQM6/MrW8mgdNv9B7yB4oAIB6B2O8=; b=kv4ev2303M5lSPFvBaXHne
 wM+0wxkhqlQ8BVBG1oU1iMzprdsM6RPRQWF6jR72L5JfGfBm5aXAP/LucCkUt7yo
 CLX+ukhO/XIDYl2hC2VfC4PshcfmQvfp9b7d8XP91oJZLgEQHNjWn7KCSR5whlVm
 Gev+HAl2YbqUgEYWhWPaEUrN7f6SW5gqdhBkY+P7e0okpXJpUZYvYxDE1YhdMV1F
 w2aFh7lHifFH3yU3UXRTUmh7FcsLkMGcBX2oABWRBQ4k7kEE2+1wJsyCQgUA160R
 syGK4hws9+wb574kxLQ4iHCm76sCP3AcfeiFUAYeeKNb+sEaBESTlOPAwMFdheag
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4m6fc7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 23:21:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58HKtYnr022347;
 Wed, 17 Sep 2025 23:21:47 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxpuu75-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 23:21:47 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58HNLjfJ10617974
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Sep 2025 23:21:45 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E02A5805C;
 Wed, 17 Sep 2025 23:21:45 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C8365805A;
 Wed, 17 Sep 2025 23:21:44 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.34.172])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Sep 2025 23:21:44 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com
Subject: [PATCH v6 11/28] crypto/x509-utils: Add helper functions for DIAG 508
 subcode 1
Date: Wed, 17 Sep 2025 19:21:13 -0400
Message-ID: <20250917232131.495848-12-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250917232131.495848-1-zycai@linux.ibm.com>
References: <20250917232131.495848-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zzc7Wn4pHDdQ0X6l9YPPqwhy7Iidgkuv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX8OfMePq9gFcq
 SZ9gHyls+36s+pggPfKkNiLiVBeitivyLz3T0b2pPLixPsmsb/IBJxEen/nV5P8Q+Qv4NsYeke+
 4yXw2KsQJ+T5k5vc+hbAm94wMaVKibvwSYF0jjLIFH/Jlstk+AVwAR74gryC+3Rzys9HM/LED/8
 ygwGGGf2kcMGAHHVwSZqMD6I78R6VTWRR8BMbm8B0qe703e4BYIcYPIPLTh0lIAN5GNXVVkBEC/
 tYdorM508mw3Iq+3NxJftKto25/hj3eW+Vv85PELdX+2rlaX5kxFOmIvdqzl7EW85XdYLwVgSl1
 tGYiDiF+HH5yPCz9+oN2HAyO8/XRPkJxk0Lop6mAW/rS6qAQ4nUoApaYAiI78/PLOU2QRElviW5
 nu+9ayb9
X-Proofpoint-ORIG-GUID: zzc7Wn4pHDdQ0X6l9YPPqwhy7Iidgkuv
X-Authority-Analysis: v=2.4 cv=QrNe3Uyd c=1 sm=1 tr=0 ts=68cb428b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=Ehcw9bocbOASTidboh8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Introduce helper functions to support signature verification required by
DIAG 508 subcode 1:

qcrypto_pkcs7_convert_sig_pem() – converts a signature from DER to PEM format
qcrypto_x509_verify_sig() – verifies the provided data against the given signature

These functions enable basic signature verification support.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 crypto/x509-utils.c         | 109 ++++++++++++++++++++++++++++++++++++
 include/crypto/x509-utils.h |  39 +++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index 763eccb190..8f3c895d7c 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -16,6 +16,7 @@
 #include <gnutls/gnutls.h>
 #include <gnutls/crypto.h>
 #include <gnutls/x509.h>
+#include <gnutls/pkcs7.h>
 
 static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
     [QCRYPTO_HASH_ALGO_MD5] = GNUTLS_DIG_MD5,
@@ -342,6 +343,97 @@ int qcrypto_x509_is_ecc_curve_p521(uint8_t *cert, size_t size, Error **errp)
     return 0;
 }
 
+int qcrypto_pkcs7_convert_sig_pem(uint8_t *sig, size_t sig_size,
+                                  uint8_t **result, size_t *resultlen,
+                                  Error **errp)
+{
+    int ret = -1;
+    int rc;
+    gnutls_pkcs7_t signature;
+    gnutls_datum_t sig_datum_der = {.data = sig, .size = sig_size};
+    gnutls_datum_t sig_datum_pem = {.data = NULL, .size = 0};
+
+    rc = gnutls_pkcs7_init(&signature);
+    if (rc < 0) {
+        error_setg(errp, "Failed to initalize pkcs7 data: %s", gnutls_strerror(rc));
+        return ret;
+     }
+
+    rc = gnutls_pkcs7_import(signature, &sig_datum_der, GNUTLS_X509_FMT_DER);
+    if (rc != 0) {
+        error_setg(errp, "Failed to import signature: %s", gnutls_strerror(rc));
+        goto cleanup;
+    }
+
+    rc = gnutls_pkcs7_export2(signature, GNUTLS_X509_FMT_PEM, &sig_datum_pem);
+    if (rc != 0) {
+        error_setg(errp, "Failed to convert signature to PEM format: %s",
+                   gnutls_strerror(rc));
+        goto cleanup;
+    }
+
+    *result = g_new0(uint8_t, sig_datum_pem.size);
+    *resultlen = sig_datum_pem.size;
+    memcpy(*result, sig_datum_pem.data, sig_datum_pem.size);
+
+    ret = 0;
+
+cleanup:
+    gnutls_pkcs7_deinit(signature);
+    gnutls_free(sig_datum_pem.data);
+    return ret;
+}
+
+int qcrypto_x509_verify_sig(uint8_t *cert, size_t cert_size,
+                            uint8_t *comp, size_t comp_size,
+                            uint8_t *sig, size_t sig_size, Error **errp)
+{
+    int rc;
+    int ret = -1;
+    gnutls_x509_crt_t crt = NULL;
+    gnutls_pkcs7_t signature = NULL;
+    gnutls_datum_t cert_datum = {.data = cert, .size = cert_size};
+    gnutls_datum_t data_datum = {.data = comp, .size = comp_size};
+    gnutls_datum_t sig_datum = {.data = sig, .size = sig_size};
+
+    rc = gnutls_x509_crt_init(&crt);
+    if (rc < 0) {
+        error_setg(errp, "Failed to initialize certificate: %s", gnutls_strerror(rc));
+        goto cleanup;
+    }
+
+    rc = gnutls_x509_crt_import(crt, &cert_datum, GNUTLS_X509_FMT_PEM);
+    if (rc != 0) {
+        error_setg(errp, "Failed to import certificate: %s", gnutls_strerror(rc));
+        goto cleanup;
+    }
+
+    rc = gnutls_pkcs7_init(&signature);
+    if (rc < 0) {
+        error_setg(errp, "Failed to initalize pkcs7 data: %s", gnutls_strerror(rc));
+        goto cleanup;
+     }
+
+    rc = gnutls_pkcs7_import(signature, &sig_datum , GNUTLS_X509_FMT_PEM);
+    if (rc != 0) {
+        error_setg(errp, "Failed to import signature: %s", gnutls_strerror(rc));
+        goto cleanup;
+    }
+
+    rc = gnutls_pkcs7_verify_direct(signature, crt, 0, &data_datum, 0);
+    if (rc != 0) {
+        error_setg(errp, "Failed to verify signature: %s", gnutls_strerror(rc));
+        goto cleanup;
+    }
+
+    ret = 0;
+
+cleanup:
+    gnutls_x509_crt_deinit(crt);
+    gnutls_pkcs7_deinit(signature);
+    return ret;
+}
+
 #else /* ! CONFIG_GNUTLS */
 
 int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
@@ -391,4 +483,21 @@ int qcrypto_x509_is_ecc_curve_p521(uint8_t *cert, size_t size, Error **errp)
     return -1;
 }
 
+int qcrypto_pkcs7_convert_sig_pem(uint8_t *sig, size_t sig_size,
+                                  uint8_t **result,
+                                  size_t *resultlen,
+                                  Error **errp)
+{
+    error_setg(errp, "GNUTLS is required to export pkcs7 signature");
+    return -1;
+}
+
+int qcrypto_x509_verify_sig(uint8_t *cert, size_t cert_size,
+                            uint8_t *comp, size_t comp_size,
+                            uint8_t *sig, size_t sig_size, Error **errp)
+{
+    error_setg(errp, "GNUTLS is required for signature-verification support");
+    return -1;
+}
+
 #endif /* ! CONFIG_GNUTLS */
diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
index 6fc8d982b7..43a3dbb7a9 100644
--- a/include/crypto/x509-utils.h
+++ b/include/crypto/x509-utils.h
@@ -111,4 +111,43 @@ int qcrypto_x509_get_cert_key_id(uint8_t *cert, size_t size,
  */
 int qcrypto_x509_is_ecc_curve_p521(uint8_t *cert, size_t size, Error **errp);
 
+/**
+ * qcrypto_pkcs7_convert_sig_pem
+ * @sig: pointer to the PKCS#7 signature in DER format
+ * @sig_size: size of the signature
+ * @result: output location for the allocated buffer for the signature in PEM format
+            (the function allocates memory which must be freed by the caller)
+ * @resultlen: pointer to the size of the buffer
+               (will be updated with the actual size of the PEM-encoded signature)
+ * @errp: error pointer
+ *
+ * Convert given PKCS#7 @sig from DER to PEM format.
+ *
+ * Returns: 0 if PEM-encoded signature was successfully stored in @result,
+ *         -1 on error.
+ */
+int qcrypto_pkcs7_convert_sig_pem(uint8_t *sig, size_t sig_size,
+                                  uint8_t **result,
+                                  size_t *resultlen,
+                                  Error **errp);
+
+/**
+ * qcrypto_x509_verify_sig
+ * @cert: pointer to the raw certificate data
+ * @cert_size: size of the certificate
+ * @comp: pointer to the component to be verified
+ * @comp_size: size of the component
+ * @sig: pointer to the signature
+ * @sig_size: size of the signature
+ * @errp: error pointer
+ *
+ * Verify the provided @comp against the @sig and @cert.
+ *
+ * Returns: 0 on success,
+ *         -1 on error.
+ */
+int qcrypto_x509_verify_sig(uint8_t *cert, size_t cert_size,
+                            uint8_t *comp, size_t comp_size,
+                            uint8_t *sig, size_t sig_size, Error **errp);
+
 #endif
-- 
2.50.1


