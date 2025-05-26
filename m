Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A4EC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 05:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQP2-0006zK-Vl; Mon, 26 May 2025 01:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQOs-0006ye-3p
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:29:27 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJQOp-0001wr-Db
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:29:25 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2347d505445so671145ad.2
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748237362; x=1748842162;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yTPfHSkJeZJYv7e6JgZMLSvgYFLhEBeDXdNvOQ5ttIE=;
 b=hLYrT2XHtV1lMUXPyJj0Vm+mdBW9NQTwEwekJ3PjtWouxB1BxVNI5yYIAo55bMO6nd
 1zrATict/H73kKGtY7f6YZVQnuyYzvd5h4Cg1XhFECW+6umdiNG7Zu4BQujinTAgZwJ2
 v800V6DqoWaWSdKGW+0JH7lDLoo85lUZz09bQLm/h6eZ9JN/yviGRytoqc1VQWFRciBK
 jM9D2f2Dz/2ZEr1jffbVPXDFGMj72XhgKPVeVNTvQNLwV26wW4XTw49uNShQyvIuC70c
 HmgTJUyzmy6nOjimoUB+OUD5Liug/Lb50ix97Y5pTzC8mUAuitTrKo335EhAmve9C2pD
 BPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748237362; x=1748842162;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTPfHSkJeZJYv7e6JgZMLSvgYFLhEBeDXdNvOQ5ttIE=;
 b=Aj1TUWcNODT6EAiMRmgMzK/qTfMS4ZjEBpNRl0Wv9z/fFKViDEiyuoPkj4Ohy5yJxe
 uW1MzwvhVE4Uo+JQmBXw+PEsteNqePkkAQ6c4hL4qv1R7SQswFz59I5fb/v8SYTFnBFC
 XtLklmhhhl/VEUZ2KyWM85R+E0T6cY9Bpb186R3ufvePF2qITgdJmlpfzRsLqM7aO6r4
 ds67RUf3Mr1iea0k1lh474PHbz6ejdK510HDVgcpvefDUL4ToF0/iXBJtSgaoCxxdcjm
 mTPDE5OhtLgghEEEB5+FTbHUiyxAIor6WKF8DsQLwbas1dBX1Wy0LqFYxxmEP+qL4wh9
 jg2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSYGcZJCHRjUWYtRqNY1vY517B8Uxx1Br+EuXKW2ByGa4Xg2TjaY9nGYDJDskB9x1g3j1yjz7pQUiv@nongnu.org
X-Gm-Message-State: AOJu0Yw7X6gqeYxSK0XEpv25pI7fg/E8cVs2ZLt1jjWllFa5wVRnGdo3
 kg3REwa2+nq0RbHQQAS09sREDLR0zbjyAq5Pj1qCYfwRnxcfj5BlDlb8FZXMDHslo4ukZFws27t
 wfbYT
X-Gm-Gg: ASbGncvVG91Txl9qDFAHsGBcusJ+C3X1s+2iUXXZ8/5WPUlm0nFeBRlM6Wqwon6g+Vt
 4mYAqi/9xCHkDNBIQgIcWwbvrX08sVHpzF6vNBmL8vIhMLWei2RKT1vF+9AWINVfDEn+M3h9uWK
 XOwRoSsUOydMMJOcTwjJ2SfKOVExKE4B9i3h77bKn5aKahvgxdu5CoVrQWiOiFEn3WGYegOA2ry
 L5Pl7pR/rfQINm1/xWALtO6v9dETxdtbsUmHPNIcOa1YKp41w2iFnHcS+kNZXK/U5P/Xwh/0c87
 Dmd73Z0ottc1QcY9+Y8Q/wHtxU3uxtxi9b0JMejeL3Wj9Kk2HxTG
X-Google-Smtp-Source: AGHT+IG6D00Vkzrdtz1BoGZzsKkk7Rvyr6qPMSJbV5WbXbynlqwoRgbeJZ7kFMDxZePvjbZI2Dnw3g==
X-Received: by 2002:a17:903:3a86:b0:231:9902:1519 with SMTP id
 d9443c01a7336-23414fd3e28mr125388425ad.39.1748237361709; 
 Sun, 25 May 2025 22:29:21 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2340c4eb87dsm38075125ad.17.2025.05.25.22.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 22:29:21 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 26 May 2025 14:29:11 +0900
Subject: [PATCH v4 01/11] futex: Check value after qemu_futex_wait()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-event-v4-1-5b784cc8e1de@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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
 util/qemu-thread-posix.c          | 35 +++++++++++++----------------------
 3 files changed, 25 insertions(+), 23 deletions(-)

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
index b2e26e21205b..04fc3bf2298e 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -394,11 +394,7 @@ void qemu_event_set(QemuEvent *ev)
      */
     smp_mb();
     if (qatomic_read(&ev->value) != EV_SET) {
-        int old = qatomic_xchg(&ev->value, EV_SET);
-
-        /* Pairs with memory barrier in kernel futex_wait system call.  */
-        smp_mb__after_rmw();
-        if (old == EV_BUSY) {
+        if (qatomic_xchg(&ev->value, EV_SET) == EV_BUSY) {
             /* There were waiters, wake them up.  */
             qemu_futex_wake(ev, INT_MAX);
         }
@@ -428,17 +424,17 @@ void qemu_event_wait(QemuEvent *ev)
 
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
+         */
+        value = qatomic_load_acquire(&ev->value);
+        if (value == EV_SET) {
+            break;
+        }
+
         if (value == EV_FREE) {
             /*
              * Leave the event reset and tell qemu_event_set that there are
@@ -452,15 +448,10 @@ void qemu_event_wait(QemuEvent *ev)
              * like the load above.
              */
             if (qatomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) == EV_SET) {
-                return;
+                break;
             }
         }
 
-        /*
-         * This is the final check for a concurrent set, so it does need
-         * a smp_mb() pairing with the second barrier of qemu_event_set().
-         * The barrier is inside the FUTEX_WAIT system call.
-         */
         qemu_futex_wait(ev, EV_BUSY);
     }
 }

-- 
2.49.0


