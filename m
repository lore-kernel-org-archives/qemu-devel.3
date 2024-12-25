Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3767E7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 05:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQKC8-00071w-3w; Wed, 25 Dec 2024 00:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tQKC5-00071T-NY
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 00:44:29 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tQKC3-0008Jd-Nh
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 00:44:29 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21619108a6bso54441715ad.3
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 21:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735105466; x=1735710266;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zAt3HH9n1Q4e0VDMLF4qELhaKJyL8RlrkODaMjrBVSc=;
 b=oSwxILHiylHH25z+5EbR/a792Cc6+KEgpnLWEB2mg1fyz2FsFZBxQZXR9ViVXt2Q0O
 gCeZzKF4BZ+Ajpk0g85g/ys7ODVchqptt/S/Yy5J9zIssydZXm46KjKjNu7y1es7lgVl
 p97WknmYtmE/zoPaYo2xzw+Ozssy8WAf8E8m+RCXKn9PD7iIMvRvGAHlrHliLRyIhzPd
 LPAzXjpfadWwiMwZaubGNlxz4zK5sXGprXicYSP7F6qtkP8GdLUDS7o0WVpdDAQN9JIS
 EHAs60dzlAoJh8lCDnu0t/De6NG0inV4opz13QHdDJIFqHLw/8f2h7CHYQ+lGBBxT3Uf
 18yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735105466; x=1735710266;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zAt3HH9n1Q4e0VDMLF4qELhaKJyL8RlrkODaMjrBVSc=;
 b=Z7w/dqqBGNNwFBOElaHCE+WudBe8qZ7gHC561UbuQX8LzLl178zgu+ILQk0jIgdwCE
 uXE5KGb6XShC+5XWOnKXVdLIY+ZycM4dTuQ0OoLSQKy+Xc/0GfMoPM1pnbJmnrrgbYY5
 Zi0H18ikF/quGSjFPvBu/kEnvxtBfCMdOAxZkrLBHBd/pAne6MSAypkWuNNx/1tdLrSl
 DgO/fQjQPI9/izTUrQcyrnOAoUo6EUMC/1kERpSqufIO7jIg9aEo9gsqDLdtcGTMopLG
 FjjFAU6uai/ChOA3RFldk8H2R/F/zURqcPrRoQ0zQKNf0Tqh1p28eeiJU3kO42b+4yvD
 o09Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRpR/MdiFy7J5FY7RXjkMLqexFEqK6qg+VD479oXRikZFvr88UupP1+3xudDe3sL/kNJZMkgnWbYTS@nongnu.org
X-Gm-Message-State: AOJu0YwpbhR66xjsA+AQxzZPz/OctdCMw5SqGYddI7UBe60Tv6UWJaSx
 +t3m8ziqDZuQp7idw59UR6KEdlP/0tfoNMxEIIRgYwdmNtxcR7o1/Tp0qBhSGyc=
X-Gm-Gg: ASbGnctgB1Ak8+Hoph3KwZmZCmVU+1nCvKkYokVOo3O+aNca7puf53jI/7YMlspKm7H
 C5CAWBthOBxegcB5KGIEBejGaKM4+XyGXyBb8Stj9fYLfpIBsmlEg7EEj5LsL+KFTf78nhFjTj5
 9dZQACFNEKbgQnUt+hFRq3pJNME453WBtJACFNcVz7qpiuVAO7Thhk67Es/iEnVdyxlBHYh6AeH
 VXwLI1LGNgE9SR4swi7qojiuB3iLG5MPLkOTBUFbrzp8n0id6shXHL9m2H/
X-Google-Smtp-Source: AGHT+IEC15ohGaoIdaRd2slbCHL8fkV2+MJGVukl9AVQbPL1+v3VFYd+I/HTkIqlUH5UDU/0Xvcfvg==
X-Received: by 2002:a05:6a20:d49b:b0:1e0:c7cf:bc1f with SMTP id
 adf61e73a8af0-1e5e0447f12mr30538920637.9.1735105466177; 
 Tue, 24 Dec 2024 21:44:26 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72aad8dd180sm10923398b3a.109.2024.12.24.21.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 21:44:25 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 25 Dec 2024 14:44:14 +0900
Subject: [PATCH 2/8] futex: Support Windows
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241225-event-v1-2-a58c8d63eb70@daynix.com>
References: <20241225-event-v1-0-a58c8d63eb70@daynix.com>
In-Reply-To: <20241225-event-v1-0-a58c8d63eb70@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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

Windows supports futex-like APIs since Windows 8 and Windows Server
2012.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 meson.build                       |  2 ++
 include/qemu/futex.h              | 52 ++++++++++++++++++++++++++++++---------
 tests/unit/test-aio-multithread.c |  2 +-
 util/lockcnt.c                    |  2 +-
 util/qemu-thread-posix.c          |  4 +--
 util/meson.build                  |  2 +-
 6 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/meson.build b/meson.build
index e0b880e4e138..083b6c45d240 100644
--- a/meson.build
+++ b/meson.build
@@ -798,11 +798,13 @@ emulator_link_args = []
 midl = not_found
 widl = not_found
 pathcch = not_found
+synchronization = not_found
 host_dsosuf = '.so'
 if host_os == 'windows'
   midl = find_program('midl', required: false)
   widl = find_program('widl', required: false)
   pathcch = cc.find_library('pathcch')
+  synchronization = cc.find_library('Synchronization')
   socket = cc.find_library('ws2_32')
   winmm = cc.find_library('winmm')
 
diff --git a/include/qemu/futex.h b/include/qemu/futex.h
index f57774005330..c22d756021c9 100644
--- a/include/qemu/futex.h
+++ b/include/qemu/futex.h
@@ -1,5 +1,5 @@
 /*
- * Wrappers around Linux futex syscall
+ * Wrappers around Linux futex syscall and similar
  *
  * Copyright Red Hat, Inc. 2017
  *
@@ -11,28 +11,36 @@
  *
  */
 
+/*
+ * Note that a wake-up can also be caused by common futex usage patterns in
+ * unrelated code that happened to have previously used the futex word's
+ * memory location (e.g., typical futex-based implementations of Pthreads
+ * mutexes can cause this under some conditions).  Therefore, qemu_futex_wait()
+ * callers should always conservatively assume that it is a spurious wake-up,
+ * and use the futex word's value (i.e., the user-space synchronization scheme)
+ * to decide whether to continue to block or not.
+ */
+
 #ifndef QEMU_FUTEX_H
 #define QEMU_FUTEX_H
 
+#define HAVE_FUTEX
+
+#ifdef CONFIG_LINUX
 #include <sys/syscall.h>
 #include <linux/futex.h>
 
 #define qemu_futex(...)              syscall(__NR_futex, __VA_ARGS__)
 
-static inline void qemu_futex_wake(void *f, int n)
+static inline void qemu_futex_wake_all(void *f)
 {
-    qemu_futex(f, FUTEX_WAKE, n, NULL, NULL, 0);
+    qemu_futex(f, FUTEX_WAKE, INT_MAX, NULL, NULL, 0);
 }
 
-/*
- * Note that a wake-up can also be caused by common futex usage patterns in
- * unrelated code that happened to have previously used the futex word's
- * memory location (e.g., typical futex-based implementations of Pthreads
- * mutexes can cause this under some conditions).  Therefore, callers should
- * always conservatively assume that it is a spurious wake-up, and use the futex
- * word's value (i.e., the user-space synchronization scheme) to decide whether
- * to continue to block or not.
- */
+static inline void qemu_futex_wake_single(void *f)
+{
+    qemu_futex(f, FUTEX_WAKE, 1, NULL, NULL, 0);
+}
 static inline void qemu_futex_wait(void *f, unsigned val)
 {
     while (qemu_futex(f, FUTEX_WAIT, (int) val, NULL, NULL, 0)) {
@@ -46,5 +54,25 @@ static inline void qemu_futex_wait(void *f, unsigned val)
         }
     }
 }
+#elif defined(CONFIG_WIN32)
+#include <synchapi.h>
+
+static inline void qemu_futex_wake_all(void *f)
+{
+    WakeByAddressAll(f);
+}
+
+static inline void qemu_futex_wake_single(void *f)
+{
+    WakeByAddressSingle(f);
+}
+
+static inline void qemu_futex_wait(void *f, unsigned val)
+{
+    WaitOnAddress(f, &val, sizeof(val), INFINITE);
+}
+#else
+#undef HAVE_FUTEX
+#endif
 
 #endif /* QEMU_FUTEX_H */
diff --git a/tests/unit/test-aio-multithread.c b/tests/unit/test-aio-multithread.c
index 8c2e41545a29..0ead6bf34ad1 100644
--- a/tests/unit/test-aio-multithread.c
+++ b/tests/unit/test-aio-multithread.c
@@ -330,7 +330,7 @@ static void mcs_mutex_unlock(void)
     /* Wake up the next in line.  */
     next = qatomic_read(&nodes[id].next);
     nodes[next].locked = 0;
-    qemu_futex_wake(&nodes[next].locked, 1);
+    qemu_futex_wake_single(&nodes[next].locked);
 }
 
 static void test_multi_fair_mutex_entry(void *opaque)
diff --git a/util/lockcnt.c b/util/lockcnt.c
index d07c6cc5cee4..ca27d8e61a5c 100644
--- a/util/lockcnt.c
+++ b/util/lockcnt.c
@@ -106,7 +106,7 @@ static bool qemu_lockcnt_cmpxchg_or_wait(QemuLockCnt *lockcnt, int *val,
 static void lockcnt_wake(QemuLockCnt *lockcnt)
 {
     trace_lockcnt_futex_wake(lockcnt);
-    qemu_futex_wake(&lockcnt->count, 1);
+    qemu_futex_wake_single(&lockcnt->count);
 }
 
 void qemu_lockcnt_inc(QemuLockCnt *lockcnt)
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index eade5311d175..13459e44c768 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -345,7 +345,7 @@ static inline void qemu_futex_wait(QemuEvent *ev, unsigned val)
 
 /* Valid transitions:
  * - free->set, when setting the event
- * - busy->set, when setting the event, followed by qemu_futex_wake
+ * - busy->set, when setting the event, followed by qemu_futex_wake_all
  * - set->free, when resetting the event
  * - free->busy, when waiting
  *
@@ -400,7 +400,7 @@ void qemu_event_set(QemuEvent *ev)
         smp_mb__after_rmw();
         if (old == EV_BUSY) {
             /* There were waiters, wake them up.  */
-            qemu_futex_wake(ev, INT_MAX);
+            qemu_futex_wake_all(ev);
         }
     }
 }
diff --git a/util/meson.build b/util/meson.build
index 5d8bef98912a..da5b49f1ea82 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -25,7 +25,7 @@ else
   util_ss.add(files('event_notifier-win32.c'))
   util_ss.add(files('oslib-win32.c'))
   util_ss.add(files('qemu-thread-win32.c'))
-  util_ss.add(winmm, pathcch)
+  util_ss.add(winmm, pathcch, synchronization)
 endif
 util_ss.add(when: linux_io_uring, if_true: files('fdmon-io_uring.c'))
 if glib_has_gslice

-- 
2.47.1


