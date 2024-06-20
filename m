Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BC2C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 14:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJ1p-0003Hm-Kj; Thu, 20 Jun 2024 10:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sKJ1g-0003Fb-1w; Thu, 20 Jun 2024 10:44:36 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sKJ1d-00018i-0w; Thu, 20 Jun 2024 10:44:35 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:3196:0:640:fabe:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 5AA4C60C87;
 Thu, 20 Jun 2024 17:44:29 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b486::1:24])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 4iL0bh2RiW20-ABHW6XPu; Thu, 20 Jun 2024 17:44:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1718894668;
 bh=odenp/LNRk8KjjxKjcA9pMJ4w/k6evutOr5gqJFwKqU=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=DoXRC7AZ5vseeKtgrKGZ4UDvQYVQLyNR+LDTwvrr62ai4cWeyiZcmQC1upoR3MqjP
 QeNjwqMTJy6Yud3RwzoSH32j+9iRy0q3ZMAu/rQ2+Sfk7Z+baB73hi1JL6vXnNel/z
 ZGHy5/vMoiv4c74U5ccYhdGbr+LZp2OJxdvT1qTI=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 2/2] iotests/backup-discard-source: don't use actual-size
Date: Thu, 20 Jun 2024 17:44:02 +0300
Message-Id: <20240620144402.65896-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620144402.65896-1-vsementsov@yandex-team.ru>
References: <20240620144402.65896-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Relying on disk usage is bad thing, and test just doesn't work on XFS.

Let's instead add a dirty bitmap to track writes to test image.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
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
2.34.1


