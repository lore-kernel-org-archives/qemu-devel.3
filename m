Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B753CC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWWS-0007Jo-Ru; Wed, 22 Jul 2026 08:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWTV-0008GF-8O; Wed, 22 Jul 2026 08:55:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWTT-00035J-C7; Wed, 22 Jul 2026 08:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724575; bh=ZbL3Go4PS6XBXeG+quCsX0C9bN+36/RBwEayYbR6fcM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aLcpJrhc0Atn4Y1/ZI1+akza2RUHSuZsbXqa7OUyRtjzy4mElgfkvU2nTG64eiofu
 xMczaTvIXDC9xilkcREiSa0nItZAwPn8BDvT6grsbAGgdtU6gR+xowW0fv8HEwPs43
 OlyXu+Q0hqCd+x24JTD7bYUOnjvjSlD3eRsmA/TMI9svdTzWTg0/i/D5SM+YCdkpe3
 1dBULJMxKH9C2zhyxBLSixuTg8ggVqZVC5Jr8MUa9EO99EDdbwwDVakPuHrkGWEzG4
 luC3hYqOLrOtr+66fVdSHA+GnpwZEju9zI5oG+QB4NupGJ7RmL/h6LBsUFVcsg1PZd
 cFVdexAyH5i7w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3F0A01C3B51;
 Wed, 22 Jul 2026 15:49:35 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 87FD63F37A1;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E4E9C17F77; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Xiangfeng Cai <caixiangfeng@bytedance.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 116/127] tests/qtest: add xhci-pci unplug finalize
 regression test
Date: Wed, 22 Jul 2026 15:48:41 +0300
Message-ID: <20260722124859.32371-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiangfeng Cai <caixiangfeng@bytedance.com>

Add a qtest that hot-adds an nec-usb-xhci controller, requests unplug,
resets the system to process the request, and waits for DEVICE_DELETED.
This covers the xHCI PCI host-link refcount cycle by verifying that
device_finalize() runs after unplug.

Signed-off-by: Xiangfeng Cai <caixiangfeng@bytedance.com>
Message-ID: <20260618110119.3084296-3-caixiangfeng@bytedance.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit ba54d7e66e251764f06d6231c5832d7c7239aa8b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index 0cccfd85a64..b58fa1e2dae 100644
--- a/tests/qtest/usb-hcd-xhci-test.c
+++ b/tests/qtest/usb-hcd-xhci-test.c
@@ -10,6 +10,72 @@
 #include "qemu/osdep.h"
 #include "libqtest-single.h"
 #include "libqos/usb.h"
+#include "qobject/qdict.h"
+
+static void wait_device_deleted_event(QTestState *qtest, const char *id)
+{
+    QDict *resp, *data;
+    const char *device;
+
+    /*
+     * Other devices might get removed along with the removed device. Skip
+     * these. The device of interest will be the last one.
+     */
+    for (;;) {
+        resp = qtest_qmp_eventwait_ref(qtest, "DEVICE_DELETED");
+        data = qdict_get_qdict(resp, "data");
+        device = data ? qdict_get_try_str(data, "device") : NULL;
+        if (device && !strcmp(device, id)) {
+            qobject_unref(resp);
+            break;
+        }
+        qobject_unref(resp);
+    }
+}
+
+/*
+ * Regression test for the xHCI-PCI "host" strong-link reference cycle.
+ *
+ * The xHCI PCI wrapper embeds an xhci-core child whose strong "host" link
+ * points back at the PCI device, forming a refcount cycle. If
+ * usb_xhci_pci_exit() does not break that cycle, the device's refcount never
+ * reaches 0 on unplug, device_finalize() never runs, and therefore the
+ * DEVICE_DELETED event (emitted from device_finalize()) is never sent.
+ *
+ * This test hot-plugs an xHCI controller into an ACPI-hotpluggable bus,
+ * requests its removal and waits for DEVICE_DELETED. Without the fix the event
+ * is never delivered (device_finalize() is blocked), so the test would
+ * hang/time out.
+ */
+static void test_xhci_unplug_finalize(void)
+{
+    QTestState *qtest;
+    const char *arch = qtest_get_arch();
+
+    if (strcmp(arch, "i386") != 0 && strcmp(arch, "x86_64") != 0) {
+        g_test_skip("Test only runs on x86 (ACPI PCI hotplug)");
+        return;
+    }
+    if (!qtest_has_device("nec-usb-xhci")) {
+        g_test_skip("Device nec-usb-xhci not available");
+        return;
+    }
+
+    qtest = qtest_initf("-machine pc");
+
+    qtest_qmp_device_add(qtest, "nec-usb-xhci", "xhci-finalize", "{}");
+
+    /*
+     * Request device removal. As the guest is not running, the unplug request
+     * won't be processed until the next system reset, which performs the
+     * removal and triggers device_finalize() (and thus DEVICE_DELETED).
+     */
+    qtest_qmp_device_del_send(qtest, "xhci-finalize");
+    qtest_system_reset_nowait(qtest);
+    wait_device_deleted_event(qtest, "xhci-finalize");
+
+    qtest_quit(qtest);
+}
 
 static void test_xhci_hotplug(void)
 {
@@ -50,6 +116,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("/xhci/pci/hotplug", test_xhci_hotplug);
+    qtest_add_func("/xhci/pci/unplug/finalize", test_xhci_unplug_finalize);
     if (qtest_has_device("usb-uas")) {
         qtest_add_func("/xhci/pci/hotplug/usb-uas", test_usb_uas_hotplug);
     }
-- 
2.47.3


