Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B60FC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 07:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s24dB-0000r7-FK; Wed, 01 May 2024 03:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s24dA-0000qa-45
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:43:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s24d7-0003ZS-FT
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714549432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v98YNa/eB+VuXpNUsDmwf5/Lc+Hzywry1owXyzt6Ids=;
 b=VtAvpwW+TgoYccD/vvm1cGJgOg6/uTNoyNVxl4tYRN/hRc0Spfpa7zGPjyLsiBjapUVSvj
 7lRYZ5URMuKPGMtDhl/NaQn6iJ68Ssn7vJT9KrTOCV2+JkpKgrx0GBLWbcJc4/9wCMfReO
 XyRvuqFbkTmxi8YnfKh1AUQgKAZOf1Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-I_0IzbowNTWZaDAA24Skhg-1; Wed,
 01 May 2024 03:43:51 -0400
X-MC-Unique: I_0IzbowNTWZaDAA24Skhg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E36D629AA3AC;
 Wed,  1 May 2024 07:43:50 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9E8E40BAA2;
 Wed,  1 May 2024 07:43:49 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 6/9] qga/commands-posix: don't do fork()/exec() when suspending
 via sysfs
Date: Wed,  1 May 2024 10:43:37 +0300
Message-ID: <20240501074340.19641-7-kkostiuk@redhat.com>
In-Reply-To: <20240501074340.19641-1-kkostiuk@redhat.com>
References: <20240501074340.19641-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
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

Since commit 246d76eba ("qga: guest_suspend: decoupling pm-utils and sys
logic") pm-utils logic is running in a separate child from the sysfs
logic.  Now when suspending via sysfs we don't really need to do that in
a separate process as we only need to perform one write to /sys/power/state.

Let's just use g_file_set_contents() to simplify things here.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/r/20240320161648.158226-7-andrey.drobyshev@virtuozzo.com
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
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
2.44.0


