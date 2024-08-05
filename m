Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AADEC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 00:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saldk-0008Kp-44; Sun, 04 Aug 2024 20:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saldi-0008GK-Vs
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 20:31:55 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saldh-0002K0-74
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 20:31:54 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70eb73a9f14so7496153b3a.2
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 17:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722817912; x=1723422712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9loKzQW0fz51/k/WMOHKeqW5+iqLnIhl+VnJpSdO5ZI=;
 b=z8JohOe5JP8EdqkOEMIzg7roJLJ9w0DnhGtYH8RzmrDAWxQvQ4k1XqMLV4P200wwa+
 S6DyzEpIMYkiJHO4q9+EAUbdyo7bHnQZx2dlYZHArmmGI20cvOy5TJOdeAz7A0j71XAy
 JRsxlT6YiXG4iyw6wC8dUKoBbecSUdR2LplJ43k6Ov96TGhi2dBSvA7liIt0DECxi6HC
 aVLGAJG2HS9HCz8q59h/76IO6DPGFqiqtTNAyX+Fp+iQhZCetuDygh7x1NaKpn3TDmt/
 dBFLDyd2cwpYnkf59vP4f0/5M+lYHL614CaagUD0z3SJukXW6X99nnjvYs+cJbk06NnQ
 WCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722817912; x=1723422712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9loKzQW0fz51/k/WMOHKeqW5+iqLnIhl+VnJpSdO5ZI=;
 b=nXUNWaoQNbu1N8j3dOBOoZ+uOBXvSQemn1M3bgNXWD6ovOqlSVyw1mDHxfL3tOcag9
 c9/0SpcgtgQQvCBab7TUMRLxU3PIq27gjOyfeSgRcQN1sppipaFZjjKNvyaajdBlXC83
 0XURflMuq/6b4iIHz7inxub4m2qrQMpkWmoA75jOMTKNGmpcbLDf9aC00fpiulCcDOyh
 PYu1Yi2VJPpLjSf0kr+uQf3fv4R2x6uggyB7TZhPge7GPE5Vw5grlhlD3LDycM/HKCc3
 8RhxLrozBwnhTbNAdaEFS99rroH4aqxkt/RO1nNTtaWLVY17sc9Q5rzfBjqiiuBbY+Pu
 Ad3w==
X-Gm-Message-State: AOJu0Yyehg4RrOKq5QcReITwmAuj/ymPgY2LvAKu5PW0RDQ9qh+BX8x/
 l2coECoFi3G9xWp0nNgrbpQHnhvnlN+rUbRVACy+wSSCEiG6tED7cJBnQP80ls9HT7V7G6jask6
 gnIRLSA==
X-Google-Smtp-Source: AGHT+IEvdMNgPGsehcKqxCVF7owcv9eNvXWwTqHmDDWT5K9tnLJhGkLLkBmAhXEYjFBIwLm4jyAdXw==
X-Received: by 2002:a05:6a00:22d6:b0:710:591e:b52f with SMTP id
 d2e1a72fcca58-7106cf933f9mr13521120b3a.5.1722817911689; 
 Sun, 04 Aug 2024 17:31:51 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ed16cb3sm4576038b3a.179.2024.08.04.17.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 17:31:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
Subject: [PULL 5/6] qemu/osdep: Add excluded fd parameter to
 qemu_close_all_open_fd()
Date: Mon,  5 Aug 2024 10:31:28 +1000
Message-ID: <20240805003130.1421051-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805003130.1421051-1-richard.henderson@linaro.org>
References: <20240805003130.1421051-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

In order for this function to be usable by tap.c code, add a list of
file descriptors that should not be closed.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Message-ID: <20240802145423.3232974-5-cleger@rivosinc.com>
[rth: Use max_fd in qemu_close_all_open_fd_close_range]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/osdep.h    |  8 +++-
 system/async-teardown.c |  2 +-
 util/oslib-posix.c      | 98 ++++++++++++++++++++++++++++++++++-------
 3 files changed, 89 insertions(+), 19 deletions(-)

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
index 9b79fc7cff..11b35e48fb 100644
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
@@ -833,24 +859,60 @@ static bool qemu_close_all_open_fd_proc(void)
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
+    int max_fd = open_max - 1;
+    int first = 0, last;
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
+        last = max_fd;
+        if (cur_skip < nskip) {
+            last = skip[cur_skip] - 1;
+            last = MIN(last, max_fd);
+        }
+
+        /* With the adjustments to the range, we might be done. */
+        if (first > last) {
+            break;
+        }
+
+        ret = close_range(first, last, 0);
+        if (ret < 0) {
+            return false;
+        }
+
+        first = last + 1;
+    } while (last < max_fd);
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
@@ -858,10 +920,14 @@ static void qemu_close_all_open_fd_fallback(void)
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
2.43.0


