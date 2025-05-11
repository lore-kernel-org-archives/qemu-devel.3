Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D3DC3ABC5
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 06:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDzs8-0002EP-Ea; Sun, 11 May 2025 02:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzs7-0002EA-4R
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:09:11 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzs4-0003up-Ho
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:09:10 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7406c6dd2b1so4124361b3a.0
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 23:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746943747; x=1747548547;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2ROcRo5lRkpHeGga5i/5rAD10k/YOPwsQfA+djJP2tA=;
 b=071pZoyxua1Pu2gebDqAYhqwLPO44hTjRPkIMv/o9TB8SjlXETnaJr1hFf2WoAr7gQ
 R4A5U5zVK4ZY77m5pBy+LIEovOx9xLHqZ4KtMI+qQmZlCcjD0x+NWYxUM7TANpzGX0t0
 4ZhvbfWVAPv72z9miaJ5wBGvKAxm1UV9EB8r/9fXx9ILsCP5QamL1ahY9Uki4ZMwkHzo
 Cibmv186by+ElH2YHgqBACwpoi/Q8dhoEaVQyCO2fk7xBAFl4TzxFIQveZol4SnBfv+Q
 +n6p4Qb/qxqtBRNo6+OWn0vUmKehf+N0f6lzhl7Wda63yUTHoFZtLVLL+xDZQsqIcz2n
 UHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746943747; x=1747548547;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ROcRo5lRkpHeGga5i/5rAD10k/YOPwsQfA+djJP2tA=;
 b=Hju9jnXQJDEzDTmwkw+LXBCkQUxkRhaMPUv0IRxDUK6iRoJkxqOKyPA+YI875GB7Qw
 efD+rMmht+9sbiRw005NnrCivPTX+YqKJh5/5AiAaguMuAmeTGPAhd+RzI68sGSSf8rI
 eAD5VAMJsZ4IBiiVP88suhxJEfut4ppCppRjY92M+KwAI3387WyPTQ32/CBioYvpZd4N
 pU7kiZ9WCwguwN3i04hS35b+1Csqd1JuYYmAK1B6E7Nax/vmrubdnfkcOTVFpz9XCAYL
 hp6cj0BdWp93X1emgqzSa6+0C8HaCIu3Bmkd93dyrAn4BT4Oxa8M7Q9mNLS3/30nM99a
 tmeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGDTszN/k/xUyGoFYU+Apoeny9wSUrbTLrP7g8GGCurThFrWl/D2qWpg+aE7qoygXZzJxKKuK6QHTc@nongnu.org
X-Gm-Message-State: AOJu0Yz3CQxi2DWoYi9GEcgRPZ5JTdFye+Lp1H2QpBwgG7DT2dry0Dqa
 LMhURn9eqQU5PjwAeqRh/I4U6GjzeqimtKAch9fgk91AIquvXmCE+CkCiX4IGEM=
X-Gm-Gg: ASbGnctQjgFAvakWf/PUBsK/Ck2oUsH3Ccfraiwyjm+AkGLdILzSG8qKrseqavqLar1
 xZ2d9+0niDblLi+fW94noeTu5kw/GT2kYWuGl+O0yWjurAsT3T7iAJKpy2RCGbP/9toirufXo0W
 LfTnIC354KVGZcMHOFXu+2tx22x6Y0aI/4JFAwxbJnDneSZfRWmNPBrHcHDP6JljlxDCghpg3kB
 2Jg5pk53qeU5C9ednP1siRD1FYrNfBjItOfeUxJysPkeymD/xzMlmYai/R14eIzUeuNh/8LkMsA
 W8PWPUmgeYUBMvkbh+RXXUADZZQyep7lXjClZtDYqtSD9qPmUbAdY1g=
X-Google-Smtp-Source: AGHT+IG8a6hyVJ6PSj9WMjgh2PR9D5WAjm0uvxVOdkqBrtq5wCIza7CblpXPznSKomPiXD7vYVAS+w==
X-Received: by 2002:a05:6a21:32a9:b0:1f3:20be:c18a with SMTP id
 adf61e73a8af0-215ab579af0mr11378190637.10.1746943746908; 
 Sat, 10 May 2025 23:09:06 -0700 (PDT)
Received: from localhost ([157.82.203.223])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-74237704630sm3374944b3a.22.2025.05.10.23.09.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 23:09:06 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 11 May 2025 15:08:22 +0900
Subject: [PATCH v3 05/10] qemu-thread: Use futex for QemuEvent on Windows
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250511-event-v3-5-f7f69247d303@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
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

Use the futex-based implementation of QemuEvent on Windows to
remove code duplication and remove the overhead of event object
construction and destruction.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qemu/thread-posix.h |   9 ---
 include/qemu/thread-win32.h |   6 --
 include/qemu/thread.h       |  11 +++-
 util/event.c                | 148 ++++++++++++++++++++++++++++++++++++++++++++
 util/qemu-thread-posix.c    | 147 -------------------------------------------
 util/qemu-thread-win32.c    | 129 --------------------------------------
 util/meson.build            |   1 +
 7 files changed, 159 insertions(+), 292 deletions(-)

diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h
index c412623a9143..758808b705e4 100644
--- a/include/qemu/thread-posix.h
+++ b/include/qemu/thread-posix.h
@@ -32,15 +32,6 @@ struct QemuSemaphore {
     unsigned int count;
 };
 
-struct QemuEvent {
-#ifndef CONFIG_LINUX
-    pthread_mutex_t lock;
-    pthread_cond_t cond;
-#endif
-    unsigned value;
-    bool initialized;
-};
-
 struct QemuThread {
     pthread_t thread;
 };
diff --git a/include/qemu/thread-win32.h b/include/qemu/thread-win32.h
index d95af4498fc9..da9e7322990c 100644
--- a/include/qemu/thread-win32.h
+++ b/include/qemu/thread-win32.h
@@ -28,12 +28,6 @@ struct QemuSemaphore {
     bool initialized;
 };
 
-struct QemuEvent {
-    int value;
-    HANDLE event;
-    bool initialized;
-};
-
 typedef struct QemuThreadData QemuThreadData;
 struct QemuThread {
     QemuThreadData *data;
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 6f800aad31a9..573f8c9ede20 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -3,13 +3,22 @@
 
 #include "qemu/processor.h"
 #include "qemu/atomic.h"
+#include "qemu/futex.h"
 
 typedef struct QemuCond QemuCond;
 typedef struct QemuSemaphore QemuSemaphore;
-typedef struct QemuEvent QemuEvent;
 typedef struct QemuLockCnt QemuLockCnt;
 typedef struct QemuThread QemuThread;
 
+typedef struct QemuEvent {
+#ifndef HAVE_FUTEX
+    pthread_mutex_t lock;
+    pthread_cond_t cond;
+#endif
+    unsigned value;
+    bool initialized;
+} QemuEvent;
+
 #ifdef _WIN32
 #include "qemu/thread-win32.h"
 #else
diff --git a/util/event.c b/util/event.c
new file mode 100644
index 000000000000..20853d61a7cd
--- /dev/null
+++ b/util/event.c
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu/thread.h"
+
+/*
+ * Valid transitions:
+ * - free->set, when setting the event
+ * - busy->set, when setting the event, followed by qemu_futex_wake_all
+ * - set->free, when resetting the event
+ * - free->busy, when waiting
+ *
+ * set->busy does not happen (it can be observed from the outside but
+ * it really is set->free->busy).
+ *
+ * busy->free provably cannot happen; to enforce it, the set->free transition
+ * is done with an OR, which becomes a no-op if the event has concurrently
+ * transitioned to free or busy.
+ */
+
+#define EV_SET         0
+#define EV_FREE        1
+#define EV_BUSY       -1
+
+void qemu_event_init(QemuEvent *ev, bool init)
+{
+#ifndef HAVE_FUTEX
+    pthread_mutex_init(&ev->lock, NULL);
+    pthread_cond_init(&ev->cond, NULL);
+#endif
+
+    ev->value = (init ? EV_SET : EV_FREE);
+    ev->initialized = true;
+}
+
+void qemu_event_destroy(QemuEvent *ev)
+{
+    assert(ev->initialized);
+    ev->initialized = false;
+#ifndef HAVE_FUTEX
+    pthread_mutex_destroy(&ev->lock);
+    pthread_cond_destroy(&ev->cond);
+#endif
+}
+
+void qemu_event_set(QemuEvent *ev)
+{
+    assert(ev->initialized);
+
+    /*
+     * Pairs with qemu_event_wait() (on Linux) and qemu_event_reset().
+     *
+     * qemu_event_set has release semantics, but because it *loads*
+     * ev->value we need a full memory barrier here.
+     *
+     * qemu_event_wait() do not have a paired barrier on non-Linux because
+     * ev->lock ensures ordering.
+     */
+    smp_mb();
+
+#ifdef HAVE_FUTEX
+    if (qatomic_read(&ev->value) != EV_SET) {
+        int old = qatomic_xchg(&ev->value, EV_SET);
+
+        /* Pairs with memory barrier in kernel futex_wait system call.  */
+        smp_mb__after_rmw();
+        if (old == EV_BUSY) {
+            /* There were waiters, wake them up.  */
+            qemu_futex_wake_all(ev);
+        }
+    }
+#else
+    pthread_mutex_lock(&ev->lock);
+    qatomic_set(&ev->value, EV_SET);
+    pthread_cond_broadcast(&ev->cond);
+    pthread_mutex_unlock(&ev->lock);
+#endif
+}
+
+void qemu_event_reset(QemuEvent *ev)
+{
+    assert(ev->initialized);
+
+    /*
+     * If there was a concurrent reset (or even reset+wait),
+     * do nothing.  Otherwise change EV_SET->EV_FREE.
+     */
+    qatomic_or(&ev->value, EV_FREE);
+
+    /*
+     * Order reset before checking the condition in the caller.
+     * Pairs with the first memory barrier in qemu_event_set().
+     */
+    smp_mb__after_rmw();
+}
+
+void qemu_event_wait(QemuEvent *ev)
+{
+    assert(ev->initialized);
+
+#ifdef HAVE_FUTEX
+    while (true) {
+        /*
+         * qemu_event_wait must synchronize with qemu_event_set even if it does
+         * not go down the slow path, so this load-acquire is needed that
+         * synchronizes with the first memory barrier in qemu_event_set().
+         *
+         * If we do go down the slow path, there is no requirement at all: we
+         * might miss a qemu_event_set() here but ultimately the memory barrier
+         * in qemu_futex_wait() will ensure the check is done correctly.
+         */
+        unsigned value = qatomic_load_acquire(&ev->value);
+        if (value == EV_SET) {
+            break;
+        }
+
+        if (value == EV_FREE) {
+            /*
+             * Leave the event reset and tell qemu_event_set that there are
+             * waiters.  No need to retry, because there cannot be a concurrent
+             * busy->free transition.  After the CAS, the event will be either
+             * set or busy.
+             *
+             * This cmpxchg doesn't have particular ordering requirements if it
+             * succeeds (moving the store earlier can only cause
+             * qemu_event_set() to issue _more_ wakeups), the failing case needs
+             * acquire semantics like the load above.
+             */
+            if (qatomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) == EV_SET) {
+                break;
+            }
+        }
+
+        /*
+         * This is the final check for a concurrent set, so it does need
+         * a smp_mb() pairing with the second barrier of qemu_event_set().
+         * The barrier is inside the FUTEX_WAIT system call.
+         */
+        qemu_futex_wait(ev, EV_BUSY);
+    }
+#else
+    pthread_mutex_lock(&ev->lock);
+    while (qatomic_read(&ev->value) != EV_SET) {
+        pthread_cond_wait(&ev->cond, &ev->lock);
+    }
+    pthread_mutex_unlock(&ev->lock);
+#endif
+}
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 6dc6f2b25dce..ba725444ba63 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -317,153 +317,6 @@ void qemu_sem_wait(QemuSemaphore *sem)
     qemu_mutex_unlock(&sem->mutex);
 }
 
-#ifdef CONFIG_LINUX
-#include "qemu/futex.h"
-#endif
-
-/* Valid transitions:
- * - free->set, when setting the event
- * - busy->set, when setting the event, followed by qemu_futex_wake_all
- * - set->free, when resetting the event
- * - free->busy, when waiting
- *
- * set->busy does not happen (it can be observed from the outside but
- * it really is set->free->busy).
- *
- * busy->free provably cannot happen; to enforce it, the set->free transition
- * is done with an OR, which becomes a no-op if the event has concurrently
- * transitioned to free or busy.
- */
-
-#define EV_SET         0
-#define EV_FREE        1
-#define EV_BUSY       -1
-
-void qemu_event_init(QemuEvent *ev, bool init)
-{
-#ifndef CONFIG_LINUX
-    pthread_mutex_init(&ev->lock, NULL);
-    pthread_cond_init(&ev->cond, NULL);
-#endif
-
-    ev->value = (init ? EV_SET : EV_FREE);
-    ev->initialized = true;
-}
-
-void qemu_event_destroy(QemuEvent *ev)
-{
-    assert(ev->initialized);
-    ev->initialized = false;
-#ifndef CONFIG_LINUX
-    pthread_mutex_destroy(&ev->lock);
-    pthread_cond_destroy(&ev->cond);
-#endif
-}
-
-void qemu_event_set(QemuEvent *ev)
-{
-    assert(ev->initialized);
-
-    /*
-     * Pairs with qemu_event_wait() (on Linux) and qemu_event_reset().
-     *
-     * qemu_event_set has release semantics, but because it *loads*
-     * ev->value we need a full memory barrier here.
-     *
-     * qemu_event_wait() do not have a paired barrier on non-Linux because
-     * ev->lock ensures ordering.
-     */
-    smp_mb();
-
-#ifdef CONFIG_LINUX
-    if (qatomic_read(&ev->value) != EV_SET) {
-        int old = qatomic_xchg(&ev->value, EV_SET);
-
-        /* Pairs with memory barrier in kernel futex_wait system call.  */
-        smp_mb__after_rmw();
-        if (old == EV_BUSY) {
-            /* There were waiters, wake them up.  */
-            qemu_futex_wake_all(ev);
-        }
-    }
-#else
-    pthread_mutex_lock(&ev->lock);
-    qatomic_set(&ev->value, EV_SET);
-    pthread_cond_broadcast(&ev->cond);
-    pthread_mutex_unlock(&ev->lock);
-#endif
-}
-
-void qemu_event_reset(QemuEvent *ev)
-{
-    assert(ev->initialized);
-
-    /*
-     * If there was a concurrent reset (or even reset+wait),
-     * do nothing.  Otherwise change EV_SET->EV_FREE.
-     */
-    qatomic_or(&ev->value, EV_FREE);
-
-    /*
-     * Order reset before checking the condition in the caller.
-     * Pairs with the first memory barrier in qemu_event_set().
-     */
-    smp_mb__after_rmw();
-}
-
-void qemu_event_wait(QemuEvent *ev)
-{
-    assert(ev->initialized);
-
-#ifdef CONFIG_LINUX
-    while (true) {
-        /*
-         * qemu_event_wait must synchronize with qemu_event_set even if it does
-         * not go down the slow path, so this load-acquire is needed that
-         * synchronizes with the first memory barrier in qemu_event_set().
-         *
-         * If we do go down the slow path, there is no requirement at all: we
-         * might miss a qemu_event_set() here but ultimately the memory barrier
-         * in qemu_futex_wait() will ensure the check is done correctly.
-         */
-        unsigned value = qatomic_load_acquire(&ev->value);
-        if (value == EV_SET) {
-            break;
-        }
-
-        if (value == EV_FREE) {
-            /*
-             * Leave the event reset and tell qemu_event_set that there are
-             * waiters.  No need to retry, because there cannot be a concurrent
-             * busy->free transition.  After the CAS, the event will be either
-             * set or busy.
-             *
-             * This cmpxchg doesn't have particular ordering requirements if it
-             * succeeds (moving the store earlier can only cause qemu_event_set()
-             * to issue _more_ wakeups), the failing case needs acquire semantics
-             * like the load above.
-             */
-            if (qatomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) == EV_SET) {
-                break;
-            }
-        }
-
-        /*
-         * This is the final check for a concurrent set, so it does need
-         * a smp_mb() pairing with the second barrier of qemu_event_set().
-         * The barrier is inside the FUTEX_WAIT system call.
-         */
-        qemu_futex_wait(ev, EV_BUSY);
-    }
-#else
-    pthread_mutex_lock(&ev->lock);
-    while (qatomic_read(&ev->value) != EV_SET) {
-        pthread_cond_wait(&ev->cond, &ev->lock);
-    }
-    pthread_mutex_unlock(&ev->lock);
-#endif
-}
-
 static __thread NotifierList thread_exit;
 
 /*
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index a7fe3cc345f0..ca2e0b512e26 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -231,135 +231,6 @@ void qemu_sem_wait(QemuSemaphore *sem)
     }
 }
 
-/* Wrap a Win32 manual-reset event with a fast userspace path.  The idea
- * is to reset the Win32 event lazily, as part of a test-reset-test-wait
- * sequence.  Such a sequence is, indeed, how QemuEvents are used by
- * RCU and other subsystems!
- *
- * Valid transitions:
- * - free->set, when setting the event
- * - busy->set, when setting the event, followed by SetEvent
- * - set->free, when resetting the event
- * - free->busy, when waiting
- *
- * set->busy does not happen (it can be observed from the outside but
- * it really is set->free->busy).
- *
- * busy->free provably cannot happen; to enforce it, the set->free transition
- * is done with an OR, which becomes a no-op if the event has concurrently
- * transitioned to free or busy (and is faster than cmpxchg).
- */
-
-#define EV_SET         0
-#define EV_FREE        1
-#define EV_BUSY       -1
-
-void qemu_event_init(QemuEvent *ev, bool init)
-{
-    /* Manual reset.  */
-    ev->event = CreateEvent(NULL, TRUE, TRUE, NULL);
-    ev->value = (init ? EV_SET : EV_FREE);
-    ev->initialized = true;
-}
-
-void qemu_event_destroy(QemuEvent *ev)
-{
-    assert(ev->initialized);
-    ev->initialized = false;
-    CloseHandle(ev->event);
-}
-
-void qemu_event_set(QemuEvent *ev)
-{
-    assert(ev->initialized);
-
-    /*
-     * Pairs with both qemu_event_reset() and qemu_event_wait().
-     *
-     * qemu_event_set has release semantics, but because it *loads*
-     * ev->value we need a full memory barrier here.
-     */
-    smp_mb();
-    if (qatomic_read(&ev->value) != EV_SET) {
-        int old = qatomic_xchg(&ev->value, EV_SET);
-
-        /* Pairs with memory barrier after ResetEvent.  */
-        smp_mb__after_rmw();
-        if (old == EV_BUSY) {
-            /* There were waiters, wake them up.  */
-            SetEvent(ev->event);
-        }
-    }
-}
-
-void qemu_event_reset(QemuEvent *ev)
-{
-    assert(ev->initialized);
-
-    /*
-     * If there was a concurrent reset (or even reset+wait),
-     * do nothing.  Otherwise change EV_SET->EV_FREE.
-     */
-    qatomic_or(&ev->value, EV_FREE);
-
-    /*
-     * Order reset before checking the condition in the caller.
-     * Pairs with the first memory barrier in qemu_event_set().
-     */
-    smp_mb__after_rmw();
-}
-
-void qemu_event_wait(QemuEvent *ev)
-{
-    unsigned value;
-
-    assert(ev->initialized);
-
-    /*
-     * qemu_event_wait must synchronize with qemu_event_set even if it does
-     * not go down the slow path, so this load-acquire is needed that
-     * synchronizes with the first memory barrier in qemu_event_set().
-     *
-     * If we do go down the slow path, there is no requirement at all: we
-     * might miss a qemu_event_set() here but ultimately the memory barrier in
-     * qemu_futex_wait() will ensure the check is done correctly.
-     */
-    value = qatomic_load_acquire(&ev->value);
-    if (value != EV_SET) {
-        if (value == EV_FREE) {
-            /*
-             * Here the underlying kernel event is reset, but qemu_event_set is
-             * not yet going to call SetEvent.  However, there will be another
-             * check for EV_SET below when setting EV_BUSY.  At that point it
-             * is safe to call WaitForSingleObject.
-             */
-            ResetEvent(ev->event);
-
-            /*
-             * It is not clear whether ResetEvent provides this barrier; kernel
-             * APIs (KeResetEvent/KeClearEvent) do not.  Better safe than sorry!
-             */
-            smp_mb();
-
-            /*
-             * Leave the event reset and tell qemu_event_set that there are
-             * waiters.  No need to retry, because there cannot be a concurrent
-             * busy->free transition.  After the CAS, the event will be either
-             * set or busy.
-             */
-            if (qatomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) == EV_SET) {
-                return;
-            }
-        }
-
-        /*
-         * ev->value is now EV_BUSY.  Since we didn't observe EV_SET,
-         * qemu_event_set() must observe EV_BUSY and call SetEvent().
-         */
-        WaitForSingleObject(ev->event, INFINITE);
-    }
-}
-
 struct QemuThreadData {
     /* Passed to win32_start_routine.  */
     void             *(*start_routine)(void *);
diff --git a/util/meson.build b/util/meson.build
index c756558d6763..58033131328a 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -35,6 +35,7 @@ if glib_has_gslice
 endif
 util_ss.add(files('defer-call.c'))
 util_ss.add(files('envlist.c', 'path.c', 'module.c'))
+util_ss.add(files('event.c'))
 util_ss.add(files('host-utils.c'))
 util_ss.add(files('bitmap.c', 'bitops.c'))
 util_ss.add(files('fifo8.c'))

-- 
2.49.0


