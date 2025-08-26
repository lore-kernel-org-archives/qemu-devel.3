Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A795CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 14:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uquJ4-00064u-Uy; Tue, 26 Aug 2025 10:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uquIW-0005us-G5
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:05:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uquIM-0006n9-UA
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756217104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gpr5BEiJG98iqlxJYetB1UMIinIuIwew365BsOdINxM=;
 b=g8vkHSSDWfmkrOVUHPTXdtsEmsdyjkHTbxSXlIV6oIpmX6qOp5K7xK3axEQ5omUG722OlK
 F39MGu7cv08Q/+O/mBo1fX8FU6m092gU+/JMr3G0MKbrYpipN1hKqjg+zCZRsx+vFX6wJw
 eoKp1QJ3D/hgW6bfOlpu8yAjFhVZGfk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-AFI72CCXPVyTSklwcSoavQ-1; Tue,
 26 Aug 2025 10:05:01 -0400
X-MC-Unique: AFI72CCXPVyTSklwcSoavQ-1
X-Mimecast-MFC-AGG-ID: AFI72CCXPVyTSklwcSoavQ_1756217100
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C867E1956095; Tue, 26 Aug 2025 14:04:59 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7EAA81800280; Tue, 26 Aug 2025 14:04:57 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC 01/18] rust: remove unused global qemu "allocator"
Date: Tue, 26 Aug 2025 18:04:29 +0400
Message-ID: <20250826140449.4190022-2-marcandre.lureau@redhat.com>
In-Reply-To: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
References: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
---
 meson.build               |   4 --
 rust/Cargo.toml           |   2 +-
 rust/qemu-api/Cargo.toml  |   1 -
 rust/qemu-api/meson.build |   1 -
 rust/qemu-api/src/lib.rs  | 135 --------------------------------------
 5 files changed, 1 insertion(+), 142 deletions(-)

diff --git a/meson.build b/meson.build
index 50c774a195..ebbe9f8785 100644
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
index 0868e1b426..1a24859cd7 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -17,7 +17,7 @@ rust-version = "1.77.0"
 
 [workspace.lints.rust]
 unexpected_cfgs = { level = "deny", check-cfg = [
-    'cfg(MESON)', 'cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)',
+    'cfg(MESON)',
 ] }
 
 # Occasionally, we may need to silence warnings and clippy lints that
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index db7000dee4..603327945f 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -21,7 +21,6 @@ foreign = "~0.3.1"
 
 [features]
 default = ["debug_cell"]
-allocator = []
 debug_cell = []
 
 [lints]
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index a090297c45..062009f161 100644
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
index 86dcd8ef17..0f9231f398 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -32,139 +32,4 @@
 pub mod vmstate;
 pub mod zeroable;
 
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
2.50.1


