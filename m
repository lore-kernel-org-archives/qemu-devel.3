Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B897C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96zD-0007YU-AN; Tue, 22 Sep 2026 16:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96z0-0006Vp-EN
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yy-0008T1-I6
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9pnESmMHOg/motPjQXq6fH1cMueMeJF8C0Y6hiyubjY=;
 b=X9DobBATY0pRzYA8hHJYcyUicWhNSu8SccwYcbvrAO1ufSfajsVYXfrh/DC7ItaXnMFBj1
 PUUu2emC/f1ySjspab7UH8+FYg4+lrmGrJ5HPYleDGl0+VdQCOMSHOT3G6qbhjXwe0pGa+
 kXZWLjDbM6+wq1pPqdm+wvwcJHXKfWE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-1EmcM4erN4a5TknmNXQaMg-1; Tue,
 22 Sep 2026 16:20:50 -0400
X-MC-Unique: 1EmcM4erN4a5TknmNXQaMg-1
X-Mimecast-MFC-AGG-ID: 1EmcM4erN4a5TknmNXQaMg_1790108449
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 904441955F3F; Tue, 22 Sep 2026 20:20:49 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0E245BC; Tue, 22 Sep 2026 20:20:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:35 +0400
Subject: [PATCH 28/88] qemu-iotests/124: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-28-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=6622;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UU/AFkO666+N3lSHF7TVz+V9GV5MRu/WHJ21aufEtoM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKwvWrgv3qqJ20/IahB5PAfcNH9vb7r6y0yG
 Eml+RjKUDOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisAAKCRDa6OEJdZac
 5cv2D/97JezwBcLN8ysHSieYs3UJ7JHKLKocd0E8KWDSIqzw0Fl8WHf+ed3aAzia1e8rcisgPmH
 2Bpps/1kZINwayfqv3iqQnjiXfyTfv1K25+cEvMWrGM2ZBKSxomcZZdSn+szmn2WZ9ovy7d92E5
 IhzPEKWfzvmHwUR49HjAftYuTjP2KadPHe6puvm6JOwoMFnmZI2L/25vs1FVxhreJwMf8oKw/Tu
 CUO5EbsSjkCTAs1NjolmeBHwYyf9fwuAmoz+QrNi0PBE77T0bQKLbBhqbbodzBPT/WSocWHZHnk
 9zf+4AwQAeKZ5mk+bOBYeRyuiIab5NaTyPVGogaz2KQccyv66CJ109ULZYJpKVjDPvhkUcVUtTH
 3kvhoH1D6CRf5BU1lXb/uYJ7PMeCUCaOiCvEA4Q+NV5W6IhJU6dXZFHkWvKBRdYFBdRbATnFvEg
 /Ou5ovWescRz+0I91XlNv2TFteuk7GgMPOzfs7HsWnKMmdhPcdeqefBx0xrAcJGtxbVuMifByZw
 J9OZn18TE15nH0ge5w4KSIdHDrwchS2IuFqoJvMZMhtCP7+LznhS0/sVwhhQzL2xocDO+236BZ1
 e5TnH8v/vbN/aDebjUGotwq5xFu/crpMVRV9D7bkZk6/Xlw8brQpk/7ti+KXpKTUjLPvpO1Dnwi
 LxgkRr/odWUZ8Wg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/124 | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index ab9ea4d8b59d..662cca71d6d7 100755
--- a/tests/qemu-iotests/124
+++ b/tests/qemu-iotests/124
@@ -249,10 +249,10 @@ class TestIncrementalBackupBase(iotests.QMPTestCase):
             self.assertTrue(iotests.compare_images(last, bitmap.drive['file']))
 
 
-    def hmp_io_writes(self, drive, patterns):
+    def qmp_io_writes(self, drive, patterns):
         for pattern in patterns:
-            self.vm.hmp_qemu_io(drive, 'write -P%s %s %s' % pattern)
-        self.vm.hmp_qemu_io(drive, 'flush')
+            self.vm.qmp_qemu_io(drive, 'write -P%s %s %s' % pattern)
+        self.vm.qmp_qemu_io(drive, 'flush')
 
 
     def do_incremental_simple(self, **kwargs):
@@ -263,12 +263,12 @@ class TestIncrementalBackupBase(iotests.QMPTestCase):
         self.create_incremental()
         # Three writes: One complete overwrite, one new segment,
         # and one partial overlap.
-        self.hmp_io_writes(self.drives[0]['id'], (('0xab', 0, 512),
+        self.qmp_io_writes(self.drives[0]['id'], (('0xab', 0, 512),
                                                   ('0xfe', '16M', '256k'),
                                                   ('0x64', '32736k', '64k')))
         self.create_incremental()
         # Three more writes, one of each kind, like above
-        self.hmp_io_writes(self.drives[0]['id'], (('0x9a', 0, 512),
+        self.qmp_io_writes(self.drives[0]['id'], (('0x9a', 0, 512),
                                                   ('0x55', '8M', '352k'),
                                                   ('0x78', '15872k', '1M')))
         self.create_incremental()
@@ -337,7 +337,7 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
         # overwrite [32736, 32799] which will dirty bitmap clusters at
         # 32M-64K and 32M. 32M+64K will be left undirtied.
         bitmap0 = self.add_bitmap('bitmap0', drive0)
-        self.hmp_io_writes(drive0['id'],
+        self.qmp_io_writes(drive0['id'],
                            (('0xab', 0, 512),
                             ('0xfe', '16M', '256k'),
                             ('0x64', '32736k', '64k')))
@@ -382,7 +382,7 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
 
         drive0 = self.drives[0]
         bitmap0 = self.add_bitmap('bitmap0', drive0)
-        self.hmp_io_writes(drive0['id'], (('0xab', 0, 512),
+        self.qmp_io_writes(drive0['id'], (('0xab', 0, 512),
                                           ('0xfe', '16M', '256k'),
                                           ('0x64', '32736k', '64k')))
         bitmap1 = self.add_bitmap('bitmap1', drive0)
@@ -396,7 +396,7 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
         self.wait_until_completed(drive0['id'])
         self.files.append(drive0['backup'])
 
-        self.hmp_io_writes(drive0['id'], (('0x9a', 0, 512),
+        self.qmp_io_writes(drive0['id'], (('0x9a', 0, 512),
                                           ('0x55', '8M', '352k'),
                                           ('0x78', '15872k', '1M')))
         # Both bitmaps should be correctly in sync.
@@ -450,10 +450,10 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
 
         # Emulate some writes
         if not race:
-            self.hmp_io_writes(drive0['id'], (('0xab', 0, 512),
+            self.qmp_io_writes(drive0['id'], (('0xab', 0, 512),
                                               ('0xfe', '16M', '256k'),
                                               ('0x64', '32736k', '64k')))
-        self.hmp_io_writes(drive1['id'], (('0xba', 0, 512),
+        self.qmp_io_writes(drive1['id'], (('0xba', 0, 512),
                                           ('0xef', '16M', '256k'),
                                           ('0x46', '32736k', '64k')))
 
@@ -584,7 +584,7 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
                     size=(65 * 1048576))
 
         # Dirty the image past the old end
-        self.vm.hmp_qemu_io(self.drives[0]['id'], 'write 64M 64k')
+        self.vm.qmp_qemu_io(self.drives[0]['id'], 'write 64M 64k')
 
         target = self.prepare_backup(size='65M')
         self.create_incremental(target=target)
@@ -640,13 +640,13 @@ class TestIncrementalBackupBlkdebug(TestIncrementalBackupBase):
         # Note: at this point, during a normal execution,
         # Assume that the VM resumes and begins issuing IO requests here.
 
-        self.hmp_io_writes(drive0['id'], (('0xab', 0, 512),
+        self.qmp_io_writes(drive0['id'], (('0xab', 0, 512),
                                           ('0xfe', '16M', '256k'),
                                           ('0x64', '32736k', '64k')))
 
         result = self.create_incremental(validate=False)
         self.assertFalse(result)
-        self.hmp_io_writes(drive0['id'], (('0x9a', 0, 512),
+        self.qmp_io_writes(drive0['id'], (('0x9a', 0, 512),
                                           ('0x55', '8M', '352k'),
                                           ('0x78', '15872k', '1M')))
         self.create_incremental()
@@ -660,7 +660,7 @@ class TestIncrementalBackupBlkdebug(TestIncrementalBackupBase):
 
         drive0 = self.drives[0]
         # NB: The blkdebug script here looks for a "flush, read" pattern.
-        # The flush occurs in hmp_io_writes, and the read during the block job.
+        # The flush occurs in qmp_io_writes, and the read during the block job.
         self.vm.cmd('blockdev-add',
                     node_name=drive0['id'],
                     driver=drive0['fmt'],
@@ -687,7 +687,7 @@ class TestIncrementalBackupBlkdebug(TestIncrementalBackupBase):
         bitmap = self.add_bitmap('bitmap0', drive0)
 
         # Emulate guest activity
-        self.hmp_io_writes(drive0['id'], (('0xab', 0, 512),
+        self.qmp_io_writes(drive0['id'], (('0xab', 0, 512),
                                           ('0xfe', '16M', '256k'),
                                           ('0x64', '32736k', '64k')))
 
@@ -750,5 +750,4 @@ class TestIncrementalBackupBlkdebug(TestIncrementalBackupBase):
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'],
-                 supported_protocols=['file'],
-                 require_hmp=True)
+                 supported_protocols=['file'])

-- 
2.56.0.rc0.29.g47ce80527c56


