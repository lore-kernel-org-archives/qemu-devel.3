Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDCCCDB479
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 15:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc2z6-0004lX-Nh; Tue, 23 Jun 2026 11:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wc2z1-0004jr-Ps
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:24:16 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wc2yz-0003FR-3u
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:24:15 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490b613a17bso48515255e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1782228250; x=1782833050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/0VvjIeKyQ+VdrjQccUt1hft7SyBvtWdcKKSRrD52Lc=;
 b=IWZbQFWgB3ESKH1jEd1Q2aj87891vxVKcntiiz+HEHVLnM1t8oppimbaHKPomdC8re
 bg43a6L/KHL93RAES7qubbIGA9HRIZtcsTWHWWNdMaVzsrKEe3/HweurRaWTNT17XljN
 tbwTYkDowFUi0qw5wz+RL9SOXgT5UZLSVASUQ7zhIrpENr2rlBSQamZ3qimdETkC57y5
 USV7ob81GN+bpD2d7GHnK6wohEiv/lL3I8cM5hURqQAlrO0F8rbJlIv3sS2GJUQ+X2zl
 X0cDQNQZw5cQFujom5gJslIOGSLkplD1ViZm/lmE38e5vieH5IsbjKRrCPPkiTIpZ9CA
 4yLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782228250; x=1782833050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/0VvjIeKyQ+VdrjQccUt1hft7SyBvtWdcKKSRrD52Lc=;
 b=tHOpZnvtT7PKzuvl1PNh/8XV8vaRr5zThe+lCzlRI7EeYMteNByWtxK2gDbDMWdAjt
 LAN8X5lXYEAJcWNKkA1/G05qslchE2b+r2BG9YlB0sEcXxId9fRGO4MwTin77yrP51Ep
 BdWhbzep8bpKFwL0fUmRCrNAenBapu6MMp/pWKNx8tgLf26DPhNMoLCXBTcgOWcyLzPG
 kpVdHuRvHfuEeeKt04yHprr4y7Js3+lZ6U0YvoLLXQIebBJ/KgHsSazjrWFbPi3iMJVC
 V1q266TNJAY3aoWpQQKaG2iQcLezcl/t6mREGt0XZevVMrsUKlPZXKdmO58a8Uonq7B8
 t7tw==
X-Gm-Message-State: AOJu0YwkCIOrhr1Cnws+y+CKyKdLIjJw7Es2iePyaF4t3I6J4b+WBL6+
 GNrC9TUM8tuHxueO1XtFL9uDaoTq2/5WH449VYgXEIxP5nLnZB0euXE2A8uxjxsrUM8=
X-Gm-Gg: AfdE7ckz4gQ0HW7ontCnGStrKCZ/4SIOeTGQWk+MegUf/OysaI5R+btJXahs76d10sf
 9RsBq+qCZxEjuM14C2MS3QicgtDPSIVU8oigRTrKdG7e3EF9W/ST9OzjwUW6JHFgQgVdvzpP9t8
 m6cHiOqcRqdwD4j3jhqnSvpas1w49GWPzuilPTd5B3YmGVekILl8rq94r+UOm65zpiSks2PuXT1
 4F8l0RGJET9bTPyB9Lh7UnUoXHkgjyrQBRTdqxhWDAKKYhtdGk56ORrHJlP+xWI9kXaJareF9F7
 ptLn4F7B8DjklVk3aV1Ie1IDyJJEd3tn3oZRpf94bm5VUg3PJKsB+N6rb2EvQRNXeFaeUCnYVMq
 kWq+RkdQCXPXRUDYkl0roOw90MJDnDYxz/r265439qix18L2ND/63pfKij5kSgiYfw3kdkTbUAT
 GggbL0rQ==
X-Received: by 2002:a05:600c:500d:b0:492:37b7:6080 with SMTP id
 5b1f17b1804b1-49249083ccamr234039725e9.7.1782228250170; 
 Tue, 23 Jun 2026 08:24:10 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:406b:7279:5a3e:280f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240eef2basm406008895e9.2.2026.06.23.08.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 08:24:09 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 1/2] job: keep job paused across overlapping pause requests
Date: Tue, 23 Jun 2026 17:24:05 +0200
Message-ID: <20260623152406.1180235-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623152406.1180235-1-den@openvz.org>
References: <20260623152406.1180235-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=den@openvz.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
---
 job.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/job.c b/job.c
index e747908472..d7220aaf30 100644
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
2.53.0


