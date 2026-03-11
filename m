Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCC5112583A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 14:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0L0F-0001Pf-3r; Wed, 11 Mar 2026 10:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1w0L0D-0001NL-1A; Wed, 11 Mar 2026 10:57:37 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1w0L0A-0002oQ-Pz; Wed, 11 Mar 2026 10:57:36 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 2837A874F9;
 Wed, 11 Mar 2026 15:57:26 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, qemu-stable@nongnu.org
Subject: [PATCH 2/3] iotests/041: add test for mirror with throttled NBD
 export as target
Date: Wed, 11 Mar 2026 15:54:26 +0100
Message-ID: <20260311145717.668492-3-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311145717.668492-1-f.ebner@proxmox.com>
References: <20260311145717.668492-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1773241010367
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Mostly in preparation for commit "iotests/041: add test for duplicate
job-complete with throttled target".

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 tests/qemu-iotests/041     | 112 ++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/041.out |   4 +-
 2 files changed, 113 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 8452845f44..a7e1980f13 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -24,7 +24,7 @@ import os
 import re
 import json
 import iotests
-from iotests import qemu_img, qemu_img_map, qemu_io
+from iotests import qemu_img, qemu_img_map, qemu_io, QemuStorageDaemon
 
 backing_img = os.path.join(iotests.test_dir, 'backing.img')
 target_backing_img = os.path.join(iotests.test_dir, 'target-backing.img')
@@ -1373,6 +1373,116 @@ class TestFilters(iotests.QMPTestCase):
 
         self.complete_and_wait('mirror')
 
+# Tests for mirror where the target is a throttled NBD export.
+class TestThrottledNBDTarget(iotests.QMPTestCase):
+    image_len = 3 * 1024 * 1024
+    bps_total = 1 * 1024 * 1024
+
+    def setUp(self):
+        iotests.create_image(backing_img, self.image_len)
+        iotests.create_image(target_backing_img, self.image_len)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', f'backing_file={backing_img}', '-F', 'raw', test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', f'backing_file={target_backing_img}', '-F', 'raw',
+                 target_img)
+        qemu_io('-c', 'write -P 23 0 3M', test_img)
+
+        self.qsd = QemuStorageDaemon('--nbd-server',
+                                     f'addr.type=unix,addr.path={nbd_sock_path}',
+                                     qmp=True)
+
+        self.qsd.cmd('object-add', {
+            'qom-type': 'throttle-group',
+            'id': 'thrgr-target',
+            'limits': {
+                'bps-total': self.bps_total,
+            }
+        })
+
+        self.qsd.cmd('blockdev-add', {
+            'node-name': 'target',
+            'driver': 'throttle',
+            'throttle-group': 'thrgr-target',
+            'file': {
+                'driver': iotests.imgfmt,
+                'file': {
+                    'driver': 'file',
+                    'filename': target_img
+                }
+            }
+        })
+
+        self.qsd.cmd('block-export-add', {
+            'id': 'exp0',
+            'type': 'nbd',
+            'node-name': 'target',
+            'writable': True
+        })
+
+        self.vm = iotests.VM().add_device('virtio-scsi,id=vio-scsi')
+        self.vm.launch()
+
+        self.vm.cmd('blockdev-add',{
+            'node-name': 'source',
+            'driver': iotests.imgfmt,
+            'file': {
+                'driver': 'file',
+                'filename': test_img
+            },
+            'backing': {
+                'node-name': 'backing',
+                'driver': 'raw',
+                'file': {
+                    'driver': 'file',
+                    'filename': backing_img
+                }
+            }
+        })
+
+        self.vm.cmd('device_add',
+                    driver='scsi-hd',
+                    id='virtio',
+                    bus='vio-scsi.0',
+                    drive='source')
+
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'target',
+            'driver': 'nbd',
+            'export': 'target',
+            'server': {
+                'type': 'unix',
+                'path': nbd_sock_path
+            }
+        })
+
+    def tearDown(self):
+        os.remove(test_img)
+        os.remove(target_img)
+        os.remove(backing_img)
+        os.remove(target_backing_img)
+
+    def test_throttled(self):
+        self.vm.cmd('blockdev-mirror',
+                    job_id='mirror',
+                    device='source',
+                    target='target',
+                    sync='full')
+
+        time.sleep(1)
+        result = self.vm.qmp('query-block-jobs')
+        self.assert_qmp(result, 'return[0]/ready', False)
+        self.vm.qtest(f'clock_step {4 * 1000 * 1000 * 1000}')
+        time.sleep(1) # in real time, the rest should now comlpete fast
+        result = self.vm.qmp('query-block-jobs')
+        self.assert_qmp(result, 'return[0]/ready', True)
+
+        self.complete_and_wait('mirror')
+        self.vm.shutdown()
+        self.qsd.stop()
+        self.assertTrue(iotests.compare_images(test_img, target_img),
+                        'target image does not match source after mirroring')
+
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'],
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index 46651953e8..5273ce86c3 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-...........................................................................................................
+............................................................................................................
 ----------------------------------------------------------------------
-Ran 107 tests
+Ran 108 tests
 
 OK
-- 
2.47.3



