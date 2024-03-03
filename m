Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457DBC54E49
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 07:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rggS1-0001sN-CE; Sun, 03 Mar 2024 02:40:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rggRy-0001qo-LO; Sun, 03 Mar 2024 02:39:58 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rggRt-0001lN-8a; Sun, 03 Mar 2024 02:39:58 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4710952759;
 Sun,  3 Mar 2024 10:40:18 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E5F918E84E;
 Sun,  3 Mar 2024 10:39:34 +0300 (MSK)
Received: (nullmailer pid 1350613 invoked by uid 1000);
 Sun, 03 Mar 2024 07:39:34 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.10 52/54] tests/qtest/display-vga-test: Add proper checks
 if a device is available
Date: Sun,  3 Mar 2024 10:39:31 +0300
Message-Id: <20240303073934.1350568-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.10-20240303092734@cover.tls.msk.ru>
References: <qemu-stable-7.2.10-20240303092734@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

display-vga-test currently tries to guess the usable VGA devices
according to the target architecture that is used for the test.
This of course does not work if QEMU has been built with the
"--without-default-devices" configure switch. To fix this, use the
qtest_has_device() function for the decision instead. This way
we can also consolidate most of the test functions into one single
function (that takes a parameter with the device name now), except
for the multihead test that tries to instantiate two devices and
thus is a little bit different.

Message-Id: <20230130104446.1286773-4-thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit f2e57851b831922625f9d364d78c11a0258331a6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/display-vga-test.c b/tests/qtest/display-vga-test.c
index ace3bb28e0..75b341a9c6 100644
--- a/tests/qtest/display-vga-test.c
+++ b/tests/qtest/display-vga-test.c
@@ -8,61 +8,46 @@
  */
 
 #include "qemu/osdep.h"
-#include "libqtest-single.h"
-
-static void pci_cirrus(void)
-{
-    qtest_start("-vga none -device cirrus-vga");
-    qtest_end();
-}
-
-static void pci_stdvga(void)
-{
-    qtest_start("-vga none -device VGA");
-    qtest_end();
-}
-
-static void pci_secondary(void)
-{
-    qtest_start("-vga none -device secondary-vga");
-    qtest_end();
-}
+#include "libqtest.h"
 
 static void pci_multihead(void)
 {
-    qtest_start("-vga none -device VGA -device secondary-vga");
-    qtest_end();
-}
+    QTestState *qts;
 
-static void pci_virtio_gpu(void)
-{
-    qtest_start("-vga none -device virtio-gpu-pci");
-    qtest_end();
+    qts = qtest_init("-vga none -device VGA -device secondary-vga");
+    qtest_quit(qts);
 }
 
-static void pci_virtio_vga(void)
+static void test_vga(gconstpointer data)
 {
-    qtest_start("-vga none -device virtio-vga");
-    qtest_end();
+    QTestState *qts;
+
+    qts = qtest_initf("-vga none -device %s", (const char *)data);
+    qtest_quit(qts);
 }
 
 int main(int argc, char **argv)
 {
-    const char *arch = qtest_get_arch();
+    static const char *devices[] = {
+        "cirrus-vga",
+        "VGA",
+        "secondary-vga",
+        "virtio-gpu-pci",
+        "virtio-vga"
+    };
 
     g_test_init(&argc, &argv, NULL);
 
-    if (strcmp(arch, "alpha") == 0 || strcmp(arch, "i386") == 0 ||
-        strcmp(arch, "mips") == 0 || strcmp(arch, "x86_64") == 0) {
-        qtest_add_func("/display/pci/cirrus", pci_cirrus);
+    for (int i = 0; i < ARRAY_SIZE(devices); i++) {
+        if (qtest_has_device(devices[i])) {
+            char *testpath = g_strdup_printf("/display/pci/%s", devices[i]);
+            qtest_add_data_func(testpath, devices[i], test_vga);
+            g_free(testpath);
+        }
     }
-    qtest_add_func("/display/pci/stdvga", pci_stdvga);
-    qtest_add_func("/display/pci/secondary", pci_secondary);
-    qtest_add_func("/display/pci/multihead", pci_multihead);
-    qtest_add_func("/display/pci/virtio-gpu", pci_virtio_gpu);
-    if (g_str_equal(arch, "i386") || g_str_equal(arch, "x86_64") ||
-        g_str_equal(arch, "hppa") || g_str_equal(arch, "ppc64")) {
-        qtest_add_func("/display/pci/virtio-vga", pci_virtio_vga);
+
+    if (qtest_has_device("secondary-vga")) {
+        qtest_add_func("/display/pci/multihead", pci_multihead);
     }
 
     return g_test_run();
-- 
2.39.2


