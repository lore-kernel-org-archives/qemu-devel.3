Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21404E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOByu-0007Gx-6c; Thu, 19 Dec 2024 03:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByr-00070x-Vt
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:34:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByq-0005I2-9L
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U+S3jYqRgwAQ1T9HC2IL/MfLkL7BjAjJkf+HWEFlTLA=;
 b=WypAOm3ZCnMOgXxtYJGzARGySAQao+5X2Xzmw6bg+rIXDlyVjQze4uqfzZZ2uy0KX04gC5
 JjUjRdOgfqqVqvD2Xkn6vlOoDTHt+4G223m/+NR1Kzn5FzoOnUrFzv8vuA9OQOMKvrTwIV
 xVnNfgIonJuwW6CF8FsDOxKitSd62Ps=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-at6QnB2jNGCoK7TnqPqeww-1; Thu, 19 Dec 2024 03:33:58 -0500
X-MC-Unique: at6QnB2jNGCoK7TnqPqeww-1
X-Mimecast-MFC-AGG-ID: at6QnB2jNGCoK7TnqPqeww
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4362f893bfaso2906595e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597236; x=1735202036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U+S3jYqRgwAQ1T9HC2IL/MfLkL7BjAjJkf+HWEFlTLA=;
 b=WHJmUxvV4VtVA6Kocsv+fMM/9WOR4yUY0tSOvYZoNE/bAqfCd2uP8BW6DEHnz3FCcD
 UASkpAH9aVGBeLqS60U41Bx2fsd+UhWxcy8M72D5QaIcB8oSJ9wIuIVb3rKWsxoD1Xj/
 VmdMe0TDIExWJCVRIQ549bhRIfsd2Rinrn8LlMts+tLeGXj7KaxU623BoD4NHENBntwh
 0iQ4TOfqFnG8UMdfZ/DtL4ubMGda2apIcLvj9bz6ClsKcN1KVulVOZlc1Dqy9xZ0pdnr
 /upeANIxBP3yfGb0uB2IjDUSkqaR5SpyBpiajPosaxlNCibdddPS/zRNi3Jh4Zq8/Lfn
 96XA==
X-Gm-Message-State: AOJu0Yx7edM837mzpE+RYyZy2eAM8ZPk436kptc5Wa3TeTZxE0fs6wcr
 w8pzdCbajgOwR7DPkFJKYXXGPURNSwGjNjbjRTVDM5LWgcEd9+bDZikTKcOd9hmfGJBMtGIUkZl
 JluV14aPSYtVck/ACZ97V2imPoj4zeByLXSkXLoUIHsCzX2SdCUaR03Q4ZRjvDuIGKQH1M8jpup
 WTBuPIilFLgYvinSscnD8C6QaDFtqvoiUSyPRU
X-Gm-Gg: ASbGncsz0wb8JJDEEmiD9qGCIVybAH71sYD8ls+/3tMdd2LZjburoQj5UL17OMTAkNe
 J13/1uXllD90Qj7b7/4zx/tro3v6hlUcoCzv9iyu4herrnAHN5n/BUcJHNoysMW7XR/3WtGPS99
 GHZgo1qMgVfq4CkkpQsHhrjCe8l4ULWdk8NeUxJWcFjGTmDvci0MruHpJ8E7NPu6DjfLtxcSd4f
 gPw1FWNuCycTSz+m7ML/1ZkC41dd5zRA4GRk5MUp+qFz9SE2QiBp/nR56iA
X-Received: by 2002:a5d:64ad:0:b0:386:4a0d:bb21 with SMTP id
 ffacd0b85a97d-388e4d65d0dmr4627776f8f.22.1734597236252; 
 Thu, 19 Dec 2024 00:33:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFM1AtXbKz73wxXgesHASBpqMGQ97i3i/Tbv+mU2IvhyozYT/k0oF9ppraZFqb8AJLAu1v3/A==
X-Received: by 2002:a5d:64ad:0:b0:386:4a0d:bb21 with SMTP id
 ffacd0b85a97d-388e4d65d0dmr4627746f8f.22.1734597235793; 
 Thu, 19 Dec 2024 00:33:55 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c493sm10990055e9.28.2024.12.19.00.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 40/41] rust: pl011: fix migration stream
Date: Thu, 19 Dec 2024 09:32:27 +0100
Message-ID: <20241219083228.363430-41-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The Rust vmstate macros lack the type-safety of their C equivalents (so
safe, much abstraction), and therefore they were predictably wrong.

The registers have already been changed to 32-bits in the previous patch,
but read_pos/read_count/read_trigger also have to be u32 instead of usize.
The easiest way to do so is to let the FIFO use u32 indices instead
of usize.

My plan for making VMStateField typesafe is to have a trait to retrieve
a basic VMStateField; for example something like vmstate_uint32 would
become an implementation of the VMState trait on u32.  Then you'd write
something like "vmstate_of!(Type, field).with_version_id(2)".  That is,
vmstate_of retrieves the basic VMStateField and fills in the offset,
and then more changes can be applied on top.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs       | 38 ++++++++++++++++++++++----
 rust/hw/char/pl011/src/device_class.rs | 10 +++----
 rust/qemu-api/src/vmstate.rs           | 22 ---------------
 3 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 090e5d64504..4d620b442ed 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -31,7 +31,7 @@
 const FBRD_MASK: u32 = 0x3f;
 
 /// QEMU sourced constant.
-pub const PL011_FIFO_DEPTH: usize = 16_usize;
+pub const PL011_FIFO_DEPTH: u32 = 16;
 
 #[derive(Clone, Copy, Debug)]
 enum DeviceId {
@@ -56,6 +56,32 @@ impl DeviceId {
     const PL011_ID_LUMINARY: [c_uchar; 8] = [0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1];
 }
 
+// FIFOs use 32-bit indices instead of usize, for compatibility with
+// the migration stream produced by the C version of this device.
+#[repr(transparent)]
+#[derive(Debug, Default)]
+pub struct Fifo([registers::Data; PL011_FIFO_DEPTH as usize]);
+
+impl Fifo {
+    const fn len(&self) -> u32 {
+        self.0.len() as u32
+    }
+}
+
+impl std::ops::IndexMut<u32> for Fifo {
+    fn index_mut(&mut self, idx: u32) -> &mut Self::Output {
+        &mut self.0[idx as usize]
+    }
+}
+
+impl std::ops::Index<u32> for Fifo {
+    type Output = registers::Data;
+
+    fn index(&self, idx: u32) -> &Self::Output {
+        &self.0[idx as usize]
+    }
+}
+
 #[repr(C)]
 #[derive(Debug, qemu_api_macros::Object, qemu_api_macros::offsets)]
 /// PL011 Device Model in QEMU
@@ -73,14 +99,14 @@ pub struct PL011State {
     pub dmacr: u32,
     pub int_enabled: u32,
     pub int_level: u32,
-    pub read_fifo: [registers::Data; PL011_FIFO_DEPTH],
+    pub read_fifo: Fifo,
     pub ilpr: u32,
     pub ibrd: u32,
     pub fbrd: u32,
     pub ifl: u32,
-    pub read_pos: usize,
-    pub read_count: usize,
-    pub read_trigger: usize,
+    pub read_pos: u32,
+    pub read_count: u32,
+    pub read_trigger: u32,
     #[doc(alias = "chr")]
     pub char_backend: CharBackend,
     /// QEMU interrupts
@@ -480,7 +506,7 @@ pub fn loopback_enabled(&self) -> bool {
     }
 
     #[inline]
-    pub fn fifo_depth(&self) -> usize {
+    pub fn fifo_depth(&self) -> u32 {
         // Note: FIFO depth is expected to be power-of-2
         if self.fifo_enabled() {
             return PL011_FIFO_DEPTH;
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index 975c3d42be7..7f3ca895071 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -6,8 +6,8 @@
 use std::os::raw::{c_int, c_void};
 
 use qemu_api::{
-    bindings::*, c_str, vmstate_clock, vmstate_fields, vmstate_int32, vmstate_subsections,
-    vmstate_uint32, vmstate_uint32_array, vmstate_unused, zeroable::Zeroable,
+    bindings::*, c_str, vmstate_clock, vmstate_fields, vmstate_subsections, vmstate_uint32,
+    vmstate_uint32_array, vmstate_unused, zeroable::Zeroable,
 };
 
 use crate::device::{PL011State, PL011_FIFO_DEPTH};
@@ -64,9 +64,9 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
         vmstate_uint32!(ibrd, PL011State),
         vmstate_uint32!(fbrd, PL011State),
         vmstate_uint32!(ifl, PL011State),
-        vmstate_int32!(read_pos, PL011State),
-        vmstate_int32!(read_count, PL011State),
-        vmstate_int32!(read_trigger, PL011State),
+        vmstate_uint32!(read_pos, PL011State),
+        vmstate_uint32!(read_count, PL011State),
+        vmstate_uint32!(read_trigger, PL011State),
     },
     subsections: vmstate_subsections! {
         VMSTATE_PL011_CLOCK
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 25c68b703ea..63c897abcdf 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -106,28 +106,6 @@ macro_rules! vmstate_uint32 {
     }};
 }
 
-#[doc(alias = "VMSTATE_INT32_V")]
-#[macro_export]
-macro_rules! vmstate_int32_v {
-    ($field_name:ident, $struct_name:ty, $version_id:expr) => {{
-        $crate::vmstate_single!(
-            $field_name,
-            $struct_name,
-            $version_id,
-            ::core::ptr::addr_of!($crate::bindings::vmstate_info_int32),
-            ::core::mem::size_of::<i32>()
-        )
-    }};
-}
-
-#[doc(alias = "VMSTATE_INT32")]
-#[macro_export]
-macro_rules! vmstate_int32 {
-    ($field_name:ident, $struct_name:ty) => {{
-        $crate::vmstate_int32_v!($field_name, $struct_name, 0)
-    }};
-}
-
 #[doc(alias = "VMSTATE_ARRAY")]
 #[macro_export]
 macro_rules! vmstate_array {
-- 
2.47.1


