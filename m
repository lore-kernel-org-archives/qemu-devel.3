Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C945DC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 15:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKIZC-0003Vq-Pp; Wed, 28 May 2025 11:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1uKIZA-0003VR-U3
 for qemu-devel@nongnu.org; Wed, 28 May 2025 11:19:41 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1uKIZ5-0006uA-2o
 for qemu-devel@nongnu.org; Wed, 28 May 2025 11:19:40 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-60b8a9be972so968637eaf.1
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 08:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748445572; x=1749050372; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qA9Udb9eBCGzXFBNz6INRTeAqdTkugi7lKHtWO4Oe4Q=;
 b=YPKInl5rP9oHC4P7EfinlkH9od1Fvsk98yucyUExDKk/Hc+OmIGf7ygPnymp/V+sx4
 tAca+M3mkcQZKHH1ic0nzjPQwKRXJLv8racp45jUcJTLaNM6ijQG6ydnJv/D/rSmhuNb
 DGQh9hi27slMztNCdONiIlkmbO4Czulp18bVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748445572; x=1749050372;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qA9Udb9eBCGzXFBNz6INRTeAqdTkugi7lKHtWO4Oe4Q=;
 b=H4whEb4gkb0Hy97InZzRA8aZ+IiokQoR8T3Wb51JR6k/orjjKeGbwXvtQVbgMK6IVC
 icQ3Ya1XPClsHfgVIY58D0w1Z5dvNTjG1dfK12pKxHC0JX6pZ3+O2BBMB+HlK78Mg739
 +j6kP/zH2XsRRtDkKkgcwAjiVI+6FUsmAZYICgXZlxIliUuWGQFXfxdpHAerAzQhdxGf
 wNCnUjDZNX8XTPN/ODMU+Xx775p+7kXvF9iQbN8/c/HMq/++dR+aDVPQH90ybRS9mjXt
 NZRYcINOiqY3jacETy6JkVlhxp0cAOLcriVuAbh5hgUvaG8b0prnbFBl8IzLYGJq3w/N
 CpJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEKz1wV2jgVZWf2fJNQsdYwkdtJbNPM/i3wl7cCuereXz5y2E7uuz8Wtr3A8cpg6+bZwHnT27YgTdR@nongnu.org
X-Gm-Message-State: AOJu0Ywn0tWaX8i6TqrJg0eI39Ekyk+0wRl+PZAaTtDUburwAmeU34pQ
 2N7PeK1zE+UnqZ9CnLs6em0e/g1thCFANopCBc3DTRW0BbrU0A4pXyksNpGpiJIEqtk=
X-Gm-Gg: ASbGncscs84V5m9+V4pTxDHxIrj5Oa5NdyeBOmKr5x6OuBK9i1UiiWDIB1P9JU7FKIQ
 R2UWcNPUrz4IxNEmtf7DiknMGC01INSEQULK+B7cc86387NLvlL8GXWV0q/mhmDuA+mFv6Wm/h7
 3c7GEQGp3ORyqxhmDc6gyedqW1SEhZEIicFjaivJUEx0pvAMbtl5gmn9NvUwa/fQ4nQ34V8x0Ij
 92y11GCyq7pOlX2nzUiKMSZecEjeREw8zLB4MSaGHI3WJPdlznW9Gw0jGDLjQAPrEcn28L/Z3ix
 4oTNZtnZ3DfomVuxRfPxYVEa/yTjDkg1RZijggfesvBpZgzRjy6sP52lJVEecHrWAYRdoUUfMnv
 QJNSWwMxHaI7O
X-Google-Smtp-Source: AGHT+IHt1y6uP140FCGPwCd1umQRJ7YqsoFH9gV1I+QHkB7k6n+FRsNvH7As5n07PcZGswyJHhXqmA==
X-Received: by 2002:a05:6870:4008:b0:2e8:f5d4:6077 with SMTP id
 586e51a60fabf-2e8f5d46ec1mr434331fac.38.1748445571801; 
 Wed, 28 May 2025 08:19:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e8e176b4f7sm263557fac.27.2025.05.28.08.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 08:19:30 -0700 (PDT)
Date: Wed, 28 May 2025 09:19:27 -0600
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
Message-ID: <20250528151927.GB100073@bill-the-cat>
References: <20250528123236.1138632-1-sjg@chromium.org>
 <20250528142521.GW100073@bill-the-cat>
 <CAFLszTiHxdkoGbdOg8rzmn9kUmt925LZvZNxSXQC5Y4A=s2Vig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FQ8O+vMEqOogGsJJ"
Content-Disposition: inline
In-Reply-To: <CAFLszTiHxdkoGbdOg8rzmn9kUmt925LZvZNxSXQC5Y4A=s2Vig@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=trini@konsulko.com; helo=mail-oo1-xc34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


--FQ8O+vMEqOogGsJJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 03:32:12PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 28 May 2025 at 15:25, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, May 28, 2025 at 06:32:02AM -0600, Simon Glass wrote:
> > >
> > > This series adds a standard way of passing information between differ=
ent
> > > firmware phases. This already exists in U-Boot at a very basic level,=
 in
> > > the form of a bloblist containing an spl_handoff structure, but the i=
ntent
> > > here is to define something useful across projects.
> > >
> > > The need for this is growing as firmware fragments into multiple bina=
ries
> > > each with its own purpose. Without any run-time connection, we must r=
ely
> > > on build-time settings which are brittle and painful to keep in sync.
> > >
> > > This feature is named 'standard passage' since the name is more unique
> > > than many others that could be chosen, it is a passage in the sense t=
hat
> > > information is flowing from one place to another and it is standard,
> > > because that is what we want to create.
> > >
> > > The implementation is mostly a pointer to a bloblist in a register, w=
ith
> > > an extra register to point to a devicetree, for more complex data. Th=
is
> > > should cover all cases (small memory footprint as well as complex data
> > > flow) and be easy enough to implement on all architectures.
> > >
> > > The emphasis is on enabling open communcation between binaries, not
> > > enabling passage of secret, undocumented data, although this is possi=
ble
> > > in a private environment.
> > >
> > > To try this out:
> > >
> > > $ ./scripts/build-qemu -a arm -rsx
> > >
> > > This will build and run QEMU for arm64 and you should see the standda=
rd
> > > passage working:
> > >
> > >    Core:  49 devices, 13 uclasses, devicetree: passage
> > >
> > > This series is available at u-boot-dm/pass-working
> > >
> > > Changes in v5:
> > > - Add RFC for test script
> >
> > And this is why I question if you are working in good faith. I've
> > rejected this countless times. I'm still rejecting it. Stop including
> > it. Point at the version you could easily be maintaining in the contrib
> > repository where you have write access and no one will be telling you to
> > not do something. People would even review the patches since it would be
> > against mainline.
>=20
> I fully understand that you don't want the script and I'm only
> including (as an RFC) so people can actually try this series out. I
> didn't want to point to my tree as I thought that would annoy you. I
> already went through why the contrib tree is not suitable for me.

So I have to take changes that I disagree with, but you can't work with
a tree for your tooling where the community would be happy to provide
feedback? That does not sound like compromise. Again, I have trouble
believing that you are working in good faith to resolve the differences
here.

--=20
Tom

--FQ8O+vMEqOogGsJJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg3KX8ACgkQFHw5/5Y0
tywxHAwAlA/ak9ngBDCz8F+HvYRXP/qq+ol4YYHDMH/7rPTc1zwhnFXtZcx5aJi6
3v9wP4+ihX/zE9rIvmY7rX/1hPKTE1M5U9A1vCaJpnJHs5ciR53nJgDXjYfgu48m
cFSpMl567NyfzC7auYDGR6k1sRULszDAXB7LGc5WBlSrSIofcqZv5dUWLMVe4jp/
eMVwpIwSBRt80Ik63SXhO2byeXGVz9gnRZm35/uHIBIMxZMVLbhA2Zl50hzsJ6Ld
uQuRuP/JwaO8Et96S4cmiVTJ9t7KlY0RBJzgKAwW28DNXPl7/1ujwYCOuqrxZcNb
5m8siF0PlOf3UErAxTMpAkWsZLJLgLV981lwEC0FEcxpsh9fWR81LBysJ32f76hW
X5lEi/d1XyhJoejf194E4lUG27wVeyAGXkCLsoxmGamCaCM8awkNdF0RykM50CMQ
Elt1JVUbUvtkIeuwJi37ktrtMMKwNd/oRMMqZbVXhN4nuk0ejPg1UMSWKYa1wwcK
obyFFlaL
=X2ej
-----END PGP SIGNATURE-----

--FQ8O+vMEqOogGsJJ--

