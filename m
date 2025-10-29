Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A70BCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 12:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE4yC-0003di-Vr; Wed, 29 Oct 2025 08:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xr-0003Qi-8c
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xM-000550-I0
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761739628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+1Ut9r8lCcnqPAU7QxkJlD7etLQhVb4lI9907JqxRfU=;
 b=YFUpKY1y90vtdoHM8d225ZYoEdSn7EJ1XVGYmK+b0LfkIeLBMhkTmPQHA6q0JoM6DF+uUI
 Lsu2NTsbJm6SMdDxa5YGyzQPad8wweFZZRQx3+iNjKHSAzc93GRK8pMVH3p9JyWx14i046
 JiTHRUMqBwmdXEXG8zHMzDSnxxwopRo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-07uXfyblNEqync_l67RqRw-1; Wed,
 29 Oct 2025 08:07:05 -0400
X-MC-Unique: 07uXfyblNEqync_l67RqRw-1
X-Mimecast-MFC-AGG-ID: 07uXfyblNEqync_l67RqRw_1761739624
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 396071800D8D; Wed, 29 Oct 2025 12:07:04 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.33.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EEDF0180044F; Wed, 29 Oct 2025 12:07:02 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 14/18] iotests: add test for resizing a 'file' node below a
 'raw' node
Date: Wed, 29 Oct 2025 13:06:30 +0100
Message-ID: <20251029120634.288467-15-kwolf@redhat.com>
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
Message-ID: <20250917115509.401015-6-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/tests/resize-below-raw     | 53 +++++++++++++++++++
 tests/qemu-iotests/tests/resize-below-raw.out |  5 ++
 2 files changed, 58 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/resize-below-raw
 create mode 100644 tests/qemu-iotests/tests/resize-below-raw.out

diff --git a/tests/qemu-iotests/tests/resize-below-raw b/tests/qemu-iotests/tests/resize-below-raw
new file mode 100755
index 0000000000..3c9241c918
--- /dev/null
+++ b/tests/qemu-iotests/tests/resize-below-raw
@@ -0,0 +1,53 @@
+#!/usr/bin/env python3
+# group: rw quick
+#
+# Test what happens when a 'file' node below a 'raw' node is resized.
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
+class TestResizeBelowRaw(QMPTestCase):
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
+                'node-name': 'file0',
+            }
+        }))
+        self.vm.launch()
+
+    def tearDown(self) -> None:
+        self.vm.shutdown()
+        os.remove(image)
+
+    def assert_size(self, size: int) -> None:
+        nodes = self.vm.qmp('query-named-block-nodes', flat=True)['return']
+        self.assertEqual(len(nodes), 2)
+        for node in nodes:
+            if node['drv'] == 'file':
+                continue
+            self.assertEqual(node['image']['virtual-size'], size)
+
+    def test_resize_below_raw(self) -> None:
+        self.assert_size(image_size)
+        self.vm.qmp('block_resize', node_name='file0', size=2*image_size)
+        self.assert_size(2*image_size)
+        self.vm.qmp('block_resize', node_name='node0', size=3*image_size)
+        self.assert_size(3*image_size)
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['raw'], supported_protocols=['file'])
diff --git a/tests/qemu-iotests/tests/resize-below-raw.out b/tests/qemu-iotests/tests/resize-below-raw.out
new file mode 100644
index 0000000000..ae1213e6f8
--- /dev/null
+++ b/tests/qemu-iotests/tests/resize-below-raw.out
@@ -0,0 +1,5 @@
+.
+----------------------------------------------------------------------
+Ran 1 tests
+
+OK
-- 
2.51.0


