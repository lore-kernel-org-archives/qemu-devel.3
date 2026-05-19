Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA68CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNrl-0008Ih-BM; Tue, 19 May 2026 13:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNrT-0008AX-4Q
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNrR-0004Nq-Cd
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779210244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=06IwaCK6uoA4GQaGnFk7LeWoE13yL3/b3GgPq0TR6UY=;
 b=HPY9ovxrzH7iQ01bRfoUyZpUKCIVMvQ+/x9/VvLS96xzniFeKuIdTZwwXJcGAzyDhDEKjN
 Gxt2bAvYiWrXrecUUZHxg5e8G31Ptlseh0TDrQpyylO6ugmWRsvlpN++El8G0GQ+ealvcw
 jCS06BJUKP34OWEvEkW7Cf2uY0HTkyc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-dfZOGB84NDu2DO4SySfFHA-1; Tue,
 19 May 2026 13:04:01 -0400
X-MC-Unique: dfZOGB84NDu2DO4SySfFHA-1
X-Mimecast-MFC-AGG-ID: dfZOGB84NDu2DO4SySfFHA_1779210240
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A2BC18005B3; Tue, 19 May 2026 17:04:00 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.49.113])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DCF4C1684; Tue, 19 May 2026 17:03:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 17/18] block/graph-lock: fix missed wakeup in
 bdrv_graph_co_rdunlock()
Date: Tue, 19 May 2026 19:03:16 +0200
Message-ID: <20260519170317.345032-18-kwolf@redhat.com>
In-Reply-To: <20260519170317.345032-1-kwolf@redhat.com>
References: <20260519170317.345032-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 block/graph-lock.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/block/graph-lock.c b/block/graph-lock.c
index b7319473a17..f2501d75fbe 100644
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
2.54.0


