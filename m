Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E08C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 09:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnbXa-0003SR-UT; Fri, 22 Mar 2024 05:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rnbXY-0003R5-Kl; Fri, 22 Mar 2024 05:50:20 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rnbXW-00020m-Ea; Fri, 22 Mar 2024 05:50:20 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 113C1418DD;
 Fri, 22 Mar 2024 10:50:15 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, fam@euphon.net, stefanha@redhat.com,
 t.lamprecht@proxmox.com, w.bumiller@proxmox.com
Subject: [PATCH v3 4/4] iotests: add test for stream job with an unaligned
 prefetch read
Date: Fri, 22 Mar 2024 10:50:09 +0100
Message-Id: <20240322095009.346989-5-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240322095009.346989-1-f.ebner@proxmox.com>
References: <20240322095009.346989-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Previously, bdrv_pad_request() could not deal with a NULL qiov when
a read needed to be aligned. During prefetch, a stream job will pass a
NULL qiov. Add a test case to cover this scenario.

By accident, also covers a previous race during shutdown, where block
graph changes during iteration in bdrv_flush_all() could lead to
unreferencing the wrong block driver state and an assertion failure
later.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

No changes in v3.
New in v2.

 .../tests/stream-unaligned-prefetch           | 86 +++++++++++++++++++
 .../tests/stream-unaligned-prefetch.out       |  5 ++
 2 files changed, 91 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/stream-unaligned-prefetch
 create mode 100644 tests/qemu-iotests/tests/stream-unaligned-prefetch.out

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



