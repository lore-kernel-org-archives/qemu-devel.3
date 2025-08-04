Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4087EC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 10:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uis8W-0006IZ-8n; Mon, 04 Aug 2025 06:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uis7P-0005zb-2j
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 06:08:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uis7M-0004vq-Gk
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 06:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754302110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o1TdvNN+z1sK0RpIh+poIaIGxfYSVZLeWGAj7Vp5N50=;
 b=iYSHFYqRPsj2J8SxbY0iO45SAM53h8Ai56sesB6cTXvS0YmJpaFBiJ8n5o8LxyLEJzuAoH
 YxNLuaLm/pItrraWJo4l9aGuEj+QWLUOZtoesCCLYLxDnYl362+JV6X5pjFUnT1PTMra4w
 KseGW9fLNZdYD8Y9eIuYKT+A2hx8izc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-1qLHTCOuPuu5E6CDRbzZug-1; Mon, 04 Aug 2025 06:08:29 -0400
X-MC-Unique: 1qLHTCOuPuu5E6CDRbzZug-1
X-Mimecast-MFC-AGG-ID: 1qLHTCOuPuu5E6CDRbzZug_1754302108
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451d3f03b74so21939555e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 03:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754302108; x=1754906908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o1TdvNN+z1sK0RpIh+poIaIGxfYSVZLeWGAj7Vp5N50=;
 b=PyxR3ADAI80njKn9vA6uZO8RAwvAPDKnkMn8Z57z4SeOARY1i5E+OFotxgvJRzmuMz
 ZTASPsdbL/iZK4MdPfodJ86vFE3+LuToNwU3TmiOeFrvWUHZ4pRfYwWhmsAbeKO8mmJ+
 rWA4Eil8qAFNIUEyd3ZqzxxylWpCoQ0Fwi3uZAw3NcHPVCTNIqi6G2qNKjRo0n/dM30d
 HeVIVeKdO2FBH3VjsGU0pmAgtj8mknbqwsBWhv0B8byNblOEQ9fhoBDc3mqQzF616Fus
 irW9LVINFjTO+PnmMuP8ogoVR3I0IA0dklvl8AVojaQ/zsepihdYvYqsw5xEHbZRLr22
 V2jQ==
X-Gm-Message-State: AOJu0YyiwiBvTyW00JSVacjkvrS6yQrR40Lti2uvyIa1wC9S9hW1QBW7
 S2sD8XTie2wPF6Ilam92J1VddZ2PKPsZUY4HJWp2aS+el+WMVIqVlykRM4lgC0Fw+gCxk4cEIvn
 IhH2EJDyS5PcH3RQiipUNhb4eR47tUf8DU7MhaVtjLXz7wXPVDOGrhREGXGc0NYu8/ZTjiOu01E
 5MsoQy6zb3JriTm1zBWqKMZHDwtrP1q5k=
X-Gm-Gg: ASbGnct14NsRq+43X3MLxmPFdf0F8WPFzDvs/W3gWxPvRSSWMT5valcktpVqwR7Ei1G
 f3stURKyNyPdJi0I5RB5F3hFCMKwlPJzORL6YSaheQTvWzYwNSvW0of/vMSbA2pIccPLgqcGJc4
 upEQhYyg1M4ksYojURYeIL
X-Received: by 2002:a05:600c:4692:b0:458:a559:a693 with SMTP id
 5b1f17b1804b1-458b6b316b3mr65389685e9.18.1754302107786; 
 Mon, 04 Aug 2025 03:08:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbU55T3r3T6/QGs5csnfFiUkjcwaQVOQeDnNp+CMFAnO5y6dXEHvZmb8wPgi6toYxh+2+WcJfE15PJH8lN6QQ=
X-Received: by 2002:a05:600c:4692:b0:458:a559:a693 with SMTP id
 5b1f17b1804b1-458b6b316b3mr65389435e9.18.1754302107370; Mon, 04 Aug 2025
 03:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1754060086.git.mkletzan@redhat.com>
 <ad68bd5bdf4148770e3750fca4f14d0ae794538d.1754060086.git.mkletzan@redhat.com>
 <CABgObfYBVF3aCOBtX-eQcm4M-WNAHxbMcjsUKiY3rLkinGe1qA@mail.gmail.com>
 <aJB1oeH2eTIeeJne@wheatley.k8r.cz>
In-Reply-To: <aJB1oeH2eTIeeJne@wheatley.k8r.cz>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 4 Aug 2025 12:08:15 +0200
X-Gm-Features: Ac12FXze5VPLacZDvIO_VVhGukIoOQBSdVm4wvSrGl8KJvdDK_hebCS5C48yZf4
Message-ID: <CABgObfaivWp1v55KHjBK1Ba8fDgo3Lr+wF5HkHrvOz62Z_gLoQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: Add antoher variant for impl_vmstate_struct!
 macro
To: Martin Kletzander <mkletzan@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f0595e063b8749be"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000f0595e063b8749be
Content-Type: text/plain; charset="UTF-8"

Il lun 4 ago 2025, 10:56 Martin Kletzander <mkletzan@redhat.com> ha scritto:

> *BUT* of course I had to rebase the patches on top of current rust-next
> on Friday and there were some of your commits from Thursday which I now
> see actually fix all what I tried fixing before as well.  I tried
> finding the previous commit on which I saw all the issues and after some
> rebuilding I could not.  So it is now not even broken on rust-next.
>
> This way I completely wasted your time, but at least learned something
> that's happening in the code.  Sorry for that.
>

Uh no you didn't. It was broken.

Paolo

Martin
>
> >Paolo
> >
> > rust/qemu-api/src/vmstate.rs         | 11 +++++++++++
> >>  rust/qemu-api/tests/vmstate_tests.rs |  1 +
> >>  2 files changed, 12 insertions(+)
> >>
> >> diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/
> vmstate.rs
> >> index b5c6b764fbba..716e52afe740 100644
> >> --- a/rust/qemu-api/src/vmstate.rs
> >> +++ b/rust/qemu-api/src/vmstate.rs
> >> @@ -449,6 +449,17 @@ macro_rules! vmstate_validate {
> >>  /// description of the struct.
> >>  #[macro_export]
> >>  macro_rules! impl_vmstate_struct {
> >> +    ($type:ty, $(&)?$vmsd:ident) => {
> >> +        unsafe impl $crate::vmstate::VMState for $type {
> >> +            const BASE: $crate::bindings::VMStateField =
> >> +                $crate::bindings::VMStateField {
> >> +                    vmsd: $vmsd.as_ref(),
> >> +                    size: ::core::mem::size_of::<$type>(),
> >> +                    flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
> >> +                    ..$crate::zeroable::Zeroable::ZERO
> >> +                };
> >> +        }
> >> +    };
> >>      ($type:ty, $vmsd:expr) => {
> >>          unsafe impl $crate::vmstate::VMState for $type {
> >>              const BASE: $crate::bindings::VMStateField = {
> >> diff --git a/rust/qemu-api/tests/vmstate_tests.rs
> b/rust/qemu-api/tests/
> >> vmstate_tests.rs
> >> index 2c0670ba0eed..7d3180e6c2ea 100644
> >> --- a/rust/qemu-api/tests/vmstate_tests.rs
> >> +++ b/rust/qemu-api/tests/vmstate_tests.rs
> >> @@ -320,6 +320,7 @@ fn test_vmstate_struct_varray_uint8_wrapper() {
> >>          b"arr_a_wrap\0"
> >>      );
> >>      assert_eq!(foo_fields[5].num_offset, 228);
> >> +    assert_eq!(foo_fields[5].vmsd, VMSTATE_FOOA.as_ref());
> >>      assert!(unsafe { foo_fields[5].field_exists.unwrap()(foo_b_p, 0)
> });
> >>
> >>      // The last VMStateField in VMSTATE_FOOB.
> >> --
> >> 2.50.1
> >>
> >>
>

--000000000000f0595e063b8749be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 4 ago 2025, 10:56 Martin =
Kletzander &lt;<a href=3D"mailto:mkletzan@redhat.com">mkletzan@redhat.com</=
a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">*BUT* of course I had to rebase the patches on top of current rust-next<=
br>
on Friday and there were some of your commits from Thursday which I now<br>
see actually fix all what I tried fixing before as well.=C2=A0 I tried<br>
finding the previous commit on which I saw all the issues and after some<br=
>
rebuilding I could not.=C2=A0 So it is now not even broken on rust-next.<br=
>
<br>
This way I completely wasted your time, but at least learned something<br>
that&#39;s happening in the code.=C2=A0 Sorry for that.<br></blockquote></d=
iv></div><div dir=3D"auto"><br></div><div dir=3D"auto">Uh no you didn&#39;t=
. It was broken.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
 gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Martin<br>
<br>
&gt;Paolo<br>
&gt;<br>
&gt; rust/qemu-api/src/<a href=3D"http://vmstate.rs" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">vmstate.rs</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 11 +++++++++++<br>
&gt;&gt;=C2=A0 rust/qemu-api/tests/<a href=3D"http://vmstate_tests.rs" rel=
=3D"noreferrer noreferrer" target=3D"_blank">vmstate_tests.rs</a> |=C2=A0 1=
 +<br>
&gt;&gt;=C2=A0 2 files changed, 12 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/rust/qemu-api/src/<a href=3D"http://vmstate.rs" rel=
=3D"noreferrer noreferrer" target=3D"_blank">vmstate.rs</a> b/rust/qemu-api=
/src/<a href=3D"http://vmstate.rs" rel=3D"noreferrer noreferrer" target=3D"=
_blank">vmstate.rs</a><br>
&gt;&gt; index b5c6b764fbba..716e52afe740 100644<br>
&gt;&gt; --- a/rust/qemu-api/src/<a href=3D"http://vmstate.rs" rel=3D"noref=
errer noreferrer" target=3D"_blank">vmstate.rs</a><br>
&gt;&gt; +++ b/rust/qemu-api/src/<a href=3D"http://vmstate.rs" rel=3D"noref=
errer noreferrer" target=3D"_blank">vmstate.rs</a><br>
&gt;&gt; @@ -449,6 +449,17 @@ macro_rules! vmstate_validate {<br>
&gt;&gt;=C2=A0 /// description of the struct.<br>
&gt;&gt;=C2=A0 #[macro_export]<br>
&gt;&gt;=C2=A0 macro_rules! impl_vmstate_struct {<br>
&gt;&gt; +=C2=A0 =C2=A0 ($type:ty, $(&amp;)?$vmsd:ident) =3D&gt; {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsafe impl $crate::vmstate::VMState =
for $type {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const BASE: $crate::bin=
dings::VMStateField =3D<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $crate::b=
indings::VMStateField {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 vmsd: $vmsd.as_ref(),<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 size: ::core::mem::size_of::&lt;$type&gt;(),<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 flags: $crate::bindings::VMStateFlags::VMS_STRUCT,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ..$crate::zeroable::Zeroable::ZERO<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 };<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 ($type:ty, $vmsd:expr) =3D&gt; {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsafe impl $crate::vmstate::VMS=
tate for $type {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const BASE: $crate=
::bindings::VMStateField =3D {<br>
&gt;&gt; diff --git a/rust/qemu-api/tests/<a href=3D"http://vmstate_tests.r=
s" rel=3D"noreferrer noreferrer" target=3D"_blank">vmstate_tests.rs</a> b/r=
ust/qemu-api/tests/<br>
&gt;&gt; <a href=3D"http://vmstate_tests.rs" rel=3D"noreferrer noreferrer" =
target=3D"_blank">vmstate_tests.rs</a><br>
&gt;&gt; index 2c0670ba0eed..7d3180e6c2ea 100644<br>
&gt;&gt; --- a/rust/qemu-api/tests/<a href=3D"http://vmstate_tests.rs" rel=
=3D"noreferrer noreferrer" target=3D"_blank">vmstate_tests.rs</a><br>
&gt;&gt; +++ b/rust/qemu-api/tests/<a href=3D"http://vmstate_tests.rs" rel=
=3D"noreferrer noreferrer" target=3D"_blank">vmstate_tests.rs</a><br>
&gt;&gt; @@ -320,6 +320,7 @@ fn test_vmstate_struct_varray_uint8_wrapper() =
{<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 b&quot;arr_a_wrap\0&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 );<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 assert_eq!(foo_fields[5].num_offset, 228);<br>
&gt;&gt; +=C2=A0 =C2=A0 assert_eq!(foo_fields[5].vmsd, VMSTATE_FOOA.as_ref(=
));<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 assert!(unsafe { foo_fields[5].field_exists.un=
wrap()(foo_b_p, 0) });<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 // The last VMStateField in VMSTATE_FOOB.<br>
&gt;&gt; --<br>
&gt;&gt; 2.50.1<br>
&gt;&gt;<br>
&gt;&gt;<br>
</blockquote></div></div></div>

--000000000000f0595e063b8749be--


