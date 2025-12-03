Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6DED1BDD0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 18:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQrx7-0007Zc-HI; Wed, 03 Dec 2025 13:51:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQrx5-0007Yp-OC
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vQrx3-00012E-Rb
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 13:51:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764787904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aHNzjllbBUzUbH3e9EozX0+yCDvl12oO5bAZL6BQpCU=;
 b=fw0FZbZrg1fNRBpw4FCC6IPAhy13uE1ShJfqk3ql5v3RkMSIaXwt9053Xm86c2RtNhT2hl
 yqTdQJGFYNy5jDiIBsOyDZoV5DtcmGfeMuqkplyeADxaSScex7yat8vcW60zwta86pgdaf
 GKBZeGgBJMzfNJoyRZIl8IyBFz0xwPw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-y4q31VbYPdSl7f2IdOM6og-1; Wed, 03 Dec 2025 13:51:43 -0500
X-MC-Unique: y4q31VbYPdSl7f2IdOM6og-1
X-Mimecast-MFC-AGG-ID: y4q31VbYPdSl7f2IdOM6og_1764787902
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47775585257so556295e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 10:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764787901; x=1765392701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aHNzjllbBUzUbH3e9EozX0+yCDvl12oO5bAZL6BQpCU=;
 b=N7M4X5Jbje467wLhupRB6RxlShrt5OM4yVtBbpRPsJbrrH6L+DppF9igqc7aOSzy2D
 G7ATWU3Jb+reog1tDFOUKqUD3sM0ZTdQBjoUPfyGDAZDC10gXHQ1OW29CKxzq9Q/i88x
 YkYea91hjFmdnZ/JfYAOJ0fGwEDKHsYxCs5NDZToC0nHgtALgAC8gplKvbbOIA+9TWC+
 LREGLs5DfA6KqnKDbgveUgwPOOezuppqWHrbjP2m/pYTk26Ytfl6Af2JkxMJ813iamuv
 YTzJNWyZn6u9qCBgSaTpWF7WXlLBI2onC5Fs2aLcqI3+nxyG9afDFdKCLrB3V6TpYnj9
 vI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764787901; x=1765392701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aHNzjllbBUzUbH3e9EozX0+yCDvl12oO5bAZL6BQpCU=;
 b=iWzT55PQ3TBnh1vPTK4yxuKYEsV21FbfNQ/D2PkLWADFy7MXB4dglX3ir4lI03IFMB
 FToyLH8oDAb1aghS+xrMc1mg5lZqp7/AW4pH/aEesDXHV+SNJlc+0zz9K8IYOp0JuZ+7
 rH8k22l/rlZzkSd0uTryjosDNgW42l4poQKApiZzI/yUgpcNoJup8+xPOevsSyFXPjiY
 SAz9ybjINrcueYdaWQ78Spgtdyx+QSjBS2nYX4YenmigCXvzPZ1N7ySgl/WgeAxu3jga
 s+y7IKnbS1RK18qn/BK7Edx3gIVvmprlBh2EKEn/A/A8HXpzRVaOgfdsxUfly1CYJtH5
 8L2g==
X-Gm-Message-State: AOJu0Yx7IVJq0HL4kiXYFpHFOxa5Qi7Fv8ZaEbhvY3oBck+ucxXnAnpz
 MTpJUPWknb4faH/awFs64kH0evP3aZe5MQmWBI5D3Wr+OvUOGKU2fy4hsNKqlzUZy6EKhE/R2w7
 etukFwcR/xX7pTVrOQ5CMGZ4QvalC8Zi6rMLfWFvU9MKRQ0PuWoriu9MUEqXlzfUmGvd3WLuDzR
 v62A5IQLlkr4WQPb2ryENYruORqyBrCJzOBI8HLTMJ
X-Gm-Gg: ASbGncuB7UWxFKMmazAkSmlfQq/Ohr18g2k0Kb9DGao3SsTTf3Ro4haE3DRWvuq5Cle
 1XO6OTPwY0Zso0qYw030+JNJJ2V8gQGi1ckS8xmP493PAU+7OKNPJ/uaX92ufYLnvHX8B7EMJ0G
 5W4havQLM/g2X04eVvLzdH1DCny78lY3ez5h5ouoMM9RPiccO/RHy0N9T4B8j/jRlBkgeTAPotG
 W2m71KgOMMLKfdmcHQ5TxwQtkzsXsjCVwVy0UzT5yfGKfxuzjBS0hYFSiHZWl4c5w7DtJSeUY4h
 DPN18mqDQNoVDhtQRS2WFeXA5oglNkf/x+N+Jtj16CmAtrmSzN4saXSQL44TqH6VYEQgcCfJWg8
 HkGZnqAsWxyyd/rNa7SGfCzWbakN8PFg+GuDVBqyKxS/XWQlyJxntq+vMssLME06tw/Db0OOAsq
 KM3K7o+ORj8Vg9b5I=
X-Received: by 2002:a05:600c:35d5:b0:477:8b2e:aa7d with SMTP id
 5b1f17b1804b1-4792af40437mr42485165e9.30.1764787900895; 
 Wed, 03 Dec 2025 10:51:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3zHtej+xWRSEmXryrtZtgCWqTXzbqEAAuWs4blNcR4U6gtRgei+xBVybRbCTS4pupY31tEw==
X-Received: by 2002:a05:600c:35d5:b0:477:8b2e:aa7d with SMTP id
 5b1f17b1804b1-4792af40437mr42484855e9.30.1764787900404; 
 Wed, 03 Dec 2025 10:51:40 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792a8ccdfbsm66579645e9.14.2025.12.03.10.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 10:51:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	kwolf@redhat.omc
Subject: [PATCH 2/5] block: extract include/qemu/aiocb.h out of
 include/block/aio.h
Date: Wed,  3 Dec 2025 19:51:30 +0100
Message-ID: <20251203185133.2458207-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203185133.2458207-1-pbonzini@redhat.com>
References: <20251203185133.2458207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Create a new header corresponding to functions defined in
util/aiocb.c, and include it whenever AIOCBs are used but
AioContext is not.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 fsdev/qemu-fsdev-throttle.h        |  1 -
 include/block/aio.h                | 21 -----------------
 include/block/block-global-state.h |  1 +
 include/block/block-io.h           |  1 +
 include/block/block_int-common.h   |  2 +-
 include/block/raw-aio.h            |  1 +
 include/block/thread-pool.h        |  1 +
 include/hw/ide/ide-dma.h           |  2 +-
 include/hw/scsi/scsi.h             |  1 +
 include/qemu/aiocb.h               | 38 ++++++++++++++++++++++++++++++
 include/qemu/job.h                 |  1 +
 include/qemu/throttle.h            |  1 +
 block/win32-aio.c                  |  1 +
 hw/core/ptimer.c                   |  1 -
 hw/misc/i2c-echo.c                 |  1 -
 hw/virtio/virtio-pmem.c            |  1 -
 scsi/qemu-pr-helper.c              |  1 -
 tests/unit/test-thread-pool.c      |  1 +
 ui/input-linux.c                   |  1 -
 ui/vnc-jobs.c                      |  1 -
 util/aiocb.c                       |  2 +-
 21 files changed, 50 insertions(+), 31 deletions(-)
 create mode 100644 include/qemu/aiocb.h

diff --git a/fsdev/qemu-fsdev-throttle.h b/fsdev/qemu-fsdev-throttle.h
index daa8ca2494d..a1dc0307903 100644
--- a/fsdev/qemu-fsdev-throttle.h
+++ b/fsdev/qemu-fsdev-throttle.h
@@ -15,7 +15,6 @@
 #ifndef QEMU_FSDEV_THROTTLE_H
 #define QEMU_FSDEV_THROTTLE_H
 
-#include "block/aio.h"
 #include "qemu/coroutine.h"
 #include "qemu/throttle.h"
 
diff --git a/include/block/aio.h b/include/block/aio.h
index cc3d5f25a24..59c56d695ee 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -27,27 +27,6 @@
 #include "hw/core/qdev.h"
 
 
-typedef struct BlockAIOCB BlockAIOCB;
-typedef void BlockCompletionFunc(void *opaque, int ret);
-
-typedef struct AIOCBInfo {
-    void (*cancel_async)(BlockAIOCB *acb);
-    size_t aiocb_size;
-} AIOCBInfo;
-
-struct BlockAIOCB {
-    const AIOCBInfo *aiocb_info;
-    BlockDriverState *bs;
-    BlockCompletionFunc *cb;
-    void *opaque;
-    int refcnt;
-};
-
-void *qemu_aio_get(const AIOCBInfo *aiocb_info, BlockDriverState *bs,
-                   BlockCompletionFunc *cb, void *opaque);
-void qemu_aio_unref(void *p);
-void qemu_aio_ref(void *p);
-
 typedef struct AioHandler AioHandler;
 typedef QLIST_HEAD(, AioHandler) AioHandlerList;
 typedef void QEMUBHFunc(void *opaque);
diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 479ca2858e1..c2127f17249 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -24,6 +24,7 @@
 #ifndef BLOCK_GLOBAL_STATE_H
 #define BLOCK_GLOBAL_STATE_H
 
+#include "qemu/aiocb.h"
 #include "block/block-common.h"
 #include "qemu/coroutine.h"
 #include "qemu/transactions.h"
diff --git a/include/block/block-io.h b/include/block/block-io.h
index 4cf83fb3674..e5efe0efb2f 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -24,6 +24,7 @@
 #ifndef BLOCK_IO_H
 #define BLOCK_IO_H
 
+#include "qemu/aiocb.h"
 #include "block/aio-wait.h"
 #include "block/block-common.h"
 #include "qemu/coroutine.h"
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index cb0143ea77b..6d0898e53d1 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -24,10 +24,10 @@
 #ifndef BLOCK_INT_COMMON_H
 #define BLOCK_INT_COMMON_H
 
-#include "block/aio.h"
 #include "block/block-common.h"
 #include "block/block-global-state.h"
 #include "block/snapshot.h"
+#include "qemu/aiocb.h"
 #include "qemu/iov.h"
 #include "qemu/rcu.h"
 #include "qemu/stats64.h"
diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index 30e5fc9a9fd..d568b887f1c 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -16,6 +16,7 @@
 #ifndef QEMU_RAW_AIO_H
 #define QEMU_RAW_AIO_H
 
+#include "qemu/aiocb.h"
 #include "block/aio.h"
 #include "block/block-common.h"
 #include "qemu/iov.h"
diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
index dd48cf07e85..65cabfc1388 100644
--- a/include/block/thread-pool.h
+++ b/include/block/thread-pool.h
@@ -18,6 +18,7 @@
 #ifndef QEMU_THREAD_POOL_H
 #define QEMU_THREAD_POOL_H
 
+#include "qemu/aiocb.h"
 #include "block/aio.h"
 
 #define THREAD_POOL_MAX_THREADS_DEFAULT         64
diff --git a/include/hw/ide/ide-dma.h b/include/hw/ide/ide-dma.h
index d0b19ac9c57..296010a4e0d 100644
--- a/include/hw/ide/ide-dma.h
+++ b/include/hw/ide/ide-dma.h
@@ -1,7 +1,7 @@
 #ifndef HW_IDE_DMA_H
 #define HW_IDE_DMA_H
 
-#include "block/aio.h"
+#include "qemu/aiocb.h"
 #include "qemu/iov.h"
 
 typedef struct IDEState IDEState;
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 83782339d4b..75b4d781a5c 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -1,6 +1,7 @@
 #ifndef QEMU_HW_SCSI_H
 #define QEMU_HW_SCSI_H
 
+#include "qemu/aiocb.h"
 #include "block/aio.h"
 #include "hw/block/block.h"
 #include "hw/core/qdev.h"
diff --git a/include/qemu/aiocb.h b/include/qemu/aiocb.h
new file mode 100644
index 00000000000..0622646f31d
--- /dev/null
+++ b/include/qemu/aiocb.h
@@ -0,0 +1,38 @@
+/*
+ * Data structures representing asynchronous I/O operations
+ *
+ * Copyright IBM, Corp. 2008
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef QEMU_AIOCB_H
+#define QEMU_AIOCB_H
+
+typedef struct BlockAIOCB BlockAIOCB;
+typedef void BlockCompletionFunc(void *opaque, int ret);
+
+typedef struct AIOCBInfo {
+    void (*cancel_async)(BlockAIOCB *acb);
+    size_t aiocb_size;
+} AIOCBInfo;
+
+struct BlockAIOCB {
+    const AIOCBInfo *aiocb_info;
+    BlockDriverState *bs;
+    BlockCompletionFunc *cb;
+    void *opaque;
+    int refcnt;
+};
+
+void *qemu_aio_get(const AIOCBInfo *aiocb_info, BlockDriverState *bs,
+                   BlockCompletionFunc *cb, void *opaque);
+void qemu_aio_unref(void *p);
+void qemu_aio_ref(void *p);
+
+#endif
diff --git a/include/qemu/job.h b/include/qemu/job.h
index ead31578d3d..af29b8c6531 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -27,6 +27,7 @@
 #define JOB_H
 
 #include "qapi/qapi-types-job.h"
+#include "qemu/aiocb.h"
 #include "qemu/queue.h"
 #include "qemu/progress_meter.h"
 #include "qemu/coroutine.h"
diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index 181245d29bc..8fa2b29452a 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -25,6 +25,7 @@
 #ifndef THROTTLE_H
 #define THROTTLE_H
 
+#include "block/aio.h"
 #include "qapi/qapi-types-block-core.h"
 #include "qemu/timer.h"
 
diff --git a/block/win32-aio.c b/block/win32-aio.c
index f0689f3ee95..539f1c81c65 100644
--- a/block/win32-aio.c
+++ b/block/win32-aio.c
@@ -28,6 +28,7 @@
 #include "block/block_int.h"
 #include "block/aio.h"
 #include "block/raw-aio.h"
+#include "qemu/aiocb.h"
 #include "qemu/event_notifier.h"
 #include "qemu/iov.h"
 #include "qemu/memalign.h"
diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index e42e06fa4de..0cbe1ed5787 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -13,7 +13,6 @@
 #include "exec/replay-core.h"
 #include "exec/icount.h"
 #include "system/qtest.h"
-#include "block/aio.h"
 #include "hw/core/clock.h"
 
 #define DELTA_ADJUST     1
diff --git a/hw/misc/i2c-echo.c b/hw/misc/i2c-echo.c
index 2bb99ec0dbf..54d07db6fae 100644
--- a/hw/misc/i2c-echo.c
+++ b/hw/misc/i2c-echo.c
@@ -11,7 +11,6 @@
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h"
-#include "block/aio.h"
 #include "hw/i2c/i2c.h"
 #include "trace.h"
 
diff --git a/hw/virtio/virtio-pmem.c b/hw/virtio/virtio-pmem.c
index 854d08abf6e..5381d592824 100644
--- a/hw/virtio/virtio-pmem.c
+++ b/hw/virtio/virtio-pmem.c
@@ -22,7 +22,6 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "standard-headers/linux/virtio_pmem.h"
 #include "system/hostmem.h"
-#include "block/aio.h"
 #include "block/thread-pool.h"
 #include "trace.h"
 
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 074b4db4720..9dcd3ec7111 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -52,7 +52,6 @@
 #include "trace/control.h"
 #include "qemu-version.h"
 
-#include "block/aio.h"
 #include "block/thread-pool.h"
 
 #include "scsi/constants.h"
diff --git a/tests/unit/test-thread-pool.c b/tests/unit/test-thread-pool.c
index 33407b595d3..ea5234f9f48 100644
--- a/tests/unit/test-thread-pool.c
+++ b/tests/unit/test-thread-pool.c
@@ -3,6 +3,7 @@
 #include "block/thread-pool.h"
 #include "block/block.h"
 #include "qapi/error.h"
+#include "qemu/aiocb.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
diff --git a/ui/input-linux.c b/ui/input-linux.c
index 44d0c15a9b7..c16726a3b79 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -13,7 +13,6 @@
 #include "ui/input.h"
 #include "qom/object_interfaces.h"
 #include "system/iothread.h"
-#include "block/aio.h"
 
 #include <sys/ioctl.h>
 #include "standard-headers/linux/input.h"
diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index bed33950a87..b296d19e089 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -31,7 +31,6 @@
 #include "vnc-jobs.h"
 #include "qemu/sockets.h"
 #include "qemu/main-loop.h"
-#include "block/aio.h"
 #include "trace.h"
 
 /*
diff --git a/util/aiocb.c b/util/aiocb.c
index 5aef3a069c8..d1a581080d3 100644
--- a/util/aiocb.c
+++ b/util/aiocb.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "block/aio.h"
+#include "qemu/aiocb.h"
 
 void *qemu_aio_get(const AIOCBInfo *aiocb_info, BlockDriverState *bs,
                    BlockCompletionFunc *cb, void *opaque)
-- 
2.52.0


