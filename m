Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0478C5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 18:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMsMN-0002TL-CP; Wed, 04 Jun 2025 13:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsMI-0002P3-05
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:57:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsMG-0000Zc-33
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749059819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cA11rBlXPvecTxzlhAGDwyL2hn2h3jdhDaUm3RbOFdk=;
 b=aWAtX295iKtkhwIihxxMxhnhY6qNWlCCxe7euec5V6HwcVqS5TUxCxYATSExC+KNPCkTq2
 4qxsSv+7lyOPLl9vjlQiY/Eu5+YkDzAB0S9bG1QWlAFTkibwRE+d70cWYjkJYzucbE3lZb
 dTMtr8zoLstoKKcLD8+eFUfdDaEcCJ4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-zWlDvWiQMRmjrXVD20MVOw-1; Wed,
 04 Jun 2025 13:56:58 -0400
X-MC-Unique: zWlDvWiQMRmjrXVD20MVOw-1
X-Mimecast-MFC-AGG-ID: zWlDvWiQMRmjrXVD20MVOw_1749059817
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A822180045B; Wed,  4 Jun 2025 17:56:57 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.34.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0926D18003FD; Wed,  4 Jun 2025 17:56:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 21/24] iotests/graph-changes-while-io: add test case with
 removal of lower snapshot
Date: Wed,  4 Jun 2025 19:56:10 +0200
Message-ID: <20250604175613.344113-22-kwolf@redhat.com>
In-Reply-To: <20250604175613.344113-1-kwolf@redhat.com>
References: <20250604175613.344113-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
[FE: re-use top image and rename snap1->mid as suggested by Kevin Wolf
     remove image file after test as suggested by Kevin Wolf
     add type annotation for function argument to make mypy happy]
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250530151125.955508-22-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 .../qemu-iotests/tests/graph-changes-while-io | 101 ++++++++++++++++--
 .../tests/graph-changes-while-io.out          |   4 +-
 2 files changed, 96 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/tests/graph-changes-while-io b/tests/qemu-iotests/tests/graph-changes-while-io
index 35489e3b5e..dca1167b6d 100755
--- a/tests/qemu-iotests/tests/graph-changes-while-io
+++ b/tests/qemu-iotests/tests/graph-changes-while-io
@@ -27,6 +27,7 @@ from iotests import imgfmt, qemu_img, qemu_img_create, qemu_io, \
 
 
 top = os.path.join(iotests.test_dir, 'top.img')
+mid = os.path.join(iotests.test_dir, 'mid.img')
 nbd_sock = os.path.join(iotests.sock_dir, 'nbd.sock')
 
 
@@ -59,6 +60,15 @@ class TestGraphChangesWhileIO(QMPTestCase):
         self.qsd.stop()
         os.remove(top)
 
+    def _wait_for_blockjob(self, status: str) -> None:
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
@@ -117,15 +127,92 @@ class TestGraphChangesWhileIO(QMPTestCase):
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
+            qemu_img_create('-f', imgfmt, mid, '1G')
+            qemu_img_create('-f', imgfmt, top, '1G')
+
+            self.qsd.cmd('blockdev-add', {
+                'driver': imgfmt,
+                'node-name': 'mid',
+                'file': {
+                    'driver': 'file',
+                    'filename': mid
+                }
+            })
+
+            self.qsd.cmd('blockdev-snapshot', {
+                'node': 'node0',
+                'overlay': 'mid',
+            })
+
+            self.qsd.cmd('blockdev-add', {
+                'driver': imgfmt,
+                'node-name': 'top',
+                'file': {
+                    'driver': 'file',
+                    'filename': top
+                }
+            })
+
+            self.qsd.cmd('blockdev-snapshot', {
+                'node': 'mid',
+                'overlay': 'top',
+            })
+
+            self.qsd.cmd('block-commit', {
+                'job-id': 'commit-mid',
+                'device': 'top',
+                'top-node': 'mid',
+                'base-node': 'node0',
+                'auto-finalize': True,
+                'auto-dismiss': False,
+            })
+
+            self._wait_for_blockjob('concluded')
+            self.qsd.cmd('job-dismiss', {
+                'id': 'commit-mid',
+            })
+
+            self.qsd.cmd('block-commit', {
+                'job-id': 'commit-top',
+                'device': 'top',
+                'top-node': 'top',
+                'base-node': 'node0',
+                'auto-finalize': True,
+                'auto-dismiss': False,
+            })
+
+            self._wait_for_blockjob('ready')
+            self.qsd.cmd('job-complete', {
+                'id': 'commit-top',
+            })
+
+            self._wait_for_blockjob('concluded')
+            self.qsd.cmd('job-dismiss', {
+                'id': 'commit-top',
+            })
+
+            self.qsd.cmd('blockdev-del', {
+                'node-name': 'mid'
+            })
+            self.qsd.cmd('blockdev-del', {
+                'node-name': 'top'
+            })
 
         bench_thr.join()
+        os.remove(mid)
 
 if __name__ == '__main__':
     # Format must support raw backing files
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
2.49.0


