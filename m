Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513A5C369A6
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 16:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Bdq-0006ox-0P; Tue, 08 Apr 2025 12:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BIb-0005Tl-1U; Tue, 08 Apr 2025 11:55:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1u2BIY-0005rP-9n; Tue, 08 Apr 2025 11:55:40 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538CS1sa017173;
 Tue, 8 Apr 2025 15:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ovmlXm7ClsfXbt/dK
 D7g5N9R734cctuQU1guVoEJlUk=; b=hEQL6x72hiLuY2H6oxs7jvsPjRmm5xitm
 2QaFXvEtRc5agi1HJURZpOcklw8Zq4KaaKqLDHKqBSZd12huuNUyNlgvC5MN9JV5
 GJof/FThNU9ld6xV75ytUMVdz/FhBtWFh3TJCnsO2/VJW8YXjpgWUmVNyFoLgleV
 vqNayCH/MX+ibgL8wvWU2+i32C3/oEdkuBtY6oGPVvsscTlsEX0GPblHxK05J948
 KzUg9vQbOYaFZkSRAWmUHNgvipG63fJjXAFDxWm+yI5ax96ueR070Zum/EF6OoSa
 b6CYGj1T90Hnq+/YO8LsxdGa8cAyMornhm6dZQq46ZR0ai0+evEUQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45w3u3122t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:55:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538CBO1R013925;
 Tue, 8 Apr 2025 15:55:34 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ufunkb9k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 15:55:34 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 538FtXtV17695246
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 15:55:33 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44EAA5803F;
 Tue,  8 Apr 2025 15:55:33 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C779B5804E;
 Tue,  8 Apr 2025 15:55:31 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.125.94])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  8 Apr 2025 15:55:31 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v1 02/24] hw/s390x/ipl: Create certificate store
Date: Tue,  8 Apr 2025 11:55:04 -0400
Message-ID: <20250408155527.123341-3-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408155527.123341-1-zycai@linux.ibm.com>
References: <20250408155527.123341-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RFPq93mGWkidBa_TUaSisaHwFKV8eLQs
X-Proofpoint-ORIG-GUID: RFPq93mGWkidBa_TUaSisaHwFKV8eLQs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 priorityscore=1501 phishscore=0
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

Create a certificate store for boot certificates used for secure IPL.

Load certificates from the -boot-certificate option into the cert store.

Currently, only x509 certificates in DER format and uses SHA-256 hashing
algorithm are supported, as these are the types required for secure boot
on s390.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/s390x/cert-store.c       | 249 ++++++++++++++++++++++++++++++++++++
 hw/s390x/cert-store.h       |  50 ++++++++
 hw/s390x/ipl.c              |   9 ++
 hw/s390x/ipl.h              |   3 +
 hw/s390x/meson.build        |   1 +
 include/hw/s390x/ipl/qipl.h |   3 +
 6 files changed, 315 insertions(+)
 create mode 100644 hw/s390x/cert-store.c
 create mode 100644 hw/s390x/cert-store.h

diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
new file mode 100644
index 0000000000..1aa8aea040
--- /dev/null
+++ b/hw/s390x/cert-store.c
@@ -0,0 +1,249 @@
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
+#include "qemu/cutils.h"
+#include "cert-store.h"
+
+#ifdef CONFIG_GNUTLS
+#include <gnutls/x509.h>
+#include <gnutls/gnutls.h>
+#endif /* #define CONFIG_GNUTLS */
+
+static const char *s390_get_boot_certificates(void)
+{
+    QemuOpts *opts;
+    const char *path;
+
+    opts = qemu_find_opts_singleton("boot-certificates");
+    path = qemu_opt_get(opts, "boot-certificates");
+
+    return path;
+}
+
+static size_t cert2buf(char *path, size_t max_size, char **cert_buf)
+{
+    size_t size;
+    g_autofree char *buf;
+    buf = g_malloc(max_size);
+
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
+#ifdef CONFIG_GNUTLS
+int g_init_cert(uint8_t *raw_cert, size_t cert_size, gnutls_x509_crt_t *g_cert)
+{
+    int rc;
+
+    if (gnutls_x509_crt_init(g_cert) < 0) {
+        return -1;
+    }
+
+    gnutls_datum_t datum_cert = {raw_cert, cert_size};
+    rc = gnutls_x509_crt_import(*g_cert, &datum_cert, GNUTLS_X509_FMT_DER);
+    if (rc) {
+        gnutls_x509_crt_deinit(*g_cert);
+        return rc;
+    }
+
+    return 0;
+}
+#endif /* CONFIG_GNUTLS */
+
+static int init_cert_x509_der(size_t size, char *raw, S390IPLCertificate **qcert)
+{
+#ifdef CONFIG_GNUTLS
+    gnutls_x509_crt_t g_cert = NULL;
+    g_autofree S390IPLCertificate *q_cert;
+    size_t key_id_size;
+    size_t hash_size;
+    int rc;
+
+    rc = g_init_cert((uint8_t *)raw, size, &g_cert);
+    if (rc) {
+        if (rc == GNUTLS_E_ASN1_TAG_ERROR) {
+            error_report("The certificate is not in DER format");
+        }
+        return -1;
+    }
+
+    rc = gnutls_x509_crt_get_key_id(g_cert, GNUTLS_KEYID_USE_SHA256, NULL, &key_id_size);
+    if (rc != GNUTLS_E_SHORT_MEMORY_BUFFER) {
+        error_report("Failed to get certificate key ID size");
+        goto out;
+    }
+
+    rc = gnutls_x509_crt_get_fingerprint(g_cert, GNUTLS_DIG_SHA256, NULL, &hash_size);
+    if (rc != GNUTLS_E_SHORT_MEMORY_BUFFER) {
+        error_report("Failed to get certificate hash size");
+        goto out;
+    }
+
+    q_cert = g_malloc(sizeof(*q_cert));
+    q_cert->size = size;
+    q_cert->key_id_size = key_id_size;
+    q_cert->hash_size = hash_size;
+    q_cert->raw = raw;
+    q_cert->format = GNUTLS_X509_FMT_DER;
+    *qcert = g_steal_pointer(&q_cert);
+
+    gnutls_x509_crt_deinit(g_cert);
+
+    return 0;
+out:
+    gnutls_x509_crt_deinit(g_cert);
+    return -1;
+#else
+    error_report("Cryptographic library is not enabled")
+    return -1;
+#endif /* #define CONFIG_GNUTLS */
+}
+
+static int check_path_type(const char *path)
+{
+    struct stat path_stat;
+
+    stat(path, &path_stat);
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
+static int init_cert(char *paths, S390IPLCertificate **qcert)
+{
+    char *buf;
+    char vc_name[VC_NAME_LEN_BYTES];
+    const gchar *filename;
+    size_t size;
+
+    filename = g_path_get_basename(paths);
+
+    size = cert2buf(paths, CERT_MAX_SIZE, &buf);
+    if (size == 0) {
+        error_report("Failed to load certificate: %s", paths);
+        return -1;
+    }
+
+    if (init_cert_x509_der(size, buf, qcert) < 0) {
+        error_report("Failed to initialize certificate: %s", paths);
+        return -1;
+    }
+
+    /*
+     * Left justified certificate name with padding on the right with blanks.
+     * Convert certificate name to EBCDIC.
+     */
+    strpadcpy(vc_name, VC_NAME_LEN_BYTES, filename, ' ');
+    ebcdic_put((*qcert)->vc_name, vc_name, VC_NAME_LEN_BYTES);
+
+    return 0;
+}
+
+static void update_cert_store(S390IPLCertificateStore *cert_store,
+                              S390IPLCertificate *qcert)
+{
+    size_t data_size;
+
+    data_size = qcert->size + qcert->key_id_size + qcert->hash_size;
+
+    if (cert_store->max_cert_size < data_size) {
+        cert_store->max_cert_size = data_size;
+    }
+
+    cert_store->certs[cert_store->count] = *qcert;
+    cert_store->total_bytes += data_size;
+    cert_store->count++;
+}
+
+static GPtrArray *get_cert_paths(void)
+{
+    const char *path;
+    gchar **paths;
+    int path_type;
+    GDir *dir = NULL;
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
+    while (*paths) {
+        /* skip empty certificate path */
+        if (!strcmp(*paths, "")) {
+            paths += 1;
+            continue;
+        }
+
+        path_type = check_path_type(*paths);
+        if (path_type == S_IFREG) {
+            g_ptr_array_add(cert_path_builder, (gpointer) *paths);
+        } else if (path_type == S_IFDIR) {
+            dir = g_dir_open(*paths, 0, NULL);
+
+            while ((filename = g_dir_read_name(dir))) {
+                gchar *cert_path = NULL;
+                cert_path = g_build_filename(*paths, filename, NULL);
+                g_ptr_array_add(cert_path_builder, (gpointer) cert_path);
+            }
+
+            g_dir_close(dir);
+        }
+
+        paths += 1;
+    }
+
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
+        S390IPLCertificate *qcert = NULL;
+        if (init_cert((char *) cert_path_builder->pdata[i], &qcert) < 0) {
+            continue;
+        }
+
+        update_cert_store(cert_store, qcert);
+    }
+
+    g_ptr_array_free(cert_path_builder, true);
+}
diff --git a/hw/s390x/cert-store.h b/hw/s390x/cert-store.h
new file mode 100644
index 0000000000..80141c07da
--- /dev/null
+++ b/hw/s390x/cert-store.h
@@ -0,0 +1,50 @@
+/*
+ * S390 certificate store
+ *
+ * Copyright 2025 IBM Corp.
+ * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef HW_S390_CERT_STORE_H
+#define HW_S390_CERT_STORE_H
+
+#include "hw/s390x/ipl/qipl.h"
+
+#ifdef CONFIG_GNUTLS
+#include <gnutls/x509.h>
+#include <gnutls/gnutls.h>
+#endif /* #define CONFIG_GNUTLS */
+
+#define VC_NAME_LEN_BYTES  64
+
+struct S390IPLCertificate {
+    uint8_t vc_name[VC_NAME_LEN_BYTES];
+    size_t size;
+    size_t key_id_size;
+    size_t hash_size;
+    char *raw;
+#ifdef CONFIG_GNUTLS
+    gnutls_x509_crt_fmt_t format;
+#endif /* #define CONFIG_GNUTLS */
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
+#ifdef CONFIG_GNUTLS
+int g_init_cert(uint8_t *raw_cert, size_t cert_size, gnutls_x509_crt_t *g_cert);
+#endif /* #define CONFIG_GNUTLS */
+
+void s390_ipl_create_cert_store(S390IPLCertificateStore *cert_store);
+
+#endif
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index ce6f6078d7..b0810c9191 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -36,6 +36,7 @@
 #include "qemu/option.h"
 #include "qemu/ctype.h"
 #include "standard-headers/linux/virtio_ids.h"
+#include "cert-store.h"
 
 #define KERN_IMAGE_START                0x010000UL
 #define LINUX_MAGIC_ADDR                0x010008UL
@@ -423,6 +424,13 @@ void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
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
@@ -716,6 +724,7 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
 
     if (!ipl->kernel || ipl->iplb_valid) {
         cpu->env.psw.addr = ipl->bios_start_addr;
+        s390_ipl_create_cert_store(&ipl->cert_store);
         if (!ipl->iplb_valid) {
             ipl->iplb_valid = s390_init_all_iplbs(ipl);
         } else {
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 8e3882d506..8c2a442255 100644
--- a/hw/s390x/ipl.h
+++ b/hw/s390x/ipl.h
@@ -13,6 +13,7 @@
 #ifndef HW_S390_IPL_H
 #define HW_S390_IPL_H
 
+#include "cert-store.h"
 #include "cpu.h"
 #include "exec/address-spaces.h"
 #include "hw/qdev-core.h"
@@ -31,6 +32,7 @@ int s390_ipl_pv_unpack(void);
 void s390_ipl_prepare_cpu(S390CPU *cpu);
 IplParameterBlock *s390_ipl_get_iplb(void);
 IplParameterBlock *s390_ipl_get_iplb_pv(void);
+S390IPLCertificateStore *s390_ipl_get_certificate_store(void);
 
 enum s390_reset {
     /* default is a reset not triggered by a CPU e.g. issued by QMP */
@@ -59,6 +61,7 @@ struct S390IPLState {
     IplParameterBlock iplb;
     IplParameterBlock iplb_pv;
     QemuIplParameters qipl;
+    S390IPLCertificateStore cert_store;
     uint64_t start_addr;
     uint64_t compat_start_addr;
     uint64_t bios_start_addr;
diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
index 610b29bf76..8f0cfaa056 100644
--- a/hw/s390x/meson.build
+++ b/hw/s390x/meson.build
@@ -16,6 +16,7 @@ s390x_ss.add(files(
   'sclpcpu.c',
   'sclpquiesce.c',
   'tod.c',
+  'cert-store.c',
 ))
 s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
   'tod-kvm.c',
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
-- 
2.49.0


