Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CF3FE51F3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGCpg-0008Em-1a; Fri, 24 Apr 2026 05:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wGCp5-0007QI-1m
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:27:43 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wGCp0-0007aB-1L
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:27:42 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63O9RHId004358
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 24 Apr 2026 18:27:26 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=2lrFVsOwSY/n/C0RCLf6Y19MCgXdoAnnxYob5thdabU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1777022846; v=1;
 b=M6rzkSbAKaf0mJ0HK6MsyeudpxJReB/TfL3EMWS4U4j+Nmhn72rjPxMshnG5gh02
 VC8xNrwfAzFdOGE4WoIeXj9bDOYzqxw0iUnTv9cEdFfo+56UmCs+kC5N2GVOL3B/
 Rw/DGwda5xxBkhBkyrZzm3MvikNtXl6Da9uspDKi8Pl31YHtZml/pONaa5Lz1/GF
 /Tf5jYmkUJzE/hypHnjFKzViUYFTznmfx8sGCbXkv46+g9xwo1mdD9c17xeFw77T
 u375xMbHIKB99aIDRFmKJ6u7TmPoTfW6rNFo4kZOxiqA6PiGNKHrBo7dLPX+c64l
 FdqK0Rxv0P5j24bnzJXVXA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 24 Apr 2026 18:27:06 +0900
Subject: [PATCH v4 1/6] futex: Add qemu_futex_timedwait()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-force_rcu-v4-1-feccfaca0568@rsg.ci.i.u-tokyo.ac.jp>
References: <20260424-force_rcu-v4-0-feccfaca0568@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260424-force_rcu-v4-0-feccfaca0568@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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
2.53.0


