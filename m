Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12840E8FDDD
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQyN-0006yQ-CO; Sat, 27 Dec 2025 04:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxp-0006a8-Fh
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxn-0007Xs-C3
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aHNzjllbBUzUbH3e9EozX0+yCDvl12oO5bAZL6BQpCU=;
 b=UbdN0goK2MpChVRY1xX200M5DrXroClSdXCn6mWfRKfwQggaumRViHjMM4JBrnLVDkD0vK
 ZfeSHpwCrgVTkYZA8bph/lhaY+CdXSu4K7LPJ6aZXers33ECg5bpxcYDnMPQDskPmiU0oC
 IPH+XPjnrCs8aodXW7ZN0hyJJV68LJY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-kAZyYZcVPbmRb6N2LffOEQ-1; Sat, 27 Dec 2025 04:51:51 -0500
X-MC-Unique: kAZyYZcVPbmRb6N2LffOEQ-1
X-Mimecast-MFC-AGG-ID: kAZyYZcVPbmRb6N2LffOEQ_1766829111
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4775d110fabso65577715e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829110; x=1767433910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aHNzjllbBUzUbH3e9EozX0+yCDvl12oO5bAZL6BQpCU=;
 b=UF4g0IObtA77O044zzcGHpcEC9tk+yx+79XAE0PHnhGJpCMtQvFU1mO1BwOuRtnZn9
 g9WRb5S0h+ry3jIk5MngSpO08AbyOil5aThXN4QAwQoRx36rfT8RK4Yd8YyzLdAfqy35
 02KRLJ1Q4GMnt4bTf1bYqm3kUbec8/glaBFn3/t5wXj0NG2byvvjClUG61MlDnVXRufl
 UpTl8lRjY+mUDebXTlg6SxVb7crXdr03Eu9EMfAF4E+hpDfv4EPH/AxHcItvzxd0rF+b
 cR+C07kP91JCrrRZBGLKo9z2qPbILuRcA52R5qZRISWHuSoq0OprbBMOv7M3rCDxq71M
 OI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829110; x=1767433910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aHNzjllbBUzUbH3e9EozX0+yCDvl12oO5bAZL6BQpCU=;
 b=L1DRF7+Tkl81kGhdlV6/O3ESwOvG83tYNr6n0Gti20OTzM3yyJzZeW7R1A+u1NqiPx
 +KP9tJNjUoIyPF3xERoMtoj3uZTX2cTlU/hHuoE9WJ7TE37DSREZXwGNUWBvvfOFnsyl
 t6uUmfsCuwInUvrepuAvuzDutqNu8VAcbUEltozRyHXvKl4dzk1PlLcqC9rqFTv8taaB
 4ImDMQqb+nDIV23n2PiDrOIp1/4zsXo6vcSexuXxm9QBtNGkqXKq0w6lwGAVngip2Inw
 nXdnV5Zaz/4FS0B+/UhZOfJ69fO3hVlVaHe8bYKMxKtg+u0yeGYsxweleVD5/m9SOwPF
 0+UQ==
X-Gm-Message-State: AOJu0Yz9ixaXVWziyPxnTljxpQmoUWqX8I/56myG3LMlwH5knyWVUOR2
 f8wfpw3Q0rkcgNzmXT0G3m+Xp/jg3ExXbWE5RgPx7wtVEOUevEzH7VsUvzBBooYlRy0jn50Ry3z
 4+NUvMTzjWCluPv6U/71o9rUCu364WMCm2dqmiKE1r/Jt5KXvEFRg/rNqN1rIN0Q3DlVVpaI67d
 ndpGNuWVhy3vYwNhvDZBzW13evI2EGkCjfDlKeg2E3
X-Gm-Gg: AY/fxX5ddBwrzr5Pf7Whk17PNssi8sFZKOZQxReguM6G+GMOIAqws1s8lJgplyXzYxE
 6AiE8+s3uFM7h22Wpj2LFcP2JdwbHPYzJiek0vjJ2bl9et478yNOwkNGCNSwzILPW3u16jZJwM3
 XNN4kb8CLKbwQsPuAxTBpGNetLntqthhVNrYsmEoWcapcUbkGz6E3ZXWeWDsLNoZ2LX024419hh
 1kBjLYeKgNi4VPftEIu0TJbmUR3fCTbXWvfqzDAPI09zhYYwWtXiTNpAL/rIOlDzL6v6yBmDwMW
 bS44Tyiz+wbeHFrnpOYjS4xfAodd7kS2Gpcz0HoXj7i6I0KAa6nWVjy+Vs4y5aeOOmNGv7AZtDy
 0W6sxCjoz2iE7/jqPF8OJoC4ox+/Sf49agnFohgf5MJCnTXXdPiWp7d9YWPQo6UqCbtB+3Samkg
 sWM/W6iAPLIERxKRc=
X-Received: by 2002:a05:6000:200f:b0:431:8f8:7f2e with SMTP id
 ffacd0b85a97d-4324e50615emr33865542f8f.33.1766829109784; 
 Sat, 27 Dec 2025 01:51:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZyr2RkcDx+6mcd68hLCgSVgMVYXHKjJl9oMSMCmwhTuKkT4MrQgryGptXqkUkrqHx1z0hmQ==
X-Received: by 2002:a05:6000:200f:b0:431:8f8:7f2e with SMTP id
 ffacd0b85a97d-4324e50615emr33865508f8f.33.1766829109129; 
 Sat, 27 Dec 2025 01:51:49 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43277b82a58sm16563587f8f.6.2025.12.27.01.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:51:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 150/153] block: extract include/qemu/aiocb.h out of
 include/block/aio.h
Date: Sat, 27 Dec 2025 10:47:55 +0100
Message-ID: <20251227094759.35658-76-pbonzini@redhat.com>
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


