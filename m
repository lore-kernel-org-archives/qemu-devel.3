Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37586CA0EE9
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 21:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo7eX-0001zJ-Rs; Mon, 18 Aug 2025 17:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uo7dp-0001gk-E9; Mon, 18 Aug 2025 17:43:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uo7dn-0003m6-Er; Mon, 18 Aug 2025 17:43:45 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ID7cao031324;
 Mon, 18 Aug 2025 21:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5hzX6z
 zvOb1EfclVIP0O6jxDqootMn/oL420wqUNcSg=; b=GwHX6wgDp6LkGWtZORpr2L
 5xiLxfnHkdog3tCSxdRk1G/Ky6YkHwKSG65wExZPBYY8/GtVFl31vu+Jq8WvfoB2
 1CUItZx+gExFePpnVXAtcOO4sCARmpBgHChFBb8QU3pFJ7xg+Y58buYgB9oGVyHE
 XCEkAmmk8KrZ+T/u4AwhfvSSaj0rJ6ixOzrFcpvMMPl4mtBqm0MicJ1Uqa2OaNSB
 Tr/WhGyO/PO4Rm9shTVj9rGszjczonUOYX9oCt34K5kJYjLI1SYxgFSVA0haojsh
 ZY7lPvWHEpc8I9NmlFQSy5oRPglolZDbHgDYe3wdUhBaOAUWTDBxMqxCCygzzO+Q
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48k60g0cnu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 21:43:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57IKJKmA002381;
 Mon, 18 Aug 2025 21:43:40 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k712y9w5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 21:43:40 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57ILhdmh20709892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Aug 2025 21:43:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14A5C58057;
 Mon, 18 Aug 2025 21:43:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A3C7B58058;
 Mon, 18 Aug 2025 21:43:37 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.98.172])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 18 Aug 2025 21:43:37 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v5 11/29] crypto/x509-utils: Add helper functions for DIAG 508
 subcode 1
Date: Mon, 18 Aug 2025 17:43:04 -0400
Message-ID: <20250818214323.529501-12-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818214323.529501-1-zycai@linux.ibm.com>
References: <20250818214323.529501-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _Sm9C0wKQx291DhepiDPSUX1Tq1vdwEP
X-Authority-Analysis: v=2.4 cv=coObk04i c=1 sm=1 tr=0 ts=68a39e8d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=Ehcw9bocbOASTidboh8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _Sm9C0wKQx291DhepiDPSUX1Tq1vdwEP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE3MDAxNiBTYWx0ZWRfX3b3VP9bo/KFH
 Q6AYSSxHPNF7MCVN5LdoN6M0p46hOdu3aIPKgAp68FurNg5+E5swA/kJjrgmOAA67zcu2NuB4im
 CdXJGVtRZHy6wEw4AVRMAM/+8pd4tUO1TCVyXTSpb5dJHUpvLXjZcAUvTpa/2LB48wgZKV4Ru6r
 OpblCBm7bVPoesuw5P8anXL9aXh4KzCSprpkJ4TanrjAHlgddcN34X36yVqkWgO0wIA78lLnFI0
 I9x39BNT/ETRc4+w0isBzNxtBI9/XulKNf35W7RCu1MJHSx8vN9E4NYDBWuC5zUbA9KlUGPDoTX
 ZvQEuNnsiVJeNrUmrBAeAbAMwrQ7EsfGU/W5fH+GJtU1U7GmX68xRYvIqHd4e0rhgLSswbcUnhe
 yjU9wUL1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508170016
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
 crypto/x509-utils.c         | 108 ++++++++++++++++++++++++++++++++++++
 include/crypto/x509-utils.h |  39 +++++++++++++
 2 files changed, 147 insertions(+)

diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index 67b42aad1f..f582e2ee48 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -16,6 +16,7 @@
 #include <gnutls/gnutls.h>
 #include <gnutls/crypto.h>
 #include <gnutls/x509.h>
+#include <gnutls/pkcs7.h>
 
 static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
     [QCRYPTO_HASH_ALGO_MD5] = GNUTLS_DIG_MD5,
@@ -275,6 +276,96 @@ cleanup:
     return ret;
 }
 
+int qcrypto_pkcs7_convert_sig_pem(uint8_t *sig, size_t sig_size,
+                                  uint8_t **result, size_t *resultlen,
+                                  Error **errp)
+{
+    int ret = -1;
+    int rc;
+    gnutls_pkcs7_t signature;
+    gnutls_datum_t sig_datum_der = {.data = sig, .size = sig_size};
+    gnutls_datum_t sig_datum_pem = { 0, };
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
+        gnutls_free(sig_datum_pem.data);
+        goto cleanup;
+    }
+
+    *result = g_steal_pointer(&sig_datum_pem.data);
+    *resultlen = sig_datum_pem.size;
+
+    ret = 0;
+
+cleanup:
+    gnutls_pkcs7_deinit(signature);
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
@@ -318,4 +409,21 @@ int qcrypto_x509_get_cert_key_id(uint8_t *cert, size_t size,
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
index f169df81cb..c4073fd265 100644
--- a/include/crypto/x509-utils.h
+++ b/include/crypto/x509-utils.h
@@ -97,4 +97,43 @@ int qcrypto_x509_get_cert_key_id(uint8_t *cert, size_t size,
                                  size_t *resultlen,
                                  Error **errp);
 
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


