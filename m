Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186DFC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHOA-0006Pr-Ca; Thu, 02 Jul 2026 09:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wfHNs-0005zZ-Fs; Thu, 02 Jul 2026 09:23:23 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wfHNp-0001v6-Ud; Thu, 02 Jul 2026 09:23:16 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3EE9B479FE;
 Thu, 02 Jul 2026 15:23:03 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 qemu-stable@nongnu.org
Subject: [PATCH 2/2] iotests: test O_TRUNC behavior for fuse exports
Date: Thu,  2 Jul 2026 15:22:36 +0200
Message-ID: <20260702132256.661429-3-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702132256.661429-1-f.ebner@proxmox.com>
References: <20260702132256.661429-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1782998575665
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

The test cases for the blockdev-based export and for the file-based
export with growable=on work before commit a94a1d7699 ("fuse: Manually
process requests (without libfuse)"), then are broken until commit
"block/export/fuse: fix regression with O_TRUNC when export is
growable".

The test case for the blockdev-based export requires passwordless sudo
for losetup and chmod similar to test 108.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 tests/qemu-iotests/tests/fuse-truncate     | 171 +++++++++++++++++++++
 tests/qemu-iotests/tests/fuse-truncate.out |   5 +
 2 files changed, 176 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/fuse-truncate
 create mode 100644 tests/qemu-iotests/tests/fuse-truncate.out

diff --git a/tests/qemu-iotests/tests/fuse-truncate b/tests/qemu-iotests/tests/fuse-truncate
new file mode 100755
index 0000000000..10bc1175c0
--- /dev/null
+++ b/tests/qemu-iotests/tests/fuse-truncate
@@ -0,0 +1,171 @@
+#!/usr/bin/env python3
+# group: rw
+#
+# Test how fuse exports behave with regard to O_TRUNC.
+#
+# Copyright (C) 2026 Proxmox Server Solutions GmbH
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import subprocess
+from pathlib import Path
+
+import iotests
+from iotests import qemu_img, QemuStorageDaemon
+
+fuse_mount_point = os.path.join(iotests.test_dir, 'export.fuse')
+image_size = 1 * 1024 * 1024
+image = os.path.join(iotests.test_dir, 'image.' + iotests.imgfmt)
+
+def check_fuse_support():
+    Path(fuse_mount_point).touch()
+    test_qsd = QemuStorageDaemon('--blockdev', 'null-co,node-name=node0',
+                                 qmp=True)
+    res = test_qsd.qmp('block-export-add', {
+        'id': 'exp0',
+        'type': 'fuse',
+        'node-name': 'node0',
+        'mountpoint': fuse_mount_point,
+        'allow-other': 'off'
+    })
+    test_qsd.stop()
+    os.remove(fuse_mount_point)
+    if 'error' in res:
+        assert (res['error']['desc'] ==
+                "Parameter 'type' does not accept value 'fuse'")
+        iotests.notrun('No FUSE support')
+
+def check_sudo_support():
+    try:
+        subprocess.run(['sudo', '-n', 'losetup', '--version'],
+                       capture_output=True, check=True)
+    except subprocess.CalledProcessError:
+        return False
+    try:
+        subprocess.run(['sudo', '-n', 'chmod', '--version'],
+                       capture_output=True, check=True)
+    except subprocess.CalledProcessError:
+        return False
+    return True
+
+check_fuse_support()
+
+class TestTruncateBase(iotests.QMPTestCase):
+    growable = False
+    supports_preconditions = True
+
+    def evaluate_preconditions(self):
+        return
+
+    def add_blockdev(self):
+        qemu_img('create', '-f', iotests.imgfmt, image, str(image_size))
+        self.qsd.cmd('blockdev-add', {
+            'node-name': 'node0',
+            'driver': iotests.imgfmt,
+            'file': {
+                'driver': 'file',
+                'filename': image
+            }
+        })
+
+    def cleanup_blockdev(self):
+        os.remove(image)
+
+    def add_export(self):
+        self.qsd.cmd('block-export-add', {
+            'id': 'exp0',
+            'type': 'fuse',
+            'node-name': 'node0',
+            'mountpoint': fuse_mount_point,
+            'growable': self.growable,
+            'writable': True,
+            'allow-other': 'off'
+        })
+
+    def stop_qsd(self):
+        if self.qsd:
+            self.qsd.cmd('block-export-del', {'id': 'exp0'})
+            self.qsd.stop()
+            self.qsd = None
+
+    def setUp(self):
+        self.evaluate_preconditions()
+        if not self.supports_preconditions:
+            return
+        Path(fuse_mount_point).touch()
+        self.qsd = QemuStorageDaemon(qmp=True)
+        self.add_blockdev()
+        self.add_export()
+
+    def tearDown(self):
+        if not self.supports_preconditions:
+            return
+        self.stop_qsd()
+        self.cleanup_blockdev()
+        os.remove(fuse_mount_point)
+
+class TestTruncateFileGrowable(TestTruncateBase):
+    growable = True
+
+    def test_o_trunc(self):
+        with open(fuse_mount_point, 'w+b') as file:
+            file.seek(0, os.SEEK_END)
+            self.assertEqual(file.tell(), 0)
+            file.write(b"test")
+        self.stop_qsd()
+
+class TestTruncateFileNotGrowable(TestTruncateBase):
+    growable = False
+
+    def test_o_trunc(self):
+        with open(fuse_mount_point, 'w+b') as file:
+            file.seek(0, os.SEEK_END)
+            self.assertEqual(file.tell(), image_size)
+            file.seek(0, os.SEEK_SET)
+            file.write(b"test")
+        self.stop_qsd()
+
+class TestTruncateBlockdev(TestTruncateBase):
+    growable = False
+
+    def evaluate_preconditions(self):
+        self.supports_preconditions = check_sudo_support()
+
+    def add_blockdev(self):
+        qemu_img('create', '-f', iotests.imgfmt, image, str(image_size))
+        res = subprocess.run(['sudo', '-n', 'losetup', '--show', '-f', image],
+                             check=True, capture_output=True, text=True)
+        self.loopdev = res.stdout.strip()
+        subprocess.run(['sudo', '-n', 'chmod', 'go+rw', self.loopdev],
+                       check=True, capture_output=True)
+        self.qsd.cmd('blockdev-add', {
+            'node-name': 'node0',
+            'driver': iotests.imgfmt,
+            'file': {
+                'driver': 'host_device',
+                'filename': self.loopdev
+            }
+        })
+
+    def cleanup_blockdev(self):
+        subprocess.run(['sudo', '-n', 'losetup', '--detach', self.loopdev],
+                       check=True, capture_output=True)
+        os.remove(image)
+
+    def test_o_trunc(self):
+        if not self.supports_preconditions:
+            iotests.case_notrun('No passwordless sudo for losetup and chmod')
+            return
+
+        with open(fuse_mount_point, 'w+b') as file:
+            file.seek(0, os.SEEK_END)
+            self.assertEqual(file.tell(), image_size)
+            file.seek(0, os.SEEK_SET)
+            file.write(b"test")
+        self.stop_qsd()
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['raw'],
+                 supported_protocols=['file'],
+                 supported_platforms=['linux'])
diff --git a/tests/qemu-iotests/tests/fuse-truncate.out b/tests/qemu-iotests/tests/fuse-truncate.out
new file mode 100644
index 0000000000..8d7e996700
--- /dev/null
+++ b/tests/qemu-iotests/tests/fuse-truncate.out
@@ -0,0 +1,5 @@
+...
+----------------------------------------------------------------------
+Ran 3 tests
+
+OK
-- 
2.47.3



