Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A0DCCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 21:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIvzr-0007va-7W; Tue, 11 Nov 2025 16:33:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIvzm-0007bu-0V
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:33:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIvzk-000213-1J
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:33:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762896822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ZC45b+YLC8hAjPqvQ8hxvi6YolSPofBUAJKu4Vdz0c=;
 b=T16kuN/7O5DelW9gXdjxYVaNzE+MaexxjfMiUn7HcRxXtUOcAusv9w5Qyf75HNUDs1R8nj
 FJrbNPDnbGHAbM1I6ces9sCOO3GxLAH4oCF7KYdj8+IZ27odLq9yZkETkPhLXzl1JTfmvF
 SUHt1s0u+A05JdPJWpR/Zksloxt2ZrQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-2-yi3z9oOCm6qeMFQSha4A-1; Tue,
 11 Nov 2025 16:33:41 -0500
X-MC-Unique: 2-yi3z9oOCm6qeMFQSha4A-1
X-Mimecast-MFC-AGG-ID: 2-yi3z9oOCm6qeMFQSha4A_1762896820
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 723B91800451; Tue, 11 Nov 2025 21:33:40 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.214])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B804530044E0; Tue, 11 Nov 2025 21:33:38 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 18/28] iotests: Test resizing file node under raw with
 size/offset
Date: Tue, 11 Nov 2025 22:32:28 +0100
Message-ID: <20251111213238.181992-19-kwolf@redhat.com>
In-Reply-To: <20251111213238.181992-1-kwolf@redhat.com>
References: <20251111213238.181992-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This adds some more tests for using the 'size' and 'offset' options of
raw to the recently added resize-below-raw test.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20251028094328.17919-1-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/tests/resize-below-raw     | 53 +++++++++++++++++--
 tests/qemu-iotests/tests/resize-below-raw.out |  4 +-
 2 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/tests/resize-below-raw b/tests/qemu-iotests/tests/resize-below-raw
index 3c9241c918..ddf3f44742 100755
--- a/tests/qemu-iotests/tests/resize-below-raw
+++ b/tests/qemu-iotests/tests/resize-below-raw
@@ -8,16 +8,27 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 import os
+from typing import Dict, Optional
+
 import iotests
 from iotests import imgfmt, qemu_img_create, QMPTestCase
 
 image_size = 1 * 1024 * 1024
 image = os.path.join(iotests.test_dir, 'test.img')
 
-class TestResizeBelowRaw(QMPTestCase):
+class BaseResizeBelowRaw(QMPTestCase):
+    raw_size: Optional[int] = None
+    raw_offset: Optional[int] = None
+
     def setUp(self) -> None:
         qemu_img_create('-f', imgfmt, image, str(image_size))
 
+        extra_options: Dict[str, str] = {}
+        if self.raw_size is not None:
+            extra_options['size'] = str(self.raw_size)
+        if self.raw_offset is not None:
+            extra_options['offset'] = str(self.raw_offset)
+
         self.vm = iotests.VM()
         self.vm.add_blockdev(self.vm.qmp_to_opts({
             'driver': imgfmt,
@@ -26,7 +37,8 @@ class TestResizeBelowRaw(QMPTestCase):
                 'driver': 'file',
                 'filename': image,
                 'node-name': 'file0',
-            }
+            },
+            **extra_options
         }))
         self.vm.launch()
 
@@ -34,14 +46,16 @@ class TestResizeBelowRaw(QMPTestCase):
         self.vm.shutdown()
         os.remove(image)
 
-    def assert_size(self, size: int) -> None:
+    def assert_size(self, size: int, file_size: Optional[int] = None) -> None:
         nodes = self.vm.qmp('query-named-block-nodes', flat=True)['return']
         self.assertEqual(len(nodes), 2)
         for node in nodes:
-            if node['drv'] == 'file':
+            if node['drv'] == 'file' and file_size is not None:
+                self.assertEqual(node['image']['virtual-size'], file_size)
                 continue
             self.assertEqual(node['image']['virtual-size'], size)
 
+class TestResizeBelowUnlimitedRaw(BaseResizeBelowRaw):
     def test_resize_below_raw(self) -> None:
         self.assert_size(image_size)
         self.vm.qmp('block_resize', node_name='file0', size=2*image_size)
@@ -49,5 +63,36 @@ class TestResizeBelowRaw(QMPTestCase):
         self.vm.qmp('block_resize', node_name='node0', size=3*image_size)
         self.assert_size(3*image_size)
 
+# offset = 0 behaves the same as absent offset
+class TestResizeBelowRawWithZeroOffset(TestResizeBelowUnlimitedRaw):
+    raw_offset = 0
+
+class TestResizeBelowRawWithSize(BaseResizeBelowRaw):
+    raw_size = image_size // 2
+
+    def test_resize_below_raw_with_size(self) -> None:
+        self.assert_size(image_size // 2, image_size)
+
+        # This QMP command fails because node0 unshares RESIZE
+        self.vm.qmp('block_resize', node_name='file0', size=2*image_size)
+        self.assert_size(image_size // 2, image_size)
+
+        # This QMP command fails because node0 is a fixed-size disk
+        self.vm.qmp('block_resize', node_name='node0', size=3*image_size)
+        self.assert_size(image_size // 2, image_size)
+
+class TestResizeBelowRawWithOffset(BaseResizeBelowRaw):
+    raw_offset = image_size // 4
+
+    def test_resize_below_raw_with_offset(self) -> None:
+        self.assert_size(image_size * 3 // 4, image_size)
+
+        # This QMP command fails because node0 unshares RESIZE
+        self.vm.qmp('block_resize', node_name='file0', size=2*image_size)
+        self.assert_size(image_size * 3 // 4, image_size)
+
+        self.vm.qmp('block_resize', node_name='node0', size=3*image_size)
+        self.assert_size(3 * image_size, image_size * 13 // 4)
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['raw'], supported_protocols=['file'])
diff --git a/tests/qemu-iotests/tests/resize-below-raw.out b/tests/qemu-iotests/tests/resize-below-raw.out
index ae1213e6f8..89968f35d7 100644
--- a/tests/qemu-iotests/tests/resize-below-raw.out
+++ b/tests/qemu-iotests/tests/resize-below-raw.out
@@ -1,5 +1,5 @@
-.
+....
 ----------------------------------------------------------------------
-Ran 1 tests
+Ran 4 tests
 
 OK
-- 
2.51.1


