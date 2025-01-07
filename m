Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE805E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 12:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV8d3-0004Bf-BV; Tue, 07 Jan 2025 07:24:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tV8d1-0004BN-Rj
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 07:24:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tV8cz-0001tI-VG
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 07:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736252648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tBhgfETM99NEMDiU1FVnu4UUpsHSbAgJWNnVsfsni24=;
 b=H5NyvW/rFJ3tCALwAnzOwEQ3FwwBGcUHrTo/oO8n8Dx0Ec2JJpRWo5FJCmUt3zWtMBNGxJ
 cnycKoQwIxsXwBJ9ZuKtQ0Z9ykBOIZ2I3skXzxN//5ZXFflxKXr6homqMqDJ2w6/2D9wUs
 CN0yh4fzJqKd5pjG+mJ1AXmNNNnFSac=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-82-3_OQaPzyEfqrHQOCkqw-1; Tue, 07 Jan 2025 07:24:06 -0500
X-MC-Unique: 82-3_OQaPzyEfqrHQOCkqw-1
X-Mimecast-MFC-AGG-ID: 82-3_OQaPzyEfqrHQOCkqw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385ed79291eso7733929f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 04:24:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736252645; x=1736857445;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tBhgfETM99NEMDiU1FVnu4UUpsHSbAgJWNnVsfsni24=;
 b=uhzkL6U9FabIrffH+WQLHKY9uDNms60fAdygIxSHm/TGufQpDCdjRmGruay5wuoZ1x
 KEohbNS1IvMLpVt1+Znz6eou9D/0TqgSjGpZae8v+jG0EZRY+WnvZ0zIZJQoag76nBh4
 EfTGgS3Oog4b6vyjGeX4plXDxUkZK5mxUbFuSdqODIZU2ENScp9GY7VJylbpMCZV94Dk
 XwbMeJ8VfzmEua0FLXE1sot2j5BKxDyAv2Zd8mkE7WQGlWw0FX+UglwYz88Ae9z3oBf+
 WFDY3uY+6dB1OxcOfQEGXxJ++YGVyB/C2AP1RnKf8jGZKrEkKa8ornU+8pB5EZIka3xx
 5IdA==
X-Gm-Message-State: AOJu0YyDMfvFqPFQR7RQoUDmvjXYgEc25qnoubSSw6mvH0cg0tLYxnEf
 NtAm7R1e4ZDgxpD0CExQheBHXq3MOn6c8Dm4BgRsZcsyKPYt44YhB9hLwY9DAvbimAz2wnDLZnS
 1T67OCRpnk8xmvgtulS0LQW1QtnvvdcGBxYB2CNnqZdp7+nqqS2ZCmLQJjMO3AXTP2naxvG02or
 oOD1sMMnZIyotwAwR13doztcaz8WY=
X-Gm-Gg: ASbGncu/PrIYzAvwjO3VogVoC2LcLaSxWOgae6KHBmV3+fEMZ+19AqV/kKZZN1WDWLg
 XCWoo4TqB3Guzn30tFKO8Cjr4TIVoCl/5/dJVew==
X-Received: by 2002:a5d:5f56:0:b0:382:45db:6a1e with SMTP id
 ffacd0b85a97d-38a7913bcf8mr2711312f8f.14.1736252644725; 
 Tue, 07 Jan 2025 04:24:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdCOBT/WPKqbvxYoZE1G1ce2F6839rhweRBKlBnacFSZhluProYmcnIpDOweSXkOJJ9GaBJbJOd+9g+ItmULs=
X-Received: by 2002:a5d:5f56:0:b0:382:45db:6a1e with SMTP id
 ffacd0b85a97d-38a7913bcf8mr2711195f8f.14.1736252642416; Tue, 07 Jan 2025
 04:24:02 -0800 (PST)
MIME-Version: 1.0
References: <20241231002336.25931-1-pbonzini@redhat.com>
 <20241231002336.25931-2-pbonzini@redhat.com>
 <Z3zstgKXAgeRrIU2@intel.com>
In-Reply-To: <Z3zstgKXAgeRrIU2@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 7 Jan 2025 13:23:50 +0100
Message-ID: <CABgObfbdFo9B1nedC+Bu2QQfjTL1TOpmSQt0p0a0d0iWev6UKg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] rust: vmstate: add new type safe implementation
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, junjie.mao@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, Jan 7, 2025 at 9:39=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrote=
:
> This is very good work! I am curious about how QEMU plays with Rust
> forum:
>
> Rust forum's disscussion is under MIT and Apache 2.0 licenses [1], and
> since vmstate.rs is under the GPLv2 license, do we need to specify that
> certain code retains the MIT license?

I will add a note similar to the one that is already there in offset_of.

> > +/// ```
> > +/// # use qemu_api::call_func_with_field;
> > +/// # use core::marker::PhantomData;
> > +/// const fn size_of_field<T>(_: PhantomData<T>) -> usize {
> > +///     std::mem::size_of::<T>()
> > +/// }
> > +///
> > +/// struct Foo {
> > +///     x: u16,
> > +/// };
> > +/// // calls size_of_field::<u16>()
> > +/// assert_eq!(call_func_with_field!(size_of_field, Foo, x), 2);
> > +/// ```
> > +#[macro_export]
> > +macro_rules! call_func_with_field {
> > +    ($func:expr, $typ:ty, $($field:tt).+) =3D> {
> > +        $func(loop {
> > +            #![allow(unreachable_code)]
> > +            const fn phantom__<T>(_: &T) -> ::core::marker::PhantomDat=
a<T> { ::core::marker::PhantomData }
> > +            // Unreachable code is exempt from checks on uninitialized=
 values.
> > +            // Use that trick to infer the type of this PhantomData.
> > +            break ::core::marker::PhantomData;
> > +            break phantom__(&{ let value__: $typ; value__.$($field).+ =
});
> > +        })
> > +    };
> > +}
>
> Very flexible and powerful. (I even think this code could be released as
> a new public crate.)

It's probably not _that_ useful in general, unless you're implementing
this kind of reflection... otherwise I would have found an existing
solution. :) But yes, it's very powerful.

Out of curiosity, I asked claude.ai to explain it and it said "This is
a rather advanced use of Rust's type system and macro capabilities to
do compile-time reflection - basically inspecting the types of struct
fields without runtime overhead. While creative, this pattern isn't
commonly needed in everyday Rust code."

When fed the initial comment from the Rust forum it said "your comment
about wanting to access <T as SomeTrait>::SOMETHING for a field's type
is a classic serialization pattern - often used to get things like
type IDs, serialization formats, or field metadata at compile time".
That's actually pretty impressive; the LLM was also impressed and it
started asking me more about it ("Are you building a custom
serialization framework from scratch, or extending an existing one?").

> > +/// Return the `VMStateField` for a field of a struct.  The field must=
 be
> > +/// visible in the current scope.
> > +///
> > +/// In order to support other types, the trait `VMState` must be imple=
mented
> > +/// for them.
> > +#[macro_export]
> > +macro_rules! vmstate_of {
> > +    ($struct_name:ty, $field_name:ident $(,)?) =3D> {
>
> why allow a comma at the end? It seems other patches don't use that
> style.

I copied it from the standard library offset_of, but I can remove it too.

> > +// Add a couple builder-style methods to VMStateField, allowing
> > +// easy derivation of VMStateField constants from other types.
> > +impl VMStateField {
> > +    #[must_use]
> > +    pub const fn with_version_id(mut self, version_id: i32) -> Self {
>
> Why not use u32 (and omit an assert)?

The version_id field is an int in the C struct; you'd still need to
assert that it's <=3D i32::MAX, and you'd also need an 'as i32'. In
practice it will always be a constant, therefore it will auto-cast to
either i32 or u32.

Paolo


