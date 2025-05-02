Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F65C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAh7m-0004CS-DM; Thu, 01 May 2025 23:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh7R-000494-7p
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:31:23 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAh7M-0001F6-2z
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:31:18 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7376dd56eccso1884005b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746156674; x=1746761474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+1L16zdFQs77EwxEGySwBuyx2+iOaiRonGPqPDTCnPA=;
 b=B0Y2MHLknax4czKs/tULUZcQ+qDOVpMwkN6L8IWQ5JJFFJGYK4A+v4EyvX0YU7uoUz
 ctoy1GX2/gNdFsImn4ip4AfD7uKzDJ5bQL2nhMwnboT76Uy96Ywpry438r5s7VghwfHq
 bPl+mdAl3BI+fMg8mqfnCH+6jPPOj11TY2RJnj3Oaf4yuQLoGFxVNF027LWw3ViwxzC1
 tsjDqC7qaRdmv8DRNI10RijpAzEJZrMX2sbjdqr02DhmpF2yJz+LKktwbo4BMDuiqgnK
 LaSzRIf4SIeBEB511MmES/fWUpgZiOl1IBSBkOyOpwaau69lKjEYiRErxxEZTA7mnppC
 1EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746156674; x=1746761474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+1L16zdFQs77EwxEGySwBuyx2+iOaiRonGPqPDTCnPA=;
 b=GqrQu75G/B5sBcFiPX9B1T8wTU7O3PK4VksLr7UqIrSlchBRc1YOEp7/upyLyF7EGt
 Nl/BzDQt8iIEVhZ+pliiiFz2IpBMz3onXkcaFoWzTwrto9jD2I8/H5hhiurl9XSW1U8q
 mD9H+Jl4TEKs1nF4hkWubKbNilI68/d/Zj25MBb7NmpL1Sv1Udlg2IyJy3lzHl94TJUp
 VELz3uItCMb7m88tTnP/gGmo5e+6eXO/jW5NUleIb+N4tso/AwU77ZGxDxmA7KNbNPRr
 aklSvlWEohSKFUGCYu3Fpm5QS5SucsqdoOR/OZO1NR000rVKvG4TlbMJoaRC7YDPvrEs
 HtxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSyKXI07E4AMX9M1gRiBQSayPVWtSkE8dS3nIvJrEFn2sVm5Zt1RLWCD+51orNZqjNgjPz/0LuKoqa@nongnu.org
X-Gm-Message-State: AOJu0YwXIu99mJXOC3MPl1EYhb7MLqaj8ZACKJ1hc855GO4H5Ni4mbsh
 0k20huCo8FH/rNDFiYOQU3rsVAHJ9PfFDvKCgoH9qWyK50Vid/u6
X-Gm-Gg: ASbGncvKMZVgZJ0BRz+nx6iknmvTRQOcYhrPO/BLICh9yfJUc1DSMltwwCK6oNXjM3F
 xwuI7P8T53zimpLBljgS7kHC8x1uC9jvGXsbrQBXMgDeddkbbItlH+jtvrXdLyAgwfGwgFPpiwo
 zJZWS2uuLTxQK4GDT3iV67ir5EiezmHLJiR1xOcYyF0+asvSk2WxjeM9p2w9jZy+BAI8sDmQ0GW
 dXX8lTMao4+TJBuC7xAu+cMEkguNp9dMAkinVvDSYQy7w8Z/TWzJ5wXo7rsSKxUVbHyelyZoukI
 mrES19wyV4RtKLhOU5EbVir7bdI3ZRCb0Xw/TJPgvX8TOabcssmmpuk=
X-Google-Smtp-Source: AGHT+IF2ygvBhapplJ2/l9wvnLvHz6gJJsBuV+BPWjqxd1zsL2B0vwZagCqqbVhV+BOvIEkQIGlDjA==
X-Received: by 2002:a05:6a20:c6cb:b0:1f5:64fd:68ea with SMTP id
 adf61e73a8af0-20cde46cd69mr1986468637.4.1746156674097; 
 Thu, 01 May 2025 20:31:14 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059063f6esm488055b3a.139.2025.05.01.20.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:31:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 03/22] tests/qtest/xhci: test the qemu-xhci device
Date: Fri,  2 May 2025 13:30:27 +1000
Message-ID: <20250502033047.102465-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502033047.102465-1-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add support in the test code for running multiple drivers, and add
tests for the qemu-xhci device.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/usb-hcd-xhci-test.c | 190 +++++++++++++++++++++++++++++---
 1 file changed, 176 insertions(+), 14 deletions(-)

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index 0cccfd85a64..abdd52c444c 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -8,17 +8,147 @@
  */
 
 #include "qemu/osdep.h"
+#include "libqtest.h"
 #include "libqtest-single.h"
+#include "libqos/libqos.h"
+#include "libqos/libqos-pc.h"
 #include "libqos/usb.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pci_ids.h"
 
-static void test_xhci_hotplug(void)
+typedef struct TestData {
+    const char *device;
+    uint32_t fingerprint;
+} TestData;
+
+/*** Test Setup & Teardown ***/
+typedef struct XHCIQState {
+    /* QEMU PCI variables */
+    QOSState *parent;
+    QPCIDevice *dev;
+    QPCIBar bar;
+    uint64_t barsize;
+    uint32_t fingerprint;
+} XHCIQState;
+
+#define XHCI_QEMU_ID (PCI_DEVICE_ID_REDHAT_XHCI << 16 | \
+                      PCI_VENDOR_ID_REDHAT)
+#define XHCI_NEC_ID (PCI_DEVICE_ID_NEC_UPD720200 << 16 | \
+                     PCI_VENDOR_ID_NEC)
+
+/**
+ * Locate, verify, and return a handle to the XHCI device.
+ */
+static QPCIDevice *get_xhci_device(QTestState *qts)
+{
+    QPCIDevice *xhci;
+    QPCIBus *pcibus;
+
+    pcibus = qpci_new_pc(qts, NULL);
+
+    /* Find the XHCI PCI device and verify it's the right one. */
+    xhci = qpci_device_find(pcibus, QPCI_DEVFN(0x1D, 0x0));
+    g_assert(xhci != NULL);
+
+    return xhci;
+}
+
+static void free_xhci_device(QPCIDevice *dev)
+{
+    QPCIBus *pcibus = dev ? dev->bus : NULL;
+
+    /* libqos doesn't have a function for this, so free it manually */
+    g_free(dev);
+    qpci_free_pc(pcibus);
+}
+
+/**
+ * Start a Q35 machine and bookmark a handle to the XHCI device.
+ */
+G_GNUC_PRINTF(1, 0)
+static XHCIQState *xhci_vboot(const char *cli, va_list ap)
+{
+    XHCIQState *s;
+
+    s = g_new0(XHCIQState, 1);
+    s->parent = qtest_pc_vboot(cli, ap);
+    alloc_set_flags(&s->parent->alloc, ALLOC_LEAK_ASSERT);
+
+    /* Verify that we have an XHCI device present. */
+    s->dev = get_xhci_device(s->parent->qts);
+    s->fingerprint = qpci_config_readl(s->dev, PCI_VENDOR_ID);
+    s->bar = qpci_iomap(s->dev, 0, &s->barsize);
+    /* turns on pci.cmd.iose, pci.cmd.mse and pci.cmd.bme */
+    qpci_device_enable(s->dev);
+
+    return s;
+}
+
+/**
+ * Start a Q35 machine and bookmark a handle to the XHCI device.
+ */
+G_GNUC_PRINTF(1, 2)
+static XHCIQState *xhci_boot(const char *cli, ...)
+{
+    XHCIQState *s;
+    va_list ap;
+
+    va_start(ap, cli);
+    s = xhci_vboot(cli, ap);
+    va_end(ap);
+
+    return s;
+}
+
+static XHCIQState *xhci_boot_dev(const char *device, uint32_t fingerprint)
+{
+    XHCIQState *s;
+
+    s = xhci_boot("-M q35 "
+                  "-device %s,id=xhci,bus=pcie.0,addr=1d.0 "
+                  "-drive id=drive0,if=none,file=null-co://,"
+                         "file.read-zeroes=on,format=raw", device);
+    g_assert_cmphex(s->fingerprint, ==, fingerprint);
+
+    return s;
+}
+
+/**
+ * Clean up the PCI device, then terminate the QEMU instance.
+ */
+static void xhci_shutdown(XHCIQState *xhci)
+{
+    QOSState *qs = xhci->parent;
+
+    free_xhci_device(xhci->dev);
+    g_free(xhci);
+    qtest_shutdown(qs);
+}
+
+/*** tests ***/
+
+static void test_xhci_hotplug(const void *arg)
 {
-    usb_test_hotplug(global_qtest, "xhci", "1", NULL);
+    const TestData *td = arg;
+    XHCIQState *s;
+    QTestState *qts;
+
+    s = xhci_boot_dev(td->device, td->fingerprint);
+    qts = s->parent->qts;
+
+    usb_test_hotplug(qts, "xhci", "1", NULL);
+
+    xhci_shutdown(s);
 }
 
-static void test_usb_uas_hotplug(void)
+static void test_usb_uas_hotplug(const void *arg)
 {
-    QTestState *qts = global_qtest;
+    const TestData *td = arg;
+    XHCIQState *s;
+    QTestState *qts;
+
+    s = xhci_boot_dev(td->device, td->fingerprint);
+    qts = s->parent->qts;
 
     qtest_qmp_device_add(qts, "usb-uas", "uas", "{}");
     qtest_qmp_device_add(qts, "scsi-hd", "scsihd", "{'drive': 'drive0'}");
@@ -32,9 +162,14 @@ static void test_usb_uas_hotplug(void)
     qtest_qmp_device_del(qts, "uas");
 }
 
-static void test_usb_ccid_hotplug(void)
+static void test_usb_ccid_hotplug(const void *arg)
 {
-    QTestState *qts = global_qtest;
+    const TestData *td = arg;
+    XHCIQState *s;
+    QTestState *qts;
+
+    s = xhci_boot_dev(td->device, td->fingerprint);
+    qts = s->parent->qts;
 
     qtest_qmp_device_add(qts, "usb-ccid", "ccid", "{}");
     qtest_qmp_device_del(qts, "ccid");
@@ -43,23 +178,50 @@ static void test_usb_ccid_hotplug(void)
     qtest_qmp_device_del(qts, "ccid");
 }
 
+static void add_test(const char *name, TestData *td, void (*fn)(const void *))
+{
+    g_autofree char *full_name = g_strdup_printf(
+            "/xhci/pci/%s/%s", td->device, name);
+    qtest_add_data_func(full_name, td, fn);
+}
+
+static void add_tests(TestData *td)
+{
+    add_test("hotplug", td, test_xhci_hotplug);
+    if (qtest_has_device("usb-uas")) {
+        add_test("usb-uas", td, test_usb_uas_hotplug);
+    }
+    if (qtest_has_device("usb-ccid")) {
+        add_test("usb-ccid", td, test_usb_ccid_hotplug);
+    }
+}
+
+/* tests */
 int main(int argc, char **argv)
 {
     int ret;
+    const char *arch;
+    int i;
+    TestData td[] = {
+        { .device = "qemu-xhci", .fingerprint = XHCI_QEMU_ID, },
+        { .device = "nec-usb-xhci", .fingerprint = XHCI_NEC_ID, },
+    };
 
     g_test_init(&argc, &argv, NULL);
 
-    qtest_add_func("/xhci/pci/hotplug", test_xhci_hotplug);
-    if (qtest_has_device("usb-uas")) {
-        qtest_add_func("/xhci/pci/hotplug/usb-uas", test_usb_uas_hotplug);
+    /* Check architecture */
+    arch = qtest_get_arch();
+    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
+        g_test_message("Skipping test for non-x86");
+        return 0;
     }
-    if (qtest_has_device("usb-ccid")) {
-        qtest_add_func("/xhci/pci/hotplug/usb-ccid", test_usb_ccid_hotplug);
+
+    for (i = 0; i < ARRAY_SIZE(td); i++) {
+        if (qtest_has_device(td[i].device)) {
+            add_tests(&td[i]);
+        }
     }
 
-    qtest_start("-device nec-usb-xhci,id=xhci"
-                " -drive id=drive0,if=none,file=null-co://,"
-                "file.read-zeroes=on,format=raw");
     ret = g_test_run();
     qtest_end();
 
-- 
2.47.1


