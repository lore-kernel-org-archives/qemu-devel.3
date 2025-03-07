Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7071FC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 14:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqYbR-0007H1-AR; Fri, 07 Mar 2025 09:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1tqYbP-0007Gm-Gp
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 09:23:03 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1tqYbO-0003tE-1Y
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 09:23:03 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e53a91756e5so1542545276.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 06:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741357380; x=1741962180; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KIvYXF9emjqCuYP63hp9hk40m2VUXYGZv3p6HcXeHTk=;
 b=Npp73gGLgKlk/SDOSuhbAq7l8iE/oZTupWt0kO6Ti8PgzF2amXqxYtRJwRJezYhgS/
 XCF4rc4fmZCWD2l6IdQaHvaZZEff9+UJRaFlGBv21v7mzcKVV31aC5E7qZUDy5M9p0Tf
 y9IZf7fEsBlJ+Ilg3o2c3DxZfLKzqM1aLguKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741357380; x=1741962180;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KIvYXF9emjqCuYP63hp9hk40m2VUXYGZv3p6HcXeHTk=;
 b=GnAZZ/VJAYzTIOyHvtRdA7IESCNC+xMJ1zW3CSA0f+hNI4siHwMv8NEp8uhby4NLIk
 pj7Oj3m1j7t6pVsPLAnzeNhms65zGPsbrB3LVNQCkTGwdgftFTdYG1hO7f7ehOFrgNJH
 ONU/LQF80H5aZUgZs4UG7KsfncUeIZ6CNHNBvedLfLRKI57gUAn927LILKf7xcSYsH2a
 e8o2xl7rnkP+dtBv4aS81AhH8dul32ZY8guRSHKfB+6LgPcQPPHbR8hGdmLPYrw6ZxNK
 XpupVHXMiuRUMSm1ccTSWBQAvitffff/oHpGJCaOG2wZCQF2kqHUoNxSuO6bMKk1dWzp
 QM1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUqw3hx7Wv/b/gmjhdTVRVO32e/8CZ+xxlKg99qAVs4sTkrk6vVVToOeGRbEhKVwZeY8N2CLpC8p40@nongnu.org
X-Gm-Message-State: AOJu0YzN7D2/KPtyWX7nEPbTm317uGRjWv9FW49Sr+WlEOKXuROE9qGY
 z/I6J8k3l3DHqXTSX3Jg1nNH1q3e8j8hThLCBzBvvTcuReRk0Dt2EAuwwOhcE7g=
X-Gm-Gg: ASbGnctKNS9iybAYu63FUs+lgWtozzDlsyWMIhF7M874WNmS/fol9iRkpW5GHCn/bnr
 da9JX4X/9wcV+I0I/0jRdXN9c5FrWH4Fb0MpqKsurvPOWf2OxIz2mMpBSsuRQO5NdYbTRWD1o0r
 qsXZSvuW3Gb7wEvJys7ofqvu37KmziUEjtYXI6YdKdAy1bhz/keJ/JO5cCuksiUGeWYS/59Ws9M
 XIOsPawES5D95k4+urHRAvROId7XNgnTYX/i8ZSlgdt+kjxugh4+YWm2cXOQaUO74EUErHzEZ1Q
 gUwhN+xKwxgn3JjMp7/WJRiYK6CGjoFG6zjn95pWH96fVg==
X-Google-Smtp-Source: AGHT+IEwfO3SCfGR8JTwnypQ7c1K8e5E9yx/FK2eyPLNbqQknJZvJqri4d1bEFPO/uS+5ug2IOkT4A==
X-Received: by 2002:a05:6902:2884:b0:e5d:e23d:5603 with SMTP id
 3f1490d57ef6-e635c1c40b8mr3531534276.38.1741357380086; 
 Fri, 07 Mar 2025 06:23:00 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e634b85493esm803485276.26.2025.03.07.06.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 06:22:59 -0800 (PST)
Date: Fri, 7 Mar 2025 08:22:55 -0600
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
Message-ID: <20250307142255.GL2640854@bill-the-cat>
References: <20250306160428.3041057-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gk0dqMtvAFAUNhfe"
Content-Disposition: inline
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=trini@konsulko.com; helo=mail-yb1-xb35.google.com
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


--gk0dqMtvAFAUNhfe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 09:03:27AM -0700, Simon Glass wrote:

> U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
> is not perfect.
>=20
> With both builds, executing the VESA ROM causes an intermittent hang, at
> least on some AMD CPUs.
>=20
> With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
> is done in a way that works on real hardware but not with QEMU. This
> means that performance is 4-5x slower than it could be, at least on my
> CPU.
>=20
> We can work around the first problem by using Bochs, which is anyway a
> better choice than VESA for QEMU. The second can be addressed by using
> the same descriptor across the jump to long mode.
>=20
> With an MTRR fix this allows booting into Ubuntu on qemu-x86_64
>=20
> In v3 some e820 patches are included to make booting reliable and avoid
> ACPI tables being dropped. Also, several MTTR problems are addressed, to
> support memory sizes above 4GB reliably.

Do you plan to rebase the prerequisite series' this requires so that it
can be merged?

--=20
Tom

--gk0dqMtvAFAUNhfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfLAT8ACgkQFHw5/5Y0
tyzWUQv/aBQH/dA1/o1urgt8WrBqX/d9HQj3wotUJRB0gsv2MH9MEumYFmfl244o
b6MIs4BwYjl7xIA7zgK0Su6qg1ltDBREahic0ykiyxcS1ytUxsZ3s0I58g9jZ2tY
mRjmJmnVqQqomeoG0d+6wpC7r56fI3CUyhbel33X3dEUgI8ZzQQCIiru0o7ZH9h2
fZNM01c9u6F41qb1rCmcMpMJlyffn1No/b2dlxPcWeRuKp7um9HExVlW1jMZCL7n
o3DvPiX3CIwof6m8GEBZ6O1U8Rq93oWfbl1f/PzUX6aO7ETYUR76w6dJ8l4a8oVb
KLXpnaBKMX7joy0QPIkfds2PJdhG4zaWIwfFvK3lx8skazaa8vqkk34m7yzDLw9M
juVt4y+o0EzxyaU7FSJlIbVn4s98nbY0pJ1W7CcRu1vfsjGiftnWrDgfi9+pBPwe
DBQJISbE6+yVz9aKjiWoz3WpcV5mgDbr0dRFq+ts5Ji4vljiBawVim1AxnGfn43v
wBNk9f2X
=2V4Y
-----END PGP SIGNATURE-----

--gk0dqMtvAFAUNhfe--

