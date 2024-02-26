Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D142CC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 04:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reSih-0004P3-PG; Sun, 25 Feb 2024 23:36:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1reSig-0004On-60
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 23:36:02 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1reSie-000474-Ei
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 23:36:01 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a28a6cef709so403562866b.1
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 20:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708922158; x=1709526958; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDdStFujdNr2uDxBNI/xSitC7eI2GokMDG8SRexgmWA=;
 b=F97X7jS1vczgr+cDkkdnvOb5PNo74DtmXUKcSaMVzS75Iyjq7/vcTpeymDwCnPf8dV
 ZYpJSnS3h/eu5zp/ICqCjKqABBgfdS5hpdZbHD8vARXBQtSSWjQ0EUF6uT8qiD0G8QGm
 yZEw08E2FvYmHL7q9KKKtmxcaAeMWETJZLrh3s6JBY/tKfuCpKlbynHAfttJb+FWR5TE
 64vRHZ4W40J9DwgGv3frZkup8orSebyPDB+nNh+0Vy+f8Zn0ZDYVmFoKfFrxJbUv6U9Y
 5VropllKoJMWz6P+RQCbMVL3GIN3ACDQ9UzLzyYeKIJwoX0kKraFhyG/Xg5OUAREJg6a
 s0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708922158; x=1709526958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZDdStFujdNr2uDxBNI/xSitC7eI2GokMDG8SRexgmWA=;
 b=hPuMfx4RjwjE/VxID/V6q2s9F0nzDDknB94q4+EaFQz15dVxRH65EeLG4sjTpBMtz+
 Z7CRmT84/B3SM9qLZVojg/Hm+Nfo37c4sdp5pB5XrtzxFNM9JYtPw2AH8H5f7wZeBa5I
 wD1uloRf/IyoIFYGtxnzmXfLnygzGrVSi+C04eEzX+mx7HXM50tcUn2L3giGXp1x7GIX
 B06iyGbU2At2yMQup2rYsWO568Gi19QfOj6Btc1ooql2DHprJjAxC0AFawPgbEYN0eKb
 m1+s+SRIbV2GAPMQvYh/4Yui7WE79YkXhzF0FkJuURHJgn02L1itVFj9D1vdiLFtJA4s
 Iy6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9Z6gAw0iJx5L3ocY7AoJPpU7tZ4lQ28CPE6auZgK+y0MC7puFoIDqPtkzw54fr9G3Je1AiO6ucPSztum4TVlGnD6FqiA=
X-Gm-Message-State: AOJu0Yw94fX81+ua8sHBVZfFGirB3UU9m9pnvwvFboMy84O2xEDLyWZI
 Br0bQX7Pkfl30/tvDCPbyGdLeNmYEwebfZgJR9pGqNuCc7Q23alUw8KHVwuQK6hQjKKz1jVeJd6
 AOuVTBLa8XImDgASzASucFLxBlGTeZYgRLBxFmw==
X-Google-Smtp-Source: AGHT+IE+yGeJ3BTf+LTzJ2dH0qEqEHi+bo2uZsPX09xMRpUXSMY/YaHMb9GgudseQFiMzqE5d5XjMclQ1p0fMPNx7Cs=
X-Received: by 2002:a17:906:6da:b0:a42:f6f5:d10d with SMTP id
 v26-20020a17090606da00b00a42f6f5d10dmr3196563ejb.12.1708922158231; Sun, 25
 Feb 2024 20:35:58 -0800 (PST)
MIME-Version: 1.0
References: <20220908132817.1831008-1-bmeng.cn@gmail.com>
 <20220908132817.1831008-4-bmeng.cn@gmail.com>
 <556496df-4362-6780-8379-e14bf4269e3f@ilande.co.uk>
 <CAEUhbmVmKhJJk0pQcVJKryie+V4uZEznZCu0dzjftYCycBtD8w@mail.gmail.com>
 <504673a3-d269-428d-876d-fd3dcc8fe680@weilnetz.de>
In-Reply-To: <504673a3-d269-428d-876d-fd3dcc8fe680@weilnetz.de>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 26 Feb 2024 12:35:46 +0800
Message-ID: <CAEUhbmUdvtbAZSOh_hQRLFmQtr8zeUadm6XBo+Ayg=CvidCOag@mail.gmail.com>
Subject: Re: [PATCH 3/7] scripts/nsis.py: Automatically package required DLLs
 of QEMU executables
To: Stefan Weil <sw@weilnetz.de>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Bin Meng <bin.meng@windriver.com>, 
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=bmeng.cn@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 26, 2024 at 1:37=E2=80=AFAM Stefan Weil <sw@weilnetz.de> wrote:
>
> Am 10.09.22 um 02:37 schrieb Bin Meng:
> > On Sat, Sep 10, 2022 at 12:49 AM Mark Cave-Ayland
> > <mark.cave-ayland@ilande.co.uk> wrote:
> >>
> >> On 08/09/2022 14:28, Bin Meng wrote:
> >>
> >>> From: Bin Meng <bin.meng@windriver.com>
> >>>
> >>> At present packaging the required DLLs of QEMU executables is a
> >>> manual process, and error prone.
> >>>
> >>> Actually build/config-host.mak contains a GLIB_BINDIR variable
> >>> which is the directory where glib and other DLLs reside. This
> >>> works for both Windows native build and cross-build on Linux.
> >>> We can use it as the search directory for DLLs and automate
> >>> the whole DLL packaging process.
> >>>
> >>> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> >>> ---
> >>>
> >>>    meson.build     |  1 +
> >>>    scripts/nsis.py | 46 ++++++++++++++++++++++++++++++++++++++++++---=
-
> >>>    2 files changed, 43 insertions(+), 4 deletions(-)
> >>>
> [...]>>> diff --git a/scripts/nsis.py b/scripts/nsis.py
> >>> index baa6ef9594..03ed7608a2 100644
> >>> --- a/scripts/nsis.py
> >>> +++ b/scripts/nsis.py
> >>> @@ -18,12 +18,36 @@ def signcode(path):
> >>>            return
> >>>        subprocess.run([cmd, path])
> >>>
> >>> +def find_deps(exe_or_dll, search_path, analyzed_deps):
> >>> +    deps =3D [exe_or_dll]
> >>> +    output =3D subprocess.check_output(["objdump", "-p", exe_or_dll]=
, text=3DTrue)
>
> This fails on non x86 hosts where objdump does not know how to handle a
> Windows x86_64 exe file.

Does this command work in the MSYS2 environment on Windows Arm?

>
> >>> +    output =3D output.split("\n")
> >>> +    for line in output:
> >>> +        if not line.startswith("\tDLL Name: "):
> >>> +            continue
> >>> +
> >>> +        dep =3D line.split("DLL Name: ")[1].strip()
> >>> +        if dep in analyzed_deps:
> >>> +            continue
> >>> +
> >>> +        dll =3D os.path.join(search_path, dep)
> >>> +        if not os.path.exists(dll):
> >>> +            # assume it's a Windows provided dll, skip it
> >>> +            continue
> >>> +
> >>> +        analyzed_deps.add(dep)
> >>> +        # locate the dll dependencies recursively
> >>> +        rdeps =3D find_deps(dll, search_path, analyzed_deps)
> >>> +        deps.extend(rdeps)
> >>> +
> >>> +    return deps
> [...]
> >>
> >> FWIW I wrote a similar script a while back to help package a custom Wi=
ndows build for
> >> a client, however I used ldd instead of objdump since it provided the =
full paths for
> >> DLLs installed in the msys2/mingw-w64 environment via pacman which wer=
e outside the
> >> QEMU build tree.
> >>
> >
> > Yep, ldd also works, but only on Windows native build. objdump can
> > work on both Windows native and Linux cross builds.
>
>
> objdump fails on Linux cross builds on any non x86 host, because objdump
> typically only supports the native host architecture.
>
> Therefore I get an error on an ARM64 host (podman on Mac M1):
>
>          objdump: /tmp/tmpvae5u0qm/qemu/qemu-system-aarch64.exe: file
> format not recognized
>
> I could use x86_64-w64-mingw32-objdump to fix the cross builds, but then
> native builds might fail because they don't have x86_64-w64-mingw32-objdu=
mp.
>
> Is there a simple way how we can get the information here whether
> objdump requires a cross build prefix?

For QEMU Windows, I believe the only supported architecture is x86_64,
correct? Do we want to support (cross) building QEMU for Windows Arm?

Based on your observation, objdump on Linux cross builds on any x86
host works, but not on non x86 host.
Maybe it's a hint to ask for binutils guys to include the PE format
support for objdump Arm by default.

Regards,
Bin

