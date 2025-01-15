Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5056DC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 12:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY27W-0003j9-9s; Wed, 15 Jan 2025 07:03:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tY27P-0003dX-H7
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:03:32 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tY27N-0008Aj-8T
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 07:03:31 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso113007745ad.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 04:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736942608; x=1737547408;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NPcUIuA+1v7HK1TMvnl73wkTi9fItVYjHIROGL3QJso=;
 b=Pe/ENQT6dqRa4z2fpr7/1YS0VF0GwJ/tO0kPXOgig7q2opOw3Gk8O/SnoJpnCdh67F
 K2WwPvOnW+67Zj+3XSV7v6kw40sAWZPkt+RK7y/DicqurGd3iLlaHKlNEikJdJE+73jz
 drP3dkF1GhGeKx272GB1Zx9WAihqXJHXpXmC8MLv0MzXE+xwN/lNkqf8WoVs2BxA8BD2
 rVVvCgjq8cpRIcWpmI7PoPjhl//QrPSTzPX3knrOFy2tTz3k9KiQTlvnbVkfnACYIZqw
 oLmmkeGHnN0Mib/M0P0KD9MZBg2TyO71MHoOWd4tzzOfGY6zrxq/KUX9v0/DwSJMXXXL
 wxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736942608; x=1737547408;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NPcUIuA+1v7HK1TMvnl73wkTi9fItVYjHIROGL3QJso=;
 b=It9AOYqm5iRjmrTt801WVYzQBfYaTDOQoUneox1Cf6C1qN+TwqZxvKgugWtIXKsrWu
 mLCh3gU4IAzEeEYYOcfKnCkxFCy2rPYqYQ1ciUVs5KAGoAnnuAZv3HreP+ypE5i9Bqm6
 9KzjxN8awpSyIMIJnXs5grhoDfBW7j/eflLF8DR6luFj7NNfQKU5cY9iwex7VpuYgCNI
 alLu8ABbxifAuUpVzhhUHI640oDFsFmWXNDkYDz+cKCnKCJIUiS2fF7fu0eJ/cC8Cmp7
 DV+nKc+PASoyWVYDeLrnnynDAPPh7f7KIjEgV+TUqfBX+5oHPrTAcaIKTNM1Y072IAfG
 676g==
X-Gm-Message-State: AOJu0Yx/Q6wS6iZTBfTZqNZamle4o/qydPM1Ln44mGblQIDa9XDkDXvc
 TjavVim006m2LEaP+0yuyvyMLxi1hbySyhWhjOzqfFYF46qZzRXq0NUYUPS9jLk=
X-Gm-Gg: ASbGncuhIAKD6Pb3LhEd7n5KAH2RPIAgGZpfLX7p5tZ5j1wqKiN045v3i3LIN1rlhmB
 Di3vTHBeiRinImGHSCHsG2KHRKVdFNJ9tibnOjd3u7bu4LCDzXSQStQP68ObAKfm3sIqudSc7o8
 /x9wZ0f8XQQJ4ObLRiK7hwsn6AfrR33erCJd2VPhgP7xZqYAmuYlexVgf/HMchuwgkk846UWArH
 NdIzfXlZ43GhMrzCsLmrKsfnjiE1T/pBbGxTfcyDMTC5e8XHXszgqO9cnQd
X-Google-Smtp-Source: AGHT+IHwF9rqf14Q99mM9bLnSiPXZh7CM3vfJwM8vQR9VPQmupTPiucL6mmbhn8VnDwOA4Ag212BeQ==
X-Received: by 2002:a17:902:d2ca:b0:211:8404:a957 with SMTP id
 d9443c01a7336-21a83fc0619mr437535545ad.41.1736942607768; 
 Wed, 15 Jan 2025 04:03:27 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21a9f219a94sm81685845ad.129.2025.01.15.04.03.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 04:03:27 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 15 Jan 2025 21:03:08 +0900
Subject: [PATCH v4 2/2] tap: Use g_spawn_sync() and g_spawn_check_wait_status()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-glib-v4-2-a827b2676259@daynix.com>
References: <20250115-glib-v4-0-a827b2676259@daynix.com>
In-Reply-To: <20250115-glib-v4-0-a827b2676259@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, Lei Yang <leiyang@redhat.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

g_spawn_sync() (for GLib < 2.68) or g_spawn_async_with_pipes_and_fds()
(for the newer) gives an informative message if it fails to execute
the script instead of reporting exiting status 1.

g_spawn_check_wait_status() also gives an message easier to understand
than the raw value returned by waitpid().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 net/tap.c | 220 +++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 117 insertions(+), 103 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index ae1c7e398321..f1e00de4181c 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -385,56 +385,59 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     return s;
 }
 
-static void close_all_fds_after_fork(int excluded_fd)
+#if !GLIB_CHECK_VERSION(2, 68, 0)
+static void unset_cloexec(gpointer data)
 {
-    const int skip_fd[] = {STDIN_FILENO, STDOUT_FILENO, STDERR_FILENO,
-                           excluded_fd};
-    unsigned int nskip = ARRAY_SIZE(skip_fd);
-
-    /*
-     * skip_fd must be an ordered array of distinct fds, exclude
-     * excluded_fd if already included in the [STDIN_FILENO - STDERR_FILENO]
-     * range
-     */
-    if (excluded_fd <= STDERR_FILENO) {
-        nskip--;
-    }
-
-    qemu_close_all_open_fd(skip_fd, nskip);
+    g_assert(!fcntl(GPOINTER_TO_INT(data), F_SETFD, 0));
 }
+#endif
 
 static void launch_script(const char *setup_script, const char *ifname,
                           int fd, Error **errp)
 {
-    int pid, status;
-    char *args[3];
-    char **parg;
+    int status;
+    const gchar *args[] = { setup_script, ifname, NULL };
+    g_autoptr(GError) error = NULL;
+    bool spawned;
 
     /* try to launch network script */
-    pid = fork();
-    if (pid < 0) {
-        error_setg_errno(errp, errno, "could not launch network script %s",
-                         setup_script);
-        return;
-    }
-    if (pid == 0) {
-        close_all_fds_after_fork(fd);
-        parg = args;
-        *parg++ = (char *)setup_script;
-        *parg++ = (char *)ifname;
-        *parg = NULL;
-        execv(setup_script, args);
-        _exit(1);
-    } else {
+#if GLIB_CHECK_VERSION(2, 68, 0)
+    pid_t pid;
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+    spawned = g_spawn_async_with_pipes_and_fds(NULL, args, NULL,
+                                               G_SPAWN_DO_NOT_REAP_CHILD |
+                                               G_SPAWN_CHILD_INHERITS_STDIN,
+                                               NULL, NULL, -1, -1, -1,
+                                               &fd, &fd, 1, &pid,
+                                               NULL, NULL, NULL, &error);
+#pragma GCC diagnostic pop
+    if (spawned) {
         while (waitpid(pid, &status, 0) != pid) {
             /* loop */
         }
+    }
+#else
+    gchar *mutable_args[sizeof(args)];
 
-        if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
-            return;
-        }
-        error_setg(errp, "network script %s failed with status %d",
-                   setup_script, status);
+    for (size_t i = 0; i < ARRAY_SIZE(args); i++) {
+        mutable_args[i] = (gchar *)args[i];
+    }
+
+    spawned = g_spawn_sync(NULL, mutable_args, NULL,
+                           G_SPAWN_CHILD_INHERITS_STDIN,
+                           unset_cloexec, GINT_TO_POINTER(fd),
+                           NULL, NULL, &status, &error);
+#endif
+    if (!spawned) {
+        error_setg(errp, "could not launch network script %s: %s",
+                   setup_script, error->message);
+        return;
+    }
+
+    if (!g_spawn_check_wait_status(status, &error)) {
+        error_setg(errp, "network script %s failed: %s",
+                   setup_script, error->message);
     }
 }
 
@@ -477,10 +480,17 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
 {
     sigset_t oldmask, mask;
     g_autofree char *default_helper = NULL;
+    g_autofree char *fd_buf = NULL;
+    g_autofree char *br_buf = NULL;
+    g_autofree char *helper_cmd = NULL;
+    g_autoptr(GError) error = NULL;
+    int fd;
+    int saved_errno;
     int pid, status;
-    char *args[5];
-    char **parg;
+    const char *args[5];
+    const char **parg;
     int sv[2];
+    bool spawned;
 
     sigemptyset(&mask);
     sigaddset(&mask, SIGCHLD);
@@ -495,82 +505,86 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
         return -1;
     }
 
-    /* try to launch bridge helper */
-    pid = fork();
-    if (pid < 0) {
-        error_setg_errno(errp, errno, "Can't fork bridge helper");
-        return -1;
-    }
-    if (pid == 0) {
-        char *fd_buf = NULL;
-        char *br_buf = NULL;
-        char *helper_cmd = NULL;
-
-        close_all_fds_after_fork(sv[1]);
-        fd_buf = g_strdup_printf("%s%d", "--fd=", sv[1]);
+    fd_buf = g_strdup_printf("%s%d", "--fd=", sv[1]);
 
-        if (strrchr(helper, ' ') || strrchr(helper, '\t')) {
-            /* assume helper is a command */
+    if (strrchr(helper, ' ') || strrchr(helper, '\t')) {
+        /* assume helper is a command */
 
-            if (strstr(helper, "--br=") == NULL) {
-                br_buf = g_strdup_printf("%s%s", "--br=", bridge);
-            }
-
-            helper_cmd = g_strdup_printf("%s %s %s %s", helper,
-                            "--use-vnet", fd_buf, br_buf ? br_buf : "");
+        if (strstr(helper, "--br=") == NULL) {
+            br_buf = g_strdup_printf("%s%s", "--br=", bridge);
+        }
 
-            parg = args;
-            *parg++ = (char *)"sh";
-            *parg++ = (char *)"-c";
-            *parg++ = helper_cmd;
-            *parg++ = NULL;
+        helper_cmd = g_strdup_printf("%s %s %s %s", helper,
+                        "--use-vnet", fd_buf, br_buf ? br_buf : "");
 
-            execv("/bin/sh", args);
-            g_free(helper_cmd);
-        } else {
-            /* assume helper is just the executable path name */
+        parg = args;
+        *parg++ = "sh";
+        *parg++ = "-c";
+        *parg++ = helper_cmd;
+        *parg++ = NULL;
+    } else {
+        /* assume helper is just the executable path name */
 
-            br_buf = g_strdup_printf("%s%s", "--br=", bridge);
+        br_buf = g_strdup_printf("%s%s", "--br=", bridge);
 
-            parg = args;
-            *parg++ = (char *)helper;
-            *parg++ = (char *)"--use-vnet";
-            *parg++ = fd_buf;
-            *parg++ = br_buf;
-            *parg++ = NULL;
+        parg = args;
+        *parg++ = helper;
+        *parg++ = "--use-vnet";
+        *parg++ = fd_buf;
+        *parg++ = br_buf;
+        *parg++ = NULL;
+    }
 
-            execv(helper, args);
-        }
-        g_free(fd_buf);
-        g_free(br_buf);
-        _exit(1);
+    /* try to launch bridge helper */
+#if GLIB_CHECK_VERSION(2, 68, 0)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+    spawned = g_spawn_async_with_pipes_and_fds(NULL, args, NULL,
+                                               G_SPAWN_DO_NOT_REAP_CHILD |
+                                               G_SPAWN_CHILD_INHERITS_STDIN,
+                                               NULL, NULL, -1, -1, -1,
+                                               &fd, &fd, 1, &pid,
+                                               NULL, NULL, NULL, &error);
+#pragma GCC diagnostic pop
+#else
+    gchar *mutable_args[sizeof(args)];
+
+    for (size_t i = 0; i < ARRAY_SIZE(args); i++) {
+        mutable_args[i] = (gchar *)args[i];
+    }
 
-    } else {
-        int fd;
-        int saved_errno;
+    spawned = g_spawn_async(NULL, mutable_args, NULL,
+                            G_SPAWN_DO_NOT_REAP_CHILD |
+                            G_SPAWN_CHILD_INHERITS_STDIN,
+                            unset_cloexec, GINT_TO_POINTER(sv[1]),
+                            &pid, &error);
+#endif
+    if (!spawned) {
+        error_setg(errp, "could not launch bridge helper: %s", error->message);
+        return -1;
+    }
 
-        close(sv[1]);
+    close(sv[1]);
 
-        fd = RETRY_ON_EINTR(recv_fd(sv[0]));
-        saved_errno = errno;
+    fd = RETRY_ON_EINTR(recv_fd(sv[0]));
+    saved_errno = errno;
 
-        close(sv[0]);
+    close(sv[0]);
 
-        while (waitpid(pid, &status, 0) != pid) {
-            /* loop */
-        }
-        sigprocmask(SIG_SETMASK, &oldmask, NULL);
-        if (fd < 0) {
-            error_setg_errno(errp, saved_errno,
-                             "failed to recv file descriptor");
-            return -1;
-        }
-        if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
-            error_setg(errp, "bridge helper failed");
-            return -1;
-        }
-        return fd;
+    while (waitpid(pid, &status, 0) != pid) {
+        /* loop */
     }
+    sigprocmask(SIG_SETMASK, &oldmask, NULL);
+    if (fd < 0) {
+        error_setg_errno(errp, saved_errno,
+                            "failed to recv file descriptor");
+        return -1;
+    }
+    if (!g_spawn_check_wait_status(status, &error)) {
+        error_setg(errp, "bridge helper failed: %s", error->message);
+        return -1;
+    }
+    return fd;
 }
 
 int net_init_bridge(const Netdev *netdev, const char *name,

-- 
2.47.1


