Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0599CCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 06:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDzR7-0000aD-Fn; Wed, 29 Oct 2025 02:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDzQv-0000Wx-3K
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 02:13:23 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDzQq-0006q8-EE
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 02:13:20 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59T6CsDQ077258
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 29 Oct 2025 15:13:03 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ObGDg58GkO+t0cgNXUb4j1Xn/JeawhbGtLdiRBdfBHQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1761718383; v=1;
 b=pRXAAtGfPA9dzIG3iya0Jxlb6kacZ42OPxetCwRv/uHjiIxEKxx1CEwg0gKjOex3
 z9qWHDbPmlFM5lzDtU3v+7b6999VbIu8TtlDPVBDz3BHdvVaDT3W7bPXxLX46CQ4
 PIn7EeECtlY9O3f2Y2eIdYszU/NVMQvx08d7OI83krnecKPiq5aU/7omSD0DRQ8e
 F9MrmUBclHUCvY1xWgyCiwrpVqqrk0sonbOV72SaOAvot741rt+MAO413gGEXgw9
 bG/zfrCAGSREHsYgGUb1vJbU1mc9wIiwR43+/uxYGKerLqfJsFOqNpIP5auuT2B6
 3/N0s2wqjsLnwt0IXHriOA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 29 Oct 2025 15:12:45 +0900
Subject: [PATCH 1/5] futex: Add qemu_futex_timedwait()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-force_rcu-v1-1-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
References: <20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251029-force_rcu-v1-0-bf860a6277a6@rsg.ci.i.u-tokyo.ac.jp>
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
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

qemu_futex_timedwait() is equivalent to qemu_futex_wait(), except it has
an absolute timeout.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/qemu/futex.h | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/qemu/futex.h b/include/qemu/futex.h
index 607613eec835..e5e56603d117 100644
--- a/include/qemu/futex.h
+++ b/include/qemu/futex.h
@@ -24,6 +24,7 @@
 #ifndef QEMU_FUTEX_H
 #define QEMU_FUTEX_H
 
+#include "qemu/timer.h"
 #define HAVE_FUTEX
 
 #ifdef CONFIG_LINUX
@@ -42,18 +43,28 @@ static inline void qemu_futex_wake_single(void *f)
     qemu_futex(f, FUTEX_WAKE, 1, NULL, NULL, 0);
 }
 
-static inline void qemu_futex_wait(void *f, unsigned val)
+static inline bool qemu_futex_timedwait(void *f, unsigned val, int64_t ns)
 {
-    while (qemu_futex(f, FUTEX_WAIT, (int) val, NULL, NULL, 0)) {
+    struct timespec ts;
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
@@ -68,12 +79,20 @@ static inline void qemu_futex_wake_single(void *f)
     WakeByAddressSingle(f);
 }
 
-static inline void qemu_futex_wait(void *f, unsigned val)
+static inline bool qemu_futex_timedwait(void *f, unsigned val, int64_t ns)
 {
-    WaitOnAddress(f, &val, sizeof(val), INFINITE);
+    uint32_t duration = MIN((ns - get_clock()) / SCALE_MS, UINT32_MAX);
+    return WaitOnAddress(f, &val, sizeof(val), duration);
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
2.51.0


