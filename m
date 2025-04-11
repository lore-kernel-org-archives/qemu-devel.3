Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28E4C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u39Ip-0002W5-Ui; Fri, 11 Apr 2025 03:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39IQ-0002Kw-Ic
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 03:59:33 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u39IN-0003tE-W5
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 03:59:29 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736c1cf75e4so1218196b3a.2
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 00:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744358366; x=1744963166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BFXWhhDmYjKxO9sih23/q3NnrBmE2qXOofnI065wk+8=;
 b=YJ5oIAzuaS2vPtvTXXGZunmAeE5yrprh0tpNg9VRb0rgthfZ1LAyK5rHiW6NcwgIxw
 mndn5HOh0RUmGQFnSTzFv8Z3KtkPSf+zTDO2Elk5CYzQ1dPztT1PRkiD1oynHBb3JYhm
 lHELzioyRtQXzvBGd8tGj06FbT5mZyjkX6/Ii3g+VPjPQMX49zHQwlFdQQYQ/Eh/Xc3W
 G2JOF5N/S7f8FAGq2W6EuCxakFGyiZaL+wuxaD22aid9Pqry7NA10Cztk72EuiocpJ+P
 FzSZNZGQl82qjOPwkC4qseLYo40Xkkk1D/nJlHp7/VPj+NQHendi8vfg941tImaKRL5Y
 VTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744358366; x=1744963166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BFXWhhDmYjKxO9sih23/q3NnrBmE2qXOofnI065wk+8=;
 b=WgCfRSfJdAcW8v75Ttws4OlDJk8d5kC9B0I3hJgt2TghMP96RHPck3Da9aNw/ZW8nY
 N3dg88GLnFFk8emUh27yqEHvV5Zr5LULLNDdoHy95pEMt7m/XQNqcLiEgjZxw52NH1hg
 v4VRvh2svG9FzcioY1brYlEzYNxev/tVbm86jVToEY1upKvrRot3yCcQKJjNO8dEB4mM
 GmRjSY6frPnl5ynkz0BIOpZMYR6VPdZyyX7bi0SPGYOTufG3+jnEk6bcL9GIbri1ozTX
 ulHl6+2hyJSfxGiO0irNAjCE+ZOOdfhU8ZNqCnNyirAGAbcQHyKwmIWgKNsTWUERaLq5
 7sHw==
X-Gm-Message-State: AOJu0YwOBmL7YdmJQk5oWks4oQYcrjkV8M5GQjOfy1rrTS/ujDzmrNHk
 ljBKa98tYDMZ2O84baBW/FbKaX+XjtIxk046/5Zh7o3kXWYoRSY2YZYAbw==
X-Gm-Gg: ASbGnctQN2stT+JPYhtkrvFw0cGX862HLTX0CipdfnhCpOoqNtN7nKJS4RUY6pxMrmb
 FsHcBnb3tUtJGXa2JbzH2NT/UVIFCjc4+gD+rL9alKVZ5JBgDrbDOagY3AJ4gUuln08231A/jvA
 Gr4OqYxpibv/Y/ZvH5H0p4WBgGbX8DRUjeasZ6mRJdY1lPfhGSskfl8iLXo1Zzj6IfsfNgQgjNX
 oB3UIp++lg19LyLOmDKGJm4sd/NWfBtpNbpLHohwf/rDEbnxuGiNJmbP2zSw29FSx3VepOOiSZC
 VGwiRr5qwTOQOyIbvugu2GmNANnVN3yvZCKKNJqDpL5T
X-Google-Smtp-Source: AGHT+IFEfuJ5OjPgZyfeoyJMJoCYAiWoonTs3DBz/JIbwUBlhPyGh2wc0qx16WMx53s1HNF4uFn5gw==
X-Received: by 2002:a05:6a21:1010:b0:1f5:706b:5410 with SMTP id
 adf61e73a8af0-2017998feb3mr3016612637.38.1744358366215; 
 Fri, 11 Apr 2025 00:59:26 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd233554asm851687b3a.180.2025.04.11.00.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 00:59:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 6/8] tests/qtest/xhci: test the qemu-xhci device
Date: Fri, 11 Apr 2025 17:58:48 +1000
Message-ID: <20250411075851.206995-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411075851.206995-1-npiggin@gmail.com>
References: <20250411075851.206995-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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
 tests/qtest/usb-hcd-xhci-test.c | 96 +++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 33 deletions(-)

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index 63359fb70b9..4efe7b69d4f 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -13,10 +13,15 @@
 #include "libqos/libqos-pc.h"
 #include "libqtest-single.h"
 #include "libqos/usb.h"
+#include "hw/pci/pci.h"
 #include "hw/pci/pci_ids.h"
 #include "hw/pci/pci_regs.h"
 #include "hw/usb/hcd-xhci.h"
 
+typedef struct TestData {
+    const char *device;
+} TestData;
+
 /*** Test Setup & Teardown ***/
 typedef struct XHCIQSlotState {
     /* In-memory arrays */
@@ -56,6 +61,8 @@ typedef struct XHCIQState {
     XHCIQSlotState slots[32];
 } XHCIQState;
 
+#define XHCI_QEMU_ID (PCI_DEVICE_ID_REDHAT_XHCI << 16 | \
+                      PCI_VENDOR_ID_REDHAT)
 #define XHCI_NEC_ID (PCI_DEVICE_ID_NEC_UPD720200 << 16 | \
                      PCI_VENDOR_ID_NEC)
 
@@ -76,6 +83,7 @@ static QPCIDevice *get_xhci_device(QTestState *qts, uint32_t *fingerprint)
 
     xhci_fingerprint = qpci_config_readl(xhci, PCI_VENDOR_ID);
     switch (xhci_fingerprint) {
+    case XHCI_QEMU_ID:
     case XHCI_NEC_ID:
         break;
     default:
@@ -128,20 +136,21 @@ static XHCIQState *xhci_boot(const char *cli, ...)
     XHCIQState *s;
     va_list ap;
 
-    if (cli) {
-        va_start(ap, cli);
-        s = xhci_vboot(cli, ap);
-        va_end(ap);
-    } else {
-        s = xhci_boot("-M q35 "
-                      "-device nec-usb-xhci,id=xhci,bus=pcie.0,addr=1d.0 "
-                      "-drive id=drive0,if=none,file=null-co://,"
-                          "file.read-zeroes=on,format=raw");
-    }
+    va_start(ap, cli);
+    s = xhci_vboot(cli, ap);
+    va_end(ap);
 
     return s;
 }
 
+static XHCIQState *xhci_boot_dev(const char *device)
+{
+    return xhci_boot("-M q35 "
+                    "-device %s,id=xhci,bus=pcie.0,addr=1d.0 "
+                    "-drive id=drive0,if=none,file=null-co://,"
+                        "file.read-zeroes=on,format=raw", device);
+}
+
 /**
  * Clean up the PCI device, then terminate the QEMU instance.
  */
@@ -156,12 +165,13 @@ static void xhci_shutdown(XHCIQState *xhci)
 
 /*** tests ***/
 
-static void test_xhci_hotplug(void)
+static void test_xhci_hotplug(const void *arg)
 {
+    const TestData *td = arg;
     XHCIQState *s;
     QTestState *qts;
 
-    s = xhci_boot(NULL);
+    s = xhci_boot_dev(td->device);
     qts = s->parent->qts;
 
     usb_test_hotplug(qts, "xhci", "1", NULL);
@@ -169,12 +179,13 @@ static void test_xhci_hotplug(void)
     xhci_shutdown(s);
 }
 
-static void test_usb_uas_hotplug(void)
+static void test_usb_uas_hotplug(const void *arg)
 {
+    const TestData *td = arg;
     XHCIQState *s;
     QTestState *qts;
 
-    s = xhci_boot(NULL);
+    s = xhci_boot_dev(td->device);
     qts = s->parent->qts;
 
     qtest_qmp_device_add(qts, "usb-uas", "uas", "{}");
@@ -191,12 +202,13 @@ static void test_usb_uas_hotplug(void)
     xhci_shutdown(s);
 }
 
-static void test_usb_ccid_hotplug(void)
+static void test_usb_ccid_hotplug(const void *arg)
 {
+    const TestData *td = arg;
     XHCIQState *s;
     QTestState *qts;
 
-    s = xhci_boot(NULL);
+    s = xhci_boot_dev(td->device);
     qts = s->parent->qts;
 
     qtest_qmp_device_add(qts, "usb-ccid", "ccid", "{}");
@@ -392,8 +404,9 @@ static void submit_tr_trb(XHCIQState *s, int slot, XHCITRB *trb)
  * This could be librified in future (like AHCI0 to have a way to bring up
  * an endpoint to test device protocols.
  */
-static void pci_xhci_stress_rings(void)
+static void test_xhci_stress_rings(const void *arg)
 {
+    const TestData *td = arg;
     XHCIQState *s;
     uint32_t value;
     uint64_t input_context;
@@ -405,11 +418,11 @@ static void pci_xhci_stress_rings(void)
     int i;
 
     s = xhci_boot("-M q35 "
-            "-device nec-usb-xhci,id=xhci,bus=pcie.0,addr=1d.0 "
+            "-device %s,id=xhci,bus=pcie.0,addr=1d.0 "
             "-device usb-storage,bus=xhci.0,drive=drive0 "
             "-drive id=drive0,if=none,file=null-co://,"
-                "file.read-zeroes=on,format=raw "
-            );
+                "file.read-zeroes=on,format=raw ",
+            td->device);
 
     hcsparams1 = xhci_cap_readl(s, XHCI_HCCAP_REG_HCSPARAMS1);
     s->maxports = (hcsparams1 >> 24) & 0xff;
@@ -567,11 +580,37 @@ static void pci_xhci_stress_rings(void)
     xhci_shutdown(s);
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
+    if (qtest_has_device("usb-storage")) {
+        add_test("xhci-stress-rings", td, test_xhci_stress_rings);
+    }
+}
+
 /* tests */
 int main(int argc, char **argv)
 {
     int ret;
     const char *arch;
+    int i;
+    TestData td[] = {
+        { .device = "qemu-xhci", },
+        { .device = "nec-usb-xhci", },
+    };
 
     g_test_init(&argc, &argv, NULL);
 
@@ -582,19 +621,10 @@ int main(int argc, char **argv)
         return 0;
     }
 
-    if (!qtest_has_device("nec-usb-xhci")) {
-        return 0;
-    }
-
-    qtest_add_func("/xhci/pci/hotplug", test_xhci_hotplug);
-    if (qtest_has_device("usb-uas")) {
-        qtest_add_func("/xhci/pci/hotplug/usb-uas", test_usb_uas_hotplug);
-    }
-    if (qtest_has_device("usb-ccid")) {
-        qtest_add_func("/xhci/pci/hotplug/usb-ccid", test_usb_ccid_hotplug);
-    }
-    if (qtest_has_device("usb-storage")) {
-        qtest_add_func("/xhci/pci/xhci-stress-rings", pci_xhci_stress_rings);
+    for (i = 0; i < ARRAY_SIZE(td); i++) {
+        if (qtest_has_device(td[i].device)) {
+            add_tests(&td[i]);
+        }
     }
 
     ret = g_test_run();
-- 
2.47.1


