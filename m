Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690B0C19F53
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 07:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s24dB-0000rM-P0; Wed, 01 May 2024 03:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s24dA-0000ql-Hj
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:43:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s24d8-0003aW-NY
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714549434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ownYj/qlgNbv9VvIzzLsn6x+0ehrNzewTvcneFeFHA=;
 b=giWd3Bs3fed2C7i0mTHIQE3X9gmt/HraeCBVTA60S+oTSEE7YgJ92A0zz7pMfCwvuuGMgz
 /oN5NLse3m2PZILVkHjVKGf3kRQ2cpsxgZtbL5iG219uRn211G9G9sQ2eyn/oIbC5S1CVR
 QNmCLkUPTqVZeJVjkZ1UpNqS8rBGLao=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-cp-O5migNWWmGz11JWzTMw-1; Wed,
 01 May 2024 03:43:52 -0400
X-MC-Unique: cp-O5migNWWmGz11JWzTMw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D080380621E;
 Wed,  1 May 2024 07:43:52 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 349B740C5C2;
 Wed,  1 May 2024 07:43:51 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 7/9] qga/commands-posix: qmp_guest_set_user_password: use
 ga_run_command helper
Date: Wed,  1 May 2024 10:43:38 +0300
Message-ID: <20240501074340.19641-8-kkostiuk@redhat.com>
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

There's no need to check for the existence of the "chpasswd", "pw"
executables, as the exec() call will do that for us.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/r/20240320161648.158226-8-andrey.drobyshev@virtuozzo.com
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-posix.c | 96 ++++++--------------------------------------
 1 file changed, 13 insertions(+), 83 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 9910957ff5..7a065c4085 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2151,14 +2151,8 @@ void qmp_guest_set_user_password(const char *username,
                                  Error **errp)
 {
     Error *local_err = NULL;
-    char *passwd_path = NULL;
-    pid_t pid;
-    int status;
-    int datafd[2] = { -1, -1 };
-    char *rawpasswddata = NULL;
+    g_autofree char *rawpasswddata = NULL;
     size_t rawpasswdlen;
-    char *chpasswddata = NULL;
-    size_t chpasswdlen;
 
     rawpasswddata = (char *)qbase64_decode(password, -1, &rawpasswdlen, errp);
     if (!rawpasswddata) {
@@ -2169,95 +2163,31 @@ void qmp_guest_set_user_password(const char *username,
 
     if (strchr(rawpasswddata, '\n')) {
         error_setg(errp, "forbidden characters in raw password");
-        goto out;
+        return;
     }
 
     if (strchr(username, '\n') ||
         strchr(username, ':')) {
         error_setg(errp, "forbidden characters in username");
-        goto out;
+        return;
     }
 
 #ifdef __FreeBSD__
-    chpasswddata = g_strdup(rawpasswddata);
-    passwd_path = g_find_program_in_path("pw");
+    g_autofree char *chpasswdata = g_strdup(rawpasswddata);
+    const char *crypt_flag = crypted ? "-H" : "-h";
+    const char *argv[] = {"pw", "usermod", "-n", username,
+                          crypt_flag, "0", NULL};
 #else
-    chpasswddata = g_strdup_printf("%s:%s\n", username, rawpasswddata);
-    passwd_path = g_find_program_in_path("chpasswd");
+    g_autofree char *chpasswddata = g_strdup_printf("%s:%s\n", username,
+                                                    rawpasswddata);
+    const char *crypt_flag = crypted ? "-e" : NULL;
+    const char *argv[] = {"chpasswd", crypt_flag, NULL};
 #endif
 
-    chpasswdlen = strlen(chpasswddata);
-
-    if (!passwd_path) {
-        error_setg(errp, "cannot find 'passwd' program in PATH");
-        goto out;
-    }
-
-    if (!g_unix_open_pipe(datafd, FD_CLOEXEC, NULL)) {
-        error_setg(errp, "cannot create pipe FDs");
-        goto out;
-    }
-
-    pid = fork();
-    if (pid == 0) {
-        close(datafd[1]);
-        /* child */
-        setsid();
-        dup2(datafd[0], 0);
-        reopen_fd_to_null(1);
-        reopen_fd_to_null(2);
-
-#ifdef __FreeBSD__
-        const char *h_arg;
-        h_arg = (crypted) ? "-H" : "-h";
-        execl(passwd_path, "pw", "usermod", "-n", username, h_arg, "0", NULL);
-#else
-        if (crypted) {
-            execl(passwd_path, "chpasswd", "-e", NULL);
-        } else {
-            execl(passwd_path, "chpasswd", NULL);
-        }
-#endif
-        _exit(EXIT_FAILURE);
-    } else if (pid < 0) {
-        error_setg_errno(errp, errno, "failed to create child process");
-        goto out;
-    }
-    close(datafd[0]);
-    datafd[0] = -1;
-
-    if (qemu_write_full(datafd[1], chpasswddata, chpasswdlen) != chpasswdlen) {
-        error_setg_errno(errp, errno, "cannot write new account password");
-        goto out;
-    }
-    close(datafd[1]);
-    datafd[1] = -1;
-
-    ga_wait_child(pid, &status, &local_err);
+    ga_run_command(argv, chpasswddata, "set user password", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        goto out;
-    }
-
-    if (!WIFEXITED(status)) {
-        error_setg(errp, "child process has terminated abnormally");
-        goto out;
-    }
-
-    if (WEXITSTATUS(status)) {
-        error_setg(errp, "child process has failed to set user password");
-        goto out;
-    }
-
-out:
-    g_free(chpasswddata);
-    g_free(rawpasswddata);
-    g_free(passwd_path);
-    if (datafd[0] != -1) {
-        close(datafd[0]);
-    }
-    if (datafd[1] != -1) {
-        close(datafd[1]);
+        return;
     }
 }
 #else /* __linux__ || __FreeBSD__ */
-- 
2.44.0


