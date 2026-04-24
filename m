Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE91FE5205
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGDwV-0002c7-3N; Fri, 24 Apr 2026 06:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wGDwT-0002ai-Br; Fri, 24 Apr 2026 06:39:25 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wGDwR-0001zz-7M; Fri, 24 Apr 2026 06:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=0rF0i4tPGZ/wx4pJf8mTyDIVzwqbQMZM1Dp9RCapltc=; b=SPlzZmObKbiZ
 gC+fKyfTr2oJ1itRsdCycNSYt+z/wtX0BXG/JkAnJypFbUF2/K4x2POIKP78cqJAjz4f2rafPHa/N
 +ju7yQIrxTPOY+tN9QEgurL9iAvB5A1+Kfu1T4VJxiwN+ckM41VgMhKR5xxAFUsZksoWoOtK8auW0
 dkQAw84bb8GeauihKqhY9Y4TiSEFnQxdjvO6szqhut5t4aJe/sjgM5BTUHemeoorDau9yBiGh8FCc
 e2riJdWT8zUR8F6a0gnQUBuL7HhumiikGNhs4xvH2hvt5CzztDoALlQuJN6hQHhajyRDOSgC+garS
 izQRbNPOQlrwhFuTROSwCg==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1wGDtf-00F3Ps-1J;
 Fri, 24 Apr 2026 12:39:15 +0200
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org,
 "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: [PATCH 1/2] block/graph-lock: fix missed wakeup in
 bdrv_graph_co_rdunlock()
Date: Fri, 24 Apr 2026 12:39:16 +0200
Message-ID: <20260424103917.248668-2-den@openvz.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260424103917.248668-1-den@openvz.org>
References: <20260424103917.248668-1-den@openvz.org>
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

tests/qemu-iotests/tests/iothreads-create reproduces the hang on
master under `stress-ng --cpu $(nproc) --timeout 0`.  The iotest's
vm.run_job() times out and qemu stays permanently stuck in
ppoll(timeout=-1) inside bdrv_graph_wrlock_drained -> blk_remove_bs
during qemu_cleanup().  The timing window is narrow on modern
bare-metal hardware and much wider in a VM guest; downstream trees
that still use plain bdrv_graph_wrlock() in blk_remove_bs() hit it
on the first iteration under the same stress.

bdrv_graph_wrlock() zeroes has_writer around its AIO_WAIT_WHILE loop
so that callbacks dispatched by aio_poll() can still take the read
lock on the fast path.  The rdunlock side, however, only kicks a
waiting writer when has_writer is observed set; a reader that drops
its lock inside the polling window silently returns and nothing ever
wakes the writer:

  main thread                         iothread0 coroutine
  -----------                         -------------------
  bdrv_graph_wrlock:                  rdlock held, reader_count=1
    bdrv_drain_all_begin_nopoll
    has_writer = 0
    AIO_WAIT_WHILE_UNLOCKED(
        NULL, reader_count >= 1):
      num_waiters++
      smp_mb
      aio_poll(main_ctx, true)   -->  bdrv_graph_co_rdunlock:
        (ppoll, blocked)                reader_count-- -> 0
                                        smp_mb
                                        read has_writer = 0
                                        skip aio_wait_kick()
                                      return

reader_count is now 0 and num_waiters is still 1, but no BH, fd or
timer on the main AioContext will fire -- the only entity that could
kick just decided it did not have to.  Main stays in ppoll() holding
BQL, so RCU, VCPUs and any iothread path that needs BQL stall behind
it.  The hang is final; no timeout, no forward progress, no recovery
as there is no other source of wake up inside qemu_cleanup().

bdrv_drain_all_begin() does not close the race on its own: it
quiesces in-flight I/O, but graph readers also include non-I/O
coroutines (block-job cleanup, virtio-scsi polling) that drain does
not evict.  The bdrv_graph_wrlock_drained() wrapper narrows the
window but does not eliminate it; every plain bdrv_graph_wrlock()
site is exposed on the same basis.

Drop the has_writer check in bdrv_graph_co_rdunlock() and call
aio_wait_kick() unconditionally.  The helper itself loads num_waiters
atomically and only schedules a dummy BH when a waiter exists, so the
change is a no-op on the no-writer path and closes the missed-wakeup
on the writer path.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>
---
 block/graph-lock.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/block/graph-lock.c b/block/graph-lock.c
index b7319473a1..f2501d75fb 100644
--- a/block/graph-lock.c
+++ b/block/graph-lock.c
@@ -278,14 +278,12 @@ void coroutine_fn bdrv_graph_co_rdunlock(void)
     smp_mb();
 
     /*
-     * has_writer == 0: this means reader will read reader_count decreased
-     * has_writer == 1: we don't know if writer read reader_count old or
-     *                  new. Therefore, kick again so on next iteration
-     *                  writer will for sure read the updated value.
+     * Always kick: bdrv_graph_wrlock() zeroes has_writer while polling (to
+     * let callbacks take the reader lock via the fast path), so we cannot
+     * rely on has_writer to detect a waiting writer. aio_wait_kick() is a
+     * no-op when no one is waiting, so it is cheap in the common case.
      */
-    if (qatomic_read(&has_writer)) {
-        aio_wait_kick();
-    }
+    aio_wait_kick();
 }
 
 void bdrv_graph_rdlock_main_loop(void)
-- 
2.51.0


