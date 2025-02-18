Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA968C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 18:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkSEt-0007Lg-FP; Tue, 18 Feb 2025 13:22:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkSDX-000645-5t
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:21:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkSDU-0007da-Nl
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739902868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qbJRLhkTHhbgND2eqUgNnvV/fnQHqoFQy8tGkOv51fc=;
 b=KDHzY5dwIVwOO6YRR+keyiES0s9kjr1LTCzt89bOoqz/U+rtJNS4ymkZ83Ou68vauEkKc7
 m0HxVm2U4CSZnSwfdN6pADlsk60gmaYRAtrM4iNKxQQ6mtPnyY7wWYlWadAxmXnU/Dz46B
 OM1wEiNoAr+oM2kR6YOZJwuZ2JP85xw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-8myATExoOACfc_2Jg-DQmA-1; Tue,
 18 Feb 2025 13:21:03 -0500
X-MC-Unique: 8myATExoOACfc_2Jg-DQmA-1
X-Mimecast-MFC-AGG-ID: 8myATExoOACfc_2Jg-DQmA_1739902862
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B14F196E078; Tue, 18 Feb 2025 18:21:02 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.226.66])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ACA2E180034D; Tue, 18 Feb 2025 18:20:59 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: [PATCH v2 11/11] rust/block: Add format probing
Date: Tue, 18 Feb 2025 19:20:19 +0100
Message-ID: <20250218182019.111467-12-kwolf@redhat.com>
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
index 9dd84446e1..b1247a6bd5 100644
--- a/rust/block/src/bochs.rs
+++ b/rust/block/src/bochs.rs
@@ -188,6 +188,26 @@ pub async fn new(file: BdrvChild) -> io::Result<Self> {
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
index baeaf47eda..1b132bc8de 100644
--- a/rust/block/src/driver.rs
+++ b/rust/block/src/driver.rs
@@ -7,7 +7,7 @@
 use qemu_api::errno::Errno;
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
 
@@ -161,6 +171,19 @@ pub async fn read_uninit<T: SizedIoBuffer>(
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


