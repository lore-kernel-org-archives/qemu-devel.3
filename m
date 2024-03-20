Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EA1C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmycs-0007aE-Ck; Wed, 20 Mar 2024 12:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rmycc-0007TE-Ef
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:16:59 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rmyca-0003sl-FL
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-Id:Date:Subject
 :From; bh=dPDq2E1a5t3XOvJE0MnFN0/zcRmXvO+hIToGf+t3lWI=; b=lr8sSaRGV+4pb/p4N4I
 2sCsYZF+AcobbJA9SbZvZ1xwGY26NxymFHU7Yox68qHw+HOsba3sAHnA6Obbtm3JT4K2W1HHrELfc
 JqITv6ZWXQIoOLzqM8xlj3paq3Lq6TI9OGAQ52HoQn3XiCECl7MKjx/3UoVPMrId1Hw6dTQmS0J/B
 r0U5qQo51kyBEoe8IeICl+BwO8jIs363FQUengmv3rd/DfvYbWS1e1jVL158Ow4kmBrcRjlcZiY56
 wk0v4pk0FDYjKjtHc+NOOgYehb7uSi5yxBGz3gVnkAtdFZae+w/k0SKvv61A1l44RUdRog86dUCt7
 ar1HplfhfQdr3Mw==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1rmyaM-006TNN-2R;
 Wed, 20 Mar 2024 17:16:38 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v4 6/7] qga/commands-posix: don't do fork()/exec() when
 suspending via sysfs
Date: Wed, 20 Mar 2024 18:16:47 +0200
Message-Id: <20240320161648.158226-7-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240320161648.158226-1-andrey.drobyshev@virtuozzo.com>
References: <20240320161648.158226-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Since commit 246d76eba ("qga: guest_suspend: decoupling pm-utils and sys
logic") pm-utils logic is running in a separate child from the sysfs
logic.  Now when suspending via sysfs we don't really need to do that in
a separate process as we only need to perform one write to /sys/power/state.

Let's just use g_file_set_contents() to simplify things here.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/commands-posix.c | 41 +++++------------------------------------
 1 file changed, 5 insertions(+), 36 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 9b993772f5..9910957ff5 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1928,52 +1928,21 @@ static bool linux_sys_state_supports_mode(SuspendMode mode, Error **errp)
 
 static void linux_sys_state_suspend(SuspendMode mode, Error **errp)
 {
-    Error *local_err = NULL;
+    g_autoptr(GError) local_gerr = NULL;
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
-
-    ga_wait_child(pid, &status, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!g_file_set_contents(LINUX_SYS_STATE_FILE, sysfile_str,
+                             -1, &local_gerr)) {
+        error_setg(errp, "suspend: cannot write to '%s': %s",
+                   LINUX_SYS_STATE_FILE, local_gerr->message);
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


