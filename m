Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FE3D2CE01
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 16:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3I4h-0000YX-Gm; Tue, 22 Oct 2024 12:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3I4b-0000L4-Ey
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t3I4X-00065x-Jq
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729615768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rl0hWf2NeoTp5Fong/EsvdHnc9EM8hnTSIjY+zlizyA=;
 b=ERG53exUQN6Zc5mZqfchfn6ACkiCosY2+5hKzW/qRH1lD02bLexLk/PkqZoi8p84IH9LwA
 yWBAOxoFTzPje97Agp/cQqnU1585e0LlqoLbNhJJnHBnckQIK4q9pkiqsdOOMWx45iM3S4
 vY7WlGK8uANrbkonl2lFxpOdFVyRP/M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-zkNmY3dsPMOLyiW_5LvZaw-1; Tue,
 22 Oct 2024 12:49:27 -0400
X-MC-Unique: zkNmY3dsPMOLyiW_5LvZaw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 475A11955D92; Tue, 22 Oct 2024 16:49:26 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66CD41956056; Tue, 22 Oct 2024 16:49:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 6/9] iotests/backup-discard-source: don't use actual-size
Date: Tue, 22 Oct 2024 18:49:00 +0200
Message-ID: <20241022164903.282174-7-kwolf@redhat.com>
In-Reply-To: <20241022164903.282174-1-kwolf@redhat.com>
References: <20241022164903.282174-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Relying on disk usage is bad thing, and test just doesn't work on XFS.

Let's instead add a dirty bitmap to track writes to test image.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20240620144402.65896-3-vsementsov@yandex-team.ru>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Tested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 .../qemu-iotests/tests/backup-discard-source  | 29 +++++++++++++------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/tests/backup-discard-source b/tests/qemu-iotests/tests/backup-discard-source
index 05fbe5d26b..17fef9c6d3 100755
--- a/tests/qemu-iotests/tests/backup-discard-source
+++ b/tests/qemu-iotests/tests/backup-discard-source
@@ -31,12 +31,6 @@ target_img = os.path.join(iotests.test_dir, 'target')
 size = 1024 * 1024
 
 
-def get_actual_size(vm, node_name):
-    nodes = vm.cmd('query-named-block-nodes', flat=True)
-    node = next(n for n in nodes if n['node-name'] == node_name)
-    return node['image']['actual-size']
-
-
 class TestBackup(iotests.QMPTestCase):
     def setUp(self):
         qemu_img_create('-f', iotests.imgfmt, source_img, str(size))
@@ -84,7 +78,12 @@ class TestBackup(iotests.QMPTestCase):
             }
         })
 
-        self.assertLess(get_actual_size(self.vm, 'temp'), 512 * 1024)
+        self.bitmap = {
+            'node': 'temp',
+            'name': 'bitmap0'
+        }
+
+        self.vm.cmd('block-dirty-bitmap-add', self.bitmap)
 
     def tearDown(self):
         # That should fail, because region is discarded
@@ -113,6 +112,13 @@ class TestBackup(iotests.QMPTestCase):
 
         self.vm.event_wait(name='BLOCK_JOB_COMPLETED')
 
+    def get_bitmap_count(self):
+        nodes = self.vm.cmd('query-named-block-nodes', flat=True)
+        temp = next(n for n in nodes if n['node-name'] == 'temp')
+        bitmap = temp['dirty-bitmaps'][0]
+        assert bitmap['name'] == self.bitmap['name']
+        return bitmap['count']
+
     def test_discard_written(self):
         """
         1. Guest writes
@@ -125,7 +131,7 @@ class TestBackup(iotests.QMPTestCase):
         self.assert_qmp(result, 'return', '')
 
         # Check that data is written to temporary image
-        self.assertGreater(get_actual_size(self.vm, 'temp'), size)
+        self.assertEqual(self.get_bitmap_count(), size)
 
         self.do_backup()
 
@@ -138,13 +144,18 @@ class TestBackup(iotests.QMPTestCase):
         """
         self.do_backup()
 
+        # backup job did discard operation and pollute the bitmap,
+        # we have to clean the bitmap, to check next write
+        self.assertEqual(self.get_bitmap_count(), size)
+        self.vm.cmd('block-dirty-bitmap-clear', self.bitmap)
+
         # Try trigger copy-before-write operation
         result = self.vm.hmp_qemu_io('cbw', 'write 0 1M')
         self.assert_qmp(result, 'return', '')
 
         # Check that data is not written to temporary image, as region
         # is discarded from copy-before-write process
-        self.assertLess(get_actual_size(self.vm, 'temp'), 512 * 1024)
+        self.assertEqual(self.get_bitmap_count(), 0)
 
 
 if __name__ == '__main__':
-- 
2.47.0


