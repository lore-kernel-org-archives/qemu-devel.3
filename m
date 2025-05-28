Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A22C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 14:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKHim-000229-8C; Wed, 28 May 2025 10:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1uKHik-000221-7C
 for qemu-devel@nongnu.org; Wed, 28 May 2025 10:25:30 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1uKHii-0007eZ-EE
 for qemu-devel@nongnu.org; Wed, 28 May 2025 10:25:29 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72c173211feso1236435a34.1
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 07:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748442326; x=1749047126; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rSYy3JOnjlvPanwi3lqHexOXKUTQ/Go2whW10qTiO9w=;
 b=EAMb68MX3JNyJSHES9Dcbn7PFTmUO+4VnVOsVMAYv6MXgfs4EeCpX/y8+l5bt1wDNr
 3E39kB3F8Ms2nVKhQUYazzCbkBh3132Ovvp+aqSLp+UnTna0aPp2Yiy5uE7v6X2hLd8D
 A04qomZznzZyX6He92TjkMwiOX20Yl4H3c14g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748442326; x=1749047126;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rSYy3JOnjlvPanwi3lqHexOXKUTQ/Go2whW10qTiO9w=;
 b=nKiNdMemNW6N4FGaTqCrHRSY1+bDAJUm+il9s5Rm4P+cwWedfaGjHtZ1wlwI+PDusB
 +0nwrcd8pXeiGaQ+UV8eSBi7d1bLsH8Zj6r2Uer6o8AhDxPxd9blOgK4TD7S785GL+lS
 5rh8kINiGblDjSo4XqrGC9IiR/P01zpaRGBC8d+UWkX401ccqSyWMKEYXwacG9sYG/Gy
 rFxIU/90zK4SpUvqF+m2I1FNVe3k4HmW/SWuY/XiSSdkjsgBCqnNdMfbc21tqLAE5RrC
 POadZ/J6/hl4m9OMojyiW73WHKTMPp8AeYGGZpG+mv311cFEKxJYwOTdHMW07BvgNUhL
 i2/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa1nm1jHW9s2o0Vqq3oRNs+T+bUxX9IVYkyHfohWlc/Caz2LCUehG3hOkDz3DlneMFQYvcTYf3Rqtv@nongnu.org
X-Gm-Message-State: AOJu0YwwIjuR1hVNIYtc0UJImhHKIf9Fgu9BZBxFLkkOsg2kAt4iZqkt
 wy3edvuzHEHNEpL+zqRi18EBHI/hPddZAml+kA2HjAopGqoGx2A2INz7Yxycsol9taE=
X-Gm-Gg: ASbGncugYqEsJ4LoVUnCkV1HakLQwqpuZQXH2FU5nMxb0UM7MplzKLBZ8lk8pqPwnxd
 7DisxWqU8rQXYhGdbMZWpj/NBbD+PtxErBVPXBIvOGVHgmL/OuI2e6kqCz4QfgAi8OFS4wDhn4s
 UQqx5AuSXGBFsXknyL3xTrmz2xgmzOVP2M+ufpjw4jlahsKi7xBGsF8JGxT9tPhJJUxcoOoECP3
 /mParbYQ1SnMjguaCG3qmKicAB6MnDbLwvDgnCNAdfpTXoZ0H5r0MCUyluKTSL2SMPLwQTjeLm5
 Y55ieNn7uOU4LMGVuGg1Mp6LIZcQAu7rpMhmGqtp0hrSVmF4KpPaCwia3xIFxR1pAWmR5wmKzv1
 h13d1p98Uj7eu
X-Google-Smtp-Source: AGHT+IHDmfyr/dRl+RQ3e60qohzQTRuBJtZ5OdJuNCC/AzPGkx9rlKpPCM5q7edkEcqz8yKJ5BNiVA==
X-Received: by 2002:a05:6808:6905:b0:3f8:eee4:7140 with SMTP id
 5614622812f47-40646802306mr9903336b6e.22.1748442325796; 
 Wed, 28 May 2025 07:25:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60bd9c35479sm194134eaf.24.2025.05.28.07.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 07:25:24 -0700 (PDT)
Date: Wed, 28 May 2025 08:25:21 -0600
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
Message-ID: <20250528142521.GW100073@bill-the-cat>
References: <20250528123236.1138632-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s6I0JLWs7/f7a4tv"
Content-Disposition: inline
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=trini@konsulko.com; helo=mail-ot1-x335.google.com
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


--s6I0JLWs7/f7a4tv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 06:32:02AM -0600, Simon Glass wrote:
>=20
> This series adds a standard way of passing information between different
> firmware phases. This already exists in U-Boot at a very basic level, in
> the form of a bloblist containing an spl_handoff structure, but the intent
> here is to define something useful across projects.
>=20
> The need for this is growing as firmware fragments into multiple binaries
> each with its own purpose. Without any run-time connection, we must rely
> on build-time settings which are brittle and painful to keep in sync.
>=20
> This feature is named 'standard passage' since the name is more unique
> than many others that could be chosen, it is a passage in the sense that
> information is flowing from one place to another and it is standard,
> because that is what we want to create.
>=20
> The implementation is mostly a pointer to a bloblist in a register, with
> an extra register to point to a devicetree, for more complex data. This
> should cover all cases (small memory footprint as well as complex data
> flow) and be easy enough to implement on all architectures.
>=20
> The emphasis is on enabling open communcation between binaries, not
> enabling passage of secret, undocumented data, although this is possible
> in a private environment.
>=20
> To try this out:
>=20
> $ ./scripts/build-qemu -a arm -rsx
>=20
> This will build and run QEMU for arm64 and you should see the standdard
> passage working:
>=20
>    Core:  49 devices, 13 uclasses, devicetree: passage
>=20
> This series is available at u-boot-dm/pass-working
>=20
> Changes in v5:
> - Add RFC for test script

And this is why I question if you are working in good faith. I've
rejected this countless times. I'm still rejecting it. Stop including
it. Point at the version you could easily be maintaining in the contrib
repository where you have write access and no one will be telling you to
not do something. People would even review the patches since it would be
against mainline.

--=20
Tom

--s6I0JLWs7/f7a4tv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg3HNEACgkQFHw5/5Y0
tyzpzQv/QAvNLQIMwMNIoNlySjMBTRKDsdEucnkSGWEE4bSazKS8NUXsereQpKSG
5oDQe6KQNIuQLEUF+fcBDnvy8gaDfW6iKtrXku3jqrLIMRpgTWsulHlEqSjJ+2HS
GcUpeKSDwftsVs3L+c1HN/qXGbT7v1oBuSUPc0PBTviJ1ITjBblokyGvx/u/UWFr
G4um65qj/NgEjGREV8SCuoV9hA/L5QLjXrSe/nzz3WKLcTKt/el0FF0b3SRIageT
Us3WJYIwPLo3RJeQT/7n9gdmZn0Xs63mWgJqd3yUqvP/pmb9e8z+rHC+HMC3c/Ez
RqrjDxzswBhDNjGjPW0eogtJWagzOCXptoFesV3iGOVFgOc56g1WaHeXeMM8Eejx
j9Sll7c1HNoCBj52lihpcpsgPMmVus3Xdk+ePyJWLtqXPi8h20/mXY7Aontkp83X
ZPrnovhA5VTKit9aqPnH9+XRSkqsUJcy96zS6z0ZoN2ow38GRiY8f+RzPwIKSPnx
/JbMx5FE
=gcjb
-----END PGP SIGNATURE-----

--s6I0JLWs7/f7a4tv--

