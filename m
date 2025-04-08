Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF39C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 10:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u26DC-0000Li-K0; Tue, 08 Apr 2025 06:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u26DA-0000KD-VI
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 06:29:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u26D9-0006ji-Dn
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 06:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744108182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P4ouzJG0fz4KNdTDpsxKwoTdI2TNQkioWbAVISGNtk8=;
 b=ivLHa9Z18r4myr89uSIGJQ6a30M6mJF1fE15ZKgZxQDOAnJcO3BYPWdeGJU6RmzsESrOLc
 x8+696ks8WMKCVpMQmPUlxtsbDZjStBRnkfroEg+LTxwKlHrvOYwTE+jCnBtfqKg9f5ayZ
 QmbQIjUAozBz9JM9NSC+wXVrOHCy9jo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-SbrsvtcgPYO9RrqQe_EvLQ-1; Tue,
 08 Apr 2025 06:29:39 -0400
X-MC-Unique: SbrsvtcgPYO9RrqQe_EvLQ-1
X-Mimecast-MFC-AGG-ID: SbrsvtcgPYO9RrqQe_EvLQ_1744108178
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80807180025E; Tue,  8 Apr 2025 10:29:37 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.56])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B687180174E; Tue,  8 Apr 2025 10:29:31 +0000 (UTC)
Date: Tue, 8 Apr 2025 12:29:24 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vitalii Mordan <mordan@ispras.ru>
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org, Vadim Mutilin <mutilin@ispras.ru>,
 Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH] Fix data races in test-bdrv-drain test
Message-ID: <Z_T6hNpk83eq-PTs@redhat.com>
References: <20250402102119.3345626-1-mordan@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402102119.3345626-1-mordan@ispras.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 02.04.2025 um 12:21 hat Vitalii Mordan geschrieben:
> This patch addresses potential data races involving access to Job fields
> in the test-bdrv-drain test.
> 
> Fixes: 7253220de4 ("test-bdrv-drain: Test drain vs. block jobs")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2900
> Signed-off-by: Vitalii Mordan <mordan@ispras.ru>

Considering that we're nearing the end of the code freeze for 10.0, I
fixed up a few trivial problems myself instead of asking for a v2 (see
diff below).

Thanks, applied to the block branch.

Kevin

diff --git a/include/qemu/job.h b/include/qemu/job.h
index f27551a9ad..a5a04155ea 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -520,8 +520,6 @@ bool job_is_internal(Job *job);
  */
 bool job_is_cancelled(Job *job);

-bool job_is_paused(Job *job);
-
 /* Same as job_is_cancelled(), but called with job lock held. */
 bool job_is_cancelled_locked(Job *job);

@@ -547,6 +545,9 @@ bool job_is_ready(Job *job);
 /* Same as job_is_ready(), but called with job lock held. */
 bool job_is_ready_locked(Job *job);

+/** Returns whether the job is paused. Called with job_mutex *not* held. */
+bool job_is_paused(Job *job);
+
 /**
  * Request @job to pause at the next pause point. Must be paired with
  * job_resume(). If the job is supposed to be resumed by user action, call
diff --git a/job.c b/job.c
index d9b2dd8532..0653bc2ba6 100644
--- a/job.c
+++ b/job.c
@@ -253,8 +253,8 @@ bool job_is_cancelled_locked(Job *job)

 bool job_is_paused(Job *job)
 {
-	JOB_LOCK_GUARD();
-	return job->paused;
+    JOB_LOCK_GUARD();
+    return job->paused;
 }

 bool job_is_cancelled(Job *job)
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 65041c9230..290cd2a70e 100644
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
@@ -799,7 +801,7 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
     WITH_JOB_LOCK_GUARD() {
         g_assert_cmpint(job->job.pause_count, ==, 0);
         g_assert_false(job->job.paused);
-        g_assert_true(tjob->running);
+        g_assert_true(qatomic_read(&tjob->running));
         g_assert_true(job->job.busy); /* We're in qemu_co_sleep_ns() */
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
@@ -1557,8 +1561,10 @@ static void test_blockjob_commit_by_drained_end(void)

 typedef struct TestSimpleBlockJob {
     BlockJob common;
-    bool should_complete;
     bool *did_complete;
+
+    /* Accessed with atomics */
+    bool should_complete;
 } TestSimpleBlockJob;

 static int coroutine_fn test_simple_job_run(Job *job, Error **errp)


