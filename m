Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78745C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 12:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzD7G-0007Yw-Nn; Wed, 26 Aug 2026 08:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7D-0007WM-A6; Wed, 26 Aug 2026 08:52:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wzD7A-0002Qg-WA; Wed, 26 Aug 2026 08:52:27 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCW2NY2877774; Wed, 26 Aug 2026 12:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3qT8/T
 vKVN2eBp/bmmADAW3dCJWTTLMLC0e3i6BtHew=; b=Q6oDQ3peZL+/kkOqrstB3P
 +4DaMqXMvsUwrNZLZ3zcOVL3d1gGbZr0bQzK9IGQIgnsNS576mCrEB06O3gF2SEZ
 2JTjLD5ZyVH7u8kOAS4OXHe2depBXxdk/vkvmpZ7Co3xkSKvLLCpFsKfTSs/Jxo9
 NuGDfRcDsOOT9DGgf0cxcO4l/AqZJuZdsGqzEw7gdoYk/JYq5Fq+o19YX7Jf4Y/6
 yqJ4KL9Tkl0iklWIUU4okdAUI/SaKMufLUNT8SjSoJIUafsmAAFK2oOpZQsUlJNE
 kXSDPxmGD+CFtpG7JfLdeFGW+gLTZaiaqRTi9ZKq3YD/lfVJyAATSPYxTPsZexZg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726epkje-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QCfGfI002326;
 Wed, 26 Aug 2026 12:52:23 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k1xvp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 12:52:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QCqL5r42729818
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 12:52:22 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E69EF5805B;
 Wed, 26 Aug 2026 12:52:21 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D018158059;
 Wed, 26 Aug 2026 12:52:20 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.78.161]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 12:52:20 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Farhan Ali <alifm@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 05/37] crypto/x509-utils: Add helper functions for certificate
 store
Date: Wed, 26 Aug 2026 08:51:40 -0400
Message-ID: <20260826125213.1901252-6-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826125213.1901252-1-farman@linux.ibm.com>
References: <20260826125213.1901252-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8ee187 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=GV1Vcjpo_iY7pHGplTMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfX5SLgJ6CwwsfH
 2d2f8loOBoFwCT8sz45XJTSGJ7mSVC1VuzSXToUPXthh0pmT9pn4oqf/j9vF8hALOGx1ATgwWmJ
 YDgLKMGKPF0oWtQ84OJ1kidXAjps7fQ=
X-Proofpoint-GUID: vK--Bq6tqAsYE-38wEMqB2P7-wscJvti
X-Proofpoint-ORIG-GUID: vK--Bq6tqAsYE-38wEMqB2P7-wscJvti
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNCBTYWx0ZWRfXw8BMVs5thHmx
 Djg2FH1UWP6In4fQtX/bavjJ8krUoM+GQJl8nqtB8mRVLu6zg38h58c0xm7JWPA6AjhlJAW70gd
 TuWcnhSIMJQ4a5qesLKYbI+JKb90/0WDsegC0+i3O3b3tvu7lpEYsw8eQAI6ATxOlO6Lq8b3iHQ
 Z7+XMiDAW4fSSli4nfvtsiAJcBRbKyPKjDTSwjbE5XH8S51GdaYph6W/fp16qXyMyz+HyAYu6MB
 l32O86C9tuKlXxqlTFBozd64mguIhQYxuEn9TXdO+0BaknLZ+BTKswVKvM4ZZofNRH5ugD5htao
 5Re2iS6OXigW18Uqcm22ErH+NtquELTB3JzzeFpBFULTefbJm5kAi7WqI2F+w1ZC11rOeWQFnCv
 AyhOQg3Wj8w3tnmNZARelikF+H+yec3qWPzPkQYDiP4VIX59QR9cZajBR23lXiLC/4PMkAbJXUi
 jOQ6ktr0oFAdfr/ALaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260104
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Zhuoying Cai <zycai@linux.ibm.com>

Introduce new helper functions for x509 certificate, which will be used
by the certificate store:

qcrypto_x509_convert_cert_der() - converts a certificate from PEM to DER format

These functions provide support for certificate format conversion.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260730214624.2328883-4-zycai@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 crypto/x509-utils.c         | 49 +++++++++++++++++++++++++++++++++++++
 include/crypto/x509-utils.h | 21 ++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index 1b497caae8..369e7ca6af 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -82,6 +82,46 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
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
+    g_free(datum_der.data);
+    return ret;
+}
+
 #else /* ! CONFIG_GNUTLS */
 
 int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
@@ -94,4 +134,13 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
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
2.55.0


