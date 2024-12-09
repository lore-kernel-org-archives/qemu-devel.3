Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0228E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKd3b-000614-Cn; Mon, 09 Dec 2024 07:40:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1i-00045t-D5
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:38:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1g-0007Wl-Dd
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:38:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733747891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmaMuh+/1R6nn1pVbFPg8WJblYj+VkUXSy659iDTG4g=;
 b=JA3pDqT4MYv+ht8he5HPnzaY3jSz29KwELx2dHlbLyVrfkaInox0qrw4YBx+siC1XDFGoR
 EMm5heqpgr3FC/JPDvg7yPpxwLWvQTa2ho/nKT8zNAWLWvq/Bi3qlf+6zW080V+3uOxlQU
 oZC5b3Wt0ymBa1MlsdK/D0V5g0Vdua4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-4UmEr9RnPqe0HdP5bDF4Cg-1; Mon, 09 Dec 2024 07:38:10 -0500
X-MC-Unique: 4UmEr9RnPqe0HdP5bDF4Cg-1
X-Mimecast-MFC-AGG-ID: 4UmEr9RnPqe0HdP5bDF4Cg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434fb9646efso5568575e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 04:38:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747889; x=1734352689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cmaMuh+/1R6nn1pVbFPg8WJblYj+VkUXSy659iDTG4g=;
 b=SRnnHHt+Nx3VPivoeIkEC/BDev32tKFsONOfj1icp9kxKA+ziegTvEjUhUGCx+fEul
 0ABWvVGn4+/vglH3h76toQsQtRwq6XOQ19I4QXp1QzoRtHrUuxpCJSWJJoNgq+cKYsfj
 2httYQwLOfaQkK0sSipFA2YD+nHvcVYb2kjprxmbm1Lba/RhA/YinXTOZTuPQhxCzyve
 aqwTOolE5Fk6kVwn3jeshgG4lzwwDnto1o0/nz/mWPFq29yx6fPdO2oh4KDAUOcXBOwb
 nP/RlIOviqhu9zQguGSrUqnh2HnCxfqqfqy0PDnnIrWJqS05PRJ7SVt1mJpz5IHOp5ZU
 4BWw==
X-Gm-Message-State: AOJu0YzIk69l0QNFY1iQdfirDi58pMNMHXJGDCAMvFyctvpLV3Ec1lcj
 CdZTqkWKr/u52f+xLXGSiibdtebVu5h/KlLWC32ySV9lcquC9I1uqBOgnrKH4LZJKn+X9CeLAPj
 XXnVZmkiefLZQcqSZ6+aPUP4c4wfIwkQOZ0xvx6ets4c5uzFLMX3RHdJAJRExvA4c1Dh9NoQi8y
 aSCVzmvfcTZL1V9AdXakMwka69Jkyxhx+pzlON
X-Gm-Gg: ASbGncsMlJ7peHsLsmPQzYrcIe/qZvzCIuw8FRedCzn2MVZriylmYiA65+0xNgN2ZjB
 QgOrnpK3DjrXo7BZbIB9qsudsCpse0aLf/KDCHGcfCCx3WfC1POiu1FVK22LH5TXZu6ZbxjHpxt
 Ss8TSnjGi7K45UTZ1L4V2jirW6Hz4mgTSfrjW3CdtGvmjoATMKynyOMgpGvRGR9WExbFd1jlNa1
 n4rtq6jKWcbfZHKQCMEHk3F/JnHa7zDk/ou++/nZH1862yjehzhww==
X-Received: by 2002:a05:600c:1c96:b0:431:5632:448b with SMTP id
 5b1f17b1804b1-434fff9849dmr2482245e9.25.1733747888831; 
 Mon, 09 Dec 2024 04:38:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzxrIt2hL84FuIM5l+V57mX/GA9hUrrhEw+bUfQlZXN7YqyIgAcSrIvzXh5BA7Vs54nPmEKg==
X-Received: by 2002:a05:600c:1c96:b0:431:5632:448b with SMTP id
 5b1f17b1804b1-434fff9849dmr2482005e9.25.1733747888422; 
 Mon, 09 Dec 2024 04:38:08 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d527395csm189736155e9.17.2024.12.09.04.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:38:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 20/26] rust: re-export C types from qemu-api submodules
Date: Mon,  9 Dec 2024 13:37:11 +0100
Message-ID: <20241209123717.99077-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209123717.99077-1-pbonzini@redhat.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Long term we do not want device code to use "bindings" at all, so make it
possible to get the relevant types from the other modules of qemu-api.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qdev.rs    |  7 +++++--
 rust/qemu-api/src/qom.rs     | 10 ++++++----
 rust/qemu-api/src/sysbus.rs  |  3 ++-
 rust/qemu-api/src/vmstate.rs |  9 +++++----
 rust/qemu-api/tests/tests.rs |  3 ++-
 5 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 1228dabaaaf..96a4b1515da 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -6,10 +6,13 @@
 
 use std::ffi::CStr;
 
+pub use bindings::{DeviceClass, DeviceState, Property};
+
 use crate::{
-    bindings::{self, DeviceClass, DeviceState, Error, ObjectClass, Property, VMStateDescription},
+    bindings::{self, Error},
     prelude::*,
-    qom::ClassInitImpl,
+    qom::{ClassInitImpl, ObjectClass},
+    vmstate::VMStateDescription,
     zeroable::Zeroable,
 };
 
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 9b316e07efa..6e3923d8ed0 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -36,7 +36,9 @@
 
 use std::{ffi::CStr, os::raw::c_void};
 
-use crate::bindings::{self, Object, ObjectClass, TypeInfo};
+pub use bindings::{Object, ObjectClass};
+
+use crate::bindings::{self, TypeInfo};
 
 unsafe extern "C" fn rust_instance_init<T: ObjectImpl>(obj: *mut Object) {
     // SAFETY: obj is an instance of T, since rust_instance_init<T>
@@ -161,8 +163,8 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
 ///
 /// Each struct will implement this trait with `T` equal to each
 /// superclass.  For example, a device should implement at least
-/// `ClassInitImpl<`[`DeviceClass`](crate::bindings::DeviceClass)`>` and
-/// `ClassInitImpl<`[`ObjectClass`](crate::bindings::ObjectClass)`>`.
+/// `ClassInitImpl<`[`DeviceClass`](crate::qdev::DeviceClass)`>` and
+/// `ClassInitImpl<`[`ObjectClass`]`>`.
 ///
 /// Fortunately, this is almost never necessary.  Instead, the Rust
 /// implementation of methods will usually come from a trait like
@@ -193,7 +195,7 @@ pub trait ClassInitImpl<T> {
     ///
     /// The virtual method implementations usually come from another
     /// trait, for example [`DeviceImpl`](crate::qdev::DeviceImpl)
-    /// when `T` is [`DeviceClass`](crate::bindings::DeviceClass).
+    /// when `T` is [`DeviceClass`](crate::qdev::DeviceClass).
     ///
     /// On entry, `klass`'s parent class is initialized, while the other fields
     /// are all zero; it is therefore assumed that all fields in `T` can be
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index fa69cadd7c1..a23562d7273 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -7,10 +7,11 @@
 pub use bindings::{SysBusDevice, SysBusDeviceClass};
 
 use crate::{
-    bindings::{self, DeviceClass},
+    bindings,
     cell::bql_locked,
     irq::InterruptSource,
     prelude::*,
+    qdev::DeviceClass,
     qom::ClassInitImpl,
 };
 
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index bedcf1e8f39..25c68b703ea 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -10,6 +10,8 @@
 //! [`vmstate_fields`](crate::vmstate_fields) are meant to be used when
 //! declaring a device model state struct.
 
+pub use crate::bindings::VMStateDescription;
+
 #[doc(alias = "VMSTATE_UNUSED_BUFFER")]
 #[macro_export]
 macro_rules! vmstate_unused_buffer {
@@ -328,7 +330,7 @@ macro_rules! vmstate_fields {
 }
 
 /// A transparent wrapper type for the `subsections` field of
-/// [`VMStateDescription`](crate::bindings::VMStateDescription).
+/// [`VMStateDescription`].
 ///
 /// This is necessary to be able to declare subsection descriptions as statics,
 /// because the only way to implement `Sync` for a foreign type (and `*const`
@@ -342,9 +344,8 @@ macro_rules! vmstate_fields {
 
 unsafe impl Sync for VMStateSubsectionsWrapper {}
 
-/// Helper macro to declare a list of subsections
-/// ([`VMStateDescription`](`crate::bindings::VMStateDescription`)) into a
-/// static and return a pointer to the array of pointers it created.
+/// Helper macro to declare a list of subsections ([`VMStateDescription`])
+/// into a static and return a pointer to the array of pointers it created.
 #[macro_export]
 macro_rules! vmstate_subsections {
     ($($subsection:expr),*$(,)*) => {{
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index fc57eb81290..68557fb85c7 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -8,8 +8,9 @@
     bindings::*,
     c_str, declare_properties, define_property,
     prelude::*,
-    qdev::DeviceImpl,
+    qdev::{DeviceImpl, DeviceState, Property},
     qom::ObjectImpl,
+    vmstate::VMStateDescription,
     zeroable::Zeroable,
 };
 
-- 
2.47.1


