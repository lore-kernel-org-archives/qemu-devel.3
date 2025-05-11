Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F510C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 06:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDzs3-0002Dr-9p; Sun, 11 May 2025 02:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzs1-0002Db-Kk
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:09:05 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzrz-0003tt-Rw
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:09:05 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so3457962b3a.1
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 23:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746943742; x=1747548542;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t4He4Y15Xp8xwu9a/XWtChbFBOOATPRIJaHB0mBDOUI=;
 b=ZoQKZUfIunKae00mIhUZ+wlvi0CTJ0pTAgSHsw98lvVVUq+vRGukTjbZJnclMmMQEi
 5P5Ht2AzhmKIvEOrVnBCrT2A7dZtv0ZhV2nYKjm14WGX0a+5MY8QG08WxngayIyL+wGe
 QmwC/LX78Pb8vEV73u3DS5Icac6BTfediH9LtrTVjAusEsk9e3k/9TVRjSHsMOlpxARa
 HW4R/IUFc1FbjstweoSjykcfIdMDERhXye5Voht1TAEtyeqRz5f7J6ws8ksxWq2NTwA8
 w5pASkTQks8B8/QEDvA8AjInU6MFX7pGCA1ICBlGI9rBehKLSLg08TjQI5jGV75Gk48W
 xB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746943742; x=1747548542;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t4He4Y15Xp8xwu9a/XWtChbFBOOATPRIJaHB0mBDOUI=;
 b=elCb5bATreD2UfVtMJ1xwGCcoLQsSEF3KCtEXnPUqwEbRLXvlrz/6Qq0qbh2qULEtZ
 OTANqm/tL4fv5RfITrUqzLBBiMvLmH2t2z9JkWyFvJ95zDuDXvvpk74D5y2VK4wQccKq
 zVH3K2hMMr8cDSLAQx0a25LD98aSlQmpx8y+pLriEM8+KqVPGT+cF0IJdiZ0kPo0Yvu0
 FGfkZ96Fa4Jm4TE/PJgt38qScKvSS9CQesI1Z5tJtQG+cyWUyeHXJRo4vbKSQJHI/jrn
 yiMNA5SY76L9mmFYF1vlBR7mnhVj9ZJyQlnnTvQBQcuBifh2XOw0YWPNRebahCEFc4VV
 UdJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMNrUwuB72YqClgrZeLnzKLsva4xQjiwFFdVHnqKYrGs9gZm2ZLJz0IH71AqZz2fwVmsisn6AMBFLS@nongnu.org
X-Gm-Message-State: AOJu0YwnkXHJzeDq0VD2Ep/tAEtYmff/BwRInDOcgNg8secvxtonbEIx
 fX5LJZZ1ZFjCHEkShBrXzduXC1Z4lqLW7spViqPhC2TVuq1w8O3tvqin+u7Ff3w=
X-Gm-Gg: ASbGncvPv5PZgdBN4BIXqbEYgPmTDdlTYlGVC76p+OMQdfQZ0KDk/V2Ek7pK8WClr9N
 bE16fkCag3W7znPfqmvR+7etgd6/AVfWIY6m7MKcEPnQSlqSOSv6be49PPn8PCfmpoztC/DXet0
 z7/uEgGw4sV28brUGRAikO1MEf2Jn6evvUmjH2bzTb8f1W26pY5yvnM82+/Mm106QUeglqmOuAQ
 j9USoiqNaBwwxKlcmX732Gy0Fzm9t52QofLTrcl/RaEmC8uOfluHqJTgwhk/dz7BetniH4V2rNN
 jTfZTitU07KTtm/z4MzDN8lebLpIA+tiykzG+UbT0vcoeQ6WuP6xJpU=
X-Google-Smtp-Source: AGHT+IGy6lk1rDPNGiPejFJq+SeQS2zPbbQPOcH88b6uOAdaEIjv9Yn3IZO20IE9s8vmRhAuLmTMlg==
X-Received: by 2002:a05:6a20:d48e:b0:1f5:8072:d7f3 with SMTP id
 adf61e73a8af0-215abc17313mr15535012637.30.1746943742496; 
 Sat, 10 May 2025 23:09:02 -0700 (PDT)
Received: from localhost ([157.82.203.223])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b2350ddbb93sm3705853a12.61.2025.05.10.23.08.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 23:09:02 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 11 May 2025 15:08:21 +0900
Subject: [PATCH v3 04/10] qemu-thread: Avoid futex abstraction for
 non-Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250511-event-v3-4-f7f69247d303@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
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
 util/qemu-thread-posix.c | 47 +++++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index dfe26b8d020c..6dc6f2b25dce 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -319,28 +319,6 @@ void qemu_sem_wait(QemuSemaphore *sem)
 
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
@@ -387,12 +365,17 @@ void qemu_event_set(QemuEvent *ev)
     assert(ev->initialized);
 
     /*
-     * Pairs with both qemu_event_reset() and qemu_event_wait().
+     * Pairs with qemu_event_wait() (on Linux) and qemu_event_reset().
      *
      * qemu_event_set has release semantics, but because it *loads*
      * ev->value we need a full memory barrier here.
+     *
+     * qemu_event_wait() do not have a paired barrier on non-Linux because
+     * ev->lock ensures ordering.
      */
     smp_mb();
+
+#ifdef CONFIG_LINUX
     if (qatomic_read(&ev->value) != EV_SET) {
         int old = qatomic_xchg(&ev->value, EV_SET);
 
@@ -403,6 +386,12 @@ void qemu_event_set(QemuEvent *ev)
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
@@ -424,10 +413,9 @@ void qemu_event_reset(QemuEvent *ev)
 
 void qemu_event_wait(QemuEvent *ev)
 {
-    unsigned value;
-
     assert(ev->initialized);
 
+#ifdef CONFIG_LINUX
     while (true) {
         /*
          * qemu_event_wait must synchronize with qemu_event_set even if it does
@@ -438,7 +426,7 @@ void qemu_event_wait(QemuEvent *ev)
          * might miss a qemu_event_set() here but ultimately the memory barrier
          * in qemu_futex_wait() will ensure the check is done correctly.
          */
-        value = qatomic_load_acquire(&ev->value);
+        unsigned value = qatomic_load_acquire(&ev->value);
         if (value == EV_SET) {
             break;
         }
@@ -467,6 +455,13 @@ void qemu_event_wait(QemuEvent *ev)
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


