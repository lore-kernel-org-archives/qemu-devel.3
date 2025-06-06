Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D48C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:39:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWIt-00031W-M5; Fri, 06 Jun 2025 08:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIs-00031H-ON
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIo-0005yT-94
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ABdK2+gDgIqRRB207sGDriwUuy9jXWxeTHpCdVbnrMY=;
 b=e6QsdBoV46veqeIcNNjEp0232cs+IibYR7an9wObG7MOJp4PPitb5Rl2lKwndya6kQakjY
 d8Q+ZLDc8fG9Gpxn5t57Ox4iV2gq+PIAAIBnIqyFMDmW6iDKnHIMBYvICOIe0wmMOaQdU4
 Ip7zD+S+eyLlJ1Hqs4GQmq8ZoSJipTM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-XRZhwoA8Mxyw00W1Lj5EKA-1; Fri, 06 Jun 2025 08:36:03 -0400
X-MC-Unique: XRZhwoA8Mxyw00W1Lj5EKA-1
X-Mimecast-MFC-AGG-ID: XRZhwoA8Mxyw00W1Lj5EKA_1749213362
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4e6d426b1so1640526f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213361; x=1749818161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ABdK2+gDgIqRRB207sGDriwUuy9jXWxeTHpCdVbnrMY=;
 b=TMnbQhx2MImyIwKeYvc2tVS14mCO/prrFqKtMFmoLaT9l34u/gVrpmkVZFQxhgbqld
 g9cvE97mKxH+SMcJtNQ6+xufxqnrgwUL+Ypi8d5nvruyDc1yA5jGNPCaeD1ZmqmOh6Ti
 yQJwGDVcxXjHsBMEd1JVxgGqM0Bb0c+5paowBrW7nuIzqCkQC7fgCDNVsjJQm06c49r/
 D9jSuKd/SsKk81DTy8TdbE38BshjUi31hylPrDTV/dBZ8Z7MAUeHBgvtqCssxkLnsZvT
 YaQSazlyEBMm5RyA/gtDPRW0t5IDMeRCwAMzMYagZuNNoJv93o2FlACI9cdtbE08xfvM
 9RRQ==
X-Gm-Message-State: AOJu0YxZMWYa3ONxKRoB0lwBhNWa+XNSlFem6XH6sd/0pimDhRLa1Ve/
 dkEI1ywJ1WECcXq5nhWljdMdb3W0yyOSdEZcXFJkDe5Bht4gNWuxFJEuj+frtK6yOj1cdnUqV0g
 FCPoG5yjWq/iLxnoWNnZ9WI02cmZq+onjaqeaYHRf+/R8D6qlcXZopUWukRU+rmNxp6fYioGuqq
 6R1iEMm+Jqw2EQNwvJTScixjOQ4dn+6EESgEImC3ke
X-Gm-Gg: ASbGncvCujJ3eNNNz7QktapRWsKQgZ4HivEblrzYUoKNBg09dnufGfSyttM54Uoyhek
 aBvZzIP63XiKehDbtBkEdIXJrJ2nokebMJRWqE4qd7UYCtvsdUInT27BJNOTHMLpHMsmpYOEhZO
 o6P4/E2cG4phSBkc0lOWbYRHckibzd/yxoBseJb6gSTWBemw1E/MOl7XouWdpTY0R4NXx0hbAbF
 bbZcJyJPo7Qb4wqH0uN1jKBIJIVsV5x9bD5xMfejVER68U2cc1uix2ZkQCvovqLZMKXF2zRyG2W
 YR71i4jup0vYMbUfwp/Nsh/0
X-Received: by 2002:a05:600c:4e4f:b0:450:d79d:3b16 with SMTP id
 5b1f17b1804b1-4520159c111mr33957765e9.14.1749213360859; 
 Fri, 06 Jun 2025 05:36:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBufwLEWGhmprVMPxR0sMKerr9eZLKRzR9Ckz8WTCUqXt3ujk2i6Qy+2RVSoqYzq390beVQg==
X-Received: by 2002:a05:600c:4e4f:b0:450:d79d:3b16 with SMTP id
 5b1f17b1804b1-4520159c111mr33957375e9.14.1749213360067; 
 Fri, 06 Jun 2025 05:36:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452730c73d2sm19897365e9.30.2025.06.06.05.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:35:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/31] qemu-thread: Use futex for QemuEvent on Windows
Date: Fri,  6 Jun 2025 14:34:35 +0200
Message-ID: <20250606123447.538131-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Use the futex-based implementation of QemuEvent on Windows to
remove code duplication and remove the overhead of event object
construction and destruction.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250526-event-v4-6-5b784cc8e1de@daynix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/thread-posix.h |   9 --
 include/qemu/thread-win32.h |   6 --
 include/qemu/thread.h       |  11 ++-
 util/event.c                | 171 ++++++++++++++++++++++++++++++++++++
 util/qemu-thread-posix.c    | 170 -----------------------------------
 util/qemu-thread-win32.c    | 129 ---------------------------
 util/meson.build            |   1 +
 7 files changed, 182 insertions(+), 315 deletions(-)
 create mode 100644 util/event.c

diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h
index c412623a914..758808b705e 100644
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
index d95af4498fc..da9e7322990 100644
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
index 6f800aad31a..573f8c9ede2 100644
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
index 00000000000..5a8141cd0e4
--- /dev/null
+++ b/util/event.c
@@ -0,0 +1,171 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu/thread.h"
+
+/*
+ * Valid transitions:
+ * - FREE -> SET (qemu_event_set)
+ * - BUSY -> SET (qemu_event_set)
+ * - SET -> FREE (qemu_event_reset)
+ * - FREE -> BUSY (qemu_event_wait)
+ *
+ * With futex, the waking and blocking operations follow
+ * BUSY -> SET and FREE -> BUSY, respectively.
+ *
+ * Without futex, BUSY -> SET and FREE -> BUSY never happen. Instead, the waking
+ * operation follows FREE -> SET and the blocking operation will happen in
+ * qemu_event_wait() if the event is not SET.
+ *
+ * SET->BUSY does not happen (it can be observed from the outside but
+ * it really is SET->FREE->BUSY).
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
+    /* Pairs with qemu_event_reset()'s load acquire.  */
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
+#ifdef HAVE_FUTEX
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
+#else
+    /*
+     * If futexes are not available, there are no EV_FREE->EV_BUSY
+     * transitions because wakeups are done entirely through the
+     * condition variable.  Since qatomic_set() only writes EV_FREE,
+     * the load seems useless but in reality, the acquire synchronizes
+     * with qemu_event_set()'s store release: if qemu_event_reset()
+     * sees EV_SET here, then the caller will certainly see a
+     * successful condition and skip qemu_event_wait():
+     *
+     * done = 1;                 if (done == 0)
+     * qemu_event_set() {          qemu_event_reset() {
+     *   lock();
+     *   ev->value = EV_SET ----->     load ev->value
+     *                                 ev->value = old value | EV_FREE
+     *   cond_broadcast()
+     *   unlock();                 }
+     * }                           if (done == 0)
+     *                               // qemu_event_wait() not called
+     */
+    qatomic_set(&ev->value, qatomic_load_acquire(&ev->value) | EV_FREE);
+#endif
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
index 7fafbedbc4f..ba725444ba6 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -317,176 +317,6 @@ void qemu_sem_wait(QemuSemaphore *sem)
     qemu_mutex_unlock(&sem->mutex);
 }
 
-#ifdef CONFIG_LINUX
-#include "qemu/futex.h"
-#endif
-
-/* Valid transitions:
- * - FREE -> SET (qemu_event_set)
- * - BUSY -> SET (qemu_event_set)
- * - SET -> FREE (qemu_event_reset)
- * - FREE -> BUSY (qemu_event_wait)
- *
- * With futex, the waking and blocking operations follow
- * BUSY -> SET and FREE -> BUSY, respectively.
- *
- * Without futex, BUSY -> SET and FREE -> BUSY never happen. Instead, the waking
- * operation follows FREE -> SET and the blocking operation will happen in
- * qemu_event_wait() if the event is not SET.
- *
- * SET->BUSY does not happen (it can be observed from the outside but
- * it really is SET->FREE->BUSY).
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
-    /* Pairs with qemu_event_reset()'s load acquire.  */
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
-#ifdef CONFIG_LINUX
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
-#else
-    /*
-     * If futexes are not available, there are no EV_FREE->EV_BUSY
-     * transitions because wakeups are done entirely through the
-     * condition variable.  Since qatomic_set() only writes EV_FREE,
-     * the load seems useless but in reality, the acquire synchronizes
-     * with qemu_event_set()'s store release: if qemu_event_reset()
-     * sees EV_SET here, then the caller will certainly see a
-     * successful condition and skip qemu_event_wait():
-     *
-     * done = 1;                 if (done == 0)
-     * qemu_event_set() {          qemu_event_reset() {
-     *   lock();
-     *   ev->value = EV_SET ----->     load ev->value
-     *                                 ev->value = old value | EV_FREE
-     *   cond_broadcast()
-     *   unlock();                 }
-     * }                           if (done == 0)
-     *                               // qemu_event_wait() not called
-     */
-    qatomic_set(&ev->value, qatomic_load_acquire(&ev->value) | EV_FREE);
-#endif
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
index a7fe3cc345f..ca2e0b512e2 100644
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
index 5735f65f199..35029380a37 100644
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


