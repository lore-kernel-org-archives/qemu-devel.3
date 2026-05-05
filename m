Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701B1FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMEy-0007em-5y; Tue, 05 May 2026 16:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wKMEt-0007Z6-BN; Tue, 05 May 2026 16:19:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wKMEr-0000DC-7O; Tue, 05 May 2026 16:19:31 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645Adpuh1590574; Tue, 5 May 2026 20:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=slu57R
 hsP9V5y/w105doFgjQg0HKAF2KwZnOyZHw+J4=; b=tl9er4/PE+OUhBxUz5Nb3T
 tHW0w01n1qk/kgTY9a1pkoifDBx4K7Zr1M8KAaxREHdG5SHTD6e6U/aE25TdnsXA
 UH/JHJj4lVvWq+Xne4c7Tn9i/k9hvzzyzd2EWw6NO27jGSqoiW/Eu5Fr31tGrh18
 PeNH+0jebEaX9uk6ovZEnKjZnEN+iXBNOPnLtmT+1+cd0Wy+uIWl7EwihaKvqaf5
 jSH6VhYv+Xu2aIhOpsSxvZJwAAQkuEX+DQcS4EDvni3E0K9vN0CRjsyGhSgNnoHW
 lk3k3w+VgVSNv/SKw9VCWr8SzVmpC9Ou50XhwJmN1RKzbflkPvUiiUgfjmQbuK4Q
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxn50g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 20:19:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645K9Q0x015549;
 Tue, 5 May 2026 20:19:24 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yb249-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 20:19:24 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 645KJMIN43319790
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2026 20:19:22 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C29935805C;
 Tue,  5 May 2026 20:19:22 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A51A58059;
 Tue,  5 May 2026 20:19:21 +0000 (GMT)
Received: from fedora-workstation.pok.ibm.com (unknown [9.12.79.241])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 May 2026 20:19:21 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v11 08/32] crypto/x509-utils: Add helper functions for DIAG
 320 subcode 2
Date: Tue,  5 May 2026 16:18:40 -0400
Message-ID: <20260505201905.997996-9-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505201905.997996-1-zycai@linux.ibm.com>
References: <20260505201905.997996-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE5NSBTYWx0ZWRfXyEfxHxgdBzZf
 r/Diixi54Ogg3cfcdRuNgVKT4dndFSer6D/CN2lwqqnzoQVSj3jCnFza/LW+L0z8W4A97cWnRDM
 TvkdqB/TK1AQRzPXN7MG+pA7fghEcdmdcz4psa+puQPWM8+U7Aq8oEKtcakRhn5tV6cxj8oiRdV
 +EJHqT50coFmNzbzYVvbvz95ndEHQ7HnkHnPPSPgY3MC2MFhGpTXniOnk10jFdrY7WbxSjiiQyL
 ya8fh7MnDLvGfiNVzsq5R+eo2CIr5OxZaS45l7qjbP7QEO9todi8CdgHxzWh21DKbLsN8NR6XoT
 v9j0DlCSnt1Kl9Nk4NZTW0w4i3wRfldyi5Ep/ZAd6+MRIdKfJnREFs8kJpUX7rGZGWXvwnasK9P
 FlkHTXGhXC/9agS+XZyCWk2wWbFpxjglP89iRPEZ+vcQKhCLroOpqSA61OHc5ZI54XdbRdq7oez
 Q2hVnvAxMC5NDPF2pZg==
X-Proofpoint-ORIG-GUID: 1f7QwPYqiH9DEALzjYGiQDWCmdy7_ojx
X-Proofpoint-GUID: 1f7QwPYqiH9DEALzjYGiQDWCmdy7_ojx
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fa50cd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=cx8EP_J7U0ANkHmDKVUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050195
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Introduce new helper functions to extract certificate metadata:

qcrypto_x509_check_cert_times() - validates the certificate's validity period against the current time
qcrypto_x509_get_cert_key_id() - extracts the key ID from the certificate
qcrypto_x509_check_ecc_curve_p521() - determines the ECC public key algorithm uses P-521 curve

These functions provide support for metadata extraction and validity checking
for X.509 certificates.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
---
 crypto/x509-utils.c         | 236 ++++++++++++++++++++++++++++++++++++
 include/crypto/x509-utils.h |  51 ++++++++
 2 files changed, 287 insertions(+)

diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index 68cf008938..7dd8d1a0e9 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -27,6 +27,16 @@ static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
     [QCRYPTO_HASH_ALGO_RIPEMD160] = GNUTLS_DIG_RMD160,
 };
 
+static const int qcrypto_to_gnutls_keyid_flags_map[] = {
+    [QCRYPTO_HASH_ALGO_MD5] = -1,
+    [QCRYPTO_HASH_ALGO_SHA1] = GNUTLS_KEYID_USE_SHA1,
+    [QCRYPTO_HASH_ALGO_SHA224] = -1,
+    [QCRYPTO_HASH_ALGO_SHA256] = GNUTLS_KEYID_USE_SHA256,
+    [QCRYPTO_HASH_ALGO_SHA384] = -1,
+    [QCRYPTO_HASH_ALGO_SHA512] = GNUTLS_KEYID_USE_SHA512,
+    [QCRYPTO_HASH_ALGO_RIPEMD160] = -1,
+};
+
 int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
                                       QCryptoHashAlgo alg,
                                       uint8_t *result,
@@ -121,6 +131,210 @@ cleanup:
     return ret;
 }
 
+int qcrypto_x509_check_cert_times(uint8_t *cert, size_t size, Error **errp)
+{
+    int rc;
+    int ret = -1;
+    gnutls_x509_crt_t crt;
+    gnutls_datum_t datum = {.data = cert, .size = size};
+    time_t now = time(NULL);
+    time_t exp_time;
+    time_t act_time;
+
+    if (now == ((time_t)-1)) {
+        error_setg_errno(errp, errno, "Cannot get current time");
+        return ret;
+    }
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
+    ret = 0;
+
+cleanup:
+    gnutls_x509_crt_deinit(crt);
+    return ret;
+}
+
+static int qcrypto_x509_get_pk_algorithm(uint8_t *cert, size_t size, Error **errp)
+{
+    int rc;
+    int ret = -1;
+    unsigned int bits;
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
+    rc = gnutls_x509_crt_get_pk_algorithm(crt, &bits);
+    if (rc < 0) {
+        error_setg(errp, "Unknown public key algorithm %d", rc);
+        goto cleanup;
+    }
+
+    ret = rc;
+
+cleanup:
+    gnutls_x509_crt_deinit(crt);
+    return ret;
+}
+
+int qcrypto_x509_get_cert_key_id(uint8_t *cert, size_t size,
+                                 QCryptoHashAlgo hash_alg,
+                                 uint8_t **result,
+                                 size_t *resultlen,
+                                 Error **errp)
+{
+    int rc;
+    int ret = -1;
+    gnutls_x509_crt_t crt;
+    gnutls_datum_t datum = {.data = cert, .size = size};
+
+    if (hash_alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
+        error_setg(errp, "Unknown hash algorithm %d", hash_alg);
+        return ret;
+    }
+
+    if (hash_alg >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map) ||
+        qcrypto_to_gnutls_keyid_flags_map[hash_alg] == -1) {
+        error_setg(errp, "Unsupported key id flag %d", hash_alg);
+        return ret;
+    }
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
+    *resultlen = gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[hash_alg]);
+    if (*resultlen == 0) {
+        error_setg(errp, "Failed to get hash algorithn length: %s", gnutls_strerror(rc));
+        goto cleanup;
+    }
+
+    *result = g_malloc0(*resultlen);
+    if (gnutls_x509_crt_get_key_id(crt,
+                                   qcrypto_to_gnutls_keyid_flags_map[hash_alg],
+                                   *result, resultlen) != 0) {
+        error_setg(errp, "Failed to get key ID from certificate");
+        g_clear_pointer(result, g_free);
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
+static int qcrypto_x509_get_ecc_curve(uint8_t *cert, size_t size, Error **errp)
+{
+    int rc;
+    int ret = -1;
+    gnutls_x509_crt_t crt;
+    gnutls_datum_t datum = {.data = cert, .size = size};
+    gnutls_ecc_curve_t curve_id;
+    gnutls_datum_t x = {.data = NULL, .size = 0};
+    gnutls_datum_t y = {.data = NULL, .size = 0};
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
+    rc = gnutls_x509_crt_get_pk_ecc_raw(crt, &curve_id, &x, &y);
+    if (rc != 0) {
+        error_setg(errp, "Failed to get ECC public key curve: %s", gnutls_strerror(rc));
+        goto cleanup;
+    }
+
+    ret = curve_id;
+
+cleanup:
+    gnutls_x509_crt_deinit(crt);
+    g_free(x.data);
+    g_free(y.data);
+    return ret;
+}
+
+int qcrypto_x509_check_ecc_curve_p521(uint8_t *cert, size_t size, Error **errp)
+{
+    int algo;
+    int curve_id;
+
+    algo = qcrypto_x509_get_pk_algorithm(cert, size, errp);
+    if (algo != GNUTLS_PK_ECDSA) {
+        return 0;
+    }
+
+    curve_id = qcrypto_x509_get_ecc_curve(cert, size, errp);
+    if (curve_id == -1) {
+        error_setg(errp, "Failed to get ECC curve");
+        return -1;
+    }
+
+    if (curve_id == GNUTLS_ECC_CURVE_INVALID) {
+        error_setg(errp, "Invalid ECC curve");
+        return -1;
+    }
+
+    return curve_id == GNUTLS_ECC_CURVE_SECP521R1;
+}
+
 #else /* ! CONFIG_GNUTLS */
 
 int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
@@ -142,4 +356,26 @@ int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
     return -1;
 }
 
+int qcrypto_x509_check_cert_times(uint8_t *cert, size_t size, Error **errp)
+{
+    error_setg(errp, "GNUTLS is required to get certificate times");
+    return -1;
+}
+
+int qcrypto_x509_get_cert_key_id(uint8_t *cert, size_t size,
+                                 QCryptoHashAlgo hash_alg,
+                                 uint8_t **result,
+                                 size_t *resultlen,
+                                 Error **errp)
+{
+    error_setg(errp, "GNUTLS is required to get key ID");
+    return -1;
+}
+
+int qcrypto_x509_check_ecc_curve_p521(uint8_t *cert, size_t size, Error **errp)
+{
+    error_setg(errp, "GNUTLS is required to determine ecc curve");
+    return -1;
+}
+
 #endif /* ! CONFIG_GNUTLS */
diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
index 91ae79fb03..6040894a46 100644
--- a/include/crypto/x509-utils.h
+++ b/include/crypto/x509-utils.h
@@ -40,4 +40,55 @@ int qcrypto_x509_convert_cert_der(uint8_t *cert, size_t size,
                                   size_t *resultlen,
                                   Error **errp);
 
+/**
+ * qcrypto_x509_check_cert_times
+ * @cert: pointer to the raw certificate data
+ * @size: size of the certificate
+ * @errp: error pointer
+ *
+ * Check whether the activation and expiration times of @cert
+ * are valid at the current time.
+ *
+ * Returns: 0 if the certificate times are valid,
+ *         -1 on error.
+ */
+int qcrypto_x509_check_cert_times(uint8_t *cert, size_t size, Error **errp);
+
+/**
+ * qcrypto_x509_get_cert_key_id
+ * @cert: pointer to the raw certificate data
+ * @size: size of the certificate
+ * @hash_alg: the hash algorithm flag
+ * @result: output location for the allocated buffer for key ID
+ *          (the function allocates memory which must be freed by the caller)
+ * @resultlen: pointer to the size of the buffer
+ *             (will be updated with the actual size of key id)
+ * @errp: error pointer
+ *
+ * Retrieve the key ID from the @cert based on the specified @flag.
+ *
+ * Returns: 0 if key ID was successfully stored in @result,
+ *         -1 on error.
+ */
+int qcrypto_x509_get_cert_key_id(uint8_t *cert, size_t size,
+                                 QCryptoHashAlgo hash_alg,
+                                 uint8_t **result,
+                                 size_t *resultlen,
+                                 Error **errp);
+
+/**
+ * qcrypto_x509_check_ecc_curve_p521
+ * @cert: pointer to the raw certificate data
+ * @size: size of the certificate
+ * @errp: error pointer
+ *
+ * Determine whether the ECC public key in the given certificate uses the P-521
+ * curve.
+ *
+ * Returns: 0 if ECC public key does not use P521 curve.
+ *          1 if ECC public key uses P521 curve.
+ *         -1 on error.
+ */
+int qcrypto_x509_check_ecc_curve_p521(uint8_t *cert, size_t size, Error **errp);
+
 #endif
-- 
2.54.0


