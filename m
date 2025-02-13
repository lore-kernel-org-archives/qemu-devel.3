Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992F7C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 11:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiX7O-00051q-EE; Thu, 13 Feb 2025 06:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mordan@ispras.ru>) id 1tiX7L-00051f-Cu
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 06:10:51 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mordan@ispras.ru>) id 1tiX7I-0007wR-W3
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 06:10:51 -0500
Received: from Neilbrown.intra.ispras.ru (unknown [10.10.2.179])
 by mail.ispras.ru (Postfix) with ESMTPSA id 470A8422488E;
 Thu, 13 Feb 2025 11:10:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 470A8422488E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1739445044;
 bh=JYVDohb5Vzfbi7ZY/z+vjZ6PgqxgJ9qLDVNpVzBZSM4=;
 h=From:To:Cc:Subject:Date:From;
 b=HT+LbJcPn+fLwGi4BQi8YtMxX0MQE2acsTLdBeB1a7Emdao0ARY8ve0afr8/Hp3n7
 /PM+j60QDAnhgLBWe0rXkXAMv2aHztU1bQT85kikNzqjUWdJ3eQgoCtqm4hhJn26N7
 OZ/uWZJITm0LWXnILgnFZ4xMWGCL0Qil3sLHdTeg=
From: Vitalii Mordan <mordan@ispras.ru>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Vitalii Mordan <mordan@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org, Vadim Mutilin <mutilin@ispras.ru>,
 Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] Fix Data Races with TestBlockJob Fields in test-block-iothread
Date: Thu, 13 Feb 2025 14:10:31 +0300
Message-Id: <20250213111032.2726976-1-mordan@ispras.ru>
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

This patch resolves potential data races involving access to TestBlockJob
fields in test-block-iothread.c.

Fixes: 93c60f3862 ("test-block-iothread: Job coroutine thread after AioContext switch")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2809
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
 tests/unit/test-block-iothread.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 7324ea4a68..b3d3f2fdb3 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -513,8 +513,8 @@ static int coroutine_fn test_job_run(Job *job, Error **errp)
     TestBlockJob *s = container_of(job, TestBlockJob, common.job);
 
     job_transition_to_ready(&s->common.job);
-    while (!s->should_complete) {
-        s->n++;
+    while (!qatomic_read(&s->should_complete)) {
+        qatomic_inc(&s->n);
         g_assert(qemu_get_current_aio_context() == job->aio_context);
 
         /* Avoid job_sleep_ns() because it marks the job as !busy. We want to
@@ -533,7 +533,7 @@ static int coroutine_fn test_job_run(Job *job, Error **errp)
 static void test_job_complete(Job *job, Error **errp)
 {
     TestBlockJob *s = container_of(job, TestBlockJob, common.job);
-    s->should_complete = true;
+    qatomic_set(&s->should_complete, true);
 }
 
 BlockJobDriver test_job_driver = {
@@ -564,28 +564,28 @@ static void test_attach_blockjob(void)
                             0, 0, NULL, NULL, &error_abort);
     job_start(&tjob->common.job);
 
-    while (tjob->n == 0) {
+    while (qatomic_read(&tjob->n) == 0) {
         aio_poll(qemu_get_aio_context(), false);
     }
 
     blk_set_aio_context(blk, ctx, &error_abort);
 
     tjob->n = 0;
-    while (tjob->n == 0) {
+    while (qatomic_read(&tjob->n) == 0) {
         aio_poll(qemu_get_aio_context(), false);
     }
 
     blk_set_aio_context(blk, qemu_get_aio_context(), &error_abort);
 
     tjob->n = 0;
-    while (tjob->n == 0) {
+    while (qatomic_read(&tjob->n) == 0) {
         aio_poll(qemu_get_aio_context(), false);
     }
 
     blk_set_aio_context(blk, ctx, &error_abort);
 
     tjob->n = 0;
-    while (tjob->n == 0) {
+    while (qatomic_read(&tjob->n) == 0) {
         aio_poll(qemu_get_aio_context(), false);
     }
 
-- 
2.34.1


