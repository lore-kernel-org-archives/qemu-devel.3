Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18318CCFA13
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 11:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIltq-0008GJ-4i; Fri, 01 May 2026 07:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wIltn-0008Fi-HM
 for qemu-devel@nongnu.org; Fri, 01 May 2026 07:19:11 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wIltl-0005rO-RU
 for qemu-devel@nongnu.org; Fri, 01 May 2026 07:19:11 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9DA6E6011F;
 Fri,  1 May 2026 11:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B578C2BCB4;
 Fri,  1 May 2026 11:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777634340;
 bh=gonc7RCHdVYjcEQb8ak4HONl3LWUpKP3jqs5xJvEy9o=;
 h=From:To:Cc:Subject:Date:From;
 b=uz3Dx0PteJkt2K5Qg5MQ9P09zMaJe74+V+D8nGmNCN7Hid2aWmB24Qf+hkcPjZKa4
 uIGFUIuAUwb/Gql6xQ6pzN1Pf6e/e9fFLo+bUbj8wLFjuJBswiAEPwgre4W8GPZVV0
 NUdxwPeHZWwp+VaAzHTtCYNiRWbyeczZNDGNTcM1lhxZXSvtvrDEU+UhOrVHz+zV77
 9sqj8FEKbWBjU/9KtHsc+sk5CUootQ16w89iY8eXCbzSJKw04gbsXhKGO3YzXYHf0C
 Xrt1DgTAiraKc0BAmFwf0nEbbtC6aTOTD9Mo8p+1eTG5f7xFT9JEYK2wcuTkxCm4LM
 8beRK5lh6HeJA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH] linux-user: Fix AT_EXECFN in AUXV for symlinked programs
Date: Fri,  1 May 2026 13:18:54 +0200
Message-ID: <20260501111854.15674-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
---
 linux-user/main.c           |  6 ++++--
 linux-user/syscall.c        | 14 +++++++-------
 linux-user/user-internals.h |  1 +
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 86d04cca3c..c08c73fd80 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -772,8 +772,10 @@ int main(int argc, char **argv, char **envp)
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
index d3d9fffb54..65bbeb8551 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8790,9 +8790,9 @@ static int maybe_do_fake_open(CPUArchState *cpu_env, int dirfd,
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
 
@@ -8929,9 +8929,9 @@ ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz)
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
@@ -9022,7 +9022,7 @@ static int do_execv(CPUArchState *cpu_env, int dirfd,
 
     const char *exe = p;
     if (is_proc_myself(p, "exe")) {
-        exe = exec_path;
+        exe = real_exec_path;
     }
     ret = is_execveat
         ? safe_execveat(dirfd, exe, argp, envp, flags)
@@ -11033,9 +11033,9 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
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
index 24d35998f0..7730444aa5 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -24,6 +24,7 @@
 #include "exec/translation-block.h"
 
 extern char *exec_path;
+extern char real_exec_path[PATH_MAX];
 void init_task_state(TaskState *ts);
 void task_settid(TaskState *);
 void stop_all_tasks(void);
-- 
2.53.0


