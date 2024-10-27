Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2204D1358A
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 22:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Bvm-00019F-4B; Sun, 27 Oct 2024 18:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t5Bvk-00018p-QX
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 18:40:16 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t5Bvg-00077F-QV
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 18:40:16 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9abe139088so545095566b.1
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 15:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730068810; x=1730673610; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MlcbIEV68T3lg3zHMGKuS41SE8rkss6CLwNsnvaaVWY=;
 b=xKavURr5TdRu22cb0qU7rgqf5mmqkBxQ9m33j//qdYooLlkA+jJZ9FTrKKQXA2gYnJ
 AFUA3EWqGlWChaHvy/4gKSQPScyP8Capu+s5lLTJDBsVortC1iQ6cmW/YcXlICsNcq4u
 LayahVf9lJxOS5B9y5Yr8OTJkFTCk0sTQ3Y2tqsN/t+oXiZptJ5vBUceHkJ30EacVjBv
 bjny4VKRsKcYIEUCfMiGB7MO56ykmzuOi42pj38sYxIWPWJcAJydsPHU0s9oAjWcstbj
 P8KyAbFGuGh8uoSG/7VHDDs0WFzRxPXr1cJIUv7Vag8OfRoaNrCChV7rQe5vhiDoaYzN
 uoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730068810; x=1730673610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MlcbIEV68T3lg3zHMGKuS41SE8rkss6CLwNsnvaaVWY=;
 b=WHivHid6Ge+r72lifgjN1TteNlINmKrmyem24JZs2TrjcxU+AsV38I2LyJy+Ly5Sip
 6l/B+ag4lBqhOh8LRBbX8GiC4CfWXP7AWY/Y2RB6/VX4sMXuf+8/XM4k0hf9CsZ5HCVr
 8xSK70q5vbgh1+TfgarokHwl4zV7bgzfaoSM3EQIx/ZQsjbJKjpefwwsTmG8tkpUmA+g
 wAaPNjTNV091YLKQWPnDRtJ80kw7PY7WWXX+tPc/4VOZiGy2RmfAqRWXaZe+zWwPqRcx
 Mx/xkPornvDllRxiOyQ0WeEP+BiT8svmXnGUcbFvDS1HLS2qWxhbi12nhsJrJzL2L4IS
 aE3g==
X-Gm-Message-State: AOJu0YyUQzIABLwLnKlD+zE+o/DdxNnXnWqJsB7HLwjtJ/lW1+LdTy0L
 4YIFjQ/ynyFuiQFVLHTK2Iv//Mk/yblXtc+l1uPOhyDeP32gsxj+Oo2QGI2UktZeyR07TFVhp9J
 sIOizfvJLxD6y6g05hqUWjTmjQrXWlCLpwNP0Gw==
X-Google-Smtp-Source: AGHT+IHpaisiznr3YmXVl/XJc+jPl2/50L6PpC01t9GOfWm9X0UdAwotv5NKDV/4Rs/qXm0oE0LZd7IV5NpMV+xQ4hI=
X-Received: by 2002:a17:906:6a1d:b0:a9a:18ee:5106 with SMTP id
 a640c23a62f3a-a9de61e95a5mr543813866b.65.1730068809814; Sun, 27 Oct 2024
 15:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
 <20241024-rust-round-2-v1-3-051e7a25b978@linaro.org>
 <f7d087fe-e9cb-4021-b816-df43656e22f5@redhat.com>
In-Reply-To: <f7d087fe-e9cb-4021-b816-df43656e22f5@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 28 Oct 2024 00:39:43 +0200
Message-ID: <CAAjaMXb+zzeZyrjdxO4ZAhWUOXN_Xoi5wuPJ4vYmJMsbV=gNWQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] rust/qemu-api-macros: introduce Device proc macro
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Thank you for the review comments Paolo. I will address any bits I did
wrong and not much the rest, it's obvious you have a disagreement over
how things are done and that's fine. This series does not attempt to
solve everything at once and arguing again and again over "this Trait
should have been OtherTrait and this thing should have been thing!()"
is not productive. Your review style of relentless disagreement after
disagreement is tiresome and impossible to deal with; it's like a
denial of service for other human beings. I suggest you take a step
back and take a deep breath before reviewing Rust patches again. I
assure you I will make sure to address all your comments either in
code, TODO comments, or patch messages.

In the meantime, take it easy.

On Sun, Oct 27, 2024 at 10:58=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> Hello,
>
> here is my second attempt to review this, this time placing the remarks
> as close as possible to the code that is affected.  However, the meat is
> the same as in my previous replies to the 03/11 thread.
>
> I hope this shows that I have practical concerns about the patch and
> it's not just FUD that it's not acceptable.
>
> On 10/24/24 16:03, Manos Pitsidianakis wrote:
> > Add a new derive procedural macro to declare device models. Add
> > corresponding DeviceImpl trait after already existing ObjectImpl trait.
> > At the same time, add instance_init, instance_post_init,
> > instance_finalize methods to the ObjectImpl trait and call them from th=
e
> > ObjectImplUnsafe trait, which is generated by the procedural macro.
> >
> > This allows all the boilerplate device model registration to be handled
> > by macros, and all pertinent details to be declared through proc macro
> > attributes or trait associated constants and methods.
> >
> > The device class can now be generated automatically and the name can be
> > optionally overridden:
> >
> >    ------------------------ >8 ------------------------
> >   #[repr(C)]
> >   #[derive(Debug, qemu_api_macros::Object, qemu_api_macros::Device)]
> >   #[device(class_name_override =3D PL011Class)]
> >   /// PL011 Device Model in QEMU
> >   pub struct PL011State {
>
> The first design issue is already visible here in this example.  I could
> place the same comment when the code appears in rust/hw/char/pl011, but
> it's easier to do it here.
>
> You have two derive macros, Object and Device.  Object is derived by all
> objects (even if right now we have only devices), Device is derived by
> devices only.
>
> The class name is a property of any object, not just devices.  It should
> not be part of the #[device()] attribute.  #[derive(Device)] and
> #[device()] instead should take care of properties and categories (and
> possibly vmstate, but I'm not sure about that and there's already enough
> to say about this patch).
>
>
> You also have no documentation, which means that users will have no idea
> of what are the other sub-attributes of #[device()], including the
> difference between class_name and class_name_override, or how categories
> are defined.
>
> Even if we don't have support for rustdoc yet in tree, we should have
> all the needed documentation as soon as the API moves from "ad hoc usage
> of C symbols" to idiomatic.
>
> > Object methods (instance_init, etc) methods are now trait methods:
> >
> >    ------------------------ >8 ------------------------
> >   /// Trait a type must implement to be registered with QEMU.
> >   pub trait ObjectImpl {
> >       type Class: ClassImpl;
> >       const TYPE_NAME: &'static CStr;
> >       const PARENT_TYPE_NAME: Option<&'static CStr>;
> >       const ABSTRACT: bool;
>
>
> Class, TYPE_NAME, PARENT_TYPE_NAME, ABSTRACT should be defined via
> #[object()].
>
> But actually, there is already room for defining a separate trait:
>
> /// # Safety
> ///
> /// - the first field of the struct must be of `Object` type,
> ///   or derived from it
> ///
> /// - `TYPE` must match the type name used in the `TypeInfo` (no matter
> ///   if it is defined in C or Rust).
> ///
> /// - the struct must be `#[repr(C)]`
> pub unsafe trait ObjectType {
>      type Class: ClassImpl;
>      const TYPE_NAME: &'static CStr;
> }
>
> ... because you can implement it even for classes that are defined in C
> code.  Then #[derive(Object)] can find the TYPE_NAME directly from the
> first field of the struct, i.e.
>
>       parent_obj: SysBusDevice;
>
> becomes
>
>      const PARENT_TYPE_NAME: Option<&'static CStr> =3D
>          Some(<SysBusDevice as TypeImpl>::TYPE_NAME);
>
> while #[object()] would be just
>
> #[object(class_type =3D PL011Class, type_name =3D "pl011")]
>
> Accessing the type of the first field is easy using the get_fields()
> function that Junjie added at
> https://lore.kernel.org/qemu-devel/20241025160209.194307-16-pbonzini@redh=
at.com/
>
> This shows another reason why I prefer to get CI to work first.  Having
> to do simple, but still non-trivial work, often provides code that can
> be reused in more complex setups.
>
> >       unsafe fn instance_init(&mut self) {}
> >       fn instance_post_init(&mut self) {}
> >       fn instance_finalize(&mut self) {}
> >   }
>
> In the trait, having a default implementation that is empty works
> (unlike for realize/reset, as we'll see later).  So this is a bit
> simpler.  However, instance_finalize should have a non-empty default
> implementation:
>
>         std::ptr::drop_in_place(self);
>
> which should be okay for most devices.
>
> Alternatively, leave out instance_post_init() and instance_finalize()
> until we need them, and put the drop_in_place() call directly in the
> unsafe function that goes in the TypeInfo.
>
> >    ------------------------ >8 ------------------------
> >
> > Device methods (realize/reset etc) are now safe idiomatic trait methods=
:
> >
> >    ------------------------ >8 ------------------------
> >   /// Implementation methods for device types.
> >   pub trait DeviceImpl: ObjectImpl {
> >       fn realize(&mut self) {}
> >       fn reset(&mut self) {}
> >   }
> >    ------------------------ >8 ------------------------
>
> This is an incorrect definition of the trait.  The default definition of
> device methods is not "empty", it's "just reuse the superclass
> implementation".  In particular, this means that PL011LuminaryState
> right now cannot use #[derive(Device)].
>
> > The derive Device macro is responsible for creating all the extern "C" =
FFI
> > functions that QEMU needs to call these methods.
>
> This is unnecessary.  It is perfectly possible to write the extern "C"
> functions (class_init, realize, reset) just once as either type-generic
> functions, or functions in a trait.  More on this later.
>
> > diff --git a/rust/qemu-api/src/objects.rs b/rust/qemu-api/src/objects.r=
s
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..5c6762023ed6914f9c6b7dd=
16a5e07f778c2d4fa
> > --- /dev/null
> > +++ b/rust/qemu-api/src/objects.rs
> > @@ -0,0 +1,90 @@
> > +// Copyright 2024, Linaro Limited
> > +// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +//! Implementation traits for QEMU objects, devices.
> > +
> > +use ::core::ffi::{c_int, c_void, CStr};
> > +
> > +use crate::bindings::{DeviceState, Error, MigrationPriority, Object, O=
bjectClass, TypeInfo};
> > +
> > +/// Trait a type must implement to be registered with QEMU.
> > +pub trait ObjectImpl {
> > +    type Class: ClassImpl;
> > +    const TYPE_NAME: &'static CStr;
> > +    const PARENT_TYPE_NAME: Option<&'static CStr>;
> > +    const ABSTRACT: bool;
>
> These consts should entirely be derived from the #[object()] attribute.
> You can facilitate the split by having two traits, one for things
> derived from the attribute (the above four), and one for the vtable.
>
> > +    unsafe fn instance_init(&mut self) {}
> > +    fn instance_post_init(&mut self) {}
> > +    fn instance_finalize(&mut self) {}
> > +}
>
> See above remark on the default implementation of instance_finalize.
>
> > +/// The `extern`/`unsafe` analogue of [`ObjectImpl`]; it is used inter=
nally by `#[derive(Object)]`
> > +/// and should not be implemented manually.
> > +pub unsafe trait ObjectImplUnsafe {
> > +    const TYPE_INFO: TypeInfo;
> > +
> > +    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)=
>;
> > +    const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Ob=
ject)>;
> > +    const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Obj=
ect)>;
> > +}
> > +
>
> This trait is not needed at all, because it really has juts one
> implementation.  The fact that there is just one implementation is
> hidden by the fact that you are generating the code instead of relying
> on the type system.
>
> All you need is a single function, which will be called via the
> module_init mechanism:
>
> fn rust_type_register<T: ObjectImpl>() {
>      let TypeInfo ti =3D ...;
>      unsafe { type_register(&ti); }
> }
>
> >
> > +/// Methods for QOM class types.
> > +pub trait ClassImpl {
> > +    type Object: ObjectImpl;
> > +
> > +    unsafe fn class_init(&mut self, _data: *mut core::ffi::c_void) {}
> > +    unsafe fn class_base_init(&mut self, _data: *mut core::ffi::c_void=
) {}
> > +}
> > +
>
> This trait (or more precisely class_init and class_base_init) is not
> needed.  class_base_init is only needed in very special cases, we can
> just decide they won't be available in Rust for now and possible for ever=
.
>
> As to class_init device XYZ would only need a non-empty class_init
> method if we added support for the _data argument.  But then we would
> need a way to provide the type of _data, and to cast _data to the
> appropriate type; we would also need a way to provide a mapping from
> multiple data objects to multiple type names, which is hard to do
> because right now each Rust struct has a single type name associated.
>
> So, let's just keep only the auto-generated class_init for simplicity.
> If we can just decide that, if device XYZ has superclass FooDevice, it
> implements FooDeviceImpl and class_init is provided by the FooDevice
> bindings.
>
> I can't really say if the "type Object" part is needed.  I couldn't
> offhand find anything that uses it, but I may have missed it.  If so, it
> can be in ClassImplUnsafe.
>
> > +/// The `extern`/`unsafe` analogue of [`ClassImpl`]; it is used intern=
ally by `#[derive(Object)]`
> > +/// and should not be implemented manually.
> > +pub unsafe trait ClassImplUnsafe {
> > +    const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectCl=
ass, data: *mut c_void)>;
> > +    const CLASS_BASE_INIT: Option<
> > +        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_voi=
d),
> > +    >;
> > +}
>
> Again, no need to have CLASS_BASE_INIT here.
>
> > +/// Implementation methods for device types.
> > +pub trait DeviceImpl: ObjectImpl {
> > +    fn realize(&mut self) {}
> > +    fn reset(&mut self) {}
> > +}
>
> These unfortunately cannot be functions.  Doing so forces the class_init
> method to assign both dc->reset and dc->realize for _all_ classes,
> whereas for example PL011LuminaryClass would not override either.
>
> Therefore, the definition must be
>
> pub trait DeviceImpl: ObjectImpl {
>      const REALIZE: Option<fn realize(&mut self)> =3D None;
>      const RESET: Option<fn realize(&mut self)> =3D None;
> }
>
> Yes, it's uglier, but we cannot escape the fact that we're implementing
> something that Rust doesn't have natively (inheritance). :(  So we
> cannot use language features meant for a completely different kind of
> polymorphism.
>
> > +/// The `extern`/`unsafe` analogue of [`DeviceImpl`]; it is used inter=
nally by `#[derive(Device)]`
> > +/// and should not be implemented manually.
> > +pub unsafe trait DeviceImplUnsafe {
> > +    const REALIZE: Option<unsafe extern "C" fn(dev: *mut DeviceState, =
_errp: *mut *mut Error)>;
> > +    const RESET: Option<unsafe extern "C" fn(dev: *mut DeviceState)>;
> > +}
>
> This trait is also unnecessary, because all that you need is a single
> function:
>
> fn rust_device_class_init<T: DeviceImpl>(
>      klass: *mut ObjectClass, _data: *mut c_void)
>
> defined outside the procedural macro.  #[derive(Device)] can define
> ClassImplUnsafe to point CLASS_INIT to rust_device_class_init.
>
> (Later, rust_device_class_init() can be moved into a trait so that it's
> possible to define other classes of devices, for example PCI devices.
> Note that such an extension would be much easier, than if it was
> _required_ to touch the procedural macro).
>
> >
> > +/// Constant metadata and implementation methods for types with device=
 migration state.
> > +pub trait Migrateable: DeviceImplUnsafe {
> > +    const NAME: Option<&'static CStr> =3D None;
> > +    const UNMIGRATABLE: bool =3D true;
> > +    const EARLY_SETUP: bool =3D false;
> > +    const VERSION_ID: c_int =3D 1;
> > +    const MINIMUM_VERSION_ID: c_int =3D 1;
> > +    const PRIORITY: MigrationPriority =3D MigrationPriority::MIG_PRI_D=
EFAULT;
> > +
> > +    unsafe fn pre_load(&mut self) -> c_int {
> > +        0
> > +    }
> > +    unsafe fn post_load(&mut self, _version_id: c_int) -> c_int {
> > +        0
> > +    }
> > +    unsafe fn pre_save(&mut self) -> c_int {
> > +        0
> > +    }
> > +    unsafe fn post_save(&mut self) -> c_int {
> > +        0
> > +    }
> > +    unsafe fn needed(&mut self) -> bool {
> > +        false
> > +    }
> > +    unsafe fn dev_unplug_pending(&mut self) -> bool {
> > +        false
> > +    }
> > +}
>
> Premature.  No need to add this trait until you add support for migration=
.
>
> > diff --git a/rust/qemu-api/src/tests.rs b/rust/qemu-api/src/tests.rs
> > deleted file mode 100644
> > index df54edbd4e27e7d2aafc243355d1826d52497c21..00000000000000000000000=
00000000000000000
> > --- a/rust/qemu-api/src/tests.rs
> > +++ /dev/null
> > @@ -1,49 +0,0 @@
>
> Nope.  Fix the test, don't remove it.
>
>
> > -#[derive(Debug, qemu_api_macros::Object)]
> > +#[derive(Debug, qemu_api_macros::Object, qemu_api_macros::Device)]
> > +#[device(class_name_override =3D PL011Class)]
> >   /// PL011 Device Model in QEMU
> >   pub struct PL011State {
> >       pub parent_obj: SysBusDevice,
> > @@ -51,6 +52,7 @@ pub struct PL011State {
> >       pub read_count: usize,
> >       pub read_trigger: usize,
> >       #[doc(alias =3D "chr")]
> > +    #[property(name =3D c"chardev", qdev_prop =3D qdev_prop_chr)]
>
> (See earlier comments on accepting only a LitStr and deriving qdev_prop
> from the type).
>
> > +impl DeviceImpl for PL011State {
> > +    fn realize(&mut self) {
> > +        ...
> > +    }
> > +
> > +    fn reset(&mut self) {
> > +        ...
> > +    }
>
> This extractions of code into DeviceImpl is good.  However, as I said
> above, I'm not sure about the trait itself.  I'll remark later when I
> encounter the definition.
>
> > +impl qemu_api::objects::Migrateable for PL011State {}
>
> Premature.
>
> Before moving on to the procedural macro code, my proposal to split the
> patches is:
>
> 1) introduce the trait ObjectType, define it for Object, DeviceState and
> SysBusDevice.
>
> 2) introduce the traits ObjectImpl, DeviceImpl and ClassImplUnsafe.
> Define the first two for PL011State.
>
> 3) add to common code the wrappers that call into DeviceImpl, removing
> them from PL011State
>
> 4) introduce the functions rust_type_register and rust_device_class_init
> that use the traits.
>
> 5) remove most arguments of device_class_init!(), using the
> infrastructure introduced in the previous two steps
>
> 6) split ObjectImpl into a part that will be covered by #[object()],
> let's call it ObjectInfo
>
> 7) add implementation of #[object()], replace PL011State's
> implementation of ObjectInfo with #[object()]
>
> 8) split DeviceImpl into a part that will be covered by #[device()]
> (properties and categories), let's call it DeviceInfo
>
> 9) add #[derive(Device) and implementation of #[device()], replace
> PL011State's implementation of DeviceInfo with #[device()]
>
> Where 1-5 should be submitted as a separate series, one that does not
> touch procedural macros *at all* and just generalizes the pl011 code
> that defines QOM types.
>
>
> Anyhow, I'll continue reviewing the procedural macro code.
>
> > +#[derive(Debug, Default)]
> > +struct DeriveContainer {
> > +    category: Option<syn::Path>,
> > +    class_name: Option<syn::Ident>,
> > +    class_name_override: Option<syn::Ident>,
> > +}
>
> Rename to DeviceAttribute.
>
> > +impl Parse for DeriveContainer {
> > +    fn parse(input: ParseStream) -> Result<Self> {
>
> syn::Result represents a parse error, not an error in the allowed syntax
> of the attribute.  Below, you're using panic! and unwrap(), but probably
> instead of syn::Result we need to have something like
>
> pub enum Error {
>      CompileError(syn::Span, String),
>      ParseError(syn::Error)
> }
>
> which extends the CompileError enum of
> https://lore.kernel.org/qemu-devel/20241025160209.194307-16-pbonzini@redh=
at.com/
> and is amenable to use with "?".  In particular, note the idiom used by
> the root derive_offsets() functions:
>
>      let input =3D parse_macro_input!(input as DeriveInput);
>      let expanded =3D derive_offsets_or_error(input).
>          unwrap_or_else(Into::into);
>
>      TokenStream::from(expanded)
>
> which works via an "impl From<CompileError> for proc_macro2::TokenStream"=
.
>
> I believe that most of the benefit of this series (basically, all except
> the #[property] attribute) can be obtained without the procedural macro.
>   Therefore, once we do add the procedural macro, we should not have it
> panic on errors.
>
> > +        let _: syn::Token![#] =3D input.parse()?;
> > +        let bracketed;
> > +        _ =3D syn::bracketed!(bracketed in input);
> > +        assert_eq!(DEVICE, bracketed.parse::<syn::Ident>()?);
> > +        let mut retval =3D Self {
> > +            category: None,
> > +            class_name: None,
> > +            class_name_override: None,
> > +        };
> > +        let content;
> > +        _ =3D syn::parenthesized!(content in bracketed);
> > +        while !content.is_empty() {
> > +            let value: syn::Ident =3D content.parse()?;
> > +            if value =3D=3D CLASS_NAME {
> > +                let _: syn::Token![=3D] =3D content.parse()?;
> > +                if retval.class_name.is_some() {
> > +                    panic!("{} can only be used at most once", CLASS_N=
AME);
> > +                }
>
> No panic!, instead we need to return a compile_error!() TokenStream, or
> as above a Result<> that can be converted to compile_error!() up in the
> chain.
>
> > +                retval.class_name =3D Some(content.parse()?);
>
> Please make this function a separate trait in utilities:
>
> trait AttributeParsing {
>      const NAME: Symbol;
>      fn set(&mut self, key: &syn::Ident, input: &ParseStream) -> Result<(=
)>;
>      fn parse(input: ParseStream) -> Result<Self> { ... }
> }
>
> Then the "if" can move to the struct-specific implementation of
> AttributeParsing::set, while the rest can move to the default
> implementation of AttributeParsing::parse.
>
> #[property()] and #[device()] (and also the proposed #[object()]) can
> then share the implementation of AttributeParsing::parse.
>
> > +            } else if value =3D=3D CLASS_NAME_OVERRIDE {
> > +                let _: syn::Token![=3D] =3D content.parse()?;
> > +                if retval.class_name_override.is_some() {
> > +                    panic!("{} can only be used at most once", CLASS_N=
AME_OVERRIDE);
> > +                }> +                retval.class_name_override =3D Som=
e(content.parse()?);
> > +            } else if value =3D=3D CATEGORY {
> > +                let _: syn::Token![=3D] =3D content.parse()?;
> > +                if retval.category.is_some() {
> > +                    panic!("{} can only be used at most once", CATEGOR=
Y);
> > +                }
> > +                let lit: syn::LitStr =3D content.parse()?;
> > +                let path: syn::Path =3D lit.parse()?;
>
> Do I understand that this would be
>
>     category =3D "foo::bar::Baz"
>
> ?  If so, why the extra quotes?  There can actually be more than one
> category, so at least add a TODO here.
>
> > +#[derive(Debug)]
> > +struct QdevProperty {
> > +    name: Option<syn::LitCStr>,
>
> Just LitStr.  Convert it to CString in the macro.  You can reuse the
> c_str!() macro that I'm adding in the series to fix CI and support old
> rustc, i.e. quote! { ::qemu_api::c_str!(#name) } or something like that.
>
> > +    qdev_prop: Option<syn::Path>,
> > +}
> > +
> > +impl Parse for QdevProperty {
> > +    fn parse(input: ParseStream) -> Result<Self> {
> > +        let _: syn::Token![#] =3D input.parse()?;
> > +        let bracketed;
> > +        _ =3D syn::bracketed!(bracketed in input);
> > +        assert_eq!(PROPERTY, bracketed.parse::<syn::Ident>()?);
> > +        let mut retval =3D Self {
> > +            name: None,
> > +            qdev_prop: None,
> > +        };
> > +        let content;
> > +        _ =3D syn::parenthesized!(content in bracketed);
> > +        while !content.is_empty() {
> > +            let value: syn::Ident =3D content.parse()?;
> > +            if value =3D=3D NAME {
> > +                let _: syn::Token![=3D] =3D content.parse()?;
> > +                if retval.name.is_some() {
> > +                    panic!("{} can only be used at most once", NAME);
> > +                }
> > +                retval.name =3D Some(content.parse()?);
> > +            } else if value =3D=3D QDEV_PROP {
> > +                let _: syn::Token![=3D] =3D content.parse()?;
> > +                if retval.qdev_prop.is_some() {
> > +                    panic!("{} can only be used at most once", QDEV_PR=
OP);
> > +                }
> > +                retval.qdev_prop =3D Some(content.parse()?);
> > +            } else {
> > +                panic!("unrecognized token `{}`", value);
> > +            }
> > +
> > +            if !content.is_empty() {
> > +                let _: syn::Token![,] =3D content.parse()?;
> > +            }
> > +        }
> > +        Ok(retval)
>
> See above with respect to the duplicated code with #[device()].
>
> > +    let derive_container: DeriveContainer =3D input
> > +        .attrs
> > +        .iter()
> > +        .find(|a| a.path() =3D=3D DEVICE)
> > +        .map(|a| syn::parse(a.to_token_stream().into()).expect("could =
not parse device attr"))
> > +        .unwrap_or_default();
> > +    let (qdev_properties_static, qdev_properties_expanded) =3D make_qd=
ev_properties(&input);
>
> Please put functions before their callers.
>
> > +    let realize_fn =3D format_ident!("__{}_realize_generated", name);
> > +    let reset_fn =3D format_ident!("__{}_reset_generated", name);
> > +
> > +    let expanded =3D quote! {
> > +        unsafe impl ::qemu_api::objects::DeviceImplUnsafe for #name {
> > +            const REALIZE: ::core::option::Option<
> > +                unsafe extern "C" fn(
> > +                    dev: *mut ::qemu_api::bindings::DeviceState,
> > +                    errp: *mut *mut ::qemu_api::bindings::Error,
> > +                ),
> > +                > =3D Some(#realize_fn);
> > +            const RESET: ::core::option::Option<
> > +                unsafe extern "C" fn(dev: *mut ::qemu_api::bindings::D=
eviceState),
> > +                > =3D Some(#reset_fn);
> > +        }
> > +
> > +        #[no_mangle]
>
> Not needed.
>
> > +        pub unsafe extern "C" fn #realize_fn(
> > +            dev: *mut ::qemu_api::bindings::DeviceState,
> > +            errp: *mut *mut ::qemu_api::bindings::Error,
> > +        ) {
> > +            let mut instance =3D NonNull::new(dev.cast::<#name>()).exp=
ect(concat!("Expected dev to be a non-null pointer of type ", stringify!(#n=
ame)));
> > +            unsafe {
> > +                ::qemu_api::objects::DeviceImpl::realize(instance.as_m=
ut());
> > +            }
> > +        }
> > +
> > +        #[no_mangle]
>
> Not needed.
>
> > +        pub unsafe extern "C" fn #reset_fn(
> > +            dev: *mut ::qemu_api::bindings::DeviceState,
> > +        ) {
> > +            let mut instance =3D NonNull::new(dev.cast::<#name>()).exp=
ect(concat!("Expected dev to be a non-null pointer of type ", stringify!(#n=
ame)));
> > +            unsafe {
> > +                ::qemu_api::objects::DeviceImpl::reset(instance.as_mut=
());
> > +            }
> > +        }
>
> All this code depends on nothing but #name.  This is not the C
> preprocessor; the way to do it in Rust is monomorphization as described
> above.
>
> > +fn gen_device_class(
> > +    derive_container: DeriveContainer,
> > +    qdev_properties_static: syn::Ident,
> > +    name: &syn::Ident,
> > +) -> proc_macro2::TokenStream {
> > +    let (class_name, class_def) =3D match (
> > +        derive_container.class_name_override,
> > +        derive_container.class_name,
> > +    ) {
> > +        (Some(class_name), _) =3D> {
> > +            let class_expanded =3D quote! {
> > +                #[repr(C)]
> > +                pub struct #class_name {
> > +                    _inner: [u8; 0],
> > +                }
> > +            };
> > +            (class_name, class_expanded)
> > +        }
> > +        (None, Some(class_name)) =3D> (class_name, quote! {}),
> > +        (None, None) =3D> {
> > +            let class_name =3D format_ident!("{}Class", name);
> > +            let class_expanded =3D quote! {
> > +                #[repr(C)]
> > +                pub struct #class_name {
> > +                    _inner: [u8; 0],
> > +                }
>
> This should have a DeviceClass member, it should not be a dummy 0-byte ty=
pe.
>
> Also, this should be generated by #[derive(Object)].
>
> > +            };
> > +            (class_name, class_expanded)
> > +        }
> > +    };
> > +    let class_init_fn =3D format_ident!("__{}_class_init_generated", c=
lass_name);
> > +    let class_base_init_fn =3D format_ident!("__{}_class_base_init_gen=
erated", class_name);
> > +
> > +    let (vmsd, vmsd_impl) =3D {
> > +        let (i, vmsd) =3D make_vmstate(name);
> > +        (quote! { &#i }, vmsd)
> > +    };
> > +    let category =3D if let Some(category) =3D derive_container.catego=
ry {
> > +        quote! {
> > +            const BITS_PER_LONG: u32 =3D ::core::ffi::c_ulong::BITS;
> > +            let _: ::qemu_api::bindings::DeviceCategory =3D #category;
> > +            let nr: ::core::ffi::c_ulong =3D #category as _;
> > +            let mask =3D 1 << (nr as u32 % BITS_PER_LONG);
> > +            let p =3D ::core::ptr::addr_of_mut!(dc.as_mut().categories=
).offset((nr as u32 / BITS_PER_LONG) as isize);
> > +            let p: *mut ::core::ffi::c_ulong =3D p.cast();
> > +            let categories =3D p.read_unaligned();
> > +            p.write_unaligned(categories | mask);
>
> What's wrong with
>
> const BITS_PER_ELEMENT: u32 =3D
>      ::core::mem::sizeof(dc.categories) /
>      dc.categories.len() * 8;
>
> dc.categories[((nr as u32) / BITS_PER_ELEMENT) as usize]
>      |=3D 1 << ((nr as u32) % BITS_PER_ELEMENT);
>
> ?
>
> > +        #[no_mangle]
> > +        pub unsafe extern "C" fn #class_init_fn(klass: *mut ObjectClas=
s, data: *mut core::ffi::c_void) {
> > +            {
> > +                {
> > +                    let mut dc =3D
> > +                        ::core::ptr::NonNull::new(klass.cast::<::qemu_=
api::bindings::DeviceClass>()).unwrap();
>
> And then "let mut dc =3D dc.as_mut()".  Just write the conversion once.
>
> > +                    unsafe {
> > +                        dc.as_mut().realize =3D
> > +                            <#name as ::qemu_api::objects::DeviceImplU=
nsafe>::REALIZE;
> > +                        ::qemu_api::bindings::device_class_set_legacy_=
reset(
> > +                            dc.as_mut(),
> > +                            <#name as ::qemu_api::objects::DeviceImplU=
nsafe>::RESET
> > +                        );
>
> As written elsewhere, these should be conditional.
>
> > +                        dc.as_mut().vmsd =3D #vmsd;
> > +                        #props
> > +                        #category
>  > +                    }> +                }
>
> All this code should be outside the macro, and should use trait consts
> instead of quoting.
>
> > +                let mut klass =3D NonNull::new(klass.cast::<#class_nam=
e>()).expect(concat!("Expected klass to be a non-null pointer of type ", st=
ringify!(#class_name)));
> > +                unsafe {
> > +                    ::qemu_api::objects::ClassImpl::class_init(klass.a=
s_mut(), data);
> > +                }
> > +            }
> > +        }
> > +        #[no_mangle]
> > +        pub unsafe extern "C" fn #class_base_init_fn(klass: *mut Objec=
tClass, data: *mut core::ffi::c_void) {
> > +            {
> > +                let mut klass =3D NonNull::new(klass.cast::<#class_nam=
e>()).expect(concat!("Expected klass to be a non-null pointer of type ", st=
ringify!(#class_name)));
> > +                unsafe {
> > +                    ::qemu_api::objects::ClassImpl::class_base_init(kl=
ass.as_mut(), data);
> > +                }
> > +            }
> > +        }
> > +
> > +        #vmsd_impl
> > +    }
> > +}
> > +
> > +fn make_vmstate(name: &syn::Ident) -> (syn::Ident, proc_macro2::TokenS=
tream) {
>
> Not needed.  Just let the user provide a VMStateDescription in
> DeviceImpl.  I'm not sure if it's possible to make it a const; if not,
> it can be a function returning a &'static VMStateDescription.
>
> > +    let vmstate_description_ident =3D format_ident!("__VMSTATE_{}", na=
me);
> > +
> > +    let pre_load =3D format_ident!("__{}_pre_load_generated", name);
> > +    let post_load =3D format_ident!("__{}_post_load_generated", name);
> > +    let pre_save =3D format_ident!("__{}_pre_save_generated", name);
> > +    let post_save =3D format_ident!("__{}_post_save_generated", name);
> > +    let needed =3D format_ident!("__{}_needed_generated", name);
> > +    let dev_unplug_pending =3D format_ident!("__{}_dev_unplug_pending_=
generated", name);
> > +
> > +    let migrateable_fish =3D quote! {<#name as ::qemu_api::objects::Mi=
grateable>};
> > +    let vmstate_description =3D quote! {
> > +        #[used]
>
> Attribute not needed.
>
> > +        #[allow(non_upper_case_globals)]
> > +        pub static #vmstate_description_ident: ::qemu_api::bindings::V=
MStateDescription =3D ::qemu_api::bindings::VMStateDescription {
> > +            name: if let Some(name) =3D #migrateable_fish::NAME {
> > +                name.as_ptr()
> > +            } else {
> > +                <#name as ::qemu_api::objects::ObjectImplUnsafe>::TYPE=
_INFO.name
> > +            },
> > +            unmigratable: #migrateable_fish::UNMIGRATABLE,
> > +            early_setup: #migrateable_fish::EARLY_SETUP,
> > +            version_id: #migrateable_fish::VERSION_ID,
> > +            minimum_version_id: #migrateable_fish::MINIMUM_VERSION_ID,
> > +            priority: #migrateable_fish::PRIORITY,
> > +            pre_load: Some(#pre_load),
> > +            post_load: Some(#post_load),
> > +            pre_save: Some(#pre_save),
> > +            post_save: Some(#post_save),
> > +            needed: Some(#needed),
> > +            dev_unplug_pending: Some(#dev_unplug_pending),
> > +            fields: ::core::ptr::null(),
> > +            subsections: ::core::ptr::null(),
> > +        };
> > +
> > +        #[no_mangle]
>
> Not needed (other occurrences below).
>
> > +        pub unsafe extern "C" fn #pre_load(opaque: *mut ::core::ffi::c=
_void) -> ::core::ffi::c_int {
> > +            let mut instance =3D NonNull::new(opaque.cast::<#name>()).=
expect(concat!("Expected opaque to be a non-null pointer of type ", stringi=
fy!(#name), "::Object"));
> > +            unsafe {
> > +                ::qemu_api::objects::Migrateable::pre_load(instance.as=
_mut())
> > +            }
> > +        }
> > +        #[no_mangle]
> > +        pub unsafe extern "C" fn #post_load(opaque: *mut ::core::ffi::=
c_void, version_id: core::ffi::c_int) -> ::core::ffi::c_int {
> > +            let mut instance =3D NonNull::new(opaque.cast::<#name>()).=
expect(concat!("Expected opaque to be a non-null pointer of type ", stringi=
fy!(#name), "::Object"));
> > +            unsafe {
> > +                ::qemu_api::objects::Migrateable::post_load(instance.a=
s_mut(), version_id)
>
> Again, introducing the Migrateable code and all these thunks is
> premature; but in any case, this can only return 0 or -1 so make
> Migrateable::post_load() return Result<(), ()>.
>
> > +            }
> > +        }
> > +        #[no_mangle]
> > +        pub unsafe extern "C" fn #pre_save(opaque: *mut ::core::ffi::c=
_void) -> ::core::ffi::c_int {
> > +            let mut instance =3D NonNull::new(opaque.cast::<#name>()).=
expect(concat!("Expected opaque to be a non-null pointer of type ", stringi=
fy!(#name), "::Object"));
> > +            unsafe {
> > +                ::qemu_api::objects::Migrateable::pre_save(instance.as=
_mut())
> > +            }
> > +        }
>
> Likewise.
>
> > +        #[no_mangle]
> > +        pub unsafe extern "C" fn #post_save(opaque: *mut ::core::ffi::=
c_void) -> ::core::ffi::c_int {
> > +            let mut instance =3D NonNull::new(opaque.cast::<#name>()).=
expect(concat!("Expected opaque to be a non-null pointer of type ", stringi=
fy!(#name), "::Object"));
> > +            unsafe {
> > +                ::qemu_api::objects::Migrateable::post_save(instance.a=
s_mut())
> > +            }
> > +        }
>
> Likewise.
>
> > +        #[no_mangle]
> > +        pub unsafe extern "C" fn #needed(opaque: *mut ::core::ffi::c_v=
oid) -> bool {
> > +            let mut instance =3D NonNull::new(opaque.cast::<#name>()).=
expect(concat!("Expected opaque to be a non-null pointer of type ", stringi=
fy!(#name), "::Object"));
> > +            unsafe {
> > +                ::qemu_api::objects::Migrateable::needed(instance.as_m=
ut())
> > +            }
> > +        }
> > +        #[no_mangle]
> > +        pub unsafe extern "C" fn #dev_unplug_pending(opaque: *mut ::co=
re::ffi::c_void) -> bool {
> > +            let mut instance =3D NonNull::new(opaque.cast::<#name>()).=
expect(concat!("Expected opaque to be a non-null pointer of type ", stringi=
fy!(#name), "::Object"));
> > +            unsafe {
> > +                ::qemu_api::objects::Migrateable::dev_unplug_pending(i=
nstance.as_mut())
> > +            }
> > +        }
> > +    };
> > +
> > +    let expanded =3D quote! {
> > +        #vmstate_description
> > +    };
> > +    (vmstate_description_ident, expanded)
> > +}
> > diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src=
/lib.rs
> > index 59aba592d9ae4c5a4cdfdc6f9b9b08363b8a57e5..7753a853fae72fc87e6dc64=
2cf076c6d0c736345 100644
> > --- a/rust/qemu-api-macros/src/lib.rs
> > +++ b/rust/qemu-api-macros/src/lib.rs
> > @@ -2,42 +2,21 @@
> >   // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> >   // SPDX-License-Identifier: GPL-2.0-or-later
> >
> > +#![allow(dead_code)]
>
> Why?
>
> >   use proc_macro::TokenStream;
> > -use quote::{format_ident, quote};
> > -use syn::{parse_macro_input, DeriveInput};
> > +
> > +mod device;
> > +mod object;
> > +mod symbols;
> > +mod utilities;
> >
> >   #[proc_macro_derive(Object)]
> >   pub fn derive_object(input: TokenStream) -> TokenStream {
> > -    let input =3D parse_macro_input!(input as DeriveInput);
> > -
> > -    let name =3D input.ident;
> > -    let module_static =3D format_ident!("__{}_LOAD_MODULE", name);
> > -
> > -    let expanded =3D quote! {
> > -        #[allow(non_upper_case_globals)]
> > -        #[used]
> > -        #[cfg_attr(target_os =3D "linux", link_section =3D ".ctors")]
> > -        #[cfg_attr(target_os =3D "macos", link_section =3D "__DATA,__m=
od_init_func")]
> > -        #[cfg_attr(target_os =3D "windows", link_section =3D ".CRT$XCU=
")]
> > -        pub static #module_static: extern "C" fn() =3D {
> > -            extern "C" fn __register() {
> > -                unsafe {
> > -                    ::qemu_api::bindings::type_register_static(&<#name=
 as ::qemu_api::definitions::ObjectImpl>::TYPE_INFO);
> > -                }
> > -            }
> > -
> > -            extern "C" fn __load() {
> > -                unsafe {
> > -                    ::qemu_api::bindings::register_module_init(
> > -                        Some(__register),
> > -                        ::qemu_api::bindings::module_init_type::MODULE=
_INIT_QOM
> > -                    );
> > -                }
> > -            }
> > -
> > -            __load
> > -        };
> > -    };
> > +    object::derive_object(input)
>
> Moving code to a separate file should be a separate patch from modifying
> the expansion of the macro.
>
> > diff --git a/rust/qemu-api-macros/src/symbols.rs b/rust/qemu-api-macros=
/src/symbols.rs
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..f73768d228ed2b4d478c183=
36db56cb11e70f012
> > --- /dev/null
> > +++ b/rust/qemu-api-macros/src/symbols.rs
> > @@ -0,0 +1,55 @@
> > +// Copyright 2024, Linaro Limited
> > +// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +use core::fmt;
> > +use syn::{Ident, Path};
> > +
> > +#[derive(Copy, Clone, Debug)]
> > +pub struct Symbol(&'static str);
> > +
> > +pub const DEVICE: Symbol =3D Symbol("device");
> > +pub const NAME: Symbol =3D Symbol("name");
> > +pub const CATEGORY: Symbol =3D Symbol("category");
> > +pub const CLASS_NAME: Symbol =3D Symbol("class_name");
> > +pub const CLASS_NAME_OVERRIDE: Symbol =3D Symbol("class_name_override"=
);
> > +pub const QDEV_PROP: Symbol =3D Symbol("qdev_prop");
> > +pub const MIGRATEABLE: Symbol =3D Symbol("migrateable");
> > +pub const PROPERTIES: Symbol =3D Symbol("properties");
> > +pub const PROPERTY: Symbol =3D Symbol("property");
>
> Declare these in device.rs as needed, not here.  This avoids "use
> symbols::*".  It also allows making them not "pub", so that dead ones
> are detected by the compiler (e.g. MIGRATEABLE, PROPERTIES).
>
> > +pub fn assert_is_repr_c_struct(input: &DeriveInput, derive_macro: &'st=
atic str) {
>
> Nice but a bit overengineered.  Unless you think/know that you'll have a
> use for Repr elsewhere, try sharing code with Junjie's macro
> https://lore.kernel.org/qemu-devel/20241025160209.194307-16-pbonzini@redh=
at.com/.
>
> Paolo
>

