Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A11C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp7GX-0004EA-EC; Tue, 26 Mar 2024 09:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rp7GV-0004C9-1o
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rp7GT-0001Q9-Ek
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711461296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Coa9Um95coZQAOs2TmVRBiG/R0G8A+PNbpwEgpIM3Tg=;
 b=ht9wwx1RRuvULiMrxuMnU2idUkp1LsmGbytzvx45+oAp6Qdjk3skSW8JymDwBA6kHMIMCw
 5df8UEfw4BkT8NbZfK7AdCgpVxKAPdwaZVTHIi2o/OUZSLDxZfWDEwxrDGbMFYbumObYaR
 3/lt235H3hsBRSfbOtrgLChZaj17StI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-rvSwBDJZNxu6Cdy18UcNIQ-1; Tue,
 26 Mar 2024 09:54:53 -0400
X-MC-Unique: rvSwBDJZNxu6Cdy18UcNIQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B42128EC11D;
 Tue, 26 Mar 2024 13:54:53 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6593112132A;
 Tue, 26 Mar 2024 13:54:52 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 6/6] iotests: add test for stream job with an unaligned
 prefetch read
Date: Tue, 26 Mar 2024 14:54:40 +0100
Message-ID: <20240326135440.421609-7-kwolf@redhat.com>
In-Reply-To: <20240326135440.421609-1-kwolf@redhat.com>
References: <20240326135440.421609-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
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
2.44.0


