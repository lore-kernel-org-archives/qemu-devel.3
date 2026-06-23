Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47694CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 15:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc2z6-0004lP-4b; Tue, 23 Jun 2026 11:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wc2z4-0004kS-6V
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:24:18 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wc2z0-0003Fn-72
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:24:17 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490b613a17bso48515745e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1782228252; x=1782833052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XzsX0Wp5kYrKeC7ZDwHnYAxGPSqeFnF2AaqMrkEjN8Q=;
 b=sz9pweLZ88LLk7tXTf8DLQpWB2Zqo816OtUNIpdJNax46MenLZiF8rrz1GT005RPvK
 EIQ8FJOt/MgV4c2h0T/SLDRAAJygFYcunljqF4sIXwkR0trV6/NjseByUWzXGEUCBG8f
 f08wx/KH8jTQYMrmBka7CZDD7Wz4MPhXLyDZ7EO924iL4JMWjTWk/UC9v3blmcynqb3Y
 HOLGM0n05pYuff8RwfUsqnbLbcCkOw/fv0guxWTa52WsNJsqjfeH5wHxyDf0vXwYrrV1
 SD5plgJRzi/cnPrFYN6uiJQWbzS2hR6QtjPvvlf3kOVuZYgCsVO4ZVuuOkhBKu/gn1F/
 qPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782228252; x=1782833052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XzsX0Wp5kYrKeC7ZDwHnYAxGPSqeFnF2AaqMrkEjN8Q=;
 b=GUKAu4QImDhU16vBkjIoa1RAfNZkqqdlEBTti2GE1dMMd1fRAwiCOwJGFCwGNoxxsj
 sGT9xnmu4+Ht8xFzVV4mvWoJrD9Y4HHN2VwnpZuvWc8ZF/a3nLCB5gmdk2nWRDPkoy7F
 kdwLaRf2xXy2lj0+OJLLUXz+/4z4asJvW8D2ym26A0KOgYtl9Js7ixCww6HcD4Y8XcL/
 8Je8XRBLp0BuaBc7ARdlIZmrMpPq1Qkwb1Ja4LHZQA0j6gPPKqGwKEYtJKPEi6AlTqFg
 XQbWw8gojEdRZmQCcE+uxBwLKcqpR23dPxq3wchHeqbR/0oja4+NvZDGeOCpqYsAILT2
 JgAw==
X-Gm-Message-State: AOJu0Yz/pO04iJCozUw/LCPIGsWWSXWL8ej5L4B+zPFLdGr9hMenRcXL
 vuWbmtCo//EnZDafBRScqQDxc4P+IUUeKQ7E4HmDHFRvFz9gUBeVFYvRD2Ekfk/zWtw2EBjWRJ1
 M4jfouRPyDgHk
X-Gm-Gg: AfdE7ckUKgepvQrQPPnrjLi92WPR2RzHQcBwf6z8N8RZr5UKPcUCmX4GNHxKezPxRv6
 9gA7UFl/b1+FRLhWC5+0FcFKUD5xo2nGPOxgdUcoxbAfhjAnkUSC1RYFxpV5ogVX3x1G0lSeZzh
 H9878GYk0fObi1fqwubpdlCAOQ6ElfZNXYLVJPRZLNlvglL0JMfsA/q/4sbIG6+9mwLgwjH/zty
 GE/ckskn55gWT+YN+ZJIhL9FDtjg3PYQzPGwkz3p63Rc0WcnD9L04oJbRFWaNsH+bbbf2u8OkJk
 l6c2rzLmzW3gF10WP0GqFzG11NpOHqpAQTOwKw935wzLC/EbGpH6Cx7/ro6kXTe6gPOrpH/N6CR
 a57WwLb8SyOH2zqbCz9HfI61pmopVRQBG6b8H9IskwI85rWMBj3cH0uLSi+AuDj60oldG4/M=
X-Received: by 2002:a05:600c:348b:b0:490:44eb:c1ea with SMTP id
 5b1f17b1804b1-492490a771dmr237984845e9.24.1782228251614; 
 Tue, 23 Jun 2026 08:24:11 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:406b:7279:5a3e:280f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240eef2basm406008895e9.2.2026.06.23.08.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 08:24:11 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 2/2] tests/unit/test-blockjob: cover keeping a job paused
 while a pause is pending
Date: Tue, 23 Jun 2026 17:24:06 +0200
Message-ID: <20260623152406.1180235-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623152406.1180235-1-den@openvz.org>
References: <20260623152406.1180235-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=den@openvz.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 tests/unit/test-blockjob.c | 100 +++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/tests/unit/test-blockjob.c b/tests/unit/test-blockjob.c
index abdbe4b835..3b77d19b91 100644
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
2.53.0


