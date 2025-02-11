Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC020C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 21:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thy56-0000iO-Hs; Tue, 11 Feb 2025 16:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thy3b-00082c-Vi
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:44:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thy3Z-0005PF-F1
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739310274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fv2Uo09WYcGphLTGQEV2WMtzqcDmBt/d8fau8kl6t7w=;
 b=CrDYeDvwhgt2pfv65Arpz6ilh9xquom7B0kON32ZtMhihH/uMPPGa1VhXGkNepMqhWYdpy
 xhlw9zKjP2X0i0A90pgP1zDcFWB4TmoHfenXnbSI+Q/rV9Q4zr6b3RmBVH/wYcZHVwv22Y
 ifzuOMzSIGH0P79Oa7swSu1n6deUMdY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-Ig6yLRrxN2yyTbjmMdhOoQ-1; Tue,
 11 Feb 2025 16:44:31 -0500
X-MC-Unique: Ig6yLRrxN2yyTbjmMdhOoQ-1
X-Mimecast-MFC-AGG-ID: Ig6yLRrxN2yyTbjmMdhOoQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6CEC195609D; Tue, 11 Feb 2025 21:44:29 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.210])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 93274195608D; Tue, 11 Feb 2025 21:44:27 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: [PATCH 08/11] rust/block: Add driver module
Date: Tue, 11 Feb 2025 22:43:25 +0100
Message-ID: <20250211214328.640374-9-kwolf@redhat.com>
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

This adds a barebones module for a block driver interface. Because there
is no native QAPI support for Rust yet, opening images takes a few
unsafe functions to call into C visitor functions. This should be
cleaned up later.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 rust/block/src/driver.rs | 190 +++++++++++++++++++++++++++++++++++++++
 rust/block/src/lib.rs    |   1 +
 2 files changed, 191 insertions(+)
 create mode 100644 rust/block/src/driver.rs

diff --git a/rust/block/src/driver.rs b/rust/block/src/driver.rs
new file mode 100644
index 0000000000..5c7c46bfa0
--- /dev/null
+++ b/rust/block/src/driver.rs
@@ -0,0 +1,190 @@
+// Copyright Red Hat Inc.
+// Author(s): Kevin Wolf <kwolf@redhat.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+// All of this is unused until the first block driver is added
+#![allow(dead_code)]
+#![allow(unused_macros)]
+#![allow(unused_imports)]
+
+use crate::{IoBuffer, SizedIoBuffer};
+use qemu_api::bindings;
+use std::ffi::c_void;
+use std::io::{self, Error, ErrorKind};
+use std::mem::MaybeUninit;
+use std::ptr;
+
+/// A trait for writing block drivers.
+///
+/// Types that implement this trait can be registered as QEMU block drivers using the
+/// [`block_driver`] macro.
+pub trait BlockDriver {
+    /// The type that contains the block driver specific options for opening an image
+    type Options;
+
+    // TODO Native support for QAPI types and deserialization
+    unsafe fn parse_options(
+        v: &mut bindings::Visitor,
+        opts: &mut *mut Self::Options,
+        errp: *mut *mut bindings::Error,
+    );
+    unsafe fn free_options(opts: *mut Self::Options);
+    unsafe fn open(
+        bs: *mut bindings::BlockDriverState,
+        opts: &Self::Options,
+        errp: *mut *mut bindings::Error,
+    ) -> std::os::raw::c_int;
+
+    /// Returns the size of the image in bytes
+    fn size(&self) -> u64;
+}
+
+/// Represents the connection between a parent and its child node.
+///
+/// This is a wrapper around the `BdrvChild` type in C.
+pub struct BdrvChild {
+    child: *mut bindings::BdrvChild,
+}
+
+impl BdrvChild {
+    /// Creates a new child reference from a `BlockdevRef`.
+    pub unsafe fn new(
+        parent: *mut bindings::BlockDriverState,
+        bref: *mut bindings::BlockdevRef,
+        errp: *mut *mut bindings::Error,
+    ) -> Option<Self> {
+        unsafe {
+            let child_bs = bindings::bdrv_open_blockdev_ref_file(bref, parent, errp);
+            if child_bs.is_null() {
+                return None;
+            }
+
+            bindings::bdrv_graph_wrlock();
+            let child = bindings::bdrv_attach_child(
+                parent,
+                child_bs,
+                c"file".as_ptr(),
+                &bindings::child_of_bds as *const _,
+                bindings::BDRV_CHILD_IMAGE,
+                errp,
+            );
+            bindings::bdrv_graph_wrunlock();
+
+            if child.is_null() {
+                None
+            } else {
+                Some(BdrvChild { child })
+            }
+        }
+    }
+
+    /// Reads data from the child node into a linear byte buffer.
+    ///
+    /// # Safety
+    ///
+    /// `buf` must be a valid I/O buffer that can store at least `bytes` bytes.
+    pub async unsafe fn read_raw(&self, offset: u64, bytes: usize, buf: *mut u8) -> io::Result<()> {
+        let offset: i64 = offset
+            .try_into()
+            .map_err(|e| Error::new(ErrorKind::InvalidInput, e))?;
+        let bytes: i64 = bytes
+            .try_into()
+            .map_err(|e| Error::new(ErrorKind::InvalidInput, e))?;
+
+        let ret = unsafe { bindings::bdrv_pread(self.child, offset, bytes, buf as *mut c_void, 0) };
+        if ret < 0 {
+            Err(Error::from_raw_os_error(ret))
+        } else {
+            Ok(())
+        }
+    }
+
+    /// Reads data from the child node into a linear typed buffer.
+    pub async fn read<T: IoBuffer + ?Sized>(&self, offset: u64, buf: &mut T) -> io::Result<()> {
+        unsafe {
+            self.read_raw(offset, buf.buffer_len(), buf.buffer_mut_ptr())
+                .await
+        }
+    }
+
+    /// Reads data from the child node into a linear, potentially uninitialised typed buffer.
+    pub async fn read_uninit<T: SizedIoBuffer>(
+        &self,
+        offset: u64,
+        mut buf: MaybeUninit<T>,
+    ) -> io::Result<T> {
+        unsafe {
+            self.read_raw(offset, buf.buffer_len(), buf.buffer_mut_ptr())
+                .await?;
+            Ok(buf.assume_init())
+        }
+    }
+}
+
+#[doc(hidden)]
+pub unsafe extern "C" fn bdrv_open<D: BlockDriver>(
+    bs: *mut bindings::BlockDriverState,
+    options: *mut bindings::QDict,
+    _flags: std::os::raw::c_int,
+    errp: *mut *mut bindings::Error,
+) -> std::os::raw::c_int {
+    unsafe {
+        let v = match bindings::qobject_input_visitor_new_flat_confused(options, errp).as_mut() {
+            None => return -(bindings::EINVAL as std::os::raw::c_int),
+            Some(v) => v,
+        };
+
+        let mut opts: *mut D::Options = ptr::null_mut();
+        D::parse_options(v, &mut opts, errp);
+        bindings::visit_free(v);
+
+        let opts = match opts.as_mut() {
+            None => return -(bindings::EINVAL as std::os::raw::c_int),
+            Some(opts) => opts,
+        };
+
+        while let Some(e) = bindings::qdict_first(options).as_ref() {
+            bindings::qdict_del(options, e.key);
+        }
+
+        let ret = D::open(bs, opts, errp);
+        D::free_options(opts);
+        ret
+    }
+}
+
+#[doc(hidden)]
+pub unsafe extern "C" fn bdrv_close<D: BlockDriver>(bs: *mut bindings::BlockDriverState) {
+    unsafe {
+        let state = (*bs).opaque as *mut D;
+        ptr::drop_in_place(state);
+    }
+}
+
+/// Declare a format block driver. This macro is meant to be used at the top level.
+///
+/// `typ` is a type implementing the [`BlockDriver`] trait to handle the image format with the
+/// user-visible name `fmtname`.
+macro_rules! block_driver {
+    ($fmtname:expr, $typ:ty) => {
+        const _: () = {
+            static mut BLOCK_DRIVER: ::qemu_api::bindings::BlockDriver =
+                ::qemu_api::bindings::BlockDriver {
+                    format_name: ::qemu_api::c_str!($fmtname).as_ptr(),
+                    instance_size: ::std::mem::size_of::<$typ>() as i32,
+                    bdrv_open: Some($crate::driver::bdrv_open::<$typ>),
+                    bdrv_close: Some($crate::driver::bdrv_close::<$typ>),
+                    bdrv_child_perm: Some(::qemu_api::bindings::bdrv_default_perms),
+                    is_format: true,
+                    ..::qemu_api::zeroable::Zeroable::ZERO
+                };
+
+            qemu_api::module_init! {
+                MODULE_INIT_BLOCK => unsafe {
+                    ::qemu_api::bindings::bdrv_register(std::ptr::addr_of_mut!(BLOCK_DRIVER));
+                }
+            }
+        };
+    };
+}
+pub(crate) use block_driver;
diff --git a/rust/block/src/lib.rs b/rust/block/src/lib.rs
index 1c03549821..54ebd480ec 100644
--- a/rust/block/src/lib.rs
+++ b/rust/block/src/lib.rs
@@ -1,3 +1,4 @@
+mod driver;
 mod iobuffer;
 
 pub use iobuffer::{IoBuffer, SizedIoBuffer};
-- 
2.48.1


