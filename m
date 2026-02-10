Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCAEEA8105
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 12:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpmga-0003Ss-8l; Tue, 10 Feb 2026 07:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmf3-0001gP-BK; Tue, 10 Feb 2026 07:16:10 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmf1-0000OT-CD; Tue, 10 Feb 2026 07:16:09 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 10371187DAE;
 Tue, 10 Feb 2026 15:13:53 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9FD78360CD0;
 Tue, 10 Feb 2026 15:14:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Aleksandr Sergeev <sergeev0xef@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.1 76/78] linux-user/syscall.c: Prevent acquiring
 clone_lock while fork()
Date: Tue, 10 Feb 2026 15:14:29 +0300
Message-ID: <20260210121438.67781-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.1-20260210151332@cover.tls.msk.ru>
References: <qemu-stable-10.2.1-20260210151332@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Aleksandr Sergeev <sergeev0xef@gmail.com>

By the spec, fork() copies only the thread which executes it.
So it may happen, what while one thread is doing a fork,
another thread is holding `clone_lock` mutex
(e.g. doing a `fork()` or `exit()`).
So the child process is born with the mutex being held,
and there are nobody to release it.

As the thread executing do_syscall() is not considered running,
start_exclusive() does not protect us from the case.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3226
Signed-off-by: Aleksandr Sergeev <sergeev0xef@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260126151612.2176451-1-sergeev0xef@gmail.com>
(cherry picked from commit d22e9aec572396836782e993cb18d598e6012688)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/main.c b/linux-user/main.c
index db751c0757..c49d1e91d2 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -145,6 +145,7 @@ unsigned long guest_stack_size = TARGET_DEFAULT_STACK_SIZE;
 void fork_start(void)
 {
     start_exclusive();
+    clone_fork_start();
     mmap_fork_start();
     cpu_list_lock();
     qemu_plugin_user_prefork_lock();
@@ -174,6 +175,7 @@ void fork_end(pid_t pid)
         cpu_list_unlock();
     }
     gdbserver_fork_end(thread_cpu, pid);
+    clone_fork_end(child);
     /*
      * qemu_init_cpu_list() reinitialized the child exclusive state, but we
      * also need to keep current_cpu consistent, so call end_exclusive() for
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fbacbaea3a..7404af9194 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6853,6 +6853,20 @@ static void *clone_func(void *arg)
     return NULL;
 }
 
+void clone_fork_start(void)
+{
+    pthread_mutex_lock(&clone_lock);
+}
+
+void clone_fork_end(bool child)
+{
+    if (child) {
+        pthread_mutex_init(&clone_lock, NULL);
+    } else {
+        pthread_mutex_unlock(&clone_lock);
+    }
+}
+
 /* do_fork() Must return host values and target errnos (unlike most
    do_*() functions). */
 static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 067c02bb93..24d35998f0 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -69,6 +69,8 @@ abi_long get_errno(abi_long ret);
 const char *target_strerror(int err);
 int get_osversion(void);
 void init_qemu_uname_release(void);
+void clone_fork_start(void);
+void clone_fork_end(bool child);
 void fork_start(void);
 void fork_end(pid_t pid);
 
-- 
2.47.3


