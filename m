Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFBDCA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 14:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uquJ7-000670-EC; Tue, 26 Aug 2025 10:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uquJ2-00063w-BF
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:05:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uquIr-000728-V7
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756217133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o2GQ5VjLakir0/k6HgSkaXNO8ljFlfMT2OkBfKsfPEU=;
 b=BVdr9D1a0JXpPhnKHjram9MgyHGagwjpY5MLQrHIVginHq8r7JetH3XTmRlSizB9DudaSj
 pcJzBr4T8xpMshvhSqeEW6hzV12etdct3zrCwTfL3cqFXjosTszIuhljiK/ymUwmyL9wYu
 +9XhQ7CbupH7ZTuLh11eo4DOIMxBA8Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-lPBflaZQPK26Uhz6Di2OVA-1; Tue,
 26 Aug 2025 10:05:29 -0400
X-MC-Unique: lPBflaZQPK26Uhz6Di2OVA-1
X-Mimecast-MFC-AGG-ID: lPBflaZQPK26Uhz6Di2OVA_1756217128
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B1A518002A4; Tue, 26 Aug 2025 14:05:28 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7FD401800447; Tue, 26 Aug 2025 14:05:26 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC 06/18] rust: move VMState handling to QOM module
Date: Tue, 26 Aug 2025 18:04:34 +0400
Message-ID: <20250826140449.4190022-7-marcandre.lureau@redhat.com>
In-Reply-To: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
References: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 rust/qemu-api/src/qom.rs     |  3 +++
 rust/qemu-api/src/vmstate.rs | 10 +++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index c2f9a682bb..56feff3e17 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -110,6 +110,7 @@
         object_get_typename, object_new, object_ref, object_unref, TypeInfo,
     },
     cell::bql_locked,
+    impl_vmstate_pointer,
 };
 
 /// A safe wrapper around [`bindings::Object`].
@@ -949,3 +950,5 @@ fn debug_fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
 
 impl<T> ObjectClassMethods for T where T: IsA<Object> {}
 impl<R: ObjectDeref> ObjectMethods for R where R::Target: IsA<Object> {}
+
+impl_vmstate_pointer!(Owned<T> where T: VMState + ObjectType);
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index ff64d2c6a2..c1e2b06390 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -29,8 +29,8 @@
 
 use common::{callbacks::FnCall, Zeroable};
 
+use crate::bindings::VMStateFlags;
 pub use crate::bindings::{VMStateDescription, VMStateField};
-use crate::{bindings::VMStateFlags, prelude::*, qom::Owned};
 
 /// This macro is used to call a function with a generic argument bound
 /// to the type of a field.  The function must take a
@@ -396,11 +396,12 @@ unsafe impl VMState for $type {
 // Note that references are not supported, though references to cells
 // could be allowed.
 
+#[macro_export]
 macro_rules! impl_vmstate_pointer {
     ($type:ty where $base:tt: VMState $($where:tt)*) => {
-        unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
-            const SCALAR_TYPE: VMStateFieldType = <T as VMState>::SCALAR_TYPE;
-            const BASE: VMStateField = <$base as VMState>::BASE.with_pointer_flag();
+        unsafe impl<$base> $crate::vmstate::VMState for $type where $base: $crate::vmstate::VMState $($where)* {
+            const SCALAR_TYPE: $crate::vmstate::VMStateFieldType = <T as $crate::vmstate::VMState>::SCALAR_TYPE;
+            const BASE: $crate::vmstate::VMStateField = <$base as $crate::vmstate::VMState>::BASE.with_pointer_flag();
         }
     };
 }
@@ -412,7 +413,6 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 // Unlike C pointers, Box is always non-null therefore there is no need
 // to specify VMS_ALLOC.
 impl_vmstate_pointer!(Box<T> where T: VMState);
-impl_vmstate_pointer!(Owned<T> where T: VMState + ObjectType);
 
 // Arrays using the underlying type's VMState plus
 // VMS_ARRAY/VMS_ARRAY_OF_POINTER
-- 
2.50.1


