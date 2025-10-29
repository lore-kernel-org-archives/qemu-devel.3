Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891F9CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 12:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE4xy-0003QP-Q1; Wed, 29 Oct 2025 08:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xi-0003P9-Eo
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xK-00054J-Ke
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761739626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cCZx8pQMWF2V6jc7yz6lG5be+du26mLG0xjV3VyCdtA=;
 b=VVGhgkWldFZDnxa1bNPqbnI6JOtlsnzJ/8QZUzSG8zneye+B3nF+XDa1fQE4C4HhAqUkwt
 jLcrMoTtvwv7zMg0TKqnvELMTsQyyMAxGMKSt739xthxRAiLJirWqaqIeKNukLB5XUfjfS
 dDvlxt+fwpHEpitp9D4nUGPQ8H0eby0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-ez5XbZFBOeKn4Q-uNv_UEg-1; Wed,
 29 Oct 2025 08:07:03 -0400
X-MC-Unique: ez5XbZFBOeKn4Q-uNv_UEg-1
X-Mimecast-MFC-AGG-ID: ez5XbZFBOeKn4Q-uNv_UEg_1761739622
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77E10180121B; Wed, 29 Oct 2025 12:07:02 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.33.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 39FDB180044F; Wed, 29 Oct 2025 12:07:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 13/18] iotests: add test for resizing a node below filters
Date: Wed, 29 Oct 2025 13:06:29 +0100
Message-ID: <20251029120634.288467-14-kwolf@redhat.com>
In-Reply-To: <20251029120634.288467-1-kwolf@redhat.com>
References: <20251029120634.288467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20250917115509.401015-5-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.51.0


