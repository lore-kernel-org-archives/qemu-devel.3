Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1964E606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EJ+qSrqM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOasw-00071F-Od; Wed, 04 Nov 2026 08:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOasu-00070c-Uh
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 08:18:36 -0500
Received: from out-141.mta0.migadu.com ([2001:41d0:1004:224b::8d]
 helo=mta0.migadu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <junjie.cao@linux.dev>)
 id 1xOast-0002yk-2f
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 08:18:36 -0500
X-Envelope-To: qemu-devel@nongnu.org
DKIM-Signature: a=rsa-sha256; bh=1GkPIVi5R/OHW4MKMzCWp4ii2U9UH3X7izv3DNUmMYo=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793798312; v=1; x=1794403112;
 b=EJ+qSrqMaiB2TDvh/Psg2aLvGuBZZD0/LBAgvkGco3FTQD0wEC4qwoPvNydrLMWTw89YCBfA
 w6zeEONedaPk1sWstQUiYvtxfD9Pa0XAkSovWJXuOoJczh3GxkNewRHCpapRvEk2Ntinp0nPeBi
 4AJ+yWxg+/F+UlmL8bJiy4Fs=
X-Envelope-To: qemu-devel@nongnu.org
Received: by smtp.migadu.com with ESMTPS id a44c55cd4cdfb42f;
 Wed, 04 Nov 2026 13:18:32 +0000
X-Mizu-Trace-ID: a44c55cd4cdfb42f
X-Migadu-Flow: FLOW_OUT
From: Junjie Cao <junjie.cao@linux.dev>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, philmd@oss.qualcomm.com,
 zhao1.liu@intel.com, richard.henderson@linaro.org, farosas@suse.de,
 lvivier@redhat.com, pierrick.bouvier@oss.qualcomm.com, thuth@redhat.com,
 peter.maydell@linaro.org, kraxel@redhat.com, berrange@redhat.com,
 marcandre.lureau@redhat.com, deller@gmx.de, clg@redhat.com,
 jamin_lin@aspeedtech.com, junjie.cao@linux.dev
Subject: [RFC PATCH 3/4] tests/qtest: check which host controller -usb creates
 on pc and q35
Date: Wed,  4 Nov 2026 07:18:09 -0600
Message-ID: <20261104131810.2063834-4-junjie.cao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104131810.2063834-1-junjie.cao@linux.dev>
References: <20261104131810.2063834-1-junjie.cao@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:1004:224b::8d;
 envelope-from=junjie.cao@linux.dev; helo=mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Run query-pci on the pc and q35 aliases, the 12.0 and the 11.2 types.
With -usb the former two pairs get qemu-xhci at 1d.0, the 11.2 ones
PIIX3 UHCI and ICH9 EHCI plus companions; without -usb there is no
USB controller.

Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
---
 tests/qtest/meson.build           |   3 +
 tests/qtest/usb-pc-default-test.c | 135 ++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 tests/qtest/usb-pc-default-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index ff4bf9528a..615056876d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -91,6 +91,9 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_USB_UHCI') and                                        \
    config_all_devices.has_key('CONFIG_USB_EHCI') ? ['usb-hcd-ehci-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_USB_XHCI_NEC') ? ['usb-hcd-xhci-test'] : []) +        \
+  (config_all_devices.has_key('CONFIG_USB_UHCI') and                                        \
+   config_all_devices.has_key('CONFIG_USB_EHCI_PCI') and                                    \
+   config_all_devices.has_key('CONFIG_USB_XHCI_PCI') ? ['usb-pc-default-test'] : []) +      \
   (config_all_devices.has_key('CONFIG_TPM_CRB') ? ['tpm-crb-test'] : []) +                  \
   (config_all_devices.has_key('CONFIG_TPM_CRB') ? ['tpm-crb-swtpm-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_TPM_TIS_ISA') ? ['tpm-tis-test'] : []) +              \
diff --git a/tests/qtest/usb-pc-default-test.c b/tests/qtest/usb-pc-default-test.c
new file mode 100644
index 0000000000..060e9bc469
--- /dev/null
+++ b/tests/qtest/usb-pc-default-test.c
@@ -0,0 +1,135 @@
+/*
+ * Which USB host controller -usb creates on the pc and q35 machines
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_ids.h"
+
+typedef struct {
+    int slot, func;
+    uint16_t vendor, device;
+} Controller;
+
+typedef struct {
+    const char *machine;
+    bool usb;
+    const char *const *devices;
+    const Controller *ctrl;
+    size_t n;
+} TestCase;
+
+static const Controller piix3_uhci[] = {
+    { 1, 2, PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371SB_2 },
+};
+
+static const Controller xhci[] = {
+    { 0x1d, 0, PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_XHCI },
+};
+
+static const Controller ich9_ehci[] = {
+    { 0x1d, 0, PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801I_UHCI1 },
+    { 0x1d, 1, PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801I_UHCI2 },
+    { 0x1d, 2, PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801I_UHCI3 },
+    { 0x1d, 7, PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801I_EHCI1 },
+};
+
+/* host controller types a case needs, in case the build left them out */
+static const char *const xhci_dev[] = { "qemu-xhci", NULL };
+static const char *const piix3_dev[] = { "piix3-usb-uhci", NULL };
+static const char *const ich9_dev[] = { "ich9-usb-ehci1", "ich9-usb-uhci1",
+                                        NULL };
+
+static const TestCase cases[] = {
+    { "pc", true, xhci_dev, xhci, ARRAY_SIZE(xhci) },
+    { "q35", true, xhci_dev, xhci, ARRAY_SIZE(xhci) },
+    { "pc-i440fx-12.0", true, xhci_dev, xhci, ARRAY_SIZE(xhci) },
+    { "pc-q35-12.0", true, xhci_dev, xhci, ARRAY_SIZE(xhci) },
+    { "pc-i440fx-11.2", true, piix3_dev, piix3_uhci, ARRAY_SIZE(piix3_uhci) },
+    { "pc-q35-11.2", true, ich9_dev, ich9_ehci, ARRAY_SIZE(ich9_ehci) },
+    { "pc", false, NULL, NULL, 0 },
+    { "q35", false, NULL, NULL, 0 },
+};
+
+static bool has_devices(const char *const *devices)
+{
+    for (; devices && *devices; devices++) {
+        if (!qtest_has_device(*devices)) {
+            return false;
+        }
+    }
+    return true;
+}
+
+static void test_usb_controllers(const void *data)
+{
+    const TestCase *tc = data;
+    QTestState *qts = qtest_initf(tc->usb ? "-M %s -usb" : "-M %s",
+                                  tc->machine);
+    QDict *resp = qtest_qmp(qts, "{ 'execute': 'query-pci' }");
+    QList *buses = qdict_get_qlist(resp, "return");
+    QListEntry *be, *de;
+    size_t found = 0;
+
+    QLIST_FOREACH_ENTRY(buses, be) {
+        QDict *bus = qobject_to(QDict, qlist_entry_obj(be));
+        QList *devices = qdict_get_qlist(bus, "devices");
+
+        QLIST_FOREACH_ENTRY(devices, de) {
+            QDict *dev = qobject_to(QDict, qlist_entry_obj(de));
+            QDict *id = qdict_get_qdict(dev, "id");
+            int slot = qdict_get_int(dev, "slot");
+            int func = qdict_get_int(dev, "function");
+            int vendor = qdict_get_int(id, "vendor");
+            int device = qdict_get_int(id, "device");
+            size_t i;
+
+            if (qdict_get_int(qdict_get_qdict(dev, "class_info"), "class") !=
+                PCI_CLASS_SERIAL_USB) {
+                continue;
+            }
+            for (i = 0; i < tc->n; i++) {
+                if (tc->ctrl[i].slot == slot && tc->ctrl[i].func == func) {
+                    break;
+                }
+            }
+            if (i == tc->n) {
+                g_test_message("unexpected USB controller %02x.%x %04x:%04x",
+                               slot, func, vendor, device);
+                g_assert_not_reached();
+            }
+            g_assert_cmpint(vendor, ==, tc->ctrl[i].vendor);
+            g_assert_cmpint(device, ==, tc->ctrl[i].device);
+            found++;
+        }
+    }
+    g_assert_cmpuint(found, ==, tc->n);
+
+    qobject_unref(resp);
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    size_t i;
+
+    g_test_init(&argc, &argv, NULL);
+    for (i = 0; i < ARRAY_SIZE(cases); i++) {
+        static const char *const kind[] = { "no-usb", "usb" };
+        g_autofree char *path = NULL;
+
+        if (!qtest_has_machine(cases[i].machine) ||
+            !has_devices(cases[i].devices)) {
+            continue;
+        }
+        path = g_strdup_printf("/usb/pc-default/%s/%s", kind[cases[i].usb],
+                               cases[i].machine);
+        qtest_add_data_func(path, &cases[i], test_usb_controllers);
+    }
+    return g_test_run();
+}
-- 
2.43.0


