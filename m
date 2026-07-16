Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF118C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPav-0007I3-QH; Thu, 16 Jul 2026 13:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariyam@oss.nttdata.com>)
 id 1wkPaq-0007Dh-HX
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:09:53 -0400
Received: from oss.nttdata.com ([49.212.34.109])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariyam@oss.nttdata.com>)
 id 1wkPao-0007Rk-Dq
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:09:52 -0400
Received: by oss.nttdata.com (Postfix, from userid 1024)
 id 72F982020243; Fri, 17 Jul 2026 02:09:24 +0900 (JST)
From: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
To: qemu-devel@nongnu.org
Cc: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/4] tests/qtest: drive_del: Add regression test for empty
 CD-ROM BlockBackend leak
Date: Fri, 17 Jul 2026 02:09:23 +0900
Message-ID: <20260716170923.2125858-5-Mitsuru.Kariya@oss.nttdata.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716170923.2125858-1-Mitsuru.Kariya@oss.nttdata.com>
References: <20260716170923.2125858-1-Mitsuru.Kariya@oss.nttdata.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.4.3 at oss.nttdata.com
X-Virus-Status: Clean
Received-SPF: pass client-ip=49.212.34.109;
 envelope-from=kariyam@oss.nttdata.com; helo=oss.nttdata.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

Add a regression test for the BlockBackend reference leak in
scsi_cd_realize(): create an empty scsi-cd (which gets an anonymous
BlockBackend), insert a medium, unplug the device, and check that the
medium's blockdev node can then be deleted.  Before the fix the leaked
BlockBackend keeps the node in use and blockdev-del fails.

Signed-off-by: Mitsuru Kariya <Mitsuru.Kariya@oss.nttdata.com>
---
 tests/qtest/drive_del-test.c | 58 ++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tests/qtest/drive_del-test.c b/tests/qtest/drive_del-test.c
index 30d9451ddd..24793da852 100644
--- a/tests/qtest/drive_del-test.c
+++ b/tests/qtest/drive_del-test.c
@@ -320,6 +320,62 @@ static void test_empty_device_del(void)
     qtest_quit(qts);
 }
 
+static void test_insert_medium_and_device_del(void)
+{
+    QTestState *qts;
+    QDict *response;
+
+    if (!has_device_builtin("virtio-scsi")) {
+        g_test_skip("Device virtio-scsi is not available");
+        return;
+    }
+
+    /* An empty scsi-cd creates an anonymous BlockBackend at realize. */
+    qts = qtest_initf("-device virtio-scsi-%s -device scsi-cd,id=dev0",
+                      qvirtio_get_dev_type());
+
+    /* Create the blockdev node to be inserted as a medium. */
+    blockdev_add_with_media(qts);
+
+    /* Open tray. */
+    response = qtest_qmp(qts, "{'execute': 'blockdev-open-tray',"
+                              " 'arguments': {'id': 'dev0'}}");
+    g_assert(response);
+    g_assert(qdict_haskey(response, "return"));
+    qobject_unref(response);
+
+    /*
+     * Insert a medium into the empty drive.  This adds a reference from
+     * the anonymous BlockBackend to the blockdev node.
+     */
+    response = qtest_qmp(qts, "{'execute': 'blockdev-insert-medium',"
+                              " 'arguments': {'id': 'dev0',"
+                              "               'node-name': 'drive0'}}");
+    g_assert(response);
+    g_assert(qdict_haskey(response, "return"));
+    qobject_unref(response);
+
+    /*
+     * Unplug the device.  This drops the last reference to the anonymous
+     * BlockBackend, so it is deleted and releases its reference to the
+     * blockdev node.
+     */
+    device_del(qts, false);
+
+    /*
+     * If the BlockBackend leaked, drive0 is still in use here and
+     * blockdev-del fails.
+     */
+    response = qtest_qmp(qts, "{'execute': 'blockdev-del',"
+                              " 'arguments': {'node-name': 'drive0'}}");
+    g_assert(response);
+    g_assert(qdict_haskey(response, "return"));
+    qobject_unref(response);
+    g_assert(!has_blockdev(qts));
+
+    qtest_quit(qts);
+}
+
 static void test_device_add_and_del(void)
 {
     QTestState *qts;
@@ -516,6 +572,8 @@ int main(int argc, char **argv)
                        test_drive_add_device_add_and_del);
         qtest_add_func("/device_del/empty",
                        test_empty_device_del);
+        qtest_add_func("/device_del/insert_medium",
+                       test_insert_medium_and_device_del);
         qtest_add_func("/device_del/blockdev",
                        test_blockdev_add_device_add_and_del);
 
-- 
2.43.0


