Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C59CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 05:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uob81-0007eC-Qm; Wed, 20 Aug 2025 01:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eschwartz93@gmail.com>)
 id 1uob7t-0007ac-Mw; Wed, 20 Aug 2025 01:12:46 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eschwartz93@gmail.com>)
 id 1uob7r-0001QR-JT; Wed, 20 Aug 2025 01:12:45 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-70a9f5d4d97so63747006d6.3; 
 Tue, 19 Aug 2025 22:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755666761; x=1756271561; darn=nongnu.org;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=K5leS3AmeiUGKi+9R+Z+vWRMvBAefDpHyYO8FUVdYgs=;
 b=Zx6CbEtRhVt4hMwfDI2cLk5lP253X4f7Tq7GxpaOyo01gCkXqW2H1g9nUz6nFgxA1x
 HTfyNz4KSEiXr+0t5Fyhsu3O2Ob7mA3mTrVf5UD67oTH9hIJo5+FisNI1/GojeAZgrb/
 CXfTN0ul9fK+eIvkGsYK2fmZabVbplcFaT3DvvgNA1HOEM/R/bR5EUMuPSdqZxNsyJM9
 fpJsviSe66VVt8oCADQY41A/YttgGjhGJCR5tDCDharJ9iNDsCfQSgX9gJnF9eoj+zSn
 C+v4EbYLbkRUS92LHCUGetAW1hS8t3nwoU9tiUd2Y+gQ/7kLZ6nzqP2reT4kZZAU4QRD
 jm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755666761; x=1756271561;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K5leS3AmeiUGKi+9R+Z+vWRMvBAefDpHyYO8FUVdYgs=;
 b=xCVY85lhB1sFVUFP0dwvfR6nT4IEU15xU7Nh2ay2gaC+z/mKXx6mg/tyYx8GHeNPxf
 eQaa7Sl8K3GwvASwxaOJHthE19z5K312ISilV+o5dk3+NPe7BThU/1+0c6KbjT2I6ZYq
 umhtOJ7A5S/uErEObojB886R/Trgreno000WHXLTTZN50SqTUgZhaEdfKoHa2DwHOAV4
 9Yd0f5jjEBXQeIpzayrcJHTlCkRO5jh4EC2dzyBX1clafkyJVc5iZuOD/HzbaJ7zo/o2
 PoN18mSVm6kl6Js8oX9kv5gW/vOWUDvEX0Mr9DY4P9cBGtlxcp3lnaXhzhVmVOJEF16t
 wA/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrRDh8bLLZtsvCcjx1p8FGnxRYvMudVQq/Cnmx1I9QO3ai/eWVY8FiWIh0/RdVdASUUx698urJb0s=@nongnu.org
X-Gm-Message-State: AOJu0Yy3kbaIR+Eq6xIcoOh6AsXcPBA0kr0wZqaAD1khcAosc/NBkYv1
 RvW5Z9W5SjDmYXxisdZPsFQ5tuw5bRzS1PkKrrc+VhFe+fw3u7oZce9J
X-Gm-Gg: ASbGncso9wmG3gDpVrA88S8YjDOTAy+b85qz3AidSTcTsUlFxDZWhCxdNPo31QNmJtR
 xrjnLE4LpdlxGHAoIeLqKqBWVw9FDADDryWegKQb1adATKPeN9EmES3m5xSE1GJYpXT3/RbNKUW
 bCcCEGEpH3dE+wlbuzELkAhpW7vkIvQaKIpXy0jPLIXjIuQSpBnVcX5azLmA7wpm9XnWvktkor+
 5v4Mub/0LccdxJFrvzGozc2hGYZWqQiuoCJgoZ8G1hA41kp0ZFL97XZ3gN9f+CEgh3jruUkXBge
 3HljCDDS8oBniC5KeunPfSJlpSPExgm3uJlOd9V71mwTjgSDch41rUuNvsx18NnRbCKNFNT2e3b
 8jw29Lss/ss1+2s1FIs3ixWQGvTq19CXwsIX4
X-Google-Smtp-Source: AGHT+IHwGupkBy5ZEBt+Tae+7V3tY2FTXXwuhgldvuHMwBA1tNZcNmLY6airHRc/K6s9NGaF3L2dIA==
X-Received: by 2002:a05:6214:c4b:b0:707:70b7:376d with SMTP id
 6a1803df08f44-70d76f1c5f3mr17892686d6.1.1755666760923; 
 Tue, 19 Aug 2025 22:12:40 -0700 (PDT)
Received: from ?IPV6:2603:6011:3f0:cf90::12ac? ([2603:6011:3f0:cf90::12ac])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ba902f4e2sm82199026d6.7.2025.08.19.22.12.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 22:12:40 -0700 (PDT)
Message-ID: <eda4ade9-ba07-4e6e-adf8-e308a9ec3435@gmail.com>
Date: Wed, 20 Aug 2025 01:12:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: set test programs to not build by default
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:Rust-related patc..." <qemu-rust@nongnu.org>
References: <20250819154940.2137965-1-eschwartz@gentoo.org>
 <aKSmyWRB_Gi3kru_@redhat.com>
Content-Language: en-US
From: Eli Schwartz <eschwartz93@gmail.com>
Autocrypt: addr=eschwartz93@gmail.com; keydata=
 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
In-Reply-To: <aKSmyWRB_Gi3kru_@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0FJm7ihbLgSDXxnT1NeOLQVG"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=eschwartz93@gmail.com; helo=mail-qv1-xf2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0FJm7ihbLgSDXxnT1NeOLQVG
Content-Type: multipart/mixed; boundary="------------Xfk6eFVdTsXcNgZhIK4uhfyg";
 protected-headers="v1"
From: Eli Schwartz <eschwartz93@gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:Rust-related patc..." <qemu-rust@nongnu.org>
Message-ID: <eda4ade9-ba07-4e6e-adf8-e308a9ec3435@gmail.com>
Subject: Re: [PATCH] meson: set test programs to not build by default
References: <20250819154940.2137965-1-eschwartz@gentoo.org>
 <aKSmyWRB_Gi3kru_@redhat.com>
In-Reply-To: <aKSmyWRB_Gi3kru_@redhat.com>

--------------Xfk6eFVdTsXcNgZhIK4uhfyg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 8/19/25 12:31 PM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Aug 19, 2025 at 11:49:40AM -0400, Eli Schwartz wrote:
>> Rather, they are built when running `meson test`. This change is inert=

>> unless building with meson 1.7, as previous versions of meson build al=
l
>> `meson test` dependencies as part of `ninja all` as well.
>>
>> See:
>> https://mesonbuild.com/Release-notes-for-1-7-0.html#test-targets-no-lo=
nger-built-by-default
>>
>> An existing comment references this meson issue, with an included bug
>> reference, but was written before meson 1.7 fixed the bug. Update the
>> comment to change the advice from "if the bug gets fixed" to "when
>> bumping the minimum meson version".
>=20
> I am very much not a fan of projects that do not build test
> programs by default.
>=20
> If a dev is changing code and running 'ninja'/'make' everything
> that is affected should be rebuilt to identify any build failures
> that may have introduced immediately. This should include all
> test binaries, regardless of whether the dev is intending to run
> the tests at that time or not.
>=20
> We already have too many occassions when contributors submit
> patches that have tests which fail to pass & this will expand
> that problem with contributors submitting patches that fail
> to even pass compilation of the tests.


I don't really understand this division between people who submit broken
untested patches and people who submit broken untested patches. You do
still need to test the patches and reject them for not passing the tests
so no time is really saved. It strikes me as some kind of confusing
optics-based objection, like this is about the exact embarrassment level
of a broken patch.

But your proposal runs counter to existing code already in qemu's build
system, i.e. the comment I've updated. So I don't think it's entirely
fair to raise an objection to my patch at all -- better you should raise
a meta-discussion about this to discuss changing the existing
build_by_defaults.


> If we want the ability to opt-out of building tests by default
> so reduce build time, IMHO that should be behind a 'configure'
> flag / meson_options.txt setting.


There is anyways no point in this being a meson_options.txt setting and
complexifying all test programs via conditionals. As explained in my
link, you can have Makefile itself read a configure option and run:

`ninja all meson-test-prereq`

instead of

`ninja all`

In fact users submitting patches could as well -- but then too, they
could simply run tests for code they touched.

Either way it is definitely of interest to users running a build +
install of a tagged release, to skip building tests they won't run. e.g.
many linux distros make the test phase of packaging be optional.

Automake works the same way -- tests can be excluded from `make && make
install`, but get built on demand by `make check`.


--=20
Eli Schwartz

--------------Xfk6eFVdTsXcNgZhIK4uhfyg--

--------------0FJm7ihbLgSDXxnT1NeOLQVG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAEBCgB9FiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmilWURfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDYw
NDExMzA0QzA5RDM2NjI4MzQwRUVGRkNFQjE2N0VGQjU3MjJCRDYACgkQzrFn77Vy
K9a5IBAAnATPyNHRYFQZNRh92z5Jioxiw9GGDEBOd8w1zUHFFE1V2IQvUWjWWkaH
rwI5FjF5SNpezhq0mHQvVljSDanMrZK9cDfhcU+gTcZlQP3Klxb3Qu0jLfvCHsCy
2vsrjJjuFVoFvm/KoRCFsHv6W/CDvg72B3U6nomGgZ2US5IGKnO9SlJ8q/8hvU34
bCzSvVCjzIlwK2cYpCeHJmQekDcAWkp0H0qsRSOO/i9wcw7V+FlCrmO/8rPIMA+M
Eb9QG5L9Tv5lEpW8D9O0obC5y+X6imfAi7nhq5qIXtr0SjBuO7C5jlk+l3avrdRT
KrJZffYMwCbBw05zEhtkSFk4VB1RcwU+OMff4hz7wmYZBhSV0+AUX0tbk1rzNxnI
zFrLWfcW2di5MwaG6H0pZDklmccOV3TqGUQMpdewm/gmY1/Gl9vLxVcTPGBrTz7s
5dblDSGrv+0YUxlYNdOW2JtTzHUSOc1j1mI2WFlr59yC2FPIZyMKdraMrbgPTyU4
U2hLB5r8N6V/S9fQsfexT3X2iDc8jq3xo02SUxlCA1jPJtZg9o77r25vvvMV6Clc
42ANzyMfWf+B8tgDwZxHfGQUHTtDEac8Mc88dwCzqYn1x/vlUYZDusRiBsz/Irpf
I57/uvlcdEWnA892FTqXpa1KLpM39dFgpusVqeMiqC1BK0itqEU=
=6I8R
-----END PGP SIGNATURE-----

--------------0FJm7ihbLgSDXxnT1NeOLQVG--

