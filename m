Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D87C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 02:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfTfB-00088C-Uw; Thu, 02 Jul 2026 22:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfTf4-00085O-Fz; Thu, 02 Jul 2026 22:29:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfTf2-00034n-NQ; Thu, 02 Jul 2026 22:29:50 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6631K1wY1204379; Fri, 3 Jul 2026 02:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/3eqHN
 bv4aXfd+u4AnT0IFpGYmbYJdEcHut8ZRCL9ww=; b=SMWX7rYjh+pHlHX2StMelL
 Ne6T+lCyP1smsnM04bsjEDVclOKcLkBpq3fKvg0m53OzcxVKyRqfdAcumVXqUWWz
 sAJCvDMs9ZtRqTLhoCCH7hCKgsMS7yYYsIbTbfivsKsji2dB28f1pmaN8vZg3J94
 sl+zE9iibxfbekWjLGc6NFq9xMHKxGk/8TMw4pl8leYhp0BNkkxlUtIpwO2fG0XK
 d+F3W2Q/8td67MWfhWR66j/eyEGhgEHY51mNaYPLmr50jEHXaPOQtZLZl87CtvOV
 jruUDOQtONH0OS00KykfjpqxTVvcXifgX1psiUKIOvfN6+e4V1pc5wjC8rJIylOg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qacjsb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:29:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6632Jhb1023659;
 Fri, 3 Jul 2026 02:29:44 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhppdh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:29:44 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6632Thgp30278382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 02:29:43 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7ECE858052;
 Fri,  3 Jul 2026 02:29:43 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EC3358056;
 Fri,  3 Jul 2026 02:29:41 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.151.121])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 02:29:41 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v13 03/33] crypto/x509-utils: Add helper functions for
 certificate store
Date: Thu,  2 Jul 2026 22:29:01 -0400
Message-ID: <20260703022933.1805010-4-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703022933.1805010-1-zycai@linux.ibm.com>
References: <20260703022933.1805010-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAyMCBTYWx0ZWRfXwcEpV+nWCpX5
 smzTzmjR7qKLlzDJoars7gkZZy0sGyPX141Yuf8MvfazEFnylzqMUYql9owz2edm1iWU6Wg4rhc
 IJ2Rlq58scdhrsUaCe80QOQ0L7VYtS5M7DfL5od+duiOW1OFYbcfa+HB/ZpDxixQwCRNHJyr3h8
 7iGTJzGqelBU2eiW7cgssk3kNr+OwiKh4SvcEAdHIjru3WXp2P9CTQuKLQvu9rzh4S0SKAdVR+L
 /FI9L+X6Dx53/PNGw5jc3pO+e1FAjeLWpo1qET4fdprurXU5fvKbH+dyQhmQnwUICV7VaGxMznQ
 iHYehl2p6SzsBa2il4jCNSzpmBgdQWvNynOC3fBzFgE1g43zF3G1/wuJ9T73Ai5ZAojks98hL4q
 9MYLdbZ+dHrNhhgVLuW+wJXizGu79yITUFbQ4JIvOQRLiIE/5ZeIbLJS5enwsMEYaK/OvdD/k6w
 RysjU0hwIXbDrooK+GQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAyMCBTYWx0ZWRfX7yJjtPEQiv2/
 V+HbtFT+J3fdo5O00fUP0derWYYG1b/evud17uCteRI2F3qAxHUidsYYBIavRtwwF/yokqSqSkP
 8kGLay8/B7fXtCHKUkUaiTeFZB9S/Zs=
X-Proofpoint-GUID: wTkDmcjzXWl9lOh_yVf35DLGHk3nSqkW
X-Proofpoint-ORIG-GUID: wTkDmcjzXWl9lOh_yVf35DLGHk3nSqkW
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a471e99 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=GX81FK21qHpjiM7aGUoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030020
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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
index 6176a88653..68cf008938 100644
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
+    g_free(datum_der.data);
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
2.54.0


