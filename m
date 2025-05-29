Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327A3C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 05:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKW6P-000381-Md; Thu, 29 May 2025 01:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW6F-00035Z-3H
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:46 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW6C-0003E0-Ql
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:42 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-23035b3edf1so5205035ad.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 22:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748497599; x=1749102399;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FcEa4ndMyii+7LB2M35RVE9s5452FNapzNXg78hJqtg=;
 b=UlsPQmlGnTiqb8+jAzpeP4QOBaI3W5RrXmDQCgyO49rCnRM1Wx0BIa0fdVsaCd+wNy
 qaRphVa+/anWYgSA3IQw3/BWBCwfVw7kc6GgT5fD1ULlu2p85dk3SW9Ig18Es2b6qFev
 cB3BJ/TfHedYGwljEKpXL3NcQRfL3cxEP2rYU7QvU/s5PSzSYLyd8l6wWbIsTNiqWFOp
 BuQugQW2fkVhiAceCS30/oJoUTdL+uCjbDopSRZSDYGSASc5IPbrJgTG6KbP5CLyaMdZ
 LCKSP7fJdA9uMyXlrariKmL2rg0onUJ8gfFBQMcjEbpE0RWYRkpega7S/BrXH+wQHoYy
 u+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748497599; x=1749102399;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FcEa4ndMyii+7LB2M35RVE9s5452FNapzNXg78hJqtg=;
 b=q56CQg0IimKiZusEFU2Cr89iz566Y0t/Fa72mmyjD+OkNWsVlE/HF8j+gR/7K6bzNR
 xCus73WBT7v4bHgRiBp6zegzknHnwNc7fyZEBh7OpVuqBuV/ybR68Ou5M0acbtMv33k+
 RAVuh0liOh2Krn+rKqFkjUy3r0ijjJBgMuh6c2do23VcIYlNM9K4QQnGoTzURiZL80m5
 3xxUSFXZ0E2OK008IlQFLCSMn7moMoTllHUQdZZs36xcDGS8wg9fDsRkNgOyzpAuzJzd
 7niKTxUIrt9ul8aMVvEmv1iWT/bgwovhFF7P75UsleEjJFyyq2gGq40qF8ebORfOvA5K
 7BUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsUNgMFMtJmJj7Ye51HVhSLW4/AfSG84MdENpFEV81wPcbU4sMO+I2XnBh2JP3pXR2Tg0gNzVd2ke1@nongnu.org
X-Gm-Message-State: AOJu0YzcI0rDCCYAoHix28bUwsLHC9lRKVgmetokW1XbkW6iSG+6eifK
 lAIa+ypTJmPxBF4KYqlJmm6+cy/0TEBIb2CenOVD29UvDeKYCUjFzDecmX+EnBN2pyUMAIvE0iU
 iNtKz
X-Gm-Gg: ASbGnctOPgBCXKJJMkjLMENBFo05p/wAD62aHCZxxbRTHkYUVXPW86RzN55THZUxSaa
 BTU22qIWUs4tlCTEBootDrAMGjX27rXipsQRBKRYnymodMqPg+t2xO/+fzLk/oySmI4+GcaZBka
 NNMOwhRH/mBriqKngCT4pj3ZD+vR3iKSn7V2Sa6Ls4DwuDIMgLzwX25FZ70paWrbj6KKfc40C8F
 gJBd5a3T5uzE5lZNkwNQ8u+GQ8qjHTtmeN3W9mgs2AR5+9xI4lP8uWlT6Y1QpJzGwBC9eK7VyfS
 ZkvwLC9ikb1HBtB9lvBeNZR60iJx4QvKpi4eN6M7tawwUiYWcqPSe7bDtCXCkeg=
X-Google-Smtp-Source: AGHT+IGrejCONCdvVLxo+X//pJFVNA2Y2WK6y6ZF1UUdGJOU5fAEPpmGjMOH4BHUtuq9JSeePHwSAw==
X-Received: by 2002:a17:902:ce0a:b0:234:9375:e07c with SMTP id
 d9443c01a7336-234d2c4aa60mr80984545ad.46.1748497598762; 
 Wed, 28 May 2025 22:46:38 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23506bc8695sm5088325ad.34.2025.05.28.22.46.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 22:46:38 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 29 May 2025 14:46:02 +0900
Subject: [PATCH v5 13/13] qemu-thread: Document QemuEvent memory ordering
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-event-v5-13-53b285203794@daynix.com>
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

Background
----------

I added a variant of QemuEvent for platforms without futex and
refactored qemu_event_set() to find it is difficult to show the
correctness of these changes.

Analyzing the code, I found there are three different levels of memory
ordering constraints:

1. The requirement of QemuEvent users.
2. The constraints that needs to be imposed on memory operations to
   satisfy 1.
3. The actual constraints imposed on memory operations.

Distinguishing these levels make it easier to show the correctness of
the mentioned changes. Constraint 1 is not affected by the mentioned
changes, so we only need to focus on contraint 2 and 3. It also allows
sharing constraints 1 and 2 for the variants of QemuEvent
implementations.

Change description
------------------

The code already included some documentation of memory ordering as
inline comments. This change splits the documentation into the three
levels, and place them to appropriate places. Each of the documentations
of constraint 2 and 3 includes references to one of its higher level.

Constraint 1 is now documented in include/qemu/thread.h so that the
users of QemuEvent can refer to it without reading the implementation.

Constraint 2 follows the documentation of the state transitions in
util/event.c.

The inline comments describe constraint 3. The documentation of memory
operations already describe the memory ordering of them well, so they
usually contain only references to constraint 2, which memory operations
are intended to satisfy.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qemu/thread.h | 19 ++++++++++++
 util/event.c          | 84 ++++++++++++++++++++++++++++-----------------------
 2 files changed, 66 insertions(+), 37 deletions(-)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index f0302ed01fdb..8fafff73de7d 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -19,6 +19,25 @@ typedef struct QemuThread QemuThread;
  * https://learn.microsoft.com/en-us/windows/win32/sync/using-event-objects
  *
  * QemuEvent is more lightweight than QemuSemaphore when HAVE_FUTEX is defined.
+ *
+ * Memory ordering
+ * ---------------
+ *
+ * The documentation of Win32 manual-reset event objects do not specify
+ * memory ordering. Below describes the memory ordering QemuEvent establishes.
+ *
+ * Assume each of the following two orders is specified in a different thread:
+ * - X -> qemu_event_set()
+ * - qemu_event_reset() or qemu_event_wait() -> Y
+ *
+ * X -> Y will be ensured for the two threads if any of the following is
+ * satisfied:
+ * - qemu_event_set() happens before qemu_event_reset().
+ * - qemu_event_set() happens before qemu_event_wait().
+ * - qemu_event_wait() waits for qemu_event_set().
+ *
+ * Note that this is true even when the value is already set before
+ * qemu_event_set().
  */
 typedef struct QemuEvent {
 #ifndef HAVE_FUTEX
diff --git a/util/event.c b/util/event.c
index df6d60836041..d0dc6ebc00ff 100644
--- a/util/event.c
+++ b/util/event.c
@@ -5,24 +5,33 @@
 
 /*
  * Valid transitions:
- * - free->set, when setting the event
- * - busy->set, when setting the event
- * - set->free, when resetting the event
- * - free->busy, when waiting
+ * - FREE -> SET (qemu_event_set)
+ * - BUSY -> SET (qemu_event_set)
+ * - SET -> FREE (qemu_event_reset)
+ * - FREE -> BUSY (qemu_event_wait)
  *
- * With futex, the waking and blocking operations follow busy->set and
- * free->busy, respectively.
+ * With futex, the waking and blocking operations follow
+ * BUSY -> SET and FREE -> BUSY, respectively.
  *
- * Without futex, busy->set and free->busy never happen. Instead, the waking
- * operation follows free->set and the blocking operation will happen when
- * waiting if the event is not set.
+ * Without futex, BUSY -> SET and FREE -> BUSY never happen. Instead, the waking
+ * operation follows FREE -> SET and the blocking operation will happen in
+ * qemu_event_wait() if the event is not SET.
  *
- * set->busy does not happen (it can be observed from the outside but
- * it really is set->free->busy).
+ * The following orders specified in a thread are preserved for any other thread
+ * accessing the event value:
+ * 1. qemu_event_set: X -> store SET
+ * 2. qemu_event_reset: store FREE -> X
+ * 3. qemu_event_wait: load SET -> X
+ * 4. qemu_event_set: store SET -> wake
  *
- * busy->free provably cannot happen; to enforce it, the set->free transition
- * is done with an OR, which becomes a no-op if the event has concurrently
- * transitioned to free or busy.
+ * Different combinations of orders 1, 2, 3, and 4 establish the order visible
+ * to the users of QemuEvent in different situations:
+ * When qemu_event_set() happens before qemu_event_reset(): orders 1 and 2
+ * When qemu_event_set() happens before qemu_event_wait(): orders 1 and 3
+ * when qemu_event_wait() waits for qemu_event_set(): orders 1 and 3
+ *
+ * Order 4 ensures that qemu_event_set() wakes qemu_event_wait() if it is
+ * blocked.
  */
 
 #define EV_SET         0
@@ -55,12 +64,23 @@ void qemu_event_set(QemuEvent *ev)
     assert(ev->initialized);
 
 #ifdef HAVE_FUTEX
+    /*
+     * Transitions:
+     * - FREE -> SET
+     * - BUSY -> SET
+     *
+     * Order 1. X -> store SET
+     */
     if (qatomic_xchg(&ev->value, EV_SET) == EV_BUSY) {
-        /* There were waiters, wake them up.  */
+        /* Order 4. store SET -> wake  */
         qemu_futex_wake_all(ev);
     }
 #else
     pthread_mutex_lock(&ev->lock);
+    /*
+     * Transition FREE -> SET
+     * Order 1. X -> store SET
+     */
     qatomic_store_release(&ev->value, EV_SET);
     pthread_cond_broadcast(&ev->cond);
     pthread_mutex_unlock(&ev->lock);
@@ -72,15 +92,14 @@ void qemu_event_reset(QemuEvent *ev)
     assert(ev->initialized);
 
     /*
-     * If there was a concurrent reset (or even reset+wait),
-     * do nothing.  Otherwise change EV_SET->EV_FREE.
+     * Transition SET -> FREE
+     *
+     * Ensure that BUSY -> FREE never happens with an OR, which becomes a no-op
+     * if the event has concurrently transitioned to FREE or BUSY.
      */
     qatomic_or(&ev->value, EV_FREE);
 
-    /*
-     * Order reset before checking the condition in the caller.
-     * Pairs with the store-release in qemu_event_set().
-     */
+    /* Order 2. store FREE -> X */
     smp_mb__after_rmw();
 }
 
@@ -90,28 +109,14 @@ void qemu_event_wait(QemuEvent *ev)
 
 #ifdef HAVE_FUTEX
     while (true) {
-        /*
-         * qemu_event_wait must synchronize with qemu_event_set even if it does
-         * not go down the slow path, so this load-acquire is needed that
-         * synchronizes with the store-release in qemu_event_set().
-         */
+        /* Order 3. load SET -> X */
         unsigned value = qatomic_load_acquire(&ev->value);
         if (value == EV_SET) {
             break;
         }
 
         if (value == EV_FREE) {
-            /*
-             * Leave the event reset and tell qemu_event_set that there are
-             * waiters.  No need to retry, because there cannot be a concurrent
-             * busy->free transition.  After the CAS, the event will be either
-             * set or busy.
-             *
-             * This cmpxchg doesn't have particular ordering requirements if it
-             * succeeds (moving the store earlier can only cause
-             * qemu_event_set() to issue _more_ wakeups), the failing case needs
-             * acquire semantics like the load above.
-             */
+            /* Order 3. load SET -> X */
             if (qatomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) == EV_SET) {
                 break;
             }
@@ -120,6 +125,11 @@ void qemu_event_wait(QemuEvent *ev)
         qemu_futex_wait(ev, EV_BUSY);
     }
 #else
+    /*
+     * Order 3. load SET -> X
+     *
+     * qatomic_read() loads SET. ev->lock ensures the order.
+     */
     pthread_mutex_lock(&ev->lock);
     while (qatomic_read(&ev->value) != EV_SET) {
         pthread_cond_wait(&ev->cond, &ev->lock);

-- 
2.49.0


