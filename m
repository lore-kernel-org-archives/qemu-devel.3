Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9995606A329
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=imchHksj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5cQ-0006PK-N8; Mon, 02 Nov 2026 22:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cO-0006Om-Sw
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cN-0000at-3D
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793678126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w46zRlPYmZtu6PckmhIkKlhVU77eOMnlyzNZpnwauWk=;
 b=imchHksj1WvkveyFeJkHtLAox/sH1j/MvGt8tqgSiepszGlGcG4VUl8ab7GI52m9xpZpFC
 0Fn1SokYf1VzXBuJGt6ss1FQp8l000SThA/2+gbaEVrKQZqIjxwykebkn1W8Jmn1ZJaB9n
 WoDa1a977R3uPHWOm7XsEP4lem3+okE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-4jZqCJITNF6b6cjosy7hbg-1; Mon,
 02 Nov 2026 22:55:24 -0500
X-MC-Unique: 4jZqCJITNF6b6cjosy7hbg-1
X-Mimecast-MFC-AGG-ID: 4jZqCJITNF6b6cjosy7hbg_1793678123
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55BAE1956049; Tue,  3 Nov 2026 03:55:23 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A49037E5; Tue,  3 Nov 2026 03:55:21 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PULL 06/16] iotests/040: cover large and fragmented commit runs
Date: Mon,  2 Nov 2026 21:54:17 -0600
Message-ID: <20261103035506.2688772-24-eblake@redhat.com>
In-Reply-To: <20261103035506.2688772-18-eblake@redhat.com>
References: <20261103035506.2688772-18-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Denis V. Lunev" <den@openvz.org>

040 never commits runs long enough to span more than one block-status
query, so the answer that commit_iteration() is about to start caching
goes untested.

Add two cases on a base <- mid <- active chain, committing mid so the
job takes the regular commit path rather than active commit, and compare
base against a snapshot of mid taken before the commit. One case mixes
multi-megabyte data, zero and hole runs, the other fragments them down
to single clusters with every transition off the 512K boundary.

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20261030010613.1612771-3-den@openvz.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/040     | 102 ++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/040.out |   4 +-
 2 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 5c18e413ec9..e01c9385bae 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -25,13 +25,14 @@
 import time
 import os
 import iotests
-from iotests import qemu_img, qemu_io
+from iotests import qemu_img, qemu_img_create, qemu_io, compare_images
 import struct
 import errno

 backing_img = os.path.join(iotests.test_dir, 'backing.img')
 mid_img = os.path.join(iotests.test_dir, 'mid.img')
 test_img = os.path.join(iotests.test_dir, 'test.img')
+reference_img = os.path.join(iotests.test_dir, 'reference.img')

 class ImageCommitTestCase(iotests.QMPTestCase):
     '''Abstract base class for image commit test cases'''
@@ -951,6 +952,105 @@ class TestCommitWithOverriddenBacking(iotests.QMPTestCase):
         self.vm.qmp('block-job-complete', device='commit')
         self.vm.event_wait('BLOCK_JOB_COMPLETED')

+class TestCommitLargeRuns(iotests.QMPTestCase):
+    """Commit runs long enough to cross commit_iteration()'s cached span."""
+
+    MB = 1024 * 1024
+    CLUSTER = 64 * 1024
+
+    # Runs several COMMIT_BUFFER_SIZE (512K) chunks long, of every kind.
+    SIZE = 32 * MB
+    LAYOUT = [
+        (0, 4 * MB, 'data'),
+        (4 * MB, 6 * MB, 'hole'),
+        (10 * MB, 4 * MB, 'data'),
+        (14 * MB, 6 * MB, 'zero'),
+        (20 * MB, 4 * MB, 'data'),
+        (24 * MB, 8 * MB, 'hole'),
+    ]
+
+    # The same, with every transition off the 512K boundary.
+    SIZE_FRAGMENTED = 384 * CLUSTER  # 24M
+    LAYOUT_FRAGMENTED = [
+        (0, 45 * CLUSTER, 'data'),
+        (45 * CLUSTER, 55 * CLUSTER, 'hole'),
+        (100 * CLUSTER, CLUSTER, 'data'),
+        (101 * CLUSTER, 49 * CLUSTER, 'zero'),
+        (150 * CLUSTER, 80 * CLUSTER, 'data'),
+        (230 * CLUSTER, CLUSTER, 'hole'),
+        (231 * CLUSTER, 69 * CLUSTER, 'data'),
+        (300 * CLUSTER, 83 * CLUSTER, 'zero'),
+        (383 * CLUSTER, CLUSTER, 'hole'),
+    ]
+
+    def setUp(self):
+        self.vm = iotests.VM()
+        self.vm.launch()
+
+    def tearDown(self):
+        self.vm.shutdown()
+        for img in (backing_img, mid_img, test_img, reference_img):
+            if os.path.exists(img):
+                os.remove(img)
+
+    def build_images(self, layout, size):
+        # A pattern of its own in base, so a misplaced cluster shows up.
+        qemu_img_create('-f', iotests.imgfmt, backing_img, str(size))
+        qemu_io('-c', f'write -P 0x11 0 {size}', backing_img)
+
+        qemu_img_create('-f', iotests.imgfmt, '-b', backing_img, '-F',
+                        iotests.imgfmt, mid_img, str(size))
+        for offset, length, kind in layout:
+            if kind == 'data':
+                qemu_io('-c', f'write -P 0x22 {offset} {length}', mid_img)
+            elif kind == 'zero':
+                qemu_io('-c', f'write -z {offset} {length}', mid_img)
+
+        # What base must equal once mid is committed into it.
+        qemu_img('convert', '-f', iotests.imgfmt, '-O', iotests.imgfmt,
+                 mid_img, reference_img)
+
+        # An empty layer above mid, so top_node=mid is not the active one.
+        qemu_img_create('-f', iotests.imgfmt, '-b', mid_img, '-F',
+                        iotests.imgfmt, test_img, str(size))
+
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'base',
+            'driver': iotests.imgfmt,
+            'file': {'driver': 'file', 'filename': backing_img},
+        })
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'mid',
+            'driver': iotests.imgfmt,
+            'file': {'driver': 'file', 'filename': mid_img},
+            'backing': 'base',
+        })
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'active',
+            'driver': iotests.imgfmt,
+            'file': {'driver': 'file', 'filename': test_img},
+            'backing': 'mid',
+        })
+
+    def commit_and_verify(self):
+        self.vm.cmd('block-commit', job_id='commit0', device='active',
+                    top_node='mid', base_node='base')
+        self.wait_until_completed(drive='commit0')
+
+        self.vm.cmd('blockdev-del', node_name='active')
+        self.vm.cmd('blockdev-del', node_name='mid')
+        self.vm.cmd('blockdev-del', node_name='base')
+        self.assertTrue(compare_images(reference_img, backing_img))
+
+    def test_commit_large_runs(self):
+        self.build_images(self.LAYOUT, self.SIZE)
+        self.commit_and_verify()
+
+    def test_commit_fragmented_runs(self):
+        self.build_images(self.LAYOUT_FRAGMENTED, self.SIZE_FRAGMENTED)
+        self.commit_and_verify()
+
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'],
                  supported_protocols=['file'])
diff --git a/tests/qemu-iotests/040.out b/tests/qemu-iotests/040.out
index 1bb1dc5f0ea..d2e2a2d98f6 100644
--- a/tests/qemu-iotests/040.out
+++ b/tests/qemu-iotests/040.out
@@ -1,5 +1,5 @@
-.................................................................
+...................................................................
 ----------------------------------------------------------------------
-Ran 65 tests
+Ran 67 tests

 OK
-- 
2.56.0


