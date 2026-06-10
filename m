Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D4DCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXHaF-0003wv-Mn; Wed, 10 Jun 2026 07:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wXHaC-0003vE-KW; Wed, 10 Jun 2026 07:58:56 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1wXHaA-0004l3-QR; Wed, 10 Jun 2026 07:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=A1UQrNrmTVxgkSXkAIyZaWrFr46WHntZzbpFfnfFGAo=; b=Yqu1Ak0dKEhI
 mKlrFVLmfTZBtcVnbDqtkMeLoTNhnqzF/RNeJJV/1+30WEVBrqJXO80AysOEkTrSFXk4i7oWZw29a
 7COFEq6QL18FEG0wIsGMPEPW1HWdJ9ikSHbS7FJhhl0hnSr5DV/vNVC9BV0iiOm34+UCaAEc+zZoB
 suluQiyx2Md8UlzDE55vi/n2unjPDY0gUO31ucRDAd4tpfR6YzQLpO7QPqWxzn/bxyhVF+dupYrng
 3AwuRSBU2PgpYpth4FSQPD4mfFCH/lpbb78fY2RYJCOW+raRniM3eITzkmhjlHnYWkg3oRgW6G8S7
 krN8Azcj2+/nAAEeA7FGJA==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=athena.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1wXHZl-001cCx-1H;
 Wed, 10 Jun 2026 13:58:50 +0200
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH v3 0/1] coroutine: fix lost wakeup in qemu_co_sleep_wake()
Date: Wed, 10 Jun 2026 13:58:49 +0200
Message-ID: <20260610115850.2410566-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
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

Changes since v2
----------------
  * Drop the redundant fast-path check in qemu_co_sleep(); the publish
    cmpxchg already consumes a pending wake (Kevin).
  * Add a deterministic regression test, no threads or timers needed.

Changes since v1
----------------
  * Patch 1 (graph-lock) applied as e3082ab3b3, dropped here.
  * Fix the qemu_co_sleep_wake() primitive instead of working around
    it in qcow2 (Kevin).

Problem
-------

The qemu shutdown / blockdev-close path can deadlock permanently on
upstream master. The main thread enters ppoll(timeout=-1) holding
BQL, no other thread has a wake source that points back at it, and
qemu has to be SIGKILLed. The hang has no timeout -- it is a hard
deadlock, not a slow operation; behind BQL, RCU, VCPUs and every
iothread path that needs BQL stall with it.

The race exposed in qcow2's cache_clean_timer cancellation path:

  ppoll -> aio_poll -> cache_clean_timer_del_and_wait -> qcow2_close

The race diagram and the exact stale-state read are in the patch's
commit message.

Reproducer
----------

Environment: 4-vCPU VM guest, kernel 6.12.x, upstream master at
de5d8bfd61. On modern bare-metal the window is narrow enough that the
hang rarely reproduces without a VM -- a VM guest under full CPU
saturation is what makes the timing reliable.

    # reproducer
    stress-ng --cpu "$(nproc)" --timeout 0 &
    for r in $(seq 20); do
        timeout 120 ./build/tests/qemu-iotests/check -qcow2 iothreads-create
    done
    kill %1

With `stress-ng --cpu $(nproc)` the race surfaces. With
`stress-ng --cpu $(($(nproc) - 1))` or without a stressor it does
not reproduce reliably across 20 iterations.

The new unit test reproduces the same lost wakeup deterministically,
without a VM or a stressor.

Results
-------

Same guest, 20 iterations of the loop above, master at de5d8bfd61:

  without this patch:  reproduces reliably (qcow2_close in ppoll)
  with this patch:     20/20 PASS

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>

Denis V. Lunev (1):
  coroutine: fix lost wakeup in qemu_co_sleep_wake()

 include/qemu/coroutine.h    | 17 +++++++++---
 tests/unit/test-coroutine.c | 53 +++++++++++++++++++++++++++++++++++++
 util/qemu-coroutine-sleep.c | 53 ++++++++++++++++++++++++++-----------
 3 files changed, 104 insertions(+), 19 deletions(-)

-- 
2.53.0


