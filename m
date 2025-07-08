Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700C7C83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFCA-0007S2-J3; Tue, 08 Jul 2025 16:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZDkK-0001tL-M8
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZDk8-0006Od-RS
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752001959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1rfzYxDUpv0Tylp1QlKL9hPZrfntityS4sq9sZVtVaw=;
 b=cSpBsbvf6EivNu3xoFLdlXkUDoXIhdiGbJLaqSMlEAEbX6KBZJMfAZEmNOf0xDVPlDYT4e
 jdWtY0cKgj3RI0dfVh3DTRFVZaep1+RZwAybqyYtLfuezUTml6/Cugu+ldXjU+WZbKk2xm
 YuYURv4n8/Cg0E7z54nMRSIbEcUdeM0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-FZjgV6tkNsCrwwsx__nJpg-1; Tue, 08 Jul 2025 05:48:04 -0400
X-MC-Unique: FZjgV6tkNsCrwwsx__nJpg-1
X-Mimecast-MFC-AGG-ID: FZjgV6tkNsCrwwsx__nJpg_1751968083
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-454b907e338so24351445e9.1
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 02:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751968082; x=1752572882;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1rfzYxDUpv0Tylp1QlKL9hPZrfntityS4sq9sZVtVaw=;
 b=GgRM92Mg3QdTvF2nhP6iXtDzEK9IHo3bpENM4MfNzREqqdYSxWJ4Afnt709r6lm8Kn
 U/j84h7w1T2yL7hcCCi3guVW226C+DDevEoL4TBEfgDIFfbYEKfleV0McYfiy5dLMa1M
 Phgju5x3z/1Ukef+R9n1iL5UIPsd2lDkbTfZ46mADZhimdAI7EA1mDJ4zEJqS/rD6HlO
 2USuRwd6wf8ktBZIgMydKJl1mjshdsWwG+zgUDxmJFXjyYAjQsz0xOKZfhBP5xOOQxgk
 1LmM4c4Ebh0h4evw0mlWZKATpOLmkfwcBKNTtgFZOklsXvnypaQ0JG1bN8mPeiDls9jw
 UT5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYOF88XWTIS/ZOrRoq7uaIah6EYGLjDk1Ei97DUhVtXSNOoq9qMeD/Zia5FqmrDhJlrJO6TufLw9MP@nongnu.org
X-Gm-Message-State: AOJu0YzwblNDK0RvdIUYzqO3Uu9qPyfyD3tMcAQqR5jwaUj7tr9Byl3e
 FVIgJ/frFEGc+iZwTnxoCZe/aKyxmnoplSbElCy6FRoQNB/qCqKZs/C4lgHXEqu9ANKlL7chCbP
 C0AxOHqmLahutlTfvJ/MyeiPqSrX2hQBVAooq1Aldt5KsmjGgXNiSD5hbjEGc9Pkx
X-Gm-Gg: ASbGncuOtguUHGaQBO2P2erSSUAGJxFYreqy0QhV8GwQM23V+Y9wGwDKuSwvhawtTgH
 adzwfDjvjc1LOQWls8QaNe35HITsGAvnL0Rs5oABKr4Fupme/d6xt1G/7U5S/W+NCuLt8eHnQJM
 IwOJUIwqexHnr/0cg6vjNpaBqLh9BiO1VZrb/fm+tMHfx+fNwgGOxZL9VwUP5hCH9LnfRHZmBs/
 zm+PHwUvq6IBFCYnNARlBQrMDoWfuO9kZT9qoyqiaDLOEdz10XD/UznK9ZzLYc1rpb4P9TPB3w2
 8C67gA6R0tNF7D5xiwdl98CakTY=
X-Received: by 2002:a05:600c:c4a1:b0:43d:4686:5cfb with SMTP id
 5b1f17b1804b1-454cd51d0ddmr20398715e9.27.1751968082052; 
 Tue, 08 Jul 2025 02:48:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjGJ9hhIiZDu3b5iLqrG1uKpKFH967e9VIjSab8B0det6E7h323e2OAslO8EFOblHuMRzvnw==
X-Received: by 2002:a05:600c:c4a1:b0:43d:4686:5cfb with SMTP id
 5b1f17b1804b1-454cd51d0ddmr20398425e9.27.1751968081505; 
 Tue, 08 Jul 2025 02:48:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.202.169])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-454cd45061csm16600845e9.15.2025.07.08.02.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 02:48:00 -0700 (PDT)
Message-ID: <63edd7ca-02b3-416c-ae28-38bd5386aa89@redhat.com>
Date: Tue, 8 Jul 2025 11:47:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2] rust: add qdev DeviceProperties derive macro
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
References: <20250703-rust-qdev-properties-v2-1-d4afac766e94@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250703-rust-qdev-properties-v2-1-d4afac766e94@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/3/25 16:37, Manos Pitsidianakis wrote:
> Add derive macro for declaring qdev properties directly above the field
> definitions. To do this, we split DeviceImpl::properties method on a
> separate trait so we can implement only that part in the derive macro
> expansion (we cannot partially implement the DeviceImpl trait).
> 
> Adding a `property` attribute above the field declaration will generate
> a `qemu_api::bindings::Property` array member in the device's property
> list.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Very nice.  I have relatively many comments but they are all very 
simple.  The main ones are about unused functionality that could be left 
for later, and some code duplication.

Aside from that, I actually liked using Device for the macro name in 
your earlier versions.  Yes, it's just for properties in practice, but 
it's nice and small to just say Device; and it mimics Object.  It's your 
choice anyway.

> - Update hpet code to use the derive macro

Don't worry about that for the first inclusion.  More below.

> - Change MacroError use to syn::Error use if changed in upstream too

True.  In the review below I'll just use syn::Error instead of MacroError.

> +impl DevicePropertiesImpl for PL011Luminary {}

Does it make sense to use #[derive()] anyway, and skip the import? 
Especially because...

> +/// Trait to define device properties.
> +pub trait DevicePropertiesImpl {
> +    /// An array providing the properties that the user can set on the
> +    /// device.  Not a `const` because referencing statics in constants
> +    /// is unstable until Rust 1.83.0.
> +    fn properties() -> &'static [Property] {
> +        &[]
> +    }
> +}
> +

... the trait should be declared unsafe(*), and it's nice to hide the 
implementation of unsafe traits behind macros that do guarantee the safety.

	(*) One can also declare properties() unsafe, but with 1.83.0
             properties() becomes an associated const, and there are no
             unsafe const declarations... might as well plan ahead.

And then, what about calling the trait "DeviceImplUnsafe"?  It is a 
clearer split: device code uses #[derive()] for anything that cannot be 
declared safely (think of zerocopy), and impl for what *is* safe.

> +            } else if value == "qdev_prop" {
> +                let _: syn::Token![=] = content.parse()?;
> +                if retval.qdev_prop.is_some() {
> +                    return Err(syn::Error::new(
> +                        value.span(),
> +                        "`qdev_prop` can only be used at most once",
> +                    ));
> +                }
> +                retval.qdev_prop = Some(content.parse()?);

qdev_prop is only needed together with bitnr, right?  If so:

1) Thoughts for later: maybe if bitnr is used the macro should use a 
different trait than QDevProp (e.g. QDevBitProp).  Would this be enough 
for qdev_prop to go away? (I think/hope so)

2) Thoughts for now: maybe leave out bitnr and qdev_prop?  And revisit 
together with the HPET conversion, which needs bitnr.

> +        let prop_name = rename
> +            .as_ref()

I think ".as_ref()" is not needed?  I may be wrong though.

> +                DevicePropertyName::Str(lit) => {> +                    let span = lit.span();
> +                    let value = lit.value();
> +                    let lit = std::ffi::CString::new(value.as_str())
> +                        .map_err(|err| {
> +                            MacroError::Message(
> +                                format!("Property name `{value}` cannot be represented as a C string: {err}"),
> +                                span
> +                            )
> +                        })?;
> +                    let lit = syn::LitCStr::new(&lit, span);
> +                    Ok(quote_spanned! {span=>
> +                        #lit
> +                    })

quote_spanned! is not needed here, because all the tokens that you're 
producing are interpolated:

   Any interpolated tokens preserve the Span information provided by
   their ToTokens implementation. Tokens that originate within the
   quote_spanned! invocation are spanned with the given span argument
   (https://docs.rs/quote/1.0.40/quote/macro.quote_spanned.html)

Also please extract this into a separate function.  That is, make 
everything just

     make_c_str(lit.value(), lit.span())

(make_c_str returns a Result<syn::LitCStr, syn::Error>).

> +            .unwrap_or_else(|| {
> +                let span = field_name.span();
> +                let field_name_value = field_name.to_string();
> +                let lit = std::ffi::CString::new(field_name_value.as_str()).map_err(|err| {
> +                    MacroError::Message(
> +                        format!("Field `{field_name_value}` cannot be represented as a C string: {err}\nPlease set an explicit property name using the `rename=...` option in the field's `property` attribute."),

I don't think this error can happen, because the field name cannot 
contain a NUL character and that's the only way CString::new fails.  So 
just using the same function above is fine, because the more detailed 
error isn't necessary.

Putting everything together and using .map_or_else() gives you something 
like this:

         let prop_name = rename
             .map_or_else(
                 || make_c_str(field_name.to_string(), field_name.span())
                 |lit| {
                     match lit {
                         DevicePropertyName::CStr(lit) => {
                             Ok(lit)
                         }
                         DevicePropertyName::Str(lit) => {
                             make_c_str(lit.value(), lit.span())
                         }
                     }
                 })?;

You could even go ahead and only accept syn::LitStr, dropping 
DevicePropertyName altogether.  But since you've written the code and 
c"" support is only 10-15 lines of code overall, do as you wish.

> +                        span
> +                    )
> +                })?;
> +                let lit = syn::LitCStr::new(&lit, span);
> +                Ok(quote_spanned! {span=>
> +                    #lit
> +                })
> +            })?;
> +        let field_ty = field.ty.clone();
> +        let qdev_prop = qdev_prop
> +            .as_ref()

Again, .as_ref() might not be needed here either.

> +            .map(|path| {
> +                quote_spanned! {field_span=>
> +                    unsafe { &#path }
> +                }
> +            })
> +            .unwrap_or_else(
> +                || quote_spanned! {field_span=> <#field_ty as ::qemu_api::qdev::QDevProp>::VALUE },
> +            );

If you decide to keep qdev_prop, .map_or_else() can be used here too.

> +        let set_default = defval.is_some();
> +        let bitnr = bitnr.as_ref().unwrap_or(&zero);
> +        let defval = defval.as_ref().unwrap_or(&zero);
> +        properties_expanded.push(quote_spanned! {field_span=>
> +            ::qemu_api::bindings::Property {
> +                name: ::std::ffi::CStr::as_ptr(#prop_name),
> +                info: #qdev_prop ,
> +                offset: ::core::mem::offset_of!(#name, #field_name) as isize,
> +                bitnr: #bitnr,
> +                set_default: #set_default,
> +                defval: ::qemu_api::bindings::Property__bindgen_ty_1 { u: #defval as u64 },

Maybe add a TODO that not all types should have a default (e.g. 
pointers).  No need to fix it now, but having a note in the code would 
be nice.

> diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
> index 36f02fb57dbffafb21a2e7cc96419ca42e865269..01f199f198c6a5f8a761beb143e567fc267028aa 100644
> --- a/rust/qemu-api/src/qdev.rs
> +++ b/rust/qemu-api/src/qdev.rs
> @@ -101,8 +101,54 @@ pub trait ResettablePhasesImpl {
>       T::EXIT.unwrap()(unsafe { state.as_ref() }, typ);
>   }
>   
> +/// Helper trait to return pointer to a [`bindings::PropertyInfo`] for a type.
> +///
> +/// This trait is used by [`qemu_api_macros::DeviceProperty`] derive macro.
> +///
> +/// # Safety
> +///
> +/// This trait is marked as `unsafe` because currently having a `const` refer to an `extern static`
> +/// results in this compiler error:
> +///
> +/// ```text
> +/// constructing invalid value: encountered reference to `extern` static in `const`
> +/// ```
> +///
> +/// It is the implementer's responsibility to provide a valid [`bindings::PropertyInfo`] pointer
> +/// for the trait implementation to be safe.
> +pub unsafe trait QDevProp {
> +    const VALUE: *const bindings::PropertyInfo;

"*const" or "&"?

> @@ -68,10 +68,13 @@ impl ObjectImpl for DummyState {
>   
>   impl ResettablePhasesImpl for DummyState {}
>   
> -impl DeviceImpl for DummyState {
> +impl DevicePropertiesImpl for DummyState {
>       fn properties() -> &'static [Property] {
>           &DUMMY_PROPERTIES
>       }
> +}

You can easily use #[derive()] here too, since the DummyState code is 
mostly copied from pl011.

> +impl DevicePropertiesImpl for DummyChildState {}

... and here too.

Thanks,

Paolo


