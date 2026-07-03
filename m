Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2A8C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhGT-0007hj-AU; Fri, 03 Jul 2026 13:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhGO-0007gu-TO; Fri, 03 Jul 2026 13:01:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfhGL-00033u-1i; Fri, 03 Jul 2026 13:01:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIbgd3302552; Fri, 3 Jul 2026 17:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=vZ6XjVwKJ57vr6VLp
 DkiPjHiiY2cc54kZG6p99I4YVs=; b=Ui2JbTdiHJx+t9/Mq/U3hETA4iUHDJr5y
 oKIGiuSq2Y+k4piX4otJSGhxTfoUF7gHp8DcVshF6ofMFeuwvAxplwwC/2nV5qs7
 2XgWuwg1tb5jMwNSQtIpN0z/c2iDff1wJzu7aF1kc+cPJ5FE1jU/Gikzmscs8KfW
 /k1WIQu0Gq+TO91KMr1iTo2h0Tm31itXn1DQ/D6lpHKMfkE+tJ82x2hd/icF3En6
 OvemGijHwm5l/7sQgL5ZeTZGLnPJRySCXRf1SjG9BZHVpLXOoMPgBdt5hJBy1u+6
 Ut9gHWx/wltFaVXR4zpJS1eJxFu0Agn7rtJ4bT8kamnwWeNoNOo6g==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n688w9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:01:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 663Gngvq003089;
 Fri, 3 Jul 2026 17:01:07 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhsnd0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 17:01:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 663H15KT13173458
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 17:01:06 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D39345805F;
 Fri,  3 Jul 2026 17:01:05 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAD2758054;
 Fri,  3 Jul 2026 17:01:02 +0000 (GMT)
Received: from fedora-workstation.lan (unknown [9.61.75.28])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 17:01:02 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, armbru@redhat.com, zycai@linux.ibm.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
Subject: [PATCH v14 09/33] s390x/diag: Implement DIAG 320 subcode 2
Date: Fri,  3 Jul 2026 13:00:06 -0400
Message-ID: <20260703170032.1893204-10-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703170032.1893204-1-zycai@linux.ibm.com>
References: <20260703170032.1893204-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX6BSj3NtdRVNH
 Db5Ac5wmpvIs6nfLfpVG6u2+oUPfG/PV4i+lJwUJuEMd7B+j8Z49JTiAvrGioCgUKrrX0lYrJ+J
 GA7NW5EE3f0YFl79RfYtI3rZdSQe7VOBkVmGZE5TX0vLFwFxnj37TmxtdjqGl5ZL9egcqfWSqjo
 BBOHFAC9O9xZ87QpQJ/XRabSzno1Wicflt+2+MaWdZCzvTjwVbPy9pdSr69We8ceaMnGlTMUOHl
 CvZt0k/1027VruVNrJYeenw/PGQszJlB7BgDXy96pLn0BMv1CdG8yHGsxI9QAoYXcDKDvrh1nSK
 Qx3LPHz/QE+rfPhvm4UYClG15isQ0dwkkhp6X9OzSeSijr9CKKjONpO0h7qoRIV3wOMUClP4e9s
 hLZU3/od63JCBV68hpCSwR+ktNIzZPFw+viVyqW2HsUKoGHmu4MKQaM6YasQu/ky3+rGBl/msgG
 BTllKE2DXPTbsmjXypQ==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a47ead4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=yb4F8fGd1MjoyQfLk7gA:9
X-Proofpoint-ORIG-GUID: TUOhPHvgazEHCpfl0f5UCVcrXLagvc0A
X-Proofpoint-GUID: TUOhPHvgazEHCpfl0f5UCVcrXLagvc0A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NyBTYWx0ZWRfX0QTpd7UhznQG
 uO7RGmxR0VAskWc1uXbriMMN8l0LJdEMblpquwDfZDnuMnlOAc44ab/w4nAbfVh7AliF0q1QmSQ
 YFi/WBfCW/alaLeVBVZyp7Cm4dOlEvs=
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

DIAG 320 subcode 2 provides verification-certificates (VCs) that are in the
certificate store. Only X509 certificates in DER format and SHA-256 hash
type are recognized.

The subcode value is denoted by setting the second-left-most bit
of an 8-byte field.

The Verification Certificate Block (VCB) contains the output data
when the operation completes successfully. It includes a common
header followed by zero or more Verification Certificate Entries (VCEs),
depending on the VCB input length and the VC range (from the first VC
index to the last VC index) in the certificate store.

Each VCE contains information about a certificate retrieved from
the S390IPLCertificateStore, such as the certificate name, key type,
key ID length, hash length, and the raw certificate data.
The key ID and hash are extracted from the raw certificate by the crypto API.

Note: SHA2-256 VC hash type is required for retrieving the hash
(fingerprint) of the certificate.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
---
 docs/specs/s390x-secure-ipl.rst |  24 +++
 include/hw/s390x/ipl/diag320.h  |  38 ++++
 target/s390x/diag.c             | 316 +++++++++++++++++++++++++++++++-
 3 files changed, 377 insertions(+), 1 deletion(-)

diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
index d5d4c3a24d..a17bb0ab55 100644
--- a/docs/specs/s390x-secure-ipl.rst
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -42,3 +42,27 @@ Subcode 1 - query verification certificate storage information
     The output is returned in the verification-certificate-storage-size block
     (VCSSB). A VCSSB length of 4 indicates that no certificates are available
     in the CS.
+
+Subcode 2 - store verification certificates
+    Provides VCs that are in the certificate store.
+
+    The output is provided in a VCB, which includes a common header followed by
+    zero or more verification-certificate entries (VCEs).
+
+    The instruction expects the cert store to maintain an origin of 1 for the
+    index (i.e. a retrieval of the first certificate in the store should be
+    denoted by setting first-VC to 1).
+
+    The first-VC and last-VC fields of the VCB specify the index range of
+    VCs to be stored in the VCB. Certs are stored sequentially, starting
+    with first-VC index. As each cert is stored, a "stored count" is
+    incremented. If there is not enough space to store all certs requested
+    by the index range, a "remaining count" will be recorded and no more
+    certificates will be stored.
+
+    Each VCE contains a header followed by information extracted from a
+    certificate within the certificate store. The information includes:
+    key-id, hash, and certificate data. This information is stored
+    contiguously in a VCE (with zero-padding). Following the header, the
+    key-id is immediately stored. The hash and certificate data follow and
+    may be accessed via the respective offset fields stored in the VCE.
diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
index d37d8eaa86..7fda2d44fd 100644
--- a/include/hw/s390x/ipl/diag320.h
+++ b/include/hw/s390x/ipl/diag320.h
@@ -12,19 +12,45 @@
 
 #define DIAG_320_SUBC_QUERY_ISM     0
 #define DIAG_320_SUBC_QUERY_VCSI    1
+#define DIAG_320_SUBC_STORE_VC      2
 
 #define DIAG_320_RC_OK              0x0001
 #define DIAG_320_RC_NOT_SUPPORTED   0x0102
 #define DIAG_320_RC_INVAL_VCSSB_LEN 0x0202
+#define DIAG_320_RC_INVAL_VCB_LEN   0x0204
+#define DIAG_320_RC_BAD_RANGE       0x0302
 
 #define DIAG_320_ISM_QUERY_SUBCODES 0x80000000
 #define DIAG_320_ISM_QUERY_VCSI     0x40000000
+#define DIAG_320_ISM_STORE_VC       0x20000000
 
 #define VCSSB_NO_VC     4
 #define VCSSB_LEN_VALID   128
 
 #define CERT_NAME_MAX_LEN  64
 
+/*
+ * If the VCE flags indicate an invalid certificate,
+ * the VCE length is set to 72, containing only the
+ * first five fields of VCEntry.
+ */
+#define VCE_INVALID_LEN 72
+
+#define DIAG_320_VCE_FLAGS_VALID                0x80
+
+typedef enum Diag320VceKeyType {
+    DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING = 0,
+    DIAG_320_VCE_KEYTYPE_ECDSA_P521 = 1,
+} Diag320VceKeyType;
+
+typedef enum Diag320VceFormat {
+    DIAG_320_VCE_FORMAT_X509_DER = 1,
+} Diag320VceFormat;
+
+typedef enum Diag320VceHashType {
+    DIAG_320_VCE_HASHTYPE_SHA2_256 = 1,
+} Diag320VceHashType;
+
 struct VCStorageSizeBlock {
     uint32_t length;
     uint8_t reserved0[3];
@@ -60,6 +86,12 @@ struct VCEntryHeader {
 };
 typedef struct VCEntryHeader VCEntryHeader;
 
+struct VCEntry {
+    VCEntryHeader vce_hdr;
+    uint8_t cert_buf[];
+};
+typedef struct VCEntry VCEntry;
+
 struct VCBlockHeader {
     uint32_t in_len;
     uint32_t reserved0;
@@ -74,4 +106,10 @@ struct VCBlockHeader {
 };
 typedef struct VCBlockHeader VCBlockHeader;
 
+struct VCBlock {
+    VCBlockHeader vcb_hdr;
+    uint8_t vce_buf[];
+};
+typedef struct VCBlock VCBlock;
+
 #endif
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index 228956ab13..c072daca3a 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -17,13 +17,16 @@
 #include "s390x-internal.h"
 #include "hw/watchdog/wdt_diag288.h"
 #include "system/cpus.h"
+#include "hw/s390x/cert-store.h"
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/ipl/diag320.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "system/kvm.h"
 #include "kvm/kvm_s390x.h"
 #include "target/s390x/kvm/pv.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "crypto/x509-utils.h"
 
 
 static inline bool diag_parm_addr_valid(uint64_t addr, size_t size, bool write)
@@ -241,8 +244,306 @@ static int handle_diag320_query_vcsi(S390CPU *cpu, uint64_t addr, uint64_t r1,
     return DIAG_320_RC_OK;
 }
 
+static bool is_cert_valid(const S390IPLCertificate *cert)
+{
+    int rc;
+    Error *err = NULL;
+
+    rc = qcrypto_x509_check_cert_times(cert->raw, cert->size, &err);
+    if (rc != 0) {
+        error_report_err(err);
+        return false;
+    }
+
+    return true;
+}
+
+static int handle_key_id(VCEntry *vce, const S390IPLCertificate *cert)
+{
+    int rc;
+    g_autofree unsigned char *key_id_data = NULL;
+    size_t key_id_len;
+    Error *err = NULL;
+
+    rc = qcrypto_x509_get_cert_key_id(cert->raw, cert->size,
+                                      QCRYPTO_HASH_ALGO_SHA256,
+                                      &key_id_data, &key_id_len, &err);
+    if (rc < 0) {
+        error_report_err(err);
+        return 0;
+    }
+
+    if (sizeof(VCEntryHeader) + key_id_len > be32_to_cpu(vce->vce_hdr.len)) {
+        error_report("Unable to write key ID: exceeds buffer bounds");
+        return 0;
+    }
+
+    vce->vce_hdr.keyid_len = cpu_to_be16(key_id_len);
+
+    memcpy(vce->cert_buf, key_id_data, key_id_len);
+
+    return ROUND_UP(key_id_len, 4);
+}
+
+static int handle_hash(VCEntry *vce, const S390IPLCertificate *cert,
+                       uint16_t keyid_field_len)
+{
+    int rc;
+    uint16_t hash_offset;
+    g_autofree void *hash_data = NULL;
+    size_t hash_len;
+    Error *err = NULL;
+
+    hash_len = CERT_HASH_LEN;
+    hash_data = g_malloc0(hash_len);
+    rc = qcrypto_get_x509_cert_fingerprint(cert->raw, cert->size,
+                                           QCRYPTO_HASH_ALGO_SHA256,
+                                           hash_data, &hash_len, &err);
+    if (rc < 0) {
+        error_report_err(err);
+        return 0;
+    }
+
+    hash_offset = sizeof(VCEntryHeader) + keyid_field_len;
+    if (hash_offset + hash_len > be32_to_cpu(vce->vce_hdr.len)) {
+        error_report("Unable to write hash: exceeds buffer bounds");
+        return 0;
+    }
+
+    vce->vce_hdr.hash_len = cpu_to_be16(hash_len);
+    vce->vce_hdr.hash_type = DIAG_320_VCE_HASHTYPE_SHA2_256;
+    vce->vce_hdr.hash_offset = cpu_to_be16(hash_offset);
+
+    memcpy((uint8_t *)vce + hash_offset, hash_data, hash_len);
+
+    return ROUND_UP(hash_len, 4);
+}
+
+static int handle_cert(VCEntry *vce, const S390IPLCertificate *cert,
+                       uint16_t hash_field_len)
+{
+    int rc;
+    uint16_t cert_offset;
+    g_autofree uint8_t *cert_der = NULL;
+    size_t der_size;
+    Error *err = NULL;
+
+    rc = qcrypto_x509_convert_cert_der(cert->raw, cert->size,
+                                       &cert_der, &der_size, &err);
+    if (rc < 0) {
+        error_report_err(err);
+        return 0;
+    }
+
+    cert_offset = be16_to_cpu(vce->vce_hdr.hash_offset) + hash_field_len;
+    if (cert_offset + der_size > be32_to_cpu(vce->vce_hdr.len)) {
+        error_report("Unable to write certificate: exceeds buffer bounds");
+        return 0;
+    }
+
+    vce->vce_hdr.format = DIAG_320_VCE_FORMAT_X509_DER;
+    vce->vce_hdr.cert_len = cpu_to_be32(der_size);
+    vce->vce_hdr.cert_offset = cpu_to_be16(cert_offset);
+
+    memcpy((uint8_t *)vce + cert_offset, cert_der, der_size);
+
+    return ROUND_UP(der_size, 4);
+}
+
+static int get_key_type(const S390IPLCertificate *cert)
+{
+    int rc;
+    Error *err = NULL;
+
+    rc = qcrypto_x509_check_ecc_curve_p521(cert->raw, cert->size, &err);
+    if (rc == -1) {
+        error_report_err(err);
+        return -1;
+    }
+
+    return (rc == 1) ? DIAG_320_VCE_KEYTYPE_ECDSA_P521 :
+                       DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING;
+}
+
+static int build_vce_header(VCEntry *vce, const S390IPLCertificate *cert, int idx)
+{
+    int key_type;
+
+    vce->vce_hdr.len = cpu_to_be32(sizeof(VCEntryHeader));
+    vce->vce_hdr.cert_idx = cpu_to_be16(idx + 1);
+    memcpy(vce->vce_hdr.name, cert->name, CERT_NAME_MAX_LEN);
+
+    if (!is_cert_valid(cert)) {
+        return -1;
+    }
+
+    key_type = get_key_type(cert);
+    if (key_type == -1) {
+        return -1;
+    }
+    vce->vce_hdr.key_type = key_type;
+
+    return 0;
+}
+
+static int build_vce_data(VCEntry *vce, const S390IPLCertificate *cert,
+                          uint32_t vce_max_len)
+{
+    uint16_t keyid_field_len;
+    uint16_t hash_field_len;
+    uint32_t cert_field_len;
+    uint32_t vce_len;
+
+    vce->vce_hdr.len = cpu_to_be32(vce_max_len);
+
+    keyid_field_len = handle_key_id(vce, cert);
+    if (!keyid_field_len) {
+        return -1;
+    }
+
+    hash_field_len = handle_hash(vce, cert, keyid_field_len);
+    if (!hash_field_len) {
+        return -1;
+    }
+
+    cert_field_len = handle_cert(vce, cert, hash_field_len);
+    if (!cert_field_len) {
+        return -1;
+    }
+
+    vce_len = sizeof(VCEntryHeader) + keyid_field_len + hash_field_len + cert_field_len;
+    if (vce_len > vce_max_len) {
+        return -1;
+    }
+
+    vce->vce_hdr.flags |= DIAG_320_VCE_FLAGS_VALID;
+
+    /* Update vce length to reflect the actual size used by vce */
+    vce->vce_hdr.len = cpu_to_be32(vce_len);
+
+    return 0;
+}
+
+static int handle_diag320_store_vc(S390CPU *cpu, uint64_t addr, uint64_t r1, uintptr_t ra,
+                                   S390IPLCertificateStore *cs)
+{
+    g_autofree VCBlockHeader *vcb_hdr = NULL;
+    size_t remaining_space;
+    uint16_t first_vc_index;
+    uint16_t last_vc_index;
+    int cs_start_index;
+    int cs_end_index;
+    uint32_t vce_max_len;
+    uint32_t vce_len;
+    uint32_t in_len;
+
+    vcb_hdr = g_new0(VCBlockHeader, 1);
+    if (s390_cpu_virt_mem_read(cpu, addr, r1, vcb_hdr, sizeof(*vcb_hdr))) {
+        s390_cpu_virt_mem_handle_exc(cpu, ra);
+        return -1;
+    }
+
+    in_len = be32_to_cpu(vcb_hdr->in_len);
+    first_vc_index = be16_to_cpu(vcb_hdr->first_vc_index);
+    last_vc_index = be16_to_cpu(vcb_hdr->last_vc_index);
+
+    if (in_len % TARGET_PAGE_SIZE != 0) {
+        return DIAG_320_RC_INVAL_VCB_LEN;
+    }
+
+    if (first_vc_index > last_vc_index) {
+        return DIAG_320_RC_BAD_RANGE;
+    }
+
+    vcb_hdr->out_len = sizeof(VCBlockHeader);
+
+    /*
+     * DIAG 320 subcode 2 expects to query a certificate store that
+     * maintains an index origin of 1. However, the S390IPLCertificateStore
+     * maintains an index origin of 0. Thus, the indices must be adjusted
+     * for correct access into the cert store. A couple of special cases
+     * must also be accounted for.
+     */
+
+    /* Both indices are 0; return header with no certs */
+    if (first_vc_index == 0 && last_vc_index == 0) {
+        goto out;
+    }
+
+    /* Normalize indices */
+    cs_start_index = (first_vc_index == 0) ? 0 : first_vc_index - 1;
+    cs_end_index = last_vc_index - 1;
+
+    /* Requested range is outside the cert store; return header with no certs */
+    if (cs_start_index >= cs->count || cs_end_index >= cs->count) {
+        goto out;
+    }
+
+    remaining_space = in_len - sizeof(VCBlockHeader);
+
+    for (int i = cs_start_index; i <= cs_end_index; i++) {
+        const S390IPLCertificate *cert = &cs->certs[i];
+        /*
+         * Each field of the VCE is word-aligned.
+         * Allocate enough space for the largest possible size for this VCE.
+         * As the certificate fields (key-id, hash, data) are parsed, the
+         * VCE's length field will be updated accordingly.
+         */
+        vce_max_len = sizeof(VCEntryHeader) + ROUND_UP(CERT_KEY_ID_LEN, 4) +
+                      ROUND_UP(CERT_HASH_LEN, 4) + ROUND_UP(cert->der_size, 4);
+        g_autofree VCEntry *vce = g_malloc0(vce_max_len);
+
+        /*
+         * Bit 0 of the VCE flags indicates whether the certificate is valid.
+         * The caller of DIAG320 subcode 2 is responsible for verifying that
+         * the VCE contains a valid certificate.
+         */
+        if (build_vce_header(vce, cert, i) || build_vce_data(vce, cert, vce_max_len)) {
+            /*
+             * Error occurs - VCE does not contain a valid certificate.
+             * Bit 0 of the VCE flags is 0 and the VCE length is set.
+             */
+            vce->vce_hdr.len = cpu_to_be32(VCE_INVALID_LEN);
+        }
+        vce_len = be32_to_cpu(vce->vce_hdr.len);
+
+        /*
+         * If there is no more space to store the cert,
+         * set the remaining verification cert count and
+         * break early.
+         */
+        if (remaining_space < vce_len) {
+            vcb_hdr->remain_ct = cpu_to_be16(last_vc_index - i);
+            break;
+        }
+
+        /* Write VCE */
+        if (s390_cpu_virt_mem_write(cpu, addr + vcb_hdr->out_len, r1, vce, vce_len)) {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
+            return -1;
+        }
+
+        vcb_hdr->out_len += vce_len;
+        remaining_space -= vce_len;
+        vcb_hdr->stored_ct++;
+    }
+    vcb_hdr->stored_ct = cpu_to_be16(vcb_hdr->stored_ct);
+
+out:
+    vcb_hdr->out_len = cpu_to_be32(vcb_hdr->out_len);
+
+    if (s390_cpu_virt_mem_write(cpu, addr, r1, vcb_hdr, sizeof(VCBlockHeader))) {
+        s390_cpu_virt_mem_handle_exc(cpu, ra);
+        return -1;
+    }
+
+    return DIAG_320_RC_OK;
+}
+
 QEMU_BUILD_BUG_MSG(sizeof(VCStorageSizeBlock) != VCSSB_LEN_VALID,
                    "size of VCStorageSizeBlock is wrong");
+QEMU_BUILD_BUG_MSG(sizeof(VCBlock) != 64, "size of VCBlock is wrong");
+QEMU_BUILD_BUG_MSG(sizeof(VCEntry) != 128, "size of VCEntry is wrong");
 
 void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
@@ -273,7 +574,8 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
          * for now.
          */
         uint32_t ism_word0 = cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES |
-                                         DIAG_320_ISM_QUERY_VCSI);
+                                         DIAG_320_ISM_QUERY_VCSI |
+                                         DIAG_320_ISM_STORE_VC);
 
         if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism_word0, sizeof(ism_word0))) {
             s390_cpu_virt_mem_handle_exc(cpu, ra);
@@ -299,6 +601,18 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
         }
         env->regs[r1 + 1] = rc;
         break;
+    case DIAG_320_SUBC_STORE_VC:
+        if (addr & ~TARGET_PAGE_MASK) {
+            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
+            return;
+        }
+
+        rc = handle_diag320_store_vc(cpu, addr, r1, ra, cs);
+        if (rc == -1) {
+            return;
+        }
+        env->regs[r1 + 1] = rc;
+        break;
     default:
         env->regs[r1 + 1] = DIAG_320_RC_NOT_SUPPORTED;
         break;
-- 
2.54.0


