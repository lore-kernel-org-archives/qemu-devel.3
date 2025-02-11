Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30118C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 21:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thy6N-0002jT-I2; Tue, 11 Feb 2025 16:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thy3k-00089E-Fe
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:44:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thy3g-0005aB-WB
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739310282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EQGiwTCHjvG0hJog8XC9+JXJepkNrNsdabgIXvuqv1g=;
 b=PvLOIBdLWjoDHdM5okSlkNVlwZW05oHMRXaTZf4ihkzul+hpizJoZlayIPcW3ZW0KozDN9
 qG570BBZDl77ccCm/ocOv5GDgfBPVFbQ9XAA42W1ujZNlk7FKsswNoyoh4mYH3EVOcjBRl
 CZPKsjE7YacJSmlOnX2ZiTB1QqyqJv8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-vZ7AGSsxMHCCLTBQoS_rVw-1; Tue,
 11 Feb 2025 16:44:39 -0500
X-MC-Unique: vZ7AGSsxMHCCLTBQoS_rVw-1
X-Mimecast-MFC-AGG-ID: vZ7AGSsxMHCCLTBQoS_rVw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A80A19560A7; Tue, 11 Feb 2025 21:44:38 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.210])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B89E195608D; Tue, 11 Feb 2025 21:44:35 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: [PATCH 11/11] rust/block: Add format probing
Date: Tue, 11 Feb 2025 22:43:28 +0100
Message-ID: <20250211214328.640374-12-kwolf@redhat.com>
In-Reply-To: <20250211214328.640374-1-kwolf@redhat.com>
References: <20250211214328.640374-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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

This adds format probing both to the BlockDriver trait and the bochs-rs
block driver. With this, bochs-rs achieves feature parity with its C
counterpart. Its probe function returns a higher priority so that it is
preferred when both drivers are available.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 rust/block/src/bochs.rs  | 20 ++++++++++++++++++++
 rust/block/src/driver.rs | 26 +++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/rust/block/src/bochs.rs b/rust/block/src/bochs.rs
index 388ac5ef03..bccc55ead9 100644
--- a/rust/block/src/bochs.rs
+++ b/rust/block/src/bochs.rs
@@ -186,6 +186,26 @@ pub async fn new(file: BdrvChild) -> io::Result<Self> {
 impl BlockDriver for BochsImage {
     type Options = bindings::BlockdevOptionsGenericFormat;
 
+    fn probe(buf: &[u8], _filename: &str) -> u16 {
+        let header = match BochsHeader::from_byte_slice(buf) {
+            Some(header) => header,
+            None => return 0,
+        };
+
+        if header.magic != HEADER_MAGIC
+            || header.imgtype != HEADER_TYPE_REDOLOG
+            || header.subtype != HEADER_SUBTYPE_GROWING
+        {
+            return 0;
+        }
+
+        // This driver is better than the C one which returns 100, give it priority
+        match header.version {
+            HEADER_VERSION | HEADER_V1 => 200,
+            _ => 0,
+        }
+    }
+
     unsafe fn parse_options(
         v: &mut bindings::Visitor,
         opts: &mut *mut Self::Options,
diff --git a/rust/block/src/driver.rs b/rust/block/src/driver.rs
index 740e9266aa..727d13b751 100644
--- a/rust/block/src/driver.rs
+++ b/rust/block/src/driver.rs
@@ -6,7 +6,7 @@
 use qemu_api::bindings;
 use qemu_api::futures::qemu_co_run_future;
 use std::cmp::min;
-use std::ffi::c_void;
+use std::ffi::{c_void, CStr};
 use std::io::{self, Error, ErrorKind};
 use std::mem::MaybeUninit;
 use std::ptr;
@@ -65,6 +65,16 @@ unsafe fn open(
         errp: *mut *mut bindings::Error,
     ) -> std::os::raw::c_int;
 
+    /// Returns the image format probing priority of this block driver for disk images starting
+    /// with the byte sequence in `buf`. Probing selects the driver that returns the highest
+    /// number.
+    ///
+    /// If the driver doesn't support images starting with `buf`, 0 is returned.
+    fn probe(buf: &[u8], filename: &str) -> u16 {
+        let _ = (buf, filename);
+        0
+    }
+
     /// Returns the size of the image in bytes
     fn size(&self) -> u64;
 
@@ -156,6 +166,19 @@ pub async fn read_uninit<T: SizedIoBuffer>(
     }
 }
 
+#[doc(hidden)]
+pub unsafe extern "C" fn bdrv_probe<D: BlockDriver>(
+    buf: *const u8,
+    buf_size: std::os::raw::c_int,
+    filename: *const std::os::raw::c_char,
+) -> std::os::raw::c_int {
+    let buf = unsafe { std::slice::from_raw_parts(buf, buf_size as usize) };
+    match unsafe { CStr::from_ptr(filename) }.to_str() {
+        Ok(filename) => D::probe(buf, filename).into(),
+        Err(_) => 0,
+    }
+}
+
 #[doc(hidden)]
 pub unsafe extern "C" fn bdrv_open<D: BlockDriver>(
     bs: *mut bindings::BlockDriverState,
@@ -266,6 +289,7 @@ macro_rules! block_driver {
                 ::qemu_api::bindings::BlockDriver {
                     format_name: ::qemu_api::c_str!($fmtname).as_ptr(),
                     instance_size: ::std::mem::size_of::<$typ>() as i32,
+                    bdrv_probe: Some($crate::driver::bdrv_probe::<$typ>),
                     bdrv_open: Some($crate::driver::bdrv_open::<$typ>),
                     bdrv_close: Some($crate::driver::bdrv_close::<$typ>),
                     bdrv_co_preadv_part: Some($crate::driver::bdrv_co_preadv_part::<$typ>),
-- 
2.48.1


