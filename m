Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FBAFE5204
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGDwU-0002b6-9p; Fri, 24 Apr 2026 06:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wGDwT-0002aZ-0o; Fri, 24 Apr 2026 06:39:25 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wGDwR-000200-7h; Fri, 24 Apr 2026 06:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-ID:Date:Subject
 :From; bh=EcnsQFbnncWE7Prrulk8hdwft53Btw+MTadW5OXdZ6Q=; b=wbwwoxqLyd8iuh9vy7o
 jOxUsAJMjWigQXUHNgzLzjAvRSrVXUeaaVjUw2HMvw2wQLHaiRVuNWoyNCLLh+1KG7yIIefqDQEK5
 s2sCAIQHeKJlsoerIbQ5TrAYQVtKJubLEqZQFHd0Y68q0S9JaH2GQg3jiYCDN/EvncOhHxXlIIm5Z
 EPwdt7VAwnbBBqRrV2epDGnc+zUVz/Zk1uUYUT+Y6s89XefhfWirADzGE1YLOKlobiGl/qBz8fqQL
 goO8R/hC9JS/Gy4t2c4QCoeFqrptoLCuaf9IfP2+ExpBdrJf5d7XZrslaSNqnNqt1Lc+49iQBoMiM
 pcfS8gZ6OrFeqSw==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1wGDtf-00F3Ps-05;
 Fri, 24 Apr 2026 12:39:14 +0200
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org,
 "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: [PATCH 0/2] block: fix two missed-wakeup hangs on shutdown path
Date: Fri, 24 Apr 2026 12:39:15 +0200
Message-ID: <20260424103917.248668-1-den@openvz.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Problem
-------

The qemu shutdown / blockdev-close path can deadlock permanently on
upstream master.  The main thread enters ppoll(timeout=-1) holding
BQL, no other thread has a wake source that points back at it, and
qemu has to be SIGKILLed.  The hang has no timeout -- it is a hard
deadlock, not a slow operation; behind BQL, RCU, VCPUs and every
iothread path that needs BQL stall with it.

Two independent missed-wakeup races in the block layer contribute.
Both share the same shape: a waiter arms on one side, the waker
reads stale state on its fast path and silently skips the kick, and
nothing else on the AioContext will fire to recover.  They are
different bugs in different subsystems and each patch stands on its
own; they are posted together because they surface through the same
test and the same symptom and are easiest to diagnose side by side.

Depending on which race fires, the main thread backtrace at the
moment of hang is one of:

  ppoll -> aio_poll -> bdrv_graph_wrlock -> blk_remove_bs
      (patch 1 -- block/graph-lock)

  ppoll -> aio_poll -> cache_clean_timer_del_and_wait -> qcow2_close
      (patch 2 -- block/qcow2 cache_clean_timer)

Race diagrams and the exact stale-state read are in each patch's
commit message.

Reproducer
----------

Environment used for the numbers below: 4-vCPU VM guest,
kernel 6.12.x, upstream master at bb230769b4.  On modern bare-metal
the window is narrow enough that the hangs rarely reproduce without
a VM -- a VM guest under full CPU saturation is what makes the
timing reliable.  Downstream trees that still use plain
bdrv_graph_wrlock() in blk_remove_bs() hit the graph-lock race on
the first iteration without any stress at all.

    # reproducer
    stress-ng --cpu "$(nproc)" --timeout 0 &
    for r in $(seq 20); do
        timeout 120 ./build/tests/qemu-iotests/check -qcow2 iothreads-create
    done
    kill %1

With `stress-ng --cpu $(nproc)` both races surface.  With
`stress-ng --cpu $(($(nproc) - 1))` or without a stressor neither
reproduces reliably across 20 iterations.

When a race fires, the Python QMP client times out on vm.run_job()
after 5 s, the qemu process keeps running but never makes forward
progress, and the outer `timeout 120` eventually kills it.  attach
gdb before the timeout kills qemu to capture the stack and
distinguish which of the two races fired.

Results
-------

Same guest, 20 iterations of the loop above:

  upstream master:            10/20 FAIL (first fail at iter #2)
  master + both patches:      20/20 PASS

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>
Cc: Hanna Czenczek <hreitz@redhat.com>

Denis V. Lunev (2):
  block/graph-lock: fix missed wakeup in bdrv_graph_co_rdunlock()
  block/qcow2: fix hangup in cache_clean_timer cancellation

 block/graph-lock.c | 12 +++++-------
 block/qcow2.c      | 28 +++++++++++++++++-----------
 2 files changed, 22 insertions(+), 18 deletions(-)

--
2.51.0

