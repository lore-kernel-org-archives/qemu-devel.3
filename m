Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042B2C36014
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 10:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzvA8-0002jL-JA; Wed, 02 Apr 2025 06:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mordan@ispras.ru>) id 1tzvA6-0002if-29
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 06:17:34 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mordan@ispras.ru>) id 1tzvA4-00027r-0K
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 06:17:33 -0400
Received: from Neilbrown.intra.ispras.ru (unknown [10.10.2.179])
 by mail.ispras.ru (Postfix) with ESMTPSA id A0C1B40777CB;
 Wed,  2 Apr 2025 10:17:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A0C1B40777CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1743589046;
 bh=puVkcoSM8F2ihaohFXdaYLbOBJzPGLUoQP142m866uA=;
 h=From:To:Cc:Subject:Date:From;
 b=bImpUTTsiZMJ68cu3Qo6h25jp8+GudbmdFZtBbvJYwDLRYGHX7bvkWBPJea17B8CI
 bTdfmDBAqsBY4kExBzKFNxEzA7X/oEID3EY+TXqatRONEaMDZGZ2qDeKhxjU14t0q8
 BkudlXdamKa3VmLz3u2H2XuLEiFtrZq7Q75LBsSo=
From: Vitalii Mordan <mordan@ispras.ru>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitalii Mordan <mordan@ispras.ru>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org,
 Vadim Mutilin <mutilin@ispras.ru>,
 Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] Add annotations in QemuEvent functions
Date: Wed,  2 Apr 2025 13:17:15 +0300
Message-Id: <20250402101715.3345287-1-mordan@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84; envelope-from=mordan@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch adds missing annotations for qemu_event_set, qemu_event_reset,
and qemu_event_wait to prevent TSAN from reporting false alarms caused by
the use of barriers and futex_wait.

Fixes: c7c4d063f5 ("qemu-thread: add QemuEvent")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2904
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
 util/qemu-thread-posix.c | 4 ++++
 util/qemu-thread-win32.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index b2e26e2120..2f6b4834e9 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -403,6 +403,7 @@ void qemu_event_set(QemuEvent *ev)
             qemu_futex_wake(ev, INT_MAX);
         }
     }
+    QEMU_TSAN_ANNOTATE_HAPPENS_BEFORE(ev);
 }
 
 void qemu_event_reset(QemuEvent *ev)
@@ -420,6 +421,7 @@ void qemu_event_reset(QemuEvent *ev)
      * Pairs with the first memory barrier in qemu_event_set().
      */
     smp_mb__after_rmw();
+    QEMU_TSAN_ANNOTATE_HAPPENS_BEFORE(ev);
 }
 
 void qemu_event_wait(QemuEvent *ev)
@@ -452,6 +454,7 @@ void qemu_event_wait(QemuEvent *ev)
              * like the load above.
              */
             if (qatomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) == EV_SET) {
+                QEMU_TSAN_ANNOTATE_HAPPENS_AFTER(ev);
                 return;
             }
         }
@@ -463,6 +466,7 @@ void qemu_event_wait(QemuEvent *ev)
          */
         qemu_futex_wait(ev, EV_BUSY);
     }
+    QEMU_TSAN_ANNOTATE_HAPPENS_AFTER(ev);
 }
 
 static __thread NotifierList thread_exit;
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index a7fe3cc345..b08aed9b6f 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -290,6 +290,7 @@ void qemu_event_set(QemuEvent *ev)
             SetEvent(ev->event);
         }
     }
+    QEMU_TSAN_ANNOTATE_HAPPENS_BEFORE(ev);
 }
 
 void qemu_event_reset(QemuEvent *ev)
@@ -307,6 +308,7 @@ void qemu_event_reset(QemuEvent *ev)
      * Pairs with the first memory barrier in qemu_event_set().
      */
     smp_mb__after_rmw();
+    QEMU_TSAN_ANNOTATE_HAPPENS_BEFORE(ev);
 }
 
 void qemu_event_wait(QemuEvent *ev)
@@ -348,6 +350,7 @@ void qemu_event_wait(QemuEvent *ev)
              * set or busy.
              */
             if (qatomic_cmpxchg(&ev->value, EV_FREE, EV_BUSY) == EV_SET) {
+                QEMU_TSAN_ANNOTATE_HAPPENS_AFTER(ev);
                 return;
             }
         }
@@ -358,6 +361,7 @@ void qemu_event_wait(QemuEvent *ev)
          */
         WaitForSingleObject(ev->event, INFINITE);
     }
+    QEMU_TSAN_ANNOTATE_HAPPENS_AFTER(ev);
 }
 
 struct QemuThreadData {
-- 
2.34.1


