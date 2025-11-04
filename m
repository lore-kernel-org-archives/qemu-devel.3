Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01464CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGLJF-00050B-4X; Tue, 04 Nov 2025 12:59:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGLFH-0001Ca-AA
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:55:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGLFE-0006pP-V7
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762278899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p2EMYiwxj/oVBU9VEtcLL37qDHoCJVDZD5yuGv+nPBQ=;
 b=Z4NVntCXUena4O38sABFqG/mIJWLnNOshtf27UZbwuFYC6drHGCkSmgJ72rtbXJTWNRbuX
 nIGUPKFCrUZOsYF1Fxfj2Uv+y8wEsExVGRiFXcrbdQdNDBFJoGq6jr+SGwrV+0nt2FoJgs
 v0B16zKi1lMnkOY3yP7pgjfxWZ7+mEA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-M1NXqHl_MXqEC06QF-M_GQ-1; Tue,
 04 Nov 2025 12:54:57 -0500
X-MC-Unique: M1NXqHl_MXqEC06QF-M_GQ-1
X-Mimecast-MFC-AGG-ID: M1NXqHl_MXqEC06QF-M_GQ_1762278897
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA89019560B2; Tue,  4 Nov 2025 17:54:56 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.226.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A2D051800451; Tue,  4 Nov 2025 17:54:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 18/27] iotests: Test resizing file node under raw with
 size/offset
Date: Tue,  4 Nov 2025 18:54:06 +0100
Message-ID: <20251104175415.525388-19-kwolf@redhat.com>
In-Reply-To: <20251104175415.525388-1-kwolf@redhat.com>
References: <20251104175415.525388-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
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
 tests/qemu-iotests/tests/resize-below-raw     | 51 +++++++++++++++++--
 tests/qemu-iotests/tests/resize-below-raw.out |  4 +-
 2 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/tests/resize-below-raw b/tests/qemu-iotests/tests/resize-below-raw
index 3c9241c918..41d21c83b7 100755
--- a/tests/qemu-iotests/tests/resize-below-raw
+++ b/tests/qemu-iotests/tests/resize-below-raw
@@ -14,10 +14,19 @@ from iotests import imgfmt, qemu_img_create, QMPTestCase
 image_size = 1 * 1024 * 1024
 image = os.path.join(iotests.test_dir, 'test.img')
 
-class TestResizeBelowRaw(QMPTestCase):
+class BaseResizeBelowRaw(QMPTestCase):
+    raw_size = None
+    raw_offset = None
+
     def setUp(self) -> None:
         qemu_img_create('-f', imgfmt, image, str(image_size))
 
+        extra_options = {}
+        if self.raw_size is not None:
+            extra_options['size'] = str(self.raw_size)
+        if self.raw_offset is not None:
+            extra_options['offset'] = str(self.raw_offset)
+
         self.vm = iotests.VM()
         self.vm.add_blockdev(self.vm.qmp_to_opts({
             'driver': imgfmt,
@@ -26,7 +35,8 @@ class TestResizeBelowRaw(QMPTestCase):
                 'driver': 'file',
                 'filename': image,
                 'node-name': 'file0',
-            }
+            },
+            **extra_options
         }))
         self.vm.launch()
 
@@ -34,14 +44,16 @@ class TestResizeBelowRaw(QMPTestCase):
         self.vm.shutdown()
         os.remove(image)
 
-    def assert_size(self, size: int) -> None:
+    def assert_size(self, size: int, file_size: int|None = None) -> None:
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
@@ -49,5 +61,36 @@ class TestResizeBelowRaw(QMPTestCase):
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


