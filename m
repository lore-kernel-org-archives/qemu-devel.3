Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682D4C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 02:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfTfI-0008Df-KN; Thu, 02 Jul 2026 22:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfTfG-0008CN-Kn; Thu, 02 Jul 2026 22:30:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfTfE-00038k-DY; Thu, 02 Jul 2026 22:30:02 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6631Iq6j1202808; Fri, 3 Jul 2026 02:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wQ+il+
 s9Xg/o08k/00pPOPcbrUnAgwjkgTF3VysbxK4=; b=XYryZGzIBc4PFS0skrPBgm
 Mm9TT7D9Q/XIDW+ARLzXSCLkHtjgNRXmzYRiROVvhNViIIN1WOUUL4FhJ8v9i/Ka
 P18LXc5V7vTrA0w4TnDbjQOuIjzvO9msLdFfrH3wcrbU8HkCMjOCcKPKs69qUGOC
 cmcmyZ282LybY22wurJ/1cCGwq9XOXLDfaFwGmsYGMYUV2KboJkAfyZieMLtIwv7
 U060SNez2zcX3AxN7yVt5uzP9S+bye4ZKeIQo3iU2crE7/r3j3bi3O/6ft4fAgxr
 FyUNY5i1yYLt8jRbop6gqfN2xtmPubwX5EFcrABO2qzneBLdJvnyTVsPdtFAhxIw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qacjsn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:29:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6632JvP2019581;
 Fri, 3 Jul 2026 02:29:56 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyph3b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:29:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6632TsKr16318992
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 02:29:54 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E81758056;
 Fri,  3 Jul 2026 02:29:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 232BD58052;
 Fri,  3 Jul 2026 02:29:52 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.151.121])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 02:29:52 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v13 08/33] crypto/x509-utils: Add helper functions for DIAG
 320 subcode 2
Date: Thu,  2 Jul 2026 22:29:06 -0400
Message-ID: <20260703022933.1805010-9-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703022933.1805010-1-zycai@linux.ibm.com>
References: <20260703022933.1805010-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAyMCBTYWx0ZWRfX8c4wTYjBNtzg
 TUX+KqRCujKT29Se0x/H1FL+fqgm4vXn+cP/POT9UHw6IuLl6wCw2e+eCRHvPqUWof/HJkwDs/z
 mgcok1HtkrFMFY+nCTIcu28Wh6LNoIAmWBFOY8U3cfTq2Jij4OYRh2fwnm5Pd3ve0lUPNFkBWwN
 k9z8P2kRG7jXAO7wOGLt5KjX04HyFa6YbUMf8JKHi1lLqnIJDKiZcD1NFT3+r1SAIYT6A+LFUea
 RtShUQp/1KC+0BPOlRKkSYzMFj66Ql6G4+8+Ga5ANmOeFUmNi6ZNuZOzE9jYBlsxr3Q/+To25vk
 rgG7o2ylIJ8gUlBa69i5W8JHJyZBM59ovfX8Fn+m1gdmojnPmdO+B1aH8/qHeUorm5AEaTzUxJL
 ELXKbtIkP8t00FQ9r3NZZ7UubS3Xgoo4eM58fF2a7U9c3aAyPBu8kE/9EMEMs01jSdu8U3NyAZ9
 iJRPHVnO+s8pAOsNvqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAyMCBTYWx0ZWRfX5pUoYGdZrLgv
 FgLIDzMy/n/8R34Ov8oRH0PWMxHYde6QT1xDfHv1MNPiiv0ag4wsVocINTv/VGZBjWP/brhjKP5
 y7RmPSFjiFOQ3dCCYn6VSqV+odMhkIY=
X-Proofpoint-GUID: FP9QiWn5GXfx0Ff3eCMHHwn2TCAVDRHl
X-Proofpoint-ORIG-GUID: FP9QiWn5GXfx0Ff3eCMHHwn2TCAVDRHl
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a471ea5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=cx8EP_J7U0ANkHmDKVUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
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
index 68cf008938..d0e0384e9c 100644
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
+        error_setg(errp, "Failed to get hash algorithm length: %s", gnutls_strerror(rc));
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
index 91ae79fb03..fcace73c49 100644
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
+ * Retrieve the key ID from the @cert based on the specified @hash_alg.
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


