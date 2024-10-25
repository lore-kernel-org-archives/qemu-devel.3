Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5519D0BB56
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 15:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4M9U-000440-3i; Fri, 25 Oct 2024 11:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4M9S-00043n-Cm
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:22:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4M9P-00081O-Ur
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729869773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nii1EAnXm8u8JrjMH/ssb6+jDyu0dxGGtoA3oVgG3Uc=;
 b=h+0OR3pBFJaTl4gmVLZZ+3r7ggUEZwi03YvxN3Nq6+5d/R6TIHGVrx9tUx2M+rdG2ceZl0
 ib7ag69MOeUQo1c4jxVkcL3fgbLTet/4N6l/g+mzMWGGpLjFByXat9U0X4t2EJgeLjZQyo
 JD7B02HgXyREZVcfGxylxsK0zSVv/+c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-lEz36SKxP-2fmThMABdfSA-1; Fri, 25 Oct 2024 11:22:52 -0400
X-MC-Unique: lEz36SKxP-2fmThMABdfSA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d59ad50f3so1125264f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 08:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729869771; x=1730474571;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nii1EAnXm8u8JrjMH/ssb6+jDyu0dxGGtoA3oVgG3Uc=;
 b=sg1GR7GKt61/HFK2Y4wUbAj5xujgtTpvTrj10L4IF9nWRqrMtT7oK+TRbQEw+FExFW
 gH7/RdekKW5mxYVtMW+HXDt6MavF50XVdarsCkS9Kqywq6dAZrFsTYHlfomay7EELR1C
 PzQEh8k6LlompbJroEMYFK/DzGJNGnNbsJqJxvQRJsKdCBRAM8z+EhZ18eCBj/skWDME
 5gdpSCkRGaXNqN7YyXMWL04k4myKa3jW5QGVkiIvVM5bHa3R/nzmwHOIGznpI20wQq+g
 dH1HH41Fh4KM55hQqhJzrRj7aiE+4fb6n1BsQFyxumjntGq4g4O0YmN6Y3CN/0hiLOL0
 xi7w==
X-Gm-Message-State: AOJu0Yyrooq86JmtLbVQjEkZEaZ0MoVJm/tdemQHYL0mJiaztEXEFTWj
 6EWrvk1wVyojtMrLxZuEpqrLw4C4rdOssRhAPzZpL+jMkfQVAJi5BlSG2TEYdZu/X0KHMKe41qm
 LfHu0XkmuLy0lMuf1gTSnfqnoXBqfRAgzh7NlbOqf5SMr199TgyGCGk0N8X9u9DA0/MoUxSlXza
 uDhgpNnh+msOTdBupWefhGoECcbJk=
X-Received: by 2002:a05:6000:c8b:b0:37d:4ebe:164c with SMTP id
 ffacd0b85a97d-380458b5659mr4456475f8f.45.1729869770649; 
 Fri, 25 Oct 2024 08:22:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHol0HRRzkMxLrjRWePJWcWjP8wj3i78om5sS59AR6PaFGqyF5HU8cV2KxV2BrNt/8JDlk84HHjHaSrMyJAytQ=
X-Received: by 2002:a05:6000:c8b:b0:37d:4ebe:164c with SMTP id
 ffacd0b85a97d-380458b5659mr4456439f8f.45.1729869770191; Fri, 25 Oct 2024
 08:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241024-rust-round-2-v1-0-051e7a25b978@linaro.org>
 <20241024-rust-round-2-v1-3-051e7a25b978@linaro.org>
 <34f5191b-67d9-4815-a58b-a794fff0294d@redhat.com>
 <CAAjaMXZmNN5WS7ETQnGgUvWK+aY9w0oW+G3oBko_C2utK2BjHA@mail.gmail.com>
In-Reply-To: <CAAjaMXZmNN5WS7ETQnGgUvWK+aY9w0oW+G3oBko_C2utK2BjHA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Oct 2024 17:22:37 +0200
Message-ID: <CABgObfZj1ViRJ_6mgvuzYuHGqLvQ43G+va-6ahZbk8ripr5pcQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] rust/qemu-api-macros: introduce Device proc macro
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
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
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

[snipping to concentrate on the QOM code generation]

On Fri, Oct 25, 2024 at 4:05=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> > The part where I have most comments, and some ideas of how to make your
> > work a little more maintainable, is the implementation of class_init
> > (and all that depends on it).
> >
> > Let's start with these generated functions:
> >
> > > +        pub unsafe extern "C" fn #realize_fn(
> > > +            dev: *mut ::qemu_api::bindings::DeviceState,
> > > +            errp: *mut *mut ::qemu_api::bindings::Error,
> > > +        ) {
> > > +            let mut instance =3D NonNull::new(dev.cast::<#name>()).e=
xpect(concat!("Expected dev to be a non-null pointer of type ", stringify!(=
#name)));
> > > +            unsafe {
> > > +                DeviceImpl::realize(instance.as_mut());
> > > +            }
> > > +        }
> > > +
> > > +        #[no_mangle]
> > > +        pub unsafe extern "C" fn #reset_fn(
> > > +            dev: *mut ::qemu_api::bindings::DeviceState,
> > > +        ) {
> > > +            let mut instance =3D NonNull::new(dev.cast::<#name>()).e=
xpect(concat!("Expected dev to be a non-null pointer of type ", stringify!(=
#name)));
> > > +            unsafe {
> > > +                DeviceImpl::reset(instance.as_mut());
> > > +            }
> > > +        }
> >
> > This can be handled entirely in Rust code, outside the macro.  If you a=
dd:
>
> Why? I don't understand what this solves. These are *just* trampoline
> functions to call the Rust-abi code.

Yes, and there is no need to place them in the procedural macros.

Generally it's a good rule to do as little as possible in procedural
macros, and move as much code as possible outside; this often means to
generic functions or a declarative macros. For some examples you can
look at Linux; in rust/macros/zeroable.rs for example the only
"quote!" is

    quote! {
        ::kernel::__derive_zeroable!(
            parse_input:
                @sig(#(#rest)*),
                @impl_generics(#(#new_impl_generics)*),
                @ty_generics(#(#ty_generics)*),
                @body(#last),
        );
    }

For more information, see https://www.youtube.com/watch?v=3DDMLBBZBlKis

> > unsafe extern "C" fn realize_fn_unsafe<T: DeviceImpl>(...) {}
> > unsafe extern "C" fn reset_fn_unsafe<T: DeviceImpl>(...) {}
>
> So just rename them and put a generic argument. Still not seeing any gain=
 here.

The gain is that you have a much shorter macro implementation, a
shorter expansion which makes it easier to debug the macro, and an
implementation of realize_fn_unsafe<>() and reset_fn_unsafe<>() that
is isolated.

> > Going on to the implementation of the safe functions:
> >
> > > +impl DeviceImpl for PL011State {
> > > +    fn realize(&mut self) {
> >
> > These are not quite traits.  First, you can implement only some of the
> > functions.
>
> This is called "default implementations" in Rust

Sort of. Yes, this is related to default implementations, but the
default implementation of a QOM method is not "call whatever is
declared in the trait". It's "call whatever is defined by the
superclass", which is represented by None.

>  > Second, if you don't implement them they are not overwritten
> > by the class_init method.
>
> WYM overwritten? That we hook up the empty stub instead of a NULL
> function pointer?

Not really the NULL function pointer: the value left by the
superclass. In other words, the class_init function should not have

    // realize is a function in a trait
    dc.as_mut().realize =3D Self::realize;

but rather

    // realize is a constant Option<fn(...)> in a trait
    if let Some(realize_fn) =3D Self::REALIZE {
        dc.as_mut().realize =3D Self::realize_fn;
    }

> > Why is this important? Because the only code transformation is the
> > generation of properties and vtables, and the bindings can be developed
> > almost entirely in qemu_api instead of qemu_api_macros.  This has
> > several advantages:
> >
> > 1) it's much easier: simpler error messages, no macro indirection, no
> > super long global crate paths
>
> Hard no, sorry. Error messages can definitely be generated from proc
> macros. Long crate paths; that's just a matter of using imports or
> changing names.

I don't mean error messages from proc macros. I mean that debugging
macros that are this complex (does not matter if procedural or
declarative) is hell. If you move code outside the macro, to generic
functions and blanket trait implementations, error messages from the
compiler are simpler.

One additional benefit is that the code is compiled _always_, not just
if the macro hits a specific code path. It simplifies the testing
noticeably.

Finally, without -Zmacro-backtrace (nightly only) debugging procedural
macros is a tedious matter of using "cargo expand". With
-Zmacro-backtrace it's better but we don't want developers to install
nightly to develop QEMU. Note that this code is not write-once; it
will be extended for example as soon as we have a device that can fail
realization.

> Long crate paths; that's just a matter of using imports or
> changing names.

Only to some extent. See how many ::core::ffi:: or ::core::mem:: are
there in the current macros.

> > 2) it allows simplifying the pl011 code piecewise, even before
> > introducing procedural macro code
>
> Not sure how that is relevant can you explain?

Alex asked for a way to validate the expansion of the macro. If the
procedural macro is simple and the code is outside, then reviewers can
easily compare the pl011 code and the qemu-api-macros code, and see
that they expand to the same thing.

Try to put yourself into the mindset of the reviewer. If I see a patch like

+#[qom_class_init]
 impl DeviceImpl for PL011State {
-    const REALIZE: Option<fn(&mut self)> =3D {
         fn realize(&mut self) { ... }
-        Some(realize)
-    };

-    const RESET: Option<fn(&mut self)> =3D {
         fn reset(&mut self) { ... }
-        Some(reset)
-    };

     const VMSTATE: ... =3D ...;
     const CATEGORY: ... =3D ...;
 }

... then it's quite obvious what to expect from the expansion of the
#[qom_class_init] attribute macro.

> > It also becomes much easier to separate the work in separate patches, o=
r
> > even separate series.  Replacing the arguments to device_class_init!()
> > with DeviceImpl + DeviceImplUnsafe can be introduced first: posted,
> > reviewed, merged.  All the remaining tasks are pretty much independent:
> >
> > 1) splitting out ObjectInfo and introducing #[object] to automate it
> > (i.e. extending derive(Object))
> >
> > 2) splitting out DeviceInfo and introducing #[property] to automate it
> > (i.e. derive(Device))
> >
> > 3) the #[qom_class_init] macro
>
> I disagree with this approach at the moment. This patch is in an
> acceptable state albeit a bit longish while all these suggestions
> would merely cause  more running around making changes for no real
> gain while also delaying review and merging.

I will be very clear: no, this patch is very far from an acceptable
state. It's a wonderful prototype, just like hw/char/pl011, but at
this point we're not accepting prototype-quality Rust code anymore:
we're turning the existing prototype, which has a manageable but still
large size, into the real thing.

To sum up the basic points underlying the suggestions, my review comments a=
re:

- the syntax of #[device(...)] is arbitrary. You are keeping things
that obviously refer to the QOM object (type name, parent type name)
far from #[derive(Object)]. You are putting in #[device()] things that
apply to the QOM object class (e.g. class_name_override) rather than
the QOM device class. Finally, you are putting in #[device()] the
vmstate, which is not self-contained (due to subsections).

- the split in modules needs more work. For example, why is
Migrateable under qemu_api::objects instead of qemu_api::device_class?

- the part that would require the fewest changes is probably
#[property], but we need to be careful about not introducing "fake
safety".

- to simplify splitting the patches, start by moving code out of the
existing declarative macros and into generic code or declarative
macros

- to simply reviewing the patches, only use the procedural macros as a
syntactic sugar, and do as little code generation as possible in the
procedural macros themselves

- splitting the ObjectImpl/DeviceImpl traits in two (one for code
generated by derive-macros; one for stuff that is definde outside the
struct declaration) could be a way to work incrementally, adding more
and more parts of the class definition to the procedural macro but
without doing everything at once

- it must be possible to specify non-overridden DeviceClass or
ObjectClass functions

The suggestions are just a way to achieve these objectives. In
particular, the suggestions are about how to achieve the bullets in
the above list starting from the third.

Also, this series *must* come after the other cleanups and CI
integration that have been posted, for several reasons.

As to the cleanups, right now we *already* have in the tree code that
is duplicate, dead or untested. Removing that, and ensuring that it
does not regress, is a priority over everything else.

As to CI integration, first, changes like this one must be fully
bisectable, which requires having working CI before. Second, if we
want to advertise 9.2 as supporting --enable-rust (even if
experimental), we need a way to run automated tests on at least _some_
of the platforms that we support.

So my plan right now is to post a pull request for part 1 next week,
and to include part 2 (including your work on migration and Luminary,
but without the procedural macro) in -rc1. This work is for 10.0.

> > A final word: I absolutely don't want you to think that your work is of
> > no value.  It's totally okay to throw away the first version of
> > something.  You showed that it _is_ possible to have idiomatic code wit=
h
> > the help of procedural macros.  Even if the implementation can be
> > improved, the _idea_ remains yours.
>
> I don't know what this is in reference to :P What work and throwing
> away are you talking about?

I was talking in general. When working in Rust I often found that the
first thing I came up with was crap, and the main value of it was in
learning. Sometimes I came up with the second version on my own,
sometimes it was pointed out during review. But even if it's pointed
out during review, the reviewer doesn't in any way think bad of you or
your work.

Paolo


