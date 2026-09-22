Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A03EC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96zZ-0008Mb-EZ; Tue, 22 Sep 2026 16:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zC-0007WZ-Cx
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zA-0008Uu-4z
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uWR/4wqOnTK5h6KoP4Jpw4AQp5HAuFP1gW4zx67zOAA=;
 b=Kkn7tX4vXYuxjeaGnfGkMcRMQWjy7aTOaSbBmh2OxFgYNtxu2jFzZoXSIMtRAm30Vzc4CN
 VAooxmL/oruiG8bkGjCk5mWDt76V7bjf8ydHhs1yUy775uFqsoONcvHiPACfj5U1RVeas4
 /8LujS2fRhcME+V86U++XagIAMTKsj4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-MD1KucpnOLSTlX_jARHJTQ-1; Tue,
 22 Sep 2026 16:21:01 -0400
X-MC-Unique: MD1KucpnOLSTlX_jARHJTQ-1
X-Mimecast-MFC-AGG-ID: MD1KucpnOLSTlX_jARHJTQ_1790108460
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64FAB1834504; Tue, 22 Sep 2026 20:21:00 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 659A8180056E; Tue, 22 Sep 2026 20:20:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:38 +0400
Subject: [PATCH 31/88] qemu-iotests/151: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-31-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=8052;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=zEvqGlh2zD2RFuBVhoLhjUPWnMDJg7apnbI3daehNko=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKwYsV3TtRW23onix5wkDraX5NpP60M5ajJg
 ggMVl5eq+2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisAAKCRDa6OEJdZac
 5Xx9D/9KF1bxDS3lC1AlGN/V0wr2+y6WbXGSyUMomDx8k5HMa2s+7Jve+HJnCUoL08nLhYpjaPu
 W6nps1DIQ7mTc/fK0jOyPyuzUH6y/n66fsu4URrH2q7bJcDWk3tVxCUZbye3MY+2x5Bz31mgptt
 WweOsW5y6GDBRR+08ZfYt8PaCe/XBPWLFHF21YSZSKBq6P/mjsRCSXGgibmBMp98S1WmtfIBqE+
 2zx1MP87nwpjOnWCB3HaMypYz6KqK/w4LGCQ7gMqPaDDLtB28NntyGWas1nn/58x89q1l4wrMdz
 M4HxasugRspEY49U06cQkxwvuu26klnvOziNdt6r9DbYQ0/Q1Fy2Izj9XKruugiKAi0LBZ3UIMk
 ybvwJZhNztJ+ZRybjaGLAFpLzah35n57syqg4pKVKZcxZrnWbllh1spjX2Cmhc8gbXQxCI3FMNF
 1C6c8qKPVB/a/isgDJiwF+kQPGt8GxihLZsyNYiNwjWmNcBUAHFCnx51NJSc7t9Sya+H3OayjLU
 DGAOL/ZH5stxgAMYytgSFO6fiWff+Rc5PtYjUK4S6NC9R7vpRbeNhCsjZCth0c1whwldMtV5dlD
 Uwo0HmgvwldpsqV6W0MrYtyaVTZADKQkIT8cFoajyhqS8rgtyghenUkn8hZd3b/YvGGlMsA+T75
 Cr9gIkGeLIL3WPg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 tests/qemu-iotests/151 | 51 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
index 204221a5738e..72f7bcaa0c60 100755
--- a/tests/qemu-iotests/151
+++ b/tests/qemu-iotests/151
@@ -69,14 +69,14 @@ class TestActiveMirror(iotests.QMPTestCase):
 
     def doActiveIO(self, sync_source_and_target):
         # Fill the source image
-        self.vm.hmp_qemu_io('source',
+        self.vm.qmp_qemu_io('source',
                             'write -P 1 0 %i' % self.image_len);
 
         # Start some background requests
         for offset in range(1 * self.image_len // 8, 3 * self.image_len // 8, 1024 * 1024):
-            self.vm.hmp_qemu_io('source', 'aio_write -P 2 %i 1M' % offset)
+            self.vm.qmp_qemu_io('source', 'aio_write -P 2 %i 1M' % offset)
         for offset in range(2 * self.image_len // 8, 3 * self.image_len // 8, 1024 * 1024):
-            self.vm.hmp_qemu_io('source', 'aio_write -z %i 1M' % offset)
+            self.vm.qmp_qemu_io('source', 'aio_write -z %i 1M' % offset)
 
         # Start the block job
         self.vm.cmd('blockdev-mirror',
@@ -89,9 +89,9 @@ class TestActiveMirror(iotests.QMPTestCase):
 
         # Start some more requests
         for offset in range(3 * self.image_len // 8, 5 * self.image_len // 8, 1024 * 1024):
-            self.vm.hmp_qemu_io('source', 'aio_write -P 3 %i 1M' % offset)
+            self.vm.qmp_qemu_io('source', 'aio_write -P 3 %i 1M' % offset)
         for offset in range(4 * self.image_len // 8, 5 * self.image_len // 8, 1024 * 1024):
-            self.vm.hmp_qemu_io('source', 'aio_write -z %i 1M' % offset)
+            self.vm.qmp_qemu_io('source', 'aio_write -z %i 1M' % offset)
 
         # Wait for the READY event
         self.wait_ready(drive='mirror')
@@ -101,14 +101,14 @@ class TestActiveMirror(iotests.QMPTestCase):
         # The mirror code itself asserts that the source BDS's dirty
         # bitmap will stay clean between READY and COMPLETED.
         for offset in range(5 * self.image_len // 8, 7 * self.image_len // 8, 1024 * 1024):
-            self.vm.hmp_qemu_io('source', 'aio_write -P 3 %i 1M' % offset)
+            self.vm.qmp_qemu_io('source', 'aio_write -P 3 %i 1M' % offset)
         for offset in range(6 * self.image_len // 8, 7 * self.image_len // 8, 1024 * 1024):
-            self.vm.hmp_qemu_io('source', 'aio_write -z %i 1M' % offset)
+            self.vm.qmp_qemu_io('source', 'aio_write -z %i 1M' % offset)
 
         if sync_source_and_target:
             # If source and target should be in sync after the mirror,
             # we have to flush before completion
-            self.vm.hmp_qemu_io('source', 'aio_flush')
+            self.vm.qmp_qemu_io('source', 'aio_flush')
             self.potential_writes_in_flight = False
 
         self.complete_and_wait(drive='mirror', wait_ready=False)
@@ -121,7 +121,7 @@ class TestActiveMirror(iotests.QMPTestCase):
 
     def testUnalignedActiveIO(self):
         # Fill the source image
-        result = self.vm.hmp_qemu_io('source', 'write -P 1 0 2M')
+        result = self.vm.qmp_qemu_io('source', 'write -P 1 0 2M')
 
         # Start the block job (very slowly)
         self.vm.cmd('blockdev-mirror',
@@ -135,7 +135,7 @@ class TestActiveMirror(iotests.QMPTestCase):
                     speed=1)
 
         # Start an unaligned request to a dirty area
-        result = self.vm.hmp_qemu_io('source', 'write -P 2 %i 1' % (1048576 + 42))
+        result = self.vm.qmp_qemu_io('source', 'write -P 2 %i 1' % (1048576 + 42))
 
         # Let the job finish
         self.vm.cmd('block-job-set-speed', device='mirror', speed=0)
@@ -145,7 +145,7 @@ class TestActiveMirror(iotests.QMPTestCase):
 
     def testIntersectingActiveIO(self):
         # Fill the source image
-        result = self.vm.hmp_qemu_io('source', 'write -P 1 0 2M')
+        result = self.vm.qmp_qemu_io('source', 'write -P 1 0 2M')
 
         # Start the block job (very slowly)
         self.vm.cmd('blockdev-mirror',
@@ -157,23 +157,23 @@ class TestActiveMirror(iotests.QMPTestCase):
                     copy_mode='write-blocking',
                     speed=1)
 
-        self.vm.hmp_qemu_io('source', 'break write_aio A')
-        self.vm.hmp_qemu_io('source', 'aio_write 0 1M')  # 1
-        self.vm.hmp_qemu_io('source', 'wait_break A')
-        self.vm.hmp_qemu_io('source', 'aio_write 0 2M')  # 2
-        self.vm.hmp_qemu_io('source', 'aio_write 0 2M')  # 3
+        self.vm.qmp_qemu_io('source', 'break write_aio A')
+        self.vm.qmp_qemu_io('source', 'aio_write 0 1M')  # 1
+        self.vm.qmp_qemu_io('source', 'wait_break A')
+        self.vm.qmp_qemu_io('source', 'aio_write 0 2M')  # 2
+        self.vm.qmp_qemu_io('source', 'aio_write 0 2M')  # 3
 
         # Now 2 and 3 are in mirror_wait_on_conflicts, waiting for 1
 
-        self.vm.hmp_qemu_io('source', 'break write_aio B')
-        self.vm.hmp_qemu_io('source', 'aio_write 1M 2M')  # 4
-        self.vm.hmp_qemu_io('source', 'wait_break B')
+        self.vm.qmp_qemu_io('source', 'break write_aio B')
+        self.vm.qmp_qemu_io('source', 'aio_write 1M 2M')  # 4
+        self.vm.qmp_qemu_io('source', 'wait_break B')
 
         # 4 doesn't wait for 2 and 3, because they didn't yet set
         # in_flight_bitmap. So, nothing prevents 4 to go except for our
         # break-point B.
 
-        self.vm.hmp_qemu_io('source', 'resume A')
+        self.vm.qmp_qemu_io('source', 'resume A')
 
         # Now we resumed 1, so 2 and 3 goes to the next iteration of while loop
         # in mirror_wait_on_conflicts(). They don't exit, as bitmap is dirty
@@ -181,7 +181,7 @@ class TestActiveMirror(iotests.QMPTestCase):
         # In the past at that point 2 and 3 would wait for each other producing
         # a dead-lock. Now this is fixed and they will wait for request 4.
 
-        self.vm.hmp_qemu_io('source', 'resume B')
+        self.vm.qmp_qemu_io('source', 'resume B')
 
         # After resuming 4, one of 2 and 3 goes first and set in_flight_bitmap,
         # so the other will wait for it.
@@ -193,7 +193,7 @@ class TestActiveMirror(iotests.QMPTestCase):
 
     def testUnalignedSmallerThanGranularityWriteZeroes(self):
         # Fill the source image
-        self.vm.hmp_qemu_io('source', 'write -P 1 0 %i' % self.image_len);
+        self.vm.qmp_qemu_io('source', 'write -P 1 0 %i' % self.image_len);
 
         # Start the block job
         self.vm.cmd('blockdev-mirror',
@@ -208,7 +208,7 @@ class TestActiveMirror(iotests.QMPTestCase):
         self.wait_ready(drive='mirror')
 
         for offset in range(6 * self.image_len // 8, 7 * self.image_len // 8, 1024 * 1024):
-            self.vm.hmp_qemu_io('source', 'aio_write -z %i 512' % (offset + 512))
+            self.vm.qmp_qemu_io('source', 'aio_write -z %i 512' % (offset + 512))
 
         self.complete_and_wait(drive='mirror', wait_ready=False)
 
@@ -323,7 +323,7 @@ class TestLowThrottledWithNbdExport(TestThrottledWithNbdExportBase):
         # progress (because when the job was started, those areas were not
         # intended to be copied, so active mirroring will only lead to not
         # losing progress, but also not making any).
-        self.vm.hmp_qemu_io('source-node',
+        self.vm.qmp_qemu_io('source-node',
                             f'aio_write -P 1 0 {self.image_len // 2}')
         self.vm.qtest(f'clock_step {1 * 1000 * 1000 * 1000}')
 
@@ -434,5 +434,4 @@ class TestHighThrottledWithNbdExport(TestThrottledWithNbdExportBase):
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'raw'],
-                 supported_protocols=['file'],
-                 require_hmp=True)
+                 supported_protocols=['file'])

-- 
2.56.0.rc0.29.g47ce80527c56


