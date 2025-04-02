Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D0EC36014
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 10:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzvE5-0004sl-TH; Wed, 02 Apr 2025 06:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mordan@ispras.ru>)
 id 1tzvDz-0004s8-8a; Wed, 02 Apr 2025 06:21:35 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mordan@ispras.ru>)
 id 1tzvDx-0002ml-6j; Wed, 02 Apr 2025 06:21:34 -0400
Received: from Neilbrown.intra.ispras.ru (unknown [10.10.2.179])
 by mail.ispras.ru (Postfix) with ESMTPSA id 58D22448787C;
 Wed,  2 Apr 2025 10:21:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 58D22448787C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1743589291;
 bh=QdT77uApGerlM6ikEWy+iXoDjZvq2QdTQSZe6pb03rc=;
 h=From:To:Cc:Subject:Date:From;
 b=PaEen7bQm39Tft78mJtdQzPV1LXbWERJyEFb8AGCFaUAKfdw/kLBLxjFs2ynsiZkQ
 bYPMkXzVeSKs4GjlFKBhb8ieVS1Gmid7PJeDB68zykgQ5I1r9XE/qihq2tdSpa46eE
 vMqKGohGFtMrDrfgLqQ+OA0lkBs1Jii09Yn6Z7Q0=
From: Vitalii Mordan <mordan@ispras.ru>
To: John Snow <jsnow@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitalii Mordan <mordan@ispras.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org,
 Vadim Mutilin <mutilin@ispras.ru>,
 Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] Fix data races in test-bdrv-drain test
Date: Wed,  2 Apr 2025 13:21:19 +0300
Message-Id: <20250402102119.3345626-1-mordan@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84; envelope-from=mordan@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch addresses potential data races involving access to Job fields
in the test-bdrv-drain test.

Fixes: 7253220de4 ("test-bdrv-drain: Test drain vs. block jobs")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2900
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
 include/qemu/job.h           |  2 ++
 job.c                        |  6 ++++++
 tests/unit/test-bdrv-drain.c | 20 ++++++++++----------
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/qemu/job.h b/include/qemu/job.h
index 2b873f2576..f27551a9ad 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -520,6 +520,8 @@ bool job_is_internal(Job *job);
  */
 bool job_is_cancelled(Job *job);
 
+bool job_is_paused(Job *job);
+
 /* Same as job_is_cancelled(), but called with job lock held. */
 bool job_is_cancelled_locked(Job *job);
 
diff --git a/job.c b/job.c
index 660ce22c56..d9b2dd8532 100644
--- a/job.c
+++ b/job.c
@@ -251,6 +251,12 @@ bool job_is_cancelled_locked(Job *job)
     return job->force_cancel;
 }
 
+bool job_is_paused(Job *job)
+{
+	JOB_LOCK_GUARD();
+	return job->paused;
+}
+
 bool job_is_cancelled(Job *job)
 {
     JOB_LOCK_GUARD();
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 7410e6f352..65041c9230 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -667,10 +667,10 @@ static int coroutine_fn test_job_run(Job *job, Error **errp)
 
     /* We are running the actual job code past the pause point in
      * job_co_entry(). */
-    s->running = true;
+    qatomic_set(&s->running, true);
 
     job_transition_to_ready(&s->common.job);
-    while (!s->should_complete) {
+    while (!qatomic_read(&s->should_complete)) {
         /* Avoid job_sleep_ns() because it marks the job as !busy. We want to
          * emulate some actual activity (probably some I/O) here so that drain
          * has to wait for this activity to stop. */
@@ -685,7 +685,7 @@ static int coroutine_fn test_job_run(Job *job, Error **errp)
 static void test_job_complete(Job *job, Error **errp)
 {
     TestBlockJob *s = container_of(job, TestBlockJob, common.job);
-    s->should_complete = true;
+    qatomic_set(&s->should_complete, true);
 }
 
 BlockJobDriver test_job_driver = {
@@ -791,7 +791,7 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
         /* job_co_entry() is run in the I/O thread, wait for the actual job
          * code to start (we don't want to catch the job in the pause point in
          * job_co_entry(). */
-        while (!tjob->running) {
+        while (!qatomic_read(&tjob->running)) {
             aio_poll(qemu_get_aio_context(), false);
         }
     }
@@ -825,7 +825,7 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
          *
          * paused is reset in the I/O thread, wait for it
          */
-        while (job->job.paused) {
+        while (job_is_paused(&job->job)) {
             aio_poll(qemu_get_aio_context(), false);
         }
     }
@@ -858,7 +858,7 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
          *
          * paused is reset in the I/O thread, wait for it
          */
-        while (job->job.paused) {
+        while (job_is_paused(&job->job)) {
             aio_poll(qemu_get_aio_context(), false);
         }
     }
@@ -1422,7 +1422,7 @@ static int coroutine_fn test_drop_backing_job_run(Job *job, Error **errp)
     TestDropBackingBlockJob *s =
         container_of(job, TestDropBackingBlockJob, common.job);
 
-    while (!s->should_complete) {
+    while (!qatomic_read(&s->should_complete)) {
         job_sleep_ns(job, 0);
     }
 
@@ -1541,7 +1541,7 @@ static void test_blockjob_commit_by_drained_end(void)
 
     job_start(&job->common.job);
 
-    job->should_complete = true;
+    qatomic_set(&job->should_complete, true);
     bdrv_drained_begin(bs_child);
     g_assert(!job_has_completed);
     bdrv_drained_end(bs_child);
@@ -1565,7 +1565,7 @@ static int coroutine_fn test_simple_job_run(Job *job, Error **errp)
 {
     TestSimpleBlockJob *s = container_of(job, TestSimpleBlockJob, common.job);
 
-    while (!s->should_complete) {
+    while (!qatomic_read(&s->should_complete)) {
         job_sleep_ns(job, 0);
     }
 
@@ -1700,7 +1700,7 @@ static void test_drop_intermediate_poll(void)
     job->did_complete = &job_has_completed;
 
     job_start(&job->common.job);
-    job->should_complete = true;
+    qatomic_set(&job->should_complete, true);
 
     g_assert(!job_has_completed);
     ret = bdrv_drop_intermediate(chain[1], chain[0], NULL, false);
-- 
2.34.1


