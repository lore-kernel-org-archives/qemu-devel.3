Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC61BC3ABC5
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 06:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDzrv-0002CH-Vk; Sun, 11 May 2025 02:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzro-0002Bd-Ew
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:08:53 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDzrl-0003qn-RP
 for qemu-devel@nongnu.org; Sun, 11 May 2025 02:08:51 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso4794247b3a.2
 for <qemu-devel@nongnu.org>; Sat, 10 May 2025 23:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746943728; x=1747548528;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pmNZ7ppKIZvWL/zBQGiJLjC96XIPRx7qmwliG7uE764=;
 b=Yxe7PdEKhvOYLpaxSrxd/eDG/XiaXcD1hs9sOzT0A5fVI1nmXzqMqb0gTChwT993LM
 bNKpOuSxz6mxGdMK4W7zjX/Yk3WJ8X9Z/SPqDnFlINwExQ/a/nc+jCaGmpwsVIhUM0eD
 pjV4NMYHSjx4xqvtPDgnSgKfgRnd42E20jRLjCctIwnzDMMHdg7/8ZA8fx39NCttVk9I
 +9Mg8OlFM1qBgj7do2Zja28p0y5xChm98WZROWdEvhpY4182Y7UAoGjynVjJtMSjwzjk
 kVvyxU7MJfsswRtyj/92QtgHbjcj4fFhWPCTIrEBVwgmeRGkUj6WIEf/YbbgYilK+zkF
 dAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746943728; x=1747548528;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pmNZ7ppKIZvWL/zBQGiJLjC96XIPRx7qmwliG7uE764=;
 b=Z+brGvQHK/lj2Tp54Rxp7c++E5X+z3EhSpIwoF7P8U5mYZdo0c2oQyE+Cg+OBHYTV9
 lHES8uDdouY/9MHdzGm+2UR/LHHHfw9iSTfBKZUtxunI2yJfB3aWaXp3W7elWIvJ2wy1
 3FbOt++UhACYj0UTx91WHjHr7uySB9YKMExjcPyS6YGVcMdxJL4gkhToaVTk4xlTzqYk
 SYgoyMcRI6pi827WiDZcPyF67VeT2R39uqofbM1RdvzgKwSMyi4JCoL0AeSTHBSYZueS
 /gwF8secbOWxU16n6EUWap3pRplnA+ASIu0YqRihGUyxAc1gdW7Yd4zDAHr2R+8qLIAk
 DB+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFNWkGWe+5RcxqUlirmh5PamMK3Rd9kdVs9J4s0ppZdyQhRA+1uOWJMA2dUOyPKCkqZzGVqfinvy/L@nongnu.org
X-Gm-Message-State: AOJu0YzteKzcL79ZjoYKCQcsDMdM5yh77H/hXsD8fb99ZQbHyO6O7Fsc
 j/7ympRrY0fnpJHojkWXztaluLmdSods22hzCC5t57psaRVZ0GtOMG3NmQ8AOWbHo29rLIgKnCS
 h
X-Gm-Gg: ASbGncuKWolbCVXccrhVtXtoiGYEl2wa8X3plqh9EiBWtwApPJGRbkUms2+YREwJBsM
 9tQFq+v3WfMlYNFEcOkzLGUBSLfI0WNpW9jWBlUenBzS1oYzPTam7rbumXsWKS/UbyS6osU+Kv3
 hAOmBaavGZ0g46C9Vja6bY/DbKZvN+NlcD7HfTe8DZlmv72S3RwwBOfv7vhahVBwCNk8/Mwe4g9
 Zsa1M4K0QQJMMCrQcjcEaf8XCbT+Q0T6ouMd63htOOU+BanDir6z4he2tf50GRsXRH6DXaFAPqC
 +3OEO6Ek8WomdzUb422RDBSJLiwXLzaztXguRWtL4DqwbXuDYsylskI=
X-Google-Smtp-Source: AGHT+IGhiGar9OwyhY+ygUb8vTkxAw0bcB6qj1JAfzXLfvUFVIerZxb051yOUyjlqkbLOwYAh7XAww==
X-Received: by 2002:a05:6a20:9c88:b0:1ee:d418:f764 with SMTP id
 adf61e73a8af0-215abc6f679mr12701252637.38.1746943728512; 
 Sat, 10 May 2025 23:08:48 -0700 (PDT)
Received: from localhost ([157.82.203.223])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-30ad4d2e499sm6638795a91.16.2025.05.10.23.08.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 May 2025 23:08:48 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 11 May 2025 15:08:18 +0900
Subject: [PATCH v3 01/10] futex: Check value after qemu_futex_wait()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250511-event-v3-1-f7f69247d303@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
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


