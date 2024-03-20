Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A78DC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmyd8-0007ph-DS; Wed, 20 Mar 2024 12:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rmycc-0007TI-Sq
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:16:59 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rmyca-0003sq-B6
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-Id:Date:Subject
 :From; bh=PZWTqNmbKcfjj26fmVmiN5H+88Z5Ziac/wIPJxHChJw=; b=aXfLkrALii7UgOWYLU0
 TmEKA5GPZy9LpUtLaw37T0awqbmtFpjlLaCFPEw273MEtGOTNaWaVmkNeMfrwygRKFbWdmJg1QKzX
 1g6bDbjkZ8NLOzonD1FkBqmW7fDM+LNLhChu8mToJVfHmoe8lFfz7MY13cwI6IcW/X6Ba/WS8SVP3
 8yREfM/DJ0ybdHUlAC17EvfUhEh+hQc0RBnKo3bk+mWg9B/ZXprrWf3e7SM9zFbyuepf5Ftxf6S/J
 XSVqkUg5Ja0Jz7WDKbwMl8ASSJsT0wCDoGeIEcC4aB4TqzPyKpd2qkX1/ZMAwdXUSa6Y/hT3tPBeR
 EWLSLmw7YbeZKTA==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1rmyaM-006TNN-1u;
 Wed, 20 Mar 2024 17:16:37 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v4 3/7] qga/commands-posix: qmp_guest_shutdown: use
 ga_run_command helper
Date: Wed, 20 Mar 2024 18:16:44 +0200
Message-Id: <20240320161648.158226-4-andrey.drobyshev@virtuozzo.com>
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

Also remove the G_GNUC_UNUSED attribute added in the previous commit from
the helper.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/commands-posix.c | 39 ++++++---------------------------------
 1 file changed, 6 insertions(+), 33 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 9b1bdf194c..cb9eed9a0b 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -108,7 +108,6 @@ static ssize_t ga_pipe_read_str(int fd[2], char **str)
  * sending string to stdin and taking error message from
  * stdout/err.
  */
-G_GNUC_UNUSED
 static int ga_run_command(const char *argv[], const char *in_str,
                           const char *action, Error **errp)
 {
@@ -230,8 +229,6 @@ void qmp_guest_shutdown(const char *mode, Error **errp)
 {
     const char *shutdown_flag;
     Error *local_err = NULL;
-    pid_t pid;
-    int status;
 
 #ifdef CONFIG_SOLARIS
     const char *powerdown_flag = "-i5";
@@ -260,46 +257,22 @@ void qmp_guest_shutdown(const char *mode, Error **errp)
         return;
     }
 
-    pid = fork();
-    if (pid == 0) {
-        /* child, start the shutdown */
-        setsid();
-        reopen_fd_to_null(0);
-        reopen_fd_to_null(1);
-        reopen_fd_to_null(2);
-
+    const char *argv[] = {"/sbin/shutdown",
 #ifdef CONFIG_SOLARIS
-        execl("/sbin/shutdown", "shutdown", shutdown_flag, "-g0", "-y",
-              "hypervisor initiated shutdown", (char *)NULL);
+                          shutdown_flag, "-g0", "-y",
 #elif defined(CONFIG_BSD)
-        execl("/sbin/shutdown", "shutdown", shutdown_flag, "+0",
-               "hypervisor initiated shutdown", (char *)NULL);
+                          shutdown_flag, "+0",
 #else
-        execl("/sbin/shutdown", "shutdown", "-h", shutdown_flag, "+0",
-               "hypervisor initiated shutdown", (char *)NULL);
+                          "-h", shutdown_flag, "+0",
 #endif
-        _exit(EXIT_FAILURE);
-    } else if (pid < 0) {
-        error_setg_errno(errp, errno, "failed to create child process");
-        return;
-    }
+                          "hypervisor initiated shutdown", (char *) NULL};
 
-    ga_wait_child(pid, &status, &local_err);
+    ga_run_command(argv, NULL, "shutdown", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
 
-    if (!WIFEXITED(status)) {
-        error_setg(errp, "child process has terminated abnormally");
-        return;
-    }
-
-    if (WEXITSTATUS(status)) {
-        error_setg(errp, "child process has failed to shutdown");
-        return;
-    }
-
     /* succeeded */
 }
 
-- 
2.39.3


