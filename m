Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292FFC83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 09:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZnpt-0006gP-07; Thu, 10 Jul 2025 05:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZnmI-0003uz-Iv
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 05:41:23 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uZnmE-0001QA-FL
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 05:41:17 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-60700a745e5so1430264a12.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 02:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752140459; x=1752745259; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+X/My+fccYmoU/a5r3/dgMI3DlG1ukJmNg/JqkbMMUs=;
 b=p23px/aZQMiEerYOlzJ0wKOBP//MmKOC+l3wztBcqsDICYewNBxmBnxx6euIllaNfF
 /T6JF7tebqIZ4taPesVj2ZM+gT9dDSgvGKj0bLRpInBaZAQFmlGkVKYxHsoZ6czW2QbW
 CbbR7j9gzzKbRtO5JqGp44uKLaU9ugeo1+q3l7OeVM+O0IHiKsHO2Qjm6Ko3yapstJ27
 YK0htLgehNaOCLfYS/7y/oDtjD1NCF91q0btjBI5geRiAxQM1DTV4ByQIZnYxlpJFkIv
 y1VnWUfHQj/Ihoqi1abC2lTP+sQ0lBQagQiqdap9YjeKhCdQmsKOUlmsKNwCZpMpskkS
 VkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752140459; x=1752745259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+X/My+fccYmoU/a5r3/dgMI3DlG1ukJmNg/JqkbMMUs=;
 b=SfFLZBw1J7k8zzb2pGbFWdvU0NxIeVCnUnPWYKfZpzXBsAvs7dNEuHSFBnKRp2QtRf
 rqbGWB96lmiKi6FCb5551rikcV7AjJeTWJsh59OJMj2hQWuYle4Ha8QjXHRNAzlJ0pVT
 nl/POEoGdBOIVXXw3bvEVAwfv9sTiUGsqINdJ2H4yOhEPt9pvQZWkynsx1E0UQzMnDwE
 To1+Cf6V0OwbV/Qg4ClxeeylLM3eZuWogkx13OHmty3jcFgmdmIINbNrQ7YTyg0HXEa1
 JoycwQQS/iQc99rBqtTid29r09UTR3vVUPJOJNdsgEsgUIUp7SZrQmAOdCkzevmGitOe
 a30w==
X-Gm-Message-State: AOJu0YweexxqrXtf5xlcV/7V2HF7kgM94Qnd8yIAhxhFGATdD5lr1DFb
 8cVMxz0FZUzzt4h4bohzDCPV2B+eWcHNbcFYBNP3GmFL1k4B7G+VC/wb9GQMcQKASuR3LtdCjtq
 WVmQ4iZexJPuCzTKRrx5QMWcySVRAzv+a8RrDyimE2Q==
X-Gm-Gg: ASbGncusKf6kfYjzJH7afXIQk69qYJwkHY+wHHYdZuydH5KjgNoaM201hSOypcr5dzI
 64O8oAOFr8+GoEoxiz+opQgd9FLQfRqRNRIbAgn1bOYn2SveKB7gWK6uxyYIjyjRF+Saut7dtK1
 mYZJ9wqINWCsToYqp/cspLjJk1k9Cpn9fRQBO+pPeLFI6T7f+wUqSahg==
X-Google-Smtp-Source: AGHT+IHFR95borLPoiLx1vYBl8kT16hfp7qWyYFUhIcO5NUasn/i/FHnnS3Y8qrhqlLQ5C9VHdq41opOgeaQAWot9IY=
X-Received: by 2002:a05:6402:35cf:b0:607:f513:4808 with SMTP id
 4fb4d7f45d1cf-611c83fc620mr1581190a12.1.1752140459321; Thu, 10 Jul 2025
 02:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250703-rust-qdev-properties-v2-1-d4afac766e94@linaro.org>
 <63edd7ca-02b3-416c-ae28-38bd5386aa89@redhat.com>
In-Reply-To: <63edd7ca-02b3-416c-ae28-38bd5386aa89@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 10 Jul 2025 12:40:31 +0300
X-Gm-Features: Ac12FXwVQrqYjz5BLgNbMB8ChiJWM7kebKLvctS4dt7JOL4ISAoGEeujoynmMtg
Message-ID: <CAAjaMXbdA51QOR0tx4OnbSnWdx9=cjR_GsaMFdAvrVHy9a-XQQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2] rust: add qdev DeviceProperties derive macro
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52a.google.com
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

Thanks for the comments, I am preparing a new version with all
problems/suggestions fixed.

On Tue, Jul 8, 2025 at 12:48=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 7/3/25 16:37, Manos Pitsidianakis wrote:
> > Add derive macro for declaring qdev properties directly above the field
> > definitions. To do this, we split DeviceImpl::properties method on a
> > separate trait so we can implement only that part in the derive macro
> > expansion (we cannot partially implement the DeviceImpl trait).
> >
> > Adding a `property` attribute above the field declaration will generate
> > a `qemu_api::bindings::Property` array member in the device's property
> > list.
> >
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>
> Very nice.  I have relatively many comments but they are all very
> simple.  The main ones are about unused functionality that could be left
> for later, and some code duplication.
>
> Aside from that, I actually liked using Device for the macro name in
> your earlier versions.  Yes, it's just for properties in practice, but
> it's nice and small to just say Device; and it mimics Object.  It's your
> choice anyway.

I was thinking of making a `Device` derive macro that lets you also
define `DeviceImpl::REALIZE` and `DeviceImpl::vmsd` as macro
attributes on the struct definition, then merge DeviceProperties into
that. WDYT?

>
> > - Update hpet code to use the derive macro
>
> Don't worry about that for the first inclusion.  More below.
>
> > - Change MacroError use to syn::Error use if changed in upstream too
>
> True.  In the review below I'll just use syn::Error instead of MacroError=
.
>
> > +impl DevicePropertiesImpl for PL011Luminary {}
>
> Does it make sense to use #[derive()] anyway, and skip the import?
> Especially because...

Oops, yes.

>
> > +/// Trait to define device properties.
> > +pub trait DevicePropertiesImpl {
> > +    /// An array providing the properties that the user can set on the
> > +    /// device.  Not a `const` because referencing statics in constant=
s
> > +    /// is unstable until Rust 1.83.0.
> > +    fn properties() -> &'static [Property] {
> > +        &[]
> > +    }
> > +}
> > +
>
> ... the trait should be declared unsafe(*), and it's nice to hide the
> implementation of unsafe traits behind macros that do guarantee the safet=
y.

Good idea, will do,

>
>         (*) One can also declare properties() unsafe, but with 1.83.0
>              properties() becomes an associated const, and there are no
>              unsafe const declarations... might as well plan ahead.
>
> And then, what about calling the trait "DeviceImplUnsafe"?  It is a
> clearer split: device code uses #[derive()] for anything that cannot be
> declared safely (think of zerocopy), and impl for what *is* safe.

Hm, isn't it redundant if the trait is marked as `unsafe`? Or maybe I
misunderstood your point.
>
> > +            } else if value =3D=3D "qdev_prop" {
> > +                let _: syn::Token![=3D] =3D content.parse()?;
> > +                if retval.qdev_prop.is_some() {
> > +                    return Err(syn::Error::new(
> > +                        value.span(),
> > +                        "`qdev_prop` can only be used at most once",
> > +                    ));
> > +                }
> > +                retval.qdev_prop =3D Some(content.parse()?);
>
> qdev_prop is only needed together with bitnr, right?  If so:
>
> 1) Thoughts for later: maybe if bitnr is used the macro should use a
> different trait than QDevProp (e.g. QDevBitProp).  Would this be enough
> for qdev_prop to go away? (I think/hope so)
>
> 2) Thoughts for now: maybe leave out bitnr and qdev_prop?  And revisit
> together with the HPET conversion, which needs bitnr.

Agreed, that makes more sense

>
> > +        let prop_name =3D rename
> > +            .as_ref()
>
> I think ".as_ref()" is not needed?  I may be wrong though.
>
> > +                DevicePropertyName::Str(lit) =3D> {> +                =
    let span =3D lit.span();
> > +                    let value =3D lit.value();
> > +                    let lit =3D std::ffi::CString::new(value.as_str())
> > +                        .map_err(|err| {
> > +                            MacroError::Message(
> > +                                format!("Property name `{value}` canno=
t be represented as a C string: {err}"),
> > +                                span
> > +                            )
> > +                        })?;
> > +                    let lit =3D syn::LitCStr::new(&lit, span);
> > +                    Ok(quote_spanned! {span=3D>
> > +                        #lit
> > +                    })
>
> quote_spanned! is not needed here, because all the tokens that you're
> producing are interpolated:
>
>    Any interpolated tokens preserve the Span information provided by
>    their ToTokens implementation. Tokens that originate within the
>    quote_spanned! invocation are spanned with the given span argument
>    (https://docs.rs/quote/1.0.40/quote/macro.quote_spanned.html)
>
> Also please extract this into a separate function.  That is, make
> everything just
>
>      make_c_str(lit.value(), lit.span())
>
> (make_c_str returns a Result<syn::LitCStr, syn::Error>).
>
> > +            .unwrap_or_else(|| {
> > +                let span =3D field_name.span();
> > +                let field_name_value =3D field_name.to_string();
> > +                let lit =3D std::ffi::CString::new(field_name_value.as=
_str()).map_err(|err| {
> > +                    MacroError::Message(
> > +                        format!("Field `{field_name_value}` cannot be =
represented as a C string: {err}\nPlease set an explicit property name usin=
g the `rename=3D...` option in the field's `property` attribute."),
>
> I don't think this error can happen, because the field name cannot
> contain a NUL character and that's the only way CString::new fails.  So
> just using the same function above is fine, because the more detailed
> error isn't necessary.
>
> Putting everything together and using .map_or_else() gives you something
> like this:
>
>          let prop_name =3D rename
>              .map_or_else(
>                  || make_c_str(field_name.to_string(), field_name.span())
>                  |lit| {
>                      match lit {
>                          DevicePropertyName::CStr(lit) =3D> {
>                              Ok(lit)
>                          }
>                          DevicePropertyName::Str(lit) =3D> {
>                              make_c_str(lit.value(), lit.span())
>                          }
>                      }
>                  })?;
>
> You could even go ahead and only accept syn::LitStr, dropping
> DevicePropertyName altogether.  But since you've written the code and
> c"" support is only 10-15 lines of code overall, do as you wish.
>
> > +                        span
> > +                    )
> > +                })?;
> > +                let lit =3D syn::LitCStr::new(&lit, span);
> > +                Ok(quote_spanned! {span=3D>
> > +                    #lit
> > +                })
> > +            })?;
> > +        let field_ty =3D field.ty.clone();
> > +        let qdev_prop =3D qdev_prop
> > +            .as_ref()
>
> Again, .as_ref() might not be needed here either.
>
> > +            .map(|path| {
> > +                quote_spanned! {field_span=3D>
> > +                    unsafe { &#path }
> > +                }
> > +            })
> > +            .unwrap_or_else(
> > +                || quote_spanned! {field_span=3D> <#field_ty as ::qemu=
_api::qdev::QDevProp>::VALUE },
> > +            );
>
> If you decide to keep qdev_prop, .map_or_else() can be used here too.
>
> > +        let set_default =3D defval.is_some();
> > +        let bitnr =3D bitnr.as_ref().unwrap_or(&zero);
> > +        let defval =3D defval.as_ref().unwrap_or(&zero);
> > +        properties_expanded.push(quote_spanned! {field_span=3D>
> > +            ::qemu_api::bindings::Property {
> > +                name: ::std::ffi::CStr::as_ptr(#prop_name),
> > +                info: #qdev_prop ,
> > +                offset: ::core::mem::offset_of!(#name, #field_name) as=
 isize,
> > +                bitnr: #bitnr,
> > +                set_default: #set_default,
> > +                defval: ::qemu_api::bindings::Property__bindgen_ty_1 {=
 u: #defval as u64 },
>
> Maybe add a TODO that not all types should have a default (e.g.
> pointers).  No need to fix it now, but having a note in the code would
> be nice.
>
> > diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
> > index 36f02fb57dbffafb21a2e7cc96419ca42e865269..01f199f198c6a5f8a761beb=
143e567fc267028aa 100644
> > --- a/rust/qemu-api/src/qdev.rs
> > +++ b/rust/qemu-api/src/qdev.rs
> > @@ -101,8 +101,54 @@ pub trait ResettablePhasesImpl {
> >       T::EXIT.unwrap()(unsafe { state.as_ref() }, typ);
> >   }
> >
> > +/// Helper trait to return pointer to a [`bindings::PropertyInfo`] for=
 a type.
> > +///
> > +/// This trait is used by [`qemu_api_macros::DeviceProperty`] derive m=
acro.
> > +///
> > +/// # Safety
> > +///
> > +/// This trait is marked as `unsafe` because currently having a `const=
` refer to an `extern static`
> > +/// results in this compiler error:
> > +///
> > +/// ```text
> > +/// constructing invalid value: encountered reference to `extern` stat=
ic in `const`
> > +/// ```
> > +///
> > +/// It is the implementer's responsibility to provide a valid [`bindin=
gs::PropertyInfo`] pointer
> > +/// for the trait implementation to be safe.
> > +pub unsafe trait QDevProp {
> > +    const VALUE: *const bindings::PropertyInfo;
>
> "*const" or "&"?

This is the thing I mentioned to you over IRC: Unfortunately even with
const refs for statics we get this because the static is extern:

error[E0080]: it is undefined behavior to use this value
   --> build/rust/qemu-api/libqemu_api.rlib.p/structured/qdev.rs:135:5
    |
135 |     const VALUE: &'static bindings::PropertyInfo =3D unsafe {
&bindings::qdev_prop_chr };
    |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ constructing
invalid value: encountered reference to `extern` static in `const`
    |
    =3D note: The rules on what exactly is undefined behavior aren't
clear, so this check might be overzealous. Please open an issue on the
rustc repository if you believe it should not be considered undefined
behavior.
    =3D note: the raw bytes of the constant (size: 8, align: 8) {
                =E2=95=BE=E2=94=80=E2=94=80=E2=94=80=E2=94=80alloc93<imm>=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=BC                     =
    =E2=94=82 =E2=95=BE=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=95=BC
            }
IIUC the error, it's because const refs can get dereferenced in const
context by the compiler in general, but PropertyInfo does not get
dereferenced anywhere so we are good.

>
> > @@ -68,10 +68,13 @@ impl ObjectImpl for DummyState {
> >
> >   impl ResettablePhasesImpl for DummyState {}
> >
> > -impl DeviceImpl for DummyState {
> > +impl DevicePropertiesImpl for DummyState {
> >       fn properties() -> &'static [Property] {
> >           &DUMMY_PROPERTIES
> >       }
> > +}
>
> You can easily use #[derive()] here too, since the DummyState code is
> mostly copied from pl011.
>
> > +impl DevicePropertiesImpl for DummyChildState {}
>
> ... and here too.
>
> Thanks,
>
> Paolo
>



--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

