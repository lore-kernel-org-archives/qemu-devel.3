Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8776C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhFo-0006BP-TN; Fri, 21 Mar 2025 14:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEo-0003Le-LI
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEm-00077J-Fk
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z4A4b9/OXiyaSRX/qk8oeDehU/YXPK8pcQSTIn5TX0I=;
 b=CrcWKop4EPIa1EmlUvDmvvKY16AIdZlh/1qAGIC58amwGYzUBky9KcHP9L1qAwwLa+toQz
 w0AnmhWPT5f1LGmUUkjJEruR8HuNvg+ALtTDyjgiEwLJihCzxytgCpuInYCvevs+zhYb65
 RiV44OE1YKCrsxbGOsSVIsKr4HAjHKI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-e-iGnkIvM-WG5W8T6LuiMQ-1; Fri, 21 Mar 2025 14:36:54 -0400
X-MC-Unique: e-iGnkIvM-WG5W8T6LuiMQ-1
X-Mimecast-MFC-AGG-ID: e-iGnkIvM-WG5W8T6LuiMQ_1742582213
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39979ad285bso1339010f8f.2
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582212; x=1743187012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z4A4b9/OXiyaSRX/qk8oeDehU/YXPK8pcQSTIn5TX0I=;
 b=wB9ijbi+oYgG0/rIkpYN1In28swMVfj1tq9JZvo6i+AecqdhVeBBoIgzV+8+f0cxXw
 DD3F0tPYfBbiRJXxHW6ZjS6BCtZbqTzWM0j3cgapD5NxzR+5Tt3vILtFBTeiaFhAGgdi
 uK6uEFErg28OIku0OtZOgY/x5nhdSeKBHQoJfdfMob9+dKzh/Uy0duLa6xZ5HdnU4Ybb
 8syny99aJ0w7GbGBvaG0Xuk7ssSSH3TrublOYyX2INk/baWSioHRxNhVLERS0pkugAnP
 lH8FXNEoM5dPTHjdhWE//hi+AhXXfUdWko9esY1HSutt2ezuYz3OPa7XXtT5OPLc682P
 vLRQ==
X-Gm-Message-State: AOJu0YxUDIrjGAALTvWHwc1g5HiL1gZ1C+w2/q8XWjZItgGPVHsrw4a8
 UA1KlZeQA6io4+MV+wTx+jkBjQxzTyOPKw71dNw9gCwuuw347+io/VKf7gaw0i6sZSFdOZVXRnJ
 wx6GF/sZZ+znifSanzfjkWFDDuB6SsJZpr6XktcjPOhDyeLfXjD5kdn5eMfrgkH7cuBfqnoAMV+
 MPwgG+Yli0Xze8FofTLXOasyVYEwfhWF1zk8aD
X-Gm-Gg: ASbGncvlw5Rw0QCmLDobd8AqT3OCuHOMZZ7UEROj3YTxL5NwGci4Xs/ZsXFi6GfZLGL
 iebrcPHpgADSDbIXJV6yskpeKMkpeAI66VhElhjuTbVXVPU33PX6jIngs7CIlDJoSusKRE1pYcf
 stra0LTVqL0oKToNbaPgg+OYoZNv6ULZzdgYcCchVzS0UvfMXPSNgZOdmgQFFUwK4QlvsxCAXur
 eB7p2gBquf+MzCG13AEaQ6mCV6QQe07x1aDHOMDf3zLR5sAE/MXIXR77MLPDxTThPAB1niR15m9
 d2grED6uFd8RmbMrmTWs
X-Received: by 2002:a05:6000:1543:b0:390:f987:26a1 with SMTP id
 ffacd0b85a97d-3997f911531mr4606720f8f.29.1742582212077; 
 Fri, 21 Mar 2025 11:36:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFphEiDkT9cdo4ZZYqJH9AHvJPpaVJZ5+H5hK4DQi4iDzQbcTG7Uf1LICBlQ9PQfAhZosgtUg==
X-Received: by 2002:a05:6000:1543:b0:390:f987:26a1 with SMTP id
 ffacd0b85a97d-3997f911531mr4606695f8f.29.1742582211548; 
 Fri, 21 Mar 2025 11:36:51 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd9df6bsm33907585e9.31.2025.03.21.11.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 21/24] rust/vmstate: Add unit test for pointer case
Date: Fri, 21 Mar 2025 19:35:53 +0100
Message-ID: <20250321183556.155097-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321183556.155097-1-pbonzini@redhat.com>
References: <20250321183556.155097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

From: Zhao Liu <zhao1.liu@intel.com>

Add a unit test to cover some patterns accepted by vmstate_of macro,
which correspond to the following C version macros:
 * VMSTATE_POINTER
 * VMSTATE_ARRAY_OF_POINTER

Note: Currently, vmstate_struct can't handle the pointer to structure
case. Leave this case as a FIXME and use vmstate_unused as a place
holder.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250318130219.1799170-14-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/tests/vmstate_tests.rs | 119 ++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 4 deletions(-)

diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index 2c3301e02af..027b2266753 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -2,15 +2,16 @@
 // Author(s): Zhao Liu <zhai1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{ffi::CStr, mem::size_of, slice};
+use std::{ffi::CStr, mem::size_of, ptr::NonNull, slice};
 
 use qemu_api::{
     bindings::{
-        vmstate_info_bool, vmstate_info_int64, vmstate_info_int8, vmstate_info_uint64,
-        vmstate_info_uint8, vmstate_info_unused_buffer, VMStateFlags,
+        vmstate_info_bool, vmstate_info_int32, vmstate_info_int64, vmstate_info_int8,
+        vmstate_info_uint64, vmstate_info_uint8, vmstate_info_unused_buffer, VMStateFlags,
     },
     c_str,
-    cell::BqlCell,
+    cell::{BqlCell, Opaque},
+    impl_vmstate_forward,
     vmstate::{VMStateDescription, VMStateField},
     vmstate_fields, vmstate_of, vmstate_struct, vmstate_unused,
     zeroable::Zeroable,
@@ -286,3 +287,113 @@ fn test_vmstate_macro_array() {
     // The last VMStateField in VMSTATE_FOOB.
     assert_eq!(foo_fields[5].flags, VMStateFlags::VMS_END);
 }
+
+// =========================== Test VMSTATE_FOOC ===========================
+// Test the use cases of the vmstate macro, corresponding to the following C
+// macro variants:
+//   * VMSTATE_FOOC:
+//     - VMSTATE_POINTER
+//     - VMSTATE_ARRAY_OF_POINTER
+struct FooCWrapper([Opaque<*mut u8>; FOO_ARRAY_MAX]); // Though Opaque<> array is almost impossible.
+
+impl_vmstate_forward!(FooCWrapper);
+
+#[repr(C)]
+#[derive(qemu_api_macros::offsets)]
+struct FooC {
+    ptr: *const i32,
+    ptr_a: NonNull<FooA>,
+    arr_ptr: [Box<u8>; FOO_ARRAY_MAX],
+    arr_ptr_wrap: FooCWrapper,
+}
+
+static VMSTATE_FOOC: VMStateDescription = VMStateDescription {
+    name: c_str!("foo_c").as_ptr(),
+    version_id: 3,
+    minimum_version_id: 1,
+    fields: vmstate_fields! {
+        vmstate_of!(FooC, ptr).with_version_id(2),
+        // FIXME: Currently vmstate_struct doesn't support the pointer to structure.
+        // VMSTATE_STRUCT_POINTER: vmstate_struct!(FooC, ptr_a, VMSTATE_FOOA, NonNull<FooA>)
+        vmstate_unused!(size_of::<NonNull<FooA>>()),
+        vmstate_of!(FooC, arr_ptr),
+        vmstate_of!(FooC, arr_ptr_wrap),
+    },
+    ..Zeroable::ZERO
+};
+
+const PTR_SIZE: usize = size_of::<*mut ()>();
+
+#[test]
+fn test_vmstate_pointer() {
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOC.fields, 6) };
+
+    // 1st VMStateField ("ptr") in VMSTATE_FOOC (corresponding to VMSTATE_POINTER)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[0].name) }.to_bytes_with_nul(),
+        b"ptr\0"
+    );
+    assert_eq!(foo_fields[0].offset, 0);
+    assert_eq!(foo_fields[0].num_offset, 0);
+    assert_eq!(foo_fields[0].info, unsafe { &vmstate_info_int32 });
+    assert_eq!(foo_fields[0].version_id, 2);
+    assert_eq!(foo_fields[0].size, 4);
+    assert_eq!(foo_fields[0].num, 0);
+    assert_eq!(
+        foo_fields[0].flags.0,
+        VMStateFlags::VMS_SINGLE.0 | VMStateFlags::VMS_POINTER.0
+    );
+    assert!(foo_fields[0].vmsd.is_null());
+    assert!(foo_fields[0].field_exists.is_none());
+}
+
+#[test]
+fn test_vmstate_macro_array_of_pointer() {
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOC.fields, 6) };
+
+    // 3rd VMStateField ("arr_ptr") in VMSTATE_FOOC (corresponding to
+    // VMSTATE_ARRAY_OF_POINTER)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[2].name) }.to_bytes_with_nul(),
+        b"arr_ptr\0"
+    );
+    assert_eq!(foo_fields[2].offset, 2 * PTR_SIZE);
+    assert_eq!(foo_fields[2].num_offset, 0);
+    assert_eq!(foo_fields[2].info, unsafe { &vmstate_info_uint8 });
+    assert_eq!(foo_fields[2].version_id, 0);
+    assert_eq!(foo_fields[2].size, PTR_SIZE);
+    assert_eq!(foo_fields[2].num, FOO_ARRAY_MAX as i32);
+    assert_eq!(
+        foo_fields[2].flags.0,
+        VMStateFlags::VMS_ARRAY.0 | VMStateFlags::VMS_ARRAY_OF_POINTER.0
+    );
+    assert!(foo_fields[2].vmsd.is_null());
+    assert!(foo_fields[2].field_exists.is_none());
+}
+
+#[test]
+fn test_vmstate_macro_array_of_pointer_wrapped() {
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOC.fields, 6) };
+
+    // 4th VMStateField ("arr_ptr_wrap") in VMSTATE_FOOC (corresponding to
+    // VMSTATE_ARRAY_OF_POINTER)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[3].name) }.to_bytes_with_nul(),
+        b"arr_ptr_wrap\0"
+    );
+    assert_eq!(foo_fields[3].offset, (FOO_ARRAY_MAX + 2) * PTR_SIZE);
+    assert_eq!(foo_fields[3].num_offset, 0);
+    assert_eq!(foo_fields[2].info, unsafe { &vmstate_info_uint8 });
+    assert_eq!(foo_fields[3].version_id, 0);
+    assert_eq!(foo_fields[3].size, PTR_SIZE);
+    assert_eq!(foo_fields[3].num, FOO_ARRAY_MAX as i32);
+    assert_eq!(
+        foo_fields[2].flags.0,
+        VMStateFlags::VMS_ARRAY.0 | VMStateFlags::VMS_ARRAY_OF_POINTER.0
+    );
+    assert!(foo_fields[3].vmsd.is_null());
+    assert!(foo_fields[3].field_exists.is_none());
+
+    // The last VMStateField in VMSTATE_FOOC.
+    assert_eq!(foo_fields[4].flags, VMStateFlags::VMS_END);
+}
-- 
2.49.0


