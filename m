Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11192CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCAv-0002Ca-7f; Thu, 18 Jun 2026 08:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <caixiangfeng@bytedance.com>)
 id 1waAWi-00014M-Bw
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:03:27 -0400
Received: from va-1-112.ptr.blmpb.com ([209.127.230.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <caixiangfeng@bytedance.com>)
 id 1waAWb-0004V4-FY
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 07:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1781780583; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=aNMwjAAnCe0QKH0dKPiG5znG6N5MLtjse8A7jPAR4Xo=;
 b=YeKI3xGvOAuh0SCtK8/sUBYm+8Yfnmn7iOtWjJI1lYeDAh1RhVgjySg4dFAGvivdyfjXSj
 gu/1HwBkqZX+esX/kfI1cwQDIh4/czN4jCSMNKDLQ3vvayuaX5x4j8g4emhyJ8TcSrvPCY
 KQbwQ6R1xjtE/woQu6BWlnLjHNtCT6l3Scz8metyeTD7Ftp1NtyiaKGN4TSMPsw78tkAFZ
 m67LRvQGgOMWMR+ZZuQk4fWQZ9sGABGcLdcN4LSlR4lvEFf2i5ozlKLoXoe5n8nLPDNMZs
 34hFMqu5lhCaGHCGJw0czy0tcC2OcrlssawPYoTcc1kYF4uewOli2yxqvDUcGQ==
Cc: <caixiangfeng@bytedance.com>, <yanfei.xu@bytedance.com>, 
 "Fabiano Rosas" <farosas@suse.de>, "Laurent Vivier" <lvivier@redhat.com>, 
 "Paolo Bonzini" <pbonzini@redhat.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a33d066+83ad6b+nongnu.org+caixiangfeng@bytedance.com>
Subject: [PATCH 2/2] tests/qtest: add xhci-pci unplug finalize regression test
In-Reply-To: <20260618110119.3084296-1-caixiangfeng@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <20260618110119.3084296-3-caixiangfeng@bytedance.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc1
References: <20260618110119.3084296-1-caixiangfeng@bytedance.com>
To: <qemu-devel@nongnu.org>
From: "Xiangfeng Cai" <caixiangfeng@bytedance.com>
Date: Thu, 18 Jun 2026 19:01:19 +0800
X-Original-From: Xiangfeng Cai <caixiangfeng@bytedance.com>
Received-SPF: pass client-ip=209.127.230.112;
 envelope-from=caixiangfeng@bytedance.com; helo=va-1-112.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Jun 2026 08:48:01 -0400
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

Add a qtest that hot-adds an nec-usb-xhci controller, requests unplug,
resets the system to process the request, and waits for DEVICE_DELETED.
This covers the xHCI PCI host-link refcount cycle by verifying that
device_finalize() runs after unplug.

Signed-off-by: Xiangfeng Cai <caixiangfeng@bytedance.com>
---
 tests/qtest/usb-hcd-xhci-test.c | 67 +++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tests/qtest/usb-hcd-xhci-test.c b/tests/qtest/usb-hcd-xhci-test.c
index 0cccfd85a6..b58fa1e2da 100644
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
2.55.0.rc1

