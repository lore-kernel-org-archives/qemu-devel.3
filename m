Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D038E7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 05:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQKCA-00072J-TR; Wed, 25 Dec 2024 00:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tQKC8-000727-Up
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 00:44:33 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tQKC7-0008LI-B2
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 00:44:32 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso60944535ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 21:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735105470; x=1735710270;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PYcRFVNaBbHYspn9XDdEp8ak1VIr/hP0YWEzEZgYuj4=;
 b=g+3zM5iDvcuSNDXreBc9VH86Mqmnh+I+69ozCOZOeYWp2yvlsncdc7A3Q1DGX/e5Mr
 qLnbTizpG2LiKznT4yc3mR6f8+Pi7jmO8CE1XmdqdLdAAQQassvMLfHucyXyRl7auz2s
 o1swaZrPc8g5kMPpDVjxVSy3AuCLw9xEBeViwPPX6wTYP6jJ1iFACaxwEaGstLPN3rtc
 PW6dV2ZHL4wGLitxHV0VaffJEGRRNZ1MXe/7hO0bGCGBH8GFRPNFCpJ9U5VjQ6DskG6r
 3iZ9uJDLwheVRTASJrzQ+XRIHW0mMGW1w8e6L/z8320mxWZZDwVKQuQdWI7vB20Rzuft
 nSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735105470; x=1735710270;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PYcRFVNaBbHYspn9XDdEp8ak1VIr/hP0YWEzEZgYuj4=;
 b=pONF7RZXs3eMU77RWS27DOfu/TTG1ZzkgQekrQpc90J72rAiF7FNsMIEeaap/92KQE
 8VkGP64mB7830rq8kcw/N1MFAfHAIhN2UGOkRRHq3lc2lLzQdBNQHvx0zLM8lqyjIHNN
 shvEQJGaBFBo9Jt0lV0bmq3mnIXkGABfmhL2sB2WqK7sPRYtHOLXzdPzXjBgDYBT5hvM
 PxcqW1RhJhtUH93DPu6xZw2CNjYkcS6C/4eH9RgHspxPB0VdAF9dBnjrUSBDtRK8PtRL
 wSDD+lNxXCLVu2fSZ9gOMviv9e/y0XVc/LJYoAU9FRiJy2y+OPXFUeK1Rs1nLteNosC7
 gMtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQllYJ8kECvna1KillMns9v3GV7pg7n1Pa/kPXRKJksRhLlfZxlN/jDQda/+VIgY57fCY7u7EKIs4g@nongnu.org
X-Gm-Message-State: AOJu0YzFLSVO6BMyv420ICZ5Qf9tZ3OSxl6migSQJhJVi1pf+2zp8p6U
 tzAIZF58sCeRiA+9rSRjFwoG5jJCAh8j+wVlyqakSfG2V4wNL1awxnqOVxVkqxgYFFtnN0GEgwV
 0g50=
X-Gm-Gg: ASbGncvljZ2ooGNWv4SJSV6HWjYC/f8xRkzVDGth9kmES0TN2P0wZ4AgiCvOXFn9bVk
 P+Q/LSSNpFnlPwmHjuwqyxSGoQX+sZczs177gcg3Nw3ePT8x2dKitn23vqyUfW0SlMyq9PrFjjm
 1eDcXZAtpG+WnRl6K7oFfdsUXexE3JksbMNEJ4QLkip8wtPTbw/6caYEURcOKGsx1qk4ybcjv1S
 tjTCqjQDtClX7B+HU1UauVq5aM659ait/SUAXajbRFHaVJUDiqB8n18QnfM
X-Google-Smtp-Source: AGHT+IHXeDoyUqcHHFAsb3MfjDdYSpHlqL0+sCQwhI7BH1vH3qex9nH45BL1yrtyPZxVuEEhq2rxyg==
X-Received: by 2002:a17:902:d2ca:b0:216:32c4:f7f5 with SMTP id
 d9443c01a7336-219e6ea19a7mr212205245ad.19.1735105469927; 
 Tue, 24 Dec 2024 21:44:29 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-219dc96e764sm98329955ad.62.2024.12.24.21.44.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 21:44:29 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 25 Dec 2024 14:44:15 +0900
Subject: [PATCH 3/8] qemu-thread: Avoid futex abstraction for non-Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241225-event-v1-3-a58c8d63eb70@daynix.com>
References: <20241225-event-v1-0-a58c8d63eb70@daynix.com>
In-Reply-To: <20241225-event-v1-0-a58c8d63eb70@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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
2.47.1


