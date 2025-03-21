Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1759FC36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhFl-0005dd-A6; Fri, 21 Mar 2025 14:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEk-0003H0-N2
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:37:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEi-00076r-Jk
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pcyVK0Ky40+jKcAU7SkEAV4PP044DRu6ufX6WoYHJU0=;
 b=V0uVzU+n08QbEYd2vAiiXcuK04Aztclk2bPhhBAc8N6wPr2cRpJbkk2/xJw2BRq77hV+SP
 JogcHUYEFxx2bNd/F87IoOfGhj+27+Lxv/IlU3loufdUGCg1uo7wCi3chGhUhbSEcQAZYv
 yHouaSME0gyhrMn7V2cQRaOaZ9Eps6k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-xnbq1i0YOQiUz7Nl7n00Lw-1; Fri, 21 Mar 2025 14:36:50 -0400
X-MC-Unique: xnbq1i0YOQiUz7Nl7n00Lw-1
X-Mimecast-MFC-AGG-ID: xnbq1i0YOQiUz7Nl7n00Lw_1742582209
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43935e09897so15071465e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582208; x=1743187008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pcyVK0Ky40+jKcAU7SkEAV4PP044DRu6ufX6WoYHJU0=;
 b=HS+P/44wsEM1SmxRN8BIPEPCsNv4Pt11ATPcS9Z2BbLjQTKZStFszd2FZ1zzSOs0Of
 CUz8q40Wq9L8nHM73VdX7r7vKmGfL5rp7gOilso6cj5tOkU06dop56csvamB6HmEMTwv
 1eKwmwwS0YE/kr+94f9rx+09O8zXf76TCmXvMXZJz1ODeTlwM8NDo0WC1hp4SaCiqcj+
 VV1DeV3sfnOb9/RZMI2Lp33DO9dzERfyqD1BG8RCMuJs7ei1RJXy0Uq+fLXJiISPgJIt
 pbjiS3pLB6fuvlMbCLV0eXos2cnGxSXsikmxrzehux01TUkyO/8xaXhHSGlRmLOEKLqp
 GFZA==
X-Gm-Message-State: AOJu0YxV6g4pxcroc5X3JCL7XiokAJ+kr3eFc/0CCXf5F82vAkoXdnzJ
 c4NzGDEI9MLr5w0+KWo3ujJ1iZlvX0Xa75LuPSW8Rpi0J8QnZZiqJsRh0835gn7tZaoNyujt6/S
 iBLCQkTMx3zBwSV2wg++02JEGAF6JEdhF8KxB/MZFZg+Xjg7yWseoqkAwslFgzKJeOfHfHoW5c6
 akm36ZoPIfFaxxd2yqdxEJO87ol5Vq/YIfhcZ1
X-Gm-Gg: ASbGncsVh2g2jOs/VEHUimZuKTb47AGUm8K0eDNIwlYmTL0qZH+HIVaQwWvKjvqk15X
 l6cAE3mHrVPkywERIBswusCcC159L8GJqsBnafgAZQVl0A3CtL0ndd4xWbwO/In+Wiuubehqz70
 VhBK9m8ItpqSiTlJrBYnQA6hEryDIHHUibIQGEzhTzbjpNPtChSRQG02I+aidRM/cgvyu69N/5j
 5AdSIWud4ZIJ7oMZfyjcKN0UNIiBPIfdtNpj/KISG6syAAhnLNW2IkHigdNqapBgggx2xK4OoQk
 4XS6eC+Txxb2NmZb5/69
X-Received: by 2002:a05:600c:c0c:b0:43c:f64c:447f with SMTP id
 5b1f17b1804b1-43d50a35aaemr48151735e9.29.1742582207960; 
 Fri, 21 Mar 2025 11:36:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy57PaLAZzNf+1AnjppVEEzJZrmpyJtnOm8DpjSokdP2AC7rFe3vqA0oI/H9fo9cu2okUPTg==
X-Received: by 2002:a05:600c:c0c:b0:43c:f64c:447f with SMTP id
 5b1f17b1804b1-43d50a35aaemr48151455e9.29.1742582207407; 
 Fri, 21 Mar 2025 11:36:47 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d3adc4488sm75247505e9.0.2025.03.21.11.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 19/24] rust/vmstate: Add unit test for vmstate_of macro
Date: Fri, 21 Mar 2025 19:35:51 +0100
Message-ID: <20250321183556.155097-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321183556.155097-1-pbonzini@redhat.com>
References: <20250321183556.155097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

From: Zhao Liu <zhao1.liu@intel.com>

The vmstate has too many combinations of VMStateFlags and VMStateField.
Currently, the best way to test is to ensure that the Rust vmstate
definition is consistent with the (possibly corresponding) C version.

Add a unit test to cover some patterns accepted by vmstate_of macro,
which correspond to the following C version macros:
 * VMSTATE_U16
 * VMSTATE_UNUSED
 * VMSTATE_VARRAY_UINT16_UNSAFE
 * VMSTATE_VARRAY_MULTIPLY

Note: Because vmstate_info_* are defined in vmstate-types.c, it's
necessary to link libmigration to rust unit tests. In the future,
maybe it's possible to spilt libmigration from rust_qemu_api_objs.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250318130219.1799170-12-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/meson.build            |   5 +-
 rust/qemu-api/tests/tests.rs         |   2 +
 rust/qemu-api/tests/vmstate_tests.rs | 134 +++++++++++++++++++++++++++
 3 files changed, 139 insertions(+), 2 deletions(-)
 create mode 100644 rust/qemu-api/tests/vmstate_tests.rs

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index a3f226ccc2a..858685ddd4a 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -58,7 +58,8 @@ rust_qemu_api_objs = static_library(
               libchardev.extract_all_objects(recursive: false),
               libcrypto.extract_all_objects(recursive: false),
               libauthz.extract_all_objects(recursive: false),
-              libio.extract_all_objects(recursive: false)])
+              libio.extract_all_objects(recursive: false),
+              libmigration.extract_all_objects(recursive: false)])
 rust_qemu_api_deps = declare_dependency(
     dependencies: [
       qom_ss.dependencies(),
@@ -71,7 +72,7 @@ rust_qemu_api_deps = declare_dependency(
 test('rust-qemu-api-integration',
     executable(
         'rust-qemu-api-integration',
-        'tests/tests.rs',
+        files('tests/tests.rs', 'tests/vmstate_tests.rs'),
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 269122e7ec1..99a7aab6fed 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -17,6 +17,8 @@
     zeroable::Zeroable,
 };
 
+mod vmstate_tests;
+
 // Test that macros can compile.
 pub static VMSTATE: VMStateDescription = VMStateDescription {
     name: c_str!("name").as_ptr(),
diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
new file mode 100644
index 00000000000..eb1bb2f8a04
--- /dev/null
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -0,0 +1,134 @@
+// Copyright (C) 2025 Intel Corporation.
+// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use std::{ffi::CStr, mem::size_of, slice};
+
+use qemu_api::{
+    bindings::{vmstate_info_int8, vmstate_info_uint8, vmstate_info_unused_buffer, VMStateFlags},
+    c_str,
+    vmstate::{VMStateDescription, VMStateField},
+    vmstate_fields, vmstate_of, vmstate_unused,
+    zeroable::Zeroable,
+};
+
+const FOO_ARRAY_MAX: usize = 3;
+
+// =========================== Test VMSTATE_FOOA ===========================
+// Test the use cases of the vmstate macro, corresponding to the following C
+// macro variants:
+//   * VMSTATE_FOOA:
+//     - VMSTATE_U16
+//     - VMSTATE_UNUSED
+//     - VMSTATE_VARRAY_UINT16_UNSAFE
+//     - VMSTATE_VARRAY_MULTIPLY
+#[repr(C)]
+#[derive(qemu_api_macros::offsets)]
+struct FooA {
+    arr: [u8; FOO_ARRAY_MAX],
+    num: u16,
+    arr_mul: [i8; FOO_ARRAY_MAX],
+    num_mul: u32,
+    elem: i8,
+}
+
+static VMSTATE_FOOA: VMStateDescription = VMStateDescription {
+    name: c_str!("foo_a").as_ptr(),
+    version_id: 1,
+    minimum_version_id: 1,
+    fields: vmstate_fields! {
+        vmstate_of!(FooA, elem),
+        vmstate_unused!(size_of::<i64>()),
+        vmstate_of!(FooA, arr[0 .. num]).with_version_id(0),
+        vmstate_of!(FooA, arr_mul[0 .. num_mul * 16]),
+    },
+    ..Zeroable::ZERO
+};
+
+#[test]
+fn test_vmstate_uint16() {
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOA.fields, 5) };
+
+    // 1st VMStateField ("elem") in VMSTATE_FOOA (corresponding to VMSTATE_UINT16)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[0].name) }.to_bytes_with_nul(),
+        b"elem\0"
+    );
+    assert_eq!(foo_fields[0].offset, 16);
+    assert_eq!(foo_fields[0].num_offset, 0);
+    assert_eq!(foo_fields[0].info, unsafe { &vmstate_info_int8 });
+    assert_eq!(foo_fields[0].version_id, 0);
+    assert_eq!(foo_fields[0].size, 1);
+    assert_eq!(foo_fields[0].num, 0);
+    assert_eq!(foo_fields[0].flags, VMStateFlags::VMS_SINGLE);
+    assert!(foo_fields[0].vmsd.is_null());
+    assert!(foo_fields[0].field_exists.is_none());
+}
+
+#[test]
+fn test_vmstate_unused() {
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOA.fields, 5) };
+
+    // 2nd VMStateField ("unused") in VMSTATE_FOOA (corresponding to VMSTATE_UNUSED)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[1].name) }.to_bytes_with_nul(),
+        b"unused\0"
+    );
+    assert_eq!(foo_fields[1].offset, 0);
+    assert_eq!(foo_fields[1].num_offset, 0);
+    assert_eq!(foo_fields[1].info, unsafe { &vmstate_info_unused_buffer });
+    assert_eq!(foo_fields[1].version_id, 0);
+    assert_eq!(foo_fields[1].size, 8);
+    assert_eq!(foo_fields[1].num, 0);
+    assert_eq!(foo_fields[1].flags, VMStateFlags::VMS_BUFFER);
+    assert!(foo_fields[1].vmsd.is_null());
+    assert!(foo_fields[1].field_exists.is_none());
+}
+
+#[test]
+fn test_vmstate_varray_uint16_unsafe() {
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOA.fields, 5) };
+
+    // 3rd VMStateField ("arr") in VMSTATE_FOOA (corresponding to
+    // VMSTATE_VARRAY_UINT16_UNSAFE)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[2].name) }.to_bytes_with_nul(),
+        b"arr\0"
+    );
+    assert_eq!(foo_fields[2].offset, 0);
+    assert_eq!(foo_fields[2].num_offset, 4);
+    assert_eq!(foo_fields[2].info, unsafe { &vmstate_info_uint8 });
+    assert_eq!(foo_fields[2].version_id, 0);
+    assert_eq!(foo_fields[2].size, 1);
+    assert_eq!(foo_fields[2].num, 0);
+    assert_eq!(foo_fields[2].flags, VMStateFlags::VMS_VARRAY_UINT16);
+    assert!(foo_fields[2].vmsd.is_null());
+    assert!(foo_fields[2].field_exists.is_none());
+}
+
+#[test]
+fn test_vmstate_varray_multiply() {
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOA.fields, 5) };
+
+    // 4th VMStateField ("arr_mul") in VMSTATE_FOOA (corresponding to
+    // VMSTATE_VARRAY_MULTIPLY)
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[3].name) }.to_bytes_with_nul(),
+        b"arr_mul\0"
+    );
+    assert_eq!(foo_fields[3].offset, 6);
+    assert_eq!(foo_fields[3].num_offset, 12);
+    assert_eq!(foo_fields[3].info, unsafe { &vmstate_info_int8 });
+    assert_eq!(foo_fields[3].version_id, 0);
+    assert_eq!(foo_fields[3].size, 1);
+    assert_eq!(foo_fields[3].num, 16);
+    assert_eq!(
+        foo_fields[3].flags.0,
+        VMStateFlags::VMS_VARRAY_UINT32.0 | VMStateFlags::VMS_MULTIPLY_ELEMENTS.0
+    );
+    assert!(foo_fields[3].vmsd.is_null());
+    assert!(foo_fields[3].field_exists.is_none());
+
+    // The last VMStateField in VMSTATE_FOOA.
+    assert_eq!(foo_fields[4].flags, VMStateFlags::VMS_END);
+}
-- 
2.49.0


