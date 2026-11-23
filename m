Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAC7606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVQVb-0005UG-EE; Mon, 23 Nov 2026 04:38:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xVQVF-0005Pg-Bb; Mon, 23 Nov 2026 04:38:25 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xVQVD-0003V2-1Y; Mon, 23 Nov 2026 04:38:25 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id D1F2241039;
 Mon, 23 Nov 2026 10:38:13 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com
Subject: [PATCH v4 1/2] iotests/041: add test for mirror with throttled NBD
 export as target
Date: Mon, 23 Nov 2026 10:37:40 +0100
Message-ID: <20261123093808.185781-2-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123093808.185781-1-f.ebner@proxmox.com>
References: <20261123093808.185781-1-f.ebner@proxmox.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1795426692382
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mostly in preparation for commit "iotests/041: add test for duplicate
job-complete with throttled target".

Use a second VM instance for providing the NBD export rather than
qemu-storage-daemon, because the latter does not support qtest for
stepping the clock.

Use copy_mode='write-blocking' for easy checking how many bytes were
written in a given time. In the job's offset, the numbers are
inflated, since a 1 KiB write will mean copying a full cluster of
64 KiB.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v4:
* Rebase on current master.
* tearDown: shut down source before target (worked the other way
  around too, since IO was flushed already, but cleaner in this
  order).
* tearDown: also remove nbd socket

 tests/qemu-iotests/041     | 148 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/041.out |   4 +-
 2 files changed, 150 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index abc070435d..ea03a9ace5 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1502,6 +1502,154 @@ class TestThrottleDriveMirror(TestThrottle):
                     sync='full',
                     mode='existing')
 
+# Tests for mirror where the target is a throttled NBD export.
+class TestThrottledNBDTarget(iotests.QMPTestCase):
+    image_len = 32 * 1024 * 1024
+    reqs = 20
+    req_len = 1024
+
+    def setUp(self):
+        iotests.create_image(backing_img, self.image_len)
+        iotests.create_image(target_backing_img, self.image_len)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', f'backing_file={backing_img}', '-F', 'raw', test_img)
+        qemu_img('create', '-f', iotests.imgfmt,
+                 '-o', f'backing_file={target_backing_img}', '-F', 'raw',
+                 target_img)
+        qemu_io('-c', f'write -P 23 0 {self.image_len}', test_img)
+
+        self.target_vm = iotests.VM()
+        self.target_vm.launch()
+
+        self.target_vm.cmd('nbd-server-start', {
+            'addr': {
+                'type': 'unix',
+                'data': {
+                    'path': nbd_sock_path
+                }
+            }
+        })
+
+        self.target_vm.cmd('object-add', {
+            'qom-type': 'throttle-group',
+            'id': 'thrgr-target',
+            'limits': {} # limits are set by the individual tests
+        })
+
+        self.target_vm.cmd('blockdev-add', {
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
+        self.target_vm.cmd('block-export-add', {
+            'id': 'exp0',
+            'type': 'nbd',
+            'node-name': 'target',
+            'writable': True
+        })
+
+        self.vm = iotests.VM().add_device('virtio-scsi,id=vio-scsi')
+        self.vm.launch()
+
+        self.vm.cmd('blockdev-add', {
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
+        self.drive_qdev = '/machine/peripheral/virtio'
+
+    def set_throttle_limits(self, limits):
+        self.target_vm.cmd('qom-set', {
+            'path': 'thrgr-target',
+            'property': 'limits',
+            'value': limits
+        })
+
+    def disable_throttling(self):
+        if self.target_vm.is_running():
+            self.set_throttle_limits({})
+            for i in range(0, self.reqs):
+                self.target_vm.qtest(f'clock_step {1 * 1000 * 1000 * 1000}')
+
+    def tearDown(self):
+        self.vm.shutdown()
+        if self.target_vm.is_running():
+            self.disable_throttling()
+            self.target_vm.shutdown()
+        os.remove(test_img)
+        os.remove(target_img)
+        os.remove(backing_img)
+        os.remove(target_backing_img)
+        os.remove(nbd_sock_path)
+
+    def test_throttled(self):
+        self.vm.cmd('blockdev-mirror',
+                    job_id='mirror',
+                    device='source',
+                    target='target',
+                    sync='full',
+                    copy_mode='write-blocking')
+
+        self.wait_ready('mirror')
+
+        self.set_throttle_limits({'iops-write': 1})
+
+        # Issue requests that will be throttled.
+        for i in range(0, self.reqs):
+            req = f'aio_write -P 7 {i}M {self.req_len}'
+            self.vm.hmp_qemu_io(self.drive_qdev, req, qdev=True)
+
+        # Check that requests do not complete faster than 1 per second. They
+        # might complete in batches, so do not check for exactly 1 per second.
+        for i in range(0, self.reqs):
+            result = self.vm.cmd('query-blockstats')
+            assert result[0]['stats']['wr_bytes'] <= (i + 1) * self.req_len
+
+            self.target_vm.qtest(f'clock_step {1 * 1000 * 1000 * 1000}')
+            time.sleep(0.1)
+
+        self.complete_and_wait('mirror', wait_ready=False)
+        self.target_vm.shutdown()
+        self.vm.shutdown()
+        self.assertTrue(iotests.compare_images(test_img, target_img),
+                        'target image does not match source after mirroring')
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'],
                  supported_protocols=['file'],
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index ec055a9915..4fad1fcbcf 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-.................................................................................................................
+..................................................................................................................
 ----------------------------------------------------------------------
-Ran 113 tests
+Ran 114 tests
 
 OK
-- 
2.47.3



