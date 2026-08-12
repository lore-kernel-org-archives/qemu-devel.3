Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E90C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuATI-0004y2-0d; Wed, 12 Aug 2026 11:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuARj-000491-LS; Wed, 12 Aug 2026 11:00:52 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuARh-0002BO-NC; Wed, 12 Aug 2026 11:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546233; bh=X3rI/qcWj9KRsNt0pTxo6IY1/iSXJfXRx0ptQaoiKfU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Jb1Tn944r9rs4XvfKw6e8sasm1Bkxq/ivecu2MtEDv6gDl2Stk6jVbVYFmRj4tI5d
 W1i7lnUdJyYXUTsLoRSaNruwjGjgm4fUSJgzwW/ndZbTvs7poD4qRFU31l91BID3Hm
 XOotkgHXHVycNp3z88loRR4C5WcMRyZ8RiZxRI0g2cECV3rQHBNJrLU57T20xx8pkG
 kEIc4ovfxiy7XnWFbmbAHvQmTWDWeO9iCxG0IrozYdkMY/fkbMqeEEP1i52MEBV1am
 X8MYvNb4YMlf5Rlf06/kDUdbb5ye7Hj6QqynFjO+jHPeokduyZOfuuBBoxCxr0MrzL
 u7+Mpfi9JtulQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AB0D21CA66B;
 Wed, 12 Aug 2026 17:50:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 11A4A409DB0;
 Wed, 12 Aug 2026 17:50:45 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6F5272FA31; Wed, 12 Aug 2026 17:50:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 103/120] iotests: test O_TRUNC behavior for fuse
 exports
Date: Wed, 12 Aug 2026 17:49:26 +0300
Message-ID: <20260812144955.649205-103-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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

The test cases for the blockdev-based export and for the file-based
export with growable=on work before commit a94a1d7699 ("fuse: Manually
process requests (without libfuse)"), then are broken until commit
"block/export/fuse: fix regression with O_TRUNC when export is
growable".

The test case for the blockdev-based export requires passwordless sudo
for losetup and chmod similar to test 108.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20260702132256.661429-3-f.ebner@proxmox.com>
[kwolf: Catch OSError when probing sudo support]
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 7d06bbb2d9ba77e45b5a3131c9e7f934df99d5bc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/tests/fuse-truncate b/tests/qemu-iotests/tests/fuse-truncate
new file mode 100755
index 00000000000..7eee35111c8
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
+    except (OSError, subprocess.CalledProcessError):
+        return False
+    try:
+        subprocess.run(['sudo', '-n', 'chmod', '--version'],
+                       capture_output=True, check=True)
+    except (OSError, subprocess.CalledProcessError):
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
index 00000000000..8d7e9967009
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


