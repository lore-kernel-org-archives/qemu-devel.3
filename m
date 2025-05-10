Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78958C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 08:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDfwD-0006Ds-HH; Sat, 10 May 2025 04:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDfwC-0006Db-3G
 for qemu-devel@nongnu.org; Sat, 10 May 2025 04:52:04 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDfwA-0005cD-5g
 for qemu-devel@nongnu.org; Sat, 10 May 2025 04:52:03 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-879d2e419b9so2448967a12.2
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 01:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746867120; x=1747471920;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pmNZ7ppKIZvWL/zBQGiJLjC96XIPRx7qmwliG7uE764=;
 b=DvyngOlEbgC3/o8VIDM5exKE/2OE9wjoL5I6pLqWZKDzgeya1HLTx5Ps+JRZHsMGLS
 CuLP4oZGAhU32UiMV1YciU1wk5Rc0LkXe4K+4eU+4WC5AQQDZH3mOwF5IaxZS0d2Agx5
 Yqdt2BD24fG+5GUL5CiFyh/vRqvqybFphC1FUWL5tfcKQ/JVmkRUbfDIo5JxAgQQ/Dqo
 DjrC84M5eL7jMV+Lr0H+/DGBZiEectDe2j/GnO3juSq/wrxt7gjEAwdF9GjM3iM7SfVb
 SyySzQy4Y9wA4jcRAcwaOfX/DTXFpyf5Z4KbWnuyQ9k6s4Xo43DQspzM939/hTq/yzGF
 X++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746867120; x=1747471920;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pmNZ7ppKIZvWL/zBQGiJLjC96XIPRx7qmwliG7uE764=;
 b=O6b3Xqpn+Gk6CxfrK7XZUXjelEpOTWJl0uIsqmZ0l+dMbLOr49sEJ3ckNyp4DVBxkN
 tEx/5DhlVd+lp0fUaA1MikJoQ7dAp3ifgwlacK0h8nIvggVi9M7bKWNAdwxGVF51Qde2
 KVvspGbH5CeV+5huSoZEtnLCp4/Y3+hPQXEPZQju1FniXiK6Gdbb12B/3Y4FqAnImiR0
 ZQFS6F0J8P3Kk7JFxHD6EsXBczFOn7ysQD4K6NM9fezhb4H2DTO57rnFx39M/k1/6goQ
 cff9ANvD1lI+PA7xnUB2ckYJ9mqBVS2ArVBPCRGB2Ts2IwfIdc3Z5EgglzG/9u93Ti8K
 6yrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsyBnSKj8ZTsrZXJ342MvT5Xg9gOWEV/EM97cHUgY1QxMNz+DV5avQvlRcB6EKak9zN9gyQazdGQk8@nongnu.org
X-Gm-Message-State: AOJu0YwWGKwODjj7Wv30L/8X2L1ZqAF0HytfwP/4Hz0c4PFyPRHay8We
 7wmcmjq/AI5KaryCqDolumx64y/I76sTjIDZ79L39/dvX8KUYz3aZhMG9XK6BQlW0sDZy6e6D9X
 b
X-Gm-Gg: ASbGncuY3oLcEnHGJM9WTSigZjEZec8vvmeRPmTh4OPiibi+rUPooKfBh3XEdCsdwdP
 upiRQCCx68/mWl80mZvTrccX4YUspOKTOLgdm4r7Q7iyGk2dhLc8z1jWsdJgO/U+a/sdxGv4n6M
 HWaUIzbKBFGKu8pMntLPesG3jMtEZd+2N7QszAo2OaBTJe/eHuS5MhOeB7KVpE3SysVjF9GluDi
 HWp+GP+entmwo8lu2IzEwmHLVkf2p0XqHXeIQzSPGM3x4nAHZygmLUfzhtHxbA4KnzRcKDvpZ78
 vo1byFDWuGdQ4p5b1WNMbEcO17d2mYE1XDGkQc1iOflA1DaL75Wshjo=
X-Google-Smtp-Source: AGHT+IErttrYztJGb15hqvo6fRcbmJ1pdAAiTTtq1OgXGxixIFyyECBty/WM7lH0LSzBjXZmxpPOxQ==
X-Received: by 2002:a17:903:3bce:b0:220:ff3f:6cc0 with SMTP id
 d9443c01a7336-22fc918ff27mr99389565ad.38.1746867120350; 
 Sat, 10 May 2025 01:52:00 -0700 (PDT)
Received: from localhost ([157.82.203.223])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22fc828b364sm29419265ad.172.2025.05.10.01.51.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 01:52:00 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 10 May 2025 17:51:46 +0900
Subject: [PATCH v2 1/9] futex: Check value after qemu_futex_wait()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-event-v2-1-7953177ce1b8@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
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

futex(2) - Linux manual page
https://man7.org/linux/man-pages/man2/futex.2.html
> Note that a wake-up can also be caused by common futex usage patterns
> in unrelated code that happened to have previously used the futex
> word's memory location (e.g., typical futex-based implementations of
> Pthreads mutexes can cause this under some conditions).  Therefore,
> callers should always conservatively assume that a return value of 0
> can mean a spurious wake-up, and use the futex word's value (i.e.,
> the user-space synchronization scheme) to decide whether to continue
> to block or not.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qemu/futex.h              |  9 +++++++++
 tests/unit/test-aio-multithread.c |  4 +++-
 util/qemu-thread-posix.c          | 28 ++++++++++++++++------------
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/include/qemu/futex.h b/include/qemu/futex.h
index 91ae88966e12..f57774005330 100644
--- a/include/qemu/futex.h
+++ b/include/qemu/futex.h
@@ -24,6 +24,15 @@ static inline void qemu_futex_wake(void *f, int n)
     qemu_futex(f, FUTEX_WAKE, n, NULL, NULL, 0);
 }
 
+/*
+ * Note that a wake-up can also be caused by common futex usage patterns in
+ * unrelated code that happened to have previously used the futex word's
+ * memory location (e.g., typical futex-based implementations of Pthreads
+ * mutexes can cause this under some conditions).  Therefore, callers should
+ * always conservatively assume that it is a spurious wake-up, and use the futex
+ * word's value (i.e., the user-space synchronization scheme) to decide whether
+ * to continue to block or not.
+ */
 static inline void qemu_futex_wait(void *f, unsigned val)
 {
     while (qemu_futex(f, FUTEX_WAIT, (int) val, NULL, NULL, 0)) {
diff --git a/tests/unit/test-aio-multithread.c b/tests/unit/test-aio-multithread.c
index 08d4570ccb14..8c2e41545a29 100644
--- a/tests/unit/test-aio-multithread.c
+++ b/tests/unit/test-aio-multithread.c
@@ -305,7 +305,9 @@ static void mcs_mutex_lock(void)
     prev = qatomic_xchg(&mutex_head, id);
     if (prev != -1) {
         qatomic_set(&nodes[prev].next, id);
-        qemu_futex_wait(&nodes[id].locked, 1);
+        while (qatomic_read(&nodes[id].locked) == 1) {
+            qemu_futex_wait(&nodes[id].locked, 1);
+        }
     }
 }
 
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index b2e26e21205b..eade5311d175 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -428,17 +428,21 @@ void qemu_event_wait(QemuEvent *ev)
 
     assert(ev->initialized);
 
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
+        value = qatomic_load_acquire(&ev->value);
+        if (value == EV_SET) {
+            break;
+        }
+
         if (value == EV_FREE) {
             /*
              * Leave the event reset and tell qemu_event_set that there are
@@ -452,7 +456,7 @@ void qemu_event_wait(QemuEvent *ev)
              * like the load above.
              */
             if (qatomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) == EV_SET) {
-                return;
+                break;
             }
         }
 

-- 
2.49.0


