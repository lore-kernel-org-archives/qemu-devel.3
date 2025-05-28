Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4874C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 17:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKKDw-0006Ee-Eo; Wed, 28 May 2025 13:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1uKKDs-0006Ct-04
 for qemu-devel@nongnu.org; Wed, 28 May 2025 13:05:48 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1uKKDl-0001uv-4W
 for qemu-devel@nongnu.org; Wed, 28 May 2025 13:05:45 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2c873231e7bso26949fac.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 10:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748451938; x=1749056738; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t/yAv5kPWMuG89DIVHklSZkFE6BdGUjYUE7Um0QfmUI=;
 b=tmHo7ye3aNmaYEXLWLpkmfK6eWlAi/i7hMyl+7UMQQZnlaj2LgenEbQuCKZUCk5Kdc
 SGhnwl2T8bPBcm0whs4LLQ2oMR4xaI/HyQYfZCuiLpQl352LHSO8jWq0w1Lrz7wwgcxE
 6he7BbZ0MkKqrOUiUPprxjcyRtWfoNLWKnlOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748451938; x=1749056738;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t/yAv5kPWMuG89DIVHklSZkFE6BdGUjYUE7Um0QfmUI=;
 b=veRvA+88f9R5k9fn40FN9cnMhXGFgbcFAKFDNcVn5ch/R1Igsqq4AIywmFcCF5Rky0
 vOhtNdkjqhg0mf96Aj4YTFgqqrgnZeblMw8r9411NDja9UE2NtYG2vrDNlpW94Ay5MpY
 qXPQS0s+j9I/ThJSxYsN4GCcgieIyBkIaZRx+O6tx7SbvGAyc0pTcDite/1w4lYlKszW
 DTN7yLEkY4nzul1guABk7z+/kn5JthKBOKmTD/am3KTb/QHw5muFvCCeWkvvItgGVchZ
 NwvR9xpTo2sVuRfRbAE26KjxfJ+Ax0TSarwwfw8I6GPz3sNYDsHfRjR1kBfv4a5COvtV
 jyUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLxuGRSuF9/gBQLlUPOG5tAkZzkM5qntcYhpv7r3/OAqWjARSP3H0IbvGUqppQHPMldyoHYcy116Ce@nongnu.org
X-Gm-Message-State: AOJu0YyKxxlyhAscKKz8m89/5+tZuwVOcdqtfpuDjMEMSBOMA3AXaAuv
 9w+uj4BTVzWoLTTjo0GK8+csxRwq7vFa16eEmUpJusY/9P3Drkdn3cgf3oRB7zopXFM=
X-Gm-Gg: ASbGnctg/e0+DjHPj6XRxmDcMLUDkaeuJwa/Nmh7HxDTNLwkYymlibU5nmoAcJ3bexL
 5TzXoU88GhTmVAFxT0ywMyrkHQ3yg40o7spWC9PoVJtXmRb7pfvqVXyPp2tojJ2SFSypzbRp89j
 z7BWBye0z1hUN3tjCOX6Ijfb8bWDvrCIwLxta4mPsgPZ662fonDQUUqI2euXsfAhJO6ObwYwkmu
 i8eDPfIqub+hq1A622Yeand5h2/H/JVdLtcqo2ymQUEXIXhM5ERDjTmMl/E6QDnn5n0Px2aqyZq
 vPVovf8mpzL6M99g7pyuNVXo3JiWzqN+xaLV+J/EoxTc0ABwFTstIVgu1mI2yiytftSKFQVOydc
 E3kLSszpXw19O
X-Google-Smtp-Source: AGHT+IEscc4t72F00UPULHXQsCH/1TqK2kzc60h7uB3JBTi2x2GwBnsdOiviB3vkuVn+0xG6jW/WgQ==
X-Received: by 2002:a05:6870:d294:b0:2d4:c19a:94e5 with SMTP id
 586e51a60fabf-2e862106460mr7296301fac.39.1748451938084; 
 Wed, 28 May 2025 10:05:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e8e1a3782fsm312213fac.38.2025.05.28.10.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 10:05:37 -0700 (PDT)
Date: Wed, 28 May 2025 11:05:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 =?iso-8859-1?Q?Fran=E7ois?= Ozog <francois.ozog@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Alexander Graf <agraf@csgraf.de>,
 Boyan Karatotev <boyan.karatotev@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Fabio Estevam <festevam@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>, Jonas Karlman <jonas@kwiboo.se>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Liya Huang <1425075683@qq.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@nabladev.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Xu Zhang <423756212@qq.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 00/25] passage: Define a standard for firmware data flow
Message-ID: <20250528170533.GE100073@bill-the-cat>
References: <20250528123236.1138632-1-sjg@chromium.org>
 <20250528142521.GW100073@bill-the-cat>
 <CAFLszTiHxdkoGbdOg8rzmn9kUmt925LZvZNxSXQC5Y4A=s2Vig@mail.gmail.com>
 <20250528151927.GB100073@bill-the-cat>
 <CAFLszTh3WDhn_ZSRsBMTpD8i5AyNLFGiV0cbPhOfCUAud1_WOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xp7Z45B7ao1e4WIh"
Content-Disposition: inline
In-Reply-To: <CAFLszTh3WDhn_ZSRsBMTpD8i5AyNLFGiV0cbPhOfCUAud1_WOg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=trini@konsulko.com; helo=mail-oa1-x2a.google.com
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


--Xp7Z45B7ao1e4WIh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 05:08:38PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 28 May 2025 at 16:19, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, May 28, 2025 at 03:32:12PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 28 May 2025 at 15:25, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, May 28, 2025 at 06:32:02AM -0600, Simon Glass wrote:
> > > > >
> > > > > This series adds a standard way of passing information between di=
fferent
> > > > > firmware phases. This already exists in U-Boot at a very basic le=
vel, in
> > > > > the form of a bloblist containing an spl_handoff structure, but t=
he intent
> > > > > here is to define something useful across projects.
> > > > >
> > > > > The need for this is growing as firmware fragments into multiple =
binaries
> > > > > each with its own purpose. Without any run-time connection, we mu=
st rely
> > > > > on build-time settings which are brittle and painful to keep in s=
ync.
> > > > >
> > > > > This feature is named 'standard passage' since the name is more u=
nique
> > > > > than many others that could be chosen, it is a passage in the sen=
se that
> > > > > information is flowing from one place to another and it is standa=
rd,
> > > > > because that is what we want to create.
> > > > >
> > > > > The implementation is mostly a pointer to a bloblist in a registe=
r, with
> > > > > an extra register to point to a devicetree, for more complex data=
=2E This
> > > > > should cover all cases (small memory footprint as well as complex=
 data
> > > > > flow) and be easy enough to implement on all architectures.
> > > > >
> > > > > The emphasis is on enabling open communcation between binaries, n=
ot
> > > > > enabling passage of secret, undocumented data, although this is p=
ossible
> > > > > in a private environment.
> > > > >
> > > > > To try this out:
> > > > >
> > > > > $ ./scripts/build-qemu -a arm -rsx
> > > > >
> > > > > This will build and run QEMU for arm64 and you should see the sta=
nddard
> > > > > passage working:
> > > > >
> > > > >    Core:  49 devices, 13 uclasses, devicetree: passage
> > > > >
> > > > > This series is available at u-boot-dm/pass-working
> > > > >
> > > > > Changes in v5:
> > > > > - Add RFC for test script
> > > >
> > > > And this is why I question if you are working in good faith. I've
> > > > rejected this countless times. I'm still rejecting it. Stop includi=
ng
> > > > it. Point at the version you could easily be maintaining in the con=
trib
> > > > repository where you have write access and no one will be telling y=
ou to
> > > > not do something. People would even review the patches since it wou=
ld be
> > > > against mainline.
> > >
> > > I fully understand that you don't want the script and I'm only
> > > including (as an RFC) so people can actually try this series out. I
> > > didn't want to point to my tree as I thought that would annoy you. I
> > > already went through why the contrib tree is not suitable for me.
> >
> > So I have to take changes that I disagree with, but you can't work with
> > a tree for your tooling where the community would be happy to provide
> > feedback? That does not sound like compromise. Again, I have trouble
> > believing that you are working in good faith to resolve the differences
> > here.
>=20
> Yes, as mentioned before I would like you to take changes you disagree
> with, at least once we have discussed alternatives and I'm sure that's
> the way I want to go. It would save a lot of grief if you could do
> that.
>=20
> I could use your contrib/ repo but there isn't a lot of point, since I
> have to have my own tree anyway, due to rejected / changes-requested
> patches. It's just lots of fiddling around for no gain. I'm fine with
> your not having the scripts in your tree and I'm fine with maintaining
> the Python tools in my tree. Basically it seems my tree is the dumping
> ground for the stuff you don't want in 'pure U-Boot', or don't want
> yet. If you would like me to sync my scripts to the contrib/ tree
> every now and then, yes I can do that. I don't see much point since we
> can't reference them in docs or test them in CI, but I'm willing to do
> it.
>=20
> But I do want to post patches so I can get feedback from people who
> are interested. Perhaps we could set up an 'experimental' mailing list
> for that, since you seem really unhappy when I send them to the U-Boot
> mailing list?
>=20
> Re your 'good faith' thing, I'm really just trying to make progress
> and I wish there was less 'email overhead' and more action. If you
> have concerns, it would be better to discuss a resolution f2f or on a
> VC, not endless email threads which don't relate to the patches I'm
> sending. The series we are discussing here was sent in 2021 based on
> bloblist from 2018! [1]. It is why Firmware Handoff happened. Give me
> some credit for foresight, at least.

You need to decide if it's more important to work with the community or
have your way every time. You cannot have both. You need to accept that
some things you think are good ideas have been rejected or you need to
fork off from U-Boot. Or you can ask the community to take over as the
project head. If the community wants you to run things, I will step
down and just be an individual contributor again. Five months of this
experiment shows me that it's not working at all and will only be a
bigger problem as time goes on.

--=20
Tom

--Xp7Z45B7ao1e4WIh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg3Ql0ACgkQFHw5/5Y0
tyyVDwv+LlUHM6bp8YMtrImHtYTBJRv1I9sZ8I+MItxNvHa/Uawx7eA7IOUQ5iNf
0Pjn3Wz4Al83EfMC3Ez1eSUt6tQKwsgJ4NsGXdDURx6FqLBC/XUK3kLVbeEXYUu1
++bXeAZ5/CtgiWHTg3WH8FlVNNqMwBmYG82Lef9w03QCO7F8qr3wK1M+rISrZKfK
ppAXbJx56lNfxHfNp6Dr0mDCAb+9gnacBQ+nv4XDNT9V0rPYNIuxREDknxpXBKor
w2vXSt2okINwoNcYn7m/rzexStz1ClCmiodIpJS6C1ciBe8LRXfqELTLFuP0ejh5
JxOgdm6PsWT+VxWnAR+FI1SkU/m2/KSSzxRsboFYzAZqvlHrHzmccnDfXe+WOwTo
BJPGdlSPeuDtAS1oJHHSloh9zF43ySc4HfaKzko4aV7mQamzHaA7Ti8xTmHN3hmt
usU+yEfmE9S/z53mDhEx5SBL0AdA1SQSV34Qahj/HoKn37WC65RllkcxplCLuOIi
nX24LAzf
=nStp
-----END PGP SIGNATURE-----

--Xp7Z45B7ao1e4WIh--

