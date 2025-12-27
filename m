Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D80E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQyP-00075v-9r; Sat, 27 Dec 2025 04:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxp-0006Yp-9L
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxn-0007Xw-CE
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6mA9qiVHrcRk5ept2GBYRaDPsRAZx+xjC+RZbHBMI2k=;
 b=WD6QCp00C+W1jB+MpZbdQmBSpF8xkCyBWcKp8AbNIQv6U+/vJB/CAnaX6HMaokWT1NNl91
 bDg2tX50As+5Z++wKPvlPfqzSyWlS/sBm3H6bv9j1xHaR834Lj7h0PEay2xdqdjy9kzzGH
 oqj85k3LJiL0tVf6c3k48P+mKH+IkpM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-K58UxYnZOZmjrD0cP1xz1A-1; Sat, 27 Dec 2025 04:51:53 -0500
X-MC-Unique: K58UxYnZOZmjrD0cP1xz1A-1
X-Mimecast-MFC-AGG-ID: K58UxYnZOZmjrD0cP1xz1A_1766829112
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477563a0c75so17865465e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829112; x=1767433912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6mA9qiVHrcRk5ept2GBYRaDPsRAZx+xjC+RZbHBMI2k=;
 b=h/dAQLmWIPvV8az8mgcQaL7QhHSmmimmJiEo6EGTqkj4YZdCh8zgQed4GkhKgE8+5s
 0DTEnKa/OczUUNfoSEjlrBG70FtER1In6icvb/y4+dsXcmbM6u/R3czzqBWWChr1/7yY
 NWK+her/3rQZ7cs/D/MlEWzG1ObWge3QQ8Bbyr0IhB4ODqBXbDmCmX6I+WzRGrFmbwAJ
 IwDax52O97bAIYZaZBtVOjoZ/G3VqZ30I4pvYCU/UvFKU4kI+yvKpVMu+spmqKie0t1u
 oFLB/ZfuGJHAdGPqhqorU7Ks3Y09HtIHPqLKX4GfqAwbVMTJfrd3ScV0+Rq7OIfk7Nx+
 6sMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829112; x=1767433912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6mA9qiVHrcRk5ept2GBYRaDPsRAZx+xjC+RZbHBMI2k=;
 b=IeFicE4uMx50plRxmlFQOtbk1QN2fjS0N2swXeZz/jK5JTHaiCiDlrdDtTIGpTuxQq
 V1NbA3ZoIzRehe/oqFmlNTjtQJLNUoQhUD2yLGhFs8fYe4PLYWLjRMfHeLLeBbRGW6Fp
 0CO6WmAff4PSXeHaEEvm+zFTjQ5uQBYYVL59uKydJR04A46IrmWecXg3l+XBjbsL3vIZ
 wzFvfwzdnnIiclrRakh0f+YkL0VR9rOdyW2vJFGDYOdIhnfsOeaaqIZzDtdTzolu08mf
 pv9ISoZS2jAgStjuJkjPfpa/6BxnitoFqbY+7XxlTjqhjlKQ4waOp15p0uWFBVnNcmDc
 ws0A==
X-Gm-Message-State: AOJu0YybgijultWbVEswvxOKrf5YT4nz0cdd09l1cwtnb0KzRNT1gSrr
 BqOhxouZ314W88h8G2zJ3gToGux/3cCKPQNQi1aXIWj7odFhQH+3rOtZctrGxxgh0DbK8MjGo61
 W+HjBW4u8ti0QcQF980iaCyuZ8yTjZHpahFjFMh58/0/ixEEY6F09djRp8t+qpDUJiObWuHbVmS
 sXFlr9pL3qBDe/If63dxeHqLtqAdsovdw4P+s809dt
X-Gm-Gg: AY/fxX6h+WkwH6QMNgiWNWDwPAITGEjIaZ//rQSSDDdeDxPznMcyxLtlcIWMqbM3mKd
 lJahyTHzNDbP6PHcEtnxYXSKvRsXhQFim6T0SpXhVvOlgNiF48NJ0VztOq2EKLnOzVNU2V+HiNe
 FYVZhvvWZpg1fj6U9kpSAcZDTbbl6KpAhDtQoYhRyyrL7FaQe8/eDMA+Uva6LYPC/6ti+tJVFii
 eHNbfAPPooISBuFMPM22m/xYRUZt3EY05+unTxsrNbwY7W/kRdTQLb4Ya0Q9BC4FuT/oDaHUMtH
 w34LmujAeylHO8q/dEZDscUMIS1aN1xLFfs9nNSvlqqV9qb5FJP6KdPI36f4Ydn8oZ25ybtLywh
 D4AX2Sw4dLOFIDI7njmEH1+GFzNieHPt7LXbgn0Z2gKgyjzmnecMBrNXfLEINxRB2REaggzkomf
 S0JwWPq4rexZTpjjw=
X-Received: by 2002:a05:600c:a31a:b0:477:b48d:ba7a with SMTP id
 5b1f17b1804b1-47d1afcd9e2mr214702685e9.32.1766829111958; 
 Sat, 27 Dec 2025 01:51:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGM25jueoOtnYSnik6LR9Hu476CqEkd3h+jmCQKAQz7FAHYXW1+wq5GfuFPpgti3pfsDTGs6A==
X-Received: by 2002:a05:600c:a31a:b0:477:b48d:ba7a with SMTP id
 5b1f17b1804b1-47d1afcd9e2mr214702505e9.32.1766829111495; 
 Sat, 27 Dec 2025 01:51:51 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be272e46fsm476214485e9.4.2025.12.27.01.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:51:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 151/153] block: reduce files included by block/aio.h
Date: Sat, 27 Dec 2025 10:47:56 +0100
Message-ID: <20251227094759.35658-77-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Avoid including all of qdev everywhere (the hw/core/qdev.h header in fact
brings in a lot more headers too), instead declare a couple structs for
which only a pointer type is needed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/block/aio.h                |  7 +++----
 include/block/block-copy.h         |  1 +
 include/block/block-global-state.h |  1 +
 include/block/block-io.h           |  1 +
 include/block/dirty-bitmap.h       |  1 +
 include/hw/core/qdev.h             |  6 +-----
 include/qemu/job.h                 |  1 +
 include/qemu/main-loop.h           |  2 +-
 include/qemu/mem-reentrancy.h      | 10 ++++++++++
 net/net.c                          |  1 +
 tests/unit/ptimer-test-stubs.c     |  2 +-
 util/async.c                       |  1 +
 12 files changed, 23 insertions(+), 11 deletions(-)
 create mode 100644 include/qemu/mem-reentrancy.h

diff --git a/include/block/aio.h b/include/block/aio.h
index 59c56d695ee..8cca2360d1a 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -23,9 +23,8 @@
 #include "qemu/lockcnt.h"
 #include "qemu/thread.h"
 #include "qemu/timer.h"
-#include "block/graph-lock.h"
-#include "hw/core/qdev.h"
 
+struct MemReentrancyGuard;
 
 typedef struct AioHandler AioHandler;
 typedef QLIST_HEAD(, AioHandler) AioHandlerList;
@@ -211,7 +210,7 @@ struct AioContext {
      * of nodes and edges from block graph while some
      * other thread is traversing it.
      */
-    BdrvGraphRWlock *bdrv_graph;
+    struct BdrvGraphRWlock *bdrv_graph;
 
     /* The list of registered AIO handlers.  Protected by ctx->list_lock. */
     AioHandlerList aio_handlers;
@@ -393,7 +392,7 @@ void aio_bh_schedule_oneshot_full(AioContext *ctx, QEMUBHFunc *cb, void *opaque,
  * device-reentrancy issues
  */
 QEMUBH *aio_bh_new_full(AioContext *ctx, QEMUBHFunc *cb, void *opaque,
-                        const char *name, MemReentrancyGuard *reentrancy_guard);
+                        const char *name, struct MemReentrancyGuard *reentrancy_guard);
 
 /**
  * aio_bh_new: Allocate a new bottom half structure
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index dd5cc82f3b2..0df2771181b 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -16,6 +16,7 @@
 #define BLOCK_COPY_H
 
 #include "block/block-common.h"
+#include "block/graph-lock.h"
 #include "qemu/progress_meter.h"
 
 /* All APIs are thread-safe */
diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index c2127f17249..ed89999f0fb 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -25,6 +25,7 @@
 #define BLOCK_GLOBAL_STATE_H
 
 #include "qemu/aiocb.h"
+#include "block/graph-lock.h"
 #include "block/block-common.h"
 #include "qemu/coroutine.h"
 #include "qemu/transactions.h"
diff --git a/include/block/block-io.h b/include/block/block-io.h
index e5efe0efb2f..7925e2241e6 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -27,6 +27,7 @@
 #include "qemu/aiocb.h"
 #include "block/aio-wait.h"
 #include "block/block-common.h"
+#include "block/graph-lock.h"
 #include "qemu/coroutine.h"
 #include "qemu/iov.h"
 
diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
index fa956debfb2..28029bbc2bc 100644
--- a/include/block/dirty-bitmap.h
+++ b/include/block/dirty-bitmap.h
@@ -2,6 +2,7 @@
 #define BLOCK_DIRTY_BITMAP_H
 
 #include "block/block-common.h"
+#include "block/graph-lock.h"
 #include "qapi/qapi-types-block-core.h"
 #include "qemu/hbitmap.h"
 
diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index e211d807e82..4b2730e9d8e 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -4,6 +4,7 @@
 #include "qemu/atomic.h"
 #include "qemu/queue.h"
 #include "qemu/bitmap.h"
+#include "qemu/mem-reentrancy.h"
 #include "qemu/rcu.h"
 #include "qemu/rcu_queue.h"
 #include "qom/object.h"
@@ -208,11 +209,6 @@ struct NamedClockList {
     QLIST_ENTRY(NamedClockList) node;
 };
 
-typedef struct MemReentrancyGuard {
-    bool engaged_in_io;
-} MemReentrancyGuard;
-
-
 typedef QLIST_HEAD(, NamedGPIOList) NamedGPIOListHead;
 typedef QLIST_HEAD(, NamedClockList) NamedClockListHead;
 typedef QLIST_HEAD(, BusState) BusStateHead;
diff --git a/include/qemu/job.h b/include/qemu/job.h
index af29b8c6531..2b163602c56 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -32,6 +32,7 @@
 #include "qemu/progress_meter.h"
 #include "qemu/coroutine.h"
 #include "block/aio.h"
+#include "block/graph-lock.h"
 
 typedef struct JobDriver JobDriver;
 typedef struct JobTxn JobTxn;
diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 0d55c636b21..241dc87be50 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -431,7 +431,7 @@ void qemu_cond_timedwait_bql(QemuCond *cond, int ms);
 #define qemu_bh_new(cb, opaque) \
     qemu_bh_new_full((cb), (opaque), (stringify(cb)), NULL)
 QEMUBH *qemu_bh_new_full(QEMUBHFunc *cb, void *opaque, const char *name,
-                         MemReentrancyGuard *reentrancy_guard);
+                         struct MemReentrancyGuard *reentrancy_guard);
 void qemu_bh_schedule_idle(QEMUBH *bh);
 
 enum {
diff --git a/include/qemu/mem-reentrancy.h b/include/qemu/mem-reentrancy.h
new file mode 100644
index 00000000000..07cafd47179
--- /dev/null
+++ b/include/qemu/mem-reentrancy.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef QEMU_MEM_REENTRANCY_H
+#define QEMU_MEM_REENTRANCY_H 1
+
+typedef struct MemReentrancyGuard {
+    bool engaged_in_io;
+} MemReentrancyGuard;
+
+#endif
diff --git a/net/net.c b/net/net.c
index 4930b573ed3..a176936f9bc 100644
--- a/net/net.c
+++ b/net/net.c
@@ -39,6 +39,7 @@
 #include "qobject/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
+#include "qemu/mem-reentrancy.h"
 #include "qemu/sockets.h"
 #include "qemu/cutils.h"
 #include "qemu/config-file.h"
diff --git a/tests/unit/ptimer-test-stubs.c b/tests/unit/ptimer-test-stubs.c
index 8c9407c560a..da46dda32d2 100644
--- a/tests/unit/ptimer-test-stubs.c
+++ b/tests/unit/ptimer-test-stubs.c
@@ -108,7 +108,7 @@ int64_t qemu_clock_deadline_ns_all(QEMUClockType type, int attr_mask)
 }
 
 QEMUBH *qemu_bh_new_full(QEMUBHFunc *cb, void *opaque, const char *name,
-                         MemReentrancyGuard *reentrancy_guard)
+                         struct MemReentrancyGuard *reentrancy_guard)
 {
     QEMUBH *bh = g_new(QEMUBH, 1);
 
diff --git a/util/async.c b/util/async.c
index 48f88286369..39f391fb71a 100644
--- a/util/async.c
+++ b/util/async.c
@@ -29,6 +29,7 @@
 #include "block/thread-pool.h"
 #include "block/graph-lock.h"
 #include "qemu/main-loop.h"
+#include "qemu/mem-reentrancy.h"
 #include "qemu/atomic.h"
 #include "qemu/lockcnt.h"
 #include "qemu/rcu_queue.h"
-- 
2.52.0


