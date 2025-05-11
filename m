Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAF2C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 06:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDzrw-0002Cn-VH; Sun, 11 May 2025 02:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzru-0002CD-8x
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:08:59 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzrr-0003s3-IF
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:08:57 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22fa414c497so40362325ad.0
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 23:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746943733; x=1747548533;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zveZBuPtk3zGBEEgYVqGSXDbx7e0Rl6JL+tYwpwf9WU=;
 b=3KUOOYvnKU2ZOzgyNgFps0cohLiPBYx0ay/w2j00AUpNwE8u9124LRwvzL52ZXl2+S
 r8P+nWZMPEeqjPG9sOewZm+KG0fqKNXE8jCZrOfLNxGByJrDOjoi3E/rAJ9cWv7Xe86O
 m4EPbsl3KPa22BQ7SmvYpmOMDChPU1Bmji22Md+ckxzt4CA4yhEzP4+RXYm9ckjhP2BY
 mkawrm8ze55UZ0WqPxx3eG2XYrjImFie+RQNblh7biNEskx5zV6ybhRqhYwrIWRE+Qqb
 RLcrvHHOfojA/+RrKY6IemDkCcMLz3n0gOkmb5LMKAhEDzihtgQeRptrFoNewE5AcCFY
 diEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746943733; x=1747548533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zveZBuPtk3zGBEEgYVqGSXDbx7e0Rl6JL+tYwpwf9WU=;
 b=HRbFWUVKHvGJX4j9eDkmDAJl2MjYHVJ7pOU6hxH/m3V3joDHxPjTr5rlphj6xBE3tl
 BdWCHku02nIXjcNZKvNhJMDXRAZ1g9fL1x88FxnTCb2H/urAR3+TK3IkK7iYk1RhkrJx
 m7Q29+fAnYlxn46v/L+PrIIqZpRoMVYlfi0KKM264jaoZIWcuF9k3XNeqGwbGPjs+ytb
 aGM2xJmwm1OKrG0N2l07iIzEHCh6Qj7oU1wCH4dtvjG6qmzqGsuDMpvtEEvdneepy3LP
 DxUkFl1RcSVWkkGYUqGD4MdnCEusZeCAIDSkwIM+htgQ5GUTEt4N1gC+Sz0azw4tC0da
 Dt5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdVrh5bNpObWAxdJnztZDqiplkoNiuxpvUyKWN3NBram+RSrT0vlC1u/GbC1DSA1xPxu1D1ewdtFCi@nongnu.org
X-Gm-Message-State: AOJu0YxgDO3xwYfQXzIyOmI8LHBnD8VrwJRYrpn8/fmC9SSZ/PvFglQV
 qUPN1wbF8jYLDYQNgyz7LkNXw8rKfk7VAPyLsK5aThkSmexrAyDPshex9ME8lsw=
X-Gm-Gg: ASbGncvCAhzmdYNvYwYLqKLdr0E34l41L1dU4zQUbJhxFfMh/MGE7sVXyFAATfZSTSV
 LdvSjEZ/QEAEvJSaGv6rmbt1KQegPw9SZskw1NNgf87WzxnBYh9VFN6tgs6C75ILO3p9gsw2BE5
 UOYcxhx3Xzz8UWGl6n7xP8P3CIqBza04KdN3EwEAlxd4HwG2OuWjJbOfzfzBS+zjUdy3PRboJLi
 lR7dE1ISVjdCI8XBtBixP8wOUZxYsSiYv7pZfLF/JznUkk9ATNY+cwIiLLc7DqEYdh6gsJKnXV9
 vvffRE7Kzzuv1wqepodc2b4rp92XN2UDHu6c4G6lVZsGcdfQvvHldgSea2d+2JSL4Q==
X-Google-Smtp-Source: AGHT+IHDXS5CY88ycLwY3Fq5oMAx4VJgHuJJ2Jr7OqWlVPS/ade/D03qb/ggsHTFKz8d1VespOlxkg==
X-Received: by 2002:a17:902:cf06:b0:21f:564:80a4 with SMTP id
 d9443c01a7336-22fc9185dcfmr111730615ad.33.1746943733315; 
 Sat, 10 May 2025 23:08:53 -0700 (PDT)
Received: from localhost ([157.82.203.223])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22fc828b4d9sm40986955ad.191.2025.05.10.23.08.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 23:08:53 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 11 May 2025 15:08:19 +0900
Subject: [PATCH v3 02/10] futex: Support Windows
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250511-event-v3-2-f7f69247d303@daynix.com>
References: <20250511-event-v3-0-f7f69247d303@daynix.com>
In-Reply-To: <20250511-event-v3-0-f7f69247d303@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, 
 devel@daynix.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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
 include/qemu/futex.h              | 53 ++++++++++++++++++++++++++++++---------
 tests/unit/test-aio-multithread.c |  2 +-
 util/lockcnt.c                    |  2 +-
 util/qemu-thread-posix.c          |  4 +--
 util/meson.build                  |  2 +-
 6 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/meson.build b/meson.build
index 27f115015285..11d42e4a7d39 100644
--- a/meson.build
+++ b/meson.build
@@ -835,11 +835,13 @@ emulator_link_args = []
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
index f57774005330..607613eec835 100644
--- a/include/qemu/futex.h
+++ b/include/qemu/futex.h
@@ -1,5 +1,5 @@
 /*
- * Wrappers around Linux futex syscall
+ * Wrappers around Linux futex syscall and similar
  *
  * Copyright Red Hat, Inc. 2017
  *
@@ -11,28 +11,37 @@
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
+}
+
+static inline void qemu_futex_wake_single(void *f)
+{
+    qemu_futex(f, FUTEX_WAKE, 1, NULL, NULL, 0);
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
 static inline void qemu_futex_wait(void *f, unsigned val)
 {
     while (qemu_futex(f, FUTEX_WAIT, (int) val, NULL, NULL, 0)) {
@@ -46,5 +55,25 @@ static inline void qemu_futex_wait(void *f, unsigned val)
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
index e5cd327e2767..c756558d6763 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -27,7 +27,7 @@ else
   util_ss.add(files('event_notifier-win32.c'))
   util_ss.add(files('oslib-win32.c'))
   util_ss.add(files('qemu-thread-win32.c'))
-  util_ss.add(winmm, pathcch)
+  util_ss.add(winmm, pathcch, synchronization)
 endif
 util_ss.add(when: linux_io_uring, if_true: files('fdmon-io_uring.c'))
 if glib_has_gslice

-- 
2.49.0


