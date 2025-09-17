Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE68DCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 11:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqlU-0000a3-SO; Wed, 17 Sep 2025 07:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uyqkx-0007he-8o; Wed, 17 Sep 2025 07:55:28 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uyqkt-0004bw-L0; Wed, 17 Sep 2025 07:55:26 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 9E5E44DC0B;
 Wed, 17 Sep 2025 13:55:20 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com
Subject: [PATCH v2 4/5] iotests: add test for resizing a node below filters
Date: Wed, 17 Sep 2025 13:54:51 +0200
Message-ID: <20250917115509.401015-5-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250917115509.401015-1-f.ebner@proxmox.com>
References: <20250917115509.401015-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1758110111520
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---
 tests/qemu-iotests/tests/resize-below-filter  | 73 +++++++++++++++++++
 .../tests/resize-below-filter.out             |  5 ++
 2 files changed, 78 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/resize-below-filter
 create mode 100644 tests/qemu-iotests/tests/resize-below-filter.out

diff --git a/tests/qemu-iotests/tests/resize-below-filter b/tests/qemu-iotests/tests/resize-below-filter
new file mode 100755
index 0000000000..f55619cf34
--- /dev/null
+++ b/tests/qemu-iotests/tests/resize-below-filter
@@ -0,0 +1,73 @@
+#!/usr/bin/env python3
+# group: rw quick
+#
+# Test what happens when a node below filter nodes is resized.
+#
+# Copyright (C) Proxmox Server Solutions GmbH
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import iotests
+from iotests import imgfmt, qemu_img_create, QMPTestCase
+
+image_size = 1 * 1024 * 1024
+image = os.path.join(iotests.test_dir, 'test.img')
+
+class TestResizeBelowFilter(QMPTestCase):
+    def setUp(self) -> None:
+        qemu_img_create('-f', imgfmt, image, str(image_size))
+
+        self.vm = iotests.VM()
+        self.vm.add_blockdev(self.vm.qmp_to_opts({
+            'driver': imgfmt,
+            'node-name': 'node0',
+            'file': {
+                'driver': 'file',
+                'filename': image,
+            }
+        }))
+        self.vm.add_blockdev(self.vm.qmp_to_opts({
+            'driver': 'compress',
+            'node-name': 'comp0',
+            'file': 'node0',
+        }))
+        self.vm.add_object('throttle-group,id=thrgr0')
+        self.vm.add_blockdev(self.vm.qmp_to_opts({
+            'driver': 'throttle',
+            'node-name': 'thr0',
+            'throttle-group': 'thrgr0',
+            'file': 'comp0',
+        }))
+        self.vm.add_object('throttle-group,id=thrgr1')
+        self.vm.add_blockdev(self.vm.qmp_to_opts({
+            'driver': 'throttle',
+            'node-name': 'thr1',
+            'throttle-group': 'thrgr1',
+            'file': 'node0',
+        }))
+        self.vm.launch()
+
+    def tearDown(self) -> None:
+        self.vm.shutdown()
+        os.remove(image)
+
+    def assert_size(self, size: int) -> None:
+        nodes = self.vm.qmp('query-named-block-nodes', flat=True)['return']
+        self.assertEqual(len(nodes), 5)
+        for node in nodes:
+            if node['drv'] == 'file':
+                continue
+            self.assertEqual(node['image']['virtual-size'], size)
+
+    def test_resize_below_filter(self) -> None:
+        self.assert_size(image_size)
+        self.vm.qmp('block_resize', node_name='thr0', size=2*image_size)
+        self.assert_size(2*image_size)
+        self.vm.qmp('block_resize', node_name='comp0', size=3*image_size)
+        self.assert_size(3*image_size)
+        self.vm.qmp('block_resize', node_name='node0', size=4*image_size)
+        self.assert_size(4*image_size)
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['qcow2'], supported_protocols=['file'])
diff --git a/tests/qemu-iotests/tests/resize-below-filter.out b/tests/qemu-iotests/tests/resize-below-filter.out
new file mode 100644
index 0000000000..ae1213e6f8
--- /dev/null
+++ b/tests/qemu-iotests/tests/resize-below-filter.out
@@ -0,0 +1,5 @@
+.
+----------------------------------------------------------------------
+Ran 1 tests
+
+OK
-- 
2.47.2



