Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7050C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 14:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9PlC-0002QS-1P; Mon, 28 Apr 2025 10:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1u9Pl9-0002Q4-Fy
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 10:47:04 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1u9Pl6-0003KB-9q
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 10:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=kJUPpgfmCRguQ/vEtpiTsLHYCHcslZ8oxVCZLJ88Fls=; b=SZ0350F6Iw64
 vTZ5wlodFQy8Iempkdq+8S8szZrcERbo/+4oIKq+dgzfIQQidgS4TLC84LodhD9VB+4a0ByL6M0fK
 K65c4w3U68rtxsaC16BAMBVnpU9VdVOcNRAkshOdYGhVO/VIrXAvnflv4L3ySScfu6tJR7WZAlmS4
 PM+kiAXpVMj9tsfoTsi1D/dPO2ZkkCZN9oE5t6Unc7Jeyw+R2pCtCd7s1iTisEkpe02rovOtZFTDL
 842hBKQ4FWAORe8nbNFj0wgSbI/288GmXenoGmJcbQUVKO6pxbPUX26uW7ETRYFhP8KLNudMTYtOp
 lwzFn94RTilwkW4dSDcpWQ==;
Received: from [130.117.225.5] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1u9PhP-00BQyK-2o;
 Mon, 28 Apr 2025 16:46:48 +0200
From: andrey.drobyshev@virtuozzo.com
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com, kwolf@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, f.ebner@proxmox.com, pbonzini@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [RFC PATCH 1/1] iotests/graph-changes-while-io: add test case with
 removal of lower snapshot
Date: Mon, 28 Apr 2025 17:46:56 +0300
Message-ID: <20250428144656.877010-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <73839c04-7616-407e-b057-80ca69e63f51@virtuozzo.com>
References: <73839c04-7616-407e-b057-80ca69e63f51@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

This case is catching potential deadlock which takes place when job-dismiss
is issued when I/O requests are processed in a separate iothread.

See https://mail.gnu.org/archive/html/qemu-devel/2025-04/msg04421.html

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 .../qemu-iotests/tests/graph-changes-while-io | 101 ++++++++++++++++--
 .../tests/graph-changes-while-io.out          |   4 +-
 2 files changed, 96 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/tests/graph-changes-while-io b/tests/qemu-iotests/tests/graph-changes-while-io
index 194fda500e..e30f823da4 100755
--- a/tests/qemu-iotests/tests/graph-changes-while-io
+++ b/tests/qemu-iotests/tests/graph-changes-while-io
@@ -27,6 +27,8 @@ from iotests import imgfmt, qemu_img, qemu_img_create, qemu_io, \
 
 
 top = os.path.join(iotests.test_dir, 'top.img')
+snap1 = os.path.join(iotests.test_dir, 'snap1.img')
+snap2 = os.path.join(iotests.test_dir, 'snap2.img')
 nbd_sock = os.path.join(iotests.sock_dir, 'nbd.sock')
 
 
@@ -58,6 +60,15 @@ class TestGraphChangesWhileIO(QMPTestCase):
     def tearDown(self) -> None:
         self.qsd.stop()
 
+    def _wait_for_blockjob(self, status) -> None:
+        done = False
+        while not done:
+            for event in self.qsd.get_qmp().get_events(wait=10.0):
+                if event['event'] != 'JOB_STATUS_CHANGE':
+                    continue
+                if event['data']['status'] == status:
+                    done = True
+
     def test_blockdev_add_while_io(self) -> None:
         # Run qemu-img bench in the background
         bench_thr = Thread(target=do_qemu_img_bench)
@@ -116,13 +127,89 @@ class TestGraphChangesWhileIO(QMPTestCase):
                 'device': 'job0',
             })
 
-            cancelled = False
-            while not cancelled:
-                for event in self.qsd.get_qmp().get_events(wait=10.0):
-                    if event['event'] != 'JOB_STATUS_CHANGE':
-                        continue
-                    if event['data']['status'] == 'null':
-                        cancelled = True
+            self._wait_for_blockjob('null')
+
+        bench_thr.join()
+
+    def test_remove_lower_snapshot_while_io(self) -> None:
+        # Run qemu-img bench in the background
+        bench_thr = Thread(target=do_qemu_img_bench, args=(100000, ))
+        bench_thr.start()
+
+        # While I/O is performed on 'node0' node, consequently add 2 snapshots
+        # on top of it, then remove (commit) them starting from lower one.
+        while bench_thr.is_alive():
+            # Recreate snapshot images on every iteration
+            qemu_img_create('-f', imgfmt, snap1, '1G')
+            qemu_img_create('-f', imgfmt, snap2, '1G')
+
+            self.qsd.cmd('blockdev-add', {
+                'driver': imgfmt,
+                'node-name': 'snap1',
+                'file': {
+                    'driver': 'file',
+                    'filename': snap1
+                }
+            })
+
+            self.qsd.cmd('blockdev-snapshot', {
+                'node': 'node0',
+                'overlay': 'snap1',
+            })
+
+            self.qsd.cmd('blockdev-add', {
+                'driver': imgfmt,
+                'node-name': 'snap2',
+                'file': {
+                    'driver': 'file',
+                    'filename': snap2
+                }
+            })
+
+            self.qsd.cmd('blockdev-snapshot', {
+                'node': 'snap1',
+                'overlay': 'snap2',
+            })
+
+            self.qsd.cmd('block-commit', {
+                'job-id': 'commit-snap1',
+                'device': 'snap2',
+                'top-node': 'snap1',
+                'base-node': 'node0',
+                'auto-finalize': True,
+                'auto-dismiss': False,
+            })
+
+            self._wait_for_blockjob('concluded')
+            self.qsd.cmd('job-dismiss', {
+                'id': 'commit-snap1',
+            })
+
+            self.qsd.cmd('block-commit', {
+                'job-id': 'commit-snap2',
+                'device': 'snap2',
+                'top-node': 'snap2',
+                'base-node': 'node0',
+                'auto-finalize': True,
+                'auto-dismiss': False,
+            })
+
+            self._wait_for_blockjob('ready')
+            self.qsd.cmd('job-complete', {
+                'id': 'commit-snap2',
+            })
+
+            self._wait_for_blockjob('concluded')
+            self.qsd.cmd('job-dismiss', {
+                'id': 'commit-snap2',
+            })
+
+            self.qsd.cmd('blockdev-del', {
+                'node-name': 'snap1'
+            })
+            self.qsd.cmd('blockdev-del', {
+                'node-name': 'snap2'
+            })
 
         bench_thr.join()
 
diff --git a/tests/qemu-iotests/tests/graph-changes-while-io.out b/tests/qemu-iotests/tests/graph-changes-while-io.out
index fbc63e62f8..8d7e996700 100644
--- a/tests/qemu-iotests/tests/graph-changes-while-io.out
+++ b/tests/qemu-iotests/tests/graph-changes-while-io.out
@@ -1,5 +1,5 @@
-..
+...
 ----------------------------------------------------------------------
-Ran 2 tests
+Ran 3 tests
 
 OK
-- 
2.43.5


