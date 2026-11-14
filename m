Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157B3606A327
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 15:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSG8P-0006Jt-4A; Sat, 14 Nov 2026 10:57:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSG8C-0006If-EW; Sat, 14 Nov 2026 10:57:33 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSG8A-0002nF-PT; Sat, 14 Nov 2026 10:57:32 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwDnHKXohPhqqR0qBg--.63775S2; 
 Sat, 14 Nov 2026 23:57:28 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwBHXWhPhqctv6AA--.37503S3;
 Sat, 14 Nov 2026 23:57:11 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 30/35] hw/pci: Add sec-sid property to PCIDevice
Date: Sat, 14 Nov 2026 23:57:08 +0800
Message-Id: <20261114155708.3615176-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwBHXWhPhqctv6AA--.37503S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWr3ZUsBTQAAso
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxGrWfJr1UGFyxXF4rZF45Awb_yoWrXF43pF
 Z5Ca4FyrWkGa4fKwsIva1xCF1rWan7K3yYkrW29w1DCF17Ar9Yqw4YkFWY9F18urWvqF1Y
 934UZFykuw1UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Arm SMMUv3 uses a SEC_SID (StreamID Security state) to determine the
security state of the programming interface that controls a transaction.
The architecture explicitly states that the association between a device
and its SEC_SID is a system-defined property, not something derived from
the physical address space.

We need a way to represent this system-defined SEC_SID for PCI devices
if we want to implement SMMU's Secure state. So that SMMUv3 can select
the correct register bank and configuration when handling their streams.

This patch adds a new char *sec_sid field to PCIDevice, together with
a "sec-sid" QOM property. The property is intended to carry the
platform-defined SEC_SID for the device; for now only Non-secure and
Secure security states are supported.

Validate the property in the PCI setter, accepting only the
case-sensitive strings "non-secure" and "secure". Reject other values
with an error when the property is set, so invalid values are caught
in the PCI layer before reaching an SMMU.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 include/hw/pci/pci_device.h |  3 +++
 hw/pci/pci.c                | 48 +++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 5cac6e16886..6e6c49fdd19 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -187,6 +187,9 @@ struct PCIDevice {
     uint32_t max_bounce_buffer_size;
 
     char *sriov_pf;
+
+    /* Arm SMMU SEC_SID */
+    char *sec_sid;
 };
 
 static inline int pci_intx(PCIDevice *pci_dev)
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d8b117799f3..c0ca836fce9 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -51,6 +51,7 @@
 #include "hw/core/boards.h"
 #include "hw/nvram/fw_cfg.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "qemu/cutils.h"
 #include "pci-internal.h"
 #include "qapi/qapi-builtin-type-infos.h"
@@ -86,6 +87,46 @@ static const PropertyInfo prop_pci_busnr = {
     .get = prop_pci_busnr_get,
 };
 
+static void prop_pci_sec_sid_get(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    qdev_prop_string.get(obj, v, name, opaque, errp);
+}
+
+static void prop_pci_sec_sid_set(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    PCIDevice *dev = PCI_DEVICE(obj);
+    g_autofree char *value = NULL;
+
+    if (!visit_type_str(v, name, &value, errp)) {
+        return;
+    }
+
+    if (strcmp(value, "non-secure") && strcmp(value, "secure")) {
+        error_setg(errp, "Invalid %s value '%s'; "
+                   "expected 'non-secure' or 'secure'", name, value);
+        return;
+    }
+
+    g_free(dev->sec_sid);
+    dev->sec_sid = g_steal_pointer(&value);
+}
+
+static void prop_pci_sec_sid_release(Object *obj, const char *name,
+                                    void *opaque)
+{
+    qdev_prop_string.release(obj, name, opaque);
+}
+
+static const PropertyInfo prop_pci_sec_sid = {
+    .type = "str",
+    .qapi_type = &str_type_info,
+    .get = prop_pci_sec_sid_get,
+    .set = prop_pci_sec_sid_set,
+    .release = prop_pci_sec_sid_release,
+};
+
 static const Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
@@ -107,6 +148,13 @@ static const Property pci_props[] = {
     DEFINE_PROP_STRING("sriov-pf", PCIDevice, sriov_pf),
     DEFINE_PROP_BIT("x-pcie-ext-tag", PCIDevice, cap_present,
                     QEMU_PCIE_EXT_TAG_BITNR, true),
+
+    /*
+     * System-defined, statically configured SEC_SID for this PCI device, used
+     * by Arm SMMU. Only support "non-secure" and "secure" security states.
+     */
+    DEFINE_PROP("sec-sid", PCIDevice, sec_sid, prop_pci_sec_sid, char *),
+
     { .name = "busnr", .info = &prop_pci_busnr },
 };
 
-- 
2.34.1


