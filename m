Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D9EC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhHG-0000CQ-1K; Fri, 03 Jul 2026 13:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhGV-0007i5-Ds; Fri, 03 Jul 2026 13:01:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhGT-00035K-HO; Fri, 03 Jul 2026 13:01:23 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIX843302336; Fri, 3 Jul 2026 17:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mXU26F
 u2/R8eROgDuf/6BQoFcSLeWh1d8e0Fq3O8M8A=; b=F3szkFL/gJJ7CiR0GtsJYm
 A9NKpmuAczHbAcRfN9EAuUiQdcbk7f3tatRVbEQhP8T2sNHAsmzfL+TN1DknHKGK
 XYWgMxnGSxg/OB6rC2QU5Z7qo4qC5WK0sTReSjx8a3uB26MC4FPyQuNCwjVcsDFY
 fF28fy8D+F81QX5rBSFsGr3v5v4HNddi0e/xRAhDZWoPS/Gha54yMglwDJR0sBna
 4uWbtdz7CINHtrt2eqQlj1ya4HsEBNUX3l1BSOTmdTcz9X959RcFeyKu/KWaWp1w
 wCSEZRV7YfPZvzFAlchVHC6puO0eiHyV1JGSbN9xsUvRmTOQ2ldLFDQc+ko8l1Nw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n688ws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:01:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663GnhUc019692;
 Fri, 3 Jul 2026 17:01:17 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqsy2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:01:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663H1F6O34341582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 17:01:15 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F35358054;
 Fri,  3 Jul 2026 17:01:15 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62FD65805D;
 Fri,  3 Jul 2026 17:01:12 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.75.28])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 17:01:12 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v14 12/33] crypto/x509-utils: Add helper functions for DIAG
 508 subcode 1
Date: Fri,  3 Jul 2026 13:00:09 -0400
Message-ID: <20260703170032.1893204-13-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703170032.1893204-1-zycai@linux.ibm.com>
References: <20260703170032.1893204-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfXzeGU265Bl6L5
 nReINMtDsxJAL2YwnO1WcUXSAWesDkfhs5lzoSeZ67P3CmeVwKwMktfW+jaWGmbRjogChfZzi2n
 IFLA4s3KMtLJ+pnW/I1YrYvzTWnWQA8OEhOmdXPUShyYb0iGGeoQ/z3RBu++zh5ybzWJilnnyYG
 lRAWWWijVWVgt74iXOZ917xuqB9N8joZky5p3qiWDilYAzMJIS+rmvUMmfxS2Rv5sdCYBRLaEJc
 THGqZeff9ovctP6FOfROdW3SDc/Wd9W0/A3o+cOA3OUMv+BQhOrQNB+ZAMhcg1XAiNrqZ9cG9Rh
 OtW0PzmbLgyeRNuPeXZEZPIn0B6HuR8inE2Q6JLmmUxIwcZH/mBXmSeE5W/VjP+ofRu1eUYLujc
 mtU+KPTdywQ8Ql2qTCmXKkHPY1pHBxQKifTbr5TntOlrGinmzmvRJ8fXi0bRLHe2WD62Gs5EyXy
 8TpFNKzqinJNbXTUoRw==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a47eade cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=Ehcw9bocbOASTidboh8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7Adxots2MCey2gHZVWbrSRfySUaR8gGi
X-Proofpoint-GUID: 7Adxots2MCey2gHZVWbrSRfySUaR8gGi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX+qX2myLck/P6
 S5ys4AUHIFbcm9sf+6YRimbBzy+btBir2vxWJj4q1Emp6we93HsYYTDWwEWa4PBt8whVpq8lXQm
 Ai/N5nGR4yP+WELIox+8aV32OV4Cubk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030167
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 crypto/x509-utils.c         | 108 ++++++++++++++++++++++++++++++++++++
 include/crypto/x509-utils.h |  41 ++++++++++++++
 2 files changed, 149 insertions(+)

diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index d0e0384e9c..b23a5f0979 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -16,6 +16,7 @@
 #include <gnutls/gnutls.h>
 #include <gnutls/crypto.h>
 #include <gnutls/x509.h>
+#include <gnutls/pkcs7.h>
 
 static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
     [QCRYPTO_HASH_ALGO_MD5] = GNUTLS_DIG_MD5,
@@ -335,6 +336,96 @@ int qcrypto_x509_check_ecc_curve_p521(uint8_t *cert, size_t size, Error **errp)
     return curve_id == GNUTLS_ECC_CURVE_SECP521R1;
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
+        error_setg(errp, "Failed to initialize pkcs7 data: %s", gnutls_strerror(rc));
+        return ret;
+    }
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
+    *resultlen = sig_datum_pem.size;
+    *result = g_memdup2(sig_datum_pem.data, sig_datum_pem.size);
+
+    ret = 0;
+
+cleanup:
+    gnutls_pkcs7_deinit(signature);
+    g_free(sig_datum_pem.data);
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
+        error_setg(errp, "Failed to initialize pkcs7 data: %s", gnutls_strerror(rc));
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
@@ -378,4 +469,21 @@ int qcrypto_x509_check_ecc_curve_p521(uint8_t *cert, size_t size, Error **errp)
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
index fcace73c49..c256d7bfad 100644
--- a/include/crypto/x509-utils.h
+++ b/include/crypto/x509-utils.h
@@ -91,4 +91,45 @@ int qcrypto_x509_get_cert_key_id(uint8_t *cert, size_t size,
  */
 int qcrypto_x509_check_ecc_curve_p521(uint8_t *cert, size_t size, Error **errp);
 
+/**
+ * qcrypto_pkcs7_convert_sig_pem
+ * @sig: pointer to the PKCS#7 signature in DER format
+ * @sig_size: size of the signature
+ * @result: output location for the allocated buffer for the signature in
+ *          PEM format
+ *          (the function allocates memory which must be freed by the caller)
+ * @resultlen: pointer to the size of the buffer
+ *              (will be updated with the actual size of the PEM-encoded
+ *               signature)
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
2.54.0


