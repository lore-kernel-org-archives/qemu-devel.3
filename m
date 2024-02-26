Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDA3C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeHp-0005Zk-7U; Mon, 26 Feb 2024 11:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1reeHl-0005XP-84
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:57:01 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1reeHX-0007aK-4k
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=fW7rtp0/UXuP9tIVplL8g9pjh+RyEaa4l4hEMmcNHFA=; b=nkY4k8MS0xF8
 r4MB6ZHqkaB9xTq8bPvnwlDWesqsfW2ddsyVyZ3aQ4DyQuzL+MGj0qyIsQD9FytrKx+aeYqCEmXoz
 6DMwxBwzdAapfcJbnBo/Ct7od0MTyBn/mHirqg/bzrvXEarfT4u4RiUxEV1J8c3qRroACuDM4+E0y
 eqdJpvipc4dQZDWJUahje0Z07HFIsaMB6MQZWB3NQTdkZw21fyhp547R9gz+U+OKAfHPLpyOhfZ88
 PIKNjoG5RITg5IHVFnfqpaEkjQuErHv9k7VE4iSaULjVtXMVhsoBZijpxp2w62WZFROVbkWrGDTkJ
 HCSRwIOzK+HzXaFZeOcsUw==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1reeG3-001AD7-0C;
 Mon, 26 Feb 2024 17:56:34 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, kkostiuk@redhat.com, marcandre.lureau@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH 2/7] qga: introduce ga_run_command() helper for guest cmd
 execution
Date: Mon, 26 Feb 2024 18:56:37 +0200
Message-Id: <20240226165642.807350-3-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240226165642.807350-1-andrey.drobyshev@virtuozzo.com>
References: <20240226165642.807350-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When executing guest commands in *nix environment, we repeat the same
fork/exec pattern multiple times.  Let's just separate it into a single
helper which would also be able to feed input data into the launched
process' stdin.  This way we can avoid code duplication.

To keep the history more bisectable, let's replace qmp commands
implementations one by one.  Also add G_GNUC_UNUSED attribute to the
helper and remove it in the next commit.

Originally-by: Yuri Pudgorodskiy <yur@virtuozzo.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 qga/commands-posix.c | 140 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 752ef509d0..510b902b1a 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -76,6 +76,146 @@ static void ga_wait_child(pid_t pid, int *status, Error **errp)
     g_assert(rpid == pid);
 }
 
+static void ga_pipe_read_str(int fd[2], char **str, size_t *len)
+{
+    ssize_t n;
+    char buf[1024];
+    close(fd[1]);
+    fd[1] = -1;
+    while ((n = read(fd[0], buf, sizeof(buf))) != 0) {
+        if (n < 0) {
+            if (errno == EINTR) {
+                continue;
+            } else {
+                break;
+            }
+        }
+        *str = g_realloc(*str, *len + n);
+        memcpy(*str + *len, buf, n);
+        *len += n;
+    }
+    close(fd[0]);
+    fd[0] = -1;
+}
+
+/*
+ * Helper to run command with input/output redirection,
+ * sending string to stdin and taking error message from
+ * stdout/err.
+ */
+G_GNUC_UNUSED
+static int ga_run_command(const char *argv[], const char *in_str,
+                          const char *action, Error **errp)
+{
+    pid_t pid;
+    int status;
+    int retcode = -1;
+    int infd[2] = { -1, -1 };
+    int outfd[2] = { -1, -1 };
+    char *str = NULL;
+    size_t len = 0;
+
+    if ((in_str && !g_unix_open_pipe(infd, FD_CLOEXEC, NULL)) ||
+        !g_unix_open_pipe(outfd, FD_CLOEXEC, NULL)) {
+        error_setg(errp, "cannot create pipe FDs");
+        goto out;
+    }
+
+    pid = fork();
+    if (pid == 0) {
+        char *cherr = NULL;
+
+        setsid();
+
+        if (in_str) {
+            /* Redirect stdin to infd. */
+            close(infd[1]);
+            dup2(infd[0], 0);
+            close(infd[0]);
+        } else {
+            reopen_fd_to_null(0);
+        }
+
+        /* Redirect stdout/stderr to outfd. */
+        close(outfd[0]);
+        dup2(outfd[1], 1);
+        dup2(outfd[1], 2);
+        close(outfd[1]);
+
+        execvp(argv[0], (char *const *)argv);
+
+        /* Write the cause of failed exec to pipe for the parent to read it. */
+        cherr = g_strdup_printf("failed to exec '%s'", argv[0]);
+        perror(cherr);
+        g_free(cherr);
+        _exit(EXIT_FAILURE);
+    } else if (pid < 0) {
+        error_setg_errno(errp, errno, "failed to create child process");
+        goto out;
+    }
+
+    if (in_str) {
+        close(infd[0]);
+        infd[0] = -1;
+        if (qemu_write_full(infd[1], in_str, strlen(in_str)) !=
+                strlen(in_str)) {
+            error_setg_errno(errp, errno, "%s: cannot write to stdin pipe",
+                             action);
+            goto out;
+        }
+        close(infd[1]);
+        infd[1] = -1;
+    }
+
+    ga_pipe_read_str(outfd, &str, &len);
+
+    ga_wait_child(pid, &status, errp);
+    if (*errp) {
+        goto out;
+    }
+
+    if (!WIFEXITED(status)) {
+        if (len) {
+            error_setg(errp, "child process has terminated abnormally: %s",
+                       str);
+        } else {
+            error_setg(errp, "child process has terminated abnormally");
+        }
+        goto out;
+    }
+
+    retcode = WEXITSTATUS(status);
+
+    if (WEXITSTATUS(status)) {
+        if (len) {
+            error_setg(errp, "child process has failed to %s: %s",
+                       action, str);
+        } else {
+            error_setg(errp, "child process has failed to %s: exit status %d",
+                       action, WEXITSTATUS(status));
+        }
+        goto out;
+    }
+
+out:
+    g_free(str);
+
+    if (infd[0] != -1) {
+        close(infd[0]);
+    }
+    if (infd[1] != -1) {
+        close(infd[1]);
+    }
+    if (outfd[0] != -1) {
+        close(outfd[0]);
+    }
+    if (outfd[1] != -1) {
+        close(outfd[1]);
+    }
+
+    return retcode;
+}
+
 void qmp_guest_shutdown(const char *mode, Error **errp)
 {
     const char *shutdown_flag;
-- 
2.39.3


