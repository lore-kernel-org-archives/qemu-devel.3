Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92971C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 14:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbKt8-0003im-7l; Fri, 24 Jan 2025 09:42:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mordan@ispras.ru>) id 1tbKt5-0003iL-Tm
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 09:42:23 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mordan@ispras.ru>) id 1tbKt2-0004YM-Ud
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 09:42:23 -0500
Received: from Neilbrown.intra.ispras.ru (unknown [10.10.2.179])
 by mail.ispras.ru (Postfix) with ESMTPSA id 6C180407674C;
 Fri, 24 Jan 2025 14:42:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6C180407674C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1737729736;
 bh=LI0excmxEGTvWAi2bMzSkvHNAqkxXMfiXJ+zEKIjHc4=;
 h=From:To:Cc:Subject:Date:From;
 b=WNx8WftjgxjBqDGbiMEOsdlZHDkCScqZMQkxsOjWLbrrYgjbaLkIDxPlRyxpXXGdC
 X+R0lMCEVZGrlGn4YoxdCzDg8d26tKlncTpT/Tft4WoVyGoFY6c7gGeyF1nI1/hWX0
 wZBQG01tGnufem98Wj/D0CzxrJl33cREZqhSMpW4=
From: Vitalii Mordan <mordan@ispras.ru>
To: Thomas Huth <thuth@redhat.com>
Cc: Vitalii Mordan <mordan@ispras.ru>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org, Vadim Mutilin <mutilin@ispras.ru>,
 Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH v2] Fix a data race with goflag in rcutorture test
Date: Fri, 24 Jan 2025 17:42:02 +0300
Message-Id: <20250124144202.743759-1-mordan@ispras.ru>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch addresses a potential data race involving the global variable
goflag in the rcutorture test.

Fixes: 8fda74a52b ("rcu: add rcutorture")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2750
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
v2: Access goflag using qatomic_read and qatomic_set as requested by
Paolo Bonzini.
 tests/unit/rcutorture.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tests/unit/rcutorture.c b/tests/unit/rcutorture.c
index 7662081683..30c8ad279f 100644
--- a/tests/unit/rcutorture.c
+++ b/tests/unit/rcutorture.c
@@ -123,10 +123,10 @@ static void *rcu_read_perf_test(void *arg)
 
     *(struct rcu_reader_data **)arg = get_ptr_rcu_reader();
     qatomic_inc(&nthreadsrunning);
-    while (goflag == GOFLAG_INIT) {
+    while (qatomic_read(&goflag) == GOFLAG_INIT) {
         g_usleep(1000);
     }
-    while (goflag == GOFLAG_RUN) {
+    while (qatomic_read(&goflag) == GOFLAG_RUN) {
         for (i = 0; i < RCU_READ_RUN; i++) {
             rcu_read_lock();
             rcu_read_unlock();
@@ -149,10 +149,10 @@ static void *rcu_update_perf_test(void *arg)
 
     *(struct rcu_reader_data **)arg = get_ptr_rcu_reader();
     qatomic_inc(&nthreadsrunning);
-    while (goflag == GOFLAG_INIT) {
+    while (qatomic_read(&goflag) == GOFLAG_INIT) {
         g_usleep(1000);
     }
-    while (goflag == GOFLAG_RUN) {
+    while (qatomic_read(&goflag) == GOFLAG_RUN) {
         synchronize_rcu();
         n_updates_local++;
     }
@@ -174,9 +174,9 @@ static void perftestrun(int nthreads, int duration, int nreaders, int nupdaters)
     while (qatomic_read(&nthreadsrunning) < nthreads) {
         g_usleep(1000);
     }
-    goflag = GOFLAG_RUN;
+    qatomic_set(&goflag, GOFLAG_RUN);
     g_usleep(duration * G_USEC_PER_SEC);
-    goflag = GOFLAG_STOP;
+    qatomic_set(&goflag, GOFLAG_STOP);
     wait_all_threads();
     printf("n_reads: %lld  n_updates: %ld  nreaders: %d  nupdaters: %d duration: %d\n",
            n_reads, n_updates, nreaders, nupdaters, duration);
@@ -253,10 +253,10 @@ static void *rcu_read_stress_test(void *arg)
     rcu_register_thread();
 
     *(struct rcu_reader_data **)arg = get_ptr_rcu_reader();
-    while (goflag == GOFLAG_INIT) {
+    while (qatomic_read(&goflag) == GOFLAG_INIT) {
         g_usleep(1000);
     }
-    while (goflag == GOFLAG_RUN) {
+    while (qatomic_read(&goflag) == GOFLAG_RUN) {
         rcu_read_lock();
         p = qatomic_rcu_read(&rcu_stress_current);
         if (qatomic_read(&p->mbtest) == 0) {
@@ -305,11 +305,11 @@ static void *rcu_update_stress_test(void *arg)
     rcu_register_thread();
     *(struct rcu_reader_data **)arg = get_ptr_rcu_reader();
 
-    while (goflag == GOFLAG_INIT) {
+    while (qatomic_read(&goflag) == GOFLAG_INIT) {
         g_usleep(1000);
     }
 
-    while (goflag == GOFLAG_RUN) {
+    while (qatomic_read(&goflag) == GOFLAG_RUN) {
         struct rcu_stress *p;
         rcu_stress_idx++;
         if (rcu_stress_idx >= RCU_STRESS_PIPE_LEN) {
@@ -347,10 +347,10 @@ static void *rcu_fake_update_stress_test(void *arg)
     rcu_register_thread();
 
     *(struct rcu_reader_data **)arg = get_ptr_rcu_reader();
-    while (goflag == GOFLAG_INIT) {
+    while (qatomic_read(&goflag) == GOFLAG_INIT) {
         g_usleep(1000);
     }
-    while (goflag == GOFLAG_RUN) {
+    while (qatomic_read(&goflag) == GOFLAG_RUN) {
         synchronize_rcu();
         g_usleep(1000);
     }
@@ -373,9 +373,9 @@ static void stresstest(int nreaders, int duration)
     for (i = 0; i < 5; i++) {
         create_thread(rcu_fake_update_stress_test);
     }
-    goflag = GOFLAG_RUN;
+    qatomic_set(&goflag, GOFLAG_RUN);
     g_usleep(duration * G_USEC_PER_SEC);
-    goflag = GOFLAG_STOP;
+    qatomic_set(&goflag, GOFLAG_STOP);
     wait_all_threads();
     printf("n_reads: %lld  n_updates: %ld  n_mberror: %d\n",
            n_reads, n_updates, n_mberror);
@@ -403,9 +403,9 @@ static void gtest_stress(int nreaders, int duration)
     for (i = 0; i < 5; i++) {
         create_thread(rcu_fake_update_stress_test);
     }
-    goflag = GOFLAG_RUN;
+    qatomic_set(&goflag, GOFLAG_RUN);
     g_usleep(duration * G_USEC_PER_SEC);
-    goflag = GOFLAG_STOP;
+    qatomic_set(&goflag, GOFLAG_STOP);
     wait_all_threads();
     g_assert_cmpint(n_mberror, ==, 0);
     for (i = 2; i <= RCU_STRESS_PIPE_LEN; i++) {
-- 
2.34.1


