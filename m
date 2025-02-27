Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D842C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnelD-000824-5s; Thu, 27 Feb 2025 09:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekr-0007Ov-SZ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tneko-0003ot-Ry
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q60znN5LHGAuKN5cvbnnTxdVSjdEKcjfrdyADjSGY/8=;
 b=CuEdutb1711u8Kd3/FC70iq/I4Ta2RrUT6FTRRdQFbKpWwuBC6gr9P5Cd1xAio8vRcglli
 c8MWMGR/DA+NFA8DWtyIGuW5xuLQ6I5v94pZa4os+43hKma5MeM9StdKTwaBnh7QkVEls7
 2Io2cvH9ErfHHNDWSePOiz8K8Iq4F0k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-5RawHmHOPJeZUdNtRaqPPw-1; Thu, 27 Feb 2025 09:20:44 -0500
X-MC-Unique: 5RawHmHOPJeZUdNtRaqPPw-1
X-Mimecast-MFC-AGG-ID: 5RawHmHOPJeZUdNtRaqPPw_1740666044
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-abbb44abae6so103500366b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666043; x=1741270843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q60znN5LHGAuKN5cvbnnTxdVSjdEKcjfrdyADjSGY/8=;
 b=nR8ysKzKX0whsC92Bxi1ZP6OEWes+Wbqdk1gJP4C03A9hwHtmIqtjJydVljVQ6MWre
 Qqb5BE0byw0TICAS8QRbb4BD/wD83sTE+DOLADC3lJVt+IbnZ2AWes66XJ2O354Mvmxn
 yYBy5HkkkqWEjwumTpeU/dQcTUWvsU47CEdQ96rdh4kV0+EtVZOw+boDqb45QRJF8XiY
 2z7yMPZ6VfZi4F/jLKxXdBQXKgugU6cJZ0TfrMW9aYLKsuP76wFYszoz/CWFlHjI2En1
 Ek6BcNhjoyU/qEJrxSvp1GOtmpt6ucTwFSfrKhHsfRGq7u6boyx974L4pbzCPxkER5Za
 XHAA==
X-Gm-Message-State: AOJu0YxjDCWUq3nAuDvzy98zCHt2f2YQn7MfGGsDn+0TcA7Rvxgh93Fr
 DkbCmPqqlXvErSH1Rh+9pbFvmqJ/gQn/K/1kikUFMmE922A6TMSsUtq2KMhQIKlhoixZgdfn+ZB
 1ecUfztS3zemJjdeU/brZFNJTyX/SG8acuXV6QMz6z6IEmz71aMF8OXP2cOgx1SrisgtGYFOfgG
 aWEbE2oqAYSCJ+qlLdKmS6xhRlvpscoKfyWxAn8vg=
X-Gm-Gg: ASbGncv4ezNP8CQRMvRxu755IKx30AYuBd7KLA6oWB2voamd8VulKabAwZo3lsMOEt3
 LO9nkeDj5/ZKU6M1hwRoZUaW45nhoAQ68q6Aait5pAsAlRg6vt06FtHN2u0/caNF4dyW6Mz5LVB
 0+xKxaa2RaW0r3KMPmGOVIWnEzzaU5HiFGOso19sD302Sp6fJk6fDz20c418WwuvxPXWwwbdmc7
 AC17zwnRT7ebG7WXbITsZ2z+oZmElKbyLNo2Q5Bj3D35VOvtdsnJ84KYjLVmrkMWImTMOyKEE/4
 0dYSwPgTqFYiJTy8XqC4
X-Received: by 2002:a17:907:7d89:b0:ab7:6bb3:b14b with SMTP id
 a640c23a62f3a-abc0da33611mr3300699166b.30.1740666042779; 
 Thu, 27 Feb 2025 06:20:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFb1bHwxk1EffUFOzZVieNJknGQA3xXnKmKjwXesUr64bD662hrJtfxu4y5jpFLM/XDlaNRww==
X-Received: by 2002:a17:907:7d89:b0:ab7:6bb3:b14b with SMTP id
 a640c23a62f3a-abc0da33611mr3300695766b.30.1740666042282; 
 Thu, 27 Feb 2025 06:20:42 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c75c333sm130592566b.145.2025.02.27.06.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 22/34] rust: qom: add ObjectImpl::CLASS_INIT
Date: Thu, 27 Feb 2025 15:19:40 +0100
Message-ID: <20250227141952.811410-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

As shown in the PL011 device, the orphan rules required a manual
implementation of ClassInitImpl for anything not in the qemu_api crate;
this gets in the way of moving system emulation-specific code (including
DeviceClass, which as a blanket ClassInitImpl<DeviceClass> implementation)
into its own crate.

Make ClassInitImpl optional, at the cost of having to specify the CLASS_INIT
member by hand in every implementation of ObjectImpl.  The next commits will
get rid of it, replacing all the "impl<T> ClassInitImpl<Class> for T" blocks
with a generic class_init<T> method on Class.

Right now the definition is always the same, but do not provide a default
as that will not be true once ClassInitImpl goes away.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |  3 +++
 rust/hw/timer/hpet/src/hpet.rs   |  3 ++-
 rust/qemu-api/src/qom.rs         | 14 +++++++++++---
 rust/qemu-api/tests/tests.rs     |  3 +++
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index bea9723aed8..ead361b3f52 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -160,6 +160,7 @@ impl ObjectImpl for PL011State {
 
     const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
     const INSTANCE_POST_INIT: Option<fn(&Self)> = Some(Self::post_init);
+    const CLASS_INIT: fn(&mut Self::Class) = <Self as ClassInitImpl<Self::Class>>::class_init;
 }
 
 impl DeviceImpl for PL011State {
@@ -744,6 +745,8 @@ unsafe impl ObjectType for PL011Luminary {
 
 impl ObjectImpl for PL011Luminary {
     type ParentType = PL011State;
+
+    const CLASS_INIT: fn(&mut Self::Class) = <Self as ClassInitImpl<Self::Class>>::class_init;
 }
 
 impl DeviceImpl for PL011Luminary {}
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index b4ffccf815f..e01b4b67064 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -21,7 +21,7 @@
     },
     prelude::*,
     qdev::{DeviceImpl, DeviceMethods, DeviceState, Property, ResetType, ResettablePhasesImpl},
-    qom::{ObjectImpl, ObjectType, ParentField},
+    qom::{ClassInitImpl, ObjectImpl, ObjectType, ParentField},
     qom_isa,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
     timer::{Timer, CLOCK_VIRTUAL},
@@ -836,6 +836,7 @@ impl ObjectImpl for HPETState {
 
     const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
     const INSTANCE_POST_INIT: Option<fn(&Self)> = Some(Self::post_init);
+    const CLASS_INIT: fn(&mut Self::Class) = <Self as ClassInitImpl<Self::Class>>::class_init;
 }
 
 // TODO: Make these properties user-configurable!
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 10ce359becb..d821ac25acc 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -180,7 +180,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
     T::INSTANCE_POST_INIT.unwrap()(unsafe { state.as_ref() });
 }
 
-unsafe extern "C" fn rust_class_init<T: ObjectType + ClassInitImpl<T::Class>>(
+unsafe extern "C" fn rust_class_init<T: ObjectType + ObjectImpl>(
     klass: *mut ObjectClass,
     _data: *mut c_void,
 ) {
@@ -190,7 +190,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
     // SAFETY: klass is a T::Class, since rust_class_init<T>
     // is called from QOM core as the class_init function
     // for class T
-    T::class_init(unsafe { klass.as_mut() })
+    <T as ObjectImpl>::CLASS_INIT(unsafe { klass.as_mut() })
 }
 
 unsafe extern "C" fn drop_object<T: ObjectImpl>(obj: *mut Object) {
@@ -499,7 +499,7 @@ impl<T: ObjectType> ObjectDeref for &mut T {}
 impl<T: ObjectType> ObjectCastMut for &mut T {}
 
 /// Trait a type must implement to be registered with QEMU.
-pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> + IsA<Object> {
+pub trait ObjectImpl: ObjectType + IsA<Object> {
     /// The parent of the type.  This should match the first field of the
     /// struct that implements `ObjectImpl`, minus the `ParentField<_>` wrapper.
     type ParentType: ObjectType;
@@ -552,6 +552,14 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> + IsA<Object> {
 
     // methods on ObjectClass
     const UNPARENT: Option<fn(&Self)> = None;
+
+    /// Store into the argument the virtual method implementations
+    /// for `Self`.  On entry, the virtual method pointers are set to
+    /// the default values coming from the parent classes; the function
+    /// can change them to override virtual methods of a parent class.
+    ///
+    /// Usually defined as `<Self as ClassInitImpl<Self::Class>::class_init`.
+    const CLASS_INIT: fn(&mut Self::Class);
 }
 
 /// Internal trait used to automatically fill in a class struct.
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 03569e4a44c..9546e9d7963 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -60,6 +60,7 @@ unsafe impl ObjectType for DummyState {
 impl ObjectImpl for DummyState {
     type ParentType = DeviceState;
     const ABSTRACT: bool = false;
+    const CLASS_INIT: fn(&mut DummyClass) = <Self as ClassInitImpl<DummyClass>>::class_init;
 }
 
 impl ResettablePhasesImpl for DummyState {}
@@ -102,6 +103,8 @@ unsafe impl ObjectType for DummyChildState {
 impl ObjectImpl for DummyChildState {
     type ParentType = DummyState;
     const ABSTRACT: bool = false;
+    const CLASS_INIT: fn(&mut DummyChildClass) =
+        <Self as ClassInitImpl<DummyChildClass>>::class_init;
 }
 
 impl ResettablePhasesImpl for DummyChildState {}
-- 
2.48.1


