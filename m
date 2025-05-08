Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96085C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDA5F-00040t-Tx; Thu, 08 May 2025 18:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5E-00040d-3H; Thu, 08 May 2025 18:51:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA5B-0006RG-7i; Thu, 08 May 2025 18:51:15 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548Isal5025860;
 Thu, 8 May 2025 22:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=XMzsVFI1aBb9qC4ED
 XhwGWP6++mCu7WIX0gVrOxjS5Q=; b=lEDdfthL36TzJnXCD85teshLZUC30cOn6
 bsQOH2fu3UfaUAy27iE5YON7vqHrbsq+3tC1OJw5ibCoijudEcTs3qQrHCL71Kuo
 isKPAAoq4VbL04rJ5ePoe6KvGY2mIz+FLvwmvmG05y/U5TWL/SN2s9+luD+35MTU
 7zRIfoowvjEWloA0+NrXdmdTImadait9x+f9C1IRr9psY/7S25vdxb7NYskhqIf8
 LuXaZm0uSkwoNvjHT5RFPW3851Mfb8oUyO41IhUJsviazXug2UgTcDTO82+y+cO/
 y9WHkD+fujUVlCkX32/oO9tjMx3xTdayYoRds1V4RbuL7v19iG5jg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gthkbh9s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548MiKCR013769;
 Thu, 8 May 2025 22:51:09 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46e062qrep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:09 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 548Mp8RZ26477202
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 May 2025 22:51:08 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F359958055;
 Thu,  8 May 2025 22:51:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63E8B58059;
 Thu,  8 May 2025 22:51:06 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.11.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 May 2025 22:51:06 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v2 02/25] hw/s390x/ipl: Create certificate store
Date: Thu,  8 May 2025 18:50:18 -0400
Message-ID: <20250508225042.313672-3-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508225042.313672-1-zycai@linux.ibm.com>
References: <20250508225042.313672-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDIwNSBTYWx0ZWRfX5VUWoPP8PoAQ
 NAiUJCSzu3xt+J5wGnR/TIeEHI3Q5HPWe6Qq0yEq7alkQEf78scKGvMgumn1AkzH9qE7GPuh38g
 OzgqhyFqGrSh1EBV6Buq/zAx0pMHWM6cM4qL7HCAoj+Zeqe+ojQGahLPZRiyM8yhGQQFAyX8FDt
 1kehKosi6Tb/Ez+7YoWngtgU0SHUj+t7JJmqgQISSMFG7FTn++34Fp1cZZNEHNBWkjXwY8afp6c
 fri7bXkQr6kOzfAJbB75fXOlpTAol50VTn95+YEkjQVl9VQps4IKUBZYJIixatkqc1aWG2UTl0d
 sXUMuBorUnGjAEeePXrVmYjjfe6sV1etQ7nqoB30GqUjRPNazfe5Dn4wNMisYJDpqiHtde+ZJ6p
 aTz/VCPN3mPe5QL4rFs9S3DaoeVWuonLm1vfjA/l8ojvBB/GqvvY/0pVLiGhsOQBCGU+T609
X-Proofpoint-ORIG-GUID: cww_vvaDWlbSHkgE1_2vW90STjrnsOnP
X-Authority-Analysis: v=2.4 cv=PvCTbxM3 c=1 sm=1 tr=0 ts=681d355e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=XcWEwDmNAFxX--LxKZsA:9
X-Proofpoint-GUID: cww_vvaDWlbSHkgE1_2vW90STjrnsOnP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_07,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080205
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Create a certificate store for boot certificates used for secure IPL.

Load certificates from the -boot-certificate option into the cert store.

Currently, only x509 certificates in DER format and uses SHA-256 hashing
algorithm are supported, as these are the types required for secure boot
on s390.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 crypto/meson.build          |   5 +-
 crypto/x509-utils.c         | 163 ++++++++++++++++++++++++
 hw/s390x/cert-store.c       | 242 ++++++++++++++++++++++++++++++++++++
 hw/s390x/cert-store.h       |  39 ++++++
 hw/s390x/ipl.c              |   9 ++
 hw/s390x/ipl.h              |   3 +
 hw/s390x/meson.build        |   1 +
 include/crypto/x509-utils.h |   6 +
 include/hw/s390x/ipl/qipl.h |   3 +
 qapi/crypto.json            |  80 ++++++++++++
 10 files changed, 547 insertions(+), 4 deletions(-)
 create mode 100644 hw/s390x/cert-store.c
 create mode 100644 hw/s390x/cert-store.h

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
index 8bad00a51b..0b8cfc9022 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -11,6 +11,12 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "crypto/x509-utils.h"
+
+/*
+ * Surround with GNUTLS marco to ensure the interfaces are
+ * still available when GNUTLS is not enabled.
+ */
+#ifdef CONFIG_GNUTLS
 #include <gnutls/gnutls.h>
 #include <gnutls/crypto.h>
 #include <gnutls/x509.h>
@@ -25,6 +31,94 @@ static const int qcrypto_to_gnutls_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
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
+int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
+                                 QCryptoCertFmt fmt, Error **errp)
+{
+    int rc;
+    int ret = 0;
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
+        goto cleanup;
+    }
+
+    rc = gnutls_x509_crt_import(crt, &datum, qcrypto_to_gnutls_cert_fmt_map[fmt]);
+    if (rc == GNUTLS_E_ASN1_TAG_ERROR) {
+        ret = 0;
+        goto cleanup;
+    }
+
+    ret = 1;
+
+cleanup:
+    gnutls_x509_crt_deinit(crt);
+    return ret;
+}
+
+static int qcrypto_get_x509_cert_fmt(uint8_t *cert, size_t size, Error **errp)
+{
+    int fmt;
+
+    if (qcrypto_check_x509_cert_fmt(cert, size, QCRYPTO_CERT_FMT_DER, errp)) {
+        fmt = GNUTLS_X509_FMT_DER;
+    } else if (qcrypto_check_x509_cert_fmt(cert, size, QCRYPTO_CERT_FMT_PEM, errp)) {
+        fmt = GNUTLS_X509_FMT_PEM;
+    } else {
+        return -1;
+    }
+
+    return fmt;
+}
+
+int qcrypto_get_x509_hash_len(QCryptoHashAlgo alg, Error **errp)
+{
+    if (alg >= G_N_ELEMENTS(qcrypto_to_gnutls_hash_alg_map)) {
+        error_setg(errp, "Unknown hash algorithm");
+        return 0;
+    }
+
+    return gnutls_hash_get_len(qcrypto_to_gnutls_hash_alg_map[alg]);
+}
+
+int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag, Error **errp)
+{
+    QCryptoHashAlgo alg;
+
+    if (flag >= G_N_ELEMENTS(qcrypto_to_gnutls_keyid_flags_map)) {
+        error_setg(errp, "Unknown key id flag");
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
+    return qcrypto_get_x509_hash_len(alg, errp);
+}
+
 int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
                                       QCryptoHashAlgo alg,
                                       uint8_t *result,
@@ -74,3 +168,72 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
     gnutls_x509_crt_deinit(crt);
     return ret;
 }
+
+int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **errp)
+{
+    int rc = -1;
+    gnutls_x509_crt_t crt;
+    gnutls_datum_t datum = {.data = cert, .size = size};
+    gnutls_x509_crt_fmt_t fmt;
+
+    fmt = qcrypto_get_x509_cert_fmt(cert, size, errp);
+    if (fmt == -1) {
+        error_setg(errp, "Certificate is neither in DER or PEM format");
+        return rc;
+    }
+
+    if (gnutls_x509_crt_init(&crt) < 0) {
+        error_setg(errp, "Failed to initialize certificate");
+        return rc;
+    }
+
+    if (gnutls_x509_crt_import(crt, &datum, fmt) != 0) {
+        error_setg(errp, "Failed to import certificate");
+        goto cleanup;
+    }
+
+    rc = gnutls_x509_crt_get_signature_algorithm(crt);
+
+cleanup:
+    gnutls_x509_crt_deinit(crt);
+    return rc;
+}
+
+#else /* ! CONFIG_GNUTLS */
+
+int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
+                                 QCryptoCertFmt fmt, Error **errp)
+{
+    error_setg(errp, "To get certificate format requires GNUTLS");
+    return -ENOTSUP;
+}
+
+int qcrypto_get_x509_hash_len(QCryptoHashAlgo alg, Error **errp)
+{
+    error_setg(errp, "To get hash length requires GNUTLS");
+    return -ENOTSUP;
+}
+
+int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag, Error **errp)
+{
+    error_setg(errp, "To get key ID length requires GNUTLS");
+    return -ENOTSUP;
+}
+
+int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
+                                      QCryptoHashAlgo hash,
+                                      uint8_t *result,
+                                      size_t *resultlen,
+                                      Error **errp)
+{
+    error_setg(errp, "To get fingerprint requires GNUTLS");
+    return -ENOTSUP;
+}
+
+int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **errp)
+{
+    error_setg(errp, "To get signature algorithm requires GNUTLS");
+    return -ENOTSUP;
+}
+
+#endif /* ! CONFIG_GNUTLS */
diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
new file mode 100644
index 0000000000..87bf9e381d
--- /dev/null
+++ b/hw/s390x/cert-store.c
@@ -0,0 +1,242 @@
+/*
+ * S390 certificate store implementation
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "cert-store.h"
+#include "qemu/error-report.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
+#include "hw/s390x/ebcdic.h"
+#include "hw/s390x/s390-virtio-ccw.h"
+#include "qemu/cutils.h"
+#include "crypto/x509-utils.h"
+
+static const char *s390_get_boot_certificates(void)
+{
+    return S390_CCW_MACHINE(qdev_get_machine())->boot_certificates;
+}
+
+static size_t cert2buf(char *path, size_t max_size, char **cert_buf)
+{
+    size_t size;
+    g_autofree char *buf;
+
+    /*
+     * maximum allowed size of the certificate file to avoid consuming excessive memory
+     * (malformed or maliciously large files)
+     */
+    if (!g_file_get_contents(path, &buf, &size, NULL) ||
+        size == 0 || size > max_size) {
+        return 0;
+    }
+
+    *cert_buf = g_steal_pointer(&buf);
+
+    return size;
+}
+
+static S390IPLCertificate *init_cert_x509_der(size_t size, char *raw)
+{
+    S390IPLCertificate *q_cert = NULL;
+    int key_id_size;
+    int hash_size;
+    int is_der;
+    int hash_type;
+    Error *err = NULL;
+
+    is_der = qcrypto_check_x509_cert_fmt((uint8_t *)raw, size,
+                                         QCRYPTO_CERT_FMT_DER, &err);
+    /* return early if GNUTLS is not enabled */
+    if (is_der == -ENOTSUP) {
+        error_report("GNUTLS is not enabled");
+        return q_cert;
+    }
+    if (!is_der) {
+        error_report("The certificate is not in DER format");
+        return q_cert;
+    }
+
+    hash_type = qcrypto_get_x509_signature_algorithm((uint8_t *)raw, size, &err);
+    if (hash_type != QCRYPTO_SIG_ALGO_RSA_SHA256) {
+        error_report("The certificate does not use SHA-256 hashing");
+        return q_cert;
+    }
+
+    key_id_size = qcrypto_get_x509_keyid_len(QCRYPTO_KEYID_FLAGS_SHA256, &err);
+    if (key_id_size == 0) {
+        error_report("Failed to get certificate key ID size");
+        return q_cert;
+    }
+
+    hash_size = qcrypto_get_x509_hash_len(QCRYPTO_HASH_ALGO_SHA256, &err);
+    if (hash_size == 0) {
+        error_report("Failed to get certificate hash size");
+        return q_cert;
+    }
+
+    q_cert = g_new(S390IPLCertificate, 1);
+    q_cert->size = size;
+    q_cert->key_id_size = key_id_size;
+    q_cert->hash_size = hash_size;
+    q_cert->raw = raw;
+    q_cert->format = QCRYPTO_CERT_FMT_DER;
+    q_cert->hash_type = QCRYPTO_SIG_ALGO_RSA_SHA256;
+
+    return q_cert;
+}
+
+static int check_path_type(const char *path)
+{
+    struct stat path_stat;
+
+    if (stat(path, &path_stat) != 0) {
+        perror("stat");
+        return -1;
+    }
+
+    if (S_ISDIR(path_stat.st_mode)) {
+        return S_IFDIR;
+    } else if (S_ISREG(path_stat.st_mode)) {
+        return S_IFREG;
+    } else {
+        return -1;
+    }
+}
+
+static S390IPLCertificate *init_cert(char *paths)
+{
+    char *buf;
+    char vc_name[VC_NAME_LEN_BYTES];
+    g_autofree gchar *filename;
+    size_t size;
+    S390IPLCertificate *qcert = NULL;
+
+    filename = g_path_get_basename(paths);
+
+    size = cert2buf(paths, CERT_MAX_SIZE, &buf);
+    if (size == 0) {
+        error_report("Failed to load certificate: %s", paths);
+        return qcert;
+    }
+
+    qcert = init_cert_x509_der(size, buf);
+    if (qcert == NULL) {
+        error_report("Failed to initialize certificate: %s", paths);
+        g_free(buf);
+        return qcert;
+    }
+
+    /*
+     * Left justified certificate name with padding on the right with blanks.
+     * Convert certificate name to EBCDIC.
+     */
+    strpadcpy(vc_name, VC_NAME_LEN_BYTES, filename, ' ');
+    ebcdic_put(qcert->vc_name, vc_name, VC_NAME_LEN_BYTES);
+
+    return qcert;
+}
+
+static void update_cert_store(S390IPLCertificateStore *cert_store,
+                              S390IPLCertificate *qcert)
+{
+    size_t data_buf_size;
+    size_t keyid_buf_size;
+    size_t hash_buf_size;
+    size_t cert_buf_size;
+
+    /* length field is word aligned for later DIAG use */
+    keyid_buf_size = ROUND_UP(qcert->key_id_size, 4);
+    hash_buf_size = ROUND_UP(qcert->hash_size, 4);
+    cert_buf_size = ROUND_UP(qcert->size, 4);
+    data_buf_size = keyid_buf_size + hash_buf_size + cert_buf_size;
+
+    if (cert_store->max_cert_size < data_buf_size) {
+        cert_store->max_cert_size = data_buf_size;
+    }
+
+    cert_store->certs[cert_store->count] = *qcert;
+    cert_store->total_bytes += data_buf_size;
+    cert_store->count++;
+}
+
+static GPtrArray *get_cert_paths(void)
+{
+    const char *path;
+    gchar **paths;
+    gchar **paths_copy;
+    int path_type;
+    GDir *dir = NULL;
+    gchar *cert_path;
+    const gchar *filename;
+    GPtrArray *cert_path_builder;
+
+    cert_path_builder = g_ptr_array_new();
+
+    path = s390_get_boot_certificates();
+    if (path == NULL) {
+        return cert_path_builder;
+    }
+
+    paths = g_strsplit(path, ":", -1);
+    /* save the original pointer for freeing later */
+    paths_copy = paths;
+    while (*paths) {
+        /* skip empty certificate path */
+        if (!strcmp(*paths, "")) {
+            paths += 1;
+            continue;
+        }
+
+        cert_path = NULL;
+        path_type = check_path_type(*paths);
+        if (path_type == S_IFREG) {
+            cert_path = g_strdup(*paths);
+            g_ptr_array_add(cert_path_builder, cert_path);
+        } else if (path_type == S_IFDIR) {
+            dir = g_dir_open(*paths, 0, NULL);
+
+            if (dir) {
+                while ((filename = g_dir_read_name(dir))) {
+                    cert_path = g_build_filename(*paths, filename, NULL);
+                    g_ptr_array_add(cert_path_builder, (gpointer) cert_path);
+                }
+
+                g_dir_close(dir);
+            }
+        }
+
+        paths += 1;
+    }
+
+    g_strfreev(paths_copy);
+    return cert_path_builder;
+}
+
+void s390_ipl_create_cert_store(S390IPLCertificateStore *cert_store)
+{
+    GPtrArray *cert_path_builder;
+
+    cert_path_builder = get_cert_paths();
+    if (cert_path_builder->len == 0) {
+        g_ptr_array_free(cert_path_builder, true);
+        return;
+    }
+
+    cert_store->max_cert_size = 0;
+    cert_store->total_bytes = 0;
+
+    for (int i = 0; i < cert_path_builder->len; i++) {
+        S390IPLCertificate *qcert = init_cert((char *) cert_path_builder->pdata[i]);
+        if (qcert) {
+            update_cert_store(cert_store, qcert);
+        }
+    }
+
+    g_ptr_array_free(cert_path_builder, true);
+}
diff --git a/hw/s390x/cert-store.h b/hw/s390x/cert-store.h
new file mode 100644
index 0000000000..04acc6c2e0
--- /dev/null
+++ b/hw/s390x/cert-store.h
@@ -0,0 +1,39 @@
+/*
+ * S390 certificate store
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_S390_CERT_STORE_H
+#define HW_S390_CERT_STORE_H
+
+#include "hw/s390x/ipl/qipl.h"
+#include "crypto/x509-utils.h"
+
+#define VC_NAME_LEN_BYTES  64
+
+struct S390IPLCertificate {
+    uint8_t vc_name[VC_NAME_LEN_BYTES];
+    size_t size;
+    size_t key_id_size;
+    size_t hash_size;
+    char *raw;
+    QCryptoCertFmt format;
+    QCryptoSigAlgo hash_type;
+};
+typedef struct S390IPLCertificate S390IPLCertificate;
+
+struct S390IPLCertificateStore {
+    uint16_t count;
+    size_t max_cert_size;
+    size_t total_bytes;
+    S390IPLCertificate certs[MAX_CERTIFICATES];
+} QEMU_PACKED;
+typedef struct S390IPLCertificateStore S390IPLCertificateStore;
+
+void s390_ipl_create_cert_store(S390IPLCertificateStore *cert_store);
+
+#endif
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 2f082396c7..186be923d7 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -35,6 +35,7 @@
 #include "qemu/option.h"
 #include "qemu/ctype.h"
 #include "standard-headers/linux/virtio_ids.h"
+#include "cert-store.h"
 
 #define KERN_IMAGE_START                0x010000UL
 #define LINUX_MAGIC_ADDR                0x010008UL
@@ -422,6 +423,13 @@ void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
     }
 }
 
+S390IPLCertificateStore *s390_ipl_get_certificate_store(void)
+{
+    S390IPLState *ipl = get_ipl_device();
+
+    return &ipl->cert_store;
+}
+
 static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
 {
     CcwDevice *ccw_dev = NULL;
@@ -717,6 +725,7 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
 
     if (!ipl->kernel || ipl->iplb_valid) {
         cpu->env.psw.addr = ipl->bios_start_addr;
+        s390_ipl_create_cert_store(&ipl->cert_store);
         if (!ipl->iplb_valid) {
             ipl->iplb_valid = s390_init_all_iplbs(ipl);
         } else {
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 505cded490..ac1f7517ea 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -13,6 +13,7 @@
 #ifndef HW_S390_IPL_H
 #define HW_S390_IPL_H
 
+#include "cert-store.h"
 #include "cpu.h"
 #include "exec/target_page.h"
 #include "system/address-spaces.h"
@@ -35,6 +36,7 @@ int s390_ipl_pv_unpack(struct S390PVResponse *pv_resp);
 void s390_ipl_prepare_cpu(S390CPU *cpu);
 IplParameterBlock *s390_ipl_get_iplb(void);
 IplParameterBlock *s390_ipl_get_iplb_pv(void);
+S390IPLCertificateStore *s390_ipl_get_certificate_store(void);
 
 enum s390_reset {
     /* default is a reset not triggered by a CPU e.g. issued by QMP */
@@ -63,6 +65,7 @@ struct S390IPLState {
     IplParameterBlock iplb;
     IplParameterBlock iplb_pv;
     QemuIplParameters qipl;
+    S390IPLCertificateStore cert_store;
     uint64_t start_addr;
     uint64_t compat_start_addr;
     uint64_t bios_start_addr;
diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index 11e4e78b85..5b02f47155 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -17,6 +17,7 @@ s390x_ss.add(files(
   'sclpcpu.c',
   'sclpquiesce.c',
   'tod.c',
+  'cert-store.c',
 ))
 s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
   'tod-kvm.c',
diff --git a/include/crypto/x509-utils.h b/include/crypto/x509-utils.h
index 1e99661a71..8fb263b9e1 100644
--- a/include/crypto/x509-utils.h
+++ b/include/crypto/x509-utils.h
@@ -19,4 +19,10 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
                                       size_t *resultlen,
                                       Error **errp);
 
+int qcrypto_check_x509_cert_fmt(uint8_t *cert, size_t size,
+                                 QCryptoCertFmt fmt, Error **errp);
+int qcrypto_get_x509_hash_len(QCryptoHashAlgo alg, Error **errp);
+int qcrypto_get_x509_keyid_len(QCryptoKeyidFlags flag, Error **errp);
+int qcrypto_get_x509_signature_algorithm(uint8_t *cert, size_t size, Error **errp);
+
 #endif
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 6824391111..b8e7d1da71 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -20,6 +20,9 @@
 #define LOADPARM_LEN    8
 #define NO_LOADPARM "\0\0\0\0\0\0\0\0"
 
+#define MAX_CERTIFICATES 64
+#define CERT_MAX_SIZE     (1024 * 8)
+
 /*
  * The QEMU IPL Parameters will be stored at absolute address
  * 204 (0xcc) which means it is 32-bit word aligned but not
diff --git a/qapi/crypto.json b/qapi/crypto.json
index c9d967d782..2bbf29affe 100644
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
+# Since: 9.2
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
+# Since: 9.2
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
+# Since: 9.2
+##
+{ 'enum': 'QCryptoSigAlgo',
+  'data': ['unknown', 'rsa-sha1', 'dsa-sha1',
+           'rsa-md5', 'rsa-md2', 'rsa-rmd160',
+           'rsa-sha256', 'rsa-sha384', 'rsa-sha512', 'rsa-sha224',
+           'dsa-sha224', 'dsa-sha256',
+           'ecdsa-sha1', 'ecdsa-sha224', 'ecdsa-sha256', 'ecdsa-sha384', 'ecdsa-sha512']}
-- 
2.49.0


