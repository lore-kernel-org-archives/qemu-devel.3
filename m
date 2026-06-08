Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84424CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWdD8-00014I-4P; Mon, 08 Jun 2026 12:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wWdD6-00013b-MX
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wWdD4-0007PU-RY
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780937542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eic9GKGBf47K8jtvuXw5EiaNEoND+0CxI3NLGGfrcLE=;
 b=cE4elFY4Oymy3Dz8shAu4wpRBeB6WBY8Aq56M3KeVg/9VdidiP7vjO2aXf/hkGtttRGYAq
 C0DxZG6I6G7dS85KXNBtgCLjDwUrzOwNIqB/VtA7h4RjtkODMCQIaDC4xCDcNwbeUtnlOW
 UP0yT1GfGx3IusfYBZDCjfI5BryA3ow=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-kpAv1JhaNc2sG3ob7vsHEw-1; Mon,
 08 Jun 2026 12:52:19 -0400
X-MC-Unique: kpAv1JhaNc2sG3ob7vsHEw-1
X-Mimecast-MFC-AGG-ID: kpAv1JhaNc2sG3ob7vsHEw_1780937538
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14053195411C; Mon,  8 Jun 2026 16:52:18 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.50.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE0EC19540CB; Mon,  8 Jun 2026 16:52:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 3/8] iotests/136: Test stats-intervals with -blockdev/-device
Date: Mon,  8 Jun 2026 18:52:02 +0200
Message-ID: <20260608165207.307488-4-kwolf@redhat.com>
In-Reply-To: <20260608165207.307488-1-kwolf@redhat.com>
References: <20260608165207.307488-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Commit 9f0c763e introduced the "stats-intervals" qdev property for
block devices, a setting that was previously only accessible with
-drive. Extend the corresponding test to include test cases that set the
property on -device instead, both with -drive and -blockdev.

We wouldn't really improve coverage with testing every combination of
account_invalid and account_failed with all modes to set up statistics,
so it seems good enough to test all combinations with the old way, and
only both True or both False with the additional ways.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260521101854.31997-1-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/136     | 87 ++++++++++++++++++++++++++++++++------
 tests/qemu-iotests/136.out |  4 +-
 2 files changed, 77 insertions(+), 14 deletions(-)

diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
index 8fce88bd677..58df876bafc 100755
--- a/tests/qemu-iotests/136
+++ b/tests/qemu-iotests/136
@@ -22,6 +22,7 @@
 
 import iotests
 import os
+import json
 
 interval_length = 10
 nsec_per_sec = 1000000000
@@ -45,14 +46,22 @@ class BlockDeviceStatsTestCase(iotests.QMPTestCase):
     wr_highest_offset = 0
     account_invalid = False
     account_failed = False
+    stats_in_device = False
+    use_blockdev = False
 
     def blockstats(self, device):
         result = self.vm.qmp("query-blockstats")
         for r in result['return']:
-            if r['device'] == device:
+            if r['device'] == device or r['node-name'] == device:
                 return r['stats']
         raise Exception("Device not found for blockstats: %s" % device)
 
+    def qemu_io(self, cmd):
+        if self.use_blockdev:
+            self.vm.hmp_qemu_io("virtio0/virtio-backend", cmd, qdev=True)
+        else:
+            self.vm.hmp_qemu_io("drive0", cmd)
+
     def create_blkdebug_file(self):
         file = open(blkdebug_file, 'w')
         file.write('''
@@ -73,17 +82,54 @@ sector = "%d"
 
     @iotests.skip_if_unsupported(required_drivers)
     def setUp(self):
-        drive_args = []
-        drive_args.append("stats-intervals.0=%d" % interval_length)
-        drive_args.append("stats-account-invalid=%s" %
-                          (self.account_invalid and "on" or "off"))
-        drive_args.append("stats-account-failed=%s" %
-                          (self.account_failed and "on" or "off"))
-        drive_args.append("file.image.read-zeroes=on")
         self.create_blkdebug_file()
-        self.vm = iotests.VM().add_drive('blkdebug:%s:%s://' %
-                                         (blkdebug_file, self.test_driver),
-                                         ','.join(drive_args))
+        self.vm = iotests.VM()
+
+        drive_args = [
+            "file.image.read-zeroes=on",
+        ]
+        if self.stats_in_device:
+            interface = "none"
+            dev_args = {
+                "driver": "virtio-blk",
+                "id": "virtio0",
+                "drive": "drive0",
+                "stats-intervals": [ interval_length ],
+                "account-invalid": "on" if self.account_invalid else "off",
+                "account-failed": "on" if self.account_failed else "off",
+            }
+            self.vm.add_device(json.dumps(dev_args))
+        else:
+            assert not self.use_blockdev
+            interface = "virtio"
+            drive_args += [
+                "stats-intervals.0=%d" % interval_length,
+                "stats-account-invalid=%s" %
+                    (self.account_invalid and "on" or "off"),
+                "stats-account-failed=%s" %
+                    (self.account_failed and "on" or "off"),
+            ]
+
+        if self.use_blockdev:
+            blockdev_args = {
+                "node-name": "drive0",
+                "driver": "raw",
+                "file": {
+                    "driver": "blkdebug",
+                    "config": blkdebug_file,
+                    "image": {
+                        "driver": self.test_driver,
+                        "read-zeroes": True,
+                    },
+                },
+            }
+            self.vm.add_blockdev(json.dumps(blockdev_args))
+        else:
+            self.vm.add_drive('blkdebug:%s:%s://' %
+                              (blkdebug_file, self.test_driver),
+                              ','.join(drive_args),
+                              interface=interface)
+
         self.vm.launch()
         # Set an initial value for the clock
         self.vm.qtest("clock_step %d" % nsec_per_sec)
@@ -261,7 +307,7 @@ sector = "%d"
 
         # Now perform all operations
         for op in ops:
-            self.vm.hmp_qemu_io("drive0", op)
+            self.qemu_io(op)
 
         # Update the expected totals
         self.total_rd_bytes += rd_ops * rd_size
@@ -328,6 +374,12 @@ sector = "%d"
         # All values must be sane before doing any I/O
         self.check_values()
 
+class BlockDeviceStatsTestDevice(BlockDeviceStatsTestCase):
+    stats_in_device = True
+
+class BlockDeviceStatsTestBlockdev(BlockDeviceStatsTestCase):
+    stats_in_device = True
+    use_blockdev = True
 
 class BlockDeviceStatsTestAccountInvalid(BlockDeviceStatsTestCase):
     account_invalid = True
@@ -341,6 +393,17 @@ class BlockDeviceStatsTestAccountBoth(BlockDeviceStatsTestCase):
     account_invalid = True
     account_failed = True
 
+class BlockDeviceStatsTestAccountBothDevice(BlockDeviceStatsTestCase):
+    account_invalid = True
+    account_failed = True
+    stats_in_device = True
+
+class BlockDeviceStatsTestAccountBothBlockdev(BlockDeviceStatsTestCase):
+    account_invalid = True
+    account_failed = True
+    stats_in_device = True
+    use_blockdev = True
+
 class BlockDeviceStatsTestCoroutine(BlockDeviceStatsTestCase):
     test_driver = "null-co"
 
diff --git a/tests/qemu-iotests/136.out b/tests/qemu-iotests/136.out
index cfa5c0d0e66..4823c113d58 100644
--- a/tests/qemu-iotests/136.out
+++ b/tests/qemu-iotests/136.out
@@ -1,5 +1,5 @@
-...................................
+...............................................................
 ----------------------------------------------------------------------
-Ran 35 tests
+Ran 63 tests
 
 OK
-- 
2.54.0


