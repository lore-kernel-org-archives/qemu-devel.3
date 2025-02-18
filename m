Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2B9C021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 18:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkSF0-00082w-Fp; Tue, 18 Feb 2025 13:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkSDU-00061I-Jf
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:21:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkSDQ-0007ct-Jw
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739902863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HYDBdvCCLCh/3DzHHIYPWhxjAV2dOJsE37N1HZlYDI4=;
 b=DFB3VrirOquXhEAuDLUaSD+AZkpyhLI8825bK3k1ktO9ngrczvMmjYL3Rz3GIlYrvvbzq9
 cLgc1pVd3cAF9+gX+F7X679wWQcZrA8Qnp6HSMVHWQNuIzRrEO2m3N85ONBJcQM2lCq3J1
 KLeQVxdCAXlXqyUrZS//Kb4oe5WPCIU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-RyapdECdMxuCXuX1ca_2mQ-1; Tue,
 18 Feb 2025 13:21:00 -0500
X-MC-Unique: RyapdECdMxuCXuX1ca_2mQ-1
X-Mimecast-MFC-AGG-ID: RyapdECdMxuCXuX1ca_2mQ_1739902859
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 358B81800872; Tue, 18 Feb 2025 18:20:59 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.226.66])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AAA0A1800358; Tue, 18 Feb 2025 18:20:56 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: [PATCH v2 10/11] bochs-rs: Add bochs block driver reimplementation in
 Rust
Date: Tue, 18 Feb 2025 19:20:18 +0100
Message-ID: <20250218182019.111467-11-kwolf@redhat.com>
In-Reply-To: <20250218182019.111467-1-kwolf@redhat.com>
References: <20250218182019.111467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This adds a separate block driver for the bochs image format called
'bochs-rs' so that for the moment both the C implementation and the Rust
implementation can be present in the same build. The intention is to
remove the C implementation eventually and rename this one into 'bochs'.
This can only happen once Rust can be a hard build dependency for QEMU.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 rust/block/Cargo.toml    |   2 +-
 rust/block/src/bochs.rs  | 297 +++++++++++++++++++++++++++++++++++++++
 rust/block/src/driver.rs |   5 -
 rust/block/src/lib.rs    |   1 +
 4 files changed, 299 insertions(+), 6 deletions(-)
 create mode 100644 rust/block/src/bochs.rs

diff --git a/rust/block/Cargo.toml b/rust/block/Cargo.toml
index fbc2f2d6ef..b91483aed1 100644
--- a/rust/block/Cargo.toml
+++ b/rust/block/Cargo.toml
@@ -3,7 +3,7 @@ name = "block"
 version = "0.1.0"
 edition = "2021"
 authors = ["Kevin Wolf <kwolf@redhat.com>"]
-license = "GPL-2.0-or-later"
+license = "GPL-2.0-or-later AND MIT"
 readme = "README.md"
 description = "Block backends for QEMU"
 repository = "https://gitlab.com/qemu-project/qemu/"
diff --git a/rust/block/src/bochs.rs b/rust/block/src/bochs.rs
new file mode 100644
index 0000000000..9dd84446e1
--- /dev/null
+++ b/rust/block/src/bochs.rs
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Block driver for the various disk image formats used by Bochs
+ * Currently only for "growing" type in read-only mode
+ *
+ * Copyright (c) 2005 Alex Beregszaszi
+ * Copyright (c) 2024 Red Hat
+ *
+ * Authors:
+ *   Alex Beregszaszi
+ *   Kevin Wolf <kwolf@redhat.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+use crate::driver::{block_driver, BdrvChild, BlockDriver, Mapping, MappingTarget, Request};
+use crate::SizedIoBuffer;
+use qemu_api::bindings;
+use qemu_api::errno::Errno;
+use qemu_api::futures::qemu_run_future;
+use std::cmp::min;
+use std::io::{self, Error, ErrorKind};
+use std::mem::MaybeUninit;
+use std::ptr;
+use std::sync::Arc;
+
+const BDRV_SECTOR_SIZE: u64 = 512;
+
+const HEADER_MAGIC: [u8; 32] = *b"Bochs Virtual HD Image\0\0\0\0\0\0\0\0\0\0";
+const HEADER_VERSION: u32 = 0x00020000;
+const HEADER_V1: u32 = 0x00010000;
+const HEADER_SIZE: usize = 512;
+
+const HEADER_TYPE_REDOLOG: [u8; 16] = *b"Redolog\0\0\0\0\0\0\0\0\0";
+const HEADER_SUBTYPE_GROWING: [u8; 16] = *b"Growing\0\0\0\0\0\0\0\0\0";
+
+// TODO Use u64.div_ceil() when MSRV is updated to at least 1.73.0
+fn div_ceil(a: u64, b: u64) -> u64 {
+    (a + b - 1) / b
+}
+
+// TODO Use little endian enforcing type for integers
+
+#[repr(C, packed)]
+struct BochsHeader {
+    pub magic: [u8; 32],
+    pub imgtype: [u8; 16],
+    pub subtype: [u8; 16],
+    pub version: u32,
+    pub header_size: u32,
+    pub catalog_entries: u32,
+    pub bitmap_size: u32,
+    pub extent_size: u32,
+    pub extra: BochsHeaderExtra,
+}
+unsafe impl SizedIoBuffer for BochsHeader {}
+
+#[repr(C, packed)]
+union BochsHeaderExtra {
+    v2: BochsHeaderExtraRedolog,
+    v1: BochsHeaderExtraRedologV1,
+    padding: [u8; HEADER_SIZE - 84],
+}
+
+#[repr(C, packed)]
+#[derive(Clone, Copy)]
+struct BochsHeaderExtraRedolog {
+    pub timestamp: u32,
+    pub disk_size: u64,
+}
+
+#[repr(C, packed)]
+#[derive(Clone, Copy)]
+struct BochsHeaderExtraRedologV1 {
+    pub disk_size: u64,
+}
+
+pub struct BochsImage {
+    file: Arc<BdrvChild>,
+    size: u64,
+    data_offset: u64,
+    bitmap_blocks: u64,
+    extent_size: u64,
+    extent_blocks: u64,
+    catalog_bitmap: Vec<u32>, // TODO Rename
+}
+
+impl BochsImage {
+    pub async fn new(file: BdrvChild) -> io::Result<Self> {
+        let header = file
+            .read_uninit(0, Box::new(MaybeUninit::<BochsHeader>::uninit()))
+            .await?;
+
+        if header.magic != HEADER_MAGIC
+            || header.imgtype != HEADER_TYPE_REDOLOG
+            || header.subtype != HEADER_SUBTYPE_GROWING
+        {
+            return Err(Error::new(
+                ErrorKind::InvalidInput,
+                "Image not in Bochs format",
+            ));
+        }
+
+        let size = match u32::from_le(header.version) {
+            HEADER_VERSION => unsafe { header.extra.v2.disk_size.to_le() },
+            HEADER_V1 => unsafe { header.extra.v1.disk_size.to_le() },
+            _ => return Err(Error::new(ErrorKind::InvalidInput, "Version not supported")),
+        };
+
+        let header_size: u64 = header.header_size.to_le().into();
+        let extent_size: u64 = header.extent_size.to_le().into();
+
+        if extent_size < BDRV_SECTOR_SIZE {
+            // bximage actually never creates extents smaller than 4k
+            return Err(Error::new(
+                ErrorKind::InvalidInput,
+                "Extent size must be at least 512",
+            ));
+        } else if !extent_size.is_power_of_two() {
+            return Err(Error::new(
+                ErrorKind::InvalidInput,
+                format!("Extent size {extent_size} is not a power of two"),
+            ));
+        } else if extent_size > 0x800000 {
+            return Err(Error::new(
+                ErrorKind::InvalidInput,
+                format!("Extent size {extent_size} is too large"),
+            ));
+        }
+
+        // Limit to 1M entries to avoid unbounded allocation. This is what is
+        // needed for the largest image that bximage can create (~8 TB).
+        let catalog_entries: usize = header
+            .catalog_entries
+            .to_le()
+            .try_into()
+            .map_err(|e| Error::new(ErrorKind::InvalidInput, e))?;
+        if catalog_entries > 0x100000 {
+            return Err(Error::new(ErrorKind::Other, "Catalog size is too large"));
+        } else if (catalog_entries as u64) < div_ceil(size, extent_size) {
+            return Err(Error::new(
+                ErrorKind::InvalidInput,
+                "Catalog size is too small for this disk size",
+            ));
+        }
+
+        // FIXME This was g_try_malloc() in C
+        let mut catalog_bitmap = vec![0u32; catalog_entries];
+        file.read(header_size, catalog_bitmap.as_mut_slice())
+            .await?;
+
+        for entry in &mut catalog_bitmap {
+            *entry = entry.to_le();
+        }
+
+        let data_offset = header_size + (catalog_entries as u64 * 4);
+        let bitmap_blocks = (1 + (header.bitmap_size.to_le() - 1) / 512).into();
+        let extent_blocks = 1 + (extent_size - 1) / 512;
+
+        Ok(Self {
+            file: Arc::new(file),
+            size,
+            data_offset,
+            bitmap_blocks,
+            extent_size,
+            extent_blocks,
+            catalog_bitmap,
+        })
+    }
+}
+
+impl BlockDriver for BochsImage {
+    type Options = bindings::BlockdevOptionsGenericFormat;
+
+    unsafe fn parse_options(
+        v: &mut bindings::Visitor,
+        opts: &mut *mut Self::Options,
+        errp: *mut *mut bindings::Error,
+    ) {
+        unsafe {
+            bindings::visit_type_BlockdevOptionsGenericFormat(v, ptr::null(), opts as *mut _, errp);
+        }
+    }
+
+    unsafe fn free_options(opts: *mut Self::Options) {
+        unsafe {
+            bindings::qapi_free_BlockdevOptionsGenericFormat(opts);
+        }
+    }
+
+    unsafe fn open(
+        bs: *mut bindings::BlockDriverState,
+        opts: &Self::Options,
+        errp: *mut *mut bindings::Error,
+    ) -> std::os::raw::c_int {
+        let file_child;
+        unsafe {
+            /* No write support yet */
+            bindings::bdrv_graph_rdlock_main_loop();
+            let ret = bindings::bdrv_apply_auto_read_only(bs, ptr::null(), errp);
+            bindings::bdrv_graph_rdunlock_main_loop();
+            if ret < 0 {
+                return ret;
+            }
+
+            file_child = match BdrvChild::new(bs, opts.file, errp) {
+                Some(c) => c,
+                None => return -libc::EINVAL,
+            };
+        }
+
+        qemu_run_future(async {
+            match BochsImage::new(file_child).await {
+                Ok(bdrv) => unsafe {
+                    (*bs).total_sectors =
+                        div_ceil(bdrv.size(), BDRV_SECTOR_SIZE).try_into().unwrap();
+                    let state = (*bs).opaque as *mut BochsImage;
+                    state.write(bdrv);
+                    0
+                },
+                Err(e) => -i32::from(Errno::from(e).0),
+            }
+        })
+    }
+
+    fn size(&self) -> u64 {
+        self.size
+    }
+
+    async fn map(&self, req: &Request) -> io::Result<Mapping> {
+        let (offset, len) = match *req {
+            Request::Read { offset, len } => (offset, len),
+        };
+
+        let extent_index: usize = (offset / self.extent_size).try_into().unwrap();
+        let extent_offset = (offset % self.extent_size) / 512;
+
+        if self.catalog_bitmap[extent_index] == 0xffffffff {
+            return Ok(Mapping {
+                offset: (extent_index as u64) * self.extent_size,
+                len: self.extent_size,
+                target: MappingTarget::Unmapped,
+            });
+        }
+
+        let bitmap_offset = self.data_offset
+            + (512
+                * (self.catalog_bitmap[extent_index] as u64)
+                * (self.extent_blocks + self.bitmap_blocks));
+
+        // Read in bitmap for current extent
+        // TODO This should be cached
+        let mut bitmap_entry = 0x8;
+        self.file
+            .read(bitmap_offset + (extent_offset / 8), &mut bitmap_entry)
+            .await?;
+
+        // We checked only a single sector
+        let offset = offset & !511;
+        let len = min(len, 512);
+
+        if (bitmap_entry >> (extent_offset % 8)) & 1 == 0 {
+            return Ok(Mapping {
+                offset,
+                len,
+                target: MappingTarget::Unmapped,
+            });
+        }
+
+        Ok(Mapping {
+            offset,
+            len,
+            target: MappingTarget::Data {
+                node: self.file.clone(),
+                offset: bitmap_offset + (512 * (self.bitmap_blocks + extent_offset)),
+            },
+        })
+    }
+}
+
+block_driver!("bochs-rs", BochsImage);
diff --git a/rust/block/src/driver.rs b/rust/block/src/driver.rs
index 022d50ffbc..baeaf47eda 100644
--- a/rust/block/src/driver.rs
+++ b/rust/block/src/driver.rs
@@ -2,11 +2,6 @@
 // Author(s): Kevin Wolf <kwolf@redhat.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-// All of this is unused until the first block driver is added
-#![allow(dead_code)]
-#![allow(unused_macros)]
-#![allow(unused_imports)]
-
 use crate::{IoBuffer, SizedIoBuffer};
 use qemu_api::bindings;
 use qemu_api::errno::Errno;
diff --git a/rust/block/src/lib.rs b/rust/block/src/lib.rs
index 54ebd480ec..ff528609bc 100644
--- a/rust/block/src/lib.rs
+++ b/rust/block/src/lib.rs
@@ -1,3 +1,4 @@
+mod bochs;
 mod driver;
 mod iobuffer;
 
-- 
2.48.1


