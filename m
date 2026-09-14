Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C310C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x683k-0002pB-UP; Mon, 14 Sep 2026 10:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x683H-0002bv-TP
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:53:00 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x683F-0005lI-LA
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:52:59 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso41234865e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 07:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789397576; x=1790002376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FVFVBUMQqJn9U7YWOlxhFjuHlIQg5TGpWx/r9Z6Cy4Q=;
 b=AK5L5La+sXb3mYzrAjW+0BWFcoXHwsD8HdVW3A/lkipIb7emEPCac7c1YyvtSO+xAk
 IU7zNwwjEBZD9HA2DUTXLEEQFXB6nwkd3YvQ+GNEMgKFPbODWNsqtY1NhapJIaqfb6Et
 Nr4SnPrWfQqeSfrAp3F3SsOOK7s6G5nfK+KQs3p0KhcTIniVMvLmtsFgCYFmJNoBHru0
 6LHe6pap3wKbPaAr/6yX5rMWIkA3DkcEZJfxsaxetT8Uj6bb2iMjrlsD9UmFbdDkycry
 xJdJt209SBjji8DtyZ8gG2a5KBxOox9eQI8/QTTuni97v9rkDTQmVW9F2kQon9KtGcN8
 2RDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789397576; x=1790002376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FVFVBUMQqJn9U7YWOlxhFjuHlIQg5TGpWx/r9Z6Cy4Q=;
 b=EP3MoXq7TddGb/qb2PwpWMYodWK/PedMmf0+iZl3i0GL52qdwSnr47FR+By/AHXsSv
 0zoDfjDuOGbG+5RvrY+SuiiJn6g/5C0pB1k72p/jZdfs+bp23TQDFxTPkMYH3+hunEcg
 roJTZ1vtchu3/xI6gaaIRF4SGP9EMoRY+RQ6lzqm3brZnDKKG+hm8XMfDT1hWxIwB+xK
 Woiq50haWXcnNUG2XxATN0nDjHBQGIv4i1I1BKCiLi7ynwNg4xZdb6+GdOmwojBZnDty
 0fyBC4HPw7X9afEcGPMf/oIchSUo+5RblJMq8Ziuc2o4rS43FQhHgeW+GQmXDk6C8+SU
 EnrQ==
X-Gm-Message-State: AFuF++kaCgpOGlu1a7AWspHVcqfEwTYM1N2qjfM2fJbTtjoRy2+5x9/5
 vdnc1JLE2WydnMZ2NWaqLoVsA5eB2UByOOHp+zqf6KPRVakkYC0IF70RaZHULvZz5mS7YgnrHQ7
 0sq1R
X-Gm-Gg: AYBFou3B0lhDhk2T0somGUURYGw1Xx/2lKl4P617UxIer63Usaov/D2Y/lccqgdugMP
 lFJpDf/gF1zPZ6dPiizxJo2B7WD41o+J+6qkDEwdk+5LruqaXEfxpQ3wqP8GvVRP3koqdrFfX/+
 WCpKMb4lhk+00NIpqUFOr5RNDlib2EYQUnHdFvN9aF22hfOBl+Rit03V+YSadX32sSd/VNyazHR
 YdYhQFhtobhnhD0HLHXWvIgRqiRaujuqBxU8ZCrTxT+NsABVgFXxd1q9ynf7PzcmXeGi5ZJLO1q
 3te7opguAzGjKhimWCq+jU3jpFHmRBuZk2tnqWqvXdABdJm/71/OXckY5jtJVa5MDtruZvUOkUT
 r58NTAOt/WqnpimJOFYt31aY2EZifgJc0foxc/jeyXf6vLLqw90VAcciVOcPc3lcCSaYzIbmCuL
 v7umpAEgRu34ihJdWF5Mrr1pe92xkWN1L8ghOmcZvKEsVQhR08Oeogg8j/DHnb6eGy2X07
X-Received: by 2002:a05:600c:a47:b0:49c:fc6e:8cb4 with SMTP id
 5b1f17b1804b1-49e7a67741cmr36331425e9.24.1789397576170; 
 Mon, 14 Sep 2026 07:52:56 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:aec6:5a37:bc54:89b7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e63c9a7c9sm540230595e9.13.2026.09.14.07.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:52:55 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v2 2/9] iotests/040: cover large and fragmented commit runs
Date: Mon, 14 Sep 2026 16:52:43 +0200
Message-ID: <20260914145250.2792879-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914145250.2792879-1-den@openvz.org>
References: <20260914145250.2792879-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=den@openvz.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Denis V. Lunev <den@openvz.org>

040 never commits runs long enough to span more than one block-status
query, so the answer that commit_iteration() is about to start caching
goes untested.

Add two cases on a base <- mid <- active chain, committing mid so the
job takes the regular commit path rather than active commit, and compare
base against a snapshot of mid taken before the commit. One case mixes
multi-megabyte data, zero and hole runs, the other fragments them down
to single clusters with every transition off the 512K boundary.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/040     | 102 ++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/040.out |   4 +-
 2 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 5c18e413ec..e01c9385ba 100755
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
index 1bb1dc5f0e..d2e2a2d98f 100644
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
2.53.0


