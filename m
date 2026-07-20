Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3BFC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wllOf-0003kc-JM; Mon, 20 Jul 2026 06:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wllOb-0003k4-Hc
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:38:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wllOZ-0008GP-QT
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784543925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IQPrpkxIioqNtONJjKR1RF/mZ5zqy/yI+BFZyibIAWk=;
 b=PeKBupRkrDKzBafUU2A1NxHRZTGEkdFwvQaZUWLu4Hy7jlDwumcNFymRcXEMo4dgVX2uBT
 j1A0RZ/BtKGz8UMKo+JIXKxAK+waD8axpPdpea4WFXyRRv/5LneprVQEJgpue6joSr5VJx
 0gXafVJw3kfcEgV7JcZuTMlmyexQGBQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-b6VvOooQOwa9aVHrae4uEw-1; Mon,
 20 Jul 2026 06:38:44 -0400
X-MC-Unique: b6VvOooQOwa9aVHrae4uEw-1
X-Mimecast-MFC-AGG-ID: b6VvOooQOwa9aVHrae4uEw_1784543923
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81B171802564; Mon, 20 Jul 2026 10:38:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.82])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F0A921588; Mon, 20 Jul 2026 10:38:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Xiangfeng Cai <caixiangfeng@bytedance.com>
Subject: [PULL 3/7] tests/qtest: add xhci-pci unplug finalize regression test
Date: Mon, 20 Jul 2026 12:38:29 +0200
Message-ID: <20260720103833.364506-4-thuth@redhat.com>
In-Reply-To: <20260720103833.364506-1-thuth@redhat.com>
References: <20260720103833.364506-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
---
 tests/qtest/usb-hcd-xhci-test.c | 67 +++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

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
2.55.0


