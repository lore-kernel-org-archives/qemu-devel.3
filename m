Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D224EC5DF7D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww33N-0003Ij-Lt; Mon, 17 Aug 2026 15:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ww330-0003E2-Fz; Mon, 17 Aug 2026 15:31:03 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ww32x-00032G-Rv; Mon, 17 Aug 2026 15:31:01 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id F258D80669;
 Mon, 17 Aug 2026 22:30:55 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:d2f::1:33])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id rUaw3t0XVW20-i4pnX9CA; Mon, 17 Aug 2026 22:30:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1786995055;
 bh=IhnY7dl5HPtxi/v1FI9u4iSL+biA3nduueZ/yMxFM8o=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=F4npuaIjoSvN4FCq4uMGGWlxIJRRpTQVW44HIgE1/S1gy4bRjWTc/FmHnshqFKrlV
 OVhSglolbXxi7yFy9ibTKj+lGroyWSvbR1KpIfnUs+y2APfLc5SCfBtMKst4DEvm2N
 6mYnrWhhDaZ2x0yn+h65kVxzqWBQZJtNshJmEgss=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	den@openvz.org,
	vsementsov@yandex-team.ru
Subject: [PULL 2/6] tests/unit/test-blockjob: cover keeping a job paused while
 a pause is pending
Date: Mon, 17 Aug 2026 22:29:44 +0300
Message-ID: <20260817192948.1743452-3-vsementsov@yandex-team.ru>
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

Add a regression test for the previous commit. A job that has reached
its pause point is spuriously re-entered (job_enter()) while a pause is
still pending (pause_count > 0), reproducing what an overlapping drain
does: one drain's job_resume() wakes the job while the next drain's
job_pause() is already counted. The job must stay parked - it must not
run job code or clear job->paused, or job_set_aio_context() could
observe paused == false and abort.

The test counts the job's run-loop iterations: without the fix the
re-entered job clears job->paused, runs one iteration and re-pauses, so
the counter advances; with the fix it stays parked and the counter is
unchanged. It runs in the main AioContext, so job_enter() is synchronous
and the check is deterministic.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Message-ID: <20260623152406.1180235-3-den@openvz.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/unit/test-blockjob.c | 100 +++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/tests/unit/test-blockjob.c b/tests/unit/test-blockjob.c
index abdbe4b8350..3b77d19b911 100644
--- a/tests/unit/test-blockjob.c
+++ b/tests/unit/test-blockjob.c
@@ -388,6 +388,105 @@ static void test_cancel_concluded(void)
     cancel_common(s);
 }
 
+typedef struct PauseCountJob {
+    BlockJob common;
+    int n;
+    bool should_complete;
+} PauseCountJob;
+
+static void pause_count_job_complete(Job *job, Error **errp)
+{
+    PauseCountJob *s = container_of(job, PauseCountJob, common.job);
+    s->should_complete = true;
+}
+
+static int coroutine_fn pause_count_job_run(Job *job, Error **errp)
+{
+    PauseCountJob *s = container_of(job, PauseCountJob, common.job);
+
+    while (!s->should_complete) {
+        if (job_is_cancelled(&s->common.job)) {
+            return 0;
+        }
+        s->n++;
+        /*
+         * Yields; while a pause is pending the yield is skipped and the job
+         * parks in job_pause_point() instead.
+         */
+        job_sleep_ns(&s->common.job, 10 * 1000 * 1000);
+    }
+
+    return 0;
+}
+
+static const BlockJobDriver pause_count_job_driver = {
+    .job_driver = {
+        .instance_size = sizeof(PauseCountJob),
+        .free          = block_job_free,
+        .user_resume   = block_job_user_resume,
+        .run           = pause_count_job_run,
+        .complete      = pause_count_job_complete,
+    },
+};
+
+/*
+ * A job that has reached its pause point must stay paused while a pause is
+ * still pending (pause_count > 0). An overlapping drain re-enters the job (one
+ * drain's job_resume() wakes it while the next drain's job_pause() is already
+ * counted); the job must not run or clear job->paused, otherwise
+ * job_set_aio_context() can observe paused == false and abort.
+ */
+static void test_pause_keeps_paused(void)
+{
+    BlockBackend *blk;
+    BlockJob *bjob;
+    PauseCountJob *s;
+    Job *job;
+    int n0;
+
+    blk = create_blk(NULL);
+    bjob = mk_job(blk, "job0", &pause_count_job_driver, true,
+                  JOB_MANUAL_FINALIZE | JOB_MANUAL_DISMISS);
+    s = container_of(bjob, PauseCountJob, common);
+    job = &bjob->job;
+    WITH_JOB_LOCK_GUARD() {
+        job_ref_locked(job);
+    }
+
+    job_start(job);
+
+    /* Pause the running job; it parks in job_pause_point() with paused set. */
+    WITH_JOB_LOCK_GUARD() {
+        job_pause_locked(job);
+        g_assert_true(job->paused);
+        g_assert_cmpint(job->status, ==, JOB_STATUS_PAUSED);
+    }
+    n0 = s->n;
+
+    /*
+     * Spurious wake while the pause is still pending. The job must stay parked:
+     * the bug clears job->paused, runs an iteration (s->n advances) and
+     * re-pauses, exposing a paused == false window.
+     */
+    job_enter(job);
+    WITH_JOB_LOCK_GUARD() {
+        g_assert_true(job->paused);
+    }
+    g_assert_cmpint(s->n, ==, n0);
+
+    /* Resume and tear down. */
+    WITH_JOB_LOCK_GUARD() {
+        job_resume_locked(job);
+    }
+    job_cancel_sync(job, true);
+    WITH_JOB_LOCK_GUARD() {
+        Job *dummy = job;
+        job_dismiss_locked(&dummy, &error_abort);
+        job_unref_locked(job);
+    }
+    destroy_blk(blk);
+}
+
 int main(int argc, char **argv)
 {
     qemu_init_main_loop(&error_abort);
@@ -402,5 +501,6 @@ int main(int argc, char **argv)
     g_test_add_func("/blockjob/cancel/standby", test_cancel_standby);
     g_test_add_func("/blockjob/cancel/pending", test_cancel_pending);
     g_test_add_func("/blockjob/cancel/concluded", test_cancel_concluded);
+    g_test_add_func("/blockjob/pause/keep_paused", test_pause_keeps_paused);
     return g_test_run();
 }
-- 
2.43.0


