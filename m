Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB33C021A0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 21:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thy5u-0001WB-EX; Tue, 11 Feb 2025 16:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thy3P-00080w-BS
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:44:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thy3K-0005DR-8r
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739310261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gt9MtMPak5dCFIyItE8PxiGLTKybUmN/3gmNvVFg0uM=;
 b=boNZgKu8LA4H/zJVCtIkUz240W9E6caW+GCP8uwdFl8FkpzMfTK7UBgv0pANWMYWyAOQVU
 9pp56iVSW52StpA4j9x1xz+AOLUUsSRu8HQJjjr5aOJgIKxnGSwfuezOuj5TO5lRzucVpI
 Tzsbk5YkOklAFBIvmrZpUUEoTdd1+Jg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-uypDdlaqP2KLKHc8pFHSAA-1; Tue,
 11 Feb 2025 16:44:19 -0500
X-MC-Unique: uypDdlaqP2KLKHc8pFHSAA-1
X-Mimecast-MFC-AGG-ID: uypDdlaqP2KLKHc8pFHSAA_1739310258
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F08A51800874; Tue, 11 Feb 2025 21:44:17 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.210])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A93F195608D; Tue, 11 Feb 2025 21:44:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: [PATCH 04/11] rust/qemu-api: Add wrappers to run futures in QEMU
Date: Tue, 11 Feb 2025 22:43:21 +0100
Message-ID: <20250211214328.640374-5-kwolf@redhat.com>
In-Reply-To: <20250211214328.640374-1-kwolf@redhat.com>
References: <20250211214328.640374-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This adds helper functions that allow running Rust futures to completion
using QEMU's event loops.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qemu/coroutine-rust.h | 24 +++++++++++
 rust/wrapper.h                |  1 +
 util/qemu-co-rust-async.c     | 55 ++++++++++++++++++++++++
 rust/qemu-api/meson.build     |  1 +
 rust/qemu-api/src/futures.rs  | 78 +++++++++++++++++++++++++++++++++++
 rust/qemu-api/src/lib.rs      |  1 +
 util/meson.build              |  3 ++
 7 files changed, 163 insertions(+)
 create mode 100644 include/qemu/coroutine-rust.h
 create mode 100644 util/qemu-co-rust-async.c
 create mode 100644 rust/qemu-api/src/futures.rs

diff --git a/include/qemu/coroutine-rust.h b/include/qemu/coroutine-rust.h
new file mode 100644
index 0000000000..0c5cf42a6b
--- /dev/null
+++ b/include/qemu/coroutine-rust.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ * Helpers to run Rust futures using QEMU coroutines
+ *
+ * Copyright Red Hat
+ *
+ * Author:
+ *   Kevin Wolf <kwolf@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+#ifndef QEMU_COROUTINE_RUST_H
+#define QEMU_COROUTINE_RUST_H
+
+typedef struct RustBoxedFuture RustBoxedFuture;
+typedef void coroutine_fn RunFuture(RustBoxedFuture *future, void *opaque);
+
+void no_coroutine_fn rust_run_future(RustBoxedFuture *future,
+                                     RunFuture *entry,
+                                     void *opaque);
+
+#endif
diff --git a/rust/wrapper.h b/rust/wrapper.h
index c3e1e6f9cf..61afac0494 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -57,3 +57,4 @@ typedef enum memory_order {
 #include "block/block_int.h"
 #include "block/qdict.h"
 #include "qapi/qapi-visit-block-core.h"
+#include "qemu/coroutine-rust.h"
diff --git a/util/qemu-co-rust-async.c b/util/qemu-co-rust-async.c
new file mode 100644
index 0000000000..d893dfb7bd
--- /dev/null
+++ b/util/qemu-co-rust-async.c
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ * Helpers to run Rust futures using QEMU coroutines
+ *
+ * Copyright Red Hat
+ *
+ * Author:
+ *   Kevin Wolf <kwolf@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "block/aio-wait.h"
+#include "qemu/coroutine.h"
+#include "qemu/coroutine-rust.h"
+#include "qemu/main-loop.h"
+
+typedef struct FutureCo {
+    RustBoxedFuture *future;
+    RunFuture *entry;
+    void *opaque;
+    bool done;
+} FutureCo;
+
+static void coroutine_fn rust_co_run_future_entry(void *opaque)
+{
+    FutureCo *data = opaque;
+
+    data->entry(data->future, data->opaque);
+    data->done = true;
+    aio_wait_kick();
+}
+
+void no_coroutine_fn rust_run_future(RustBoxedFuture *future,
+                                     RunFuture *entry,
+                                     void *opaque)
+{
+    AioContext *ctx = qemu_get_current_aio_context();
+    Coroutine *co;
+    FutureCo data = {
+        .future = future,
+        .entry = entry,
+        .opaque = opaque,
+        .done = false,
+    };
+
+    GLOBAL_STATE_CODE();
+
+    co = qemu_coroutine_create(rust_co_run_future_entry, &data);
+    aio_co_enter(ctx, co);
+    AIO_WAIT_WHILE(ctx, !data.done);
+}
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index acac384936..713812bc2f 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -18,6 +18,7 @@ sources_core = [
   'src/callbacks.rs',
   'src/cell.rs',
   'src/c_str.rs',
+  'src/futures.rs',
   'src/module.rs',
   'src/offset_of.rs',
   'src/prelude.rs',
diff --git a/rust/qemu-api/src/futures.rs b/rust/qemu-api/src/futures.rs
new file mode 100644
index 0000000000..485041fd98
--- /dev/null
+++ b/rust/qemu-api/src/futures.rs
@@ -0,0 +1,78 @@
+use crate::bindings;
+use std::ffi::c_void;
+use std::future::Future;
+use std::mem::MaybeUninit;
+use std::sync::Arc;
+use std::task::{Context, Poll, Wake};
+
+struct RunFutureWaker {
+    co: *mut bindings::Coroutine,
+}
+unsafe impl Send for RunFutureWaker {}
+unsafe impl Sync for RunFutureWaker {}
+
+impl Wake for RunFutureWaker {
+    fn wake(self: Arc<Self>) {
+        unsafe {
+            bindings::aio_co_wake(self.co);
+        }
+    }
+}
+
+/// Use QEMU's event loops to run a Rust [`Future`] to completion and return its result.
+///
+/// This function must be called in coroutine context. If the future isn't ready yet, it yields.
+pub fn qemu_co_run_future<F: Future>(future: F) -> F::Output {
+    let waker = Arc::new(RunFutureWaker {
+        co: unsafe { bindings::qemu_coroutine_self() },
+    })
+    .into();
+    let mut cx = Context::from_waker(&waker);
+
+    let mut pinned_future = std::pin::pin!(future);
+    loop {
+        match pinned_future.as_mut().poll(&mut cx) {
+            Poll::Ready(res) => return res,
+            Poll::Pending => unsafe {
+                bindings::qemu_coroutine_yield();
+            },
+        }
+    }
+}
+
+/// Wrapper around [`qemu_co_run_future`] that can be called from C.
+///
+/// # Safety
+///
+/// `future` must be a valid pointer to an owned `F` (it will be freed in this function).  `output`
+/// must be a valid pointer representing a mutable reference to an `F::Output` where the result can
+/// be stored.
+unsafe extern "C" fn rust_co_run_future<F: Future>(
+    future: *mut bindings::RustBoxedFuture,
+    output: *mut c_void,
+) {
+    let future = unsafe { Box::from_raw(future.cast::<F>()) };
+    let output = output.cast::<F::Output>();
+    let ret = qemu_co_run_future(*future);
+    unsafe {
+        *output = ret;
+    }
+}
+
+/// Use QEMU's event loops to run a Rust [`Future`] to completion and return its result.
+///
+/// This function must be called outside of coroutine context to avoid deadlocks. It blocks and
+/// runs a nested even loop until the future is ready and returns a result.
+pub fn qemu_run_future<F: Future>(future: F) -> F::Output {
+    let future_ptr = Box::into_raw(Box::new(future));
+    let mut output = MaybeUninit::<F::Output>::uninit();
+    unsafe {
+        bindings::rust_run_future(
+            future_ptr.cast::<bindings::RustBoxedFuture>(),
+            #[allow(clippy::as_underscore)]
+            Some(rust_co_run_future::<F> as _),
+            output.as_mut_ptr().cast::<c_void>(),
+        );
+        output.assume_init()
+    }
+}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 3c6c154f3d..9b8f5fa4f1 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -18,6 +18,7 @@
 pub mod c_str;
 pub mod callbacks;
 pub mod cell;
+pub mod futures;
 #[cfg(feature = "system")]
 pub mod irq;
 pub mod module;
diff --git a/util/meson.build b/util/meson.build
index 780b5977a8..14a2ae17fd 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -101,6 +101,9 @@ if have_block
   util_ss.add(files('qemu-coroutine-sleep.c'))
   util_ss.add(files('qemu-co-shared-resource.c'))
   util_ss.add(files('qemu-co-timeout.c'))
+  if have_rust
+    util_ss.add(files('qemu-co-rust-async.c'))
+  endif
   util_ss.add(files('readline.c'))
   util_ss.add(files('throttle.c'))
   util_ss.add(files('timed-average.c'))
-- 
2.48.1


