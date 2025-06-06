Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767A9C61CE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWIf-0002vV-Lq; Fri, 06 Jun 2025 08:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIe-0002ul-09
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWIb-0005wi-Km
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xz1XhOu9Eds1DlIWIBiFtM0oXrj8OabBoECKhWUXSz8=;
 b=cC+4byohULvtlQkneiAebt9dmpgplmwFVHYga7WJIgtxZBGBJNp2LrGW3XrRVfYSG5ALkC
 EjH8B6eNeyepYyZeXaUCtxhsSC9R8KjETZ7R03Z7b4M7MdaljWe8TPHOjmNEXDNy963jNZ
 U34NBHPTwMuYyGVHSTnRfpMFSBD4IEw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-15Jqb6BhMwG0reYxJYmn1A-1; Fri, 06 Jun 2025 08:35:51 -0400
X-MC-Unique: 15Jqb6BhMwG0reYxJYmn1A-1
X-Mimecast-MFC-AGG-ID: 15Jqb6BhMwG0reYxJYmn1A_1749213350
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f8fd1856so971079f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213349; x=1749818149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xz1XhOu9Eds1DlIWIBiFtM0oXrj8OabBoECKhWUXSz8=;
 b=MOlDWwP1rEaxG2QVjboreol/7EZIpIMqDY4qQ9VoOzin+DwnDjxNUD9HJHNlqsT9z1
 hJRdaFEJsoTMpDNXU2t3vtBl7Spnho74oXqEM3sbnsXPxpDsj0GiizTk0MuAvhw/CB6c
 seSwllaD1+6LX/Gcvo59ePSFlMhLhR4WYNNiX2OblciwTVj68G2D1sXvbIIOVaaMyHL2
 Cd5H8l/y/2CdWxohmKYFOp7kI1GCZWlmcBtrzNw8o24RKsJSfvSnzvRS2dE28JTeD503
 YL1xHrjh6wgUc1uzwkmh1l00vYb0Ek+r7u87Ynczj1UryPCJ0BycLJsxx2SgYNq9fkeK
 nKXw==
X-Gm-Message-State: AOJu0YyQJJVUBOAGBUAj80Rm6xmsK3KCzfu1mVQHSsE3CRYYmWDlzMvn
 g9IRtsTYwt2kfx3z5i+iHtC+fqCH26vv5BQZH/qf+CoG1reJiu6cGIYUZ+/vf8XYPLfya015JHR
 hkblUBv9vu7Opjr118z/k2JvdGqKU5le2FHLMSHA9u2PVHX8cWFdoFsJh3zhquxjWN6ZtvMnk0R
 Bpv+SUUG8lOHA78Gd5/QOuxNhlHuokqgRnWil8XNrS
X-Gm-Gg: ASbGncvHFRWtkF5wGAA5r4VJ0oKfEGrJkK+/Y6p9v2wN3p8XkFUaIT+34I8FrYIgCWM
 zRen0wv/bmNDK2W0/H9/+CA/AagTXWqV1jeg+pS52So59jKeVCm0O0njqXVeKKtWFGii86o9N9S
 TA5DSs85U4X7YFenYrfOBw0D7eu2JIYVgLBYJVu+9KtRI/EF3XYEdSBcVnFRCjNT5hQsAXFErpY
 BPgO13vQSjaGMLGvgw2Fma4ykl4b9dR4WBH7HVKJj1HYdxkX/5N53cE5NfHWEqbprUi6gebRnj6
 WS78H8YhvXmDkTeAI1wiJXV4
X-Received: by 2002:a5d:64c6:0:b0:3a4:ec23:dba7 with SMTP id
 ffacd0b85a97d-3a531886727mr2966282f8f.31.1749213348993; 
 Fri, 06 Jun 2025 05:35:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9LKKDUvwCZIrike6sHrjM4DZJ2uu7Ka13AMvogPQieP5NLNRm4QesFLdnADablQoyXsc1Eg==
X-Received: by 2002:a5d:64c6:0:b0:3a4:ec23:dba7 with SMTP id
 ffacd0b85a97d-3a531886727mr2966260f8f.31.1749213348493; 
 Fri, 06 Jun 2025 05:35:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323b59d0sm1812308f8f.38.2025.06.06.05.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:35:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 18/31] futex: Support Windows
Date: Fri,  6 Jun 2025 14:34:32 +0200
Message-ID: <20250606123447.538131-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606123447.538131-1-pbonzini@redhat.com>
References: <20250606123447.538131-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Windows supports futex-like APIs since Windows 8 and Windows Server
2012.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Link: https://lore.kernel.org/r/20250529-event-v5-2-53b285203794@daynix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                       |  7 ++++
 include/qemu/futex.h              | 53 ++++++++++++++++++++++++-------
 tests/unit/test-aio-multithread.c |  2 +-
 util/lockcnt.c                    |  2 +-
 util/qemu-thread-posix.c          |  4 +--
 util/meson.build                  |  2 +-
 6 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/meson.build b/meson.build
index 967a10e80b8..34729c2a3dd 100644
--- a/meson.build
+++ b/meson.build
@@ -838,11 +838,18 @@ emulator_link_args = []
 midl = not_found
 widl = not_found
 pathcch = not_found
+synchronization = not_found
 host_dsosuf = '.so'
 if host_os == 'windows'
   midl = find_program('midl', required: false)
   widl = find_program('widl', required: false)
   pathcch = cc.find_library('pathcch')
+  synchronization = cc.find_library('Synchronization', required: false)
+  if not synchronization.found()
+    # The library name is lowercase on mingw
+    synchronization = cc.find_library('synchronization', required: true)
+  endif
+
   socket = cc.find_library('ws2_32')
   winmm = cc.find_library('winmm')
 
diff --git a/include/qemu/futex.h b/include/qemu/futex.h
index f5777400533..607613eec83 100644
--- a/include/qemu/futex.h
+++ b/include/qemu/futex.h
@@ -1,5 +1,5 @@
 /*
- * Wrappers around Linux futex syscall
+ * Wrappers around Linux futex syscall and similar
  *
  * Copyright Red Hat, Inc. 2017
  *
@@ -11,28 +11,37 @@
  *
  */
 
+/*
+ * Note that a wake-up can also be caused by common futex usage patterns in
+ * unrelated code that happened to have previously used the futex word's
+ * memory location (e.g., typical futex-based implementations of Pthreads
+ * mutexes can cause this under some conditions).  Therefore, qemu_futex_wait()
+ * callers should always conservatively assume that it is a spurious wake-up,
+ * and use the futex word's value (i.e., the user-space synchronization scheme)
+ * to decide whether to continue to block or not.
+ */
+
 #ifndef QEMU_FUTEX_H
 #define QEMU_FUTEX_H
 
+#define HAVE_FUTEX
+
+#ifdef CONFIG_LINUX
 #include <sys/syscall.h>
 #include <linux/futex.h>
 
 #define qemu_futex(...)              syscall(__NR_futex, __VA_ARGS__)
 
-static inline void qemu_futex_wake(void *f, int n)
+static inline void qemu_futex_wake_all(void *f)
 {
-    qemu_futex(f, FUTEX_WAKE, n, NULL, NULL, 0);
+    qemu_futex(f, FUTEX_WAKE, INT_MAX, NULL, NULL, 0);
+}
+
+static inline void qemu_futex_wake_single(void *f)
+{
+    qemu_futex(f, FUTEX_WAKE, 1, NULL, NULL, 0);
 }
 
-/*
- * Note that a wake-up can also be caused by common futex usage patterns in
- * unrelated code that happened to have previously used the futex word's
- * memory location (e.g., typical futex-based implementations of Pthreads
- * mutexes can cause this under some conditions).  Therefore, callers should
- * always conservatively assume that it is a spurious wake-up, and use the futex
- * word's value (i.e., the user-space synchronization scheme) to decide whether
- * to continue to block or not.
- */
 static inline void qemu_futex_wait(void *f, unsigned val)
 {
     while (qemu_futex(f, FUTEX_WAIT, (int) val, NULL, NULL, 0)) {
@@ -46,5 +55,25 @@ static inline void qemu_futex_wait(void *f, unsigned val)
         }
     }
 }
+#elif defined(CONFIG_WIN32)
+#include <synchapi.h>
+
+static inline void qemu_futex_wake_all(void *f)
+{
+    WakeByAddressAll(f);
+}
+
+static inline void qemu_futex_wake_single(void *f)
+{
+    WakeByAddressSingle(f);
+}
+
+static inline void qemu_futex_wait(void *f, unsigned val)
+{
+    WaitOnAddress(f, &val, sizeof(val), INFINITE);
+}
+#else
+#undef HAVE_FUTEX
+#endif
 
 #endif /* QEMU_FUTEX_H */
diff --git a/tests/unit/test-aio-multithread.c b/tests/unit/test-aio-multithread.c
index 8c2e41545a2..0ead6bf34ad 100644
--- a/tests/unit/test-aio-multithread.c
+++ b/tests/unit/test-aio-multithread.c
@@ -330,7 +330,7 @@ static void mcs_mutex_unlock(void)
     /* Wake up the next in line.  */
     next = qatomic_read(&nodes[id].next);
     nodes[next].locked = 0;
-    qemu_futex_wake(&nodes[next].locked, 1);
+    qemu_futex_wake_single(&nodes[next].locked);
 }
 
 static void test_multi_fair_mutex_entry(void *opaque)
diff --git a/util/lockcnt.c b/util/lockcnt.c
index d07c6cc5cee..ca27d8e61a5 100644
--- a/util/lockcnt.c
+++ b/util/lockcnt.c
@@ -106,7 +106,7 @@ static bool qemu_lockcnt_cmpxchg_or_wait(QemuLockCnt *lockcnt, int *val,
 static void lockcnt_wake(QemuLockCnt *lockcnt)
 {
     trace_lockcnt_futex_wake(lockcnt);
-    qemu_futex_wake(&lockcnt->count, 1);
+    qemu_futex_wake_single(&lockcnt->count);
 }
 
 void qemu_lockcnt_inc(QemuLockCnt *lockcnt)
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index f81fca5c116..f80f564e762 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -345,7 +345,7 @@ static inline void qemu_futex_wait(QemuEvent *ev, unsigned val)
 
 /* Valid transitions:
  * - free->set, when setting the event
- * - busy->set, when setting the event, followed by qemu_futex_wake
+ * - busy->set, when setting the event, followed by qemu_futex_wake_all
  * - set->free, when resetting the event
  * - free->busy, when waiting
  *
@@ -400,7 +400,7 @@ void qemu_event_set(QemuEvent *ev)
         smp_mb__after_rmw();
         if (old == EV_BUSY) {
             /* There were waiters, wake them up.  */
-            qemu_futex_wake(ev, INT_MAX);
+            qemu_futex_wake_all(ev);
         }
     }
 }
diff --git a/util/meson.build b/util/meson.build
index 1adff96ebd5..5735f65f199 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -27,7 +27,7 @@ else
   util_ss.add(files('event_notifier-win32.c'))
   util_ss.add(files('oslib-win32.c'))
   util_ss.add(files('qemu-thread-win32.c'))
-  util_ss.add(winmm, pathcch)
+  util_ss.add(winmm, pathcch, synchronization)
 endif
 util_ss.add(when: linux_io_uring, if_true: files('fdmon-io_uring.c'))
 if glib_has_gslice
-- 
2.49.0


