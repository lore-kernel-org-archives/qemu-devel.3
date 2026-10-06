Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED89BCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENCu-0001eu-CS; Wed, 07 Oct 2026 04:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xEIZa-0005B6-2M; Tue, 06 Oct 2026 23:44:17 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xEIZU-0001Mn-Ti; Tue, 06 Oct 2026 23:44:03 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 87F8844458;
 Tue, 06 Oct 2026 13:42:45 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 armbru@redhat.com, eblake@redhat.com
Subject: [PATCH v2 3/3] iotests/041: add tests for mirroring below throttle
 node
Date: Tue,  6 Oct 2026 13:42:18 +0200
Message-ID: <20261006114240.478523-4-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261006114240.478523-1-f.ebner@proxmox.com>
References: <20261006114240.478523-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791286964627
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

Test mirror with a non-root node as a source. This restriction was
dropped with commit "blockdev: mirror: do not require a root block
node".

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

No changes in v2.

 tests/qemu-iotests/041     | 40 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/041.out |  4 ++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 2552388690..abc070435d 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1434,10 +1434,19 @@ class TestThrottle(iotests.QMPTestCase):
                     bus='vio-scsi.0',
                     drive='throttle')
 
+        self.drive_qdev = '/machine/peripheral/virtio'
+
     def tearDown(self):
         os.remove(test_img)
         os.remove(target_img)
 
+    def blockstats(self, device):
+        result = self.vm.qmp("query-blockstats")
+        for r in result['return']:
+            if r['node-name'] == device:
+                return r['stats']
+        raise Exception(f'Device {device} not found when querying blockstats')
+
     def test_throttled(self):
         self.mirror_command('throttle')
 
@@ -1451,6 +1460,37 @@ class TestThrottle(iotests.QMPTestCase):
         self.assertTrue(iotests.compare_images(test_img, target_img),
                         'target image does not match source after mirroring')
 
+    def test_below_throttle(self):
+        self.mirror_command('source')
+
+        # The throttling above should not block the mirror from completing.
+        self.complete_and_wait('mirror')
+        self.vm.shutdown()
+        self.assertTrue(iotests.compare_images(test_img, target_img),
+                        'target image does not match source after mirroring')
+
+    def test_below_throttle_with_io_on_throttle(self):
+        self.mirror_command('source')
+
+        reqs = 3
+        req_len = 1 * 1024
+
+        for i in range(0, reqs):
+            req = f'aio_write -P 7 {i}M {req_len}'
+            self.vm.hmp_qemu_io(self.drive_qdev, req, qdev=True)
+
+        self.wait_ready('mirror')
+        # The throttle node above should still have in-flight requests.
+        assert self.blockstats('throttle')['wr_bytes'] <= 1 * req_len
+
+        self.complete_and_wait('mirror', wait_ready=False)
+        assert self.blockstats('throttle')['wr_bytes'] == reqs * req_len
+        self.vm.shutdown()
+        # The throttle node above is drained too when the mirror finishes, so
+        # the images should match.
+        self.assertTrue(iotests.compare_images(test_img, target_img),
+                        'target image does not match source after mirroring')
+
 class TestThrottleDriveMirror(TestThrottle):
     attachTargetImage = False
 
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index 96a0752f44..ec055a9915 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-.............................................................................................................
+.................................................................................................................
 ----------------------------------------------------------------------
-Ran 109 tests
+Ran 113 tests
 
 OK
-- 
2.47.3



