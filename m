Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA8AD2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 11:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viA4t-0002If-73; Tue, 20 Jan 2026 06:39:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1viA4r-0002He-EV; Tue, 20 Jan 2026 06:39:17 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1viA4o-0000K5-VF; Tue, 20 Jan 2026 06:39:17 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 0292F466FC;
 Tue, 20 Jan 2026 12:39:12 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 eblake@redhat.com
Subject: [PATCH] iotests: test active mirror with unaligned,
 small write zeroes op
Date: Tue, 20 Jan 2026 12:38:57 +0100
Message-ID: <20260120113859.251743-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <0e2a9f8d-c6f4-43dd-936d-4d977d427b96@yandex-team.ru>
References: <0e2a9f8d-c6f4-43dd-936d-4d977d427b96@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1768909095958
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This tests the scenario fixed by "block/mirror: check range
when setting zero bitmap for sync write" [0].

[0] https://lore.kernel.org/qemu-devel/20260112152544.261923-1-f.ebner@proxmox.com/

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 tests/qemu-iotests/151     | 20 ++++++++++++++++++++
 tests/qemu-iotests/151.out |  4 ++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
index 06ee3585db..9b9c815db5 100755
--- a/tests/qemu-iotests/151
+++ b/tests/qemu-iotests/151
@@ -191,6 +191,26 @@ class TestActiveMirror(iotests.QMPTestCase):
 
         self.potential_writes_in_flight = False
 
+    def testUnalignedSmallerThanGranularityWriteZeroes(self):
+        # Fill the source image
+        self.vm.hmp_qemu_io('source', 'write -P 1 0 %i' % self.image_len);
+
+        # Start the block job
+        self.vm.cmd('blockdev-mirror',
+                    job_id='mirror',
+                    filter_node_name='mirror-node',
+                    device='source-node',
+                    target='target-node',
+                    sync='full',
+                    copy_mode='write-blocking')
+
+        # Wait for the READY event
+        self.wait_ready(drive='mirror')
+
+        for offset in range(6 * self.image_len // 8, 7 * self.image_len // 8, 1024 * 1024):
+            self.vm.hmp_qemu_io('source', 'aio_write -z %i 512' % (offset + 512))
+
+        self.complete_and_wait(drive='mirror', wait_ready=False)
 
 class TestThrottledWithNbdExportBase(iotests.QMPTestCase):
     image_len = 128 * 1024 * 1024  # MB
diff --git a/tests/qemu-iotests/151.out b/tests/qemu-iotests/151.out
index 3f8a935a08..2f7d3902f2 100644
--- a/tests/qemu-iotests/151.out
+++ b/tests/qemu-iotests/151.out
@@ -1,5 +1,5 @@
-......
+.......
 ----------------------------------------------------------------------
-Ran 6 tests
+Ran 7 tests
 
 OK
-- 
2.47.3



