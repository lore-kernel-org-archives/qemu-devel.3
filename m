Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC60C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 10:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7Xt-00036o-CB; Thu, 05 Jun 2025 06:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uN7Xn-000365-Ov; Thu, 05 Jun 2025 06:09:55 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uN7Xk-0008Uz-Qq; Thu, 05 Jun 2025 06:09:55 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 95C0144AEF;
 Thu,  5 Jun 2025 12:09:42 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	kwolf@redhat.com,
	hreitz@redhat.com
Subject: [PATCH] iotests: add test for changing the 'drive' property via
 'qom-set'
Date: Thu,  5 Jun 2025 12:09:38 +0200
Message-Id: <20250605100938.43133-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
---
 tests/qemu-iotests/tests/qom-set-drive     | 75 ++++++++++++++++++++++
 tests/qemu-iotests/tests/qom-set-drive.out | 11 ++++
 2 files changed, 86 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/qom-set-drive
 create mode 100644 tests/qemu-iotests/tests/qom-set-drive.out

diff --git a/tests/qemu-iotests/tests/qom-set-drive b/tests/qemu-iotests/tests/qom-set-drive
new file mode 100755
index 0000000000..e44fe4cebc
--- /dev/null
+++ b/tests/qemu-iotests/tests/qom-set-drive
@@ -0,0 +1,75 @@
+#!/usr/bin/env python3
+# group: quick
+#
+# Test how changing the 'drive' property via 'qom-set' behaves.
+#
+# Copyright (C) Proxmox Server Solutions GmbH
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import os
+import iotests
+from iotests import imgfmt, log, qemu_img_create, QMPTestCase
+
+image_size = 1 * 1024 * 1024
+images = [os.path.join(iotests.test_dir, f'{i}.img') for i in range(0, 4)]
+
+class TestQOMSetDrive(QMPTestCase):
+    def setUp(self) -> None:
+        for i in range(0, len(images)):
+            qemu_img_create('-f', imgfmt, images[i], str(image_size))
+
+        self.vm = iotests.VM()
+        for i in range(0, len(images)):
+            self.vm.add_blockdev(self.vm.qmp_to_opts({
+                'driver': imgfmt,
+                'node-name': f'node{i}',
+                'file': {
+                    'driver': 'file',
+                    'filename': images[i]
+                }
+            }))
+        self.vm.add_object('iothread,id=iothread0')
+        self.vm.add_device('virtio-scsi,iothread=iothread0')
+        self.vm.add_device(f'scsi-hd,id=iot,drive=node0')
+        self.vm.add_device('virtio-scsi')
+        self.vm.add_device(f'scsi-hd,id=no-iot,drive=node1')
+        self.vm.launch()
+
+    def tearDown(self) -> None:
+        self.vm.shutdown()
+        for i in range(0, len(images)):
+            os.remove(images[i])
+
+    def test_qom_set_drive(self) -> None:
+        log(self.vm.qmp('qom-get', path='/machine/peripheral/iot',
+                        property='drive'))
+        log(self.vm.qmp('qom-set', path='/machine/peripheral/iot',
+                        property='drive', value='node2'))
+        log(self.vm.qmp('qom-get', path='/machine/peripheral/iot',
+                        property='drive'))
+
+        log(self.vm.qmp('qom-get', path='/machine/peripheral/no-iot',
+                        property='drive'))
+        log(self.vm.qmp('qom-set', path='/machine/peripheral/no-iot',
+                        property='drive', value='node3'))
+        log(self.vm.qmp('qom-get', path='/machine/peripheral/no-iot',
+                        property='drive'))
+
+if __name__ == '__main__':
+    iotests.activate_logging()
+    # LUKS would require special key-secret handling in add_blockdevs()
+    iotests.main(supported_fmts=['generic'],
+                 unsupported_fmts=['luks'])
diff --git a/tests/qemu-iotests/tests/qom-set-drive.out b/tests/qemu-iotests/tests/qom-set-drive.out
new file mode 100644
index 0000000000..7fc243dca6
--- /dev/null
+++ b/tests/qemu-iotests/tests/qom-set-drive.out
@@ -0,0 +1,11 @@
+{"return": "node0"}
+{"error": {"class": "GenericError", "desc": "Different aio context is not supported for new node"}}
+{"return": "node0"}
+{"return": "node1"}
+{"return": {}}
+{"return": "node3"}
+.
+----------------------------------------------------------------------
+Ran 1 tests
+
+OK
-- 
2.39.5



