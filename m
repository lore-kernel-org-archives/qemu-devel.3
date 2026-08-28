Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A876C61DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzxqL-0002iF-No; Fri, 28 Aug 2026 10:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzxqJ-0002go-Lt
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 10:46:07 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzxqG-0000fG-Q5
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 10:46:07 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49b8be0409fso5703725e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 07:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787928363; x=1788533163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ic8YSpl0sDXU/HqDuSw78ZZ5FsWNoX87Js49G50yPhs=;
 b=Q+6HcWmiy9o2st3Trq0lfSEPBWAQuB5uZUrq9Y70ikDCEO8g8EqkRW8UG+QRLrU7/r
 6oi3CbY8o3dr35fpwfMd2JokWKt+wS1XNRib0j9i458ABXOeBQ9XhvfDOaNXiB5rdpim
 bax+TCnyxGH9JQea4jySw+LUv43lw+5ofl9coiXo2RSz9DWX/Cmygfc5AKdn6kjlrI9R
 jKKFLr5ONJ9DqWlZ+ZsKmGy/WEkU9hTA4b5DJ3TPnPBLZcggaIeue2bxwesDv3ZawgM2
 NHZYh+CFe74NEHnavqqUqyweFxUbpjZSExycT4WQasH3B8Bz9xL5SyRYNmFzcR6cCBGy
 +89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787928363; x=1788533163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ic8YSpl0sDXU/HqDuSw78ZZ5FsWNoX87Js49G50yPhs=;
 b=NeLylop67g8pfYbhAG/rN8ieFYRNPtBajwfD6TNUAQmMNMWWJ6l/HVnBK1CqzPLJN4
 oWnAYy7ZbGu3w5F2GMlyolnSi7sKNG6W80wtMpyzVzDxncEj/lQNeZWDeKpTn/exOJAy
 L7WFXrt8jLjvmTH36y4/tBGdCiR8XXRRGHL38VIsA8Y+KGAV845Fs3Ab26XzFTRCJUyf
 mP2uelDqL9AYrwFCge9OlcnMNXpVXFD6Tr3MN5UkWlnbcAKcosaqqsMOGMFr3SMYC8zI
 FMM8LRhxpoUW9jSGPLb9+fQzuTtIqzaQB2ve/wzzTOwWMVBI5CA7BRj30KWoJlzlikNK
 GL7g==
X-Gm-Message-State: AFuF++nhSGqjYcpn759XGAFZkwjlLWGxXYiGIUsiufzZ0UvH6XYeeST6
 ysRZo4X1Pl1UPNV3IDlmPGMYxGR7sb5fIxBnmbixi7XcLZTvUW1xh/ecFegapBSX69L/6m66s/p
 lT28N
X-Gm-Gg: AR+sD10U77rvq9arUAzILQmtb1FyT079Ot9CfUaJ7ebHxZMQP9v/sMZJrcm0eta37Wf
 i7c25XJMioffb07aXufU78WB3Uo3loe83+ALRslh3GHD6dQ5JhFIdhfaj7J05mhTe5c4O/G1a+G
 dMN7yg7JTsqok/J1yTxNBjHtQb3Mro66nUZeGXmn6cLSxBnEKP0e4n/cmnPpjbnEjIK7yDSllyG
 7QHg6GQSgauJHjSsmHYGvGY1I//ire+hIQTrcRv6Qcex2XK5cC41KORxitUGNCoVYHJfDMuYUtc
 0BPww3k85vFd4ZdCvq7V5sx+VaXMBCCnUXBNEzEOIHSAFZdaolpmAez/zRWi9dR1VhTr/elw8FW
 malQ7YUCps2af7Ug4+6cttymQjw8e9u/gSkVCT+yvGO20emLnwzPZ2llPbS9+jhYX5M5tx1jmC5
 Frk9IpVB4NQejZrYLj9/XTAJbjdvbvTmEFXFrAehR/7QCZfYnlEkmdIFaBlg==
X-Received: by 2002:a05:600c:5288:b0:499:84fe:5f3e with SMTP id
 5b1f17b1804b1-49b91c41014mr122321075e9.9.1787928363074; 
 Fri, 28 Aug 2026 07:46:03 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9458:da19:ab04:373a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b94dcaf61sm53730925e9.4.2026.08.28.07.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:46:02 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 4/9] iotests/124: cover backup of zero clusters and holes
Date: Fri, 28 Aug 2026 16:45:49 +0200
Message-ID: <20260828144554.1741910-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828144554.1741910-1-den@openvz.org>
References: <20260828144554.1741910-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=den@openvz.org; helo=mail-wm1-x330.google.com
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

The backup tests compare content only, and their sources hold data
alone, so nothing pins how backup treats zero clusters and holes. Back
up a source mixing data, write-zero and holes with sync=full, sync=top
and sync=bitmap, and check the target with qemu-img map, which tells a
copied cluster apart from a write-zero and from an untouched one.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/124     | 402 ++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/124.out |   4 +-
 2 files changed, 403 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index b2f4328e34..eb5ab02904 100755
--- a/tests/qemu-iotests/124
+++ b/tests/qemu-iotests/124
@@ -22,8 +22,11 @@
 #
 
 import os
+from collections import namedtuple
+
 import iotests
-from iotests import try_remove
+from iotests import (compare_images, qemu_img_create, qemu_img_map, qemu_io,
+                     try_remove)
 from qemu.qmp.qmp_client import ExecuteError
 
 
@@ -748,6 +751,403 @@ class TestIncrementalBackupBlkdebug(TestIncrementalBackupBase):
         self.check_backups()
 
 
+# Backup of sources mixing data, zero clusters and holes.
+
+Extent = namedtuple('Extent', ['start', 'length', 'kind'])
+
+source_img = os.path.join(iotests.test_dir, 'source')
+base_img = os.path.join(iotests.test_dir, 'base')
+target_img = os.path.join(iotests.test_dir, 'target')
+
+SIZE = 64 * 1024 * 1024
+MB = 1024 * 1024
+CLUSTER = 64 * 1024
+
+# Data, write-zero and holes, every combination at a cluster boundary.
+LAYOUT = [
+    (0, MB, 'data'),
+    (2 * MB, MB, 'zero'),
+    (5 * MB, 2 * MB, 'data'),
+    (8 * MB, MB, 'zero'),
+    (10 * MB, MB // 2, 'data'),
+    (20 * MB, 4 * MB, 'zero'),
+    (30 * MB, MB, 'data'),
+]
+
+# Single-cluster runs, and a zero run ending exactly at EOF.
+BOUNDARY_SIZE = 16 * MB
+LAYOUT_BOUNDARY = [
+    (0, CLUSTER, 'zero'),
+    (CLUSTER, CLUSTER, 'data'),
+    (2 * CLUSTER, CLUSTER, 'zero'),
+    (3 * CLUSTER, CLUSTER, 'data'),
+    (4 * CLUSTER, 8 * MB, 'zero'),
+    (4 * CLUSTER + 8 * MB, CLUSTER, 'data'),
+    (BOUNDARY_SIZE - CLUSTER, CLUSTER, 'zero'),
+]
+
+# A zero run past the old block_copy_chunk_size() 16M cap.
+LARGE_ZERO_SIZE = 48 * MB
+LAYOUT_LARGE_ZERO = [
+    (0, MB, 'data'),
+    (4 * MB, 32 * MB, 'zero'),
+    (40 * MB, MB, 'data'),
+]
+
+# Image size not a multiple of the cluster size: a partial tail cluster.
+TAIL_SIZE = 4 * MB + 4096
+LAYOUT_TAIL_ZERO = [
+    (0, MB, 'data'),
+    (2 * MB, TAIL_SIZE - 2 * MB, 'zero'),
+]
+LAYOUT_TAIL_DATA = [
+    (0, MB, 'data'),
+    (2 * MB, MB, 'zero'),
+    (4 * MB, TAIL_SIZE - 4 * MB, 'data'),
+]
+
+
+def coalesce(extents):
+    out = []
+    for e in extents:
+        prev = out[-1] if out else None
+        adjacent = prev is not None and prev.start + prev.length == e.start
+        if adjacent and prev.kind == e.kind:
+            out[-1] = prev._replace(length=prev.length + e.length)
+        else:
+            out.append(e)
+    return out
+
+
+def layout_to_extents(layout, size, gap='hole'):
+    extents = []
+    pos = 0
+    for offset, length, kind in layout:
+        if offset > pos:
+            extents.append(Extent(pos, offset - pos, gap))
+        extents.append(Extent(offset, length, kind))
+        pos = offset + length
+    if pos < size:
+        extents.append(Extent(pos, size - pos, gap))
+    return coalesce(extents)
+
+
+class TestBackupZeroClusters(iotests.QMPTestCase):
+    def setUp(self):
+        self.vm = iotests.VM()
+        self.vm.launch()
+
+    def tearDown(self):
+        self.vm.shutdown()
+        for img in (source_img, base_img, target_img):
+            if os.path.exists(img):
+                os.remove(img)
+
+    def hmp_write(self, drive, cmd):
+        res = self.vm.hmp_qemu_io(drive, cmd)
+        assert 'error' not in res['return'].lower(), res
+
+    def assert_map(self, img, layout, size, backing=False, gap='hole'):
+        # Content is not enough, pin the data/zero/hole split as well.
+        def classify(e):
+            is_hole = e['depth'] > 0 if backing else not e['present']
+            return 'hole' if is_hole else ('zero' if e['zero'] else 'data')
+
+        actual = coalesce([Extent(e['start'], e['length'], classify(e))
+                           for e in qemu_img_map(img)])
+
+        self.assertEqual(actual, layout_to_extents(layout, size, gap))
+
+    def add_source(self, layout=None, size=SIZE, backing=None):
+        if layout is None:
+            layout = LAYOUT
+
+        create_args = ['-f', iotests.imgfmt]
+        if backing:
+            create_args += ['-b', backing, '-F', iotests.imgfmt]
+        create_args += [source_img, str(size)]
+        qemu_img_create(*create_args)
+
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'src',
+            'driver': iotests.imgfmt,
+            'file': {'driver': 'file', 'filename': source_img},
+        })
+
+        # Write through the node, so an attached bitmap sees it.
+        for offset, length, kind in layout:
+            opt = '-z' if kind == 'zero' else '-P 0x5a'
+            self.hmp_write('src', f'write {opt} {offset} {length}')
+
+    def do_backup(self, sync, target_backing=None, size=SIZE, prefill=None,
+                 **kwargs):
+        create_args = ['-f', iotests.imgfmt]
+        if target_backing:
+            create_args += ['-b', target_backing, '-F', iotests.imgfmt]
+        create_args += [target_img, str(size)]
+        qemu_img_create(*create_args)
+
+        if prefill is not None:
+            # Not zero, so a skipped cluster is provably untouched.
+            qemu_io('-c', f'write -P {prefill} 0 {size}', target_img)
+
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'target',
+            'driver': iotests.imgfmt,
+            'file': {'driver': 'file', 'filename': target_img},
+        })
+
+        self.vm.cmd('blockdev-backup', device='src', target='target',
+                    job_id='bk0', sync=sync, **kwargs)
+        self.wait_until_completed(drive='bk0')
+
+        self.vm.cmd('blockdev-del', node_name='target')
+        self.vm.cmd('blockdev-del', node_name='src')
+
+    def test_full(self):
+        self.add_source()
+        self.do_backup('full')
+        self.assertTrue(compare_images(source_img, target_img))
+        self.assert_map(target_img, LAYOUT, SIZE, gap='zero')
+
+    def test_full_zero_overwrite(self):
+        # full skips holes, so only check that zero overwrites prefill.
+        self.add_source(layout=[(2 * MB, MB, 'zero')])
+        self.do_backup('full', prefill=0xcc)
+        qemu_io('-c', f'read -P 0 {2 * MB} {MB}', target_img)
+
+    def test_bitmap(self):
+        self.add_source()
+
+        # A new bitmap tracks nothing yet: dirty all, then re-apply.
+        self.vm.cmd('block-dirty-bitmap-add', node='src', name='bm0')
+        self.hmp_write('src', f'write -z 0 {SIZE}')
+        for offset, length, kind in LAYOUT:
+            opt = '-z' if kind == 'zero' else '-P 0x5a'
+            self.hmp_write('src', f'write {opt} {offset} {length}')
+
+        self.do_backup('bitmap', bitmap='bm0', bitmap_mode='never')
+        self.assertTrue(compare_images(source_img, target_img))
+
+        # The blanket write-zero above turned LAYOUT's gaps into zero.
+        self.assert_map(target_img, LAYOUT, SIZE, gap='zero')
+
+    def test_top(self):
+        # Non-zero backing data, so a hole and an explicit zero differ.
+        qemu_img_create('-f', iotests.imgfmt, base_img, str(SIZE))
+        qemu_io('-c', f'write -P 0x33 0 {SIZE}', base_img)
+
+        self.add_source(backing=base_img)
+
+        self.do_backup('top', target_backing=base_img)
+        self.assertTrue(compare_images(source_img, target_img))
+        self.assert_map(target_img, LAYOUT, SIZE, backing=True)
+
+    def test_boundary_full(self):
+        self.add_source(layout=LAYOUT_BOUNDARY, size=BOUNDARY_SIZE)
+        self.do_backup('full', size=BOUNDARY_SIZE)
+        self.assertTrue(compare_images(source_img, target_img))
+        self.assert_map(target_img, LAYOUT_BOUNDARY, BOUNDARY_SIZE,
+                        gap='zero')
+
+    def test_boundary_bitmap(self):
+        self.add_source(layout=LAYOUT_BOUNDARY, size=BOUNDARY_SIZE)
+
+        self.vm.cmd('block-dirty-bitmap-add', node='src', name='bm0')
+        self.hmp_write('src', f'write -z 0 {BOUNDARY_SIZE}')
+        for offset, length, kind in LAYOUT_BOUNDARY:
+            opt = '-z' if kind == 'zero' else '-P 0x5a'
+            self.hmp_write('src', f'write {opt} {offset} {length}')
+
+        self.do_backup('bitmap', bitmap='bm0', size=BOUNDARY_SIZE,
+                       bitmap_mode='never')
+        self.assertTrue(compare_images(source_img, target_img))
+        self.assert_map(target_img, LAYOUT_BOUNDARY, BOUNDARY_SIZE, gap='zero')
+
+    def test_large_zero_full(self):
+        self.add_source(layout=LAYOUT_LARGE_ZERO, size=LARGE_ZERO_SIZE)
+        self.do_backup('full', size=LARGE_ZERO_SIZE)
+        self.assertTrue(compare_images(source_img, target_img))
+        self.assert_map(target_img, LAYOUT_LARGE_ZERO, LARGE_ZERO_SIZE,
+                        gap='zero')
+
+    def test_large_zero_bitmap(self):
+        self.add_source(layout=LAYOUT_LARGE_ZERO, size=LARGE_ZERO_SIZE)
+
+        self.vm.cmd('block-dirty-bitmap-add', node='src', name='bm0')
+        self.hmp_write('src', f'write -z 0 {LARGE_ZERO_SIZE}')
+        for offset, length, kind in LAYOUT_LARGE_ZERO:
+            opt = '-z' if kind == 'zero' else '-P 0x5a'
+            self.hmp_write('src', f'write {opt} {offset} {length}')
+
+        self.do_backup('bitmap', bitmap='bm0', size=LARGE_ZERO_SIZE,
+                       bitmap_mode='never')
+        self.assertTrue(compare_images(source_img, target_img))
+        self.assert_map(target_img, LAYOUT_LARGE_ZERO, LARGE_ZERO_SIZE,
+                        gap='zero')
+
+    def test_huge_zero(self):
+        # One run past BLOCK_COPY_MAX_ZERO_CHUNK (256M), so it splits.
+        size = 768 * MB
+        self.add_source(layout=[(0, size, 'zero')], size=size)
+        self.do_backup('full', size=size)
+        self.assertTrue(compare_images(source_img, target_img))
+        self.assert_map(target_img, [(0, size, 'zero')], size)
+
+    def test_tail_data(self):
+        self.add_source(layout=LAYOUT_TAIL_DATA, size=TAIL_SIZE)
+        self.do_backup('full', size=TAIL_SIZE)
+        self.assertTrue(compare_images(source_img, target_img))
+        self.assert_map(target_img, LAYOUT_TAIL_DATA, TAIL_SIZE, gap='zero')
+
+    def test_tail_zero(self):
+        # The partial tail cluster falls out of zero_bitmap, so it copies.
+        self.add_source(layout=LAYOUT_TAIL_ZERO, size=TAIL_SIZE)
+        self.do_backup('full', size=TAIL_SIZE)
+        self.assertTrue(compare_images(source_img, target_img))
+
+        tail_cluster = (TAIL_SIZE // CLUSTER) * CLUSTER
+        expected = [
+            (0, MB, 'data'),
+            (2 * MB, tail_cluster - 2 * MB, 'zero'),
+            (tail_cluster, TAIL_SIZE - tail_cluster, 'data'),
+        ]
+        self.assert_map(target_img, expected, TAIL_SIZE, gap='zero')
+
+    def test_tail_zero_bitmap(self):
+        # Same tail rounding as test_tail_zero, via the bitmap scan.
+        self.add_source(layout=LAYOUT_TAIL_ZERO, size=TAIL_SIZE)
+
+        self.vm.cmd('block-dirty-bitmap-add', node='src', name='bm0')
+        self.hmp_write('src', f'write -z 0 {TAIL_SIZE}')
+        for offset, length, kind in LAYOUT_TAIL_ZERO:
+            opt = '-z' if kind == 'zero' else '-P 0x5a'
+            self.hmp_write('src', f'write {opt} {offset} {length}')
+
+        self.do_backup('bitmap', bitmap='bm0', size=TAIL_SIZE,
+                       bitmap_mode='never')
+        self.assertTrue(compare_images(source_img, target_img))
+
+        tail_cluster = (TAIL_SIZE // CLUSTER) * CLUSTER
+        expected = [
+            (0, MB, 'data'),
+            (2 * MB, tail_cluster - 2 * MB, 'zero'),
+            (tail_cluster, TAIL_SIZE - tail_cluster, 'data'),
+        ]
+        self.assert_map(target_img, expected, TAIL_SIZE, gap='zero')
+
+    def test_mixed_cluster(self):
+        # 4K source clusters, so content varies inside one 64K cluster.
+        size = 2 * CLUSTER
+        qemu_img_create('-f', iotests.imgfmt, '-o', 'cluster_size=4k',
+                        source_img, str(size))
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'src',
+            'driver': iotests.imgfmt,
+            'file': {'driver': 'file', 'filename': source_img},
+        })
+
+        # Zero, data and a hole inside the first cluster.
+        self.hmp_write('src', 'write -z 0 8k')
+        self.hmp_write('src', 'write -P 0x5a 8k 8k')
+
+        # The second cluster is uniformly zero.
+        self.hmp_write('src', f'write -z {CLUSTER} {CLUSTER}')
+
+        self.do_backup('full', size=size)
+        self.assertTrue(compare_images(source_img, target_img))
+
+        # A mixed cluster must be data, or the data at [8k, 16k) is lost.
+        self.assert_map(target_img, [(0, CLUSTER, 'data'),
+                                     (CLUSTER, CLUSTER, 'zero')], size)
+
+    def test_top_zero_broken(self):
+        # An overlay hole before an explicit-zero run: the zero prefix
+        # must stop at the hole, or the backing data under it is lost.
+        size = 2 * CLUSTER
+        qemu_img_create('-f', iotests.imgfmt, '-o', 'cluster_size=4k',
+                        base_img, str(size))
+        qemu_io('-c', f'write -P 0x33 0 {size}', base_img)
+
+        qemu_img_create('-f', iotests.imgfmt, '-o', 'cluster_size=4k',
+                        '-b', base_img, '-F', iotests.imgfmt,
+                        source_img, str(size))
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'src',
+            'driver': iotests.imgfmt,
+            'file': {'driver': 'file', 'filename': source_img},
+        })
+        # [0, 4k) stays a hole, the zero run spills into cluster 1.
+        self.hmp_write('src', f'write -z 4096 {CLUSTER}')
+
+        self.do_backup('top', target_backing=base_img, size=size)
+        self.assertTrue(compare_images(source_img, target_img))
+
+    def test_bitmap_straddle(self):
+        # One dirty run straddling a zero/data transition, both ways.
+        self.add_source(layout=[])
+        self.vm.cmd('block-dirty-bitmap-add', node='src', name='bm0')
+
+        # zero -> data straddle: one contiguous dirty run [7M, 9M)
+        self.hmp_write('src', f'write -z {7 * MB} {MB}')
+        self.hmp_write('src', f'write -P 0x5a {8 * MB} {MB}')
+
+        # data -> zero straddle: one contiguous dirty run [15M, 17M)
+        self.hmp_write('src', f'write -P 0x5a {15 * MB} {MB}')
+        self.hmp_write('src', f'write -z {16 * MB} {MB}')
+
+        self.do_backup('bitmap', bitmap='bm0', bitmap_mode='never')
+        self.assertTrue(compare_images(source_img, target_img))
+
+    def test_bitmap_fragmented(self):
+        # Isolated single-cluster dirty spots: nothing outside them
+        # may reach the target.
+        self.add_source(layout=[])
+
+        # Written before the bitmap exists, so untracked.
+        self.hmp_write('src', f'write -P 0x5a 0 {16 * MB}')
+
+        self.vm.cmd('block-dirty-bitmap-add', node='src', name='bm0')
+
+        # The only dirty bit in the data region.
+        data_island = 4 * MB
+        self.hmp_write('src', f'write -P 0x7b {data_island} {CLUSTER}')
+
+        # The only dirty bit in the hole region.
+        zero_island = 24 * MB
+        self.hmp_write('src', f'write -z {zero_island} {CLUSTER}')
+
+        self.do_backup('bitmap', bitmap='bm0', bitmap_mode='never',
+                      prefill=0xcc)
+
+        # Only the two isolated spots should have reached target ...
+        qemu_io('-c', f'read -P 0x7b {data_island} {CLUSTER}', target_img)
+        qemu_io('-c', f'read -P 0 {zero_island} {CLUSTER}', target_img)
+
+        # ... everything else must still hold the prefill pattern.
+        qemu_io('-c', f'read -P 0xcc 0 {CLUSTER}', target_img)
+        qemu_io('-c', f'read -P 0xcc {8 * MB} {CLUSTER}', target_img)
+
+    def test_bitmap_clean_zero_gap(self):
+        # A clean zero run between two dirty ones must stay prefilled.
+        self.add_source(layout=[], size=16 * MB)
+        self.hmp_write('src', f'write -z 0 {16 * MB}')
+
+        self.vm.cmd('block-dirty-bitmap-add', node='src', name='bm0')
+        self.hmp_write('src', f'write -z {2 * MB} {MB}')
+        self.hmp_write('src', f'write -z {6 * MB} {MB}')
+
+        self.do_backup('bitmap', bitmap='bm0', bitmap_mode='never',
+                      size=16 * MB, prefill=0xcc)
+
+        qemu_io('-c', f'read -P 0 {2 * MB} {MB}', target_img)
+        qemu_io('-c', f'read -P 0 {6 * MB} {MB}', target_img)
+
+        qemu_io('-c', f'read -P 0xcc 0 {2 * MB}', target_img)
+        qemu_io('-c', f'read -P 0xcc {3 * MB} {3 * MB}', target_img)
+        qemu_io('-c', f'read -P 0xcc {7 * MB} {9 * MB}', target_img)
+
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'],
                  supported_protocols=['file'])
diff --git a/tests/qemu-iotests/124.out b/tests/qemu-iotests/124.out
index fa16b5ccef..5ce2f9a2ed 100644
--- a/tests/qemu-iotests/124.out
+++ b/tests/qemu-iotests/124.out
@@ -1,5 +1,5 @@
-.............
+..............................
 ----------------------------------------------------------------------
-Ran 13 tests
+Ran 30 tests
 
 OK
-- 
2.53.0


