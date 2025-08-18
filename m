Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064F5CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 21:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo7e9-0001m5-EO; Mon, 18 Aug 2025 17:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uo7dm-0001em-Qa; Mon, 18 Aug 2025 17:43:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uo7dk-0003lc-Jd; Mon, 18 Aug 2025 17:43:42 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IL2teK002048;
 Mon, 18 Aug 2025 21:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=cIFl8QUkvc9rkLeWj
 HRvvINIONuCW4qqySiXGR4kxHk=; b=U2EfVyADIntRlpTLT+ka5lwKLUi0zeYc6
 Pi+LD2eNheoWQvPMh1wS+mjoCU8fkpiPtLsvEYsuEcgKJ3hTGTb1+54SqxI1REvn
 hmiXhIxIxbknwxMoCkH2Uhs07OVRq8yVeBkYhn3UlnAwLE5pOvb8Ef/dlB9f3RtZ
 1To/o7J+RNKMRabDNIGEc5wto1PqtQgRBKB1TdyuKMh5rWQWX97tmAnAAW4CAdEo
 Q0X+cxwD/EXrwy+JfBxMK49lvj2V76bK63MbmYAOj9iNFJWiv+xAkXpRNSQ8w67W
 9ssSqseHEZweJWvZdvB4nIw/C4iFMD8bza3EoATD1VHP1gc3W59Dw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jfdrujj5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 21:43:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57IK4nFL002362;
 Mon, 18 Aug 2025 21:43:38 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k712y9w2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 21:43:38 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57ILhadE23069420
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Aug 2025 21:43:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19C2058058;
 Mon, 18 Aug 2025 21:43:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D158A58057;
 Mon, 18 Aug 2025 21:43:34 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.98.172])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 18 Aug 2025 21:43:34 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v5 09/29] s390x/diag: Implement DIAG 320 subcode 2
Date: Mon, 18 Aug 2025 17:43:02 -0400
Message-ID: <20250818214323.529501-10-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818214323.529501-1-zycai@linux.ibm.com>
References: <20250818214323.529501-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zWW9hZUrn3_W2860qpp2ljmAeAB0L3jQ
X-Proofpoint-GUID: zWW9hZUrn3_W2860qpp2ljmAeAB0L3jQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAwMSBTYWx0ZWRfX77pHBRKyxt64
 kc3zZME9r4RMt7bbPcixFCktCwshpLvD8zEVs2Al4gArYyBGgPCaOCslszJotCHdqGow9Xvld1t
 BiI3yqYkC4OAIYODorh/no1c3V1Uf/7RXGcamzHyIQrVIgTvht1duE5MIQsZ1mzYcg23SCunn2S
 1ufJRP7xaKPSVIN4zFI5kYKgELz54z7UwOotHY+ll3+AYep9DgtizQc9xwrG1LiZaDLncCA81I4
 /lQdLPnM2ZQKDsjvHbMrIJnXXCQ8hFyBLCdk9jUCOxh2T6pCryF5y4MVxnht3Kc1owN3K74suT9
 u2hPTfuwAQ55nuW+lMqRm9CV9PaNaRPrZCgU8bZJLZW1OSnHm6l0w+PxupjVRfslnNEWU5YO0P7
 Oz+tLtN3
X-Authority-Analysis: v=2.4 cv=GotC+l1C c=1 sm=1 tr=0 ts=68a39e8b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=xHnrawAp1QBLmOVMci8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160001
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
 docs/specs/s390x-secure-ipl.rst |  13 ++
 include/hw/s390x/ipl/diag320.h  |  49 ++++++
 target/s390x/diag.c             | 286 +++++++++++++++++++++++++++++++-
 3 files changed, 347 insertions(+), 1 deletion(-)

diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
index ddc15f0322..16868aa823 100644
--- a/docs/specs/s390x-secure-ipl.rst
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -33,3 +33,16 @@ Subcode 1 - query verification certificate storage information
 
     The output is returned in the verification-certificate-storage-size block (VCSSB).
     A VCSSB length of 4 indicates that no certificates are available in the CS.
+
+Subcode 2 - store verification certificates
+    Provides VCs that are in the certificate store.
+
+    The output is provided in a VCB, which includes a common header followed by zero
+    or more verification-certificate entries (VCEs).
+
+    The first-VC index and last-VC index fields of VCB specify the range of VCs
+    to be stored by subcode 2. Stored count and remained count fields specify the
+    number of VCs stored and could not be stored in the VCB due to insufficient
+    storage specified in the VCB input length field.
+
+    VCE contains various information of a VC from the CS.
diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
index 6e4779c699..9d37dea665 100644
--- a/include/hw/s390x/ipl/diag320.h
+++ b/include/hw/s390x/ipl/diag320.h
@@ -12,19 +12,30 @@
 
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
+#define VCE_INVALID_LEN 72
 #define VCB_HEADER_LEN  64
 
+#define DIAG_320_VCE_FLAGS_VALID                0x80
+#define DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING    0
+#define DIAG_320_VCE_KEYTYPE_ECDSA              1
+#define DIAG_320_VCE_FORMAT_X509_DER            1
+#define DIAG_320_VCE_HASHTYPE_SHA2_256          1
+
 struct VCStorageSizeBlock {
     uint32_t length;
     uint8_t reserved0[3];
@@ -39,4 +50,42 @@ struct VCStorageSizeBlock {
 };
 typedef struct VCStorageSizeBlock VCStorageSizeBlock;
 
+struct VCBlock {
+    uint32_t in_len;
+    uint32_t reserved0;
+    uint16_t first_vc_index;
+    uint16_t last_vc_index;
+    uint32_t reserved1[5];
+    uint32_t out_len;
+    uint8_t reserved2[3];
+    uint8_t version;
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
+    uint32_t name[16];
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
index b42cf8fe98..820f45a0bd 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -17,6 +17,7 @@
 #include "s390x-internal.h"
 #include "hw/watchdog/wdt_diag288.h"
 #include "system/cpus.h"
+#include "hw/s390x/cert-store.h"
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/ipl/diag320.h"
 #include "hw/s390x/s390-virtio-ccw.h"
@@ -24,6 +25,7 @@
 #include "kvm/kvm_s390x.h"
 #include "target/s390x/kvm/pv.h"
 #include "qemu/error-report.h"
+#include "crypto/x509-utils.h"
 
 
 int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
@@ -225,6 +227,280 @@ static int handle_diag320_query_vcsi(S390CPU *cpu, uint64_t addr, uint64_t r1,
     return DIAG_320_RC_OK;
 }
 
+static bool is_cert_valid(S390IPLCertificate qcert)
+{
+    int rc;
+    Error *err = NULL;
+
+    rc = qcrypto_x509_check_cert_times(qcert.raw, qcert.size, &err);
+    if (rc != 0) {
+        error_report_err(err);
+        return false;
+    }
+
+    return true;
+}
+
+static void handle_key_id(VCEntry *vce, S390IPLCertificate qcert)
+{
+    int rc;
+    g_autofree unsigned char *key_id_data = NULL;
+    Error *err = NULL;
+
+    /* key id and key id len */
+    rc = qcrypto_x509_get_cert_key_id(qcert.raw, qcert.size,
+                                      QCRYPTO_HASH_ALGO_SHA256,
+                                      &key_id_data, &qcert.key_id_size, &err);
+    if (rc < 0) {
+        error_report_err(err);
+        return;
+    }
+    vce->keyid_len = cpu_to_be16(qcert.key_id_size);
+
+    memcpy(vce->cert_buf, key_id_data, qcert.key_id_size);
+}
+
+static int handle_hash(VCEntry *vce, S390IPLCertificate qcert, uint16_t keyid_field_len)
+{
+    int rc;
+    uint16_t hash_offset;
+    g_autofree void *hash_data = NULL;
+    Error *err = NULL;
+
+    /* hash and hash len */
+    hash_data = g_malloc0(qcert.hash_size);
+    rc = qcrypto_get_x509_cert_fingerprint(qcert.raw, qcert.size,
+                                           QCRYPTO_HASH_ALGO_SHA256,
+                                           hash_data, &qcert.hash_size, &err);
+    if (rc < 0) {
+        error_report_err(err);
+        return -1;
+    }
+    vce->hash_len = cpu_to_be16(qcert.hash_size);
+
+    /* hash type */
+    vce->hash_type = DIAG_320_VCE_HASHTYPE_SHA2_256;
+
+    hash_offset = VCE_HEADER_LEN + keyid_field_len;
+    vce->hash_offset = cpu_to_be16(hash_offset);
+
+    memcpy((uint8_t *)vce + hash_offset, hash_data, qcert.hash_size);
+
+    return 0;
+}
+
+static int handle_cert(VCEntry *vce, S390IPLCertificate qcert, uint16_t hash_field_len)
+{
+    int rc;
+    uint16_t cert_offset;
+    g_autofree uint8_t *cert_der = NULL;
+    Error *err = NULL;
+
+    /* certificate in DER format */
+    rc = qcrypto_x509_convert_cert_der(qcert.raw, qcert.size,
+                                       &cert_der, &qcert.der_size, &err);
+    if (rc < 0) {
+        error_report_err(err);
+        return -1;
+    }
+    vce->format = DIAG_320_VCE_FORMAT_X509_DER;
+    vce->cert_len = cpu_to_be32(qcert.der_size);
+    cert_offset = be16_to_cpu(vce->hash_offset) + hash_field_len;
+    vce->cert_offset = cpu_to_be16(cert_offset);
+
+    memcpy((uint8_t *)vce + cert_offset, cert_der, qcert.der_size);
+
+    return 0;
+}
+
+static int build_vce_header(VCEntry *vce, S390IPLCertificate qcert, int idx)
+{
+    int algo;
+    Error *err = NULL;
+
+    vce->len = cpu_to_be32(VCE_HEADER_LEN);
+    vce->cert_idx = cpu_to_be16(idx + 1);
+    strncpy((char *)vce->name, (char *)qcert.vc_name, VC_NAME_LEN_BYTES);
+
+    /* public key algorithm */
+    algo = qcrypto_x509_get_pk_algorithm(qcert.raw, qcert.size, &err);
+    if (algo < 0) {
+        error_report_err(err);
+        return -1;
+    }
+
+    if (algo == QCRYPTO_PK_ALGO_ECDSA) {
+        vce->key_type = DIAG_320_VCE_KEYTYPE_ECDSA;
+    } else {
+        vce->key_type = DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING;
+    }
+
+    return 0;
+}
+
+static int build_vce_data(VCEntry *vce, S390IPLCertificate qcert)
+{
+    uint16_t keyid_field_len;
+    uint16_t hash_field_len;
+    uint32_t cert_field_len;
+    int rc;
+
+    handle_key_id(vce, qcert);
+    /* vce key id field length - can be 0 if failed to retrieve */
+    keyid_field_len = ROUND_UP(be16_to_cpu(vce->keyid_len), 4);
+
+    rc = handle_hash(vce, qcert, keyid_field_len);
+    if (rc) {
+        return -1;
+    }
+    hash_field_len = ROUND_UP(be16_to_cpu(vce->hash_len), 4);
+
+    rc = handle_cert(vce, qcert, hash_field_len);
+    if (rc || !is_cert_valid(qcert)) {
+        return -1;
+    }
+    /* vce certificate field length */
+    cert_field_len = ROUND_UP(be32_to_cpu(vce->cert_len), 4);
+
+    /* The certificate is valid and VCE contains the certificate */
+    vce->flags |= DIAG_320_VCE_FLAGS_VALID;
+
+    /* Update vce length to reflect the acutal size used by vce */
+    vce->len += cpu_to_be32(keyid_field_len + hash_field_len + cert_field_len);
+
+    return 0;
+}
+
+static VCEntry *diag_320_build_vce(S390IPLCertificate qcert, uint32_t vce_len, int idx)
+{
+    g_autofree VCEntry *vce = NULL;
+    int rc;
+
+    /*
+     * Construct VCE
+     * Allocate enough memory for all certificate data (key id, hash and certificate).
+     * Unused area following the VCE field contains zeros.
+     */
+    vce = g_malloc0(vce_len);
+    rc = build_vce_header(vce, qcert, idx);
+    if (rc) {
+        vce->len = cpu_to_be32(VCE_INVALID_LEN);
+        goto out;
+    }
+    vce->len = cpu_to_be32(VCE_HEADER_LEN);
+
+    rc = build_vce_data(vce, qcert);
+    if (rc) {
+        vce->len = cpu_to_be32(VCE_INVALID_LEN);
+    }
+
+out:
+    return g_steal_pointer(&vce);
+}
+
+static int handle_diag320_store_vc(S390CPU *cpu, uint64_t addr, uint64_t r1, uintptr_t ra,
+                                   S390IPLCertificateStore *qcs)
+{
+    g_autofree VCBlock *vcb = NULL;
+    size_t vce_offset;
+    size_t remaining_space;
+    uint32_t vce_len;
+    uint16_t first_vc_index;
+    uint16_t last_vc_index;
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
+    if (first_vc_index == 0) {
+        /*
+         * Zero is a valid index for the first and last VC index.
+         * Zero index results in the VCB header and zero certificates returned.
+         */
+        if (last_vc_index == 0) {
+            goto out;
+        }
+
+        /* DIAG320 certificate store remains a one origin for cert entries */
+        vcb->first_vc_index = 1;
+        first_vc_index = 1;
+    }
+
+    vce_offset = VCB_HEADER_LEN;
+    vcb->out_len = VCB_HEADER_LEN;
+    remaining_space = in_len - VCB_HEADER_LEN;
+
+    for (int i = first_vc_index - 1; i < last_vc_index && i < qcs->count; i++) {
+        VCEntry *vce;
+        S390IPLCertificate qcert = qcs->certs[i];
+        /*
+         * Each VCE is word aligned.
+         * Each variable length field within the VCE is also word aligned.
+         */
+        vce_len = VCE_HEADER_LEN +
+                  ROUND_UP(qcert.key_id_size, 4) +
+                  ROUND_UP(qcert.hash_size, 4) +
+                  ROUND_UP(qcert.der_size, 4);
+
+        /*
+         * If there is no more space to store the cert,
+         * set the remaining verification cert count and
+         * break early.
+         */
+        if (remaining_space < vce_len) {
+            vcb->remain_ct = cpu_to_be16(last_vc_index - i);
+            break;
+        }
+
+        vce = diag_320_build_vce(qcert, vce_len, i);
+
+        /* Write VCE */
+        if (s390_cpu_virt_mem_write(cpu, addr + vce_offset, r1,
+                                    vce, be32_to_cpu(vce->len))) {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
+            return -1;
+        }
+
+        vce_offset += be32_to_cpu(vce->len);
+        vcb->out_len += be32_to_cpu(vce->len);
+        remaining_space -= be32_to_cpu(vce->len);
+        vcb->stored_ct++;
+
+        g_free(vce);
+    }
+
+    vcb->out_len = cpu_to_be32(vcb->out_len);
+    vcb->stored_ct = cpu_to_be16(vcb->stored_ct);
+
+out:
+    /*
+     * Write VCB header
+     * All VCEs have been populated with the latest information
+     * and write VCB header last.
+     */
+    if (s390_cpu_virt_mem_write(cpu, addr, r1, vcb, VCB_HEADER_LEN)) {
+        s390_cpu_virt_mem_handle_exc(cpu, ra);
+        return -1;
+    }
+
+    return DIAG_320_RC_OK;
+}
+
 void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     S390CPU *cpu = env_archcpu(env);
@@ -256,7 +532,8 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
          * for now.
          */
         uint32_t ism_word0 = cpu_to_be32(DIAG_320_ISM_QUERY_SUBCODES |
-                                         DIAG_320_ISM_QUERY_VCSI);
+                                         DIAG_320_ISM_QUERY_VCSI |
+                                         DIAG_320_ISM_STORE_VC);
 
         if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism_word0, sizeof(ism_word0))) {
             s390_cpu_virt_mem_handle_exc(cpu, ra);
@@ -282,6 +559,13 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
         }
         env->regs[r1 + 1] = rc;
         break;
+    case DIAG_320_SUBC_STORE_VC:
+        rc = handle_diag320_store_vc(cpu, addr, r1, ra, qcs);
+        if (rc == -1) {
+            return;
+        }
+        env->regs[r1 + 1] = rc;
+        break;
     default:
         env->regs[r1 + 1] = DIAG_320_RC_NOT_SUPPORTED;
         break;
-- 
2.50.1


