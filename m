Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F2ACD6E51
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 04:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTYFZ-00088x-Ac; Sun, 31 May 2026 00:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTYFX-00088o-HZ
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:58:11 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wTYFV-0005Fa-4x
 for qemu-devel@nongnu.org; Sun, 31 May 2026 00:58:11 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-36d98b68d68so161499a91.2
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 21:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780203487; cv=none;
 d=google.com; s=arc-20240605;
 b=eRDaPKSE7IKY1slM5ZpZo9xu8iwwn1tXNbxD5Z5re9rHovM31hv+7YIr4DOkZRNZB8
 RqFRZgmOcsoIsw7oaalmHtJ1tA0BtzMbSebURqOoWdH21YFhFt1ieYZ98ZUQs69Qgi4W
 UZxDeSBbjgSvfxz66JNE2VfD6On7ypofNazwxMFLCqxDGDw5p7EIKLxOTo8L8wHV6u9X
 /airjR2E2NDUe+vA5g2/YnYr3RcskWXJfKoSdDP770bIi8SOu3onPR/Htv7Z5uW4p1WV
 QbxN5gudPn5BLIjReJwEmPynPn8u78TLfQQL3M/xIlEkop6gZThVFOWy6mw08cfsIvto
 bQ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=p0giyAhNjbu/r6c/Y9/toWRecSArJBl3oNPVRW1XWOg=;
 fh=+DxRVnEC95Ptxk5HMfIFqaUwIao1HhLaAPFCgZPm1R4=;
 b=B3ABAzj1LV27qiGvotlLRGYReeZQL2FJMrDTfbMIoR3wUtomH8HICgnbDfRmnGrzVm
 H0dIa5VYy/loj98veycJWpYZAsOJTNIrwCE9RtsO6ncFZbPwY9mvOrbASGaN6L28Jimu
 +eopF/qGY5DxiEM/JiLwzH5NMoGdSIb1NTyDsFsbOqn3HiXT1yblukqC2SgOCWCbmW+B
 X1eATfqqJKSKSIG39ToP/lTqc+HBJZmNR9VSgpa88yx1yenby0TKDM5plaIgid8pVYeU
 fRUBGeJ6brcaHpG1/ppFx8fRLgFiwqZbXLwKzQHnrPUxMBbooJdwOg9O4sWRSeT+Ymju
 HpBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1780203487; x=1780808287;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p0giyAhNjbu/r6c/Y9/toWRecSArJBl3oNPVRW1XWOg=;
 b=Y3ek46GJ7wQfIEGCWLqQPoRJ+bF8/0IAUC/u2Z65d5XGzcvRuGmFeDgEi00eJSF+5X
 13xeIjeJo08Kiw5+1X1oO3qG6phT+AScJBeYeJ/cnx1Og4PPztYFJeaQ03Y7ucY+dw0D
 tgEqttQbZ1y6MT8ZuIDkCnALhXnLWwDxlvsDTwj182pTTl4WEotFBLAzeyVDK/utQhfC
 cymqrFYA6gHT76Yozh4TvxBsY2OCpX1ypwfbyiF6todPSdfZRYZr2StOSgu071FUWXbo
 olLZ6x5vxBuEcAIv+k6P11/VpzgOX+ADF+VjE0oiWTRqBOOlaYqHO/N0tPFACCetQBiY
 CcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780203487; x=1780808287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p0giyAhNjbu/r6c/Y9/toWRecSArJBl3oNPVRW1XWOg=;
 b=CRNttUzq1quHdSciSBZnnV4PPsiZELhI93bE0R78ERJCIXdu2AHzhXBWQ7N1LFO8cS
 t1E94+XJMMRUWOIip5TBBuXgWMWeHsmvmuV/LxNgSHo9l9grSdwzgH6iMM2olRNi2jYn
 lBRbV6CSQmWA5nr/KbSxp9AdaH3e1bjlxyB9AWFuJ6klJ5kPCz4FYjpL40tuTnQSv0MN
 BAk+qxZ1FChcfVuRuf01oVEVvaCtxncAVcfij2n/DAhcVHZma3imVwXYycwDz9Alf4Mn
 MvrfGsjtgubjiQPngfMPlymft7g+hqjI6aCpGBbVXZU4Xr9aMneoK0Nt1IMSFAipQx5F
 laRQ==
X-Gm-Message-State: AOJu0Yxa5DgUj9D93W0n+hh2zUtXcoECJPZM6HD0txBmu6K3nWouk2Zn
 NHrQ4zKVzdY6xLE7ebPOur+0g537flCCHZb6Lwx2/eFHPM4zVlLwI/ENWuK0E3dOQ653cPiiwQx
 ioybEeLaLN7/yqsmFS8SnMhcir5rgJvpTQfcsU8BqVA==
X-Gm-Gg: Acq92OHIV46xRaycA3KF1Y1RoEmybvpT1GH7DHwYXgc8PCdrae+cI2qDOZBrLh0zJu3
 XlIKab5SELlBZCTe4iRcMWEP+zGOqtz0/7DYg8Ye9Y9UF21W51Irj7Phen8CZXXM4kSz2ukkimc
 Ft2DBhNHECywZpyY3rpQ4lYNXlAeYt7jMBsRd70F4WcTPiCX0EZfunW5S8NcOBFQxQ43S55LRAA
 bDELddWA+640XsrcWgsKK/keH4eL5kRbDJGRYUlYkJ8z12pjTmBXj/vbpgSPevj9B6tP9Ih9KAo
 isZsSA2MyHlfdPDZUu0cBhn5Ei5oLXc9DG9X8LboefVjVdhUm+2YVKJYBg==
X-Received: by 2002:a17:903:8c8:b0:2bd:606d:b342 with SMTP id
 d9443c01a7336-2bf36833abfmr64966555ad.26.1780203487134; Sat, 30 May 2026
 21:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260530211248.375318-1-richard.henderson@linaro.org>
In-Reply-To: <20260530211248.375318-1-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 30 May 2026 22:57:55 -0600
X-Gm-Features: AVHnY4JdR_lMLPn2s1Rk1WosWH5LUNLFTwgN07e_LlcEB2ttG21X_N_stnOllDI
Message-ID: <CANCZdfor7DamDsGrMx+=-VRJMdHFqm+TnhpkKaPxD+xJ8CCyZQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] *-user: probe_guest_base improvments
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Content-Type: multipart/alternative; boundary="0000000000007a91c5065315ece9"
Received-SPF: none client-ip=2607:f8b0:4864:20::102f;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000007a91c5065315ece9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 3:12=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> The first 4 patches fix the ambiguous guest_lobase parameter,
> which affects an odd usage of a bare metal image with qemu-arm.
>
> The rest of the patches improve bsd-user to use probe_guest_base.
>

Thanks for taking the time to do this. I had some parallel work on this, bu=
t
I think this is likely a better base. The few things I think I might have
done a
bit better I've commented on in the reviews, but this series overall is muc=
h
more complete than I did in the blitz branch. Thank you!

Warner


> r~
>
> Richard Henderson (13):
>   linux-user: Introduce PGBRange
>   linux-user: Use PGBRange in load_elf_image
>   linux-user: Drop hiaddr out-of-range check in probe_guest_base
>   linux-user: Pass image_range to probe_guest_base
>   linux-user: Use PGBRange for commpage
>   common-user: Move mmap_min_addr from linux-user
>   common-user: Initialize mmap_min_addr for FreeBSD
>   include/user/guest-host: Include missing cpu.h
>   common-user: Move selfmap from util
>   common-user: Implement read_self_maps for FreeBSD
>   common-user: Move probe_guest_base from linux-user
>   bsd-user: Use probe_guest_base
>   common-user: Move guest_base, have_guest_base to probe-guest-base.c
>
>  include/user/guest-host.h        |   1 +
>  include/user/mmap-min-addr.h     |  12 +
>  include/user/probe-guest-base.h  |  37 +++
>  include/{qemu =3D> user}/selfmap.h |   0
>  linux-user/arm/target_elf.h      |   2 +-
>  linux-user/hppa/target_elf.h     |   2 +-
>  linux-user/user-internals.h      |  17 +-
>  bsd-user/elfload.c               |  37 +--
>  bsd-user/main.c                  |  42 +---
>  common-user/mmap-min-addr.c      |  50 ++++
>  common-user/probe-guest-base.c   | 347 +++++++++++++++++++++++++++
>  {util =3D> common-user}/selfmap.c  |  45 +++-
>  linux-user/arm/elfload.c         |   2 +-
>  linux-user/elfload.c             | 400 ++-----------------------------
>  linux-user/flatload.c            |   3 +-
>  linux-user/hppa/elfload.c        |   4 +-
>  linux-user/main.c                |  35 +--
>  linux-user/mmap.c                |   1 +
>  linux-user/syscall.c             |   2 +-
>  common-user/meson.build          |   8 +
>  util/meson.build                 |   4 -
>  21 files changed, 565 insertions(+), 486 deletions(-)
>  create mode 100644 include/user/mmap-min-addr.h
>  create mode 100644 include/user/probe-guest-base.h
>  rename include/{qemu =3D> user}/selfmap.h (100%)
>  create mode 100644 common-user/mmap-min-addr.c
>  create mode 100644 common-user/probe-guest-base.c
>  rename {util =3D> common-user}/selfmap.c (69%)
>
> --
> 2.43.0
>
>

--0000000000007a91c5065315ece9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, May 30,=
 2026 at 3:12=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.he=
nderson@linaro.org">richard.henderson@linaro.org</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">The first 4 patches fix the=
 ambiguous guest_lobase parameter,<br>
which affects an odd usage of a bare metal image with qemu-arm.<br>
<br>
The rest of the patches improve bsd-user to use probe_guest_base.<br></bloc=
kquote><div><br></div><div>Thanks for taking=C2=A0the time to do this. I ha=
d some parallel work on this, but</div><div>I think this is likely a better=
 base. The few things I think I might have done a</div><div>bit better I&#3=
9;ve commented on in the reviews, but this series overall is much</div><div=
>more complete than I did in the blitz branch. Thank you!</div><div><br></d=
iv><div>Warner</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
r~<br>
<br>
Richard Henderson (13):<br>
=C2=A0 linux-user: Introduce PGBRange<br>
=C2=A0 linux-user: Use PGBRange in load_elf_image<br>
=C2=A0 linux-user: Drop hiaddr out-of-range check in probe_guest_base<br>
=C2=A0 linux-user: Pass image_range to probe_guest_base<br>
=C2=A0 linux-user: Use PGBRange for commpage<br>
=C2=A0 common-user: Move mmap_min_addr from linux-user<br>
=C2=A0 common-user: Initialize mmap_min_addr for FreeBSD<br>
=C2=A0 include/user/guest-host: Include missing cpu.h<br>
=C2=A0 common-user: Move selfmap from util<br>
=C2=A0 common-user: Implement read_self_maps for FreeBSD<br>
=C2=A0 common-user: Move probe_guest_base from linux-user<br>
=C2=A0 bsd-user: Use probe_guest_base<br>
=C2=A0 common-user: Move guest_base, have_guest_base to probe-guest-base.c<=
br>
<br>
=C2=A0include/user/guest-host.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 =
+<br>
=C2=A0include/user/mmap-min-addr.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 12 +<br>
=C2=A0include/user/probe-guest-base.h=C2=A0 |=C2=A0 37 +++<br>
=C2=A0include/{qemu =3D&gt; user}/selfmap.h |=C2=A0 =C2=A00<br>
=C2=A0linux-user/arm/target_elf.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br=
>
=C2=A0linux-user/hppa/target_elf.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br=
>
=C2=A0linux-user/user-internals.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 17 +-<br>
=C2=A0bsd-user/elfload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 37 +--<br>
=C2=A0bsd-user/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 42 +---<br>
=C2=A0common-user/mmap-min-addr.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 50 ++++<br>
=C2=A0common-user/probe-guest-base.c=C2=A0 =C2=A0| 347 ++++++++++++++++++++=
+++++++<br>
=C2=A0{util =3D&gt; common-user}/selfmap.c=C2=A0 |=C2=A0 45 +++-<br>
=C2=A0linux-user/arm/elfload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A02 +-<br>
=C2=A0linux-user/elfload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 400 ++-----------------------------<br>
=C2=A0linux-user/flatload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A03 +-<br>
=C2=A0linux-user/hppa/elfload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 =
+-<br>
=C2=A0linux-user/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 35 +--<br>
=C2=A0linux-user/mmap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0linux-user/syscall.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A02 +-<br>
=C2=A0common-user/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A08 +<br>
=C2=A0util/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A04 -<br>
=C2=A021 files changed, 565 insertions(+), 486 deletions(-)<br>
=C2=A0create mode 100644 include/user/mmap-min-addr.h<br>
=C2=A0create mode 100644 include/user/probe-guest-base.h<br>
=C2=A0rename include/{qemu =3D&gt; user}/selfmap.h (100%)<br>
=C2=A0create mode 100644 common-user/mmap-min-addr.c<br>
=C2=A0create mode 100644 common-user/probe-guest-base.c<br>
=C2=A0rename {util =3D&gt; common-user}/selfmap.c (69%)<br>
<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--0000000000007a91c5065315ece9--

