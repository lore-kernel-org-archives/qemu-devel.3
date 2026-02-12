Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD9EEEA84F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 20:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqdXn-0000bI-RC; Thu, 12 Feb 2026 15:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdXl-0000a6-Iw; Thu, 12 Feb 2026 15:44:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdXj-0007KH-Sv; Thu, 12 Feb 2026 15:44:09 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CIntf1331321; Thu, 12 Feb 2026 20:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cKJcRT
 uNn0GBFmcAIRYrF1sy/DGr4faYEQiLpVgVxaE=; b=WNlTCyg67JY6+WdLQl2uKN
 ABI2ZPiqXvBO0JFn6723Jd537F1aWOToO2VZvA5wtXbc/LtWc35phdsnPK/D5N+S
 7g/W7OyZNn82/ZK04XQCRtxOcE9bW9LsMTCv7lPOxJOhy/bVHvE7Ume1KjLIiier
 5zV6a+RTcN167TRYUzLM1cEI42QiJ+WZbZ5NBcDqs+BiZ9ffpxCPJDD5NEOXOdub
 pAk2uG5yMFAAbwP2eTVDZ7EH7nBHBo8bqjD3QRdsfV/JZXYzbEf4YcLh7zkjAOrs
 vbwK0zfKHWtowdU6O4CgWdwYprz0wWPTyFrN7iGt2zbWsS2bnTg+8rLqcVt4v0QQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696vd8rd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61CK7S6s002570;
 Thu, 12 Feb 2026 20:44:02 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6fqsvbh0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:02 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61CKi1Rg66257252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Feb 2026 20:44:01 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F14315804E;
 Thu, 12 Feb 2026 20:44:00 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E08158054;
 Thu, 12 Feb 2026 20:43:59 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.112.15])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Feb 2026 20:43:59 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com
Subject: [PATCH v8 03/30] crypto/x509-utils: Add helper functions for
 certificate store
Date: Thu, 12 Feb 2026 15:43:24 -0500
Message-ID: <20260212204352.1044699-4-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212204352.1044699-1-zycai@linux.ibm.com>
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lXHXcu4dISylcMFUENkeNaJCv5JVcXbl
X-Proofpoint-ORIG-GUID: lXHXcu4dISylcMFUENkeNaJCv5JVcXbl
X-Authority-Analysis: v=2.4 cv=JdWxbEKV c=1 sm=1 tr=0 ts=698e3b93 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=GX81FK21qHpjiM7aGUoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE1NyBTYWx0ZWRfX9p9EWbdKhr++
 BKqH6bjpVL/t/ift4Rwuy8lRkxeIgh6tHDNeTB2HNBXx7c2gAfAghPJvmKjcSTtOYxC4yM+uix2
 uHyNeqw6dzUeZ6TbBxJ7eAUwxJdDVvdeQ8vjJP/9MtHc6iLElsmFd0IAhpktq6cRbn3Igx5CzWy
 aZejJW8GLBL6OdJRfGrGrWpFcqjBJ8A53x6v0t9s23Fb40qUGmv9jZrPbD6GDyVtNxLMWVChcMK
 7iqy654ciuc7hYmmjAh4YJFep0P9Bv8lygD4+USDoPddQL5+8WUzq+bd+hs7k9MFewy0fcIt6Rz
 /E9IPbCjNLtjF08pj//EJgifj1e51IZTdO3pPZMAoRefGExjfFYhILob5YRf61pJFG5LczwRPfu
 axfyjsg9zTdK+tRVYhqO7FY9Xdu57BtCCLYVk67r41PTYUTFI0RhIfYj96/tAL3d4t2IlxqkSE6
 opBMi0hnMetD/jvF67Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120157
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

Introduce new helper functions for x509 certificate, which will be used
by the certificate store:

qcrypto_x509_convert_cert_der() - converts a certificate from PEM to DER format

These functions provide support for certificate format conversion.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 crypto/x509-utils.c         | 49 +++++++++++++++++++++++++++++++++++++
 include/crypto/x509-utils.h | 21 ++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index 6176a88653..2696d48155 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -81,6 +81,46 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
     return ret;
 }
 
+int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
+                                  uint8_t **result, size_t *resultlen,
+                                  Error **errp)
+{
+    int ret = -1;
+    int rc;
+    gnutls_x509_crt_t crt;
+    gnutls_datum_t datum = {.data = cert, .size = size};
+    gnutls_datum_t datum_der = {.data = NULL, .size = 0};
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
+    rc = gnutls_x509_crt_export2(crt, GNUTLS_X509_FMT_DER, &datum_der);
+    if (rc != 0) {
+        error_setg(errp, "Failed to convert certificate to DER format: %s",
+                   gnutls_strerror(rc));
+        goto cleanup;
+    }
+
+    *resultlen = datum_der.size;
+    *result = g_memdup2(datum_der.data, datum_der.size);
+
+    ret = 0;
+
+cleanup:
+    gnutls_x509_crt_deinit(crt);
+    gnutls_free(datum_der.data);
+    return ret;
+}
+
 #else /* ! CONFIG_GNUTLS */
 
 int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
@@ -93,4 +133,13 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
     return -1;
 }
 
+int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
+                                  uint8_t **result,
+                                  size_t *resultlen,
+                                  Error **errp)
+{
+    error_setg(errp, "GNUTLS is required to export X.509 certificate");
+    return -1;
+}
+
 #endif /* ! CONFIG_GNUTLS */
diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
index 1e99661a71..91ae79fb03 100644
--- a/include/crypto/x509-utils.h
+++ b/include/crypto/x509-utils.h
@@ -19,4 +19,25 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
                                       size_t *resultlen,
                                       Error **errp);
 
+/**
+ * qcrypto_x509_convert_cert_der
+ * @cert: pointer to the raw certificate data in PEM format
+ * @size: size of the certificate
+ * @result: output location for the allocated buffer for the certificate
+ *          in DER format
+ *          (the function allocates memory which must be freed by the caller)
+ * @resultlen: pointer to the size of the buffer (will be updated with the
+ *             actual size of the DER-encoded certificate)
+ * @errp: error pointer
+ *
+ * Convert the given @cert from PEM to DER format.
+ *
+ * Returns: 0 on success,
+ *         -1 on error.
+ */
+int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
+                                  uint8_t **result,
+                                  size_t *resultlen,
+                                  Error **errp);
+
 #endif
-- 
2.52.0


