Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0D6C3ABCB
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 08:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDfwI-0006Ea-WE; Sat, 10 May 2025 04:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDfwG-0006E9-Ip
 for qemu-devel@nongnu.org; Sat, 10 May 2025 04:52:08 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDfwE-0005cY-LP
 for qemu-devel@nongnu.org; Sat, 10 May 2025 04:52:08 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-30a89c31ae7so3854296a91.2
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 01:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746867124; x=1747471924;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vkvPmDiOAPYnCtcN0QwQoM7DvKQdYVk9JaH5fbJhHro=;
 b=a2t4Uvr7qTaj/7VO1vo+FO7clRHEQQkUDEMNjThK1rd2Cj6PUoJUny9us3Wxawc88j
 DV5r7m51ReRHW4Uzo5zE3RrxmxWYO2QlMbhl0epwn0M2kxFkOnoMuSyfTapXTv++urkr
 FAUbcucwkXvqV8qoTK44DJ/jMA7cKg3qSJLnblxNFxtK/2h5+uVWNbxVJd8zEQNUZhQj
 Cfa6SIukjSQMAnm/L1vQwvEIYPwYtrmiXHBtIsx36I9I8Oc85Gy15zQFVUOg6s1EjZdw
 h0XJcd5X2AKVTVEM/ZmSLjcRYKl5Rvy8vNHj3drYR/LVSOqHjcePQYkI4XWP2A/sVc5/
 j6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746867124; x=1747471924;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vkvPmDiOAPYnCtcN0QwQoM7DvKQdYVk9JaH5fbJhHro=;
 b=m9BAIcdJ23hvGAC7xBspqlHO7NMyKpwF4rkBxkJx14ZHcNuaY1h1HcSYHz8a2kT8nk
 aqzWR34qc5PgdCek8mS+XmidL0j6kAQguVPdBsaBkH+ea3OVIN9fiAupQQSyI2ErXT/u
 VgFdvxPOF76+/qCKsTheuVxKoOaYtkCYKkqJlRaAiS+6VthporTcY0/p4R8meTeMMjOb
 RWlwC3j0wDFZfWO9FPCu9y87TMhAp7xvd91UYBuyAVYXjpkgRxwAeyYysYwn2CuFLvoS
 DDvef87s30sby8j0n8GOc6D2N9/CjQOzVK/0Y7HjR2/mGe6HvFfbZbCrt/Wc/b0ES/RW
 2y7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf30Zmd0duprM9zzhIM3hhtK83rDAp2mZjNpa42BmcTI0WN6qlYSXnxYxb6VWlUmhusDzqNhbM+2ZE@nongnu.org
X-Gm-Message-State: AOJu0YwuRmGcunYSnKMhqUT0iQNXYMQOMIDRAxpjcOB1QULGu0WhYrDq
 dcqpQpzKIF9we9sG+Qp/AbclRkOglWOMuuFFdGN+D9YBXU02XTud+yWkPEvrkTVuPGQoiqEabg3
 A
X-Gm-Gg: ASbGncsUUxdR8+GCvEUQdTn8ERcnlKhh19b25h8HkeX/jJgnEVOx1vybglqm78tKmln
 raoOjuxcelQ4sZHWxETQHUK2NkjN1Wh7CwHe/PV0eV2guOkk1JyRev8I1NJuCg8SwZ0Iy5jSbA4
 N0wHlPGSsRE0FjyB1lMTetNOv+46oYN5TsBqzX28CHwQ7M1BKfiAVBhNFnjipLJiGrG/yVagmUo
 mKbMtsgxDoSheHPGtnDhHqss1QWc3xAX5FsCnC9+bNqq8i4HOk58/Ocb3cIQqFHsQTS7hoGB3+v
 TL+YNXNbnfz5pKp/lsdJB22L6H46zYRjc//DNwEig7CFftIBUlwLmI4=
X-Google-Smtp-Source: AGHT+IGuUl9CocnSGMpQiz4AKnFyFHBw/tMcmvbAJJrAkHZYlzCXV/zOZ4C5IVSU6/NljY81fTgzDQ==
X-Received: by 2002:a17:902:c94f:b0:224:f12:3734 with SMTP id
 d9443c01a7336-22fc8c8cbb7mr81457235ad.30.1746867124650; 
 Sat, 10 May 2025 01:52:04 -0700 (PDT)
Received: from localhost ([157.82.203.223])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22fc828f96fsm29326445ad.197.2025.05.10.01.52.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 01:52:04 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 10 May 2025 17:51:47 +0900
Subject: [PATCH v2 2/9] futex: Support Windows
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-event-v2-2-7953177ce1b8@daynix.com>
References: <20250510-event-v2-0-7953177ce1b8@daynix.com>
In-Reply-To: <20250510-event-v2-0-7953177ce1b8@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102a.google.com
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


