Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009ADC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmyd9-0007uI-7f; Wed, 20 Mar 2024 12:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rmycc-0007TH-SA
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:16:59 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rmyca-0003sr-GD
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-Id:Date:Subject
 :From; bh=J5GA2ToeZpS4Nt6uAUdq29B5O4s8bwbyayEo8FiUTnc=; b=FgYUp7iGSk9URz/J9LK
 JV+7UUGYfoObLGjakl2FmAfpS+z6BwIbkZB6sCUiMt40nZ5dpiH//OGAVrd+aQ4dXiXnSWLUQvtZe
 GlHiMnywrUGsKvZ1+b2u+26nK2bqWlBVog+O7bL99h/1aRm10GrjKXgV6pzcigvkn/1y+lXNuOD1v
 mQATcE2JggD0mtZ7wBMcWSDePeEPRyov2LePYCXphHtRbhkvrh+zbaWJ7qgF+Xs5H+dXLyKr9EZ71
 Gr5z3gz9d/H0814vnLqFIdSXgmsmXn7shoKsmrYiGfjDwzZX9B0rzKDR1BbSpiKNdLJ6GouvvDgcw
 v9iozL8xn+3THsw==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1rmyaM-006TNN-2H;
 Wed, 20 Mar 2024 17:16:38 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v4 5/7] qga/commands-posix: execute_fsfreeze_hook: use
 ga_run_command helper
Date: Wed, 20 Mar 2024 18:16:46 +0200
Message-Id: <20240320161648.158226-6-andrey.drobyshev@virtuozzo.com>
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

There's no need to check for the existence of the hook executable, as the
exec() call will do that for us.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/commands-posix.c | 35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 545f3c99dc..9b993772f5 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -736,8 +736,6 @@ static const char *fsfreeze_hook_arg_string[] = {
 
 static void execute_fsfreeze_hook(FsfreezeHookArg arg, Error **errp)
 {
-    int status;
-    pid_t pid;
     const char *hook;
     const char *arg_str = fsfreeze_hook_arg_string[arg];
     Error *local_err = NULL;
@@ -746,42 +744,15 @@ static void execute_fsfreeze_hook(FsfreezeHookArg arg, Error **errp)
     if (!hook) {
         return;
     }
-    if (access(hook, X_OK) != 0) {
-        error_setg_errno(errp, errno, "can't access fsfreeze hook '%s'", hook);
-        return;
-    }
 
-    slog("executing fsfreeze hook with arg '%s'", arg_str);
-    pid = fork();
-    if (pid == 0) {
-        setsid();
-        reopen_fd_to_null(0);
-        reopen_fd_to_null(1);
-        reopen_fd_to_null(2);
-
-        execl(hook, hook, arg_str, NULL);
-        _exit(EXIT_FAILURE);
-    } else if (pid < 0) {
-        error_setg_errno(errp, errno, "failed to create child process");
-        return;
-    }
+    const char *argv[] = {hook, arg_str, NULL};
 
-    ga_wait_child(pid, &status, &local_err);
+    slog("executing fsfreeze hook with arg '%s'", arg_str);
+    ga_run_command(argv, NULL, "execute fsfreeze hook", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
-
-    if (!WIFEXITED(status)) {
-        error_setg(errp, "fsfreeze hook has terminated abnormally");
-        return;
-    }
-
-    status = WEXITSTATUS(status);
-    if (status) {
-        error_setg(errp, "fsfreeze hook has failed with status %d", status);
-        return;
-    }
 }
 
 /*
-- 
2.39.3


