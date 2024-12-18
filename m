Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730EAE77183
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 06:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNniQ-0007EE-Fs; Wed, 18 Dec 2024 01:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNniN-0007Ct-9N; Wed, 18 Dec 2024 01:39:23 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tNniK-0001KA-3o; Wed, 18 Dec 2024 01:39:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734503960; x=1766039960;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=0j7yWL1ku3s8tx6AjaydGcnQsUTd3IjyXBmPGFmWXw4=;
 b=GvFvsplt2pUE2lgTitB1sbsiAQXoGTlk/lNcZ17yPMZngwJvAiEs/V+6
 /SfcNnxAboJqciCm3Zsq3UoyFne1OSFXhdriCynMQfmtuI8ksoPXNnyVv
 is5PTBBG5ownrfGD45WFiQWm7wpTk/pCQ9rBMJGKGTRfrqOyYOkOaikQC
 OhNjj1bMoBp3FbgXUpaGF8KId1uh3UnOoXkRKAzNMm/lWRidyRAqpayRT
 O9db9d1RCyJ9zXi0u+8K1GpErwm9qXasvuQZ0YIwCbZP4wneQW6xdhDJJ
 a5aJiTExrjAnWhkhFNsmJ7BqASg667RO6ae3iC7a4BGBpHjSzo1Or8UWi g==;
X-CSE-ConnectionGUID: 7d4lqVZhQ8KqsxyM7AZeww==
X-CSE-MsgGUID: MYBb8/2/TnuYxp+LGqMWgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="38639578"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; d="scan'208";a="38639578"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2024 22:39:16 -0800
X-CSE-ConnectionGUID: miwF27DHQMy1dnIxi9voKQ==
X-CSE-MsgGUID: VCB4b5HMSme3Hf7isY3xtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; d="scan'208";a="102604995"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 17 Dec 2024 22:39:14 -0800
Date: Wed, 18 Dec 2024 14:57:54 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 24/26] rust: qom: move device_id to PL011 class side
Message-ID: <Z2JycooziPsfV8vX@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-25-pbonzini@redhat.com>
 <Z2D2zk2Wdlqc5q2k@intel.com>
 <CABgObfY=jyu96eZ+ZcU9GXU+amt2wRm53vpvubHYTaeY9MWd2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfY=jyu96eZ+ZcU9GXU+amt2wRm53vpvubHYTaeY9MWd2A@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Dec 17, 2024 at 05:50:09PM +0100, Paolo Bonzini wrote:
> Date: Tue, 17 Dec 2024 17:50:09 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH 24/26] rust: qom: move device_id to PL011 class side
> 
> Il mar 17 dic 2024, 04:39 Zhao Liu <zhao1.liu@intel.com> ha scritto:
> 
> > > +impl ClassInitImpl<PL011Class> for PL011State {
> > > +    fn class_init(klass: &mut PL011Class) {
> > > +        klass.device_id = DeviceId::ARM;
> > > +        <Self as ClassInitImpl<SysBusDeviceClass>>::class_init(&mut
> > klass.parent_class);
> >
> > This seems a bit of a conflict with the C version of QOM semantics. In C,
> > class_init is registered in TypeInfo, and then the QOM code will
> > automatically call the parent's class_init without needing to explicitly
> > call the parent's in the child's class_init.
> >
> 
> This is the same in Rust.
> 
> The difference is that in C you have a single class_init function that sets
> all members of ObjectClass, DeviceClass, etc. In Rust each class has one
> trait and there is a chain of ClassInitImpl implementations—one filling in
> "oc" from ObjectImpl, one filling in "dc" from DeviceImpl and so on.
>
> But in both cases you get a chain of calls from qom/object.c.
> 
> Therefore, the call here seems valid from the code logic's perspective.

I supposed a case, where there is such a QOM (QEMU Object Model)
structure relationship:

* DummyState / DummyClass: defined in Rust side, and registered the
  TypeInfo by `Object` macro.

  - So its class_init will be called by C QOM code.

* DummyChildState / DummyChildClass: defined in Rust side as the
  child-object of DummyState, and registered the TypeInfo by `Object`
  macro. And suppose it can inherit the trait of DummyClass -
  ClassInitImpl<DummyClass> (but I found a gap here, as detailed later;
  I expect it should be able to inherit normally).

 - So its class_init will be called by C QOM code. In C code call chain,
   its parent's class_init should be called by C before its own
   class_init.
 - However, note that according to the Rust class initialization call
   chain, it should also call the parent's class_init within its own
   class_init.
 - :( the parent's class_init gets called twice.

If you agree this case indeed exists, then I think we should distinguish
between different class_init methods for the Rust and C call chains.

Moving on to another topic, about the gap (or question :-)) where a
child class inherits the ClassInitImpl trait from the parent, please see
my test case example below: Doing something similar to SysBusDevice and
DeviceState using a generic T outside of the QOM library would violate
the orphan rule.

diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 7edadf911cca..8cae222a37be 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -13,8 +13,8 @@
 use qemu_api::{
     bindings::*,
     c_str, declare_properties, define_property,
-    qdev::{DeviceImpl, DeviceState, Property},
-    qom::{ObjectCast, ObjectCastMut, ObjectImpl, ObjectMethods, ObjectType},
+    qdev::{DeviceClass, DeviceImpl, DeviceState, Property},
+    qom::{ClassInitImpl, ObjectCast, ObjectCastMut, ObjectImpl, ObjectMethods, ObjectType},
     qom_isa,
     vmstate::VMStateDescription,
     zeroable::Zeroable,
@@ -37,6 +37,10 @@ pub struct DummyState {

 qom_isa!(DummyState: Object, DeviceState);

+pub struct DummyClass {
+    parent_class: <DeviceState as ObjectType>::Class,
+}
+
 declare_properties! {
     DUMMY_PROPERTIES,
         define_property!(
@@ -49,7 +53,7 @@ pub struct DummyState {
 }

 unsafe impl ObjectType for DummyState {
-    type Class = <DeviceState as ObjectType>::Class;
+    type Class = DummyClass;
     const TYPE_NAME: &'static CStr = c_str!("dummy");
 }

@@ -67,6 +71,51 @@ fn vmsd() -> Option<&'static VMStateDescription> {
     }
 }

+// `impl<T> ClassInitImpl<DummyClass> for T` doesn't work since it violates orphan rule.
+impl ClassInitImpl<DummyClass> for DummyState {
+    fn class_init(klass: &mut DummyClass) {
+        <Self as ClassInitImpl<DeviceClass>>::class_init(&mut klass.parent_class);
+    }
+}
+
+#[derive(qemu_api_macros::offsets)]
+#[repr(C)]
+#[derive(qemu_api_macros::Object)]
+pub struct DummyChildState {
+    parent: DummyState,
+    migrate_clock: bool,
+}
+
+qom_isa!(DummyChildState: Object, DeviceState, DummyState);
+
+pub struct DummyChildClass {
+    parent_class: <DummyState as ObjectType>::Class,
+}
+
+unsafe impl ObjectType for DummyChildState {
+    type Class = DummyChildClass;
+    const TYPE_NAME: &'static CStr = c_str!("dummy_child");
+}
+
+impl ObjectImpl for DummyChildState {
+    type ParentType = DummyState;
+    const ABSTRACT: bool = false;
+}
+
+impl DeviceImpl for DummyChildState {}
+
+impl ClassInitImpl<DummyClass> for DummyChildState {
+    fn class_init(klass: &mut DummyClass) {
+        <Self as ClassInitImpl<DeviceClass>>::class_init(&mut klass.parent_class);
+    }
+}
+
+impl ClassInitImpl<DummyChildClass> for DummyChildState {
+    fn class_init(klass: &mut DummyChildClass) {
+        <Self as ClassInitImpl<DummyClass>>::class_init(&mut klass.parent_class);
+    }
+}
+
 fn init_qom() {
     static ONCE: Mutex<Cell<bool>> = Mutex::new(Cell::new(false));

@@ -85,6 +134,7 @@ fn test_object_new() {
     init_qom();
     unsafe {
         object_unref(object_new(DummyState::TYPE_NAME.as_ptr()).cast());
+        object_unref(object_new(DummyChildState::TYPE_NAME.as_ptr()).cast());
     }
 }

> > But, when there is deeper class inheritance, it seems impossible to
> > prevent class_init from being called both by the C side's QOM code and by
> > this kind of recursive case on the Rust side.
> >
> 
> Note that here you have two parameters: what class is being filled (the
> argument C of ClassInitImpl<C>) *and* what type is being initialized
> (that's Self).
> 
> The "recursion" is only on the argument C, and matches the way C code
> implements class_init.

For Rust side, PL011Class' class_init calls SysBusDeviceClass' class_init,
and SysBusDeviceClass will also call DeviceClass' class_init. So this is
also recursion, right?

> Maybe the confusion is because I implemented class_init twice instead of
> using a separate trait "PL011Impl"?

Ah, yes! But I think the Rust call chain should not use class_init anymore
but should use a different method. This way, the original class_init would
only serve the C QOM. A separate trait might break the inheritance
relationship similar to ClassInitImpl.

Regards,
Zhao



