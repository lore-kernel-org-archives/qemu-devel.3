Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EB0CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXbC-0002Tb-EQ; Fri, 22 May 2026 17:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXaw-00015D-K1; Fri, 22 May 2026 17:39:54 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXau-0002yL-OP; Fri, 22 May 2026 17:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485683; bh=kBVhGhz/+qRjiAGKSIr8cCYc1RoITfOAx3YapVSC5rc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZI5UAhgdXMFpV+Yf4RStZSslXFa3wuu2lRDLwLhBVJcOXMR4H9FXKFh963LeYeqMb
 56ZulqzHLM/9AtvlP4sFGJ7QkiXE0StJGZnx4FFjzFQWazptqoMf+yoDueAs0S6lnl
 ICFAauRwRtjtrjWkl7ddxuiuc90f/9xQ8fjZTAgD/418epPgQ+JqaYOCA6LkInKN6B
 q52SzhH1Lk0suUcQHwOXTXzT4j/fm+mjOxOH8ZWIVVS2v+J1PnOIQzqmH1auRhA6dD
 TGKmHQ6bDg9gNwW4GIHF+Qu4A1j5RyfE2wNR9OZpD0VgaEh5NRmUdvEx0HsooDsKXB
 QC6Cux176f/Lw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7BA331AFB0A;
 Sat, 23 May 2026 00:34:43 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A0CF43B718A;
 Sat, 23 May 2026 00:34:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 121/136] linux-user: Fix AT_EXECFN in AUXV for
 symlinked programs
Date: Sat, 23 May 2026 00:34:29 +0300
Message-ID: <20260522213446.806182-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260522213601@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260522213601@cover.tls.msk.ru>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Helge Deller <deller@gmx.de>

The AT_EXECFN entry in AUXV needs to keep the value which was used when
the program was started. Especially for symlinked programs qemu should
not try to resolve the realpath.

Here is a reproducer:
(arm64-chroot)root@p100:/# cd /usr/bin
(arm64-chroot)root@p100:/usr/bin# ln -s echo testprog
(arm64-chroot)root@p100:/usr/bin# LD_SHOW_AUXV=1 ./testprog | grep AT_EXECFN
AT_EXECFN:            ./testprog

In this example, "./testprog" is the correct output, and not "/usr/bin/echo".

This patch fixes parts of commit 258bec39 ("linux-user: Fix access to
/proc/self/exe").

Fixes: 258bec39 ("linux-user: Fix access to /proc/self/exe")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3379
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 6b5aef7cac9dab7c16451588cff6615eb2048293)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/main.c b/linux-user/main.c
index 57fc568e72..7a8acf0cc1 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -791,8 +791,10 @@ int main(int argc, char **argv, char **envp)
     }
 
     /* Resolve executable file name to full path name */
-    if (realpath(exec_path, real_exec_path)) {
-        exec_path = real_exec_path;
+    /* Keep how we started the program in exec_path, e.g. "./my_program" */
+    /* Store real path in real_exec_path, e.g. "/usr/local/bin/my_program" */
+    if (!realpath(exec_path, real_exec_path)) {
+        printf("Could not resolve %s\n", exec_path);
     }
 
     /*
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b6c57dbd07..9204dc64ad 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8661,9 +8661,9 @@ static int maybe_do_fake_open(CPUArchState *cpu_env, int dirfd,
             return -1;
         }
         if (safe) {
-            return safe_openat(dirfd, exec_path, flags, mode);
+            return safe_openat(dirfd, real_exec_path, flags, mode);
         } else {
-            return openat(dirfd, exec_path, flags, mode);
+            return openat(dirfd, real_exec_path, flags, mode);
         }
     }
 
@@ -8796,9 +8796,9 @@ ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz)
          * Don't worry about sign mismatch as earlier mapping
          * logic would have thrown a bad address error.
          */
-        ret = MIN(strlen(exec_path), bufsiz);
+        ret = MIN(strlen(real_exec_path), bufsiz);
         /* We cannot NUL terminate the string. */
-        memcpy(buf, exec_path, ret);
+        memcpy(buf, real_exec_path, ret);
     } else {
         ret = readlink(path(pathname), buf, bufsiz);
     }
@@ -8889,7 +8889,7 @@ static int do_execv(CPUArchState *cpu_env, int dirfd,
 
     const char *exe = p;
     if (is_proc_myself(p, "exe")) {
-        exe = exec_path;
+        exe = real_exec_path;
     }
     ret = is_execveat
         ? safe_execveat(dirfd, exe, argp, envp, flags)
@@ -10805,9 +10805,9 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
                  * Don't worry about sign mismatch as earlier mapping
                  * logic would have thrown a bad address error.
                  */
-                ret = MIN(strlen(exec_path), arg4);
+                ret = MIN(strlen(real_exec_path), arg4);
                 /* We cannot NUL terminate the string. */
-                memcpy(p2, exec_path, ret);
+                memcpy(p2, real_exec_path, ret);
             } else {
                 ret = get_errno(readlinkat(arg1, path(p), p2, arg4));
             }
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 02872a98d5..792bbb271a 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -23,6 +23,7 @@
 #include "qemu/log.h"
 
 extern char *exec_path;
+extern char real_exec_path[PATH_MAX];
 void init_task_state(TaskState *ts);
 void task_settid(TaskState *);
 void stop_all_tasks(void);
-- 
2.47.3


