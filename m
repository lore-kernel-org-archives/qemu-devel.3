Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DAE606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H77bIdoh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjWj-00087e-O3; Tue, 27 Oct 2026 11:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xLjWa-00086L-J9
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:55:45 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xLjWX-0005aI-LT
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:55:43 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F32C60219;
 Tue, 27 Oct 2026 15:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3B11F031E3;
 Tue, 27 Oct 2026 15:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793116533;
 bh=yRw4GZUuOUp8HRjWU6tIX56Qk4m0IW3baJENpWMjjKA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=H77bIdohXCfwoD4yTndJb/H+/2KWwW8B12y9Var0tA8VET1Vvc82bEV1qmWM8Aodw
 1cZx4dhXpOkmLTuSFd4QguufAxzjc+X6oeW3btDGZj05F9nMHyc2snMq2jxKjHATVE
 /5zisu5Hw66y2KL6eF7mB6HLxHgw52rtEYDXsybTTYAd+l6k3znc3eTxmK5T64WUM2
 GvSZI8KmvHhwJUeF8qIPzCYuo9br66NcGDg1Tzz414bJn1QKS+Upiuo+rV5TiS2Aqc
 UPvmKIPEDWFdJTrPaDOveE8ZHhu6XMNCAItGq0FXBOr+oGWHOnzii69N7hccOiHnu2
 P1seMXBcYKpgQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/2] linux-user: Use QemuSemaphore to wait for clone child
 thread
Date: Tue, 27 Oct 2026 16:55:28 +0100
Message-ID: <20261027155528.5040-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027155528.5040-1-deller@kernel.org>
References: <20261027155528.5040-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


