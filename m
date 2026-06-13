Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D70CD98D2
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 19:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUSn-0001nB-Fa; Sat, 13 Jun 2026 15:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUSl-0001mm-VS; Sat, 13 Jun 2026 15:56:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUSj-0004oQ-J9; Sat, 13 Jun 2026 15:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781380261; bh=1tPYqxfalQvrH6IzMDSuSMzVqSC8HCP4VLvVLuJifHw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gOTzF19DBo45pzwcC17L5shKocUZfx0wmeLdTMKKXezBJgRj4LYFtDfr8TwsiW8DJ
 lfBCM3cbG5JScIR/8u1H/ZnuctDLI23Wdie58Eoh0TUhBvwEblHe1qqFC2yIm9ERMc
 taKAFPNU8e/vnKnLzhz/Uu1GzF+mhOE2eWtpQKtQTbKGfzRhR6f3ntBLvk2RpuSBK0
 VwFk4r83QGjJzzCLEqDrg6q1bD7blpnUnSyYY45/VPlbdeaYq9b0k0Dh5jDLFa1mOj
 CSXbNJxA6YTos/KH6PktNitVXvwe5QrlrrYA8G2EW5p9hoSYDXP+xpUVdbZynw7+f4
 QxYvnMpIUF0sw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 638441B6E42;
 Sat, 13 Jun 2026 22:51:01 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BB43E3CE8BC;
 Sat, 13 Jun 2026 22:51:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Lamprecht <t.lamprecht@proxmox.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 51/56] qcow2: Fix data loss on zero write with
 detect-zeroes=unmap
Date: Sat, 13 Jun 2026 22:51:05 +0300
Message-ID: <20260613195116.1807273-51-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Thomas Lamprecht <t.lamprecht@proxmox.com>

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
Fixes: 9c3d7bf39f ("qcow2: Fix corruption on discard during write with COW") in 10.0.x series
Cc: qemu-stable@nongnu.org
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
Message-ID: <20260522151318.238064-1-t.lamprecht@proxmox.com>
[kwolf: Reverted unnecessary change to 'nr' assignment]
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 1d47eb68983577a4e06fe1c165d90e128b191b86)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index c20011d34c..23eeb9fc56 100644
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
@@ -2037,7 +2037,7 @@ int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
      * We don't need to allocate a QCowL2Meta for the discard operation because
      * s->lock is held for the duration of the whole operation.
      */
-    wait_for_dependencies(bs, offset, bytes);
+    qcow2_wait_for_dependencies(bs, offset, bytes);
 
     /* Caller must pass aligned values, except at image end */
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
@@ -2208,7 +2208,7 @@ int coroutine_fn qcow2_subcluster_zeroize(BlockDriverState *bs, uint64_t offset,
      * We don't need to allocate a QCowL2Meta for the zeroize operation because
      * s->lock is held for the duration of the whole operation.
      */
-    wait_for_dependencies(bs, offset, bytes);
+    qcow2_wait_for_dependencies(bs, offset, bytes);
 
     /* If we have to stay in sync with an external data file, zero out
      * s->data_file first. */
diff --git a/block/qcow2.c b/block/qcow2.c
index 7774e7f090..6f1612a5d8 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4088,10 +4088,16 @@ qcow2_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
         }
 
         qemu_co_mutex_lock(&s->lock);
-        /* We can have new write after previous check */
         offset -= head;
         bytes = s->subcluster_size;
         nr = s->subcluster_size;
+        /*
+         * Wait for in-flight allocating writes first: otherwise the type
+         * check below could pass on UNALLOCATED while a yet-to-link_l2 write
+         * completes during qcow2_subcluster_zeroize()'s own wait, letting the
+         * resumed MAY_UNMAP discard the just-written data.
+         */
+        qcow2_wait_for_dependencies(bs, offset, bytes);
         ret = qcow2_get_host_offset(bs, offset, &nr, &off, &type);
         if (ret < 0 ||
             (type != QCOW2_SUBCLUSTER_UNALLOCATED_PLAIN &&
diff --git a/block/qcow2.h b/block/qcow2.h
index a9e3481c6e..e1cd91df19 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -958,6 +958,10 @@ int coroutine_fn GRAPH_RDLOCK
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


