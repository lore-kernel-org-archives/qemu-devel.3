Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD154C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 21:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaL2D-0000p7-5L; Fri, 11 Jul 2025 17:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL1t-0000em-Ow; Fri, 11 Jul 2025 17:11:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL1m-0002rT-TF; Fri, 11 Jul 2025 17:11:37 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BFp60J005980;
 Fri, 11 Jul 2025 21:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ESWcnMGkf/jtq9IK5
 nVY1i31rmSWkH63PpklrL2yCGs=; b=f4gQhXC5rZLFXp7JMk75ZzEpopuVstGQe
 opvEQ/krjnsmzrXUUeWKpSm4RWoj26xuT+039FJgY6GsnSjvxJprKRMMSQoi9/YI
 wb/OtyhkYaZxKZY4woPX9yZexOAEh/d06TQdfYnWYlnfMOQgpNyB0Npm72HTGXUQ
 HRUMs32szolT+Dqmm4bwuat+jo3Fu94LJKOAFJshNNmuSsY2j+p+FEbNMU1Jnwmb
 lM1zOVSNMboBv48d+qqJaYWkPWlvvV6oqZxwUmC04St2D59WhRe6MgfjGPZkkMq8
 3k5pvwHMM21H79GsjVVLz0TTJMXebWogWD37E/RjmDfWtfYzIxzjQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk4n6ss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56BJL3Km025618;
 Fri, 11 Jul 2025 21:11:26 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfcpmk52-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:26 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56BLBPKt26870488
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 21:11:25 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE7EC58059;
 Fri, 11 Jul 2025 21:11:24 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E6705805C;
 Fri, 11 Jul 2025 21:11:23 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.25.251])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Jul 2025 21:11:23 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 09/28] s390x/diag: Implement DIAG 320 subcode 2
Date: Fri, 11 Jul 2025 17:10:45 -0400
Message-ID: <20250711211105.439554-10-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711211105.439554-1-zycai@linux.ibm.com>
References: <20250711211105.439554-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE1NiBTYWx0ZWRfXzbzh0RdlibWj
 ioY72ExFnB9Amd25b9mga1Zm3ObN4sl+ZfYvrNwdJhhTlMkC64IUu2l5GEA0v6FT5Q6H5qfFFWu
 9ZKlT7So7VSIsyeZkHnEk/aF9QkkvMeU78tV+nR4l1S2E4/zIMBGFlsc3NnKk/U0j6ceTuQTir7
 gXCoD3Qd2CdqBQz93Nzg8sDYOOH8WcuQXBOG6ePOpAOZGh3TV++xpbZI445dvxsS7wC6xNJoY+9
 oXSqE3dc2fnMm+hGan8t/0t4fZD8UA2Qs5E3Xw32iWzQjqhSsQ4DiSmuhyZt08gwPRK7NlxzsZf
 17G/QGfn3BgR6R6VuAbeloQbkdRtMpWjrrNthpcB+tNJEPVYK+h+9uaC0j+vC4nFvZVL2aystKD
 JFoEzBApAHi1HfSMatc0SDkwd7T3uC0blrzA7gV9HImQ+zqtlWykHy/yKpXheo/STnuHRWEc
X-Authority-Analysis: v=2.4 cv=XYeJzJ55 c=1 sm=1 tr=0 ts=68717dff cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=R4z4TraTOLgKuyQb884A:9
X-Proofpoint-ORIG-GUID: Ibyth_mFyHja7fvq7o7BWHM8BzJwereN
X-Proofpoint-GUID: Ibyth_mFyHja7fvq7o7BWHM8BzJwereN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_06,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110156
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 include/hw/s390x/ipl/diag320.h |  47 ++++++
 target/s390x/diag.c            | 254 ++++++++++++++++++++++++++++++++-
 2 files changed, 300 insertions(+), 1 deletion(-)

diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
index 3916a2915e..a926cf7d25 100644
--- a/include/hw/s390x/ipl/diag320.h
+++ b/include/hw/s390x/ipl/diag320.h
@@ -12,14 +12,23 @@
 
 #define DIAG_320_SUBC_QUERY_ISM     0
 #define DIAG_320_SUBC_QUERY_VCSI    1
+#define DIAG_320_SUBC_STORE_VC      2
 
 #define DIAG_320_RC_OK              0x0001
+#define DIAG_320_RC_INVAL_VCB_LEN   0x0204
+#define DIAG_320_RC_BAD_RANGE       0x0302
 
 #define VCSSB_MAX_LEN   128
 #define VCE_HEADER_LEN  128
 #define VCB_HEADER_LEN  64
 
 #define DIAG_320_ISM_QUERY_VCSI     0x4000000000000000
+#define DIAG_320_ISM_STORE_VC       0x2000000000000000
+
+#define DIAG_320_VCE_FLAGS_VALID                0x80
+#define DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING    0
+#define DIAG_320_VCE_FORMAT_X509_DER            1
+#define DIAG_320_VCE_HASHTYPE_SHA2_256          1
 
 struct VCStorageSizeBlock {
     uint32_t length;
@@ -37,4 +46,42 @@ struct VCStorageSizeBlock {
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
index 1f7d0cb2f6..4641f88278 100644
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
@@ -191,8 +193,252 @@ out:
     }
 }
 
+static int diag_320_is_cert_valid(S390IPLCertificate qcert)
+{
+    int version;
+    int rc;
+    Error *err = NULL;
+
+    version = qcrypto_x509_get_cert_version(qcert.raw, qcert.size, &err);
+    if (version < 0) {
+        error_report_err(err);
+        return -1;
+    }
+
+    rc = qcrypto_x509_check_cert_times(qcert.raw, qcert.size, &err);
+    if (rc != 0) {
+        error_report_err(err);
+        return -1;
+    }
+
+    return 0;
+}
+
+static int diag_320_get_cert_info(VCEntry *vce, S390IPLCertificate qcert,
+                                  uint8_t **cert_der, unsigned char **key_id_data,
+                                  void **hash_data)
+{
+    int algo;
+    int rc;
+    Error *err = NULL;
+
+    /* key-type */
+    algo = qcrypto_x509_get_pk_algorithm(qcert.raw, qcert.size, &err);
+    if (algo < 0) {
+        error_report_err(err);
+        return -1;
+    }
+    if (algo == QCRYPTO_PK_ALGO_RSA) {
+        vce->key_type = DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING;
+    }
+
+    /* certificate in DER format */
+    rc = qcrypto_x509_convert_cert_der(qcert.raw, qcert.size,
+                                       cert_der, &qcert.der_size, &err);
+    if (rc < 0) {
+        error_report_err(err);
+        goto out;
+    }
+
+    /* VC format */
+    vce->format = DIAG_320_VCE_FORMAT_X509_DER;
+
+    /* key id and key id len */
+    rc = qcrypto_x509_get_cert_key_id(qcert.raw, qcert.size,
+                                      QCRYPTO_KEYID_FLAGS_SHA256,
+                                      key_id_data, &qcert.key_id_size, &err);
+    if (rc < 0) {
+        error_report_err(err);
+        goto out;
+    }
+    vce->keyid_len = cpu_to_be16(qcert.key_id_size);
+
+    /* hash type */
+    if (qcert.hash_type == QCRYPTO_SIG_ALGO_RSA_SHA256) {
+        vce->hash_type = DIAG_320_VCE_HASHTYPE_SHA2_256;
+    }
+
+    /* hash and hash len */
+    *hash_data = g_malloc0(qcert.hash_size);
+    rc = qcrypto_get_x509_cert_fingerprint(qcert.raw, qcert.size,
+                                           QCRYPTO_HASH_ALGO_SHA256,
+                                           *hash_data, &qcert.hash_size, &err);
+    if (rc < 0) {
+        error_report_err(err);
+        goto out;
+    }
+    vce->hash_len = cpu_to_be16(qcert.hash_size);
+
+    return 0;
+
+out:
+    g_clear_pointer(cert_der, g_free);
+    g_clear_pointer(key_id_data, g_free);
+    g_clear_pointer(hash_data, g_free);
+
+    return -1;
+}
+
+static VCEntry *build_vce(S390IPLCertificate qcert, uint32_t vce_len, int idx,
+                          size_t keyid_buf_size, size_t hash_buf_size)
+{
+    g_autofree VCEntry *vce = NULL;
+    g_autofree uint8_t *cert_der = NULL;
+    g_autofree unsigned char *key_id_data = NULL;
+    g_autofree void *hash_data = NULL;
+    int is_valid = -1;
+    int rc;
+
+    /*
+     * Construct VCE
+     * Unused area following the VCE field contains zeros.
+     */
+    vce = g_malloc0(vce_len);
+
+    rc = diag_320_get_cert_info(vce, qcert, &cert_der, &key_id_data, &hash_data);
+    if (rc) {
+        return NULL;
+    }
+
+    is_valid = diag_320_is_cert_valid(qcert);
+
+    vce->len = cpu_to_be32(vce_len);
+    vce->cert_idx = cpu_to_be16(idx + 1);
+    vce->cert_len = cpu_to_be32(qcert.der_size);
+
+    strncpy((char *)vce->name, (char *)qcert.vc_name, VC_NAME_LEN_BYTES);
+
+    /* VCE field offset is also word aligned */
+    vce->hash_offset = cpu_to_be16(VCE_HEADER_LEN + keyid_buf_size);
+    vce->cert_offset = cpu_to_be16(VCE_HEADER_LEN + keyid_buf_size + hash_buf_size);
+
+    /* Write Key ID */
+    memcpy(vce->cert_buf, key_id_data, qcert.key_id_size);
+    /* Write Hash key */
+    memcpy(vce->cert_buf + keyid_buf_size, hash_data, qcert.hash_size);
+    /* Write VCE cert data */
+    memcpy(vce->cert_buf + keyid_buf_size + hash_buf_size, cert_der, qcert.der_size);
+
+    /* The certificate is valid and VCE contains the certificate */
+    if (is_valid == 0) {
+        vce->flags |= DIAG_320_VCE_FLAGS_VALID;
+    }
+
+    return g_steal_pointer(&vce);
+}
+
+static int handle_diag320_store_vc(S390CPU *cpu, uint64_t addr, uint64_t r1, uintptr_t ra,
+                                   S390IPLCertificateStore *qcs)
+{
+    g_autofree VCBlock *vcb = NULL;
+    size_t vce_offset;
+    size_t remaining_space;
+    size_t keyid_buf_size;
+    size_t hash_buf_size;
+    size_t cert_buf_size;
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
+        keyid_buf_size = ROUND_UP(qcert.key_id_size, 4);
+        hash_buf_size = ROUND_UP(qcert.hash_size, 4);
+        cert_buf_size = ROUND_UP(qcert.der_size, 4);
+        vce_len = VCE_HEADER_LEN + cert_buf_size + keyid_buf_size + hash_buf_size;
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
+        vce = build_vce(qcert, vce_len, i, keyid_buf_size, hash_buf_size);
+        if (vce == NULL) {
+            continue;
+        }
+
+        /* Write VCE */
+        if (s390_cpu_virt_mem_write(cpu, addr + vce_offset, r1, vce, vce_len)) {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
+            return -1;
+        }
+
+        vce_offset += vce_len;
+        vcb->out_len += vce_len;
+        remaining_space -= vce_len;
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
 QEMU_BUILD_BUG_MSG(sizeof(VCStorageSizeBlock) != 128,
                    "size of VCStorageSizeBlock is wrong");
+QEMU_BUILD_BUG_MSG(sizeof(VCBlock) != 64, "size of VCBlock is wrong");
+QEMU_BUILD_BUG_MSG(sizeof(VCEntry) != 128, "size of VCEntry is wrong");
 
 void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
@@ -219,7 +465,7 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
     switch (subcode) {
     case DIAG_320_SUBC_QUERY_ISM:
-        uint64_t ism = cpu_to_be64(DIAG_320_ISM_QUERY_VCSI);
+        uint64_t ism = cpu_to_be64(DIAG_320_ISM_QUERY_VCSI | DIAG_320_ISM_STORE_VC);
 
         if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism, sizeof(ism))) {
             s390_cpu_virt_mem_handle_exc(cpu, ra);
@@ -258,6 +504,12 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
         }
         rc = DIAG_320_RC_OK;
         break;
+    case DIAG_320_SUBC_STORE_VC:
+        rc = handle_diag320_store_vc(cpu, addr, r1, ra, qcs);
+        if (rc == -1) {
+            return;
+        }
+        break;
     default:
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
-- 
2.49.0


