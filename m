Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F34606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 03:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IxlcmB8z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO5cW-0006SY-K5; Mon, 02 Nov 2026 22:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cT-0006R9-MK
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xO5cQ-0000bc-TW
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 22:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793678129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2d2M2em0NBvHvpwykvSpbjKbZkMyzBnODVtR+5DKOcA=;
 b=IxlcmB8zQphJzhfhIULRI1cehj/LOJUREYoHOUWR63ECqVOvCUAi+58HICcu+dUgb4QJCd
 hED9rV8i9wULMGDXAKivot5vH/7LcHiJUFAXCE91i2kzZMTp9KMx1E6PICazM2grkeBapQ
 WrhPXzKlMjpjvKxNd6EOsvD+E1xtqrQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-il635yhoPCuXPhwa4pX4wQ-1; Mon,
 02 Nov 2026 22:55:28 -0500
X-MC-Unique: il635yhoPCuXPhwa4pX4wQ-1
X-Mimecast-MFC-AGG-ID: il635yhoPCuXPhwa4pX4wQ_1793678127
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 373B51955F73; Tue,  3 Nov 2026 03:55:27 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A49237E7; Tue,  3 Nov 2026 03:55:25 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PULL 08/16] iotests/124: cover backup of zero clusters and holes
Date: Mon,  2 Nov 2026 21:54:19 -0600
Message-ID: <20261103035506.2688772-26-eblake@redhat.com>
In-Reply-To: <20261103035506.2688772-18-eblake@redhat.com>
References: <20261103035506.2688772-18-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The backup tests compare content only, and their sources hold data
alone, so nothing pins how backup treats zero clusters and holes. Back
up a source mixing data, write-zero and holes with sync=full, sync=top
and sync=bitmap, and check the target with qemu-img map, which tells a
copied cluster apart from a write-zero and from an untouched one.

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20261030010613.1612771-5-den@openvz.org>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/124     | 347 ++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/124.out |   4 +-
 2 files changed, 348 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index ab9ea4d8b59..7afcf61324d 100755
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


@@ -748,6 +751,348 @@ class TestIncrementalBackupBlkdebug(TestIncrementalBackupBase):
         self.check_backups()


+# Backup of sources mixing data, zero clusters and holes.
+
+Extent = namedtuple('Extent', ['start', 'length', 'kind'])
+Case = namedtuple('Case', ['size', 'layout', 'expected'], defaults=[None])
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
+MIXED = Case(SIZE, [
+    (0, MB, 'data'),
+    (2 * MB, MB, 'zero'),
+    (5 * MB, 2 * MB, 'data'),
+    (8 * MB, MB, 'zero'),
+    (10 * MB, MB // 2, 'data'),
+    (20 * MB, 4 * MB, 'zero'),
+    (30 * MB, MB, 'data'),
+])
+
+# Single-cluster runs, and a zero run ending exactly at EOF.
+BOUNDARY_SIZE = 16 * MB
+BOUNDARY = Case(BOUNDARY_SIZE, [
+    (0, CLUSTER, 'zero'),
+    (CLUSTER, CLUSTER, 'data'),
+    (2 * CLUSTER, CLUSTER, 'zero'),
+    (3 * CLUSTER, CLUSTER, 'data'),
+    (4 * CLUSTER, 8 * MB, 'zero'),
+    (4 * CLUSTER + 8 * MB, CLUSTER, 'data'),
+    (BOUNDARY_SIZE - CLUSTER, CLUSTER, 'zero'),
+])
+
+# A zero run past the old block_copy_chunk_size() 16M cap.
+LARGE_ZERO = Case(48 * MB, [
+    (0, MB, 'data'),
+    (4 * MB, 32 * MB, 'zero'),
+    (40 * MB, MB, 'data'),
+])
+
+# Image size not a multiple of the cluster size: a partial tail cluster.
+TAIL_SIZE = 4 * MB + 4096
+TAIL_CLUSTER = (TAIL_SIZE // CLUSTER) * CLUSTER
+TAIL_DATA = Case(TAIL_SIZE, [
+    (0, MB, 'data'),
+    (2 * MB, MB, 'zero'),
+    (4 * MB, TAIL_SIZE - 4 * MB, 'data'),
+])
+# The partial tail cluster falls out of zero_bitmap, so it copies as data.
+TAIL_ZERO = Case(TAIL_SIZE, [
+    (0, MB, 'data'),
+    (2 * MB, TAIL_SIZE - 2 * MB, 'zero'),
+], [
+    (0, MB, 'data'),
+    (2 * MB, TAIL_CLUSTER - 2 * MB, 'zero'),
+    (TAIL_CLUSTER, TAIL_SIZE - TAIL_CLUSTER, 'data'),
+])
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
+def create_image(path, size, backing=None, opts=None):
+    args = ['-f', iotests.imgfmt]
+    if opts:
+        args += ['-o', opts]
+    if backing:
+        args += ['-b', backing, '-F', iotests.imgfmt]
+    qemu_img_create(*args, path, str(size))
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
+        self.assertNotIn('error', res['return'].lower())
+
+    def write_layout(self, layout):
+        for offset, length, kind in layout:
+            opt = '-z' if kind == 'zero' else '-P 0x5a'
+            self.hmp_write('src', f'write {opt} {offset} {length}')
+
+    def assert_map(self, case, backing=False, gap='hole'):
+        # Content is not enough, pin the data/zero/hole split as well.
+        def classify(e):
+            is_hole = e['depth'] > 0 if backing else not e['present']
+            return 'hole' if is_hole else ('zero' if e['zero'] else 'data')
+
+        actual = coalesce([Extent(e['start'], e['length'], classify(e))
+                           for e in qemu_img_map(target_img)])
+        layout = case.expected if case.expected else case.layout
+
+        self.assertEqual(actual, layout_to_extents(layout, case.size, gap))
+
+    def add_source(self, case=MIXED, backing=None, opts=None):
+        create_image(source_img, case.size, backing, opts)
+
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'src',
+            'driver': iotests.imgfmt,
+            'file': {'driver': 'file', 'filename': source_img},
+        })
+
+        # Write through the node, so an attached bitmap sees it.
+        self.write_layout(case.layout)
+
+    def dirty_layout(self, case):
+        # A new bitmap tracks nothing yet: dirty all, then re-apply.
+        self.vm.cmd('block-dirty-bitmap-add', node='src', name='bm0')
+        self.hmp_write('src', f'write -z 0 {case.size}')
+        self.write_layout(case.layout)
+
+    def do_backup(self, sync, case, target_backing=None, prefill=None,
+                  **kwargs):
+        create_image(target_img, case.size, target_backing)
+
+        if prefill is not None:
+            # Not zero, so a skipped cluster is provably untouched.
+            qemu_io('-c', f'write -P {prefill} 0 {case.size}', target_img)
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
+    def backup_and_check(self, sync, case, gap='zero', backing=False,
+                         **kwargs):
+        self.do_backup(sync, case, **kwargs)
+        self.assertTrue(compare_images(source_img, target_img))
+        self.assert_map(case, backing=backing, gap=gap)
+
+    def test_full(self):
+        self.add_source()
+        self.backup_and_check('full', MIXED)
+
+    def test_full_zero_overwrite(self):
+        # full skips holes, so only check that zero overwrites prefill.
+        case = Case(SIZE, [(2 * MB, MB, 'zero')])
+        self.add_source(case)
+        self.do_backup('full', case, prefill=0xcc)
+        qemu_io('-c', f'read -P 0 {2 * MB} {MB}', target_img)
+
+    def test_bitmap(self):
+        self.add_source()
+        self.dirty_layout(MIXED)
+        self.backup_and_check('bitmap', MIXED, bitmap='bm0',
+                              bitmap_mode='never')
+
+    def test_top(self):
+        # Non-zero backing data, so a hole and an explicit zero differ.
+        create_image(base_img, SIZE)
+        qemu_io('-c', f'write -P 0x33 0 {SIZE}', base_img)
+
+        self.add_source(backing=base_img)
+        self.backup_and_check('top', MIXED, gap='hole', backing=True,
+                              target_backing=base_img)
+
+    def test_boundary_full(self):
+        self.add_source(BOUNDARY)
+        self.backup_and_check('full', BOUNDARY)
+
+    def test_boundary_bitmap(self):
+        self.add_source(BOUNDARY)
+        self.dirty_layout(BOUNDARY)
+        self.backup_and_check('bitmap', BOUNDARY, bitmap='bm0',
+                              bitmap_mode='never')
+
+    def test_large_zero_full(self):
+        self.add_source(LARGE_ZERO)
+        self.backup_and_check('full', LARGE_ZERO)
+
+    def test_large_zero_bitmap(self):
+        self.add_source(LARGE_ZERO)
+        self.dirty_layout(LARGE_ZERO)
+        self.backup_and_check('bitmap', LARGE_ZERO, bitmap='bm0',
+                              bitmap_mode='never')
+
+    def test_huge_zero(self):
+        # A zero run past the cap on a single write-zeroes request, so it
+        # has to be split. qemu-io caps one write at 2G, hence three.
+        case = Case(2560 * MB, [(0, 1024 * MB, 'zero'),
+                                (1024 * MB, 1024 * MB, 'zero'),
+                                (2048 * MB, 512 * MB, 'zero')])
+        self.add_source(case)
+        self.backup_and_check('full', case)
+
+    def test_tail_data(self):
+        self.add_source(TAIL_DATA)
+        self.backup_and_check('full', TAIL_DATA)
+
+    def test_tail_zero(self):
+        self.add_source(TAIL_ZERO)
+        self.backup_and_check('full', TAIL_ZERO)
+
+    def test_tail_zero_bitmap(self):
+        # Same tail rounding as test_tail_zero, via the bitmap scan.
+        self.add_source(TAIL_ZERO)
+        self.dirty_layout(TAIL_ZERO)
+        self.backup_and_check('bitmap', TAIL_ZERO, bitmap='bm0',
+                              bitmap_mode='never')
+
+    def test_mixed_cluster(self):
+        # 4K source clusters, so content varies inside one 64K cluster.
+        case = Case(2 * CLUSTER, [
+            (0, 8 * 1024, 'zero'),
+            (8 * 1024, 8 * 1024, 'data'),
+            (CLUSTER, CLUSTER, 'zero'),
+        ], [
+            # A mixed cluster must be data, or the data at [8k, 16k) is lost.
+            (0, CLUSTER, 'data'),
+            (CLUSTER, CLUSTER, 'zero'),
+        ])
+        self.add_source(case, opts='cluster_size=4k')
+        self.backup_and_check('full', case)
+
+    def test_top_zero_broken(self):
+        # An overlay hole before an explicit-zero run: the zero prefix
+        # must stop at the hole, or the backing data under it is lost.
+        size = 2 * CLUSTER
+        create_image(base_img, size, opts='cluster_size=4k')
+        qemu_io('-c', f'write -P 0x33 0 {size}', base_img)
+
+        # [0, 4k) stays a hole, the zero run spills into cluster 1.
+        case = Case(size, [(4096, CLUSTER, 'zero')])
+        self.add_source(case, backing=base_img, opts='cluster_size=4k')
+
+        self.do_backup('top', case, target_backing=base_img)
+        self.assertTrue(compare_images(source_img, target_img))
+
+    def test_bitmap_straddle(self):
+        # One dirty run straddling a zero/data transition, both ways.
+        case = Case(SIZE, [])
+        self.add_source(case)
+        self.vm.cmd('block-dirty-bitmap-add', node='src', name='bm0')
+
+        # One contiguous dirty run each: [7M, 9M) zero to data, and
+        # [15M, 17M) data to zero.
+        layout = [
+            (7 * MB, MB, 'zero'),
+            (8 * MB, MB, 'data'),
+            (15 * MB, MB, 'data'),
+            (16 * MB, MB, 'zero'),
+        ]
+        self.write_layout(layout)
+
+        self.do_backup('bitmap', case, bitmap='bm0', bitmap_mode='never')
+        self.assertTrue(compare_images(source_img, target_img))
+        # Nothing outside the two dirty runs may reach the target.
+        self.assert_map(case._replace(layout=layout))
+
+    def test_bitmap_fragmented(self):
+        # Isolated single-cluster dirty spots: nothing outside them
+        # may reach the target.
+        case = Case(SIZE, [])
+        self.add_source(case)
+
+        # Written before the bitmap exists, so untracked.
+        self.hmp_write('src', f'write -P 0x5a 0 {16 * MB}')
+
+        self.vm.cmd('block-dirty-bitmap-add', node='src', name='bm0')
+
+        # The only dirty bit in the data region, with a pattern of its own.
+        data_island = 4 * MB
+        self.hmp_write('src', f'write -P 0x7b {data_island} {CLUSTER}')
+
+        # The only dirty bit in the hole region.
+        zero_island = 24 * MB
+        self.hmp_write('src', f'write -z {zero_island} {CLUSTER}')
+
+        self.do_backup('bitmap', case, bitmap='bm0', bitmap_mode='never',
+                       prefill=0xcc)
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
+        case = Case(16 * MB, [])
+        self.add_source(case)
+        self.hmp_write('src', f'write -z 0 {16 * MB}')
+
+        self.vm.cmd('block-dirty-bitmap-add', node='src', name='bm0')
+        self.write_layout([(2 * MB, MB, 'zero'), (6 * MB, MB, 'zero')])
+
+        self.do_backup('bitmap', case, bitmap='bm0', bitmap_mode='never',
+                       prefill=0xcc)
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
                  supported_protocols=['file'],
diff --git a/tests/qemu-iotests/124.out b/tests/qemu-iotests/124.out
index fa16b5cceff..5ce2f9a2ed9 100644
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
2.56.0


