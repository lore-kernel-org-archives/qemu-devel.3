Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7957CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 14:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uquJC-0006AS-FO; Tue, 26 Aug 2025 10:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uquIy-00062T-Lq
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uquIm-00071I-1H
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756217127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CFTCJrN/ErsTKJeHGSYgSgdl79/H5tHqcfewRtfo3pU=;
 b=aOoUBkvBMvByC5J0JbJWRbthnNqxFpwdpmclb+li0GvQq53n7K8YjNDjWTAR1Y1j9kUxPj
 7HbhlNCKPA4l0ndR6r3imF+iRnOv6b0ohGVNjwE6QC47HExQlfz+slT784kbBuPDelaNkn
 SQla8ur9rqp9/QZXB8Y5rc8+acr/2eA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-9ss3N93bOLOtMTDz7dGBpA-1; Tue,
 26 Aug 2025 10:05:23 -0400
X-MC-Unique: 9ss3N93bOLOtMTDz7dGBpA-1
X-Mimecast-MFC-AGG-ID: 9ss3N93bOLOtMTDz7dGBpA_1756217122
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E22A19560A1; Tue, 26 Aug 2025 14:05:22 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 30DCA30001A2; Tue, 26 Aug 2025 14:05:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC 05/18] rust: move vmstate_clock!() to qdev module
Date: Tue, 26 Aug 2025 18:04:33 +0400
Message-ID: <20250826140449.4190022-6-marcandre.lureau@redhat.com>
In-Reply-To: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
References: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This will allow to split vmstate to a standalone crate next.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 rust/qemu-api/src/qdev.rs    | 34 ++++++++++++++++++++++++++++++++++
 rust/qemu-api/src/vmstate.rs | 34 ----------------------------------
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 02e9d55e6a..5469eef22a 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -408,3 +408,37 @@ unsafe impl ObjectType for Clock {
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_CLOCK) };
 }
 qom_isa!(Clock: Object);
+
+#[doc(alias = "VMSTATE_CLOCK")]
+#[macro_export]
+macro_rules! vmstate_clock {
+    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])?) => {{
+        $crate::bindings::VMStateField {
+            name: ::core::concat!(::core::stringify!($field_name), "\0")
+                .as_bytes()
+                .as_ptr() as *const ::std::os::raw::c_char,
+            offset: {
+                ::common::assert_field_type!(
+                    $struct_name,
+                    $field_name,
+                    $crate::qom::Owned<$crate::qdev::Clock> $(, num = $num)?
+                );
+                ::std::mem::offset_of!($struct_name, $field_name)
+            },
+            size: ::core::mem::size_of::<*const $crate::qdev::Clock>(),
+            flags: $crate::bindings::VMStateFlags(
+                $crate::bindings::VMStateFlags::VMS_STRUCT.0
+                    | $crate::bindings::VMStateFlags::VMS_POINTER.0,
+            ),
+            vmsd: unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_clock) },
+            ..::common::zeroable::Zeroable::ZERO
+         } $(.with_varray_flag_unchecked(
+                  $crate::call_func_with_field!(
+                      $crate::vmstate::vmstate_varray_flag,
+                      $struct_name,
+                      $num
+                  )
+              )
+           $(.with_varray_multiply($factor))?)?
+    }};
+}
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 4e2b7e2db0..ff64d2c6a2 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -504,40 +504,6 @@ macro_rules! vmstate_struct {
     };
 }
 
-#[doc(alias = "VMSTATE_CLOCK")]
-#[macro_export]
-macro_rules! vmstate_clock {
-    ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])?) => {{
-        $crate::bindings::VMStateField {
-            name: ::core::concat!(::core::stringify!($field_name), "\0")
-                .as_bytes()
-                .as_ptr() as *const ::std::os::raw::c_char,
-            offset: {
-                ::common::assert_field_type!(
-                    $struct_name,
-                    $field_name,
-                    $crate::qom::Owned<$crate::qdev::Clock> $(, num = $num)?
-                );
-                ::std::mem::offset_of!($struct_name, $field_name)
-            },
-            size: ::core::mem::size_of::<*const $crate::qdev::Clock>(),
-            flags: $crate::bindings::VMStateFlags(
-                $crate::bindings::VMStateFlags::VMS_STRUCT.0
-                    | $crate::bindings::VMStateFlags::VMS_POINTER.0,
-            ),
-            vmsd: unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_clock) },
-            ..::common::zeroable::Zeroable::ZERO
-         } $(.with_varray_flag_unchecked(
-                  $crate::call_func_with_field!(
-                      $crate::vmstate::vmstate_varray_flag,
-                      $struct_name,
-                      $num
-                  )
-              )
-           $(.with_varray_multiply($factor))?)?
-    }};
-}
-
 /// Helper macro to declare a list of
 /// ([`VMStateField`](`crate::bindings::VMStateField`)) into a static and return
 /// a pointer to the array of values it created.
-- 
2.50.1


