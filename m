Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74AACD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoWp-00010i-FW; Wed, 06 May 2026 22:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wKoWV-0008Pl-Ib
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:31:37 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1wKoWS-0000mu-SJ
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:31:35 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-362e50b4641so178816a91.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:31:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778121090; cv=none;
 d=google.com; s=arc-20240605;
 b=cNmJ5u31f2TS4tN6tc1IgRRIlnUSwOMyERh1FMvrIAPhiioIQFnwFjnLWwJHQCfzic
 vyN6Sr+fQP0If3kcRi60dG48P4bTvGkQOEV6W7krY7tJwyqTHjAX7hhCbsOE4NKEJ+C5
 cp+iKtUB9vV4BmymjYP8/dXkJ9F9EKN9XhX5jRLI/LakiRuGBD78u6ExSSwT2m0vjXCL
 yQwjt6rUyVkrNhi+Eg+1BXeTNu1ag/6taBItGSvWcIHQZL3SIWDcQe+FjhWMC0Hr9w1x
 tJoG5LAZqdcbWHFBS4vxl1QwkqenefyDD1HefbidQmdn41VlzXuARStZDi3ybjPPcbkJ
 3xXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UaVZP/5PfmekL5G651lYBnZB6BDDsQk3jPNwZNgJZ4s=;
 fh=d9iMSPgxEhCILQ2/iXvh+ZORujpc1zkJihlswtOhKiE=;
 b=ZWbwaosD3o2OeAI/YPPCN71zciUDkkWE5PDhSv6yi5GrhrNs3b3Vcr/BgJ5gRmKQM+
 S0e9CN1vsinEDEx0fJs/X+OmFrbBUlTIWvXXi/m8RQWQ3VDarO/TrT84v+AM/GaQcnQT
 uXRzRG1s0Nb4R730ATAvSSoZpL/ZfzD2VahdQdKLYT/V0YUdi5WT6xTYQZvY0aJdqaki
 WrP3ZywbLpE5swsIEF341cr8sWeD0tx6ozHvjiH3WFdS2w2gBYeg4wQvfTEBK1A4JVMJ
 GISoUUBqXxLxT6GyYKGRmMC6nRl+BCbJk5mntdIEAlS9M2hJBqnYz4oG/7616Gu8L2no
 B88Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778121090; x=1778725890;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UaVZP/5PfmekL5G651lYBnZB6BDDsQk3jPNwZNgJZ4s=;
 b=o5VPyNRbBAmJ7GrIFmPq8kr9k3xm/kQxpWf/fT9eyVI1hQppaVCmPweZank1vCLyoh
 gS+C6fCNDe93h3EcL+vtsGc/3Po1rjlifr0MrpjOCxm+1TOyxyz88G8fYZgCF6jnd0kn
 lOP7gsUI0nMZrHr1xRK0Ob26hW6L4Lcg2rL0Ivy+bmdeojd6zjXqwL6X/ElymTO3aoOI
 OGut83M05RKy4HsJUa3Jl2ABTjdOhYCOvLXbTN7VkRkqeDk9amnxML5oz8249CwmVpoB
 KWFiPqSNklcAV3+Q/1f0D7epyWl6aWn/p8ToISSTcA8NFthiWySdhG6wlKxKZ/KvP6eC
 cMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121090; x=1778725890;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UaVZP/5PfmekL5G651lYBnZB6BDDsQk3jPNwZNgJZ4s=;
 b=d5bExnlrjT/iFFhUVCxKrQG7OIdak6lp861uYNNkeMhnUmbzrOzdypv6lLm8YG+yQq
 z+1quFDf51rMxXo9W0ARIT9FQ8TycaXvIi6EFnQbzDoYoKCoRtXKnn/PxY9RvEBxRu1L
 57V23aO0hXtXD168fjMvq2mzeFdSny0uiDWrujEniG/nVpEAQRXvdFI6pgwBYN7YwWdp
 aD9FkNXXfk40Bf+ToaqeFKiBN+6773dOTvRgSWD1TU7V2rdJ4Veq+HuFGwZO90ZhBCxn
 LIpA8XNdkZ2GnxD7SOSrCzEQnx4F0M41a+aC0B5CPbvA8o7Qdvg5lwcZJcoPU9YPoqe3
 VmsQ==
X-Gm-Message-State: AOJu0YxIY9BvMvRSRp0ypPXqd+Kbbb5GbtaJm3I8oWQ0Ppg07b2V61ai
 fCU1aF8R6TPtxM8iINeeNkIXQqDncoAgGtupatO59f+h5YHPFQXM1vu6qazyRtzcpFqyZT26zKK
 nQFeYKM/KCsqamasuTNYpZdHY4Q6ijflGa9xedQIqJdxvQzOVCETjWvQ=
X-Gm-Gg: AeBDiet82OgYC6Twh6uQgYmCngzS0Dn00Mnft3oT5yKUDwPDHB+yemvpeKam1pOeHWA
 yAAULjL0H4HrqXZebkEoM7FABf0eZSl0badTyQus8zvCi+GpTtC97GoqtxjGnisiiOROyJ27Acy
 Y6xmnQeE4wvQ41DLN2saaQK2NvXl4ZVuJrNqNjGWGOSD9dKUk5g/ryumV+siBB9UjmYJopTUc3g
 cf1j6ELoiXQTCcCRj0qcqQ+yV88fnnmuctNzP+V6InvQiBaXA3thjd5c2RNFcRUWkx3F2gPzimL
 gXrqjyEaFBC545JhFg==
X-Received: by 2002:a17:90b:548d:b0:35f:b647:d98a with SMTP id
 98e67ed59e1d1-365ab9b8c53mr5273284a91.5.1778121089842; Wed, 06 May 2026
 19:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260507022219.44171-1-imp@bsdimp.com>
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 6 May 2026 20:31:18 -0600
X-Gm-Features: AVHnY4INytWIfzGJ1DhGesiPGg5aNQGH2zlNTZLNuhu7A1v2JPnX6KMgfr5hgPY
Message-ID: <CANCZdfpzNBZv4XseC0KWkVHaPwCRRNgS9sWAHeCrZusqP3V=1Q@mail.gmail.com>
Subject: Re: [PATCH 00/25] bsd-user May 2026 pull request
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000ed94020651311348"
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

--000000000000ed94020651311348
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please ignore this.

It was a botched pull request. I've sent the real pull request. My
apologies for the noise.

Warner

On Wed, May 6, 2026 at 8:24=E2=80=AFPM Warner Losh <imp@bsdimp.com> wrote:

> Three patch series were reviewed during the code freeze and are finally
> ready to
> head into the tree.
>
> (1) Use SPDX identifiers in most places. This makes it easier for me to
> upstream
> since I can do almost all of the files in the forked tree and not have it
> be an
> issue each time I add a new file.
>
> (2) Per discussions in the review, copy thunk.c to bsd-user from
> linux-user. We
> will use this in the third set of patches, ioctls. All that changed is th=
e
> copyright header. This file has style problems, but fixing them would be =
a
> worse
> problem than the style issues since we share it with linux-user and want =
to
> track changes there. In the future we may actually share, but for now thi=
s
> was
> the compromise.
>
> (3) All the ioctls that bsd-user supports in FreeBSD. This uses the
> thunk.c code
> to translate back and forth between host and target. A number of pedantic
> changes were made against the blitz branch upstream and were discovered o=
r
> highlighted by claude code.
>
> I used claude to extract all the ioctl code from the blitz branch for
> upstreaming. I had it review the code and fixed the problems it found
> (though
> one was a false positive). I've not tagged these as Assisted-by: since
> that part
> of our policy is in flux. No creative output of claude was applied here,
> though
> it also suggested the commit messages (that I rewrote in large part, but
> vestiges of the original remain). To be clear: Claude didn't write any of
> the actual code.
>
> Stacey Son (19):
>   bsd-user: ioctl: add common definitions
>   bsd-user: Add FreeBSD tty ioctl definitions
>   bsd-user: Add FreeBSD file I/O ioctl definitions
>   bsd-user: Add FreeBSD socket ioctl definitions
>   bsd-user: Add FreeBSD cryptodev ioctl definitions
>   bsd-user: Add FreeBSD disk ioctl definitions
>   bsd-user: Add FreeBSD IPv6 ioctl definitions
>   bsd-user: Add FreeBSD ioctl type definitions
>   bsd-user: Add FreeBSD ioctl command table
>   bsd-user: Add bsd-ioctl.h header
>   bsd-user: Add target_sockaddr and safe_ioctl to syscall_defs.h
>   bsd-user: Add bsd-ioctl.c infrastructure and termios conversion
>   bsd-user: Add log_unsupported_ioctl function
>   bsd-user: Add do_ioctl_unsupported function
>   bsd-user: Add target_to_host_sockaddr_in6 function
>   bsd-user: Add do_ioctl_in6_ifreq_sockaddr_int function
>   bsd-user: Add do_bsd_ioctl main function
>   bsd-user: Add init_bsd_ioctl function
>   bsd-user: Add call to do_bsd_ioctl and add bsd-ioctl.c to the build
>
> Warner Losh (6):
>   bsd-user: Switch to SPDX-License-Expression
>   bsd-user: Add syscall header generator for FreeBSD
>   bsd-user: Delete sbrk and sstk system calls.
>   bsd-user: Create os-syscall.h
>   bsd-user: Switch to generated syscall_nr.h
>   bsd-user: Copy linux-user/thunk.c to bsd-user
>
>  bsd-user/aarch64/signal.c               |  15 +-
>  bsd-user/aarch64/target_arch.h          |  16 +-
>  bsd-user/aarch64/target_arch_cpu.c      |  15 +-
>  bsd-user/aarch64/target_arch_cpu.h      |  18 +-
>  bsd-user/aarch64/target_arch_elf.h      |  14 +-
>  bsd-user/aarch64/target_arch_reg.h      |  19 +-
>  bsd-user/aarch64/target_arch_signal.h   |  16 +-
>  bsd-user/aarch64/target_arch_sigtramp.h |  16 +-
>  bsd-user/aarch64/target_arch_sysarch.h  |  16 +-
>  bsd-user/aarch64/target_arch_thread.h   |  16 +-
>  bsd-user/aarch64/target_arch_vmparam.h  |  16 +-
>  bsd-user/aarch64/target_syscall.h       |  16 +-
>  bsd-user/arm/signal.c                   |  18 +-
>  bsd-user/arm/target_arch.h              |  16 +-
>  bsd-user/arm/target_arch_cpu.c          |  18 +-
>  bsd-user/arm/target_arch_cpu.h          |  18 +-
>  bsd-user/arm/target_arch_elf.h          |  18 +-
>  bsd-user/arm/target_arch_reg.h          |  18 +-
>  bsd-user/arm/target_arch_signal.h       |  18 +-
>  bsd-user/arm/target_arch_sigtramp.h     |  18 +-
>  bsd-user/arm/target_arch_sysarch.h      |  18 +-
>  bsd-user/arm/target_arch_thread.h       |  18 +-
>  bsd-user/arm/target_arch_vmparam.h      |  18 +-
>  bsd-user/arm/target_syscall.h           |  18 +-
>  bsd-user/bsd-file.h                     |  18 +-
>  bsd-user/bsd-ioctl.c                    | 436 ++++++++++++++++++++
>  bsd-user/bsd-ioctl.h                    |  14 +
>  bsd-user/bsd-mem.c                      |  17 +-
>  bsd-user/bsd-mem.h                      |  30 +-
>  bsd-user/bsd-proc.c                     |  17 +-
>  bsd-user/bsd-proc.h                     |  17 +-
>  bsd-user/freebsd/meson.build            |  10 +-
>  bsd-user/freebsd/os-ioctl-cmds.h        | 149 +++++++
>  bsd-user/freebsd/os-ioctl-cryptodev.h   |  84 ++++
>  bsd-user/freebsd/os-ioctl-disk.h        |  52 +++
>  bsd-user/freebsd/os-ioctl-filio.h       |  34 ++
>  bsd-user/freebsd/os-ioctl-in6_var.h     | 226 +++++++++++
>  bsd-user/freebsd/os-ioctl-ioccom.h      |  43 ++
>  bsd-user/freebsd/os-ioctl-sockio.h      | 246 +++++++++++
>  bsd-user/freebsd/os-ioctl-ttycom.h      | 239 +++++++++++
>  bsd-user/freebsd/os-ioctl-types.h       | 109 +++++
>  bsd-user/freebsd/os-misc.h              |  18 +-
>  bsd-user/freebsd/os-proc.c              |  17 +-
>  bsd-user/freebsd/os-proc.h              |  18 +-
>  bsd-user/freebsd/os-stat.c              |  17 +-
>  bsd-user/freebsd/os-stat.h              |  18 +-
>  bsd-user/freebsd/os-strace.h            |  19 +-
>  bsd-user/freebsd/os-syscall.c           |  17 +-
>  bsd-user/freebsd/os-syscall.h           |  21 +
>  bsd-user/freebsd/scripts/syscallhdr.sh  |   9 +
>  bsd-user/freebsd/strace.list            |   4 +
>  bsd-user/freebsd/syscall_nr.h           | 515 ------------------------
>  bsd-user/freebsd/target_os_elf.h        |  18 +-
>  bsd-user/freebsd/target_os_siginfo.h    |  18 +-
>  bsd-user/freebsd/target_os_signal.h     |   7 +
>  bsd-user/freebsd/target_os_stack.h      |  18 +-
>  bsd-user/freebsd/target_os_thread.h     |  18 +-
>  bsd-user/freebsd/target_os_user.h       |  18 +-
>  bsd-user/freebsd/target_os_vmparam.h    |  18 +-
>  bsd-user/i386/signal.c                  |  17 +-
>  bsd-user/i386/target_arch.h             |  16 +-
>  bsd-user/i386/target_arch_cpu.c         |  17 +-
>  bsd-user/i386/target_arch_cpu.h         |  17 +-
>  bsd-user/i386/target_arch_elf.h         |  18 +-
>  bsd-user/i386/target_arch_reg.h         |  19 +-
>  bsd-user/i386/target_arch_signal.h      |  16 +-
>  bsd-user/i386/target_arch_sigtramp.h    |  16 +-
>  bsd-user/i386/target_arch_sysarch.h     |  18 +-
>  bsd-user/i386/target_arch_thread.h      |  18 +-
>  bsd-user/i386/target_arch_vmparam.h     |  18 +-
>  bsd-user/i386/target_syscall.h          |  16 +-
>  bsd-user/meson.build                    |   2 +
>  bsd-user/qemu-bsd.h                     |  18 +-
>  bsd-user/syscall_defs.h                 |  50 +--
>  bsd-user/thunk.c                        | 470 +++++++++++++++++++++
>  bsd-user/x86_64/signal.c                |  16 +-
>  bsd-user/x86_64/target_arch.h           |  16 +-
>  bsd-user/x86_64/target_arch_cpu.c       |  17 +-
>  bsd-user/x86_64/target_arch_cpu.h       |  17 +-
>  bsd-user/x86_64/target_arch_elf.h       |  18 +-
>  bsd-user/x86_64/target_arch_reg.h       |  19 +-
>  bsd-user/x86_64/target_arch_signal.h    |  17 +-
>  bsd-user/x86_64/target_arch_sigtramp.h  |  17 +-
>  bsd-user/x86_64/target_arch_sysarch.h   |  17 +-
>  bsd-user/x86_64/target_arch_thread.h    |  18 +-
>  bsd-user/x86_64/target_arch_vmparam.h   |  18 +-
>  bsd-user/x86_64/target_syscall.h        |  16 +-
>  87 files changed, 2362 insertions(+), 1526 deletions(-)
>  create mode 100644 bsd-user/bsd-ioctl.c
>  create mode 100644 bsd-user/bsd-ioctl.h
>  create mode 100644 bsd-user/freebsd/os-ioctl-cmds.h
>  create mode 100644 bsd-user/freebsd/os-ioctl-cryptodev.h
>  create mode 100644 bsd-user/freebsd/os-ioctl-disk.h
>  create mode 100644 bsd-user/freebsd/os-ioctl-filio.h
>  create mode 100644 bsd-user/freebsd/os-ioctl-in6_var.h
>  create mode 100644 bsd-user/freebsd/os-ioctl-ioccom.h
>  create mode 100644 bsd-user/freebsd/os-ioctl-sockio.h
>  create mode 100644 bsd-user/freebsd/os-ioctl-ttycom.h
>  create mode 100644 bsd-user/freebsd/os-ioctl-types.h
>  create mode 100644 bsd-user/freebsd/os-syscall.h
>  create mode 100644 bsd-user/freebsd/scripts/syscallhdr.sh
>  delete mode 100644 bsd-user/freebsd/syscall_nr.h
>  create mode 100644 bsd-user/thunk.c
>
> --
> 2.52.0
>
>

--000000000000ed94020651311348
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Please ignore this.<div><br></div><div>It was a botched pu=
ll request. I&#39;ve sent the real pull request. My apologies for the noise=
.</div><div><br></div><div>Warner</div></div><br><div class=3D"gmail_quote =
gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 6,=
 2026 at 8:24=E2=80=AFPM Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">=
imp@bsdimp.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Three patch series were reviewed during the code freeze and a=
re finally ready to<br>
head into the tree.<br>
<br>
(1) Use SPDX identifiers in most places. This makes it easier for me to ups=
tream<br>
since I can do almost all of the files in the forked tree and not have it b=
e an<br>
issue each time I add a new file.<br>
<br>
(2) Per discussions in the review, copy thunk.c to bsd-user from linux-user=
. We<br>
will use this in the third set of patches, ioctls. All that changed is the<=
br>
copyright header. This file has style problems, but fixing them would be a =
worse<br>
problem than the style issues since we share it with linux-user and want to=
<br>
track changes there. In the future we may actually share, but for now this =
was<br>
the compromise.<br>
<br>
(3) All the ioctls that bsd-user supports in FreeBSD. This uses the thunk.c=
 code<br>
to translate back and forth between host and target. A number of pedantic<b=
r>
changes were made against the blitz branch upstream and were discovered or<=
br>
highlighted by claude code.<br>
<br>
I used claude to extract all the ioctl code from the blitz branch for<br>
upstreaming. I had it review the code and fixed the problems it found (thou=
gh<br>
one was a false positive). I&#39;ve not tagged these as Assisted-by: since =
that part<br>
of our policy is in flux. No creative output of claude was applied here, th=
ough<br>
it also suggested the commit messages (that I rewrote in large part, but<br=
>
vestiges of the original remain). To be clear: Claude didn&#39;t write any =
of<br>
the actual code.<br>
<br>
Stacey Son (19):<br>
=C2=A0 bsd-user: ioctl: add common definitions<br>
=C2=A0 bsd-user: Add FreeBSD tty ioctl definitions<br>
=C2=A0 bsd-user: Add FreeBSD file I/O ioctl definitions<br>
=C2=A0 bsd-user: Add FreeBSD socket ioctl definitions<br>
=C2=A0 bsd-user: Add FreeBSD cryptodev ioctl definitions<br>
=C2=A0 bsd-user: Add FreeBSD disk ioctl definitions<br>
=C2=A0 bsd-user: Add FreeBSD IPv6 ioctl definitions<br>
=C2=A0 bsd-user: Add FreeBSD ioctl type definitions<br>
=C2=A0 bsd-user: Add FreeBSD ioctl command table<br>
=C2=A0 bsd-user: Add bsd-ioctl.h header<br>
=C2=A0 bsd-user: Add target_sockaddr and safe_ioctl to syscall_defs.h<br>
=C2=A0 bsd-user: Add bsd-ioctl.c infrastructure and termios conversion<br>
=C2=A0 bsd-user: Add log_unsupported_ioctl function<br>
=C2=A0 bsd-user: Add do_ioctl_unsupported function<br>
=C2=A0 bsd-user: Add target_to_host_sockaddr_in6 function<br>
=C2=A0 bsd-user: Add do_ioctl_in6_ifreq_sockaddr_int function<br>
=C2=A0 bsd-user: Add do_bsd_ioctl main function<br>
=C2=A0 bsd-user: Add init_bsd_ioctl function<br>
=C2=A0 bsd-user: Add call to do_bsd_ioctl and add bsd-ioctl.c to the build<=
br>
<br>
Warner Losh (6):<br>
=C2=A0 bsd-user: Switch to SPDX-License-Expression<br>
=C2=A0 bsd-user: Add syscall header generator for FreeBSD<br>
=C2=A0 bsd-user: Delete sbrk and sstk system calls.<br>
=C2=A0 bsd-user: Create os-syscall.h<br>
=C2=A0 bsd-user: Switch to generated syscall_nr.h<br>
=C2=A0 bsd-user: Copy linux-user/thunk.c to bsd-user<br>
<br>
=C2=A0bsd-user/aarch64/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 15 +-<br>
=C2=A0bsd-user/aarch64/target_arch.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 16 +-<br>
=C2=A0bsd-user/aarch64/target_arch_cpu.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 15 +-<=
br>
=C2=A0bsd-user/aarch64/target_arch_cpu.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 18 +-<=
br>
=C2=A0bsd-user/aarch64/target_arch_elf.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +-<=
br>
=C2=A0bsd-user/aarch64/target_arch_reg.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 19 +-<=
br>
=C2=A0bsd-user/aarch64/target_arch_signal.h=C2=A0 =C2=A0|=C2=A0 16 +-<br>
=C2=A0bsd-user/aarch64/target_arch_sigtramp.h |=C2=A0 16 +-<br>
=C2=A0bsd-user/aarch64/target_arch_sysarch.h=C2=A0 |=C2=A0 16 +-<br>
=C2=A0bsd-user/aarch64/target_arch_thread.h=C2=A0 =C2=A0|=C2=A0 16 +-<br>
=C2=A0bsd-user/aarch64/target_arch_vmparam.h=C2=A0 |=C2=A0 16 +-<br>
=C2=A0bsd-user/aarch64/target_syscall.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1=
6 +-<br>
=C2=A0bsd-user/arm/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 18 +-<br>
=C2=A0bsd-user/arm/target_arch.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 16 +-<br>
=C2=A0bsd-user/arm/target_arch_cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 18 +-<br>
=C2=A0bsd-user/arm/target_arch_cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 18 +-<br>
=C2=A0bsd-user/arm/target_arch_elf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 18 +-<br>
=C2=A0bsd-user/arm/target_arch_reg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 18 +-<br>
=C2=A0bsd-user/arm/target_arch_signal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1=
8 +-<br>
=C2=A0bsd-user/arm/target_arch_sigtramp.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 18 +-<=
br>
=C2=A0bsd-user/arm/target_arch_sysarch.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 18 +-<=
br>
=C2=A0bsd-user/arm/target_arch_thread.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1=
8 +-<br>
=C2=A0bsd-user/arm/target_arch_vmparam.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 18 +-<=
br>
=C2=A0bsd-user/arm/target_syscall.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 18 +-<br>
=C2=A0bsd-user/bsd-file.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 18 +-<br>
=C2=A0bsd-user/bsd-ioctl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | 436 ++++++++++++++++++++<br>
=C2=A0bsd-user/bsd-ioctl.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +<br>
=C2=A0bsd-user/bsd-mem.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 17 +-<br>
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 30 +-<br>
=C2=A0bsd-user/bsd-proc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 17 +-<br>
=C2=A0bsd-user/bsd-proc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 17 +-<br>
=C2=A0bsd-user/freebsd/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 10 +-<br>
=C2=A0bsd-user/freebsd/os-ioctl-cmds.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 149 +++=
++++<br>
=C2=A0bsd-user/freebsd/os-ioctl-cryptodev.h=C2=A0 =C2=A0|=C2=A0 84 ++++<br>
=C2=A0bsd-user/freebsd/os-ioctl-disk.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5=
2 +++<br>
=C2=A0bsd-user/freebsd/os-ioctl-filio.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 3=
4 ++<br>
=C2=A0bsd-user/freebsd/os-ioctl-in6_var.h=C2=A0 =C2=A0 =C2=A0| 226 ++++++++=
+++<br>
=C2=A0bsd-user/freebsd/os-ioctl-ioccom.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 43 ++<=
br>
=C2=A0bsd-user/freebsd/os-ioctl-sockio.h=C2=A0 =C2=A0 =C2=A0 | 246 ++++++++=
+++<br>
=C2=A0bsd-user/freebsd/os-ioctl-ttycom.h=C2=A0 =C2=A0 =C2=A0 | 239 ++++++++=
+++<br>
=C2=A0bsd-user/freebsd/os-ioctl-types.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 109 +++=
++<br>
=C2=A0bsd-user/freebsd/os-misc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 18 +-<br>
=C2=A0bsd-user/freebsd/os-proc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 17 +-<br>
=C2=A0bsd-user/freebsd/os-proc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 18 +-<br>
=C2=A0bsd-user/freebsd/os-stat.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 17 +-<br>
=C2=A0bsd-user/freebsd/os-stat.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 18 +-<br>
=C2=A0bsd-user/freebsd/os-strace.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 19 +-<br>
=C2=A0bsd-user/freebsd/os-syscall.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 17 +-<br>
=C2=A0bsd-user/freebsd/os-syscall.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 21 +<br>
=C2=A0bsd-user/freebsd/scripts/syscallhdr.sh=C2=A0 |=C2=A0 =C2=A09 +<br>
=C2=A0bsd-user/freebsd/strace.list=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A04 +<br>
=C2=A0bsd-user/freebsd/syscall_nr.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 515 ------------------------<br>
=C2=A0bsd-user/freebsd/target_os_elf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1=
8 +-<br>
=C2=A0bsd-user/freebsd/target_os_siginfo.h=C2=A0 =C2=A0 |=C2=A0 18 +-<br>
=C2=A0bsd-user/freebsd/target_os_signal.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0=
7 +<br>
=C2=A0bsd-user/freebsd/target_os_stack.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 18 +-<=
br>
=C2=A0bsd-user/freebsd/target_os_thread.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 18 +-<=
br>
=C2=A0bsd-user/freebsd/target_os_user.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1=
8 +-<br>
=C2=A0bsd-user/freebsd/target_os_vmparam.h=C2=A0 =C2=A0 |=C2=A0 18 +-<br>
=C2=A0bsd-user/i386/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 17 +-<br>
=C2=A0bsd-user/i386/target_arch.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 16 +-<br>
=C2=A0bsd-user/i386/target_arch_cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 17 +-<br>
=C2=A0bsd-user/i386/target_arch_cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 17 +-<br>
=C2=A0bsd-user/i386/target_arch_elf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 18 +-<br>
=C2=A0bsd-user/i386/target_arch_reg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 19 +-<br>
=C2=A0bsd-user/i386/target_arch_signal.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 16 +-<=
br>
=C2=A0bsd-user/i386/target_arch_sigtramp.h=C2=A0 =C2=A0 |=C2=A0 16 +-<br>
=C2=A0bsd-user/i386/target_arch_sysarch.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 18 +-<=
br>
=C2=A0bsd-user/i386/target_arch_thread.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 18 +-<=
br>
=C2=A0bsd-user/i386/target_arch_vmparam.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 18 +-<=
br>
=C2=A0bsd-user/i386/target_syscall.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 16 +-<br>
=C2=A0bsd-user/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0bsd-user/qemu-bsd.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 18 +-<br>
=C2=A0bsd-user/syscall_defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 50 +--<br>
=C2=A0bsd-user/thunk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 470 +++++++++++++++++++++<br>
=C2=A0bsd-user/x86_64/signal.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 16 +-<br>
=C2=A0bsd-user/x86_64/target_arch.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 16 +-<br>
=C2=A0bsd-user/x86_64/target_arch_cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1=
7 +-<br>
=C2=A0bsd-user/x86_64/target_arch_cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1=
7 +-<br>
=C2=A0bsd-user/x86_64/target_arch_elf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1=
8 +-<br>
=C2=A0bsd-user/x86_64/target_arch_reg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1=
9 +-<br>
=C2=A0bsd-user/x86_64/target_arch_signal.h=C2=A0 =C2=A0 |=C2=A0 17 +-<br>
=C2=A0bsd-user/x86_64/target_arch_sigtramp.h=C2=A0 |=C2=A0 17 +-<br>
=C2=A0bsd-user/x86_64/target_arch_sysarch.h=C2=A0 =C2=A0|=C2=A0 17 +-<br>
=C2=A0bsd-user/x86_64/target_arch_thread.h=C2=A0 =C2=A0 |=C2=A0 18 +-<br>
=C2=A0bsd-user/x86_64/target_arch_vmparam.h=C2=A0 =C2=A0|=C2=A0 18 +-<br>
=C2=A0bsd-user/x86_64/target_syscall.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1=
6 +-<br>
=C2=A087 files changed, 2362 insertions(+), 1526 deletions(-)<br>
=C2=A0create mode 100644 bsd-user/bsd-ioctl.c<br>
=C2=A0create mode 100644 bsd-user/bsd-ioctl.h<br>
=C2=A0create mode 100644 bsd-user/freebsd/os-ioctl-cmds.h<br>
=C2=A0create mode 100644 bsd-user/freebsd/os-ioctl-cryptodev.h<br>
=C2=A0create mode 100644 bsd-user/freebsd/os-ioctl-disk.h<br>
=C2=A0create mode 100644 bsd-user/freebsd/os-ioctl-filio.h<br>
=C2=A0create mode 100644 bsd-user/freebsd/os-ioctl-in6_var.h<br>
=C2=A0create mode 100644 bsd-user/freebsd/os-ioctl-ioccom.h<br>
=C2=A0create mode 100644 bsd-user/freebsd/os-ioctl-sockio.h<br>
=C2=A0create mode 100644 bsd-user/freebsd/os-ioctl-ttycom.h<br>
=C2=A0create mode 100644 bsd-user/freebsd/os-ioctl-types.h<br>
=C2=A0create mode 100644 bsd-user/freebsd/os-syscall.h<br>
=C2=A0create mode 100644 bsd-user/freebsd/scripts/syscallhdr.sh<br>
=C2=A0delete mode 100644 bsd-user/freebsd/syscall_nr.h<br>
=C2=A0create mode 100644 bsd-user/thunk.c<br>
<br>
-- <br>
2.52.0<br>
<br>
</blockquote></div>

--000000000000ed94020651311348--

