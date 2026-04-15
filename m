Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4119F43857
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 16:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD2lg-0005c9-D4; Wed, 15 Apr 2026 12:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gyorgy.tamasi@gmail.com>)
 id 1wD2lY-0005br-A6
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 12:07:00 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gyorgy.tamasi@gmail.com>)
 id 1wD2lU-0007s4-SM
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 12:06:59 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-59e4a04f059so6687262e87.2
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 09:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776269214; cv=none;
 d=google.com; s=arc-20240605;
 b=MIq5YgIMk99B1IUmHh0OrMskJOSm1woU7cxKRFE4xBwTYmxq1iYsk11RlkcgC0C7O0
 CJSUZFIB3di2jX8061pWN9BmrUzqjrUmjGSZlUWF37bl3nRFvx5JaaKClVatktUCurLK
 mODfDPnFaPV01fiHAB1C+f0gmeTowr/QHAwQBz/XiJ/DFYUGwrHDj54S1XLE53Cor001
 +aq/Ei1+7NB/fGVz+7X0bJH4GOIWhJlpuExObTd+VEFwermaVoT2xecc6cCUwg4uhCHm
 1VUE1Vkg/7nOkEff5QWO+zM/ycmEFbifNN0h1twhoidBztwUJ1x6nBicTq3x2y+8VEff
 Eaig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=82W50w1NovQ3iogFOyeKDY6MzG//aT9qGjZlXhruf34=;
 fh=eQ8gFmoiRTPJ7q6dt3ypbYMdb6M0NZFRnAZWQvy9k7w=;
 b=VJI4JT0PUzgr4L/QLfCRK0RF3FcbSg+l97vQzMX5kI8XgjZdTFMFl7EceWmZeiivSK
 ZAeFVLGuo7YmPc7FgSnLrAxrTeEiXtGavTs4K/G7xpHGvkJv+/kqgpEw+vChUhqCWUAp
 AHOcMcW0iu/3ejXhW3dwvMJu6LMMoj95kIZ558PIYgJWxXH2m1NxTRPmNoSJq0msNM82
 ZzF8iKT8Tb1RvVP91eFyQk+slidajUBVkqEN38tZ0C48fjW0upvw17iVHAJ1nkSVY+XC
 8qnhzEydxndBuRjbCccu8FA2MrMR+24GQJqgtuKXS33Lj09VfXEnUQhS+2/W+3Z3LqlA
 e1zg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776269214; x=1776874014; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82W50w1NovQ3iogFOyeKDY6MzG//aT9qGjZlXhruf34=;
 b=oJQs/sDfHmRSmvRubV/JN+nOjP+0fg0SNRFjZlhBwLbtnAFh/J3hJkkbEO0gEDvO0C
 jePjz7Xi/zTGab9R71cuUCieItVDD0SqjUl2zXveEiIBhF2/jOw86C9hL2X6/DjYouMV
 qR4F+jTUaJ8UQlJKs6SfT3cX4Jb79fGjz6+g5snqM9Jqn9+buUzTfHUwVnEwygoIt+Ne
 qnKnt8T4cOtNcHIAWl4r5RIC0kTAsIu1KMfTF5whkxrvESVx0+HCOT8MXuSn0cS4USlM
 XVbWzUq4ZVeJdTeE+1jy+4WI4M4oW0c3cNzTkmP+H2lB14Z9/FM70U7IRTkRMLj0OCGG
 NTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776269214; x=1776874014;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=82W50w1NovQ3iogFOyeKDY6MzG//aT9qGjZlXhruf34=;
 b=E1H0I5CeTnjBPPYfceo7KobqP0DSQZgEOw4UqlwYX4I7+i0nSANLcPKx0gxKcxxXxW
 9jMjp71e1Ue3h4n7OFaQuV+/nuCjmz4pCcryRE3whQwi+6RlkpIVyESFydTnX+SHrmtP
 Rv831UCVGrNXiS2t3G7lVX/g1F0EZBC31rri7C6u4i5siQyKlB3LuX6dwYJE6mwVVfT5
 BOkKT9M5LN1HfLmY01GBtI6zKjf3B1AK+Cx3v1iUp2YDCPEU/ERSUbGN4IfBwxCu0dyl
 htGenqMHjRhhPEN8UzR+CnCELObeyHkriT92Z50FltP2rI+UKXVetORfA9JTd7yU8YSG
 kJXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ80e7eVw6pDwilXzzhFB09K+QK6xrZ6ZYqmFjlDF5jNMYJfsOTmcWCRtc4Lr9SWL/7FCOmC9nZu1V4/@nongnu.org
X-Gm-Message-State: AOJu0YxhemnlOVU7aKBVXAv1VO50s4S8zbCtDhA8rhBZBEhI9tIkyiTQ
 pkv/e4J2L+Sy5FtAG9BMeEhTiglT7EicZHNClonEJnhgDIKjS0J+vS6BAOSAc4QPYXcwEy4BCbn
 IwHCr8TT1HwZBGzEW4AAp7ijs9INPKOs=
X-Gm-Gg: AeBDieswJ/TqQLe3kQpFLkDOdJfgVNvGVVZWese00FVKcpMira3WyYVf/eLdSsxjNq1
 bmGAtN1gWo4UGRsJ6151+dJ2TamHhZXkOPUByC6lpFobjHdWfVsNmaiJur1UfQ42q/GvV73FQ56
 96/ydUz6G99YgyGZ+PmZ79iqx1p95hrWE+P7S6pMQiW0FW2e9NH5c53bvuKHwABtE+1/syDZ0wb
 uDuxkv/5wHSikWU/t4yjncWR/ur46rqdhXiJO373WrykJWQZE97sjJPuE0In9rYSEwj8jpQrOzV
 eXk5xCxkBhBBck3nj0o6EQK+drJpT+DCMbSjz60/PbWzS/i0IqQ=
X-Received: by 2002:a05:6512:1287:b0:5a3:d30b:958a with SMTP id
 2adb3069b0e04-5a3efb8be95mr6928775e87.22.1776269213788; Wed, 15 Apr 2026
 09:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAFsMJvCLRw2Q=4muDNG1Ojj3oL+UgTrVzpYM6VULRvdFxgR=KA@mail.gmail.com>
 <df1c484f-bc30-49d5-9928-de6e17dd2816@linaro.org>
 <CAFsMJvDWFmMx2t+9JXmBsWP+8r0XZDP+LRm6bN9k8wF5b6CSLQ@mail.gmail.com>
 <d56c0dd2-720a-2973-865d-c9d16b90b69f@loongson.cn>
 <CAFsMJvBKkLf=F=g=6H5_-FX4wJAzC6MhweoapqVTPx+7V9e9bw@mail.gmail.com>
 <CAAhV-H6tAdv9BwrkgPTLWKpy35jJx+aG0xHGK2=CWdx5cUeiPg@mail.gmail.com>
 <CAFsMJvAhdCdXEAFC27JJceA4Mc2Y3fADC7ASHBPitqeLgHMJKA@mail.gmail.com>
 <73b6b6c0-81ee-b054-ad59-3067a718b492@loongson.cn>
In-Reply-To: <73b6b6c0-81ee-b054-ad59-3067a718b492@loongson.cn>
From: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
Date: Wed, 15 Apr 2026 18:06:44 +0200
X-Gm-Features: AQROBzAXUvQXaXM95MnsuzJyD8OMlm3a5I916ysVQyUqacc68mgE0zjXrDjJk6k
Message-ID: <CAFsMJvAj9Kp_ZP188QnuAzsPv90Y9Gb0x4twuiamo4OG8Kvc6w@mail.gmail.com>
Subject: Re: [PATCH] linux-user: fix usage of struct target_stat64 for
 TARGET_LOONGARCH64 in syscall_defs.h
To: gaosong <gaosong@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 laurent@vivier.eu, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 bibo mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>, 
 pierrick.bouvier@posteo.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=gyorgy.tamasi@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

This is a very simple change within a broader and more complex logical
context. It has an important property: it targets a single specific
QEMU configuration (LOONGARCH64) and has no possible side effects for
other configurations. Additionally, it can only have a positive effect
in any context (in any QEMU fork) when the modified code is
executed=E2=80=94even in non-standard or unexpected scenarios, such as
attempting to run an ABI 1.0 binary using a qemu-user-loongarch64
build intended for ABI 2.0. In such cases, if the limited (non-ABI
2.0=E2=80=93specific) feature set of the ABI 1.0 application happens to all=
ow
execution, this change still behaves safely. In this sense, it follows
a fundamental principle of software bug fixing (and medicine): primum
non nocere (=E2=80=9Cfirst, do no harm=E2=80=9D). =F0=9F=99=82

I understand that we are currently in the middle of an important
transition period, during which even traditionally =E2=80=9COld World=E2=80=
=9D (ABI
1.0=E2=80=93dependent) LoongArch64 Linux distributions are releasing their
=E2=80=9CNew World=E2=80=9D (ABI 2.0=E2=80=93specific) versions.

I do not feel qualified to estimate the duration of the next phase of
this transition, namely the replacement of ABI 1.0 OS installations
with ABI 2.0 versions in the end-user base. If a company plans to
release something for LoongArch64 now, and its goal is to make it
available to as many users as possible, building for ABI 2.0=E2=80=94and
optionally also for ABI 1.0=E2=80=94may still be a reasonable choice (provi=
ded
a sufficiently large number of users are still on ABI 1.0 systems
before they upgrade).

My (admittedly very specific) personal perspective: I do not yet have
access to real LoongArch64 hardware, so I have been testing both ABI
2.0 and ABI 1.0 LA64 binaries using different qemu-user versions (even
if this is not a typical use case). Since I have already applied this
modification in my own qemu-user builds, the issue no longer affects
me. Therefore, I can accept that this fix may not be integrated into
the official QEMU branches (given that it concerns the now phasing-out
ABI 1.0). The decision is beyond my scope.

Best regards,
-tgy


On Mon, Apr 13, 2026 at 5:04=E2=80=AFAM gaosong <gaosong@loongson.cn> wrote=
:
>
> =E5=9C=A8 2026/4/11 =E4=B8=8B=E5=8D=886:39, Gyorgy Tamasi =E5=86=99=E9=81=
=93:
> >>> This changeset was the last mod of syscall_defs.h - but it still
> >>> incorrectly modifies the condition of struct target_stat64 usage:
> >>> (~ "Add Loongarch64 old ABI support")
> >>> https://github.com/loongson/qemu/commit/409f7717d6e3217cb8f497547bbe4=
5c2e864be99
> >>> (line 2006)
> >>> -----
> >>> -#if !defined(TARGET_RISCV64)
> >>> +#if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
> >> I think this patch has nothing to do with ABI 1.0/2.0, it really fixed
> >> a bug, similar to RISCV. While RISCV has no ABI 1.0/2.0.
> >> Huacai
> > But here the added "|| defined(TARGET_LOONGARCH64)" part doesn't fix
> > that affected bug similar to RISCV[32] vs. RISCV64...you need "&&
> > !defined(TARGET_LOONGARCH64)" here to create an effect for
> > TARGET_LOONGARCH64 similar to the proper solution for TARGET_RISCV64
> > (~ disable the use of this struct target_stat64 with 32bit sec/nsec
> > fields for a glibc environment where 64bit sec/nsecs are used - the
> > default struct target_stat is perfect for these 64bit envs, do not let
> > TARGET_HAS_STRUCT_STAT64 to be defined). [This 2nd embedded "||
> > defined(TARGET_LOONGARCH64)" within an other encapsulating "||
> > defined(TARGET_LOONGARCH64)" #elif-section is effectively a no-op here
> > (the 2nd is always true, if the encapsulating 1st was true)...it does
> > not effectively change the behaviour of its conditional
> > code-fragment-body in the actual context...comparing to the original
> > "#if !defined(TARGET_RISCV64)" full-line.]
> >
> > How the contexts of LoongArch64 ABI1.0 vs. ABI2.0 are linked to this
> > issue (related to an optional code-path in qemu/linux-user/syscall.c)?
> > The answer:
> > The existence of this bug does not directly depend on or linked to any
> > difference of core features of LA64's ABI1.0 vs. ABI2.0.
> > The difference in behaviour of ABI1.0 and ABI2.0 environments related
> > to this qemu-code-part here strictly depends on the behaviour of
> > specific glibc versions used by those LA64 ABI1.0 and ABI2.0
> > environments.
> >
> > In the ABI1.0 env of glibc-2.28-7cdc44d5a1 used by Loongson's gcc 8.3
> > rc1.6 a stat-like call (filling up a struct stat instance) IS NOT
> > always routed via the statx syscall, newfstatat can be used
> > instead!...and the processing of this newfstatat triggers the usage of
> > the problematic code-path in qemu/linux-user/syscall.c having this
> > bug, related to the host_to_target_stat64() function, where this code
> > fragment prefers to use struct target_stat64 (instead of struct
> > target_stat), if its use is enabled by
> > defined(TARGET_HAS_STRUCT_STAT64):
> > (~ around line 7975 in the 10.2.2 source)
> > #if defined(TARGET_HAS_STRUCT_STAT64)
> >          struct target_stat64 *target_st;
> > #else
> >          struct target_stat *target_st;
> > #endif
> >
> > While in the ABI2.0 env of glibc of this gcc
> > https://github.com/loongson/build-tools/releases/download/2025.08.08/x8=
6_64-cross-tools-loongarch64-binutils_2.45-gcc_15.1.0-glibc_2.42.tar.xz
> > from https://github.com/loongson/build-tools (glibc:
> > https://ftp.gnu.org/gnu/glibc/glibc-2.42.tar.xz) ALL stat-like calls
> > ARE ROUTED via the statx syscall, so the problematic code path of
> > host_to_target_stat64() IS NOT used/triggered at all (and processing
> > path of the statx syscall in linux-user/syscall.c is correct). This
> > behaviour of glibc-2.42 can be determined by these definitions in
> > glibc-2.42/sysdeps/unix/sysv/linux/loongarch/fixup-asm-unistd.h:
> > -----
> > /* To avoid the messy usage of the fstat, newfstatat, and statx system =
calls, we
> > only use statx.  */
> > #undef __NR_fstat
> > #undef __NR_newfstatat
> > -----
> >
> > -tgy
> Hi,
>
> Thank you for your explanation.
>
> I confirm that the same issue exists in the 9.2-tcg-old branch, and you h=
ave clearly identified the root cause of the problem.
> There is no doubt that the patch itself is fine, but what confuses me is =
that you attempted to run (ABI 1.0.0) using QEMU (ABI 2.0),
> which led to the misconception that QEMU (2.0) is compatible with 1.0, wh=
en in fact QEMU has never been compatible with 1.0.
> As far as I understand, the differences between the ABI 2.0 and ABI 1.0 e=
nvironments should be quite significant.
>
> Therefore, I am unsure whether we should accept this patch.
> Should we submit this patch to the 9.2-tcg-0ld branch?
> Or should you consider discontinuing support for ABI 1.0? To my knowledge=
, ABI 2.0 has now become the mainstream standard.
>
> Thanks.
> Song Gao
>
> >
> > On Sat, Apr 11, 2026 at 10:24=E2=80=AFAM Huacai Chen <chenhuacai@kernel=
.org> wrote:
> >> On Sat, Apr 11, 2026 at 10:09=E2=80=AFAM Gyorgy Tamasi <gyorgy.tamasi@=
gmail.com> wrote:
> >>> Hi,
> >>>
> >>> Thanks for the link of this separate Loongson-maintained 9.2-tcg-old
> >>> branch - intended for use specifically with ABI 1.0 code.
> >>>
> >>> This separate branch still contains the same bug (in the context of
> >>> the glibc-2.28-7cdc44d5a1 env of Loongson's gcc 8.3.0 rc1.6 - where
> >>> fstatat syscall can be used by glibc, and it can trigger the usage of
> >>> the related erroneous data-conversion workflow based on  struct
> >>> target_stat64 with 4byte sec/nsec fields):
> >>>
> >>> This changeset was the last mod of syscall_defs.h - but it still
> >>> incorrectly modifies the condition of struct target_stat64 usage:
> >>> (~ "Add Loongarch64 old ABI support")
> >>> https://github.com/loongson/qemu/commit/409f7717d6e3217cb8f497547bbe4=
5c2e864be99
> >>> (line 2006)
> >>> -----
> >>> -#if !defined(TARGET_RISCV64)
> >>> +#if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
> >> I think this patch has nothing to do with ABI 1.0/2.0, it really fixed
> >> a bug, similar to RISCV. While RISCV has no ABI 1.0/2.0.
> >>
> >> Huacai
> >>
> >>> -----
> >>>
> >>> This is the broader context in this 9.2-tcg-old original version:
> >>> Here the 2nd embedded "|| defined(TARGET_LOONGARCH64)" normally a
> >>> no-op: always true/false if the 1st "|| defined(TARGET_LOONGARCH64)"
> >>> is true/false.
> >>> -----
> >>> #elif defined(TARGET_OPENRISC) || defined(TARGET_NIOS2) \
> >>>          || defined(TARGET_RISCV) || defined(TARGET_HEXAGON) || \
> >>>          defined(TARGET_LOONGARCH64)
> >>> /* These are the asm-generic versions of the stat and stat64 structur=
es */
> >>>
> >>> #define TARGET_STAT_HAVE_NSEC
> >>> struct target_stat {
> >>> ...
> >>> };
> >>>
> >>> #if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
> >>> #define TARGET_HAS_STRUCT_STAT64
> >>> struct target_stat64 {
> >>> ...
> >>> };
> >>> #endif
> >>>
> >>> #elif defined(TARGET_HPPA)
> >>> -----
> >>>
> >>> The correct fix is the same here (~ disable the use of this struct
> >>> target_stat64 - instead of explicitly enabling it for
> >>> TARGET_LOONGARCH64 with the "|| defined(...)" part):
> >>> -----
> >>> ~/qemu/qemu-9.2-tcg-old/linux-user$ diff -u syscall_defs.h.ori syscal=
l_defs.h
> >>> --- syscall_defs.h.ori  2026-04-10 20:53:34.639034304 +0200
> >>> +++ syscall_defs.h      2026-04-10 20:55:12.219347804 +0200
> >>> @@ -2003,7 +2003,7 @@
> >>>       abi_uint __unused5;
> >>>   };
> >>>
> >>> -#if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
> >>> +#if !defined(TARGET_RISCV64) && !defined(TARGET_LOONGARCH64)
> >>>   #define TARGET_HAS_STRUCT_STAT64
> >>>   struct target_stat64 {
> >>>       abi_ullong st_dev;
> >>> -----
> >>>
> >>> The same test-scenario of
> >>> https://gitlab.com/qemu-project/qemu/-/work_items/3371 can be used
> >>> [with the relevant gcc 8.3 rc1.6 & this qemu linux-user 9.2-tcg-old
> >>> toolset] to show exactly the same bad & good test results - without &
> >>> with this mod.
> >>>
> >>> Just a personal experience based side-note on ABI1.0 compatibility
> >>> with mainline qemu (~10.2.2):
> >>> I'm working on porting a quite large code-base (a commercial OCR &
> >>> document conversion SDK) to LoongArch64 (for ABI1.0 and ABI2.0)...and
> >>> I'm trying to check correctness of my actual builds using the
> >>> regression-test package of this codebase. It runs quite complex
> >>> workflows of general CLI code. I accept that this is not a
> >>> comprehensive test with all of the edge cases or touching every
> >>> special areas (like signal handling) of compatibility of ABI1.0 and
> >>> mainline qemu, but...the ABI1.0 version of this test-code seems to be
> >>> able to run with mainline qemu-user 10.2.2.
> >>>
> >>> Best regards,
> >>> -tgy
> >>>
> >>> On Fri, Apr 10, 2026 at 11:37=E2=80=AFAM gaosong <gaosong@loongson.cn=
> wrote:
> >>>> =E5=9C=A8 2026/4/9 =E4=B8=8B=E5=8D=888:14, Gyorgy Tamasi =E5=86=99=
=E9=81=93:
> >>>>> Tested-by: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
> >>>>>
> >>>>> Additional independent testing (bug + fix cases) is documented here=
 -
> >>>>> see comments by sourav/@kishu279:
> >>>>> https://gitlab.com/qemu-project/qemu/-/work_items/3371
> >>>> Hi.
> >>>> Please note that QEMU is not compatible with ABI 1.0.
> >>>>
> >>>> If you absolutely must use ABI 1.0, the branch below is the version =
we use.
> >>>> https://github.com/loongson/qemu/commits/9.2-tcg-old/
> >>>>
> >>>> However, this branch is quite far from the mainline.
> >>>> The QEMU mainline follows the kernel mainline, and
> >>>> I believe this is the case for other architectures as well.
> >>>>
> >>>> Thanks.
> >>>> Song Gao
> >>>>> On Wed, Apr 8, 2026 at 8:21=E2=80=AFPM Pierrick Bouvier
> >>>>> <pierrick.bouvier@linaro.org> wrote:
> >>>>>> On 4/8/26 11:17 AM, Gyorgy Tamasi wrote:
> >>>>>>> In a 64bit LoongArch64 env (both TARGET_LOONGARCH and
> >>>>>>> TARGET_LOONGARCH64 are defined!) we can not use the struct
> >>>>>>> target_stat64 for data-transfer, since this struct target_stat64 =
is
> >>>>>>> defined for 32bit environments with its int-sized (4byte) st_*tim=
e
> >>>>>>> sec/nsec components.
> >>>>>>> The user side compiler headers of the LoongArch64 env uses long-s=
ized
> >>>>>>> (8byte) st_*time sec/nsec components.
> >>>>>>>
> >>>>>>> (This is similar to the case of 32bit vs. 64bit RISCV: the origin=
al
> >>>>>>> code does not use struct target_stat64 in 64bit RISCV env, when b=
oth
> >>>>>>> TARGET_RISCV and TARGET_RISCV64 are defined.)
> >>>>>>>
> >>>>>>> This fix is important for LoongArch64 ABI1.0, where stat() is usi=
ng an
> >>>>>>> fstatat syscall with this struct target_stat64, if its usage is
> >>>>>>> enabled.
> >>>>>>> (In case of LoongArch64 ABI2.0 stat() uses statx syscall, where t=
his
> >>>>>>> problematic struct target_stat64 is not used, struct statx is cor=
rect
> >>>>>>> in the LoongArch64 env.)
> >>>>>>> See also: https://gitlab.com/qemu-project/qemu/-/work_items/3371
> >>>>>>>
> >>>>>>> Signed-off-by: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
> >>>>>>> ---
> >>>>>>>     linux-user/syscall_defs.h | 2 +-
> >>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>>
> >>>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>

