Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A67BD6AAE7
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 22:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8QK2-0000nM-Gq; Thu, 02 Apr 2026 18:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1w8QK0-0000lk-BY; Thu, 02 Apr 2026 18:15:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1w8QJx-0004nY-PU; Thu, 02 Apr 2026 18:15:28 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 632E9KxD3843131; Thu, 2 Apr 2026 22:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=v1ZQVi8UvQVOhwDia
 Md0vew3OF15YZuhnxWIDW5x3+E=; b=ligYfTanSTb7B7IdRum66h9dgLTABzUnB
 2CsM9rEWwE44v3bTstMM+IJ7kP/5sId8OX+buAIrQVseD9chYJJGOD317/OVc+EF
 FeXY8SFU2r8mPZzzcQDQdyQZniuiflcOkXUfYfDrMz4z7LvA7ssg8xMn23ESZeSr
 YFa02AzAuVZUeaaN7vWpAlzvzwDhUAnge9ZZewh0NU2GAU9v7SMkwBQUXFOA/Si5
 Yme5cofMkE75deDaRomgxM3w9jrPThwEzE4UWYu42ONJiOB2bbOsuqXNGia++1iP
 gEiZMe6RG7gK2pH/mxvcSZvZo8LKjTAKuvlsYE9hkOW+W46npciJA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66msdtfr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 22:15:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632LZU19030955;
 Thu, 2 Apr 2026 22:15:20 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhk3rm3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 22:15:20 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 632MFJvf15467014
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2026 22:15:20 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D92A25806C;
 Thu,  2 Apr 2026 22:15:19 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7EF825806A;
 Thu,  2 Apr 2026 22:15:18 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.183.185])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2026 22:15:18 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com, jdaley@linux.ibm.com
Subject: [PATCH v10 09/30] s390x/diag: Implement DIAG 320 subcode 2
Date: Thu,  2 Apr 2026 18:14:31 -0400
Message-ID: <20260402221453.1602899-10-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402221453.1602899-1-zycai@linux.ibm.com>
References: <20260402221453.1602899-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69ceea79 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=P_7nqk-uq5PAz_mi5GAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE5NSBTYWx0ZWRfX8cc4xwhsaIYb
 +g6yO1fuLpqteF49k3sLXnNKvRBI0c7YXZYfB7bgJAt8tO+A9v63SLTXbRT+jHi0GHAFFMApE+U
 8Pto2VkAJfMems6ddUTYqYJGII/tRfpcMVTF3X+UnOnRScKU6gQuGje0gHXaRh+6qrtJioFhPOy
 ibojl0SQHsTJxiQGbxsvfeu/hpViR6aheeYW0aKyrQt1tQsILcD4T94NuTMuSby/OxoTH7EuWLb
 MNcYTnQl89O/UJpgWMQJO2dl6XupiaGT4m5XIaGNd1TDOz9DxjNoFiFepSLa47iUeUv1VX9824d
 b21ycl3dgqXulf3wPYdojXsD8q55gr3dsPSn0Dnytob8AEtxWSq01oNioLGpKwBoGXqOj//lOyd
 hsaZSNQqd+LAhvOSVCKENHiUyQplQHnJSFZHQiKYxLUAYK9GsTqj1pkq+fACtkuDthKYCWXyqkg
 KvUffavPvtHYrdHA6rg==
X-Proofpoint-GUID: nzcBBW00HfdNMW0MVOGCiCyf4YXB002Y
X-Proofpoint-ORIG-GUID: nzcBBW00HfdNMW0MVOGCiCyf4YXB002Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_04,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020195
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
---
 docs/specs/s390x-secure-ipl.rst |  24 +++
 hw/s390x/cert-store.h           |   3 +-
 include/hw/s390x/ipl/diag320.h  |  55 ++++++
 target/s390x/diag.c             | 338 +++++++++++++++++++++++++++++++-
 4 files changed, 417 insertions(+), 3 deletions(-)

diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
index 52661fab00..1a712a0e0c 100644
--- a/docs/specs/s390x-secure-ipl.rst
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -38,3 +38,27 @@ Subcode 1 - query verification certificate storage information
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
diff --git a/hw/s390x/cert-store.h b/hw/s390x/cert-store.h
index 7fc9503cb9..6f5ee63177 100644
--- a/hw/s390x/cert-store.h
+++ b/hw/s390x/cert-store.h
@@ -11,10 +11,9 @@
 #define HW_S390_CERT_STORE_H
 
 #include "hw/s390x/ipl/qipl.h"
+#include "hw/s390x/ipl/diag320.h"
 #include "crypto/x509-utils.h"
 
-#define CERT_NAME_MAX_LEN  64
-
 #define CERT_KEY_ID_LEN    QCRYPTO_HASH_DIGEST_LEN_SHA256
 #define CERT_HASH_LEN      QCRYPTO_HASH_DIGEST_LEN_SHA256
 
diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
index 6e4779c699..bfd6385b40 100644
--- a/include/hw/s390x/ipl/diag320.h
+++ b/include/hw/s390x/ipl/diag320.h
@@ -12,19 +12,37 @@
 
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
 #define VCSSB_MIN_LEN   128
 #define VCE_HEADER_LEN  128
+/*
+ * If the VCE flags indicate an invalid certificate,
+ * the VCE length is set to 72, containing only the
+ * first five fields of VCEntry.
+ */
+#define VCE_INVALID_LEN 72
 #define VCB_HEADER_LEN  64
 
+#define CERT_NAME_MAX_LEN  64
+
+#define DIAG_320_VCE_FLAGS_VALID                0x80
+#define DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING    0
+#define DIAG_320_VCE_KEYTYPE_ECDSA_P521         1
+#define DIAG_320_VCE_FORMAT_X509_DER            1
+#define DIAG_320_VCE_HASHTYPE_SHA2_256          1
+
 struct VCStorageSizeBlock {
     uint32_t length;
     uint8_t reserved0[3];
@@ -39,4 +57,41 @@ struct VCStorageSizeBlock {
 };
 typedef struct VCStorageSizeBlock VCStorageSizeBlock;
 
+struct VCBlock {
+    uint32_t in_len;
+    uint32_t reserved0;
+    uint16_t first_vc_index;
+    uint16_t last_vc_index;
+    uint32_t reserved1[5];
+    uint32_t out_len;
+    uint8_t reserved2[4];
+    uint16_t stored_ct;
+    uint16_t remain_ct;
+    uint32_t reserved3[5];
+    uint8_t vce_buf[];
+};
+typedef struct VCBlock VCBlock;
+
+struct VCEntry {
+    uint32_t len;
+    uint8_t flags;
+    uint8_t key_type;
+    uint16_t cert_idx;
+    uint8_t name[CERT_NAME_MAX_LEN];
+    uint8_t format;
+    uint8_t reserved0;
+    uint16_t keyid_len;
+    uint8_t reserved1;
+    uint8_t hash_type;
+    uint16_t hash_len;
+    uint32_t reserved2;
+    uint32_t cert_len;
+    uint32_t reserved3[2];
+    uint16_t hash_offset;
+    uint16_t cert_offset;
+    uint32_t reserved4[7];
+    uint8_t cert_buf[];
+};
+typedef struct VCEntry VCEntry;
+
 #endif
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index c44624e1e6..d62e134f74 100644
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
@@ -236,8 +239,328 @@ static int handle_diag320_query_vcsi(S390CPU *cpu, uint64_t addr, uint64_t r1,
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
+        return -1;
+    }
+
+    if (VCE_HEADER_LEN + key_id_len > be32_to_cpu(vce->len)) {
+        error_report("Unable to write key ID: exceeds buffer bounds");
+        return -1;
+    }
+
+    vce->keyid_len = cpu_to_be16(key_id_len);
+
+    memcpy(vce->cert_buf, key_id_data, key_id_len);
+
+    return 0;
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
+        return -1;
+    }
+
+    hash_offset = VCE_HEADER_LEN + keyid_field_len;
+    if (hash_offset + hash_len > be32_to_cpu(vce->len)) {
+        error_report("Unable to write hash: exceeds buffer bounds");
+        return -1;
+    }
+
+    vce->hash_len = cpu_to_be16(hash_len);
+    vce->hash_type = DIAG_320_VCE_HASHTYPE_SHA2_256;
+    vce->hash_offset = cpu_to_be16(hash_offset);
+
+    memcpy((uint8_t *)vce + hash_offset, hash_data, hash_len);
+
+    return 0;
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
+        return -1;
+    }
+
+    cert_offset = be16_to_cpu(vce->hash_offset) + hash_field_len;
+    if (cert_offset + der_size > be32_to_cpu(vce->len)) {
+        error_report("Unable to write certificate: exceeds buffer bounds");
+        return -1;
+    }
+
+    vce->format = DIAG_320_VCE_FORMAT_X509_DER;
+    vce->cert_len = cpu_to_be32(der_size);
+    vce->cert_offset = cpu_to_be16(cert_offset);
+
+    memcpy((uint8_t *)vce + cert_offset, cert_der, der_size);
+
+    return 0;
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
+                        DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING;
+}
+
+static int build_vce_header(VCEntry *vce, const S390IPLCertificate *cert, int idx)
+{
+    int key_type;
+
+    vce->len = cpu_to_be32(VCE_HEADER_LEN);
+    vce->cert_idx = cpu_to_be16(idx + 1);
+    memcpy(vce->name, cert->name, CERT_NAME_MAX_LEN);
+
+    key_type = get_key_type(cert);
+    if (key_type == -1) {
+        return -1;
+    }
+    vce->key_type = key_type;
+
+    return 0;
+}
+
+static int build_vce_data(VCEntry *vce, const S390IPLCertificate *cert)
+{
+    uint16_t keyid_field_len;
+    uint16_t hash_field_len;
+    uint32_t cert_field_len;
+    uint32_t vce_len;
+    int rc;
+
+    rc = handle_key_id(vce, cert);
+    if (rc) {
+        return -1;
+    }
+    keyid_field_len = ROUND_UP(be16_to_cpu(vce->keyid_len), 4);
+
+    rc = handle_hash(vce, cert, keyid_field_len);
+    if (rc) {
+        return -1;
+    }
+    hash_field_len = ROUND_UP(be16_to_cpu(vce->hash_len), 4);
+
+    rc = handle_cert(vce, cert, hash_field_len);
+    if (rc || !is_cert_valid(cert)) {
+        return -1;
+    }
+    cert_field_len = ROUND_UP(be32_to_cpu(vce->cert_len), 4);
+
+    vce_len = VCE_HEADER_LEN + keyid_field_len + hash_field_len + cert_field_len;
+    if (vce_len > be32_to_cpu(vce->len)) {
+        return -1;
+    }
+
+    vce->flags |= DIAG_320_VCE_FLAGS_VALID;
+
+    /* Update vce length to reflect the actual size used by vce */
+    vce->len = cpu_to_be32(vce_len);
+
+    return 0;
+}
+
+static VCEntry *diag_320_build_vce(const S390IPLCertificate *cert, int idx)
+{
+    g_autofree VCEntry *vce = NULL;
+    uint32_t vce_max_size;
+    int rc;
+
+    /*
+     * Each field of the VCE is word-aligned.
+     * Allocate enough space for the largest possible size for this VCE.
+     * As the certificate fields (key-id, hash, data) are parsed, the
+     * VCE's length field will be updated accordingly.
+     */
+    vce_max_size = VCE_HEADER_LEN +
+                   ROUND_UP(CERT_KEY_ID_LEN, 4) +
+                   ROUND_UP(CERT_HASH_LEN, 4) +
+                   ROUND_UP(cert->der_size, 4);
+
+    vce = g_malloc0(vce_max_size);
+    rc = build_vce_header(vce, cert, idx);
+    if (rc) {
+        /*
+         * Error occurs - VCE does not contain a valid certificate.
+         * Bit 0 of the VCE flags is 0 and the VCE length is set.
+         */
+        vce->len = cpu_to_be32(VCE_INVALID_LEN);
+        goto out;
+    }
+
+    vce->len = cpu_to_be32(vce_max_size);
+    rc = build_vce_data(vce, cert);
+    if (rc) {
+        vce->len = cpu_to_be32(VCE_INVALID_LEN);
+    }
+
+out:
+    return g_steal_pointer(&vce);
+}
+
+static int handle_diag320_store_vc(S390CPU *cpu, uint64_t addr, uint64_t r1, uintptr_t ra,
+                                   S390IPLCertificateStore *cs)
+{
+    g_autofree VCBlock *vcb = NULL;
+    size_t remaining_space;
+    uint16_t first_vc_index;
+    uint16_t last_vc_index;
+    int cs_start_index;
+    int cs_end_index;
+    uint32_t in_len;
+
+    vcb = g_new0(VCBlock, 1);
+    if (s390_cpu_virt_mem_read(cpu, addr, r1, vcb, sizeof(*vcb))) {
+        s390_cpu_virt_mem_handle_exc(cpu, ra);
+        return -1;
+    }
+
+    in_len = be32_to_cpu(vcb->in_len);
+    first_vc_index = be16_to_cpu(vcb->first_vc_index);
+    last_vc_index = be16_to_cpu(vcb->last_vc_index);
+
+    if (in_len % TARGET_PAGE_SIZE != 0) {
+        return DIAG_320_RC_INVAL_VCB_LEN;
+    }
+
+    if (first_vc_index > last_vc_index) {
+        return DIAG_320_RC_BAD_RANGE;
+    }
+
+    vcb->out_len = VCB_HEADER_LEN;
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
+    remaining_space = in_len - VCB_HEADER_LEN;
+
+    for (int i = cs_start_index; i <= cs_end_index; i++) {
+        VCEntry *vce;
+        const S390IPLCertificate *cert = &cs->certs[i];
+
+        /*
+         * Bit 0 of the VCE flags indicates whether the certificate is valid.
+         * The caller of DIAG320 subcode 2 is responsible for verifying that
+         * the VCE contains a valid certificate.
+         */
+        vce = diag_320_build_vce(cert, i);
+
+        /*
+         * If there is no more space to store the cert,
+         * set the remaining verification cert count and
+         * break early.
+         */
+        if (remaining_space < vce->len) {
+            vcb->remain_ct = cpu_to_be16(last_vc_index - i);
+            g_free(vce);
+            break;
+        }
+
+        /* Write VCE */
+        if (s390_cpu_virt_mem_write(cpu, addr + vcb->out_len, r1, vce, vce->len)) {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
+            g_free(vce);
+            return -1;
+        }
+
+        vcb->out_len += vce->len;
+        remaining_space -= vce->len;
+        vcb->stored_ct++;
+
+        g_free(vce);
+    }
+    vcb->stored_ct = cpu_to_be16(vcb->stored_ct);
+
+out:
+    vcb->out_len = cpu_to_be32(vcb->out_len);
+
+    if (s390_cpu_virt_mem_write(cpu, addr, r1, vcb, VCB_HEADER_LEN)) {
+        s390_cpu_virt_mem_handle_exc(cpu, ra);
+        return -1;
+    }
+
+    return DIAG_320_RC_OK;
+}
+
 QEMU_BUILD_BUG_MSG(sizeof(VCStorageSizeBlock) != VCSSB_MIN_LEN,
                    "size of VCStorageSizeBlock is wrong");
+QEMU_BUILD_BUG_MSG(sizeof(VCBlock) != VCB_HEADER_LEN, "size of VCBlock is wrong");
+QEMU_BUILD_BUG_MSG(sizeof(VCEntry) != VCE_HEADER_LEN, "size of VCEntry is wrong");
 
 void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
@@ -268,7 +591,8 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
          * for now.
          */
         uint32_t ism_word0 = cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES |
-                                         DIAG_320_ISM_QUERY_VCSI);
+                                         DIAG_320_ISM_QUERY_VCSI |
+                                         DIAG_320_ISM_STORE_VC);
 
         if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism_word0, sizeof(ism_word0))) {
             s390_cpu_virt_mem_handle_exc(cpu, ra);
@@ -294,6 +618,18 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
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
2.53.0


