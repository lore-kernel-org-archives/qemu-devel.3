Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B899CC54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 05:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKW5r-0002xv-OW; Thu, 29 May 2025 01:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW5n-0002x5-Dd
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:15 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKW5l-0003AK-O5
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:46:15 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22e09f57ed4so15172905ad.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 22:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748497572; x=1749102372;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=48X/OtmA+PKwfi2j51VbH6eWdr4k3IlX3/dT9ZbelTw=;
 b=oZKqknpyU0rRP3qoixdk7n2nyMhC2EJUAirJTPEF7iUwn1YcTZBhBWmJtBt9BxC0H8
 ijOUofDmLrUwAfun+litk8pjzewwmJCLtFa9iXf+jMUsbDOzuP/lbbmjw9+Q+HTlHqDT
 kuH/U/lMMqKKsIzvDQpVk4tgUExy/BVc6qUvXNqrd07pRpwSah23G52uuz5dMN7JIlbm
 0nTtZVfEVKUA2oAmMEATC/T76C72LAUoBFrrnY6OX8KUyPs2uOJeDS8WmH8CEUnSxfdJ
 CunHe9Ddp4xsvr2pBnW92fR1MNaebggT9IA8Yct88VJjN0RQOYARmQlIk8slo622zWsP
 xLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748497572; x=1749102372;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48X/OtmA+PKwfi2j51VbH6eWdr4k3IlX3/dT9ZbelTw=;
 b=ZqCLoSqWd3iC2GON7GA6ZVKS7KnfAALONKNYE0cjyKphg9gkBq9ck1sLe//hPQmh0D
 89u3S8q3O0WnCHqOchNZNqkYXutYGHtzsVcnVLIBSX1CO5LoXhYddDRkKXau7Db0ZScl
 /ydvxMvTUWA/k6A1l0IJLGSXRjDdhQM1oTaVbcMb/fo1d5Eyg3LodAQo51woD0ZnTF9U
 vekd9yAnGIVk9OeRLJLzVOM3nuBGH6YHkxX0WZZUfD76hQR7NzvK++IWKiykvjQTrOgb
 SpvDYFbZJpMz0atSDeUziiYqNS7VFc837dlJJwz0SI1hA4L1QlrVFLrFEweG5kOo22gg
 uIKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM1SmiXDzZL0KpFh5MyAnpRBILPv2aSeG0+XL8tVPWwwUQgQXtLi+VKP4YCPX0Eu+uwpFZ08k7KC7J@nongnu.org
X-Gm-Message-State: AOJu0Yywx7yp2EsQr8PFFzUcKne1Kvs4Q/gmbW8+FYw7cokpI84lmoAd
 SqhdR+IUw4aiJxILtvPG654mDh7KwM8g4JqFotCraF/VnYIZ/VgMhwupryF4UmLzFvQ=
X-Gm-Gg: ASbGncstny7EIvZA7ZH9nST/OlFYYAqopSJJ+VoJr6BSSXrZ1Pq1AuKJCq8EIK+OkBS
 aiPx7OiAQQk62Ys0S28Zc53ZtFXAw1RY64cxA4Xr6v6bO3vVk/gt44COB+cegs/ELyegT+29MDN
 ycvQV5KWoZBIiqPLJaoV0RdmQnxEnKp14NKjDmzc3duqpWb5zzpJoQIuaIrzULIDGhjqo9yDf+L
 Mdoq2Pk8Zse74vrBGdvBOFf1Yu5F/OjOEiYAsv3dau7v75faFrz93mg5OKKiqq++3bn+g8dNUQJ
 I3Nef//hAosFyx2C1SbZQxlhuD5+G7uUUQ04MuT8/Wr5y5JPev/n
X-Google-Smtp-Source: AGHT+IEMmuUo6nqdmK7xUpAjL7XIVrVsIQ6VjJqAV34R58fLhBm6Pgd/jEsLxgrJfQm3Phx4/MfDng==
X-Received: by 2002:a17:903:32cf:b0:233:c5ef:3b88 with SMTP id
 d9443c01a7336-234f6780f92mr32126515ad.5.1748497572194; 
 Wed, 28 May 2025 22:46:12 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23506cfcbb9sm4980285ad.208.2025.05.28.22.46.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 22:46:11 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 29 May 2025 14:45:53 +0900
Subject: [PATCH v5 04/13] qemu-thread: Avoid futex abstraction for
 non-Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-event-v5-4-53b285203794@daynix.com>
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
---
 util/qemu-thread-posix.c | 50 +++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 21ed12ddb56b..dc13b61f1bd8 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -319,36 +319,21 @@ void qemu_sem_wait(QemuSemaphore *sem)
 
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
  * - free->set, when setting the event
- * - busy->set, when setting the event, followed by qemu_futex_wake_all
+ * - busy->set, when setting the event
  * - set->free, when resetting the event
  * - free->busy, when waiting
  *
+ * With futex, the waking and blocking operations follow busy->set and
+ * free->busy, respectively.
+ *
+ * Without futex, busy->set and free->busy never happen. Instead, the waking
+ * operation follows free->set and the blocking operation will happen when
+ * waiting if the event is not set.
+ *
  * set->busy does not happen (it can be observed from the outside but
  * it really is set->free->busy).
  *
@@ -386,6 +371,7 @@ void qemu_event_set(QemuEvent *ev)
 {
     assert(ev->initialized);
 
+#ifdef CONFIG_LINUX
     /*
      * Pairs with both qemu_event_reset() and qemu_event_wait().
      *
@@ -399,6 +385,12 @@ void qemu_event_set(QemuEvent *ev)
             qemu_futex_wake_all(ev);
         }
     }
+#else
+    pthread_mutex_lock(&ev->lock);
+    qatomic_store_release(&ev->value, EV_SET);
+    pthread_cond_broadcast(&ev->cond);
+    pthread_mutex_unlock(&ev->lock);
+#endif
 }
 
 void qemu_event_reset(QemuEvent *ev)
@@ -420,17 +412,16 @@ void qemu_event_reset(QemuEvent *ev)
 
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
@@ -454,6 +445,13 @@ void qemu_event_wait(QemuEvent *ev)
 
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


