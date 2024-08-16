Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A750C52D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 13:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sewuQ-0005Sz-WB; Fri, 16 Aug 2024 09:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sewuM-0005Bi-1Z
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 09:22:22 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sewuJ-0007kL-Fo
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 09:22:21 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3687ea0521cso1269392f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 06:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723814537; x=1724419337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ePF/o/hQSoaSIDuJhqV/fjOlqlj+BNS3IyHKpKM6oQg=;
 b=mrqVp0OBcAe4Hn1oFWMxipmza+iw5QK4XAYyViPj8Zsck1o8LEqSTZij4kGPkX90yj
 MoEM/y+JrLduP8JKfWyAx6sksz6xYc3+lkxB7/qFfAEMcYOeNmlkBRueoQuW5fwCpmYc
 BkTR020xNhH2kHO1dO5DEeAht1mAHnDhaRNRAyDmSLV2cXLoMaXjo2VenG844KpEzLZD
 vgOdn/s3DXNtLnNSnwHHL9E3vkmnmWLHyWCcEIiM4jAbxuapDlRJBp1LkbTstZNpGSzB
 njm3SHDEEsphQfYGWetUQoTlcRoLVxVNyn2Op946Psj9QKOyHwoiR5PV8XEjXJDa0JKj
 D1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723814537; x=1724419337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ePF/o/hQSoaSIDuJhqV/fjOlqlj+BNS3IyHKpKM6oQg=;
 b=XpYpxeMauC0YCoH1v0SoxxAYEKYb1wRe2e+6bUUkvj3ayvMsDGC8Bh6fb/POeykUZI
 sIf9ySNJQgHE+yZHaLuxbe/klfhhIRcCAd3f8HzOZiSdpLkRsbK7cuOAaQK46aENkvDV
 cmr0Gpj4Qf/kUZsHXmH6UxaotpobVX+jGlTGGP2LEpLrpPK2qZ4DF/V5rIT/pF43y9q6
 QATxmVaoCDV6uj4C2fx6d3uKSh/sFdIz+xxT5Sn2ViIY8uca410G+Gs0AbxKPtU838Ha
 0lzbdtiX4AMSvRkk2+1M5pzZDYXD+SDtdexkt6yfJGrg8CCLPBufIoZmTeZS2xnyuGKL
 ioRA==
X-Gm-Message-State: AOJu0Yyur1tk8Fd/ra8HYQG8eYcTkFx0coAtdCK9/cdcwxy91gksQE60
 F5ikkl5z3kkNOLYQLW8kPeVHob0Q50IV+JIxYsbayr5cOmxmgkYsCE/sLHuJofORs/lLKH2T1xx
 N
X-Google-Smtp-Source: AGHT+IFoOGB36cUl+ANrXfK2uA5RyEUDPxaEqgm5wAdCd3EuuT4+mcUtxP9lKqQVSt7kurYPIY8uMA==
X-Received: by 2002:a5d:4e42:0:b0:371:8eea:24b7 with SMTP id
 ffacd0b85a97d-371946a04e6mr2246256f8f.50.1723814537151; 
 Fri, 16 Aug 2024 06:22:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898ab855sm3631948f8f.105.2024.08.16.06.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 06:22:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 4/7] docs/devel/multiple-iothreads: Convert to rST format
Date: Fri, 16 Aug 2024 14:22:09 +0100
Message-Id: <20240816132212.3602106-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816132212.3602106-1-peter.maydell@linaro.org>
References: <20240816132212.3602106-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Convert docs/devel/multiple-iothreads.txt to rST format.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/index-internals.rst    |   1 +
 docs/devel/multiple-iothreads.rst | 139 ++++++++++++++++++++++++++++++
 docs/devel/multiple-iothreads.txt | 130 ----------------------------
 3 files changed, 140 insertions(+), 130 deletions(-)
 create mode 100644 docs/devel/multiple-iothreads.rst
 delete mode 100644 docs/devel/multiple-iothreads.txt

diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
index 4ac7725d728..88fa0e9450d 100644
--- a/docs/devel/index-internals.rst
+++ b/docs/devel/index-internals.rst
@@ -21,3 +21,4 @@ Details about QEMU's various subsystems including how to add features to them.
    writing-monitor-commands
    virtio-backends
    crypto
+   multiple-iothreads
diff --git a/docs/devel/multiple-iothreads.rst b/docs/devel/multiple-iothreads.rst
new file mode 100644
index 00000000000..d1f3fc4510a
--- /dev/null
+++ b/docs/devel/multiple-iothreads.rst
@@ -0,0 +1,139 @@
+Using Multiple ``IOThread``\ s
+==============================
+
+..
+   Copyright (c) 2014-2017 Red Hat Inc.
+
+   This work is licensed under the terms of the GNU GPL, version 2 or later.  See
+   the COPYING file in the top-level directory.
+
+
+This document explains the ``IOThread`` feature and how to write code that runs
+outside the BQL.
+
+The main loop and ``IOThread``\ s
+---------------------------------
+QEMU is an event-driven program that can do several things at once using an
+event loop.  The VNC server and the QMP monitor are both processed from the
+same event loop, which monitors their file descriptors until they become
+readable and then invokes a callback.
+
+The default event loop is called the main loop (see ``main-loop.c``).  It is
+possible to create additional event loop threads using
+``-object iothread,id=my-iothread``.
+
+Side note: The main loop and ``IOThread`` are both event loops but their code is
+not shared completely.  Sometimes it is useful to remember that although they
+are conceptually similar they are currently not interchangeable.
+
+Why ``IOThread``\ s are useful
+------------------------------
+``IOThread``\ s allow the user to control the placement of work.  The main loop is a
+scalability bottleneck on hosts with many CPUs.  Work can be spread across
+several ``IOThread``\ s instead of just one main loop.  When set up correctly this
+can improve I/O latency and reduce jitter seen by the guest.
+
+The main loop is also deeply associated with the BQL, which is a
+scalability bottleneck in itself.  vCPU threads and the main loop use the BQL
+to serialize execution of QEMU code.  This mutex is necessary because a lot of
+QEMU's code historically was not thread-safe.
+
+The fact that all I/O processing is done in a single main loop and that the
+BQL is contended by all vCPU threads and the main loop explain
+why it is desirable to place work into ``IOThread``\ s.
+
+The experimental ``virtio-blk`` data-plane implementation has been benchmarked and
+shows these effects:
+ftp://public.dhe.ibm.com/linux/pdfs/KVM_Virtualized_IO_Performance_Paper.pdf
+
+.. _how-to-program:
+
+How to program for ``IOThread``\ s
+----------------------------------
+The main difference between legacy code and new code that can run in an
+``IOThread`` is dealing explicitly with the event loop object, ``AioContext``
+(see ``include/block/aio.h``).  Code that only works in the main loop
+implicitly uses the main loop's ``AioContext``.  Code that supports running
+in ``IOThread``\ s must be aware of its ``AioContext``.
+
+AioContext supports the following services:
+ * File descriptor monitoring (read/write/error on POSIX hosts)
+ * Event notifiers (inter-thread signalling)
+ * Timers
+ * Bottom Halves (BH) deferred callbacks
+
+There are several old APIs that use the main loop AioContext:
+ * LEGACY ``qemu_aio_set_fd_handler()`` - monitor a file descriptor
+ * LEGACY ``qemu_aio_set_event_notifier()`` - monitor an event notifier
+ * LEGACY ``timer_new_ms()`` - create a timer
+ * LEGACY ``qemu_bh_new()`` - create a BH
+ * LEGACY ``qemu_bh_new_guarded()`` - create a BH with a device re-entrancy guard
+ * LEGACY ``qemu_aio_wait()`` - run an event loop iteration
+
+Since they implicitly work on the main loop they cannot be used in code that
+runs in an ``IOThread``.  They might cause a crash or deadlock if called from an
+``IOThread`` since the BQL is not held.
+
+Instead, use the ``AioContext`` functions directly (see ``include/block/aio.h``):
+ * ``aio_set_fd_handler()`` - monitor a file descriptor
+ * ``aio_set_event_notifier()`` - monitor an event notifier
+ * ``aio_timer_new()`` - create a timer
+ * ``aio_bh_new()`` - create a BH
+ * ``aio_bh_new_guarded()`` - create a BH with a device re-entrancy guard
+ * ``aio_poll()`` - run an event loop iteration
+
+The ``qemu_bh_new_guarded``/``aio_bh_new_guarded`` APIs accept a
+``MemReentrancyGuard``
+argument, which is used to check for and prevent re-entrancy problems. For
+BHs associated with devices, the reentrancy-guard is contained in the
+corresponding ``DeviceState`` and named ``mem_reentrancy_guard``.
+
+The ``AioContext`` can be obtained from the ``IOThread`` using
+``iothread_get_aio_context()`` or for the main loop using
+``qemu_get_aio_context()``. Code that takes an ``AioContext`` argument
+works both in ``IOThread``\ s or the main loop, depending on which ``AioContext``
+instance the caller passes in.
+
+How to synchronize with an ``IOThread``
+---------------------------------------
+Variables that can be accessed by multiple threads require some form of
+synchronization such as ``qemu_mutex_lock()``, ``rcu_read_lock()``, etc.
+
+``AioContext`` functions like ``aio_set_fd_handler()``,
+``aio_set_event_notifier()``, ``aio_bh_new()``, and ``aio_timer_new()``
+are thread-safe. They can be used to trigger activity in an ``IOThread``.
+
+Side note: the best way to schedule a function call across threads is to call
+``aio_bh_schedule_oneshot()``.
+
+The main loop thread can wait synchronously for a condition using
+``AIO_WAIT_WHILE()``.
+
+``AioContext`` and the block layer
+----------------------------------
+The ``AioContext`` originates from the QEMU block layer, even though nowadays
+``AioContext`` is a generic event loop that can be used by any QEMU subsystem.
+
+The block layer has support for ``AioContext`` integrated.  Each
+``BlockDriverState`` is associated with an ``AioContext`` using
+``bdrv_try_change_aio_context()`` and ``bdrv_get_aio_context()``.
+This allows block layer code to process I/O inside the
+right ``AioContext``.  Other subsystems may wish to follow a similar approach.
+
+Block layer code must therefore expect to run in an ``IOThread`` and avoid using
+old APIs that implicitly use the main loop.  See
+`How to program for IOThreads`_ for information on how to do that.
+
+Code running in the monitor typically needs to ensure that past
+requests from the guest are completed.  When a block device is running
+in an ``IOThread``, the ``IOThread`` can also process requests from the guest
+(via ioeventfd).  To achieve both objects, wrap the code between
+``bdrv_drained_begin()`` and ``bdrv_drained_end()``, thus creating a "drained
+section".
+
+Long-running jobs (usually in the form of coroutines) are often scheduled in
+the ``BlockDriverState``'s ``AioContext``.  The functions
+``bdrv_add``/``remove_aio_context_notifier``, or alternatively
+``blk_add``/``remove_aio_context_notifier`` if you use ``BlockBackends``,
+can be used to get a notification whenever ``bdrv_try_change_aio_context()``
+moves a ``BlockDriverState`` to a different ``AioContext``.
diff --git a/docs/devel/multiple-iothreads.txt b/docs/devel/multiple-iothreads.txt
deleted file mode 100644
index de85767b124..00000000000
--- a/docs/devel/multiple-iothreads.txt
+++ /dev/null
@@ -1,130 +0,0 @@
-Copyright (c) 2014-2017 Red Hat Inc.
-
-This work is licensed under the terms of the GNU GPL, version 2 or later.  See
-the COPYING file in the top-level directory.
-
-
-This document explains the IOThread feature and how to write code that runs
-outside the BQL.
-
-The main loop and IOThreads
----------------------------
-QEMU is an event-driven program that can do several things at once using an
-event loop.  The VNC server and the QMP monitor are both processed from the
-same event loop, which monitors their file descriptors until they become
-readable and then invokes a callback.
-
-The default event loop is called the main loop (see main-loop.c).  It is
-possible to create additional event loop threads using -object
-iothread,id=my-iothread.
-
-Side note: The main loop and IOThread are both event loops but their code is
-not shared completely.  Sometimes it is useful to remember that although they
-are conceptually similar they are currently not interchangeable.
-
-Why IOThreads are useful
-------------------------
-IOThreads allow the user to control the placement of work.  The main loop is a
-scalability bottleneck on hosts with many CPUs.  Work can be spread across
-several IOThreads instead of just one main loop.  When set up correctly this
-can improve I/O latency and reduce jitter seen by the guest.
-
-The main loop is also deeply associated with the BQL, which is a
-scalability bottleneck in itself.  vCPU threads and the main loop use the BQL
-to serialize execution of QEMU code.  This mutex is necessary because a lot of
-QEMU's code historically was not thread-safe.
-
-The fact that all I/O processing is done in a single main loop and that the
-BQL is contended by all vCPU threads and the main loop explain
-why it is desirable to place work into IOThreads.
-
-The experimental virtio-blk data-plane implementation has been benchmarked and
-shows these effects:
-ftp://public.dhe.ibm.com/linux/pdfs/KVM_Virtualized_IO_Performance_Paper.pdf
-
-How to program for IOThreads
-----------------------------
-The main difference between legacy code and new code that can run in an
-IOThread is dealing explicitly with the event loop object, AioContext
-(see include/block/aio.h).  Code that only works in the main loop
-implicitly uses the main loop's AioContext.  Code that supports running
-in IOThreads must be aware of its AioContext.
-
-AioContext supports the following services:
- * File descriptor monitoring (read/write/error on POSIX hosts)
- * Event notifiers (inter-thread signalling)
- * Timers
- * Bottom Halves (BH) deferred callbacks
-
-There are several old APIs that use the main loop AioContext:
- * LEGACY qemu_aio_set_fd_handler() - monitor a file descriptor
- * LEGACY qemu_aio_set_event_notifier() - monitor an event notifier
- * LEGACY timer_new_ms() - create a timer
- * LEGACY qemu_bh_new() - create a BH
- * LEGACY qemu_bh_new_guarded() - create a BH with a device re-entrancy guard
- * LEGACY qemu_aio_wait() - run an event loop iteration
-
-Since they implicitly work on the main loop they cannot be used in code that
-runs in an IOThread.  They might cause a crash or deadlock if called from an
-IOThread since the BQL is not held.
-
-Instead, use the AioContext functions directly (see include/block/aio.h):
- * aio_set_fd_handler() - monitor a file descriptor
- * aio_set_event_notifier() - monitor an event notifier
- * aio_timer_new() - create a timer
- * aio_bh_new() - create a BH
- * aio_bh_new_guarded() - create a BH with a device re-entrancy guard
- * aio_poll() - run an event loop iteration
-
-The qemu_bh_new_guarded/aio_bh_new_guarded APIs accept a "MemReentrancyGuard"
-argument, which is used to check for and prevent re-entrancy problems. For
-BHs associated with devices, the reentrancy-guard is contained in the
-corresponding DeviceState and named "mem_reentrancy_guard".
-
-The AioContext can be obtained from the IOThread using
-iothread_get_aio_context() or for the main loop using qemu_get_aio_context().
-Code that takes an AioContext argument works both in IOThreads or the main
-loop, depending on which AioContext instance the caller passes in.
-
-How to synchronize with an IOThread
------------------------------------
-Variables that can be accessed by multiple threads require some form of
-synchronization such as qemu_mutex_lock(), rcu_read_lock(), etc.
-
-AioContext functions like aio_set_fd_handler(), aio_set_event_notifier(),
-aio_bh_new(), and aio_timer_new() are thread-safe. They can be used to trigger
-activity in an IOThread.
-
-Side note: the best way to schedule a function call across threads is to call
-aio_bh_schedule_oneshot().
-
-The main loop thread can wait synchronously for a condition using
-AIO_WAIT_WHILE().
-
-AioContext and the block layer
-------------------------------
-The AioContext originates from the QEMU block layer, even though nowadays
-AioContext is a generic event loop that can be used by any QEMU subsystem.
-
-The block layer has support for AioContext integrated.  Each BlockDriverState
-is associated with an AioContext using bdrv_try_change_aio_context() and
-bdrv_get_aio_context().  This allows block layer code to process I/O inside the
-right AioContext.  Other subsystems may wish to follow a similar approach.
-
-Block layer code must therefore expect to run in an IOThread and avoid using
-old APIs that implicitly use the main loop.  See the "How to program for
-IOThreads" above for information on how to do that.
-
-Code running in the monitor typically needs to ensure that past
-requests from the guest are completed.  When a block device is running
-in an IOThread, the IOThread can also process requests from the guest
-(via ioeventfd).  To achieve both objects, wrap the code between
-bdrv_drained_begin() and bdrv_drained_end(), thus creating a "drained
-section".
-
-Long-running jobs (usually in the form of coroutines) are often scheduled in
-the BlockDriverState's AioContext.  The functions
-bdrv_add/remove_aio_context_notifier, or alternatively
-blk_add/remove_aio_context_notifier if you use BlockBackends, can be used to
-get a notification whenever bdrv_try_change_aio_context() moves a
-BlockDriverState to a different AioContext.
-- 
2.34.1


