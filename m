Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F50F3ED44
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 10:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBVkQ-0006yx-6D; Sat, 11 Apr 2026 06:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gyorgy.tamasi@gmail.com>)
 id 1wBVkN-0006ym-6t
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 06:39:27 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gyorgy.tamasi@gmail.com>)
 id 1wBVkK-0000EI-Ea
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 06:39:26 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-38df1889fb9so30709921fa.1
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 03:39:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775903961; cv=none;
 d=google.com; s=arc-20240605;
 b=FwYH2NyY96sYgDA19ooOqQPlaK9q3SyB5VJ1OjcGpH4/qNwYp+s9sF1aZ+o8inRaR4
 ToRS+Kei+5bz6rDc0hwlD0n+MOh+HHApvr9ROVn+s5222uLchbZsQvJ6KM4UFSlTidyi
 WKcjnDXlBQmicOD5s3OuACtL3z/xPAUp99JeOOyJTvI0jCCWPF6aCUsX0Tc59gS2O8r/
 U/OgjsLLmOLE9BZdpbl95IPGGE+BfzzDQwOVZMp58vFzxhMYkW3S4jRxs9wEhYeDUCUt
 txKbr2lGj2CU6PAGwfXVPesDjPOyTQU11V5hN50iMu5p20wCVuvMi587rw4o47jFHZkk
 9JWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TaDK7ZIqg9WV8Y0/xPGkoRXmyNtXi2ntIED7sMJIEaY=;
 fh=eWx0tyDlnMUvPzdJnhSVUnpoEQSSSeLtEb7cjgKksBc=;
 b=BzngAr6k2QwuV7mKfu7y3poqNaNuSgjIYTnVrRJgtHMROdjwct4Y7HcngPHf6AOqfi
 RD7nlcatXsLgqMjZ1aZzGYOMFbStvYSMKl7kwC4h8f6t6b5/RWaW1FJnY7khW0mzm1na
 MJzTHMIoGxKpuiDeekuNc5NBl1+o3PgQTzIMdbiFekGO8rALyJ0h85pxc5WX/ocV4RfV
 xdou+fYMiaEE1g4VSS744N5ijiho4HyKKBOdTetdzW84zcSYQnKuiO5c3ktY4/Bjpn3T
 gSKz6e0zPNUMR8NfmRTiCebGmtjL4Rz4Q2nIR/ugWr/Q9AT7ZXK1X2vuS+dUy3G7/MPO
 bokA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775903961; x=1776508761; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TaDK7ZIqg9WV8Y0/xPGkoRXmyNtXi2ntIED7sMJIEaY=;
 b=SY1+BSpWIaPlMIfa+f4rxvECcX2a1i6CxBU6qKqTAK9nlEdP1pvK26nFid/K2PirDA
 SlRE+CYCNt0KdU8w1WygSpaKfCM9vjMATybVzJOtmMJM/t3vDJ6U0NMv6altgz2SyJVy
 3YgmOou8D4iwoWqq2kWWnaFXLepkwGAmn0YXVWQwyTK9lKd3zFDu+AGnfHLS6itOAE4u
 M8LNeB+d2+ysWPUS/nxQ+nvINOusOlOWNmFWHCGSPmaNu4xfYjk+vQhrBtf380sOjHXK
 0b94HibM9wUmPUQHlJpcMqhKgia/HMKdyma06UvpzX/g4kydB1TGpk2b+HzUElYj+K7K
 8WKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775903961; x=1776508761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TaDK7ZIqg9WV8Y0/xPGkoRXmyNtXi2ntIED7sMJIEaY=;
 b=nsoNr9HaZMpS/KlieYONZU6SMe6jf5oYzSHkFRYu5qlKpkZozONa4FbyeizTY9mxWH
 F6AlbuSv/mSntf4pbhc4u2IkK+OAUfnMPpXHaQuAhDg6nG7gFDC5TuPFLYMH/Rv2MmGt
 bxLNCiD3MonGTFND6Dd6GuYVva5Nr2XPEmFgECMk4h7n53KL+7f4dV/T7zYDUPPgNWQ0
 EbhS1iGNUDrNFcLWSwSWKFniQHE6AwOWbWwDLXqsMFln/Uk8ffjrGLXmRDsvggp9C+NF
 CJ7kCtk/+gM+/+JtlWb4RxMozYPtKFW2Pk3urLq1RXgqgwEiNhjZjGVgEe6UsYnh48xn
 eBDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8SZ1OzPdZVh66AvzP1+v1eAH3PEJ7KRiVP5ZVGElq6rtkzE4zJJX4wIzhy30Y+MoS9s7O27uUjhhX@nongnu.org
X-Gm-Message-State: AOJu0Yztc8NLfuRpgttAabGY9djMXreInyIwo5Arhc1sn55k6s/8jgJR
 zlQ8kD/drbp+f5OxU8yE582btlVrgcDN4uHS5eXGuIaJtJwP5riqNpQMPIupeW6N7nX1dLeFRBR
 12dTRW0+VzNIDaBuEjGaDa+gfIuNcWE4=
X-Gm-Gg: AeBDietk7sResGG7Gxv0UdJnL5wx6zEXmBAjYp+w0h5OgnM3xHyEhc2nbtseKl1neB9
 omZi+hdC7vSA5dmoCxiITDQNWh/2baDLrza6blMGCbB53dX4ParQgWymsf/lrtm5oM21vsDcmrO
 l27ALH1z9ikj2eobgtNZd4YlQER5Hth0S0Zo83hySte8UG+BtT3qtQtR1IEjwTCUU/6nPNp9sSn
 XzZezMXioMRsTpEG89J8wi+nn0ifquRc0IHYIYz9XUrd7pVRZSKYltNkGo7djUJAA0BMdhnASch
 G9hYLKL3tKtTwclXK4EI7vrsAC/C/aHSgA80l6D9
X-Received: by 2002:a05:6512:3c9e:b0:5a1:3207:694c with SMTP id
 2adb3069b0e04-5a3efd8a12emr2078265e87.29.1775903960499; Sat, 11 Apr 2026
 03:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAFsMJvCLRw2Q=4muDNG1Ojj3oL+UgTrVzpYM6VULRvdFxgR=KA@mail.gmail.com>
 <df1c484f-bc30-49d5-9928-de6e17dd2816@linaro.org>
 <CAFsMJvDWFmMx2t+9JXmBsWP+8r0XZDP+LRm6bN9k8wF5b6CSLQ@mail.gmail.com>
 <d56c0dd2-720a-2973-865d-c9d16b90b69f@loongson.cn>
 <CAFsMJvBKkLf=F=g=6H5_-FX4wJAzC6MhweoapqVTPx+7V9e9bw@mail.gmail.com>
 <CAAhV-H6tAdv9BwrkgPTLWKpy35jJx+aG0xHGK2=CWdx5cUeiPg@mail.gmail.com>
In-Reply-To: <CAAhV-H6tAdv9BwrkgPTLWKpy35jJx+aG0xHGK2=CWdx5cUeiPg@mail.gmail.com>
From: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
Date: Sat, 11 Apr 2026 12:39:10 +0200
X-Gm-Features: AQROBzCw2agMgCfcliBqQ0qyUc9YLpcazzcEOJF5Qna3QU2W4oV7QmdPZf14mzM
Message-ID: <CAFsMJvAhdCdXEAFC27JJceA4Mc2Y3fADC7ASHBPitqeLgHMJKA@mail.gmail.com>
Subject: Re: [PATCH] linux-user: fix usage of struct target_stat64 for
 TARGET_LOONGARCH64 in syscall_defs.h
To: Huacai Chen <chenhuacai@kernel.org>
Cc: gaosong <gaosong@loongson.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, laurent@vivier.eu, 
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 bibo mao <maobibo@loongson.cn>, xianglai li <lixianglai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=gyorgy.tamasi@gmail.com; helo=mail-lj1-x22b.google.com
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

> > This changeset was the last mod of syscall_defs.h - but it still
> > incorrectly modifies the condition of struct target_stat64 usage:
> > (~ "Add Loongarch64 old ABI support")
> > https://github.com/loongson/qemu/commit/409f7717d6e3217cb8f497547bbe45c=
2e864be99
> > (line 2006)
> > -----
> > -#if !defined(TARGET_RISCV64)
> > +#if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
> I think this patch has nothing to do with ABI 1.0/2.0, it really fixed
> a bug, similar to RISCV. While RISCV has no ABI 1.0/2.0.
> Huacai

But here the added "|| defined(TARGET_LOONGARCH64)" part doesn't fix
that affected bug similar to RISCV[32] vs. RISCV64...you need "&&
!defined(TARGET_LOONGARCH64)" here to create an effect for
TARGET_LOONGARCH64 similar to the proper solution for TARGET_RISCV64
(~ disable the use of this struct target_stat64 with 32bit sec/nsec
fields for a glibc environment where 64bit sec/nsecs are used - the
default struct target_stat is perfect for these 64bit envs, do not let
TARGET_HAS_STRUCT_STAT64 to be defined). [This 2nd embedded "||
defined(TARGET_LOONGARCH64)" within an other encapsulating "||
defined(TARGET_LOONGARCH64)" #elif-section is effectively a no-op here
(the 2nd is always true, if the encapsulating 1st was true)...it does
not effectively change the behaviour of its conditional
code-fragment-body in the actual context...comparing to the original
"#if !defined(TARGET_RISCV64)" full-line.]

How the contexts of LoongArch64 ABI1.0 vs. ABI2.0 are linked to this
issue (related to an optional code-path in qemu/linux-user/syscall.c)?
The answer:
The existence of this bug does not directly depend on or linked to any
difference of core features of LA64's ABI1.0 vs. ABI2.0.
The difference in behaviour of ABI1.0 and ABI2.0 environments related
to this qemu-code-part here strictly depends on the behaviour of
specific glibc versions used by those LA64 ABI1.0 and ABI2.0
environments.

In the ABI1.0 env of glibc-2.28-7cdc44d5a1 used by Loongson's gcc 8.3
rc1.6 a stat-like call (filling up a struct stat instance) IS NOT
always routed via the statx syscall, newfstatat can be used
instead!...and the processing of this newfstatat triggers the usage of
the problematic code-path in qemu/linux-user/syscall.c having this
bug, related to the host_to_target_stat64() function, where this code
fragment prefers to use struct target_stat64 (instead of struct
target_stat), if its use is enabled by
defined(TARGET_HAS_STRUCT_STAT64):
(~ around line 7975 in the 10.2.2 source)
#if defined(TARGET_HAS_STRUCT_STAT64)
        struct target_stat64 *target_st;
#else
        struct target_stat *target_st;
#endif

While in the ABI2.0 env of glibc of this gcc
https://github.com/loongson/build-tools/releases/download/2025.08.08/x86_64=
-cross-tools-loongarch64-binutils_2.45-gcc_15.1.0-glibc_2.42.tar.xz
from https://github.com/loongson/build-tools (glibc:
https://ftp.gnu.org/gnu/glibc/glibc-2.42.tar.xz) ALL stat-like calls
ARE ROUTED via the statx syscall, so the problematic code path of
host_to_target_stat64() IS NOT used/triggered at all (and processing
path of the statx syscall in linux-user/syscall.c is correct). This
behaviour of glibc-2.42 can be determined by these definitions in
glibc-2.42/sysdeps/unix/sysv/linux/loongarch/fixup-asm-unistd.h:
-----
/* To avoid the messy usage of the fstat, newfstatat, and statx system call=
s, we
only use statx.  */
#undef __NR_fstat
#undef __NR_newfstatat
-----

-tgy

On Sat, Apr 11, 2026 at 10:24=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org=
> wrote:
>
> On Sat, Apr 11, 2026 at 10:09=E2=80=AFAM Gyorgy Tamasi <gyorgy.tamasi@gma=
il.com> wrote:
> >
> > Hi,
> >
> > Thanks for the link of this separate Loongson-maintained 9.2-tcg-old
> > branch - intended for use specifically with ABI 1.0 code.
> >
> > This separate branch still contains the same bug (in the context of
> > the glibc-2.28-7cdc44d5a1 env of Loongson's gcc 8.3.0 rc1.6 - where
> > fstatat syscall can be used by glibc, and it can trigger the usage of
> > the related erroneous data-conversion workflow based on  struct
> > target_stat64 with 4byte sec/nsec fields):
> >
> > This changeset was the last mod of syscall_defs.h - but it still
> > incorrectly modifies the condition of struct target_stat64 usage:
> > (~ "Add Loongarch64 old ABI support")
> > https://github.com/loongson/qemu/commit/409f7717d6e3217cb8f497547bbe45c=
2e864be99
> > (line 2006)
> > -----
> > -#if !defined(TARGET_RISCV64)
> > +#if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
> I think this patch has nothing to do with ABI 1.0/2.0, it really fixed
> a bug, similar to RISCV. While RISCV has no ABI 1.0/2.0.
>
> Huacai
>
> > -----
> >
> > This is the broader context in this 9.2-tcg-old original version:
> > Here the 2nd embedded "|| defined(TARGET_LOONGARCH64)" normally a
> > no-op: always true/false if the 1st "|| defined(TARGET_LOONGARCH64)"
> > is true/false.
> > -----
> > #elif defined(TARGET_OPENRISC) || defined(TARGET_NIOS2) \
> >         || defined(TARGET_RISCV) || defined(TARGET_HEXAGON) || \
> >         defined(TARGET_LOONGARCH64)
> > /* These are the asm-generic versions of the stat and stat64 structures=
 */
> >
> > #define TARGET_STAT_HAVE_NSEC
> > struct target_stat {
> > ...
> > };
> >
> > #if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
> > #define TARGET_HAS_STRUCT_STAT64
> > struct target_stat64 {
> > ...
> > };
> > #endif
> >
> > #elif defined(TARGET_HPPA)
> > -----
> >
> > The correct fix is the same here (~ disable the use of this struct
> > target_stat64 - instead of explicitly enabling it for
> > TARGET_LOONGARCH64 with the "|| defined(...)" part):
> > -----
> > ~/qemu/qemu-9.2-tcg-old/linux-user$ diff -u syscall_defs.h.ori syscall_=
defs.h
> > --- syscall_defs.h.ori  2026-04-10 20:53:34.639034304 +0200
> > +++ syscall_defs.h      2026-04-10 20:55:12.219347804 +0200
> > @@ -2003,7 +2003,7 @@
> >      abi_uint __unused5;
> >  };
> >
> > -#if !defined(TARGET_RISCV64) || defined(TARGET_LOONGARCH64)
> > +#if !defined(TARGET_RISCV64) && !defined(TARGET_LOONGARCH64)
> >  #define TARGET_HAS_STRUCT_STAT64
> >  struct target_stat64 {
> >      abi_ullong st_dev;
> > -----
> >
> > The same test-scenario of
> > https://gitlab.com/qemu-project/qemu/-/work_items/3371 can be used
> > [with the relevant gcc 8.3 rc1.6 & this qemu linux-user 9.2-tcg-old
> > toolset] to show exactly the same bad & good test results - without &
> > with this mod.
> >
> > Just a personal experience based side-note on ABI1.0 compatibility
> > with mainline qemu (~10.2.2):
> > I'm working on porting a quite large code-base (a commercial OCR &
> > document conversion SDK) to LoongArch64 (for ABI1.0 and ABI2.0)...and
> > I'm trying to check correctness of my actual builds using the
> > regression-test package of this codebase. It runs quite complex
> > workflows of general CLI code. I accept that this is not a
> > comprehensive test with all of the edge cases or touching every
> > special areas (like signal handling) of compatibility of ABI1.0 and
> > mainline qemu, but...the ABI1.0 version of this test-code seems to be
> > able to run with mainline qemu-user 10.2.2.
> >
> > Best regards,
> > -tgy
> >
> > On Fri, Apr 10, 2026 at 11:37=E2=80=AFAM gaosong <gaosong@loongson.cn> =
wrote:
> > >
> > > =E5=9C=A8 2026/4/9 =E4=B8=8B=E5=8D=888:14, Gyorgy Tamasi =E5=86=99=E9=
=81=93:
> > > > Tested-by: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
> > > >
> > > > Additional independent testing (bug + fix cases) is documented here=
 -
> > > > see comments by sourav/@kishu279:
> > > > https://gitlab.com/qemu-project/qemu/-/work_items/3371
> > >
> > > Hi.
> > > Please note that QEMU is not compatible with ABI 1.0.
> > >
> > > If you absolutely must use ABI 1.0, the branch below is the version w=
e use.
> > > https://github.com/loongson/qemu/commits/9.2-tcg-old/
> > >
> > > However, this branch is quite far from the mainline.
> > > The QEMU mainline follows the kernel mainline, and
> > > I believe this is the case for other architectures as well.
> > >
> > > Thanks.
> > > Song Gao
> > > > On Wed, Apr 8, 2026 at 8:21=E2=80=AFPM Pierrick Bouvier
> > > > <pierrick.bouvier@linaro.org> wrote:
> > > >> On 4/8/26 11:17 AM, Gyorgy Tamasi wrote:
> > > >>> In a 64bit LoongArch64 env (both TARGET_LOONGARCH and
> > > >>> TARGET_LOONGARCH64 are defined!) we can not use the struct
> > > >>> target_stat64 for data-transfer, since this struct target_stat64 =
is
> > > >>> defined for 32bit environments with its int-sized (4byte) st_*tim=
e
> > > >>> sec/nsec components.
> > > >>> The user side compiler headers of the LoongArch64 env uses long-s=
ized
> > > >>> (8byte) st_*time sec/nsec components.
> > > >>>
> > > >>> (This is similar to the case of 32bit vs. 64bit RISCV: the origin=
al
> > > >>> code does not use struct target_stat64 in 64bit RISCV env, when b=
oth
> > > >>> TARGET_RISCV and TARGET_RISCV64 are defined.)
> > > >>>
> > > >>> This fix is important for LoongArch64 ABI1.0, where stat() is usi=
ng an
> > > >>> fstatat syscall with this struct target_stat64, if its usage is
> > > >>> enabled.
> > > >>> (In case of LoongArch64 ABI2.0 stat() uses statx syscall, where t=
his
> > > >>> problematic struct target_stat64 is not used, struct statx is cor=
rect
> > > >>> in the LoongArch64 env.)
> > > >>> See also: https://gitlab.com/qemu-project/qemu/-/work_items/3371
> > > >>>
> > > >>> Signed-off-by: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>
> > > >>> ---
> > > >>>    linux-user/syscall_defs.h | 2 +-
> > > >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> > > >>>
> > > >> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > >

