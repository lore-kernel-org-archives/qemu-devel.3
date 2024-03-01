Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3F2C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6h2-0003n1-Av; Fri, 01 Mar 2024 12:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rg6h0-0003mL-Fe
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:29:06 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rg6gx-0005d3-Ve
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=B+XurtnpYoJZP5kVIIxzoSwbJmwbE81ygmsZxH5LmXM=; b=HgMHYh9tec3s
 unHYZogQn7vprxNDBv7Lda4bGPTU0l5JKhVGD4QIRGZeFUrtx9A9hXN/xyZyx/3VZ3Gnlh4dhUZn0
 SNAgRV/lWzU7ayz5BC5QNCr1iQ1qTIV4kywmbFhBEDH/FLN2Ss2/8Z1DdzSKfbH9eqK3C8DQpwsGl
 LxASjS4U1CH8RGBHASbsiT2uBKmhmpHcBibQhdKsds+YuwO7fs3/9FQOv13sn67ShRPIqzrps+QBC
 /C8IP4txM49zhwYGtwyqtpYZ5kqVTVt45QQNA+ZltfNgct5RL0Q+x/1+Now/9MXBRM//+3Yv6jDte
 qbkiwAQcYAYuZWpH0kC1GA==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1rg6fM-0022sZ-1U;
 Fri, 01 Mar 2024 18:28:57 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, kkostiuk@redhat.com, marcandre.lureau@redhat.com,
 philmd@linaro.org, andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 6/7] qga/commands-posix: use ga_run_command helper when
 suspending via sysfs
Date: Fri,  1 Mar 2024 19:28:57 +0200
Message-Id: <20240301172858.665135-7-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240301172858.665135-1-andrey.drobyshev@virtuozzo.com>
References: <20240301172858.665135-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We replace the direct call to open() with a "sh -c 'echo ...'" call, so
that it becomes an executable command.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 qga/commands-posix.c | 36 ++++--------------------------------
 1 file changed, 4 insertions(+), 32 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index dd2a7ad2e6..f3f4a05e2d 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1921,49 +1921,21 @@ static void linux_sys_state_suspend(SuspendMode mode, Error **errp)
     Error *local_err = NULL;
     const char *sysfile_strs[3] = {"disk", "mem", NULL};
     const char *sysfile_str = sysfile_strs[mode];
-    pid_t pid;
-    int status;
 
     if (!sysfile_str) {
         error_setg(errp, "unknown guest suspend mode");
         return;
     }
 
-    pid = fork();
-    if (!pid) {
-        /* child */
-        int fd;
-
-        setsid();
-        reopen_fd_to_null(0);
-        reopen_fd_to_null(1);
-        reopen_fd_to_null(2);
-
-        fd = open(LINUX_SYS_STATE_FILE, O_WRONLY);
-        if (fd < 0) {
-            _exit(EXIT_FAILURE);
-        }
-
-        if (write(fd, sysfile_str, strlen(sysfile_str)) < 0) {
-            _exit(EXIT_FAILURE);
-        }
-
-        _exit(EXIT_SUCCESS);
-    } else if (pid < 0) {
-        error_setg_errno(errp, errno, "failed to create child process");
-        return;
-    }
+    g_autofree char *echo_cmd = g_strdup_printf(
+        "echo %s > " LINUX_SYS_STATE_FILE, sysfile_str);
+    const char *argv[] = {"sh", "-c", echo_cmd, NULL};
 
-    ga_wait_child(pid, &status, &local_err);
+    ga_run_command(argv, NULL, "suspend", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
-
-    if (WEXITSTATUS(status)) {
-        error_setg(errp, "child process has failed to suspend");
-    }
-
 }
 
 static void guest_suspend(SuspendMode mode, Error **errp)
-- 
2.39.3


