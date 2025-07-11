Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BC5C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 21:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaL1q-0000b8-GB; Fri, 11 Jul 2025 17:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL1f-0000Ps-E1; Fri, 11 Jul 2025 17:11:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uaL1d-0002mT-1H; Fri, 11 Jul 2025 17:11:23 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BJUYOb013022;
 Fri, 11 Jul 2025 21:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Vp47kswcVaXKGtPVZ
 z3nSQzawUpCZT0sUaLk/HKGO1M=; b=eyczcdSwCBjR+ddYyBU9DELFpYSTjhbI6
 VYNEyh7aqPjbE9hNyey1hpHllJ7RZwIVooLg4CIr5j2wH0FAE5a6UWb9yxN4x+F8
 i9CZVhstxfeU+4jB/gL4NhlSN0+c1itgX1YxXsbSl8pgdMcXJ3GLnD0oqxoHBgTW
 WiDB43u3oaq9If4bNrQwH6CP4vP7SYCfPq+tTpq/g5bEJ6ljL5h4L8UOe0F9+PeA
 qe2YxL29AfWNd0iEpQPs0Pw5FwLBt4F+ysfJB7RCY9uGY/C87F6RLtq/KUQ17KMD
 i9EyIifWKbI/1/cj1odRegulU5jxabwY7CBDbbCX2Z0vLJsbudukw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47t3xdk8vs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56BKUHwP003362;
 Fri, 11 Jul 2025 21:11:16 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmvebd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 21:11:16 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56BLBEES14025260
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 21:11:15 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB00E58059;
 Fri, 11 Jul 2025 21:11:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F0C85805C;
 Fri, 11 Jul 2025 21:11:13 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.25.251])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Jul 2025 21:11:13 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, zycai@linux.ibm.com
Subject: [PATCH v4 03/28] hw/s390x/ipl: Create certificate store
Date: Fri, 11 Jul 2025 17:10:39 -0400
Message-ID: <20250711211105.439554-4-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711211105.439554-1-zycai@linux.ibm.com>
References: <20250711211105.439554-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XGwScRuOa6rJG72EweGRNm5hWBo0JSGg
X-Authority-Analysis: v=2.4 cv=MLRgmNZl c=1 sm=1 tr=0 ts=68717df5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=0q5552V7iw1ixI5x2VsA:9
X-Proofpoint-GUID: XGwScRuOa6rJG72EweGRNm5hWBo0JSGg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE1NiBTYWx0ZWRfX3k3eXrOoANdp
 ILMnhHOaXVY5o8j5cKQQwh9YRri+zEJcxpCxOQuamzA4I09nR2Df7KxREyhhk2LHg7VVAeDXFl8
 afrLyLJOhGxRmBnWoagso1cB/1h/QVZYRFg4uVJ3wVkPf8k0mINTmLeArk0AkuObDMZBLM0Ybts
 p3SMK9yL1w3Z3/9GvDaE6ARcnLqkv30ZeHxMpnCoUyyQ7+NkTZOzNjZ4ZQQJfDGdEBHkjZmfIgY
 cvJTF4MSAzzxYVn3EoRuzwSnDZLCI0ISx5sjHFW9UG/O2PlCBiFJdzXPjsvwiR1MNA61mo/ad8j
 xZvLqSgRMWSmvzZOWnaZOi6X1/XQXf6eI0523U1qa6Cye3r+5MFgyWK12pkagdy3wsKjY4A4gpp
 /inrKTO5keFEPpVQFFh1eyqmhy6gCMGf5xxvT9ATzmPnQFAi5x2WTsivwDfcwrOQdpRxhmeD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_06,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
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

Create a certificate store for boot certificates used for secure IPL.

Load certificates from the boot-certificate parameter of s390-ccw-virtio
machine type option into the cert store.

Currently, only X.509 certificates in PEM format are supported, as the
QEMU command line accepts certificates in PEM format only. Additionally,
only the SHA-256 hashing algorithm is supported, as it is required for
secure boot on s390.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/s390x/cert-store.c       | 223 ++++++++++++++++++++++++++++++++++++
 hw/s390x/cert-store.h       |  39 +++++++
 hw/s390x/ipl.c              |   9 ++
 hw/s390x/ipl.h              |   3 +
 hw/s390x/meson.build        |   1 +
 include/hw/s390x/ipl/qipl.h |   2 +
 6 files changed, 277 insertions(+)
 create mode 100644 hw/s390x/cert-store.c
 create mode 100644 hw/s390x/cert-store.h

diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
new file mode 100644
index 0000000000..3b4faa3738
--- /dev/null
+++ b/hw/s390x/cert-store.c
@@ -0,0 +1,223 @@
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
+#include "qapi/error.h"
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
+static size_t cert2buf(char *path, char **cert_buf)
+{
+    size_t size;
+
+    if (!g_file_get_contents(path, cert_buf, &size, NULL) || size == 0) {
+        return 0;
+    }
+
+    return size;
+}
+
+static S390IPLCertificate *init_cert_x509(size_t size, uint8_t *raw)
+{
+    S390IPLCertificate *q_cert = NULL;
+    int key_id_size;
+    int hash_size;
+    int hash_type;
+    Error *err = NULL;
+
+    g_autofree uint8_t *cert_der = NULL;
+    size_t der_len = size;
+    int rc;
+
+    hash_type = qcrypto_x509_get_signature_algorithm(raw, size, &err);
+    if (hash_type == -1) {
+        error_report_err(err);
+        return NULL;
+    }
+    if (hash_type != QCRYPTO_SIG_ALGO_RSA_SHA256) {
+        error_report_err(err);
+        return NULL;
+    }
+
+    key_id_size = qcrypto_x509_get_keyid_len(QCRYPTO_KEYID_FLAGS_SHA256, &err);
+    if (key_id_size == -1) {
+        error_report_err(err);
+        return NULL;
+    }
+
+    hash_size = QCRYPTO_HASH_DIGEST_LEN_SHA256;
+
+    rc = qcrypto_x509_convert_cert_der(raw, size, &cert_der, &der_len, &err);
+    if (rc != 0) {
+        error_report_err(err);
+        return NULL;
+    }
+
+    q_cert = g_new0(S390IPLCertificate, 1);
+    q_cert->size = size;
+    q_cert->der_size = der_len;
+    q_cert->key_id_size = key_id_size;
+    q_cert->hash_size = hash_size;
+    q_cert->raw = raw;
+    q_cert->hash_type = QCRYPTO_SIG_ALGO_RSA_SHA256;
+
+    return q_cert;
+}
+
+static S390IPLCertificate *init_cert(char *path)
+{
+    char *buf;
+    size_t size;
+    char vc_name[VC_NAME_LEN_BYTES];
+    g_autofree gchar *filename = NULL;
+    S390IPLCertificate *qcert = NULL;
+
+    filename = g_path_get_basename(path);
+
+    size = cert2buf(path, &buf);
+    if (size == 0) {
+        error_report("Failed to load certificate: %s", path);
+        g_free(buf);
+        return NULL;
+    }
+
+    qcert = init_cert_x509(size, (uint8_t *)buf);
+    if (qcert == NULL) {
+        error_report("Failed to initialize certificate: %s", path);
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
+    cert_buf_size = ROUND_UP(qcert->der_size, 4);
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
+    const char *paths_list;
+    g_auto(GStrv) paths = NULL;
+    gchar **paths_copy;
+    GDir *dir = NULL;
+    const gchar *filename;
+    g_autoptr(GError) err = NULL;
+    g_autoptr(GPtrArray) cert_path_builder = g_ptr_array_new_full(0, g_free);
+
+    paths_list = s390_get_boot_certificates();
+    if (paths_list == NULL) {
+        return g_steal_pointer(&cert_path_builder);
+    }
+
+    paths = g_strsplit(paths_list, ":", -1);
+
+    paths_copy = paths;
+    while (*paths_copy) {
+        if (!strcmp(*paths_copy, "")) {
+            error_report("Empty path in certificate path list is not allowed");
+            exit(1);
+        }
+
+        struct stat st;
+        if (stat(*paths_copy, &st) != 0) {
+            error_report("Failed to stat path '%s': %s", *paths_copy, g_strerror(errno));
+            exit(1);
+        }
+
+        if (S_ISREG(st.st_mode)) {
+            g_ptr_array_add(cert_path_builder, g_strdup(*paths_copy));
+        } else if (S_ISDIR(st.st_mode)) {
+            dir = g_dir_open(*paths_copy, 0, &err);
+            if (dir == NULL) {
+                error_report("Failed to open directory '%s': %s",
+                             *paths_copy, err->message);
+                exit(1);
+            }
+
+            while ((filename = g_dir_read_name(dir))) {
+                g_ptr_array_add(cert_path_builder,
+                                g_build_filename(*paths_copy, filename, NULL));
+            }
+
+            g_dir_close(dir);
+        } else {
+            error_report("Path '%s' is neither a file nor a directory", *paths_copy);
+        }
+
+        paths_copy += 1;
+    }
+
+    return g_steal_pointer(&cert_path_builder);
+}
+
+void s390_ipl_create_cert_store(S390IPLCertificateStore *cert_store)
+{
+    GPtrArray *cert_path_builder;
+
+    cert_path_builder = get_cert_paths();
+    if (cert_path_builder->len == 0) {
+        g_ptr_array_free(cert_path_builder, TRUE);
+        return;
+    }
+
+    cert_store->max_cert_size = 0;
+    cert_store->total_bytes = 0;
+
+    for (int i = 0; i < cert_path_builder->len; i++) {
+        if (i > MAX_CERTIFICATES - 1) {
+            error_report("Maximum %d certificates are allowed", MAX_CERTIFICATES);
+            exit(1);
+        }
+
+        S390IPLCertificate *qcert = init_cert((char *) cert_path_builder->pdata[i]);
+        if (qcert) {
+            update_cert_store(cert_store, qcert);
+        }
+    }
+
+    g_ptr_array_free(cert_path_builder, TRUE);
+}
diff --git a/hw/s390x/cert-store.h b/hw/s390x/cert-store.h
new file mode 100644
index 0000000000..00a107815b
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
+    size_t  size;
+    size_t  der_size;
+    size_t  key_id_size;
+    size_t  hash_size;
+    uint8_t *raw;
+    QCryptoSigAlgo hash_type;
+};
+typedef struct S390IPLCertificate S390IPLCertificate;
+
+struct S390IPLCertificateStore {
+    uint16_t count;
+    size_t   max_cert_size;
+    size_t   total_bytes;
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
index 8866012ddc..80d3d4a74d 100644
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
index 6824391111..e505f44020 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -20,6 +20,8 @@
 #define LOADPARM_LEN    8
 #define NO_LOADPARM "\0\0\0\0\0\0\0\0"
 
+#define MAX_CERTIFICATES  64
+
 /*
  * The QEMU IPL Parameters will be stored at absolute address
  * 204 (0xcc) which means it is 32-bit word aligned but not
-- 
2.49.0


