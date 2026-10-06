Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3A9CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN1y-0001pH-P0; Wed, 07 Oct 2026 04:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xEHm3-0006W8-Gy; Tue, 06 Oct 2026 22:52:59 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <f.ebner@proxmox.com>)
 id 1xEHlu-00047u-7h; Tue, 06 Oct 2026 22:52:49 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6291F47F57;
 Tue, 06 Oct 2026 13:42:45 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 armbru@redhat.com, eblake@redhat.com
Subject: [PATCH v2 1/3] iotests/041: add test for mirror with throttle node as
 source
Date: Tue,  6 Oct 2026 13:42:16 +0200
Message-ID: <20261006114240.478523-2-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261006114240.478523-1-f.ebner@proxmox.com>
References: <20261006114240.478523-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791286964507
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

Mostly in preparation for commit "iotests/041: add tests for mirroring
below throttle node" which adds test cases for commit "blockdev:
mirror: do not require a root block node".

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v2:
* Drop two accidentally included semicolons.

 tests/qemu-iotests/041     | 88 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/041.out |  4 +-
 2 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 8452845f44..2552388690 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1373,6 +1373,94 @@ class TestFilters(iotests.QMPTestCase):
 
         self.complete_and_wait('mirror')
 
+class TestThrottle(iotests.QMPTestCase):
+    image_len = 3 * 1024 * 1024
+    attachTargetImage = True
+
+    def mirror_command(self, device):
+        self.vm.cmd('blockdev-mirror',
+                    job_id='mirror',
+                    device=device,
+                    target='target',
+                    sync='full')
+
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt,
+                 test_img, str(self.image_len))
+        qemu_img('create', '-f', iotests.imgfmt,
+                 target_img, str(self.image_len))
+        qemu_io('-c', 'write -P 23 0 3M', test_img)
+
+        self.vm = iotests.VM().add_device('virtio-scsi,id=vio-scsi')
+        self.vm.launch()
+
+        self.vm.cmd('object-add', {
+                        'id': 'thrgr0',
+                        'qom-type': 'throttle-group',
+                        'limits': {
+                            'bps-total': 1 * 1024
+                        }
+                    })
+
+        if self.attachTargetImage:
+            self.vm.cmd('blockdev-add', {
+                            'node-name': 'target',
+                            'driver': iotests.imgfmt,
+                            'file': {
+                                'driver': 'file',
+                                'filename': target_img
+                            },
+                        })
+
+        source = {
+            'node-name': 'source',
+            'driver': iotests.imgfmt,
+            'file': {
+                'driver': 'file',
+                'filename': test_img
+            },
+        }
+
+        self.vm.cmd('blockdev-add', {
+                        'node-name': 'throttle',
+                        'driver': 'throttle',
+                        'throttle-group': 'thrgr0',
+                        'file': source,
+                    })
+
+        self.vm.cmd('device_add',
+                    driver='scsi-hd',
+                    id='virtio',
+                    bus='vio-scsi.0',
+                    drive='throttle')
+
+    def tearDown(self):
+        os.remove(test_img)
+        os.remove(target_img)
+
+    def test_throttled(self):
+        self.mirror_command('throttle')
+
+        time.sleep(1)
+        result = self.vm.qmp('query-block-jobs')
+        self.assert_qmp(result, 'return[0]/ready', False)
+
+        self.vm.qtest(f'clock_step {4 * 1000 * 1000 * 1000 * 1000}')
+        self.complete_and_wait('mirror')
+        self.vm.shutdown()
+        self.assertTrue(iotests.compare_images(test_img, target_img),
+                        'target image does not match source after mirroring')
+
+class TestThrottleDriveMirror(TestThrottle):
+    attachTargetImage = False
+
+    def mirror_command(self, device):
+        self.vm.cmd('drive-mirror',
+                    job_id='mirror',
+                    device=device,
+                    target=target_img,
+                    sync='full',
+                    mode='existing')
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'],
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index 46651953e8..96a0752f44 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-...........................................................................................................
+.............................................................................................................
 ----------------------------------------------------------------------
-Ran 107 tests
+Ran 109 tests
 
 OK
-- 
2.47.3



