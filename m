Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C46CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZSl-0006D0-RC; Mon, 08 Sep 2025 06:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSg-0006BU-BN
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSW-000639-7P
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9EmQyCrmyO2jBSfeXLEXhbG6MX8/0THqidDwj3+204M=;
 b=Dq5f5i+X5xnTxc+Zmn9pdsXMjSc4t9l8SAtBz0fBxLSRk7BWSx8eQZnlfeobfF+cX5W8Hf
 84o4gNCM6iSL77Uwb1MJmhfIvsHzIPo7H/xsbsSFXV1IdFerYsQHr8KazGYr56wXpAVZ0m
 XVkmCBUiRAjqT8FAhkYe+We3OvL3+9g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-xNHcounUOt6WWqemW5p-EA-1; Mon, 08 Sep 2025 06:50:43 -0400
X-MC-Unique: xNHcounUOt6WWqemW5p-EA-1
X-Mimecast-MFC-AGG-ID: xNHcounUOt6WWqemW5p-EA_1757328642
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3df07c967e9so2721063f8f.2
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328641; x=1757933441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9EmQyCrmyO2jBSfeXLEXhbG6MX8/0THqidDwj3+204M=;
 b=g1efq4e8UkE2hAVRdMaW4CZfev/kq+0EaOOkyMH/+apnm1gS5ihwdQNOWMWnMMUo3R
 3ybntcKBRf5X+jmtDSQHoCAcSesDc4vcqq0KCySXm5b0Ii5x1aJX236UK0MEiA/zZeBi
 j2swRGjPaJWbDoE5GIz3is1wr9fHUBhDJ2GSsjHrrHrBzRGbPU1INA4BqWhO9uIrk6eS
 dTss/99hfp63jfanRz0oRUXyMim/N48rjyiq+/aSf3sPPyYf4BAYFFeFlK+Jn69f7qIS
 7EqWNxkaavNqrYwd5v9R++sq0rnEzXSS9t5bgMJ4DJ8uTS/WjDXn9IFdv2EKePqaXzzD
 cPUg==
X-Gm-Message-State: AOJu0Ywylew95jRZwqPqszi/pWmKVi19QLH/lWf5BAzuXV41alh8tDvy
 tUYZl0O2PHmo9vn5X+5j1B6N4DQpG9DJGzDnTW6Hto3jXRo9tyqLi2GFTsYjMerkJcoQ4J925MX
 wAx4yR6nwlRRYjjjYDSKhQm+OLShfFW9ZX0pyOcOtUAhe44/D37+dpPLw4WSCpyn+oD5mmU+e3F
 y61474GB84GX0acrhrTswtXvhC8uBLW+yBhx+gghdg
X-Gm-Gg: ASbGncttcMMgNrpMiqb8hv+V3Qbqo9U2NKnFKSybSvzxFySFQGLdV74lbMfEFnGFhYz
 Bb0UP/Pk81NtEGlD/SvbeDMfQ08bBjoy4mI9rNKqUECPBrkPwpnBtKcqMZWrTNPUGwS7fO2y5K2
 Tuxsjo/ZelsQ67C5A5wHqU++iqOC2wm3/VdhU0C/OsI5ZnYxGDmKwbze71iS10X8iUwV9uauRQB
 7PDI2uswNHGGZDzfWIG1fvz0DVIyFtuom9jdYgbegavyru8tXUB6mQEtZl95HytjUYbd7S35vC2
 /0xiG8hGIBqEyLc9OcihVeModbecSnWVM/eODzFyfTiA0zncxgNQytRKrP350gnMtWlxjWIvwxC
 oZv+dy9urYzQyelA65M2zfjynB11a1LGrgLOYujuy8A4=
X-Received: by 2002:a5d:5d12:0:b0:3e5:f1e2:6789 with SMTP id
 ffacd0b85a97d-3e64c692dfcmr6530379f8f.59.1757328640938; 
 Mon, 08 Sep 2025 03:50:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3+GfLiuBHRfK4KSCzOc49Lq3CODruDTt1XcA9SbRSNZ0PlI1x7WcBPb1vJD0oO5MMwhqqeA==
X-Received: by 2002:a5d:5d12:0:b0:3e5:f1e2:6789 with SMTP id
 ffacd0b85a97d-3e64c692dfcmr6530340f8f.59.1757328640364; 
 Mon, 08 Sep 2025 03:50:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf34494776sm40906337f8f.61.2025.09.08.03.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:50:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 14/33] rust: move VMState handling to QOM module
Date: Mon,  8 Sep 2025 12:49:46 +0200
Message-ID: <20250908105005.2119297-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908105005.2119297-1-pbonzini@redhat.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Link: https://lore.kernel.org/r/20250827104147.717203-9-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qom.rs     |  3 +++
 rust/qemu-api/src/vmstate.rs | 11 +++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 014ffb1fd88..12c6fc6752c 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -109,6 +109,7 @@
         object_get_typename, object_new, object_ref, object_unref, TypeInfo,
     },
     cell::{bql_locked, Opaque},
+    impl_vmstate_pointer,
 };
 
 /// A safe wrapper around [`bindings::Object`].
@@ -948,3 +949,5 @@ fn debug_fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
 
 impl<T> ObjectClassMethods for T where T: IsA<Object> {}
 impl<R: ObjectDeref> ObjectMethods for R where R::Target: IsA<Object> {}
+
+impl_vmstate_pointer!(Owned<T> where T: VMState + ObjectType);
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 59c7950a5aa..4e1086779ac 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -40,8 +40,6 @@
     bindings::{self, VMStateFlags},
     callbacks::FnCall,
     errno::{into_neg_errno, Errno},
-    prelude::*,
-    qom::Owned,
     zeroable::Zeroable,
 };
 
@@ -128,7 +126,8 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
 /// * a transparent wrapper for any of the above (`Cell`, `UnsafeCell`,
 ///   [`BqlCell`], [`BqlRefCell`]
 /// * a raw pointer to any of the above
-/// * a `NonNull` pointer, a `Box` or an [`Owned`] for any of the above
+/// * a `NonNull` pointer, a `Box` or an [`Owned`](crate::qom::Owned) for any of
+///   the above
 /// * an array of any of the above
 ///
 /// In order to support other types, the trait `VMState` must be implemented
@@ -335,10 +334,11 @@ unsafe impl VMState for $type {
 // Note that references are not supported, though references to cells
 // could be allowed.
 
+#[macro_export]
 macro_rules! impl_vmstate_pointer {
     ($type:ty where $base:tt: VMState $($where:tt)*) => {
-        unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
-            const BASE: VMStateField = <$base as VMState>::BASE.with_pointer_flag();
+        unsafe impl<$base> $crate::vmstate::VMState for $type where $base: $crate::vmstate::VMState $($where)* {
+            const BASE: $crate::vmstate::VMStateField = <$base as $crate::vmstate::VMState>::BASE.with_pointer_flag();
         }
     };
 }
@@ -350,7 +350,6 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 // Unlike C pointers, Box is always non-null therefore there is no need
 // to specify VMS_ALLOC.
 impl_vmstate_pointer!(Box<T> where T: VMState);
-impl_vmstate_pointer!(Owned<T> where T: VMState + ObjectType);
 
 // Arrays using the underlying type's VMState plus
 // VMS_ARRAY/VMS_ARRAY_OF_POINTER
-- 
2.51.0


