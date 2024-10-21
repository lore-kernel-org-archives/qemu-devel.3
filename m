Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C40D0E6EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 10:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2pwX-0001g6-OJ; Mon, 21 Oct 2024 06:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2pwW-0001eL-MG
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2pwU-0003a0-U1
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729507638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nOVx/dP4UStu4JJZrHz8GvwYSs/ljoTJ5doKqYykNuU=;
 b=Hf5ZfBiHiliFnXovAjRM/ilU1rGqj0Yxmo667Khdi12awzNgPls83+0RJZpo11OHs0fojX
 4kntlUBIbkuL3RD7a+QSQspl6r9lVtzzNpa1AF1AECOOttH6NFyCkWEp+AOiqQQs+3Cw97
 9/Ax8vivHOADCQ3JtyPVRemZsL+0uQ8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-OTl0MqxRMiiVZAMhRN-GKA-1; Mon, 21 Oct 2024 06:47:17 -0400
X-MC-Unique: OTl0MqxRMiiVZAMhRN-GKA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d609ef9f7so2060478f8f.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 03:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729507635; x=1730112435;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nOVx/dP4UStu4JJZrHz8GvwYSs/ljoTJ5doKqYykNuU=;
 b=xVZ6QPYAD7VYiR09lcH0mHuqsFLTAlhoWsA5UFKUVJ62lVl0J9BSf3CSymdbKqh3pk
 ofJhNp9jfYOUMXbdvLP1bp7uQzB1786TNHuAw8Ubr5be2IRsqGdwX/Yr844u4l/yWKSR
 Qawg2KPht0+z/Wepz47DqQJEUQiUQ2+mLkaHnunKwWvOO73NLg5RNKdv6argtaSh7geX
 twqMOUGnQtu+z3gpnNuLMQPnD6oFOETYil1h4BLkltJr+f9CywFFW8dzhh7jOKXOG4h2
 v7dtXZGZF4uUhFq7S6IlW8dMCuE/sZKaanrJ3DsN41k4wSBlaegapHL8GoJC9+tSC+Xv
 ZkAA==
X-Gm-Message-State: AOJu0Yw3tEIJwTEkwa/6PpJ551FbdPhlYqpcU75VwcMn6jqdyGVjuva8
 ECrzsLn/2EmBuVjRjvpSjSXPu97z9lTLFzdqhrwtWp94l4XoK7IHRzIHfmWh4BU6yDqCcc0zUgU
 peYfw5qeS5z75kicdSPmxRIv4zC82UblmzHNLi4geB9snh/RP8VLu8AvVW0J+jX9ogpWgT6y1gW
 /0RnMBKBKjfCqNy318QQFE/AdgoT6Qfg7JMWmjcA==
X-Received: by 2002:adf:fb45:0:b0:37c:d23f:e465 with SMTP id
 ffacd0b85a97d-37eab712dbfmr6378525f8f.55.1729507634881; 
 Mon, 21 Oct 2024 03:47:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLv9VUDyQ/Em58uBwbIr45rzFfbC2fXesrjBmWLNWJVRf+dZoJYsnqybub6lBBbGrsjeqSEhbrnHrfavPAus8=
X-Received: by 2002:adf:fb45:0:b0:37c:d23f:e465 with SMTP id
 ffacd0b85a97d-37eab712dbfmr6378514f8f.55.1729507634526; Mon, 21 Oct 2024
 03:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20241018144306.954716-1-pbonzini@redhat.com>
 <20241018144306.954716-9-pbonzini@redhat.com>
 <SY0P300MB1026A61776DE7025EC7B9F1C95432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY0P300MB1026A61776DE7025EC7B9F1C95432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Oct 2024 12:47:04 +0200
Message-ID: <CABgObfZ79VZUbwqm_vsYvSGdbk5Fz-b06bf5__b3D+LC9wNfnA@mail.gmail.com>
Subject: Re: [PATCH 08/13] rust: build integration test for the qemu_api crate
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000003150bc0624fa604c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

--0000000000003150bc0624fa604c
Content-Type: text/plain; charset="UTF-8"

Il lun 21 ott 2024, 12:34 Junjie Mao <junjie.mao@hotmail.com> ha scritto:

>
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > Adjust the integration test to compile with a subset of QEMU object
> > files, and make it actually create an object of the class it defines.
> >
> > Follow the Rust filesystem conventions, where tests go in tests/ if
> > they use the library in the same way any other code would.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
>
> A few minor comments on cosmetic below.
>
> > ---
> >  meson.build                  | 10 ++++-
> >  rust/qemu-api/meson.build    | 20 +++++++--
> >  rust/qemu-api/src/tests.rs   | 49 ----------------------
> >  rust/qemu-api/tests/tests.rs | 78 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 104 insertions(+), 53 deletions(-)
> >  delete mode 100644 rust/qemu-api/src/tests.rs
> >  create mode 100644 rust/qemu-api/tests/tests.rs
> >
> <snip>
> > diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
> > new file mode 100644
> > index 00000000000..57bab62772d
> > --- /dev/null
> > +++ b/rust/qemu-api/tests/tests.rs
> > @@ -0,0 +1,78 @@
> > +// Copyright 2024, Linaro Limited
> > +// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +use core::ffi::CStr;
> > +
> > +use qemu_api::{
> > +    bindings::*, declare_properties, define_property,
> > +    definitions::Class,
> > +    definitions::ObjectImpl,
> > +    device_class_init, vm_state_description,
>
> Cargo fmt (with the current rust/rustfmt.toml) formats those lines in a
> different way, and ...
>

I will tweak this.

Paolo

> +};
> > +
> <snip>
> > +    impl ObjectImpl for DummyState {
> > +        type Class = DummyClass;
> > +        const TYPE_INFO: qemu_api::bindings::TypeInfo =
> qemu_api::type_info! { Self };
> > +        const TYPE_NAME: &'static CStr = c"dummy";
> > +        const PARENT_TYPE_NAME: Option<&'static CStr> =
> Some(TYPE_DEVICE);
> > +        const ABSTRACT: bool = false;
> > +        const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut
> Object)> = None;
> > +        const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut
> Object)> = None;
> > +        const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut
> Object)> = None;
> > +    }
> > +
> > +    impl Class for DummyClass {
> > +        const CLASS_INIT: Option<
> > +            unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut
> core::ffi::c_void),
> > +            > = Some(dummy_class_init);
>
> ... ditto. Shall we tweak the formats here or adjust the rustfmt
> settings later?
>
> --
> Best Regards
> Junjie Mao
>
>

--0000000000003150bc0624fa604c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 21 ott 2024, 12:34 Junjie Mao &lt;<a href=3D"ma=
ilto:junjie.mao@hotmail.com">junjie.mao@hotmail.com</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" =
rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; writes:<br>
<br>
&gt; Adjust the integration test to compile with a subset of QEMU object<br=
>
&gt; files, and make it actually create an object of the class it defines.<=
br>
&gt;<br>
&gt; Follow the Rust filesystem conventions, where tests go in tests/ if<br=
>
&gt; they use the library in the same way any other code would.<br>
&gt;<br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
<br>
Reviewed-by: Junjie Mao &lt;<a href=3D"mailto:junjie.mao@hotmail.com" targe=
t=3D"_blank" rel=3D"noreferrer">junjie.mao@hotmail.com</a>&gt;<br>
<br>
A few minor comments on cosmetic below.<br>
<br>
&gt; ---<br>
&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 10 ++++-<br>
&gt;=C2=A0 rust/qemu-api/meson.build=C2=A0 =C2=A0 | 20 +++++++--<br>
&gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://tests.rs" rel=3D"noreferrer =
noreferrer" target=3D"_blank">tests.rs</a>=C2=A0 =C2=A0| 49 ---------------=
-------<br>
&gt;=C2=A0 rust/qemu-api/tests/<a href=3D"http://tests.rs" rel=3D"noreferre=
r noreferrer" target=3D"_blank">tests.rs</a> | 78 +++++++++++++++++++++++++=
+++++++++++<br>
&gt;=C2=A0 4 files changed, 104 insertions(+), 53 deletions(-)<br>
&gt;=C2=A0 delete mode 100644 rust/qemu-api/src/<a href=3D"http://tests.rs"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">tests.rs</a><br>
&gt;=C2=A0 create mode 100644 rust/qemu-api/tests/<a href=3D"http://tests.r=
s" rel=3D"noreferrer noreferrer" target=3D"_blank">tests.rs</a><br>
&gt;<br>
&lt;snip&gt;<br>
&gt; diff --git a/rust/qemu-api/tests/<a href=3D"http://tests.rs" rel=3D"no=
referrer noreferrer" target=3D"_blank">tests.rs</a> b/rust/qemu-api/tests/<=
a href=3D"http://tests.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">=
tests.rs</a><br>
&gt; new file mode 100644<br>
&gt; index 00000000000..57bab62772d<br>
&gt; --- /dev/null<br>
&gt; +++ b/rust/qemu-api/tests/<a href=3D"http://tests.rs" rel=3D"noreferre=
r noreferrer" target=3D"_blank">tests.rs</a><br>
&gt; @@ -0,0 +1,78 @@<br>
&gt; +// Copyright 2024, Linaro Limited<br>
&gt; +// Author(s): Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidi=
anakis@linaro.org" target=3D"_blank" rel=3D"noreferrer">manos.pitsidianakis=
@linaro.org</a>&gt;<br>
&gt; +// SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; +<br>
&gt; +use core::ffi::CStr;<br>
&gt; +<br>
&gt; +use qemu_api::{<br>
&gt; +=C2=A0 =C2=A0 bindings::*, declare_properties, define_property,<br>
&gt; +=C2=A0 =C2=A0 definitions::Class,<br>
&gt; +=C2=A0 =C2=A0 definitions::ObjectImpl,<br>
&gt; +=C2=A0 =C2=A0 device_class_init, vm_state_description,<br>
<br>
Cargo fmt (with the current rust/rustfmt.toml) formats those lines in a<br>
different way, and ...<br></blockquote></div></div><div dir=3D"auto"><br></=
div><div dir=3D"auto">I will tweak this.</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
&gt; +};<br>
&gt; +<br>
&lt;snip&gt;<br>
&gt; +=C2=A0 =C2=A0 impl ObjectImpl for DummyState {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 type Class =3D DummyClass;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const TYPE_INFO: qemu_api::bindings::Type=
Info =3D qemu_api::type_info! { Self };<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const TYPE_NAME: &amp;&#39;static CStr =
=3D c&quot;dummy&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const PARENT_TYPE_NAME: Option&lt;&amp;&#=
39;static CStr&gt; =3D Some(TYPE_DEVICE);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const ABSTRACT: bool =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const INSTANCE_INIT: Option&lt;unsafe ext=
ern &quot;C&quot; fn(obj: *mut Object)&gt; =3D None;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const INSTANCE_POST_INIT: Option&lt;unsaf=
e extern &quot;C&quot; fn(obj: *mut Object)&gt; =3D None;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const INSTANCE_FINALIZE: Option&lt;unsafe=
 extern &quot;C&quot; fn(obj: *mut Object)&gt; =3D None;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 impl Class for DummyClass {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const CLASS_INIT: Option&lt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsafe extern &quot;C&quot;=
 fn(klass: *mut ObjectClass, data: *mut core::ffi::c_void),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &gt; =3D Some(dummy_class_i=
nit);<br>
<br>
... ditto. Shall we tweak the formats here or adjust the rustfmt<br>
settings later?<br>
<br>
--<br>
Best Regards<br>
Junjie Mao<br>
<br>
</blockquote></div></div></div>

--0000000000003150bc0624fa604c--


