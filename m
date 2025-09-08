Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8035CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 11:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZSh-0006Bb-MG; Mon, 08 Sep 2025 06:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSf-0006Av-Ck
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSO-00062A-GC
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ApGgfRVEvTaI43FD8Iugc81VQGICJEpmXCmyVAUrBuM=;
 b=d02dljnHg9ULQndoIVbzB4UtQX1uyuYArYIE+lEmzS4iVcerEXfmsFHvGy/SMEe5NSgnPN
 SrXaqW0MSzcT2v/oIqCw6/1XAkvloFJc8pcoCE7EQ4ElAdHCubBdcrWmNL/MMsa15Ehbha
 jRQo/U+LCA77v6327ry7bg/eD5wcv3o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-5fz0jOWcN_mxTaXGCvPFNg-1; Mon, 08 Sep 2025 06:50:37 -0400
X-MC-Unique: 5fz0jOWcN_mxTaXGCvPFNg-1
X-Mimecast-MFC-AGG-ID: 5fz0jOWcN_mxTaXGCvPFNg_1757328636
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b96c2f4ccso25273755e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328635; x=1757933435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ApGgfRVEvTaI43FD8Iugc81VQGICJEpmXCmyVAUrBuM=;
 b=qYYppQHl89uT4xgNtwh/DJJuUMB4nxhHdbkwym3H1OUyC32DsAjmEWJxjo5UfA0Kk8
 9DnQ0bM3Ck+bc4nlyBnXqZg890Rh00MzhfOVrTgGHmmrA4AhqT0NIX3vLpy+P7onnsyy
 D+/GOcaYEzJ3AozBD7FoOl36/9O14btVM2feQdL03d6uKjgctdujmn5Ddr7XkX+Bt8C1
 ARP6npLU4+Dl36lfzNf+PCKXf5FAU58YMnFSLPDFvXsmkMzo+A4A+wDyuy7a30arNIze
 0/FuOYvwMzJcu0vWZiC5SIpR90YW5IS+5DyLVhN0BJvK7PFu0jGkgEygnpoXTQYYmaL0
 A/ow==
X-Gm-Message-State: AOJu0Yy1ddFncrxEXgga/6oYzRg9Wr45tRMgQFdOLurLT/t9EfVWDQ9n
 yCHIGYJIT/YpfQgLq5E2S+Y3X4bVd/dN2843vHkNSEbOjHcqli8i2CLoK0VxLSwG5/K/NdUz1C0
 3XuYnx32XIWNvHAF2X0iDU/jHkpPPpt9vttLpfbUd1kogyN5ugsR+PY1P2N9K823GExD5lIKvkQ
 W4AoSYnzvOHV0ApJiZY4fV0RKHPEs7bw7spXVwDYSo
X-Gm-Gg: ASbGncsUZy0WrVvpnTl1U2OPmJpcvP0pIa1Glj28gExCaFoiJyg+KVqESxlw7UMGSj9
 HiRZSaNh3Vcob3gRfqHN79cx6wCNZelyBr/2pwkH/ybRDqrSOnRHjyukRxl9IttUE4Z8JLB70q9
 AgBfzlBEN3569OTLVju/LHePAjOSynT64Tq1TIeN4Jxh7AzdmDewvmS2AzvsO6214qd5gWNoC8v
 0Pf5ZjTbiMIcBKCJyfjvLTfHjD9OV+4SYIC2ZGxGOyww7nb5tW6hJXmCh2XVUxK8UQ4g7yaBs0Y
 coHTehk20CYVFdxxYuXDheL7KPnBU7uiDGN4foLj9uN/gt05Hboc1U4dai8lSersCw49xhlNlrQ
 ojU0IaZXD1munC7+000aLUwPral6KgEGjv7mtlYW4JQA=
X-Received: by 2002:a05:600c:4ed0:b0:45d:e5ff:e38c with SMTP id
 5b1f17b1804b1-45de5ffe7f7mr29308655e9.32.1757328634516; 
 Mon, 08 Sep 2025 03:50:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT1yyGXD9QZFsZ42v4A1P3yBGwLRacFCQspB+0AA325FvcbF4DZ8roANmX8Nu6HUr66tJB+g==
X-Received: by 2002:a05:600c:4ed0:b0:45d:e5ff:e38c with SMTP id
 5b1f17b1804b1-45de5ffe7f7mr29308235e9.32.1757328633827; 
 Mon, 08 Sep 2025 03:50:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45de6e787desm15563985e9.8.2025.09.08.03.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:50:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 11/33] rust: remove unused global qemu "allocator"
Date: Mon,  8 Sep 2025 12:49:43 +0200
Message-ID: <20250908105005.2119297-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908105005.2119297-1-pbonzini@redhat.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The global allocator has always been disabled. There is no clear reason
Rust and C should use the same allocator. Allocations made from Rust
must be freed by Rust, and same for C, otherwise we head into troubles.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250827104147.717203-3-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build               |   4 --
 rust/Cargo.toml           |   2 +-
 rust/qemu-api/Cargo.toml  |   1 -
 rust/qemu-api/meson.build |   1 -
 rust/qemu-api/src/lib.rs  | 135 --------------------------------------
 5 files changed, 1 insertion(+), 142 deletions(-)

diff --git a/meson.build b/meson.build
index ef3f52b951d..49395197f44 100644
--- a/meson.build
+++ b/meson.build
@@ -1090,9 +1090,6 @@ glib = declare_dependency(dependencies: [glib_pc, gmodule],
 # TODO: remove this check and the corresponding workaround (qtree) when
 # the minimum supported glib is >= 2.75.3
 glib_has_gslice = glib.version().version_compare('<2.75.3')
-# Check whether glib has the aligned_alloc family of functions.
-# <https://docs.gtk.org/glib/func.aligned_alloc.html>
-glib_has_aligned_alloc = glib.version().version_compare('>=2.72.0')
 
 # override glib dep to include the above refinements
 meson.override_dependency('glib-2.0', glib)
@@ -2706,7 +2703,6 @@ config_host_data.set('CONFIG_GETLOADAVG', cc.has_function('getloadavg'))
 config_host_data.set('HAVE_COPY_FILE_RANGE', cc.has_function('copy_file_range'))
 config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
 config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
-config_host_data.set('HAVE_GLIB_WITH_ALIGNED_ALLOC', glib_has_aligned_alloc)
 config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', dependencies: util))
 config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul', prefix: osdep_prefix))
 config_host_data.set('HAVE_SYSTEM_FUNCTION', cc.has_function('system', prefix: '#include <stdlib.h>'))
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 9b26aa07cec..d98d2b77026 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -23,7 +23,7 @@ libc = "0.2.162"
 
 [workspace.lints.rust]
 unexpected_cfgs = { level = "deny", check-cfg = [
-    'cfg(MESON)', 'cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)',
+    'cfg(MESON)',
 ] }
 
 # Occasionally, we may need to silence warnings and clippy lints that
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index c07a17a28b0..c5ed78035b6 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -21,7 +21,6 @@ libc = { workspace = true }
 
 [features]
 default = ["debug_cell"]
-allocator = []
 debug_cell = []
 
 [lints]
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index a090297c458..062009f1618 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -2,7 +2,6 @@ _qemu_api_cfg = run_command(rustc_args,
   '--config-headers', config_host_h, '--features', files('Cargo.toml'),
   capture: true, check: true).stdout().strip().splitlines()
 
-# _qemu_api_cfg += ['--cfg', 'feature="allocator"']
 if get_option('debug_mutex')
   _qemu_api_cfg += ['--cfg', 'feature="debug_cell"']
 endif
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index bcb51c7986a..daa2493bb69 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -36,139 +36,4 @@
 // crate).
 extern crate self as qemu_api;
 
-use std::{
-    alloc::{GlobalAlloc, Layout},
-    ffi::c_void,
-};
-
 pub use error::{Error, Result};
-
-#[cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)]
-extern "C" {
-    fn g_aligned_alloc0(
-        n_blocks: bindings::gsize,
-        n_block_bytes: bindings::gsize,
-        alignment: bindings::gsize,
-    ) -> bindings::gpointer;
-    fn g_aligned_free(mem: bindings::gpointer);
-}
-
-#[cfg(not(HAVE_GLIB_WITH_ALIGNED_ALLOC))]
-extern "C" {
-    fn qemu_memalign(alignment: usize, size: usize) -> *mut c_void;
-    fn qemu_vfree(ptr: *mut c_void);
-}
-
-extern "C" {
-    fn g_malloc0(n_bytes: bindings::gsize) -> bindings::gpointer;
-    fn g_free(mem: bindings::gpointer);
-}
-
-/// An allocator that uses the same allocator as QEMU in C.
-///
-/// It is enabled by default with the `allocator` feature.
-///
-/// To set it up manually as a global allocator in your crate:
-///
-/// ```ignore
-/// use qemu_api::QemuAllocator;
-///
-/// #[global_allocator]
-/// static GLOBAL: QemuAllocator = QemuAllocator::new();
-/// ```
-#[derive(Clone, Copy, Debug)]
-#[repr(C)]
-pub struct QemuAllocator {
-    _unused: [u8; 0],
-}
-
-#[cfg_attr(all(feature = "allocator", not(test)), global_allocator)]
-pub static GLOBAL: QemuAllocator = QemuAllocator::new();
-
-impl QemuAllocator {
-    // From the glibc documentation, on GNU systems, malloc guarantees 16-byte
-    // alignment on 64-bit systems and 8-byte alignment on 32-bit systems. See
-    // https://www.gnu.org/software/libc/manual/html_node/Malloc-Examples.html.
-    // This alignment guarantee also applies to Windows and Android. On Darwin
-    // and OpenBSD, the alignment is 16 bytes on both 64-bit and 32-bit systems.
-    #[cfg(all(
-        target_pointer_width = "32",
-        not(any(target_os = "macos", target_os = "openbsd"))
-    ))]
-    pub const DEFAULT_ALIGNMENT_BYTES: Option<usize> = Some(8);
-    #[cfg(all(
-        target_pointer_width = "64",
-        not(any(target_os = "macos", target_os = "openbsd"))
-    ))]
-    pub const DEFAULT_ALIGNMENT_BYTES: Option<usize> = Some(16);
-    #[cfg(all(
-        any(target_pointer_width = "32", target_pointer_width = "64"),
-        any(target_os = "macos", target_os = "openbsd")
-    ))]
-    pub const DEFAULT_ALIGNMENT_BYTES: Option<usize> = Some(16);
-    #[cfg(not(any(target_pointer_width = "32", target_pointer_width = "64")))]
-    pub const DEFAULT_ALIGNMENT_BYTES: Option<usize> = None;
-
-    pub const fn new() -> Self {
-        Self { _unused: [] }
-    }
-}
-
-impl Default for QemuAllocator {
-    fn default() -> Self {
-        Self::new()
-    }
-}
-
-// Sanity check.
-const _: [(); 8] = [(); ::core::mem::size_of::<*mut c_void>()];
-
-unsafe impl GlobalAlloc for QemuAllocator {
-    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
-        if matches!(Self::DEFAULT_ALIGNMENT_BYTES, Some(default) if default.checked_rem(layout.align()) == Some(0))
-        {
-            // SAFETY: g_malloc0() is safe to call.
-            unsafe { g_malloc0(layout.size().try_into().unwrap()).cast::<u8>() }
-        } else {
-            #[cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)]
-            {
-                // SAFETY: g_aligned_alloc0() is safe to call.
-                unsafe {
-                    g_aligned_alloc0(
-                        layout.size().try_into().unwrap(),
-                        1,
-                        layout.align().try_into().unwrap(),
-                    )
-                    .cast::<u8>()
-                }
-            }
-            #[cfg(not(HAVE_GLIB_WITH_ALIGNED_ALLOC))]
-            {
-                // SAFETY: qemu_memalign() is safe to call.
-                unsafe { qemu_memalign(layout.align(), layout.size()).cast::<u8>() }
-            }
-        }
-    }
-
-    unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
-        if matches!(Self::DEFAULT_ALIGNMENT_BYTES, Some(default) if default.checked_rem(layout.align()) == Some(0))
-        {
-            // SAFETY: `ptr` must have been allocated by Self::alloc thus a valid
-            // glib-allocated pointer, so `g_free`ing is safe.
-            unsafe { g_free(ptr.cast::<_>()) }
-        } else {
-            #[cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)]
-            {
-                // SAFETY: `ptr` must have been allocated by Self::alloc thus a valid aligned
-                // glib-allocated pointer, so `g_aligned_free`ing is safe.
-                unsafe { g_aligned_free(ptr.cast::<_>()) }
-            }
-            #[cfg(not(HAVE_GLIB_WITH_ALIGNED_ALLOC))]
-            {
-                // SAFETY: `ptr` must have been allocated by Self::alloc thus a valid aligned
-                // glib-allocated pointer, so `qemu_vfree`ing is safe.
-                unsafe { qemu_vfree(ptr.cast::<_>()) }
-            }
-        }
-    }
-}
-- 
2.51.0


