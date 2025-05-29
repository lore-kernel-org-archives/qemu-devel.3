Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37C8C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 05:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKW5u-0002zQ-Aj; Thu, 29 May 2025 01:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW5r-0002yA-GR
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:19 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW5o-0003Ad-UO
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:19 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso548813b3a.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 22:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748497575; x=1749102375;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ht3SM+0+jB27uCclc/G29FDcuTXTxlxDzjlbSsqKrWU=;
 b=hlKttj0k48awKuRremAIYQmStSdMHb23vkb9VqZMSPt+hEGHQT4zOd3FFK1eRIZvEm
 qOazhYDXFDLNKqRPFR93aNrM6w2MWaRGaKdPxXrVPhSOxioochs13qb9+YtMwRefQywn
 4fWtOWOHcEfc4UrVSuqAfblXb552awTKfasHtEv39YofjwYZk8X0iRtzK3ka7vYA3s8Y
 8o7/M1JZ/90RYuSn1cYjzwo6TQUdOBeiQyebttQxEmEVxE1IciOSipG9r9BvXA2e9YIX
 32IN2JI6wroV9sy//ViHVYDhmkOG1OuYoBpV6zxLIK6lIb2rsnRLT0CTIfUKWmVscKoK
 2daA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748497575; x=1749102375;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ht3SM+0+jB27uCclc/G29FDcuTXTxlxDzjlbSsqKrWU=;
 b=oCGNXTj3qcYJEomcal92C61Q52vi/bcOHnjY+aXEGAC0c50agABV/nTYiRJRakbFhX
 IvZog9lG/K4Vc38y2Xi7sX4kvo56tRkkSS5MCtUxRSXGNwyVmbctzmEqeqBOCoAvUfKO
 jPb+07RpNPHJ9gD+UaxopoFkF3UKUJf/Bp/Nz5JRnye3z8dNWNGgBkx/073KCzgbL381
 eXBONMNELSmXN9D0UqCiW39X77rALHy8bZFP4h9w3HD9JGUApnv21kbAU8LcDoeicX3B
 zKE7DX/mGRYtzy6hk/PKtFepcOd06EqeQq//wLR96BD2b5wwFlgFqeXEpR0L5YLREwhW
 KOeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcEZtwrK66yOSRr7G/uHXi77n4DosEU8XWtrkxmLvZghcex1yM6gtvrEgrL1yStsz1fCEERsaTvTVl@nongnu.org
X-Gm-Message-State: AOJu0YwXsKWLkaKlQIfNLN+R4dpD7+8ZjGfxCoitJJwZug9quMT2IgbN
 VRMnhihit6NkmD/lDgyoL2QHenphLvBaaZ1EGv4z5Vg+lKjhbIAFQenz8NkPnLTG5uQ=
X-Gm-Gg: ASbGncumrhQYORRKKmjxdSznH3rjvTnNsbtRzG6PBdrvBuFpMWmtvihENkk1Y1bEM7c
 Nr7ZnE+18MPbFFAeh5mni4kuhYU6B/WUP4+6iKJgz5FJ4uBV7ekD20yy4hGmbRHiVVhFVGNSBVi
 OqH7WWqGgGPt5F+WUtjm5y1icO2Hdnyf+IXgBmuN6yW/GWdlrBblFsWKugwrFXhjOMT+xROKWbn
 pawRg37G1TFsGRoBIg7iEruv1OHBKg7o/3f6k1jGsM4v/HHyasOU20xS5jGUSRXEjwaJ8kKp8mw
 OcfK3TObiR+Oa+0ZQwzgRKeQfoD34sipYYvWxk14ktL9PFMdmHJV
X-Google-Smtp-Source: AGHT+IHEE/R5lJQsWEwmjuBX77b6pyIOkjWtMtBjycog7eUSbZEjWknccI5mh7Ig9emBPETOB4M5aQ==
X-Received: by 2002:a05:6a21:7316:b0:215:d64d:412e with SMTP id
 adf61e73a8af0-21ac5cd92d0mr3435381637.20.1748497575231; 
 Wed, 28 May 2025 22:46:15 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-747affd478bsm548531b3a.155.2025.05.28.22.46.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 22:46:14 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 29 May 2025 14:45:54 +0900
Subject: [PATCH v5 05/13] qemu-thread: Use futex for QemuEvent on Windows
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250529-event-v5-5-53b285203794@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/thread-posix.h |   9 ---
 include/qemu/thread-win32.h |   6 --
 include/qemu/thread.h       |  11 +++-
 util/event.c                | 138 ++++++++++++++++++++++++++++++++++++++++++++
 util/qemu-thread-posix.c    | 137 -------------------------------------------
 util/qemu-thread-win32.c    | 129 -----------------------------------------
 util/meson.build            |   1 +
 7 files changed, 149 insertions(+), 282 deletions(-)

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
index 000000000000..e937804a92a8
--- /dev/null
+++ b/util/event.c
@@ -0,0 +1,138 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu/thread.h"
+
+/*
+ * Valid transitions:
+ * - free->set, when setting the event
+ * - busy->set, when setting the event
+ * - set->free, when resetting the event
+ * - free->busy, when waiting
+ *
+ * With futex, the waking and blocking operations follow busy->set and
+ * free->busy, respectively.
+ *
+ * Without futex, busy->set and free->busy never happen. Instead, the waking
+ * operation follows free->set and the blocking operation will happen when
+ * waiting if the event is not set.
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
+#ifdef HAVE_FUTEX
+    /*
+     * Pairs with both qemu_event_reset() and qemu_event_wait().
+     *
+     * qemu_event_set has release semantics, but because it *loads*
+     * ev->value we need a full memory barrier here.
+     */
+    smp_mb();
+    if (qatomic_read(&ev->value) != EV_SET) {
+        if (qatomic_xchg(&ev->value, EV_SET) == EV_BUSY) {
+            /* There were waiters, wake them up.  */
+            qemu_futex_wake_all(ev);
+        }
+    }
+#else
+    pthread_mutex_lock(&ev->lock);
+    qatomic_store_release(&ev->value, EV_SET);
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
index dc13b61f1bd8..ba725444ba63 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -317,143 +317,6 @@ void qemu_sem_wait(QemuSemaphore *sem)
     qemu_mutex_unlock(&sem->mutex);
 }
 
-#ifdef CONFIG_LINUX
-#include "qemu/futex.h"
-#endif
-
-/* Valid transitions:
- * - free->set, when setting the event
- * - busy->set, when setting the event
- * - set->free, when resetting the event
- * - free->busy, when waiting
- *
- * With futex, the waking and blocking operations follow busy->set and
- * free->busy, respectively.
- *
- * Without futex, busy->set and free->busy never happen. Instead, the waking
- * operation follows free->set and the blocking operation will happen when
- * waiting if the event is not set.
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
-#ifdef CONFIG_LINUX
-    /*
-     * Pairs with both qemu_event_reset() and qemu_event_wait().
-     *
-     * qemu_event_set has release semantics, but because it *loads*
-     * ev->value we need a full memory barrier here.
-     */
-    smp_mb();
-    if (qatomic_read(&ev->value) != EV_SET) {
-        if (qatomic_xchg(&ev->value, EV_SET) == EV_BUSY) {
-            /* There were waiters, wake them up.  */
-            qemu_futex_wake_all(ev);
-        }
-    }
-#else
-    pthread_mutex_lock(&ev->lock);
-    qatomic_store_release(&ev->value, EV_SET);
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
index 5735f65f1994..35029380a376 100644
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


