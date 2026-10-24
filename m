Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F41606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=monEsnZW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKiKK-0005k9-M5; Sat, 24 Oct 2026 16:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xKiKG-0005iN-Es
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 16:26:48 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xKiKE-0006dt-RD
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 16:26:48 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C6A01600D4;
 Sat, 24 Oct 2026 20:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646B41F01825;
 Sat, 24 Oct 2026 20:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792873598;
 bh=yRw4GZUuOUp8HRjWU6tIX56Qk4m0IW3baJENpWMjjKA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=monEsnZW9UxuGp2fqKxRq3u0ro53n6p8OqLyDq0wY4uKCoiO4itLzam79Y8UwbLNq
 MeFINfa50hTwyUoJAJ09lOJB7UenYm0oXKN6EQ+biaWAVvC51MDETYYilL/kWiyeN8
 Gx9nF4lrPtKOJNNfVkFtVC9osCSsRplwiW3OYYvHRn5bOI8ou/rVda4w/qHuRQ9Ze7
 y3gw4HVfiAqacBPFBkOGamCra2MLdW8221p1Ram8nag0vAI2qDqeY/JGMoGracNjgy
 qgyQJqkcnZagu34lCBkaCjT9jnwG4Ef7b435CmGML94rP7Br1g0CyRJihbMtO4fDEI
 OVWip6bwmHWDw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 2/2] linux-user: Use QemuSemaphore to wait for clone child
 thread
Date: Sat, 24 Oct 2026 22:26:32 +0200
Message-ID: <20261024202632.103711-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261024202632.103711-1-deller@kernel.org>
References: <20261024202632.103711-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
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
---
 linux-user/syscall.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0380691a8b..9d85a193ef 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6932,8 +6932,7 @@ static abi_long do_map_shadow_stack(CPUArchState *env, abi_ulong addr,
 static pthread_mutex_t clone_lock = PTHREAD_MUTEX_INITIALIZER;
 typedef struct {
     CPUArchState *env;
-    pthread_mutex_t mutex;
-    pthread_cond_t cond;
+    QemuSemaphore sem;
     pthread_t thread;
     uint32_t tid;
     abi_ulong child_tidptr;
@@ -6964,9 +6963,7 @@ static void *clone_func(void *arg)
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
@@ -7071,9 +7068,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         }
 
         memset(&info, 0, sizeof(info));
-        pthread_mutex_init(&info.mutex, NULL);
-        pthread_mutex_lock(&info.mutex);
-        pthread_cond_init(&info.cond, NULL);
+        qemu_sem_init(&info.sem, 0);
         info.env = new_env;
         if (flags & CLONE_CHILD_SETTID) {
             info.child_tidptr = child_tidptr;
@@ -7097,7 +7092,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         pthread_attr_destroy(&attr);
         if (ret == 0) {
             /* Wait for the child to initialize.  */
-            pthread_cond_wait(&info.cond, &info.mutex);
+            qemu_sem_wait(&info.sem);
             ret = info.tid;
         } else {
             errno = ret;
@@ -7111,9 +7106,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
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
2.54.0


