Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54886C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 14:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u14Yw-0004C6-D0; Sat, 05 Apr 2025 10:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1u14Yu-0004Bi-S3
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 10:31:56 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1u14Yt-00072X-6s
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 10:31:56 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-601ff283d70so860908eaf.3
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743863513; x=1744468313; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=unb8GKjm8qvtr7GVPoUVbGjZC4UDuiqHDLGdnKJrU0M=;
 b=iCcptdxnE5ajcwLK1hSTNCnVry+8315ONNKS8fld6N7T6F5spFkJfeZ9btXzj3r5z4
 +y0NCmjKF9WeZW4LKVJDtFFpG+NZ+kzHOrJyOfwRryDvypUvqPtqH/Vhkkz0zFMdbo5D
 sTvVPZl4ZNro+6ifgi/U5r0bi7d4XFvuGF0qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743863513; x=1744468313;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=unb8GKjm8qvtr7GVPoUVbGjZC4UDuiqHDLGdnKJrU0M=;
 b=v0I3LBow/udFhll0V+6df4SDir6Rz993ynwuSIz1SSf6ndLZcp7OoaTAuh1b2M5kr/
 FT3wmvhsQ7/jseIL/1cZDu166HxK4F4TZMgRnKxyGk+LaHsakeW8XbrB1nqoaJK2GK13
 xp4IlVB5qWNwhNcvGhBDo1p6NmnGeqQvi37PHjHJDIjfjRctMzCqnMcn50z8cVrFvmwn
 LTPDGYgJ3NEQimpU+5x0duxV9sWYNfpjQFTN4r0nCqAru4VoPxIpoGQJdwcbFdoX5DvP
 5am8l3jqi+psmyxSWu8IURA27RF+3Nxv/gbpFwC5DIXgKZlMeMwTqSIn+P425K91kUIA
 FTBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp23fq/iEy325Py2KSES2P9Pth86LpA4xvvVRP/QHUMT+PzIcN8k3PQTawvuMDq3Ye1nb8UbJufGtt@nongnu.org
X-Gm-Message-State: AOJu0YwqouqbaZnafpCCB2Mq2zGof/imBoQgur/QFZ24bPDe8Q8EJH0u
 B6uEhgbsKeQWgNXo7w2D0V3/6amzUL9h46zisNzs2TSEWCa6Trta6Wk2lzBTZdU=
X-Gm-Gg: ASbGnct/twwCiT9/jY/JbHmXutprtQkzhneO+2il/Ulw12gzt49LTJOiUzEl9peOlqb
 skLY3U/vGDfihwsrJTeO3vPJOwMCJ4EEQtdtDakV+T243jEocwR/4mJrLSIc53kC2fGfij91ws2
 AaqU5soBb9u69JjM5n6lYMijeohyct+57y3gN0BXRmQOqj5H/j6DerIl1oUwsgDl44kOcJmprTm
 aJd6e3965ij4292Hnc/IIkUi2oqqFHljsuvtJRNsuVdDgdY+s0U3cVK9Wyrxx96V6GEjduWcx20
 PaI9ys/cfWGKAh2vOmmvCrBObB8atEPL9tiPmz3ipnq6iR1iRXhfHDte9r6VAXxJkd1keUdqifH
 bpDzYsw==
X-Google-Smtp-Source: AGHT+IEHhZN6J7cMHyBtXTSAuHht1mUBppR84T8qSfS3kOej08ze3i1SnF8B6zxxE+HKAnXeyImBnw==
X-Received: by 2002:a05:6820:1ac6:b0:603:f29b:85b4 with SMTP id
 006d021491bc7-6041639bd15mr2916646eaf.0.1743863512732; 
 Sat, 05 Apr 2025 07:31:52 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6040c4ea9e1sm1059806eaf.17.2025.04.05.07.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 07:31:51 -0700 (PDT)
Date: Sat, 5 Apr 2025 08:31:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
Subject: Re: [PATCH v5 00/46] x86: Improve operation under QEMU
Message-ID: <20250405143148.GX5495@bill-the-cat>
References: <20250315142643.2600605-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yYCEedz0XRXU8nYz"
Content-Disposition: inline
In-Reply-To: <20250315142643.2600605-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=trini@konsulko.com; helo=mail-oo1-xc2b.google.com
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


--yYCEedz0XRXU8nYz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 02:25:20PM +0000, Simon Glass wrote:

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

For the series, applied to u-boot/next, thanks.

--=20
Tom

--yYCEedz0XRXU8nYz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfxPtQACgkQFHw5/5Y0
tyzfrgwAt10p3arx0ZiQQB8hiKyYxJF1WAbAfVXDsaco+d1ywW25s+Ytn5RXhGiz
boCbW0lT43638L94t859EV3ieMCeIyGulSSTME1ULtnYkXiMQoWRchuAbkXPCPzr
+LP29iCFmaTpgK+H/AOSjrXGpfFJdcOst6TtoQjyknmM7dhbO/cFTtDyH0ncjca6
2CEgSh9LP9elkZQ13IElgDHTJgOZBgYGqEBu8mEbdTN8Cz5UAMRB5Ta9raNH3hiR
XkALQ26gEjlXTWh1fnNPJXEBGY7SGtEaC+nwG1AXn7YY9WAt92CeZ9uYwkdfKR0I
AkEDxVtBo2np+vIxPuTzuxGilqLJaYbNPa5X35lLex9zmGRP9fgA9ervSobq3gua
YR0A2C6WZBRyCzwR9spdJn/9oJrh4MIUzKlssSE4jpcZUFCyXIuo7OSA7k+dUH4a
HP8dIVnY6uWgPv7JUwTZu4etfnKpeu4YTdSpRwc80etlZ1eaCS9/zPY85z2IOGWt
KD7p20lG
=vJiQ
-----END PGP SIGNATURE-----

--yYCEedz0XRXU8nYz--

