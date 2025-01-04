Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8549E77199
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 08:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTz9B-0001Ks-Uu; Sat, 04 Jan 2025 03:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz93-00018F-PZ
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:04:30 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz90-0000bt-Iw
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:04:28 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2eed82ca5b4so18122229a91.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 00:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977861; x=1736582661;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j7PSWmeKm2BCZzuGe7wJN0+C8nC2dfAB8Z84i9cyTNU=;
 b=oW1Ldw2SiquzxkErrKT+z+HUrPwsNUkTye3zczsy+enTin0sodLcT1trGGL5gZziZT
 88xAuCHEYhL7uyxBnMPnpOSgqknIZrMWtB+TssLlh8Y2ZBvEulZFX/HKbcl3pTu3u+FX
 zNv9psm29/d0hrwqaPMVcTK2BoJFGalweeqwnPox/yKlpcdzDnYx0w6ymD8fkxVmZJ5J
 /D2QJOuSHS9DgGd4BwjLvqGPSAq1JGDJo2MCR1O32RdD6H9uLCtvjmRI7xjnzz9wHv1f
 ur7uTpRVCjdEbRjk4nOR7u0Mz6BYWHvBvvxvtkbG8Yc01qLh1+Lm+8mBU6VbfheB42VV
 32sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977861; x=1736582661;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j7PSWmeKm2BCZzuGe7wJN0+C8nC2dfAB8Z84i9cyTNU=;
 b=qPZSPn/h6qO+1BqKn+grp7kKVZ46B0r1xVI0qZCR7shH1f6++1zDE1xr07CZu5gWDt
 BCydgrF8y21GJ3wNX5BUv9S0FUYvy2UAnq3dKCfB3HYb4sRLcA0ell9dBID149LALbJc
 MWTrAY13YOltb3VFnunOjx/bS832Y65eBgXFpi1OKhnapzsNhbH1igQRgxgkTsA3J1aL
 IGCga19ZFWG8IhC28nNE2/fuHfYmG7k2w7DdrQ/E4ATLGNFDA/TolYKEpsIoUCUI/b7t
 bd5IjErTvszrAUKQoOtT/4h7eV/iaLWeIzxw2OU3eq6x5bnbhpOCBG0mDxhQZmQoWCRf
 l7KA==
X-Gm-Message-State: AOJu0Ywuds1CRutSsPorisiKxSxIOywzWPlFlfCs3FhrdVgQeJJwat2N
 wxNORG5w2F/pJQVeQOLFGXgQFX9XEg12z7Zm8820XXA3ubB1PubsySSxPlAgewEldaJ/KRnXQiF
 yLmY=
X-Gm-Gg: ASbGncsfabrGQnvHF/dsrLMXUuEsxYcDjvCy/2NFrrnVR81c8Wv8E/20HUXsOli58SQ
 +hdI7Ql368UApM5OUwfy6MeSYrufblbg4NdBGHCcCUlg91kvXqDKf688mQofMaBrqt63Ri9BGHA
 1xX6QYFgnhrD/9zzwJlNRQxuv0JYMBE/DF3ZzDK+qfZ3P1FZKHr7L95tMuxzNLn3MEUR3LSl6Qu
 o7ffjACHQaYSpTZ0v2SdaUC1cBhA0Y141rjhnPOzQEHCpUE+V/yT80eL9FT
X-Google-Smtp-Source: AGHT+IEo0cpdZ7IVab42kbpN91u60YM+kISR0y2YO/7w4TVuOuPVRBBh0NKzdJgevkfZPvVKb4D84A==
X-Received: by 2002:a17:90b:534b:b0:2ee:c91a:acf7 with SMTP id
 98e67ed59e1d1-2f452dfccdcmr76276094a91.4.1735977860695; 
 Sat, 04 Jan 2025 00:04:20 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2f4478a9108sm32880827a91.43.2025.01.04.00.04.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2025 00:04:20 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 17:04:08 +0900
Subject: [PATCH v2 2/2] tap: Use g_spawn_sync() and g_spawn_check_wait_status()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-glib-v2-2-12013f3e5782@daynix.com>
References: <20250104-glib-v2-0-12013f3e5782@daynix.com>
In-Reply-To: <20250104-glib-v2-0-12013f3e5782@daynix.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1034.google.com
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


