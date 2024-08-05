Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F18C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 00:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saldd-0007ts-Co; Sun, 04 Aug 2024 20:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saldb-0007m6-FN
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 20:31:47 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saldZ-0002JM-Qj
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 20:31:47 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70d150e8153so3301865b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 17:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722817904; x=1723422704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hbxagQGZ9enwm2uWyobspLUjv+kLe0ys5wANtBKsnzE=;
 b=CZ1DcJwZuqy/nrM8pY5oc5XgukNTvh4OffcFLyd3oxKMZDsUYaGuZFQ3yicXXaaZyk
 bDFVhKOQ6tgnchLnIqOSP1xSpAot9W1RljpQlUWAcJLpJWivoRO/rHkjl1e/o6eDovCH
 PlmZecFGjRZZbyzCfGFR964hRQcShryN8dTxYsKVkG/cHUtBXhFXR0ZcqWQE0tEveW20
 1FM+hU3DDmUXMEI9YAX88h36u4mXkZmBSoRXOysYkFPqbOfpyBfv6e/Hz1BmeXg06via
 UMjyDLAiKkYlrb+2GVKqJNVNhF2PxLyvy5VjksJYt1MmAWRWQbS0/KpYEENFnM8joqjI
 6Euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722817904; x=1723422704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hbxagQGZ9enwm2uWyobspLUjv+kLe0ys5wANtBKsnzE=;
 b=ICOfgLHxGY705U8ryk2DvRz03OXMMZnO2jNu2cCfK8sAJvFGnbVRpGMpC+zmKLKGPu
 wA9SDkFN1xMvGm60hxMpOdijchlZUrESZ1lZkK0nTVkmgCTz/D5ZKWaiwgfLdLKcyAJm
 rS11y0wksvqM/VdHue7ea6EN+8UwVtHaI5kO9g2tvotyqwiAUi3AHfmcJOIjKkLy7xKC
 FHXCwkeVlY4eKyAs7GPKtEimMs3la7MzXOGFzPrI0tkWpKIhwZFphd5otpqhAGzaWzpl
 L4EeRVWLn0uORDe/1/UEls+ShrdwS4Qag4Tg90IgrA7XC4l1bdcJbZ0cSCoYuLaO4RE5
 Homg==
X-Gm-Message-State: AOJu0Yx7ZNyNX7D84xnrCEBpjjo7/PG4d3Uhdv/R5RptUi6/E/Kid9+F
 MuHPbrYi662E4ltNA9W38EaUBEQnQo+MMfx/xjIzyurKU1VCML+9WHCHu6kGPF4iGvBwN5xqhKG
 /yM+JuA==
X-Google-Smtp-Source: AGHT+IFkkUC+mFjLaRBAUN6z7tpvd3EEx0ZAA7xLlBHfBHi/onGdIPKnCeGszYUm0YHph88ERT6c3g==
X-Received: by 2002:a05:6a00:2406:b0:70d:14d1:1bad with SMTP id
 d2e1a72fcca58-7106d9d9330mr18041602b3a.3.1722817904230; 
 Sun, 04 Aug 2024 17:31:44 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ed16cb3sm4576038b3a.179.2024.08.04.17.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 17:31:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 2/6] qemu/osdep: Move close_all_open_fds() to oslib-posix
Date: Mon,  5 Aug 2024 10:31:25 +1000
Message-ID: <20240805003130.1421051-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805003130.1421051-1-richard.henderson@linaro.org>
References: <20240805003130.1421051-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Clément Léger <cleger@rivosinc.com>

Move close_all_open_fds() in oslib-posix, rename it
qemu_close_all_open_fds() and export it.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240802145423.3232974-2-cleger@rivosinc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/osdep.h    |  7 +++++++
 system/async-teardown.c | 37 +------------------------------------
 util/oslib-posix.c      | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 720ed21a7e..de77c5c254 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -757,6 +757,13 @@ static inline void qemu_reset_optind(void)
 
 int qemu_fdatasync(int fd);
 
+/**
+ * qemu_close_all_open_fd:
+ *
+ * Close all open file descriptors
+ */
+void qemu_close_all_open_fd(void);
+
 /**
  * Sync changes made to the memory mapped file back to the backing
  * storage. For POSIX compliant systems this will fallback
diff --git a/system/async-teardown.c b/system/async-teardown.c
index 396963c091..edf49e1007 100644
--- a/system/async-teardown.c
+++ b/system/async-teardown.c
@@ -26,40 +26,6 @@
 
 static pid_t the_ppid;
 
-/*
- * Close all open file descriptors.
- */
-static void close_all_open_fd(void)
-{
-    struct dirent *de;
-    int fd, dfd;
-    DIR *dir;
-
-#ifdef CONFIG_CLOSE_RANGE
-    int r = close_range(0, ~0U, 0);
-    if (!r) {
-        /* Success, no need to try other ways. */
-        return;
-    }
-#endif
-
-    dir = opendir("/proc/self/fd");
-    if (!dir) {
-        /* If /proc is not mounted, there is nothing that can be done. */
-        return;
-    }
-    /* Avoid closing the directory. */
-    dfd = dirfd(dir);
-
-    for (de = readdir(dir); de; de = readdir(dir)) {
-        fd = atoi(de->d_name);
-        if (fd != dfd) {
-            close(fd);
-        }
-    }
-    closedir(dir);
-}
-
 static void hup_handler(int signal)
 {
     /* Check every second if this process has been reparented. */
@@ -85,9 +51,8 @@ static int async_teardown_fn(void *arg)
     /*
      * Close all file descriptors that might have been inherited from the
      * main qemu process when doing clone, needed to make libvirt happy.
-     * Not using close_range for increased compatibility with older kernels.
      */
-    close_all_open_fd();
+    qemu_close_all_open_fd();
 
     /* Set up a handler for SIGHUP and unblock SIGHUP. */
     sigaction(SIGHUP, &sa, NULL);
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index b090fe0eed..1e867efa47 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -807,3 +807,37 @@ int qemu_msync(void *addr, size_t length, int fd)
 
     return msync(addr, length, MS_SYNC);
 }
+
+/*
+ * Close all open file descriptors.
+ */
+void qemu_close_all_open_fd(void)
+{
+    struct dirent *de;
+    int fd, dfd;
+    DIR *dir;
+
+#ifdef CONFIG_CLOSE_RANGE
+    int r = close_range(0, ~0U, 0);
+    if (!r) {
+        /* Success, no need to try other ways. */
+        return;
+    }
+#endif
+
+    dir = opendir("/proc/self/fd");
+    if (!dir) {
+        /* If /proc is not mounted, there is nothing that can be done. */
+        return;
+    }
+    /* Avoid closing the directory. */
+    dfd = dirfd(dir);
+
+    for (de = readdir(dir); de; de = readdir(dir)) {
+        fd = atoi(de->d_name);
+        if (fd != dfd) {
+            close(fd);
+        }
+    }
+    closedir(dir);
+}
-- 
2.43.0


