Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E971F8FA99
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 15:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFDSo-0002ft-HC; Tue, 21 Apr 2026 11:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wFDSl-0002ei-GP; Tue, 21 Apr 2026 11:56:35 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wFDSj-0003JA-Fl; Tue, 21 Apr 2026 11:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=5oZ5ryl95dTV+hIbE37CXIJ9NkwjnJnZE/utqtG/ovM=; b=x0O+XMH38Aiy
 Y0ODmDeTiif5+9CCJfkkbSqDHaHQVPszRK4ydyzJEgplNtg2U0w4jWklEcWCJv8L5lP9iW/slclhz
 X0T0rlRRSFxXo35cI9Elwaz2pUZbKPFNZxIQVMtJuiBC4QpzBuw2Oka3u1+Q98zveCqa+ixLpIw0a
 Voewzd+eBwL0UHOxAHbVl7ahBjMgYMsK6sgCqRdKF2RpRoH/xW69bIg7xTzDw5UORI74CGrmsnLEK
 GHhiAioX9CFEhEdsyGZEN+LRt8bDmd0ZOyCdKjnppYwQ8Xbmg5FwG+vlXJ7uTvnMrDq5+jvzqNBFF
 Sf+WuSvdHXweXDi6/Zs7eQ==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1wFDQ2-001k3k-35;
 Tue, 21 Apr 2026 17:56:20 +0200
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org,
	qemu-stable@nongnu.org
Cc: den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 2/2] iotests: regression test for discard/write-zeroes vs
 in-flight write race
Date: Tue, 21 Apr 2026 17:56:28 +0200
Message-ID: <20260421155628.3600671-3-den@openvz.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260421155628.3600671-1-den@openvz.org>
References: <20260421155628.3600671-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add tests/qemu-iotests/tests/discard-write-serialisation, a deterministic
regression test for the race fixed in the previous commit.

Drive a single qemu-io process with a fixed-seed interleaved sequence of
async aio_write and aio_write -z -u commands at random cluster-aligned
offsets in a small contention region, then run qemu-img check and assert
zero corruptions.  On an unpatched tree the same workload reproduces the
refcount-aliasing fingerprint deterministically; on the fixed tree the
image comes back clean.

The test is scoped to qcow2 because qcow2 is the format whose qemu-img
check validates refcount/reference consistency and therefore actually
detects the fingerprint.  The underlying race is in the generic block
layer and not format-specific, but a test that asserts "qemu-img check
returns zero corruptions" only has signal on formats that run such a
check.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
---
 .../tests/discard-write-serialisation         | 97 +++++++++++++++++++
 .../tests/discard-write-serialisation.out     |  1 +
 2 files changed, 98 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/discard-write-serialisation
 create mode 100644 tests/qemu-iotests/tests/discard-write-serialisation.out

diff --git a/tests/qemu-iotests/tests/discard-write-serialisation b/tests/qemu-iotests/tests/discard-write-serialisation
new file mode 100755
index 0000000000..45a3f7f043
--- /dev/null
+++ b/tests/qemu-iotests/tests/discard-write-serialisation
@@ -0,0 +1,97 @@
+#!/usr/bin/env python3
+# group: rw quick auto
+#
+# Regression test for the block-layer race fixed in
+# block/io: serialise discard and write-zeroes against in-flight writes.
+#
+# A format driver's write path may drop its internal mutex around the
+# data I/O of an allocating write (qcow2 does so between
+# qcow2_alloc_host_offset and qcow2_alloc_cluster_link_l2).  A
+# concurrent discard or MAY_UNMAP write-zeroes on the same guest range,
+# running in that window, can clear the L2 entry and drop the cluster's
+# refcount to zero; the writer's subsequent link then binds the L2
+# entry to a freed cluster.  qemu-img check reports this as refcount=0
+# with a live OFLAG_COPIED reference, or refcount < reference when the
+# allocator re-hands the cluster out.
+#
+# The bug is in the generic block layer, not format-specific; qcow2 is
+# the detection vehicle because its refcount validation in qemu-img
+# check catches the fingerprint.  The test drives a single qemu-io
+# process with interleaved async aio_write and aio_write -z -u commands
+# at random cluster-aligned offsets in a small contention region, then
+# runs qemu-img check and asserts zero corruptions.  On an unpatched
+# tree the same workload reproduces the fingerprint deterministically
+# (seed is fixed).
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import random
+import subprocess
+
+import iotests
+from iotests import qemu_img_create, qemu_img_check, qemu_io_wrap_args
+
+
+iotests.script_initialize(supported_fmts=['qcow2'],
+                          supported_platforms=['linux'])
+
+IMG_SIZE = 256 * 1024 * 1024          # 256 MiB
+REGION = 64 * 1024 * 1024             # contention region: 64 MiB
+CLUSTER = 1024 * 1024                 # 1 MiB
+SUBCLUSTER = 32 * 1024                # 32 KiB
+OPS = 5000
+SEED = 7
+
+def build_commands() -> bytes:
+    rng = random.Random(SEED)
+    max_cluster = REGION // CLUSTER - 1
+    lines = []
+    for _ in range(OPS):
+        cl = rng.randint(0, max_cluster)
+        off = cl * CLUSTER
+        if rng.random() < 0.5:
+            # Small sub-cluster write at an unaligned position inside
+            # the cluster -- exercises the handle_copied path and the
+            # s->lock drop around the data I/O.
+            sub = rng.randrange(0, CLUSTER, SUBCLUSTER)
+            lines.append(f'aio_write -q {off + sub} 32k')
+        else:
+            # MAY_UNMAP write-zeroes aligned to the cluster -- frees
+            # clusters at the format driver level and is the concurrent
+            # cluster-free source that races with the in-flight writes.
+            lines.append(f'aio_write -q -z -u {off} 1M')
+    lines.append('aio_flush')
+    return ('\n'.join(lines) + '\n').encode()
+
+
+def main() -> None:
+    with iotests.FilePath('disk.img') as img:
+        qemu_img_create('-f', 'qcow2',
+                        '-o', 'cluster_size=1M,extended_l2=on,'
+                              'lazy_refcounts=on,refcount_bits=16',
+                        img, str(IMG_SIZE))
+
+        # Run qemu-io with async AIO.  --cache=none and --aio=native ensure
+        # the writer coroutine actually yields around its data I/O (which
+        # is what opens the race window).  Swallow stdout/stderr: the
+        # result we care about is the on-disk state, checked below.
+        args = qemu_io_wrap_args(['-f', 'qcow2', '-n',
+                                  '--cache=none', '--aio=native', img])
+        subprocess.run(args, input=build_commands(),
+                       stdout=subprocess.DEVNULL,
+                       stderr=subprocess.DEVNULL,
+                       check=True)
+
+        result = qemu_img_check(img)
+        corruptions = result.get('corruptions', 0)
+        check_errors = result.get('check-errors', 0)
+        if corruptions or check_errors:
+            iotests.log(f'FAIL: qemu-img check reports '
+                        f'corruptions={corruptions} '
+                        f'check-errors={check_errors}')
+        else:
+            iotests.log('OK')
+
+
+if __name__ == '__main__':
+    main()
diff --git a/tests/qemu-iotests/tests/discard-write-serialisation.out b/tests/qemu-iotests/tests/discard-write-serialisation.out
new file mode 100644
index 0000000000..d86bac9de5
--- /dev/null
+++ b/tests/qemu-iotests/tests/discard-write-serialisation.out
@@ -0,0 +1 @@
+OK
-- 
2.51.0


