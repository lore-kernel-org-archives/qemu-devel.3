Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80590C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeI0-0005ec-1S; Mon, 26 Feb 2024 11:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1reeHl-0005XZ-Ck
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:57:01 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1reeHX-0007aL-LW
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=r5CvpnosciMvnPjJjGTldJRMDdV43tlw4uH7/lKch6E=; b=dtlyLU6FeP4B
 qx8qFI0H+B8T5/zLRuIcSt0qlRAoJwlJYYoBxHu3JBoY0X3B1Mccm8RDfKO7mp7gNwcX4h1NmrxB6
 gf03183uaQDFbd5cPqhoKHyRErVtaEq0AGe1ztQhnp6Nti1YF/S/bj7BovzdUn+ffQ+3E18a4MXZw
 L8RrgwL2XF/gzRvXRMUPQZQ0vzH0llTL0sbu9v9JhbUtHRtuuTlml+lyLzrs51er908dSDCsDVghd
 S6MkXce1pa+0CewqIw5ZCMPgjkHkmhXFCU68mzr0LqNOLInvQZq0NJY3uDMtQpf45GnAa8L0mz2ha
 jxVEo8b6tRc1vZWSsBUkxA==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1reeG3-001AD7-0t;
 Mon, 26 Feb 2024 17:56:34 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, kkostiuk@redhat.com, marcandre.lureau@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH 6/7] qga/commands-posix: use ga_run_command helper when
 suspending via sysfs
Date: Mon, 26 Feb 2024 18:56:41 +0200
Message-Id: <20240226165642.807350-7-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240226165642.807350-1-andrey.drobyshev@virtuozzo.com>
References: <20240226165642.807350-1-andrey.drobyshev@virtuozzo.com>
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
index 6baaabc29e..599f59a323 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1917,49 +1917,21 @@ static void linux_sys_state_suspend(SuspendMode mode, Error **errp)
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


