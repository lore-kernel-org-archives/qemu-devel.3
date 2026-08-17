Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0DEC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww33w-0003Se-Na; Mon, 17 Aug 2026 15:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ww331-0003E3-Bs; Mon, 17 Aug 2026 15:31:03 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ww32x-00032E-RX; Mon, 17 Aug 2026 15:31:03 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 7572B80B0B;
 Mon, 17 Aug 2026 22:30:55 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:d2f::1:33])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id rUaw3t0XVW20-wZGEHwKs; Mon, 17 Aug 2026 22:30:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1786995055;
 bh=F3/9uID+5UQQyk8mlPm0RPopuhgY7yZ45MSr8eG3FmQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=p8/kFoWb1Ryx+U2Cz9mX08eEIOe8TcLabGopAMnmgIsihYcstx30dWxzi2oU+NPZ2
 Je0izJCTwtm5O6UgX3NoZECdu96FmC3lVJbxo8bLCBEyuLv6P3opXf8s05x06/XQOV
 VcCZpuobbpMBP8DQdaQg8mCUWruVotVDDnc2RR44=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	den@openvz.org,
	vsementsov@yandex-team.ru
Subject: [PULL 1/6] job: keep job paused across overlapping pause requests
Date: Mon, 17 Aug 2026 22:29:43 +0300
Message-ID: <20260817192948.1743452-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817192948.1743452-1-vsementsov@yandex-team.ru>
References: <20260817192948.1743452-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
---
 job.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/job.c b/job.c
index e7479084726..d7220aaf30c 100644
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
2.43.0


