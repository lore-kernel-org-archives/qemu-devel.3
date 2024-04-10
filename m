Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A25CCD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSO5-0006Oh-7s; Wed, 10 Apr 2024 03:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSNt-0006CI-40; Wed, 10 Apr 2024 03:28:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSNo-0004uy-4t; Wed, 10 Apr 2024 03:28:40 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B27DE5D6AA;
 Wed, 10 Apr 2024 10:25:06 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5502EB02EA;
 Wed, 10 Apr 2024 10:23:08 +0300 (MSK)
Received: (nullmailer pid 4191823 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 58/87] iotests: add test for stream job with an
 unaligned prefetch read
Date: Wed, 10 Apr 2024 10:22:31 +0300
Message-Id: <20240410072303.4191455-58-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

Previously, bdrv_pad_request() could not deal with a NULL qiov when
a read needed to be aligned. During prefetch, a stream job will pass a
NULL qiov. Add a test case to cover this scenario.

By accident, also covers a previous race during shutdown, where block
graph changes during iteration in bdrv_flush_all() could lead to
unreferencing the wrong block driver state and an assertion failure
later.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20240322095009.346989-5-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 12d7b3bbd3333cededd3b695501d8d247239d769)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/tests/stream-unaligned-prefetch b/tests/qemu-iotests/tests/stream-unaligned-prefetch
new file mode 100755
index 0000000000..546db1d369
--- /dev/null
+++ b/tests/qemu-iotests/tests/stream-unaligned-prefetch
@@ -0,0 +1,86 @@
+#!/usr/bin/env python3
+# group: rw quick
+#
+# Test what happens when a stream job does an unaligned prefetch read
+# which requires padding while having a NULL qiov.
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
+from iotests import imgfmt, qemu_img_create, qemu_io, QMPTestCase
+
+image_size = 1 * 1024 * 1024
+cluster_size = 64 * 1024
+base = os.path.join(iotests.test_dir, 'base.img')
+top = os.path.join(iotests.test_dir, 'top.img')
+
+class TestStreamUnalignedPrefetch(QMPTestCase):
+    def setUp(self) -> None:
+        """
+        Create two images:
+        - base image {base} with {cluster_size // 2} bytes allocated
+        - top image {top} without any data allocated and coarser
+          cluster size
+
+        Attach a compress filter for the top image, because that
+        requires that the request alignment is the top image's cluster
+        size.
+        """
+        qemu_img_create('-f', imgfmt,
+                        '-o', 'cluster_size={}'.format(cluster_size // 2),
+                        base, str(image_size))
+        qemu_io('-c', f'write 0 {cluster_size // 2}', base)
+        qemu_img_create('-f', imgfmt,
+                        '-o', 'cluster_size={}'.format(cluster_size),
+                        top, str(image_size))
+
+        self.vm = iotests.VM()
+        self.vm.add_blockdev(self.vm.qmp_to_opts({
+            'driver': imgfmt,
+            'node-name': 'base',
+            'file': {
+                'driver': 'file',
+                'filename': base
+            }
+        }))
+        self.vm.add_blockdev(self.vm.qmp_to_opts({
+            'driver': 'compress',
+            'node-name': 'compress-top',
+            'file': {
+                'driver': imgfmt,
+                'node-name': 'top',
+                'file': {
+                    'driver': 'file',
+                    'filename': top
+                },
+                'backing': 'base'
+            }
+        }))
+        self.vm.launch()
+
+    def tearDown(self) -> None:
+        self.vm.shutdown()
+        os.remove(top)
+        os.remove(base)
+
+    def test_stream_unaligned_prefetch(self) -> None:
+        self.vm.cmd('block-stream', job_id='stream', device='compress-top')
+
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['qcow2'], supported_protocols=['file'])
diff --git a/tests/qemu-iotests/tests/stream-unaligned-prefetch.out b/tests/qemu-iotests/tests/stream-unaligned-prefetch.out
new file mode 100644
index 0000000000..ae1213e6f8
--- /dev/null
+++ b/tests/qemu-iotests/tests/stream-unaligned-prefetch.out
@@ -0,0 +1,5 @@
+.
+----------------------------------------------------------------------
+Ran 1 tests
+
+OK
-- 
2.39.2


