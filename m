Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DF2CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmlR-000850-3R; Wed, 20 May 2026 15:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wPmkv-000826-3c; Wed, 20 May 2026 15:39:09 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wPmkq-0006X4-3P; Wed, 20 May 2026 15:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=G4mrBi8Rzir1MfeN7SipZShukzuC4rGhcZ3/jiXw2sU=; b=md7eegowdV3R
 fSt+Yj40+JcdDbJayat33KKATuaGPhdcR2QfSOFplha5RGSOqaxr2ijw8s4MzZSdhRbAlzaoOYIXQ
 xq1HlYPBzfR72bop1jMO7DqIiU47ltocQ5GFa6RwxDyzxI/LkouqWFxV9212ii84Ka3QTQokpENbK
 Y9GCW7Jub4ELNcI5xH4pA4DLSDgM/pbavDWem9V7K/sEzMshITnWQnY5XNOQK3enU19pjNeNnvbsx
 Nma92XQvZT8uP9k9tDJkO8ENvnb0iGaJ1essqb12jBLts0iAoOjLgQKxJmBCLOgauR2BboHY2Qz7P
 EppwjHPY40wsoH0jWl05uQ==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1wPmhP-000JWT-1i;
 Wed, 20 May 2026 21:38:49 +0200
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH v2 0/1] coroutine: fix lost wakeup in qemu_co_sleep_wake()
Date: Wed, 20 May 2026 21:38:48 +0200
Message-ID: <20260520193849.467936-1-den@openvz.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HEXHASH_WORD=2.602, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

Changes since v1
----------------

v1 was a two-patch series tracking two independent missed-wakeup
races on the qemu shutdown path.

  * Patch 1, "block/graph-lock: fix missed wakeup in
    bdrv_graph_co_rdunlock()", was applied as e3082ab3b3 by Kevin
    and is now in tree. This v2 carries only the remaining race.

  * Per Kevin's review of v1 patch 2 [1], the cache_clean_timer
    hang is no longer worked around inside block/qcow2.c. Instead,
    the underlying primitive -- qemu_co_sleep_wake() -- is fixed,
    closing the lost-wakeup window for every caller
    (cache_clean_timer, block_copy_kick, ...) rather than just
    qcow2. Cancellation latency through qemu_co_sleep_wake() drops
    from "next 1 s tick" (v1 workaround) to aio_co_wake().

[1] https://lore.kernel.org/qemu-devel/agcYkmTWud8euTds@redhat.com/

Problem
-------

The qemu shutdown / blockdev-close path can deadlock permanently on
upstream master. The main thread enters ppoll(timeout=-1) holding
BQL, no other thread has a wake source that points back at it, and
qemu has to be SIGKILLed. The hang has no timeout -- it is a hard
deadlock, not a slow operation; behind BQL, RCU, VCPUs and every
iothread path that needs BQL stall with it.

Two independent missed-wakeup races in the block layer contributed
to the symptom on v1. Both shared the same shape: a waiter arms on
one side, the waker reads stale state on its fast path and silently
skips the kick, and nothing else on the AioContext fires to
recover. The first (block/graph-lock) was fixed by e3082ab3b3 and
is now in tree. This patch closes the second one, exposed in
qcow2's cache_clean_timer cancellation path:

  ppoll -> aio_poll -> cache_clean_timer_del_and_wait -> qcow2_close

The race diagram and the exact stale-state read are in the patch's
commit message.

Reproducer
----------

Environment: 4-vCPU VM guest, kernel 6.12.x, upstream master at
e3082ab3b3 (with the graph-lock fix already applied). On modern
bare-metal the window is narrow enough that the hang rarely
reproduces without a VM -- a VM guest under full CPU saturation is
what makes the timing reliable.

    # reproducer
    stress-ng --cpu "$(nproc)" --timeout 0 &
    for r in $(seq 20); do
        timeout 120 ./build/tests/qemu-iotests/check -qcow2 iothreads-create
    done
    kill %1

With `stress-ng --cpu $(nproc)` the race surfaces. With
`stress-ng --cpu $(($(nproc) - 1))` or without a stressor it does
not reproduce reliably across 20 iterations.

When the race fires, the Python QMP client times out on
vm.run_job() after 5 s, the qemu process keeps running but never
makes forward progress, and the outer `timeout 120` eventually
kills it. Attach gdb before the timeout kills qemu to capture the
stack.

Results
-------

Same guest, 20 iterations of the loop above, master at e3082ab3b3:

  without this patch:  reproduces reliably (qcow2_close in ppoll)
  with this patch:     20/20 PASS

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>

Denis V. Lunev (1):
  coroutine: fix lost wakeup in qemu_co_sleep_wake()

 include/qemu/coroutine.h    | 17 ++++++++---
 util/qemu-coroutine-sleep.c | 60 +++++++++++++++++++++++++++----------
 2 files changed, 58 insertions(+), 19 deletions(-)

-- 
2.51.0


