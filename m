Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CEAC41513
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 07:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s24dA-0000qb-6O; Wed, 01 May 2024 03:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s24d8-0000pv-CT
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:43:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s24d6-0003Xr-16
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714549431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xda9vZ/4orUHg9RUs409tFjFC6HKizyWCmMyjF5kot0=;
 b=d3N2fJY6udmE343LImKJxHdQh1U12nMjHykCR4/YpV/Q1yD2Vzbwt+y/YGuUB+XXMvcO4m
 H2z2LbY2rNOFMUw2I2Jf7ra06ZSCY9KLU9vTvwGiE428VuWBxJeP1XWTj33M0n+ssqFVLL
 Q2l4sABJmGKUDOfnTCCtSuAkNJ58bco=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-jKoAtm4SMpSzinv62u3C9A-1; Wed, 01 May 2024 03:43:47 -0400
X-MC-Unique: jKoAtm4SMpSzinv62u3C9A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24B6018065B2;
 Wed,  1 May 2024 07:43:47 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C7BF477F80;
 Wed,  1 May 2024 07:43:46 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 3/9] qga/commands-posix: qmp_guest_shutdown: use ga_run_command
 helper
Date: Wed,  1 May 2024 10:43:34 +0300
Message-ID: <20240501074340.19641-4-kkostiuk@redhat.com>
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

Also remove the G_GNUC_UNUSED attribute added in the previous commit from
the helper.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/r/20240320161648.158226-4-andrey.drobyshev@virtuozzo.com
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
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
2.44.0


