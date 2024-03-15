Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C338EC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 12:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl6hp-0002vh-QG; Fri, 15 Mar 2024 08:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rl6hN-0002JG-Ou
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:30:13 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rl6h8-0006OW-OF
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=atrtJ9o9Y5R8NzRgsf6pRIlcgshMhbCbGyUrqmxx9xQ=; b=LCeQ/plhqWHb
 0GBn8yDCgGCXtfxYxiTJ/w+kN8LXzeSA3eKNPYBPBmAeYym/1DUvvSP12sqZ/3RD2/zw/k4aIVgpY
 CEo8hGYW8l9/7Os40PgRvoPAjuMjJi75gshN5G4zcMmge7ulkOCo9YKm7s3IF3iPzVJLQNcZBoysn
 BFSo0CiDNk8OvX40QU57kL/OT3OLZIKds7tOmHjPGaZxRudpovHBZiIHivU1py1X0IRGoQuTE2iXc
 G7z10AUfdz/oa7RtWoq0fvIs0sTUlHehiZ3qvhv5e+m/E9I/xCbVi7CXIrcQ6GJuuCmnLoPH6a9kP
 kFmTChQtLcLYRYM3Bthapg==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1rl6f5-005Caf-0z;
 Fri, 15 Mar 2024 13:29:46 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v3 7/7] qga/commands-posix: qmp_guest_set_user_password: use
 ga_run_command helper
Date: Fri, 15 Mar 2024 14:29:46 +0200
Message-Id: <20240315122946.39168-8-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240315122946.39168-1-andrey.drobyshev@virtuozzo.com>
References: <20240315122946.39168-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

There's no need to check for the existence of the "chpasswd", "pw"
executables, as the exec() call will do that for us.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 qga/commands-posix.c | 96 ++++++--------------------------------------
 1 file changed, 13 insertions(+), 83 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index e0ea377f65..ffea69c3f0 100644
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
2.39.3


