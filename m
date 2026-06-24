Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040B1CDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNpL-0005WG-4Q; Wed, 24 Jun 2026 09:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNpJ-0005UL-Gb; Wed, 24 Jun 2026 09:39:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNpH-0001Iy-Lw; Wed, 24 Jun 2026 09:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782307999; bh=DvcG+/emGldtmPeJDW0d3whJBKyCeFHS8szQ3LhN0e0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=grknz3PeTe6QompirRChMVPhqBSv4oY7SnfYviNCXDDvK5QWMp3akcEZVT0V85ijN
 tQVLg41FouGfXZpQYLP+JVX8UBVmtUmK1omn/+ZP+r1aG0C9Cs9pCA1FB+gXe/BfVk
 ArlJxgEZJpOet7wUdD7QBWes0stgRYJMB2NirJfbIcVbya7aYczOABKZA+5dbkV1s9
 ymKmUiA6+36j8n2qlZmiDTtpyM1TEZANuHAqQCPX94D5uXqo3ILsNo7zt9Kco7kbiB
 dHeqzKzKRfgU6ipOBmKFKZK4JR2XJ9hjIS2tBx4Ty3GR0qVAHv2onuPR1LDdlr/xSq
 0PXq777a1hgIg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D37241BA9F5;
 Wed, 24 Jun 2026 16:33:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 70ED43DEA44;
 Wed, 24 Jun 2026 16:33:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 067/107] iotests: test shared mmap for fuse export
Date: Wed, 24 Jun 2026 16:31:12 +0300
Message-ID: <20260624133301.403266-67-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
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

From: Fiona Ebner <f.ebner@proxmox.com>

This test would have worked before commit 8599559580 ("fuse: Set
direct_io and parallel_direct_writes") and is working again since
commit HEAD~1 ("block/export/fuse: set FUSE_DIRECT_IO_ALLOW_MMAP flag
to fix regression").

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20260506145424.10249-4-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit ba20257d9b45c28f23a66b3f79bebffd6322ff76)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/tests/fuse-mmap-shared b/tests/qemu-iotests/tests/fuse-mmap-shared
new file mode 100755
index 0000000000..52941a3bb6
--- /dev/null
+++ b/tests/qemu-iotests/tests/fuse-mmap-shared
@@ -0,0 +1,105 @@
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
+    # LUKS would require key-secret in blockdev-add
+    iotests.main(supported_fmts=['generic'],
+                 unsupported_fmts=['luks'],
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


