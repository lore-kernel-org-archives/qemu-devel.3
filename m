Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2F5C369D9
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 08:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uB7mK-00084t-Vu; Sat, 03 May 2025 03:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mI-00084H-VW
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uB7mG-0006dd-Pa
 for qemu-devel@nongnu.org; Sat, 03 May 2025 03:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746259155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4wvpnyuIrOVtJPGHl3dMJz2mkTuCIwwag/C2R+cWE7g=;
 b=UhFdkt/e9otOI1R/x5jag5+8qOscAJpaSoEB9LObZoLQ+y7gYt6lRig6vtDdr/XDvubUOA
 zp3h78oPuIhRb2/40UCE6f7xtChz7dyfxbO/aZWXegDPQlxiS9A9mK8EgLO97OtJlJfkyQ
 z4y61H/VUCHn0r24uOKhpbYPyT8/JC8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-sRH7vSTjNpuMYj_kDdvnMQ-1; Sat, 03 May 2025 03:59:14 -0400
X-MC-Unique: sRH7vSTjNpuMYj_kDdvnMQ-1
X-Mimecast-MFC-AGG-ID: sRH7vSTjNpuMYj_kDdvnMQ_1746259153
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3912a0439afso776427f8f.3
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 00:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746259152; x=1746863952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4wvpnyuIrOVtJPGHl3dMJz2mkTuCIwwag/C2R+cWE7g=;
 b=qZnGFiz5rmuyP1EnJ90feSguBH4tQEB/9ssgTH9gqchtTtgdDJuOBipXrE/HYUTs/q
 FLm9djT1uYstMsz7vMtVMvHSVa8bldH3XQUj5ajo5VuukCOd44rEpq/5qLBTM+l9hbri
 fXi8vlkO0gjQONvbPy5aZrenvHmNjlIk6VkuxY7x/i9QrDU2ShBjbBwW4E3DCs1t467d
 DMhxswzCxO+0+CGv375ID0E1O5H1kSINnbDu3ERHm63NO7E2QtwX8xkyHmR0xNaZXnie
 nLoB4HDFLXpofGvWqn/hYh40G2t7/tDFHRyFxk0oIyOJUJCyyuoQgK6/uH/zJxSgXjG1
 v7yA==
X-Gm-Message-State: AOJu0YzzjS+3RcTRbIYVKLebtWZzIsaLRqQSYppcVfMEyF5g4I5c2DJT
 QJQn34UQnAroLvoPU4ZlRkmj1J2bkA8TPId9PCZv1PSgLsFII6qPZYdS3xQcsWZ4a4KLanxUMG8
 /CyWxRBV4i6AtnepE1yySKoGfkbNdCgIdHjmi33PdTaBLI4AJ5r3H+J7rCzNBQmsHt2Inyk+asg
 uMDZVsh3JpIDf0ctJBVSifrcdOKPFj04O7VAZs
X-Gm-Gg: ASbGnct4zHPKr9ynSBR/DQvBoI8xZJHeNqm3EoS+yWvbykQ4BfU/o7GYIC9sosdZ7D/
 T4yviL0Q5y8j/dxtXuHkcAuJLmWlhCOdcrxIHzoEUAXUgAbvEpFNeHgVHft4aozXMhWX4HfsMYJ
 E54sE1oQBB1phOEwJnej/u25HOLen92BkM/PaWv5QbarPigbgUpHbQshxS3k/TfXQag8v7d6AFV
 F4rSgnkkiSC0YWiQTsLbDnEAeIZJrwt1D5cBk7drj4o7w3lQGgRpxdxZBswAALZbtvZvhSKYIW1
 M5Bj/6rlYybZmps=
X-Received: by 2002:a05:6000:240d:b0:3a0:7017:61f6 with SMTP id
 ffacd0b85a97d-3a09ceaff3bmr1498637f8f.14.1746259151676; 
 Sat, 03 May 2025 00:59:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkyVIMSkTtJs9ZAGOHwOifjxovZOiEffUumdtQA5OetJkyp33qes5LTTffGOwp5WyrUg8aag==
X-Received: by 2002:a05:6000:240d:b0:3a0:7017:61f6 with SMTP id
 ffacd0b85a97d-3a09ceaff3bmr1498624f8f.14.1746259151323; 
 Sat, 03 May 2025 00:59:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b0feb3sm4170570f8f.67.2025.05.03.00.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 00:59:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 04/13] rust/vmstate_test: Test varray with num field wrapped in
 BqlCell
Date: Sat,  3 May 2025 09:58:49 +0200
Message-ID: <20250503075858.277375-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503075858.277375-1-pbonzini@redhat.com>
References: <20250503075858.277375-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250414144943.1112885-4-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/tests/vmstate_tests.rs | 41 ++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index 8b93492a689..f7a93117e1a 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -28,7 +28,7 @@
 //     - VMSTATE_VARRAY_UINT16_UNSAFE
 //     - VMSTATE_VARRAY_MULTIPLY
 #[repr(C)]
-#[derive(qemu_api_macros::offsets)]
+#[derive(Default, qemu_api_macros::offsets)]
 struct FooA {
     arr: [u8; FOO_ARRAY_MAX],
     num: u16,
@@ -147,8 +147,9 @@ fn test_vmstate_varray_multiply() {
 //     - VMSTATE_STRUCT_VARRAY_UINT8
 //     - (no C version) MULTIPLY variant of VMSTATE_STRUCT_VARRAY_UINT32
 //     - VMSTATE_ARRAY
+//     - VMSTATE_STRUCT_VARRAY_UINT8 with BqlCell wrapper & test_fn
 #[repr(C)]
-#[derive(qemu_api_macros::offsets)]
+#[derive(Default, qemu_api_macros::offsets)]
 struct FooB {
     arr_a: [FooA; FOO_ARRAY_MAX],
     num_a: u8,
@@ -158,6 +159,12 @@ struct FooB {
     val: bool,
     // FIXME: Use Timer array. Now we can't since it's hard to link savevm.c to test.
     arr_i64: [i64; FOO_ARRAY_MAX],
+    arr_a_wrap: [FooA; FOO_ARRAY_MAX],
+    num_a_wrap: BqlCell<u32>,
+}
+
+fn validate_foob(_state: &FooB, _version_id: u8) -> bool {
+    true
 }
 
 static VMSTATE_FOOB: VMStateDescription = VMStateDescription {
@@ -170,13 +177,14 @@ struct FooB {
         vmstate_struct!(FooB, arr_a[0 .. num_a], &VMSTATE_FOOA, FooA).with_version_id(1),
         vmstate_struct!(FooB, arr_a_mul[0 .. num_a_mul * 32], &VMSTATE_FOOA, FooA).with_version_id(2),
         vmstate_of!(FooB, arr_i64),
+        vmstate_struct!(FooB, arr_a_wrap[0 .. num_a_wrap], &VMSTATE_FOOA, FooA, validate_foob),
     },
     ..Zeroable::ZERO
 };
 
 #[test]
 fn test_vmstate_bool_v() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 6) };
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 7) };
 
     // 1st VMStateField ("val") in VMSTATE_FOOB (corresponding to VMSTATE_BOOL_V)
     assert_eq!(
@@ -196,7 +204,7 @@ fn test_vmstate_bool_v() {
 
 #[test]
 fn test_vmstate_uint64() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 6) };
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 7) };
 
     // 2nd VMStateField ("wrap") in VMSTATE_FOOB (corresponding to VMSTATE_U64)
     assert_eq!(
@@ -216,7 +224,7 @@ fn test_vmstate_uint64() {
 
 #[test]
 fn test_vmstate_struct_varray_uint8() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 6) };
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 7) };
 
     // 3rd VMStateField ("arr_a") in VMSTATE_FOOB (corresponding to
     // VMSTATE_STRUCT_VARRAY_UINT8)
@@ -240,7 +248,7 @@ fn test_vmstate_struct_varray_uint8() {
 
 #[test]
 fn test_vmstate_struct_varray_uint32_multiply() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 6) };
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 7) };
 
     // 4th VMStateField ("arr_a_mul") in VMSTATE_FOOB (corresponding to
     // (no C version) MULTIPLY variant of VMSTATE_STRUCT_VARRAY_UINT32)
@@ -266,7 +274,7 @@ fn test_vmstate_struct_varray_uint32_multiply() {
 
 #[test]
 fn test_vmstate_macro_array() {
-    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 6) };
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 7) };
 
     // 5th VMStateField ("arr_i64") in VMSTATE_FOOB (corresponding to
     // VMSTATE_ARRAY)
@@ -283,9 +291,26 @@ fn test_vmstate_macro_array() {
     assert_eq!(foo_fields[4].flags, VMStateFlags::VMS_ARRAY);
     assert!(foo_fields[4].vmsd.is_null());
     assert!(foo_fields[4].field_exists.is_none());
+}
+
+#[test]
+fn test_vmstate_struct_varray_uint8_wrapper() {
+    let foo_fields: &[VMStateField] = unsafe { slice::from_raw_parts(VMSTATE_FOOB.fields, 7) };
+    let mut foo_b: FooB = Default::default();
+    let foo_b_p = std::ptr::addr_of_mut!(foo_b).cast::<c_void>();
+
+    // 6th VMStateField ("arr_a_wrap") in VMSTATE_FOOB (corresponding to
+    // VMSTATE_STRUCT_VARRAY_UINT8). Other fields are checked in
+    // test_vmstate_struct_varray_uint8.
+    assert_eq!(
+        unsafe { CStr::from_ptr(foo_fields[5].name) }.to_bytes_with_nul(),
+        b"arr_a_wrap\0"
+    );
+    assert_eq!(foo_fields[5].num_offset, 228);
+    assert!(unsafe { foo_fields[5].field_exists.unwrap()(foo_b_p, 0) });
 
     // The last VMStateField in VMSTATE_FOOB.
-    assert_eq!(foo_fields[5].flags, VMStateFlags::VMS_END);
+    assert_eq!(foo_fields[6].flags, VMStateFlags::VMS_END);
 }
 
 // =========================== Test VMSTATE_FOOC ===========================
-- 
2.49.0


