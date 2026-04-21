Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FFCF8FA90
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 15:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFDSo-0002fQ-60; Tue, 21 Apr 2026 11:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wFDSl-0002ej-GV; Tue, 21 Apr 2026 11:56:35 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wFDSj-0003JB-GB; Tue, 21 Apr 2026 11:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=tux/oh3wBPkdouV7SFgL9r8W8VUWDFSoRd15nfBxmrk=; b=A9T/9Lrr5SfM
 bJhieSxqX3VcBQnUNyJDfbYehWF7F76ucUnXVNyFxPeVWRaLcO82k+SI5w9ZE1yvna1P53wcuRu9R
 l+dN/eZ2WWqorNJTdvQ3xORssEgQj7y67LMDqCpNXfps7SaVXN/CmlpXacRjfQxpIEGu39Ek+a3I+
 HIb31CiWPIwtz+7wBUyHYNcJWebKwB8jpxhOYnN62HmMqcpjZNvJzpt0ImV6UMhFxmVQc3wfSk1UC
 TZxTRrlNY1mSM3wg95uw259YN9dO9gh7aJ0VovS33GlYFIqnVQu1lbaOCJya1pMg4XB5Gt8GvhQtj
 xlX1TRqYMCZSsawN1M567w==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1wFDQ2-001k3k-24;
 Tue, 21 Apr 2026 17:56:19 +0200
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org,
	qemu-stable@nongnu.org
Cc: den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 1/2] block/io: serialise discard and write-zeroes against
 in-flight writes
Date: Tue, 21 Apr 2026 17:56:27 +0200
Message-ID: <20260421155628.3600671-2-den@openvz.org>
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

qcow2's write path drops s->lock around the data I/O of an allocating
write. A concurrent discard (or MAY_UNMAP write-zeroes) on the same
guest offset lands the cluster-free operation in that window. The
original writer then reacquires the lock and unconditionally writes
L2[G] = alloc_offset | OFLAG_COPIED on its now-stale l2meta, binding
the L2 entry to a freed cluster:

  WRITE coroutine                       DISCARD coroutine
  ---------------                       -----------------
  qcow2_co_pwritev_part:
    lock(s->lock)
    qcow2_alloc_host_offset:
      handle_copied reads L2[G] = C | OFLAG_COPIED
      builds l2meta { alloc=C, keep_old_clusters=true }
    unlock(s->lock)                 -->
    bdrv_co_pwritev_part (data I/O)    lock(s->lock)
                                       qcow2_co_pdiscard on G:
                                         discard_in_l2_slice
                                           set_l2_entry(G, 0)
                                           free_any_cluster(C):
                                             rc(C) 1 -> 0
                                       unlock(s->lock)
    lock(s->lock)
    qcow2_handle_l2meta(link_l2=true):
      qcow2_alloc_cluster_link_l2:
        set_l2_entry(G, C | OFLAG_COPIED)  <- stale alloc onto
                                              freed cluster

The next allocator pass re-hands C out on rc=0, so we end up with two
L2 entries aliasing one host cluster. On disk this shows up in
qemu-img check as refcount=0 with a live OFLAG_COPIED reference or as
refcount < reference; at runtime the next discard on either alias
prints "qcow2_free_clusters failed: Invalid argument" on stderr with
no guest-visible error.

Mark both discards and all write-zeroes (with or without MAY_UNMAP)
as BDRV_REQ_SERIALISING in the generic block layer. Their
tracked_request then waits for overlapping in-flight writes,
including non-serialising ones, to finish their format-driver commit
before any L2/refcount mutation happens.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
---
 block/io.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index dd5f13c694..9f23029b95 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2097,6 +2097,16 @@ bdrv_aligned_pwritev(BdrvChild *child, BdrvTrackedRequest *req,
     max_transfer = QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer, INT_MAX),
                                    align);
 
+    /*
+     * Zero-writes (with or without MAY_UNMAP) mutate L2 entries / refcounts
+     * in the format driver and therefore race with concurrent in-flight
+     * regular writes that have dropped their internal mutex for the data
+     * I/O.  See the comment in bdrv_co_pdiscard(). Serialise them.
+     */
+    if (flags & BDRV_REQ_ZERO_WRITE) {
+        flags |= BDRV_REQ_SERIALISING;
+    }
+
     ret = bdrv_co_write_req_prepare(child, offset, bytes, req, flags);
 
     if (!ret && bs->detect_zeroes != BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF &&
@@ -3192,7 +3202,20 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
     bdrv_inc_in_flight(bs);
     tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_DISCARD);
 
-    ret = bdrv_co_write_req_prepare(child, offset, bytes, &req, 0);
+    /*
+     * Discards must serialise against overlapping in-flight writes.
+     * A format driver's write path may drop its internal mutex around
+     * the data I/O while still holding a pending cluster-allocation
+     * commit (see qcow2's handle_copied / qcow2_alloc_cluster_link_l2
+     * sequence).  A concurrent discard that clears L2 and drops the
+     * refcount during that window leaves the writer pointing at a
+     * freed cluster - the root of the refcount/reference aliasing
+     * corruption family.  Marking the discard serialising makes it wait
+     * for the in-flight write's tracked_request to complete before any
+     * L2/refcount mutation happens.
+     */
+    ret = bdrv_co_write_req_prepare(child, offset, bytes, &req,
+                                    BDRV_REQ_SERIALISING);
     if (ret < 0) {
         goto out;
     }
-- 
2.51.0


