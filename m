Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7DF6D41D52
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 05:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAjXK-0006ae-9F; Tue, 12 Nov 2024 00:33:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tAjXI-0006a9-8O
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 00:33:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tAjXE-0004uW-NO
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 00:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731389631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WgqsNTKXJIZt3fOpNqm3ty/N8ioHOygc1iZkJ4vZr7s=;
 b=FzeJY4L/Je9g5WzH0FphSp+UCrvUBcHrUDQpHyCW8ZWjhyudHWA4W7zuwTDbSXzBsYjDoP
 +0M9MFDUV5eYJ9pcKKbLg3ciCMDU5AhKbIZ6dN/z9sTCVPCtC75fi8WGzV29vRlda5FMYb
 Ed9YKw/lJGw3Bdm9gJm+8YjMk0OVvoQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-KTpVbReZPem5lgca6oJHKw-1; Tue, 12 Nov 2024 00:33:47 -0500
X-MC-Unique: KTpVbReZPem5lgca6oJHKw-1
X-Mimecast-MFC-AGG-ID: KTpVbReZPem5lgca6oJHKw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-431673032e6so35597235e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 21:33:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731389626; x=1731994426;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WgqsNTKXJIZt3fOpNqm3ty/N8ioHOygc1iZkJ4vZr7s=;
 b=vEiSvC2XlkwaQ0d1iyaPvu38X0yESNKGO0Aa0sG8ok69+VEHYZmHVulmjaJOpFU+dL
 xAraGeDOgdWcTM6x5CJHuUOE6tJu7F61qUAzl8KQzgU1VlPkJOyx25XtlWsl4hOCImdB
 iWo2O2SRXcBAGttb8pxXrh6T3afOYnRIx6mL52t4hNThh5G1W5MklpLTxfvD7wd0FXWx
 B0QfR0ozrLpvC75vElgulQZP87WPmnMvStwxYg9LYvs8qirPxI5E5tQgkHg9tpc/iR+2
 9zReBQmTj9JBqwHmrg1+c7FWR+cMuYfMh5ihlqg4qiRGJatd+GP2NaVSXeRr4U7BIfaY
 tTvA==
X-Gm-Message-State: AOJu0YyI+2+tdJSXI7rCa2S9dM5AfREDoIxdjFRD+jcRbqYUP52m4fbw
 h0ngJPz0syZDaYUMx+BV3cVACbDtQeqwi4g2rAj8Wamah8y6SiuAVs7kkmCk/bd0oHg+F6LDd1C
 xGL9Ze4prQwJnEYMJWZ1Lu9cOI54ssHaJCbsDLeuvYcgvogAfPos+NzbsfOOyORVZum71K9ncum
 9gC4J4wb7SYsmE4eYlLUgtGiiJVs8=
X-Received: by 2002:a05:6000:715:b0:37d:41cd:ba4e with SMTP id
 ffacd0b85a97d-3820834994fmr796599f8f.48.1731389625974; 
 Mon, 11 Nov 2024 21:33:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/0cP1KYl577FQHnREGuttHELb98AvDg/nqtvCaMLHHSjfBbdIm1Dk0ugiwu+BYCrxkISk8f3P3obf2KojyD4=
X-Received: by 2002:a05:6000:715:b0:37d:41cd:ba4e with SMTP id
 ffacd0b85a97d-3820834994fmr796583f8f.48.1731389625575; Mon, 11 Nov 2024
 21:33:45 -0800 (PST)
MIME-Version: 1.0
References: <20241108180139.117112-1-pbonzini@redhat.com>
 <20241108180139.117112-2-pbonzini@redhat.com>
 <SY0P300MB102699E99096F482F06296EF95592@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY0P300MB102699E99096F482F06296EF95592@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 12 Nov 2024 06:33:33 +0100
Message-ID: <CABgObfb9ujpoRrNUUqyiAefSfTOWSV-SGmo2YrSoMdfxBeAD9A@mail.gmail.com>
Subject: Re: [RFC PATCH 01/11] rust: qemu_api: do not disable lints outside
 bindgen-generated code
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>, "Wolf,
 Kevin" <kwolf@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nondevel.org
Content-Type: multipart/alternative; boundary="00000000000099cc010626b08f24"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.671,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--00000000000099cc010626b08f24
Content-Type: text/plain; charset="UTF-8"

Il mar 12 nov 2024, 03:47 Junjie Mao <junjie.mao@hotmail.com> ha scritto:

> I agree that storing generated stuff in the source directory should not
> be encouraged.
>
> Just want to mention that such changes can lead to trouble to
> rust-analyzer. Today there are two ways to inform rust-analyzer of the
> project structure:
>
>   1. Use rust/Cargo.toml. In this case we'll hit an issue in
>   rust-analyzer [1] that prevents it from including sources outside the
>   crate directory. Thus, definitions in the bindgen-generated code
>   cannot be found.
>
>   2. Use the meson-generated rust-project.json. Due to the use of
>   structured_sources(), that json file refers to the copied sources of
>   qemu-api in the build directory. Rust-analyzer can find every symbol
>   in the qemu-api crate but will jump to those copied files, making it a
>   bit more annoying when developing the crate.
>

Would it help to move the bindgen-generated code to a completely separate
crate (e.g. qemu-api-sys), and avoid structured_sources for qemu-api? It
might even help build times.

Paolo

We can perhaps leave it as a separate topic for another series.
>
> [1] https://github.com/rust-lang/rust-analyzer/issues/17040
>
> --
> Best Regards
> Junjie Mao
>
> > +    let path = env::var("MESON_BUILD_ROOT")
> > +        .unwrap_or_else(|_| format!("{}/src",
> env!("CARGO_MANIFEST_DIR")));
> > +
> > +    let file = format!("{}/bindings.rs.inc", path);
> > +    if !Path::new(&file).exists() {
> > +        panic!(concat!(
> > +            "No generated C bindings found! If you want to run `cargo`,
> start a subshell\n",
> > +            "with `meson devenv`, or point MESON_BUILD_ROOT to the top
> of the build tree."
> > +        ));
> >      }
> >
> > +    println!("cargo:rustc-env=BINDINGS_RS_INC={}", file);
> > +
> >      // Check for available rustc features
> >      if rustc::is_min_version("1.77.0").unwrap_or(false) {
> >          println!("cargo:rustc-cfg=has_offset_of");
> > diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
> > index 6f637af7b1b..e3870e901e3 100644
> > --- a/rust/qemu-api/meson.build
> > +++ b/rust/qemu-api/meson.build
> > @@ -9,6 +9,7 @@ _qemu_api_rs = static_library(
> >    structured_sources(
> >      [
> >        'src/lib.rs',
> > +      'src/bindings.rs',
> >        'src/c_str.rs',
> >        'src/definitions.rs',
> >        'src/device_class.rs',
> > diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/
> bindings.rs
> > new file mode 100644
> > index 00000000000..1dac310594d
> > --- /dev/null
> > +++ b/rust/qemu-api/src/bindings.rs
> > @@ -0,0 +1,29 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +#![allow(
> > +    dead_code,
> > +    improper_ctypes_definitions,
> > +    improper_ctypes,
> > +    non_camel_case_types,
> > +    non_snake_case,
> > +    non_upper_case_globals,
> > +    unsafe_op_in_unsafe_fn,
> > +    clippy::missing_const_for_fn,
> > +    clippy::too_many_arguments,
> > +    clippy::approx_constant,
> > +    clippy::use_self,
> > +    clippy::useless_transmute,
> > +    clippy::missing_safety_doc
> > +)]
> > +
> > +#[cfg(MESON)]
> > +include!("bindings.rs.inc");
> > +
> > +#[cfg(not(MESON))]
> > +include!(env!("BINDINGS_RS_INC"));
> > +
> > +unsafe impl Send for Property {}
> > +unsafe impl Sync for Property {}
> > +unsafe impl Sync for TypeInfo {}
> > +unsafe impl Sync for VMStateDescription {}
> > +unsafe impl Sync for VMStateField {}
> > +unsafe impl Sync for VMStateInfo {}
> > diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
> > index aa8d16ec94b..440aff3817d 100644
> > --- a/rust/qemu-api/src/lib.rs
> > +++ b/rust/qemu-api/src/lib.rs
> > @@ -4,31 +4,9 @@
> >
> >  #![cfg_attr(not(MESON), doc = include_str!("../README.md"))]
> >
> > -#[allow(
> > -    dead_code,
> > -    improper_ctypes_definitions,
> > -    improper_ctypes,
> > -    non_camel_case_types,
> > -    non_snake_case,
> > -    non_upper_case_globals,
> > -    unsafe_op_in_unsafe_fn,
> > -    clippy::missing_const_for_fn,
> > -    clippy::too_many_arguments,
> > -    clippy::approx_constant,
> > -    clippy::use_self,
> > -    clippy::useless_transmute,
> > -    clippy::missing_safety_doc,
> > -)]
> >  #[rustfmt::skip]
> >  pub mod bindings;
> >
> > -unsafe impl Send for bindings::Property {}
> > -unsafe impl Sync for bindings::Property {}
> > -unsafe impl Sync for bindings::TypeInfo {}
> > -unsafe impl Sync for bindings::VMStateDescription {}
> > -unsafe impl Sync for bindings::VMStateField {}
> > -unsafe impl Sync for bindings::VMStateInfo {}
> > -
> >  pub mod c_str;
> >  pub mod definitions;
> >  pub mod device_class;
>
>

--00000000000099cc010626b08f24
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 12 nov 2024, 03:47 Junjie Mao &lt;<a href=3D"ma=
ilto:junjie.mao@hotmail.com">junjie.mao@hotmail.com</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">I agree that storin=
g generated stuff in the source directory should not<br>
be encouraged.<br>
<br>
Just want to mention that such changes can lead to trouble to<br>
rust-analyzer. Today there are two ways to inform rust-analyzer of the<br>
project structure:<br>
<br>
=C2=A0 1. Use rust/Cargo.toml. In this case we&#39;ll hit an issue in<br>
=C2=A0 rust-analyzer [1] that prevents it from including sources outside th=
e<br>
=C2=A0 crate directory. Thus, definitions in the bindgen-generated code<br>
=C2=A0 cannot be found.<br>
<br>
=C2=A0 2. Use the meson-generated rust-project.json. Due to the use of<br>
=C2=A0 structured_sources(), that json file refers to the copied sources of=
<br>
=C2=A0 qemu-api in the build directory. Rust-analyzer can find every symbol=
<br>
=C2=A0 in the qemu-api crate but will jump to those copied files, making it=
 a<br>
=C2=A0 bit more annoying when developing the crate.<br></blockquote></div><=
/div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quot=
e"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"></blockquote></div></d=
iv><div dir=3D"auto">Would it help to move the bindgen-generated code to a =
completely separate crate (e.g. qemu-api-sys), and avoid structured_sources=
 for qemu-api? It might even help build times.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
We can perhaps leave it as a separate topic for another series.<br>
<br>
[1] <a href=3D"https://github.com/rust-lang/rust-analyzer/issues/17040" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://github.com/rust-lang/r=
ust-analyzer/issues/17040</a><br>
<br>
--<br>
Best Regards<br>
Junjie Mao<br>
<br>
&gt; +=C2=A0 =C2=A0 let path =3D env::var(&quot;MESON_BUILD_ROOT&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .unwrap_or_else(|_| format!(&quot;{}/src&=
quot;, env!(&quot;CARGO_MANIFEST_DIR&quot;)));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 let file =3D format!(&quot;{}/bindings.rs.inc&quot;, pa=
th);<br>
&gt; +=C2=A0 =C2=A0 if !Path::new(&amp;file).exists() {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 panic!(concat!(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;No generated C bindin=
gs found! If you want to run `cargo`, start a subshell\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;with `meson devenv`, =
or point MESON_BUILD_ROOT to the top of the build tree.&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 println!(&quot;cargo:rustc-env=3DBINDINGS_RS_INC=3D{}&q=
uot;, file);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 // Check for available rustc features<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if rustc::is_min_version(&quot;1.77.0&quot;).unwra=
p_or(false) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 println!(&quot;cargo:rustc-cfg=3Dhas=
_offset_of&quot;);<br>
&gt; diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build<br>
&gt; index 6f637af7b1b..e3870e901e3 100644<br>
&gt; --- a/rust/qemu-api/meson.build<br>
&gt; +++ b/rust/qemu-api/meson.build<br>
&gt; @@ -9,6 +9,7 @@ _qemu_api_rs =3D static_library(<br>
&gt;=C2=A0 =C2=A0 structured_sources(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 [<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;src/<a href=3D"http://lib.rs" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">lib.rs</a>&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;src/<a href=3D"http://bindings.rs" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">bindings.rs</a>&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;src/<a href=3D"http://c_str.rs" rel=3D=
"noreferrer noreferrer" target=3D"_blank">c_str.rs</a>&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;src/<a href=3D"http://definitions.rs" =
rel=3D"noreferrer noreferrer" target=3D"_blank">definitions.rs</a>&#39;,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;src/<a href=3D"http://device_class.rs"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">device_class.rs</a>&#39;,<=
br>
&gt; diff --git a/rust/qemu-api/src/<a href=3D"http://bindings.rs" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">bindings.rs</a> b/rust/qemu-api/src=
/<a href=3D"http://bindings.rs" rel=3D"noreferrer noreferrer" target=3D"_bl=
ank">bindings.rs</a><br>
&gt; new file mode 100644<br>
&gt; index 00000000000..1dac310594d<br>
&gt; --- /dev/null<br>
&gt; +++ b/rust/qemu-api/src/<a href=3D"http://bindings.rs" rel=3D"noreferr=
er noreferrer" target=3D"_blank">bindings.rs</a><br>
&gt; @@ -0,0 +1,29 @@<br>
&gt; +// SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; +#![allow(<br>
&gt; +=C2=A0 =C2=A0 dead_code,<br>
&gt; +=C2=A0 =C2=A0 improper_ctypes_definitions,<br>
&gt; +=C2=A0 =C2=A0 improper_ctypes,<br>
&gt; +=C2=A0 =C2=A0 non_camel_case_types,<br>
&gt; +=C2=A0 =C2=A0 non_snake_case,<br>
&gt; +=C2=A0 =C2=A0 non_upper_case_globals,<br>
&gt; +=C2=A0 =C2=A0 unsafe_op_in_unsafe_fn,<br>
&gt; +=C2=A0 =C2=A0 clippy::missing_const_for_fn,<br>
&gt; +=C2=A0 =C2=A0 clippy::too_many_arguments,<br>
&gt; +=C2=A0 =C2=A0 clippy::approx_constant,<br>
&gt; +=C2=A0 =C2=A0 clippy::use_self,<br>
&gt; +=C2=A0 =C2=A0 clippy::useless_transmute,<br>
&gt; +=C2=A0 =C2=A0 clippy::missing_safety_doc<br>
&gt; +)]<br>
&gt; +<br>
&gt; +#[cfg(MESON)]<br>
&gt; +include!(&quot;bindings.rs.inc&quot;);<br>
&gt; +<br>
&gt; +#[cfg(not(MESON))]<br>
&gt; +include!(env!(&quot;BINDINGS_RS_INC&quot;));<br>
&gt; +<br>
&gt; +unsafe impl Send for Property {}<br>
&gt; +unsafe impl Sync for Property {}<br>
&gt; +unsafe impl Sync for TypeInfo {}<br>
&gt; +unsafe impl Sync for VMStateDescription {}<br>
&gt; +unsafe impl Sync for VMStateField {}<br>
&gt; +unsafe impl Sync for VMStateInfo {}<br>
&gt; diff --git a/rust/qemu-api/src/<a href=3D"http://lib.rs" rel=3D"norefe=
rrer noreferrer" target=3D"_blank">lib.rs</a> b/rust/qemu-api/src/<a href=
=3D"http://lib.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">lib.rs</=
a><br>
&gt; index aa8d16ec94b..440aff3817d 100644<br>
&gt; --- a/rust/qemu-api/src/<a href=3D"http://lib.rs" rel=3D"noreferrer no=
referrer" target=3D"_blank">lib.rs</a><br>
&gt; +++ b/rust/qemu-api/src/<a href=3D"http://lib.rs" rel=3D"noreferrer no=
referrer" target=3D"_blank">lib.rs</a><br>
&gt; @@ -4,31 +4,9 @@<br>
&gt;<br>
&gt;=C2=A0 #![cfg_attr(not(MESON), doc =3D include_str!(&quot;../README.md&=
quot;))]<br>
&gt;<br>
&gt; -#[allow(<br>
&gt; -=C2=A0 =C2=A0 dead_code,<br>
&gt; -=C2=A0 =C2=A0 improper_ctypes_definitions,<br>
&gt; -=C2=A0 =C2=A0 improper_ctypes,<br>
&gt; -=C2=A0 =C2=A0 non_camel_case_types,<br>
&gt; -=C2=A0 =C2=A0 non_snake_case,<br>
&gt; -=C2=A0 =C2=A0 non_upper_case_globals,<br>
&gt; -=C2=A0 =C2=A0 unsafe_op_in_unsafe_fn,<br>
&gt; -=C2=A0 =C2=A0 clippy::missing_const_for_fn,<br>
&gt; -=C2=A0 =C2=A0 clippy::too_many_arguments,<br>
&gt; -=C2=A0 =C2=A0 clippy::approx_constant,<br>
&gt; -=C2=A0 =C2=A0 clippy::use_self,<br>
&gt; -=C2=A0 =C2=A0 clippy::useless_transmute,<br>
&gt; -=C2=A0 =C2=A0 clippy::missing_safety_doc,<br>
&gt; -)]<br>
&gt;=C2=A0 #[rustfmt::skip]<br>
&gt;=C2=A0 pub mod bindings;<br>
&gt;<br>
&gt; -unsafe impl Send for bindings::Property {}<br>
&gt; -unsafe impl Sync for bindings::Property {}<br>
&gt; -unsafe impl Sync for bindings::TypeInfo {}<br>
&gt; -unsafe impl Sync for bindings::VMStateDescription {}<br>
&gt; -unsafe impl Sync for bindings::VMStateField {}<br>
&gt; -unsafe impl Sync for bindings::VMStateInfo {}<br>
&gt; -<br>
&gt;=C2=A0 pub mod c_str;<br>
&gt;=C2=A0 pub mod definitions;<br>
&gt;=C2=A0 pub mod device_class;<br>
<br>
</blockquote></div></div></div>

--00000000000099cc010626b08f24--


