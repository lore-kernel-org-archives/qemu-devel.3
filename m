Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7A3C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 16:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt7Yz-0003rv-Hv; Fri, 14 Mar 2025 12:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1tt7Yy-0003rH-0u
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 12:07:08 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1tt7Ys-0005eV-U8
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 12:07:07 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6e8f06e13a4so29826876d6.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741968419; x=1742573219; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3bXIWMAxZplKw7lGSDS09UCMaChdlmyHIWbWcmiQFak=;
 b=cyf9PlWA4Rnh/b+y+Szc8or8Czdee4Bv/SJtvBiqILXPztWsdlmcJ+rDfUWBnoWYNB
 1tK6WezSQu2y7zZM8N7sU2c9CK7PIvYWOAOLP7BgVrLFYPfyG0Kw5shqmu0S4cWw5ytk
 o+GIbldazC28PC8BjDO7LD4vlqvXCtLmCUPYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741968419; x=1742573219;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3bXIWMAxZplKw7lGSDS09UCMaChdlmyHIWbWcmiQFak=;
 b=LMGif3Y+vqyshNSiC8eIkOMCvr/mi82tA+aQu/h+VIDBDpJ70mwPvI/LBTzBk808Vr
 2yguFdX3JOtXVXSctB2I/6A77W82Bwne21pKubuij1p0Ajs+914JWCFHa4cYLsxadyrD
 rWSUEzFpRrGxCwTluJ0P02+kzc01JSKvBM6uODYH4pXZCfrYcHX5iqdSdOBPo/ZhwnuK
 Z9231B+M3x5r7ysFiYE+bhoFQz5Wg1r/gflns86OyPg9dltB05VPa1lhGqlCeDF+rMlB
 vtZ8c10MLvxD9pWfWYYpeQyAOG7EKxaFtalztgq8GacFbUOEvoYIJVVt5QHpUwo9uGW8
 te0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5fLQhD7cKTfxvG3bxyK6laOkYHoM4UIUUwf88zA45RshSDyomjayE3UHSKlDhWMuzmL7zPxRB70tK@nongnu.org
X-Gm-Message-State: AOJu0YyCb4u9fOhf0unmpX9/zqy2lgs5ntU4zFvBaPUhYUS/SIlbXOPR
 llgeLOAS+2sOURb2cc23bfqwqdEX2CmGUI6lWdM/d9prrdAiEhBQh4N4Jb5sFSk=
X-Gm-Gg: ASbGncsmOC1izQ1jdDwzZ3QjBKxXN8masIxdTiZg6b+daqFvX1/8hO6FHcUev6em/KU
 hu91wq1IZuqrxnm/kCYRmETPe1jyRGPbnUO6Neo/Gf6HGZ7SgF9jFVdDRjRVJusfvxumvpWmvbj
 hdrIY5+dSiFctU5ZAGHW849325JPGvEmurauDsL8R4qHLZ4ND1NDb5K0tVAR3taJAoz2YhVlItB
 2kMFLicpGZVc44hjGnIbmDurA5lxBSfWNP6fRuEPu2FkGNTtxfZ7Yki8qdjENir/dp9c9IsE1cf
 5zNYMKUWPoHcYwD6dx3HpxjJS+SyHXOcULEKpZYODOpuuQ==
X-Google-Smtp-Source: AGHT+IEbpvWe/ihnPP3FJ6z5MtB8KQGI/IcDvYGpot8IoY4f1XtuxkSamlrz0+YAUmBlL7n/gOZsvw==
X-Received: by 2002:a05:6214:ac9:b0:6e2:3761:71b0 with SMTP id
 6a1803df08f44-6eaeabde063mr39558596d6.5.1741968418866; 
 Fri, 14 Mar 2025 09:06:58 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade3501ebsm25537636d6.116.2025.03.14.09.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:06:57 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:06:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Julius Lehmann <lehmanju@devpi.de>, Love Kumar <love.kumar@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Philip Oberfichtner <pro@denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 00/47] x86: Improve operation under QEMU
Message-ID: <20250314160652.GS2640854@bill-the-cat>
References: <20250306160428.3041057-1-sjg@chromium.org>
 <20250307142255.GL2640854@bill-the-cat>
 <CAFLszTgtYsVQW-kETzUAdvJvAT6fN_53TeoN7o8wu52Ze3u56Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M0o1PJS62GQK348u"
Content-Disposition: inline
In-Reply-To: <CAFLszTgtYsVQW-kETzUAdvJvAT6fN_53TeoN7o8wu52Ze3u56Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=trini@konsulko.com; helo=mail-qv1-xf31.google.com
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


--M0o1PJS62GQK348u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 02:44:35PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 7 Mar 2025 at 14:23, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Mar 06, 2025 at 09:03:27AM -0700, Simon Glass wrote:
> >
> > > U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but =
it
> > > is not perfect.
> > >
> > > With both builds, executing the VESA ROM causes an intermittent hang,=
 at
> > > least on some AMD CPUs.
> > >
> > > With qemu-x86_64 kvm cannot be used since the move to long mode (64-b=
it)
> > > is done in a way that works on real hardware but not with QEMU. This
> > > means that performance is 4-5x slower than it could be, at least on my
> > > CPU.
> > >
> > > We can work around the first problem by using Bochs, which is anyway a
> > > better choice than VESA for QEMU. The second can be addressed by using
> > > the same descriptor across the jump to long mode.
> > >
> > > With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
> > >
> > > In v3 some e820 patches are included to make booting reliable and avo=
id
> > > ACPI tables being dropped. Also, several MTTR problems are addressed,=
 to
> > > support memory sizes above 4GB reliably.
> >
> > Do you plan to rebase the prerequisite series' this requires so that it
> > can be merged?
>=20
> Here's my understanding of where things are:
>=20
> 1. You rejected the membuf series and my replies to try to resolve
> that haven't gone anywhere yet. So your tree doesn't have any tests
> for that code and still has the old naming.

https://patchwork.ozlabs.org/comment/3473898/ is a well thought out not
gratuitous summary of why the series as it stands is a step in the wrong
direction. Tests are good. They're not a reason to pull an otherwise bad
series. This series should be rebased to not depend on that series. The
tests from the other series should be split out.

> 2. I sent the first part of the PXE series so you could apply that.

Yes, I should be applying that next week.

> 3. You rejected the second part of this series because it didn't
> include support for lwip without cmdline. I offered to handle that
> case later but I'm pretty sure you rejected that too.

That's not how I would characterize it, no. I said you should probably
focus on sandbox + lwip, since you're the sandbox guru and ask Jerome to
do the net_loop-alike thing, since he's one of the network custodians
and the lwip person. I was trying to direct you to where your efforts
might be most useful but if you insist on instead doing the
net_loop-alike part and Jerome ack's it, that's fine.

> 4. This series is now marked 'changes requested' but the only feedback
> I see is in the RFC patch.

Yes, rebase to something that can be applied is a change I've requested.
Because my feedback was "Do you plan to rebase the prerequisite series'
this requires so that it can be merged?". I would have otherwise merged
it by now.

Patchwork reflects mainline status.

--=20
Tom

--M0o1PJS62GQK348u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUVBIACgkQFHw5/5Y0
tyxRNQv+JUfeU9XnoR0ccrvsc10nUJvylokveHpsNTWamOc5xnrCCw6zhoweIFCz
ahtPpa0NjX9iMpafqhi41cIOAAbIn0ICN5F2CKZ5HIVT1f7b7esDaanJU+eB5bDM
u06wuYuvUeWtcQpytnBy4qu2m/udKU8i5H9ppqTStrxkASBctHJH6vI86yxUpSwM
eunQ5Wkj/I16YdO/tnAFcLBI0aR3AGB6spF3Qz0opNER7RNh8kw265QOyGfoMqJL
L/PVi5ThwH98xD1yTWtHPDOAjTAjmezGcRezG66WkAooL+Z/iZyImLnkk4vf1wPQ
XSGJxzMjeb25/Ihf91YDs9JyL77/18Gu4oZIWGdEHHfiDMrv0Z97QXJpRU5gAjhI
hTUOs6CoP3p8EuZR2Fx1IC/FkpF+XumtXGLvuN393ZjwFwgqisqoz9cX7E7BPT4u
hF57ykTWLg+0/0+vpcBoXM87UC67IIN4VarJyqj6/eTWDBfENXgaUnsXVuRzTeVx
6+wbpGLs
=n6af
-----END PGP SIGNATURE-----

--M0o1PJS62GQK348u--

