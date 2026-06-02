Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897CDCD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 19:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXOqH-0001AX-B7; Wed, 10 Jun 2026 15:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1wXOqE-00019N-VZ; Wed, 10 Jun 2026 15:43:58 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1wXOqC-00038T-GA; Wed, 10 Jun 2026 15:43:58 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5CBF180AC0;
 Wed, 10 Jun 2026 21:43:46 +0200 (CEST)
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:qcow2)
Subject: [PATCH v3] qcow2: Fix data loss on zero write with detect-zeroes=unmap
Date: Tue,  2 Jun 2026 15:05:05 +0200
Message-ID: <20260610194329.3962857-2-t.lamprecht@proxmox.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1781120577763
Received-SPF: pass client-ip=94.136.29.106;
 envelope-from=t.lamprecht@proxmox.com; helo=proxmox-new.maurer-it.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
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

Commit b8bfb1478d ("qcow2: Fix corruption on discard during write with
COW") added a wait_for_dependencies() at the start of
qcow2_subcluster_zeroize(). That fixes the inconsistency it set out to
fix, but turns the lock-protected pre-check in the caller,
qcow2_co_pwrite_zeroes(), into a stale one: the wait yields s->lock,
so an in-flight allocating write whose QCowL2Meta is already on
s->cluster_allocs (but whose L2 entry is not yet linked) gets to link
its entry during the yield. When the zeroize wakes, the cluster is now
NORMAL, and with BDRV_REQ_MAY_UNMAP the free path in zero_in_l2_slice()
unmaps the just-written cluster, silently dropping the data write's
payload.

This is reachable with detect-zeroes=unmap (the default for VirtIO
disks with discard on in Proxmox VE), under which the block layer
auto-promotes all-zero buffers to BDRV_REQ_ZERO_WRITE |
BDRV_REQ_MAY_UNMAP. A memory-constrained Debian guest running 'apt
full-upgrade' on such a disk reproduces it as random SIGSEGVs:
swapped-out code pages come back as zero.

Wait for in-flight dependencies before the lock-protected check in
qcow2_co_pwrite_zeroes(). If a write linked its L2 entry during the
wait, the type check now fails and the block layer falls back to a
bounce-buffered zero write that only touches the requested subrange,
preserving the racing write's data. Promote wait_for_dependencies() to
qcow2_wait_for_dependencies() so qcow2.c can call it.

Fixes: b8bfb1478d ("qcow2: Fix corruption on discard during write with COW")
Cc: qemu-stable@nongnu.org
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
---

Changes v2 [0] -> v3:
* avoid churn by moving the 'nr = s->subcluster_size;' assignment to 
  'nr = bytes;' needlessly (sorry for missing that dev churn when
  submitting v2 and thanks @Kevin Wolf for noticing)

[0]: https://lore.kernel.org/qemu-devel/20260522151318.238064-1-t.lamprecht@proxmox.com/

 block/qcow2-cluster.c      | 10 +++++-----
 block/qcow2.c              |  8 +++++++-
 block/qcow2.h              |  4 ++++
 tests/qemu-iotests/046     | 23 +++++++++++++++++++++++
 tests/qemu-iotests/046.out | 10 ++++++++++
 5 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 8b1e80bd0b..e02fae6a0c 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1474,9 +1474,9 @@ static int coroutine_fn handle_dependencies(BlockDriverState *bs,
     return 0;
 }
 
-static void coroutine_mixed_fn wait_for_dependencies(BlockDriverState *bs,
-                                                     uint64_t guest_offset,
-                                                     uint64_t bytes)
+void coroutine_mixed_fn qcow2_wait_for_dependencies(BlockDriverState *bs,
+                                                    uint64_t guest_offset,
+                                                    uint64_t bytes)
 {
     BDRVQcow2State *s = bs->opaque;
     QCowL2Meta *m = NULL;
@@ -2035,7 +2035,7 @@ int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
      * We don't need to allocate a QCowL2Meta for the discard operation because
      * s->lock is held for the duration of the whole operation.
      */
-    wait_for_dependencies(bs, offset, bytes);
+    qcow2_wait_for_dependencies(bs, offset, bytes);
 
     /* Caller must pass aligned values, except at image end */
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
@@ -2204,7 +2204,7 @@ int coroutine_fn qcow2_subcluster_zeroize(BlockDriverState *bs, uint64_t offset,
      * We don't need to allocate a QCowL2Meta for the zeroize operation because
      * s->lock is held for the duration of the whole operation.
      */
-    wait_for_dependencies(bs, offset, bytes);
+    qcow2_wait_for_dependencies(bs, offset, bytes);
 
     /* If we have to stay in sync with an external data file, zero out
      * s->data_file first. */
diff --git a/block/qcow2.c b/block/qcow2.c
index 81fd299b4c..18f1232775 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4234,9 +4234,15 @@ qcow2_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
         }
 
         qemu_co_mutex_lock(&s->lock);
-        /* We can have new write after previous check */
         offset -= head;
         bytes = s->subcluster_size;
+        /*
+         * Wait for in-flight allocating writes first: otherwise the type
+         * check below could pass on UNALLOCATED while a yet-to-link_l2 write
+         * completes during qcow2_subcluster_zeroize()'s own wait, letting the
+         * resumed MAY_UNMAP discard the just-written data.
+         */
+        qcow2_wait_for_dependencies(bs, offset, bytes);
         nr = s->subcluster_size;
         ret = qcow2_get_host_offset(bs, offset, &nr, &off, &type);
         if (ret < 0 ||
diff --git a/block/qcow2.h b/block/qcow2.h
index 192a45d596..ce517040c4 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -966,6 +966,10 @@ int coroutine_fn GRAPH_RDLOCK
 qcow2_subcluster_zeroize(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
                          int flags);
 
+void coroutine_mixed_fn
+qcow2_wait_for_dependencies(BlockDriverState *bs, uint64_t guest_offset,
+                            uint64_t bytes);
+
 int GRAPH_RDLOCK
 qcow2_expand_zero_clusters(BlockDriverState *bs,
                            BlockDriverAmendStatusCB *status_cb,
diff --git a/tests/qemu-iotests/046 b/tests/qemu-iotests/046
index e03dd40147..0d84b5c1c7 100755
--- a/tests/qemu-iotests/046
+++ b/tests/qemu-iotests/046
@@ -226,6 +226,26 @@ aio_write -z 0x140000 0x10000
 resume A
 aio_flush
 EOF
+
+# Start an allocating write to a previously unallocated cluster and, before
+# its L2 update is linked, issue a concurrent sub-cluster zero write with
+# MAY_UNMAP that targets a disjoint range within the same cluster. The zero
+# write's head/tail are zero (cluster is unallocated), so qcow2_co_pwrite_zeroes
+# would expand it to the full subcluster. Without waiting for dependencies
+# before the zero write's "unallocated" type check, that check passes,
+# qcow2_subcluster_zeroize then yields in wait_for_dependencies, the allocating
+# write links its L2 entry, and the resumed zeroize unmaps the cluster -
+# silently discarding the just-written data. Waiting first makes the zero write
+# fall back to a bounce-buffered real write, which only touches its own
+# subrange.
+cat <<EOF
+break write_aio A
+aio_write -P 180 0x200000 0x4000
+wait_break A
+aio_write -z -u 0x204000 0x4000
+resume A
+aio_flush
+EOF
 }
 
 overlay_io | $QEMU_IO blkdebug::"$TEST_IMG" | _filter_qemu_io |\
@@ -310,6 +330,9 @@ verify_io()
     echo read -P 0   0x120000 0x10000
     echo read -P 0   0x130000 0x10000
     echo read -P 0   0x140000 0x10000
+
+    echo read -P 180 0x200000 0x4000
+    echo read -P 0   0x204000 0xc000
 }
 
 verify_io | $QEMU_IO "$TEST_IMG" | _filter_qemu_io
diff --git a/tests/qemu-iotests/046.out b/tests/qemu-iotests/046.out
index 6341df335c..137cf527f1 100644
--- a/tests/qemu-iotests/046.out
+++ b/tests/qemu-iotests/046.out
@@ -169,6 +169,12 @@ wrote XXX/XXX bytes at offset XXX
 XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote XXX/XXX bytes at offset XXX
 XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+blkdebug: Suspended request 'A'
+blkdebug: Resuming request 'A'
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote XXX/XXX bytes at offset XXX
+XXX KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == Verify image content ==
 read 65536/65536 bytes at offset 0
@@ -275,5 +281,9 @@ read 65536/65536 bytes at offset 1245184
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 65536/65536 bytes at offset 1310720
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 16384/16384 bytes at offset 2097152
+16 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 49152/49152 bytes at offset 2113536
+48 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 No errors were found on the image.
 *** done
-- 
2.47.3



