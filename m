Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E34E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 15:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLOd9-0004r0-0M; Wed, 11 Dec 2024 10:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dfaggioli@suse.com>)
 id 1tLOd7-0004qi-8B
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:28:01 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dfaggioli@suse.com>)
 id 1tLOd5-0000DY-8x
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:28:01 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-435004228c0so30268105e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 07:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1733930876; x=1734535676; darn=nongnu.org;
 h=mime-version:user-agent:organization:autocrypt:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/EM9BcU/0ML5fsUhSgqDL22asp9FS9Z3TFMw7SunoOE=;
 b=HntPUjW7AtKkfphMCSPJb7bSCwWPzkOsebnDrSAlzF1p8MZXr9I81VQ3E1fQXTectb
 5Zvq3OsNV6bLq6n26aJpu75KqUXI66F6KOfle+Jezvm8Mt4P94H1eynZjSCW7BsbzLQd
 nwm0VQ8DqSZ2NUcAdPoqTm6VFCcDx12Q65gV/xG6XOWEfyI3O8+pn1eMr+/a1xqu547m
 3QLdmJoXyOaHwyGMMxUkehOcNKl0f8dmHi5tDgEL97OmV0GPGqOoa+AIINKoqq9BOdNv
 aXGmO+NXRygPntQ0V/axIlpu2RS2nF5niJWr7L76uQ6QqwLzPBZVk6Lf8gazlP6t8HvS
 2hSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733930876; x=1734535676;
 h=mime-version:user-agent:organization:autocrypt:date:cc:to:from
 :subject:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/EM9BcU/0ML5fsUhSgqDL22asp9FS9Z3TFMw7SunoOE=;
 b=fS2cin1nZhFNAndS9vGviCJZRdGnGR/MfL0Ex6tr5RoISlQBbZfpRmtuM3Z3aTX7mj
 2iziMcE5OWDpP7IptRsoHB9EQjSc/DOg1+fdU0NB99ajT+Lw+CIEz4P0fA2NPCFsPDH/
 +vsFwebZ/+GfsKP/INp30HqXigLYKE9+9X9dNftPdRiMSERHHdo7atUO0QieYOIZuLep
 V2eazSvI45PYFtTkrkIqPcj+HpQVmu9fm0+u1Ev9KBRN+qhLHhr+VDddC6HxvCXSR1X6
 EkY/Ri8qQgnL67Bft6gpdv4UqX+SOH5lGxJYW55MMgn43jpx08Uv6wQZ+tyjWb1XWIeF
 xWiA==
X-Gm-Message-State: AOJu0YyIoboCQhHKnJMxuGwRnwWGkXBM3rtNBqJe6E/L1lL7TL9TOe/3
 veMA3BQRv328LNXtiRWa21k7UH9wrEvqmKR/N+POnfSmcPwaT1sf0Lb16Jr2dgnYG2i4uruO47U
 oiXY=
X-Gm-Gg: ASbGncs+M1DmTJ1kKI+upKoriuugbPNbahZi2dd3FZlqyo2L/vNvUeQNE3CuEryKA54
 Lzg1SBdeg5T9h6dhvbk+4xXBzHtw04b8hr/OD03XMJMIY4SQz4tDeuAkiGrbmvcbiSKbGywzF7d
 x/G4AdJ9I/miG9AI9Mg01Cij91Y0jDwO+eiSEqnV8G4YwHDDhsEP8fn8XnjkAZTjvk1QPCbgLCJ
 3jKcqJ0j4+3G2NYYH0bUeGNOdkoxd4QbATqQkhzwf69qjDPTcSPlcyV6klRugOg6cdIxaOm8U3i
 tOyhnFu3TvX30dqv
X-Google-Smtp-Source: AGHT+IF+CiA6S9KoNl0n/M0rWD+fIMDVnEyX+7teMUIMbWmAKUA8t2g4Qr3qZWBUoh6CP1znUWItKA==
X-Received: by 2002:a05:600c:3109:b0:434:a04d:1670 with SMTP id
 5b1f17b1804b1-4361c2b7e29mr31937095e9.0.1733930876464; 
 Wed, 11 Dec 2024 07:27:56 -0800 (PST)
Received: from Wayreth.fritz.box (87.78.186.89.cust.ip.kpnqwest.it.
 [89.186.78.87]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878251dee1sm1496538f8f.102.2024.12.11.07.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 07:27:56 -0800 (PST)
Message-ID: <23260a79710e2c302028afa401a969ca9cc389f9.camel@suse.com>
Subject: No display in Xen PV guests: "This VM has no graphic display device."
From: Dario Faggioli <dfaggioli@suse.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?=	 <philmd@linaro.org>, Paul Durrant
 <paul@xen.org>, Anthony PERARD	 <anthony@xenproject.org>, "Edgar E .
 Iglesias" <edgar.iglesias@gmail.com>,  Charles Arnold <CARNOLD@suse.com>
Date: Wed, 11 Dec 2024 16:27:54 +0100
Autocrypt: addr=dfaggioli@suse.com; prefer-encrypt=mutual;
 keydata=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
 fkAJ0OEQQ==
Organization: SUSE Software Solutions Italy S.r.l.
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-X3Bzke3B260cxcLEJz3c"
User-Agent: Evolution 3.54.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=dfaggioli@suse.com; helo=mail-wm1-x32a.google.com
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


--=-X3Bzke3B260cxcLEJz3c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

We've found an issue that manifests in Xen PV guests. We have
encountered it when testing our (SUSE and openSUSE) packaged version of
9.1.x, but I've been able to reproduce it even using the upstream
master branch.

QEMU 8.2.8 works fine, so something happened during 9.0 or 9.1
development (and not backported to stable).

Basically, it's enough to try to create a Xen PV guest with virt-
manager and the only output of the virt-manager window will be "This VM
has no graphic display device" (while, e.g., `xl console <domid>` works
fine).

There is some additional info in this bug, but not all of that makes
sense (we were in a hurry for a fix, and this is not my area :-/):

https://bugzilla.suse.com/show_bug.cgi?id=3D1232712

However, what I eventually figured out though (through a couple of
bisections), is that if I revert _both_:

- 6ece1df966 hw/xen: Register framebuffer backend via xen_backend_init()
- e99441a379 ui/curses: Do not use console_select().

Things work again.

As I said, this is not my field, so there's not much more that I can
say for now. Nevertheless, I'm happy to try to help as much as I can
(e.g., testing theories, trying patches, etc)... So let me know what I
can do. :-)

Regards,
--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)

--=-X3Bzke3B260cxcLEJz3c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAmdZr3oACgkQFkJ4iaW4
c+6GKw/+LzDm/5h92Dv96ZVSSJlGKAtw3YOiIvVAKIszWgdOZZSECnrHyvhI93JW
XSTGou+nHWlSuAocm81ir1PKzsco/0qEl+oQa9o0jjHtkGd5yHjA++311v9v+WvI
zC4VgTaUn5F3DJEqgT5TnOHK59JJtf5TeNNlEK2zYVcFWzxxflRHNcAuj5f5F72N
+CRHZITaOuT0M0CxK/7DZrbumfHgRQxdAfPFnI5R/d1NIF7Y6Jsc0CRBpXcZCRMV
Z9FQ1M8TaNolhY4AYqjSLBKRPNJvxY4w4z9e4ElJaPbzwMIblVhkX0If3KITuE+D
KB7KxbVxnXtMYCGpTM/cLzz11CBJBeJRNuZEnihH7zq1sN6Ag+gZIsjpoEOMGjJb
qcJb/MM6JpzJjKPwpbyZwpz8c67kzU60lcOJUsJy3AwzX4VRl9xZcnH8QwFXIS3Y
Xaa0+qucNOJBmUbyq4rj9NCEhjGy5AKu1HZHcfle9pbFxeaWqRBNQyJsMzmEOSN1
6/zTkBePgw+IF07s+LvSH4MY5sZd5ff/1EXXZZpNIT5A92zY1+aOMRl0VwIHZfJ9
Tuan3zzMyx5hq280GStU8urLvEm0eTdeJb0+eK2oQ/dMpENwmAy94GPqknUFeOxi
wPLMuKWYmdY7HnsNQwZoQxbjEhmt8V2aa9l/XigjdsO2gzu/dlA=
=FgP4
-----END PGP SIGNATURE-----

--=-X3Bzke3B260cxcLEJz3c--

