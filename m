Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EA5606A329
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=T8F6qXu5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3HS-00054o-IM; Mon, 16 Nov 2026 15:26:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3HK-0004H8-SK; Mon, 16 Nov 2026 15:26:15 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3HI-0006al-Rs; Mon, 16 Nov 2026 15:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860763; bh=vZ1yNF187w1NMqc55HeWMH6hACkNORuX2Q3DFATVDrA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=T8F6qXu5nB6WSXJUjoaIqMa/sJWtzJmvw8TCT4/AaQjiphYga24xWuzt+UuL+XRmq
 JH7NgICHuc3vdInH87RXvvh70tBjr5wMoBIoTB9eM+LDsXH2Yk663VGTU2xLwMrsbX
 5fMWduQEuRDGVpwOOSdXGEXYAOEgOsi/2HG7v+UIpN5/BvzolWD/uqQXEEqvXJUs3M
 JNJdJeBHFeA0HfAdj+z2cvxgsnB0eg2vbwqSObaMKhgttQ4/csZuXrINvJGxIYywaD
 oxPQJaCjycs1gXlXyqAHWhxy+INsnPWn6FUQTd9LgL7O6Ggw4+GHo4d+aEVV+q/Qnh
 9EeyMp0BiXIxQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9A2CB1E719A;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9524845FBC6;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7789AB8E50; Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 05/63] linux-user: Use QemuSemaphore to wait for clone
 child thread
Date: Mon, 16 Nov 2026 23:24:44 +0300
Message-ID: <20261116202554.535325-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

In do_fork() and clone_func() we currently use a pthread_mutex_t and
a pthread_cond_t to allow the parent thread to wait until the child
thread has started and e.g.  set fields like info->tid, before the
parent reads those fields and otherwise proceeds.

Coverity points out that this use of a pthread condition variable
isn't reliable: pthread_cond_wait() may wake up spuriously, so the
idiom for "wait on a condition" should be "loop around calling
pthread_cond_wait() until a predicate that was updated by the caller
of pthread_cond_broadcast() is true".

This is quite old code; rather than fixing up its use of raw pthread
condition variables, we can use a QemuSemaphore.  This gives us the
"thread A waits until thread B signals it" semantics we want.  (Under
the hood it is implemented with a mutex and condition variable.)

Cc: qemu-stable@nongnu.org
Resolves: CID 1527417
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 2b1b98f003325761b839b4bbd5af653416d05f72)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9f454502cb6..5343bea0f87 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6919,8 +6919,7 @@ static abi_long do_map_shadow_stack(CPUArchState *env, abi_ulong addr,
 static pthread_mutex_t clone_lock = PTHREAD_MUTEX_INITIALIZER;
 typedef struct {
     CPUArchState *env;
-    pthread_mutex_t mutex;
-    pthread_cond_t cond;
+    QemuSemaphore sem;
     pthread_t thread;
     uint32_t tid;
     abi_ulong child_tidptr;
@@ -6951,9 +6950,7 @@ static void *clone_func(void *arg)
     /* Enable signals.  */
     sigprocmask(SIG_SETMASK, &info->sigmask, NULL);
     /* Signal to the parent that we're ready.  */
-    pthread_mutex_lock(&info->mutex);
-    pthread_cond_broadcast(&info->cond);
-    pthread_mutex_unlock(&info->mutex);
+    qemu_sem_post(&info->sem);
     /* Wait until the parent has finished initializing the tls state.  */
     pthread_mutex_lock(&clone_lock);
     pthread_mutex_unlock(&clone_lock);
@@ -7058,9 +7055,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         }
 
         memset(&info, 0, sizeof(info));
-        pthread_mutex_init(&info.mutex, NULL);
-        pthread_mutex_lock(&info.mutex);
-        pthread_cond_init(&info.cond, NULL);
+        qemu_sem_init(&info.sem, 0);
         info.env = new_env;
         if (flags & CLONE_CHILD_SETTID) {
             info.child_tidptr = child_tidptr;
@@ -7084,7 +7079,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         pthread_attr_destroy(&attr);
         if (ret == 0) {
             /* Wait for the child to initialize.  */
-            pthread_cond_wait(&info.cond, &info.mutex);
+            qemu_sem_wait(&info.sem);
             ret = info.tid;
         } else {
             errno = ret;
@@ -7098,9 +7093,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
 #endif
             g_free(ts);
         }
-        pthread_mutex_unlock(&info.mutex);
-        pthread_cond_destroy(&info.cond);
-        pthread_mutex_destroy(&info.mutex);
+        qemu_sem_destroy(&info.sem);
         pthread_mutex_unlock(&clone_lock);
     } else {
         /* if no CLONE_VM, we consider it is a fork */
-- 
2.47.3


