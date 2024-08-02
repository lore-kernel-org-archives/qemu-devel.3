Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61A8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 14:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZtgN-00045g-TY; Fri, 02 Aug 2024 10:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZtgL-0003yY-Uh
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:55:01 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZtgJ-0005Fm-Sr
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:55:01 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fd8f92d805so3690075ad.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722610498; x=1723215298;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/VuHi8HCpVaGQUBeXQ5vj7rlUpYLSoENN/sFJxhSHw=;
 b=LYAFDe0UZNEIkjJ6ix1ZZSE7i1zEXfbzbKuuWTJG6/n4IxbIGZmfEIaNE9MA9dxYuH
 m6oWvlzBfpw01gGRrjtm4HMvqlt9inofDF2zN5MKylZh5LNN9Hm32mq4xN8uIxfqaGLN
 44s2rIAsbcqDVJMtPRriLBpBKeFO/BFOCGZjnY9j/zfdTZwq0xs0L+swe/S8V+UzO7CC
 CGux39NLB/50VNIyDI/OOlwXoz6YaY3wQuV60ZixuymziT9TYkXTEgGAtw/OQYfe6y38
 6vsvXccQhCdB90Vc31mMjaTR1DVzQPukuuWqNoVMtGKx0F5w7OTZ/Twbf73qVqgbvTUS
 9vHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722610498; x=1723215298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e/VuHi8HCpVaGQUBeXQ5vj7rlUpYLSoENN/sFJxhSHw=;
 b=q3ZpMUGld8SJQ0KLLiydz4UvH9YtfChBYaCmjiJtSO1Sf8lgEbPy300bLa2gSwuVZH
 VzoIhyZPPkoqP4FQNrnJGuAixxeG1wQey+2PtkysN2j3NmoBvpNWG43836jrd/Fsmw/O
 Ed329I72qMcsoRDQAXhzFoOP4lGBcoVKKVPdrRjUasuSgs1iGf5rTioJkhBKfXCAZa1U
 eGTUycnhfgnvBzzIQoE/3wSTFt6wKI/qSsDI5R4Qt1Hjr0cYDrc9YXSvIRqGQxdylsKC
 0XPv14yj0sKV+IPYcP1SaBaYwIhYF5SNHAZx+yYBT3RIGLqga41IfdA1ws4WQnj/WB5j
 J0Sg==
X-Gm-Message-State: AOJu0YxsIHdoHd4hJy24MGVxqgVbkh+ItBjcLjlFMtTvLu1u6XJmZKwe
 L90JzXqq1DHT3MCiRaMPwTod6g/mmhcJVTy08BT4r/cA6P62/iBWxoEMiT141NNCGXoKZF4Jdda
 T6Y4=
X-Google-Smtp-Source: AGHT+IFoBSPZtjftTvV1cgW54l3IXFDJC1iScLd4l9KhIUonX4gR0zCQFbpyGZ6+WZ1mpK29CFDB5w==
X-Received: by 2002:a17:902:e811:b0:1fc:7180:f4af with SMTP id
 d9443c01a7336-1ff572930a2mr28830415ad.1.1722610498083; 
 Fri, 02 Aug 2024 07:54:58 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff592aee19sm17920635ad.282.2024.08.02.07.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 07:54:57 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 4/5] qemu/osdep: Add excluded fd parameter to
 qemu_close_all_open_fd()
Date: Fri,  2 Aug 2024 16:54:20 +0200
Message-ID: <20240802145423.3232974-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802145423.3232974-1-cleger@rivosinc.com>
References: <20240802145423.3232974-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=cleger@rivosinc.com; helo=mail-pl1-x62e.google.com
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

In order for this function to be usable by tap.c code, add a list of
file descriptors that should not be closed.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 include/qemu/osdep.h    |   8 ++-
 system/async-teardown.c |   2 +-
 util/oslib-posix.c      | 106 ++++++++++++++++++++++++++++++++++------
 3 files changed, 97 insertions(+), 19 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index de77c5c254..4cc4c32b14 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -760,9 +760,13 @@ int qemu_fdatasync(int fd);
 /**
  * qemu_close_all_open_fd:
  *
- * Close all open file descriptors
+ * Close all open file descriptors except the ones supplied in the @skip array
+ *
+ * @skip: ordered array of distinct file descriptors that should not be closed
+ *        if any, or NULL.
+ * @nskip: number of entries in the @skip array or 0 if @skip is NULL.
  */
-void qemu_close_all_open_fd(void);
+void qemu_close_all_open_fd(const int *skip, unsigned int nskip);
 
 /**
  * Sync changes made to the memory mapped file back to the backing
diff --git a/system/async-teardown.c b/system/async-teardown.c
index edf49e1007..9148ee8d04 100644
--- a/system/async-teardown.c
+++ b/system/async-teardown.c
@@ -52,7 +52,7 @@ static int async_teardown_fn(void *arg)
      * Close all file descriptors that might have been inherited from the
      * main qemu process when doing clone, needed to make libvirt happy.
      */
-    qemu_close_all_open_fd();
+    qemu_close_all_open_fd(NULL, 0);
 
     /* Set up a handler for SIGHUP and unblock SIGHUP. */
     sigaction(SIGHUP, &sa, NULL);
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 9b79fc7cff..2636dcd1e0 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -808,11 +808,12 @@ int qemu_msync(void *addr, size_t length, int fd)
     return msync(addr, length, MS_SYNC);
 }
 
-static bool qemu_close_all_open_fd_proc(void)
+static bool qemu_close_all_open_fd_proc(const int *skip, unsigned int nskip)
 {
     struct dirent *de;
     int fd, dfd;
     DIR *dir;
+    unsigned int skip_start = 0, skip_end = nskip;
 
     dir = opendir("/proc/self/fd");
     if (!dir) {
@@ -823,8 +824,33 @@ static bool qemu_close_all_open_fd_proc(void)
     dfd = dirfd(dir);
 
     for (de = readdir(dir); de; de = readdir(dir)) {
+        bool close_fd = true;
+
+        if (de->d_name[0] == '.') {
+            continue;
+        }
         fd = atoi(de->d_name);
-        if (fd != dfd) {
+        if (fd == dfd) {
+            continue;
+        }
+
+        for (unsigned int i = skip_start; i < skip_end; i++) {
+            if (fd < skip[i]) {
+                /* We are below the next skipped fd, break */
+                break;
+            } else if (fd == skip[i]) {
+                close_fd = false;
+                /* Restrict the range as we found fds matching start/end */
+                if (i == skip_start) {
+                    skip_start++;
+                } else if (i == skip_end) {
+                    skip_end--;
+                }
+                break;
+            }
+        }
+
+        if (close_fd) {
             close(fd);
         }
     }
@@ -833,24 +859,68 @@ static bool qemu_close_all_open_fd_proc(void)
     return true;
 }
 
-static bool qemu_close_all_open_fd_close_range(void)
+static bool qemu_close_all_open_fd_close_range(const int *skip,
+                                               unsigned int nskip,
+                                               int open_max)
 {
 #ifdef CONFIG_CLOSE_RANGE
-    int r = close_range(0, ~0U, 0);
-    if (!r) {
-        /* Success, no need to try other ways. */
-        return true;
-    }
-#endif
+    int first = 0, last = open_max - 1;
+    unsigned int cur_skip = 0;
+    int ret;
+
+    do {
+        /* Find the start boundary of the range to close */
+        while (cur_skip < nskip && first == skip[cur_skip]) {
+            cur_skip++;
+            first++;
+        }
+
+        /* Find the upper boundary of the range to close */
+        if (cur_skip < nskip) {
+            last = skip[cur_skip] - 1;
+        }
+        /*
+         * Adjust the maximum fd to close if it's above what the system
+         * supports
+         */
+        if (last > open_max) {
+            last = open_max;
+            /*
+             * We can directly skip the remaining skip fds since the current
+             * one is already above the maximum supported one.
+             */
+            cur_skip = nskip;
+        }
+        /* If last was adjusted, we might be > first, bail out */
+        if (first > last) {
+            break;
+        }
+
+        ret = close_range(first, last, 0);
+        if (ret < 0) {
+            return false;
+        }
+        first = last + 1;
+        last = open_max;
+    } while (cur_skip < nskip);
+
+    return true;
+#else
     return false;
+#endif
 }
 
-static void qemu_close_all_open_fd_fallback(void)
+static void qemu_close_all_open_fd_fallback(const int *skip, unsigned int nskip,
+                                            int open_max)
 {
-    int open_max = sysconf(_SC_OPEN_MAX), i;
+    unsigned int cur_skip = 0;
 
     /* Fallback */
-    for (i = 0; i < open_max; i++) {
+    for (int i = 0; i < open_max; i++) {
+        if (cur_skip < nskip && i == skip[cur_skip]) {
+            cur_skip++;
+            continue;
+        }
         close(i);
     }
 }
@@ -858,10 +928,14 @@ static void qemu_close_all_open_fd_fallback(void)
 /*
  * Close all open file descriptors.
  */
-void qemu_close_all_open_fd(void)
+void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
 {
-    if (!qemu_close_all_open_fd_close_range() &&
-        !qemu_close_all_open_fd_proc()) {
-        qemu_close_all_open_fd_fallback();
+    int open_max = sysconf(_SC_OPEN_MAX);
+
+    assert(skip != NULL || nskip == 0);
+
+    if (!qemu_close_all_open_fd_close_range(skip, nskip, open_max) &&
+        !qemu_close_all_open_fd_proc(skip, nskip)) {
+        qemu_close_all_open_fd_fallback(skip, nskip, open_max);
     }
 }
-- 
2.45.2


