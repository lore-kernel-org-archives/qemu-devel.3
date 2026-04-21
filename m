Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51A7F8FA90
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 15:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFDSp-0002fw-EU; Tue, 21 Apr 2026 11:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wFDSl-0002em-Kj; Tue, 21 Apr 2026 11:56:35 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wFDSj-0003J9-FG; Tue, 21 Apr 2026 11:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=FgmINqfieKlh+6fCJ81osPdRRu4ImsoTkTh6aOy7+6c=; b=oEKj58XMIc5M
 4hJ7ACojDmm55g12Tl07OZSqkKFe+0XVMntr8pHW1ccoxCJF57G69YdE0jfF4sH77xXmqsKNWe2eJ
 z6YGFUnp/ZfnrbHv6bo/zCre2vv8jYHHHFiRAAgZX3ZpPAQpXIS5yt39bXfEW+BvaV/b6Oknv6OEM
 pkHtZUIxMt1fT+BmtL7joEHdw+Ro6JO3v//tJEvcryM+rkzzDbIyPe6y2R2un1hKpYdpopTkRKQgQ
 BHDaijx0pXtdrh2DRaGIhy87ZMy00U6Pj6Kg0otJPmd/bmaTVgX+KvZ/En7V7kBXf2mJ8Mop40H6U
 jSrE1ndGaJWufZvbltRP3Q==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1wFDQ2-001k3k-0t;
 Tue, 21 Apr 2026 17:56:19 +0200
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org,
	qemu-stable@nongnu.org
Cc: den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 0/2] block/io: fix reproducible silent data corruption in
 write-vs-discard race
Date: Tue, 21 Apr 2026 17:56:26 +0200
Message-ID: <20260421155628.3600671-1-den@openvz.org>
X-Mailer: git-send-email 2.51.0
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

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>

This series fixes a qemu block-layer race between an in-flight
format-driver write and a concurrent discard or MAY_UNMAP
write-zeroes on the same guest range. The race has been latent
in upstream since v1.0 (commit 68d100e905 "qcow2: Use coroutines",
2011-06-30) and has been producing silent qcow2 metadata
corruption in production.

Mechanism
---------

qcow2's write path drops s->lock around the data I/O of an
allocating write.  If a discard / pwrite_zeroes(MAY_UNMAP) on the
same guest offset lands in that window, it clears the L2 entry
and decrements the cluster's refcount to zero; the writer then
reacquires the lock and unconditionally writes L2[G] =
alloc_offset | OFLAG_COPIED onto the now-freed cluster.  The next
allocation re-hands the cluster out and we end up with two L2
entries aliasing one host cluster.  Patch 1/2 carries the
per-frame diagram of the interleaving.

On-disk signature: qemu-img check reports refcount=0 with a live
OFLAG_COPIED reference, or refcount < reference.  Runtime
signature: "qcow2_free_clusters failed: Invalid argument" on
stderr with no guest-visible error.

Production consequences
-----------------------

  * Silent data drift.  Once two guest offsets share one host
    cluster, writes through either alias overwrite bytes the
    other alias owns.  The guest reads back bytes it never
    wrote, with no I/O error hit anywhere in the stack.

  * Guest-filesystem corruption.  ext4 discovers the resulting
    inconsistency and remounts read-only.  Because the backing
    qemu returned success for every request, nothing in the
    guest's own block layer logs anything; kernels have been
    observed stopping all FS writes silently for hours until
    userspace tries to write.

  * Latent poisoning with multi-day incubation.  A block-job
    (commit, stream, active mirror, legacy block-migrate +
    commit on a destination) running concurrently with guest
    discard traffic plants aliased clusters that may not
    produce a symptom until a later guest discard walks one
    of them.  Cases in the wild have surfaced 8 to 17 days
    after the originating block-job window.

  * Recovery requires both fsck inside the guest AND
    qemu-img check -r all on the host -- the former repairs
    the ext4 level, the latter repairs the qcow2 refcount/L2
    aliasing; fsck alone leaves the image to re-corrupt the
    moment writes to an aliased cluster resume.

Why it surfaces only under block-jobs
-------------------------------------

Guest-only I/O rarely opens the race window: the guest's own
block layer serialises DISCARD and WRITE to the same LBA range,
so at any moment a cluster is either "being written" or "being
discarded" from the guest, not both.  The race requires a second
I/O producer on the same BDS that does not observe guest-side
ordering -- i.e. a block job.  Every migration / commit / backup
/ mirror cycle is an exposure window; steady-state VMs are
essentially immune until the next image-management operation
runs.

Fix
---

Patch 1/2 marks both pdiscard and all pwrite_zeroes (with or
without MAY_UNMAP) as BDRV_REQ_SERIALISING in the generic block
layer.  Their tracked_request then waits for overlapping
in-flight writes -- including non-serialising ones -- to finish
their format-driver commit before any L2/refcount mutation
happens.

The gate lives in block/io.c rather than in qcow2 so that:

  * every format driver that drops an internal mutex during
    the data I/O of an allocating write is covered, not just
    qcow2;

  * the NBD WRITE_ZEROES path (blk_co_pwrite_zeroes ->
    blk_co_pwritev -> bdrv_co_pwritev_part ->
    bdrv_aligned_pwritev, which bypasses the
    bdrv_co_pwrite_zeroes wrapper entirely) is still caught
    -- the gate is placed where BDRV_REQ_ZERO_WRITE is
    observed on the way down to the driver.

Perf impact is limited to the overlap window. The serialising
request only waits when a conflict actually exists, which is
exactly the corruption surface.  Steady-state non-overlapping
traffic pays nothing.

Test
----

Patch 2/2 adds a deterministic iotest
(tests/qemu-iotests/tests/discard-write-serialisation) that
drives a single qemu-io process with a fixed-seed 5000-command
sequence of interleaved aio_write and aio_write -z -u at random
cluster-aligned offsets in a small contention region, then runs
qemu-img check and asserts zero corruptions. Results across 8
runs each:

  fixed tree:    8/8 clean
  unfixed tree:  8/8 detect (2-4 corruptions per run)

100% detection on the unfixed tree, zero false positives on the
fixed tree, under 30 seconds per run.  The test is scoped to
qcow2 because qcow2 is the format whose qemu-img check validates
the fingerprint; the underlying race is format-agnostic.

Denis V. Lunev (2):
  block/io: serialise discard and write-zeroes against in-flight writes
  iotests: regression test for discard/write-zeroes vs in-flight write
    race

 block/io.c                                    | 25 ++++-
 .../tests/discard-write-serialisation         | 97 +++++++++++++++++++
 .../tests/discard-write-serialisation.out     |  1 +
 3 files changed, 122 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/tests/discard-write-serialisation
 create mode 100644 tests/qemu-iotests/tests/discard-write-serialisation.out

-- 
2.51.0


