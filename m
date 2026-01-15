Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8263BD3CCB1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 05:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgG4y-0006uK-8A; Thu, 15 Jan 2026 00:39:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vgG4v-0006st-NQ
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 00:39:29 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vgG4n-0004fL-Jd
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 00:39:28 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60F5cwVc061416
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 15 Jan 2026 14:39:07 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=j60yjpKslRyTKg/5MPqUwHkO2E1MhnIuIRKEeUYLklM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1768455547; v=1;
 b=dlQPE7yLLdt0Db1SbVIQCm/ZMQnCqLrXODq76lCwQ/QwJLeiMM/xDuPLP2C8BqhC
 KTWyWASwvtX4DiOX/SUIcbLOOeuBST2mGrK1K9utjKtOVd5dPJRAaQV8fKJfs8DL
 rN46lwWmUU6X1Runrgx6KLBeMrQdy5Uga0EVO83O9fJ7Onp2DeCaq/8DAaha9mZY
 f1n2eZiKGq/URoe9Hl36Ov7M3qFwbg01PWqZWvlXZQJrfBEBq5uljkM6GeWBC+Lk
 1PR3uF35XQKrvoX/vGgFi7faoHAZW5c31E54X1EMcZJJBr9C+xdWNmQ/QFwaTFAI
 3RAjMU9CK0cCmP2gJmF6iQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 15 Jan 2026 14:38:51 +0900
Subject: [PATCH v3 2/5] qemu-thread: Add qemu_event_timedwait()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-force_rcu-v3-2-1f8bfaff4815@rsg.ci.i.u-tokyo.ac.jp>
References: <20260115-force_rcu-v3-0-1f8bfaff4815@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260115-force_rcu-v3-0-1f8bfaff4815@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

qemu_event_timedwait() is equivalent to qemu_event_wait(), except it has
a relative timeout.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 include/qemu/thread-posix.h | 11 +++++++++++
 include/qemu/thread.h       |  8 +++++++-
 util/event.c                | 28 +++++++++++++++++++++++-----
 util/qemu-thread-posix.c    | 11 +----------
 4 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h
index 758808b705e4..11193b1580f8 100644
--- a/include/qemu/thread-posix.h
+++ b/include/qemu/thread-posix.h
@@ -36,4 +36,15 @@ struct QemuThread {
     pthread_t thread;
 };
 
+static inline clockid_t qemu_timedwait_clockid(void)
+{
+#ifdef CONFIG_PTHREAD_CONDATTR_SETCLOCK
+    return CLOCK_MONOTONIC;
+#else
+    return CLOCK_REALTIME;
+#endif
+}
+
+void compute_abs_deadline(struct timespec *ts, int ms);
+
 #endif
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index f0302ed01fdb..1b08b0bcb66a 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -201,7 +201,13 @@ void qemu_sem_destroy(QemuSemaphore *sem);
 void qemu_event_init(QemuEvent *ev, bool init);
 void qemu_event_set(QemuEvent *ev);
 void qemu_event_reset(QemuEvent *ev);
-void qemu_event_wait(QemuEvent *ev);
+void qemu_event_timedwait(QemuEvent *ev, int ms);
+
+static inline void qemu_event_wait(QemuEvent *ev)
+{
+    qemu_event_timedwait(ev, INT_MAX);
+}
+
 void qemu_event_destroy(QemuEvent *ev);
 
 void qemu_thread_create(QemuThread *thread, const char *name,
diff --git a/util/event.c b/util/event.c
index 5a8141cd0e46..cb26a0bfb952 100644
--- a/util/event.c
+++ b/util/event.c
@@ -33,7 +33,15 @@ void qemu_event_init(QemuEvent *ev, bool init)
 {
 #ifndef HAVE_FUTEX
     pthread_mutex_init(&ev->lock, NULL);
+#ifdef CONFIG_PTHREAD_CONDATTR_SETCLOCK
+    pthread_condattr_t attr;
+    pthread_condattr_init(&attr);
+    pthread_condattr_setclock(&attr, qemu_timedwait_clockid());
+    pthread_cond_init(&ev->cond, &attr);
+    pthread_condattr_destroy(&attr);
+#else
     pthread_cond_init(&ev->cond, NULL);
+#endif
 #endif
 
     ev->value = (init ? EV_SET : EV_FREE);
@@ -121,15 +129,17 @@ void qemu_event_reset(QemuEvent *ev)
 #endif
 }
 
-void qemu_event_wait(QemuEvent *ev)
+void qemu_event_timedwait(QemuEvent *ev, int ms)
 {
     assert(ev->initialized);
 
 #ifdef HAVE_FUTEX
+    int64_t deadline = get_clock() + (int64_t)ms * SCALE_MS;
+
     while (true) {
         /*
-         * qemu_event_wait must synchronize with qemu_event_set even if it does
-         * not go down the slow path, so this load-acquire is needed that
+         * qemu_event_timedwait must synchronize with qemu_event_set even if it
+         * does not go down the slow path, so this load-acquire is needed that
          * synchronizes with the first memory barrier in qemu_event_set().
          */
         unsigned value = qatomic_load_acquire(&ev->value);
@@ -159,12 +169,20 @@ void qemu_event_wait(QemuEvent *ev)
          * a smp_mb() pairing with the second barrier of qemu_event_set().
          * The barrier is inside the FUTEX_WAIT system call.
          */
-        qemu_futex_wait(ev, EV_BUSY);
+        if (!qemu_futex_timedwait(ev, EV_BUSY, deadline)) {
+            break;
+        }
     }
 #else
+    struct timespec ts;
+
+    compute_abs_deadline(&ts, ms);
+
     pthread_mutex_lock(&ev->lock);
     while (qatomic_read(&ev->value) != EV_SET) {
-        pthread_cond_wait(&ev->cond, &ev->lock);
+        if (pthread_cond_timedwait(&ev->cond, &ev->lock, &ts)) {
+            break;
+        }
     }
     pthread_mutex_unlock(&ev->lock);
 #endif
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index ba725444ba63..f649bfa00015 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -44,16 +44,7 @@ static void error_exit(int err, const char *msg)
     abort();
 }
 
-static inline clockid_t qemu_timedwait_clockid(void)
-{
-#ifdef CONFIG_PTHREAD_CONDATTR_SETCLOCK
-    return CLOCK_MONOTONIC;
-#else
-    return CLOCK_REALTIME;
-#endif
-}
-
-static void compute_abs_deadline(struct timespec *ts, int ms)
+void compute_abs_deadline(struct timespec *ts, int ms)
 {
     clock_gettime(qemu_timedwait_clockid(), ts);
     ts->tv_nsec += (ms % 1000) * 1000000;

-- 
2.52.0


