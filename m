Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11B9D13585
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 20:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5AL3-0003II-Lf; Sun, 27 Oct 2024 16:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5AL2-0003I2-3u
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 16:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5AKy-0005rz-Ho
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 16:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730062689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eYFy6SLciVw+0ElSrmzao4uGSs7h9n8VmWoKx0qyNts=;
 b=jJDDTE5b7qqNYSwr5M3kLrCoUqI7O1HRH9WZTY9OhEMcVN5/298hcV2qPJOQwSKJB1m80U
 RFF9ef3icHP6CJjz9r8joJXGhmpKmqYXSWmFac8DAC+EVoT3HL6ZBFYsCmW30ttwy01f9Z
 3dTnM0XdGFJFdnVyQ6wmEH0uNLn2rh0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-fBewV4nBNEiKyH-YyG7xFw-1; Sun, 27 Oct 2024 16:58:07 -0400
X-MC-Unique: fBewV4nBNEiKyH-YyG7xFw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d458087c0so2669581f8f.1
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 13:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730062686; x=1730667486;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eYFy6SLciVw+0ElSrmzao4uGSs7h9n8VmWoKx0qyNts=;
 b=dpVnEh/8qBEfb9+D5C4zknnomWz9GW6BTubLe5ZQFB5PJcRc5+h9kdhKhKkTD/wO52
 IfhWBi9tLGNLhI0oC4qWEZH+BjZG2Lq//N7H8fP5KAQ2/5+3DrF94w1SqHgaeRReJ5R4
 gYIP6C+63X2lxqed74Z6eqvyEm2fW131rVtjLMaFr158A+cag474UjPRJimmD04bjU6e
 0J11/ihPcuUg25IlI8mRYvbI0EwsOP+LiJVzlZvpFPtyuPDlGVPMny8pBu9MWr4dFcBH
 5moznduDaUF0ww0RqJgjnJhQMXKd8t5qGuZd8G8jQ1Vds15wTtKyNnAL6PBM5cNco8sx
 JKng==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7IyLggKbtJphnzaiV1ikrdOg8f8keUBiz2EMGrc8Sq4w461QTG0mgdxE41IYexTeOPuRRN0p5N5mp@nongnu.org
X-Gm-Message-State: AOJu0YwrIBCvMIyZ1PH0K9wm9W5QCbTZBn+kkcNbN0ijhNM/lKstUHdb
 uoqPFbWay+j6Zd2u7uGdPTf9VaREMx0GhEHTb6XFoHv4lBHfJc3NV7jA1IBl2b4w5XW5AGLlk2u
 FkUcZ7AD0Kcmss27bqozR1gowXXt5v+3DrtCwJpMnKBYxoX3baSQ4
X-Received: by 2002:a5d:524d:0:b0:37d:47eb:b586 with SMTP id
 ffacd0b85a97d-3803abc5246mr9516044f8f.4.1730062685957; 
 Sun, 27 Oct 2024 13:58:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO3nGM0U8mRC6z1BN4m5zZrc07TMKQK0cLh0NJeO5oGyPz5qsS+sm/5Fu09t5LLOCbQdTfFQ==
X-Received: by 2002:a5d:524d:0:b0:37d:47eb:b586 with SMTP id
 ffacd0b85a97d-3803abc5246mr9516023f8f.4.1730062685154; 
 Sun, 27 Oct 2024 13:58:05 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38058b1c645sm7626726f8f.17.2024.10.27.13.58.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Oct 2024 13:58:03 -0700 (PDT)
Message-ID: <f7d087fe-e9cb-4021-b816-df43656e22f5@redhat.com>
Date: Sun, 27 Oct 2024 21:58:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] rust/qemu-api-macros: introduce Device proc macro
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 Junjie Mao <junjie.mao@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
 <20241024-rust-round-2-v1-3-051e7a25b978@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241024-rust-round-2-v1-3-051e7a25b978@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
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

Hello,

here is my second attempt to review this, this time placing the remarks 
as close as possible to the code that is affected.  However, the meat is 
the same as in my previous replies to the 03/11 thread.

I hope this shows that I have practical concerns about the patch and 
it's not just FUD that it's not acceptable.

On 10/24/24 16:03, Manos Pitsidianakis wrote:
> Add a new derive procedural macro to declare device models. Add
> corresponding DeviceImpl trait after already existing ObjectImpl trait.
> At the same time, add instance_init, instance_post_init,
> instance_finalize methods to the ObjectImpl trait and call them from the
> ObjectImplUnsafe trait, which is generated by the procedural macro.
> 
> This allows all the boilerplate device model registration to be handled
> by macros, and all pertinent details to be declared through proc macro
> attributes or trait associated constants and methods.
> 
> The device class can now be generated automatically and the name can be
> optionally overridden:
> 
>    ------------------------ >8 ------------------------
>   #[repr(C)]
>   #[derive(Debug, qemu_api_macros::Object, qemu_api_macros::Device)]
>   #[device(class_name_override = PL011Class)]
>   /// PL011 Device Model in QEMU
>   pub struct PL011State {

The first design issue is already visible here in this example.  I could 
place the same comment when the code appears in rust/hw/char/pl011, but 
it's easier to do it here.

You have two derive macros, Object and Device.  Object is derived by all 
objects (even if right now we have only devices), Device is derived by 
devices only.

The class name is a property of any object, not just devices.  It should 
not be part of the #[device()] attribute.  #[derive(Device)] and 
#[device()] instead should take care of properties and categories (and 
possibly vmstate, but I'm not sure about that and there's already enough 
to say about this patch).


You also have no documentation, which means that users will have no idea 
of what are the other sub-attributes of #[device()], including the 
difference between class_name and class_name_override, or how categories 
are defined.

Even if we don't have support for rustdoc yet in tree, we should have 
all the needed documentation as soon as the API moves from "ad hoc usage 
of C symbols" to idiomatic.

> Object methods (instance_init, etc) methods are now trait methods:
> 
>    ------------------------ >8 ------------------------
>   /// Trait a type must implement to be registered with QEMU.
>   pub trait ObjectImpl {
>       type Class: ClassImpl;
>       const TYPE_NAME: &'static CStr;
>       const PARENT_TYPE_NAME: Option<&'static CStr>;
>       const ABSTRACT: bool;


Class, TYPE_NAME, PARENT_TYPE_NAME, ABSTRACT should be defined via 
#[object()].

But actually, there is already room for defining a separate trait:

/// # Safety
///
/// - the first field of the struct must be of `Object` type,
///   or derived from it
///
/// - `TYPE` must match the type name used in the `TypeInfo` (no matter
///   if it is defined in C or Rust).
///
/// - the struct must be `#[repr(C)]`
pub unsafe trait ObjectType {
     type Class: ClassImpl;
     const TYPE_NAME: &'static CStr;
}

... because you can implement it even for classes that are defined in C 
code.  Then #[derive(Object)] can find the TYPE_NAME directly from the 
first field of the struct, i.e.

      parent_obj: SysBusDevice;

becomes

     const PARENT_TYPE_NAME: Option<&'static CStr> =
         Some(<SysBusDevice as TypeImpl>::TYPE_NAME);

while #[object()] would be just

#[object(class_type = PL011Class, type_name = "pl011")]

Accessing the type of the first field is easy using the get_fields() 
function that Junjie added at 
https://lore.kernel.org/qemu-devel/20241025160209.194307-16-pbonzini@redhat.com/

This shows another reason why I prefer to get CI to work first.  Having 
to do simple, but still non-trivial work, often provides code that can 
be reused in more complex setups.

>       unsafe fn instance_init(&mut self) {}
>       fn instance_post_init(&mut self) {}
>       fn instance_finalize(&mut self) {}
>   }

In the trait, having a default implementation that is empty works 
(unlike for realize/reset, as we'll see later).  So this is a bit 
simpler.  However, instance_finalize should have a non-empty default 
implementation:

	std::ptr::drop_in_place(self);

which should be okay for most devices.

Alternatively, leave out instance_post_init() and instance_finalize() 
until we need them, and put the drop_in_place() call directly in the 
unsafe function that goes in the TypeInfo.

>    ------------------------ >8 ------------------------
> 
> Device methods (realize/reset etc) are now safe idiomatic trait methods:
> 
>    ------------------------ >8 ------------------------
>   /// Implementation methods for device types.
>   pub trait DeviceImpl: ObjectImpl {
>       fn realize(&mut self) {}
>       fn reset(&mut self) {}
>   }
>    ------------------------ >8 ------------------------

This is an incorrect definition of the trait.  The default definition of 
device methods is not "empty", it's "just reuse the superclass 
implementation".  In particular, this means that PL011LuminaryState 
right now cannot use #[derive(Device)].

> The derive Device macro is responsible for creating all the extern "C" FFI
> functions that QEMU needs to call these methods.

This is unnecessary.  It is perfectly possible to write the extern "C" 
functions (class_init, realize, reset) just once as either type-generic 
functions, or functions in a trait.  More on this later.

> diff --git a/rust/qemu-api/src/objects.rs b/rust/qemu-api/src/objects.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..5c6762023ed6914f9c6b7dd16a5e07f778c2d4fa
> --- /dev/null
> +++ b/rust/qemu-api/src/objects.rs
> @@ -0,0 +1,90 @@
> +// Copyright 2024, Linaro Limited
> +// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +//! Implementation traits for QEMU objects, devices.
> +
> +use ::core::ffi::{c_int, c_void, CStr};
> +
> +use crate::bindings::{DeviceState, Error, MigrationPriority, Object, ObjectClass, TypeInfo};
> +
> +/// Trait a type must implement to be registered with QEMU.
> +pub trait ObjectImpl {
> +    type Class: ClassImpl;
> +    const TYPE_NAME: &'static CStr;
> +    const PARENT_TYPE_NAME: Option<&'static CStr>;
> +    const ABSTRACT: bool;

These consts should entirely be derived from the #[object()] attribute.
You can facilitate the split by having two traits, one for things 
derived from the attribute (the above four), and one for the vtable.

> +    unsafe fn instance_init(&mut self) {}
> +    fn instance_post_init(&mut self) {}
> +    fn instance_finalize(&mut self) {}
> +}

See above remark on the default implementation of instance_finalize.

> +/// The `extern`/`unsafe` analogue of [`ObjectImpl`]; it is used internally by `#[derive(Object)]`
> +/// and should not be implemented manually.
> +pub unsafe trait ObjectImplUnsafe {
> +    const TYPE_INFO: TypeInfo;
> +
> +    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)>;
> +    const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)>;
> +    const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)>;
> +}
> +

This trait is not needed at all, because it really has juts one 
implementation.  The fact that there is just one implementation is 
hidden by the fact that you are generating the code instead of relying 
on the type system.

All you need is a single function, which will be called via the 
module_init mechanism:

fn rust_type_register<T: ObjectImpl>() {
     let TypeInfo ti = ...;
     unsafe { type_register(&ti); }
}

> 
> +/// Methods for QOM class types.
> +pub trait ClassImpl {
> +    type Object: ObjectImpl;
> +
> +    unsafe fn class_init(&mut self, _data: *mut core::ffi::c_void) {}
> +    unsafe fn class_base_init(&mut self, _data: *mut core::ffi::c_void) {}
> +}
> +

This trait (or more precisely class_init and class_base_init) is not 
needed.  class_base_init is only needed in very special cases, we can 
just decide they won't be available in Rust for now and possible for ever.

As to class_init device XYZ would only need a non-empty class_init 
method if we added support for the _data argument.  But then we would 
need a way to provide the type of _data, and to cast _data to the 
appropriate type; we would also need a way to provide a mapping from 
multiple data objects to multiple type names, which is hard to do 
because right now each Rust struct has a single type name associated.

So, let's just keep only the auto-generated class_init for simplicity. 
If we can just decide that, if device XYZ has superclass FooDevice, it 
implements FooDeviceImpl and class_init is provided by the FooDevice 
bindings.

I can't really say if the "type Object" part is needed.  I couldn't 
offhand find anything that uses it, but I may have missed it.  If so, it 
can be in ClassImplUnsafe.

> +/// The `extern`/`unsafe` analogue of [`ClassImpl`]; it is used internally by `#[derive(Object)]`
> +/// and should not be implemented manually.
> +pub unsafe trait ClassImplUnsafe {
> +    const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void)>;
> +    const CLASS_BASE_INIT: Option<
> +        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
> +    >;
> +}

Again, no need to have CLASS_BASE_INIT here.

> +/// Implementation methods for device types.
> +pub trait DeviceImpl: ObjectImpl {
> +    fn realize(&mut self) {}
> +    fn reset(&mut self) {}
> +}

These unfortunately cannot be functions.  Doing so forces the class_init 
method to assign both dc->reset and dc->realize for _all_ classes, 
whereas for example PL011LuminaryClass would not override either.

Therefore, the definition must be

pub trait DeviceImpl: ObjectImpl {
     const REALIZE: Option<fn realize(&mut self)> = None;
     const RESET: Option<fn realize(&mut self)> = None;
}

Yes, it's uglier, but we cannot escape the fact that we're implementing 
something that Rust doesn't have natively (inheritance). :(  So we 
cannot use language features meant for a completely different kind of 
polymorphism.

> +/// The `extern`/`unsafe` analogue of [`DeviceImpl`]; it is used internally by `#[derive(Device)]`
> +/// and should not be implemented manually.
> +pub unsafe trait DeviceImplUnsafe {
> +    const REALIZE: Option<unsafe extern "C" fn(dev: *mut DeviceState, _errp: *mut *mut Error)>;
> +    const RESET: Option<unsafe extern "C" fn(dev: *mut DeviceState)>;
> +}

This trait is also unnecessary, because all that you need is a single 
function:

fn rust_device_class_init<T: DeviceImpl>(
     klass: *mut ObjectClass, _data: *mut c_void)

defined outside the procedural macro.  #[derive(Device)] can define 
ClassImplUnsafe to point CLASS_INIT to rust_device_class_init.

(Later, rust_device_class_init() can be moved into a trait so that it's 
possible to define other classes of devices, for example PCI devices. 
Note that such an extension would be much easier, than if it was 
_required_ to touch the procedural macro).

> 
> +/// Constant metadata and implementation methods for types with device migration state.
> +pub trait Migrateable: DeviceImplUnsafe {
> +    const NAME: Option<&'static CStr> = None;
> +    const UNMIGRATABLE: bool = true;
> +    const EARLY_SETUP: bool = false;
> +    const VERSION_ID: c_int = 1;
> +    const MINIMUM_VERSION_ID: c_int = 1;
> +    const PRIORITY: MigrationPriority = MigrationPriority::MIG_PRI_DEFAULT;
> +
> +    unsafe fn pre_load(&mut self) -> c_int {
> +        0
> +    }
> +    unsafe fn post_load(&mut self, _version_id: c_int) -> c_int {
> +        0
> +    }
> +    unsafe fn pre_save(&mut self) -> c_int {
> +        0
> +    }
> +    unsafe fn post_save(&mut self) -> c_int {
> +        0
> +    }
> +    unsafe fn needed(&mut self) -> bool {
> +        false
> +    }
> +    unsafe fn dev_unplug_pending(&mut self) -> bool {
> +        false
> +    }
> +}

Premature.  No need to add this trait until you add support for migration.

> diff --git a/rust/qemu-api/src/tests.rs b/rust/qemu-api/src/tests.rs
> deleted file mode 100644
> index df54edbd4e27e7d2aafc243355d1826d52497c21..0000000000000000000000000000000000000000
> --- a/rust/qemu-api/src/tests.rs
> +++ /dev/null
> @@ -1,49 +0,0 @@

Nope.  Fix the test, don't remove it.


> -#[derive(Debug, qemu_api_macros::Object)]
> +#[derive(Debug, qemu_api_macros::Object, qemu_api_macros::Device)]
> +#[device(class_name_override = PL011Class)]
>   /// PL011 Device Model in QEMU
>   pub struct PL011State {
>       pub parent_obj: SysBusDevice,
> @@ -51,6 +52,7 @@ pub struct PL011State {
>       pub read_count: usize,
>       pub read_trigger: usize,
>       #[doc(alias = "chr")]
> +    #[property(name = c"chardev", qdev_prop = qdev_prop_chr)]

(See earlier comments on accepting only a LitStr and deriving qdev_prop 
from the type).

> +impl DeviceImpl for PL011State {
> +    fn realize(&mut self) {
> +        ...
> +    }
> +
> +    fn reset(&mut self) {
> +        ...
> +    }

This extractions of code into DeviceImpl is good.  However, as I said 
above, I'm not sure about the trait itself.  I'll remark later when I 
encounter the definition.

> +impl qemu_api::objects::Migrateable for PL011State {}

Premature.

Before moving on to the procedural macro code, my proposal to split the 
patches is:

1) introduce the trait ObjectType, define it for Object, DeviceState and 
SysBusDevice.

2) introduce the traits ObjectImpl, DeviceImpl and ClassImplUnsafe. 
Define the first two for PL011State.

3) add to common code the wrappers that call into DeviceImpl, removing 
them from PL011State

4) introduce the functions rust_type_register and rust_device_class_init 
that use the traits.

5) remove most arguments of device_class_init!(), using the 
infrastructure introduced in the previous two steps

6) split ObjectImpl into a part that will be covered by #[object()], 
let's call it ObjectInfo

7) add implementation of #[object()], replace PL011State's 
implementation of ObjectInfo with #[object()]

8) split DeviceImpl into a part that will be covered by #[device()] 
(properties and categories), let's call it DeviceInfo

9) add #[derive(Device) and implementation of #[device()], replace 
PL011State's implementation of DeviceInfo with #[device()]

Where 1-5 should be submitted as a separate series, one that does not 
touch procedural macros *at all* and just generalizes the pl011 code 
that defines QOM types.


Anyhow, I'll continue reviewing the procedural macro code.

> +#[derive(Debug, Default)]
> +struct DeriveContainer {
> +    category: Option<syn::Path>,
> +    class_name: Option<syn::Ident>,
> +    class_name_override: Option<syn::Ident>,
> +}

Rename to DeviceAttribute.

> +impl Parse for DeriveContainer {
> +    fn parse(input: ParseStream) -> Result<Self> {

syn::Result represents a parse error, not an error in the allowed syntax 
of the attribute.  Below, you're using panic! and unwrap(), but probably 
instead of syn::Result we need to have something like

pub enum Error {
     CompileError(syn::Span, String),
     ParseError(syn::Error)
}

which extends the CompileError enum of 
https://lore.kernel.org/qemu-devel/20241025160209.194307-16-pbonzini@redhat.com/ 
and is amenable to use with "?".  In particular, note the idiom used by 
the root derive_offsets() functions:

     let input = parse_macro_input!(input as DeriveInput);
     let expanded = derive_offsets_or_error(input).
         unwrap_or_else(Into::into);

     TokenStream::from(expanded)

which works via an "impl From<CompileError> for proc_macro2::TokenStream".

I believe that most of the benefit of this series (basically, all except 
the #[property] attribute) can be obtained without the procedural macro. 
  Therefore, once we do add the procedural macro, we should not have it 
panic on errors.

> +        let _: syn::Token![#] = input.parse()?;
> +        let bracketed;
> +        _ = syn::bracketed!(bracketed in input);
> +        assert_eq!(DEVICE, bracketed.parse::<syn::Ident>()?);
> +        let mut retval = Self {
> +            category: None,
> +            class_name: None,
> +            class_name_override: None,
> +        };
> +        let content;
> +        _ = syn::parenthesized!(content in bracketed);
> +        while !content.is_empty() {
> +            let value: syn::Ident = content.parse()?;
> +            if value == CLASS_NAME {
> +                let _: syn::Token![=] = content.parse()?;
> +                if retval.class_name.is_some() {
> +                    panic!("{} can only be used at most once", CLASS_NAME);
> +                }

No panic!, instead we need to return a compile_error!() TokenStream, or 
as above a Result<> that can be converted to compile_error!() up in the 
chain.

> +                retval.class_name = Some(content.parse()?);

Please make this function a separate trait in utilities:

trait AttributeParsing {
     const NAME: Symbol;
     fn set(&mut self, key: &syn::Ident, input: &ParseStream) -> Result<()>;
     fn parse(input: ParseStream) -> Result<Self> { ... }
}

Then the "if" can move to the struct-specific implementation of 
AttributeParsing::set, while the rest can move to the default 
implementation of AttributeParsing::parse.

#[property()] and #[device()] (and also the proposed #[object()]) can 
then share the implementation of AttributeParsing::parse.

> +            } else if value == CLASS_NAME_OVERRIDE {
> +                let _: syn::Token![=] = content.parse()?;
> +                if retval.class_name_override.is_some() {
> +                    panic!("{} can only be used at most once", CLASS_NAME_OVERRIDE);
> +                }> +                retval.class_name_override = Some(content.parse()?);
> +            } else if value == CATEGORY {
> +                let _: syn::Token![=] = content.parse()?;
> +                if retval.category.is_some() {
> +                    panic!("{} can only be used at most once", CATEGORY);
> +                }
> +                let lit: syn::LitStr = content.parse()?;
> +                let path: syn::Path = lit.parse()?;

Do I understand that this would be

    category = "foo::bar::Baz"

?  If so, why the extra quotes?  There can actually be more than one 
category, so at least add a TODO here.

> +#[derive(Debug)]
> +struct QdevProperty {
> +    name: Option<syn::LitCStr>,

Just LitStr.  Convert it to CString in the macro.  You can reuse the 
c_str!() macro that I'm adding in the series to fix CI and support old 
rustc, i.e. quote! { ::qemu_api::c_str!(#name) } or something like that.

> +    qdev_prop: Option<syn::Path>,
> +}
> +
> +impl Parse for QdevProperty {
> +    fn parse(input: ParseStream) -> Result<Self> {
> +        let _: syn::Token![#] = input.parse()?;
> +        let bracketed;
> +        _ = syn::bracketed!(bracketed in input);
> +        assert_eq!(PROPERTY, bracketed.parse::<syn::Ident>()?);
> +        let mut retval = Self {
> +            name: None,
> +            qdev_prop: None,
> +        };
> +        let content;
> +        _ = syn::parenthesized!(content in bracketed);
> +        while !content.is_empty() {
> +            let value: syn::Ident = content.parse()?;
> +            if value == NAME {
> +                let _: syn::Token![=] = content.parse()?;
> +                if retval.name.is_some() {
> +                    panic!("{} can only be used at most once", NAME);
> +                }
> +                retval.name = Some(content.parse()?);
> +            } else if value == QDEV_PROP {
> +                let _: syn::Token![=] = content.parse()?;
> +                if retval.qdev_prop.is_some() {
> +                    panic!("{} can only be used at most once", QDEV_PROP);
> +                }
> +                retval.qdev_prop = Some(content.parse()?);
> +            } else {
> +                panic!("unrecognized token `{}`", value);
> +            }
> +
> +            if !content.is_empty() {
> +                let _: syn::Token![,] = content.parse()?;
> +            }
> +        }
> +        Ok(retval)

See above with respect to the duplicated code with #[device()].

> +    let derive_container: DeriveContainer = input
> +        .attrs
> +        .iter()
> +        .find(|a| a.path() == DEVICE)
> +        .map(|a| syn::parse(a.to_token_stream().into()).expect("could not parse device attr"))
> +        .unwrap_or_default();
> +    let (qdev_properties_static, qdev_properties_expanded) = make_qdev_properties(&input);

Please put functions before their callers.

> +    let realize_fn = format_ident!("__{}_realize_generated", name);
> +    let reset_fn = format_ident!("__{}_reset_generated", name);
> +
> +    let expanded = quote! {
> +        unsafe impl ::qemu_api::objects::DeviceImplUnsafe for #name {
> +            const REALIZE: ::core::option::Option<
> +                unsafe extern "C" fn(
> +                    dev: *mut ::qemu_api::bindings::DeviceState,
> +                    errp: *mut *mut ::qemu_api::bindings::Error,
> +                ),
> +                > = Some(#realize_fn);
> +            const RESET: ::core::option::Option<
> +                unsafe extern "C" fn(dev: *mut ::qemu_api::bindings::DeviceState),
> +                > = Some(#reset_fn);
> +        }
> +
> +        #[no_mangle]

Not needed.

> +        pub unsafe extern "C" fn #realize_fn(
> +            dev: *mut ::qemu_api::bindings::DeviceState,
> +            errp: *mut *mut ::qemu_api::bindings::Error,
> +        ) {
> +            let mut instance = NonNull::new(dev.cast::<#name>()).expect(concat!("Expected dev to be a non-null pointer of type ", stringify!(#name)));
> +            unsafe {
> +                ::qemu_api::objects::DeviceImpl::realize(instance.as_mut());
> +            }
> +        }
> +
> +        #[no_mangle]

Not needed.

> +        pub unsafe extern "C" fn #reset_fn(
> +            dev: *mut ::qemu_api::bindings::DeviceState,
> +        ) {
> +            let mut instance = NonNull::new(dev.cast::<#name>()).expect(concat!("Expected dev to be a non-null pointer of type ", stringify!(#name)));
> +            unsafe {
> +                ::qemu_api::objects::DeviceImpl::reset(instance.as_mut());
> +            }
> +        }

All this code depends on nothing but #name.  This is not the C 
preprocessor; the way to do it in Rust is monomorphization as described 
above.

> +fn gen_device_class(
> +    derive_container: DeriveContainer,
> +    qdev_properties_static: syn::Ident,
> +    name: &syn::Ident,
> +) -> proc_macro2::TokenStream {
> +    let (class_name, class_def) = match (
> +        derive_container.class_name_override,
> +        derive_container.class_name,
> +    ) {
> +        (Some(class_name), _) => {
> +            let class_expanded = quote! {
> +                #[repr(C)]
> +                pub struct #class_name {
> +                    _inner: [u8; 0],
> +                }
> +            };
> +            (class_name, class_expanded)
> +        }
> +        (None, Some(class_name)) => (class_name, quote! {}),
> +        (None, None) => {
> +            let class_name = format_ident!("{}Class", name);
> +            let class_expanded = quote! {
> +                #[repr(C)]
> +                pub struct #class_name {
> +                    _inner: [u8; 0],
> +                }

This should have a DeviceClass member, it should not be a dummy 0-byte type.

Also, this should be generated by #[derive(Object)].

> +            };
> +            (class_name, class_expanded)
> +        }
> +    };
> +    let class_init_fn = format_ident!("__{}_class_init_generated", class_name);
> +    let class_base_init_fn = format_ident!("__{}_class_base_init_generated", class_name);
> +
> +    let (vmsd, vmsd_impl) = {
> +        let (i, vmsd) = make_vmstate(name);
> +        (quote! { &#i }, vmsd)
> +    };
> +    let category = if let Some(category) = derive_container.category {
> +        quote! {
> +            const BITS_PER_LONG: u32 = ::core::ffi::c_ulong::BITS;
> +            let _: ::qemu_api::bindings::DeviceCategory = #category;
> +            let nr: ::core::ffi::c_ulong = #category as _;
> +            let mask = 1 << (nr as u32 % BITS_PER_LONG);
> +            let p = ::core::ptr::addr_of_mut!(dc.as_mut().categories).offset((nr as u32 / BITS_PER_LONG) as isize);
> +            let p: *mut ::core::ffi::c_ulong = p.cast();
> +            let categories = p.read_unaligned();
> +            p.write_unaligned(categories | mask);

What's wrong with

const BITS_PER_ELEMENT: u32 =
     ::core::mem::sizeof(dc.categories) /
     dc.categories.len() * 8;

dc.categories[((nr as u32) / BITS_PER_ELEMENT) as usize]
     |= 1 << ((nr as u32) % BITS_PER_ELEMENT);

?

> +        #[no_mangle]
> +        pub unsafe extern "C" fn #class_init_fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void) {
> +            {
> +                {
> +                    let mut dc =
> +                        ::core::ptr::NonNull::new(klass.cast::<::qemu_api::bindings::DeviceClass>()).unwrap();

And then "let mut dc = dc.as_mut()".  Just write the conversion once.

> +                    unsafe {
> +                        dc.as_mut().realize =
> +                            <#name as ::qemu_api::objects::DeviceImplUnsafe>::REALIZE;
> +                        ::qemu_api::bindings::device_class_set_legacy_reset(
> +                            dc.as_mut(),
> +                            <#name as ::qemu_api::objects::DeviceImplUnsafe>::RESET
> +                        );

As written elsewhere, these should be conditional.

> +                        dc.as_mut().vmsd = #vmsd;
> +                        #props
> +                        #category
 > +                    }> +                }

All this code should be outside the macro, and should use trait consts 
instead of quoting.

> +                let mut klass = NonNull::new(klass.cast::<#class_name>()).expect(concat!("Expected klass to be a non-null pointer of type ", stringify!(#class_name)));
> +                unsafe {
> +                    ::qemu_api::objects::ClassImpl::class_init(klass.as_mut(), data);
> +                }
> +            }
> +        }
> +        #[no_mangle]
> +        pub unsafe extern "C" fn #class_base_init_fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void) {
> +            {
> +                let mut klass = NonNull::new(klass.cast::<#class_name>()).expect(concat!("Expected klass to be a non-null pointer of type ", stringify!(#class_name)));
> +                unsafe {
> +                    ::qemu_api::objects::ClassImpl::class_base_init(klass.as_mut(), data);
> +                }
> +            }
> +        }
> +
> +        #vmsd_impl
> +    }
> +}
> +
> +fn make_vmstate(name: &syn::Ident) -> (syn::Ident, proc_macro2::TokenStream) {

Not needed.  Just let the user provide a VMStateDescription in 
DeviceImpl.  I'm not sure if it's possible to make it a const; if not, 
it can be a function returning a &'static VMStateDescription.

> +    let vmstate_description_ident = format_ident!("__VMSTATE_{}", name);
> +
> +    let pre_load = format_ident!("__{}_pre_load_generated", name);
> +    let post_load = format_ident!("__{}_post_load_generated", name);
> +    let pre_save = format_ident!("__{}_pre_save_generated", name);
> +    let post_save = format_ident!("__{}_post_save_generated", name);
> +    let needed = format_ident!("__{}_needed_generated", name);
> +    let dev_unplug_pending = format_ident!("__{}_dev_unplug_pending_generated", name);
> +
> +    let migrateable_fish = quote! {<#name as ::qemu_api::objects::Migrateable>};
> +    let vmstate_description = quote! {
> +        #[used]

Attribute not needed.

> +        #[allow(non_upper_case_globals)]
> +        pub static #vmstate_description_ident: ::qemu_api::bindings::VMStateDescription = ::qemu_api::bindings::VMStateDescription {
> +            name: if let Some(name) = #migrateable_fish::NAME {
> +                name.as_ptr()
> +            } else {
> +                <#name as ::qemu_api::objects::ObjectImplUnsafe>::TYPE_INFO.name
> +            },
> +            unmigratable: #migrateable_fish::UNMIGRATABLE,
> +            early_setup: #migrateable_fish::EARLY_SETUP,
> +            version_id: #migrateable_fish::VERSION_ID,
> +            minimum_version_id: #migrateable_fish::MINIMUM_VERSION_ID,
> +            priority: #migrateable_fish::PRIORITY,
> +            pre_load: Some(#pre_load),
> +            post_load: Some(#post_load),
> +            pre_save: Some(#pre_save),
> +            post_save: Some(#post_save),
> +            needed: Some(#needed),
> +            dev_unplug_pending: Some(#dev_unplug_pending),
> +            fields: ::core::ptr::null(),
> +            subsections: ::core::ptr::null(),
> +        };
> +
> +        #[no_mangle]

Not needed (other occurrences below).

> +        pub unsafe extern "C" fn #pre_load(opaque: *mut ::core::ffi::c_void) -> ::core::ffi::c_int {
> +            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
> +            unsafe {
> +                ::qemu_api::objects::Migrateable::pre_load(instance.as_mut())
> +            }
> +        }
> +        #[no_mangle]
> +        pub unsafe extern "C" fn #post_load(opaque: *mut ::core::ffi::c_void, version_id: core::ffi::c_int) -> ::core::ffi::c_int {
> +            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
> +            unsafe {
> +                ::qemu_api::objects::Migrateable::post_load(instance.as_mut(), version_id)

Again, introducing the Migrateable code and all these thunks is 
premature; but in any case, this can only return 0 or -1 so make 
Migrateable::post_load() return Result<(), ()>.

> +            }
> +        }
> +        #[no_mangle]
> +        pub unsafe extern "C" fn #pre_save(opaque: *mut ::core::ffi::c_void) -> ::core::ffi::c_int {
> +            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
> +            unsafe {
> +                ::qemu_api::objects::Migrateable::pre_save(instance.as_mut())
> +            }
> +        }

Likewise.

> +        #[no_mangle]
> +        pub unsafe extern "C" fn #post_save(opaque: *mut ::core::ffi::c_void) -> ::core::ffi::c_int {
> +            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
> +            unsafe {
> +                ::qemu_api::objects::Migrateable::post_save(instance.as_mut())
> +            }
> +        }

Likewise.

> +        #[no_mangle]
> +        pub unsafe extern "C" fn #needed(opaque: *mut ::core::ffi::c_void) -> bool {
> +            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
> +            unsafe {
> +                ::qemu_api::objects::Migrateable::needed(instance.as_mut())
> +            }
> +        }
> +        #[no_mangle]
> +        pub unsafe extern "C" fn #dev_unplug_pending(opaque: *mut ::core::ffi::c_void) -> bool {
> +            let mut instance = NonNull::new(opaque.cast::<#name>()).expect(concat!("Expected opaque to be a non-null pointer of type ", stringify!(#name), "::Object"));
> +            unsafe {
> +                ::qemu_api::objects::Migrateable::dev_unplug_pending(instance.as_mut())
> +            }
> +        }
> +    };
> +
> +    let expanded = quote! {
> +        #vmstate_description
> +    };
> +    (vmstate_description_ident, expanded)
> +}
> diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
> index 59aba592d9ae4c5a4cdfdc6f9b9b08363b8a57e5..7753a853fae72fc87e6dc642cf076c6d0c736345 100644
> --- a/rust/qemu-api-macros/src/lib.rs
> +++ b/rust/qemu-api-macros/src/lib.rs
> @@ -2,42 +2,21 @@
>   // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>   // SPDX-License-Identifier: GPL-2.0-or-later
>   
> +#![allow(dead_code)]

Why?

>   use proc_macro::TokenStream;
> -use quote::{format_ident, quote};
> -use syn::{parse_macro_input, DeriveInput};
> +
> +mod device;
> +mod object;
> +mod symbols;
> +mod utilities;
>   
>   #[proc_macro_derive(Object)]
>   pub fn derive_object(input: TokenStream) -> TokenStream {
> -    let input = parse_macro_input!(input as DeriveInput);
> -
> -    let name = input.ident;
> -    let module_static = format_ident!("__{}_LOAD_MODULE", name);
> -
> -    let expanded = quote! {
> -        #[allow(non_upper_case_globals)]
> -        #[used]
> -        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
> -        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
> -        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
> -        pub static #module_static: extern "C" fn() = {
> -            extern "C" fn __register() {
> -                unsafe {
> -                    ::qemu_api::bindings::type_register_static(&<#name as ::qemu_api::definitions::ObjectImpl>::TYPE_INFO);
> -                }
> -            }
> -
> -            extern "C" fn __load() {
> -                unsafe {
> -                    ::qemu_api::bindings::register_module_init(
> -                        Some(__register),
> -                        ::qemu_api::bindings::module_init_type::MODULE_INIT_QOM
> -                    );
> -                }
> -            }
> -
> -            __load
> -        };
> -    };
> +    object::derive_object(input)

Moving code to a separate file should be a separate patch from modifying 
the expansion of the macro.

> diff --git a/rust/qemu-api-macros/src/symbols.rs b/rust/qemu-api-macros/src/symbols.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..f73768d228ed2b4d478c18336db56cb11e70f012
> --- /dev/null
> +++ b/rust/qemu-api-macros/src/symbols.rs
> @@ -0,0 +1,55 @@
> +// Copyright 2024, Linaro Limited
> +// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +use core::fmt;
> +use syn::{Ident, Path};
> +
> +#[derive(Copy, Clone, Debug)]
> +pub struct Symbol(&'static str);
> +
> +pub const DEVICE: Symbol = Symbol("device");
> +pub const NAME: Symbol = Symbol("name");
> +pub const CATEGORY: Symbol = Symbol("category");
> +pub const CLASS_NAME: Symbol = Symbol("class_name");
> +pub const CLASS_NAME_OVERRIDE: Symbol = Symbol("class_name_override");
> +pub const QDEV_PROP: Symbol = Symbol("qdev_prop");
> +pub const MIGRATEABLE: Symbol = Symbol("migrateable");
> +pub const PROPERTIES: Symbol = Symbol("properties");
> +pub const PROPERTY: Symbol = Symbol("property");

Declare these in device.rs as needed, not here.  This avoids "use 
symbols::*".  It also allows making them not "pub", so that dead ones 
are detected by the compiler (e.g. MIGRATEABLE, PROPERTIES).

> +pub fn assert_is_repr_c_struct(input: &DeriveInput, derive_macro: &'static str) {

Nice but a bit overengineered.  Unless you think/know that you'll have a 
use for Repr elsewhere, try sharing code with Junjie's macro 
https://lore.kernel.org/qemu-devel/20241025160209.194307-16-pbonzini@redhat.com/.

Paolo


