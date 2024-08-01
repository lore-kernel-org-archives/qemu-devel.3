Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092ADC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 16:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZYIi-0002IW-As; Thu, 01 Aug 2024 12:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sZYId-0002EQ-QQ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:05:08 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sZYIb-0001gB-QZ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:05:07 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a7ab5fc975dso650814066b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 09:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722528303; x=1723133103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UraJEAGUMpzljakCtRMmTiDbLKttts3ShtT7iKqW2eQ=;
 b=F/k8KVVq8Xez/YbL2THE4Xku1Bifwq6ZZZaL6FuyEqkEiJp9cCTI31dGnAnspbtG3s
 X4U0j+e3cdM0/o9sir6M+k0KVnfeaOq7M6wCnINgAZcEKkYPCxjT0FU28riRmELuelQo
 Ds+S9+p/+TqqrS9jq8TanHInkaKSTwAH3npnSh19k794acaMz4xJi3RNcTt6SWchg82E
 Gm2hPPUQJgYPsPYKqTapSPwYvAty7/jvpJ7WjyaN5L7oe6lG4OyNldqiDdKZ9GPBwMec
 PawHA5jpA6zTCM2fHVPQ7fhjjGP0tRdBka9bpYG40+xu59NzOAMSD/7aUe9Cyuse3c5H
 Su+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722528303; x=1723133103;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UraJEAGUMpzljakCtRMmTiDbLKttts3ShtT7iKqW2eQ=;
 b=GqAEM1Jll4nhGcQD81MZNWwGeuFF6vaBOCYYbUu/bi6v+qqTjT5usvrcvkLOAEfkAf
 Ft1TNnX8GPcBt+ETAzRgO+pNfdRtz6tWhgbmAETLnQu+/Yim3CFLVh7HzFCZmtv9HQ8g
 06AO16O11iYrc/VpQRi2tQWK/a+R/mcK9tM24L2Q4+WtpV75m5vz0IkXQ5x4pnD7W182
 5J0zNYCHGxNoSwz04p3nInicMEcrIaC87LXiQ1VN1PlBlo48SVw8beIjXKK+sWI/HisS
 MOpBYzEvjGGSBCuiKBbL76LQ+N0ed6/Q3iRHVdEK5yd91wplw/SbXK5mGB1GCy99lSyS
 vrKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW56/nJBAe4y/LkCqq0HPyfFoz5zAWf4OqH7Yv0MTL6bC1NZOV46MXxt0S043kBErx1ViV4WvVMBbSw+6qa0K14BS1tDYg=
X-Gm-Message-State: AOJu0YzDLUaiUXVVdqLhjXiDNHfCSn6jTWDezsx6pUHg5GgFkem9lq4+
 CnaSKIPUcpu4wCFmmI/SWnfKtJYk7gU2Iy2+OtUtrLy7SFKsxgmYN8zOoglBy20=
X-Google-Smtp-Source: AGHT+IGQheyAl83OGQCgDvJX1Qq8gYqzJ54QT7zQyOcPCVmA/8NmGImxlX4P5CkAk0dPsdGHHNmHrQ==
X-Received: by 2002:a17:906:c10a:b0:a6e:f7bc:dcab with SMTP id
 a640c23a62f3a-a7dc50a47cemr50816366b.65.1722528302383; 
 Thu, 01 Aug 2024 09:05:02 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acadbb910sm919959766b.225.2024.08.01.09.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 09:05:01 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AF1225F7AD;
 Thu,  1 Aug 2024 17:05:00 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cleber Rosa <crosa@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,  Peter
 Maydell <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,  Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>,  David Woodhouse <dwmw2@infradead.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Leif Lindholm
 <quic_llindhol@quicinc.com>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 kvm@vger.kernel.org,  Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,  qemu-arm@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>,  Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  Akihiko Odaki
 <akihiko.odaki@daynix.com>
Subject: Re: [PATCH 06/13] tests/avocado: use more distinct names for assets
In-Reply-To: <CA+bd_6JjpHe=DJZMJb7x-bu_-i8X2Z4LCuk-Mz-2_LbqtUKYNQ@mail.gmail.com>
 (Cleber Rosa's message of "Wed, 31 Jul 2024 23:12:34 -0400")
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-7-crosa@redhat.com>
 <ZqdzqnpKja7Xo-Yc@redhat.com>
 <CA+bd_6JjpHe=DJZMJb7x-bu_-i8X2Z4LCuk-Mz-2_LbqtUKYNQ@mail.gmail.com>
Date: Thu, 01 Aug 2024 17:05:00 +0100
Message-ID: <87sevocjpv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Cleber Rosa <crosa@redhat.com> writes:

> On Mon, Jul 29, 2024 at 6:49=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange=
@redhat.com> wrote:
>>
>> On Fri, Jul 26, 2024 at 09:44:31AM -0400, Cleber Rosa wrote:
>> > Avocado's asset system will deposit files in a cache organized either
>> > by their original location (the URI) or by their names.  Because the
>> > cache (and the "by_name" sub directory) is common across tests, it's a
>> > good idea to make these names as distinct as possible.
>> >
>> > This avoid name clashes, which makes future Avocado runs to attempt to
>> > redownload the assets with the same name, but from the different
>> > locations they actually are from.  This causes cache misses, extra
>> > downloads, and possibly canceled tests.
>> >
>> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> > ---
>> >  tests/avocado/kvm_xen_guest.py  | 3 ++-
>> >  tests/avocado/netdev-ethtool.py | 3 ++-
>> >  2 files changed, 4 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/tests/avocado/kvm_xen_guest.py b/tests/avocado/kvm_xen_gu=
est.py
>> > index f8cb458d5d..318fadebc3 100644
>> > --- a/tests/avocado/kvm_xen_guest.py
>> > +++ b/tests/avocado/kvm_xen_guest.py
>> > @@ -40,7 +40,8 @@ def get_asset(self, name, sha1):
>> >          url =3D base_url + name
>> >          # use explicit name rather than failing to neatly parse the
>> >          # URL into a unique one
>> > -        return self.fetch_asset(name=3Dname, locations=3D(url), asset=
_hash=3Dsha1)
>> > +        return self.fetch_asset(name=3Df"qemu-kvm-xen-guest-{name}",
>> > +                                locations=3D(url), asset_hash=3Dsha1)
>>
>> Why do we need to pass a name here at all ? I see the comment here
>> but it isn't very clear about what the problem is. It just feels
>> wrong to be creating ourselves uniqueness naming problems, when we
>> have a nicely unique URL, and that cached URL can be shared across
>> tests, where as the custom names added by this patch are forcing
>> no-caching of the same URL between tests.
>>
>
> Now with your comment, I do agree that this adds some unneeded
> maintenance burden indeed.  Also, this was part of my pre-avocado bump
> patches that would work around issues present in < 103.0.  But let me
> give the complete answer.
>
> Under 88.1 the "uniqueness" of the URL did not consider the query
> parameters in the URL.  So, under 88.1:
>
>    avocado.utils.asset.Asset(name=3D'bzImage',
> locations=3D['https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/download?pa=
th=3D%2Fkvm-xen-guest&files=3DbzImage',
> ...)
>    avocado.utils.asset.Asset(name=3D'bzImage',
> locations=3D['https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/download?pa=
th=3D%2Fnetdev-ethtool&files=3DbzImage',
> ...)

This is mostly a hack to avoid having to tell NextCloud to generate a
unique sharing URL for every file.

>
> Would save content to the same location:
> /tmp/cache_old/by_location/2a8ecd750eb952504ad96b89576207afe1be6a8f/downl=
oad.
>
> This is no longer the case on 103.0 (actually since 92.0), the
> contents of those exact assets would be saved to
> '/by_location/415c998a0061347e5115da53d57ea92c908a2e7f/path=3D%2Fkvm-xen-=
guest&files=3DbzImage'
> and /by_location/415c998a0061347e5115da53d57ea92c908a2e7f/path=3D%2Fnetde=
v-ethtool&files=3DbzImage'.
>
> I personally don't like having the files named, although uniquely,
> after the query parameters.  But, If this doesn't bother others more
> than the maintenance burden, and Avocado version bump is applied, this
> patch can be dropped.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

