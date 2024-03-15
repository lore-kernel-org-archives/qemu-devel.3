Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA1CC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 12:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl6hf-0002SM-5D; Fri, 15 Mar 2024 08:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rl6hC-0002DB-PQ
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:29:58 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rl6h8-0006OV-Nb
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-Id:Date:Subject
 :From; bh=eKJQrKU9aZiOLAU3zCGqFcD6ur956gr0FfORIR7FeCE=; b=L+WpVR5ELtDahdX/XZ0
 4mNduzpPHoVPGFV6w/jlm2CFRUH/WvKabRm2ae9E7K0EeeP5kD1dd4P6T+vMRqV53BAjdnl+p66mN
 euZwGPMZx2upizrmi0YYT41685AP0tt+F2liOofQLyscC1wTOHAwcnCAon3EAfRIMwKjIF5YFiQbM
 1jUarIVVFlR4DBj7vSLeiBUszSXu8P/e2nBDj1llSVfnZ/ny0wdRaRD9iJh1dN58AAPu/SlTLBUwr
 BCuLKnzp7QZSv2PwVgNca84HLVcPklDajV2tfmEN42sdYNIBrJ6tB17Ay5PWSqlyoy1p/2cFjqzQw
 lOUxrW4rFbmR6AA==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1rl6f5-005Caf-0o;
 Fri, 15 Mar 2024 13:29:46 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v3 6/7] qga/commands-posix: don't do fork()/exec() when
 suspending via sysfs
Date: Fri, 15 Mar 2024 14:29:45 +0200
Message-Id: <20240315122946.39168-7-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240315122946.39168-1-andrey.drobyshev@virtuozzo.com>
References: <20240315122946.39168-1-andrey.drobyshev@virtuozzo.com>
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
---
 qga/commands-posix.c | 41 +++++------------------------------------
 1 file changed, 5 insertions(+), 36 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 610d225d30..e0ea377f65 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1928,52 +1928,21 @@ static bool linux_sys_state_supports_mode(SuspendMode mode, Error **errp)
 
 static void linux_sys_state_suspend(SuspendMode mode, Error **errp)
 {
-    Error *local_err = NULL;
+    GError *local_gerr = NULL;
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


