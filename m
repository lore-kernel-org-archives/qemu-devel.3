Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CECC3DA4A
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 08:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDfwM-0006F5-IW; Sat, 10 May 2025 04:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDfwK-0006Ee-BI
 for qemu-devel@nongnu.org; Sat, 10 May 2025 04:52:12 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDfwI-0005cv-J2
 for qemu-devel@nongnu.org; Sat, 10 May 2025 04:52:12 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso3282742b3a.2
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 01:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746867129; x=1747471929;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V3AmoeBtZ7ld+5B11D9BKRPXvvFhRVqQ7GA3mMlTtY8=;
 b=hTA0oxNtBeOUgsm2fyKGywJNbn7U4uYRS/SX+p/DEJcPUEzZFTX53CfpLBAwAjBmWC
 Bjedt3b8NC0hVZETinVQdBiuUkWBJol0Yi1CXxkSe5JdtagtVO2nrxJ55CVf9KKhcs6Z
 Awj0YQ2IC/ajhpA8HRlksERg7xX6LTlDH+ZU2RRwSJMXi/xbwAhZiRXa7aPLmFSINRBx
 1Vw9MC94cJYC0d74dJp6jwLwsWsHBILO4GsFnaTQg1KvaIDUpKAl1MBURf2Xkj/gr7wY
 t0QDOM9i553eE1ICQI7BDI2lykj+4PbUESjuf6aZR5wiJvOccHzh26xLy0nAeyOMTyUb
 bxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746867129; x=1747471929;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V3AmoeBtZ7ld+5B11D9BKRPXvvFhRVqQ7GA3mMlTtY8=;
 b=mbU/vkjKnd3nuEvfH950eTOgRGhnCligeNiGhkSqpTMiaQ7z9HpP15VXCgul4up1pS
 o/9rbDQmLP5EAzRtVZ7ShXdbIz1yjBwiHKT8crJaGlvJeIOmnoNv2HDvLmpIWhqlctXx
 Vo8kRA0X0pdXmpYUUhDxocRisVDnFHHBwoaLytltowxzHsBdi4uUf5/w6AD4cY5M1HEz
 Zwiyg1MNYdfheKHNIm+9DcO0Zss2c0/QMbBGLXgh+P0og/y2zVaM9H1b/HTdPx3KPEWW
 WkPjF5zpeKStxSGg0RM7N8qt9sCUs/pl7MVN5Pvydh5LlVrcwqGdaA0IB4l5gH8zVrZ2
 rhJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH+yAUsOwreR2AHHBg7I/btwod6Fpag+eqF1i5+mh3lYDr2G0q1fOSrlNvXHQCziWZcOh+sapccSpe@nongnu.org
X-Gm-Message-State: AOJu0YzX2e8iNfG/7D6PF4OoC3MkfFfF3hAO7lBKyD2m2cYtPKosA1Gs
 DX5Sph/GXJ1TIq6Ghb4DgvMD8HoIt0eEdt7XSqfVs77jtqefBLLJCe9wboG6164uALHcCqmyozU
 D
X-Gm-Gg: ASbGnctxt7wdlEcU/yfzOaXE+MCNi8i5a3mVk1AL+gyo5YCz/1iFUH1fGZ/BalszZG9
 HKCyCOV/p3EsY3jOBMrGXC+0Q5zwFsqhat+/ScykODcgHRlFbmJTK3ZARJ9A3nrXCp3eUO9pJzx
 5K3fKzu5k2DGXH2DStBSL3lYRCIJuZC19tnbSAa6a9Y/8XaPmpISnvVLvXR5podQnp0hE+86j4i
 3/E4dsjcaIUGTDgRt768T/tV2JHIXMPG1eHujyQ3bbjKZFduZ/pD3Uy6lYAas+Yy3EIJ6LW8KIo
 ekHYtAdH7RS/NgcjgWWJFeLQbgNv9fk+fVqxF6vjqluGrcY4J6ovtCw=
X-Google-Smtp-Source: AGHT+IGoo4mr3gETpe01hHdS+u3ETvEzXreWMGOfsOnHN7+WrJ0vZL8iiLSY/ODjC55gIJT12jnKSQ==
X-Received: by 2002:a05:6a20:438f:b0:1f5:8479:dfe2 with SMTP id
 adf61e73a8af0-215ababd10dmr9027933637.6.1746867129005; 
 Sat, 10 May 2025 01:52:09 -0700 (PDT)
Received: from localhost ([157.82.203.223])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b23439074a3sm2598265a12.0.2025.05.10.01.52.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 01:52:08 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 10 May 2025 17:51:48 +0900
Subject: [PATCH v2 3/9] qemu-thread: Avoid futex abstraction for non-Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-event-v2-3-7953177ce1b8@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
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
before wait and wake operations instead.

Add special implementations of qemu_event_set() and qemu_event_wait()
using pthread primitives. qemu_event_wait() will ensure qemu_event_set()
finishes, and these functions will avoid complex barrier and atomic
operations.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 util/qemu-thread-posix.c | 45 ++++++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 13459e44c768..805cac444f15 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -319,28 +319,6 @@ void qemu_sem_wait(QemuSemaphore *sem)
 
 #ifdef __linux__
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
@@ -363,7 +341,7 @@ static inline void qemu_futex_wait(QemuEvent *ev, unsigned val)
 
 void qemu_event_init(QemuEvent *ev, bool init)
 {
-#ifndef __linux__
+#ifndef CONFIG_LINUX
     pthread_mutex_init(&ev->lock, NULL);
     pthread_cond_init(&ev->cond, NULL);
 #endif
@@ -376,7 +354,7 @@ void qemu_event_destroy(QemuEvent *ev)
 {
     assert(ev->initialized);
     ev->initialized = false;
-#ifndef __linux__
+#ifndef CONFIG_LINUX
     pthread_mutex_destroy(&ev->lock);
     pthread_cond_destroy(&ev->cond);
 #endif
@@ -386,6 +364,7 @@ void qemu_event_set(QemuEvent *ev)
 {
     assert(ev->initialized);
 
+#ifdef CONFIG_LINUX
     /*
      * Pairs with both qemu_event_reset() and qemu_event_wait().
      *
@@ -403,6 +382,12 @@ void qemu_event_set(QemuEvent *ev)
             qemu_futex_wake_all(ev);
         }
     }
+#else
+    pthread_mutex_lock(&ev->lock);
+    qatomic_set(&ev->value, EV_SET);
+    pthread_cond_broadcast(&ev->cond);
+    pthread_mutex_unlock(&ev->lock);
+#endif
 }
 
 void qemu_event_reset(QemuEvent *ev)
@@ -424,10 +409,9 @@ void qemu_event_reset(QemuEvent *ev)
 
 void qemu_event_wait(QemuEvent *ev)
 {
-    unsigned value;
-
     assert(ev->initialized);
 
+#ifdef CONFIG_LINUX
     while (true) {
         /*
          * qemu_event_wait must synchronize with qemu_event_set even if it does
@@ -438,7 +422,7 @@ void qemu_event_wait(QemuEvent *ev)
          * might miss a qemu_event_set() here but ultimately the memory barrier
          * in qemu_futex_wait() will ensure the check is done correctly.
          */
-        value = qatomic_load_acquire(&ev->value);
+        unsigned value = qatomic_load_acquire(&ev->value);
         if (value == EV_SET) {
             break;
         }
@@ -467,6 +451,13 @@ void qemu_event_wait(QemuEvent *ev)
          */
         qemu_futex_wait(ev, EV_BUSY);
     }
+#else
+    pthread_mutex_lock(&ev->lock);
+    if (qatomic_read(&ev->value) != EV_SET) {
+        pthread_cond_wait(&ev->cond, &ev->lock);
+    }
+    pthread_mutex_unlock(&ev->lock);
+#endif
 }
 
 static __thread NotifierList thread_exit;

-- 
2.49.0


