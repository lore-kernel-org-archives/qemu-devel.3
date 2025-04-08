Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A359C369A2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 16:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Bdq-0006p6-Uy; Tue, 08 Apr 2025 12:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BIj-0005Vz-3H; Tue, 08 Apr 2025 11:55:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BIg-0005tI-Pc; Tue, 08 Apr 2025 11:55:48 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538E0270028245;
 Tue, 8 Apr 2025 15:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0ABvkjyLIBjEGrfnV
 63GsR9H9yligSh3cdqmq76173g=; b=OVipzHtyci5bJyxBTj7LeCq5xGyRKPNFL
 4uu7uGqLt6XuzXgrCf8q7v1Fc1sgDfdutGjg1e2UVYb1QoKL6olEqkOG9hmV5K7p
 tchr59x7PatzA3QiNwtShxCWXb5TNeRSpEbOAXEw7OyqIsPWG5k/bIFz8W64RLmR
 plQLBgdAHfm0Kv94nTP9xdgZgDw+zDEdsG8KCO8/E5hBOUxW8JdvHWmq9WcxXhQZ
 gyg+RkDwIVQXozmbm4/mnqjOOohiOv33UZfBi70hSC4LyJq8rZGlVyAMEVAmZ+Ig
 45pYJnOqGYOKJ43QTil0BoAmqaadrda/IUm62Jz45xSgdtNNBPjRg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vv6a3amf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:55:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538CBO1S013925;
 Tue, 8 Apr 2025 15:55:43 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufunkb9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:55:42 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 538Ftfgi30409274
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 15:55:41 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 734185804E;
 Tue,  8 Apr 2025 15:55:41 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA5CD58054;
 Tue,  8 Apr 2025 15:55:39 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.125.94])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Apr 2025 15:55:39 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v1 07/24] s390x/diag: Implement DIAG 320 subcode 2
Date: Tue,  8 Apr 2025 11:55:09 -0400
Message-ID: <20250408155527.123341-8-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408155527.123341-1-zycai@linux.ibm.com>
References: <20250408155527.123341-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 514Xlc-YbLKOwrfgG1YYB8fACBAB00XO
X-Proofpoint-GUID: 514Xlc-YbLKOwrfgG1YYB8fACBAB00XO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 suspectscore=0 bulkscore=0 mlxlogscore=865 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080107
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 08 Apr 2025 12:17:33 -0400
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

DIAG 320 subcode 2 provides certificates that are in the
certificate store.

The subcode value is denoted by setting the second-left-most bit
of an 8-byte field.

The verification-certificate-block (VCB) contains the output data
when the operation completes successfully. VCB includes a common
header followed by zero or more verification-certificate entries (VCEs).

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 include/hw/s390x/ipl/diag320.h |  59 +++++++++
 target/s390x/diag.c            | 227 ++++++++++++++++++++++++++++++++-
 2 files changed, 285 insertions(+), 1 deletion(-)

diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
index ded336df25..32b6914b3b 100644
--- a/include/hw/s390x/ipl/diag320.h
+++ b/include/hw/s390x/ipl/diag320.h
@@ -14,15 +14,24 @@
 
 #define DIAG_320_SUBC_QUERY_ISM     0
 #define DIAG_320_SUBC_QUERY_VCSI    1
+#define DIAG_320_SUBC_STORE_VC      2
 
 #define DIAG_320_RC_OK              0x0001
 #define DIAG_320_RC_NOMEM           0x0202
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
 
 struct VerificationCertificateStorageSizeBlock {
     uint32_t length;
@@ -41,4 +50,54 @@ struct VerificationCertificateStorageSizeBlock {
 typedef struct VerificationCertificateStorageSizeBlock \
 VerificationCertificateStorageSizeBlock;
 
+struct vcb_header {
+    uint32_t vcbinlen;
+    uint32_t reserved0;
+    uint16_t fvci;
+    uint16_t lvci;
+    uint32_t reserved1;
+    uint32_t cstoken;
+    uint32_t reserved2[3];
+    uint32_t vcboutlen;
+    uint8_t reserved3[3];
+    uint8_t version;
+    uint16_t svcc;
+    uint16_t rvcc;
+    uint32_t reserved4[5];
+} QEMU_PACKED;
+typedef struct vcb_header vcb_header;
+
+struct VerficationCertificateBlock {
+    vcb_header vcb_hdr;
+    uint8_t vcb_buf[];
+} QEMU_PACKED;
+typedef struct VerficationCertificateBlock VerficationCertificateBlock;
+
+struct vce_header {
+    uint32_t len;
+    uint8_t flags;
+    uint8_t keytype;
+    uint16_t certidx;
+    uint32_t name[16];
+    uint8_t format;
+    uint8_t reserved0;
+    uint16_t keyidlen;
+    uint8_t reserved1;
+    uint8_t hashtype;
+    uint16_t hashlen;
+    uint32_t reserved2;
+    uint32_t certlen;
+    uint32_t reserved3[2];
+    uint16_t hashoffset;
+    uint16_t certoffset;
+    uint32_t reserved4[7];
+} QEMU_PACKED;
+typedef struct vce_header vce_header;
+
+struct VerificationCertificateEntry {
+    vce_header vce_hdr;
+    uint8_t cert_data_buf[];
+} QEMU_PACKED;
+typedef struct VerificationCertificateEntry VerificationCertificateEntry;
+
 #endif
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index cc639819ec..82e4dc9e1e 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -17,6 +17,7 @@
 #include "s390x-internal.h"
 #include "hw/watchdog/wdt_diag288.h"
 #include "system/cpus.h"
+#include "hw/s390x/cert-store.h"
 #include "hw/s390x/ipl.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "system/kvm.h"
@@ -191,6 +192,94 @@ out:
     }
 }
 
+#ifdef CONFIG_GNUTLS
+static bool diag_320_is_cert_valid(gnutls_x509_crt_t cert)
+{
+    time_t now;
+
+    if (gnutls_x509_crt_get_version(cert) < 0) {
+        return false;
+    }
+
+    now = time(0);
+    if (!((gnutls_x509_crt_get_activation_time(cert) < now) &&
+         (gnutls_x509_crt_get_expiration_time(cert) > now))) {
+        return false;
+    }
+
+    return true;
+}
+#endif /* CONFIG_GNUTLS */
+
+static int diag_320_get_cert_info(VerificationCertificateEntry *vce,
+                                 S390IPLCertificate qcert, bool *is_valid,
+                                 unsigned char **key_id_data, void **hash_data)
+{
+#ifdef CONFIG_GNUTLS
+    unsigned int algo;
+    unsigned int bits;
+    int hash_type;
+    int rc;
+
+    gnutls_x509_crt_t g_cert = NULL;
+    if (g_init_cert((uint8_t *)qcert.raw, qcert.size, &g_cert)) {
+        return -1;
+    }
+
+    /* VCE flag (validity) */
+    *is_valid = diag_320_is_cert_valid(g_cert);
+
+    /* key-type */
+    algo = gnutls_x509_crt_get_pk_algorithm(g_cert, &bits);
+    if (algo == GNUTLS_PK_RSA) {
+        vce->vce_hdr.keytype = DIAG_320_VCE_KEYTYPE_SELF_DESCRIBING;
+    }
+
+    /* VC format */
+    if (qcert.format == GNUTLS_X509_FMT_DER) {
+        vce->vce_hdr.format = DIAG_320_VCE_FORMAT_X509_DER;
+    }
+
+    /* key id and key id len */
+    *key_id_data = g_malloc0(qcert.key_id_size);
+    rc = gnutls_x509_crt_get_key_id(g_cert, GNUTLS_KEYID_USE_SHA256,
+                                    *key_id_data, &qcert.key_id_size);
+    if (rc < 0) {
+        error_report("Fail to retrieve certificate key ID");
+        goto out;
+    }
+    vce->vce_hdr.keyidlen = (uint16_t)qcert.key_id_size;
+
+    /* hash type */
+    hash_type = gnutls_x509_crt_get_signature_algorithm(g_cert);
+    if (hash_type == GNUTLS_SIGN_RSA_SHA256) {
+        vce->vce_hdr.hashtype = DIAG_320_VCE_HASHTYPE_SHA2_256;
+    }
+
+    /* hash and hash len */
+    *hash_data = g_malloc0(qcert.hash_size);
+    rc = gnutls_x509_crt_get_fingerprint(g_cert, GNUTLS_DIG_SHA256,
+                                            *hash_data, &qcert.hash_size);
+    if (rc < 0) {
+        error_report("Fail to retrieve certificate hash");
+        goto out;
+    }
+    vce->vce_hdr.hashlen = (uint16_t)qcert.hash_size;
+
+    gnutls_x509_crt_deinit(g_cert);
+
+    return 0;
+out:
+    gnutls_x509_crt_deinit(g_cert);
+    g_free(*key_id_data);
+    g_free(*hash_data);
+
+    return -1;
+#else
+    return -1;
+#endif /* CONFIG_GNUTLS */
+}
+
 void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     S390CPU *cpu = env_archcpu(env);
@@ -211,7 +300,7 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 
     switch (subcode) {
     case DIAG_320_SUBC_QUERY_ISM:
-        uint64_t ism = DIAG_320_ISM_QUERY_VCSI;
+        uint64_t ism = DIAG_320_ISM_QUERY_VCSI | DIAG_320_ISM_STORE_VC;
 
         if (s390_cpu_virt_mem_write(cpu, addr, (uint8_t)r1, &ism,
                                     be64_to_cpu(sizeof(ism)))) {
@@ -257,6 +346,142 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
         }
         rc = DIAG_320_RC_OK;
         break;
+    case DIAG_320_SUBC_STORE_VC:
+        VerficationCertificateBlock *vcb;
+        size_t vce_offset = VCB_HEADER_LEN;
+        size_t remaining_space;
+        size_t vce_hdr_offset;
+        int i;
+
+        unsigned char *key_id_data = NULL;
+        void *hash_data = NULL;
+        bool is_valid = false;
+
+        vcb = g_new0(VerficationCertificateBlock, 1);
+        if (s390_cpu_virt_mem_read(cpu, addr, (uint8_t)r1, vcb, sizeof(*vcb))) {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
+            return;
+        }
+
+        if (vcb->vcb_hdr.vcbinlen % 4096 != 0) {
+            rc = DIAG_320_RC_INVAL_VCB_LEN;
+            g_free(vcb);
+            break;
+        }
+
+        if (1 > vcb->vcb_hdr.fvci || vcb->vcb_hdr.fvci > vcb->vcb_hdr.lvci) {
+            rc = DIAG_320_RC_BAD_RANGE;
+            g_free(vcb);
+            break;
+        }
+
+        vcb->vcb_hdr.vcboutlen = VCB_HEADER_LEN;
+        vcb->vcb_hdr.version = 0;
+        vcb->vcb_hdr.svcc = 0;
+        vcb->vcb_hdr.rvcc = 0;
+
+        remaining_space = vcb->vcb_hdr.vcbinlen - VCB_HEADER_LEN;
+
+        for (i = vcb->vcb_hdr.fvci - 1; i < vcb->vcb_hdr.lvci; i++) {
+            VerificationCertificateEntry vce;
+            S390IPLCertificate qcert;
+
+            /*
+             * If cert index goes beyond the highest cert
+             * store index (count - 1), then exit early
+             */
+            if (i >= qcs->count) {
+                break;
+            }
+
+            qcert = qcs->certs[i];
+
+            /*
+             * If there is no more space to store the cert,
+             * set the remaining verification cert count and
+             * break early.
+             */
+            if (remaining_space < qcert.size) {
+                vcb->vcb_hdr.rvcc = vcb->vcb_hdr.lvci - i;
+                break;
+            }
+
+            /* Construct VCE */
+            vce.vce_hdr.len = VCE_HEADER_LEN;
+            vce.vce_hdr.certidx = i + 1;
+            vce.vce_hdr.certlen = qcert.size;
+
+            strncpy((char *)vce.vce_hdr.name, (char *)qcert.vc_name, VC_NAME_LEN_BYTES);
+
+            rc = diag_320_get_cert_info(&vce, qcert, &is_valid, &key_id_data, &hash_data);
+            if (rc) {
+                continue;
+            }
+
+            vce.vce_hdr.len += vce.vce_hdr.keyidlen;
+            vce.vce_hdr.len += vce.vce_hdr.hashlen;
+            vce.vce_hdr.len += vce.vce_hdr.certlen;
+
+            vce.vce_hdr.hashoffset = VCE_HEADER_LEN + vce.vce_hdr.keyidlen;
+            vce.vce_hdr.certoffset = VCE_HEADER_LEN + vce.vce_hdr.keyidlen +
+                                     vce.vce_hdr.hashlen;
+
+            vce_hdr_offset = vce_offset;
+            vce_offset += VCE_HEADER_LEN;
+
+            /* Write Key ID */
+            if (s390_cpu_virt_mem_write(cpu, addr + vce_offset, (uint8_t)r1, key_id_data,
+                                        be16_to_cpu(vce.vce_hdr.keyidlen))) {
+                s390_cpu_virt_mem_handle_exc(cpu, ra);
+                return;
+            }
+            vce_offset += vce.vce_hdr.keyidlen;
+
+            /* Write Hash key */
+            if (s390_cpu_virt_mem_write(cpu, addr + vce_offset, (uint8_t)r1, hash_data,
+                                        be16_to_cpu(vce.vce_hdr.hashlen))) {
+                s390_cpu_virt_mem_handle_exc(cpu, ra);
+                return;
+            }
+             vce_offset += vce.vce_hdr.hashlen;
+
+            /* Write VCE cert data */
+            if (s390_cpu_virt_mem_write(cpu, addr + vce_offset, (uint8_t)r1, qcert.raw,
+                                        be32_to_cpu(vce.vce_hdr.certlen))) {
+                s390_cpu_virt_mem_handle_exc(cpu, ra);
+                return;
+            }
+            vce_offset += qcert.size;
+
+            /* The certificate is valid and VCE contains the certificate */
+            if (is_valid) {
+                vce.vce_hdr.flags |= DIAG_320_VCE_FLAGS_VALID;
+            }
+
+            /* Write VCE Header */
+            if (s390_cpu_virt_mem_write(cpu, addr + vce_hdr_offset, (uint8_t)r1, &vce,
+                                        be32_to_cpu(VCE_HEADER_LEN))) {
+                s390_cpu_virt_mem_handle_exc(cpu, ra);
+                return;
+            }
+
+            vcb->vcb_hdr.vcboutlen += vce.vce_hdr.len;
+            remaining_space -= vce.vce_hdr.len;
+            vcb->vcb_hdr.svcc++;
+
+            g_free(key_id_data);
+            g_free(hash_data);
+        }
+
+        /* Finally, write the header */
+        if (s390_cpu_virt_mem_write(cpu, addr, (uint8_t)r1, vcb,
+                                    be32_to_cpu(VCB_HEADER_LEN))) {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
+            return;
+        }
+        rc = DIAG_320_RC_OK;
+        g_free(vcb);
+        break;
     default:
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
         return;
-- 
2.49.0


