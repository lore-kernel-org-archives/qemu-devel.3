Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58564EC1436
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 12:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxOh9-00032i-4P; Tue, 03 Mar 2026 07:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vxOh2-00030K-6U
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 07:17:42 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1vxOgs-0002Dw-Lh
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 07:17:39 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3598b95ad7dso1601977a91.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 04:17:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772540248; cv=none;
 d=google.com; s=arc-20240605;
 b=dA/aJjoknKb5WrqrccxpOzjqHeP4Pp6cjHX6tA4gA7EvJuIlBjM1BdyGTsAYX40BHy
 LS7Kgi7egxXzTWa6aVliMy5cOq4I0XbTEdsd+14OSlAsLI++lKAHB5ArxRdluM1OpP4v
 C7DKA4nCTinc9MI/FllV7Ifw0GQTPXMBxOOpQKD/Si2olEUlHBRdLrvvDCE+TweJFsC5
 2n846h05V9IJuFPqbUgI3m1Wttp4Np8xNfzvxjgKv9GOk/hqmEeg1Ga9hdtrf6G/wz9V
 61pmdsZGoM1LvlhjwVxefzeLe5pWakGNZiQe1EgKwVEubAT8Wo8eCeUcjpAbvdITxQEo
 jG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NqhEeUxRz87roc0qI/HVtmUM0YWKKpgvx+3Q465KzuU=;
 fh=KkqdRGywlxv5Wj5V57PCt4gBJ9IszloNFP2Ks13LaQA=;
 b=aNFZXD/Wp9tE9bgECSfe5K4+r0eQa/0jZo0yKn5AqogjW3dJUMuSWOIvZ3W+vHvDNj
 9FEIIz6+Y131xUt6zfokzfjTGw32EwPfvpuI7kUaCVET87pqq9uRhGCE6nmdd89+UVDR
 17E6pRgxaBqG0CauxWMqV28rFpQoUSn7Bvsb2lBSABIzuvJQQd1htQGwgXzekCMvD8FW
 /SuhwG2UPrzhdohtXbjuZVmFcOFr4vmKp39+5ShfY+TShmscN5sTrK3zL9D++mWICx9u
 LvR5xUjEdcbpYdGHDyur7mAbu5jsbWHY7TEsU/SKWjGO2ZjjXhv4l5W4FTo1CK/OIooP
 7tnA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772540248; x=1773145048;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NqhEeUxRz87roc0qI/HVtmUM0YWKKpgvx+3Q465KzuU=;
 b=bcW4eSPYeB0zEvtKnLyAE03N4XKkkbR0cLohYWSD4N7vybpnyHJDG4ejde366mJ6W9
 cefH47Eq3Kih1QHA7QRhSzzcUBQrnVk7i5JrlQA37shI/PSvCz7ACXhpJptiqfYbhTKX
 Y1/XxT4Bn/8Q8uT6WwmNOln1PbI8+Gc+Sw0/AqXnHi7JnEXDwsvU1o8Ys5wfZ2MvOI8B
 ejO1QUFzPgdfZqZzt6p6RVTEQZpWWkx2vwYieiQPgc+KecBSR7o/4cMBMScAS9nis/Md
 Xzebbbq+G6gMwqCiWhVrw6aSoaubSizsS2Cp6wxnJHyQ9XHrRve3wLQKtbHoUNs2pJM/
 C6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772540248; x=1773145048;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NqhEeUxRz87roc0qI/HVtmUM0YWKKpgvx+3Q465KzuU=;
 b=d+5ttnl1LUhO71vVYyMbZdxta09cQFfngTrR9y6TXvxKcILAFPSpv5reVkMKV9DYsH
 PG2wzLmB7oMON+Mgd2fv9QhTf/RZT4vVgZhFw4ZBM+lWlvq9KDqQCW9wjY07N//WG9bn
 l9FAw9FkFscjTuTsAvi3dDPlTAh3PfhTVDf/4pcovlqGJSOzyZh8QPe+Qt8BTaytW9f+
 SS6kQQERAkCDOwic34OMYaYaNSLLfFBGoEVmVKaOayp1i4HIBNVtKniVaSlGqV9uYlDf
 QDPTNcW2rzxggTi9Qd/T6OidIs0Nm3A+IozxVE34HdqZ7CbQgfxUCnLFsJulue421YP2
 XveQ==
X-Gm-Message-State: AOJu0YwMU5/zb5tF/GDhlfYxFMjFLRBV5edis4V5ART5fA/i1MlH3del
 SGLAg0l/pd8i82eLJIHWoODDNIJ6DsZjE7zhY9FkMz4Sw2rjQC2+3odRHBQ6Bp5k6V8jzidKTy8
 X0n42eY4AHCUjRw9fnueenX4WT6gsv3nVntnKKZp2TQ==
X-Gm-Gg: ATEYQzxrthlU/dSUb9G/UfvpoUeZ3a+43o/4DzcHf9vrD7UgszgXPfkpkRiWwC1LxcV
 yScp/i7ss0d16YWMZsA954HTZHphGkhJRkDXBf63qbCBQIpecSUZKQ2Dex4DyA6vwKjSgTy1xzM
 iq7J8vGSLSpjJKXFKV18NNYJPiw3LgOg9DCrB05w3eXMR5pVyKWHxDPbVaa5XX9oNWU4/hwrUel
 0xwI61vrN94Rm0PMEYykeHQFov5KqAGwmpOGaJVM/FbNhRJR3V+GYrnvBg5bWlPZ6bg4BcT4mJ8
 AZcJJqA4ojjX6JjZ5A==
X-Received: by 2002:a17:90b:4d8d:b0:359:3426:c60a with SMTP id
 98e67ed59e1d1-35965c3afa6mr14459229a91.4.1772540247170; Tue, 03 Mar 2026
 04:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20260302-bsd-user-copyright-v1-1-f05587d18d4e@bsdimp.com>
 <aaahAbpycKhDzfbL@redhat.com>
In-Reply-To: <aaahAbpycKhDzfbL@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 3 Mar 2026 05:17:15 -0700
X-Gm-Features: AaiRm52E1MZvZ4Rj6l4quCUFwhGafs8pkyu2WtPE90V563Z8oAbWlEx7czk4DcI
Message-ID: <CANCZdfoxESrbaUbXWo9g2jfaqsgaWbpNxg5CGd3xgf0MRMDMcw@mail.gmail.com>
Subject: Re: [PATCH] bsd-user: Switch to SPDX-License-Expression
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000c86f40064c1daf9d"
Received-SPF: none client-ip=2607:f8b0:4864:20::1031;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x1031.google.com
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

--000000000000c86f40064c1daf9d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 1:51=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> On Mon, Mar 02, 2026 at 09:46:06PM -0700, Warner Losh wrote:
> > Switch all the files over to using SPDX. This also corrects various
> > small errors in the form of the copyright messages. It adds copyright t=
o
> > those files that lack it. There's no functional change.
> >
> > Signed-off-by: Stacey Son <sson@FreeBSD.org>
> > Signed-off-by: Warner Losh <imp@bsdimp.com>
> > ---
> > Since I'll be upstreaming more files from bsd-user, and since qemu now
> > requires SPDX and prohibits boilerplate, this will make it easier. I've
> > converted all the relevant bits in bsd-user upstream.
>
> Note, QEMU / checkpatch.pl only requires SDPX on *newly* authored files.
> Existing code files, or new files whose content is copied from an
> existing file (either inside or outside QEMU git) are exempt from this
> and in fact required to be left without SPDX.
>
> The reasoning is that there is some uncertainty about the legality of
> removing license header text from existing files due to the GPL clause
> 1 which says
>
>   "keep intact all the notices that refer to this License and
>    to the absence of any warranty;"
>
> I interpret that to mean we can not remove license header text from
> files unless the person doing the removal is the exclusive copyright
> holder, or has got recorded permission from all copyright holders
> that apply to each file changed.
>
> It is confusing for people because Linux removed all their GPL header
> text in favour of SPDX, but never provided any clear explanation of
> why they considered that to be acceptable from the GPL compliance POV.
>

So I have Stacey's permission to do this, and he's the only actual copyrigh=
t
holder on these files. If I messed up on any, specifically, please let me
know.
That's why I included his signed-off-by: he signed off on it and that he's
legally
able to make the change.

Also, I did this to reduce friction in upstreaming bsd-user which has been
going on for 6ish years now. The SPDX rule is one more thing that slows
that down. Rather than get an exception to the rule, I brought everything
into compliance so it isn't yet another issue that takes more time because
I forgot to do it for a specific patch series. The more issues I have to
have
on my checklist, the more the works are gummed up and the slower the
progress is. We still have somethign like ~30k lines to go last I checked.

Also, these files have also been out of tree for over a decade. The new
rule forces me to do what you're complaining about the Linux tree doing:
remove GPL markings to get it into your tree. Well which is it?  Either it'=
s
wrong and I shouldn't have to do it for the old files.  Or what I've done
is proper since it's uniform. Your tree is just an arbitrary repo of these
files, and isn't special in any meaningful way. So I'm in a no-win situatio=
n
here by your argument.

Also, when I talk about a burdensome and cumbersome upstreaming process,
this is yet another example. An arbitrary rule that causes friction, but
provides
no actual benefit. It's like the style rules: I have to arbitrarily
reformat code that
is like that in linux-user because this is "new code". So I spend a fair
amount of
time fetching different stones to obey the rules, but since now the code is
different
it becomes harder to track linux-user or to ever converge them. Change for
the
sake of compliance with an arbitrary rule that doesn't apply elsewhere (for
whatever
reason) is one of the death by a thousand cuts I, and others doing this
work, have
been suffering for far too long. It's in large measure why things aren't
further along:
it steals what little time I have for this and it demotivates further work
for a while.

Note: I'm specifically not complaining about the code review that finds
actual
problems. That's quite useful and has improved the quality. So I've not
tried to do
any 'maintainer reviewed' end-run around this process since it has been
helpful,
though also timeconsuming at times.

So, having said that, is there any specific objection to anything I've
done? Given
Stacey's explicit blessing of this change (you'll recall from the patch
series I just did
I waited until I had contacted him before I changing it there), did I mess
up anywhere?

Warner


> > ---
> >  bsd-user/aarch64/signal.c               | 15 ++-------------
> >  bsd-user/aarch64/target_arch.h          | 16 ++--------------
> >  bsd-user/aarch64/target_arch_cpu.c      | 15 ++-------------
> >  bsd-user/aarch64/target_arch_cpu.h      | 18 +++---------------
> >  bsd-user/aarch64/target_arch_elf.h      | 14 +-------------
> >  bsd-user/aarch64/target_arch_reg.h      | 19 +++----------------
> >  bsd-user/aarch64/target_arch_signal.h   | 16 ++--------------
> >  bsd-user/aarch64/target_arch_sigtramp.h | 16 ++--------------
> >  bsd-user/aarch64/target_arch_sysarch.h  | 16 ++--------------
> >  bsd-user/aarch64/target_arch_thread.h   | 16 ++--------------
> >  bsd-user/aarch64/target_arch_vmparam.h  | 16 ++--------------
> >  bsd-user/aarch64/target_syscall.h       | 16 ++--------------
> >  bsd-user/arm/signal.c                   | 18 +++---------------
> >  bsd-user/arm/target_arch.h              | 16 ++--------------
> >  bsd-user/arm/target_arch_cpu.c          | 18 +++---------------
> >  bsd-user/arm/target_arch_cpu.h          | 18 +++---------------
> >  bsd-user/arm/target_arch_elf.h          | 18 +++---------------
> >  bsd-user/arm/target_arch_reg.h          | 18 +++---------------
> >  bsd-user/arm/target_arch_signal.h       | 18 +++---------------
> >  bsd-user/arm/target_arch_sigtramp.h     | 18 +++---------------
> >  bsd-user/arm/target_arch_sysarch.h      | 18 +++---------------
> >  bsd-user/arm/target_arch_thread.h       | 18 +++---------------
> >  bsd-user/arm/target_arch_vmparam.h      | 18 +++---------------
> >  bsd-user/arm/target_syscall.h           | 18 +++---------------
> >  bsd-user/bsd-file.h                     | 18 +++---------------
> >  bsd-user/bsd-mem.c                      | 17 +++--------------
> >  bsd-user/bsd-mem.h                      | 17 +++--------------
> >  bsd-user/bsd-proc.c                     | 17 +++--------------
> >  bsd-user/bsd-proc.h                     | 17 +++--------------
> >  bsd-user/bsdload.c                      | 17 +++--------------
> >  bsd-user/elfload.c                      | 17 +++--------------
> >  bsd-user/freebsd/os-misc.h              | 18 +++---------------
> >  bsd-user/freebsd/os-proc.c              | 17 +++--------------
> >  bsd-user/freebsd/os-proc.h              | 18 +++---------------
> >  bsd-user/freebsd/os-stat.c              | 17 +++--------------
> >  bsd-user/freebsd/os-stat.h              | 18 +++---------------
> >  bsd-user/freebsd/os-strace.h            | 19 +++----------------
> >  bsd-user/freebsd/target_os_elf.h        | 18 +++---------------
> >  bsd-user/freebsd/target_os_siginfo.h    | 18 +++---------------
> >  bsd-user/freebsd/target_os_stack.h      | 18 +++---------------
> >  bsd-user/freebsd/target_os_thread.h     | 18 +++---------------
> >  bsd-user/freebsd/target_os_user.h       | 18 +++---------------
> >  bsd-user/freebsd/target_os_vmparam.h    | 18 +++---------------
> >  bsd-user/i386/signal.c                  | 17 +++--------------
> >  bsd-user/i386/target_arch.h             | 16 ++--------------
> >  bsd-user/i386/target_arch_cpu.c         | 17 +++--------------
> >  bsd-user/i386/target_arch_cpu.h         | 17 +++--------------
> >  bsd-user/i386/target_arch_elf.h         | 18 +++---------------
> >  bsd-user/i386/target_arch_reg.h         | 19 +++----------------
> >  bsd-user/i386/target_arch_signal.h      | 16 +++-------------
> >  bsd-user/i386/target_arch_sigtramp.h    | 16 ++--------------
> >  bsd-user/i386/target_arch_sysarch.h     | 18 +++---------------
> >  bsd-user/i386/target_arch_thread.h      | 18 +++---------------
> >  bsd-user/i386/target_arch_vmparam.h     | 18 +++---------------
> >  bsd-user/i386/target_syscall.h          | 16 +++-------------
> >  bsd-user/main.c                         | 20 ++++----------------
> >  bsd-user/mmap.c                         | 17 +++--------------
> >  bsd-user/qemu-bsd.h                     | 18 +++---------------
> >  bsd-user/qemu.h                         | 15 +++------------
> >  bsd-user/signal.c                       | 19 ++++---------------
> >  bsd-user/strace.c                       | 16 +++-------------
> >  bsd-user/syscall_defs.h                 | 18 +++---------------
> >  bsd-user/x86_64/signal.c                | 16 +++-------------
> >  bsd-user/x86_64/target_arch.h           | 16 ++--------------
> >  bsd-user/x86_64/target_arch_cpu.c       | 17 +++--------------
> >  bsd-user/x86_64/target_arch_cpu.h       | 17 +++--------------
> >  bsd-user/x86_64/target_arch_elf.h       | 18 +++---------------
> >  bsd-user/x86_64/target_arch_reg.h       | 19 +++----------------
> >  bsd-user/x86_64/target_arch_signal.h    | 17 +++--------------
> >  bsd-user/x86_64/target_arch_sigtramp.h  | 17 ++---------------
> >  bsd-user/x86_64/target_arch_sysarch.h   | 17 +++--------------
> >  bsd-user/x86_64/target_arch_thread.h    | 18 +++---------------
> >  bsd-user/x86_64/target_arch_vmparam.h   | 18 +++---------------
> >  bsd-user/x86_64/target_syscall.h        | 16 +++-------------
> >  74 files changed, 208 insertions(+), 1069 deletions(-)
> >
> > diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
> > index 6bc73a798f..ad19e5144e 100644
> > --- a/bsd-user/aarch64/signal.c
> > +++ b/bsd-user/aarch64/signal.c
> > @@ -1,20 +1,9 @@
> >  /*
> >   * ARM AArch64 specific signal definitions for bsd-user
> >   *
> > - * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
> > + * Copyright (c) 2015 Stacey D. Son
> >   *
> > - * This library is free software; you can redistribute it and/or
> > - * modify it under the terms of the GNU Lesser General Public
> > - * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > - *
> > - * This library is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > - * Lesser General Public License for more details.
> > - *
> > - * You should have received a copy of the GNU Lesser General Public
> > - * License along with this library; if not, see <
> http://www.gnu.org/licenses/>.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >  #include "qemu/osdep.h"
> >
> > diff --git a/bsd-user/aarch64/target_arch.h
> b/bsd-user/aarch64/target_arch.h
> > index 4815a56ae3..7861233889 100644
> > --- a/bsd-user/aarch64/target_arch.h
> > +++ b/bsd-user/aarch64/target_arch.h
> > @@ -1,22 +1,10 @@
> >  /*
> >   * ARM AArch64 specific prototypes for bsd-user
> >   *
> > - * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
> > + * Copyright (c) 2015 Stacey D. Son
> >   *
> > - * This library is free software; you can redistribute it and/or
> > - * modify it under the terms of the GNU Lesser General Public
> > - * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > - *
> > - * This library is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > - * Lesser General Public License for more details.
> > - *
> > - * You should have received a copy of the GNU Lesser General Public
> > - * License along with this library; if not, see <
> http://www.gnu.org/licenses/>.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_H
> >  #define TARGET_ARCH_H
> >
> > diff --git a/bsd-user/aarch64/target_arch_cpu.c
> b/bsd-user/aarch64/target_arch_cpu.c
> > index b2fa59efaf..6e9519e1b0 100644
> > --- a/bsd-user/aarch64/target_arch_cpu.c
> > +++ b/bsd-user/aarch64/target_arch_cpu.c
> > @@ -1,20 +1,9 @@
> >  /*
> >   * ARM AArch64 specific CPU for bsd-user
> >   *
> > - * Copyright (c) 2015 Stacey Son
> > + * Copyright (c) 2015 Stacey D. Son
> >   *
> > - * This library is free software; you can redistribute it and/or
> > - * modify it under the terms of the GNU Lesser General Public
> > - * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > - *
> > - * This library is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > - * Lesser General Public License for more details.
> > - *
> > - * You should have received a copy of the GNU Lesser General Public
> > - * License along with this library; if not, see <
> http://www.gnu.org/licenses/>.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >  #include "qemu/osdep.h"
> >  #include "target_arch.h"
> > diff --git a/bsd-user/aarch64/target_arch_cpu.h
> b/bsd-user/aarch64/target_arch_cpu.h
> > index 15df84fda2..09d942b040 100644
> > --- a/bsd-user/aarch64/target_arch_cpu.h
> > +++ b/bsd-user/aarch64/target_arch_cpu.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  ARM AArch64 cpu init and loop
> > + * ARM AArch64 cpu init and loop
> >   *
> > - * Copyright (c) 2015 Stacey Son
> > + * Copyright (c) 2015 Stacey D. Son
> >   *
> > - * This library is free software; you can redistribute it and/or
> > - * modify it under the terms of the GNU Lesser General Public
> > - * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > - *
> > - * This library is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > - * Lesser General Public License for more details.
> > - *
> > - * You should have received a copy of the GNU Lesser General Public
> > - * License along with this library; if not, see <
> http://www.gnu.org/licenses/>.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_CPU_H
> >  #define TARGET_ARCH_CPU_H
> >
> > diff --git a/bsd-user/aarch64/target_arch_elf.h
> b/bsd-user/aarch64/target_arch_elf.h
> > index cec254f88b..5ea5232a57 100644
> > --- a/bsd-user/aarch64/target_arch_elf.h
> > +++ b/bsd-user/aarch64/target_arch_elf.h
> > @@ -3,20 +3,8 @@
> >   *
> >   * Copyright (c) 2015 Stacey D. Son
> >   *
> > - * This library is free software; you can redistribute it and/or
> > - * modify it under the terms of the GNU Lesser General Public
> > - * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > - *
> > - * This library is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > - * Lesser General Public License for more details.
> > - *
> > - * You should have received a copy of the GNU Lesser General Public
> > - * License along with this library; if not, see <
> http://www.gnu.org/licenses/>.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_ELF_H
> >  #define TARGET_ARCH_ELF_H
> >
> > diff --git a/bsd-user/aarch64/target_arch_reg.h
> b/bsd-user/aarch64/target_arch_reg.h
> > index b53302e7f7..9cca3c0ea0 100644
> > --- a/bsd-user/aarch64/target_arch_reg.h
> > +++ b/bsd-user/aarch64/target_arch_reg.h
> > @@ -1,23 +1,10 @@
> >  /*
> > - *  FreeBSD arm64 register structures
> > + * FreeBSD arm64 register structures
> >   *
> > - *  Copyright (c) 2015 Stacey Son
> > - *  All rights reserved.
> > + * Copyright (c) 2015 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_REG_H
> >  #define TARGET_ARCH_REG_H
> >
> > diff --git a/bsd-user/aarch64/target_arch_signal.h
> b/bsd-user/aarch64/target_arch_signal.h
> > index b72ba7aa50..6085217546 100644
> > --- a/bsd-user/aarch64/target_arch_signal.h
> > +++ b/bsd-user/aarch64/target_arch_signal.h
> > @@ -1,22 +1,10 @@
> >  /*
> >   * ARM AArch64 specific signal definitions for bsd-user
> >   *
> > - * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
> > + * Copyright (c) 2015 Stacey D. Son
> >   *
> > - * This library is free software; you can redistribute it and/or
> > - * modify it under the terms of the GNU Lesser General Public
> > - * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > - *
> > - * This library is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > - * Lesser General Public License for more details.
> > - *
> > - * You should have received a copy of the GNU Lesser General Public
> > - * License along with this library; if not, see <
> http://www.gnu.org/licenses/>.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_SIGNAL_H
> >  #define TARGET_ARCH_SIGNAL_H
> >
> > diff --git a/bsd-user/aarch64/target_arch_sigtramp.h
> b/bsd-user/aarch64/target_arch_sigtramp.h
> > index 8cdd33b621..38a447fc25 100644
> > --- a/bsd-user/aarch64/target_arch_sigtramp.h
> > +++ b/bsd-user/aarch64/target_arch_sigtramp.h
> > @@ -1,22 +1,10 @@
> >  /*
> >   * ARM AArch64 sigcode for bsd-user
> >   *
> > - * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
> > + * Copyright (c) 2015 Stacey D. Son
> >   *
> > - * This library is free software; you can redistribute it and/or
> > - * modify it under the terms of the GNU Lesser General Public
> > - * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > - *
> > - * This library is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > - * Lesser General Public License for more details.
> > - *
> > - * You should have received a copy of the GNU Lesser General Public
> > - * License along with this library; if not, see <
> http://www.gnu.org/licenses/>.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_SIGTRAMP_H
> >  #define TARGET_ARCH_SIGTRAMP_H
> >
> > diff --git a/bsd-user/aarch64/target_arch_sysarch.h
> b/bsd-user/aarch64/target_arch_sysarch.h
> > index b003015daf..5569c996cb 100644
> > --- a/bsd-user/aarch64/target_arch_sysarch.h
> > +++ b/bsd-user/aarch64/target_arch_sysarch.h
> > @@ -1,22 +1,10 @@
> >  /*
> >   * ARM AArch64 sysarch() system call emulation for bsd-user.
> >   *
> > - * Copyright (c) 2015 <sson at FreeBSD>
> > + * Copyright (c) 2015 Stacey D. Son
> >   *
> > - * This library is free software; you can redistribute it and/or
> > - * modify it under the terms of the GNU Lesser General Public
> > - * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > - *
> > - * This library is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > - * Lesser General Public License for more details.
> > - *
> > - * You should have received a copy of the GNU Lesser General Public
> > - * License along with this library; if not, see <
> http://www.gnu.org/licenses/>.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_SYSARCH_H
> >  #define TARGET_ARCH_SYSARCH_H
> >
> > diff --git a/bsd-user/aarch64/target_arch_thread.h
> b/bsd-user/aarch64/target_arch_thread.h
> > index 4c911e605a..06676980c9 100644
> > --- a/bsd-user/aarch64/target_arch_thread.h
> > +++ b/bsd-user/aarch64/target_arch_thread.h
> > @@ -1,22 +1,10 @@
> >  /*
> >   * ARM AArch64 thread support for bsd-user.
> >   *
> > - * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
> > + * Copyright (c) 2015 Stacey D. Son
> >   *
> > - * This library is free software; you can redistribute it and/or
> > - * modify it under the terms of the GNU Lesser General Public
> > - * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > - *
> > - * This library is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > - * Lesser General Public License for more details.
> > - *
> > - * You should have received a copy of the GNU Lesser General Public
> > - * License along with this library; if not, see <
> http://www.gnu.org/licenses/>.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_THREAD_H
> >  #define TARGET_ARCH_THREAD_H
> >
> > diff --git a/bsd-user/aarch64/target_arch_vmparam.h
> b/bsd-user/aarch64/target_arch_vmparam.h
> > index 0c35491970..ea32f5b56d 100644
> > --- a/bsd-user/aarch64/target_arch_vmparam.h
> > +++ b/bsd-user/aarch64/target_arch_vmparam.h
> > @@ -1,22 +1,10 @@
> >  /*
> >   * ARM AArch64 VM parameters definitions for bsd-user.
> >   *
> > - * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
> > + * Copyright (c) 2015 Stacey D. Son
> >   *
> > - * This library is free software; you can redistribute it and/or
> > - * modify it under the terms of the GNU Lesser General Public
> > - * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > - *
> > - * This library is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > - * Lesser General Public License for more details.
> > - *
> > - * You should have received a copy of the GNU Lesser General Public
> > - * License along with this library; if not, see <
> http://www.gnu.org/licenses/>.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_VMPARAM_H
> >  #define TARGET_ARCH_VMPARAM_H
> >
> > diff --git a/bsd-user/aarch64/target_syscall.h
> b/bsd-user/aarch64/target_syscall.h
> > index 08ae913c42..a574edc429 100644
> > --- a/bsd-user/aarch64/target_syscall.h
> > +++ b/bsd-user/aarch64/target_syscall.h
> > @@ -1,22 +1,10 @@
> >  /*
> >   * ARM AArch64 specific CPU for bsd-user
> >   *
> > - * Copyright (c) 2015 Stacey D. Son <sson at Freebsd>
> > + * Copyright (c) 2015 Stacey D. Son
> >   *
> > - * This library is free software; you can redistribute it and/or
> > - * modify it under the terms of the GNU Lesser General Public
> > - * License as published by the Free Software Foundation; either
> > - * version 2 of the License, or (at your option) any later version.
> > - *
> > - * This library is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > - * Lesser General Public License for more details.
> > - *
> > - * You should have received a copy of the GNU Lesser General Public
> > - * License along with this library; if not, see <
> http://www.gnu.org/licenses/>.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef BSD_USER_AARCH64_TARGET_SYSCALL_H
> >  #define BSD_USER_AARCH64_TARGET_SYSCALL_H
> >
> > diff --git a/bsd-user/arm/signal.c b/bsd-user/arm/signal.c
> > index 9734407543..35cedeba06 100644
> > --- a/bsd-user/arm/signal.c
> > +++ b/bsd-user/arm/signal.c
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  arm signal functions
> > + * arm signal functions
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #include "qemu/osdep.h"
> >  #include "qemu.h"
> >
> > diff --git a/bsd-user/arm/target_arch.h b/bsd-user/arm/target_arch.h
> > index d80cb85c64..e0add162e8 100644
> > --- a/bsd-user/arm/target_arch.h
> > +++ b/bsd-user/arm/target_arch.h
> > @@ -1,22 +1,10 @@
> >  /*
> >   * ARM 32-bit specific prototypes for bsd-user
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_H
> >  #define TARGET_ARCH_H
> >
> > diff --git a/bsd-user/arm/target_arch_cpu.c
> b/bsd-user/arm/target_arch_cpu.c
> > index fe38ae2210..6a4f5cec0e 100644
> > --- a/bsd-user/arm/target_arch_cpu.c
> > +++ b/bsd-user/arm/target_arch_cpu.c
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  arm cpu related code
> > + * arm cpu related code
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #include "qemu/osdep.h"
> >  #include "target_arch.h"
> >
> > diff --git a/bsd-user/arm/target_arch_cpu.h
> b/bsd-user/arm/target_arch_cpu.h
> > index 9a952ef0ff..faef3ea17a 100644
> > --- a/bsd-user/arm/target_arch_cpu.h
> > +++ b/bsd-user/arm/target_arch_cpu.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  arm cpu init and loop
> > + * arm cpu init and loop
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_CPU_H
> >  #define TARGET_ARCH_CPU_H
> >
> > diff --git a/bsd-user/arm/target_arch_elf.h
> b/bsd-user/arm/target_arch_elf.h
> > index b54bf5fbc6..fd13bc87f4 100644
> > --- a/bsd-user/arm/target_arch_elf.h
> > +++ b/bsd-user/arm/target_arch_elf.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  arm ELF definitions
> > + * arm ELF definitions
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_ELF_H
> >  #define TARGET_ARCH_ELF_H
> >
> > diff --git a/bsd-user/arm/target_arch_reg.h
> b/bsd-user/arm/target_arch_reg.h
> > index 070fa24da1..9d23dda27d 100644
> > --- a/bsd-user/arm/target_arch_reg.h
> > +++ b/bsd-user/arm/target_arch_reg.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  FreeBSD arm register structures
> > + * FreeBSD arm register structures
> >   *
> > - *  Copyright (c) 2015 Stacey Son
> > + * Copyright (c) 2015 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_REG_H
> >  #define TARGET_ARCH_REG_H
> >
> > diff --git a/bsd-user/arm/target_arch_signal.h
> b/bsd-user/arm/target_arch_signal.h
> > index 10f96b8bfc..dfaefa25d1 100644
> > --- a/bsd-user/arm/target_arch_signal.h
> > +++ b/bsd-user/arm/target_arch_signal.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  arm signal definitions
> > + * arm signal definitions
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_SIGNAL_H
> >  #define TARGET_ARCH_SIGNAL_H
> >
> > diff --git a/bsd-user/arm/target_arch_sigtramp.h
> b/bsd-user/arm/target_arch_sigtramp.h
> > index 06198045ed..8a2d34aafc 100644
> > --- a/bsd-user/arm/target_arch_sigtramp.h
> > +++ b/bsd-user/arm/target_arch_sigtramp.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  arm sysarch() system call emulation
> > + * arm sysarch() system call emulation
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_SIGTRAMP_H
> >  #define TARGET_ARCH_SIGTRAMP_H
> >
> > diff --git a/bsd-user/arm/target_arch_sysarch.h
> b/bsd-user/arm/target_arch_sysarch.h
> > index 5cb7864197..5f7c421e11 100644
> > --- a/bsd-user/arm/target_arch_sysarch.h
> > +++ b/bsd-user/arm/target_arch_sysarch.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  arm sysarch() system call emulation
> > + * arm sysarch() system call emulation
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_SYSARCH_H
> >  #define TARGET_ARCH_SYSARCH_H
> >
> > diff --git a/bsd-user/arm/target_arch_thread.h
> b/bsd-user/arm/target_arch_thread.h
> > index fd257f313d..d22619a845 100644
> > --- a/bsd-user/arm/target_arch_thread.h
> > +++ b/bsd-user/arm/target_arch_thread.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  arm thread support
> > + * arm thread support
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_THREAD_H
> >  #define TARGET_ARCH_THREAD_H
> >
> > diff --git a/bsd-user/arm/target_arch_vmparam.h
> b/bsd-user/arm/target_arch_vmparam.h
> > index 3fb69aff51..c973fcf7d5 100644
> > --- a/bsd-user/arm/target_arch_vmparam.h
> > +++ b/bsd-user/arm/target_arch_vmparam.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  arm VM parameters definitions
> > + * arm VM parameters definitions
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_VMPARAM_H
> >  #define TARGET_ARCH_VMPARAM_H
> >
> > diff --git a/bsd-user/arm/target_syscall.h
> b/bsd-user/arm/target_syscall.h
> > index 5804a53541..deab3baebf 100644
> > --- a/bsd-user/arm/target_syscall.h
> > +++ b/bsd-user/arm/target_syscall.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  arm cpu system call stubs
> > + * arm cpu system call stubs
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef ARM_TARGET_SYSCALL_H
> >  #define ARM_TARGET_SYSCALL_H
> >
> > diff --git a/bsd-user/bsd-file.h b/bsd-user/bsd-file.h
> > index 6fa2c30b4d..dca1518cb1 100644
> > --- a/bsd-user/bsd-file.h
> > +++ b/bsd-user/bsd-file.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  file related system call shims and definitions
> > + * file related system call shims and definitions
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef BSD_FILE_H
> >  #define BSD_FILE_H
> >
> > diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
> > index 2ab1334b70..8c6c4081f7 100644
> > --- a/bsd-user/bsd-mem.c
> > +++ b/bsd-user/bsd-mem.c
> > @@ -1,20 +1,9 @@
> >  /*
> > - *  memory management system conversion routines
> > + * memory management system conversion routines
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >  #include "qemu/osdep.h"
> >  #include "qemu.h"
> > diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
> > index a118e57260..8c0b0b6919 100644
> > --- a/bsd-user/bsd-mem.h
> > +++ b/bsd-user/bsd-mem.h
> > @@ -1,20 +1,9 @@
> >  /*
> > - *  memory management system call shims and definitions
> > + * memory management system call shims and definitions
> >   *
> > - *  Copyright (c) 2013-15 Stacey D. Son
> > + * Copyright (c) 2013-2015 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >
> >  /*
> > diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
> > index 8dcac9608d..7fb46046c7 100644
> > --- a/bsd-user/bsd-proc.c
> > +++ b/bsd-user/bsd-proc.c
> > @@ -1,20 +1,9 @@
> >  /*
> > - *  BSD process related system call helpers
> > + * BSD process related system call helpers
> >   *
> > - *  Copyright (c) 2013-14 Stacey D. Son
> > + * Copyright (c) 2013-2014 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >  #include "qemu/osdep.h"
> >
> > diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
> > index 8b1c2deea3..b1d4446ff1 100644
> > --- a/bsd-user/bsd-proc.h
> > +++ b/bsd-user/bsd-proc.h
> > @@ -1,20 +1,9 @@
> >  /*
> > - *  process related system call shims and definitions
> > + * process related system call shims and definitions
> >   *
> > - *  Copyright (c) 2013-2014 Stacey D. Son
> > + * Copyright (c) 2013-2014 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >
> >  #ifndef BSD_PROC_H_
> > diff --git a/bsd-user/bsdload.c b/bsd-user/bsdload.c
> > index 5b3c061a45..b3c9f0265b 100644
> > --- a/bsd-user/bsdload.c
> > +++ b/bsd-user/bsdload.c
> > @@ -1,22 +1,11 @@
> >  /*
> > - *  Load BSD executables.
> > + * Load BSD executables.
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #include "qemu/osdep.h"
> > -
> >  #include "qemu.h"
> >
> >  /* ??? This should really be somewhere else.  */
> > diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
> > index 3bca0cc9ed..ddac272424 100644
> > --- a/bsd-user/elfload.c
> > +++ b/bsd-user/elfload.c
> > @@ -1,20 +1,9 @@
> >  /*
> > - *  ELF loading code
> > + * ELF loading code
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >
> >  #include "qemu/osdep.h"
> > diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
> > index 71145764a4..d9979b2a8b 100644
> > --- a/bsd-user/freebsd/os-misc.h
> > +++ b/bsd-user/freebsd/os-misc.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  miscellaneous FreeBSD system call shims
> > + * miscellaneous FreeBSD system call shims
> >   *
> > - *  Copyright (c) 2013-14 Stacey D. Son
> > + * Copyright (c) 2013-2014 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef OS_MISC_H
> >  #define OS_MISC_H
> >
> > diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
> > index bf993f1b66..0309036178 100644
> > --- a/bsd-user/freebsd/os-proc.c
> > +++ b/bsd-user/freebsd/os-proc.c
> > @@ -1,20 +1,9 @@
> >  /*
> > - *  FreeBSD process related emulation code
> > + * FreeBSD process related emulation code
> >   *
> > - *  Copyright (c) 2013-15 Stacey D. Son
> > + * Copyright (c) 2013-2014 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >  #include "qemu/osdep.h"
> >
> > diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
> > index cc53215138..72ccf23e17 100644
> > --- a/bsd-user/freebsd/os-proc.h
> > +++ b/bsd-user/freebsd/os-proc.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  process related system call shims and definitions
> > + * process related system call shims and definitions
> >   *
> > - *  Copyright (c) 2013-14 Stacey D. Son
> > + * Copyright (c) 2013-2014 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef BSD_USER_FREEBSD_OS_PROC_H
> >  #define BSD_USER_FREEBSD_OS_PROC_H
> >
> > diff --git a/bsd-user/freebsd/os-stat.c b/bsd-user/freebsd/os-stat.c
> > index f0f9e609c3..10870430fe 100644
> > --- a/bsd-user/freebsd/os-stat.c
> > +++ b/bsd-user/freebsd/os-stat.c
> > @@ -1,20 +1,9 @@
> >  /*
> > - *  FreeBSD stat related conversion routines
> > + * FreeBSD stat related conversion routines
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >  #include "qemu/osdep.h"
> >
> > diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
> > index 3bdc66aa98..ea95aa6344 100644
> > --- a/bsd-user/freebsd/os-stat.h
> > +++ b/bsd-user/freebsd/os-stat.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  stat related system call shims and definitions
> > + * stat related system call shims and definitions
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef BSD_USER_FREEBSD_OS_STAT_H
> >  #define BSD_USER_FREEBSD_OS_STAT_H
> >
> > diff --git a/bsd-user/freebsd/os-strace.h b/bsd-user/freebsd/os-strace.=
h
> > index a222f093b5..ad48e99db1 100644
> > --- a/bsd-user/freebsd/os-strace.h
> > +++ b/bsd-user/freebsd/os-strace.h
> > @@ -1,25 +1,12 @@
> >  /*
> > - *  FreeBSD dependent strace print functions
> > + * FreeBSD dependent strace print functions
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #include "target_arch_sysarch.h"    /* architecture dependent function=
s
> */
> >
> > -
> >  static inline void do_os_print_sysarch(const struct syscallname *name,
> >          abi_long arg1, abi_long arg2, abi_long arg3, abi_long arg4,
> >          abi_long arg5, abi_long arg6)
> > diff --git a/bsd-user/freebsd/target_os_elf.h
> b/bsd-user/freebsd/target_os_elf.h
> > index 01124979f7..c67e5a0f8e 100644
> > --- a/bsd-user/freebsd/target_os_elf.h
> > +++ b/bsd-user/freebsd/target_os_elf.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  freebsd ELF definitions
> > + * FreeBSD ELF definitions
> >   *
> > - *  Copyright (c) 2013-15 Stacey D. Son
> > + * Copyright (c) 2013-2015 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_OS_ELF_H
> >  #define TARGET_OS_ELF_H
> >
> > diff --git a/bsd-user/freebsd/target_os_siginfo.h
> b/bsd-user/freebsd/target_os_siginfo.h
> > index 6c282d8502..e7cf76b9bd 100644
> > --- a/bsd-user/freebsd/target_os_siginfo.h
> > +++ b/bsd-user/freebsd/target_os_siginfo.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  FreeBSD siginfo related definitions
> > + * FreeBSD siginfo related definitions
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_OS_SIGINFO_H
> >  #define TARGET_OS_SIGINFO_H
> >
> > diff --git a/bsd-user/freebsd/target_os_stack.h
> b/bsd-user/freebsd/target_os_stack.h
> > index ac0ef22cd7..262f33d839 100644
> > --- a/bsd-user/freebsd/target_os_stack.h
> > +++ b/bsd-user/freebsd/target_os_stack.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  FreeBSD setup_initial_stack() implementation.
> > + * FreeBSD setup_initial_stack() implementation.
> >   *
> > - *  Copyright (c) 2013-14 Stacey D. Son
> > + * Copyright (c) 2013-2014 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_OS_STACK_H
> >  #define TARGET_OS_STACK_H
> >
> > diff --git a/bsd-user/freebsd/target_os_thread.h
> b/bsd-user/freebsd/target_os_thread.h
> > index 1b32cebd26..ff88679e40 100644
> > --- a/bsd-user/freebsd/target_os_thread.h
> > +++ b/bsd-user/freebsd/target_os_thread.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  FreeBSD thread dependent code and definitions
> > + * FreeBSD thread dependent code and definitions
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_OS_THREAD_H
> >  #define TARGET_OS_THREAD_H
> >
> > diff --git a/bsd-user/freebsd/target_os_user.h
> b/bsd-user/freebsd/target_os_user.h
> > index 1ca7b5ab17..9703b9a61a 100644
> > --- a/bsd-user/freebsd/target_os_user.h
> > +++ b/bsd-user/freebsd/target_os_user.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  sys/user.h definitions
> > + * sys/user.h definitions
> >   *
> > - *  Copyright (c) 2015 Stacey D. Son (sson at FreeBSD)
> > + * Copyright (c) 2015 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_OS_USER_H
> >  #define TARGET_OS_USER_H
> >
> > diff --git a/bsd-user/freebsd/target_os_vmparam.h
> b/bsd-user/freebsd/target_os_vmparam.h
> > index 8457dd3913..9feec5296d 100644
> > --- a/bsd-user/freebsd/target_os_vmparam.h
> > +++ b/bsd-user/freebsd/target_os_vmparam.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  FreeBSD VM parameters definitions
> > + * FreeBSD VM parameters definitions
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_OS_VMPARAM_H
> >  #define TARGET_OS_VMPARAM_H
> >
> > diff --git a/bsd-user/i386/signal.c b/bsd-user/i386/signal.c
> > index a3131047b8..742032090d 100644
> > --- a/bsd-user/i386/signal.c
> > +++ b/bsd-user/i386/signal.c
> > @@ -1,20 +1,9 @@
> >  /*
> > - *  i386 dependent signal definitions
> > + * i386 dependent signal definitions
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >
> >  #include "qemu/osdep.h"
> > diff --git a/bsd-user/i386/target_arch.h b/bsd-user/i386/target_arch.h
> > index 9595e60f09..74c8e7fb47 100644
> > --- a/bsd-user/i386/target_arch.h
> > +++ b/bsd-user/i386/target_arch.h
> > @@ -1,22 +1,10 @@
> >  /*
> >   * Intel x86 specific prototypes for bsd-user
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_H
> >  #define TARGET_ARCH_H
> >
> > diff --git a/bsd-user/i386/target_arch_cpu.c
> b/bsd-user/i386/target_arch_cpu.c
> > index 2a3af2ddef..fa8ad4b385 100644
> > --- a/bsd-user/i386/target_arch_cpu.c
> > +++ b/bsd-user/i386/target_arch_cpu.c
> > @@ -1,20 +1,9 @@
> >  /*
> > - *  i386 cpu related code
> > + * i386 cpu related code
> >   *
> > - * Copyright (c) 2013 Stacey Son <sson@FreeBSD.org>
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >
> >  #include "qemu/osdep.h"
> > diff --git a/bsd-user/i386/target_arch_cpu.h
> b/bsd-user/i386/target_arch_cpu.h
> > index f147d5b6f8..c6e8bfd8ca 100644
> > --- a/bsd-user/i386/target_arch_cpu.h
> > +++ b/bsd-user/i386/target_arch_cpu.h
> > @@ -1,21 +1,10 @@
> >  /*
> > - *  i386 cpu init and loop
> > + * i386 cpu init and loop
> >   *
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_CPU_H
> >  #define TARGET_ARCH_CPU_H
> >
> > diff --git a/bsd-user/i386/target_arch_elf.h
> b/bsd-user/i386/target_arch_elf.h
> > index 4ac27b02e7..99cff66a22 100644
> > --- a/bsd-user/i386/target_arch_elf.h
> > +++ b/bsd-user/i386/target_arch_elf.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  i386 ELF definitions
> > + * i386 ELF definitions
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_ELF_H
> >  #define TARGET_ARCH_ELF_H
> >
> > diff --git a/bsd-user/i386/target_arch_reg.h
> b/bsd-user/i386/target_arch_reg.h
> > index 8123109697..cebf2fd5cc 100644
> > --- a/bsd-user/i386/target_arch_reg.h
> > +++ b/bsd-user/i386/target_arch_reg.h
> > @@ -1,23 +1,10 @@
> >  /*
> > - *  FreeBSD i386 register structures
> > + * FreeBSD i386 register structures
> >   *
> > - *  Copyright (c) 2015 Stacey Son
> > - *  All rights reserved.
> > + * Copyright (c) 2015 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_REG_H
> >  #define TARGET_ARCH_REG_H
> >
> > diff --git a/bsd-user/i386/target_arch_signal.h
> b/bsd-user/i386/target_arch_signal.h
> > index 2c14153ab6..070ba4357a 100644
> > --- a/bsd-user/i386/target_arch_signal.h
> > +++ b/bsd-user/i386/target_arch_signal.h
> > @@ -1,19 +1,9 @@
> >  /*
> > - *  i386 dependent signal definitions
> > + * i386 dependent signal definitions
> >   *
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >  #ifndef TARGET_ARCH_SIGNAL_H
> >  #define TARGET_ARCH_SIGNAL_H
> > diff --git a/bsd-user/i386/target_arch_sigtramp.h
> b/bsd-user/i386/target_arch_sigtramp.h
> > index ef94cc864f..ace243b6f5 100644
> > --- a/bsd-user/i386/target_arch_sigtramp.h
> > +++ b/bsd-user/i386/target_arch_sigtramp.h
> > @@ -1,22 +1,10 @@
> >  /*
> >   * Intel i386  sigcode for bsd-user
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_SIGTRAMP_H
> >  #define TARGET_ARCH_SIGTRAMP_H
> >
> > diff --git a/bsd-user/i386/target_arch_sysarch.h
> b/bsd-user/i386/target_arch_sysarch.h
> > index db8fee6380..7b128dfab1 100644
> > --- a/bsd-user/i386/target_arch_sysarch.h
> > +++ b/bsd-user/i386/target_arch_sysarch.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  i386 sysarch system call emulation
> > + * i386 sysarch system call emulation
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_SYSARCH_H
> >  #define TARGET_ARCH_SYSARCH_H
> >
> > diff --git a/bsd-user/i386/target_arch_thread.h
> b/bsd-user/i386/target_arch_thread.h
> > index cee2148d94..8ef4f6b648 100644
> > --- a/bsd-user/i386/target_arch_thread.h
> > +++ b/bsd-user/i386/target_arch_thread.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  i386 thread support
> > + * i386 thread support
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_THREAD_H
> >  #define TARGET_ARCH_THREAD_H
> >
> > diff --git a/bsd-user/i386/target_arch_vmparam.h
> b/bsd-user/i386/target_arch_vmparam.h
> > index 79db420e59..cdf6ab0a49 100644
> > --- a/bsd-user/i386/target_arch_vmparam.h
> > +++ b/bsd-user/i386/target_arch_vmparam.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  i386 VM parameters definitions
> > + * i386 VM parameters definitions
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_VMPARAM_H
> >  #define TARGET_ARCH_VMPARAM_H
> >
> > diff --git a/bsd-user/i386/target_syscall.h
> b/bsd-user/i386/target_syscall.h
> > index 940c687a52..a52851f635 100644
> > --- a/bsd-user/i386/target_syscall.h
> > +++ b/bsd-user/i386/target_syscall.h
> > @@ -1,19 +1,9 @@
> >  /*
> > - *  i386 system call definitions
> > + * i386 system call definitions
> >   *
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >  #ifndef TARGET_SYSCALL_H
> >  #define TARGET_SYSCALL_H
> > diff --git a/bsd-user/main.c b/bsd-user/main.c
> > index 73aae8c327..84351e1631 100644
> > --- a/bsd-user/main.c
> > +++ b/bsd-user/main.c
> > @@ -1,23 +1,11 @@
> >  /*
> > - *  qemu bsd user main
> > + * qemu bsd user main
> >   *
> > - *  Copyright (c) 2003-2008 Fabrice Bellard
> > - *  Copyright (c) 2013-14 Stacey Son
> > + * Copyright (c) 2003-2008 Fabrice Bellard
> > + * Copyright (c) 2013-14 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #include "qemu/osdep.h"
> >  #include <sys/resource.h>
> >  #include <sys/sysctl.h>
> > diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
> > index 24ba1728eb..fb685e84aa 100644
> > --- a/bsd-user/mmap.c
> > +++ b/bsd-user/mmap.c
> > @@ -1,20 +1,9 @@
> >  /*
> > - *  mmap support for qemu
> > + * mmap support for qemu
> >   *
> > - *  Copyright (c) 2003 - 2008 Fabrice Bellard
> > + * Copyright (c) 2003 - 2008 Fabrice Bellard
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >  #include "qemu/osdep.h"
> >  #include "exec/mmap-lock.h"
> > diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
> > index 56affcd31d..64d4fbe3a9 100644
> > --- a/bsd-user/qemu-bsd.h
> > +++ b/bsd-user/qemu-bsd.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  BSD conversion extern declarations
> > + * BSD conversion extern declarations
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef QEMU_BSD_H
> >  #define QEMU_BSD_H
> >
> > diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> > index 93388e7c34..c4ff1fb0eb 100644
> > --- a/bsd-user/qemu.h
> > +++ b/bsd-user/qemu.h
> > @@ -1,18 +1,9 @@
> >  /*
> > - *  qemu bsd user mode definition
> > + * qemu bsd user mode definition
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >  #ifndef QEMU_H
> >  #define QEMU_H
> > diff --git a/bsd-user/signal.c b/bsd-user/signal.c
> > index dadcc037dc..832ffef7c5 100644
> > --- a/bsd-user/signal.c
> > +++ b/bsd-user/signal.c
> > @@ -1,21 +1,10 @@
> >  /*
> > - *  Emulation of BSD signals
> > + * Emulation of BSD signals
> >   *
> > - *  Copyright (c) 2003 - 2008 Fabrice Bellard
> > - *  Copyright (c) 2013 Stacey Son
> > + * Copyright (c) 2003 - 2008 Fabrice Bellard
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >
> >  #include "qemu/osdep.h"
> > diff --git a/bsd-user/strace.c b/bsd-user/strace.c
> > index 6dc01d3be7..a015bfddba 100644
> > --- a/bsd-user/strace.c
> > +++ b/bsd-user/strace.c
> > @@ -1,19 +1,9 @@
> >  /*
> > - *  System call tracing and debugging
> > + * System call tracing and debugging
> >   *
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >
> >  #include "qemu/osdep.h"
> > diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
> > index cc4b484f3a..a2ded2fac1 100644
> > --- a/bsd-user/syscall_defs.h
> > +++ b/bsd-user/syscall_defs.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  System call related declarations
> > + * System call related declarations
> >   *
> > - *  Copyright (c) 2013-15 Stacey D. Son (sson at FreeBSD)
> > + * Copyright (c) 2013-2015 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef SYSCALL_DEFS_H
> >  #define SYSCALL_DEFS_H
> >
> > diff --git a/bsd-user/x86_64/signal.c b/bsd-user/x86_64/signal.c
> > index 46cb865180..823d7217ad 100644
> > --- a/bsd-user/x86_64/signal.c
> > +++ b/bsd-user/x86_64/signal.c
> > @@ -1,19 +1,9 @@
> >  /*
> > - *  x86_64 signal definitions
> > + * x86_64 signal definitions
> >   *
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >
> >  #include "qemu/osdep.h"
> > diff --git a/bsd-user/x86_64/target_arch.h
> b/bsd-user/x86_64/target_arch.h
> > index 09bd974889..177e6b442a 100644
> > --- a/bsd-user/x86_64/target_arch.h
> > +++ b/bsd-user/x86_64/target_arch.h
> > @@ -1,22 +1,10 @@
> >  /*
> >   * Intel x86_64 specific prototypes for bsd-user
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_H
> >  #define TARGET_ARCH_H
> >
> > diff --git a/bsd-user/x86_64/target_arch_cpu.c
> b/bsd-user/x86_64/target_arch_cpu.c
> > index 1d32f18907..aeeb1235c9 100644
> > --- a/bsd-user/x86_64/target_arch_cpu.c
> > +++ b/bsd-user/x86_64/target_arch_cpu.c
> > @@ -1,20 +1,9 @@
> >  /*
> > - *  x86_64 cpu related code
> > + * x86_64 cpu related code
> >   *
> > - * Copyright (c) 2013 Stacey Son <sson@FreeBSD.org>
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >
> >  #include "qemu/osdep.h"
> > diff --git a/bsd-user/x86_64/target_arch_cpu.h
> b/bsd-user/x86_64/target_arch_cpu.h
> > index 1fa71d87f1..f12a8ab49e 100644
> > --- a/bsd-user/x86_64/target_arch_cpu.h
> > +++ b/bsd-user/x86_64/target_arch_cpu.h
> > @@ -1,21 +1,10 @@
> >  /*
> > - *  x86_64 cpu init and loop
> > + * x86_64 cpu init and loop
> >   *
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_CPU_H
> >  #define TARGET_ARCH_CPU_H
> >
> > diff --git a/bsd-user/x86_64/target_arch_elf.h
> b/bsd-user/x86_64/target_arch_elf.h
> > index e51c2faf08..020533904e 100644
> > --- a/bsd-user/x86_64/target_arch_elf.h
> > +++ b/bsd-user/x86_64/target_arch_elf.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  x86_64 ELF definitions
> > + * x86_64 ELF definitions
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2015 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_ELF_H
> >  #define TARGET_ARCH_ELF_H
> >
> > diff --git a/bsd-user/x86_64/target_arch_reg.h
> b/bsd-user/x86_64/target_arch_reg.h
> > index 7a766de918..c0c766ac1a 100644
> > --- a/bsd-user/x86_64/target_arch_reg.h
> > +++ b/bsd-user/x86_64/target_arch_reg.h
> > @@ -1,23 +1,10 @@
> >  /*
> > - *  FreeBSD amd64 register structures
> > + * FreeBSD amd64 register structures
> >   *
> > - *  Copyright (c) 2015 Stacey Son
> > - *  All rights reserved.
> > + * Copyright (c) 2015 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_REG_H
> >  #define TARGET_ARCH_REG_H
> >
> > diff --git a/bsd-user/x86_64/target_arch_signal.h
> b/bsd-user/x86_64/target_arch_signal.h
> > index f833ee66ce..2b63048f8b 100644
> > --- a/bsd-user/x86_64/target_arch_signal.h
> > +++ b/bsd-user/x86_64/target_arch_signal.h
> > @@ -1,21 +1,10 @@
> >  /*
> > - *  x86_64 signal definitions
> > + * x86_64 signal definitions
> >   *
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_SIGNAL_H
> >  #define TARGET_ARCH_SIGNAL_H
> >
> > diff --git a/bsd-user/x86_64/target_arch_sigtramp.h
> b/bsd-user/x86_64/target_arch_sigtramp.h
> > index 01da614098..cab22fb7e8 100644
> > --- a/bsd-user/x86_64/target_arch_sigtramp.h
> > +++ b/bsd-user/x86_64/target_arch_sigtramp.h
> > @@ -1,29 +1,16 @@
> >  /*
> >   * Intel x86_64  sigcode for bsd-user
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_SIGTRAMP_H
> >  #define TARGET_ARCH_SIGTRAMP_H
> >
> >  static inline abi_long setup_sigtramp(abi_ulong offset, unsigned
> sigf_uc,
> >          unsigned sys_sigreturn)
> >  {
> > -
> >      return 0;
> >  }
> >  #endif /* TARGET_ARCH_SIGTRAMP_H */
> > diff --git a/bsd-user/x86_64/target_arch_sysarch.h
> b/bsd-user/x86_64/target_arch_sysarch.h
> > index 152cb8bcb8..3a6f74161f 100644
> > --- a/bsd-user/x86_64/target_arch_sysarch.h
> > +++ b/bsd-user/x86_64/target_arch_sysarch.h
> > @@ -1,21 +1,10 @@
> >  /*
> > - *  x86_64 sysarch() syscall emulation
> > + * x86_64 sysarch() syscall emulation
> >   *
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_SYSARCH_H
> >  #define TARGET_ARCH_SYSARCH_H
> >
> > diff --git a/bsd-user/x86_64/target_arch_thread.h
> b/bsd-user/x86_64/target_arch_thread.h
> > index 7739bb2154..176c347037 100644
> > --- a/bsd-user/x86_64/target_arch_thread.h
> > +++ b/bsd-user/x86_64/target_arch_thread.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  x86_64 thread support
> > + * x86_64 thread support
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_THREAD_H
> >  #define TARGET_ARCH_THREAD_H
> >
> > diff --git a/bsd-user/x86_64/target_arch_vmparam.h
> b/bsd-user/x86_64/target_arch_vmparam.h
> > index 6797623a6b..8919c5e6e5 100644
> > --- a/bsd-user/x86_64/target_arch_vmparam.h
> > +++ b/bsd-user/x86_64/target_arch_vmparam.h
> > @@ -1,22 +1,10 @@
> >  /*
> > - *  Intel x86_64 VM parameters definitions
> > + * Intel x86_64 VM parameters definitions
> >   *
> > - *  Copyright (c) 2013 Stacey D. Son
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> > -
> >  #ifndef TARGET_ARCH_VMPARAM_H
> >  #define TARGET_ARCH_VMPARAM_H
> >
> > diff --git a/bsd-user/x86_64/target_syscall.h
> b/bsd-user/x86_64/target_syscall.h
> > index a8e6274b76..5adced9bde 100644
> > --- a/bsd-user/x86_64/target_syscall.h
> > +++ b/bsd-user/x86_64/target_syscall.h
> > @@ -1,19 +1,9 @@
> >  /*
> > - *  x86_64 system call definitions
> > + * x86_64 system call definitions
> >   *
> > + * Copyright (c) 2013 Stacey D. Son
> >   *
> > - *  This program is free software; you can redistribute it and/or modi=
fy
> > - *  it under the terms of the GNU General Public License as published =
by
> > - *  the Free Software Foundation; either version 2 of the License, or
> > - *  (at your option) any later version.
> > - *
> > - *  This program is distributed in the hope that it will be useful,
> > - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *  GNU General Public License for more details.
> > - *
> > - *  You should have received a copy of the GNU General Public License
> > - *  along with this program; if not, see <http://www.gnu.org/licenses/
> >.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >  #ifndef TARGET_SYSCALL_H
> >  #define TARGET_SYSCALL_H
> >
> > ---
> > base-commit: ffcf1a7981793973ffbd8100a7c3c6042d02ae23
> > change-id: 20260302-bsd-user-copyright-3a46d2307150
> >
> > Best regards,
> > --
> > Warner Losh <imp@bsdimp.com>
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--000000000000c86f40064c1daf9d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 3, =
2026 at 1:51=E2=80=AFAM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berra=
nge@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On Mon, Mar 02, 2026 at 09:46:06PM -0700=
, Warner Losh wrote:<br>
&gt; Switch all the files over to using SPDX. This also corrects various<br=
>
&gt; small errors in the form of the copyright messages. It adds copyright =
to<br>
&gt; those files that lack it. There&#39;s no functional change.<br>
&gt; <br>
&gt; Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" targe=
t=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt; ---<br>
&gt; Since I&#39;ll be upstreaming more files from bsd-user, and since qemu=
 now<br>
&gt; requires SPDX and prohibits boilerplate, this will make it easier. I&#=
39;ve<br>
&gt; converted all the relevant bits in bsd-user upstream.<br>
<br>
Note, QEMU / <a href=3D"http://checkpatch.pl" rel=3D"noreferrer" target=3D"=
_blank">checkpatch.pl</a> only requires SDPX on *newly* authored files.<br>
Existing code files, or new files whose content is copied from an<br>
existing file (either inside or outside QEMU git) are exempt from this<br>
and in fact required to be left without SPDX.<br>
<br>
The reasoning is that there is some uncertainty about the legality of<br>
removing license header text from existing files due to the GPL clause<br>
1 which says<br>
<br>
=C2=A0 &quot;keep intact all the notices that refer to this License and<br>
=C2=A0 =C2=A0to the absence of any warranty;&quot;<br>
<br>
I interpret that to mean we can not remove license header text from<br>
files unless the person doing the removal is the exclusive copyright<br>
holder, or has got recorded permission from all copyright holders<br>
that apply to each file changed.<br>
<br>
It is confusing for people because Linux removed all their GPL header<br>
text in favour of SPDX, but never provided any clear explanation of<br>
why they considered that to be acceptable from the GPL compliance POV.<br><=
/blockquote><div><br></div><div>So I have Stacey&#39;s permission to do thi=
s, and he&#39;s the only actual copyright</div><div>holder on these files. =
If I messed up on any, specifically, please let me know.</div><div>That&#39=
;s why I included his signed-off-by: he signed off on it and that he&#39;s =
legally</div><div>able to make the change.</div><div><br></div><div>Also, I=
 did this to reduce friction in upstreaming bsd-user which has been</div><d=
iv>going on for 6ish years now. The SPDX rule is one more thing that slows<=
/div><div>that down. Rather than get an exception to the rule, I brought ev=
erything</div><div>into compliance so it isn&#39;t yet another issue that t=
akes more time because</div><div>I forgot to do it for a specific patch ser=
ies. The more issues I have to have</div><div>on my checklist, the more the=
 works are gummed up and the slower the</div><div>progress is. We still hav=
e somethign like=C2=A0~30k lines to go last I checked.</div><div><br></div>=
<div>Also, these files have also been out of tree for over a decade. The ne=
w</div><div>rule forces me to do what you&#39;re complaining about the Linu=
x tree doing:</div><div>remove GPL markings to get it into your tree. Well =
which is it?=C2=A0 Either it&#39;s</div><div>wrong and I shouldn&#39;t have=
 to do it for the old files.=C2=A0 Or what I&#39;ve done</div><div>is prope=
r since it&#39;s uniform. Your tree is just an arbitrary repo of these</div=
><div>files, and isn&#39;t special in any meaningful way. So I&#39;m in a n=
o-win situation</div><div>here by your argument.</div><div><br></div><div><=
span style=3D"background-color:rgba(243,248,255,0.965)">Also, when I talk a=
bout a burdensome and cumbersome upstreaming process,</span></div><div><spa=
n style=3D"background-color:rgba(243,248,255,0.965)">this is yet another ex=
ample. An arbitrary rule that causes friction, but provides</span></div><di=
v><span style=3D"background-color:rgba(243,248,255,0.965)">no actual benefi=
t. It&#39;s like the style rules: I have to arbitrarily reformat code that<=
/span></div><div><span style=3D"background-color:rgba(243,248,255,0.965)">i=
s like that in linux-user because this is &quot;new code&quot;. So I spend =
a fair amount of</span></div><div><span style=3D"background-color:rgba(243,=
248,255,0.965)">time fetching different stones to obey the rules, but since=
 now the code is different</span></div><div><span style=3D"background-color=
:rgba(243,248,255,0.965)">it becomes harder to track linux-user or to ever =
converge them. Change for the</span></div><div><span style=3D"background-co=
lor:rgba(243,248,255,0.965)">sake of compliance with an arbitrary rule that=
 doesn&#39;t apply elsewhere (for whatever</span></div><div><span style=3D"=
background-color:rgba(243,248,255,0.965)">reason) is one of the death by a =
thousand cuts I, and others doing this work, have</span></div><div><span st=
yle=3D"background-color:rgba(243,248,255,0.965)">been suffering for far too=
 long. It&#39;s in large measure why things aren&#39;t further along:</span=
></div><div><span style=3D"background-color:rgba(243,248,255,0.965)">it ste=
als what little time I have for this and it demotivates further work for a =
while.</span></div><div><span style=3D"background-color:rgba(243,248,255,0.=
965)"><br></span></div><div><span style=3D"background-color:rgba(243,248,25=
5,0.965)">Note: I&#39;m specifically not complaining about the code review =
that finds actual</span></div><div><span style=3D"background-color:rgba(243=
,248,255,0.965)">problems. That&#39;s quite useful and has improved the qua=
lity. So I&#39;ve not tried to do</span></div><div><span style=3D"backgroun=
d-color:rgba(243,248,255,0.965)">any &#39;maintainer reviewed&#39; end-run =
around this process since it has been helpful,</span></div><div><span style=
=3D"background-color:rgba(243,248,255,0.965)">though also timeconsuming at =
times.</span></div><div><span style=3D"background-color:rgba(243,248,255,0.=
965)"><br></span></div><div>So, having said that, is there any specific obj=
ection to anything I&#39;ve done? Given</div><div>Stacey&#39;s explicit ble=
ssing of this change (you&#39;ll recall from the patch series I just did</d=
iv><div>I waited until I had contacted him before I changing it there), did=
 I mess up anywhere?</div><div><br></div><div>Warner</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; ---<br>
&gt;=C2=A0 bsd-user/aarch64/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 15 ++-------------<br>
&gt;=C2=A0 bsd-user/aarch64/target_arch.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | 16 ++--------------<br>
&gt;=C2=A0 bsd-user/aarch64/target_arch_cpu.c=C2=A0 =C2=A0 =C2=A0 | 15 ++--=
-----------<br>
&gt;=C2=A0 bsd-user/aarch64/target_arch_cpu.h=C2=A0 =C2=A0 =C2=A0 | 18 +++-=
--------------<br>
&gt;=C2=A0 bsd-user/aarch64/target_arch_elf.h=C2=A0 =C2=A0 =C2=A0 | 14 +---=
----------<br>
&gt;=C2=A0 bsd-user/aarch64/target_arch_reg.h=C2=A0 =C2=A0 =C2=A0 | 19 +++-=
---------------<br>
&gt;=C2=A0 bsd-user/aarch64/target_arch_signal.h=C2=A0 =C2=A0| 16 ++-------=
-------<br>
&gt;=C2=A0 bsd-user/aarch64/target_arch_sigtramp.h | 16 ++--------------<br=
>
&gt;=C2=A0 bsd-user/aarch64/target_arch_sysarch.h=C2=A0 | 16 ++------------=
--<br>
&gt;=C2=A0 bsd-user/aarch64/target_arch_thread.h=C2=A0 =C2=A0| 16 ++-------=
-------<br>
&gt;=C2=A0 bsd-user/aarch64/target_arch_vmparam.h=C2=A0 | 16 ++------------=
--<br>
&gt;=C2=A0 bsd-user/aarch64/target_syscall.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 16=
 ++--------------<br>
&gt;=C2=A0 bsd-user/arm/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| 18 +++---------------<br>
&gt;=C2=A0 bsd-user/arm/target_arch.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 16 ++--------------<br>
&gt;=C2=A0 bsd-user/arm/target_arch_cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | 18 +++---------------<br>
&gt;=C2=A0 bsd-user/arm/target_arch_cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | 18 +++---------------<br>
&gt;=C2=A0 bsd-user/arm/target_arch_elf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | 18 +++---------------<br>
&gt;=C2=A0 bsd-user/arm/target_arch_reg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | 18 +++---------------<br>
&gt;=C2=A0 bsd-user/arm/target_arch_signal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 18=
 +++---------------<br>
&gt;=C2=A0 bsd-user/arm/target_arch_sigtramp.h=C2=A0 =C2=A0 =C2=A0| 18 +++-=
--------------<br>
&gt;=C2=A0 bsd-user/arm/target_arch_sysarch.h=C2=A0 =C2=A0 =C2=A0 | 18 +++-=
--------------<br>
&gt;=C2=A0 bsd-user/arm/target_arch_thread.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 18=
 +++---------------<br>
&gt;=C2=A0 bsd-user/arm/target_arch_vmparam.h=C2=A0 =C2=A0 =C2=A0 | 18 +++-=
--------------<br>
&gt;=C2=A0 bsd-user/arm/target_syscall.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 18 +++---------------<br>
&gt;=C2=A0 bsd-user/bsd-file.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 18 +++---------------<br>
&gt;=C2=A0 bsd-user/bsd-mem.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 17 +++--------------<br>
&gt;=C2=A0 bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 17 +++--------------<br>
&gt;=C2=A0 bsd-user/bsd-proc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 17 +++--------------<br>
&gt;=C2=A0 bsd-user/bsd-proc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 17 +++--------------<br>
&gt;=C2=A0 bsd-user/bsdload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 17 +++--------------<br>
&gt;=C2=A0 bsd-user/elfload.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 17 +++--------------<br>
&gt;=C2=A0 bsd-user/freebsd/os-misc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 18 +++---------------<br>
&gt;=C2=A0 bsd-user/freebsd/os-proc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 17 +++--------------<br>
&gt;=C2=A0 bsd-user/freebsd/os-proc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 18 +++---------------<br>
&gt;=C2=A0 bsd-user/freebsd/os-stat.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 17 +++--------------<br>
&gt;=C2=A0 bsd-user/freebsd/os-stat.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 18 +++---------------<br>
&gt;=C2=A0 bsd-user/freebsd/os-strace.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 19 +++----------------<br>
&gt;=C2=A0 bsd-user/freebsd/target_os_elf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 18=
 +++---------------<br>
&gt;=C2=A0 bsd-user/freebsd/target_os_siginfo.h=C2=A0 =C2=A0 | 18 +++------=
---------<br>
&gt;=C2=A0 bsd-user/freebsd/target_os_stack.h=C2=A0 =C2=A0 =C2=A0 | 18 +++-=
--------------<br>
&gt;=C2=A0 bsd-user/freebsd/target_os_thread.h=C2=A0 =C2=A0 =C2=A0| 18 +++-=
--------------<br>
&gt;=C2=A0 bsd-user/freebsd/target_os_user.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 18=
 +++---------------<br>
&gt;=C2=A0 bsd-user/freebsd/target_os_vmparam.h=C2=A0 =C2=A0 | 18 +++------=
---------<br>
&gt;=C2=A0 bsd-user/i386/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 17 +++--------------<br>
&gt;=C2=A0 bsd-user/i386/target_arch.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 16 ++--------------<br>
&gt;=C2=A0 bsd-user/i386/target_arch_cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 17 +++--------------<br>
&gt;=C2=A0 bsd-user/i386/target_arch_cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 17 +++--------------<br>
&gt;=C2=A0 bsd-user/i386/target_arch_elf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 18 +++---------------<br>
&gt;=C2=A0 bsd-user/i386/target_arch_reg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 19 +++----------------<br>
&gt;=C2=A0 bsd-user/i386/target_arch_signal.h=C2=A0 =C2=A0 =C2=A0 | 16 +++-=
------------<br>
&gt;=C2=A0 bsd-user/i386/target_arch_sigtramp.h=C2=A0 =C2=A0 | 16 ++-------=
-------<br>
&gt;=C2=A0 bsd-user/i386/target_arch_sysarch.h=C2=A0 =C2=A0 =C2=A0| 18 +++-=
--------------<br>
&gt;=C2=A0 bsd-user/i386/target_arch_thread.h=C2=A0 =C2=A0 =C2=A0 | 18 +++-=
--------------<br>
&gt;=C2=A0 bsd-user/i386/target_arch_vmparam.h=C2=A0 =C2=A0 =C2=A0| 18 +++-=
--------------<br>
&gt;=C2=A0 bsd-user/i386/target_syscall.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | 16 +++-------------<br>
&gt;=C2=A0 bsd-user/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 20 ++++----------------<br>
&gt;=C2=A0 bsd-user/mmap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 17 +++--------------<br>
&gt;=C2=A0 bsd-user/qemu-bsd.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 18 +++---------------<br>
&gt;=C2=A0 bsd-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 15 +++------------<br>
&gt;=C2=A0 bsd-user/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 19 ++++---------------<br>
&gt;=C2=A0 bsd-user/strace.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 16 +++-------------<br>
&gt;=C2=A0 bsd-user/syscall_defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| 18 +++---------------<br>
&gt;=C2=A0 bsd-user/x86_64/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 16 +++-------------<br>
&gt;=C2=A0 bsd-user/x86_64/target_arch.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 16 ++--------------<br>
&gt;=C2=A0 bsd-user/x86_64/target_arch_cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 17=
 +++--------------<br>
&gt;=C2=A0 bsd-user/x86_64/target_arch_cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 17=
 +++--------------<br>
&gt;=C2=A0 bsd-user/x86_64/target_arch_elf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 18=
 +++---------------<br>
&gt;=C2=A0 bsd-user/x86_64/target_arch_reg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 19=
 +++----------------<br>
&gt;=C2=A0 bsd-user/x86_64/target_arch_signal.h=C2=A0 =C2=A0 | 17 +++------=
--------<br>
&gt;=C2=A0 bsd-user/x86_64/target_arch_sigtramp.h=C2=A0 | 17 ++------------=
---<br>
&gt;=C2=A0 bsd-user/x86_64/target_arch_sysarch.h=C2=A0 =C2=A0| 17 +++------=
--------<br>
&gt;=C2=A0 bsd-user/x86_64/target_arch_thread.h=C2=A0 =C2=A0 | 18 +++------=
---------<br>
&gt;=C2=A0 bsd-user/x86_64/target_arch_vmparam.h=C2=A0 =C2=A0| 18 +++------=
---------<br>
&gt;=C2=A0 bsd-user/x86_64/target_syscall.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 16=
 +++-------------<br>
&gt;=C2=A0 74 files changed, 208 insertions(+), 1069 deletions(-)<br>
&gt; <br>
&gt; diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c<br>
&gt; index 6bc73a798f..ad19e5144e 100644<br>
&gt; --- a/bsd-user/aarch64/signal.c<br>
&gt; +++ b/bsd-user/aarch64/signal.c<br>
&gt; @@ -1,20 +1,9 @@<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* ARM AArch64 specific signal definitions for bsd-user<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * Copyright (c) 2015 Stacey D. Son &lt;sson at FreeBSD&gt;<br>
&gt; + * Copyright (c) 2015 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * This library is free software; you can redistribute it and/or<br>
&gt; - * modify it under the terms of the GNU Lesser General Public<br>
&gt; - * License as published by the Free Software Foundation; either<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; - *<br>
&gt; - * This library is distributed in the hope that it will be useful,<br=
>
&gt; - * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU<br>
&gt; - * Lesser General Public License for more details.<br>
&gt; - *<br>
&gt; - * You should have received a copy of the GNU Lesser General Public<b=
r>
&gt; - * License along with this library; if not, see &lt;<a href=3D"http:/=
/www.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu=
.org/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/aarch64/target_arch.h b/bsd-user/aarch64/target_=
arch.h<br>
&gt; index 4815a56ae3..7861233889 100644<br>
&gt; --- a/bsd-user/aarch64/target_arch.h<br>
&gt; +++ b/bsd-user/aarch64/target_arch.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* ARM AArch64 specific prototypes for bsd-user<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * Copyright (c) 2015 Stacey D. Son &lt;sson at FreeBSD&gt;<br>
&gt; + * Copyright (c) 2015 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * This library is free software; you can redistribute it and/or<br>
&gt; - * modify it under the terms of the GNU Lesser General Public<br>
&gt; - * License as published by the Free Software Foundation; either<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; - *<br>
&gt; - * This library is distributed in the hope that it will be useful,<br=
>
&gt; - * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU<br>
&gt; - * Lesser General Public License for more details.<br>
&gt; - *<br>
&gt; - * You should have received a copy of the GNU Lesser General Public<b=
r>
&gt; - * License along with this library; if not, see &lt;<a href=3D"http:/=
/www.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu=
.org/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_H<br>
&gt;=C2=A0 #define TARGET_ARCH_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/aarch64/target_arch_cpu.c b/bsd-user/aarch64/tar=
get_arch_cpu.c<br>
&gt; index b2fa59efaf..6e9519e1b0 100644<br>
&gt; --- a/bsd-user/aarch64/target_arch_cpu.c<br>
&gt; +++ b/bsd-user/aarch64/target_arch_cpu.c<br>
&gt; @@ -1,20 +1,9 @@<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* ARM AArch64 specific CPU for bsd-user<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * Copyright (c) 2015 Stacey Son<br>
&gt; + * Copyright (c) 2015 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * This library is free software; you can redistribute it and/or<br>
&gt; - * modify it under the terms of the GNU Lesser General Public<br>
&gt; - * License as published by the Free Software Foundation; either<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; - *<br>
&gt; - * This library is distributed in the hope that it will be useful,<br=
>
&gt; - * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU<br>
&gt; - * Lesser General Public License for more details.<br>
&gt; - *<br>
&gt; - * You should have received a copy of the GNU Lesser General Public<b=
r>
&gt; - * License along with this library; if not, see &lt;<a href=3D"http:/=
/www.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu=
.org/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;target_arch.h&quot;<br>
&gt; diff --git a/bsd-user/aarch64/target_arch_cpu.h b/bsd-user/aarch64/tar=
get_arch_cpu.h<br>
&gt; index 15df84fda2..09d942b040 100644<br>
&gt; --- a/bsd-user/aarch64/target_arch_cpu.h<br>
&gt; +++ b/bsd-user/aarch64/target_arch_cpu.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 ARM AArch64 cpu init and loop<br>
&gt; + * ARM AArch64 cpu init and loop<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * Copyright (c) 2015 Stacey Son<br>
&gt; + * Copyright (c) 2015 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * This library is free software; you can redistribute it and/or<br>
&gt; - * modify it under the terms of the GNU Lesser General Public<br>
&gt; - * License as published by the Free Software Foundation; either<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; - *<br>
&gt; - * This library is distributed in the hope that it will be useful,<br=
>
&gt; - * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU<br>
&gt; - * Lesser General Public License for more details.<br>
&gt; - *<br>
&gt; - * You should have received a copy of the GNU Lesser General Public<b=
r>
&gt; - * License along with this library; if not, see &lt;<a href=3D"http:/=
/www.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu=
.org/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_CPU_H<br>
&gt;=C2=A0 #define TARGET_ARCH_CPU_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/aarch64/target_arch_elf.h b/bsd-user/aarch64/tar=
get_arch_elf.h<br>
&gt; index cec254f88b..5ea5232a57 100644<br>
&gt; --- a/bsd-user/aarch64/target_arch_elf.h<br>
&gt; +++ b/bsd-user/aarch64/target_arch_elf.h<br>
&gt; @@ -3,20 +3,8 @@<br>
&gt;=C2=A0 =C2=A0*<br>
&gt;=C2=A0 =C2=A0* Copyright (c) 2015 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * This library is free software; you can redistribute it and/or<br>
&gt; - * modify it under the terms of the GNU Lesser General Public<br>
&gt; - * License as published by the Free Software Foundation; either<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; - *<br>
&gt; - * This library is distributed in the hope that it will be useful,<br=
>
&gt; - * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU<br>
&gt; - * Lesser General Public License for more details.<br>
&gt; - *<br>
&gt; - * You should have received a copy of the GNU Lesser General Public<b=
r>
&gt; - * License along with this library; if not, see &lt;<a href=3D"http:/=
/www.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu=
.org/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_ELF_H<br>
&gt;=C2=A0 #define TARGET_ARCH_ELF_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/aarch64/target_arch_reg.h b/bsd-user/aarch64/tar=
get_arch_reg.h<br>
&gt; index b53302e7f7..9cca3c0ea0 100644<br>
&gt; --- a/bsd-user/aarch64/target_arch_reg.h<br>
&gt; +++ b/bsd-user/aarch64/target_arch_reg.h<br>
&gt; @@ -1,23 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 FreeBSD arm64 register structures<br>
&gt; + * FreeBSD arm64 register structures<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2015 Stacey Son<br>
&gt; - *=C2=A0 All rights reserved.<br>
&gt; + * Copyright (c) 2015 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_REG_H<br>
&gt;=C2=A0 #define TARGET_ARCH_REG_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/aarch64/target_arch_signal.h b/bsd-user/aarch64/=
target_arch_signal.h<br>
&gt; index b72ba7aa50..6085217546 100644<br>
&gt; --- a/bsd-user/aarch64/target_arch_signal.h<br>
&gt; +++ b/bsd-user/aarch64/target_arch_signal.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* ARM AArch64 specific signal definitions for bsd-user<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * Copyright (c) 2015 Stacey D. Son &lt;sson at FreeBSD&gt;<br>
&gt; + * Copyright (c) 2015 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * This library is free software; you can redistribute it and/or<br>
&gt; - * modify it under the terms of the GNU Lesser General Public<br>
&gt; - * License as published by the Free Software Foundation; either<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; - *<br>
&gt; - * This library is distributed in the hope that it will be useful,<br=
>
&gt; - * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU<br>
&gt; - * Lesser General Public License for more details.<br>
&gt; - *<br>
&gt; - * You should have received a copy of the GNU Lesser General Public<b=
r>
&gt; - * License along with this library; if not, see &lt;<a href=3D"http:/=
/www.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu=
.org/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_SIGNAL_H<br>
&gt;=C2=A0 #define TARGET_ARCH_SIGNAL_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/aarch64/target_arch_sigtramp.h b/bsd-user/aarch6=
4/target_arch_sigtramp.h<br>
&gt; index 8cdd33b621..38a447fc25 100644<br>
&gt; --- a/bsd-user/aarch64/target_arch_sigtramp.h<br>
&gt; +++ b/bsd-user/aarch64/target_arch_sigtramp.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* ARM AArch64 sigcode for bsd-user<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * Copyright (c) 2015 Stacey D. Son &lt;sson at FreeBSD&gt;<br>
&gt; + * Copyright (c) 2015 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * This library is free software; you can redistribute it and/or<br>
&gt; - * modify it under the terms of the GNU Lesser General Public<br>
&gt; - * License as published by the Free Software Foundation; either<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; - *<br>
&gt; - * This library is distributed in the hope that it will be useful,<br=
>
&gt; - * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU<br>
&gt; - * Lesser General Public License for more details.<br>
&gt; - *<br>
&gt; - * You should have received a copy of the GNU Lesser General Public<b=
r>
&gt; - * License along with this library; if not, see &lt;<a href=3D"http:/=
/www.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu=
.org/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_SIGTRAMP_H<br>
&gt;=C2=A0 #define TARGET_ARCH_SIGTRAMP_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/aarch64/target_arch_sysarch.h b/bsd-user/aarch64=
/target_arch_sysarch.h<br>
&gt; index b003015daf..5569c996cb 100644<br>
&gt; --- a/bsd-user/aarch64/target_arch_sysarch.h<br>
&gt; +++ b/bsd-user/aarch64/target_arch_sysarch.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* ARM AArch64 sysarch() system call emulation for bsd-user=
.<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * Copyright (c) 2015 &lt;sson at FreeBSD&gt;<br>
&gt; + * Copyright (c) 2015 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * This library is free software; you can redistribute it and/or<br>
&gt; - * modify it under the terms of the GNU Lesser General Public<br>
&gt; - * License as published by the Free Software Foundation; either<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; - *<br>
&gt; - * This library is distributed in the hope that it will be useful,<br=
>
&gt; - * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU<br>
&gt; - * Lesser General Public License for more details.<br>
&gt; - *<br>
&gt; - * You should have received a copy of the GNU Lesser General Public<b=
r>
&gt; - * License along with this library; if not, see &lt;<a href=3D"http:/=
/www.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu=
.org/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_SYSARCH_H<br>
&gt;=C2=A0 #define TARGET_ARCH_SYSARCH_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/aarch64/target_arch_thread.h b/bsd-user/aarch64/=
target_arch_thread.h<br>
&gt; index 4c911e605a..06676980c9 100644<br>
&gt; --- a/bsd-user/aarch64/target_arch_thread.h<br>
&gt; +++ b/bsd-user/aarch64/target_arch_thread.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* ARM AArch64 thread support for bsd-user.<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * Copyright (c) 2015 Stacey D. Son &lt;sson at FreeBSD&gt;<br>
&gt; + * Copyright (c) 2015 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * This library is free software; you can redistribute it and/or<br>
&gt; - * modify it under the terms of the GNU Lesser General Public<br>
&gt; - * License as published by the Free Software Foundation; either<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; - *<br>
&gt; - * This library is distributed in the hope that it will be useful,<br=
>
&gt; - * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU<br>
&gt; - * Lesser General Public License for more details.<br>
&gt; - *<br>
&gt; - * You should have received a copy of the GNU Lesser General Public<b=
r>
&gt; - * License along with this library; if not, see &lt;<a href=3D"http:/=
/www.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu=
.org/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_THREAD_H<br>
&gt;=C2=A0 #define TARGET_ARCH_THREAD_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/aarch64/target_arch_vmparam.h b/bsd-user/aarch64=
/target_arch_vmparam.h<br>
&gt; index 0c35491970..ea32f5b56d 100644<br>
&gt; --- a/bsd-user/aarch64/target_arch_vmparam.h<br>
&gt; +++ b/bsd-user/aarch64/target_arch_vmparam.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* ARM AArch64 VM parameters definitions for bsd-user.<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * Copyright (c) 2015 Stacey D. Son &lt;sson at FreeBSD&gt;<br>
&gt; + * Copyright (c) 2015 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * This library is free software; you can redistribute it and/or<br>
&gt; - * modify it under the terms of the GNU Lesser General Public<br>
&gt; - * License as published by the Free Software Foundation; either<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; - *<br>
&gt; - * This library is distributed in the hope that it will be useful,<br=
>
&gt; - * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU<br>
&gt; - * Lesser General Public License for more details.<br>
&gt; - *<br>
&gt; - * You should have received a copy of the GNU Lesser General Public<b=
r>
&gt; - * License along with this library; if not, see &lt;<a href=3D"http:/=
/www.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu=
.org/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_VMPARAM_H<br>
&gt;=C2=A0 #define TARGET_ARCH_VMPARAM_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/aarch64/target_syscall.h b/bsd-user/aarch64/targ=
et_syscall.h<br>
&gt; index 08ae913c42..a574edc429 100644<br>
&gt; --- a/bsd-user/aarch64/target_syscall.h<br>
&gt; +++ b/bsd-user/aarch64/target_syscall.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* ARM AArch64 specific CPU for bsd-user<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * Copyright (c) 2015 Stacey D. Son &lt;sson at Freebsd&gt;<br>
&gt; + * Copyright (c) 2015 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * This library is free software; you can redistribute it and/or<br>
&gt; - * modify it under the terms of the GNU Lesser General Public<br>
&gt; - * License as published by the Free Software Foundation; either<br>
&gt; - * version 2 of the License, or (at your option) any later version.<b=
r>
&gt; - *<br>
&gt; - * This library is distributed in the hope that it will be useful,<br=
>
&gt; - * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
 GNU<br>
&gt; - * Lesser General Public License for more details.<br>
&gt; - *<br>
&gt; - * You should have received a copy of the GNU Lesser General Public<b=
r>
&gt; - * License along with this library; if not, see &lt;<a href=3D"http:/=
/www.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu=
.org/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef BSD_USER_AARCH64_TARGET_SYSCALL_H<br>
&gt;=C2=A0 #define BSD_USER_AARCH64_TARGET_SYSCALL_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/arm/signal.c b/bsd-user/arm/signal.c<br>
&gt; index 9734407543..35cedeba06 100644<br>
&gt; --- a/bsd-user/arm/signal.c<br>
&gt; +++ b/bsd-user/arm/signal.c<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 arm signal functions<br>
&gt; + * arm signal functions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu.h&quot;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/arm/target_arch.h b/bsd-user/arm/target_arch.h<b=
r>
&gt; index d80cb85c64..e0add162e8 100644<br>
&gt; --- a/bsd-user/arm/target_arch.h<br>
&gt; +++ b/bsd-user/arm/target_arch.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* ARM 32-bit specific prototypes for bsd-user<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_H<br>
&gt;=C2=A0 #define TARGET_ARCH_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/arm/target_arch_cpu.c b/bsd-user/arm/target_arch=
_cpu.c<br>
&gt; index fe38ae2210..6a4f5cec0e 100644<br>
&gt; --- a/bsd-user/arm/target_arch_cpu.c<br>
&gt; +++ b/bsd-user/arm/target_arch_cpu.c<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 arm cpu related code<br>
&gt; + * arm cpu related code<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;target_arch.h&quot;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/arm/target_arch_cpu.h b/bsd-user/arm/target_arch=
_cpu.h<br>
&gt; index 9a952ef0ff..faef3ea17a 100644<br>
&gt; --- a/bsd-user/arm/target_arch_cpu.h<br>
&gt; +++ b/bsd-user/arm/target_arch_cpu.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 arm cpu init and loop<br>
&gt; + * arm cpu init and loop<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_CPU_H<br>
&gt;=C2=A0 #define TARGET_ARCH_CPU_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/arm/target_arch_elf.h b/bsd-user/arm/target_arch=
_elf.h<br>
&gt; index b54bf5fbc6..fd13bc87f4 100644<br>
&gt; --- a/bsd-user/arm/target_arch_elf.h<br>
&gt; +++ b/bsd-user/arm/target_arch_elf.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 arm ELF definitions<br>
&gt; + * arm ELF definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_ELF_H<br>
&gt;=C2=A0 #define TARGET_ARCH_ELF_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/arm/target_arch_reg.h b/bsd-user/arm/target_arch=
_reg.h<br>
&gt; index 070fa24da1..9d23dda27d 100644<br>
&gt; --- a/bsd-user/arm/target_arch_reg.h<br>
&gt; +++ b/bsd-user/arm/target_arch_reg.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 FreeBSD arm register structures<br>
&gt; + * FreeBSD arm register structures<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2015 Stacey Son<br>
&gt; + * Copyright (c) 2015 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_REG_H<br>
&gt;=C2=A0 #define TARGET_ARCH_REG_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/arm/target_arch_signal.h b/bsd-user/arm/target_a=
rch_signal.h<br>
&gt; index 10f96b8bfc..dfaefa25d1 100644<br>
&gt; --- a/bsd-user/arm/target_arch_signal.h<br>
&gt; +++ b/bsd-user/arm/target_arch_signal.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 arm signal definitions<br>
&gt; + * arm signal definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_SIGNAL_H<br>
&gt;=C2=A0 #define TARGET_ARCH_SIGNAL_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/arm/target_arch_sigtramp.h b/bsd-user/arm/target=
_arch_sigtramp.h<br>
&gt; index 06198045ed..8a2d34aafc 100644<br>
&gt; --- a/bsd-user/arm/target_arch_sigtramp.h<br>
&gt; +++ b/bsd-user/arm/target_arch_sigtramp.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 arm sysarch() system call emulation<br>
&gt; + * arm sysarch() system call emulation<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_SIGTRAMP_H<br>
&gt;=C2=A0 #define TARGET_ARCH_SIGTRAMP_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/arm/target_arch_sysarch.h b/bsd-user/arm/target_=
arch_sysarch.h<br>
&gt; index 5cb7864197..5f7c421e11 100644<br>
&gt; --- a/bsd-user/arm/target_arch_sysarch.h<br>
&gt; +++ b/bsd-user/arm/target_arch_sysarch.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 arm sysarch() system call emulation<br>
&gt; + * arm sysarch() system call emulation<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_SYSARCH_H<br>
&gt;=C2=A0 #define TARGET_ARCH_SYSARCH_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/arm/target_arch_thread.h b/bsd-user/arm/target_a=
rch_thread.h<br>
&gt; index fd257f313d..d22619a845 100644<br>
&gt; --- a/bsd-user/arm/target_arch_thread.h<br>
&gt; +++ b/bsd-user/arm/target_arch_thread.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 arm thread support<br>
&gt; + * arm thread support<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_THREAD_H<br>
&gt;=C2=A0 #define TARGET_ARCH_THREAD_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/arm/target_arch_vmparam.h b/bsd-user/arm/target_=
arch_vmparam.h<br>
&gt; index 3fb69aff51..c973fcf7d5 100644<br>
&gt; --- a/bsd-user/arm/target_arch_vmparam.h<br>
&gt; +++ b/bsd-user/arm/target_arch_vmparam.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 arm VM parameters definitions<br>
&gt; + * arm VM parameters definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_VMPARAM_H<br>
&gt;=C2=A0 #define TARGET_ARCH_VMPARAM_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/arm/target_syscall.h b/bsd-user/arm/target_sysca=
ll.h<br>
&gt; index 5804a53541..deab3baebf 100644<br>
&gt; --- a/bsd-user/arm/target_syscall.h<br>
&gt; +++ b/bsd-user/arm/target_syscall.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 arm cpu system call stubs<br>
&gt; + * arm cpu system call stubs<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef ARM_TARGET_SYSCALL_H<br>
&gt;=C2=A0 #define ARM_TARGET_SYSCALL_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/bsd-file.h b/bsd-user/bsd-file.h<br>
&gt; index 6fa2c30b4d..dca1518cb1 100644<br>
&gt; --- a/bsd-user/bsd-file.h<br>
&gt; +++ b/bsd-user/bsd-file.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 file related system call shims and definitions<br>
&gt; + * file related system call shims and definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef BSD_FILE_H<br>
&gt;=C2=A0 #define BSD_FILE_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c<br>
&gt; index 2ab1334b70..8c6c4081f7 100644<br>
&gt; --- a/bsd-user/bsd-mem.c<br>
&gt; +++ b/bsd-user/bsd-mem.c<br>
&gt; @@ -1,20 +1,9 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 memory management system conversion routines<br>
&gt; + * memory management system conversion routines<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu.h&quot;<br>
&gt; diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h<br>
&gt; index a118e57260..8c0b0b6919 100644<br>
&gt; --- a/bsd-user/bsd-mem.h<br>
&gt; +++ b/bsd-user/bsd-mem.h<br>
&gt; @@ -1,20 +1,9 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 memory management system call shims and definitions<br>
&gt; + * memory management system call shims and definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013-15 Stacey D. Son<br>
&gt; + * Copyright (c) 2013-2015 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /*<br>
&gt; diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c<br>
&gt; index 8dcac9608d..7fb46046c7 100644<br>
&gt; --- a/bsd-user/bsd-proc.c<br>
&gt; +++ b/bsd-user/bsd-proc.c<br>
&gt; @@ -1,20 +1,9 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 BSD process related system call helpers<br>
&gt; + * BSD process related system call helpers<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013-14 Stacey D. Son<br>
&gt; + * Copyright (c) 2013-2014 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h<br>
&gt; index 8b1c2deea3..b1d4446ff1 100644<br>
&gt; --- a/bsd-user/bsd-proc.h<br>
&gt; +++ b/bsd-user/bsd-proc.h<br>
&gt; @@ -1,20 +1,9 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 process related system call shims and definitions<br>
&gt; + * process related system call shims and definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013-2014 Stacey D. Son<br>
&gt; + * Copyright (c) 2013-2014 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #ifndef BSD_PROC_H_<br>
&gt; diff --git a/bsd-user/bsdload.c b/bsd-user/bsdload.c<br>
&gt; index 5b3c061a45..b3c9f0265b 100644<br>
&gt; --- a/bsd-user/bsdload.c<br>
&gt; +++ b/bsd-user/bsdload.c<br>
&gt; @@ -1,22 +1,11 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 Load BSD executables.<br>
&gt; + * Load BSD executables.<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; -<br>
&gt;=C2=A0 #include &quot;qemu.h&quot;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* ??? This should really be somewhere else.=C2=A0 */<br>
&gt; diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c<br>
&gt; index 3bca0cc9ed..ddac272424 100644<br>
&gt; --- a/bsd-user/elfload.c<br>
&gt; +++ b/bsd-user/elfload.c<br>
&gt; @@ -1,20 +1,9 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 ELF loading code<br>
&gt; + * ELF loading code<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h<b=
r>
&gt; index 71145764a4..d9979b2a8b 100644<br>
&gt; --- a/bsd-user/freebsd/os-misc.h<br>
&gt; +++ b/bsd-user/freebsd/os-misc.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 miscellaneous FreeBSD system call shims<br>
&gt; + * miscellaneous FreeBSD system call shims<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013-14 Stacey D. Son<br>
&gt; + * Copyright (c) 2013-2014 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef OS_MISC_H<br>
&gt;=C2=A0 #define OS_MISC_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c<b=
r>
&gt; index bf993f1b66..0309036178 100644<br>
&gt; --- a/bsd-user/freebsd/os-proc.c<br>
&gt; +++ b/bsd-user/freebsd/os-proc.c<br>
&gt; @@ -1,20 +1,9 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 FreeBSD process related emulation code<br>
&gt; + * FreeBSD process related emulation code<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013-15 Stacey D. Son<br>
&gt; + * Copyright (c) 2013-2014 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h<b=
r>
&gt; index cc53215138..72ccf23e17 100644<br>
&gt; --- a/bsd-user/freebsd/os-proc.h<br>
&gt; +++ b/bsd-user/freebsd/os-proc.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 process related system call shims and definitions<br>
&gt; + * process related system call shims and definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013-14 Stacey D. Son<br>
&gt; + * Copyright (c) 2013-2014 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef BSD_USER_FREEBSD_OS_PROC_H<br>
&gt;=C2=A0 #define BSD_USER_FREEBSD_OS_PROC_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/freebsd/os-stat.c b/bsd-user/freebsd/os-stat.c<b=
r>
&gt; index f0f9e609c3..10870430fe 100644<br>
&gt; --- a/bsd-user/freebsd/os-stat.c<br>
&gt; +++ b/bsd-user/freebsd/os-stat.c<br>
&gt; @@ -1,20 +1,9 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 FreeBSD stat related conversion routines<br>
&gt; + * FreeBSD stat related conversion routines<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h<b=
r>
&gt; index 3bdc66aa98..ea95aa6344 100644<br>
&gt; --- a/bsd-user/freebsd/os-stat.h<br>
&gt; +++ b/bsd-user/freebsd/os-stat.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 stat related system call shims and definitions<br>
&gt; + * stat related system call shims and definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef BSD_USER_FREEBSD_OS_STAT_H<br>
&gt;=C2=A0 #define BSD_USER_FREEBSD_OS_STAT_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/freebsd/os-strace.h b/bsd-user/freebsd/os-strace=
.h<br>
&gt; index a222f093b5..ad48e99db1 100644<br>
&gt; --- a/bsd-user/freebsd/os-strace.h<br>
&gt; +++ b/bsd-user/freebsd/os-strace.h<br>
&gt; @@ -1,25 +1,12 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 FreeBSD dependent strace print functions<br>
&gt; + * FreeBSD dependent strace print functions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #include &quot;target_arch_sysarch.h&quot;=C2=A0 =C2=A0 /* archi=
tecture dependent functions */<br>
&gt;=C2=A0 <br>
&gt; -<br>
&gt;=C2=A0 static inline void do_os_print_sysarch(const struct syscallname =
*name,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_long arg1, abi_long arg2, abi_lo=
ng arg3, abi_long arg4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abi_long arg5, abi_long arg6)<br>
&gt; diff --git a/bsd-user/freebsd/target_os_elf.h b/bsd-user/freebsd/targe=
t_os_elf.h<br>
&gt; index 01124979f7..c67e5a0f8e 100644<br>
&gt; --- a/bsd-user/freebsd/target_os_elf.h<br>
&gt; +++ b/bsd-user/freebsd/target_os_elf.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 freebsd ELF definitions<br>
&gt; + * FreeBSD ELF definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013-15 Stacey D. Son<br>
&gt; + * Copyright (c) 2013-2015 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_OS_ELF_H<br>
&gt;=C2=A0 #define TARGET_OS_ELF_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/freebsd/target_os_siginfo.h b/bsd-user/freebsd/t=
arget_os_siginfo.h<br>
&gt; index 6c282d8502..e7cf76b9bd 100644<br>
&gt; --- a/bsd-user/freebsd/target_os_siginfo.h<br>
&gt; +++ b/bsd-user/freebsd/target_os_siginfo.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 FreeBSD siginfo related definitions<br>
&gt; + * FreeBSD siginfo related definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_OS_SIGINFO_H<br>
&gt;=C2=A0 #define TARGET_OS_SIGINFO_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/freebsd/target_os_stack.h b/bsd-user/freebsd/tar=
get_os_stack.h<br>
&gt; index ac0ef22cd7..262f33d839 100644<br>
&gt; --- a/bsd-user/freebsd/target_os_stack.h<br>
&gt; +++ b/bsd-user/freebsd/target_os_stack.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 FreeBSD setup_initial_stack() implementation.<br>
&gt; + * FreeBSD setup_initial_stack() implementation.<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013-14 Stacey D. Son<br>
&gt; + * Copyright (c) 2013-2014 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_OS_STACK_H<br>
&gt;=C2=A0 #define TARGET_OS_STACK_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/freebsd/target_os_thread.h b/bsd-user/freebsd/ta=
rget_os_thread.h<br>
&gt; index 1b32cebd26..ff88679e40 100644<br>
&gt; --- a/bsd-user/freebsd/target_os_thread.h<br>
&gt; +++ b/bsd-user/freebsd/target_os_thread.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 FreeBSD thread dependent code and definitions<br>
&gt; + * FreeBSD thread dependent code and definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_OS_THREAD_H<br>
&gt;=C2=A0 #define TARGET_OS_THREAD_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/freebsd/target_os_user.h b/bsd-user/freebsd/targ=
et_os_user.h<br>
&gt; index 1ca7b5ab17..9703b9a61a 100644<br>
&gt; --- a/bsd-user/freebsd/target_os_user.h<br>
&gt; +++ b/bsd-user/freebsd/target_os_user.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 sys/user.h definitions<br>
&gt; + * sys/user.h definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2015 Stacey D. Son (sson at FreeBSD)<br>
&gt; + * Copyright (c) 2015 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_OS_USER_H<br>
&gt;=C2=A0 #define TARGET_OS_USER_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/freebsd/target_os_vmparam.h b/bsd-user/freebsd/t=
arget_os_vmparam.h<br>
&gt; index 8457dd3913..9feec5296d 100644<br>
&gt; --- a/bsd-user/freebsd/target_os_vmparam.h<br>
&gt; +++ b/bsd-user/freebsd/target_os_vmparam.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 FreeBSD VM parameters definitions<br>
&gt; + * FreeBSD VM parameters definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_OS_VMPARAM_H<br>
&gt;=C2=A0 #define TARGET_OS_VMPARAM_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/i386/signal.c b/bsd-user/i386/signal.c<br>
&gt; index a3131047b8..742032090d 100644<br>
&gt; --- a/bsd-user/i386/signal.c<br>
&gt; +++ b/bsd-user/i386/signal.c<br>
&gt; @@ -1,20 +1,9 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 i386 dependent signal definitions<br>
&gt; + * i386 dependent signal definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; diff --git a/bsd-user/i386/target_arch.h b/bsd-user/i386/target_arch.h=
<br>
&gt; index 9595e60f09..74c8e7fb47 100644<br>
&gt; --- a/bsd-user/i386/target_arch.h<br>
&gt; +++ b/bsd-user/i386/target_arch.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Intel x86 specific prototypes for bsd-user<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_H<br>
&gt;=C2=A0 #define TARGET_ARCH_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/i386/target_arch_cpu.c b/bsd-user/i386/target_ar=
ch_cpu.c<br>
&gt; index 2a3af2ddef..fa8ad4b385 100644<br>
&gt; --- a/bsd-user/i386/target_arch_cpu.c<br>
&gt; +++ b/bsd-user/i386/target_arch_cpu.c<br>
&gt; @@ -1,20 +1,9 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 i386 cpu related code<br>
&gt; + * i386 cpu related code<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * Copyright (c) 2013 Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; diff --git a/bsd-user/i386/target_arch_cpu.h b/bsd-user/i386/target_ar=
ch_cpu.h<br>
&gt; index f147d5b6f8..c6e8bfd8ca 100644<br>
&gt; --- a/bsd-user/i386/target_arch_cpu.h<br>
&gt; +++ b/bsd-user/i386/target_arch_cpu.h<br>
&gt; @@ -1,21 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 i386 cpu init and loop<br>
&gt; + * i386 cpu init and loop<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_CPU_H<br>
&gt;=C2=A0 #define TARGET_ARCH_CPU_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/i386/target_arch_elf.h b/bsd-user/i386/target_ar=
ch_elf.h<br>
&gt; index 4ac27b02e7..99cff66a22 100644<br>
&gt; --- a/bsd-user/i386/target_arch_elf.h<br>
&gt; +++ b/bsd-user/i386/target_arch_elf.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 i386 ELF definitions<br>
&gt; + * i386 ELF definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_ELF_H<br>
&gt;=C2=A0 #define TARGET_ARCH_ELF_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/i386/target_arch_reg.h b/bsd-user/i386/target_ar=
ch_reg.h<br>
&gt; index 8123109697..cebf2fd5cc 100644<br>
&gt; --- a/bsd-user/i386/target_arch_reg.h<br>
&gt; +++ b/bsd-user/i386/target_arch_reg.h<br>
&gt; @@ -1,23 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 FreeBSD i386 register structures<br>
&gt; + * FreeBSD i386 register structures<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2015 Stacey Son<br>
&gt; - *=C2=A0 All rights reserved.<br>
&gt; + * Copyright (c) 2015 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_REG_H<br>
&gt;=C2=A0 #define TARGET_ARCH_REG_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/i386/target_arch_signal.h b/bsd-user/i386/target=
_arch_signal.h<br>
&gt; index 2c14153ab6..070ba4357a 100644<br>
&gt; --- a/bsd-user/i386/target_arch_signal.h<br>
&gt; +++ b/bsd-user/i386/target_arch_signal.h<br>
&gt; @@ -1,19 +1,9 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 i386 dependent signal definitions<br>
&gt; + * i386 dependent signal definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_SIGNAL_H<br>
&gt;=C2=A0 #define TARGET_ARCH_SIGNAL_H<br>
&gt; diff --git a/bsd-user/i386/target_arch_sigtramp.h b/bsd-user/i386/targ=
et_arch_sigtramp.h<br>
&gt; index ef94cc864f..ace243b6f5 100644<br>
&gt; --- a/bsd-user/i386/target_arch_sigtramp.h<br>
&gt; +++ b/bsd-user/i386/target_arch_sigtramp.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Intel i386=C2=A0 sigcode for bsd-user<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_SIGTRAMP_H<br>
&gt;=C2=A0 #define TARGET_ARCH_SIGTRAMP_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/i386/target_arch_sysarch.h b/bsd-user/i386/targe=
t_arch_sysarch.h<br>
&gt; index db8fee6380..7b128dfab1 100644<br>
&gt; --- a/bsd-user/i386/target_arch_sysarch.h<br>
&gt; +++ b/bsd-user/i386/target_arch_sysarch.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 i386 sysarch system call emulation<br>
&gt; + * i386 sysarch system call emulation<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_SYSARCH_H<br>
&gt;=C2=A0 #define TARGET_ARCH_SYSARCH_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/i386/target_arch_thread.h b/bsd-user/i386/target=
_arch_thread.h<br>
&gt; index cee2148d94..8ef4f6b648 100644<br>
&gt; --- a/bsd-user/i386/target_arch_thread.h<br>
&gt; +++ b/bsd-user/i386/target_arch_thread.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 i386 thread support<br>
&gt; + * i386 thread support<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_THREAD_H<br>
&gt;=C2=A0 #define TARGET_ARCH_THREAD_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/i386/target_arch_vmparam.h b/bsd-user/i386/targe=
t_arch_vmparam.h<br>
&gt; index 79db420e59..cdf6ab0a49 100644<br>
&gt; --- a/bsd-user/i386/target_arch_vmparam.h<br>
&gt; +++ b/bsd-user/i386/target_arch_vmparam.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 i386 VM parameters definitions<br>
&gt; + * i386 VM parameters definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_VMPARAM_H<br>
&gt;=C2=A0 #define TARGET_ARCH_VMPARAM_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/i386/target_syscall.h b/bsd-user/i386/target_sys=
call.h<br>
&gt; index 940c687a52..a52851f635 100644<br>
&gt; --- a/bsd-user/i386/target_syscall.h<br>
&gt; +++ b/bsd-user/i386/target_syscall.h<br>
&gt; @@ -1,19 +1,9 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 i386 system call definitions<br>
&gt; + * i386 system call definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #ifndef TARGET_SYSCALL_H<br>
&gt;=C2=A0 #define TARGET_SYSCALL_H<br>
&gt; diff --git a/bsd-user/main.c b/bsd-user/main.c<br>
&gt; index 73aae8c327..84351e1631 100644<br>
&gt; --- a/bsd-user/main.c<br>
&gt; +++ b/bsd-user/main.c<br>
&gt; @@ -1,23 +1,11 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 qemu bsd user main<br>
&gt; + * qemu bsd user main<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2003-2008 Fabrice Bellard<br>
&gt; - *=C2=A0 Copyright (c) 2013-14 Stacey Son<br>
&gt; + * Copyright (c) 2003-2008 Fabrice Bellard<br>
&gt; + * Copyright (c) 2013-14 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &lt;sys/resource.h&gt;<br>
&gt;=C2=A0 #include &lt;sys/sysctl.h&gt;<br>
&gt; diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c<br>
&gt; index 24ba1728eb..fb685e84aa 100644<br>
&gt; --- a/bsd-user/mmap.c<br>
&gt; +++ b/bsd-user/mmap.c<br>
&gt; @@ -1,20 +1,9 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 mmap support for qemu<br>
&gt; + * mmap support for qemu<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2003 - 2008 Fabrice Bellard<br>
&gt; + * Copyright (c) 2003 - 2008 Fabrice Bellard<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 #include &quot;exec/mmap-lock.h&quot;<br>
&gt; diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h<br>
&gt; index 56affcd31d..64d4fbe3a9 100644<br>
&gt; --- a/bsd-user/qemu-bsd.h<br>
&gt; +++ b/bsd-user/qemu-bsd.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 BSD conversion extern declarations<br>
&gt; + * BSD conversion extern declarations<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef QEMU_BSD_H<br>
&gt;=C2=A0 #define QEMU_BSD_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h<br>
&gt; index 93388e7c34..c4ff1fb0eb 100644<br>
&gt; --- a/bsd-user/qemu.h<br>
&gt; +++ b/bsd-user/qemu.h<br>
&gt; @@ -1,18 +1,9 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 qemu bsd user mode definition<br>
&gt; + * qemu bsd user mode definition<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #ifndef QEMU_H<br>
&gt;=C2=A0 #define QEMU_H<br>
&gt; diff --git a/bsd-user/signal.c b/bsd-user/signal.c<br>
&gt; index dadcc037dc..832ffef7c5 100644<br>
&gt; --- a/bsd-user/signal.c<br>
&gt; +++ b/bsd-user/signal.c<br>
&gt; @@ -1,21 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 Emulation of BSD signals<br>
&gt; + * Emulation of BSD signals<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2003 - 2008 Fabrice Bellard<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey Son<br>
&gt; + * Copyright (c) 2003 - 2008 Fabrice Bellard<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; diff --git a/bsd-user/strace.c b/bsd-user/strace.c<br>
&gt; index 6dc01d3be7..a015bfddba 100644<br>
&gt; --- a/bsd-user/strace.c<br>
&gt; +++ b/bsd-user/strace.c<br>
&gt; @@ -1,19 +1,9 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 System call tracing and debugging<br>
&gt; + * System call tracing and debugging<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h<br>
&gt; index cc4b484f3a..a2ded2fac1 100644<br>
&gt; --- a/bsd-user/syscall_defs.h<br>
&gt; +++ b/bsd-user/syscall_defs.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 System call related declarations<br>
&gt; + * System call related declarations<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013-15 Stacey D. Son (sson at FreeBSD)<br>
&gt; + * Copyright (c) 2013-2015 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef SYSCALL_DEFS_H<br>
&gt;=C2=A0 #define SYSCALL_DEFS_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/x86_64/signal.c b/bsd-user/x86_64/signal.c<br>
&gt; index 46cb865180..823d7217ad 100644<br>
&gt; --- a/bsd-user/x86_64/signal.c<br>
&gt; +++ b/bsd-user/x86_64/signal.c<br>
&gt; @@ -1,19 +1,9 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 x86_64 signal definitions<br>
&gt; + * x86_64 signal definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; diff --git a/bsd-user/x86_64/target_arch.h b/bsd-user/x86_64/target_ar=
ch.h<br>
&gt; index 09bd974889..177e6b442a 100644<br>
&gt; --- a/bsd-user/x86_64/target_arch.h<br>
&gt; +++ b/bsd-user/x86_64/target_arch.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Intel x86_64 specific prototypes for bsd-user<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_H<br>
&gt;=C2=A0 #define TARGET_ARCH_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/x86_64/target_arch_cpu.c b/bsd-user/x86_64/targe=
t_arch_cpu.c<br>
&gt; index 1d32f18907..aeeb1235c9 100644<br>
&gt; --- a/bsd-user/x86_64/target_arch_cpu.c<br>
&gt; +++ b/bsd-user/x86_64/target_arch_cpu.c<br>
&gt; @@ -1,20 +1,9 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 x86_64 cpu related code<br>
&gt; + * x86_64 cpu related code<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - * Copyright (c) 2013 Stacey Son &lt;sson@FreeBSD.org&gt;<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt; diff --git a/bsd-user/x86_64/target_arch_cpu.h b/bsd-user/x86_64/targe=
t_arch_cpu.h<br>
&gt; index 1fa71d87f1..f12a8ab49e 100644<br>
&gt; --- a/bsd-user/x86_64/target_arch_cpu.h<br>
&gt; +++ b/bsd-user/x86_64/target_arch_cpu.h<br>
&gt; @@ -1,21 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 x86_64 cpu init and loop<br>
&gt; + * x86_64 cpu init and loop<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_CPU_H<br>
&gt;=C2=A0 #define TARGET_ARCH_CPU_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/x86_64/target_arch_elf.h b/bsd-user/x86_64/targe=
t_arch_elf.h<br>
&gt; index e51c2faf08..020533904e 100644<br>
&gt; --- a/bsd-user/x86_64/target_arch_elf.h<br>
&gt; +++ b/bsd-user/x86_64/target_arch_elf.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 x86_64 ELF definitions<br>
&gt; + * x86_64 ELF definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2015 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_ELF_H<br>
&gt;=C2=A0 #define TARGET_ARCH_ELF_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/x86_64/target_arch_reg.h b/bsd-user/x86_64/targe=
t_arch_reg.h<br>
&gt; index 7a766de918..c0c766ac1a 100644<br>
&gt; --- a/bsd-user/x86_64/target_arch_reg.h<br>
&gt; +++ b/bsd-user/x86_64/target_arch_reg.h<br>
&gt; @@ -1,23 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 FreeBSD amd64 register structures<br>
&gt; + * FreeBSD amd64 register structures<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2015 Stacey Son<br>
&gt; - *=C2=A0 All rights reserved.<br>
&gt; + * Copyright (c) 2015 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_REG_H<br>
&gt;=C2=A0 #define TARGET_ARCH_REG_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/x86_64/target_arch_signal.h b/bsd-user/x86_64/ta=
rget_arch_signal.h<br>
&gt; index f833ee66ce..2b63048f8b 100644<br>
&gt; --- a/bsd-user/x86_64/target_arch_signal.h<br>
&gt; +++ b/bsd-user/x86_64/target_arch_signal.h<br>
&gt; @@ -1,21 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 x86_64 signal definitions<br>
&gt; + * x86_64 signal definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_SIGNAL_H<br>
&gt;=C2=A0 #define TARGET_ARCH_SIGNAL_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/x86_64/target_arch_sigtramp.h b/bsd-user/x86_64/=
target_arch_sigtramp.h<br>
&gt; index 01da614098..cab22fb7e8 100644<br>
&gt; --- a/bsd-user/x86_64/target_arch_sigtramp.h<br>
&gt; +++ b/bsd-user/x86_64/target_arch_sigtramp.h<br>
&gt; @@ -1,29 +1,16 @@<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Intel x86_64=C2=A0 sigcode for bsd-user<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_SIGTRAMP_H<br>
&gt;=C2=A0 #define TARGET_ARCH_SIGTRAMP_H<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static inline abi_long setup_sigtramp(abi_ulong offset, unsigned=
 sigf_uc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned sys_sigreturn)<br>
&gt;=C2=A0 {<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 #endif /* TARGET_ARCH_SIGTRAMP_H */<br>
&gt; diff --git a/bsd-user/x86_64/target_arch_sysarch.h b/bsd-user/x86_64/t=
arget_arch_sysarch.h<br>
&gt; index 152cb8bcb8..3a6f74161f 100644<br>
&gt; --- a/bsd-user/x86_64/target_arch_sysarch.h<br>
&gt; +++ b/bsd-user/x86_64/target_arch_sysarch.h<br>
&gt; @@ -1,21 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 x86_64 sysarch() syscall emulation<br>
&gt; + * x86_64 sysarch() syscall emulation<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_SYSARCH_H<br>
&gt;=C2=A0 #define TARGET_ARCH_SYSARCH_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/x86_64/target_arch_thread.h b/bsd-user/x86_64/ta=
rget_arch_thread.h<br>
&gt; index 7739bb2154..176c347037 100644<br>
&gt; --- a/bsd-user/x86_64/target_arch_thread.h<br>
&gt; +++ b/bsd-user/x86_64/target_arch_thread.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 x86_64 thread support<br>
&gt; + * x86_64 thread support<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_THREAD_H<br>
&gt;=C2=A0 #define TARGET_ARCH_THREAD_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/x86_64/target_arch_vmparam.h b/bsd-user/x86_64/t=
arget_arch_vmparam.h<br>
&gt; index 6797623a6b..8919c5e6e5 100644<br>
&gt; --- a/bsd-user/x86_64/target_arch_vmparam.h<br>
&gt; +++ b/bsd-user/x86_64/target_arch_vmparam.h<br>
&gt; @@ -1,22 +1,10 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 Intel x86_64 VM parameters definitions<br>
&gt; + * Intel x86_64 VM parameters definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 Copyright (c) 2013 Stacey D. Son<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt; -<br>
&gt;=C2=A0 #ifndef TARGET_ARCH_VMPARAM_H<br>
&gt;=C2=A0 #define TARGET_ARCH_VMPARAM_H<br>
&gt;=C2=A0 <br>
&gt; diff --git a/bsd-user/x86_64/target_syscall.h b/bsd-user/x86_64/target=
_syscall.h<br>
&gt; index a8e6274b76..5adced9bde 100644<br>
&gt; --- a/bsd-user/x86_64/target_syscall.h<br>
&gt; +++ b/bsd-user/x86_64/target_syscall.h<br>
&gt; @@ -1,19 +1,9 @@<br>
&gt;=C2=A0 /*<br>
&gt; - *=C2=A0 x86_64 system call definitions<br>
&gt; + * x86_64 system call definitions<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; + * Copyright (c) 2013 Stacey D. Son<br>
&gt;=C2=A0 =C2=A0*<br>
&gt; - *=C2=A0 This program is free software; you can redistribute it and/o=
r modify<br>
&gt; - *=C2=A0 it under the terms of the GNU General Public License as publ=
ished by<br>
&gt; - *=C2=A0 the Free Software Foundation; either version 2 of the Licens=
e, or<br>
&gt; - *=C2=A0 (at your option) any later version.<br>
&gt; - *<br>
&gt; - *=C2=A0 This program is distributed in the hope that it will be usef=
ul,<br>
&gt; - *=C2=A0 but WITHOUT ANY WARRANTY; without even the implied warranty =
of<br>
&gt; - *=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 S=
ee the<br>
&gt; - *=C2=A0 GNU General Public License for more details.<br>
&gt; - *<br>
&gt; - *=C2=A0 You should have received a copy of the GNU General Public Li=
cense<br>
&gt; - *=C2=A0 along with this program; if not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + * SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #ifndef TARGET_SYSCALL_H<br>
&gt;=C2=A0 #define TARGET_SYSCALL_H<br>
&gt; <br>
&gt; ---<br>
&gt; base-commit: ffcf1a7981793973ffbd8100a7c3c6042d02ae23<br>
&gt; change-id: 20260302-bsd-user-copyright-3a46d2307150<br>
&gt; <br>
&gt; Best regards,<br>
&gt; -- <br>
&gt; Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank">im=
p@bsdimp.com</a>&gt;<br>
&gt; <br>
&gt; <br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer" target=3D=
"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"noreferrer"=
 target=3D"_blank">https://entangle-photo.org</a> :|<br>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer" target=3D"_=
blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =C2=A0 <a hre=
f=3D"https://fstop138.berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div></div>

--000000000000c86f40064c1daf9d--

