Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF82C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 18:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkSDw-0006IB-0a; Tue, 18 Feb 2025 13:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkSDI-0005yy-Ad
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:21:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkSDG-0007aS-9a
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:20:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739902852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/OWHn8YVudrVjD30pFiw9gzLSOJXgZ2dezAHaj9jIKU=;
 b=GOCotALaDZ0BwpSYlRzV/eqGWiYbzfn2cgaq8nHSerNu9+ExwITsMG8GQud6AiMoYZFJSg
 FUgEp9GYo7g8Zjo/pfeGiaIA2fL65yqlqPzWp5UC1DF9xwJ8vJYIjacZmGUN55aisONG9/
 vx1TTrgJL1GhxnjkzU4U1mnuEmDc7lU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-u6Si5Hh1PAOtsAnuOkKAlA-1; Tue,
 18 Feb 2025 13:20:48 -0500
X-MC-Unique: u6Si5Hh1PAOtsAnuOkKAlA-1
X-Mimecast-MFC-AGG-ID: u6Si5Hh1PAOtsAnuOkKAlA_1739902847
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 040C71801A2F; Tue, 18 Feb 2025 18:20:47 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.226.66])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 544951800358; Tue, 18 Feb 2025 18:20:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: [PATCH v2 06/11] rust/block: Add I/O buffer traits
Date: Tue, 18 Feb 2025 19:20:14 +0100
Message-ID: <20250218182019.111467-7-kwolf@redhat.com>
In-Reply-To: <20250218182019.111467-1-kwolf@redhat.com>
References: <20250218182019.111467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Types that implement IoBuffer can be used with safe I/O functions.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 rust/block/src/iobuffer.rs | 94 ++++++++++++++++++++++++++++++++++++++
 rust/block/src/lib.rs      |  2 +
 2 files changed, 96 insertions(+)
 create mode 100644 rust/block/src/iobuffer.rs

diff --git a/rust/block/src/iobuffer.rs b/rust/block/src/iobuffer.rs
new file mode 100644
index 0000000000..d61370c961
--- /dev/null
+++ b/rust/block/src/iobuffer.rs
@@ -0,0 +1,94 @@
+// Copyright Red Hat Inc.
+// Author(s): Kevin Wolf <kwolf@redhat.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use std::mem::MaybeUninit;
+
+/// Types that implement IoBuffer can be used with safe I/O functions.
+///
+/// # Safety
+///
+/// `buffer_ptr()` and `buffer_mut_ptr()` must return pointers to the address of the same I/O
+/// buffer with the size returned by `buffer_len()` which remain valid for the lifetime of the
+/// object. It must be safe for the I/O buffer to contain any byte patterns.
+pub unsafe trait IoBuffer {
+    /// Returns a const pointer to be used as a raw I/O buffer
+    fn buffer_ptr(&self) -> *const u8;
+
+    /// Returns a mutable pointer to be used as a raw I/O buffer
+    fn buffer_mut_ptr(&mut self) -> *mut u8;
+
+    /// Returns the length in bytes for the raw I/O buffer returned by [`buffer_ptr`] and
+    /// [`buffer_mut_ptr`]
+    ///
+    /// [`buffer_ptr`]: IoBuffer::buffer_ptr
+    /// [`buffer_mut_ptr`]: IoBuffer::buffer_mut_ptr
+    fn buffer_len(&self) -> usize;
+}
+
+/// Implementing `SizedIoBuffer` provides an implementation for [`IoBuffer`] without having to
+/// implement any functions manually.
+///
+/// # Safety
+///
+/// Types implementing `SizedIoBuffer` guarantee that the whole object can be accessed as an I/O
+/// buffer that is safe to contain any byte patterns.
+pub unsafe trait SizedIoBuffer: Sized {
+    /// Safely converts a byte slice into a shared reference to the type implementing
+    /// `SizedIoBuffer`
+    fn from_byte_slice(buf: &[u8]) -> Option<&Self> {
+        if buf.len() < std::mem::size_of::<Self>() {
+            return None;
+        }
+
+        let ptr = buf.as_ptr() as *const Self;
+
+        // TODO Use ptr.is_aligned() when MSRV is updated to at least 1.79.0
+        if (ptr as usize) % std::mem::align_of::<Self>() != 0 {
+            return None;
+        }
+
+        // SAFETY: This function checked that the byte slice is large enough and aligned.
+        // Implementing SizedIoBuffer promises that any byte pattern is valid for the type.
+        Some(unsafe { &*ptr })
+    }
+}
+
+unsafe impl<T: SizedIoBuffer> IoBuffer for T {
+    fn buffer_ptr(&self) -> *const u8 {
+        self as *const Self as *const u8
+    }
+
+    fn buffer_mut_ptr(&mut self) -> *mut u8 {
+        self as *mut Self as *mut u8
+    }
+
+    fn buffer_len(&self) -> usize {
+        std::mem::size_of::<Self>()
+    }
+}
+
+unsafe impl<T: SizedIoBuffer> IoBuffer for [T] {
+    fn buffer_ptr(&self) -> *const u8 {
+        self.as_ptr() as *const u8
+    }
+
+    fn buffer_mut_ptr(&mut self) -> *mut u8 {
+        self.as_mut_ptr() as *mut u8
+    }
+
+    fn buffer_len(&self) -> usize {
+        std::mem::size_of_val(self)
+    }
+}
+
+unsafe impl<T: SizedIoBuffer> SizedIoBuffer for MaybeUninit<T> {}
+
+unsafe impl SizedIoBuffer for u8 {}
+unsafe impl SizedIoBuffer for u16 {}
+unsafe impl SizedIoBuffer for u32 {}
+unsafe impl SizedIoBuffer for u64 {}
+unsafe impl SizedIoBuffer for i8 {}
+unsafe impl SizedIoBuffer for i16 {}
+unsafe impl SizedIoBuffer for i32 {}
+unsafe impl SizedIoBuffer for i64 {}
diff --git a/rust/block/src/lib.rs b/rust/block/src/lib.rs
index 8b13789179..1c03549821 100644
--- a/rust/block/src/lib.rs
+++ b/rust/block/src/lib.rs
@@ -1 +1,3 @@
+mod iobuffer;
 
+pub use iobuffer::{IoBuffer, SizedIoBuffer};
-- 
2.48.1


