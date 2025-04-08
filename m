Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE82C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 13:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u28as-00078P-VJ; Tue, 08 Apr 2025 09:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u28Zk-0006mL-WC
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 09:01:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u28Zi-0005dE-Qv
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 09:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744117268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ahykKS5380HRIk59tI1Zc8zyJMxoC+VGjiLPBK0Cc6c=;
 b=Nq+1YHhLsX1OuCl5s9L/qMTbgEyROuvConQli7MDITLBF6KyKdhH03PK0p+obkufUJQAAQ
 lQBgl7QHaePQ1PXYUKmZPW/nLAKHwksaz0AfagH6+oOJ/XRZoLaKSlug34jOfY+5OrvOcN
 aeRAfdb+mDTzP6GtuEhZRe6G+JlPh54=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-umJ8wUPONJukArKaEsORBQ-1; Tue,
 08 Apr 2025 09:01:02 -0400
X-MC-Unique: umJ8wUPONJukArKaEsORBQ-1
X-Mimecast-MFC-AGG-ID: umJ8wUPONJukArKaEsORBQ_1744117260
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6AE418011ED; Tue,  8 Apr 2025 13:01:00 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.33.56])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 83B5019560AD; Tue,  8 Apr 2025 13:00:59 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 4/4] test-bdrv-drain: Fix data races
Date: Tue,  8 Apr 2025 15:00:48 +0200
Message-ID: <20250408130048.283364-5-kwolf@redhat.com>
In-Reply-To: <20250408130048.283364-1-kwolf@redhat.com>
References: <20250408130048.283364-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vitalii Mordan <mordan@ispras.ru>

This patch addresses potential data races involving access to Job fields
in the test-bdrv-drain test.

Fixes: 7253220de4 ("test-bdrv-drain: Test drain vs. block jobs")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2900
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
Message-ID: <20250402102119.3345626-1-mordan@ispras.ru>
[kwolf: Fixed up coding style and one missing atomic access]
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qemu/job.h           |  3 +++
 job.c                        |  6 ++++++
 tests/unit/test-bdrv-drain.c | 32 +++++++++++++++++++-------------
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/include/qemu/job.h b/include/qemu/job.h
index 2b873f2576..a5a04155ea 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -545,6 +545,9 @@ bool job_is_ready(Job *job);
 /* Same as job_is_ready(), but called with job lock held. */
 bool job_is_ready_locked(Job *job);
 
+/** Returns whether the job is paused. Called with job_mutex *not* held. */
+bool job_is_paused(Job *job);
+
 /**
  * Request @job to pause at the next pause point. Must be paired with
  * job_resume(). If the job is supposed to be resumed by user action, call
diff --git a/job.c b/job.c
index 660ce22c56..0653bc2ba6 100644
--- a/job.c
+++ b/job.c
@@ -251,6 +251,12 @@ bool job_is_cancelled_locked(Job *job)
     return job->force_cancel;
 }
 
+bool job_is_paused(Job *job)
+{
+    JOB_LOCK_GUARD();
+    return job->paused;
+}
+
 bool job_is_cancelled(Job *job)
 {
     JOB_LOCK_GUARD();
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 7410e6f352..290cd2a70e 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -632,6 +632,8 @@ typedef struct TestBlockJob {
     BlockDriverState *bs;
     int run_ret;
     int prepare_ret;
+
+    /* Accessed with atomics */
     bool running;
     bool should_complete;
 } TestBlockJob;
@@ -667,10 +669,10 @@ static int coroutine_fn test_job_run(Job *job, Error **errp)
 
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
@@ -685,7 +687,7 @@ static int coroutine_fn test_job_run(Job *job, Error **errp)
 static void test_job_complete(Job *job, Error **errp)
 {
     TestBlockJob *s = container_of(job, TestBlockJob, common.job);
-    s->should_complete = true;
+    qatomic_set(&s->should_complete, true);
 }
 
 BlockJobDriver test_job_driver = {
@@ -791,7 +793,7 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
         /* job_co_entry() is run in the I/O thread, wait for the actual job
          * code to start (we don't want to catch the job in the pause point in
          * job_co_entry(). */
-        while (!tjob->running) {
+        while (!qatomic_read(&tjob->running)) {
             aio_poll(qemu_get_aio_context(), false);
         }
     }
@@ -799,7 +801,7 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
     WITH_JOB_LOCK_GUARD() {
         g_assert_cmpint(job->job.pause_count, ==, 0);
         g_assert_false(job->job.paused);
-        g_assert_true(tjob->running);
+        g_assert_true(qatomic_read(&tjob->running));
         g_assert_true(job->job.busy); /* We're in qemu_co_sleep_ns() */
     }
 
@@ -825,7 +827,7 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
          *
          * paused is reset in the I/O thread, wait for it
          */
-        while (job->job.paused) {
+        while (job_is_paused(&job->job)) {
             aio_poll(qemu_get_aio_context(), false);
         }
     }
@@ -858,7 +860,7 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
          *
          * paused is reset in the I/O thread, wait for it
          */
-        while (job->job.paused) {
+        while (job_is_paused(&job->job)) {
             aio_poll(qemu_get_aio_context(), false);
         }
     }
@@ -1411,10 +1413,12 @@ static void test_set_aio_context(void)
 
 typedef struct TestDropBackingBlockJob {
     BlockJob common;
-    bool should_complete;
     bool *did_complete;
     BlockDriverState *detach_also;
     BlockDriverState *bs;
+
+    /* Accessed with atomics */
+    bool should_complete;
 } TestDropBackingBlockJob;
 
 static int coroutine_fn test_drop_backing_job_run(Job *job, Error **errp)
@@ -1422,7 +1426,7 @@ static int coroutine_fn test_drop_backing_job_run(Job *job, Error **errp)
     TestDropBackingBlockJob *s =
         container_of(job, TestDropBackingBlockJob, common.job);
 
-    while (!s->should_complete) {
+    while (!qatomic_read(&s->should_complete)) {
         job_sleep_ns(job, 0);
     }
 
@@ -1541,7 +1545,7 @@ static void test_blockjob_commit_by_drained_end(void)
 
     job_start(&job->common.job);
 
-    job->should_complete = true;
+    qatomic_set(&job->should_complete, true);
     bdrv_drained_begin(bs_child);
     g_assert(!job_has_completed);
     bdrv_drained_end(bs_child);
@@ -1557,15 +1561,17 @@ static void test_blockjob_commit_by_drained_end(void)
 
 typedef struct TestSimpleBlockJob {
     BlockJob common;
-    bool should_complete;
     bool *did_complete;
+
+    /* Accessed with atomics */
+    bool should_complete;
 } TestSimpleBlockJob;
 
 static int coroutine_fn test_simple_job_run(Job *job, Error **errp)
 {
     TestSimpleBlockJob *s = container_of(job, TestSimpleBlockJob, common.job);
 
-    while (!s->should_complete) {
+    while (!qatomic_read(&s->should_complete)) {
         job_sleep_ns(job, 0);
     }
 
@@ -1700,7 +1706,7 @@ static void test_drop_intermediate_poll(void)
     job->did_complete = &job_has_completed;
 
     job_start(&job->common.job);
-    job->should_complete = true;
+    qatomic_set(&job->should_complete, true);
 
     g_assert(!job_has_completed);
     ret = bdrv_drop_intermediate(chain[1], chain[0], NULL, false);
-- 
2.49.0


