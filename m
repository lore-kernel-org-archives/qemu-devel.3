Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F096C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 22:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMw7C-0002kV-Mt; Wed, 04 Jun 2025 17:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw77-0002gV-Rh; Wed, 04 Jun 2025 17:57:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw74-0006yj-W8; Wed, 04 Jun 2025 17:57:37 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554E5G45017850;
 Wed, 4 Jun 2025 21:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=QhDDEhXU3qE6XMeJS
 Y2xPaAT+wVQPmBi+hnGipuEepI=; b=Bp4K195uUtkbgGnzhXT9bdShIhm0Twe1x
 ImEfjStTO2cjPkJyOec92Pc81DytCoC5Ohd89jNV4FqR5yp5P9ENVlBUx6BokQ31
 l0un5G7tm3uVKCHfbJpfyLFGc6RWont33bycQVhuCxp2YOXNOCsh2/MHSXHu9Df6
 9T64sp1OfdNXgQe0QrCqYtfio4LHpeZK2HSC1YBuFYcPLELEFNJuzYIB48DRoXZr
 2e08WLF9/X9jRZo2DipYAxDIACbrrIfWkS8RCh1BZ34xBKS/OlPzbgryd/eAh38Q
 IBMhdSE8rOGHWu2Id+caSfxCn0WfN7bhFXsMbXHEPRf4rcHv/FZYw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 472fwums1q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 554JC0m0019937;
 Wed, 4 Jun 2025 21:57:32 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470d3p1urt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:32 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 554LvUcR28770972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jun 2025 21:57:30 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF7D058050;
 Wed,  4 Jun 2025 21:57:30 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D75D958045;
 Wed,  4 Jun 2025 21:57:28 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.211])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jun 2025 21:57:28 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v3 11/28] crypto: Add helper functions for DIAG 508 subcode 1
Date: Wed,  4 Jun 2025 17:56:39 -0400
Message-ID: <20250604215657.528142-12-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604215657.528142-1-zycai@linux.ibm.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE3NSBTYWx0ZWRfX2fWveTI048wZ
 ATJNClo3zpPGU9k50gSkYiI4jj2YcXwiy60hBo2FbCf59UgRntqsy60BRpyPRBa64FXSCxzpa1P
 8jNeAytn6daVDV8ewYk1VaqARJ3hPDpUaFHSaTCx13TZ5Fmznlz8sOolNZ33w0ofWm3o2816Zgl
 quUno8LERA7Bv/WaXF23s7sGO4qWdDLp2Fo/kGA/o9G5Da/71oAAfG6pL6ooQQeb6ji6eLU7Lip
 pcLoV6Gjp/sSfOOw8grKLbboNl53FXmgnCadBHEpSgiAxkPGW9zdOgxeeourFDP5HYrNBPJgU0E
 RjXlUWrXFZxCMUuItYwCyySEiU9Ab7XWVOIsfeLfuyLnvuXdeXYreLRLNGpr9QI9cBqFn9S68+1
 rMg9qPc/cioc1QjHrK5HGEWwDcBH+znT+P9Nit8QSWbnD241Pp0Ss5QTJIG46NV6eT8tEruz
X-Proofpoint-GUID: TqrvMmQdS6-37d7vHvf-i_wywm_i1hIe
X-Proofpoint-ORIG-GUID: TqrvMmQdS6-37d7vHvf-i_wywm_i1hIe
X-Authority-Analysis: v=2.4 cv=QtVe3Uyd c=1 sm=1 tr=0 ts=6840c14c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=xuTDbLs7dyIwHBXvKG0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
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
patch for DIAG 508 subcode 1.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 crypto/x509-utils.c         | 61 +++++++++++++++++++++++++++++++++++++
 include/crypto/x509-utils.h | 20 ++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index dd8137210c..4c997cf5d4 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -16,6 +16,7 @@
 #include <gnutls/gnutls.h>
 #include <gnutls/crypto.h>
 #include <gnutls/x509.h>
+#include <gnutls/pkcs7.h>
 
 static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
     [QCRYPTO_HASH_ALGO_MD5] = GNUTLS_DIG_MD5,
@@ -364,6 +365,58 @@ cleanup:
     return ret;
 }
 
+static int qcrypto_import_pkcs7(gnutls_pkcs7_t pkcs7, gnutls_datum_t *datum)
+{
+    int rc;
+
+    rc = gnutls_pkcs7_import(pkcs7, datum , GNUTLS_X509_FMT_PEM);
+    if (rc) {
+        rc = gnutls_pkcs7_import(pkcs7, datum , GNUTLS_X509_FMT_DER);
+    }
+
+    return rc;
+}
+
+int qcrypto_verify_x509_cert(uint8_t *cert, size_t cert_size,
+                             uint8_t *comp, size_t comp_size,
+                             uint8_t *sig, size_t sig_size, Error **errp)
+{
+    int rc = -1;
+    gnutls_x509_crt_t crt;
+    gnutls_pkcs7_t signature;
+    gnutls_datum_t cert_datum = {.data = cert, .size = cert_size};
+    gnutls_datum_t data_datum = {.data = comp, .size = comp_size};
+    gnutls_datum_t sig_datum = {.data = sig, .size = sig_size};
+
+    if (gnutls_x509_crt_init(&crt) < 0) {
+        error_setg(errp, "Failed to initialize certificate");
+        return rc;
+    }
+
+    if (qcrypto_import_x509_cert(crt, &cert_datum) != 0) {
+        error_setg(errp, "Failed to import certificate");
+        gnutls_x509_crt_deinit(crt);
+        return rc;
+    }
+
+    if (gnutls_pkcs7_init(&signature) < 0) {
+        error_setg(errp, "Failed to initalize pkcs7 data.");
+        return rc;
+    }
+
+    if (qcrypto_import_pkcs7(signature, &sig_datum) != 0) {
+        error_setg(errp, "Failed to import signature");
+        goto cleanup;
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
@@ -427,4 +480,12 @@ int qcrypto_get_x509_cert_key_id(uint8_t *cert, size_t size,
     return -ENOTSUP;
 }
 
+int qcrypto_verify_x509_cert(uint8_t *cert, size_t cert_size,
+                             uint8_t *comp, size_t comp_size,
+                             uint8_t *sig, size_t sig_size, Error **errp)
+{
+    error_setg(errp, "GNUTLS is required for signature-verification support");
+    return -ENOTSUP;
+}
+
 #endif /* ! CONFIG_GNUTLS */
diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
index 4a9941b33d..0b698b1b08 100644
--- a/include/crypto/x509-utils.h
+++ b/include/crypto/x509-utils.h
@@ -136,4 +136,24 @@ int qcrypto_get_x509_cert_key_id(uint8_t *cert, size_t size,
                                  size_t *resultlen,
                                  Error **errp);
 
+/**
+ * qcrypto_verify_x509_cert
+ * @cert: pointer to the raw certiricate data
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
+ *          negative error code on error,
+ *          -ENOTSUP if GNUTLS is not enabled.
+ */
+int qcrypto_verify_x509_cert(uint8_t *cert, size_t cert_size,
+                             uint8_t *comp, size_t comp_size,
+                             uint8_t *sig, size_t sig_size, Error **errp);
+
 #endif
-- 
2.49.0


