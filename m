Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C47AD3B7ED
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 21:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSir0-0007Gn-VE; Mon, 08 Dec 2025 16:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vSiqv-0007DD-2e; Mon, 08 Dec 2025 16:33:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vSiqs-0000cf-0j; Mon, 08 Dec 2025 16:33:03 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8E7clK019356;
 Mon, 8 Dec 2025 21:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=7JgKHNDWz7vOUDagX
 zg1pdAXNQYqH5uZn8slKjHNTq0=; b=Qvc6iEPb5VQJq6esmNnMGwPjWmzUQfrZW
 KHYx4GSEONiSRi/tHaTf8oYU6nkU8AI2UeCLIdqiuBxH8nE0sTEZBpfugnlc9Rir
 CFc8sL+cZ/qbsu3Tn0nwCWcHOWQkKxba/hp0r7Kbn6fDtNAL5AiPSZPo4EvKqPVf
 uM+g8OlMkWdcFK9S2GcMK75MBocV8F0KqoT7T529ezhGdpAWbOObwyKGV9SEfpLh
 WTDDc4iKsg5zFAB2VaPWVVhgVRAThKhmahl71AhGmFZKNPoPfPy6qXtZqio4aLPN
 CfMCwrxnTAsuX3QF+klFn0y+Meq/Z9PtBM068qHU8a5+548q01L8A==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4av9wvhmky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 21:33:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B8Jnmpu026799;
 Mon, 8 Dec 2025 21:32:59 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aw1h0yf83-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Dec 2025 21:32:59 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5B8LWvqu35193572
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Dec 2025 21:32:57 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B24155805C;
 Mon,  8 Dec 2025 21:32:57 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9A7C58059;
 Mon,  8 Dec 2025 21:32:55 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.66.246])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Dec 2025 21:32:55 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, zycai@linux.ibm.com, alifm@linux.ibm.com
Subject: [PATCH v7 04/29] hw/s390x/ipl: Create certificate store
Date: Mon,  8 Dec 2025 16:32:21 -0500
Message-ID: <20251208213247.702569-5-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251208213247.702569-1-zycai@linux.ibm.com>
References: <20251208213247.702569-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OqUc6Zc485mucELUT3ExVNhP4S7JPFVo
X-Proofpoint-ORIG-GUID: OqUc6Zc485mucELUT3ExVNhP4S7JPFVo
X-Authority-Analysis: v=2.4 cv=AdS83nXG c=1 sm=1 tr=0 ts=6937440c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=6ph8WD7lSjxTzuMCr3kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAwMCBTYWx0ZWRfX/Y/DdZT4l3G5
 ONplcI8OB9aIHj8pYM+wFrGVtb81l9oOSFeye8WTDdd2XoC1f0Rx8chc7z62LaSm8BpaLls8lmW
 oZ+BmK6jN/PVy8Vp1GX4ISgPLmCdnNRLx5LPlTvxWP229Mkwv5oveMoL6jkDV5mWP3PCxRpVVBK
 LPAEwz/X9+HLxvjVFtod3N5OywMSaicG0LBuw4jQodo8Pii1HJeJvdsXK+GKUfYmo2Pj8uQxbDw
 oGFp9rEDY6LcPDcbb5XmlX3R3KPFDb5PVLhgEo1HLyE2lPfLA2Qq9kWEZQIC1D6T/UCZ3TfvmVg
 78hNDny1EjONZ+GAiIohzbor/g3jf1Smymv30AeE4J8zrMQ/44j/6W/OX1ihE1eljRn51fVZfN7
 tfrWA1CYZBTB0MBnEggDDOaXh1qs0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060000
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

Create a certificate store for boot certificates used for secure IPL.

Load certificates from the `boot-certs` parameter of s390-ccw-virtio
machine type option into the cert store.

Currently, only X.509 certificates in PEM format are supported, as the
QEMU command line accepts certificates in PEM format only.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 docs/specs/s390x-secure-ipl.rst |  16 +++
 hw/s390x/cert-store.c           | 211 ++++++++++++++++++++++++++++++++
 hw/s390x/cert-store.h           |  41 +++++++
 hw/s390x/ipl.c                  |  19 +++
 hw/s390x/ipl.h                  |   3 +
 hw/s390x/meson.build            |   1 +
 include/hw/s390x/ipl/qipl.h     |   2 +
 7 files changed, 293 insertions(+)
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
index 0000000000..cf16911d09
--- /dev/null
+++ b/hw/s390x/cert-store.c
@@ -0,0 +1,211 @@
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
+static S390IPLCertificate *init_cert_x509(size_t size, uint8_t *raw, Error **errp)
+{
+    S390IPLCertificate *cert = NULL;
+    g_autofree uint8_t *cert_der = NULL;
+    size_t der_len = size;
+    int rc;
+
+    rc = qcrypto_x509_convert_cert_der(raw, size, &cert_der, &der_len, errp);
+    if (rc != 0) {
+        return NULL;
+    }
+
+    cert = g_new0(S390IPLCertificate, 1);
+    cert->size = size;
+    cert->der_size = der_len;
+    /* store raw pointer - ownership transfers to cert */
+    cert->raw = raw;
+
+    return cert;
+}
+
+static S390IPLCertificate *init_cert(char *path, Error **errp)
+{
+    char *buf;
+    size_t size;
+    char vc_name[VC_NAME_LEN_BYTES];
+    g_autofree gchar *filename = NULL;
+    S390IPLCertificate *cert = NULL;
+    Error *local_err = NULL;
+
+    filename = g_path_get_basename(path);
+
+    if (!g_file_get_contents(path, &buf, &size, NULL)) {
+        error_setg(errp, "Failed to load certificate: %s", path);
+        return NULL;
+    }
+
+    cert = init_cert_x509(size, (uint8_t *)buf, &local_err);
+    if (cert == NULL) {
+        error_propagate_prepend(errp, local_err,
+                                "Failed to initialize certificate: %s: ", path);
+        g_free(buf);
+        return NULL;
+    }
+
+    /*
+     * Left justified certificate name with padding on the right with blanks.
+     * Convert certificate name to EBCDIC.
+     */
+    strpadcpy(vc_name, VC_NAME_LEN_BYTES, filename, ' ');
+    ebcdic_put(cert->vc_name, vc_name, VC_NAME_LEN_BYTES);
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
+    if (cert_store->max_cert_size < data_buf_size) {
+        cert_store->max_cert_size = data_buf_size;
+    }
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
+    g_autoptr(GError) err = NULL;
+    g_autoptr(GPtrArray) cert_path_builder = g_ptr_array_new_full(0, g_free);
+
+    path_list = s390_get_boot_certs();
+    if (path_list == NULL) {
+        return g_steal_pointer(&cert_path_builder);
+    }
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
+            while ((filename = g_dir_read_name(dir))) {
+                if (g_str_has_suffix(filename, ".pem")) {
+                    g_ptr_array_add(cert_path_builder,
+                                    g_build_filename(cert_path, filename, NULL));
+                }
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
+    cert_store->max_cert_size = 0;
+    cert_store->total_bytes = 0;
+
+    for (int i = 0; i < cert_path_builder->len; i++) {
+        S390IPLCertificate *cert = init_cert((char *) cert_path_builder->pdata[i], &err);
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
index 0000000000..17a945a147
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
+#define VC_NAME_LEN_BYTES  64
+
+#define CERT_KEY_ID_LEN    QCRYPTO_HASH_DIGEST_LEN_SHA256
+#define CERT_HASH_LEN      QCRYPTO_HASH_DIGEST_LEN_SHA256
+
+struct S390IPLCertificate {
+    uint8_t vc_name[VC_NAME_LEN_BYTES];
+    size_t  size;
+    size_t  der_size;
+    uint8_t *raw;
+};
+typedef struct S390IPLCertificate S390IPLCertificate;
+
+struct S390IPLCertificateStore {
+    uint16_t count;
+    size_t   max_cert_size;
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
index 3843d2a850..38d5fff154 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -35,6 +35,7 @@
 #include "qemu/option.h"
 #include "qemu/ctype.h"
 #include "standard-headers/linux/virtio_ids.h"
+#include "cert-store.h"
 
 #define KERN_IMAGE_START                0x010000UL
 #define LINUX_MAGIC_ADDR                0x010008UL
@@ -424,6 +425,20 @@ void s390_ipl_convert_loadparm(char *ascii_lp, uint8_t *ebcdic_lp)
     }
 }
 
+S390IPLCertificateStore *s390_ipl_get_certificate_store(void)
+{
+    S390IPLState *ipl = get_ipl_device();
+
+    return &ipl->cert_store;
+}
+
+static bool s390_has_certificate(void)
+{
+    S390IPLState *ipl = get_ipl_device();
+
+    return ipl->cert_store.count > 0;
+}
+
 static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
 {
     CcwDevice *ccw_dev = NULL;
@@ -719,6 +734,10 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
 
     if (!ipl->kernel || ipl->iplb_valid) {
         cpu->env.psw.addr = ipl->bios_start_addr;
+        /* initialize cert store if it's empty */
+        if (!s390_has_certificate()) {
+            s390_ipl_create_cert_store(&ipl->cert_store);
+        }
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
2.51.1


