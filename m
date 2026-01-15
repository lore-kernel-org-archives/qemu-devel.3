Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C5FD3CCB2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 05:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgG4x-0006uD-Q5; Thu, 15 Jan 2026 00:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vgG4t-0006ru-Oi
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 00:39:27 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vgG4n-0004fI-Kh
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 00:39:26 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60F5cwVb061416
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 15 Jan 2026 14:39:07 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=TbmQfRhW7tk1w8y2oJ/yjOqATkEcmBrVR6/713ng5E4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1768455547; v=1;
 b=Xs25c2brwstefH6vbLHiQ39CrFh/AWaBN1Bv5jKzhhFfOxw/mB1fuwaMiH7luymO
 l3G/uKKS3wO3MdbeZNt2x8ExcXZcbQDT0t3N0QYRzLPUq8RHprHti5t0NhEiTHUc
 O1zyO15vDQzyjblladXDOSzWs/CW47+7KNN5xtOyCsd0ds8mxAu7ktIl8gqDNMhE
 wL5g9uIVjFtarzC9ja7evnw322RrfxZTB0NYSOm2RFtgrNK/8NPtnbWwMN+DHIDA
 eT3v5IPoGFnX2XkhDRdOwtDfnL0kEacYozX7s5n76BWBqD6dVRUWxAKroB2BBqwQ
 iJLTZlsD2MBwRNRBLdT23A==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 15 Jan 2026 14:38:50 +0900
Subject: [PATCH v3 1/5] futex: Add qemu_futex_timedwait()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-force_rcu-v3-1-1f8bfaff4815@rsg.ci.i.u-tokyo.ac.jp>
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

qemu_futex_timedwait() is equivalent to qemu_futex_wait(), except it has
an absolute timeout.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 include/qemu/futex.h | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/include/qemu/futex.h b/include/qemu/futex.h
index 607613eec835..3f3b55008f61 100644
--- a/include/qemu/futex.h
+++ b/include/qemu/futex.h
@@ -24,13 +24,19 @@
 #ifndef QEMU_FUTEX_H
 #define QEMU_FUTEX_H
 
+#include "qemu/timer.h"
 #define HAVE_FUTEX
 
 #ifdef CONFIG_LINUX
 #include <sys/syscall.h>
 #include <linux/futex.h>
+#include <linux/time_types.h>
 
+#ifdef __NR_futex_time64
+#define qemu_futex(...)              syscall(__NR_futex_time64, __VA_ARGS__)
+#else
 #define qemu_futex(...)              syscall(__NR_futex, __VA_ARGS__)
+#endif
 
 static inline void qemu_futex_wake_all(void *f)
 {
@@ -42,18 +48,28 @@ static inline void qemu_futex_wake_single(void *f)
     qemu_futex(f, FUTEX_WAKE, 1, NULL, NULL, 0);
 }
 
-static inline void qemu_futex_wait(void *f, unsigned val)
+static inline bool qemu_futex_timedwait(void *f, unsigned val, int64_t ns)
 {
-    while (qemu_futex(f, FUTEX_WAIT, (int) val, NULL, NULL, 0)) {
+    struct __kernel_timespec ts;
+    uint32_t bitset = FUTEX_BITSET_MATCH_ANY;
+
+    ts.tv_sec = ns / NANOSECONDS_PER_SECOND;
+    ts.tv_nsec = ns % NANOSECONDS_PER_SECOND;
+
+    while (qemu_futex(f, FUTEX_WAIT_BITSET, (int) val, &ts, NULL, bitset)) {
         switch (errno) {
         case EWOULDBLOCK:
-            return;
+            return true;
         case EINTR:
             break; /* get out of switch and retry */
+        case ETIMEDOUT:
+            return false;
         default:
             abort();
         }
     }
+
+    return true;
 }
 #elif defined(CONFIG_WIN32)
 #include <synchapi.h>
@@ -68,12 +84,22 @@ static inline void qemu_futex_wake_single(void *f)
     WakeByAddressSingle(f);
 }
 
-static inline void qemu_futex_wait(void *f, unsigned val)
+static inline bool qemu_futex_timedwait(void *f, unsigned val, int64_t ns)
 {
-    WaitOnAddress(f, &val, sizeof(val), INFINITE);
+    int64_t now = get_clock();
+    DWORD duration = MIN((ns - now) / SCALE_MS, INFINITE);
+
+    return ns > now && WaitOnAddress(f, &val, sizeof(val), duration);
 }
 #else
 #undef HAVE_FUTEX
 #endif
 
+#ifdef HAVE_FUTEX
+static inline void qemu_futex_wait(void *f, unsigned val)
+{
+    qemu_futex_timedwait(f, val, INT64_MAX);
+}
+#endif
+
 #endif /* QEMU_FUTEX_H */

-- 
2.52.0


