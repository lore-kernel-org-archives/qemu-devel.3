Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A313C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 07:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s24dM-0000tQ-1d; Wed, 01 May 2024 03:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s24dK-0000tI-Gm
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:44:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s24d7-0003ZX-Rt
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714549433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QnRftYsFP/MYCrapZD+5MWRcJHZMXvARHgEsjlOLw0Q=;
 b=H7PQK4a0oJif1dRVjOSpjhBllMJ9udYCAFnayTpGeJZRpOmxD62TizyGswX6D8WuGZaEzw
 kydeGTW+NeSF7VhVCUFoAMYHZoTGaime90IMRySECiF+RCS15BaTCNI5G3D5aSg0TdYHkB
 7WuoRXGEVFpJi3V9z+4XyNflv7MNdCU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-xgyA_vZlPfKKLdUpTNIqJQ-1; Wed,
 01 May 2024 03:43:49 -0400
X-MC-Unique: xgyA_vZlPfKKLdUpTNIqJQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4A0F29AA3AC;
 Wed,  1 May 2024 07:43:49 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ABFEA492BC7;
 Wed,  1 May 2024 07:43:48 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 5/9] qga/commands-posix: execute_fsfreeze_hook: use
 ga_run_command helper
Date: Wed,  1 May 2024 10:43:36 +0300
Message-ID: <20240501074340.19641-6-kkostiuk@redhat.com>
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

There's no need to check for the existence of the hook executable, as the
exec() call will do that for us.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/r/20240320161648.158226-6-andrey.drobyshev@virtuozzo.com
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
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
2.44.0


