Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D80C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 06:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXwqx-0005gp-0G; Wed, 15 Jan 2025 01:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tXwqu-0005fO-VQ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 01:26:08 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tXwqs-0006Xr-Vo
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 01:26:08 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2163b0c09afso116533305ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 22:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736922365; x=1737527165;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LbKIAcs32T5KVRGK6kz0Z6vHisYjym1l27iUCi/5cQ4=;
 b=0r61FBimwPscphxtUefr8hK7CT6tJs2Hx/g8GRds9huaD0F4mrC/YW7dGpymK+IQFZ
 9kDpLgFNDBtHcq0DMSbjsPmQIAu0gS9Z2YIkFz4ykoSe0ahPKy96oWY2YYaCSZdYx2eP
 TXGHm4f9Rg8K1jEN3GLAI3UNqKohvApR4LYVTTsHxIKZKnmgUTquKEmRWfvKvrPRMH2H
 Zgww/g8UlBJqgWtb894hwYy4aJmv1XnsWvXK46jyLPwElgGFYFi73EZ/NqekvaORqCTv
 k1PvCS1uCStzaWksrPAua+OmyTFUbHdJIv6xU2XQmvB3G1lTaNVwhuAsJMDgBt//iGFk
 +3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736922365; x=1737527165;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LbKIAcs32T5KVRGK6kz0Z6vHisYjym1l27iUCi/5cQ4=;
 b=YTDIXhSr+IsvVRfJYB8a24eUBER0E3Q33Evog92hEyQiWFIULTblzImRMuRdXOccee
 q/0Vh+B45mt0QkzR3WNf0BrOMaCI86CgElabf7D3SyMZFQE4gR6wYyeJFaYLLUkQYoTA
 Nw8ywWKiInmzwIX7jdlvlFhsHLbsnudFVfnNtn5r2T65Mpcx8Z7YgJPSWxD6n+RTvN06
 fqZyxJhDPOwsi/DagUZkI1/w1OkUhk5Y9x15uoSbEhQoDgq4YfILt2PBD6KIWpARwh0G
 +PqVonBBuN8E03AkYxnt9MUuUfGHscf/Q6qWul5y4+mE4HiVZBJYlMQssWVOfuku/Exu
 kZcw==
X-Gm-Message-State: AOJu0YyV2hol4pePWU5KsZFc+T7LKhzhlP+1COFOOfJ6YVPzi7nRNJCW
 ZTjwnXKB0imiVeKI1bIve1cFa4gYC15gMif2uhawDkBApxKmbyGvJFIMtVIGSbY=
X-Gm-Gg: ASbGnctBsduyxCR3wkOndPiqpfOYTwXvAD7VOdDMWMnE9emWJzYMc8+wf4az8bsmlp/
 kZR6F1WlrsbUsAAYFyAB6bZ2bl61hfSz1XaXF9MwAPBSNZHetm8/TZl93DJ4Z5RTaACZkAMvGGv
 wt+wL9Ilppy+DcbmP8ThN1sFp4hAjRN9o+sLrsUixsL+74ACYmzxbNYwNpMB5cFEN1XueQKKu+4
 vt0h31o0rQo5cr55FxlgneFLonhy2ujnzwuWOtZzZj/eURanebE9sev8Vc=
X-Google-Smtp-Source: AGHT+IEojZn+RG19fjTflRGbA0HAfwGHw/h4NvXHQS+t7Jc283fTgUnM3lsTV6k9SxziE3MbHSa8zg==
X-Received: by 2002:a05:6a00:368d:b0:727:99a8:cd31 with SMTP id
 d2e1a72fcca58-72d21f47fc5mr38197913b3a.14.1736922365113; 
 Tue, 14 Jan 2025 22:26:05 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72d40591ff4sm8410059b3a.77.2025.01.14.22.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 22:26:04 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 15 Jan 2025 15:25:47 +0900
Subject: [PATCH v3 2/2] tap: Use g_spawn_sync() and g_spawn_check_wait_status()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-glib-v3-2-bd3153344698@daynix.com>
References: <20250115-glib-v3-0-bd3153344698@daynix.com>
In-Reply-To: <20250115-glib-v3-0-bd3153344698@daynix.com>
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

g_spawn_sync() gives an informative message if it fails to execute
the script instead of reporting exiting status 1.

g_spawn_check_wait_status() also gives an message easier to understand
than the raw value returned by waitpid().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 net/tap.c | 169 ++++++++++++++++++++++++--------------------------------------
 1 file changed, 66 insertions(+), 103 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index ae1c7e398321..392a024f8ed9 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -385,56 +385,30 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     return s;
 }
 
-static void close_all_fds_after_fork(int excluded_fd)
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
 
 static void launch_script(const char *setup_script, const char *ifname,
                           int fd, Error **errp)
 {
-    int pid, status;
-    char *args[3];
-    char **parg;
+    gint status;
+    gchar *argv[] = { (gchar *)setup_script, (gchar *)ifname, NULL };
+    g_autoptr(GError) error = NULL;
 
     /* try to launch network script */
-    pid = fork();
-    if (pid < 0) {
-        error_setg_errno(errp, errno, "could not launch network script %s",
-                         setup_script);
+    if (!g_spawn_sync(NULL, argv, NULL, G_SPAWN_CHILD_INHERITS_STDIN,
+                      unset_cloexec, GINT_TO_POINTER(fd),
+                      NULL, NULL, &status, &error)) {
+        error_setg(errp, "could not launch network script %s: %s",
+                   setup_script, error->message);
         return;
     }
-    if (pid == 0) {
-        close_all_fds_after_fork(fd);
-        parg = args;
-        *parg++ = (char *)setup_script;
-        *parg++ = (char *)ifname;
-        *parg = NULL;
-        execv(setup_script, args);
-        _exit(1);
-    } else {
-        while (waitpid(pid, &status, 0) != pid) {
-            /* loop */
-        }
 
-        if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
-            return;
-        }
-        error_setg(errp, "network script %s failed with status %d",
-                   setup_script, status);
+    if (!g_spawn_check_wait_status(status, &error)) {
+        error_setg(errp, "network script %s failed: %s",
+                   setup_script, error->message);
     }
 }
 
@@ -477,6 +451,12 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
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
     char *args[5];
     char **parg;
@@ -495,82 +475,65 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
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
-
-            parg = args;
-            *parg++ = (char *)"sh";
-            *parg++ = (char *)"-c";
-            *parg++ = helper_cmd;
-            *parg++ = NULL;
+        if (strstr(helper, "--br=") == NULL) {
+            br_buf = g_strdup_printf("%s%s", "--br=", bridge);
+        }
 
-            execv("/bin/sh", args);
-            g_free(helper_cmd);
-        } else {
-            /* assume helper is just the executable path name */
+        helper_cmd = g_strdup_printf("%s %s %s %s", helper,
+                        "--use-vnet", fd_buf, br_buf ? br_buf : "");
 
-            br_buf = g_strdup_printf("%s%s", "--br=", bridge);
+        parg = args;
+        *parg++ = (char *)"sh";
+        *parg++ = (char *)"-c";
+        *parg++ = helper_cmd;
+        *parg++ = NULL;
+    } else {
+        /* assume helper is just the executable path name */
 
-            parg = args;
-            *parg++ = (char *)helper;
-            *parg++ = (char *)"--use-vnet";
-            *parg++ = fd_buf;
-            *parg++ = br_buf;
-            *parg++ = NULL;
+        br_buf = g_strdup_printf("%s%s", "--br=", bridge);
 
-            execv(helper, args);
-        }
-        g_free(fd_buf);
-        g_free(br_buf);
-        _exit(1);
+        parg = args;
+        *parg++ = (char *)helper;
+        *parg++ = (char *)"--use-vnet";
+        *parg++ = fd_buf;
+        *parg++ = br_buf;
+        *parg++ = NULL;
+    }
 
-    } else {
-        int fd;
-        int saved_errno;
+    /* try to launch bridge helper */
+    if (!g_spawn_async(NULL, args, NULL,
+                       G_SPAWN_DO_NOT_REAP_CHILD | G_SPAWN_CHILD_INHERITS_STDIN,
+                       unset_cloexec, GINT_TO_POINTER(sv[1]), &pid, &error)) {
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


