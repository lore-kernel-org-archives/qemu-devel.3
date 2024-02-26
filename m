Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35B9C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeHm-0005YE-Bc; Mon, 26 Feb 2024 11:57:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1reeHd-0005W7-96
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:56:54 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1reeHX-0007aM-41
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=kp8z+p1ZvDrme73dRSAIidGhStbQaeG0VLfyNPijbvw=; b=pilkOaV72yBY
 LUM1hdb/9jw54xNLi7M9lMvWtJU+UfnvmJ4lePBUOl8f9kOm+VlgXLhDIpjrtL8XYop0QegLmf+td
 kaHthwzNsNFKFvxXE3myYHTVziNX869bAbDfLPPKqH2sNikNA0YtDVLSPMfLceqIGtxHlqs3MmAwx
 dQFpRbj7d31fXVEQh9AHWoNKE99Z0CAoq6OIq1DiFgUnoYcuam+nA86VEDTnOQoqJfoFnDZoW8Cti
 /XXFW/c5WAYjd92njTlaLKXEVlK4gJe9DSRzmkOC1cz+aeJYeAzmZeazZsicKofI0KF4TMvU7XVAM
 J3NusOtARA20lk/jlOr+UA==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1reeG3-001AD7-0j;
 Mon, 26 Feb 2024 17:56:34 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, kkostiuk@redhat.com, marcandre.lureau@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH 5/7] qga/commands-posix: execute_fsfreeze_hook: use
 ga_run_command helper
Date: Mon, 26 Feb 2024 18:56:40 +0200
Message-Id: <20240226165642.807350-6-andrey.drobyshev@virtuozzo.com>
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

There's no need to check for the existence of the hook executable, as the
exec() call will do that for us.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 qga/commands-posix.c | 35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index b704006c98..6baaabc29e 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -726,8 +726,6 @@ static const char *fsfreeze_hook_arg_string[] = {
 
 static void execute_fsfreeze_hook(FsfreezeHookArg arg, Error **errp)
 {
-    int status;
-    pid_t pid;
     const char *hook;
     const char *arg_str = fsfreeze_hook_arg_string[arg];
     Error *local_err = NULL;
@@ -736,42 +734,15 @@ static void execute_fsfreeze_hook(FsfreezeHookArg arg, Error **errp)
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


