Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4298C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 09:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA3WB-0004cW-AI; Wed, 30 Apr 2025 05:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dfaggioli@suse.com>)
 id 1uA3WA-0004c7-3P
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 05:14:14 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dfaggioli@suse.com>)
 id 1uA3W8-00017C-1Z
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 05:14:13 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5f4ca707e31so11695081a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 02:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1746004448; x=1746609248; darn=nongnu.org;
 h=mime-version:user-agent:organization:autocrypt:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=mPHldffCJf7IAATP0SIHOfLFo50VQSaNS3wu0paWj+0=;
 b=gPukyacfYsjaOyW7YfGAGm5BVTFrMhz3dQTMJpux5RXG8M2geDuyNCHYfxXDhiBN8B
 6BFsoG3pTPSm0ly2egCIuoMNPvqdc+6Nu/6Pk93BCH7iPB4yH/tT+dpFBfSpzpa4Uwoj
 YxwNrmXTPuwsiXW6AuLg43gemRTFZsp0jsBmO8AcCFVDzMZgfChqdO9vaWo2f+D5Esp5
 UhJRSYuRGhYXsvRGoYQEypaGSHhqJ6mcG7lr+zECujsaQ0d9yjeuxgqpZg6ok81nKYx6
 JuoPgcCcBpY1itG3qGIZQTKTNgm+ouYf/neIB9pjAfT3Vw2llnTOb9zN8ZyvJqM4Fwy4
 Sl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746004448; x=1746609248;
 h=mime-version:user-agent:organization:autocrypt:date:cc:to:from
 :subject:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mPHldffCJf7IAATP0SIHOfLFo50VQSaNS3wu0paWj+0=;
 b=A6Ayx/1fPW7o9S+0289E0IqaPUEGMLzxwcM7+KaScCvHz/HfuBTYUqb3jK9wctB22e
 EOUuO6sHhQ9uyvyKlkakmvEZYJsGGJHdF1NbN1jy8Gt/WlGyFb0tXC9NWiUMZ0oFeFo/
 vVO3ejDM9tCZl/hG30lVV5uTd7loW7xMo0aM0qZAyScoUqxG0JELthDJkXXnVbDmPCSY
 FbQwjxtPKPYh6vozuAA+GTESsWe5CToJWDlHGTtwM2JqVvZjLxW7VCffdOKwt1GGCQf5
 OCCP6aftc4Jf77mPWwzPNFO7rygNvQfO2fWVqqBcx25Ne2yeovR9hkTQ6u/Z1noEDoXd
 VRBA==
X-Gm-Message-State: AOJu0YycKdwKovabjk9yFvHP1WxInyGag3olRzw4Ss/E5c1YpFDJmtjK
 prqvGU+Eao4Inzf8Qbw862t1mFL7o5F9RSFeC0o4QayGqsaaRe0idENsMmekBvMZugNmJ/dlN7h
 v
X-Gm-Gg: ASbGncvbKV/3X2qcTeESKOrNnz/0eVrg6r3Coumf3OF9r1xcp6fht8pmT/xZ/ssyEjr
 pdP3/pOOeoxTVYEopUpagcaus3dWRyWggXgytuaBoOBnQJAAPvH/CF1KmDwvpaO2c4Fl1lj9aQL
 MSlZ2GH92NzDOQFJ0QYgmGuLNajN3E+kh0jCDhrUaG7MD3+v3FD+vvHC5lJzWaqzEiYqEjOpIAT
 cIQQEfca/ADe+HJXwepRPXMTEU8x1gVmNd1KCKknBhnebLmJfEq0lckaJ+r8CSOOB4Qr5EBtrWN
 paSvxZPTjopEtYW5WrBu0fMcxEyMLConra1DcKayaKodQCrgfxRVhwN8CUBAiOXJEltRXZcvb+M
 =
X-Google-Smtp-Source: AGHT+IF35CYaNEz8Y1O5hde5ppHPnIwqxLjOG+QHHOyv8h7ziM/BVsV22NEZfQ1XltMYKdajz/AcNw==
X-Received: by 2002:a05:6402:2152:b0:5f8:d490:33c5 with SMTP id
 4fb4d7f45d1cf-5f8d4903d09mr389610a12.33.1746004448248; 
 Wed, 30 Apr 2025 02:14:08 -0700 (PDT)
Received: from [192.168.0.30] (87.78.186.89.cust.ip.kpnqwest.it.
 [89.186.78.87]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f7016f66b7sm8688234a12.46.2025.04.30.02.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 02:14:07 -0700 (PDT)
Message-ID: <419c09dde7ca8a538f07e259a1cc3bbb4788f3ff.camel@suse.com>
Subject: Problem building (docs) with -j1
From: Dario Faggioli <dfaggioli@suse.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 bwiedemann@suse.com
Date: Wed, 30 Apr 2025 11:14:06 +0200
Autocrypt: addr=dfaggioli@suse.com; prefer-encrypt=mutual;
 keydata=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
 fkAJ0OEQQ==
Organization: SUSE Software Solutions Italy S.r.l.
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-plMwut0xSgxMCvkycpcT"
User-Agent: Evolution 3.56.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=dfaggioli@suse.com; helo=mail-ed1-x530.google.com
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


--=-plMwut0xSgxMCvkycpcT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

When building both v10.0.0 and master sequentially (like -j1 or
equivalent, e.g., when in a 1 vCPU VM) it fails when we get to docs
(`make man` is also enough to reproduce it), with this error:

  [1/2] /usr/bin/env CONFDIR=3D/etc/qemu /home/dario/Sources/qemu/suse/git_=
upstreams/qemu/build/pyvenv/bin/sphinx-build -q -W -Dkerneldoc_werror=3D1 -=
j 1 -Dversion=3D10.0.50 '-Drelease=3DVirtualization:Staging:10.0 / openSUSE=
_Tumbleweed' -Ddepfile=3Ddocs/docs.d -Ddepfile_stamp=3Ddocs/docs.stamp -b h=
tml -d /home/dario/Sources/qemu/suse/git_upstreams/qemu/build/docs/manual.p=
 /home/dario/Sources/qemu/suse/git_upstreams/qemu/docs /home/dario/Sources/=
qemu/suse/git_upstreams/qemu/build/docs/manual
  FAILED: docs/docs.stamp=20
  /usr/bin/env CONFDIR=3D/etc/qemu /home/dario/Sources/qemu/suse/git_upstre=
ams/qemu/build/pyvenv/bin/sphinx-build -q -W -Dkerneldoc_werror=3D1 -j 1 -D=
version=3D10.0.50 '-Drelease=3DVirtualization:Staging:10.0 / openSUSE_Tumbl=
eweed' -Ddepfile=3Ddocs/docs.d -Ddepfile_stamp=3Ddocs/docs.stamp -b html -d=
 /home/dario/Sources/qemu/suse/git_upstreams/qemu/build/docs/manual.p /home=
/dario/Sources/qemu/suse/git_upstreams/qemu/docs /home/dario/Sources/qemu/s=
use/git_upstreams/qemu/build/docs/manual
  /home/dario/Sources/qemu/suse/git_upstreams/qemu/docs/system/qemu-block-d=
rivers.rst.inc:506: WARNING: duplicate label nbd, other instance in /home/d=
ario/Sources/qemu/suse/git_upstreams/qemu/docs/system/images.rst
  ninja: build stopped: subcommand failed.
  make[1]: *** [Makefile:168: run-ninja] Error 1
  make[1]: Leaving directory '/home/dario/Sources/qemu/suse/git_upstreams/q=
emu/build'
  make: *** [GNUmakefile:6: build] Error 2

It works, instead, in parallel builds. In fact, building with 2
processes seems to be already enough for compiling the docs
successfully.

OTOH, v9.2.3 works for me, in both sequential and parallel builds.

I've tried to remove the `-W -Dkerneldoc_werror=3D1` arguments from
sphinx-build and that "resolves" the issue, so I think the problem is
the "WARNING: duplicate label nbd".

I've tried to check for the reported duplication but I see the nbd
label defined only in qemu-block-drivers.rst.inc. It is, actually, the
case that the file is included in two places, but I don't know enough
of Sphinx to understand whether that is legal or not:

  system/qemu-block-drivers.rst:.. include:: qemu-block-drivers.rst.inc
  system/images.rst:.. include:: qemu-block-drivers.rst.inc

How can we deal with this?

Thanks and Regards,
--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)

--=-plMwut0xSgxMCvkycpcT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAmgR6d4ACgkQFkJ4iaW4
c+6xcxAA3m2ZlRrgRn7TjZLQEmL6nw0Ova86t5UO/CsLxcrX+HHpxNWlzjCb+85t
aFT6fiP1/ukH82m7V0t9pfRVxs+nxjDZxWuSfEMqwJq8qhhUjaqOZpUp38945G8r
OYnBq3t40BbCvaPbVDZVVoe+zAy7ZfJ71Dset7UV2eJLsqUEBvkgnAztW8GjTTKA
GgHKm6K7rkjvAbdNQWIfBs56zJtGbBl4qdYX+bz8IL3hEdD6p2kBKrVkvA7OLF6Y
DXI2K62v8jztFeCT/GgeHsttxtWHfB4qHhJ8+Qi+Is3dgmvkB54Z96Z5MWHMStNt
uG2rvGxeATnKCfkkS4dGU6lk7tiZF/JvVazKjOxnCuKinmJxP+NeMiLMCwa/onq1
sfm73FHEmzqfMPqJX0o/f/Y7Ju3ZKlu0g+zN049LOduS31fXkOsXAU3yKVMaCpd8
7N+nL5hZH0m3G10/BNjp0axXY3ySJPbToQ8CrcO8BU5taYGDLYh5eqaLGF494HLD
p/BYBnf/cC42WgqzimimuwawlTcryur7rLBJIy9C8zblSTH7Osc6rZvJQpYCo1jO
0c0T+DgAj31fNcau9yZH2XorWZgWoU+fGz9DWcZbZiiBSIXDNfGqt+sBU/j7XgEJ
Iox7tLBjAmYizye/FsOp6xhMsvIgRBU7tPYJk6p/7AocIQzdKNY=
=22UH
-----END PGP SIGNATURE-----

--=-plMwut0xSgxMCvkycpcT--

