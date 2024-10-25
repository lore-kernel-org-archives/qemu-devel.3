Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46D6D0C601
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 12:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4J0p-0002TL-5G; Fri, 25 Oct 2024 08:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4J0n-0002Rg-Kw
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 08:01:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4J0l-0004p6-5w
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 08:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729857704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XvgEeGG7vgjvBJNvWoUN1f7IZK4AxwIy9Pk1rfJQ+BE=;
 b=R6JTYX2nnU/H3wJ8g+hyO/x6J3J4CVxfLZEhVW3ii/kkP9SgEVf5jfNEU2I4K3VlSmzH6z
 BZjCoFg34cn9Ra8UUMw8y5X2Kld3RLX33fB0OiJ3Z7stkCmry/hbWou9K58BpOxH7f0jKj
 1OdpvCOsAeGhEraZEcjVe/iUgDb0ITY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-gGBlYTyAPZ-ZbsXfW7Ev8g-1; Fri, 25 Oct 2024 08:01:43 -0400
X-MC-Unique: gGBlYTyAPZ-ZbsXfW7Ev8g-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a99fd71e777so159163866b.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 05:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729857701; x=1730462501;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XvgEeGG7vgjvBJNvWoUN1f7IZK4AxwIy9Pk1rfJQ+BE=;
 b=XliwrAKJHcyouxAhhe0w1NtQsw2o19PKpw66fMzBpsRHNJujqUDnaKHyqIJfqRcSME
 sfJrxsn3M0xShRuIytv77Zj5akAx+K87EATvII3RGgSaxfCoQeGe7zwJfoM9eJOIufUv
 ot4ncoJqT1+1VSGLMIawkfvJu2ixrYnM4r0juqnE8n3E+xGlBv4Aig0OeQw/voY5LeIa
 LiYf0eIcU0hJdblsNXanohVjGczGk+c6Kl6MNH8r9Xa4n0uyPKm/QNyo97U4+rCwAnli
 6t1UQX+j57d4vgaqd5U5TgJvqGqpjla2/7ohMaIB6vLoeZ2mtJ6jCrWQdluW3EvoVkNc
 hGhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVubzkirpAEAO/tGdpMXsZUZiCkDc6DYsMjclL0KNlv3C/bIuA+KtVDcnJt63BV4QMHZ0fYaGq67lrF@nongnu.org
X-Gm-Message-State: AOJu0YxhaOB5A6KE4gFmqXjGcHw91jidvb8EYK2uzckBDb6mZaX/D5+/
 k1JSHjfcCUyQ3/mYUsqqnk7fmvJp+P8vT8OOI5hIHL4Re9xHSmtDVgfbFHT27DYDtEFn2j2yYKp
 HhpLnoTzVFdHE4cmd4XMSSt2+uzxRePkiFhGGApCRHbEPnAaGSp9VUfHSDqLw0aY=
X-Received: by 2002:a17:907:6d15:b0:a9a:dc3:c86e with SMTP id
 a640c23a62f3a-a9abf85c82fmr902414966b.11.1729857701244; 
 Fri, 25 Oct 2024 05:01:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/d6LCVawpPN4bYW29lx2pambHnjDadDBnYSolosfYjHfhtAtU3MBQxGdATXKww0rG/EArvw==
X-Received: by 2002:a17:907:6d15:b0:a9a:dc3:c86e with SMTP id
 a640c23a62f3a-a9abf85c82fmr902392366b.11.1729857699153; 
 Fri, 25 Oct 2024 05:01:39 -0700 (PDT)
Received: from [192.168.1.84] ([93.56.170.251])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a9b1dec7b90sm63899966b.28.2024.10.25.05.01.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 05:01:38 -0700 (PDT)
Message-ID: <34f5191b-67d9-4815-a58b-a794fff0294d@redhat.com>
Date: Fri, 25 Oct 2024 14:01:37 +0200
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> The device class can now be generated automatically and the name can be
> optionally overridden:
> 
>    ------------------------ >8 ------------------------
>   #[repr(C)]
>   #[derive(Debug, qemu_api_macros::Object, qemu_api_macros::Device)]
>   #[device(class_name_override = PL011Class)]
>   /// PL011 Device Model in QEMU
>   pub struct PL011State {
>    ------------------------ >8 ------------------------
> 
> Properties are now marked as field attributes:
> 
>    ------------------------ >8 ------------------------
>   #[property(name = c"chardev", qdev_prop = qdev_prop_chr)]
>   pub char_backend: CharBackend,
>    ------------------------ >8 ------------------------

Let's look at this from the point of view of separating the code into 
multiple patches.

This part is probably the easiest to extract.  We can start the device 
impl trait with just the properties:

pub trait DeviceImpl {
     const PROPERTIES: &[Property] = &[];
}

and then the device_class_init! macro can use <$type as 
DeviceImpl>::PROPERTIES instead of $props.

  qemu_api::device_class_init! {
-    pl011_class_init,
-    props => PL011_PROPERTIES,
+    PL011State, pl011_class_init,
      realize_fn => Some(pl011_realize),
      legacy_reset_fn => Some(pl011_reset),
      vmsd => VMSTATE_PL011,
  }

> Object methods (instance_init, etc) methods are now trait methods:
> 
>    ------------------------ >8 ------------------------
>   /// Trait a type must implement to be registered with QEMU.
>   pub trait ObjectImpl {
>       type Class: ClassImpl;
>       const TYPE_NAME: &'static CStr;
>       const PARENT_TYPE_NAME: Option<&'static CStr>;
>       const ABSTRACT: bool;
> 
>       unsafe fn instance_init(&mut self) {}
>       fn instance_post_init(&mut self) {}
>       fn instance_finalize(&mut self) {}
>   }
>    ------------------------ >8 ------------------------

Some comments here:

- instance_init should take either "instance: *mut self" or even better 
"instance: &mut MaybeUninit<self>".

-  for all Rust objects the implementation of instance_finalize() should 
just be ptr::drop_in_place(obj), so this need not be included in the trait.

TYPE_NAME/PARENT_TYPE_NAME/ABSTRACT could be passed to the 
#[derive(Object)] macro, for example:

#[derive(Object)]
// abstract can be optional
#[object(type_name="pl011", parent_type=DeviceState, abstract=false,
          class_type=PL011Class)]

while the "fn instance_init()" remains as a trait implementation in 
pl011/src/device.rs.

Because a trait can be implemented only once, this suggests separating 
the trait(s) in two: one for the constants that can be generated from 
the macro, one for the functions that form the vtable.  This is true for 
both objects and devices:

pub trait ObjectInfo {
     type Class: ClassImpl;
     const TYPE_NAME: &'static CStr;
     const PARENT_TYPE_NAME: Option<&'static CStr>;
     const ABSTRACT: bool;
}

pub trait ObjectImpl: ObjectInfo {
     unsafe fn instance_init(instance: &mut MaybeUninit<self>) {}
}


and likewise:

> Device methods (realize/reset etc) are now safe idiomatic trait methods:
> 
>    ------------------------ >8 ------------------------
>   /// Implementation methods for device types.
>   pub trait DeviceImpl: ObjectImpl {
>       fn realize(&mut self) {}
>       fn reset(&mut self) {}
>   }
>    ------------------------ >8 ------------------------

pub trait DeviceInfo {
     const PROPERTIES: &[Property] = &[];
}

pub trait DeviceImpl: ObjectImpl + DeviceInfo {
     fn realize(&mut self) {}
     fn reset(&mut self) {}
     const VMSTATE: Option<VMStateDescription> = None;
}

(Generally, don't read too much in the code - the syntax might have 
issues but you get the idea).


Anyhow, going forward to the property attribute:

> +    #[property(name = c"migrate-clk", qdev_prop = qdev_prop_bool)]

There are two issues here:

First, the default is true, so 1) this has to be fixed in QEMU (will 
do), 2) it is important to support it in #[property()].

Second, this provides a false sense of safety, because I could specify 
qdev_prop_chr here.  Instead, the qdev_prop type should be derived by 
the field type.

Third, since we are at it there's no need to use c"" in the attribute. 
The c_str!() macro that I am adding for backwards compatibility to old 
versions of Rust might actually come in handy here.


The part where I have most comments, and some ideas of how to make your 
work a little more maintainable, is the implementation of class_init 
(and all that depends on it).

Let's start with these generated functions:

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
> +        pub unsafe extern "C" fn #reset_fn(
> +            dev: *mut ::qemu_api::bindings::DeviceState,
> +        ) {
> +            let mut instance = NonNull::new(dev.cast::<#name>()).expect(concat!("Expected dev to be a non-null pointer of type ", stringify!(#name)));
> +            unsafe {
> +                ::qemu_api::objects::DeviceImpl::reset(instance.as_mut());
> +            }
> +        }

This can be handled entirely in Rust code, outside the macro.  If you add:

unsafe extern "C" fn realize_fn_unsafe<T: DeviceImpl>(
     dev: *mut DeviceState,
     errp: *mut *mut Error,
) {
     let mut instance = NonNull::new(dev.cast::<T>()).
         expect("Expected dev to be a non-null pointer");
     unsafe {
         ::qemu_api::objects::DeviceImpl::realize(instance.as_mut());
     }
}

unsafe extern "C" fn reset_fn_unsafe<T: DeviceImpl>(
     dev: *mut ::qemu_api::bindings::DeviceState,
) {
     let mut instance = NonNull::new(dev.cast::<T>()).
         expect("Expected dev to be a non-null pointer");
     unsafe {
         ::qemu_api::objects::DeviceImpl::reset(instance.as_mut());
     }
}

then the functions can be used directly instead of #realize_fn and 
#reset_fn with a blanket implementation of DeviceImplUnsafe:


unsafe impl DeviceImplUnsafe for T: DeviceImpl {
     const REALIZE: ... = Some(realize_fn_unsafe::<T>);
     const RESET: ... = Some(realize_fn_unsafe::<T>);
}

Going on to the implementation of the safe functions:

> +impl DeviceImpl for PL011State {
> +    fn realize(&mut self) {

These are not quite traits.  First, you can implement only some of the 
functions.  Second, if you don't implement them they are not overwritten 
by the class_init method.

So this points to a different implementation as an attribute macro, 
which is able to rewrite everything in the body of the impl.  For example:

#[qom_class_init]
impl DeviceImpl for PL011State {
     fn realize(&mut self) { ... }
     fn reset(&mut self) { ... }

     const VMSTATE: ... = {}
     const CATEGORY: ... = {}
}

can be transformed into:

#[qom_class_init]
impl DeviceImpl for PL011State {
     // fns are wrapped and transformed into consts
     const REALIZE: Option<fn(&mut self)> = {
         fn realize(&mut self) { ... }
         Some(realize)
     };
     const RESET: Option<fn(&mut self)> = {
         fn reset(&mut self) { ... }
         Some(reset)
     };

     // while associated consts (and perhaps types?) remain as is
     const VMSTATE: ... = {}
     const CATEGORY: ... = {}
}

The above blanket implementation of DeviceImplUnsafe is easily adjusted 
to support non-overridden methods:

unsafe impl DeviceImplUnsafe for T: DeviceImpl {
     const REALIZE: ... = <T as DeviceImpl>::REALIZE::map(
         || realize_fn_unsafe::<T>);
     const RESET: ... = <T as DeviceImpl>::RESET::map(
         || realize_fn_unsafe::<T>);
}


You can also keep out of the macro the class_init method itself.  Here 
I'm adding it to DeviceImplUnsafe:

pub trait DeviceImplUnsafe {
     unsafe fn class_init(klass: *mut ObjectClass, data: *mut c_void) {
         let mut dc = NonNull::new(klass.cast::<DeviceClass>()).unwrap();
         unsafe {
             dc.as_mut().realize = Self::REALIZE;
             bindings::device_class_set_legacy_reset(
                                  dc.as_mut(), Self::RESET);
             device_class_set_props(dc.as_mut(),
                                    <Self as DeviceInfo>::PROPS);
             if let Some(vmsd) = <Self as DeviceInfo>::VMSTATE {
                 dc.as_mut().vmsd = vmsd;
             }
             if let Some(cat) = <Self as DeviceInfo>::CATEGORY {
                 dc.as_mut().category = cat;
             }

             // maybe in the future for unparent
             // <Self as ObjectImplUnsafe>::class_init(klass, data)
         }
     }
}

And with all this machinery in place the device_class_init! macro 
becomes simply

     device_class_init!(PL011State);

(because the arguments have moved to DeviceInfo or DeviceImpl).


Why is this important? Because the only code transformation is the 
generation of properties and vtables, and the bindings can be developed 
almost entirely in qemu_api instead of qemu_api_macros.  This has 
several advantages:

1) it's much easier: simpler error messages, no macro indirection, no 
super long global crate paths

2) it allows simplifying the pl011 code piecewise, even before 
introducing procedural macro code

3) it's easier to add comments


It also becomes much easier to separate the work in separate patches, or 
even separate series.  Replacing the arguments to device_class_init!() 
with DeviceImpl + DeviceImplUnsafe can be introduced first: posted, 
reviewed, merged.  All the remaining tasks are pretty much independent:

1) splitting out ObjectInfo and introducing #[object] to automate it 
(i.e. extending derive(Object))

2) splitting out DeviceInfo and introducing #[property] to automate it 
(i.e. derive(Device))

3) the #[qom_class_init] macro


A final word: I absolutely don't want you to think that your work is of 
no value.  It's totally okay to throw away the first version of 
something.  You showed that it _is_ possible to have idiomatic code with 
the help of procedural macros.  Even if the implementation can be 
improved, the _idea_ remains yours.

Paolo


