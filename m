Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAEAC61CE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWIo-0002z6-SW; Fri, 06 Jun 2025 08:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIn-0002xJ-6Z
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIk-0005xi-Ki
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QugmifRH/BIjx3oWaNeHwFyMOfw//Nsiz+a4Dn2EMuI=;
 b=RbNaE77mutUj73oxbeJ9/SFOqTK8uf1JqftO5OlmlVeJxkXZYOdIWlcu+KfFeEmeytfJEV
 Pvk7Mqlc8mlYlQzPZ6z7hDJH+t61Gr2k7er7R6P8lbHCqTgwhe/38CqeeKvp5gI2jTlRZI
 LeIEIpmMYFjVQs5YqFZyCvWgdnclmdo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-RH-YUGF0N2WnvANlpCra2w-1; Fri, 06 Jun 2025 08:35:58 -0400
X-MC-Unique: RH-YUGF0N2WnvANlpCra2w-1
X-Mimecast-MFC-AGG-ID: RH-YUGF0N2WnvANlpCra2w_1749213357
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451dda846a0so15680065e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213357; x=1749818157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QugmifRH/BIjx3oWaNeHwFyMOfw//Nsiz+a4Dn2EMuI=;
 b=iKwAZRNcs7D8wgov4thENt4aSN7zE/3t8AlW2T/SP38yKWSY0IMPXOTIo1OG6l3Gfo
 /AKMWDP8N+F9xk84+hOtY/enFR9mIOV4cN1xOPeD0aLeqcjBiULeYz0t0ppue4p3LXos
 5ugYW5wOqI2bhavdrn4in2Y2acOVCH1wggRaaaaFBQYEKtaI6Ivf+LL1V9Xc9EnKyeh9
 cD6JJwWe40pz7YuNSR9JhQaHi7cwHaoS5H6g5jikhMy8Vl9bO/R5qysXIRS1aLhKvuq/
 jjEsobprla7vP2rehXkzn6ERtqjw7J+Pj70XFOmkGGF0pZB5XL20URNnlCZK0A3mXHsz
 UR8g==
X-Gm-Message-State: AOJu0Yxr2J73OjesjotEkFxLqMdYh+njDVWAOHqGIQf3T8PNUrJz6njx
 JGcgZu9IdSUYLj7XN4zbYT7ERy+W3fZKv6503wUKlZXbFpXRwCyJW3CpiHfutHZbpaNcqRKc1Zo
 7Tpm+k5NJQRMbdP25RJPUCwalmrgiOmNWQcQLZggzuNKgPlfxpv7FU13T0b/F8mP6sHn8D4c3xI
 XxR/VFNNLTzbGYB2Ct1k54ludNUjWv0hD91fajRrmi
X-Gm-Gg: ASbGncuZwyjfgCa7Y9ZWQuQgdkQ6tK4Smkdk+ZsEIEFP9aNO4BcQ4tu5NfQi9k+CrdS
 QMlFIdHVDPuuhbq0S47JxKrKzcTcg02xXpAMVIOm68QCILr+3HbAF+ENkAJplf9dqPyTr+YZkza
 590g82slRL/jaAsl+TuAaRG/fSisa3yMWw5E9W0Omk9FxthCTxSPmLU0NZk5+js44moZiBtlL3l
 sXwhtsxd1lfQhjHcgIAwYm97RL4xZkU0dFgx0QrSRmoEKLOhOtz1tmnyL6z587ObFhbLqnkGd6c
 gC+xuGi5iqroKvcQdhb+8dZj
X-Received: by 2002:a05:600c:3848:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-452013d7cc8mr30427835e9.20.1749213356647; 
 Fri, 06 Jun 2025 05:35:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrZPKWN7NiOmpjmUOM+9PzMTMgdjnEFYSFOzNbKBwaH1IBIJkndlKI/2v5m2Cl3RAClztBmA==
X-Received: by 2002:a05:600c:3848:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-452013d7cc8mr30427395e9.20.1749213355861; 
 Fri, 06 Jun 2025 05:35:55 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323be604sm1746440f8f.42.2025.06.06.05.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:35:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PULL 20/31] qemu-thread: Avoid futex abstraction for non-Linux
Date: Fri,  6 Jun 2025 14:34:34 +0200
Message-ID: <20250606123447.538131-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

qemu-thread used to abstract pthread primitives into futex for the
QemuEvent implementation of POSIX systems other than Linux. However,
this abstraction has one key difference: unlike futex, pthread
primitives require an explicit destruction, and it must be ordered after
wait and wake operations.

It would be easier to perform destruction if a wait operation ensures
the corresponding wake operation finishes as POSIX semaphore does, but
that requires to protect state accesses in qemu_event_set() and
qemu_event_wait() with a mutex. On the other hand, real futex does not
need such a protection but needs complex barrier and atomic operations
to ensure ordering between the two functions.

Add special implementations of qemu_event_set() and qemu_event_wait()
using pthread primitives. qemu_event_wait() will ensure qemu_event_set()
finishes, and these functions will avoid complex barrier and atomic
operations to ensure ordering between them.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Link: https://lore.kernel.org/r/20250526-event-v4-5-5b784cc8e1de@daynix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-thread-posix.c | 84 +++++++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 31 deletions(-)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 3dc4d30052e..7fafbedbc4f 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -319,38 +319,23 @@ void qemu_sem_wait(QemuSemaphore *sem)
 
 #ifdef CONFIG_LINUX
 #include "qemu/futex.h"
-#else
-static inline void qemu_futex_wake(QemuEvent *ev, int n)
-{
-    assert(ev->initialized);
-    pthread_mutex_lock(&ev->lock);
-    if (n == 1) {
-        pthread_cond_signal(&ev->cond);
-    } else {
-        pthread_cond_broadcast(&ev->cond);
-    }
-    pthread_mutex_unlock(&ev->lock);
-}
-
-static inline void qemu_futex_wait(QemuEvent *ev, unsigned val)
-{
-    assert(ev->initialized);
-    pthread_mutex_lock(&ev->lock);
-    if (ev->value == val) {
-        pthread_cond_wait(&ev->cond, &ev->lock);
-    }
-    pthread_mutex_unlock(&ev->lock);
-}
 #endif
 
 /* Valid transitions:
- * - free->set, when setting the event
- * - busy->set, when setting the event, followed by qemu_futex_wake_all
- * - set->free, when resetting the event
- * - free->busy, when waiting
+ * - FREE -> SET (qemu_event_set)
+ * - BUSY -> SET (qemu_event_set)
+ * - SET -> FREE (qemu_event_reset)
+ * - FREE -> BUSY (qemu_event_wait)
  *
- * set->busy does not happen (it can be observed from the outside but
- * it really is set->free->busy).
+ * With futex, the waking and blocking operations follow
+ * BUSY -> SET and FREE -> BUSY, respectively.
+ *
+ * Without futex, BUSY -> SET and FREE -> BUSY never happen. Instead, the waking
+ * operation follows FREE -> SET and the blocking operation will happen in
+ * qemu_event_wait() if the event is not SET.
+ *
+ * SET->BUSY does not happen (it can be observed from the outside but
+ * it really is SET->FREE->BUSY).
  *
  * busy->free provably cannot happen; to enforce it, the set->free transition
  * is done with an OR, which becomes a no-op if the event has concurrently
@@ -386,6 +371,7 @@ void qemu_event_set(QemuEvent *ev)
 {
     assert(ev->initialized);
 
+#ifdef CONFIG_LINUX
     /*
      * Pairs with both qemu_event_reset() and qemu_event_wait().
      *
@@ -403,12 +389,20 @@ void qemu_event_set(QemuEvent *ev)
             qemu_futex_wake_all(ev);
         }
     }
+#else
+    pthread_mutex_lock(&ev->lock);
+    /* Pairs with qemu_event_reset()'s load acquire.  */
+    qatomic_store_release(&ev->value, EV_SET);
+    pthread_cond_broadcast(&ev->cond);
+    pthread_mutex_unlock(&ev->lock);
+#endif
 }
 
 void qemu_event_reset(QemuEvent *ev)
 {
     assert(ev->initialized);
 
+#ifdef CONFIG_LINUX
     /*
      * If there was a concurrent reset (or even reset+wait),
      * do nothing.  Otherwise change EV_SET->EV_FREE.
@@ -420,21 +414,42 @@ void qemu_event_reset(QemuEvent *ev)
      * Pairs with the first memory barrier in qemu_event_set().
      */
     smp_mb__after_rmw();
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
 }
 
 void qemu_event_wait(QemuEvent *ev)
 {
-    unsigned value;
-
     assert(ev->initialized);
 
+#ifdef CONFIG_LINUX
     while (true) {
         /*
          * qemu_event_wait must synchronize with qemu_event_set even if it does
          * not go down the slow path, so this load-acquire is needed that
          * synchronizes with the first memory barrier in qemu_event_set().
          */
-        value = qatomic_load_acquire(&ev->value);
+        unsigned value = qatomic_load_acquire(&ev->value);
         if (value == EV_SET) {
             break;
         }
@@ -463,6 +478,13 @@ void qemu_event_wait(QemuEvent *ev)
          */
         qemu_futex_wait(ev, EV_BUSY);
     }
+#else
+    pthread_mutex_lock(&ev->lock);
+    while (qatomic_read(&ev->value) != EV_SET) {
+        pthread_cond_wait(&ev->cond, &ev->lock);
+    }
+    pthread_mutex_unlock(&ev->lock);
+#endif
 }
 
 static __thread NotifierList thread_exit;
-- 
2.49.0


