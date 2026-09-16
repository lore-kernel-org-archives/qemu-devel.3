Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DBBC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kJb-0004Ii-6a; Wed, 16 Sep 2026 03:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kJX-0004G4-C8; Wed, 16 Sep 2026 03:44:19 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kJV-0004uY-Kz; Wed, 16 Sep 2026 03:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789544605; bh=0JUQwdsD42rCBLJnwMCsiD+JtuaZU9eg5je+fU1SpSA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=S1wHsR859jFCFXU9GNVXPfVwFnp6XyM/HkQ+eBJPrcsAQjym2Q7DdHRqFxn0W+nhN
 dk6vgfa2TaZptqVzmA/qkiLq5tmDxnA7t2pj84op24FNZboOBGsRLaM1WucFwOWkH5
 GSbVfe3eFJYg04Yp5VLEmSna71ld9XmblD+WWx0Vrg3LIrE+Wj3bR77Bv9nCKCMMRT
 bemVpeZzrPWRNzk4PM0u3/pPAoRsWKWU3MkSWJRnE4yOVhZwGvaUada+PmIejBJPCb
 qyiG4MRvvW9BHHH8gmN74MfkX7Gkl/PZbofNlioMJ6pE6xrmJoU6E8aEJSyhHTi92u
 mW7Ofnm24KYSw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2F93F1D5591;
 Wed, 16 Sep 2026 10:43:25 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B2D80429B26;
 Wed, 16 Sep 2026 10:44:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9DE0C5A6CD; Wed, 16 Sep 2026 10:44:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 06/49] job: keep job paused across overlapping pause
 requests
Date: Wed, 16 Sep 2026 10:42:24 +0300
Message-ID: <20260916074346.671467-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
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

job_pause_point_locked() sets job->paused before yielding and clears it
unconditionally on wake, before re-checking whether a pause is still
pending. job_pause() re-enters a parked job only while it is not yet
paused, so the wake that resumes one comes from a drain *ending*
(job_resume() -> job_enter_cond()). If the next drain begins before that
wake runs, the woken coroutine clears job->paused while pause_count is
already > 0 again:

  AioContext change (BQL thread)     job coroutine (iothread)
  -----------------------------      ------------------------
                                     parked in job_pause_point():
                                       paused=1, pause_count=1, yielded
  drain ends -> job_resume():
    pause_count = 0
    job_enter_cond(): queue wake ..>   (wake pending)
  bdrv_try_change_aio_context():
    bdrv_drain_all_begin():
      job_pause() per node
      pause_count = N (> 0)
                                     wake runs, leaves job_do_yield():
                                       paused = 0  (pause_count == N)
    tran_commit -> job_set_aio_context():
      assert(paused || completed) --> abort: paused == 0

bdrv_try_change_aio_context() drains precisely to quiesce the job before
changing its AioContext, but that brief paused==0 window trips the
assertion. It is guest-triggerable: a virtio-blk reset
(virtio_blk_stop_ioeventfd() -> blk_set_aio_context()) racing a running
mirror/blockCopy job hits it, as do x-blockdev-set-iothread, blockdev
hot-plug/unplug and job completion.

Keep job->paused set while a pause is still pending: loop the yield
until job_should_pause_locked() is false (or the job is cancelled), and
only then clear job->paused. Drained-state consumers then never observe
a pending-pause job as unpaused.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Message-ID: <20260623152406.1180235-2-den@openvz.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
(cherry picked from commit 2667133c2799f670366b94059cc0513ae57fe8cb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/job.c b/job.c
index 0653bc2ba69..28981e64bd9 100644
--- a/job.c
+++ b/job.c
@@ -629,7 +629,14 @@ static void coroutine_fn job_pause_point_locked(Job *job)
                                     ? JOB_STATUS_STANDBY
                                     : JOB_STATUS_PAUSED);
         job->paused = true;
-        job_do_yield_locked(job, -1);
+        /*
+         * Stay paused across back-to-back pause requests: a transient
+         * paused == false while pause_count > 0 would be observed as
+         * "not paused" by job_set_aio_context() and other drain consumers.
+         */
+        do {
+            job_do_yield_locked(job, -1);
+        } while (job_should_pause_locked(job) && !job_is_cancelled_locked(job));
         job->paused = false;
         job_state_transition_locked(job, status);
     }
-- 
2.47.3


