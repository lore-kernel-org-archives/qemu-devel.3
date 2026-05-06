Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58BCCD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKdec-0006eH-53; Wed, 06 May 2026 10:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wKdeJ-0006Ri-8x; Wed, 06 May 2026 10:54:56 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wKdeG-0005sC-UV; Wed, 06 May 2026 10:54:54 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id ABB90491C2;
 Wed, 06 May 2026 16:54:39 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 qemu-stable@nongnu.org
Subject: [PATCH 3/3] iotests: test shared mmap for fuse export
Date: Wed,  6 May 2026 16:49:58 +0200
Message-ID: <20260506145424.10249-4-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506145424.10249-1-f.ebner@proxmox.com>
References: <20260506145424.10249-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1778079171273
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

This test would have worked before commit 8599559580 ("fuse: Set
direct_io and parallel_direct_writes") and is working again since
commit HEAD~1 ("block/export/fuse: set FUSE_DIRECT_IO_ALLOW_MMAP flag
to fix regression").

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 tests/qemu-iotests/tests/fuse-mmap-shared     | 103 ++++++++++++++++++
 tests/qemu-iotests/tests/fuse-mmap-shared.out |   5 +
 2 files changed, 108 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/fuse-mmap-shared
 create mode 100644 tests/qemu-iotests/tests/fuse-mmap-shared.out

diff --git a/tests/qemu-iotests/tests/fuse-mmap-shared b/tests/qemu-iotests/tests/fuse-mmap-shared
new file mode 100755
index 0000000000..a0a10cea6a
--- /dev/null
+++ b/tests/qemu-iotests/tests/fuse-mmap-shared
@@ -0,0 +1,103 @@
+#!/usr/bin/env python3
+# group: rw
+#
+# Test that a FUSE export can be mmap()-ed with MAP_SHARED
+#
+# Copyright (C) 2026 Proxmox Server Solutions GmbH
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import itertools
+import mmap
+from mmap import MAP_SHARED
+from pathlib import Path
+
+import iotests
+from iotests import qemu_img, qemu_io, QemuStorageDaemon
+
+def test_fuse_support(mount_point):
+    test_qsd = QemuStorageDaemon('--blockdev', 'null-co,node-name=node0',
+                                 qmp=True)
+    res = test_qsd.qmp('block-export-add', {
+        'id': 'exp0',
+        'type': 'fuse',
+        'node-name': 'node0',
+        'mountpoint': mount_point,
+        'allow-other': 'off'
+    })
+    test_qsd.stop()
+    if 'error' in res:
+        assert (res['error']['desc'] ==
+                "Parameter 'type' does not accept value 'fuse'")
+        iotests.notrun('No FUSE support')
+
+# Shared mmap when using direct IO is only supported for Linux kernels >= 6.6
+# with commit e78662e818f94 ("fuse: add a new fuse init flag to relax
+# estrictions in no cache mode").
+def test_linux_kernel_support():
+    [major, minor] = map(int, os.uname().release.split('.')[:2])
+    if major < 6 or (major == 6 and minor < 6):
+        iotests.notrun('No kernel support for shared mmap with direct IO')
+
+image_size = 1 * 1024 * 1024
+image = os.path.join(iotests.test_dir, 'image.' + iotests.imgfmt)
+fuse_mount_point = os.path.join(iotests.test_dir, 'export.fuse')
+Path(fuse_mount_point).touch()
+
+test_fuse_support(fuse_mount_point)
+test_linux_kernel_support()
+
+class TestMmapShared(iotests.QMPTestCase):
+
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, image, str(image_size))
+        qemu_io(image, '-c', f'write -P 23 0 {image_size}')
+
+        self.qsd = QemuStorageDaemon(qmp=True)
+
+        self.qsd.cmd('blockdev-add', {
+            'node-name': 'node0',
+            'driver': iotests.imgfmt,
+            'file': {
+                'driver': 'file',
+                'filename': image
+            }
+        })
+
+        self.qsd.cmd('block-export-add', {
+            'id': 'exp0',
+            'type': 'fuse',
+            'node-name': 'node0',
+            'mountpoint': fuse_mount_point,
+            'writable': True,
+            'allow-other': 'off'
+        })
+
+    def tearDown(self):
+        self.stop_qsd()
+        os.remove(image)
+        os.remove(fuse_mount_point)
+
+    def stop_qsd(self):
+        if self.qsd:
+            self.qsd.stop()
+            self.qsd = None
+
+    def test_mmap_shared(self):
+        with open(fuse_mount_point, 'r+b') as file:
+            with mmap.mmap(file.fileno(), image_size, flags=MAP_SHARED) as mm:
+                buf = bytearray(image_size)
+                buf[:] = itertools.repeat(23, image_size)
+                assert mm.read(image_size) == buf
+                buf[:] = itertools.repeat(42, image_size)
+                mm.seek(0)
+                mm.write(buf)
+                mm.flush()
+        self.stop_qsd()
+        qemu_io(image, '-c', f'read -P 42 0 {image_size}')
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['generic'],
+                 supported_protocols=['file'],
+                 supported_platforms=['linux'])
diff --git a/tests/qemu-iotests/tests/fuse-mmap-shared.out b/tests/qemu-iotests/tests/fuse-mmap-shared.out
new file mode 100644
index 0000000000..ae1213e6f8
--- /dev/null
+++ b/tests/qemu-iotests/tests/fuse-mmap-shared.out
@@ -0,0 +1,5 @@
+.
+----------------------------------------------------------------------
+Ran 1 tests
+
+OK
-- 
2.47.3



