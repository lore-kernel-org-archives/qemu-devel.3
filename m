Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB3EC54FC6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 05:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQPD-000723-Ra; Mon, 26 May 2025 01:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQP9-000711-Cd
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:29:43 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQP7-0001yC-8z
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:29:43 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b1396171fb1so825779a12.2
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748237379; x=1748842179;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HaTVJl5X/iMHZrzBG8WLsBUCVEErv5uxJdxFT0AP/9o=;
 b=BgtiJlcOjpn6aLN2WW86qQbjmQjZBUsBEY7gUiXHi3Y5COWVzzWezO/zogXhQSOwgA
 YHZ6YSitxkIctiMvX04ZPyFMCZN2VZnGAK5+9+niAL14Pta3ZfdpXAWF40MzWxYOzybi
 WHCAqxVRp0c1tR5BvUkBteHjs8oIOcaSAhh8z/ttwXdJ8DfjeUKBjbwTCpV/259pjkUv
 7K56yx5VKy//glrv8cPX0DZnPBbZ02tk5owzEkl5FBHKRsDlx2HbBrl/vtFqyO2UfAkL
 IisVvUrZHXaGecQc6yRHixfkpf2+34tgq53lvdoKKRbndff2ooocGaIMj0LY4dsfYBy0
 l+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748237379; x=1748842179;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HaTVJl5X/iMHZrzBG8WLsBUCVEErv5uxJdxFT0AP/9o=;
 b=OIcpDPbIKeEoahMZ7Sfa10IRAQaUsjAZ3OM/kV5SJWrGgxBuy7NKiZr++CzZHfQJ0i
 c3M7pCG57cM5TNZv0YOJ54mn+Xod4lYIVENCcp6ZIIhM4cDaEtZ8Iq7k6DKtTpKVEHMu
 FffBUKHA2JL9lX5VdPQW3zpHUZMku0Ct9R2oFTgudVLB1KMrXR40awCOkAMf/vQzUfMH
 d8f/uiphJ8umY9hP5+z93QCW1ikMa4Nd2VjeMoUsF9YAyr/7X2uLWYRWCMuvoZi3XWLA
 aweFTgBoStP2RlmGtl+INCqTi2YydRy/UG6tgkw0IJ+XnT1S96BGUCqq3NNr/565U6Xu
 8T+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWedI36aYERfr68Wu6D/xL1hn3Gff4CuMRVLLYVJ7pk4Q0lmc+z6XKWohWck9vjZeskEJD7y5ocUAmn@nongnu.org
X-Gm-Message-State: AOJu0YzIPUHuI43Vd4HGhftEQkU9D7izFVhWSYZ4c6ZNwC+4cTEa8YgN
 vYp8eXzUk9aJDNwMjVszqiaonHXJCP2KTo1cEromk2ZxI6V6CjxfV1CBPZWZniU19jIimnsZIiU
 kqARd
X-Gm-Gg: ASbGnctnck2IcsvZqkY5Xzg6r/JclOUHCITxXSQE4ttz72kzMrLzxvpq6+qM9Fl5kTl
 2UGoKA1I/Vg6spUn9mRp4gkwt1t/u+a5q9/nxXlZBnR0bT+5rrp90Lg3uuBoFtwLMJKL1eyHxgz
 lL096KrXncsT1PrtBOhBKHG+zMy5oJOipWx9SKgOKiUoQOLQoF0yO9aXx1fZEI935i8xpMfsU5f
 YKtn5NLaFkJs29qd5ZMw9ODy8p8WZGgeVlWpffV420ioee8PKepuT6yeduAqC+afgKCntTvhrBw
 ILVdd+o5SUN/JnWmQdg0FZxB739/sQReeO3Z7gkM01suh5nT2Qhl
X-Google-Smtp-Source: AGHT+IH03++i2pmBxdfeS59pJcyBNoHbez51/FuB8e50sXU/AfQ63FMq6wGaB5wsS6XToYgKVo/g7g==
X-Received: by 2002:a17:90b:3c90:b0:2ef:31a9:95c6 with SMTP id
 98e67ed59e1d1-3110f30f0d6mr14311900a91.14.1748237379145; 
 Sun, 25 May 2025 22:29:39 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3111f4647dasm3379133a91.48.2025.05.25.22.29.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 22:29:38 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 26 May 2025 14:29:15 +0900
Subject: [PATCH v4 05/11] qemu-thread: Avoid futex abstraction for
 non-Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-event-v4-5-5b784cc8e1de@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
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
 util/qemu-thread-posix.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 0d6344f4d216..be7f25f9b31d 100644
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
@@ -386,10 +364,17 @@ void qemu_event_set(QemuEvent *ev)
 {
     assert(ev->initialized);
 
+#ifdef CONFIG_LINUX
     if (qatomic_xchg(&ev->value, EV_SET) == EV_BUSY) {
         /* There were waiters, wake them up.  */
         qemu_futex_wake_all(ev);
     }
+#else
+    pthread_mutex_lock(&ev->lock);
+    qatomic_store_release(&ev->value, EV_SET);
+    pthread_cond_broadcast(&ev->cond);
+    pthread_mutex_unlock(&ev->lock);
+#endif
 }
 
 void qemu_event_reset(QemuEvent *ev)
@@ -411,17 +396,16 @@ void qemu_event_reset(QemuEvent *ev)
 
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
          * synchronizes with the store-release in qemu_event_set().
          */
-        value = qatomic_load_acquire(&ev->value);
+        unsigned value = qatomic_load_acquire(&ev->value);
         if (value == EV_SET) {
             break;
         }
@@ -445,6 +429,13 @@ void qemu_event_wait(QemuEvent *ev)
 
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


