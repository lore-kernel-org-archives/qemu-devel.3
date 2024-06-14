Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF851C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 17:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIB4T-00033k-CA; Fri, 14 Jun 2024 13:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sIB4Q-000330-Sr
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sIB4O-0001dv-SH
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718387435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qhz1hllXNq5z8XvXMyp4QBaSbTcjW19hXQTXGSHLySg=;
 b=TKrZNURrUc+1J4BNzf+nyxrTLYvJ88xlDJ7iz59SzRsvQNnRJ5+Q2xkS/knW6AoCEYXEPn
 tzJdSIMI/LvwMbMrZhIxzpXTQrV2xr5D4FgA16V3t+BLaMZWHyIQHR3L7OjZ5N4g7OYRSO
 R7jlxXQozhu3tX3Do2Bt6eUWh36Ey2g=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-3kEXxEyEMyWeIIQPwSb23Q-1; Fri, 14 Jun 2024 13:50:33 -0400
X-MC-Unique: 3kEXxEyEMyWeIIQPwSb23Q-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c2dfa5cfa5so2201786a91.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 10:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718387432; x=1718992232;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhz1hllXNq5z8XvXMyp4QBaSbTcjW19hXQTXGSHLySg=;
 b=T1aqoLWK3nX5RxsOpSD92ROslqUC48kAkTXPN3AEi/qyClG4tTvAVghRKNrrhJCHy0
 3hqeV4MJqrttax8kniD+6NXwuQyy8Yadu14QlL1UFf4SR9acZ7+4+O6HQWBEFaUKgNP/
 byiTAXZIcnmF+0bBb1PIUuLyqLqu+Jdm+xlF0rVP2pIBEi9tYIo9u7cvIt2d8QOiB1gl
 xB4h+IDSWYi0z+MFcmjUELha9qT9fEHiKURcahk+H874jDHxr1Zfknv7YynXqIkS915/
 kE41Waj29GaLtUkkcY8bPeuIsnQHbroKT3bLNVAnjLJn49QnEFr1+qSZWPtqIEAMSkyL
 1NbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT/uvAsksZ9MiXjRz6MhTEBaG0pxxG7zv8J1Sbe963/S7Z7XtmkdH6ke+Mvyir2xrJgLtXNFQlhUa08Emk3laR84nVX4k=
X-Gm-Message-State: AOJu0Yxa0ncMKwkyKDyxlXerEc+L0Fsu1xsXZAUVtknUi9U17KxMy9eZ
 wZqLIEWSGHwjRtHztTlwJsfnQ3LRsCxO7brhq9DmVdLmtqZEn2Y58PoAdF0tQA/H6VdH3XIEreX
 AksUZVV6B+m7hq8nExnfgyBlGXT2RZUi/Kg/vljYfC+SwR9uxG427jDZOTUqNbgXDV4olsYvFR3
 s341dG9FDpV3ZBK50C8dIQJgZqX5w=
X-Received: by 2002:a17:90a:8581:b0:2c2:fed1:769f with SMTP id
 98e67ed59e1d1-2c4db24c1a4mr3520172a91.13.1718387432622; 
 Fri, 14 Jun 2024 10:50:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOary0DWdpOA9lkKKPDIisTLbTjrOLkcMoFkW0jLiUPGWbbYLWACLh7pg7nCFqIVEx5pfZ/40mHRiTeYqfmzI=
X-Received: by 2002:a17:90a:8581:b0:2c2:fed1:769f with SMTP id
 98e67ed59e1d1-2c4db24c1a4mr3520148a91.13.1718387432258; Fri, 14 Jun 2024
 10:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <CABgObfY8BS0yCw2CxgDQTBA4np9BZgGJF3N=t6eoBcdACAE=NA@mail.gmail.com>
 <ez270.x96k6aeu0rpw@linaro.org> <ZmnHoajecti472mi@redhat.com>
 <ezjl0.qx0tmsp6d6t@linaro.org>
 <CABgObfbGwKc0RYBcDPzNkE8HOSouFj4D15Oh7TuiKOC+D7raaA@mail.gmail.com>
 <ZmqcFf0xB9m4WkA3@redhat.com>
 <CABgObfb4+FSsadFTVg6Dc1zehQV2Vei2_kSRd5CfxsGBLPN6Eg@mail.gmail.com>
 <Zmq47yQV-sQ0hGMy@redhat.com>
 <CABgObfYaxBxc8GS3=YU=EwNLEihEoD4ikZ595P4m_KTZCAAaBw@mail.gmail.com>
 <f26b0.f15017t08v16@linaro.org>
In-Reply-To: <f26b0.f15017t08v16@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 14 Jun 2024 19:50:19 +0200
Message-ID: <CABgObfaYUCU0Tj-jj66n8AaxOpqXFKcQA-E6G0W6q3MjjwQkiQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Jun 14, 2024 at 9:04=E2=80=AFAM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Thu, 13 Jun 2024 23:57, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >On Thu, Jun 13, 2024 at 11:16=E2=80=AFAM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> >> I guess there's a balance to be had somewhere on the spectrum between =
doing
> >> everything against the raw C binding, vs everything against a perfectl=
y
> >> idiomatic Rust API wrapping the C bniding. The latter might be the ide=
al,
> >> but from a pragmmatic POV I doubt we want the barrier to entry to be t=
hat
> >> high.
> >
> >Yes, I agree. I guess we could make things work step by step, even
> >committing something that only focuses on the build system like
> >Manos's work (I'll review it).
> >
> >I can try to look at the basic QOM interface.
> >
> >Manos, can you create a page on the wiki? Something like
> >https://wiki.qemu.org/Features/Meson.
>
>
> Certainly! Just to make sure I understood correctly, you mean a wiki
> page describing how things work and tracking the progress?
>
> I added https://wiki.qemu.org/Features/Meson/Rust

I moved it to https://wiki.qemu.org/Features/Rust/Meson :) and wrote
https://wiki.qemu.org/Features/Rust/QOM. I got to the point where at
least this compiles:

qdev_define_type!(c"test-device", TestDevice);
impl ObjectImpl for TestDevice {}
impl DeviceImpl for TestDevice {}

fn main() {
    let d =3D TestDevice::new();
    d.cold_reset();
}

Of course the code makes no sense but it's a start.

One thing that would be very useful is to have an Error
implementation. Looking at what Marc-Andr=C3=A9 did for Error*
(https://patchew.org/QEMU/20210907121943.3498701-1-marcandre.lureau@redhat.=
com/20210907121943.3498701-13-marcandre.lureau@redhat.com/),
his precise implementation relies on his code to go back and forth
between Rust representation, borrowed C object with Rust bindings and
owned C object with Rust bindings. But I think we can at least have
something like this:

// qemu::Error
pub struct Error {
    msg: String,
    /// Appends the print string of the error to the msg if not None
    cause: Option<Box<dyn std::error::Error>>,
    location: Option<(String, u32)>
}

impl std::error::Error for Error { ... }

impl Error {
  ...
  fn into_c_error(self) -> *const bindings::Error { ... }
}

// qemu::Result<T>
type Result<T> =3D Result<T, Error>;

which can be implemented without too much code. This way any "bool
f(..., Error *)" function (example: realize :)) could be implemented
as returning qemu::Result<()>.

Paolo


