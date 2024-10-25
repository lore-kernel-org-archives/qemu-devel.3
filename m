Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB031D0C614
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Kw5-00020p-Ox; Fri, 25 Oct 2024 10:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t4Kw4-0001zc-FF
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:05:04 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1t4Kw2-0006PH-CD
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:05:04 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-539fb49c64aso3715958e87.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865100; x=1730469900; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rvqPVF6xo+PXvpChkz9anDH4TWWzpFrpBRta0XxAsKg=;
 b=Kd0Be/Vk14akQVIdaGNrx3RTa6qFJfVPWBi8IVHrgkqZp0Y1wzQjfdmPNOCP8c99j5
 7yGZE7orDFk2J1AOJF1d5va+yHzGS96bwkPsaSgYl8XNkoKtbtU6aAS2gAodqxtjhV2V
 anRqm0izh/I76OJVHcM+W+MhZWxB+n/UatLPfBEcmTgfy2sIsfoMFMIvDQayS5oKzS1q
 mNONzTFR+9dmPw6T8EqVjKY1ZEbDXA8htqKbVbnm8Cwg3+n0eAJehW54w/TyiUbZtw47
 mJ6GpHBZQSzaSOgCnlBtZCq18t6tGygoRS8M8kTJ5JF/xiczVY26TyKGhWUNXDI/mxEd
 y+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865100; x=1730469900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rvqPVF6xo+PXvpChkz9anDH4TWWzpFrpBRta0XxAsKg=;
 b=Bha8259kwu7dMva5c0obGRdgguSi2FFxXLAwr5MdxM7CeX+Ned9/n5Q8MTnpn/N7TO
 gwwXLmB6SMO1+JDcrRz3J3+759KSlFrJKq3A1R5qLCV7doTKGyMhcN1HPvBJi5qu1A5T
 9ni2Mnwit+GeqbYUpbMS3NYSrENunAlNl5UFYYUVwcaRMpK0ez1qRCl/BxGXQutaFyOH
 oHC4bZbeW9SGBnH7fN2W9LzfPv2q3VklFpkIAkPH3/DA63rJxZ6xU5FT9F0ZVPTXq6pC
 PybOy17wxckBc6mr8Ux1V/AOaLALsMbevqgQSElmAYzBi32Y/LNaOm14wRJCxwiY87ul
 FWzw==
X-Gm-Message-State: AOJu0Yw1GfKP9Ic15RiBLfL3a33oLZUQK+eAXfXgAVA3QBoK1KEX4kHx
 opIU3LcsPeUorye0RbRWZvVikM4Q1l/6+MoqdFM1UtrYopoQ03L9TLZuBMH8/cXmPxoSg0gohUv
 U7n2PtmPfNwXBmBsiYhVSk1Z9BjHmC6hn+3/ZEQ==
X-Google-Smtp-Source: AGHT+IHRDDbKpRo2cnquTLEtFMvL0lS7twQdBfs80OqOCXEwI0ZfJuaoKuqeHxZhsPIexpbBkoRoqsrmbBP+G5gy53g=
X-Received: by 2002:a05:6512:104c:b0:536:53e3:feae with SMTP id
 2adb3069b0e04-53b1a315e5bmr9444822e87.11.1729865097848; Fri, 25 Oct 2024
 07:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
 <20241024-rust-round-2-v1-3-051e7a25b978@linaro.org>
 <34f5191b-67d9-4815-a58b-a794fff0294d@redhat.com>
In-Reply-To: <34f5191b-67d9-4815-a58b-a794fff0294d@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 25 Oct 2024 17:04:41 +0300
Message-ID: <CAAjaMXZmNN5WS7ETQnGgUvWK+aY9w0oW+G3oBko_C2utK2BjHA@mail.gmail.com>
Subject: Re: [PATCH 03/11] rust/qemu-api-macros: introduce Device proc macro
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>, 
 Junjie Mao <junjie.mao@intel.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Kevin Wolf <kwolf@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x136.google.com
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

On Fri, 25 Oct 2024 at 15:01, Paolo Bonzini <pbonzini@redhat.com> wrote:

>
> (Generally, don't read too much in the code - the syntax might have
> issues but you get the idea).
>
>
> Anyhow, going forward to the property attribute:
>
> > +    #[property(name = c"migrate-clk", qdev_prop = qdev_prop_bool)]
>
> There are two issues here:
>
> First, the default is true, so 1) this has to be fixed in QEMU (will
> do), 2) it is important to support it in #[property()].


TODO, it was not ignored just planned as next


>
> Second, this provides a false sense of safety, because I could specify
> qdev_prop_chr here.  Instead, the qdev_prop type should be derived by
> the field type.

TODO, if you recall we had that discussion about external statics,
that was what I was looking into back then.


> Third, since we are at it there's no need to use c"" in the attribute.
> The c_str!() macro that I am adding for backwards compatibility to old
> versions of Rust might actually come in handy here.

TODO, you can you use both LitStr and LitCStr in the macro


>
> The part where I have most comments, and some ideas of how to make your
> work a little more maintainable, is the implementation of class_init
> (and all that depends on it).
>
> Let's start with these generated functions:
>
> > +        pub unsafe extern "C" fn #realize_fn(
> > +            dev: *mut ::qemu_api::bindings::DeviceState,
> > +            errp: *mut *mut ::qemu_api::bindings::Error,
> > +        ) {
> > +            let mut instance = NonNull::new(dev.cast::<#name>()).expect(concat!("Expected dev to be a non-null pointer of type ", stringify!(#name)));
> > +            unsafe {
> > +                ::qemu_api::objects::DeviceImpl::realize(instance.as_mut());
> > +            }
> > +        }
> > +
> > +        #[no_mangle]
> > +        pub unsafe extern "C" fn #reset_fn(
> > +            dev: *mut ::qemu_api::bindings::DeviceState,
> > +        ) {
> > +            let mut instance = NonNull::new(dev.cast::<#name>()).expect(concat!("Expected dev to be a non-null pointer of type ", stringify!(#name)));
> > +            unsafe {
> > +                ::qemu_api::objects::DeviceImpl::reset(instance.as_mut());
> > +            }
> > +        }
>
> This can be handled entirely in Rust code, outside the macro.  If you add:

Why? I don't understand what this solves. These are *just* trampoline
functions to call the Rust-abi code.


>
> unsafe extern "C" fn realize_fn_unsafe<T: DeviceImpl>(
>      dev: *mut DeviceState,
>      errp: *mut *mut Error,
> ) {
>      let mut instance = NonNull::new(dev.cast::<T>()).
>          expect("Expected dev to be a non-null pointer");
>      unsafe {
>          ::qemu_api::objects::DeviceImpl::realize(instance.as_mut());
>      }
> }
>
> unsafe extern "C" fn reset_fn_unsafe<T: DeviceImpl>(
>      dev: *mut ::qemu_api::bindings::DeviceState,
> ) {
>      let mut instance = NonNull::new(dev.cast::<T>()).
>          expect("Expected dev to be a non-null pointer");
>      unsafe {
>          ::qemu_api::objects::DeviceImpl::reset(instance.as_mut());
>      }
> }
>
> then the functions can be used directly instead of #realize_fn and
> #reset_fn with a blanket implementation of DeviceImplUnsafe:
>

So just rename them and put a generic argument. Still not seeing any gain here.


>
> unsafe impl DeviceImplUnsafe for T: DeviceImpl {
>      const REALIZE: ... = Some(realize_fn_unsafe::<T>);
>      const RESET: ... = Some(realize_fn_unsafe::<T>);
> }
>
> Going on to the implementation of the safe functions:
>
> > +impl DeviceImpl for PL011State {
> > +    fn realize(&mut self) {
>
> These are not quite traits.  First, you can implement only some of the
> functions.

This is called "default implementations" in Rust

 > Second, if you don't implement them they are not overwritten
> by the class_init method.

WYM overwritten? That we hook up the empty stub instead of a NULL
function pointer?

> So this points to a different implementation as an attribute macro,
> which is able to rewrite everything in the body of the impl.  For example:
>
> #[qom_class_init]
> impl DeviceImpl for PL011State {
>      fn realize(&mut self) { ... }
>      fn reset(&mut self) { ... }
>
>      const VMSTATE: ... = {}
>      const CATEGORY: ... = {}
> }
>
> can be transformed into:
>
> #[qom_class_init]
> impl DeviceImpl for PL011State {
>      // fns are wrapped and transformed into consts
>      const REALIZE: Option<fn(&mut self)> = {
>          fn realize(&mut self) { ... }
>          Some(realize)
>      };
>      const RESET: Option<fn(&mut self)> = {
>          fn reset(&mut self) { ... }
>          Some(reset)
>      };
>
>      // while associated consts (and perhaps types?) remain as is
>      const VMSTATE: ... = {}
>      const CATEGORY: ... = {}
> }
>
> The above blanket implementation of DeviceImplUnsafe is easily adjusted
> to support non-overridden methods:
>
> unsafe impl DeviceImplUnsafe for T: DeviceImpl {
>      const REALIZE: ... = <T as DeviceImpl>::REALIZE::map(
>          || realize_fn_unsafe::<T>);
>      const RESET: ... = <T as DeviceImpl>::RESET::map(
>          || realize_fn_unsafe::<T>);
> }
>
>
> You can also keep out of the macro the class_init method itself.  Here
> I'm adding it to DeviceImplUnsafe:
>
> pub trait DeviceImplUnsafe {
>      unsafe fn class_init(klass: *mut ObjectClass, data: *mut c_void) {
>          let mut dc = NonNull::new(klass.cast::<DeviceClass>()).unwrap();
>          unsafe {
>              dc.as_mut().realize = Self::REALIZE;
>              bindings::device_class_set_legacy_reset(
>                                   dc.as_mut(), Self::RESET);
>              device_class_set_props(dc.as_mut(),
>                                     <Self as DeviceInfo>::PROPS);
>              if let Some(vmsd) = <Self as DeviceInfo>::VMSTATE {
>                  dc.as_mut().vmsd = vmsd;
>              }
>              if let Some(cat) = <Self as DeviceInfo>::CATEGORY {
>                  dc.as_mut().category = cat;
>              }
>
>              // maybe in the future for unparent
>              // <Self as ObjectImplUnsafe>::class_init(klass, data)
>          }
>      }
> }
>
> And with all this machinery in place the device_class_init! macro
> becomes simply
>
>      device_class_init!(PL011State);
>
> (because the arguments have moved to DeviceInfo or DeviceImpl).
>
>
> Why is this important? Because the only code transformation is the
> generation of properties and vtables, and the bindings can be developed
> almost entirely in qemu_api instead of qemu_api_macros.  This has
> several advantages:
>
> 1) it's much easier: simpler error messages, no macro indirection, no
> super long global crate paths

Hard no, sorry. Error messages can definitely be generated from proc
macros. Long crate paths; that's just a matter of using imports or
changing names.
>
> 2) it allows simplifying the pl011 code piecewise, even before
> introducing procedural macro code

Not sure how that is relevant can you explain?

>
> 3) it's easier to add comments
>
>
> It also becomes much easier to separate the work in separate patches, or
> even separate series.  Replacing the arguments to device_class_init!()
> with DeviceImpl + DeviceImplUnsafe can be introduced first: posted,
> reviewed, merged.  All the remaining tasks are pretty much independent:
>
> 1) splitting out ObjectInfo and introducing #[object] to automate it
> (i.e. extending derive(Object))
>
> 2) splitting out DeviceInfo and introducing #[property] to automate it
> (i.e. derive(Device))
>
> 3) the #[qom_class_init] macro


I disagree with this approach at the moment. This patch is in an
acceptable state albeit a bit longish while all these suggestions
would merely cause  more running around making changes for no real
gain while also delaying review and merging.


>
> A final word: I absolutely don't want you to think that your work is of
> no value.  It's totally okay to throw away the first version of
> something.  You showed that it _is_ possible to have idiomatic code with
> the help of procedural macros.  Even if the implementation can be
> improved, the _idea_ remains yours.

I don't know what this is in reference to :P What work and throwing
away are you talking about?

> Paolo
>

