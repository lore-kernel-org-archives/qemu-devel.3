Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A0AC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 05:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKW5p-0002xG-Am; Thu, 29 May 2025 01:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW5k-0002wG-C8
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:12 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW5f-00039U-C0
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:12 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso574147b3a.2
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 22:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748497566; x=1749102366;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PBZfXv948HfseffVRyzxzpmxhQPEU+TqtO1OogUChiE=;
 b=0Nypep0+IjHwWNFjdiLVI1kUSUBna5YD4hNSui8aMjcTT3Tz2ybFw883a4LW1BQkCC
 Q+yylvFnKUh650JuA5z40WWH4mIE/s58mqxgc3+dNA2q9zJHMYxADOcH6vDoxtvSkhcP
 veykJMl93KpCUHwJEBTjdE98Fnqv6bbnmXrmWWaiAzce8bT4aIc3Lfj0Q5WAC4GvjFz6
 eBvbB4dnslqW0SkCzYhdIqRng5e5BU5oMzxBvIfkUa/LMzv9Abja/swcJDixBQq3VGMj
 RilFt4vQpTni9fdta45blAvo8Pql8MAD4mv8jESBo4RoRoB1l+T3SM5Gz+2F/3Q2vdfA
 /+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748497566; x=1749102366;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PBZfXv948HfseffVRyzxzpmxhQPEU+TqtO1OogUChiE=;
 b=ZxdiGAgCY4kwIs0o6CtPN/HL4trJvNT2JqhSNjotU4JW5e4xGhnSFb2OAZLvgcL2fb
 KoMrW2DDg0CPAY7aAhGEhAw3moHSjh1X9dwIJUYBzmtA4I7RNjKDlovlRiTC3sKIc5/L
 lb7jIpE7M+LDtXLyEt9sByjqMbou0S+6mDv4Z/76hQiueLXVZHPbb5ARWJZ5aWGaNMK4
 OQwpQi8m8/NIVLQ4Ij5GEVzKiyu9UNIYCNjEO2HcM0y24UKkW2tLNNmXb2/XWahqKvxb
 aPIdWqDh4fzqPkEJa2oblI5nh4dMUdbrebNL8iQxV84vEi71VA6tLkfuhOvuUB8T4k3T
 nFsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPPAZcQeAd/UNLo3dvOjIyonyXlGnGuXvoD6c7/1GX14ynbzQaqwRXBsgytd68JhZqEcMLut71h7tt@nongnu.org
X-Gm-Message-State: AOJu0YxYhwjQLdLml35ZHIJQp1NiPRZNNhG/bkE4JKSWr4rCsKQqhpbV
 Pg/6hii+HT0Pmr4DEndyWEqHQ+LmjFvOeYnws6/+dGvGBRMcZ3K5v/IM5MbXlX3hSbQ=
X-Gm-Gg: ASbGnctXNXGzmMy+gBWURNFVGfgvUwEogH5u5HqP6rVcw0uiRO4ikxHY1sdviwBQJST
 dKz1JvhK7sa/hjhJt8kMfcTcJqxe/MwXhBvVGJ/Qv/mUNfGqTTULdnyDSbBMvYoFz8bgSOR1jeW
 ZSAfMT7yFJHUJCrcy9x2R5OyhiP0b8Zk2qAiuZNVrz+3PfpN6sEgMQM/WG5sGulZU5noQbcNcej
 PdMyQUD+vwXJGDiJdN9ldnfwL8WJ9X4LaZeaM26iPNGFjD4967asLeco31e2f1soj7IbKeN63Mq
 Pbt4dZvhzpDVaFHfUn5/ZgSlkUk+CKk6kFp2rWd8Us1javwIWNkS
X-Google-Smtp-Source: AGHT+IF4Rh/S5ZiauhCJpQWBQujyCnsuxddNt32oEpEKm3yf87/C3KxHcdUbaQR9pOtHw93XZiAaJA==
X-Received: by 2002:a05:6a00:2289:b0:73e:30dc:bb9b with SMTP id
 d2e1a72fcca58-747b0c8d05amr1354880b3a.2.1748497566010; 
 Wed, 28 May 2025 22:46:06 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-747afff72a5sm563313b3a.170.2025.05.28.22.46.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 22:46:05 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 29 May 2025 14:45:51 +0900
Subject: [PATCH v5 02/13] futex: Support Windows
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-event-v5-2-53b285203794@daynix.com>
References: <20250529-event-v5-0-53b285203794@daynix.com>
In-Reply-To: <20250529-event-v5-0-53b285203794@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
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


