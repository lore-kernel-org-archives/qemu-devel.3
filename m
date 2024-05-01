Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65096C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 07:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s24d8-0000pw-Fq; Wed, 01 May 2024 03:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s24d7-0000pm-Ls
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:43:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s24d5-0003Xs-PE
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714549431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qcSvdu/9ifEVQ6HZsFa7vRWpP1PMefXiZ5wn5zNky6I=;
 b=DeRZZ00l/odTCDHyDgPfNeVHrtnU7f1Idux3I3vfX4KuP+iYqq5Bg5gwehNClVlplw7VtR
 qFUlKcaVQs/lT1bhSuQZWEIppcigmlF5rHfcGtu2jIUi1+yuyu2hPa0E8bMDH0iKnUZViG
 wNiI5PiD096++YEs7WrhcNHpJZ+jPyg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-RlRvHKZ-OuC-Ct4u-34Ihg-1; Wed,
 01 May 2024 03:43:46 -0400
X-MC-Unique: RlRvHKZ-OuC-Ct4u-34Ihg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB3641C0513D;
 Wed,  1 May 2024 07:43:45 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3F1C40BAA2;
 Wed,  1 May 2024 07:43:44 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 2/9] qga: introduce ga_run_command() helper for guest cmd
 execution
Date: Wed,  1 May 2024 10:43:33 +0300
Message-ID: <20240501074340.19641-3-kkostiuk@redhat.com>
In-Reply-To: <20240501074340.19641-1-kkostiuk@redhat.com>
References: <20240501074340.19641-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

When executing guest commands in *nix environment, we repeat the same
fork/exec pattern multiple times.  Let's just separate it into a single
helper which would also be able to feed input data into the launched
process' stdin.  This way we can avoid code duplication.

To keep the history more bisectable, let's replace qmp commands
implementations one by one.  Also add G_GNUC_UNUSED attribute to the
helper and remove it in the next commit.

Originally-by: Yuri Pudgorodskiy <yur@virtuozzo.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/r/20240320161648.158226-3-andrey.drobyshev@virtuozzo.com
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-posix.c | 150 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 7df2d72e9f..9b1bdf194c 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -76,6 +76,156 @@ static void ga_wait_child(pid_t pid, int *status, Error **errp)
     g_assert(rpid == pid);
 }
 
+static ssize_t ga_pipe_read_str(int fd[2], char **str)
+{
+    ssize_t n, len = 0;
+    char buf[1024];
+
+    close(fd[1]);
+    fd[1] = -1;
+    while ((n = read(fd[0], buf, sizeof(buf))) != 0) {
+        if (n < 0) {
+            if (errno == EINTR) {
+                continue;
+            } else {
+                len = -errno;
+                break;
+            }
+        }
+        *str = g_realloc(*str, len + n + 1);
+        memcpy(*str + len, buf, n);
+        len += n;
+        *str[len] = '\0';
+    }
+    close(fd[0]);
+    fd[0] = -1;
+
+    return len;
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
+    ssize_t len = 0;
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
+    len = ga_pipe_read_str(outfd, &str);
+    if (len < 0) {
+        error_setg_errno(errp, -len, "%s: cannot read from stdout/stderr pipe",
+                         action);
+        goto out;
+    }
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
2.44.0


