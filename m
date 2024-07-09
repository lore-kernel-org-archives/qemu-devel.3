Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38F7C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 12:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9xq-0000kC-Ud; Tue, 09 Jul 2024 08:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sR9xp-0000id-6Y
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 08:28:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sR9xn-0005LE-Ga
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 08:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720528133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XAThAYQcfB00ilW352owO5DOb29nuHkEZe0rT0Q25a0=;
 b=RCnY6tpUvztcYR4ExmXyMUM+UgiMQkjXi8Jpu01VT+4Z79H7Mpx0Up2w+752ctZU4f7ESU
 rJvavCL/D2w4YikLU76nvOAVFt5YUB7Gel+OONHzWD94QyoSE6DyP+McO6LWJWMr8njR3f
 cR4H8VfWIyIqRfM/pgWHihnRFaMS7oA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-ZGTkAc0SP5aMxsdbmoI7rg-1; Tue, 09 Jul 2024 08:28:51 -0400
X-MC-Unique: ZGTkAc0SP5aMxsdbmoI7rg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42666ed2d5fso17353015e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 05:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720528130; x=1721132930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XAThAYQcfB00ilW352owO5DOb29nuHkEZe0rT0Q25a0=;
 b=spyg5TkLs7mlict54RJVYlKtJDkPrhTfjcuNEtb9M4ILHAgRRj7mdF5A+lbMjU4TnC
 EOwbLDutM8nb9uA2EuL63+oYfEZm1q5ao3luD3QrOCFaF8ADe+Wt50vlVOxjuGxAGwUM
 QFzjte1+cQc81/vxdLjYj/y96aAx33D16Ynu3/CITBRlNLwmwfszvpIyJyIFn7Jmj8oy
 eah9xWa3xW/ZuAkEdwlN4X7qHJgMmCYOIVnvxyX1k0LsyTOirnGI0nt4EQQukyoZMltx
 w6DQAk4BW5+qo2jczaGODXdSqTH7sPKDoqdiQ15h4ntI8woQfta/6QFr382wmDFO/WhN
 HdKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeZYdz7e0ahsW7HDHVwc+aFjmQkh77ohi6rOQyz4YoAh8PRAbC2eAXQR0SNtctfbuEatUD23RrunYo3rJ+bNtraGpqDWk=
X-Gm-Message-State: AOJu0YzClveJ9EetND/vma2Dp2C74KFPFToqzrvFDE6If1W6i/1GFIWp
 IokCBC0c5wLpowwAOZ4kuijsuQSON9bskaWSq935m5mF8dmWhxYM+Uqxwyzmcv1p7yzMcoyvd0v
 Kzh7kVnkkQ1b2oG8Vbx+YLwE3Je1J6EcAUdQ6UfPNPsP/9NFMINjsrgork63L1WpRoe1rdkC4rR
 q5dTnKWtHkZzzAkNWl0ISL+maK78g=
X-Received: by 2002:a05:600c:c8:b0:426:6171:6083 with SMTP id
 5b1f17b1804b1-426707db65emr14796375e9.13.1720528130440; 
 Tue, 09 Jul 2024 05:28:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+x0IYxYhWfBhPfXUxquZZSeQ33PjLE5fGt2CXnSXKhMrhuNhK4A7T+p7MpKgwMmt9lHU/c3283WsI1nUmRhY=
X-Received: by 2002:a05:600c:c8:b0:426:6171:6083 with SMTP id
 5b1f17b1804b1-426707db65emr14796225e9.13.1720528130098; Tue, 09 Jul 2024
 05:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <4ce5a7330f594c6c94c8cc3aabceb061095bb855.1720094395.git.manos.pitsidianakis@linaro.org>
 <87msmqsunu.fsf@draig.linaro.org>
 <CAFEAcA9X0564R7V=EsN2qxj51FNNkot3Pfev6mMgUbr35WYFZw@mail.gmail.com>
In-Reply-To: <CAFEAcA9X0564R7V=EsN2qxj51FNNkot3Pfev6mMgUbr35WYFZw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 9 Jul 2024 14:28:38 +0200
Message-ID: <CABgObfbBqHoy4M78NR8EAQ-PV+X86qEK6_ra=tS0_bgqpAt1dw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/7] rust: add bindgen step as a meson dependency
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 9, 2024 at 2:09=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>  * what is the actual baseline requirement? We definitely want
>    to support "using rustup on an older system" (should be no
>    problem) and "current distro building QEMU using the distro's
>    rust", I assume. It would certainly be nice to have "building
>    QEMU on the older-but-still-in-our-support-list distro releases
>    with that distro's rust", but this probably implies not just
>    a minimum rust version but also a limited set of crates.

I don't think limiting ourselves to the set of crates in the distro is
feasible. It's not the way the language works, for example I tried
checking if the "cstr" crate exists and I didn't find it in Debian.

We can define a known-good set of versions:
* either via Cargo.lock (i.e. recording the versions and downloading
them) or by including sources in the tree
* at any time in qemu.git, at branching time (three times a year), or
on every release

(That's six possibilities overall).

>    I think (but forget the details) that some of what we've done
>    with Python where we accept that the older-but-still-supported
>    distro will end up taking the "download at build time" path
>    in the build system might apply also for Rust.

Yes, and --without-download may be changed to the "--frozen" flag of cargo.

>  * what, on the Rust side, is the version requirement? Presumably
>    there's some features that are pretty much "we really need
>    this and can't do without it" and some which are "this would
>    be pretty awkward not to have but if we have to we can implement
>    some kind of fallback/alternative with a TODO note to come
>    back and clean up when our baseline moves forwards".

Here are the stopping points that I found over the last couple weeks:

1.56.0: 2021 edition
1.59.0: const CStr::from_bytes_with_nul_unchecked (needed by cstr
crate, see below)
1.64.0: std::ffi::c_char
1.65.0: Generic Associated Types
1.74.0: Clippy can be configured in Cargo.toml
1.77.0: C string literals, offset_of!

I think 1.59.0 is pretty much the lower bound. Not having offset_of!
will be a bit painful, but it can be worked around (and pretty much
has to be, because 1.77.0 is really new).

As far as I understand, Debian bullseye has 1.63.0 these days and it's
the oldest platform we have.

Paolo

> At that point we have more information to figure out what
> if any tradeoff we want to make.
>
> thanks
> -- PMM
>


