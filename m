Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478B2CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXcq-00077f-Em; Fri, 22 May 2026 17:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXcJ-0004N2-Vw; Fri, 22 May 2026 17:41:16 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXcI-0005fu-6e; Fri, 22 May 2026 17:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485684; bh=F6Ba537/STwNJ4Rd6q+dwZUZ+iQAMCxKlsiu5jqwPfc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qhS/X0D7bfid9gEjfBe3RzUwxuNwwqr9+49A3h29ROv8b7jIOyu+gmeQb/QvT391z
 5bnPmrykTcxNjCrsgSlbcIsO1NBnmUoRC0oKdrr4whOAOqWH9yc3vf74mSw4RwbtiR
 cG/aqgWJfOqi93Pxb0UPqLGgbaaZX62FU2uxw6yHTrAJ3F1UgISoqQ3kr4bDrWj5KK
 aKqNxDgaTBl4om77hcj9NhuENZtUQI6KBMLm+5uNxv4c4l2bJ1/DbRYzS0sqswvo/y
 D0fE0CE/oZkHeo/YQCGYrh79OrOHTX2AjpsDldJ47ny2PbBj47WBddMYq6tGpUf0P2
 yB3b719y+3x7g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 755A21AFB19;
 Sat, 23 May 2026 00:34:44 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 937A13B7199;
 Sat, 23 May 2026 00:34:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 136/136] block/graph-lock: fix missed wakeup in
 bdrv_graph_co_rdunlock()
Date: Sat, 23 May 2026 00:34:44 +0300
Message-ID: <20260522213446.806182-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260522213601@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260522213601@cover.tls.msk.ru>
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

From: "Denis V. Lunev" <den@openvz.org>

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
Message-ID: <20260424103917.248668-2-den@openvz.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit e3082ab3b38538ebdbc5cd62b4c476b673c5e515)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/graph-lock.c b/block/graph-lock.c
index c81162b147..7d018ed7f4 100644
--- a/block/graph-lock.c
+++ b/block/graph-lock.c
@@ -244,14 +244,12 @@ void coroutine_fn bdrv_graph_co_rdunlock(void)
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
2.47.3


