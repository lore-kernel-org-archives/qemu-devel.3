Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFB0CF34AD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 14:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLjDc-00051r-IA; Wed, 19 Nov 2025 09:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1vLjDZ-0004zZ-4E
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 09:31:34 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <trini@konsulko.com>)
 id 1vLjDU-00032R-MN
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 09:31:32 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-44fff8c46bbso1602212b6e.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 06:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763562684; x=1764167484; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=juJufiVkNVO2fkZQKEFEqUyffa2E5TbTGhz7j7yDR24=;
 b=RG14oxH/HD9q16I0s7rZY8Q87SHIHSbobLLejycUPDIvT+qGSnSON9CryDlgEXG611
 Z1vyZL6L7rHqAPeEfhvFwoYgbI18Q4DWUQeNpu1l6SsHzDGlXY2G3Q6GQyB0OD9m913p
 BDv6lTuWfh15ViWNdRx96o6uTI3STf6hDzpMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763562684; x=1764167484;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=juJufiVkNVO2fkZQKEFEqUyffa2E5TbTGhz7j7yDR24=;
 b=Y3ycbX9IKsF80dJwlU4uSVCvunEbaXBgf3nxyTPUHwJZ7pN+6XD3RSct/BxDnGzVFJ
 qYAeStRUmopbezpKCgIKzV9fRb9GLg8exlUCMvZc+nki7mfXJoz9s9H3AeHwxjvn6ucy
 FhmkQ9Il18Pn+c/iiGDzNUY157ZX7kiz4ya3NxGzVKTjxxK8zFgmyegTJorIyCkNpIRJ
 RuKLGPd4PfcYl4bGKB0XaVINq/ecFJosqz9bpKxsx9wd61sp7Ql0mevI58z8LwOH8mbI
 SmHgS3ozhTrOewozdBT+UtPJ4gXjKnmEx3hHcjusb84BjaNHL7MfkOchJru9PhEsOWYM
 5u7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtMq4XGVze1jPIIjSIELIWcgQyVDL/B8pH8FG805y9nNIjV1HDgeJjAG5LsgtwyGeI0/as5uYBTIaR@nongnu.org
X-Gm-Message-State: AOJu0YxlxMlGDjpNQNupu6OXtRgNGQoi/W3ES38uz2w2UV7N/ZQPYrWg
 /ji12M0MIK51OQGt3lQyPWDztscudOHaHtSymlCH/opkNfskHiutgyfV5CvR5ghBVGc=
X-Gm-Gg: ASbGnct1ZqZLGr9ilIlsAECmG9p2ItVmnivWQLdBxos3VZVjL/Yp+oJS7lVARM312vH
 HY02Q53IN29hwV8CRQ+FHJvxgfFNvLo262nLWI4ZHSIAEQhIJcm/WQPUtNd2tgmjJTMkU0lqYyg
 XX2EaER9wUroO14rHZxym7rJw7AJxi8XfEfSeIyjoVrp8BfV7xMSZo96+jAmLBtKUtK1yiJvJhg
 pjHslk5Jaacl0fXTLt85ue9CqnLB+IUUYVlKJ3HbkLEpJ3rbBfa28qgJk3Ohbt/UsYhnZPQZRor
 xRwnIEl7QQUKkjQFmtCsaSe+isTDf7lWSBYhSg7PQOSw1KcjUYzvCBgrXM3E/fApTzs+bMfSd2q
 nvfxqHovmcqaFYF9E5bhn00UDxwS9iiDL9+2OWdVXOWsjka3HB47UdOi0EaNKvudL1UrJtWZ+dl
 YNfitZjVRqgITikIBoKLMb9uK0ZCHSsYUhvNjMud7GHISzb5+CZQ==
X-Google-Smtp-Source: AGHT+IFhIZiOPo0mvGeDZt7Oq/cmLQDtTonUE/wmAbyfwo0OJlyrGuMMROFUfJeRCbD5QIBIjpgIiA==
X-Received: by 2002:a05:6808:1495:b0:450:d143:b77e with SMTP id
 5614622812f47-450d143ce1bmr6428246b6e.58.1763562683764; 
 Wed, 19 Nov 2025 06:31:23 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4508a6c1510sm6195924b6e.18.2025.11.19.06.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:31:23 -0800 (PST)
Date: Wed, 19 Nov 2025 08:31:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Bin Meng <bmeng.cn@gmail.com>, QEMU <qemu-devel@nongnu.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH 0/2] hw/sd: Fix broken ssi-sd implementation since v9.1.0
Message-ID: <20251119143121.GZ2125796@bill-the-cat>
References: <20251110110507.1641042-1-bmeng.cn@gmail.com>
 <88dae27a-e6c1-4c83-8b89-0f1d8bda4dd0@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dD6MBNoBe256Wuv1"
Content-Disposition: inline
In-Reply-To: <88dae27a-e6c1-4c83-8b89-0f1d8bda4dd0@tls.msk.ru>
X-Clacks-Overhead: GNU Terry Pratchett
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=trini@konsulko.com; helo=mail-oi1-x22d.google.com
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


--dD6MBNoBe256Wuv1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 01:44:47PM +0300, Michael Tokarev wrote:
> On 11/10/25 14:05, Bin Meng wrote:
> >=20
> > The U-Boot community reported a CI failure [1] where the
> > `sifive_unleashed` target failed to boot from an SD card after
> > upgrading from QEMU v8.2.0 to v9.2.3.
> >=20
> > At that time, the issue was traced to commit da954d0e
> > ("hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)")
> > which was introduced in v9.1.0.
> >=20
> > Testing with the latest QEMU mainline shows that the problem still
> > persists, although the underlying cause has changed due to refactoring
> > since then.
> >=20
> > This series fixes the broken `ssi-sd` model. After applying these
> > patches, U-Boot successfully boots again on the `sifive_unleashed`
> > target using QEMU=E2=80=99s `sifive_u` machine.
> >=20
> > [1] https://gitlab.com/qemu-project/qemu/-/issues/2945
>=20
> Hi!
>=20
> This seems to be a qemu-stable material.
>=20
> The refactoring mentioned above happened between 10.1.0-rc1 and
> 10.1.0-rc2, which is quite a hot spot for a refactoring.   So the
> changes are definitely relevant for 10.1.x series, where I applied
> them already.
>=20
> But we've 10.0.x series which supposed to be long-term support
> series, where we have the problem too (since the issue were
> introduced before 10.0), but the 2 fixes here don't apply to 10.0,
> obviously, due to refactoring.
>=20
> Now I wonder should we fix this in 10.0.x at all, should we
> create some unique fix for 10.0.x, or should we pick the
> refactoring done in 10.1.0-rc stage, to 10.0.x?
>=20
> This is the original refactoring patchset:
> https://lore.kernel.org/qemu-devel/20250804133406.17456-1-philmd@linaro.o=
rg/
>=20
> The patchset applies cleanly to 10.0.x, with these 2 fixes on
> top, and the resulting thing seem to work fine, so far anyway:
> https://gitlab.com/mjt0k/qemu/-/commits/10.0-sdcard
> (and with local tests, including the test in the above series).
>=20
> What do you think?  How important it is to make this whole
> thing work in 10.0.x lts series (including distribution(s)
> based on this, such as current debian stable "trixie")?

With my U-Boot hat on (which is where we found the issue), it's not
critical. I need to get us in the habit of "do a release, upgrade
ancillary tooling we test too" so that we find potential problems like
this much quicker. We should be, but aren't, on 10.1.x already for
v2026.04 and on 10.0.6 not 10.0.2 for v2026.01.

--=20
Tom

--dD6MBNoBe256Wuv1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaR3UtQAKCRAr4qD1Cr/k
CkZWAP9zv7+bLY7RoYm340a7etf8H+gY+MPD2J5P3pVe7XMJJQEAleK/R54TB2pI
tT/sAgAvP2Xc5+PXp9K/YAW0sRUOPAU=
=IIRV
-----END PGP SIGNATURE-----

--dD6MBNoBe256Wuv1--

