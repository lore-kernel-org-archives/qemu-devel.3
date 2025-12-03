Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95311D1BDD0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrx8-0007aK-HZ; Wed, 03 Dec 2025 13:51:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQrx7-0007ZO-12
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQrx5-00012n-DM
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764787906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lYzrc17+VBNLzV0q5mb2F00YL2Y2UiMTeTfct14Gr/A=;
 b=U2uO6Fd1fs1OHkg4CwZHOD2HsgaixvixpKY99LD0/uYpBSQUlaahQCb11j1iHiLROQ9Esr
 AyfViUrKBptLtMwBjL8U2LoPLUz3oJhzePJmE+2snlaZrpkIuhj9OPcxUYwlb46rvJrPFd
 GarkciqVoAx33BXNP+JLDAqVbmHc6JE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-t4WpS3b2O56UkpfVIZhG3w-1; Wed, 03 Dec 2025 13:51:45 -0500
X-MC-Unique: t4WpS3b2O56UkpfVIZhG3w-1
X-Mimecast-MFC-AGG-ID: t4WpS3b2O56UkpfVIZhG3w_1764787904
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4779d8fd4ecso408745e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 10:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764787903; x=1765392703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lYzrc17+VBNLzV0q5mb2F00YL2Y2UiMTeTfct14Gr/A=;
 b=rCzdfGHBntCrBcnarXK/pMdhg7f9Y42vyDGz1uRXwHcOCEqPvlmYgDwIenTt4aN1QR
 59Lu3GCsM+BgBeXTKtad7pooMgZdL5KYzrJC3EPYpq7nIszW1+rTKFYUrOW2YUg9uTbM
 VXqYa9rvYiaXvTASxDdJaVAuVCinnHKGmlSEYxjOcIIBnY2g5z8ekdBFXXc4rmE/asoe
 r+UNSaeWdNpmmr/hMHh/U2zIHKSv6bntK9sBBg4j9C+VMb0ObtJrYKvl70vExW17iuLs
 VyKR1AsUobSRX5cyeezmubfKo/eI1yl6TaCqWOx0FN22L/RkCaGSbWW2OPmrJBZch/zx
 oX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764787903; x=1765392703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lYzrc17+VBNLzV0q5mb2F00YL2Y2UiMTeTfct14Gr/A=;
 b=XyXU76kDRBuz0wI6BVJ+2L+KXkahYNJaaqBHMWG6gH+aeym0Lo8Z4R/hIraFDwYFM0
 fPJDV1KT6/tukbvREkgB9rjhQO0eqMVCt6EaAqb7Z97JNnG628SJAbLiA7sk+WNA61uE
 w3rOYmOmFW2ulutpow6VaLCeFrMOZFnrkNUk1NSw6YzuWYHlyelXEbCpS2uLcYfDZGBJ
 ayFRpKtI6iLPklqlzPZjJNthKl2XS8akm0g9Ua0pbKo0jVrEqvkCqCNcSy53OezrNH5v
 BssyMZPv3a11c2wMn3G9gN8+Z+3KfJuQakqLZeY1KLlIReC5YYD11+au1kqbE9PVGBWS
 O6sQ==
X-Gm-Message-State: AOJu0Yw8e80RKIB4ZT7WUhHm9smFvaBEfeGX7hxqmqGd9wz/Iucn+p8p
 3oJLJdsUEbRn/9S4DXWsn57x/Q6KZt8WWkSUOxGjKUNExtvJ3s/Lgs6IjzkLr05td4jNYj3a2CQ
 YIuuMTGMsuPI/3cwp9OLHmTegln21kGw4CaCmSZfzntcWT6C5hghVbfhdoC3UEZQ5FT6ZNtk6ir
 R9KCJnOm/InXIVzOLDZAlrBcTeas/5OKMZ/wSVxYhH
X-Gm-Gg: ASbGnctteineU1ROvt5ZVvCcThzv0OR5YYkVHswdpn2RI+STcQQad0mFLnr2Xk8pK3e
 tThytrrkMQILafTfgCue3DcuKh8JHh/u1VM/ABD21i6RCti/EFddZaTCShIzyOs7UTf/IzhmNAz
 oIryOPJuRuBVI73sSVIezCNYG633Tn0xW4mqg8fQ0jdq23yakA8ry72/2nPoahymfYf6xCfJcJR
 BERpRml7W1wUarC9KTDURcAbQxLeS8C4fG31wEN10mmFHZqAVUJAjpe5IbLFmqMV8464e1rlIVJ
 E4wfpCxDPcvT+5CGp6JBTio9pYebKNbma1uu9dAtnqb6KcdJ3Xs5mXZcbBApXBTMeKqSFkrLE1W
 ARDj4ArprrXZi1t90ojFXKRsaAER4PMC4h484FhbPSgwiRsKV5jbGGXK8dbd7iJNjzLIDKaijHq
 XLMiaqocitf6Eo75c=
X-Received: by 2002:a05:600c:3151:b0:479:255f:8805 with SMTP id
 5b1f17b1804b1-4792eb10e97mr5419545e9.4.1764787903107; 
 Wed, 03 Dec 2025 10:51:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEUW3YyNCYO1y+vU8FGieudGnHLDk3S+naLY15jST1X+p4ScQlx0j3qj8vrpuk+71/KgvmLg==
X-Received: by 2002:a05:600c:3151:b0:479:255f:8805 with SMTP id
 5b1f17b1804b1-4792eb10e97mr5419265e9.4.1764787902688; 
 Wed, 03 Dec 2025 10:51:42 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792b02e7fbsm21794075e9.2.2025.12.03.10.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 10:51:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	kwolf@redhat.omc
Subject: [PATCH 3/5] block: reduce files included by block/aio.h
Date: Wed,  3 Dec 2025 19:51:31 +0100
Message-ID: <20251203185133.2458207-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203185133.2458207-1-pbonzini@redhat.com>
References: <20251203185133.2458207-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 util/async.c                       |  1 +
 11 files changed, 22 insertions(+), 10 deletions(-)
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


