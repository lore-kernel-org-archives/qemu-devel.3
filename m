Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F07E8FDDB
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQyT-0007TH-Hv; Sat, 27 Dec 2025 04:52:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQy1-0006oK-Es
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:52:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxy-0007Yf-7j
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kI7Ens2iUFj6+g0CAWOKjGlJK4R7nHbTYZmOISHQub8=;
 b=R3EDk+kh5K0xP8Koz+pGwCX9szfUOqkwS9C+s733Qk4IGk/tvs+c5D8Iyl/6i3lZD/eTaC
 tZUKtJk0mngpe++/+7TMtTNu4M6m6XFg3r7yXW7rWHnyqBGBOMWGXP1bhjTxJJ9oTl2oxq
 xI257z1NdoWtquXCjDRfJDGZzVjOZ94=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-CvsEPy_-OH6hAluqAK2lkA-1; Sat, 27 Dec 2025 04:51:57 -0500
X-MC-Unique: CvsEPy_-OH6hAluqAK2lkA-1
X-Mimecast-MFC-AGG-ID: CvsEPy_-OH6hAluqAK2lkA_1766829117
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so78162955e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829115; x=1767433915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kI7Ens2iUFj6+g0CAWOKjGlJK4R7nHbTYZmOISHQub8=;
 b=qOfsjBVzQWXEsmlTiFnOrICTwsdeEjYRQve41qVhx4NpIUYcQnpfumqVYK3UQb6j3/
 1h848XaLei82VUwwO6QDzbdTq4jXy2j3x/Wdh0uBuNIOdeVAu8PmAOQhPLEX3gRE3Wb6
 oWZiOxfOybMQYz1zPKUe81WepdPSuHw/AGK4ANTltm5aHlry6LbajbHFGgmWX0c40+SD
 ZtzYH3Hd8qyqbknMoVM5tBAl8faK/LTr7k5oEAZnoPaf526LJ8szEJBW3Tf+UEYUaIRF
 sgOHZ61Em6/UeNNxw6MbQa2jV26irV7H6O80WR1sbVrdf6BLl4u3Op2Ub84JqJ10iGf0
 O/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829115; x=1767433915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kI7Ens2iUFj6+g0CAWOKjGlJK4R7nHbTYZmOISHQub8=;
 b=aqYU7Ztf1hxqxbBENen6PMa3TdyACXmlGoA3bUV28MEp8U9brc2wvVr4JgQeG33tx6
 CVTnvy2MuQ8NrGXX5slOrrydmOpVL/Vy9HhZNXcW2iRPOs6njFXJ7bfxAZ/wx3bEZjz6
 +nYpZBzE0+rMtNs0ot8EiRaemBraRi6EYXiX7uTuyEGB9ZmeZDYbV6wZtdY4scUKkG2e
 /mQDi+CQTNg/Y4f9FpRZa2RCz1osS9v+lUbUzypKnEhFRaZSS1mlzbqlUz9gk+hwD759
 MuotsuxRepxtLYORXA26v3ud5JGV/5Xsv8AsP6Bk5yaJyd8MfR6aLP8CusE1sfyaAie3
 wRiQ==
X-Gm-Message-State: AOJu0Yxa8PvOqa+2s0Zc/0dwd/JmjuwZI2/5/sSRyA8/l7Lym/pQqak6
 u1w0TQdZ1HnUN+xuxxKGsZEGinv4L0f7S/aC6H+syIYtZ/2ECJqYE4Lwv4dMEyR/8txLjx2EMmY
 xdBnTEr0hnKK85IzKKPuZPZD3Yh2DHqokYin5BJxMrAvYhlKgGnozJrHisydz4ILmgdt4LgbAaG
 WRMpBnwwMOqMbfRoVh5z4aQZ0hRdRocfRr1m0d8gZ+
X-Gm-Gg: AY/fxX7JfOcvGz3ev8oDE83hzi79JSR3hCM1DbO2HDfjYLevFua9/h/T+S1gCBZM0I6
 DpZcgrs7dFYTvhXA0oet/w+pLxDkHsZlG+y26XiTIk66tf3rRg4AjUgfq4dZ551QYZx/SzjhP15
 KFCYRn9rWk9r5bMI70ikAZ892rvFlbCcWNgOldvVtR/kWpu3S2Bx4lS+TmjSOg/N3E3X3IYdm4o
 Rv71nmo3d6xLB+YkwvOmvsvoKqiBjPGO4BUH/wmaJ3XUjFGg+Mxgvz2atvV7IxBKRlI/44QB7ET
 hFteEP8ndngmlMYSR5K/Kg88cU6NoMdU28TOEGhrtYuJK3SuSDxKOFEdux/5Or34v6NMQ1Ww381
 2SmzgQm3b7tXG+nXenhqblWOnPl4Gt+PRhbDs8zVBYsmPl/b5EXeb26Mjd2Zu8T2Nhya0sqDg1W
 p9N7A9Bhdpyjpa/jw=
X-Received: by 2002:a05:600c:314f:b0:47d:4fbe:e6cc with SMTP id
 5b1f17b1804b1-47d4fbee749mr18982355e9.13.1766829114334; 
 Sat, 27 Dec 2025 01:51:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyH+rngQmnvQQ5IYrFGR7PqUG4DRz8FqvwvdWsqInRMsLYHwauldLt0PR8sHC62P4OWZ2Lzw==
X-Received: by 2002:a05:600c:314f:b0:47d:4fbe:e6cc with SMTP id
 5b1f17b1804b1-47d4fbee749mr18982055e9.13.1766829113769; 
 Sat, 27 Dec 2025 01:51:53 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2723b2bsm488443555e9.3.2025.12.27.01.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:51:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 152/153] block: rename block/aio.h to qemu/aio.h
Date: Sat, 27 Dec 2025 10:47:57 +0100
Message-ID: <20251227094759.35658-78-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
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

AioContexts are used as a generic event loop even outside the block
layer; move the header file out of block/ just like the implementation
is in util/.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                       | 2 +-
 docs/devel/multiple-iothreads.rst | 4 ++--
 include/block/aio-wait.h          | 2 +-
 include/block/raw-aio.h           | 2 +-
 include/block/thread-pool.h       | 2 +-
 include/hw/scsi/scsi.h            | 2 +-
 include/hw/virtio/virtio.h        | 2 +-
 include/io/channel.h              | 2 +-
 include/{block => qemu}/aio.h     | 0
 include/qemu/job.h                | 2 +-
 include/qemu/main-loop.h          | 2 +-
 include/qemu/throttle.h           | 2 +-
 include/scsi/pr-manager.h         | 2 +-
 include/system/event-loop-base.h  | 2 +-
 include/system/iothread.h         | 2 +-
 include/system/replay.h           | 2 +-
 tests/unit/iothread.h             | 2 +-
 util/aio-posix.h                  | 2 +-
 block/aio_task.c                  | 2 +-
 block/export/fuse.c               | 2 +-
 block/io_uring.c                  | 2 +-
 block/linux-aio.c                 | 2 +-
 block/win32-aio.c                 | 2 +-
 iothread.c                        | 2 +-
 qapi/qmp-dispatch.c               | 2 +-
 replay/replay-events.c            | 2 +-
 scsi/pr-manager.c                 | 2 +-
 stubs/linux-aio.c                 | 2 +-
 stubs/replay-tools.c              | 2 +-
 tests/unit/iothread.c             | 2 +-
 tests/unit/test-aio-multithread.c | 2 +-
 tests/unit/test-aio.c             | 2 +-
 tests/unit/test-nested-aio-poll.c | 2 +-
 tests/unit/test-thread-pool.c     | 2 +-
 tests/unit/test-throttle.c        | 2 +-
 util/async.c                      | 2 +-
 util/main-loop.c                  | 2 +-
 util/qemu-co-timeout.c            | 2 +-
 util/qemu-coroutine-lock.c        | 2 +-
 util/qemu-coroutine-sleep.c       | 2 +-
 util/qemu-coroutine.c             | 2 +-
 util/throttle.c                   | 2 +-
 scripts/analyze-inclusions        | 2 +-
 43 files changed, 43 insertions(+), 43 deletions(-)
 rename include/{block => qemu}/aio.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 81f48f0709c..efceed9fe52 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3071,7 +3071,7 @@ F: util/aio-*.h
 F: util/defer-call.c
 F: util/fdmon-*.c
 F: block/io.c
-F: include/block/aio.h
+F: include/qemu/aio.h
 F: include/block/aio-wait.h
 F: include/qemu/defer-call.h
 F: scripts/qemugdb/aio.py
diff --git a/docs/devel/multiple-iothreads.rst b/docs/devel/multiple-iothreads.rst
index d1f3fc4510a..a6eb0462673 100644
--- a/docs/devel/multiple-iothreads.rst
+++ b/docs/devel/multiple-iothreads.rst
@@ -52,7 +52,7 @@ How to program for ``IOThread``\ s
 ----------------------------------
 The main difference between legacy code and new code that can run in an
 ``IOThread`` is dealing explicitly with the event loop object, ``AioContext``
-(see ``include/block/aio.h``).  Code that only works in the main loop
+(see ``include/qemu/aio.h``).  Code that only works in the main loop
 implicitly uses the main loop's ``AioContext``.  Code that supports running
 in ``IOThread``\ s must be aware of its ``AioContext``.
 
@@ -74,7 +74,7 @@ Since they implicitly work on the main loop they cannot be used in code that
 runs in an ``IOThread``.  They might cause a crash or deadlock if called from an
 ``IOThread`` since the BQL is not held.
 
-Instead, use the ``AioContext`` functions directly (see ``include/block/aio.h``):
+Instead, use the ``AioContext`` functions directly (see ``include/qemu/aio.h``):
  * ``aio_set_fd_handler()`` - monitor a file descriptor
  * ``aio_set_event_notifier()`` - monitor an event notifier
  * ``aio_timer_new()`` - create a timer
diff --git a/include/block/aio-wait.h b/include/block/aio-wait.h
index cf5e8bde1ca..57ebe21b31f 100644
--- a/include/block/aio-wait.h
+++ b/include/block/aio-wait.h
@@ -25,7 +25,7 @@
 #ifndef QEMU_AIO_WAIT_H
 #define QEMU_AIO_WAIT_H
 
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "qemu/main-loop.h"
 
 /**
diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index d568b887f1c..256d0468a88 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -17,7 +17,7 @@
 #define QEMU_RAW_AIO_H
 
 #include "qemu/aiocb.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "block/block-common.h"
 #include "qemu/iov.h"
 
diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
index 65cabfc1388..e9ddb2b6d3c 100644
--- a/include/block/thread-pool.h
+++ b/include/block/thread-pool.h
@@ -19,7 +19,7 @@
 #define QEMU_THREAD_POOL_H
 
 #include "qemu/aiocb.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 
 #define THREAD_POOL_MAX_THREADS_DEFAULT         64
 
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 75b4d781a5c..d26f1127bb5 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -2,7 +2,7 @@
 #define QEMU_HW_SCSI_H
 
 #include "qemu/aiocb.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "hw/block/block.h"
 #include "hw/core/qdev.h"
 #include "scsi/utils.h"
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 91ff2fa21a5..27cd98d2fe1 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -23,7 +23,7 @@
 #include "standard-headers/linux/virtio_config.h"
 #include "standard-headers/linux/virtio_ring.h"
 #include "qom/object.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 
 /*
  * A guest should never accept this. It implies negotiation is broken
diff --git a/include/io/channel.h b/include/io/channel.h
index f42be760f9f..1b02350437d 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -23,7 +23,7 @@
 
 #include "qom/object.h"
 #include "qemu/coroutine-core.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 
 #define TYPE_QIO_CHANNEL "qio-channel"
 OBJECT_DECLARE_TYPE(QIOChannel, QIOChannelClass,
diff --git a/include/block/aio.h b/include/qemu/aio.h
similarity index 100%
rename from include/block/aio.h
rename to include/qemu/aio.h
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 2b163602c56..0e40e8b4570 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -31,7 +31,7 @@
 #include "qemu/queue.h"
 #include "qemu/progress_meter.h"
 #include "qemu/coroutine.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "block/graph-lock.h"
 
 typedef struct JobDriver JobDriver;
diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 241dc87be50..8c1241a2c11 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -25,7 +25,7 @@
 #ifndef QEMU_MAIN_LOOP_H
 #define QEMU_MAIN_LOOP_H
 
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "qom/object.h"
 #include "system/event-loop-base.h"
 
diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index 8fa2b29452a..06b6589c946 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -25,7 +25,7 @@
 #ifndef THROTTLE_H
 #define THROTTLE_H
 
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "qapi/qapi-types-block-core.h"
 #include "qemu/timer.h"
 
diff --git a/include/scsi/pr-manager.h b/include/scsi/pr-manager.h
index 45de28d3542..5045d115c44 100644
--- a/include/scsi/pr-manager.h
+++ b/include/scsi/pr-manager.h
@@ -4,7 +4,7 @@
 #include "qom/object.h"
 #include "qapi/visitor.h"
 #include "qom/object_interfaces.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 
 #define TYPE_PR_MANAGER "pr-manager"
 
diff --git a/include/system/event-loop-base.h b/include/system/event-loop-base.h
index a6c24f13513..130629e7f31 100644
--- a/include/system/event-loop-base.h
+++ b/include/system/event-loop-base.h
@@ -13,7 +13,7 @@
 #define QEMU_EVENT_LOOP_BASE_H
 
 #include "qom/object.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 
 #define TYPE_EVENT_LOOP_BASE         "event-loop-base"
 OBJECT_DECLARE_TYPE(EventLoopBase, EventLoopBaseClass,
diff --git a/include/system/iothread.h b/include/system/iothread.h
index d95c17a6456..e26d13c6c71 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -14,7 +14,7 @@
 #ifndef IOTHREAD_H
 #define IOTHREAD_H
 
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "qemu/thread.h"
 #include "qom/object.h"
 #include "system/event-loop-base.h"
diff --git a/include/system/replay.h b/include/system/replay.h
index 68f91bdfbf2..f8715ca9feb 100644
--- a/include/system/replay.h
+++ b/include/system/replay.h
@@ -15,7 +15,7 @@
 #include "qapi/qapi-types-misc.h"
 #include "qapi/qapi-types-run-state.h"
 #include "qapi/qapi-types-ui.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "qemu/audio.h"
 
 /* replay clock kinds */
diff --git a/tests/unit/iothread.h b/tests/unit/iothread.h
index 4877cea6a31..eb4d0c77f86 100644
--- a/tests/unit/iothread.h
+++ b/tests/unit/iothread.h
@@ -13,7 +13,7 @@
 #ifndef TEST_IOTHREAD_H
 #define TEST_IOTHREAD_H
 
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "qemu/thread.h"
 
 typedef struct IOThread IOThread;
diff --git a/util/aio-posix.h b/util/aio-posix.h
index babbfa83141..0cedb8d1891 100644
--- a/util/aio-posix.h
+++ b/util/aio-posix.h
@@ -17,7 +17,7 @@
 #ifndef AIO_POSIX_H
 #define AIO_POSIX_H
 
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "qapi/error.h"
 
 struct AioHandler {
diff --git a/block/aio_task.c b/block/aio_task.c
index bb5c05f455d..21b68a9fc02 100644
--- a/block/aio_task.c
+++ b/block/aio_task.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "block/aio_task.h"
 
 struct AioTaskPool {
diff --git a/block/export/fuse.c b/block/export/fuse.c
index 465cc9891d6..8cf4572f78d 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/memalign.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "block/block_int-common.h"
 #include "block/export.h"
 #include "block/fuse.h"
diff --git a/block/io_uring.c b/block/io_uring.c
index f1514cf024a..cb131d3b8b5 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -10,7 +10,7 @@
  */
 #include "qemu/osdep.h"
 #include <liburing.h>
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "block/block.h"
 #include "block/raw-aio.h"
 #include "qemu/coroutine.h"
diff --git a/block/linux-aio.c b/block/linux-aio.c
index c200e7ad20f..53c3e9af8ae 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -8,7 +8,7 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "qemu/queue.h"
 #include "block/block.h"
 #include "block/raw-aio.h"
diff --git a/block/win32-aio.c b/block/win32-aio.c
index 539f1c81c65..6e1b34fb95f 100644
--- a/block/win32-aio.c
+++ b/block/win32-aio.c
@@ -26,7 +26,7 @@
 #include "qemu/timer.h"
 #include "block/block-io.h"
 #include "block/block_int.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "block/raw-aio.h"
 #include "qemu/aiocb.h"
 #include "qemu/event_notifier.h"
diff --git a/iothread.c b/iothread.c
index 8810376dcea..caf68e07645 100644
--- a/iothread.c
+++ b/iothread.c
@@ -15,7 +15,7 @@
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
 #include "qemu/module.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "block/block.h"
 #include "system/event-loop-base.h"
 #include "system/iothread.h"
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index e569224eaea..9bb1e6a9f4a 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
 #include "qapi/qmp-registry.h"
diff --git a/replay/replay-events.c b/replay/replay-events.c
index a96e47e7740..9e5af5e8495 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -13,7 +13,7 @@
 #include "qemu/error-report.h"
 #include "system/replay.h"
 #include "replay-internal.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "ui/input.h"
 #include "hw/core/cpu.h"
 
diff --git a/scsi/pr-manager.c b/scsi/pr-manager.c
index 40e1210eb21..fec0d68c4cc 100644
--- a/scsi/pr-manager.c
+++ b/scsi/pr-manager.c
@@ -13,7 +13,7 @@
 #include <scsi/sg.h>
 
 #include "qapi/error.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "block/thread-pool.h"
 #include "scsi/pr-manager.h"
 #include "trace.h"
diff --git a/stubs/linux-aio.c b/stubs/linux-aio.c
index 84d1f784aed..b1a27e926e3 100644
--- a/stubs/linux-aio.c
+++ b/stubs/linux-aio.c
@@ -8,7 +8,7 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "block/raw-aio.h"
 
 void laio_detach_aio_context(LinuxAioState *s, AioContext *old_context)
diff --git a/stubs/replay-tools.c b/stubs/replay-tools.c
index c537485f401..17dc3babd9b 100644
--- a/stubs/replay-tools.c
+++ b/stubs/replay-tools.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "system/replay.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 
 bool replay_events_enabled(void)
 {
diff --git a/tests/unit/iothread.c b/tests/unit/iothread.c
index f9b0791084e..a363bf8f709 100644
--- a/tests/unit/iothread.c
+++ b/tests/unit/iothread.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "qemu/main-loop.h"
 #include "qemu/rcu.h"
 #include "iothread.h"
diff --git a/tests/unit/test-aio-multithread.c b/tests/unit/test-aio-multithread.c
index c24200a7121..9179cdc6a32 100644
--- a/tests/unit/test-aio-multithread.c
+++ b/tests/unit/test-aio-multithread.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "qemu/coroutine.h"
 #include "qemu/thread.h"
 #include "qemu/error-report.h"
diff --git a/tests/unit/test-aio.c b/tests/unit/test-aio.c
index 010d65b79a5..b3ca4d8a596 100644
--- a/tests/unit/test-aio.c
+++ b/tests/unit/test-aio.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/sockets.h"
diff --git a/tests/unit/test-nested-aio-poll.c b/tests/unit/test-nested-aio-poll.c
index d13ecccd8c0..9ab1ad08a79 100644
--- a/tests/unit/test-nested-aio-poll.c
+++ b/tests/unit/test-nested-aio-poll.c
@@ -13,7 +13,7 @@
  * aio_poll() calls. This test case checks that this is indeed what happens.
  */
 #include "qemu/osdep.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "qapi/error.h"
 #include "util/aio-posix.h"
 
diff --git a/tests/unit/test-thread-pool.c b/tests/unit/test-thread-pool.c
index ea5234f9f48..1e2f05f8416 100644
--- a/tests/unit/test-thread-pool.c
+++ b/tests/unit/test-thread-pool.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "block/thread-pool.h"
 #include "block/block.h"
 #include "qapi/error.h"
diff --git a/tests/unit/test-throttle.c b/tests/unit/test-throttle.c
index dfa61c75ea4..52eb8966b3f 100644
--- a/tests/unit/test-throttle.c
+++ b/tests/unit/test-throttle.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 #include <math.h>
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "qapi/error.h"
 #include "qemu/throttle.h"
 #include "qemu/error-report.h"
diff --git a/util/async.c b/util/async.c
index 39f391fb71a..80d6b01a8aa 100644
--- a/util/async.c
+++ b/util/async.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "block/thread-pool.h"
 #include "block/graph-lock.h"
 #include "qemu/main-loop.h"
diff --git a/util/main-loop.c b/util/main-loop.c
index b462598f76e..ad8645c30a4 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -30,7 +30,7 @@
 #include "exec/icount.h"
 #include "system/replay.h"
 #include "qemu/main-loop.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "block/thread-pool.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
diff --git a/util/qemu-co-timeout.c b/util/qemu-co-timeout.c
index 00cd335649f..6774440b287 100644
--- a/util/qemu-co-timeout.c
+++ b/util/qemu-co-timeout.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/coroutine.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 
 typedef struct QemuCoTimeoutState {
     CoroutineEntry *entry;
diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 2534435388f..fac91582b5f 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -30,7 +30,7 @@
 #include "qemu/coroutine_int.h"
 #include "qemu/processor.h"
 #include "qemu/queue.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 #include "trace.h"
 
 void qemu_co_queue_init(CoQueue *queue)
diff --git a/util/qemu-coroutine-sleep.c b/util/qemu-coroutine-sleep.c
index af59f9af984..edef1172844 100644
--- a/util/qemu-coroutine-sleep.c
+++ b/util/qemu-coroutine-sleep.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/coroutine_int.h"
 #include "qemu/timer.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 
 static const char *qemu_co_sleep_ns__scheduled = "qemu_co_sleep_ns";
 
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 64d6264fc74..d17135f585a 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -19,7 +19,7 @@
 #include "qemu/coroutine_int.h"
 #include "qemu/coroutine-tls.h"
 #include "qemu/cutils.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 
 enum {
     COROUTINE_POOL_BATCH_MAX_SIZE = 128,
diff --git a/util/throttle.c b/util/throttle.c
index 9582899da3e..8044f04ffc9 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "qemu/throttle.h"
 #include "qemu/timer.h"
-#include "block/aio.h"
+#include "qemu/aio.h"
 
 /* This function make a bucket leak
  *
diff --git a/scripts/analyze-inclusions b/scripts/analyze-inclusions
index 50a7d95d9e7..c30e44f02ec 100644
--- a/scripts/analyze-inclusions
+++ b/scripts/analyze-inclusions
@@ -52,7 +52,7 @@ echo $(grep_include -F 'qapi-types.h') files include qapi-types.h
 echo $(grep_include -F 'trace/generated-tracers.h') files include generated-tracers.h
 echo $(grep_include -F 'qapi/error.h') files include qapi/error.h
 echo $(grep_include -F 'qom/object.h') files include qom/object.h
-echo $(grep_include -F 'block/aio.h') files include block/aio.h
+echo $(grep_include -F 'qemu/aio.h') files include block/aio.h
 echo $(grep_include -F 'system/memory.h') files include system/memory.h
 echo $(grep_include -F 'fpu/softfloat.h') files include fpu/softfloat.h
 echo $(grep_include -F 'qemu/bswap.h') files include qemu/bswap.h
-- 
2.52.0


