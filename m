Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3048EEEA851
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 20:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqdXq-0000da-3F; Thu, 12 Feb 2026 15:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdXo-0000bx-BY; Thu, 12 Feb 2026 15:44:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vqdXm-0007ON-1Q; Thu, 12 Feb 2026 15:44:12 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CD80Il3201530; Thu, 12 Feb 2026 20:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Lpt8LXZpW10c7Apx6
 BK1eNbikZCtHYu3JGVkXhJ74Ng=; b=o/RGluuvY2Q9TLkUW2lwd54PJmKUlw6rx
 2xmiwm6R6MZmezsGD5TGZS7K4i/GFqNCDL4ow49IkSa8JnIU78IsapMCfkMYOt5m
 w2hKxgYqvvZNZgcKNnFF9/rBIEYeECm/BtfHQX9CYDs8dwnuYMkPd9qVb9X0hTas
 jd87ANCn1C3t8xOhpXCbpa7IvZ/gj+idzgXr54Am5pONmhulivZk9wonFkT853AW
 IXhEHbEOp4GNhHt7aD2Da2GKnpjgdxhxHTXLSWqNUr9wfn2TnEwNAyKF63Piy1ZT
 E5zgp0/Img4BjNXHUy/HNrHmb0+NZdKy38JeMHquFRVgR7eYMW01A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696wg4kk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61CI0dKN012626;
 Thu, 12 Feb 2026 20:44:04 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6h7km13v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Feb 2026 20:44:04 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61CKhgSe28050118
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Feb 2026 20:43:42 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E29185804E;
 Thu, 12 Feb 2026 20:44:02 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2595C58056;
 Thu, 12 Feb 2026 20:44:01 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.112.15])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Feb 2026 20:44:01 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com,
 brueckner@linux.ibm.com
Subject: [PATCH v8 04/30] hw/s390x/ipl: Create certificate store
Date: Thu, 12 Feb 2026 15:43:25 -0500
Message-ID: <20260212204352.1044699-5-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212204352.1044699-1-zycai@linux.ibm.com>
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=698e3b95 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=6ph8WD7lSjxTzuMCr3kA:9
X-Proofpoint-GUID: RrHZWjDI8DMvoGmZ8A05-mtCIAm90Lus
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDE1NyBTYWx0ZWRfX7QVu8cJEIHck
 C9OnkZMec/mL+QIJ6Vi9W9QDA1u3w7m/uMGWlxqnclZpg6vYE/uroMN/TxDSVNR4JQ2WbYIcAs5
 3kfkr5xhQXK4mZrtqsitEojG855WKWIhQo/yefaMGlISPIqKV/sMEpZFn5UUKAneib2mRCvK84J
 oeNk4MrKUSgHCg100GhxiJTQpqQB3kgu/la9v3Vb4WjedBHQEti1t5YVGDdN2FGkBcKeYMuadve
 m/0OMWWxGk+SlxRwnQLce1bCgIrpmy5vzSjYzVZ/cL5qkZxzm7HKc1c+8wv0KPKSr+zPsPcWpzf
 /FqTdFiWHLCslvlcehRfWBi/AYqrqVP2tXESdFGkSnl/FcsWgbccAXnPufzoGl3O0lzu5J8v8ha
 WJE4osxrDUyhdduuahdRhcD/FfgNhJLNkQFIj6zwd4S/jye2a91Z3ZJe1UpPOrDmKdykLExBgEF
 uTxhEjbNJ9CQMlj7Ssw==
X-Proofpoint-ORIG-GUID: RrHZWjDI8DMvoGmZ8A05-mtCIAm90Lus
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120157
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Create a certificate store for boot certificates used for secure IPL.

Load certificates from the `boot-certs` parameter of s390-ccw-virtio
machine type option into the cert store.

Currently, only X.509 certificates in PEM format are supported, as the
QEMU command line accepts certificates in PEM format only.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 docs/specs/s390x-secure-ipl.rst |  16 +++
 hw/s390x/cert-store.c           | 221 ++++++++++++++++++++++++++++++++
 hw/s390x/cert-store.h           |  41 ++++++
 hw/s390x/ipl.c                  |  10 ++
 hw/s390x/ipl.h                  |   3 +
 hw/s390x/meson.build            |   1 +
 include/hw/s390x/ipl/qipl.h     |   2 +
 7 files changed, 294 insertions(+)
 create mode 100644 docs/specs/s390x-secure-ipl.rst
 create mode 100644 hw/s390x/cert-store.c
 create mode 100644 hw/s390x/cert-store.h

diff --git a/docs/specs/s390x-secure-ipl.rst b/docs/specs/s390x-secure-ipl.rst
new file mode 100644
index 0000000000..7ddac98a37
--- /dev/null
+++ b/docs/specs/s390x-secure-ipl.rst
@@ -0,0 +1,16 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+s390 Certificate Store and Functions
+====================================
+
+s390 Certificate Store
+----------------------
+
+A certificate store is implemented for s390-ccw guests to retain within
+memory all certificates provided by the user via the command-line, which
+are expected to be stored somewhere on the host's file system. The store
+will keep track of the number of certificates, their respective size,
+and a summation of the sizes.
+
+Note: A maximum of 64 certificates are allowed to be stored in the certificate
+store.
diff --git a/hw/s390x/cert-store.c b/hw/s390x/cert-store.c
new file mode 100644
index 0000000000..f642d50795
--- /dev/null
+++ b/hw/s390x/cert-store.c
@@ -0,0 +1,221 @@
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
+#include "qapi/qapi-types-machine-s390x.h"
+
+static BootCertificatesList *s390_get_boot_certs(void)
+{
+    return S390_CCW_MACHINE(qdev_get_machine())->boot_certs;
+}
+
+static S390IPLCertificate *init_cert(char *path, Error **errp)
+{
+    int rc;
+    char *buf;
+    size_t size;
+    size_t der_len;
+    char name[CERT_NAME_MAX_LEN];
+    g_autofree gchar *filename = NULL;
+    S390IPLCertificate *cert = NULL;
+    g_autofree uint8_t *cert_der = NULL;
+    Error *local_err = NULL;
+
+    filename = g_path_get_basename(path);
+
+    if (!g_file_get_contents(path, &buf, &size, NULL)) {
+        error_setg(errp, "Failed to load certificate: %s", path);
+        return NULL;
+    }
+
+    rc = qcrypto_x509_convert_cert_der((uint8_t *)buf, size,
+                                       &cert_der, &der_len, &local_err);
+    if (rc != 0) {
+        error_propagate_prepend(errp, local_err,
+                                "Failed to initialize certificate: %s: ", path);
+        g_free(buf);
+        return NULL;
+    }
+
+    cert = g_new0(S390IPLCertificate, 1);
+    cert->size = size;
+    /*
+     * Store DER length only - reused for size calculation.
+     * cert_der is discarded because DER certificate data will be used once
+     * and can be regenerated from cert->raw.
+     */
+    cert->der_size = der_len;
+    /* store raw pointer - ownership transfers to cert */
+    cert->raw = (uint8_t *)buf;
+
+    /*
+     * Left justified certificate name with padding on the right with blanks.
+     * Convert certificate name to EBCDIC.
+     */
+    strpadcpy(name, CERT_NAME_MAX_LEN, filename, ' ');
+    ebcdic_put(cert->name, name, CERT_NAME_MAX_LEN);
+
+    return cert;
+}
+
+static void update_cert_store(S390IPLCertificateStore *cert_store,
+                              S390IPLCertificate *cert)
+{
+    size_t data_buf_size;
+    size_t keyid_buf_size;
+    size_t hash_buf_size;
+    size_t cert_buf_size;
+
+    /* length field is word aligned for later DIAG use */
+    keyid_buf_size = ROUND_UP(CERT_KEY_ID_LEN, 4);
+    hash_buf_size = ROUND_UP(CERT_HASH_LEN, 4);
+    cert_buf_size = ROUND_UP(cert->der_size, 4);
+    data_buf_size = keyid_buf_size + hash_buf_size + cert_buf_size;
+
+    if (cert_store->largest_cert_size < data_buf_size) {
+        cert_store->largest_cert_size = data_buf_size;
+    }
+
+    g_assert(cert_store->count < MAX_CERTIFICATES);
+
+    cert_store->certs[cert_store->count] = *cert;
+    cert_store->total_bytes += data_buf_size;
+    cert_store->count++;
+}
+
+static GPtrArray *get_cert_paths(Error **errp)
+{
+    struct stat st;
+    BootCertificatesList *path_list = NULL;
+    BootCertificatesList *list = NULL;
+    gchar *cert_path;
+    GDir *dir = NULL;
+    const gchar *filename;
+    bool is_empty;
+    g_autoptr(GError) err = NULL;
+    g_autoptr(GPtrArray) cert_path_builder = g_ptr_array_new_full(0, g_free);
+
+    path_list = s390_get_boot_certs();
+
+    for (list = path_list; list; list = list->next) {
+        cert_path = list->value->path;
+
+        if (g_strcmp0(cert_path, "") == 0) {
+            error_setg(errp, "Empty path in certificate path list is not allowed");
+            goto fail;
+        }
+
+        if (stat(cert_path, &st) != 0) {
+            error_setg(errp, "Failed to stat path '%s': %s",
+                       cert_path, g_strerror(errno));
+            goto fail;
+        }
+
+        if (S_ISREG(st.st_mode)) {
+            if (!g_str_has_suffix(cert_path, ".pem")) {
+                error_setg(errp, "Certificate file '%s' must have a .pem extension",
+                           cert_path);
+                goto fail;
+            }
+
+            g_ptr_array_add(cert_path_builder, g_strdup(cert_path));
+        } else if (S_ISDIR(st.st_mode)) {
+            dir = g_dir_open(cert_path, 0, &err);
+            if (dir == NULL) {
+                error_setg(errp, "Failed to open directory '%s': %s",
+                           cert_path, err->message);
+
+                goto fail;
+            }
+
+            is_empty = true;
+            while ((filename = g_dir_read_name(dir))) {
+                is_empty = false;
+
+                if (g_str_has_suffix(filename, ".pem")) {
+                    g_ptr_array_add(cert_path_builder,
+                                    g_build_filename(cert_path, filename, NULL));
+                } else {
+                    warn_report("skipping '%s': not a .pem file", filename);
+                }
+            }
+
+            if (is_empty) {
+                warn_report("'%s' directory is empty", cert_path);
+            }
+
+            g_dir_close(dir);
+        } else {
+            error_setg(errp, "Path '%s' is neither a file nor a directory", cert_path);
+            goto fail;
+        }
+    }
+
+    qapi_free_BootCertificatesList(path_list);
+    return g_steal_pointer(&cert_path_builder);
+
+fail:
+    qapi_free_BootCertificatesList(path_list);
+    return NULL;
+}
+
+void s390_ipl_create_cert_store(S390IPLCertificateStore *cert_store)
+{
+    GPtrArray *cert_path_builder;
+    Error *err = NULL;
+
+    /* If cert store is already populated, then no work to do */
+    if (cert_store->count) {
+        return;
+    }
+
+    cert_path_builder = get_cert_paths(&err);
+    if (cert_path_builder == NULL) {
+        error_report_err(err);
+        exit(1);
+    }
+
+    if (cert_path_builder->len == 0) {
+        g_ptr_array_free(cert_path_builder, TRUE);
+        return;
+    }
+
+    if (cert_path_builder->len > MAX_CERTIFICATES - 1) {
+        error_report("Cert store exceeds maximum of %d certificates", MAX_CERTIFICATES);
+        g_ptr_array_free(cert_path_builder, TRUE);
+        exit(1);
+    }
+
+    cert_store->largest_cert_size = 0;
+    cert_store->total_bytes = 0;
+
+    for (int i = 0; i < cert_path_builder->len; i++) {
+        g_autofree S390IPLCertificate *cert = init_cert(
+                                              (char *) cert_path_builder->pdata[i],
+                                              &err);
+        if (!cert) {
+            error_report_err(err);
+            g_ptr_array_free(cert_path_builder, TRUE);
+            exit(1);
+        }
+
+        update_cert_store(cert_store, cert);
+    }
+
+    g_ptr_array_free(cert_path_builder, TRUE);
+}
diff --git a/hw/s390x/cert-store.h b/hw/s390x/cert-store.h
new file mode 100644
index 0000000000..50e36e2389
--- /dev/null
+++ b/hw/s390x/cert-store.h
@@ -0,0 +1,41 @@
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
+#define CERT_NAME_MAX_LEN  64
+
+#define CERT_KEY_ID_LEN    QCRYPTO_HASH_DIGEST_LEN_SHA256
+#define CERT_HASH_LEN      QCRYPTO_HASH_DIGEST_LEN_SHA256
+
+struct S390IPLCertificate {
+    uint8_t name[CERT_NAME_MAX_LEN];
+    size_t  size;
+    size_t  der_size;
+    uint8_t *raw;
+};
+typedef struct S390IPLCertificate S390IPLCertificate;
+
+struct S390IPLCertificateStore {
+    uint16_t count;
+    size_t   largest_cert_size;
+    size_t   total_bytes;
+    S390IPLCertificate certs[MAX_CERTIFICATES];
+};
+typedef struct S390IPLCertificateStore S390IPLCertificateStore;
+QEMU_BUILD_BUG_MSG(sizeof(S390IPLCertificateStore) != 5656,
+                   "size of S390IPLCertificateStore is wrong");
+
+void s390_ipl_create_cert_store(S390IPLCertificateStore *cert_store);
+
+#endif
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index d34adb5522..ea108fe370 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -36,6 +36,7 @@
 #include "qemu/option.h"
 #include "qemu/ctype.h"
 #include "standard-headers/linux/virtio_ids.h"
+#include "cert-store.h"
 
 #define KERN_IMAGE_START                0x010000UL
 #define LINUX_MAGIC_ADDR                0x010008UL
@@ -425,6 +426,13 @@ void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
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
@@ -718,6 +726,8 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
     cpu->env.psw.addr = ipl->start_addr;
     cpu->env.psw.mask = IPL_PSW_MASK;
 
+    s390_ipl_create_cert_store(&ipl->cert_store);
+
     if (!ipl->kernel || ipl->iplb_valid) {
         cpu->env.psw.addr = ipl->bios_start_addr;
         if (!ipl->iplb_valid) {
diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
index 85be03de1b..0c773ac8ce 100644
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
2.52.0


