Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4DCC5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 21:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMw73-0002e5-Uf; Wed, 04 Jun 2025 17:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw6v-0002cg-DO; Wed, 04 Jun 2025 17:57:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uMw6q-0006wH-VK; Wed, 04 Jun 2025 17:57:23 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554LBx0t028760;
 Wed, 4 Jun 2025 21:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=x6lygRMpcxLD9i/Cv
 D2vTBpHXoyBGvg+2K+01Jspap8=; b=gQe9PLPcJgmWpkVYipX95JUxV+PKndj8i
 4Kvzw1S5LLH0q8v7IZm6BzTQTU6zxRehvYq4P0simurQ/wUFcvR5GzGaRYBaCRp8
 bc5lVmFefqR3KSMVCjQddPNRxHeee0Hh3pTugcjI1nBEaTyrs28yUSxsZb0n0mg8
 jNnuXHNT/vuh8y1NItcxjjQCjyoUKHi4qRR3xifrrEhRKhxJsD9AB23rYfplLYyJ
 18x009h8X28VkHMbmwztNaNpvLjlg3Cv7Vv6UrVekAX+fc14rPp+t0J2tkkYK2PC
 c7xEk05FsDBaZDGbINRgIshi5PT4O+JX01pYRFk3LTVAqfFrDf7Gg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyddp5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 554JnwPJ019903;
 Wed, 4 Jun 2025 21:57:16 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470d3p1ur4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 21:57:16 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 554LvEg127329212
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Jun 2025 21:57:15 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7F2058054;
 Wed,  4 Jun 2025 21:57:14 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E962658045;
 Wed,  4 Jun 2025 21:57:12 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.211])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Jun 2025 21:57:12 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v3 03/28] hw/s390x/ipl: Create certificate store
Date: Wed,  4 Jun 2025 17:56:31 -0400
Message-ID: <20250604215657.528142-4-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604215657.528142-1-zycai@linux.ibm.com>
References: <20250604215657.528142-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=6840c13d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=NJSLarCcS8mpxalkhPMA:9
X-Proofpoint-GUID: E4sjkZ00zZ950ru3f5TdNFT428sCVkPn
X-Proofpoint-ORIG-GUID: E4sjkZ00zZ950ru3f5TdNFT428sCVkPn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDE3NSBTYWx0ZWRfXyiCszGXYoRie
 HPPVhLwYh+SkGXTnWCd2iWTS02pj2Vf01TSyr3zN78H3gP7C+1olP1kkYCh2KBeCQQHqsoBMfFY
 4F338JCB0wRMmrcpgfXz8k/Cmj9aMgc8jRc1fbWLj5fhjwa2WVwfCO9gjmU8y5PKDuABVwumZbY
 rF1fXqy4B0aNuO4MP6kupUd+0HvEBm8p6S0DvmtGtt5oobPnkuGiFtRQXT90k90ZBJsbcgDAtso
 4vdThgOAHPp+MZ/GnSSFIcViEoYlgKZ89AiAZg1ud16ReQfCRCNQqxtszi3mGuVmagveQxW1+nr
 hKMa4kuXQsU7r775DA6zIbCSOePkALKIKV3+kh/HK2M4jKGVwrXuPA1OWCiDj0eU9SN5TezU8iy
 65UXh0vA5oQNCKh+B6b1PjetxDTqyKruqDwxJAGja2SqU+Si+gGwNoj37DT5NWcChRKgcgn6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_04,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
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

Create a certificate store for boot certificates used for secure IPL.

Load certificates from the boot-certificate parameter of s390-ccw-virtio
machine type option into the cert store.

Currently, only x509 certificates in DER format and uses SHA-256 hashing
algorithm are supported, as these are the types required for secure boot
on s390.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/s390x/cert-store.c       | 247 ++++++++++++++++++++++++++++++++++++
 hw/s390x/cert-store.h       |  39 ++++++
 hw/s390x/ipl.c              |   9 ++
 hw/s390x/ipl.h              |   3 +
 hw/s390x/meson.build        |   1 +
 include/hw/s390x/ipl/qipl.h |   3 +
 6 files changed, 302 insertions(+)
 create mode 100644 hw/s390x/cert-store.c
 create mode 100644 hw/s390x/cert-store.h

diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
new file mode 100644
index 0000000000..562fa22241
--- /dev/null
+++ b/hw/s390x/cert-store.c
@@ -0,0 +1,247 @@
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
+
+    /*
+     * maximum allowed size of the certificate file to avoid consuming excessive memory
+     * (malformed or maliciously large files)
+     */
+    if (!g_file_get_contents(path, cert_buf, &size, NULL) ||
+        size == 0 || size > max_size) {
+        return 0;
+    }
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
+        return NULL;
+    }
+    if (is_der != 0) {
+        error_report("The certificate is not in DER format");
+        return NULL;
+    }
+
+    hash_type = qcrypto_get_x509_signature_algorithm((uint8_t *)raw, size, &err);
+    if (hash_type != QCRYPTO_SIG_ALGO_RSA_SHA256) {
+        error_report("The certificate does not use SHA-256 hashing");
+        return NULL;
+    }
+
+    key_id_size = qcrypto_get_x509_keyid_len(QCRYPTO_KEYID_FLAGS_SHA256);
+    if (key_id_size == 0) {
+        error_report("Failed to get certificate key ID size");
+        return NULL;
+    }
+
+    hash_size = qcrypto_get_x509_hash_len(QCRYPTO_HASH_ALGO_SHA256);
+    if (hash_size == 0) {
+        error_report("Failed to get certificate hash size");
+        return NULL;
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
+        g_free(buf);
+        return NULL;
+    }
+
+    qcert = init_cert_x509_der(size, buf);
+    if (qcert == NULL) {
+        error_report("Failed to initialize certificate: %s", paths);
+        g_free(buf);
+        return NULL;
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
+        if (i > MAX_CERTIFICATES - 1) {
+            printf("Warning: Maximum %d certificates are allowed,"
+                            " ignoring certificate #%d and beyond\n",
+                            MAX_CERTIFICATES, i + 1);
+            break;
+        }
+
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
index 8f83c7da29..bee72dfbb3 100644
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
@@ -64,6 +66,7 @@ struct S390IPLState {
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
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 6824391111..2232b88049 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -20,6 +20,9 @@
 #define LOADPARM_LEN    8
 #define NO_LOADPARM "\0\0\0\0\0\0\0\0"
 
+#define MAX_CERTIFICATES  64
+#define CERT_MAX_SIZE     (1024 * 8)
+
 /*
  * The QEMU IPL Parameters will be stored at absolute address
  * 204 (0xcc) which means it is 32-bit word aligned but not
-- 
2.49.0


