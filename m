Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC20C52D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 13:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sewuR-0005Wv-T0; Fri, 16 Aug 2024 09:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sewuM-0005EY-La
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 09:22:25 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sewuK-0007kd-50
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 09:22:22 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42816ca782dso14897415e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 06:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723814539; x=1724419339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tbFKdbxYbnOhLfqgIpN9vAb16GVhlAA5iH79ZtRgaj8=;
 b=Dj9mRKkwOdmGubtl7nJltjaSORRqagS7qtH1KIoSJNcQ0qQpFe8lURqD+l483ewK+G
 WaGBw+wn9APLCnOlGi5xPDQEJbjV8YYx23tJE4GHPD7HRoCAVNwplHWgCbfY2U/JS9FK
 1B8zjXKXGhmY0z/J98XN/b9AwXITeWNIu9xlm+JuNGyB+liwe1h8z1o4FmPx8FVOmm6e
 aHK7JMl+k+eINFPKiLU+uvREbDjfdXZZzjG2Gy0ysB3hEVOxWeGJrNUHDeRblx0ByH86
 cpnYWPbV256gd+wulRRqtMAfsPPq4GPJfqjDi67BgnoF97Dnrun/MUxTcfURftBtzxRQ
 eHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723814539; x=1724419339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tbFKdbxYbnOhLfqgIpN9vAb16GVhlAA5iH79ZtRgaj8=;
 b=brMYq/kVX3iieGRnmg9UQw3/IjZBphvSednGZj2d16N3GJPwroT8khPzWjOXvuQiBt
 lL7XZzBbEI1jubTJ+/rvennvUFUb0VzT2pxEUoPZtS9zchMljdIeOgwvjn96naGh1z0t
 7d0v/rgfV5herf0MxpYy678SDxJg/05/RIqYbCUf1J69XAi/neuzsMbMYY//HIGgBPI7
 H2K/XNylXDzJ5nFgZ2Xlr8Vs//A1A0jSNiHBRFce9Ei+/iykFSQiXWNlV2DHk2cv+5h6
 gmLs4r+q8DAkophbkW4tPOkjgdOwGSoFIp85IdoHZebj1P+lOBjulQ+/+Hri6veC48/m
 MzWQ==
X-Gm-Message-State: AOJu0YzrDbLLZ2cADwOMo5NuQp9N9WICY60q04J4aA+AmSXTGK12KEy5
 K1WRCcf4S0vX1SD09nsypniCj32c2B43V+j8oWCCYzj5E22cCoxS7vC2rqGDlKaR2gaJNuTqvGX
 3
X-Google-Smtp-Source: AGHT+IGHybU9Txyn8OmYaoT6edezR8sDktJlr/6kIrcsbP5ZDHobMtGaaDAebnnJZnqUtXFoZzvRCw==
X-Received: by 2002:a05:6000:1365:b0:367:980a:6aa with SMTP id
 ffacd0b85a97d-371946bf62dmr2252621f8f.54.1723814538477; 
 Fri, 16 Aug 2024 06:22:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898ab855sm3631948f8f.105.2024.08.16.06.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 06:22:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 6/7] include: Move QemuLockCnt APIs to their own header
Date: Fri, 16 Aug 2024 14:22:11 +0100
Message-Id: <20240816132212.3602106-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816132212.3602106-1-peter.maydell@linaro.org>
References: <20240816132212.3602106-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently the QemuLockCnt data structure and associated functions are
in the include/qemu/thread.h header.  Move them to their own
qemu/lockcnt.h.  The main reason for doing this is that it means we
can autogenerate the documentation comments into the docs/devel
documentation.

The copyright/author in the new header is drawn from lockcnt.c,
since the header changes were added in the same commit as
lockcnt.c; since neither thread.h nor lockcnt.c state an explicit
license, the standard default of GPL-2-or-later applies.

We include the new header (and the .c file, which was accidentally
omitted previously) in the "RCU" part of MAINTAINERS, since that
is where the lockcnt.rst documentation is categorized.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Paolo: could you confirm that you meant GPL2+ for this code?
---
 MAINTAINERS            |   2 +
 docs/devel/lockcnt.rst |   2 +-
 include/block/aio.h    |   1 +
 include/hw/core/cpu.h  |   1 +
 include/qemu/lockcnt.h | 130 +++++++++++++++++++++++++++++++++++++++++
 include/qemu/thread.h  | 111 -----------------------------------
 accel/accel-blocker.c  |   1 +
 hw/core/cpu-common.c   |   1 +
 util/aio-posix.c       |   1 +
 util/aio-win32.c       |   1 +
 util/async.c           |   1 +
 util/fdmon-epoll.c     |   1 +
 util/lockcnt.c         |   1 +
 13 files changed, 142 insertions(+), 112 deletions(-)
 create mode 100644 include/qemu/lockcnt.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f8f4df44460..2da11411ff3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3115,8 +3115,10 @@ S: Maintained
 F: docs/devel/lockcnt.rst
 F: docs/devel/rcu.rst
 F: include/qemu/rcu*.h
+F: include/qemu/lockcnt.h
 F: tests/unit/rcutorture.c
 F: tests/unit/test-rcu-*.c
+F: util/lockcnt.c
 F: util/rcu.c
 
 Human Monitor (HMP)
diff --git a/docs/devel/lockcnt.rst b/docs/devel/lockcnt.rst
index 994aeb57151..728594bcea3 100644
--- a/docs/devel/lockcnt.rst
+++ b/docs/devel/lockcnt.rst
@@ -175,7 +175,7 @@ three instructions in the critical path, two assignments and a ``smp_wmb()``.
 ``QemuLockCnt`` API
 -------------------
 
-The ``QemuLockCnt`` API is described in ``include/qemu/thread.h``.
+The ``QemuLockCnt`` API is described in ``include/qemu/lockcnt.h``.
 
 
 ``QemuLockCnt`` usage
diff --git a/include/block/aio.h b/include/block/aio.h
index 4ee81936ed5..43883a8a33a 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -20,6 +20,7 @@
 #include "qemu/coroutine-core.h"
 #include "qemu/queue.h"
 #include "qemu/event_notifier.h"
+#include "qemu/lockcnt.h"
 #include "qemu/thread.h"
 #include "qemu/timer.h"
 #include "block/graph-lock.h"
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 1c9c775df65..ecbeeb1c0dd 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -33,6 +33,7 @@
 #include "qemu/bitmap.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/queue.h"
+#include "qemu/lockcnt.h"
 #include "qemu/thread.h"
 #include "qom/object.h"
 
diff --git a/include/qemu/lockcnt.h b/include/qemu/lockcnt.h
new file mode 100644
index 00000000000..2c92ae17c9e
--- /dev/null
+++ b/include/qemu/lockcnt.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QemuLockCnt implementation
+ *
+ * Copyright Red Hat, Inc. 2017
+ *
+ * Author:
+ *   Paolo Bonzini <pbonzini@redhat.com>
+ *
+ */
+
+#ifndef QEMU_LOCKCNT_H
+#define QEMU_LOCKCNT_H
+
+#include "qemu/thread.h"
+
+typedef struct QemuLockCnt QemuLockCnt;
+
+struct QemuLockCnt {
+#ifndef CONFIG_LINUX
+    QemuMutex mutex;
+#endif
+    unsigned count;
+};
+
+/**
+ * qemu_lockcnt_init: initialize a QemuLockcnt
+ * @lockcnt: the lockcnt to initialize
+ *
+ * Initialize lockcnt's counter to zero and prepare its mutex
+ * for usage.
+ */
+void qemu_lockcnt_init(QemuLockCnt *lockcnt);
+
+/**
+ * qemu_lockcnt_destroy: destroy a QemuLockcnt
+ * @lockcnt: the lockcnt to destruct
+ *
+ * Destroy lockcnt's mutex.
+ */
+void qemu_lockcnt_destroy(QemuLockCnt *lockcnt);
+
+/**
+ * qemu_lockcnt_inc: increment a QemuLockCnt's counter
+ * @lockcnt: the lockcnt to operate on
+ *
+ * If the lockcnt's count is zero, wait for critical sections
+ * to finish and increment lockcnt's count to 1.  If the count
+ * is not zero, just increment it.
+ *
+ * Because this function can wait on the mutex, it must not be
+ * called while the lockcnt's mutex is held by the current thread.
+ * For the same reason, qemu_lockcnt_inc can also contribute to
+ * AB-BA deadlocks.  This is a sample deadlock scenario:
+ *
+ *            thread 1                      thread 2
+ *            -------------------------------------------------------
+ *            qemu_lockcnt_lock(&lc1);
+ *                                          qemu_lockcnt_lock(&lc2);
+ *            qemu_lockcnt_inc(&lc2);
+ *                                          qemu_lockcnt_inc(&lc1);
+ */
+void qemu_lockcnt_inc(QemuLockCnt *lockcnt);
+
+/**
+ * qemu_lockcnt_dec: decrement a QemuLockCnt's counter
+ * @lockcnt: the lockcnt to operate on
+ */
+void qemu_lockcnt_dec(QemuLockCnt *lockcnt);
+
+/**
+ * qemu_lockcnt_dec_and_lock: decrement a QemuLockCnt's counter and
+ * possibly lock it.
+ * @lockcnt: the lockcnt to operate on
+ *
+ * Decrement lockcnt's count.  If the new count is zero, lock
+ * the mutex and return true.  Otherwise, return false.
+ */
+bool qemu_lockcnt_dec_and_lock(QemuLockCnt *lockcnt);
+
+/**
+ * qemu_lockcnt_dec_if_lock: possibly decrement a QemuLockCnt's counter and
+ * lock it.
+ * @lockcnt: the lockcnt to operate on
+ *
+ * If the count is 1, decrement the count to zero, lock
+ * the mutex and return true.  Otherwise, return false.
+ */
+bool qemu_lockcnt_dec_if_lock(QemuLockCnt *lockcnt);
+
+/**
+ * qemu_lockcnt_lock: lock a QemuLockCnt's mutex.
+ * @lockcnt: the lockcnt to operate on
+ *
+ * Remember that concurrent visits are not blocked unless the count is
+ * also zero.  You can use qemu_lockcnt_count to check for this inside a
+ * critical section.
+ */
+void qemu_lockcnt_lock(QemuLockCnt *lockcnt);
+
+/**
+ * qemu_lockcnt_unlock: release a QemuLockCnt's mutex.
+ * @lockcnt: the lockcnt to operate on.
+ */
+void qemu_lockcnt_unlock(QemuLockCnt *lockcnt);
+
+/**
+ * qemu_lockcnt_inc_and_unlock: combined unlock/increment on a QemuLockCnt.
+ * @lockcnt: the lockcnt to operate on.
+ *
+ * This is the same as
+ *
+ *     qemu_lockcnt_unlock(lockcnt);
+ *     qemu_lockcnt_inc(lockcnt);
+ *
+ * but more efficient.
+ */
+void qemu_lockcnt_inc_and_unlock(QemuLockCnt *lockcnt);
+
+/**
+ * qemu_lockcnt_count: query a LockCnt's count.
+ * @lockcnt: the lockcnt to query.
+ *
+ * Note that the count can change at any time.  Still, while the
+ * lockcnt is locked, one can usefully check whether the count
+ * is non-zero.
+ */
+unsigned qemu_lockcnt_count(QemuLockCnt *lockcnt);
+
+#endif
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index fb74e21c08a..7eba27a7049 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -293,115 +293,4 @@ static inline void qemu_spin_unlock(QemuSpin *spin)
 #endif
 }
 
-struct QemuLockCnt {
-#ifndef CONFIG_LINUX
-    QemuMutex mutex;
-#endif
-    unsigned count;
-};
-
-/**
- * qemu_lockcnt_init: initialize a QemuLockcnt
- * @lockcnt: the lockcnt to initialize
- *
- * Initialize lockcnt's counter to zero and prepare its mutex
- * for usage.
- */
-void qemu_lockcnt_init(QemuLockCnt *lockcnt);
-
-/**
- * qemu_lockcnt_destroy: destroy a QemuLockcnt
- * @lockcnt: the lockcnt to destruct
- *
- * Destroy lockcnt's mutex.
- */
-void qemu_lockcnt_destroy(QemuLockCnt *lockcnt);
-
-/**
- * qemu_lockcnt_inc: increment a QemuLockCnt's counter
- * @lockcnt: the lockcnt to operate on
- *
- * If the lockcnt's count is zero, wait for critical sections
- * to finish and increment lockcnt's count to 1.  If the count
- * is not zero, just increment it.
- *
- * Because this function can wait on the mutex, it must not be
- * called while the lockcnt's mutex is held by the current thread.
- * For the same reason, qemu_lockcnt_inc can also contribute to
- * AB-BA deadlocks.  This is a sample deadlock scenario:
- *
- *            thread 1                      thread 2
- *            -------------------------------------------------------
- *            qemu_lockcnt_lock(&lc1);
- *                                          qemu_lockcnt_lock(&lc2);
- *            qemu_lockcnt_inc(&lc2);
- *                                          qemu_lockcnt_inc(&lc1);
- */
-void qemu_lockcnt_inc(QemuLockCnt *lockcnt);
-
-/**
- * qemu_lockcnt_dec: decrement a QemuLockCnt's counter
- * @lockcnt: the lockcnt to operate on
- */
-void qemu_lockcnt_dec(QemuLockCnt *lockcnt);
-
-/**
- * qemu_lockcnt_dec_and_lock: decrement a QemuLockCnt's counter and
- * possibly lock it.
- * @lockcnt: the lockcnt to operate on
- *
- * Decrement lockcnt's count.  If the new count is zero, lock
- * the mutex and return true.  Otherwise, return false.
- */
-bool qemu_lockcnt_dec_and_lock(QemuLockCnt *lockcnt);
-
-/**
- * qemu_lockcnt_dec_if_lock: possibly decrement a QemuLockCnt's counter and
- * lock it.
- * @lockcnt: the lockcnt to operate on
- *
- * If the count is 1, decrement the count to zero, lock
- * the mutex and return true.  Otherwise, return false.
- */
-bool qemu_lockcnt_dec_if_lock(QemuLockCnt *lockcnt);
-
-/**
- * qemu_lockcnt_lock: lock a QemuLockCnt's mutex.
- * @lockcnt: the lockcnt to operate on
- *
- * Remember that concurrent visits are not blocked unless the count is
- * also zero.  You can use qemu_lockcnt_count to check for this inside a
- * critical section.
- */
-void qemu_lockcnt_lock(QemuLockCnt *lockcnt);
-
-/**
- * qemu_lockcnt_unlock: release a QemuLockCnt's mutex.
- * @lockcnt: the lockcnt to operate on.
- */
-void qemu_lockcnt_unlock(QemuLockCnt *lockcnt);
-
-/**
- * qemu_lockcnt_inc_and_unlock: combined unlock/increment on a QemuLockCnt.
- * @lockcnt: the lockcnt to operate on.
- *
- * This is the same as
- *
- *     qemu_lockcnt_unlock(lockcnt);
- *     qemu_lockcnt_inc(lockcnt);
- *
- * but more efficient.
- */
-void qemu_lockcnt_inc_and_unlock(QemuLockCnt *lockcnt);
-
-/**
- * qemu_lockcnt_count: query a LockCnt's count.
- * @lockcnt: the lockcnt to query.
- *
- * Note that the count can change at any time.  Still, while the
- * lockcnt is locked, one can usefully check whether the count
- * is non-zero.
- */
-unsigned qemu_lockcnt_count(QemuLockCnt *lockcnt);
-
 #endif
diff --git a/accel/accel-blocker.c b/accel/accel-blocker.c
index e083f24aa80..75daaa29113 100644
--- a/accel/accel-blocker.c
+++ b/accel/accel-blocker.c
@@ -25,6 +25,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/lockcnt.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
 #include "hw/core/cpu.h"
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 7982ecd39a5..09c79035949 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -24,6 +24,7 @@
 #include "sysemu/hw_accel.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
+#include "qemu/lockcnt.h"
 #include "exec/log.h"
 #include "exec/gdbstub.h"
 #include "sysemu/tcg.h"
diff --git a/util/aio-posix.c b/util/aio-posix.c
index 266c9dd35fa..06bf9f456cf 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -17,6 +17,7 @@
 #include "block/block.h"
 #include "block/thread-pool.h"
 #include "qemu/main-loop.h"
+#include "qemu/lockcnt.h"
 #include "qemu/rcu.h"
 #include "qemu/rcu_queue.h"
 #include "qemu/sockets.h"
diff --git a/util/aio-win32.c b/util/aio-win32.c
index d144f9391fb..6583d5c5f31 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "block/block.h"
 #include "qemu/main-loop.h"
+#include "qemu/lockcnt.h"
 #include "qemu/queue.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
diff --git a/util/async.c b/util/async.c
index 3e3e4fc7126..99db28389f6 100644
--- a/util/async.c
+++ b/util/async.c
@@ -30,6 +30,7 @@
 #include "block/graph-lock.h"
 #include "qemu/main-loop.h"
 #include "qemu/atomic.h"
+#include "qemu/lockcnt.h"
 #include "qemu/rcu_queue.h"
 #include "block/raw-aio.h"
 #include "qemu/coroutine_int.h"
diff --git a/util/fdmon-epoll.c b/util/fdmon-epoll.c
index c6413cb18fe..9fb8800dde8 100644
--- a/util/fdmon-epoll.c
+++ b/util/fdmon-epoll.c
@@ -5,6 +5,7 @@
 
 #include "qemu/osdep.h"
 #include <sys/epoll.h>
+#include "qemu/lockcnt.h"
 #include "qemu/rcu_queue.h"
 #include "aio-posix.h"
 
diff --git a/util/lockcnt.c b/util/lockcnt.c
index 5da36946b1b..d07c6cc5cee 100644
--- a/util/lockcnt.c
+++ b/util/lockcnt.c
@@ -7,6 +7,7 @@
  *   Paolo Bonzini <pbonzini@redhat.com>
  */
 #include "qemu/osdep.h"
+#include "qemu/lockcnt.h"
 #include "qemu/thread.h"
 #include "qemu/atomic.h"
 #include "trace.h"
-- 
2.34.1


