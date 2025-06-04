Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF06C5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 22:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMw7H-0002ml-Bq; Wed, 04 Jun 2025 17:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw77-0002fv-6u; Wed, 04 Jun 2025 17:57:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw74-0006yI-UF; Wed, 04 Jun 2025 17:57:36 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554CePab029653;
 Wed, 4 Jun 2025 21:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=PrsethanPV/+69X5M
 KHHs7mQYsLs3R/EFltlTwtcBgM=; b=Jq3xM1D8Ylg1VvQdOwnjznYF3BPEl5C8P
 4Cs4eASvZEATceihWI4Fh2DvArjqP6I7YGOX4LsAC8hUnNoXIBMSPupaZ3XJ5uQf
 RXsICcNAYSC5EUB9jUQosadBJ+vJjGJXfLHhR1aqdc2esVa8JfsKZBgeADlXSyFR
 Ffo2yl68Q7vi5TLLfyxtU9HDRYcurmaIdAkHYE6eMkMBLfZTh9N1LQvrk8qYZCXu
 keH+2pyunIOXGDLE2vl8cQfJO/fu7SSwDriIJfAKilufLlIrjM341BEbG/4+Kckm
 g2bYGOjpJvn8obdkkA2CI+RaC4zBzgJWjZrODZsCp085ANjPKwI7A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geywb8g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 554IjT4l024883;
 Wed, 4 Jun 2025 21:57:28 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470dkmhs5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:28 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 554LvQ0930999210
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jun 2025 21:57:26 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C991C58050;
 Wed,  4 Jun 2025 21:57:26 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 082D558045;
 Wed,  4 Jun 2025 21:57:25 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.211])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jun 2025 21:57:24 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v3 09/28] s390x/diag: Implement DIAG 320 subcode 2
Date: Wed,  4 Jun 2025 17:56:37 -0400
Message-ID: <20250604215657.528142-10-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604215657.528142-1-zycai@linux.ibm.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: at4uGSEJQzzK190BUARtkhvNfoR4TuYk
X-Authority-Analysis: v=2.4 cv=DYMXqutW c=1 sm=1 tr=0 ts=6840c149 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=r0sPUT9nRxWdPq8P5IoA:9
X-Proofpoint-GUID: at4uGSEJQzzK190BUARtkhvNfoR4TuYk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE3NSBTYWx0ZWRfX46GIRYX4by89
 F+dXxmpm1GV+ySblE/Ml0UEYf4VVXkMo+ElmDOaABw4r0iWyYJ8Ekp1Qy+3CFJF0h/J+g1U1Itt
 iDmiUNZJktR79lsubUOy+TwBBsHf7Jq+u37BDizWD1VOMBI06a/K0UM+9qDm9Y9gHK88kD36mlh
 xxC82N0ai01wCwgb5m9o86jI/13RxOPkuffuBy4Z734dYV4OGM045QggraG0vhBr0DCZA1HkUVI
 aBBJhqOCBFJFyAV3BhBG9QBD1CiVb+Q3EPrxiEr54ssDZsVu0TeaAJRc8KimYav5UIaesB1bfwx
 7OvPDoLHW2Vb3mn5ld4lEFlXVMQ/q3v+a5epAFYoDBVempO/rrNj8JbbGWMp/m8Waae3U7B/VcA
 3gRjo8T6sFXtw1k0aCxDFRGjay6P8rhl5xa71nWpTrCCWwqh0Bg0Lt2ZPaj3JXsph5zWVvgX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040175
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 target/s390x/diag.c            | 262 ++++++++++++++++++++++++++++++++-
 2 files changed, 308 insertions(+), 1 deletion(-)

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
index 1f7d0cb2f6..c8518dc5be 100644
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
@@ -191,8 +193,260 @@ out:
     }
 }
 
+static int diag_320_is_cert_valid(S390IPLCertificate qcert, Error **errp)
+{
+    int version;
+    int rc;
+
+    version = qcrypto_get_x509_cert_version((uint8_t *)qcert.raw, qcert.size, errp);
+    if (version < 0) {
+        return version == -ENOTSUP ? -ENOTSUP : -1;
+    }
+
+    rc = qcrypto_check_x509_cert_times((uint8_t *)qcert.raw, qcert.size, errp);
+    if (rc) {
+        return -1;
+    }
+
+    return 0;
+}
+
+static int diag_320_get_cert_info(VCEntry *vce, S390IPLCertificate qcert, int *is_valid,
+                                  unsigned char **key_id_data, void **hash_data)
+{
+    int algo;
+    int rc;
+    Error *err = NULL;
+
+    /* VCE flag (validity) */
+    *is_valid = diag_320_is_cert_valid(qcert, &err);
+    /* return early if GNUTLS is not enabled */
+    if (*is_valid == -ENOTSUP) {
+        error_report("GNUTLS is not supported");
+        return -1;
+    }
+    /* reset err for the next caller to avoid assert failure */
+    err = NULL;
+
+    /* key-type */
+    algo = qcrypto_get_x509_pk_algorithm((uint8_t *)qcert.raw, qcert.size, &err);
+    if (algo == QCRYPTO_PK_ALGO_RSA) {
+        vce->key_type = DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING;
+    }
+    err = NULL;
+
+    /* VC format */
+    if (qcert.format == QCRYPTO_CERT_FMT_DER) {
+        vce->format = DIAG_320_VCE_FORMAT_X509_DER;
+    }
+
+    /* key id and key id len */
+    *key_id_data = g_malloc0(qcert.key_id_size);
+    rc = qcrypto_get_x509_cert_key_id((uint8_t *)qcert.raw, qcert.size,
+                                      QCRYPTO_KEYID_FLAGS_SHA256,
+                                      *key_id_data, &qcert.key_id_size, &err);
+    if (rc < 0) {
+        error_report_err(err);
+        error_report("Fail to retrieve certificate key ID");
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
+    rc = qcrypto_get_x509_cert_fingerprint((uint8_t *)qcert.raw, qcert.size,
+                                           QCRYPTO_HASH_ALGO_SHA256,
+                                           *hash_data, &qcert.hash_size, &err);
+    if (rc < 0) {
+        error_report_err(err);
+        error_report("Fail to retrieve certificate hash");
+        goto out;
+    }
+    vce->hash_len = cpu_to_be16(qcert.hash_size);
+
+    return 0;
+
+out:
+    g_free(*key_id_data);
+    g_free(*hash_data);
+
+    *key_id_data = NULL;
+    *hash_data = NULL;
+
+    return -1;
+}
+
+static VCEntry *build_vce(S390IPLCertificate qcert, uint32_t vce_len, int idx,
+                          size_t keyid_buf_size, size_t hash_buf_size)
+{
+    VCEntry *vce = NULL;
+    unsigned char *key_id_data = NULL;
+    void *hash_data = NULL;
+    int is_valid = -1;
+    int rc;
+
+    /*
+     * Construct VCE
+     * Unused area following the VCE field contains zeros.
+     */
+    vce = g_malloc0(vce_len);
+
+    rc = diag_320_get_cert_info(vce, qcert, &is_valid, &key_id_data, &hash_data);
+    if (rc) {
+        g_free(vce);
+        return NULL;
+    }
+
+    vce->len = cpu_to_be32(vce_len);
+    vce->cert_idx = cpu_to_be16(idx + 1);
+    vce->cert_len = cpu_to_be32(qcert.size);
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
+    memcpy(vce->cert_buf + keyid_buf_size + hash_buf_size, qcert.raw, qcert.size);
+
+    /* The certificate is valid and VCE contains the certificate */
+    if (is_valid == 0) {
+        vce->flags |= DIAG_320_VCE_FLAGS_VALID;
+    }
+
+    g_free(key_id_data);
+    g_free(hash_data);
+
+    key_id_data = NULL;
+    hash_data = NULL;
+
+    return vce;
+}
+
+static int handle_diag320_store_vc(S390CPU *cpu, uint64_t addr, uint64_t r1, uintptr_t ra,
+                                   S390IPLCertificateStore *qcs)
+{
+    VCBlock *vcb;
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
+        g_free(vcb);
+        return DIAG_320_RC_INVAL_VCB_LEN;
+    }
+
+    if (first_vc_index > last_vc_index) {
+        g_free(vcb);
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
+        cert_buf_size = ROUND_UP(qcert.size, 4);
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
+    g_free(vcb);
+    return DIAG_320_RC_OK;
+}
+
 QEMU_BUILD_BUG_MSG(sizeof(VCStorageSizeBlock) != 128,
                    "size of VCStorageSizeBlock is wrong");
+QEMU_BUILD_BUG_MSG(sizeof(VCBlock) != 64, "size of VCBlock is wrong");
+QEMU_BUILD_BUG_MSG(sizeof(VCEntry) != 128, "size of VCEntry is wrong");
 
 void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
@@ -219,7 +473,7 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
     switch (subcode) {
     case DIAG_320_SUBC_QUERY_ISM:
-        uint64_t ism = cpu_to_be64(DIAG_320_ISM_QUERY_VCSI);
+        uint64_t ism = cpu_to_be64(DIAG_320_ISM_QUERY_VCSI | DIAG_320_ISM_STORE_VC);
 
         if (s390_cpu_virt_mem_write(cpu, addr, r1, &ism, sizeof(ism))) {
             s390_cpu_virt_mem_handle_exc(cpu, ra);
@@ -258,6 +512,12 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
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


