Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F02C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjNE-0003Yn-86; Tue, 16 Jul 2024 10:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sTjN4-00035g-U9; Tue, 16 Jul 2024 10:41:40 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sTjMy-0002go-4p; Tue, 16 Jul 2024 10:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=zSlK5i+1UayUSDO7XyqWtJIJ6Zp5SiN8t5JDdEYmRm4=; b=SAiE1j7XAVrr
 rwrO4cvDICGXGIZQRkHW6K1D0H4XnvyLXyhAejMZcRkaE+ZsyCCgX7oSSWjcfEBxF4Rk3nXjZsLrv
 5Tl/O+4GjRxgbITcyGM+iIu4QDDyMAlklE9Ia7wylhRxPTPQR1cx0Cne2tfdNyCCKUcm0nsJA4ovh
 us6H6G41yq7tr5IbbF8TmnxxSlKKpDQpPIyCUUPYROFciP7vcx763bezJSZqQU43N0mLfw/z9ZlnW
 fkE81jaaWYtP4CP3o8433O/T759pYF68KikIZjfdgUE+ExeRr5rYgkjhWanYSPUFr+3dflDOSBPXu
 w/NmGYNyk1EtupO8WHRl0A==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1sTjM2-00D0sH-03;
 Tue, 16 Jul 2024 16:41:14 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, pbonzini@redhat.com, eesposit@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v3 2/3] iotests/298: add testcase for async writes with
 preallocation filter
Date: Tue, 16 Jul 2024 17:41:22 +0300
Message-Id: <20240716144123.651476-3-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240716144123.651476-1-andrey.drobyshev@virtuozzo.com>
References: <20240716144123.651476-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

The testcase simply creates a 64G image with 1M clusters, generates a list
of 1M aligned offsets and feeds aio_write commands with those offsets to
qemu-io run with '--aio native --nocache'.  Then we check the data
written at each of the offsets.  Before the previous commit this could
result into a race within the preallocation filter which would zeroize
some clusters after actually writing data to them.

Note: the test doesn't fail in 100% cases as there's a race involved,
but the failures are pretty consistent so it should be good enough for
detecting the problem.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/298     | 49 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/298.out |  4 ++--
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
index 09c9290711..b7126e9e15 100755
--- a/tests/qemu-iotests/298
+++ b/tests/qemu-iotests/298
@@ -20,8 +20,10 @@
 
 import os
 import iotests
+import random
 
 MiB = 1024 * 1024
+GiB = MiB * 1024
 disk = os.path.join(iotests.test_dir, 'disk')
 overlay = os.path.join(iotests.test_dir, 'overlay')
 refdisk = os.path.join(iotests.test_dir, 'refdisk')
@@ -176,5 +178,52 @@ class TestTruncate(iotests.QMPTestCase):
         self.do_test('off', '150M')
 
 
+class TestPreallocAsyncWrites(iotests.QMPTestCase):
+    def setUp(self):
+        # Make sure we get reproducible write patterns on each run
+        random.seed(42)
+        iotests.qemu_img_create('-f', iotests.imgfmt, disk, '-o',
+                                f'cluster_size={MiB},lazy_refcounts=on',
+                                str(64 * GiB))
+
+    def tearDown(self):
+        os.remove(disk)
+
+    def test_prealloc_async_writes(self):
+        def gen_write_pattern():
+            n = 0
+            while True:
+                yield '-P 0xaa' if n else '-z'
+                n = 1 - n
+
+        def gen_read_pattern():
+            n = 0
+            while True:
+                yield '-P 0xaa' if n else '-P 0x00'
+                n = 1 - n
+
+        requests = 2048 # Number of write/read requests to feed to qemu-io
+        total_clusters = 64 * 1024 # 64G / 1M
+
+        wpgen = gen_write_pattern()
+        rpgen = gen_read_pattern()
+
+        offsets = random.sample(range(0, total_clusters), requests)
+        aio_write_cmds = [f'aio_write {next(wpgen)} {off}M 1M' for off in offsets]
+        read_cmds = [f'read {next(rpgen)} {off}M 1M' for off in offsets]
+
+        proc = iotests.QemuIoInteractive('--aio', 'native', '--nocache',
+                                         '--image-opts', drive_opts)
+        for cmd in aio_write_cmds:
+            proc.cmd(cmd)
+        proc.close()
+
+        proc = iotests.QemuIoInteractive('-f', iotests.imgfmt, disk)
+        for cmd in read_cmds:
+            out = proc.cmd(cmd)
+            self.assertFalse('Pattern verification failed' in str(out))
+        proc.close()
+
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'], required_fmts=['preallocate'])
diff --git a/tests/qemu-iotests/298.out b/tests/qemu-iotests/298.out
index fa16b5ccef..6323079e08 100644
--- a/tests/qemu-iotests/298.out
+++ b/tests/qemu-iotests/298.out
@@ -1,5 +1,5 @@
-.............
+..............
 ----------------------------------------------------------------------
-Ran 13 tests
+Ran 14 tests
 
 OK
-- 
2.39.3


