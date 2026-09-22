Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58600C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96zK-00086G-Ev; Tue, 22 Sep 2026 16:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yw-0006Q0-6A
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yt-0008S9-Pm
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oNTNz6KrVX/ozWfk5MRSWZBSIbp2YW2PBkhhWsFHwfw=;
 b=EUiwpMjsPYXSXsT3/wVGngaZwcIb679sr8gS+Lp0+0Jp2kTRXiLFoftGZl0UMqV5OdzQg+
 IPPC68sPtZXq9THfo2kZWE+6/ATyq1d7x7CUAIcSVVuKK4WltM3NPTfsEFfJL55CqOWQ5T
 UaB0sKUWmSIUY/dQgSWfJ8ZudUR046o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-Cj3BAGVoO1KspDwTkS0c9A-1; Tue,
 22 Sep 2026 16:20:43 -0400
X-MC-Unique: Cj3BAGVoO1KspDwTkS0c9A-1
X-Mimecast-MFC-AGG-ID: Cj3BAGVoO1KspDwTkS0c9A_1790108442
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C37CC180059C; Tue, 22 Sep 2026 20:20:42 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0135341D; Tue, 22 Sep 2026 20:20:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:33 +0400
Subject: [PATCH 26/88] qemu-iotests/056: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-26-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=3653;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mUPtkQAbTTET8t6xkv0cjdeZxaf27wE7GZli+Z5Pbvk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKvSrC+nP6BxDJheoP2OltuNx4eU4IQpkoNo
 16Q3btFDxGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirwAKCRDa6OEJdZac
 5YtID/wNzJ7cidxiRojJgwhFJEscG8xup0cMDpU2O5o4MMOoTtRjeWIU7HoHNkl+PNOCSQ0LjTV
 yTNHLqmozd0nnltkmvnoAgCNJrbtE1kTDUb1nzobi3gr1FSN2yLsjA0d/QKR4CoCTmm1G4//tA1
 zGrLR6CIFy2Gs917QgVonIUVmQmi+6kzvA3+vqeiQxtU1S/2Pp6lLcnu17p3hNic/wHDFtHrt1h
 qetnTJye6Ebp5Kiq1Xb6+ChWHNe/Cg/fQda3IyyvjEe/G53WQWMmGBugdHkG4zPCjNtW9/Cbc49
 rh1tncWql/FUtYm0mjbLmOYnOkrYGs6boawjlGx6DQF11mouIUJgNefq0zQaYIQnp+Fv3a/8zYY
 +OXY4BJlyxfmlPIiOxcddyMMzUzn5LHi+uQ1HHEbMhdaAIntilVRTvOfalqSN2/95BOBBIHAhOw
 fXtisD8KNmF1yC9F8ffQoelunE+D4QOBeexrjIcsKl++lbrD1hq2aDbMyUqU2JeNWUHtyd+ljYi
 yE5bOMI2hoJDAMybv6ZqApp40JXpEhz74ZLdPcmNjRbvj5Kzu5UEdbiUzTvhseAczWPXDtyNlqw
 teImFNHmy31CgrFlBgaOTTKqp2juQrU7ph75QNPSOJRcqdON8RFGfwcPTxT/xAxtz46RI+rzHcP
 741ShoxYQGc+u1A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 tests/qemu-iotests/056 | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index 7cc97486951c..b01b11522bb5 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -91,8 +91,8 @@ class TestSyncModesNoneAndTop(iotests.QMPTestCase):
         self.vm.cmd('drive-backup', device='drive0',
                     sync='none', target=target_img)
         time.sleep(1)
-        self.vm.hmp_qemu_io('drive0', 'write -P0x5e 0 512')
-        self.vm.hmp_qemu_io('drive0', 'aio_flush')
+        self.vm.qmp_qemu_io('drive0', 'write -P0x5e 0 512')
+        self.vm.qmp_qemu_io('drive0', 'aio_flush')
         # Verify that the original contents exist in the target image.
 
         event = self.cancel_and_wait()
@@ -119,7 +119,7 @@ class TestBeforeWriteNotifier(iotests.QMPTestCase):
         self.vm.cmd('block-job-pause', device="drive0")
         # Speed is low enough that this must be an uncopied range, which will
         # trigger the before write notifier
-        self.vm.hmp_qemu_io('drive0', 'aio_write -P 1 512512 512')
+        self.vm.qmp_qemu_io('drive0', 'aio_write -P 1 512512 512')
         self.vm.resume_drive("drive0")
         self.vm.cmd('block-job-resume', device="drive0")
         event = self.cancel_and_wait()
@@ -142,10 +142,10 @@ class BackupTest(iotests.QMPTestCase):
         try_remove(self.dest_img2)
         try_remove(self.ref_img)
 
-    def hmp_io_writes(self, drive, patterns):
+    def qmp_io_writes(self, drive, patterns):
         for pattern in patterns:
-            self.vm.hmp_qemu_io(drive, 'write -P%s %s %s' % pattern)
-        self.vm.hmp_qemu_io(drive, 'flush')
+            self.vm.qmp_qemu_io(drive, 'write -P%s %s %s' % pattern)
+        self.vm.qmp_qemu_io(drive, 'flush')
 
     def qmp_backup_and_wait(self, cmd='drive-backup', serror=None,
                             aerror=None, **kwargs):
@@ -180,7 +180,7 @@ class BackupTest(iotests.QMPTestCase):
 
     def test_overlapping_writes(self):
         # Write something to back up
-        self.hmp_io_writes('drive0', [('42', '0M', '2M')])
+        self.qmp_io_writes('drive0', [('42', '0M', '2M')])
 
         # Create a reference backup
         self.qmp_backup_and_wait(device='drive0', format=iotests.imgfmt,
@@ -201,7 +201,7 @@ class BackupTest(iotests.QMPTestCase):
         self.qmp_backup(device='drive0', format=iotests.imgfmt, sync='full',
                         target=self.dest_img, speed=1, auto_dismiss=False)
 
-        self.hmp_io_writes('drive0', [('23', '%ik' % (1024 + 64), '64k'),
+        self.qmp_io_writes('drive0', [('23', '%ik' % (1024 + 64), '64k'),
                                       ('66', '1M', '1M')])
 
         # Let the job complete
@@ -266,7 +266,7 @@ class BackupTest(iotests.QMPTestCase):
         res = self.vm.qmp('query-block-jobs')
         self.assert_qmp(res, 'return', [])
         # Give blkdebug something to chew on
-        self.hmp_io_writes('drive0',
+        self.qmp_io_writes('drive0',
                            (('0x9a', 0, 512),
                            ('0x55', '8M', '352k'),
                            ('0x78', '15872k', '1M')))
@@ -332,5 +332,4 @@ class BackupTest(iotests.QMPTestCase):
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'],
-                 supported_protocols=['file'],
-                 require_hmp=True)
+                 supported_protocols=['file'])

-- 
2.56.0.rc0.29.g47ce80527c56


