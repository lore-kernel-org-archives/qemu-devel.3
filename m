Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1FEC5B543
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 05:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQPC-00071q-6m; Mon, 26 May 2025 01:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQOw-0006yy-3e
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:29:30 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQOt-0001x9-Vi
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:29:29 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-74267c68c11so1149539b3a.0
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748237366; x=1748842166;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PBZfXv948HfseffVRyzxzpmxhQPEU+TqtO1OogUChiE=;
 b=w9dWtm/lfTnhCLoGrN9Toao5NOZ3/M4OBGc7UPscM3ePJn+T2QGlw1LMdQLbE2k7Hw
 Bm0/r35JgyaIpzUODnPkTqrf+8RKkLorqKV15Uueb2ZDJgjxxKnYjPJ1bxOq+VByjjzn
 rODybUUiCPUSXA3yMLeBYOZTT28vrpAWGUexNQ2i0RdKVO0OsmKdHIbCKrzI+RZQUINM
 0dQlc4tHe/O6kXFx9dQFE8qXm1+CAvWuYM0GK/CccwqkCHf1hxo1ShLBmhZb2samLGUL
 CSUrQ2w7V9pOn4f14NWNT5d+Mi+srVybwMmdf9iiDfvwuoVyvOZ2kcNQ9OL70EiUN11q
 TLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748237366; x=1748842166;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PBZfXv948HfseffVRyzxzpmxhQPEU+TqtO1OogUChiE=;
 b=nl/uzFB1vNJ9EaWleU+DL3W5Vof/lvbv8nAcpQHSaAPMD4zbqD4vprsNWbGNnEBTHF
 c0J/hql7uiRvMq3XSs+RuymrkrqrZ6GKUeGYwToWFk9s5fSQdiJsfqaE9CuEUSKLKNrW
 qjStY6dYzRs+NNYFPKaqcUEBO4450LyDcIH6WHQ8ADzUKUHEGTJtV81IXET+h/G+4pga
 Zlk9dsvDMdAQ7eEgnxA0X8Gpuzoga7GdKSJZX8qug7p+8D6hWUqqrUNNZl+KjXJxLeum
 8QtvyAQpAljAHkvD+nVuu9oJ9jdlDr+q8eMyE+F1CPa3jUcFJ0qR8LOXFJfkcjVmTynm
 wclg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt4L1ZG7V/2ELv8F3LttGN5lJPTKz8W6A3U+uNMTSWLQ72rqJM2eVDW4ZPJrh/byl3FkGbJVc2oW+Q@nongnu.org
X-Gm-Message-State: AOJu0YzcZDQpi4fx3lRALnd4koQ8X+8J1ouIGUqaPzfO3tCiimKhgJjV
 ishpaHJiEqJvui5j5RLRkknmB9oSPKfiVd74fsTl39AMopaoxMeC0rXUo5EvmsVpb8LBcgI9TCl
 NTuME
X-Gm-Gg: ASbGncu7sr+20/qeRsC7EmjRdrMMFp8JTuh9TRhda5z8gPlVJj+iCD2x96jWCAfI4XN
 8AzAozEtWvUCadxYoQLprUkSXPd+uorGo3DwjktJhf349f/BZukXzoAunS0q2yTKoVma81gXR0o
 oyhASGrFHqvLwQCcv7ghxLx8hgVM9WUeXF4bP0JlPm8mToHXM608paK9Y/DUOsl2tk5THFUIPZs
 yQP7SdakovQbdXWefVOuZFjMNnlDOmm/ZVVfNM/I0EJuCfqnRT+I20PrlzqzlyunN4RC7NY59tN
 QV04Q062ZLsiQQ5IwRUFrzcJwG6DM2dCUOscimX3ZvFSI1ABl/Zz
X-Google-Smtp-Source: AGHT+IFtn+lHZzY0SuaRGyutdLFj1Dvy+moWDSbrdegdL7QybXmPdUcMMP5rq1aBg4Zq6GCgVhqQ6Q==
X-Received: by 2002:a05:6a00:2443:b0:736:50d1:fc84 with SMTP id
 d2e1a72fcca58-745fe05709dmr12336819b3a.21.1748237365744; 
 Sun, 25 May 2025 22:29:25 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-742bab0bc35sm14896335b3a.13.2025.05.25.22.29.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 22:29:25 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 26 May 2025 14:29:12 +0900
Subject: [PATCH v4 02/11] futex: Support Windows
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-event-v4-2-5b784cc8e1de@daynix.com>
References: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
In-Reply-To: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
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
index ad2053f968b8..d865a2ff778e 100644
--- a/meson.build
+++ b/meson.build
@@ -837,11 +837,13 @@ emulator_link_args = []
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
index 04fc3bf2298e..4d6f24d705c7 100644
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
@@ -396,7 +396,7 @@ void qemu_event_set(QemuEvent *ev)
     if (qatomic_read(&ev->value) != EV_SET) {
         if (qatomic_xchg(&ev->value, EV_SET) == EV_BUSY) {
             /* There were waiters, wake them up.  */
-            qemu_futex_wake(ev, INT_MAX);
+            qemu_futex_wake_all(ev);
         }
     }
 }
diff --git a/util/meson.build b/util/meson.build
index 1adff96ebd51..5735f65f1994 100644
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


